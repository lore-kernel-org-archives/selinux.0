Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 10:13:56 -0600
Message-Id: <1139501636.10222.11.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi James,

Thank you for the response (and putting Stephen on the CC list,
evolution flubbered my original CC list, hrm).  My response below.

On Thu, 2006-02-09 at 09:58 -0500, James Morris wrote:
> On Wed, 8 Feb 2006, Timothy R. Chavez wrote:
> 
> > 1) A new SELinux interface was introduced to give other parts of the
> > kernel the ability to resolve 'sids' into security labels.  
> 
> Please look at the way I intend to export SELinux APIs in:
> http://people.redhat.com/jmorris/selinux/skfilter/kernel/12-skfilter-selinux-exports.patch

This looks good.  Do you have a schedule for releasing this?  I could
probably wait until it becomes available in -mm before changing out the
API plumbing.

> 
> > +++ b/include/linux/netlink.h
> > @@ -143,6 +143,7 @@ struct netlink_skb_parms
> >  	__u32			dst_group;
> >  	kernel_cap_t		eff_cap;
> >  	__u32			loginuid;	/* Login (audit) uid */
> > +	__u32			secid;		/* SELinux security id */
> >  };
> 
> You also need to verify the policy serial number.

Ah, thanks.

> 
> I wonder if it might be better to use the security context directly.
>

I think it'd be the simplest solution, but I was a bit weary about
adding a string param... I thought using an integer might be the path of
least resistance :)

> 
> > @@ -460,11 +464,26 @@ static int audit_receive_msg(struct sk_b
> >  			err = 0;
> >  			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> >  			if (ab) {
> > +				len = selinux_sid_to_context(sid, NULL, 0);
> 
> This is embedding SELinux specific code into the audit code.  I think you 
> need to add some audit/SELinux glue code which disappears if SELinux is 
> not enabled.
> 
> > +	NETLINK_CB(skb).secid = security_task_getsid(current);
> 
> security_task_getsid() doesn't exist.
> 
> You created security_task_getsecurity(), which retrieves the security
> context.
> 
> 
> 
> - James

Actually, security_task_getsid() does exist (or did exist last time I
updated the viro/audit-2.6 git tree).

http://www.promethos.org/lxr/http/ident?i=security_task_getsid


Thanks again for the feedback James.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
