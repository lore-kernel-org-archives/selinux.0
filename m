Subject: Re: type bounds audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com
In-Reply-To: <4A39FA25.8050400@ak.jp.nec.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <200906161040.52279.sgrubb@redhat.com>
	 <1245164133.2848.12.camel@localhost.localdomain>
	 <200906161123.52932.sgrubb@redhat.com>
	 <1245166869.2848.21.camel@localhost.localdomain>
	 <4A38727F.7090705@ak.jp.nec.com>
	 <1245243187.29288.19.camel@localhost.localdomain>
	 <4A39FA25.8050400@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 08:50:37 -0400
Message-Id: <1245329437.3033.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-06-18 at 17:26 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> >> Some of permissions are masked at runtime during security_compute_av()
> >> due to RBAC, Constraint, MLS and Type bounds, although TE allows them.
> >> It's not clear for me whether it should be considered as an error
> >> (SELINUX_ERR) because of an internal inconsistency within the policy,
> >> or should be considered as just an information (SELINUX_INFO) from
> >> the kernel.
> > 
> > I assume the desire for a new message type is to make it clear that it
> > can be parsed using the new format.  But conceptually it is no different
> > than the SELINUX_ERR messages emitted by security_compute_sid or
> > security_validate_transition.
> 
> OK, I reverted the new SELINUX_INFO and used SELINUX_ERR instead.
> 
> >> --------
> >> [PATCH] Add audit messages for masked SELinux permissions
> >>
> >> The following patch adds a few audit messages,
> >>  1. when a multithread process switch its performing domain to unbounded
> >>     one, and the hardwired rule prevent it.
> >>
> >>   type=SELINUX_ERR msg=audit(1245207506.618:62):        \
> >>       security_bounded_transition: denied for           \
> >>       oldcontext=system_u:system_r:httpd_t:s0           \
> >>       newcontext=system_u:system_r:guest_webapp_t:s0
> > 
> > Might as well use the op=security_bounded_transition result=denied style
> > of syntax here as well for ease of parsing.
> 
> Fixed, as follows:
> 
>   type=SELINUX_ERR msg=audit(1245311998.599:17):        \
>       op=security_bounded_transition result=denied      \
>       oldcontext=system_u:system_r:httpd_t:s0           \
>       newcontext=system_u:system_r:guest_webapp_t:s0
> 
> >>  2. when RBAC, MLS/Constraints and Type bounds masks permissions allowed
> >>     with TE rules on security_compute_av().
> >>
> >>   * BRAC prevent domain transition
> >>   type=UNKNOWN[1418] msg=audit(1245207539.227:67):      \
> >>       op=security_compute_av masked=rbac                \
> >>       scontext=unconfined_u:unconfined_r:unconfined_t:s0    \
> >>       tcontext=staff_u:staff_r:staff_t:s0               \
> >>       tclass=process perms=transition
> >>
> >>   * MCS prevent accesses to *:s0:c0 by *:s0
> >>   type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
> >>       op=security_compute_av masked=constraint          \
> >>       scontext=system_u:system_r:user_webapp_t:s0       \
> >>       tcontext=system_u:object_r:shadow_t:s0:c0         \
> >>       tclass=file perms=ioctl,read,write,create,setattr,lock,append,unlink,link,rename
> > 
> > I'm not sure about adding such messages for RBAC or constraints - this
> > will potentially generate a fair number of messages for permissions that
> > will never be checked by the AVC, and they don't represent any
> > inconsistency within the policy, unlike the boundary violations.  Users
> > could potentially see many of these messages and be concerned that they
> > represent actual access attempts vs. just av computation.  If we were to
> > add such messages, I think we'd want to be able to easily disable them
> > (and do so by default), and then only enable them when doing policy
> > debugging.
> 
> I agree to drop these messages for RBAC and constraints.
> It is not too late to add them with actual requirements.
> 
> >>   * Then, type bounds prevents accesses to shadow_t
> >>   type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
> >>       op=security_compute_av masked=bounds              \
> >>       scontext=system_u:system_r:user_webapp_t:s0       \
> >>       tcontext=system_u:object_r:shadow_t:s0:c0         \
> >>       tclass=file perms=getattr,open
> > 
> > This looks ok, although I'm not sure masked= is the best name (vs. e.g.
> > reason=).
> 
> OK, "masked=" was replaced by "reason=", as follows:
> 
>   type=SELINUX_ERR msg=audit(1245312836.035:32):	\
>       op=security_compute_av reason=bounds              \
>       scontext=system_u:object_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=getattr,open
> 
> > <snip>
> >> +static void security_dump_masked_av(struct context *scontext,
> >> +				    struct context *tcontext,
> >> +				    u16 tclass,
> >> +				    u32 permissions,
> >> +				    const char *reason)
> >> +{
> >> +	struct common_datum *common_dat;
> >> +	struct class_datum *tclass_dat;
> >> +	struct audit_buffer *ab;
> >> +	char *tclass_name;
> >> +	char *scontext_name;
> >> +	char *tcontext_name;
> > 
> > Initialize the *_name variables to NULL.
> > And then you don't need multiple out paths - you can just always kfree()
> > them on the way out.
> 
> Fixed, and cleaned up.
> 
> --------
> [PATCH] Add audit messages on type boundary violations
> 
> The attached patch adds support to generate audit messages on two cases.
> 
> The first one is a case when a multi-thread process tries to switch its
> performing security context using setcon(3), but new security context is
> not bounded by the old one.
> 
>   type=SELINUX_ERR msg=audit(1245311998.599:17):        \
>       op=security_bounded_transition result=denied      \
>       oldcontext=system_u:system_r:httpd_t:s0           \
>       newcontext=system_u:system_r:guest_webapp_t:s0
> 
> The other one is a case when security_compute_av() masked any permissions
> due to the type boundary violation.
> 
>   type=SELINUX_ERR msg=audit(1245312836.035:32):	\
>       op=security_compute_av reason=bounds              \
>       scontext=system_u:object_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=getattr,open
> 
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> --
>  security/selinux/avc.c         |    2 +-
>  security/selinux/include/avc.h |    3 -
>  security/selinux/ss/services.c |  136 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 118 insertions(+), 23 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7f9b5fa..4bf5d08 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -137,7 +137,7 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
>   * @tclass: target security class
>   * @av: access vector
>   */
> -void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> +static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>  {
>  	const char **common_pts = NULL;
>  	u32 common_base = 0;
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index d12ff1a..46a940d 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -127,9 +127,6 @@ int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
>  		     u32 events, u32 ssid, u32 tsid,
>  		     u16 tclass, u32 perms);
> 
> -/* Shows permission in human readable form */
> -void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
> -
>  /* Exported to selinuxfs */
>  int avc_get_hash_stats(char *page);
>  extern unsigned int avc_cache_threshold;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index deeec6c..1ad6e17 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -22,6 +22,11 @@
>   *
>   *  Added validation of kernel classes and permissions
>   *
> + * Updated: KaiGai Kohei <kaigai@ak.jp.nec.com>
> + *
> + *  Added support for bounds domain and audit messaged on masked permissions
> + *
> + * Copyright (C) 2008, 2009 NEC Corporation
>   * Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
>   * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
>   * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
> @@ -279,6 +284,95 @@ mls_ops:
>  }
> 
>  /*
> + * security_dump_masked_av - dumps masked permissions during
> + * security_compute_av due to RBAC, MLS/Constraint and Type bounds.
> + */
> +static int dump_masked_av_helper(void *k, void *d, void *args)
> +{
> +	struct perm_datum *pdatum = d;
> +	char **permission_names = args;
> +
> +	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
> +
> +	permission_names[pdatum->value - 1] = (char *)k;
> +
> +	return 0;
> +}
> +
> +static void security_dump_masked_av(struct context *scontext,
> +				    struct context *tcontext,
> +				    u16 tclass,
> +				    u32 permissions,
> +				    const char *reason)
> +{
> +	struct common_datum *common_dat;
> +	struct class_datum *tclass_dat;
> +	struct audit_buffer *ab;
> +	char *tclass_name;
> +	char *scontext_name = NULL;
> +	char *tcontext_name = NULL;
> +	char *permission_names[32];
> +	int index, length;
> +	bool need_comma = false;
> +
> +	if (!permissions)
> +		return;
> +
> +	tclass_name = policydb.p_class_val_to_name[tclass - 1];
> +	tclass_dat = policydb.class_val_to_struct[tclass - 1];
> +	common_dat = tclass_dat->comdatum;
> +
> +	/* init permission_names */
> +	if (common_dat &&
> +	    hashtab_map(common_dat->permissions.table,
> +			dump_masked_av_helper, permission_names) < 0)
> +		goto out;
> +
> +	if (hashtab_map(tclass_dat->permissions.table,
> +			dump_masked_av_helper, permission_names) < 0)
> +		goto out;
> +
> +	/* get scontext/tcontext in text form */
> +	if (context_struct_to_string(scontext,
> +				     &scontext_name, &length) < 0)
> +		goto out;
> +
> +	if (context_struct_to_string(tcontext,
> +				     &tcontext_name, &length) < 0)
> +		goto out;
> +
> +	/* audit a message */
> +	ab = audit_log_start(current->audit_context,
> +			     GFP_ATOMIC, AUDIT_SELINUX_ERR);
> +	if (!ab)
> +		goto out;
> +
> +	audit_log_format(ab, "op=security_compute_av reason=%s "
> +			 "scontext=%s tcontext=%s tclass=%s perms=",
> +			 reason, scontext_name, tcontext_name, tclass_name);
> +
> +	for (index = 0; index < 32; index++) {
> +		u32 mask = (1 << index);
> +
> +		if ((mask & permissions) == 0)
> +			continue;
> +
> +		audit_log_format(ab, "%s%s",
> +				 need_comma ? "," : "",
> +				 permission_names[index]
> +				 ? permission_names[index] : "????");
> +		need_comma = true;
> +	}
> +	audit_log_end(ab);
> +out:
> +	/* release scontext/tcontext */
> +	kfree(tcontext_name);
> +	kfree(scontext_name);
> +
> +	return;
> +}
> +
> +/*
>   * security_boundary_permission - drops violated permissions
>   * on boundary constraint.
>   */
> @@ -347,28 +441,12 @@ static void type_attribute_bounds_av(struct context *scontext,
>  	}
> 
>  	if (masked) {
> -		struct audit_buffer *ab;
> -		char *stype_name
> -			= policydb.p_type_val_to_name[source->value - 1];
> -		char *ttype_name
> -			= policydb.p_type_val_to_name[target->value - 1];
> -		char *tclass_name
> -			= policydb.p_class_val_to_name[tclass - 1];
> -
>  		/* mask violated permissions */
>  		avd->allowed &= ~masked;
> 
> -		/* notice to userspace via audit message */
> -		ab = audit_log_start(current->audit_context,
> -				     GFP_ATOMIC, AUDIT_SELINUX_ERR);
> -		if (!ab)
> -			return;
> -
> -		audit_log_format(ab, "av boundary violation: "
> -				 "source=%s target=%s tclass=%s",
> -				 stype_name, ttype_name, tclass_name);
> -		avc_dump_av(ab, tclass, masked);
> -		audit_log_end(ab);
> +		/* audit masked permissions */
> +		security_dump_masked_av(scontext, tcontext,
> +					tclass, masked, "bounds");
>  	}
>  }
> 
> @@ -711,6 +789,26 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>  		}
>  		index = type->bounds;
>  	}
> +
> +	if (rc) {
> +		char *old_name = NULL;
> +		char *new_name = NULL;
> +		int length;
> +
> +		if (!context_struct_to_string(old_context,
> +					      &old_name, &length) &&
> +		    !context_struct_to_string(new_context,
> +					      &new_name, &length)) {
> +			audit_log(current->audit_context,
> +				  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> +				  "op=security_bounded_transition "
> +				  "result=denied "
> +				  "oldcontext=%s newcontext=%s",
> +				  old_name, new_name);
> +		}
> +		kfree(new_name);
> +		kfree(old_name);
> +	}
>  out:
>  	read_unlock(&policy_rwlock);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
