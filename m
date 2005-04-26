Date: Tue, 26 Apr 2005 13:13:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Signal problem
Message-ID: <20050426201347.GB493@shell0.pdx.osdl.net>
References: <20050426192327.70954.qmail@web51507.mail.yahoo.com> <1114545106.30521.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1114545106.30521.74.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > Using strace, the usual entry method was syscall 37 (kill). After that who knows
> > what the code path is? I'm moving the audit hook to a whole new place 
> > to solve our problem. But I thought you might want to know about this since 
> > security_task_kill appears to be not hooking signals on all platforms.

I think the hook is in the right spot.

> Hmmmm...how certain are you?  Basic testing of signal controls and
> auditing (via SELinux) seems to be working as expected here on x86.

Working fine here as well.  I see the signal get sent each time I try
it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
