Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VItbHa004970
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 14:55:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6VIsPFB018535
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:54:25 GMT
Received: from relay.pair.com (relay.pair.com [209.68.1.20])
	by jazzswing.ncsc.mil  with SMTP id h6VIsPGD018532
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:54:25 GMT
From: "Hariharan Gopalan" <hari@sapta.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Error while installing:
Date: Thu, 31 Jul 2003 14:55:35 -0400
Message-ID: <MBEOIIDPALLENBNPLKLCAEPMHOAA.hari@sapta.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1059677000.1052.260.camel@moss-huskers.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Stephen

I did not get the same error when I moved inetd.te, but got another error
for xserver.te, and that also went away when I removed xserver.

But this is the new error I am getting:

In file included from fstat_secure.c:5:
xstat_conv.h: In function `xstat_conv':
xstat_conv.h:59: structure has no member named `st_atim'
xstat_conv.h:60: structure has no member named `st_atim'
xstat_conv.h:61: structure has no member named `st_mtim'
xstat_conv.h:62: structure has no member named `st_mtim'
xstat_conv.h:63: structure has no member named `st_ctim'
xstat_conv.h:64: structure has no member named `st_ctim'
make[2]: *** [fstat_secure.o] Error 1
make[2]: Leaving directory `/usr/src/down/secure/selinux/libsecure/src'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/usr/src/down/secure/selinux/libsecure'
make: *** [quickinstall] Error 2

What could this be due to?

thanks

Hari

||-----Original Message-----
||From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
||Sent: Thursday, July 31, 2003 2:43 PM
||To: Hariharan Gopalan
||Cc: selinux@tycho.nsa.gov
||Subject: Re: Error while installing:
||
||
||On Thu, 2003-07-31 at 14:38, Hariharan Gopalan wrote:
||> I am getting this error while making quickinstall:
||>
||> It looks like the policy for inetd. My system uses xinetd, and so I did
||> notmove the inetd.te from unused, but I could not find a xinted.te...
||
||You still want to move up inetd.te when using xinetd.
||
||--
||Stephen Smalley <sds@epoch.ncsc.mil>
||National Security Agency
||
||


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
