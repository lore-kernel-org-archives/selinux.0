Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71AF1rT006190
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 06:15:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71AER52019531
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:14:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: install on new machine fails due to no ln -s on default to current
Date: Sun, 1 Aug 2004 20:14:50 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040731120919.GM3378@lkcl.net>
In-Reply-To: <20040731120919.GM3378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408012014.50635.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 31 Jul 2004 22:09, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> an installation of selinux-policy-default failed because there was
> no symlink from default to current.

There is not meant to be a sym-link.  The data is meant to be copied.  The 
postinst of selinux-policy-default will do this (see line 7).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
