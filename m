Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSJLaIi023929
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 14:21:37 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSJJmGx026037
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 19:19:48 GMT
Subject: Re: [patch] disable policycoreutils locale option
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1103514592.3871.13.camel@chris.pebenito.net>
References: <1103514592.3871.13.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1104261374.21391.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 14:16:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-12-19 at 22:49, Chris PeBenito wrote:
> This patch make the the locale code in policycoreutils able to be
> disabled.  I was trying to compile policycoreutils against uclibc for an
> embedded system, but uclibc doesn't have locale support.  The patch
> leaves locale support on by default.  The patch is against sourceforge
> CVS.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
