Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KG79XZ001405
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 12:07:09 -0400 (EDT)
Date: Wed, 20 Oct 2004 09:07:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: John Johansen <johansen@immunix.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041020090706.H2357@build.pdx.osdl.net>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com> <20041019140947.G2357@build.pdx.osdl.net> <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil> <20041020154909.GA1917@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041020154909.GA1917@immunix.com>; from johansen@immunix.com on Wed, Oct 20, 2004 at 08:49:09AM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* John Johansen (johansen@immunix.com) wrote:
> sigh it seems I posted the wrong patch file the one that got posted is
> the one where I threw up my hands and swore about having to break the
> lock as Stephan suggests.
> 
> The actual patch adds an extra lock (I liked that a little better than
> breaking the rq lock) in setscheduler and around the other points that
> call __setschedule.

Hmm, I didn't see this patch, but it's sounding like it won't fly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
