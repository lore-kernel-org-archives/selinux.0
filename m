Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N6RrgA024176
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:27:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N6I7Na028359
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 06:18:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 66CFE61B02
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:18:07 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03456-02 for <selinux@tycho.nsa.gov>;
	Thu, 23 Jun 2005 16:18:07 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1120361B01
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:18:07 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 28FC337
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:18:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: local_login_t and btmp
Date: Thu, 23 Jun 2005 16:18:02 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dQluC0FjHTAEUcp"
Message-Id: <200506231618.05959.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_dQluC0FjHTAEUcp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows /bin/login to lock the /var/log/btmp file before 
writing to it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_dQluC0FjHTAEUcp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/login.te.orig	2005-06-23 12:18:35.000000000 +1000
+++ domains/program/login.te	2005-06-23 12:18:37.000000000 +1000
@@ -111,7 +111,7 @@
 allow $1_login_t lastlog_t:file rw_file_perms;
 
 # Write to /var/log/btmp
-allow $1_login_t faillog_t:file { append read write };
+allow $1_login_t faillog_t:file { lock append read write };
 
 # Search for mail spool file.
 allow $1_login_t mail_spool_t:dir r_dir_perms;

--Boundary-00=_dQluC0FjHTAEUcp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
