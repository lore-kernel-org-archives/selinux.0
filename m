Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NCESHa024767
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 08:14:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6NCEODW006115
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 12:14:24 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
        by jazzband.ncsc.mil  with ESMTP id h6NCEOeN006111 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 12:14:24 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NCENxH014037
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 08:14:23 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6NCENcw014035
	for selinux@tycho.nsa.gov; Wed, 23 Jul 2003 08:14:23 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6MKpNHa022377
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 16:51:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6MKpMDW018240
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:51:22 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h6MKpLeN018237 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:51:21 GMT
Date: Tue, 22 Jul 2003 16:49:12 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Russell Coker <russell@coker.com.au>
cc: Charlie Watts <st_possenti@yahoo.com>, <selinux@tycho.nsa.gov>
Subject: Re: Linuxfromscratch.org
In-Reply-To: <200307221606.42540.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0307221644010.21542-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

if you are looking for integrity, Linuxfromscratch is just the start.

You have to come up with a way to exclude Kerningan-style compiler hacks,
and similar OS hacks from being inserted into the "clean" source build.

Kernigan, as some will remember, early in Unix days (70s), altered the
compiler to include a backdoor in login when it compiled login.c, and
altered the compiler to insert the backdoor-inserter whenever it compiled
itself.  So even if you recompiled Unix from scratch from clean source,
you still had a backdoor.  I think even if you retargeted the compiler, it
still inserted to the apprpropriate backdoor-inserter.  A similar hack can
be done at the OS level.

		--Dean

On Tue, 22 Jul 2003, Russell Coker wrote:

> On Mon, 21 Jul 2003 21:42, Charlie Watts wrote:
> > I want to make a linux system from scratch. I have never compiled my
> > own kernel, but I was wondering if i could start with the SE Linux
> > kernel. I am using the instructions from linuxfromscratch.org to make
> > the system on my laptop, which is running Mandrake 9, on a i686, 512Mb
> > ram, and a 1.13 GHz P IV. Ext3 file system. Any advice would be great.
>
> I recommend that you compile your own kernel without SE Linux first, and then
> try using SE Linux after you have had some practise at building your own
> kernel.  Otherwise if you have a problem you won't know whether it's SE Linux
> related or just a general kernel build issue.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
