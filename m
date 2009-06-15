Subject: Re: type bounds audit messages
From: Eric Paris <eparis@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        sgrubb@redhat.com
In-Reply-To: <4A35F091.6000202@ak.jp.nec.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <4A31A33F.2040504@ak.jp.nec.com>
	 <1244807594.18947.62.camel@localhost.localdomain>
	 <4A35F091.6000202@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 09:17:15 -0400
Message-Id: <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-06-15 at 15:56 +0900, KaiGai Kohei wrote:
> The attached patch allows to generate audit messages on access violations
> related to bounds types.
> 
> 1. When a multithread process gives an unbounded domain to setcon(3)
>    to change its domain dynamically, the current kernel denies it
>    without any notification or audit messages.
>    This patch adds an audit_log() in the security_bounded_transition()
>    to generate an audit message, when the dynamic type transition is
>    failed due to the bounds violation.
> 
>    Example:
>    type=SELINUX_ERR msg=audit(1245046106.725:65): SELinux: bounds violation: \
>        domain transition from httpd_t to guest_webapp_t

No, no 1000 times no.  We've finally got a new SELinux audit message
that tools don't understand.  I'm not about to suggest we continue to
print them in some new non-standard arbitrary format.  Everything that
includes audit_log_* from now on better be of the type key=value.

How would people on list feel about?

type=SELINUX_ERR msg=audit(1245046106.725:65): lsm="SELinux" \
    op="bounds violation on domain transition" type1="httpd_t" \
    type2="guest_webapp_t"

This would be the only place I can remember that we only output the type
instead of the complete context.  Why not ocontext= and ncontext=?  I
don't care what we call it, but I want it all to be key=value pairs and
I prefer that we (the audit system) starts making much heavier use of
audit_log_string() which includes the ""

> 2. When a set of permissions are masked due to the bounds violations,
>    it shall be reported on the type_attribute_bounds_av() invoked from
>    context_struct_context_av(), but it keeps silent on any AVC denials.
>    It may make unclear what permissions were in violation of the boundary.
>    This patch adds the "masked" field on av_decision, and it reports
>    violated permissions on AVC denials.
> 
>    Example:
>    type=AVC msg=audit(1245046439.315:72): avc:  denied  { create }     \
>      for pid=3080 comm="httpd" name="hoge"                             \
>      scontext=unconfined_u:system_r:user_webapp_t:s0                   \
>      tcontext=unconfined_u:object_r:httpd_sys_content_t:s0 tclass=file \
>      bounds: { create }
>      ^^^^^^^^^^^^^^^^^^

This one I'm still unhappy about but since it is continuing the
tradition of hard to parse audit rules I'm ok if it stays (assuming
tools like audit2allow don't get confused)

Now might be a perfect time to start emitting permissions in a better
format though, maybe someday the rest of selinux could convert to an
easier to parse format (ha ha, ok, I know it's funny)

bounds="create"

someday we might have perms="read write create open ioctl" instead of
{ ... } ???

???

Feedback strongly encouraged...

> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/avc.c              |    7 ++++-
>  security/selinux/include/security.h |    1 +
>  security/selinux/ss/services.c      |   47 ++++++++++++++--------------------
>  3 files changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7f9b5fa..c385e3b 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -536,7 +536,7 @@ void avc_audit(u32 ssid, u32 tsid,
>  {
>  	struct task_struct *tsk = current;
>  	struct inode *inode = NULL;
> -	u32 denied, audited;
> +	u32 denied, audited, masked = 0;
>  	struct audit_buffer *ab;
> 
>  	denied = requested & ~avd->allowed;
> @@ -544,6 +544,7 @@ void avc_audit(u32 ssid, u32 tsid,
>  		audited = denied;
>  		if (!(audited & avd->auditdeny))
>  			return;
> +		masked = audited & avd->masked;
>  	} else if (result) {
>  		audited = denied = requested;
>  	} else {
> @@ -688,6 +689,10 @@ void avc_audit(u32 ssid, u32 tsid,
>  	}
>  	audit_log_format(ab, " ");
>  	avc_dump_query(ab, ssid, tsid, tclass);
> +	if (masked) {
> +		audit_log_format(ab, " bounds:");
> +		avc_dump_av(ab, tclass, masked);
> +	}
>  	audit_log_end(ab);
>  }
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 5c3434f..07e7a01 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -91,6 +91,7 @@ struct av_decision {
>  	u32 auditallow;
>  	u32 auditdeny;
>  	u32 seqno;
> +	u32 masked;	/* masked by bounds types */
>  };
> 
>  int security_permissive_sid(u32 sid);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index deeec6c..349bfb2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -295,7 +295,6 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		= policydb.type_val_to_struct[scontext->type - 1];
>  	struct type_datum *target
>  		= policydb.type_val_to_struct[tcontext->type - 1];
> -	u32 masked = 0;
> 
>  	if (source->bounds) {
>  		memset(&lo_avd, 0, sizeof(lo_avd));
> @@ -310,7 +309,7 @@ static void type_attribute_bounds_av(struct context *scontext,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> +		avd->masked = ~lo_avd.allowed & avd->allowed;
>  	}
> 
>  	if (target->bounds) {
> @@ -326,7 +325,7 @@ static void type_attribute_bounds_av(struct context *scontext,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> +		avd->masked = ~lo_avd.allowed & avd->allowed;
>  	}
> 
>  	if (source->bounds && target->bounds) {
> @@ -343,33 +342,12 @@ static void type_attribute_bounds_av(struct context *scontext,
>  					  &lo_avd);
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> +		avd->masked = ~lo_avd.allowed & avd->allowed;
>  	}
> 
> -	if (masked) {
> -		struct audit_buffer *ab;
> -		char *stype_name
> -			= policydb.p_type_val_to_name[source->value - 1];
> -		char *ttype_name
> -			= policydb.p_type_val_to_name[target->value - 1];
> -		char *tclass_name
> -			= policydb.p_class_val_to_name[tclass - 1];
> -
> -		/* mask violated permissions */
> -		avd->allowed &= ~masked;
> -
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
> -	}
> +	/* mask violated permissions */
> +	if (avd->masked)
> +		avd->allowed &= ~avd->masked;
>  }
> 
>  /*
> @@ -410,6 +388,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
>  	avd->seqno = latest_granting;
> +	avd->masked = 0;
> 
>  	/*
>  	 * Check for all the invalid cases.
> @@ -711,6 +690,18 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>  		}
>  		index = type->bounds;
>  	}
> +
> +	if (rc) {
> +		char *old_name
> +			= policydb.p_type_val_to_name[old_context->type - 1];
> +		char *new_name
> +			= policydb.p_type_val_to_name[new_context->type - 1];
> +
> +		audit_log(current->audit_context,
> +			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> +			  "SELinux: bounds violation: domain transition "
> +			  "from %s to %s", old_name, new_name);
> +	}
>  out:
>  	read_unlock(&policy_rwlock);
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
