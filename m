Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JJKbrT002194
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 15:20:37 -0400 (EDT)
Date: Tue, 19 Oct 2004 12:20:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041019122034.F2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com> <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil> <20041019120200.D2357@build.pdx.osdl.net> <1098213269.29525.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098213269.29525.148.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Oct 19, 2004 at 03:14:29PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2004-10-19 at 15:02, Chris Wright wrote:
> > Can you trigger NMI?  Although i'm sure it's wakeup putting smth. on
> > runqueue.
> 
> Not on this particular machine; NMI not supported for it.  Migrating to
> different hardware to re-test.

Thanks, I had same problem (NMI not supported).
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
