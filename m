Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47J5PI4011946
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 15:05:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h47J5D7R020499
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 19:05:14 GMT
Received: from babbler.bmc.com (fw-us-sjc-1.bmc.com [198.175.229.250])
        by jazzband.ncsc.mil  with ESMTP id h47J5BKP020495 for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 19:05:12 GMT
Date: Wed, 7 May 2003 14:03:41 -0500 (CDT)
From: Richard Troth <rtroth@bmc.com>
To: Russell Coker <russell@coker.com.au>
Cc: Nick Gray <nagray@austin.rr.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux and LFS
In-Reply-To: <200305080343.11969.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0305071357530.30962-100000@trothnec.bmc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Considered Debian?

Good point.
For my own "Linux from scratch",
Debian has proved to be a vital source depot and reference.

 ...
> > my efforts to remove the software responsible. I actually found circular
> > dependencies in the packages.
>
> Debian has no such "features", and is in a fairly good state with regard to
> circular dependencies.
>
> For building a Debian system from source there are some dependency issues.
> For example you can't build packages in a regular fashion without Perl, and
> Perl needs a huge number of other things to be built before it can be built.

Right.   For the "tool chain",  you need GCC, GLIBC, and a
smattering few other development tools.   But one or two of those
(in my experience,  not exhaustively scientific)  required Perl
for their auto config.   [sigh]   So the basic tool chain
racked up to 28 packages.   That was enough to give me a
usable 'chroot' where I could re-build the same 28 and then
build anything else.

> Doing a cross-compile bootstrap of Debian will be painful because of this.
> But recompiling every package in a Debian system should be quite easy (on
> i486 and newer CPUs at least).

[Mine is not related to SE.]
I still haven't figured out Debian's build process.
I'm trying to stick to the usual

	./configure
	make
	make install

though a good number of packages need an explicit  "--prefix=/usr".

> Some people on this list have been talking about getting SE Linux going
> with Gentoo which is based on compiling everything.  I wonder how their
> progress is going.

Yes.   Gentoo is recommended by many hard-core bootstrappers.

-- RMT



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
