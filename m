Message-ID: <4473531C.2010802@redhat.com>
Date: Tue, 23 May 2006 14:23:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>,
        Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
 of inode security contexts
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>	 <20060517075435.GB7665@thorium.jmh.mhn.de>	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>	 <20060518181452.GA4935@thorium2.jmh.mhn.de>	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com> <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-05-19 at 09:18 -0400, Karl MacMillan wrote:
>   
>> On Fri, 2006-05-19 at 08:59 -0400, Stephen Smalley wrote:
>>     
>>> In the labelpriv model, rpm doesn't have to visit the individual files
>>> afterward in the common case; it just calls security_check_context(3) on
>>> each distinct context stored in the rpm header (once per context, not
>>> per file) after the module insertion phase, and if any of them are still
>>> invalid (the uncommon case), rpm then takes corrective action (whether
>>> that means relabeling files that had those invalid labels to truly be
>>> unlabeled_t, removing those files, or reverting the install altogether -
>>> the latter seems cleanest to me).  If we can't get a guarantee that rpm
>>> will perform such checking and take corrective action, then I'd agree
>>> that the kernel change is a no-go.
>>>
>>>       
>> The question is when the labels will become valid.
>>
>> Thinking through this more I realized that if we cannot guarantee
>> ordering within a transaction we cannot commit any policy modules until
>> the end of the transaction. Otherwise it will not be possible to have
>> _any_ dependencies between policy modules, which doesn't seem likely
>> based on my recent investigations into refpolicy dependencies.
>>
>> If policy modules are only committed at the end of the transaction,
>> verification of the rpms will require going back through the headers of
>> every rpm in the transaction.
>>
>> Dan, Jeremy, Paul, any thoughts about when the policy modules will be
>> committed?
>>     
>
> Below is an updated version of the kernel patch to support rpm labeling
> of files before policy load, with a couple of bug fixes and a re-base to
> 2.6.17-rc4-mm3.  Note that before we can upstream this, we need to
> resolve the issues of how rpm will check file label validity after
> policy load (e.g. calling security_check_context(3) on each label from
> the header), what corrective action rpm will take if a file label is
> invalid (options suggested include relabeling to unlabeled_t, relabeling
> to the context returned by the system policy via matchpathcon, or
> reverting the install), and the issues raised by Karl above (as they
> also affect the ability of rpm to perform such verification and
> correction sanely).
>
>   
As far as I understand it, rpm will not go back and check the whether 
the context are sane.  If the
postinstall of policy fails, the context on disk will be incorrect and 
treated like unlabeled_t.

Jeremy and Paul is that your understanding?

