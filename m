Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JGLcrT000210
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 12:21:38 -0400 (EDT)
Date: Tue, 19 Oct 2004 09:21:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: John Johansen <johansen@immunix.com>, Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019092130.W2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com> <4173F737.1070204@immunix.com> <20041018121432.O2357@build.pdx.osdl.net> <20041018214052.GB4336@immunix.com> <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Oct 19, 2004 at 08:14:56AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Mon, 2004-10-18 at 17:40, John Johansen wrote:
> > The patch to setscheduler moves the locking of the runqueue, until after
> > the calls to capable and security_task_setscheduler, so it fixes both of
> > them.  I believe this to be safe, but it really needs vetting by a
> > scheduler person.
> 
> I think that you need to hold the lock when extracting p->policy, and if
> you drop the lock for the security checks, you need to recheck that
> p->policy hasn't changed after you re-take the lock.  Advantage of your
> approach (with those fixes) is that no special handling is required by
> capable(CAP_SYS_NICE) and security_task_setscheduler hook
> implementations; they can audit immediately.  But given that the audit
> framework does support deferred auditing via audit_log_end_irq, I'm not
> sure that this is going to be compelling upstream, as it makes
> setscheduler() very convoluted.

Yup, I agree.  That's what I was referring to yesterday (policy can change
comment).  John, I didn't realize you had sent this to me earlier.
That, as well as this email never came to my inbox (only got this one
via the list).  I wonder if you need to do some envelope masquerading?

I imagine this looks suspect to our spam filters "Received: from ortho.site..."

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
