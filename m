Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JJI0rT002155
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 15:18:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JJGfvJ011555
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 19:16:41 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041019120200.D2357@build.pdx.osdl.net>
References: 
	 <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
	 <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>
	 <20041019120200.D2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1098213269.29525.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 15:14:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 15:02, Chris Wright wrote:
> Can you trigger NMI?  Although i'm sure it's wakeup putting smth. on
> runqueue.

Not on this particular machine; NMI not supported for it.  Migrating to
different hardware to re-test.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
