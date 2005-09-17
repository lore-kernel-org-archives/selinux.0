Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8HD4TNs005023
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 09:04:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8HD0pMi020911
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 13:00:52 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 671E261B01
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 23:00:57 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00517-03 for <selinux@tycho.nsa.gov>;
	Sat, 17 Sep 2005 23:00:57 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 06F2161B00
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 23:00:57 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 34EC137
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 23:00:56 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: cdrecord policy patch
Date: Sat, 17 Sep 2005 23:00:50 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HOBLD2sPDwfNW+/"
Message-Id: <200509172300.55965.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_HOBLD2sPDwfNW+/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow cdrecord to work on a nfs home 
directory.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HOBLD2sPDwfNW+/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cdrecord.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cdrecord.diff"

--- macros/program/cdrecord_macros.te.orig	2005-09-17 12:56:21.000000000 +1000
+++ macros/program/cdrecord_macros.te	2005-09-17 22:41:00.000000000 +1000
@@ -45,5 +45,9 @@
 allow $1_cdrecord_t $1_home_t:dir search;
 allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
 allow $1_cdrecord_t $1_home_t:file r_file_perms;
+if (use_nfs_home_dirs) {
+allow $1_cdrecord_t mnt_t:dir search;
+r_dir_file($1_cdrecord_t, nfs_t)
+}
 ')
 

--Boundary-00=_HOBLD2sPDwfNW+/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
