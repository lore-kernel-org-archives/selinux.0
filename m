Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i73BCurT019708
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 07:12:56 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i73BCM6o007076
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 11:12:22 GMT
Subject: Re: gcc-2.95: checking for va_list assignment copy... configure:
	error: no
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408022013.51748.russell@coker.com.au>
References: <1091383127.1295.283.camel@debby>
	 <200408021810.51884.russell@coker.com.au> <1091441074.1295.361.camel@debby>
	 <200408022013.51748.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091531568.1291.78.camel@debby>
Mime-Version: 1.0
Date: Tue, 03 Aug 2004 13:12:48 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 12:13, Russell Coker wrote:
> On Mon, 2 Aug 2004 20:04, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > > Why not just use the latest GCC?
> >
> > Because I thought it's a good idea to compile the SE-packages with the
> > same gcc version as the one I will use to compile the kernel.
> 
> That's not necessary.  

Good to know ... :)

> Using a different version of GCC for the kernel 
> shouldn't be a big deal (think of kgcc).
> 
> > And as, IINM, at least for Intel machines (I'm running ppc) gcc 2.95.3
> > still seems to be the recommended version to compile 2.6 kernels I'm
> > using 2.95 for compiling other packages, too ..
> 
> gcc 3.3.4 is working well for me when I compile my i386 kernels.

Good news for me. Thanks for letting me know

> 
> > Compiler issues.
> > ~~~~~~~~~~~~~~~~
> > - The recommended compiler (for x86) is still 2.95.3.
> > - When compiled with a modern gcc (Ie gcc 3.x), 2.6 will use additional
> >   optimisations that 2.4 didn't. This may shake out compiler bugs that
> >   2.4 didn't expose.
> > - Do not use gcc 3.0.x on x86 due to a stack pointer handling bug.
> > - gcc 2.96 is not supported with CONFIG_FRAME_POINTER=y due to a stack
> >   pointer handling bug.
> > ----------------------------------------------------
> >
> > I'll be happily using gcc-3.4 (this is the latest reliable gcc version:
> > Is this correct?) for packages and kernels  if someone tells me that
> > nowadays this is as safe as 2.95.
> 
> 3.3.4 works well for me.  I haven't tried 3.4 yet, but I will probably do so 
> soon.

I'll probably try 3.4, but at least 3.3, for the packages and the 2.6
kernel ... but not being quite sure on gcc-3.4 yet.

So the next steps will be building the packages, and then let's hope I
could manage to find a place to offer them ... :)

Thanks again

Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
