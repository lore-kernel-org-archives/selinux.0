Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72A4qrT010936
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 06:04:52 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i72A4lKV005808
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:04:51 GMT
Subject: Re: gcc-2.95: checking for va_list assignment copy... configure:
	error: no
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408021810.51884.russell@coker.com.au>
References: <1091383127.1295.283.camel@debby>
	 <200408021810.51884.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091441074.1295.361.camel@debby>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 12:04:35 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 10:10, Russell Coker wrote:
> On Mon, 2 Aug 2004 03:58, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > Trying to build a SE-Linux dpkg package with gcc-2.95 and this script:
> >
> > ends like this:
> > ----------------------------------------------------
> > checking for initscr in -lncurses... yes
> > checking if TIOCNOTTY is defined in sys/ioctl.h... yes
> > checking for va_copy... no
> > checking for va_list assignment copy... configure: error: no
> > make: ***
> > [/home/shorty/russellpackages/dpkg/dpkg-1.10.22/build/configure-stamp]
> > Error 1 ----------------------------------------------------
> >
> > Trying to build the package with the mentioned script above plus gcc-3.3
> > or gcc-3.0 or gcc-3.4 each time successfully builds these packages:
> 
> Why not just use the latest GCC?

Because I thought it's a good idea to compile the SE-packages with the
same gcc version as the one I will use to compile the kernel.

And as, IINM, at least for Intel machines (I'm running ppc) gcc 2.95.3
still seems to be the recommended version to compile 2.6 kernels I'm
using 2.95 for compiling other packages, too ..

But I'm definitely not sure on all that. As to the sane ways to compile
a kernel I have to rely on the docs I find on WWW, and those that come
with the software packages:

For instance
<http://www.codemonkey.org.uk/post-halloween-2.5.txt>
explaining "some of the new functionality to be found in the 2.6 Linux
kernel" [Excerpt]:

----------------------------------------------------
Compiler issues.
~~~~~~~~~~~~~~~~
- The recommended compiler (for x86) is still 2.95.3.
- When compiled with a modern gcc (Ie gcc 3.x), 2.6 will use additional
  optimisations that 2.4 didn't. This may shake out compiler bugs that
  2.4 didn't expose.
- Do not use gcc 3.0.x on x86 due to a stack pointer handling bug.
- gcc 2.96 is not supported with CONFIG_FRAME_POINTER=y due to a stack
  pointer handling bug.
----------------------------------------------------

I'll be happily using gcc-3.4 (this is the latest reliable gcc version:
Is this correct?) for packages and kernels  if someone tells me that
nowadays this is as safe as 2.95.

Thanks in anticipation if someone can shed some light on all that ...

Best Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
