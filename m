Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JJ27rT001906
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 15:02:08 -0400 (EDT)
Date: Tue, 19 Oct 2004 12:02:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019120200.D2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com> <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Oct 19, 2004 at 02:52:19PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> setscheduler() isn't being called from interrupt.  I changed the SELinux
> setscheduler hook to call a wrapper function to use audit_log_irq_end(),
> and exercising it immediately deadlocked the system. 
> audit_log_irq_end() -> tasklet_schedule() -> raise_softirq_irqoff() ->
> wakeup_softirqd() -> wake_up_process() is my current working guess,
> couldn't get a dump after the lockup.  No response to sysrq-t.

Can you trigger NMI?  Although i'm sure it's wakeup putting smth. on
runqueue.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
