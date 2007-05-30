Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHajZh013485
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:45 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHahue002767
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 08:45:28 -0400
Message-Id: <200705301245.l4UCjSWP003416@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Many fixes to get xen working - Diff off of strict-targeted-merge-2266 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/system/xen.if	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/xen.if	2007-05-30 07:35:54.000000000 -0400
@@ -72,12 +72,35 @@
 	')
 
 	logging_search_logs($1)
+	allow $1 xend_var_log_t:dir search_dir_perms;
 	allow $1 xend_var_log_t:file { getattr append };
 	dontaudit $1 xend_var_log_t:file write;
 ')
 
 ########################################
 ## <summary>
+##	Allow the specified domain to manage
+##	xend log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`xen_manage_log',`
+	gen_require(`
+		type var_log_t, xend_var_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 xend_var_log_t:dir create_dir_perms;
+	allow $1 xend_var_log_t:file create_file_perms;
+	dontaudit $1 xend_var_log_t:file write;
+')
+
+########################################
+## <summary>
 ##	Do not audit attempts to read and write
 ##	Xen unix domain stream sockets.  These
 ##	are leaked file descriptors.
@@ -151,3 +174,25 @@
 
 	domtrans_pattern($1,xm_exec_t,xm_t)
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to read
+##	xend image files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`xen_read_image_files',`
+	gen_require(`
+		type xen_image_t, xend_var_lib_t;
+	')
+
+	files_list_var_lib($1)
+	allow $1 xend_var_lib_t:dir search_dir_perms;
+	read_files_pattern($1,xen_image_t,xen_image_t)
+')
+
--- nsaserefpolicy/policy/modules/system/xen.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/xen.te	2007-05-30 07:35:54.000000000 -0400
@@ -25,6 +25,10 @@
 domain_type(xend_t)
 init_daemon_domain(xend_t, xend_exec_t)
 
+# tmp files
+type xend_tmp_t;
+files_tmp_file(xend_tmp_t)
+
 # var/lib files
 type xend_var_lib_t;
 files_type(xend_var_lib_t)
@@ -88,6 +92,7 @@
 allow xend_t xen_image_t:dir list_dir_perms;
 manage_dirs_pattern(xend_t,xen_image_t,xen_image_t)
 manage_files_pattern(xend_t,xen_image_t,xen_image_t)
+read_lnk_files_pattern(xend_t,xen_image_t,xen_image_t)
 rw_blk_files_pattern(xend_t,xen_image_t,xen_image_t)
 
 allow xend_t xenctl_t:fifo_file manage_file_perms;
@@ -97,7 +102,8 @@
 allow xend_t xend_var_run_t:dir setattr;
 manage_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
 manage_sock_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
-files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file })
+manage_fifo_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
+files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file fifo_file })
 
 # log files
 allow xend_t xend_var_log_t:dir setattr;
@@ -105,6 +111,10 @@
 manage_sock_files_pattern(xend_t,xend_var_log_t,xend_var_log_t)
 logging_log_filetrans(xend_t,xend_var_log_t,{ sock_file file dir })
 
+manage_files_pattern(xend_t,xend_tmp_t,xend_tmp_t)
+manage_dirs_pattern(xend_t,xend_tmp_t,xend_tmp_t)
+files_tmp_filetrans(xend_t, xend_tmp_t, { file dir })
+
 # var/lib files for xend
 manage_dirs_pattern(xend_t,xend_var_lib_t,xend_var_lib_t)
 manage_files_pattern(xend_t,xend_var_lib_t,xend_var_lib_t)
@@ -165,8 +175,13 @@
 files_manage_etc_runtime_files(xend_t)
 files_etc_filetrans_etc_runtime(xend_t,file)
 files_read_usr_files(xend_t)
+files_read_default_symlinks(xend_t)
+
+#tunable_policy(`xen_use_raw_disk',`
+	storage_raw_read_fixed_disk(xend_t)
+	storage_raw_write_fixed_disk(xend_t)
+#')
 
-storage_raw_read_fixed_disk(xend_t)
 storage_raw_read_removable_device(xend_t)
 
 term_getattr_all_user_ptys(xend_t)
@@ -195,6 +210,10 @@
 
 xen_stream_connect_xenstore(xend_t)
 
+lvm_domtrans(xend_t)
+
+mount_domtrans(xend_t)
+
 netutils_domtrans(xend_t)
 
 optional_policy(`
@@ -275,6 +294,12 @@
 
 files_read_usr_files(xenstored_t)
 
+#tunable_policy(`xen_use_raw_disk',`
+	storage_raw_read_fixed_disk(xenstored_t)
+	storage_raw_write_fixed_disk(xenstored_t)
+#')
+storage_raw_read_removable_device(xenstored_t)
+
 term_use_generic_ptys(xenstored_t)
 term_use_console(xenconsoled_t)
 
@@ -308,6 +333,11 @@
 
 allow xm_t xen_image_t:dir rw_dir_perms;
 allow xm_t xen_image_t:file read_file_perms;
+allow xm_t xen_image_t:blk_file r_file_perms;
+
+#tunable_policy(`xen_use_raw_disk',`
+	storage_raw_read_fixed_disk(xm_t)
+#')
 
 kernel_read_system_state(xm_t)
 kernel_read_kernel_sysctls(xm_t)
@@ -343,3 +373,11 @@
 xen_append_log(xm_t)
 xen_stream_connect(xm_t)
 xen_stream_connect_xenstore(xm_t)
+
+#Should have a boolean wrapping these
+fs_list_auto_mountpoints(xend_t)
+files_search_mnt(xend_t)
+fs_write_nfs_files(xend_t)
+fs_read_nfs_files(xend_t)
+fs_getattr_all_fs(xend_t)
+fs_read_dos_files(xend_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
