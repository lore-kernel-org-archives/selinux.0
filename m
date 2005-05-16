Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4GDuXgA019385
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 09:56:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4GDrAge013331
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 13:53:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2285661AEC
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 10:47:07 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01277-05 for <selinux@tycho.nsa.gov>;
	Mon, 16 May 2005 10:47:06 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B135161AEB
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 10:47:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: bluetooth policy patch
Date: Mon, 16 May 2005 23:53:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EXKiC+XLKM/S+SJ"
Message-Id: <200505162353.08139.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_EXKiC+XLKM/S+SJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

/var/run/sdp is a Unix domain socket not a regular file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_EXKiC+XLKM/S+SJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- file_contexts/program/bluetooth.fc.orig	2005-05-16 23:51:18.000000000 +1000
+++ file_contexts/program/bluetooth.fc	2005-05-16 23:51:27.000000000 +1000
@@ -4,4 +4,4 @@
 /usr/sbin/hcid		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/sdpd		--	system_u:object_r:bluetooth_exec_t
 /usr/sbin/hciattach	--	system_u:object_r:bluetooth_exec_t
-/var/run/sdp		--	system_u:object_r:bluetooth_var_run_t
+/var/run/sdp		-s	system_u:object_r:bluetooth_var_run_t

--Boundary-00=_EXKiC+XLKM/S+SJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
