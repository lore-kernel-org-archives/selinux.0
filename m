Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7U0efrT001904
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 20:40:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7U0ecis006884
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 00:40:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Andreas Schuldei <andreas@schuldei.org>
Subject: Re: selinux and kde
Date: Mon, 30 Aug 2004 10:40:36 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823234320.GC12720@lkcl.net> <200408300329.27393.russell@coker.com.au> <20040829184612.GO23299@lukas.schuldei.com>
In-Reply-To: <20040829184612.GO23299@lukas.schuldei.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408301040.36024.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Aug 2004 04:46, Andreas Schuldei <andreas@schuldei.org> wrote:
> * Russell Coker (russell@coker.com.au) [040829 19:29]:
> > The lib will go into base post-sarge.  The Debian inertia is the main
> > problem.
> >
> > I am continuing to develop Debian packages in my spare time, I just have
> > much less spare time.  This means I can't spend so much time recompiling
> > packages because of Debian developers being unwilling to accept patches.
>
> perhaps this is where other debian developers and users can help,
> by friendly suggesting to apply the patch?
>
> could you compile a list of villians or bugs?

The main thing at the moment is to get libselinux into base.  Then we can 
hopefully get patched cron and sysvinit in there, and logrotate compiled with 
SE Linux support.

Another thing that has to be done is to have PAM sorted out.  PAM is 
effectively forked multiple times.  The Red Hat and the Debian PAM packages 
have different patches and no work is being done to improve the situation at 
the moment.  Everyone seems to agree that if someone takes over PAM upstream 
and incorporates the fixes then they will follow it instead of the current 
upstream of PAM.  Know anyone who wants to take over PAM upstream?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
