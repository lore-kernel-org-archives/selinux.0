Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P4KnrT002926
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 00:20:49 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P4KkuQ028639
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 04:20:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E27EF61AFB
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:20:45 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26843-01 for <selinux@tycho.nsa.gov>;
	Wed, 25 Aug 2004 14:20:45 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6B69A61AFA
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:20:45 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 130D6B5889
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:20:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: hotplug policy
Date: Wed, 25 Aug 2004 14:20:42 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aOBLBpFE2w1UH4k"
Message-Id: <200408251420.42612.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_aOBLBpFE2w1UH4k
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against the latest CVS to make the rawhide hotplug work, 
talk to hald, and support static IP addresses on Fedora.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_aOBLBpFE2w1UH4k
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hotplug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hotplug.diff"

--- /usr/src/se/policy/domains/program/unused/hotplug.te	2004-08-25 13:21:22.000000000 +1000
+++ domains/program/unused/hotplug.te	2004-08-25 14:19:23.000000000 +1000
@@ -17,14 +17,13 @@
 ')
 
 etcdir_domain(hotplug)
-typealias hotplug_etc_t alias etc_hotplug_t;
 
 allow hotplug_t self:fifo_file { read write getattr ioctl };
 allow hotplug_t self:unix_dgram_socket create_socket_perms;
 allow hotplug_t self:unix_stream_socket create_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 
-allow hotplug_t sysctl_net_t:dir search;
+allow hotplug_t sysctl_net_t:dir r_dir_perms;
 allow hotplug_t sysctl_net_t:file { getattr read };
 
 # get info from /proc
@@ -43,12 +42,16 @@
 allow hotplug_t { bin_t sbin_t }:dir search;
 allow hotplug_t { bin_t sbin_t }:lnk_file read;
 can_exec(hotplug_t, { hotplug_exec_t bin_t sbin_t ls_exec_t shell_exec_t hotplug_etc_t etc_t })
-ifdef(`hostname.te', `
-can_exec(hotplug_t, hostname_exec_t)
-')
+ifdef(`hostname.te', `can_exec(hotplug_t, hostname_exec_t)')
+ifdef(`netutils.te', `
+ifdef(`distro_redhat', `
+# for arping used for static IP addresses on PCMCIA ethernet
+domain_auto_trans(hotplug_t, netutils_exec_t, netutils_t)
+')dnl end if distro_redhat
+')dnl end if netutils.te
 
 allow initrc_t usbdevfs_t:file { getattr read ioctl };
-allow initrc_t modules_dep_t:file { getattr read };
+allow initrc_t modules_dep_t:file { getattr read ioctl };
 r_dir_file(hotplug_t, usbdevfs_t)
 allow hotplug_t usbfs_t:dir r_dir_perms;
 allow hotplug_t usbfs_t:file { getattr read };
@@ -64,6 +67,10 @@
 allow hotplug_t var_lock_t:file getattr;
 ')
 
+ifdef(`hald.te', `
+allow hotplug_t hald_t:unix_dgram_socket sendto;
+')
+
 # for killall
 allow hotplug_t self:process { getsession getattr };
 allow hotplug_t self:file getattr;
@@ -129,8 +136,7 @@
 allow hotplug_t sound_device_t:chr_file { setattr };
 
 ifdef(`udev.te', `
-domain_auto_trans(hotplug_t, udev_exec_t, udev_t)
-domain_auto_trans(hotplug_t, udev_helper_exec_t, udev_t)
+domain_auto_trans(hotplug_t, { udev_exec_t udev_helper_exec_t }, udev_t)
 ')
 
 file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
@@ -143,7 +149,7 @@
 domain_auto_trans(hotplug_t, sendmail_exec_t, system_mail_t) 
 ')
 
-allow restorecon_t hotplug_t:fd { use };
+allow restorecon_t hotplug_t:fd use;
 
 ifdef(`unlimitedUtils', `
 unconfined_domain(hotplug_t) 

--Boundary-00=_aOBLBpFE2w1UH4k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
