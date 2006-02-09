Date: Thu, 9 Feb 2006 09:58:48 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
cc: selinux@tycho.nsa.gov, Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating
 audit messages
In-Reply-To: <1139448731.12941.30.camel@localhost>
Message-ID: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Feb 2006, Timothy R. Chavez wrote:

> 1) A new SELinux interface was introduced to give other parts of the
> kernel the ability to resolve 'sids' into security labels.  

Please look at the way I intend to export SELinux APIs in:
http://people.redhat.com/jmorris/selinux/skfilter/kernel/12-skfilter-selinux-exports.patch

> +++ b/include/linux/netlink.h
> @@ -143,6 +143,7 @@ struct netlink_skb_parms
>  	__u32			dst_group;
>  	kernel_cap_t		eff_cap;
>  	__u32			loginuid;	/* Login (audit) uid */
> +	__u32			secid;		/* SELinux security id */
>  };

You also need to verify the policy serial number.

I wonder if it might be better to use the security context directly.


> @@ -460,11 +464,26 @@ static int audit_receive_msg(struct sk_b
>  			err = 0;
>  			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
>  			if (ab) {
> +				len = selinux_sid_to_context(sid, NULL, 0);

This is embedding SELinux specific code into the audit code.  I think you 
need to add some audit/SELinux glue code which disappears if SELinux is 
not enabled.

> +	NETLINK_CB(skb).secid = security_task_getsid(current);

security_task_getsid() doesn't exist.

You created security_task_getsecurity(), which retrieves the security
context.



- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
