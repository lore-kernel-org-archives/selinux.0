Subject: Re: [PATCH] Permissive domain in userspace object manager
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: jmorris@namei.org, Eric Paris <eparis@parisplace.org>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, method@manicmethod.com,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <49D2BE6D.4030708@ak.jp.nec.com>
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>
	 <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
	 <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov>
	 <49D034B9.9080406@ak.jp.nec.com>  <49D175C6.2050001@ak.jp.nec.com>
	 <1238517993.2484.123.camel@localhost.localdomain>
	 <49D2BE6D.4030708@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 08:34:47 -0400
Message-Id: <1238589287.24074.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-01 at 10:07 +0900, KaiGai Kohei wrote:
> This patch enables applications to handle permissive domain correctly.
> 
> Since the v2.6.26 kernel, SELinux has supported an idea of permissive
> domain which allows certain processes to work as if permissive mode,
> even if the global setting is enforcing mode.
> However, we don't have an application program interface to inform
> what domains are permissive one, and what domains are not.
> It means applications focuses on SELinux (XACE/SELinux, SE-PostgreSQL
> and so on) cannot handle permissive domain correctly.
> 
> This patch add the sixth field (flags) on the reply of the /selinux/access
> interface which is used to make an access control decision from userspace.
> If the first bit of the flags field is positive, it means the required
> access control decision is on permissive domain, so application should
> allow any required actions, as the kernel doing.
> 
> This patch also has a side benefit. The av_decision.flags is set at
> context_struct_compute_av(). It enables to check required permissions
> without read_lock(&policy_rwlock).
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> --
>  security/selinux/avc.c              |    2 +-
>  security/selinux/include/security.h |    4 +++-
>  security/selinux/selinuxfs.c        |    4 ++--
>  security/selinux/ss/services.c      |   30 +++++-------------------------
>  4 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7f9b5fa..b2ab608 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -927,7 +927,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	if (denied) {
>  		if (flags & AVC_STRICT)
>  			rc = -EACCES;
> -		else if (!selinux_enforcing || security_permissive_sid(ssid))
> +		else if (!selinux_enforcing || (avd->flags & AVD_FLAGS_PERMISSIVE))
>  			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
>  					tsid, tclass, avd->seqno);
>  		else
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 5c3434f..a7be3f0 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -91,9 +91,11 @@ struct av_decision {
>  	u32 auditallow;
>  	u32 auditdeny;
>  	u32 seqno;
> +	u32 flags;
>  };
> 
> -int security_permissive_sid(u32 sid);
> +/* definitions of av_decision.flags */
> +#define AVD_FLAGS_PERMISSIVE	0x0001
> 
>  int security_compute_av(u32 ssid, u32 tsid,
>  	u16 tclass, u32 requested,
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index d3c8b98..4d56ab1 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -594,10 +594,10 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  		goto out2;
> 
>  	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
> -			  "%x %x %x %x %u",
> +			  "%x %x %x %x %u %x",
>  			  avd.allowed, 0xffffffff,
>  			  avd.auditallow, avd.auditdeny,
> -			  avd.seqno);
> +			  avd.seqno, avd.flags);
>  out2:
>  	kfree(tcon);
>  out:
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index deeec6c..500e6f7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -410,6 +410,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
>  	avd->seqno = latest_granting;
> +	avd->flags = 0;
> 
>  	/*
>  	 * Check for all the invalid cases.
> @@ -528,31 +529,6 @@ inval_class:
>  	return 0;
>  }
> 
> -/*
> - * Given a sid find if the type has the permissive flag set
> - */
> -int security_permissive_sid(u32 sid)
> -{
> -	struct context *context;
> -	u32 type;
> -	int rc;
> -
> -	read_lock(&policy_rwlock);
> -
> -	context = sidtab_search(&sidtab, sid);
> -	BUG_ON(!context);
> -
> -	type = context->type;
> -	/*
> -	 * we are intentionally using type here, not type-1, the 0th bit may
> -	 * someday indicate that we are globally setting permissive in policy.
> -	 */
> -	rc = ebitmap_get_bit(&policydb.permissive_map, type);
> -
> -	read_unlock(&policy_rwlock);
> -	return rc;
> -}
> -
>  static int security_validtrans_handle_fail(struct context *ocontext,
>  					   struct context *ncontext,
>  					   struct context *tcontext,
> @@ -767,6 +743,10 @@ int security_compute_av(u32 ssid,
> 
>  	rc = context_struct_compute_av(scontext, tcontext, tclass,
>  				       requested, avd);
> +
> +	/* permissive domain? */
> +	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +	    avd->flags |= AVD_FLAGS_PERMISSIVE;
>  out:
>  	read_unlock(&policy_rwlock);
>  	return rc;
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
