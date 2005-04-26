Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3QJNRgA011802
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 15:23:27 -0400 (EDT)
Received: from web51507.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j3QJNQAT022598
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 19:23:26 GMT
Message-ID: <20050426192327.70954.qmail@web51507.mail.yahoo.com>
Date: Tue, 26 Apr 2005 12:23:27 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Signal problem
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I ran across a problem while working on the audit code that has SE Linux
implications. The function security_task_kill does not hook all paths for signal 
entry/delivery. Just to make sure you know the piece of code I'm talking 
about:

http://lxr.linux.no/source/kernel/signal.c#L630

Some background -- we have a CAPP requirement to identify the sender of the 
TERM signal to the audit daemon. We placed a hook inside check_kill_permission().
It was called on a PPC, but my i686 kernel never sees it. I think there is some
arch specific code that changes how signals are delivered on ix86.

My test was simply /etc/rc.d/init.d/auditd stop
and then look for a message stating the shutdown signal was received.

Using strace, the usual entry method was syscall 37 (kill). After that who knows
what the code path is? I'm moving the audit hook to a whole new place 
to solve our problem. But I thought you might want to know about this since 
security_task_kill appears to be not hooking signals on all platforms.

-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
