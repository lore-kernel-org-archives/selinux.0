Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QGCurT014176
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 12:12:56 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QGCt0g019059
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 16:12:55 GMT
Subject: Re: Req: patches against vanilla source
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Laurens Blankers <lblankers@xs4all.nl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1580.10.1.1.4.1093531747.squirrel@10.1.1.4>
References: <1580.10.1.1.4.1093531747.squirrel@10.1.1.4>
Content-Type: text/plain
Message-Id: <1093536691.9280.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 12:11:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-26 at 10:49, Laurens Blankers wrote:
> Hello all,
> 
> Applying the patches, provided on the website, to the source of the
> various utilities results in rejects. Especially util-linux, which already
> includes several selinux files which don't work well with the patch and
> sysvinit causes a lot of problems.
> 
> Would it be possible to provide patches against the vanilla source?

The full SRPM is also provided.  No patches against vanilla source
exist, and the userland SELinux patches are all being maintained by
RedHat for Fedora now; we just carry a copy of a core subset (and there
are many others in Fedora) for reference for people porting to other
distros (and others have already ported them to Debian, Gentoo, and
SuSE).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
