Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JL9prT003266
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 17:09:51 -0400 (EDT)
Date: Tue, 19 Oct 2004 14:09:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019140947.G2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Tue, Oct 19, 2004 at 04:42:28PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 19 Oct 2004, Stephen Smalley wrote:
> 
> > On Tue, 2004-10-19 at 16:09, Stephen Smalley wrote:
> > > NMI Watchdog detected LOCKUP on CPU1, eip c030f99c, registers:
> > 
> > Sorry, that one wasn't very useful.  Re-tried, got a nicer one.
> > Not sure why the audit_log_end_irq calls don't show up in the call
> > trace.
> 
> Yes, it's the runqueue lock.  One simple possibility would be to convert
> the audit code over to use the keventd workqueue, and use
> schedule_delayed_work() to kick the audit logging via a timer in this
> case.

Yeah, guess that would work, but it's not that nice a solution ;-/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
