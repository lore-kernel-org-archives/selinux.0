Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72AESrT010979
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 06:14:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72AEPKV005992
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:14:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: gcc-2.95: checking for va_list assignment copy... configure: error: no
Date: Mon, 2 Aug 2004 20:13:51 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1091383127.1295.283.camel@debby> <200408021810.51884.russell@coker.com.au> <1091441074.1295.361.camel@debby>
In-Reply-To: <1091441074.1295.361.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408022013.51748.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Aug 2004 20:04, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > Why not just use the latest GCC?
>
> Because I thought it's a good idea to compile the SE-packages with the
> same gcc version as the one I will use to compile the kernel.

That's not necessary.  Using a different version of GCC for the kernel 
shouldn't be a big deal (think of kgcc).

> And as, IINM, at least for Intel machines (I'm running ppc) gcc 2.95.3
> still seems to be the recommended version to compile 2.6 kernels I'm
> using 2.95 for compiling other packages, too ..

gcc 3.3.4 is working well for me when I compile my i386 kernels.

> Compiler issues.
> ~~~~~~~~~~~~~~~~
> - The recommended compiler (for x86) is still 2.95.3.
> - When compiled with a modern gcc (Ie gcc 3.x), 2.6 will use additional
>   optimisations that 2.4 didn't. This may shake out compiler bugs that
>   2.4 didn't expose.
> - Do not use gcc 3.0.x on x86 due to a stack pointer handling bug.
> - gcc 2.96 is not supported with CONFIG_FRAME_POINTER=y due to a stack
>   pointer handling bug.
> ----------------------------------------------------
>
> I'll be happily using gcc-3.4 (this is the latest reliable gcc version:
> Is this correct?) for packages and kernels  if someone tells me that
> nowadays this is as safe as 2.95.

3.3.4 works well for me.  I haven't tried 3.4 yet, but I will probably do so 
soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
