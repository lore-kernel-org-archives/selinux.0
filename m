Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJYctT006623
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:34:38 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJYaU1004007
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:34:36 GMT
Message-ID: <46042BC6.8060705@redhat.com>
Date: Fri, 23 Mar 2007 15:34:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: fusermount policy
Content-Type: multipart/mixed;
 boundary="------------030106020803070406060304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030106020803070406060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is also used to add support for ntfs-3g from previous patch.

--------------030106020803070406060304
Content-Type: text/x-patch;
 name="fusermount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fusermount.patch"

--- nsaserefpolicy/policy/modules/system/fusermount.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/fusermount.fc	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,6 @@
+# fusermount executable will have:
+# label: system_u:object_r:fusermount_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/bin/fusermount		--	gen_context(system_u:object_r:fusermount_exec_t,s0)
--- nsaserefpolicy/policy/modules/system/fusermount.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/fusermount.if	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,41 @@
+## <summary>policy for fusermount</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run fusermount.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`fusermount_domtrans',`
+	gen_require(`
+		type fusermount_t, fusermount_exec_t;
+	')
+
+	domain_auto_trans($1,fusermount_exec_t,fusermount_t)
+
+	allow fusermount_t $1:fd use;
+	allow fusermount_t $1:fifo_file rw_file_perms;
+	allow fusermount_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Inherit and use file descriptors from fusermount.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fusermount_use_fds',`
+	gen_require(`
+		type fusermount_t;
+	')
+
+	allow $1 fusermount_t:fd use;
+')
\ No newline at end of file
--- nsaserefpolicy/policy/modules/system/fusermount.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/fusermount.te	2007-03-22 15:06:59.000000000 -0400
@@ -0,0 +1,44 @@
+policy_module(fusermount,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type fusermount_t;
+type fusermount_exec_t;
+application_domain(fusermount_t, fusermount_exec_t)
+role system_r types fusermount_t;
+
+########################################
+#
+# fusermount local policy
+#
+allow fusermount_t self:capability sys_admin;
+allow fusermount_t self:fifo_file { read write };
+allow fusermount_t self:unix_stream_socket create_stream_socket_perms;
+
+files_read_etc_files(fusermount_t)
+
+libs_use_ld_so(fusermount_t)
+libs_use_shared_libs(fusermount_t)
+
+miscfiles_read_localization(fusermount_t)
+
+files_manage_etc_runtime_files(fusermount_t)
+files_etc_filetrans_etc_runtime(fusermount_t,file)
+files_mounton_all_mountpoints(fusermount_t)
+
+fs_mount_fusefs(fusermount_t)
+
+storage_raw_read_fixed_disk(fusermount_t)
+storage_raw_write_fixed_disk(fusermount_t)
+
+optional_policy(`
+	mount_ntfs_rw_stream_sockets(fusermount_t)
+')
+
+ifdef(`targeted_policy',`
+	term_use_generic_ptys(fusermount_t)
+')
+
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/kernel/filesystem.if	2007-03-22 15:06:58.000000000 -0400
@@ -1110,11 +1110,31 @@
 		type dosfs_t;
 	')
 
+	manage_dirs_pattern($1,dosfs_t,dosfs_t)
 	manage_files_pattern($1,dosfs_t,dosfs_t)
 ')
 
 ########################################
 ## <summary>
+##	read files
+##	on a DOS filesystem.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_read_dos_files',`
+	gen_require(`
+		type dosfs_t;
+	')
+
+	read_files_pattern($1,dosfs_t,dosfs_t)
+')
+
+########################################
+## <summary>
 ##	Read eventpollfs files.
 ## </summary>
 ## <desc>
@@ -3402,3 +3422,22 @@
 	relabelfrom_blk_files_pattern($1,noxattrfs,noxattrfs)
 	relabelfrom_chr_files_pattern($1,noxattrfs,noxattrfs)
 ')
+
+
+########################################
+## <summary>
+##      Mount an fuse filesystem.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`fs_mount_fusefs',`
+        gen_require(`
+                type fusefs_t;
+        ')
+
+        allow $1 fusefs_t:filesystem mount;
+')
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/kernel/filesystem.te	2007-03-22 15:06:58.000000000 -0400
@@ -65,6 +65,11 @@
 # change to task SID 20060628
 #genfscon eventpollfs / gen_context(system_u:object_r:eventpollfs_t,s0)
 
+type fusefs_t;
+fs_type(fusefs_t)
+allow fusefs_t self:filesystem associate;
+genfscon fuse / gen_context(system_u:object_r:fusefs_t,s0)
+
 type futexfs_t;
 fs_type(futexfs_t)
 genfscon futexfs / gen_context(system_u:object_r:futexfs_t,s0)

--------------030106020803070406060304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
