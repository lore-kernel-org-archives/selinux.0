Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4EeLXZ023284
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 09:40:21 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4EcxCH020896
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 14:39:00 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1099578952.3174.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 09:35:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 02:02, Manoj Srivastava wrote:
> 	Moving waaay forward. I asked the Debian kernel team to
>  consider  compiling in SELinux (perhaps disabled by default, for
>  starters), and was told that that is not going to fly because of
>  "significant performance hit" one takes by compiling SELinux in.  I
>  did not have any data to refute the claim, so  that is where we sit.

Given that SELinux supports disabling both at boot time (via selinux=0)
and at runtime (via /selinux/disable, only useable prior to the initial
policy load, used by the patched /sbin/init when /etc/selinux/config
specifies disabled), the only performance impact they can truly claim is
fundamental to enabling SELinux at compile-time is the overhead of LSM
itself.  So ask for measurements showing that LSM in 2.6 imposes a
significant overhead by itself, and don't accept measurements based on
old versions of LSM prior to 2.6.

> 	While a laudable long term goal, the reality is that most
>  distributions do not ship these utilities today, and in the case of
>  Debian, progress, while it is happening, is slow enough that
>  pragmatism requires we consider the reality that SELinux shall _not_
>  be the default in the near term.

Fedora (and RHEL4) and Hardened Gentoo have extensive SELinux
integration, and SuSE 9.x had the SELinux code included in the kernel
and a subset of the userland, just disabled by default.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
