Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3I2Jf7C009014
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 22:19:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3I2CVRD012257
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 02:12:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4FB2861AEE
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 10:59:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16849-02 for <selinux@tycho.nsa.gov>;
	Mon, 18 Apr 2005 10:59:12 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A6B5761AED
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 10:59:12 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id EF39027102
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 12:13:48 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: postgrey policy
Date: Mon, 18 Apr 2005 12:13:45 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bfxYCWooA2R59d0"
Message-Id: <200504181213.47787.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_bfxYCWooA2R59d0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows the latest version of postgrey to do what it wants.  
It can work without getattr access to { bin_t sbin_t }:dir but there seems no 
harm in granting it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bfxYCWooA2R59d0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- postgrey.te.old	2005-04-18 12:11:10.000000000 +1000
+++ postgrey.te	2005-04-18 12:12:04.000000000 +1000
@@ -10,7 +10,7 @@
 allow postgrey_t urandom_device_t:chr_file { getattr read };
 
 # for perl
-allow postgrey_t sbin_t:dir search;
+allow postgrey_t { bin_t sbin_t }:dir { getattr search };
 allow postgrey_t usr_t:{ file lnk_file } { getattr read };
 dontaudit postgrey_t usr_t:file ioctl;
 

--Boundary-00=_bfxYCWooA2R59d0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
