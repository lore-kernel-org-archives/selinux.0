Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA477jXZ021265
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 02:07:45 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA476LCJ005048
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 07:06:23 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA472ZBW029961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 01:02:35 -0600
To: selinux@tycho.nsa.gov
Subject: Re: Updated SELinux Release
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	<Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	<1099534538.3875.6.camel@nexus.verbum.private>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Thu, 04 Nov 2004 01:02:35 -0600
In-Reply-To: <1099534538.3875.6.camel@nexus.verbum.private> (Colin Walters's
	message of "Wed, 03 Nov 2004 21:15:38 -0500")
Message-ID: <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 03 Nov 2004 21:15:38 -0500, Colin Walters <walters@verbum.org> said: 

> On Wed, 2004-11-03 at 19:21 +0000, Dhruv Gami wrote:
>> Personally, i would prefer to have those two tarballs available. I
>> know most people using SELinux are familiar with patching the
>> kernel, and are generally familiar with how Linux works and know
>> their way around on a Linux system.

> But moving forward, we don't want people to have to patch their
> kernel or utilities.

	Moving waaay forward. I asked the Debian kernel team to
 consider  compiling in SELinux (perhaps disabled by default, for
 starters), and was told that that is not going to fly because of
 "significant performance hit" one takes by compiling SELinux in.  I
 did not have any data to refute the claim, so  that is where we sit.

> Linux distributions should be shipping with a SELinux- enabled
> kernel and utilities by default.  Moreover, I think they should be
> shipping it on by default in every install, with a targeted policy
> like Fedora is doing, and a strict policy option.  We want SELinux
> to get to the point where *not* having it on in some form is viewed
> a bit like logging into your desktop as root.

	While a laudable long term goal, the reality is that most
 distributions do not ship these utilities today, and in the case of
 Debian, progress, while it is happening, is slow enough that
 pragmatism requires we consider the reality that SELinux shall _not_
 be the default in the near term.

	manoj
-- 
[It is] best to confuse only one issue at a time. K&R
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
