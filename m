Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3ULpfek022567
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2008 17:51:41 -0400
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3ULpecj001466
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2008 21:51:40 GMT
Date: Wed, 30 Apr 2008 14:51:40 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <183965.2243.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> As discussed in:
> http://marc.info/?t=120837952900003&r=1&w=2
> the ability to permit package managers and similar programs to set down
> unknown file contexts is still desired/required, not only for putting
> policy modules in packages but also for enabling build systems to create
> images of different distro releases with different policies w/o
> requiring all of the types to be defined in the build host policy.
> 
> This is an updated form of the patch originally posted in:
> http://marc.info/?l=selinux&m=114771094617968&w=2
> 
> The only significant change to the patch aside from re-basing is that
> rather than introducing a labelpriv permission in the security class to
> control the new operation, I chose to use a class/permission that is not
> already allowed for unconfined domains so that unconfined user shells
> won't get this permission by default.  I was going to add a new class
> and permission but then realized that the mac_override capability check
> seemed to fit well conceptually and since it falls in the new
> capability2 class, it is not allowed to any existing domains in policy.
> Further, by making this a capable() check rather than only a SELinux
> permission check, the ability to set unknown file contexts is still
> limited to superuser (or at least CAP_MAC_OVERRIDE)

I think you should be using CAP_MAC_ADMIN as you are explictly
setting the attribute. CAP_MAC_OVERRIDE is for violations of
normal policy, whereas this appears more like an administrative
action.

Unless I'm reading the code wrong, which does happen on occasion.


