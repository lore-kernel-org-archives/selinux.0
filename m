Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N6QRgA024153
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:26:27 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N6GfNa028351
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 06:16:42 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5D86C61B02
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:16:41 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03215-04 for <selinux@tycho.nsa.gov>;
	Thu, 23 Jun 2005 16:16:41 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EE1E661B01
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:16:40 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 0FE8F37
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:16:40 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: base_user_macros.te
Date: Thu, 23 Jun 2005 16:16:37 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HPluCfTsJQkI527"
Message-Id: <200506231616.39812.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_HPluCfTsJQkI527
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch reverts a mistake made in a recent change to the 
base_user_macros.te.

Although it's widely regarded that writing non-random data to /dev/random can 
not decrease the entropy available I think it's best to not allow 
unprivileged processes to perform such writes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HPluCfTsJQkI527
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/base_user_macros.te.orig	2005-06-23 16:14:35.000000000 +1000
+++ macros/base_user_macros.te	2005-06-23 16:14:45.000000000 +1000
@@ -358,7 +358,7 @@
 allow $1_t devtty_t:chr_file rw_file_perms;
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t zero_device_t:chr_file { rw_file_perms execute };
-allow $1_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
+allow $1_t { random_device_t urandom_device_t }:chr_file { getattr read ioctl };
 #
 # Added to allow reading of cdrom
 #

--Boundary-00=_HPluCfTsJQkI527--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
