Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KK8sXZ003928
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 16:08:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KK7eui006038
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 20:07:40 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041020104123.J2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
	 <20041019140947.G2357@build.pdx.osdl.net>
	 <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
	 <20041020104123.J2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1098302713.672.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 16:05:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-20 at 13:41, Chris Wright wrote:
> Unfortunately, policy < 0 is not really POSIX compliant, but it's
> documented behaviour, so changing this would change the ABI, and could
> break something.  Otherwise, the simplest would be remove that bit
> altogether.  Don't think we need to hold lock while sampling the value,
> since it should be processor word-sized value, nothing odd on loading
> should happen.  It's possible to loop and recheck, but w/out convincing
> oneself that livelock is not possible, -EPERM and return seems quite
> valid for this very unlikely case.  Untested patch below.

Works for me.  However, the test may be overly strong, e.g. if policy >=
0 on entry, then oldpolicy isn't used, and we don't care whether it
stayed the same, right?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
