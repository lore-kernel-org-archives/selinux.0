Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JIdvrT001686
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 14:39:57 -0400 (EDT)
Date: Tue, 19 Oct 2004 11:39:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019113954.B2357@build.pdx.osdl.net>
References: <20041019112740.A2357@build.pdx.osdl.net> <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Tue, Oct 19, 2004 at 02:36:30PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 19 Oct 2004, Chris Wright wrote:
> 
> > > Hmmm...may have spoken too soon; looks like audit_log_end_irq can
> > > deadlock too when the runqueue lock is held.  Only option is to disable
> > > auditing of CAP_SYS_NICE and setscheduler?  Very unpleasant.
> > 
> > I assume this is due to wakeup code putting smth. on the runqueue?
> 
> This shouldn't happen from interrupt.

The conosole semaphore isn't normal, iirc.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
