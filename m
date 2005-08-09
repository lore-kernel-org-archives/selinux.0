Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7986NOb021067
	for <selinux@tycho.nsa.gov>; Tue, 9 Aug 2005 04:06:23 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j797vcXY027576
	for <selinux@tycho.nsa.gov>; Tue, 9 Aug 2005 07:57:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6B2F061B0A
	for <selinux@tycho.nsa.gov>; Tue,  9 Aug 2005 17:58:36 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01387-04 for <selinux@tycho.nsa.gov>;
	Tue, 9 Aug 2005 17:58:36 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0166361B09
	for <selinux@tycho.nsa.gov>; Tue,  9 Aug 2005 17:58:35 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: lvm.te patch
Date: Tue, 9 Aug 2005 17:58:30 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qIG+C0+A5/WPY5X"
Message-Id: <200508091758.34774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_qIG+C0+A5/WPY5X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached policy patch is needed for creating a new LV with lvcreate.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_qIG+C0+A5/WPY5X
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/lvm.te.orig	2005-08-09 17:57:25.000000000 +1000
+++ domains/program/lvm.te	2005-08-09 17:57:43.000000000 +1000
@@ -64,7 +64,7 @@
 allow lvm_t { random_device_t urandom_device_t }:chr_file { getattr read ioctl };
 
 # DAC overrides and mknod for modifying /dev entries (vgmknodes)
-allow lvm_t self:capability { dac_override ipc_lock sys_admin sys_nice sys_resource mknod };
+allow lvm_t self:capability { chown dac_override ipc_lock sys_admin sys_nice sys_resource mknod };
 
 # Write to /etc/lvm, /etc/lvmtab, /etc/lvmtab.d
 file_type_auto_trans(lvm_t, { etc_t lvm_etc_t }, lvm_metadata_t, file)

--Boundary-00=_qIG+C0+A5/WPY5X--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
