Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA42IVXZ020299
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 21:18:31 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA42HA4w029913
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 02:17:10 GMT
Subject: Re: Updated SELinux Release
From: Colin Walters <walters@verbum.org>
To: dgami@uncc.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 21:15:38 -0500
Message-Id: <1099534538.3875.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 19:21 +0000, Dhruv Gami wrote:

> Personally, i would prefer to have those two tarballs available. I know 
> most people using SELinux are familiar with patching the kernel, and are 
> generally familiar with how Linux works and know their way around on a 
> Linux system. 

But moving forward, we don't want people to have to patch their kernel
or utilities.  Linux distributions should be shipping with a SELinux-
enabled kernel and utilities by default.  Moreover, I think they should
be shipping it on by default in every install, with a targeted policy
like Fedora is doing, and a strict policy option.  We want SELinux to
get to the point where *not* having it on in some form is viewed a bit
like logging into your desktop as root.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
