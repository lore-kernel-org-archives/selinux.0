Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JIRhrT001515
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 14:27:43 -0400 (EDT)
Date: Tue, 19 Oct 2004 11:27:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: John Johansen <johansen@immunix.com>, Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019112740.A2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com> <4173F737.1070204@immunix.com> <20041018121432.O2357@build.pdx.osdl.net> <20041018214052.GB4336@immunix.com> <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil> <1098209844.29525.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098209844.29525.107.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Oct 19, 2004 at 02:17:24PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2004-10-19 at 08:14, Stephen Smalley wrote:
> > I think that you need to hold the lock when extracting p->policy, and if
> > you drop the lock for the security checks, you need to recheck that
> > p->policy hasn't changed after you re-take the lock.  Advantage of your
> > approach (with those fixes) is that no special handling is required by
> > capable(CAP_SYS_NICE) and security_task_setscheduler hook
> > implementations; they can audit immediately.  But given that the audit
> > framework does support deferred auditing via audit_log_end_irq, I'm not
> > sure that this is going to be compelling upstream, as it makes
> > setscheduler() very convoluted.
> 
> Hmmm...may have spoken too soon; looks like audit_log_end_irq can
> deadlock too when the runqueue lock is held.  Only option is to disable
> auditing of CAP_SYS_NICE and setscheduler?  Very unpleasant.

I assume this is due to wakeup code putting smth. on the runqueue?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
