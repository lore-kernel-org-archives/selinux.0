Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KCRPrT006327
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 08:27:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KCQAui007753
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 12:26:10 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041019140947.G2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
	 <20041019140947.G2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 08:23:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 17:09, Chris Wright wrote:
> * James Morris (jmorris@redhat.com) wrote:
> > Yes, it's the runqueue lock.  One simple possibility would be to convert
> > the audit code over to use the keventd workqueue, and use
> > schedule_delayed_work() to kick the audit logging via a timer in this
> > case.
> 
> Yeah, guess that would work, but it's not that nice a solution ;-/

And requiring security modules to special case CAP_SYS_NICE auditing in
their capable() hooks and any auditing in their setscheduler() hooks
seems very unpleasant anyway.  I'd actually favor one of:
- Fix John's setscheduler patch to hold the lock while extracting
p->policy, drop it for the security checks, re-take the lock, and verify
that p->policy hasn't changed (if it has, bail with EPERM, as I can't
see any legitimate reason for such a race other than an intentional
malicious attempt to exploit it), or
- Add a separate post hook to setscheduler after locks are dropped, and
do all auditing from it.  Likely requires changing existing setscheduler
hook to return some state to pass along to the post hook for auditing in
addition to the error code itself.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
