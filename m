Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JIatrT001642
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 14:36:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JIasS7001572
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 18:36:54 GMT
Date: Tue, 19 Oct 2004 14:36:30 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Chris Wright <chrisw@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
In-Reply-To: <20041019112740.A2357@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Oct 2004, Chris Wright wrote:

> > Hmmm...may have spoken too soon; looks like audit_log_end_irq can
> > deadlock too when the runqueue lock is held.  Only option is to disable
> > auditing of CAP_SYS_NICE and setscheduler?  Very unpleasant.
> 
> I assume this is due to wakeup code putting smth. on the runqueue?

This shouldn't happen from interrupt.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
