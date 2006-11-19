Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAJ3JTcu014074
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 22:19:29 -0500
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAJ3HoYJ029857
	for <selinux@tycho.nsa.gov>; Sun, 19 Nov 2006 03:17:51 GMT
Date: Sat, 18 Nov 2006 22:19:39 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 00/13] NetLabel cleanups for 2.6.20 [GIT]
In-Reply-To: <200611181110.25281.paul.moore@hp.com>
Message-ID: <XMMS.LNX.4.64.0611182218570.23112@d.namei>
References: <20061117223842.399078000@hp.com> <XMMS.LNX.4.64.0611172308070.13574@d.namei>
 <200611181110.25281.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="537530981-949499154-1163906379=:23112"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--537530981-949499154-1163906379=:23112
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 18 Nov 2006, Paul Moore wrote:

> > There was one minor compilation issue caused by including linux/skbuff.h
> > in an SELinux header, which I fixed (see below).
> 
> <scratching head>
> Huh, sorry about that ... thanks for accepting the patches and making the fix.
> </scratching head>

Here's the error:

security/selinux/ss/policydb.c:472: error: conflicting types for 
â'class_destroy'
include/linux/device.h:295: error: previous declaration of 
â'class_destroy' was here


-- 
James Morris
<jmorris@namei.org>
--537530981-949499154-1163906379=:23112--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
