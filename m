Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72K5Xb2022115
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:05:33 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72K5WM1000667
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:05:32 GMT
Date: Thu, 2 Aug 2007 16:03:43 -0400
Message-Id: <200708022003.l72K3hC5029678@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_filesystem changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

anon_inodefs file system
fusefs file system
pam_namespace will mount a tmpfs_t filesystem

--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2007-07-03 07:05:38.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/filesystem.if	2007-08-02 11:02:02.000000000 -0400
@@ -1192,6 +1192,24 @@
 
 ########################################
 ## <summary>
+##      unmount a FUSE filesystem.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`fs_unmount_fusefs',`
+        gen_require(`
+                type fusefs_t;
+        ')
+
+        allow $1 fusefs_t:filesystem unmount;
+')
+
+########################################
+## <summary>
 ##	Search inotifyfs filesystem. 
 ## </summary>
 ## <param name="domain">
@@ -2219,7 +2237,7 @@
 ##	Domain allowed access.
 ##	</summary>
 ## </param>
-#
+
 interface(`fs_dontaudit_read_ramfs_files',`
 	gen_require(`
 		type ramfs_t;
@@ -3476,3 +3494,42 @@
 	relabelfrom_blk_files_pattern($1,noxattrfs,noxattrfs)
 	relabelfrom_chr_files_pattern($1,noxattrfs,noxattrfs)
 ')
+
+########################################
+## <summary>
+##	Read files of anon_inodefs file system files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_read_anon_inodefs_files',`
+	gen_require(`
+		type anon_inodefs_t;
+
+	')
+
+	read_files_pattern($1,anon_inodefs_t,anon_inodefs_t)
+')
+
+########################################
+## <summary>
+##	Read/wrie files of anon_inodefs file system files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_rw_anon_inodefs_files',`
+	gen_require(`
+		type anon_inodefs_t;
+
+	')
+
+	rw_files_pattern($1,anon_inodefs_t,anon_inodefs_t)
+')
+
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2007-07-25 10:37:36.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/filesystem.te	2007-08-02 11:02:02.000000000 -0400
@@ -43,6 +43,12 @@
 #
 # Non-persistent/pseudo filesystems
 #
+
+type anon_inodefs_t;
+fs_type(anon_inodefs_t)
+files_mountpoint(anon_inodefs_t)
+genfscon anon_inodefs / gen_context(system_u:object_r:anon_inodefs_t,s0)
+
 type bdev_t;
 fs_type(bdev_t)
 genfscon bdev / gen_context(system_u:object_r:bdev_t,s0)
@@ -139,6 +145,7 @@
 fs_type(tmpfs_t)
 files_type(tmpfs_t)
 files_mountpoint(tmpfs_t)
+files_poly_parent(tmpfs_t)
 
 # Use a transition SID based on the allocating task SID and the
 # filesystem SID to label inodes in the following filesystem types,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
