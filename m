Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JCIFrT028433
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 08:18:15 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JCH1fV020042
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 12:17:01 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: John Johansen <johansen@immunix.com>
Cc: Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041018214052.GB4336@immunix.com>
References: 
	 <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>
	 <4173F737.1070204@immunix.com> <20041018121432.O2357@build.pdx.osdl.net>
	 <20041018214052.GB4336@immunix.com>
Content-Type: text/plain
Message-Id: <1098188096.29525.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 08:14:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 17:40, John Johansen wrote:
> The patch to setscheduler moves the locking of the runqueue, until after
> the calls to capable and security_task_setscheduler, so it fixes both of
> them.  I believe this to be safe, but it really needs vetting by a
> scheduler person.

I think that you need to hold the lock when extracting p->policy, and if
you drop the lock for the security checks, you need to recheck that
p->policy hasn't changed after you re-take the lock.  Advantage of your
approach (with those fixes) is that no special handling is required by
capable(CAP_SYS_NICE) and security_task_setscheduler hook
implementations; they can audit immediately.  But given that the audit
framework does support deferred auditing via audit_log_end_irq, I'm not
sure that this is going to be compelling upstream, as it makes
setscheduler() very convoluted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
