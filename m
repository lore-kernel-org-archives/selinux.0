Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FHOKHa018687
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:24:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FHNInJ004181
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:23:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FHNIhr004178
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:23:18 GMT
Subject: Re: lsm-2.4-selinux-2003071106 compile problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: M E Robbins <merobbins@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030715153015.77905.qmail@web10002.mail.yahoo.com>
References: <20030715153015.77905.qmail@web10002.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1058289856.13738.714.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 13:24:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-15 at 11:30, M E Robbins wrote:
> I am trying to get the lsm-2.4-selinux-2003071106.tgz package to compile.
> 
> When compiling libsecure I get the error message listed below.  I checked the NSA
> mailing list archives and mention was made of a patch from May 02, which I got,
> but it appears that the newest selinux already has that patch installed.
> 
> My setup: glibc 2.3.1, gcc 3.2.3, slackware 9.x base, i386 pentium pro 200mhz.

Reverse the patch from May 02 if you want to use glibc 2.3.1, as it has
the old stat structure definition.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
