Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T6aWrT016622
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 02:36:32 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6T6aPCb026716
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 06:36:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Milan P. Stanic" <mps@rns-nis.co.yu>
Subject: Re: New or Old SELinux
Date: Thu, 29 Jul 2004 16:35:56 +1000
Cc: selinux@tycho.nsa.gov
References: <1090955044.1886.49.camel@allhosts> <20040728094631.GA2977@rns-nis.co.yu>
In-Reply-To: <20040728094631.GA2977@rns-nis.co.yu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407291635.56038.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Jul 2004 19:46, "Milan P. Stanic" <mps@rns-nis.co.yu> wrote:
> On Tue, Jul 27, 2004 at 04:04:05PM -0300, Martin Sarsale wrote:
> > I would like to stay in stable but I couldn't find any of the New
> > SELinux (coreutils, procps, etc) enabled packages for deb stable, so I
> > guess I'll have to stick with the old SELinux (on kernels 2.4.x).
>
> Which kernel version you have on stable, 2.4 or 2.6?
>
> I have backport (it is far from perfect, but it works) for woody with
> 2.6 kernels at http://www.rns-nis.co.yu/~mps/
> It is few months old, though.

It might be better if you use the backports.org repository if you are going to 
develop packages to share with others.

> Backporting SE Linux utilities and libraries isn't hard at all,
> thanks to the excellent work of the Debian maintainer.

If you could maintain a back-port repository then that would be really good!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
