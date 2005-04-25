Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3P73JgA028854
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 03:03:19 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3P6srYj024620
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 06:54:55 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E842261AD8
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 16:56:14 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06520-05 for <selinux@tycho.nsa.gov>;
	Mon, 25 Apr 2005 16:56:14 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 694F761AD7
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 16:56:14 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: cdrecord policy patch
Date: Mon, 25 Apr 2005 16:56:27 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eSJbCv+SE3V1Sk4"
Message-Id: <200504251656.30648.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_eSJbCv+SE3V1Sk4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is necessary for cdrecord to search for drives.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_eSJbCv+SE3V1Sk4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cdrecord.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cdrecord.diff"

--- macros/program/cdrecord_macros.te.orig	2005-04-25 16:53:12.000000000 +1000
+++ macros/program/cdrecord_macros.te	2005-04-25 16:53:23.000000000 +1000
@@ -40,7 +40,7 @@
 allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
-allow $1_cdrecord_t device_t:dir { getattr search };
+allow $1_cdrecord_t device_t:dir r_dir_perms;
 allow $1_cdrecord_t device_t:lnk_file { getattr read };
 
 # allow cdrecord to write the CD

--Boundary-00=_eSJbCv+SE3V1Sk4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
