Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4D5GXZ022478
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 08:05:18 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4D5G8i018411
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 13:05:17 GMT
Date: Thu, 4 Nov 2004 13:15:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, debian-devel@lists.debian.org
Subject: Re: Updated SELinux Release
Message-ID: <20041104131544.GC5461@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com> <1099534538.3875.6.camel@nexus.verbum.private> <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 04, 2004 at 01:02:35AM -0600, Manoj Srivastava wrote:
> On Wed, 03 Nov 2004 21:15:38 -0500, Colin Walters <walters@verbum.org> said: 
> 
> > On Wed, 2004-11-03 at 19:21 +0000, Dhruv Gami wrote:
> >> Personally, i would prefer to have those two tarballs available. I
> >> know most people using SELinux are familiar with patching the
> >> kernel, and are generally familiar with how Linux works and know
> >> their way around on a Linux system.
> 
> > But moving forward, we don't want people to have to patch their
> > kernel or utilities.
> 
> 	Moving waaay forward. I asked the Debian kernel team to
>  consider  compiling in SELinux (perhaps disabled by default, for
>  starters), and was told that that is not going to fly because of
>  "significant performance hit" one takes by compiling SELinux in.  I
>  did not have any data to refute the claim, so  that is where we sit.
 
  i had a bun-fight with the people who have taken over from herbert:
  at the point where i told them that recompiling applications to be
  optimised like yoper and gentoo distributions gives back performance
  far in excess of that lost by selinux, i stopped hearing back from
  them.

> 	While a laudable long term goal, the reality is that most
>  distributions do not ship these utilities today, and in the case of
>  Debian, progress, while it is happening, is slow enough that
>  pragmatism requires we consider the reality that SELinux shall _not_
>  be the default in the near term.
 
 default: no.

 available as an additional package: why not?

 heck, personally i wouldn't even care if it was i386 or 686 only.

 l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
