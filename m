Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA25342
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 03:05:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA08190
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 08:05:37 GMT
Received: from rai.sytes.net (h017.p490.iij4u.or.jp [210.149.234.17])
	by jazzswing.ncsc.mil  with ESMTP id IAA08186
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 08:05:35 GMT
Received: from there (rai.sytes.net [127.0.0.1])
	by rai.sytes.net (8.11.6/linuxconf) with SMTP id fAD85hO32732
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2001 17:05:43 +0900
Message-Id: <200111130805.fAD85hO32732@rai.sytes.net>
Content-Type: text/plain;
  charset="iso-2022-jp"
From: Tetsuji Rai <tetsuji@rai.sytes.net>
To: selinux@tycho.nsa.gov
Subject: Cannot build utils on RH7.2
Date: Tue, 13 Nov 2001 17:05:43 +0900
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

   I'm a newbiew here, trying to install selinux on my RH7.2.   But I 
cannot build utils.  I'm building selinux as readme file says (I buld 
SELinux module as part of the kernel) and many parts went well.  However, 
I'm stuck at 7) in readme file (I mean I am stuck when building utils).
   Under utils, "make" command quits with this error message after a while:

--snip---
......foo..........bar......
make[1]: Entering directory `/usr/local/selinux/utils/fileutils-4.0'
cd . && aclocal -I m4
aclocal: m4/isc-posix.m4: 11: duplicated macro `AC_ISC_POSIX'
make[1]: *** [aclocal.m4] Error 1
make[1]: Leaving directory `/usr/local/selinux/utils/fileutils-4.0'
make: *** [all] Error 1
--snip---

  To tell the truth, I tried selinux once before, when I succeeded, but I 
forgot on which RH version I tried.

  I guess next version will be released soon, so I want to fix it as soon 
as possible..
  
Thanks in advance
-- 
Tetsuji Rai (in Tokyo)
http://www.geocities.com/tetsuji_rai
Fax: +1-708-570-4868 (in the US)

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
