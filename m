Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S99srT008492
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 05:09:54 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6S99NAN027910
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 09:09:23 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6S99lJ4026387
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 11:09:47 +0200
Subject: Addendum: SeLinux packages compiled smoothly on ppc (after some
	help ..)
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1090967773.7271.2017.camel@debby>
References: <1090967773.7271.2017.camel@debby>
Content-Type: text/plain
Message-Id: <1091005786.7265.2186.camel@debby>
Mime-Version: 1.0
Date: Wed, 28 Jul 2004 11:09:46 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 00:36, Wolfgang Pfeiffer wrote:
> Hi all
> 
> With the patches/packages from (IIRC :)
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

should read:
With the patches or packages plus patches from (IIRC :)

> http://www.coker.com.au/newselinux/
> it's possible to build these binaries on ppc (on Debian/unstable and a
> Powerbook G4):
>  [ ... ]

IIRC: At least in one case (openssl) I took the package from a Debian
mirror and and the patch for it from 
http://www.coker.com.au/newselinux/

This made the build with the Debian package build system easier for me
... :)

Sorry
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
