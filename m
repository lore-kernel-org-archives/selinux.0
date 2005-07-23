Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6NASOgA012600
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2005 06:28:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6NANRfL004430
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2005 10:23:29 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EB65E61B01
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2005 20:23:11 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21504-01 for <selinux@tycho.nsa.gov>;
	Sat, 23 Jul 2005 20:23:11 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8129A61B00
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2005 20:23:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: kudzu.fc
Date: Sat, 23 Jul 2005 20:23:02 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mqh4CRO0gaXPn9D"
Message-Id: <200507232023.08031.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Mqh4CRO0gaXPn9D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for a file that kudzu creates.

Do we know what other files it may create?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Mqh4CRO0gaXPn9D
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kudzu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kudzu.diff"

--- file_contexts/program/kudzu.fc.orig	2005-07-23 20:03:22.000000000 +1000
+++ file_contexts/program/kudzu.fc	2005-07-23 20:03:39.000000000 +1000
@@ -1,3 +1,4 @@
 # kudzu
 /usr/sbin/kudzu	--	system_u:object_r:kudzu_exec_t
 /sbin/kmodule	--	system_u:object_r:kudzu_exec_t
+/var/run/Xconfig --	root:object_r:kudzu_var_run_t

--Boundary-00=_Mqh4CRO0gaXPn9D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
