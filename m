Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i728BOrT010552
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 04:11:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i728AoXV008676
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:10:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: gcc-2.95: checking for va_list assignment copy... configure: error: no
Date: Mon, 2 Aug 2004 18:10:51 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1091383127.1295.283.camel@debby>
In-Reply-To: <1091383127.1295.283.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408021810.51884.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Aug 2004 03:58, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> Trying to build a SE-Linux dpkg package with gcc-2.95 and this script:
>
> ends like this:
> ----------------------------------------------------
> checking for initscr in -lncurses... yes
> checking if TIOCNOTTY is defined in sys/ioctl.h... yes
> checking for va_copy... no
> checking for va_list assignment copy... configure: error: no
> make: ***
> [/home/shorty/russellpackages/dpkg/dpkg-1.10.22/build/configure-stamp]
> Error 1 ----------------------------------------------------
>
> Trying to build the package with the mentioned script above plus gcc-3.3
> or gcc-3.0 or gcc-3.4 each time successfully builds these packages:

Why not just use the latest GCC?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
