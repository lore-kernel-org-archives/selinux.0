Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA14453
	for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 18:29:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA23989
	for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 23:26:57 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
	by jazzswing.ncsc.mil  with ESMTP id XAA23985
	for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 23:26:57 GMT
Message-Id: <200212212326.XAA23985@jazzswing.ncsc.mil>
Date: Sat, 21 Dec 2002 18:29:1 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: Error message - BSD lib required
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am making lot of progress on compiling the UTILS on Debian.  I am being stumped with a new error while compiling
the UTILS.  The error message is as follows:

====================================

Making all in src
make[3]: Entering directory `/usr/src/selinux/utils/tar-1.13.25/src'
gcc  -g -O2   -o tar  buffer.o compare.o create.o delete.o extract.o incremen.o
list.o mangle.o misc.o names.o rtapelib.o tar.o update.o ../lib/libtar.a  ../lib/libtar.a /usr/local/selinux/lib/libsecure.a -lrt -lbsd
/usr/bin/ld: cannot find -lbsd
collect2: ld returned 1 exit status
make[3]: *** [tar] Error 1
make[3]: Leaving directory `/usr/src/selinux/utils/tar-1.13.25/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/usr/src/selinux/utils/tar-1.13.25'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/selinux/utils/tar-1.13.25'
make: *** [xtar] Error 2
 
====================================

The following are the BSD files found in /usr/lib

/usr/lib/menu/bsdgames
/usr/lib/libbsd-compat.a
/usr/lib/python2.1/lib-dynload/bsddb.so
/usr/lib/python2.2/lib-dynload/bsddb.so
/usr/lib/nessus/plugins/finger_freebsd.nasl
/usr/lib/bcc/i86/libbsd.a
/usr/lib/bcc/include/bsd
/usr/lib/bcc/include/bsd/bsd.h


The following is my /etc/ld.so.conf

/lib
/usr/lib
/usr/X11R6/lib
/usr/local/lib
/usr/lib/bcc/i86/


What am I missing that is causing this error message? ( I have executed "ldconfig" command and error message continues. )

Thank you in advance for any help.

PS - Thanks Russell for the tips on Debian packages.

Subba Rao
sailorn@attglobal.net
2002-12-21



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
