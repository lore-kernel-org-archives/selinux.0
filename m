Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IDqYrT021044
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 09:52:34 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IDqXhM026429
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 13:52:33 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   lsm <linux-security-module@wirex.com>
In-Reply-To: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1098107356.27895.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 09:49:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 08:43, Thomas Bleher wrote:
> cdrecord deadlocks linux 2.6.8.1:
> 
> I have just written selinux policy for cdrecord. While writing this 
> policy cdrecord constantly locked up the computer (even in permissive
> mode). When booting with selinux=0 the problem went away.
> 
> After digging around for a while, the following seems to be happening:
> * cdrecord calls sched_setscheduler()
> * setscheduler (in kernel/sched.c) asks for CAP_SYS_NICE
> * cdrecord doesn't have this capability
> * selinux generates an audit message ==> deadlock
> 
> When I grant cdrecord CAP_SYS_NICE everything works fine.
> I think SELinux shouldn't generate a log message in this case; like it
> is already suppressed for setsched.
> 
> To test, add the attached policy, remove sys_nice from the allowed caps
> and simply call cdrecord without parameters.

Suppressing auditing entirely is undesirable as it makes policy
debugging very difficult.  I think we need to either:
a) Add a flag to avc_audit(), optionally passed via avc_audit_data, that
tells it to use audit_log_end_irq() so that it merely enqueues the audit
message for later processing, and change capable and setscheduler hooks
to pass this flag, or 
b) Move the security checks in setscheduler outside of the runqueue
lock, then just recheck that no security-relevant conditions changed
after taking the lock.

Thoughts?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
