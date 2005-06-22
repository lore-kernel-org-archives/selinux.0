Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5M4P0gA013897
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 00:25:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5M4FPrk025873
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 04:15:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1EF6761B04
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 14:15:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00393-06 for <selinux@tycho.nsa.gov>;
	Wed, 22 Jun 2005 14:15:12 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AF3D061B01
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 14:15:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: mkfs.cramfs
Date: Wed, 22 Jun 2005 14:15:05 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OXOuCgGfufiIqOB"
Message-Id: <200506221415.10141.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_OXOuCgGfufiIqOB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch for fsadm.fc to make mkfs.cramfs not have fsadm_exec_t.  
It doesn't access block devices and is more like an archive utility than a 
regular mkfs program.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_OXOuCgGfufiIqOB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- fsadm.fc.orig	2005-06-22 14:12:25.000000000 +1000
+++ fsadm.fc	2005-06-22 14:12:44.000000000 +1000
@@ -1,6 +1,7 @@
 # fs admin utilities
 /sbin/fsck.*		--	system_u:object_r:fsadm_exec_t
 /sbin/mkfs.*		--	system_u:object_r:fsadm_exec_t
+/sbin/mkfs\.cramfs	--	system_u:object_r:sbin_t
 /sbin/e2fsck		--	system_u:object_r:fsadm_exec_t
 /sbin/mkdosfs		--	system_u:object_r:fsadm_exec_t
 /sbin/dosfsck		--	system_u:object_r:fsadm_exec_t

--Boundary-00=_OXOuCgGfufiIqOB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