> processes even if
> SELinux is in permissive mode, which I think is desirable.  These
> safeguards should help against accidental setting of invalid contexts.
> 
> With this patch applied, the following sequence is possible, subject to
> policy, which must allow <domain> self:capability2 mac_override; and
> allow unlabeled_t fs_t:filesystem associate; in order for this to work
> in enforcing mode or you can try it in permissive mode.
> 
> # touch bar
> # chcon -t foo_exec_t bar # foo_exec_t is not yet defined
> # ls -Z bar
> -rw-r--r--  root root system_u:object_r:unlabeled_t    bar
> # cat foo.te
> policy_module(foo, 1.0)
> type foo_exec_t;
> files_type(foo_exec_t)
> # make -f /usr/share/selinux/devel/Makefile foo.pp
> # semodule -i foo.pp # defines foo_exec_t
> # ls -Z bar
> -rw-r--r--  root root user_u:object_r:foo_exec_t       bar
> # semodule -r foo
> # ls -Z bar
> -rw-r--r--  root root system_u:object_r:unlabeled_t    bar
> # semodule -i foo.pp
> # ls -Z bar
> -rw-r--r--  root root user_u:object_r:foo_exec_t       bar
> 
> ---<snip>---
> 
> Introduce support for deferred mapping of security contexts in the
> SID table upon policy reload, and use this support for inode security
> contexts when the context is not yet valid under the current policy.
> Only processes with CAP_MAC_OVERRIDE + mac_override permission can
> set such invalid security contexts on inodes.  Inodes with such
> invalid contexts are treated as having the unlabeled SID until the context 
> becomes valid under a policy.  This support is for use by privileged
> processes
> like rpm that need to set down files in the proper security contexts prior to
> 
> loading the policy module that defines the context and its associated rules.
> 
> ---
> 
>  security/selinux/hooks.c            |   18 ++-
>  security/selinux/include/security.h |    2 
>  security/selinux/ss/context.h       |   27 ++++
>  security/selinux/ss/mls.c           |   11 +-
>  security/selinux/ss/mls.h           |    3 
>  security/selinux/ss/services.c      |  198
> +++++++++++++++++++++++++-----------
>  security/selinux/ss/sidtab.c        |    6 -
>  7 files changed, 194 insertions(+), 71 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 308e2cf..250344c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2667,6 +2667,11 @@ static int selinux_inode_setxattr(struct dentry
> *dentry, char *name, void *value
>  		return rc;
>  
>  	rc = security_context_to_sid(value, size, &newsid);
> +	if (rc == -EINVAL) {
> +		if (!capable(CAP_MAC_OVERRIDE))
> +			return rc;
> +		rc = security_context_to_sid_force(value, size, &newsid);
> +	}
>  	if (rc)
>  		return rc;
>  
> @@ -2700,10 +2705,11 @@ static void selinux_inode_post_setxattr(struct dentry
> *dentry, char *name,
>  		return;
>  	}
>  
> -	rc = security_context_to_sid(value, size, &newsid);
> +	rc = security_context_to_sid_force(value, size, &newsid);
>  	if (rc) {
> -		printk(KERN_WARNING "%s:  unable to obtain SID for context "
> -		       "%s, rc=%d\n", __func__, (char *)value, -rc);
> +		printk(KERN_ERR "SELinux:  unable to map context to SID"
> +		       "for (%s, %lu), rc=%d\n",
> +		       inode->i_sb->s_id, inode->i_ino, -rc);
>  		return;
>  	}
>  
> @@ -5152,6 +5158,12 @@ static int selinux_setprocattr(struct task_struct *p,
>  			size--;
>  		}
>  		error = security_context_to_sid(value, size, &sid);
> +		if (error == -EINVAL && !strcmp(name, "fscreate")) {
> +			if (!capable(CAP_MAC_OVERRIDE))
> +				return error;
> +			error = security_context_to_sid_force(value, size,
> +							      &sid);
> +		}
>  		if (error)
>  			return error;
>  	}
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index 1904c46..112d4b1 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -99,6 +99,8 @@ int security_context_to_sid(char *scontext, u32
> scontext_len,
>  int security_context_to_sid_default(char *scontext, u32 scontext_len,
>  				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
>  
> +int security_context_to_sid_force(char *scontext, u32 scontext_len, u32
> *sid);
> +
>  int security_get_user_sids(u32 callsid, char *username,
>  			   u32 **sids, u32 *nel);
>  
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 2eee0da..776d90f 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -28,6 +28,8 @@ struct context {
>  	u32 role;
>  	u32 type;
>  	struct mls_range range;
> +	char *str;	/* string representation if context cannot be mapped. */
> +	u32 len;        /* length of string in bytes */
>  };
>  
>  static inline void mls_context_init(struct context *c)
> @@ -106,20 +108,43 @@ static inline void context_init(struct context *c)
>  
>  static inline int context_cpy(struct context *dst, struct context *src)
>  {
> +	int rc;
> +
>  	dst->user = src->user;
>  	dst->role = src->role;
>  	dst->type = src->type;
> -	return mls_context_cpy(dst, src);
> +	if (src->str) {
> +		dst->str = kstrdup(src->str, GFP_ATOMIC);
> +		if (!dst->str)
> +			return -ENOMEM;
> +		dst->len = src->len;
> +	} else {
> +		dst->str = NULL;
> +		dst->len = 0;
> +	}
> +	rc = mls_context_cpy(dst, src);
> +	if (rc) {
> +		kfree(dst->str);
> +		return rc;
> +	}
> +	return 0;
>  }
>  
>  static inline void context_destroy(struct context *c)
>  {
>  	c->user = c->role = c->type = 0;
> +	kfree(c->str);
> +	c->str = NULL;
> +	c->len = 0;
>  	mls_context_destroy(c);
>  }
>  
>  static inline int context_cmp(struct context *c1, struct context *c2)
>  {
> +	if (c1->len && c2->len)
> +		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
> +	if (c1->len || c2->len)
> +		return 0;
>  	return ((c1->user == c2->user) &&
>  		(c1->role == c2->role) &&
>  		(c1->type == c2->type) &&
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 8b1706b..a6ca058 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -239,7 +239,8 @@ int mls_context_isvalid(struct policydb *p, struct
> context *c)
>   * Policy read-lock must be held for sidtab lookup.
>   *
>   */
> -int mls_context_to_sid(char oldc,
> +int mls_context_to_sid(struct policydb *pol,
> +		       char oldc,
>  		       char **scontext,
>  		       struct context *context,
>  		       struct sidtab *s,
> @@ -286,7 +287,7 @@ int mls_context_to_sid(char oldc,
>  		*p++ = 0;
>  
>  	for (l = 0; l < 2; l++) {
> -		levdatum = hashtab_search(policydb.p_levels.table, scontextp);
> +		levdatum = hashtab_search(pol->p_levels.table, scontextp);
>  		if (!levdatum) {
>  			rc = -EINVAL;
>  			goto out;
> @@ -311,7 +312,7 @@ int mls_context_to_sid(char oldc,
>  					*rngptr++ = 0;
>  				}
>  
> -				catdatum = hashtab_search(policydb.p_cats.table,
> +				catdatum = hashtab_search(pol->p_cats.table,
>  							  scontextp);
>  				if (!catdatum) {
>  					rc = -EINVAL;
> @@ -327,7 +328,7 @@ int mls_context_to_sid(char oldc,
>  				if (rngptr) {
>  					int i;
>  
> -					rngdatum = hashtab_search(policydb.p_cats.table, rngptr);
> +					rngdatum = hashtab_search(pol->p_cats.table, rngptr);
>  					if (!rngdatum) {
>  						rc = -EINVAL;
>  						goto out;
> @@ -395,7 +396,7 @@ int mls_from_string(char *str, struct context *context,
> gfp_t gfp_mask)
>  	if (!tmpstr) {
>  		rc = -ENOMEM;
>  	} else {
> -		rc = mls_context_to_sid(':', &tmpstr, context,
> +		rc = mls_context_to_sid(&policydb, ':', &tmpstr, context,
>  					NULL, SECSID_NULL);
>  		kfree(freestr);
>  	}
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index ab53663..900fb0e 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -30,7 +30,8 @@ int mls_context_isvalid(struct policydb *p, struct context
> *c);
>  int mls_range_isvalid(struct policydb *p, struct mls_range *r);
>  int mls_level_isvalid(struct policydb *p, struct mls_level *l);
>  
> -int mls_context_to_sid(char oldc,
> +int mls_context_to_sid(struct policydb *p,
> +		       char oldc,
>  	               char **scontext,
>  		       struct context *context,
>  		       struct sidtab *s,
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 2daaddb..6724b4f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -708,36 +708,24 @@ out:
>  
>  }
>  
> -static int security_context_to_sid_core(char *scontext, u32 scontext_len,
> -					u32 *sid, u32 def_sid, gfp_t gfp_flags)
> +static int string_to_context_struct(struct policydb *pol,
> +				    struct sidtab *sidtabp,
> +				    char *scontext,
> +				    u32 scontext_len,
> +				    struct context *ctx,
> +				    u32 def_sid,
> +				    gfp_t gfp_flags)
>  {
> -	char *scontext2;
> -	struct context context;
> +	char *scontext2 = NULL;
>  	struct role_datum *role;
>  	struct type_datum *typdatum;
>  	struct user_datum *usrdatum;
>  	char *scontextp, *p, oldc;
>  	int rc = 0;
>  
> -	if (!ss_initialized) {
> -		int i;
> +	context_init(ctx);
>  
> -		for (i = 1; i < SECINITSID_NUM; i++) {
> -			if (!strcmp(initial_sid_to_string[i], scontext)) {
> -				*sid = i;
> -				goto out;
> -			}
> -		}
> -		*sid = SECINITSID_KERNEL;
> -		goto out;
> -	}
> -	*sid = SECSID_NULL;
> -
> -	/* Copy the string so that we can modify the copy as we parse it.
> -	   The string should already by null terminated, but we append a
> -	   null suffix to the copy to avoid problems with the existing
> -	   attr package, which doesn't view the null terminator as part
> -	   of the attribute value. */
> +	/* Copy the string so that we can modify the copy as we parse it. */
>  	scontext2 = kmalloc(scontext_len+1, gfp_flags);
>  	if (!scontext2) {
>  		rc = -ENOMEM;
> @@ -746,11 +734,6 @@ static int security_context_to_sid_core(char *scontext,
> u32 scontext_len,
>  	memcpy(scontext2, scontext, scontext_len);
>  	scontext2[scontext_len] = 0;
>  
> -	context_init(&context);
> -	*sid = SECSID_NULL;
> -
> -	POLICY_RDLOCK;
> -
>  	/* Parse the security context. */
>  
>  	rc = -EINVAL;
> @@ -762,15 +745,15 @@ static int security_context_to_sid_core(char *scontext,
> u32 scontext_len,
>  		p++;
>  
>  	if (*p == 0)
> -		goto out_unlock;
> +		goto out;
>  
>  	*p++ = 0;
>  
> -	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
> +	usrdatum = hashtab_search(pol->p_users.table, scontextp);
>  	if (!usrdatum)
> -		goto out_unlock;
> +		goto out;
>  
> -	context.user = usrdatum->value;
> +	ctx->user = usrdatum->value;
>  
>  	/* Extract role. */
>  	scontextp = p;
> @@ -778,14 +761,14 @@ static int security_context_to_sid_core(char *scontext,
> u32 scontext_len,
>  		p++;
>  
>  	if (*p == 0)
> -		goto out_unlock;
> +		goto out;
>  
>  	*p++ = 0;
>  
> -	role = hashtab_search(policydb.p_roles.table, scontextp);
> +	role = hashtab_search(pol->p_roles.table, scontextp);
>  	if (!role)
> -		goto out_unlock;
> -	context.role = role->value;
> +		goto out;
> +	ctx->role = role->value;
>  
>  	/* Extract type. */
>  	scontextp = p;
> @@ -794,33 +777,74 @@ static int security_context_to_sid_core(char *scontext,
> u32 scontext_len,
>  	oldc = *p;
>  	*p++ = 0;
>  
> -	typdatum = hashtab_search(policydb.p_types.table, scontextp);
> +	typdatum = hashtab_search(pol->p_types.table, scontextp);
>  	if (!typdatum)
> -		goto out_unlock;
> +		goto out;
>  
> -	context.type = typdatum->value;
> +	ctx->type = typdatum->value;
>  
> -	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
> +	rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
>  	if (rc)
> -		goto out_unlock;
> +		goto out;
>  
>  	if ((p - scontext2) < scontext_len) {
>  		rc = -EINVAL;
> -		goto out_unlock;
> +		goto out;
>  	}
>  
>  	/* Check the validity of the new context. */
> -	if (!policydb_context_isvalid(&policydb, &context)) {
> +	if (!policydb_context_isvalid(pol, ctx)) {
>  		rc = -EINVAL;
> -		goto out_unlock;
> +		context_destroy(ctx);
> +		goto out;
>  	}
> -	/* Obtain the new sid. */
> -	rc = sidtab_context_to_sid(&sidtab, &context, sid);
> -out_unlock:
> -	POLICY_RDUNLOCK;
> -	context_destroy(&context);
> +	rc = 0;
> +out:
>  	kfree(scontext2);
> +	return rc;
> +}
> +
> +static int security_context_to_sid_core(char *scontext, u32 scontext_len,
> +					u32 *sid, u32 def_sid, gfp_t gfp_flags,
> +					int force)
> +{
> +	struct context context;
> +	int rc = 0;
> +
> +	if (!ss_initialized) {
> +		int i;
> +
> +		for (i = 1; i < SECINITSID_NUM; i++) {
> +			if (!strcmp(initial_sid_to_string[i], scontext)) {
> +				*sid = i;
> +				goto out;
> +			}
> +		}
> +		*sid = SECINITSID_KERNEL;
> +		goto out;
> +	}
> +	*sid = SECSID_NULL;
> +
> +	POLICY_RDLOCK;
> +	rc = string_to_context_struct(&policydb, &sidtab,
> +				      scontext, scontext_len,
> +				      &context, def_sid, gfp_flags);
> +	if (rc == -EINVAL && force) {
> +		context.str = kmalloc(scontext_len+1, gfp_flags);
> +		if (!context.str) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(context.str, scontext, scontext_len);
> +		context.str[scontext_len] = 0;
> +		context.len = scontext_len;
> +	} else if (rc)
> +		goto out;
> +	rc = sidtab_context_to_sid(&sidtab, &context, sid);
> +	if (rc)
> +		context_destroy(&context);
>  out:
> +	POLICY_RDUNLOCK;
>  	return rc;
>  }
>  
> @@ -838,7 +862,7 @@ out:
>  int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
> -					    sid, SECSID_NULL, GFP_KERNEL);
> +					    sid, SECSID_NULL, GFP_KERNEL, 0);
>  }
>  
>  /**
> @@ -855,6 +879,7 @@ int security_context_to_sid(char *scontext, u32
> scontext_len, u32 *sid)
>   * The default SID is passed to the MLS layer to be used to allow
>   * kernel labeling of the MLS field if the MLS field is not present
>   * (for upgrading to MLS without full relabel).
> + * Implicitly forces adding of the context even if it cannot be mapped yet.
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
> @@ -862,7 +887,13 @@ int security_context_to_sid_default(char *scontext, u32
> scontext_len, u32 *sid,
>  				    u32 def_sid, gfp_t gfp_flags)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
> -					    sid, def_sid, gfp_flags);
> +					    sid, def_sid, gfp_flags, 1);
> +}
> +
> +int security_context_to_sid_force(char *scontext, u32 scontext_len, u32
> *sid)
> +{
> +	return security_context_to_sid_core(scontext, scontext_len,
> +					    sid, SECSID_NULL, GFP_KERNEL, 1);
>  }
>  
>  static int compute_sid_handle_invalid_context(
> @@ -1246,9 +1277,12 @@ static inline int
> convert_context_handle_invalid_context(struct context *context
>  		char *s;
>  		u32 len;
>  
> -		context_struct_to_string(context, &s, &len);
> -		printk(KERN_ERR "SELinux:  context %s is invalid\n", s);
> -		kfree(s);
> +		if (!context_struct_to_string(context, &s, &len)) {
> +			printk(KERN_WARNING
> +		       "SELinux:  Context %s would be invalid if enforcing\n",
> +			       s);
> +			kfree(s);
> +		}
>  	}
>  	return rc;
>  }
> @@ -1280,6 +1314,32 @@ static int convert_context(u32 key,
>  
>  	args = p;
>  
> +	if (c->str) {
> +		struct context ctx;
> +		rc = string_to_context_struct(args->newp, NULL, c->str,
> +					      c->len, &ctx, SECSID_NULL,
> +					      GFP_KERNEL);
> +		if (!rc) {
> +			printk(KERN_INFO
> +		       "SELinux:  Context %s became valid (mapped).\n",
> +			       c->str);
> +			/* Replace string with mapped representation. */
> +			kfree(c->str);
> +			memcpy(c, &ctx, sizeof(*c));
> +			goto out;
> +		} else if (rc == -EINVAL) {
> +			/* Retain string representation for later mapping. */
> +			rc = 0;
> +			goto out;
> +		} else {
> +			/* Other error condition, e.g. ENOMEM. */
> +			printk(KERN_ERR
> +		       "SELinux:   Unable to map context %s, rc = %d.\n",
> +			       c->str, -rc);
> +			goto out;
> +		}
> +	}
> +
>  	rc = context_cpy(&oldc, c);
>  	if (rc)
>  		goto out;
> @@ -1319,13 +1379,21 @@ static int convert_context(u32 key,
>  	}
>  
>  	context_destroy(&oldc);
> +	rc = 0;
>  out:
>  	return rc;
>  bad:
> -	context_struct_to_string(&oldc, &s, &len);
> +	/* Map old representation to string and save it. */
> +	if (context_struct_to_string(&oldc, &s, &len))
> +		return -ENOMEM;
>  	context_destroy(&oldc);
> -	printk(KERN_ERR "SELinux:  invalidating context %s\n", s);
> -	kfree(s);
> +	context_destroy(c);
> +	c->str = s;
> +	c->len = len;
> +	printk(KERN_INFO
> +	       "SELinux:  Context %s became invalid (unmapped).\n",
> +	       c->str);
> +	rc = 0;
>  	goto out;
>  }
>  
> @@ -1406,7 +1474,11 @@ int security_load_policy(void *data, size_t len)
>  		return -EINVAL;
>  	}
>  
> -	sidtab_init(&newsidtab);
> +	if (sidtab_init(&newsidtab)) {
> +		LOAD_UNLOCK;
> +		policydb_destroy(&newpolicydb);
> +		return -ENOMEM;
> +	}
>  
>  	/* Verify that the kernel defined classes are correct. */
>  	if (validate_classes(&newpolicydb)) {
> @@ -1429,11 +1501,15 @@ int security_load_policy(void *data, size_t len)
>  		goto err;
>  	}
>  
> -	/* Convert the internal representations of contexts
> -	   in the new SID table and remove invalid SIDs. */
> +	/*
> +	 * Convert the internal representations of contexts
> +	 * in the new SID table.
> +	 */
>  	args.oldp = &policydb;
>  	args.newp = &newpolicydb;
> -	sidtab_map_remove_on_error(&newsidtab, convert_context, &args);
> +	rc = sidtab_map(&newsidtab, convert_context, &args);
> +	if (rc)
> +		goto err;
>  
>  	/* Save the old policydb and SID table to free later. */
>  	memcpy(&oldpolicydb, &policydb, sizeof policydb);
> @@ -1673,6 +1749,8 @@ int security_get_user_sids(u32 fromsid,
>  
>  	POLICY_RDLOCK;
>  
> +	context_init(&usercon);
> +
>  	fromcon = sidtab_search(&sidtab, fromsid);
>  	if (!fromcon) {
>  		rc = -EINVAL;
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 4a516ff..7f4c0d0 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -99,7 +99,7 @@ struct context *sidtab_search(struct sidtab *s, u32 sid)
>  	while (cur != NULL && sid > cur->sid)
>  		cur = cur->next;
>  
> -	if (cur == NULL || sid != cur->sid) {
> +	if (cur == NULL || sid != cur->sid || cur->context.len) {
>  		/* Remap invalid SIDs to the unlabeled SID. */
>  		sid = SECINITSID_UNLABELED;
>  		hvalue = SIDTAB_HASH(sid);
> @@ -215,6 +215,10 @@ int sidtab_context_to_sid(struct sidtab *s,
>  			goto unlock_out;
>  		}
>  		sid = s->next_sid++;
> +		if (context->len)
> +			printk(KERN_INFO
> +		       "SELinux:  Context %s is not valid (left unmapped).\n",
> +			       context->str);
>  		ret = sidtab_insert(s, sid, context);
>  		if (ret)
>  			s->next_sid--;
> 
> 
> 
>  
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
