Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7109XHa006519
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 20:09:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7108LFB006706
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 00:08:22 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-112.adsl.paradise.net.nz [203.79.124.112])
	by jazzswing.ncsc.mil  with ESMTP id h7108JGD006686
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 00:08:20 GMT
Message-ID: <3158.202.27.185.71.1059696560.squirrel@www.crypt.gen.nz>
In-Reply-To: <MBEOIIDPALLENBNPLKLCAEPMHOAA.hari@sapta.com>
References: <1059677000.1052.260.camel@moss-huskers.epoch.ncsc.mil>
    <MBEOIIDPALLENBNPLKLCAEPMHOAA.hari@sapta.com>
Date: Fri, 1 Aug 2003 12:09:20 +1200 (NZST)
Subject: RE: Error while installing:
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "Hariharan Gopalan" <hari@sapta.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hariharan Gopalan said:
> Thanks Stephen
>
> I did not get the same error when I moved inetd.te, but got another error
> for xserver.te, and that also went away when I removed xserver.
>
> But this is the new error I am getting:
>
> In file included from fstat_secure.c:5:
> xstat_conv.h: In function `xstat_conv':
> xstat_conv.h:59: structure has no member named `st_atim'
> xstat_conv.h:60: structure has no member named `st_atim'
> xstat_conv.h:61: structure has no member named `st_mtim'
> xstat_conv.h:62: structure has no member named `st_mtim'

Seems like a common thread :-)
I've added it to my FAQ at http://www.crypt.gen.nz/selinux/faq.html#I.4

I got a couple of failed hunks applying Stephen's oldstat.patch on my
2003071106 release, but I'm guessing that reversing newstat.patch does the
same thing.

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
