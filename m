Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NHbCrT011136
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 13:37:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NHb5Uk025839
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 17:37:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patches needed for Fedora
Date: Fri, 24 Sep 2004 03:37:03 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/mwUBsC74Ikql4m"
Message-Id: <200409240337.03210.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_/mwUBsC74Ikql4m
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows domains that run before a tmpfs /dev is labelled 
correctly to access tmpfs_t:chr_file and tmpfs_t:dir for Fedora.

For all systems I allow initrc_t to access usbfs_t.  It's necessary right now 
on Fedora and probably will be on other systems in the near future.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_/mwUBsC74Ikql4m
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/hotplug.te	2004-09-23 22:31:16.000000000 +1000
+++ domains/program/unused/hotplug.te	2004-09-24 02:01:03.000000000 +1000
@@ -47,6 +47,9 @@
 ifdef(`distro_redhat', `
 # for arping used for static IP addresses on PCMCIA ethernet
 domain_auto_trans(hotplug_t, netutils_exec_t, netutils_t)
+
+allow hotplug_t tmpfs_t:dir search;
+allow hotplug_t tmpfs_t:chr_file rw_file_perms;
 ')dnl end if distro_redhat
 ')dnl end if netutils.te
 
--- /usr/src/se/policy/domains/program/hostname.te	2004-09-23 22:31:14.000000000 +1000
+++ domains/program/hostname.te	2004-09-24 02:14:54.000000000 +1000
@@ -22,4 +22,7 @@
 
 # for when /usr is not mounted
 dontaudit hostname_t file_t:dir search;
-dontaudit hostname_t tmpfs_t:chr_file { read write };
+
+ifdef(`distro_redhat', `
+allow hostname_t tmpfs_t:chr_file rw_file_perms;
+')
--- /usr/src/se/policy/domains/program/mount.te	2004-09-15 16:31:21.000000000 +1000
+++ domains/program/mount.te	2004-09-24 02:18:00.000000000 +1000
@@ -97,6 +97,6 @@
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
-dontaudit mount_t tmpfs_t:chr_file { read write };
+allow mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir { mounton };
 ')
--- /usr/src/se/policy/domains/program/initrc.te	2004-09-21 14:39:14.000000000 +1000
+++ domains/program/initrc.te	2004-09-24 03:28:47.000000000 +1000
@@ -48,6 +48,8 @@
 allow initrc_t usbdevfs_t:dir r_dir_perms;
 allow initrc_t usbdevfs_t:lnk_file r_file_perms;
 allow initrc_t usbdevfs_t:file getattr;
+allow initrc_t usbfs_t:dir r_dir_perms;
+allow initrc_t usbfs_t:file getattr;
 
 # allow initrc to fork and renice itself
 allow initrc_t self:process { fork sigchld setsched setpgid setrlimit };
@@ -199,6 +201,9 @@
 allow initrc_t boot_t:lnk_file rw_file_perms;
 file_type_auto_trans(initrc_t, boot_t, boot_runtime_t, file)
 
+allow initrc_t tmpfs_t:chr_file rw_file_perms;
+allow initrc_t tmpfs_t:dir r_dir_perms;
+
 #
 # readahead asks for these
 #

--Boundary-00=_/mwUBsC74Ikql4m--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
