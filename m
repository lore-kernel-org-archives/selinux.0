Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IJBirT024121
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:11:45 -0400 (EDT)
Date: Mon, 18 Oct 2004 12:11:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041018121138.N2357@build.pdx.osdl.net>
References: <1098107356.27895.51.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Mon, Oct 18, 2004 at 11:03:15AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) wrote:
> On Mon, 18 Oct 2004, Stephen Smalley wrote:
> 
> > a) Add a flag to avc_audit(), optionally passed via avc_audit_data, that
> > tells it to use audit_log_end_irq() so that it merely enqueues the audit
> > message for later processing, and change capable and setscheduler hooks
> > to pass this flag, or 
> > b) Move the security checks in setscheduler outside of the runqueue
> > lock, then just recheck that no security-relevant conditions changed
> > after taking the lock.
> 
> A seems simpler, but perhaps better to do via a wrapper function.

I agree, esp. since the policy value can change.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
