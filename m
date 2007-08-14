Subject: Re: Illegal errno from kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <126339.54611.qm@web51508.mail.re2.yahoo.com>
References: <126339.54611.qm@web51508.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Tue, 14 Aug 2007 13:55:54 -0400
Message-Id: <1187114154.26008.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-14 at 10:51 -0700, Steve G wrote:
> Hi,
> 
> In security/selinux/ss/services.c at the selinux_audit_rule_init() function is
> this code:
> 
>         if (!ss_initialized)
>                 return -ENOTSUPP;
> 
> The audit system sends that to user space, but its a special value that is
> supposed to be internal to the kernel. Should the audit system look for this
> value and change it when it calls the function, or should we change this value in
> the selinux code? And if we change it, what should it be? EINVAL doesn't make
> sense as the syntax of what's being asked to do is correct. Should we define
> something like ENOMAC?

It should likely have been -EOPNOTSUPP in the first place.  So I'd just
change it to that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
