Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B7jwrT026630
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 03:45:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6B7jsSC016561
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 07:45:55 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8AC9F61C9D
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:45:54 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16597-01 for <selinux@tycho.nsa.gov>;
	Sun, 11 Jul 2004 17:45:54 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1B3C461BD2
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:45:54 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 09BE0B5A98
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:45:52 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: init.te
Date: Sun, 11 Jul 2004 17:45:51 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vAP8Alewt2uIzbX"
Message-Id: <200407111745.51356.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_vAP8Alewt2uIzbX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There should never be a sock_file or fifo_file object labelled as sbin_t or 
bin_t, so there is no benefit in granting init_t such access.

I can't think of any reason for granting init_t access to exec_type (except 
possibly a gross error in some other part of policy), and booting a rawhide 
machine without such access does not give any audit messages.

I have drastically reduced the access of init_t to sbin_t, bin_t, and removed 
access to exec_type, the patch is attached.

Steve, please put this in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_vAP8Alewt2uIzbX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="init.diff"

diff -ru /usr/src/se/policy/domains/program/init.te ./domains/program/init.te
--- /usr/src/se/policy/domains/program/init.te	2004-06-17 15:10:38.000000000 +1000
+++ ./domains/program/init.te	2004-07-11 17:37:09.000000000 +1000
@@ -70,11 +70,8 @@
 allow init_t self:fifo_file rw_file_perms;
 
 # Permissions required for system startup
-allow init_t bin_t:dir { read getattr lock search ioctl };
-allow init_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
-allow init_t exec_type:{ file lnk_file } { read getattr lock ioctl };
-allow init_t sbin_t:dir { read getattr lock search ioctl };
-allow init_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
+allow init_t { bin_t sbin_t }:dir r_dir_perms;
+allow init_t { bin_t sbin_t }:{ file lnk_file } { read getattr lock ioctl };
 
 # allow init to fork
 allow init_t self:process { fork sigchld };
@@ -136,4 +133,4 @@
 ')
 r_dir_file(init_t, sysfs_t)
 
-r_dir_file( init_t, selinux_config_t)
+r_dir_file(init_t, selinux_config_t)

--Boundary-00=_vAP8Alewt2uIzbX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
