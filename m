Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5E7aErT016564
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 03:36:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5E7a8bJ010438
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 03:36:10 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: debian-devel@lists.debian.org
Subject: Re: [SE/Linux] status / progress report 13jun2004
Date: Mon, 14 Jun 2004 17:35:59 +1000
Cc: Christoph Hellwig <hch@lst.de>, SE-Linux <selinux@tycho.nsa.gov>,
   debian-user@lists.debian.org
References: <20040613153648.GB26207@lkcl.net> <20040613170146.GA14854@lst.de>
In-Reply-To: <20040613170146.GA14854@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406141735.59407.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Jun 2004 03:01, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Jun 13, 2004 at 03:36:48PM +0000, Luke Kenneth Casson Leighton 
wrote:
> > * debian kernels need to be available compiled with se/linux security
> >   enabled (and boot-time optional) by default.  this results in a
> >   2% performance hit (wow big deal) when se/linux is not enabled
> >   at boot time.  Gentoo, SuSE and Fedora all accept this 2%.
>
> It's actually disabled again (compiled in but disabled) in SuSE because
> the performance hit was much much worse.  And I remember benchmark
> numbers where the lsm hooks alone decreased the SpecWeb numbers on ia64
> by more than 10%.  I'd vote strongy against enabling LSM in the Debian
> kernel images.

In other distributions more features are enabled by default to reduce the 
support costs (people will install the wrong kernel package and file bug 
reports).  In Debian choices are offered for everything, there are several 
mail servers, several POP servers, having several builds for the kernel is 
not a big deal.

Currently there has not been a large demand for SMP SE Linux kernels.  So 
adding a new kernel binary package that's the same as the default one for the 
most common CPU but with SE Linux enabled should be easy enough to do.

1-386 1-586tsc 1-686 1-686-smp 1-k6 1-k7 1-k7-smp speakup alpha amiga arm 
atari bvme6000 hppa i386 ia64 mac mvme147 mvme16x q40 s390

>From a quick grep of the packages list the above seems to be the list of 
supported Debian kernel binary packages.  Adding a 686-selinux package and 
compelling anyone who wants SE Linux on anything other than a 686 single-CPU 
machine to compile their own kernel should make most people reasonably happy.  
Athlon's generally run i686 code well.

The architectures listed are for 2.4.x kernels - not all architectures support 
2.6.x yet.  I suggest that Debian not provide any binaries to support 2.4.x 
SE Linux kernels, it's just too much work to keep them maintained.  I have 
been thinking of requesting that my package kernel-patch-2.4-lsm be removed 
from Debian as it usually takes more than a month for me to catch up with a 
new kernel.org release.

I don't have the time to build such kernel binaries though, so someone else 
will have to volunteer.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
