Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1RODq018409
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:27:46 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QAXLGK012012
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 10:34:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jeff Pitman <symbiont@berlios.de>
Subject: Re: writing zero bytes in bash
Date: Sat, 26 Feb 2005 21:32:50 +1100
Cc: fedora-devel-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
References: <200502261832.16337.russell@coker.com.au> <200502261612.54380.symbiont@berlios.de>
In-Reply-To: <200502261612.54380.symbiont@berlios.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502262132.53440.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 26 February 2005 19:12, Jeff Pitman <symbiont@berlios.de> wrote:
> On Saturday 26 February 2005 15:32, Russell Coker wrote:
> > To unset the fscreate or exec context you have to call write(fd, X,
> > 0) (the value of X doesn't seem to matter as the kernel code doesn't
> > dereference it).
>
> dd

I'm not sure what you are saying here.  Are you suggesting to use dd to write 
zero bytes or that bash should work in a similar way to dd?

dd does not seem capable of actually doing a write of 0.  If you use bs=0 then 
it gives an error code, if you use count=0 then it does nothing (like bash).  
Maybe this should be considered a bug in dd as well, but let's concentrate on 
bash for the moment.

This isn't the type of issue that can be addressed with a one-word reply.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
