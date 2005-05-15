Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4F6q0gA012023
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 02:52:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4F6moiA003978
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 06:48:51 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 523BA61AEC
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 04:03:02 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07162-05 for <selinux@tycho.nsa.gov>;
	Sun, 15 May 2005 04:03:02 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DFE7361AEB
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 04:03:01 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: initrc.fc patch
Date: Sun, 15 May 2005 16:48:43 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PDvhC38+hxFmN2T"
Message-Id: <200505151648.47359.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_PDvhC38+hxFmN2T
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch stops an audit message when relabeling a system to the 
strict policy.  It doesn't change the operation of anything, but removing 
spurious error messages is always a good thing.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_PDvhC38+hxFmN2T
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- file_contexts/program/initrc.fc.orig	2005-05-15 16:46:36.000000000 +1000
+++ file_contexts/program/initrc.fc	2005-05-15 16:46:52.000000000 +1000
@@ -39,4 +39,5 @@
 ifdef(`distro_redhat', `
 /halt			--	system_u:object_r:etc_runtime_t
 /\.autofsck		--	system_u:object_r:etc_runtime_t
+/\.autorelabel		--	system_u:object_r:etc_runtime_t
 ')

--Boundary-00=_PDvhC38+hxFmN2T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
