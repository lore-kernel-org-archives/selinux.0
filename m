Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NFlorT009988
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 11:47:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NFllUk021612
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 15:47:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E6D7F61B01
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 01:47:43 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13088-08 for <selinux@tycho.nsa.gov>;
	Fri, 24 Sep 2004 01:47:43 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9142361AFB
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 01:47:43 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 729E7B58CC
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 01:47:42 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: hald.te
Date: Fri, 24 Sep 2004 01:47:41 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dAvUBJ+Mk2Af85F"
Message-Id: <200409240147.41865.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_dAvUBJ+Mk2Af85F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes duplicate rules (also in hotplug.te).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_dAvUBJ+Mk2Af85F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-23 22:31:16.000000000 +1000
+++ domains/program/unused/hald.te	2004-09-24 01:47:04.000000000 +1000
@@ -50,9 +50,6 @@
 allow hald_t udev_tbl_t:file { getattr read };
 ')
 
-ifdef(`udev.te', `
-r_dir_file(hald_t, hotplug_etc_t)
-')
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
 allow hald_t usbfs_t:dir search;

--Boundary-00=_dAvUBJ+Mk2Af85F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
