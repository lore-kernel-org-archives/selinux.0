Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FFUHHa017896
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 11:30:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FFTGnJ025827
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 15:29:16 GMT
Received: from web10002.mail.yahoo.com (web10002.mail.yahoo.com [216.136.130.38])
	by jazzswing.ncsc.mil  with SMTP id h6FFTFhr025824
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 15:29:15 GMT
Message-ID: <20030715153015.77905.qmail@web10002.mail.yahoo.com>
Date: Tue, 15 Jul 2003 08:30:15 -0700 (PDT)
From: M E Robbins <merobbins@yahoo.com>
Subject: lsm-2.4-selinux-2003071106 compile problem
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to get the lsm-2.4-selinux-2003071106.tgz package to compile.

When compiling libsecure I get the error message listed below.  I checked the NSA
mailing list archives and mention was made of a patch from May 02, which I got,
but it appears that the newest selinux already has that patch installed.

My setup: glibc 2.3.1, gcc 3.2.3, slackware 9.x base, i386 pentium pro 200mhz.

Any thoughts?  The nsa list archives made it sound as if it is a glibc problem
but I'm afraid I don't know how to proceed.

If I can't solve this in fairly short order, I'll install debian and go from
there, but I am unreasonably fond of slackware and would like to make a go with
what I have...

Thank you,

Mike Robbins

--- start error message ---

cc -o execvp_secure.o -c -I../include -I/usr/local/selinux/include
execvp_secure.c
cc -o fchsid.o -c -I../include -I/usr/local/selinux/include fchsid.c
cc -o fchsidfs.o -c -I../include -I/usr/local/selinux/include
fchsidfs.c
cc -o fstat_secure.o -c -I../include -I/usr/local/selinux/include
fstat_secure.cIn file included from fstat_secure.c:5:
xstat_conv.h: In function `xstat_conv':
xstat_conv.h:59: structure has no member named `st_atim'
xstat_conv.h:60: structure has no member named `st_atim'
xstat_conv.h:61: structure has no member named `st_mtim'
xstat_conv.h:62: structure has no member named `st_mtim'
xstat_conv.h:63: structure has no member named `st_ctim'
xstat_conv.h:64: structure has no member named `st_ctim'
make[2]: *** [fstat_secure.o] Error 1
make[2]: Leaving directory `/usr/src/selinux/libsecure/src'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/usr/src/selinux/libsecure'
make: *** [quickinstall] Error 2

--- end error message ---




__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
