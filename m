Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i683JPrT010460
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 23:19:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i683JLaX019438
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 03:19:23 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CF51F61BD2
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 13:19:08 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26072-01 for <selinux@tycho.nsa.gov>;
	Thu, 8 Jul 2004 13:19:08 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 688C761BB4
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 13:19:08 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 03C85B59AD
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 13:19:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy to allow upgrade of nfs-utils
Date: Thu, 8 Jul 2004 13:19:05 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p0L7AycpKw7hrNi"
Message-Id: <200407081319.05138.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_p0L7AycpKw7hrNi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached policy patch is needed to allow nfs-utils to be upgraded to the 
latest version on a rawhide system.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_p0L7AycpKw7hrNi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy/domains/program/unused/rpcd.te ./domains/program/unused/rpcd.te
--- policy/domains/program/unused/rpcd.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/rpcd.te	2004-07-08 13:15:55.000000000 +1000
@@ -51,6 +51,8 @@
 
 ifdef(`rpm.te', `
 allow rpcd_t self:capability { chown dac_override setgid setuid };
+# for /etc/rc.d/init.d/nfs to create /etc/exports
+allow initrc_t etc_t:file rw_file_perms;
 ')
 
 allow rpcd_t self:file { getattr read };
diff -ru policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
--- policy/domains/program/unused/rpm.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/rpm.te	2004-07-08 13:11:32.000000000 +1000
@@ -69,6 +69,9 @@
 # for a bug in rm
 dontaudit initrc_t pidfile:file write;
 
+# bash tries to access a block device in the initrd
+dontaudit initrc_t unlabeled_t:blk_file getattr;
+
 # bash tries ioctl for some reason
 dontaudit initrc_t pidfile:file ioctl;
 
@@ -93,7 +96,9 @@
 allow rpm_t sysfs_t:filesystem getattr;
 allow rpm_t tmpfs_t:filesystem getattr;
 dontaudit rpm_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
-allow rpm_t fs_type:dir getattr;
+# needs rw permission to the directory for an rpm package that includes a mount
+# point
+allow rpm_t fs_type:dir { setattr rw_dir_perms };
 allow rpm_t fs_type:filesystem getattr;
 
 # allow compiling and loading new policy

--Boundary-00=_p0L7AycpKw7hrNi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
