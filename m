Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0AB5qIi028300
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 06:05:55 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0AB5oe6023442
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 11:05:52 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0F6A861B02
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 22:05:39 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 23671-06 for <selinux@tycho.nsa.gov>;
	Mon, 10 Jan 2005 22:05:38 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9F27761B00
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 22:05:38 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9BABBA4
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 22:05:37 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: kernel error
Date: Mon, 10 Jan 2005 22:05:36 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AGm4BMVHziGqmNk"
Message-Id: <200501102205.36386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_AGm4BMVHziGqmNk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am getting the attached kernel error repeatedly when trying to install a new 
kernel package on a Debian 2.6.10 system (stock kernel.org kernel with no 
patches).  This error happens in enforcing mode but not in permissive mode.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AGm4BMVHziGqmNk
Content-Type: text/x-log;
  charset="us-ascii";
  name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kern.log"

Jan 10 21:49:13 lyta kernel: audit(1105354153.069:0): avc:  denied  { getattr } for  pid=9350 exe=/bin/bash path=/root dev=md2 ino=206337 scontext=system_u:system_r:bootloader_t tcontext=root:object_r:sysadm_home_dir_t tclass=dir
Jan 10 21:49:13 lyta kernel: audit(1105354153.315:0): avc:  denied  { search } for  pid=9355 exe=/usr/bin/dpkg-query name=lib dev=dm-2 ino=517121 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:var_lib_t tclass=dir
Jan 10 21:49:16 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 10 21:49:16 lyta kernel:  [dump_stack+21/32] dump_stack+0x15/0x20
Jan 10 21:49:16 lyta kernel:  [sub_remove+234/240] sub_remove+0xea/0xf0
Jan 10 21:49:16 lyta kernel:  [idr_remove+27/144] idr_remove+0x1b/0x90
Jan 10 21:49:16 lyta kernel:  [release_dev+1587/1904] release_dev+0x633/0x770
Jan 10 21:49:16 lyta kernel:  [tty_release+18/32] tty_release+0x12/0x20
Jan 10 21:49:16 lyta kernel:  [__fput+295/320] __fput+0x127/0x140
Jan 10 21:49:16 lyta kernel:  [filp_close+70/112] filp_close+0x46/0x70
Jan 10 21:49:16 lyta kernel:  [sysenter_past_esp+82/121] sysenter_past_esp+0x52/0x79
Jan 10 21:49:17 lyta kernel: atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.

--Boundary-00=_AGm4BMVHziGqmNk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
