Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
From: Eric Paris <eparis@redhat.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
In-Reply-To: <20061220222443.14268.qmail@web51513.mail.yahoo.com>
References: <20061220222443.14268.qmail@web51513.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:07:29 -0500
Message-Id: <1166670449.23016.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-20 at 14:24 -0800, Steve G wrote:
> >> > ss/services.c: printk(KERN_INFO <- missing class definitions in policy
> >> > ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
> >> > ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy
> >> 
> >> Possibly an audit message?
> >
> >Maybe it should be an audit as well.  Any opinions?
> 
> Not sure this should be audited. Does this mean that policy will malfunction? Or
> that labels will not be properly attributed to subj/obj? What is the effect?
> 
> -Steve

Currently it means that access decisions which would rely on that
class/perm will be denied.  They will still be logged based on the
kernel's view.  So actually the logging is still correct and complete.
If I ever get back to my other patch set it would be possible that such
access decisions would be allowed rather than denied.

These messages are merely an indicator that your policy does not define
operations which the kernel may be mediating and the user might have a
need to look at finding a newer policy.  Except maybe in the (future)
'allow unknown' case, they have little bearing on the actual security or
proper auditing of the system.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
