Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9G9SArT011809
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 05:28:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9G9Qui9010043
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 09:26:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 07CAA627BB
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 19:28:04 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29465-10 for <selinux@tycho.nsa.gov>;
	Sat, 16 Oct 2004 19:28:03 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 982D361E02
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 19:28:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 68661B5AB3
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 19:28:01 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: insmod
Date: Sat, 16 Oct 2004 19:28:00 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gmOcBsw7ytVk3ZT"
Message-Id: <200410161928.00867.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_gmOcBsw7ytVk3ZT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It seems that we can't get insmod changed to not open the module read/write 
for locking, so the attached patch permits this access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_gmOcBsw7ytVk3ZT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/modutil.te	2004-09-21 14:39:14.000000000 +1000
+++ domains/program/modutil.te	2004-10-16 19:16:43.000000000 +1000
@@ -107,6 +108,8 @@
 
 # Read module objects.
 r_dir_file(insmod_t, modules_object_t)
+# for locking
+allow insmod_t modules_object_t:file write;
 
 allow insmod_t { var_t var_log_t }:dir search;
 ifdef(`xserver.te', `

--Boundary-00=_gmOcBsw7ytVk3ZT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
