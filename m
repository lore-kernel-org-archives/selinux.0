Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA23717
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 23:44:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA03440
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 03:43:24 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA03436 for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 03:43:21 GMT
Date: Sun, 28 Jul 2002 13:44:32 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Shaun Savage <savages@pcez.com>, SCC <SCC@securecomputing.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Message from Secure Computing
Message-ID: <20020728034432.GC7217@snoopy.apana.org.au>
References: <7124107ACDA2D3118B7300A0C99D99A107DB53CB@stpntmx01.share.rsvl.securecomputing.com> <3D429EAE.60906@pcez.com> <20020727142009.2B3092FC@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020727142009.2B3092FC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 27, 2002 at 04:20:08PM +0200, Russell Coker wrote:
> I entered into an implicit contractual agreement with the NSA and with the 
> world at large when I started working on SE Linux under the GPL.  I consider 
> no agreements other than the GPL to be binding on me or on anyone who uses my 
> work.
> 
> If SCC consider that the NSA did the wrong thing by releasing the code under 
> the GPL then they can sue the NSA for damages.  It has nothing to do with us.

My understanding, based on Debian's interpretation of the GPL, is
that any software that is derived from or requires the use of, and is
distributed with GPL software[1], it must also be licensed under the GPL
(or compatable license) if it is to be distributed.

Since SE-Linux obviously is derived from Linux and requires Linux, and
Linux is obviously GPL, and the changes appear to be distributed with
Linux, then this must mean SE-Linux must also be licensed under the GPL
(or another license compatable with the GPL).

Even if distributing the patch for Linux by itself was OK (from what I
have read, it wouldn't be OK, for instance, it would contain GPL code),
it would not be OK for third parties to distribute compiled versions of
Linux with the patch applied.

This has come up over and over again on debian-legal before under (IMHO)
less clear circumstances (eg. a program using openssl shared library and
a GPL shared library at the same time cannot be distributed as part of
the one distribution).

Footnote:

[1] The exact wording in the GPL:

The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.

I think it is clear here that this exemption does not apply; as
SE-Linux is normally distributed with Linux (unlike other proprietary
Linux modules).
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
