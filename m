Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA17904
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 02:41:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA29009
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 06:41:19 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
	by jazzswing.ncsc.mil  with ESMTP id GAA29005
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 06:41:19 GMT
Received: from jw (unknown [65.166.138.2])
	by mail.servicemail123.com (Postfix on SuSE Linux 7.1 (i386)) with ESMTP id 14BEF2CDE0
	for <selinux@tycho.nsa.gov>; Mon,  8 Jul 2002 01:41:52 -0500 (CDT)
Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Well, Make errors for real this time -- in text-utils
Date: Mon, 8 Jul 2002 01:41:32 -0500
MIME-Version: 1.0
Message-Id: <200207080141.32415.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sorry about the last false alarm, but this is a genuine error.

ccs001:/usr/src/selinux/utils # gcc --version
2.95.3


make[1]: Leaving directory `/usr/src/selinux/utils/run_init'
cd util-linux-2.11f && ./configure

configuring util-linux-2.11f
<snip>
make[2]: Entering directory `/usr/src/selinux/utils/util-linux-2.11f/text-utils'
cc -c -O -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes -DNCH=1 -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" -DMOREHELPFILE=\"/usr/share/misc/more.help\" more.c -o more.o
cc -O -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes -DNCH=1 -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" -DMOREHELPFILE=\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncpy.o -o more
more.o: In function `my_putstring':
more.o(.text+0xe): undefined reference to `putp'
more.o: In function `my_setupterm':
more.o(.text+0x36): undefined reference to `setupterm'
more.o: In function `my_tgetnum':
more.o(.text+0x4e): undefined reference to `tigetnum'
more.o: In function `my_tgetflag':
more.o(.text+0x6e): undefined reference to `tigetflag'
more.o: In function `my_tgetstr':
more.o(.text+0x8e): undefined reference to `tigetstr'
more.o: In function `my_tgoto':
more.o(.text+0xb6): undefined reference to `tparm'
more.o: In function `initterm':
more.o(.text+0x2f56): undefined reference to `PC'
more.o: In function `reset_tty':
more.o(.text+0x3819): undefined reference to `tputs'
collect2: ld returned 1 exit status
make[2]: *** [more] Error 1
make[2]: Leaving directory `/usr/src/selinux/utils/util-linux-2.11f/text-utils'
make[1]: *** [all] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/util-linux-2.11f'
make: *** [xutil-linux] Error 2
ccs001:/usr/src/selinux/utils #

- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KTQcQ5u80xXOLBcRArcOAKDFz34whgRLwZneuNIvSh0Nfsm1LACdFqVy
18seIyOH5mWPjQUXP2v+Jac=
=oxxq
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
