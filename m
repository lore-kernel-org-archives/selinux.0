Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8L5QgrT022600
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 01:26:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8L5QepT024791
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 05:26:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3B00E61B01
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 15:26:40 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21281-01 for <selinux@tycho.nsa.gov>;
	Tue, 21 Sep 2004 15:26:39 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C5F5F61B00
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 15:26:39 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8CE6DB58DC
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 15:26:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file.te and tmpfs
Date: Tue, 21 Sep 2004 15:26:37 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Nu7TBxa5hy2rjwH"
Message-Id: <200409211526.37810.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Nu7TBxa5hy2rjwH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for correct tty labelling on Fedora.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Nu7TBxa5hy2rjwH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/types/file.te	2004-09-15 16:31:24.000000000 +1000
+++ types/file.te	2004-09-21 15:20:10.000000000 +1000
@@ -259,7 +259,7 @@
 #
 allow { file_type device_type } fs_t:filesystem associate;
 ifdef(`distro_redhat', `
-allow dev_fs tmpfs_t:filesystem associate;
+allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
 ')
 
 # Allow the pty to be associated with the file system.

--Boundary-00=_Nu7TBxa5hy2rjwH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
