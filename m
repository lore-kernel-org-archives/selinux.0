Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7FMbCOb008702
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 18:37:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7FMSGdf011145
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 22:28:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A8F2C61AF1
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2005 08:28:12 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12223-01 for <selinux@tycho.nsa.gov>;
	Tue, 16 Aug 2005 08:28:12 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 31B4861AF0
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2005 08:28:12 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9BE1F44
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2005 08:28:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: syslinux
Date: Tue, 16 Aug 2005 08:28:07 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7bRADFeVVMfsXKA"
Message-Id: <200508160828.11139.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_7bRADFeVVMfsXKA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to run syslinux on a strict system.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_7bRADFeVVMfsXKA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- file_contexts/program/fsadm.fc.orig	2005-08-15 21:49:56.000000000 +1000
+++ file_contexts/program/fsadm.fc	2005-08-15 21:50:18.000000000 +1000
@@ -37,3 +37,4 @@
 /sbin/partx		--	system_u:object_r:fsadm_exec_t
 /usr/bin/partition_uuid	--	system_u:object_r:fsadm_exec_t
 /sbin/partprobe		--	system_u:object_r:fsadm_exec_t
+/usr/bin/syslinux	--	system_u:object_r:fsadm_exec_t

--Boundary-00=_7bRADFeVVMfsXKA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
