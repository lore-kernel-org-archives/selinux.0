Subject: Re: Signal problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050426192327.70954.qmail@web51507.mail.yahoo.com>
References: <20050426192327.70954.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 15:51:46 -0400
Message-Id: <1114545106.30521.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-26 at 12:23 -0700, Steve G wrote:
> Hello,
> 
> I ran across a problem while working on the audit code that has SE Linux
> implications. The function security_task_kill does not hook all paths for signal 
> entry/delivery. Just to make sure you know the piece of code I'm talking 
> about:
> 
> http://lxr.linux.no/source/kernel/signal.c#L630
> 
> Some background -- we have a CAPP requirement to identify the sender of the 
> TERM signal to the audit daemon. We placed a hook inside check_kill_permission().
> It was called on a PPC, but my i686 kernel never sees it. I think there is some
> arch specific code that changes how signals are delivered on ix86.
> 
> My test was simply /etc/rc.d/init.d/auditd stop
> and then look for a message stating the shutdown signal was received.
> 
> Using strace, the usual entry method was syscall 37 (kill). After that who knows
> what the code path is? I'm moving the audit hook to a whole new place 
> to solve our problem. But I thought you might want to know about this since 
> security_task_kill appears to be not hooking signals on all platforms.

Hmmmm...how certain are you?  Basic testing of signal controls and
auditing (via SELinux) seems to be working as expected here on x86.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
