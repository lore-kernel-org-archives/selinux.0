Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1139960902.326.5.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 08:47:31 -0500
Message-Id: <1140011251.14253.346.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 17:48 -0600, Timothy R. Chavez wrote:
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 6a2ccf7..ccd5905 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -143,6 +143,7 @@ struct netlink_skb_parms
>  	__u32			dst_group;
>  	kernel_cap_t		eff_cap;
>  	__u32			loginuid;	/* Login (audit) uid */
> +	__u32			secid;		/* SELinux security id */
>  };
>  
>  #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))

As a minor nit, does anyone know why '__u32' is used here vs. 'u32'?
The definition is already wrapped with an #ifdef __KERNEL__.  I see that
you are being consistent with the existing fields, but then we use just
'u32' in the audit code and in the SELinux interfaces and code.  Seems
like we should be consistent throughout, and I don't see a real reason
to use __u32 vs. just u32 if it is all kernel code and not included in
userland (or protected by #ifdef __KERNEL__).

> diff --git a/include/linux/security.h b/include/linux/security.h
> index b4fe8aa..c6fe5fe 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1169,6 +1174,7 @@ struct security_operations {
>  			   unsigned long arg5);
>  	void (*task_reparent_to_init) (struct task_struct * p);
>  	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
> +	void (*task_getsecid)(struct task_struct *tsk, __u32 *sid);

Same issue for the security hook interfaces.

> @@ -2457,6 +2468,9 @@ static inline void security_task_reparen
>  static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
>  { }
>  
> +static inline void security_task_getsecid(struct task_struct *tsk, __u32 *sid)
> +{ }
> +

Should we set *sid = 0 here as in the dummy function, just to make sure
it doesn't contain garbage?

> diff --git a/kernel/audit.c b/kernel/audit.c
> index d95efd6..4ca77dd 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -458,14 +462,20 @@ static int audit_receive_msg(struct sk_b
>  		err = audit_filter_user(&NETLINK_CB(skb), msg_type);
>  		if (err == 1) {
>  			err = 0;
> +			if (selinux_available()) {
> +				err = selinux_id_to_ctx(sid, &ctx, &len);
> +				if (err < 0)
> +					return err;
> +			}

It seems unfortunate to have to wrap each call to a public SELinux
interface with a selinux_available() check, and the !
defined(CONFIG_SECURITY_SELINUX) case would actually work without such a
check since it just sets (ctx, len) to (NULL, 0).  So the
selinux_available() check is only necessary for the case where SELinux
is disabled at runtime (selinux=0 or /selinux/disable).  Possibly it
should be moved within selinux_id_to_ctx() so that callers can just call
selinux_id_to_ctx() unconditionally?

>  			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
>  			if (ab) {
>  				audit_log_format(ab,
> -						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
> -						 pid, uid, loginuid, (char *)data);
> +						 "user pid=%d uid=%u auid=%u subj=%s msg='%.1024s'",
> +						 pid, uid, loginuid, ctx ? ctx : "null", (char *)data);

Do you want those "subj=null" items in the output when SELinux is
disabled, or should there be a different audit_log_format call in the !
ctx case that completely omits "subj="? 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
