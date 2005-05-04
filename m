Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j44BB4gA003028
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 07:11:04 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j44B9aZx019000
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 11:09:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0379A61AE1
	for <selinux@tycho.nsa.gov>; Wed,  4 May 2005 19:11:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12519-08 for <selinux@tycho.nsa.gov>;
	Wed, 4 May 2005 19:11:12 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8F57C61ADF
	for <selinux@tycho.nsa.gov>; Wed,  4 May 2005 19:11:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: restorecon policy
Date: Wed, 4 May 2005 21:09:37 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_11KeCDwq6OxwQ4P"
Message-Id: <200505042109.41109.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_11KeCDwq6OxwQ4P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed by rawhide running with the strict policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_11KeCDwq6OxwQ4P
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/restorecon.te.orig	2005-05-04 21:07:58.000000000 +1000
+++ domains/program/restorecon.te	2005-05-04 21:08:19.000000000 +1000
@@ -20,7 +20,7 @@
 role secadm_r types restorecon_t;
 
 allow restorecon_t initrc_devpts_t:chr_file { read write ioctl };
-allow restorecon_t { tty_device_t admin_tty_type }:chr_file { read write ioctl };
+allow restorecon_t { tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
 
 domain_auto_trans({ initrc_t sysadm_t secadm_t }, restorecon_exec_t, restorecon_t)
 allow restorecon_t { userdomain init_t privfd }:fd use;

--Boundary-00=_11KeCDwq6OxwQ4P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
