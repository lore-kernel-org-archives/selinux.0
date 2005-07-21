Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6L0qfgA022084
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 20:52:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6L0m9Dg027713
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 00:48:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BF7FD61B00
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:48:10 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 11257-05 for <selinux@tycho.nsa.gov>;
	Thu, 21 Jul 2005 10:48:10 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5F43261AFE
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:48:10 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: restorecon policy
Date: Thu, 21 Jul 2005 10:48:05 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JDv3CKlr0DTlGcA"
Message-Id: <200507211048.09050.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_JDv3CKlr0DTlGcA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Currently the command "restorecon -R /" gives an unreasonably large number of 
error messages on the /proc and /sys file systems.  I don't think that it 
needs the access to the directories on those file systems and removing such 
access greatly reduces the number of messages.

The attached patch makes this change.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_JDv3CKlr0DTlGcA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="restorecon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="restorecon.diff"

--- domains/program/restorecon.te.orig	2005-07-21 10:45:02.000000000 +1000
+++ domains/program/restorecon.te	2005-07-21 10:45:16.000000000 +1000
@@ -49,7 +49,6 @@
 allow restorecon_t ptyfile:chr_file getattr;
 
 allow restorecon_t fs_t:filesystem getattr;
-allow restorecon_t fs_type:dir r_dir_perms;
 
 allow restorecon_t etc_runtime_t:file { getattr read };
 allow restorecon_t etc_t:file { getattr read };

--Boundary-00=_JDv3CKlr0DTlGcA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
