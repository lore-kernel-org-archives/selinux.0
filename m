Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KG51XZ001355
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 12:05:01 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KG51e3005883
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 16:05:01 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: John Johansen <johansen@immunix.com>
Cc: Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041020154909.GA1917@immunix.com>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
	 <20041019140947.G2357@build.pdx.osdl.net>
	 <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
	 <20041020154909.GA1917@immunix.com>
Content-Type: text/plain
Message-Id: <1098288100.672.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 12:01:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-20 at 11:49, John Johansen wrote:
> sigh it seems I posted the wrong patch file the one that got posted is
> the one where I threw up my hands and swore about having to break the
> lock as Stephan suggests.
> 
> The actual patch adds an extra lock (I liked that a little better than
> breaking the rq lock) in setscheduler and around the other points that
> call __setschedule.

Not sure I understand - can you post the correct patch?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
