Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9L0T8XZ005715
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 20:29:08 -0400 (EDT)
Date: Wed, 20 Oct 2004 17:28:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041020172858.R2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com> <20041019140947.G2357@build.pdx.osdl.net> <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil> <20041020104123.J2357@build.pdx.osdl.net> <1098302713.672.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098302713.672.198.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Oct 20, 2004 at 04:05:13PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> Works for me.  However, the test may be overly strong, e.g. if policy >=
> 0 on entry, then oldpolicy isn't used, and we don't care whether it
> stayed the same, right?

Heh, I figured you'd mention that ;-)  It's basically what the old behaviour is,
when rq_lock serialized it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