Dan
> ---<snip>---
>
> Introduce support for deferring mapping of security contexts in the
> SID table upon policy reload, and use this support for inode security
> contexts when the context is not yet valid under the current policy.
> Only processes with 'labelpriv' permission to the 'security' class can
> set such invalid security contexts on inodes.  Inodes with such
> invalid contexts are treated as having the unlabeled SID until the context 
> becomes valid under a policy.  This support is for use by privileged processes
> like rpm that need to set down files in the proper security contexts prior to 
> loading the policy module that defines the context and its associated rules.
>
> ---
>
>  security/selinux/hooks.c                     |   16 +-
>  security/selinux/include/av_perm_to_string.h |    1 
>  security/selinux/include/av_permissions.h    |    1 
>  security/selinux/include/objsec.h            |    3 
>  security/selinux/include/security.h          |    2 
>  security/selinux/selinuxfs.c                 |    4 
>  security/selinux/ss/context.h                |   17 ++
>  security/selinux/ss/mls.c                    |   11 -
>  security/selinux/ss/mls.h                    |    3 
>  security/selinux/ss/services.c               |  213 +++++++++++++++++----------
>  security/selinux/ss/sidtab.c                 |    4 
>  11 files changed, 189 insertions(+), 86 deletions(-)
>
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/hooks.c linux-2.6.17-rc4-mm3-x/security/selinux/hooks.c
> --- linux-2.6.17-rc4-mm3/security/selinux/hooks.c	2006-05-22 09:09:46.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/hooks.c	2006-05-23 08:57:55.000000000 -0400
> @@ -2165,6 +2165,11 @@ static int selinux_inode_setxattr(struct
>  		return rc;
>  
>  	rc = security_context_to_sid(value, size, &newsid);
> +	if (rc == -EINVAL) {
> +		if (task_has_security(current, SECURITY__LABELPRIV))
> +			return rc;
> +		rc = security_context_to_sid_force(value, size, &newsid);
> +	}
>  	if (rc)
>  		return rc;
>  
> @@ -2198,10 +2203,11 @@ static void selinux_inode_post_setxattr(
>  		return;
>  	}
>  
> -	rc = security_context_to_sid(value, size, &newsid);
> +	rc = security_context_to_sid_force(value, size, &newsid);
>  	if (rc) {
>  		printk(KERN_WARNING "%s:  unable to obtain SID for context "
> -		       "%s, rc=%d\n", __FUNCTION__, (char*)value, -rc);
> +		       "%s on (%s, %lu), rc=%d\n", __FUNCTION__, (char*)value,
> +		       inode->i_sb->s_id, inode->i_ino, -rc);
>  		return;
>  	}
>  
> @@ -4186,6 +4192,12 @@ static int selinux_setprocattr(struct ta
>  			size--;
>  		}
>  		error = security_context_to_sid(value, size, &sid);
> +		if (error == -EINVAL && !strcmp(name, "fscreate")) {
> +			if (task_has_security(current, SECURITY__LABELPRIV))
> +				return error;
> +			error = security_context_to_sid_force(value, size,
> +							      &sid);
> +		}
>  		if (error)
>  			return error;
>  	}
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/include/av_permissions.h linux-2.6.17-rc4-mm3-x/security/selinux/include/av_permissions.h
> --- linux-2.6.17-rc4-mm3/security/selinux/include/av_permissions.h	2006-05-22 09:09:46.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/include/av_permissions.h	2006-05-23 08:57:55.000000000 -0400
> @@ -526,6 +526,7 @@
>  #define SECURITY__SETBOOL                         0x00000100UL
>  #define SECURITY__SETSECPARAM                     0x00000200UL
>  #define SECURITY__SETCHECKREQPROT                 0x00000400UL
> +#define SECURITY__LABELPRIV                       0x00000800UL
>  
>  #define SYSTEM__IPC_INFO                          0x00000001UL
>  #define SYSTEM__SYSLOG_READ                       0x00000002UL
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc4-mm3-x/security/selinux/include/av_perm_to_string.h
> --- linux-2.6.17-rc4-mm3/security/selinux/include/av_perm_to_string.h	2006-05-22 09:09:46.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/include/av_perm_to_string.h	2006-05-23 08:57:55.000000000 -0400
> @@ -87,6 +87,7 @@
>     S_(SECCLASS_SECURITY, SECURITY__SETBOOL, "setbool")
>     S_(SECCLASS_SECURITY, SECURITY__SETSECPARAM, "setsecparam")
>     S_(SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT, "setcheckreqprot")
> +   S_(SECCLASS_SECURITY, SECURITY__LABELPRIV, "labelpriv")
>     S_(SECCLASS_SYSTEM, SYSTEM__IPC_INFO, "ipc_info")
>     S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, "syslog_read")
>     S_(SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, "syslog_mod")
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/include/objsec.h linux-2.6.17-rc4-mm3-x/security/selinux/include/objsec.h
> --- linux-2.6.17-rc4-mm3/security/selinux/include/objsec.h	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/include/objsec.h	2006-05-23 08:57:55.000000000 -0400
> @@ -101,4 +101,7 @@ struct sk_security_struct {
>  
>  extern unsigned int selinux_checkreqprot;
>  
> +extern int task_has_security(struct task_struct *tsk,
> +			     u32 perms);
> +
>  #endif /* _SELINUX_OBJSEC_H_ */
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/include/security.h linux-2.6.17-rc4-mm3-x/security/selinux/include/security.h
> --- linux-2.6.17-rc4-mm3/security/selinux/include/security.h	2006-05-22 09:09:22.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/include/security.h	2006-05-23 08:57:55.000000000 -0400
> @@ -63,6 +63,8 @@ int security_context_to_sid(char *sconte
>  
>  int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *out_sid, u32 def_sid);
>  
> +int security_context_to_sid_force(char *scontext, u32 scontext_len, u32 *sid);
> +
>  int security_get_user_sids(u32 callsid, char *username,
>  			   u32 **sids, u32 *nel);
>  
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/selinuxfs.c linux-2.6.17-rc4-mm3-x/security/selinux/selinuxfs.c
> --- linux-2.6.17-rc4-mm3/security/selinux/selinuxfs.c	2006-05-22 09:09:46.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/selinuxfs.c	2006-05-23 08:57:55.000000000 -0400
> @@ -71,8 +71,8 @@ static int *bool_pending_values = NULL;
>  extern void selnl_notify_setenforce(int val);
>  
>  /* Check whether a task is allowed to use a security operation. */
> -static int task_has_security(struct task_struct *tsk,
> -			     u32 perms)
> +int task_has_security(struct task_struct *tsk,
> +		      u32 perms)
>  {
>  	struct task_security_struct *tsec;
>  
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/ss/context.h linux-2.6.17-rc4-mm3-x/security/selinux/ss/context.h
> --- linux-2.6.17-rc4-mm3/security/selinux/ss/context.h	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/ss/context.h	2006-05-23 12:16:28.000000000 -0400
> @@ -28,6 +28,8 @@ struct context {
>  	u32 role;
>  	u32 type;
>  	struct mls_range range;
> +	char *str;	/* string representation if context cannot be mapped. */
> +	u32 len;        /* length of string in bytes, including NUL byte. */
>  };
>  
>  static inline void mls_context_init(struct context *c)
> @@ -83,6 +85,14 @@ static inline void context_init(struct c
>  
>  static inline int context_cpy(struct context *dst, struct context *src)
>  {
> +	context_init(dst);
> +	if (src->len) {
> +		dst->str = kstrdup(src->str, GFP_ATOMIC);
> +		if (!dst->str)
> +			return -ENOMEM;
> +		dst->len = src->len;
> +		return 0;
> +	}
>  	dst->user = src->user;
>  	dst->role = src->role;
>  	dst->type = src->type;
> @@ -91,12 +101,17 @@ static inline int context_cpy(struct con
>  
>  static inline void context_destroy(struct context *c)
>  {
> -	c->user = c->role = c->type = 0;
> +	kfree(c->str);
>  	mls_context_destroy(c);
> +	context_init(c);
>  }
>  
>  static inline int context_cmp(struct context *c1, struct context *c2)
>  {
> +	if (c1->len && c2->len)
> +		return (c1->len == c2->len && !memcmp(c1->str, c2->str, c1->len));
> +	if (c1->len || c2->len)
> +		return 0;
>  	return ((c1->user == c2->user) &&
>  		(c1->role == c2->role) &&
>  		(c1->type == c2->type) &&
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/ss/mls.c linux-2.6.17-rc4-mm3-x/security/selinux/ss/mls.c
> --- linux-2.6.17-rc4-mm3/security/selinux/ss/mls.c	2006-05-22 09:09:22.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/ss/mls.c	2006-05-23 08:57:55.000000000 -0400
> @@ -249,7 +249,8 @@ static inline int mls_copy_context(struc
>   * Policy read-lock must be held for sidtab lookup.
>   *
>   */
> -int mls_context_to_sid(char oldc,
> +int mls_context_to_sid(struct policydb *pol,
> +		       char oldc,
>  		       char **scontext,
>  		       struct context *context,
>  		       struct sidtab *s,
> @@ -296,7 +297,7 @@ int mls_context_to_sid(char oldc,
>  		*p++ = 0;
>  
>  	for (l = 0; l < 2; l++) {
> -		levdatum = hashtab_search(policydb.p_levels.table, scontextp);
> +		levdatum = hashtab_search(pol->p_levels.table, scontextp);
>  		if (!levdatum) {
>  			rc = -EINVAL;
>  			goto out;
> @@ -320,7 +321,7 @@ int mls_context_to_sid(char oldc,
>  					*rngptr++ = 0;
>  				}
>  
> -				catdatum = hashtab_search(policydb.p_cats.table,
> +				catdatum = hashtab_search(pol->p_cats.table,
>  				                          scontextp);
>  				if (!catdatum) {
>  					rc = -EINVAL;
> @@ -336,7 +337,7 @@ int mls_context_to_sid(char oldc,
>  				if (rngptr) {
>  					int i;
>  
> -					rngdatum = hashtab_search(policydb.p_cats.table, rngptr);
> +					rngdatum = hashtab_search(pol->p_cats.table, rngptr);
>  					if (!rngdatum) {
>  						rc = -EINVAL;
>  						goto out;
> @@ -404,7 +405,7 @@ int mls_from_string(char *str, struct co
>  	if (!tmpstr) {
>  		rc = -ENOMEM;
>  	} else {
> -		rc = mls_context_to_sid(':', &tmpstr, context,
> +		rc = mls_context_to_sid(&policydb, ':', &tmpstr, context,
>  		                        NULL, SECSID_NULL);
>  		kfree(freestr);
>  	}
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/ss/mls.h linux-2.6.17-rc4-mm3-x/security/selinux/ss/mls.h
> --- linux-2.6.17-rc4-mm3/security/selinux/ss/mls.h	2006-05-22 09:09:22.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/ss/mls.h	2006-05-23 08:57:55.000000000 -0400
> @@ -21,7 +21,8 @@ int mls_compute_context_len(struct conte
>  void mls_sid_to_context(struct context *context, char **scontext);
>  int mls_context_isvalid(struct policydb *p, struct context *c);
>  
> -int mls_context_to_sid(char oldc,
> +int mls_context_to_sid(struct policydb *p,
> +		       char oldc,
>  	               char **scontext,
>  		       struct context *context,
>  		       struct sidtab *s,
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/ss/services.c linux-2.6.17-rc4-mm3-x/security/selinux/ss/services.c
> --- linux-2.6.17-rc4-mm3/security/selinux/ss/services.c	2006-05-22 09:09:46.000000000 -0400
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/ss/services.c	2006-05-23 12:17:26.000000000 -0400
> @@ -623,48 +623,31 @@ out:
>  
>  }
>  
> -static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
> +static int string_to_context_struct(struct policydb *pol,
> +				    struct sidtab *sidtabp,
> +				    char *scontext,
> +				    u32 scontext_len,
> +				    struct context *ctx,
> +				    u32 def_sid)
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
> -
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
> +	context_init(ctx);
>  
> -	/* Copy the string so that we can modify the copy as we parse it.
> -	   The string should already by null terminated, but we append a
> -	   null suffix to the copy to avoid problems with the existing
> -	   attr package, which doesn't view the null terminator as part
> -	   of the attribute value. */
> -	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
> +	/* Copy the string so that we can modify the copy as we parse it. */
> +	scontext2 = kmalloc(scontext_len+1, GFP_ATOMIC);
>  	if (!scontext2) {
>  		rc = -ENOMEM;
> -		goto out;
> +		goto err;
>  	}
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
> @@ -676,15 +659,15 @@ static int security_context_to_sid_core(
>  		p++;
>  
>  	if (*p == 0)
> -		goto out_unlock;
> +		goto err;
>  
>  	*p++ = 0;
>  
> -	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
> +	usrdatum = hashtab_search(pol->p_users.table, scontextp);
>  	if (!usrdatum)
> -		goto out_unlock;
> +		goto err;
>  
> -	context.user = usrdatum->value;
> +	ctx->user = usrdatum->value;
>  
>  	/* Extract role. */
>  	scontextp = p;
> @@ -692,14 +675,14 @@ static int security_context_to_sid_core(
>  		p++;
>  
>  	if (*p == 0)
> -		goto out_unlock;
> +		goto err;
>  
>  	*p++ = 0;
>  
> -	role = hashtab_search(policydb.p_roles.table, scontextp);
> +	role = hashtab_search(pol->p_roles.table, scontextp);
>  	if (!role)
> -		goto out_unlock;
> -	context.role = role->value;
> +		goto err;
> +	ctx->role = role->value;
>  
>  	/* Extract type. */
>  	scontextp = p;
> @@ -708,32 +691,74 @@ static int security_context_to_sid_core(
>  	oldc = *p;
>  	*p++ = 0;
>  
> -	typdatum = hashtab_search(policydb.p_types.table, scontextp);
> +	typdatum = hashtab_search(pol->p_types.table, scontextp);
>  	if (!typdatum)
> -		goto out_unlock;
> +		goto err;
>  
> -	context.type = typdatum->value;
> +	ctx->type = typdatum->value;
>  
> -	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
> +	rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
>  	if (rc)
> -		goto out_unlock;
> +		goto err;
>  
> -	if ((p - scontext2) < scontext_len) {
> -		rc = -EINVAL;
> -		goto out_unlock;
> -	}
> +	rc = -EINVAL;
> +	if ((p - scontext2) < scontext_len)
> +		goto err;
>  
>  	/* Check the validity of the new context. */
> -	if (!policydb_context_isvalid(&policydb, &context)) {
> -		rc = -EINVAL;
> -		goto out_unlock;
> +	if (!policydb_context_isvalid(pol, ctx))
> +		goto err;
> +
> +	rc = 0;
> +out:
> +	kfree(scontext2);
> +	return rc;
> +err:
> +	context_destroy(ctx);
> +	goto out;
> +}
> +
> +static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid, int force)
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
>  	}
> -	/* Obtain the new sid. */
> +	*sid = SECSID_NULL;
> +
> +	POLICY_RDLOCK;
> +	rc = string_to_context_struct(&policydb, &sidtab,
> +				      scontext, scontext_len,
> +				      &context, def_sid);
> +	if (rc == -EINVAL && force && scontext_len) {
> +		context_init(&context);
> +		context.len = scontext_len;
> +		if (scontext[scontext_len-1])
> +			context.len++; /* extend for NUL. */
> +		context.str = kmalloc(context.len, GFP_ATOMIC);
> +		if (!context.str) {
> +			rc = -ENOMEM;
> +			goto out_unlock;
> +		}
> +		memcpy(context.str, scontext, scontext_len);
> +		context.str[context.len-1] = 0;
> +	} else if (rc)
> +		goto out_unlock;
>  	rc = sidtab_context_to_sid(&sidtab, &context, sid);
> +	context_destroy(&context);
>  out_unlock:
>  	POLICY_RDUNLOCK;
> -	context_destroy(&context);
> -	kfree(scontext2);
>  out:
>  	return rc;
>  }
> @@ -752,7 +777,7 @@ out:
>  int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
> -	                                    sid, SECSID_NULL);
> +	                                    sid, SECSID_NULL, 0);
>  }
>  
>  /**
> @@ -769,13 +794,21 @@ int security_context_to_sid(char *sconte
>   * The default SID is passed to the MLS layer to be used to allow
>   * kernel labeling of the MLS field if the MLS field is not present
>   * (for upgrading to MLS without full relabel).
> + * Adds the string representation if the context cannot be mapped under
> + * current policy.
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
>  int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
> -	                                    sid, def_sid);
> +	                                    sid, def_sid, 1);
> +}
> +
> +int security_context_to_sid_force(char *scontext, u32 scontext_len, u32 *sid)
> +{
> +	return security_context_to_sid_core(scontext, scontext_len,
> +	                                    sid, SECSID_NULL, 1);
>  }
>  
>  static int compute_sid_handle_invalid_context(
> @@ -1112,9 +1145,10 @@ static inline int convert_context_handle
>  		char *s;
>  		u32 len;
>  
> -		context_struct_to_string(context, &s, &len);
> -		printk(KERN_ERR "security:  context %s is invalid\n", s);
> -		kfree(s);
> +		if (!context_struct_to_string(context, &s, &len)) {
> +			printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
> +			kfree(s);
> +		}
>  	}
>  	return rc;
>  }
> @@ -1146,6 +1180,27 @@ static int convert_context(u32 key,
>  
>  	args = p;
>  
> +	if (c->str) {
> +		struct context ctx;
> +		rc = string_to_context_struct(args->newp, NULL, c->str,
> +					      c->len, &ctx, SECSID_NULL);
> +		if (!rc) {
> +			printk(KERN_INFO "SELinux:  Context %s became valid under new policy.\n", c->str);
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
> +			printk(KERN_ERR "SELinux:   Failed trying to map context %s (rc %d) under new policy, leaving unmapped.\n", c->str, -rc);
> +			goto out;
> +		}
> +	}
> +
>  	rc = context_cpy(&oldc, c);
>  	if (rc)
>  		goto out;
> @@ -1155,46 +1210,48 @@ static int convert_context(u32 key,
>  	/* Convert the user. */
>  	usrdatum = hashtab_search(args->newp->p_users.table,
>  	                          args->oldp->p_user_val_to_name[c->user - 1]);
> -	if (!usrdatum) {
> -		goto bad;
> -	}
> +	if (!usrdatum)
> +		goto map;
>  	c->user = usrdatum->value;
>  
>  	/* Convert the role. */
>  	role = hashtab_search(args->newp->p_roles.table,
>  	                      args->oldp->p_role_val_to_name[c->role - 1]);
> -	if (!role) {
> -		goto bad;
> -	}
> +	if (!role)
> +		goto map;
>  	c->role = role->value;
>  
>  	/* Convert the type. */
>  	typdatum = hashtab_search(args->newp->p_types.table,
>  	                          args->oldp->p_type_val_to_name[c->type - 1]);
> -	if (!typdatum) {
> -		goto bad;
> -	}
> +	if (!typdatum)
> +		goto map;
>  	c->type = typdatum->value;
>  
>  	rc = mls_convert_context(args->oldp, args->newp, c);
>  	if (rc)
> -		goto bad;
> +		goto map;
>  
>  	/* Check the validity of the new context. */
>  	if (!policydb_context_isvalid(args->newp, c)) {
>  		rc = convert_context_handle_invalid_context(&oldc);
>  		if (rc)
> -			goto bad;
> +			goto map;
>  	}
>  
>  	context_destroy(&oldc);
>  out:
>  	return rc;
> -bad:
> -	context_struct_to_string(&oldc, &s, &len);
> +map:
> +	/* Map old representation to string and save it. */
> +	if (context_struct_to_string(&oldc, &s, &len))
> +		return -ENOMEM;
>  	context_destroy(&oldc);
> -	printk(KERN_ERR "security:  invalidating context %s\n", s);
> -	kfree(s);
> +	context_destroy(c);
> +	c->str = s;
> +	c->len = len;
> +	printk(KERN_INFO "SELinux:  Context %s became invalid under new policy.\n", c->str);
> +	rc = 0;
>  	goto out;
>  }
>  
> @@ -1253,7 +1310,11 @@ int security_load_policy(void *data, siz
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
>  	/* Verify that the existing classes did not change. */
>  	if (hashtab_map(policydb.p_classes.table, validate_class, &newpolicydb)) {
> @@ -1271,10 +1332,12 @@ int security_load_policy(void *data, siz
>  	}
>  
>  	/* Convert the internal representations of contexts
> -	   in the new SID table and remove invalid SIDs. */
> +	   in the new SID table. */
>  	args.oldp = &policydb;
>  	args.newp = &newpolicydb;
> -	sidtab_map_remove_on_error(&newsidtab, convert_context, &args);
> +	rc = sidtab_map(&newsidtab, convert_context, &args);
> +	if (rc)
> +		goto err;
>  
>  	/* Save the old policydb and SID table to free later. */
>  	memcpy(&oldpolicydb, &policydb, sizeof policydb);
> @@ -1524,6 +1587,8 @@ int security_get_user_sids(u32 fromsid,
>  
>  	POLICY_RDLOCK;
>  
> +	context_init(&usercon);
> +
>  	fromcon = sidtab_search(&sidtab, fromsid);
>  	if (!fromcon) {
>  		rc = -EINVAL;
> diff -X /home/sds/dontdiff -rup linux-2.6.17-rc4-mm3/security/selinux/ss/sidtab.c linux-2.6.17-rc4-mm3-x/security/selinux/ss/sidtab.c
> --- linux-2.6.17-rc4-mm3/security/selinux/ss/sidtab.c	2006-03-20 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-mm3-x/security/selinux/ss/sidtab.c	2006-05-23 08:57:55.000000000 -0400
> @@ -100,7 +100,7 @@ struct context *sidtab_search(struct sid
>  	while (cur != NULL && sid > cur->sid)
>  		cur = cur->next;
>  
> -	if (cur == NULL || sid != cur->sid) {
> +	if (cur == NULL || sid != cur->sid || cur->context.len) {
>  		/* Remap invalid SIDs to the unlabeled SID. */
>  		sid = SECINITSID_UNLABELED;
>  		hvalue = SIDTAB_HASH(sid);
> @@ -218,6 +218,8 @@ int sidtab_context_to_sid(struct sidtab 
>  			goto unlock_out;
>  		}
>  		sid = s->next_sid++;
> +		if (context->len)
> +			printk(KERN_INFO "SELinux:  Context %s is not valid under current policy, adding as unmapped value.\n", context->str);
>  		ret = sidtab_insert(s, sid, context);
>  		if (ret)
>  			s->next_sid--;
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
