Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JItjrT001843
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 14:55:45 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JIthS7002562
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 18:55:44 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 14:52:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 14:36, James Morris wrote:
> On Tue, 19 Oct 2004, Chris Wright wrote:
> 
> > > Hmmm...may have spoken too soon; looks like audit_log_end_irq can
> > > deadlock too when the runqueue lock is held.  Only option is to disable
> > > auditing of CAP_SYS_NICE and setscheduler?  Very unpleasant.
> > 
> > I assume this is due to wakeup code putting smth. on the runqueue?
> 
> This shouldn't happen from interrupt.

setscheduler() isn't being called from interrupt.  I changed the SELinux
setscheduler hook to call a wrapper function to use audit_log_irq_end(),
and exercising it immediately deadlocked the system. 
audit_log_irq_end() -> tasklet_schedule() -> raise_softirq_irqoff() ->
wakeup_softirqd() -> wake_up_process() is my current working guess,
couldn't get a dump after the lockup.  No response to sysrq-t.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
