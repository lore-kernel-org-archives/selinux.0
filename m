Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27035
	for <selinux@tycho.nsa.gov>; Sat, 16 Nov 2002 11:01:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA06305
	for <selinux@tycho.nsa.gov>; Sat, 16 Nov 2002 15:59:56 GMT
Received: from prserv.net (asmtp2.prserv.net [32.97.166.52])
        by jazzband.ncsc.mil  with ESMTP id PAA06301 for <selinux@tycho.nsa.gov>; Sat, 16 Nov 2002 15:59:56 GMT
Message-Id: <200211161559.PAA06301@jazzband.ncsc.mil>
Date: Sat, 16 Nov 2002 10:58:38 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: SELinux compile errors
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

I am trying to compile SELinux on Slackware 8.1
The LSM tree is LSM-2.4-selinux-2002102211.tgz.  I have downloaded the complete source tree. 

Towards the end of the kernel compilation I got the following error messages:

===========================================================
make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/flask'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/flask'
make -C selopt
make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-commo
 -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6    -I../include -I.. -nostdinc -I /usr/lib/gcc-lib/i3
6-slackware-linux/2.95.3/include -DKBUILD_BASENAME=selopt_core  -c -o selopt_core.o selopt_core.c
selopt_core.c: In function `selopt_ip_label_output':
selopt_core.c:299: parse error before `)'
selopt_core.c: In function `selopt_ip_map_input':
selopt_core.c:355: parse error before `)'
selopt_core.c:363: parse error before `)'
selopt_core.c: In function `selopt_ip_defragment':
selopt_core.c:549: parse error before `)'
make[3]: *** [selopt_core.o] Error 1
make[3]: Leaving directory `/usr/src/lsm-2.4/security/selinux/selopt'
make[2]: *** [_subdir_selopt] Error 2
make[2]: Leaving directory `/usr/src/lsm-2.4/security/selinux'
make[1]: *** [_subdir_selinux] Error 2
make[1]: Leaving directory `/usr/src/lsm-2.4/security'
make: *** [_dir_security] Error 2
===========================================================

Did anyone here on the list compile SELinux on Slackware 8.x successfully?

Subba Rao
sailorn@attglobal.net
2002-11-16



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
