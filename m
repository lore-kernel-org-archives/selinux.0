Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S8MVrT008183
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 04:22:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6S8LxAN026991
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:22:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Martin Sarsale <martin@emepe3.net>
Subject: Re: New or Old SELinux
Date: Wed, 28 Jul 2004 16:59:06 +1000
Cc: selinux@tycho.nsa.gov
References: <1090955044.1886.49.camel@allhosts>
In-Reply-To: <1090955044.1886.49.camel@allhosts>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407281659.06601.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Jul 2004 05:04, Martin Sarsale <martin@emepe3.net> wrote:
> Im trying to install SELinux on a debian stable box.
>
> I would like to stay in stable but I couldn't find any of the New
> SELinux (coreutils, procps, etc) enabled packages for deb stable, so I
> guess I'll have to stick with the old SELinux (on kernels 2.4.x).
>
> How old is the old SELinux? Is it insecure?

The old SE Linux is quite old, but has no security problems.  There are no 
patches for recent kernels, and the recent kernels fix some security issues, 
so you will have to find back-ports of all the kernel patches in question.

Sarge is about to be frozen, maybe it's best to wait for the Sarge freeze and 
use it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
