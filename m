Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i51NKKrT029614
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 19:20:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i527Eobn006251
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 03:14:51 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: corruption of ext2 filesystem (extended attributes get deleted)
Date: Mon, 31 May 2004 23:21:42 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040531131307.GD5251@lkcl.net>
In-Reply-To: <20040531131307.GD5251@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405312321.42670.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 31 May 2004 23:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> hi, okay, i'm back on the cycle of corruption and restoration.
> this is a fairly consistent thing and thoroughly reproducible.
>
> this time, /dev/log and /etc/motd weren't corrupted but the
> extended attributes on / were, resulting in this:

What version of the kernel?  kernel.org source or Debian kernel source tree?  
My kernel-patch package or NSA patches?  Debian EA patch or acl.bestbits?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
