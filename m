Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JIKlrT001418
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 14:20:47 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JIKkS7000696
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 18:20:46 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: John Johansen <johansen@immunix.com>
Cc: Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>
	 <4173F737.1070204@immunix.com> <20041018121432.O2357@build.pdx.osdl.net>
	 <20041018214052.GB4336@immunix.com>
	 <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1098209844.29525.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 14:17:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 08:14, Stephen Smalley wrote:
> I think that you need to hold the lock when extracting p->policy, and if
> you drop the lock for the security checks, you need to recheck that
> p->policy hasn't changed after you re-take the lock.  Advantage of your
> approach (with those fixes) is that no special handling is required by
> capable(CAP_SYS_NICE) and security_task_setscheduler hook
> implementations; they can audit immediately.  But given that the audit
> framework does support deferred auditing via audit_log_end_irq, I'm not
> sure that this is going to be compelling upstream, as it makes
> setscheduler() very convoluted.

Hmmm...may have spoken too soon; looks like audit_log_end_irq can
deadlock too when the runqueue lock is held.  Only option is to disable
auditing of CAP_SYS_NICE and setscheduler?  Very unpleasant.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
