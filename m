Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i719Z1rT005991
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 05:35:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i719Yw0x018729
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:34:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: hacked Makefile to use 17 instead of 18
Date: Sun, 1 Aug 2004 19:34:54 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040731122835.GO3378@lkcl.net>
In-Reply-To: <20040731122835.GO3378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408011934.54470.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 31 Jul 2004 22:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> well, i'm about to find out if it's okay, but i hacked the 1.14-1
> Makefile to forcibly put policy file of type 18 into a file named
> policy.17.

Bad idea.  Why would you want to do that?

> oh, darn, i'm using xfs, hope that's okay.

XFS works on the latest kernels.  But make sure you have 512 byte Inodes (see 
previous discussion on the list).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
