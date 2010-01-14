Subject: Re: [RFC][PATCH v2] selinux: change the handling of unknown classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1262972586.13162.47.camel@moss-pluto.epoch.ncsc.mil>
References: <20091218183016.9365.621.stgit@flek.lan>
	 <1262901683.2821.141.camel@moss-pluto.epoch.ncsc.mil>
	 <201001080942.33039.paul.moore@hp.com>
	 <1262972586.13162.47.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 14 Jan 2010 13:48:52 -0500
Message-Id: <1263494932.8548.40.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-08 at 12:43 -0500, Stephen Smalley wrote:
> If allow_unknown==deny, SELinux treats an undefined kernel security
> class as an error condition rather than as a typical permission denial
> and thus does not allow permissions on undefined classes even when in
> permissive mode.  Change the SELinux logic so that this case is handled
> as a typical permission denial, subject to the usual permissive mode
> and permissive domain handling.
> 
> Also drop the 'requested' argument from security_compute_av() and
> helpers as it is a legacy of the original security server interface and
> is unused.
> 
> Changes:
> - Handle permissive domains consistently by moving up the test for a
> permissive domain.
> - Make security_compute_av_user() consistent with security_compute_av();
> the only difference now is that security_compute_av() performs mapping
> between the kernel-private class and permission indices and the policy
> values.  In the userspace case, this mapping is handled by libselinux.
> 
> Based in part on a patch by Paul Moore <paul.moore@hp.com>.

Ping?

> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> 
> ---
> 
>  security/selinux/avc.c              |    5 
>  security/selinux/include/security.h |   10 -
>  security/selinux/selinuxfs.c        |    7 -
>  security/selinux/ss/services.c      |  186 +++++++++++++++---------------------
>  4 files changed, 89 insertions(+), 119 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index f2dde26..3ee9b6a 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -746,9 +746,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  		else
>  			avd = &avd_entry;
>  
> -		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
> -		if (rc)
> -			goto out;
> +		security_compute_av(ssid, tsid, tclass, avd);
>  		rcu_read_lock();
>  		node = avc_insert(ssid, tsid, tclass, avd);
>  	} else {
> @@ -770,7 +768,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	}
>  
>  	rcu_read_unlock();
> -out:
>  	return rc;
>  }
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 2553266..022cf06 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -96,13 +96,11 @@ struct av_decision {
>  /* definitions of av_decision.flags */
>  #define AVD_FLAGS_PERMISSIVE	0x0001
>  
> -int security_compute_av(u32 ssid, u32 tsid,
> -			u16 tclass, u32 requested,
> -			struct av_decision *avd);
> +void security_compute_av(u32 ssid, u32 tsid,
> +			 u16 tclass, struct av_decision *avd);
>  
> -int security_compute_av_user(u32 ssid, u32 tsid,
> -			     u16 tclass, u32 requested,
> -			     struct av_decision *avd);
> +void security_compute_av_user(u32 ssid, u32 tsid,
> +			     u16 tclass, struct av_decision *avd);
>  
>  int security_transition_sid(u32 ssid, u32 tsid,
>  			    u16 tclass, u32 *out_sid);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index fab36fd..b7bb0f5 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -494,7 +494,6 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  	char *scon, *tcon;
>  	u32 ssid, tsid;
>  	u16 tclass;
> -	u32 req;
>  	struct av_decision avd;
>  	ssize_t length;
>  
> @@ -512,7 +511,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  		goto out;
>  
>  	length = -EINVAL;
> -	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
> +	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
>  	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> @@ -522,9 +521,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_compute_av_user(ssid, tsid, tclass, req, &avd);
> -	if (length < 0)
> -		goto out2;
> +	security_compute_av_user(ssid, tsid, tclass, &avd);
>  
>  	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
>  			  "%x %x %x %x %u %x",
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 07ddc81..6b90ed3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -87,11 +87,10 @@ static u32 latest_granting;
>  static int context_struct_to_string(struct context *context, char **scontext,
>  				    u32 *scontext_len);
>  
> -static int context_struct_compute_av(struct context *scontext,
> -				     struct context *tcontext,
> -				     u16 tclass,
> -				     u32 requested,
> -				     struct av_decision *avd);
> +static void context_struct_compute_av(struct context *scontext,
> +				      struct context *tcontext,
> +				      u16 tclass,
> +				      struct av_decision *avd);
>  
>  struct selinux_mapping {
>  	u16 value; /* policy value */
> @@ -196,23 +195,6 @@ static u16 unmap_class(u16 tclass)
>  	return tclass;
>  }
>  
> -static u32 unmap_perm(u16 tclass, u32 tperm)
> -{
> -	if (tclass < current_mapping_size) {
> -		unsigned i;
> -		u32 kperm = 0;
> -
> -		for (i = 0; i < current_mapping[tclass].num_perms; i++)
> -			if (tperm & (1<<i)) {
> -				kperm |= current_mapping[tclass].perms[i];
> -				tperm &= ~(1<<i);
> -			}
> -		return kperm;
> -	}
> -
> -	return tperm;
> -}
> -
>  static void map_decision(u16 tclass, struct av_decision *avd,
>  			 int allow_unknown)
>  {
> @@ -532,7 +514,6 @@ out:
>  static void type_attribute_bounds_av(struct context *scontext,
>  				     struct context *tcontext,
>  				     u16 tclass,
> -				     u32 requested,
>  				     struct av_decision *avd)
>  {
>  	struct context lo_scontext;
> @@ -553,7 +534,6 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		context_struct_compute_av(&lo_scontext,
>  					  tcontext,
>  					  tclass,
> -					  requested,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> @@ -569,7 +549,6 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		context_struct_compute_av(scontext,
>  					  &lo_tcontext,
>  					  tclass,
> -					  requested,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> @@ -586,7 +565,6 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		context_struct_compute_av(&lo_scontext,
>  					  &lo_tcontext,
>  					  tclass,
> -					  requested,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> @@ -607,11 +585,10 @@ static void type_attribute_bounds_av(struct context *scontext,
>   * Compute access vectors based on a context structure pair for
>   * the permissions in a particular class.
>   */
> -static int context_struct_compute_av(struct context *scontext,
> -				     struct context *tcontext,
> -				     u16 tclass,
> -				     u32 requested,
> -				     struct av_decision *avd)
> +static void context_struct_compute_av(struct context *scontext,
> +				      struct context *tcontext,
> +				      u16 tclass,
> +				      struct av_decision *avd)
>  {
>  	struct constraint_node *constraint;
>  	struct role_allow *ra;
> @@ -622,19 +599,14 @@ static int context_struct_compute_av(struct context *scontext,
>  	struct ebitmap_node *snode, *tnode;
>  	unsigned int i, j;
>  
> -	/*
> -	 * Initialize the access vectors to the default values.
> -	 */
>  	avd->allowed = 0;
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
> -	avd->seqno = latest_granting;
> -	avd->flags = 0;
>  
>  	if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
>  		if (printk_ratelimit())
>  			printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> @@ -705,9 +677,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	 * permission and notice it to userspace via audit.
>  	 */
>  	type_attribute_bounds_av(scontext, tcontext,
> -				 tclass, requested, avd);
> -
> -	return 0;
> +				 tclass, avd);
>  }
>  
>  static int security_validtrans_handle_fail(struct context *ocontext,
> @@ -886,110 +856,118 @@ out:
>  	return rc;
>  }
>  
> -
> -static int security_compute_av_core(u32 ssid,
> -				    u32 tsid,
> -				    u16 tclass,
> -				    u32 requested,
> -				    struct av_decision *avd)
> +static void avd_init(struct av_decision *avd)
>  {
> -	struct context *scontext = NULL, *tcontext = NULL;
> -	int rc = 0;
> -
> -	scontext = sidtab_search(&sidtab, ssid);
> -	if (!scontext) {
> -		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> -		       __func__, ssid);
> -		return -EINVAL;
> -	}
> -	tcontext = sidtab_search(&sidtab, tsid);
> -	if (!tcontext) {
> -		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> -		       __func__, tsid);
> -		return -EINVAL;
> -	}
> -
> -	rc = context_struct_compute_av(scontext, tcontext, tclass,
> -				       requested, avd);
> -
> -	/* permissive domain? */
> -	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> -		avd->flags |= AVD_FLAGS_PERMISSIVE;
> -
> -	return rc;
> +	avd->allowed = 0;
> +	avd->auditallow = 0;
> +	avd->auditdeny = 0xffffffff;
> +	avd->seqno = latest_granting;
> +	avd->flags = 0;
>  }
>  
> +
>  /**
>   * security_compute_av - Compute access vector decisions.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> - * @requested: requested permissions
>   * @avd: access vector decisions
>   *
>   * Compute a set of access vector decisions based on the
>   * SID pair (@ssid, @tsid) for the permissions in @tclass.
> - * Return -%EINVAL if any of the parameters are invalid or %0
> - * if the access vector decisions were computed successfully.
>   */
> -int security_compute_av(u32 ssid,
> -			u32 tsid,
> -			u16 orig_tclass,
> -			u32 orig_requested,
> -			struct av_decision *avd)
> +void security_compute_av(u32 ssid,
> +			 u32 tsid,
> +			 u16 orig_tclass,
> +			 struct av_decision *avd)
>  {
>  	u16 tclass;
> -	u32 requested;
> -	int rc;
> +	struct context *scontext = NULL, *tcontext = NULL;
>  
> +	avd_init(avd);
>  	read_lock(&policy_rwlock);
>  
>  	if (!ss_initialized)
>  		goto allow;
>  
> -	requested = unmap_perm(orig_tclass, orig_requested);
> +	scontext = sidtab_search(&sidtab, ssid);
> +	if (!scontext) {
> +		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +		       __func__, ssid);
> +		goto out;
> +	}
> +
> +	/* permissive domain? */
> +	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +		avd->flags |= AVD_FLAGS_PERMISSIVE;
> +
> +	tcontext = sidtab_search(&sidtab, tsid);
> +	if (!tcontext) {
> +		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +		       __func__, tsid);
> +		goto out;
> +	}
> +
>  	tclass = unmap_class(orig_tclass);
>  	if (unlikely(orig_tclass && !tclass)) {
>  		if (policydb.allow_unknown)
>  			goto allow;
> -		rc = -EINVAL;
>  		goto out;
>  	}
> -	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
> +	context_struct_compute_av(scontext, tcontext, tclass, avd);
>  	map_decision(orig_tclass, avd, policydb.allow_unknown);
>  out:
>  	read_unlock(&policy_rwlock);
> -	return rc;
> +	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> -	avd->auditallow = 0;
> -	avd->auditdeny = 0xffffffff;
> -	avd->seqno = latest_granting;
> -	avd->flags = 0;
> -	rc = 0;
>  	goto out;
>  }
>  
> -int security_compute_av_user(u32 ssid,
> -			     u32 tsid,
> -			     u16 tclass,
> -			     u32 requested,
> -			     struct av_decision *avd)
> +void security_compute_av_user(u32 ssid,
> +			      u32 tsid,
> +			      u16 tclass,
> +			      struct av_decision *avd)
>  {
> -	int rc;
> +	struct context *scontext = NULL, *tcontext = NULL;
>  
> -	if (!ss_initialized) {
> -		avd->allowed = 0xffffffff;
> -		avd->auditallow = 0;
> -		avd->auditdeny = 0xffffffff;
> -		avd->seqno = latest_granting;
> -		return 0;
> +	avd_init(avd);
> +	read_lock(&policy_rwlock);
> +
> +	if (!ss_initialized)
> +		goto allow;
> +
> +	scontext = sidtab_search(&sidtab, ssid);
> +	if (!scontext) {
> +		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +		       __func__, ssid);
> +		goto out;
>  	}
>  
> -	read_lock(&policy_rwlock);
> -	rc = security_compute_av_core(ssid, tsid, tclass, requested, avd);
> +	/* permissive domain? */
> +	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +		avd->flags |= AVD_FLAGS_PERMISSIVE;
> +
> +	tcontext = sidtab_search(&sidtab, tsid);
> +	if (!tcontext) {
> +		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +		       __func__, tsid);
> +		goto out;
> +	}
> +
> +	if (unlikely(!tclass)) {
> +		if (policydb.allow_unknown)
> +			goto allow;
> +		goto out;
> +	}
> +
> +	context_struct_compute_av(scontext, tcontext, tclass, avd);
> + out:
>  	read_unlock(&policy_rwlock);
> -	return rc;
> +	return;
> +allow:
> +	avd->allowed = 0xffffffff;
> +	goto out;
>  }
>  
>  /*
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
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
