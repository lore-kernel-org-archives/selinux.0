Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JKgkrT002996
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 16:42:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JKgjS7007918
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 20:42:45 GMT
Date: Tue, 19 Oct 2004 16:42:28 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
In-Reply-To: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Oct 2004, Stephen Smalley wrote:

> On Tue, 2004-10-19 at 16:09, Stephen Smalley wrote:
> > NMI Watchdog detected LOCKUP on CPU1, eip c030f99c, registers:
> 
> Sorry, that one wasn't very useful.  Re-tried, got a nicer one.
> Not sure why the audit_log_end_irq calls don't show up in the call
> trace.

Yes, it's the runqueue lock.  One simple possibility would be to convert
the audit code over to use the keventd workqueue, and use
schedule_delayed_work() to kick the audit logging via a timer in this
case.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
