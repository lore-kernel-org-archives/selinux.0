Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2MMrQx6027878
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 17:53:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2MMntlY020507
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 22:49:56 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2MMnqKX020504
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 22:49:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id E056ABF42
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:53:20 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09531-10
 for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:53:19 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 308B9BF41
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:53:19 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A80BF9253C
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 09:53:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6ED1F357
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 23:53:10 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Sat, 22 Mar 2003 23:53:09 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VlOf+mDs9RJ1Pw5"
Message-Id: <200303222353.09876.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_VlOf+mDs9RJ1Pw5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch to use readable_t for the timezone files.  It's a bit of 
an experimental patch, perhaps we should have a timezone_t instead.

I've attached a patch to make some file_type_auto_trans rules specific to the 
classes that they need to create.  This removes some access that isn't 
needed.  I think that this should be included in the CVS.

The file "general" contains a patch for the global macros, and a patch for the 
X server policy to tighten it down a lot.  This is also good for the CVS 
IMHO.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_VlOf+mDs9RJ1Pw5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="readable"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="readable"

diff -ru /tmp/policy/domains/program/init.te policy/domains/program/init.te
--- /tmp/policy/domains/program/init.te	2003-03-22 21:52:23.000000000 +0100
+++ policy/domains/program/init.te	2003-03-22 22:07:25.000000000 +0100
@@ -119,3 +119,8 @@
 
 # for initrd pivot_root seems to access this
 dontaudit init_t file_labels_t:dir { search };
+
+# Read directories and files with the readable_t type.
+# This type is a general type for "world"-readable files.
+allow domain readable_t:dir r_dir_perms;
+allow domain readable_t:notdevfile_class_set r_file_perms;
diff -ru /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2003-03-16 12:33:43.000000000 +0100
+++ policy/file_contexts/types.fc	2003-03-22 21:28:34.000000000 +0100
@@ -170,6 +171,7 @@
 /etc/security/selinux/src(/.*)?	system_u:object_r:policy_src_t
 /etc/security/default_context.*	system_u:object_r:default_context_t
 /etc/services			system_u:object_r:etc_t
+/etc/localtime			system_u:object_r:readable_t
 
 #
 # /lib
@@ -197,6 +200,7 @@
 # /usr
 #
 /usr(/.*)?			system_u:object_r:usr_t
+/usr/share/zoneinfo(/.*)?	system_u:object_r:readable_t
 /usr/etc(/.*)?			system_u:object_r:etc_t
 /usr/libexec(/.*)?		system_u:object_r:lib_t
 /usr/src(/.*)?			system_u:object_r:src_t

--Boundary-00=_VlOf+mDs9RJ1Pw5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="file_type"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="file_type"

diff -ru /tmp/policy/domains/program/fsadm.te policy/domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2003-02-12 13:36:05.000000000 +0100
+++ policy/domains/program/fsadm.te	2003-03-18 11:57:43.000000000 +0100
@@ -26,11 +26,11 @@
 # remount file system to apply changes
 allow fsadm_t fs_t:filesystem remount;
 
-# Use capabilities.
-allow fsadm_t fsadm_t:capability { sys_admin sys_rawio };
+# Use capabilities.  ipc_lock is for losetup
+allow fsadm_t self:capability { ipc_lock sys_rawio sys_admin };
 
 # Write to /etc/mtab.
-file_type_auto_trans(fsadm_t, etc_t, etc_runtime_t)
+file_type_auto_trans(fsadm_t, etc_t, etc_runtime_t, file)
 
 # Inherit and use descriptors from init.
 allow fsadm_t init_t:fd use;
diff -ru /tmp/policy/domains/program/init.te policy/domains/program/init.te
--- /tmp/policy/domains/program/init.te	2003-03-22 21:52:23.000000000 +0100
+++ policy/domains/program/init.te	2003-03-22 22:07:25.000000000 +0100
@@ -43,10 +43,10 @@
 ')
 
 # Create /dev/initctl.
-file_type_auto_trans(init_t, device_t, initctl_t)
+file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
 
 # Create ioctl.save.
-file_type_auto_trans(init_t, etc_t, etc_runtime_t)
+file_type_auto_trans(init_t, etc_t, etc_runtime_t, file)
 
 # Update /etc/ld.so.cache
 allow init_t ld_so_cache_t:file rw_file_perms;
diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2003-03-22 21:52:23.000000000 +0100
+++ policy/domains/program/initrc.te	2003-03-22 22:12:15.000000000 +0100
@@ -102,7 +102,7 @@
 allow initrc_t file_t:dir { read search getattr mounton };
 
 # Create runtime files in /etc, e.g. /etc/mtab, /etc/HOSTNAME.
-file_type_auto_trans(initrc_t, etc_t, etc_runtime_t)
+file_type_auto_trans(initrc_t, etc_t, etc_runtime_t, file)
 
 # Update /etc/ld.so.cache.
 allow initrc_t ld_so_cache_t:file rw_file_perms;
diff -ru /tmp/policy/domains/program/mount.te policy/domains/program/mount.te
--- /tmp/policy/domains/program/mount.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/mount.te	2003-03-18 11:57:37.000000000 +0100
@@ -20,7 +20,7 @@
 allow mount_t self:capability { ipc_lock dac_override };
 
 # Create and modify /etc/mtab.
-file_type_auto_trans(mount_t, etc_t, etc_runtime_t)
+file_type_auto_trans(mount_t, etc_t, etc_runtime_t, file)
 
 allow mount_t file_type:dir search;
 
diff -ru /tmp/policy/macros/program/mount_macros.te policy/macros/program/mount_macros.te
--- /tmp/policy/macros/program/mount_macros.te	2002-09-21 05:01:30.000000000 +0200
+++ policy/macros/program/mount_macros.te	2003-03-18 11:58:42.000000000 +0100
@@ -33,7 +33,7 @@
 allow $2_t self:capability { net_bind_service sys_rawio sys_admin };
 
 # Create and modify /etc/mtab.
-file_type_auto_trans($2_t, etc_t, etc_runtime_t)
+file_type_auto_trans($2_t, etc_t, etc_runtime_t, file)
 
 # Access the terminal.
 allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };

--Boundary-00=_VlOf+mDs9RJ1Pw5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="general"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="general"

diff -ru /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-03-22 21:52:43.000000000 +0100
+++ policy/macros/global_macros.te	2003-03-22 22:38:33.000000000 +0100
@@ -605,6 +620,11 @@
 allow $1 self:msgq rw_msgq_perms;
 allow $1 self:shm  rw_shm_perms;
 
+# Use descriptors created by login, sshd, or newrole.
+allow $1 privfd:fd use;
+
+# Use descriptors created by mount (e.g. NFS).
+allow $1 mount_t:fd use;
 ')
 
 #
diff -ru /tmp/policy/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2003-03-17 23:08:46.000000000 +0100
+++ policy/macros/program/xserver_macros.te	2003-03-07 17:53:53.000000000 +0100
@@ -48,10 +48,24 @@
 
 allow $1_xserver_t proc_t:dir search;
 
-# Use capabilities.  Access /dev/mem.  
-allow $1_xserver_t self:capability { setuid setgid sys_rawio sys_nice };
+# Use capabilities.
+# allow setuid/setgid for the wrapper program to change UID
+# sys_rawio is for iopl access - should not be needed for frame-buffer
+# sys_admin, locking shared mem?  chowning IPC message queues or semaphores?
+# admin of APM bios?
+# sys_nice is so that the X server can set a negative nice value
+allow $1_xserver_t self:capability { setuid setgid sys_rawio sys_admin sys_nice };
 dontaudit $1_xserver_t self:capability { dac_override dac_read_search };
+
+# memory_device_t access is needed if not using the frame buffer
+dontaudit $1_xserver_t memory_device_t:chr_file read;
 #allow $1_xserver_t memory_device_t:chr_file { rw_file_perms execute };
+# net_bind_service is needed if you want your X server to allow TCP connections
+# from other hosts, EG an XDM serving a network of X terms
+# if you want good security you do not want this
+# not sure why some people want chown, fsetid, and sys_tty_config.
+#allow $1_xserver_t self:capability { net_bind_service chown fsetid sys_tty_config };
+dontaudit $1_xserver_t self:capability chown;
 
 allow $1_xserver_t mtrr_device_t:file rw_file_perms;
 allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;

--Boundary-00=_VlOf+mDs9RJ1Pw5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
