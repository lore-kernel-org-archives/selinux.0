Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CpFVr015316
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:15 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CpE7E013958
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:14 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 42E1441C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:08 +0200 (CEST)
Message-Id: <20080804123736.050488959@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:05 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 09/35] xen policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mostly uncontroversial fixes and cleanups, also adds the xen_rw_image_files
interface which is needed for the qemu patch.

Submitted Jul 19, no comments, refreshed to apply cleanly

Index: refpolicy/policy/modules/system/xen.fc
===================================================================
--- refpolicy.orig/policy/modules/system/xen.fc	2008-08-03 13:09:36.000000000 +0200
+++ refpolicy/policy/modules/system/xen.fc	2008-08-03 17:16:57.000000000 +0200
@@ -20,6 +20,7 @@
 /var/run/xenconsoled\.pid --	gen_context(system_u:object_r:xenconsoled_var_run_t,s0)
 /var/run/xend(/.*)?		gen_context(system_u:object_r:xend_var_run_t,s0)
 /var/run/xend\.pid	--      gen_context(system_u:object_r:xend_var_run_t,s0)
+/var/run/xenner(/.*)?		gen_context(system_u:object_r:xend_var_run_t,s0)
 /var/run/xenstore\.pid	--	gen_context(system_u:object_r:xenstored_var_run_t,s0)
 /var/run/xenstored(/.*)?	gen_context(system_u:object_r:xenstored_var_run_t,s0)
 
Index: refpolicy/policy/modules/system/xen.if
===================================================================
--- refpolicy.orig/policy/modules/system/xen.if	2008-08-03 13:09:36.000000000 +0200
+++ refpolicy/policy/modules/system/xen.if	2008-08-03 17:16:57.000000000 +0200
@@ -167,11 +167,14 @@
 #
 interface(`xen_stream_connect',`
 	gen_require(`
-		type xend_t, xend_var_run_t;
+		type xend_t, xend_var_run_t,  xend_var_lib_t;
 	')
 
 	files_search_pids($1)
 	stream_connect_pattern($1,xend_var_run_t,xend_var_run_t,xend_t)
+
+	files_search_var_lib($1)
+	stream_connect_pattern($1,xend_var_lib_t,xend_var_lib_t,xend_t)
 ')
 
 ########################################
@@ -191,3 +194,24 @@
 
 	domtrans_pattern($1,xm_exec_t,xm_t)
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to read/write
+##	xend image files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`xen_rw_image_files',`
+	gen_require(`
+		type xen_image_t, xend_var_lib_t;
+	')
+
+	files_list_var_lib($1)
+	allow $1 xend_var_lib_t:dir search_dir_perms;
+	rw_files_pattern($1,xen_image_t,xen_image_t)
+')
Index: refpolicy/policy/modules/system/xen.te
===================================================================
--- refpolicy.orig/policy/modules/system/xen.te	2008-08-03 13:09:36.000000000 +0200
+++ refpolicy/policy/modules/system/xen.te	2008-08-03 17:16:57.000000000 +0200
@@ -6,6 +6,13 @@
 # Declarations
 #
 
+## <desc>
+## <p>
+## Allow xen to manage nfs files
+## </p>
+## </desc>
+gen_tunable(xen_use_nfs,false)
+
 # console ptys
 type xen_devpts_t;
 term_pty(xen_devpts_t);
@@ -42,25 +49,31 @@
 # pid files
 type xend_var_run_t;
 files_pid_file(xend_var_run_t)
+files_mountpoint(xend_var_run_t)
 
 type xenstored_t;
 type xenstored_exec_t;
-domain_type(xenstored_t)
-domain_entry_file(xenstored_t,xenstored_exec_t)
-role system_r types xenstored_t;
+init_daemon_domain(xenstored_t,xenstored_exec_t)
+
+# tmp files
+type xenstored_tmp_t;
+files_tmp_file(xenstored_tmp_t)
 
 # var/lib files
 type xenstored_var_lib_t;
 files_type(xenstored_var_lib_t)
 
+# log files
+type xenstored_var_log_t;
+logging_log_file(xenstored_var_log_t)
+
 # pid files
 type xenstored_var_run_t;
 files_pid_file(xenstored_var_run_t)
 
 type xenconsoled_t;
 type xenconsoled_exec_t;
-domain_type(xenconsoled_t)
-domain_entry_file(xenconsoled_t,xenconsoled_exec_t)
+init_daemon_domain(xenconsoled_t,xenconsoled_exec_t)
 role system_r types xenconsoled_t;
 
 # pid files
@@ -95,7 +108,7 @@
 read_lnk_files_pattern(xend_t,xen_image_t,xen_image_t)
 rw_blk_files_pattern(xend_t,xen_image_t,xen_image_t)
 
-allow xend_t xenctl_t:fifo_file manage_file_perms;
+allow xend_t xenctl_t:fifo_file manage_fifo_file_perms;
 dev_filetrans(xend_t, xenctl_t, fifo_file)
 
 manage_files_pattern(xend_t,xend_tmp_t,xend_tmp_t)
@@ -103,14 +116,14 @@
 files_tmp_filetrans(xend_t, xend_tmp_t, { file dir })
 
 # pid file
-allow xend_t xend_var_run_t:dir setattr;
+manage_dirs_pattern(xend_t,xend_var_run_t,xend_var_run_t)
 manage_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
 manage_sock_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
 manage_fifo_files_pattern(xend_t,xend_var_run_t,xend_var_run_t)
-files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file fifo_file })
+files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file fifo_file dir })
 
 # log files
-allow xend_t xend_var_log_t:dir setattr;
+manage_dirs_pattern(xend_t,xend_var_log_t,xend_var_log_t)
 manage_files_pattern(xend_t,xend_var_log_t,xend_var_log_t)
 manage_sock_files_pattern(xend_t,xend_var_log_t,xend_var_log_t)
 logging_log_filetrans(xend_t,xend_var_log_t,{ sock_file file dir })
@@ -122,15 +135,13 @@
 manage_fifo_files_pattern(xend_t,xend_var_lib_t,xend_var_lib_t)
 files_var_lib_filetrans(xend_t,xend_var_lib_t,{ file dir })
 
+init_stream_connect_script(xend_t)
+
 # transition to store
-domain_auto_trans(xend_t, xenstored_exec_t, xenstored_t)
-allow xenstored_t xend_t:fd use;
-allow xenstored_t xend_t:process sigchld;
-allow xenstored_t xend_t:fifo_file write;
+domtrans_pattern(xend_t, xenstored_exec_t, xenstored_t)
 
 # transition to console
-domain_auto_trans(xend_t, xenconsoled_exec_t, xenconsoled_t)
-allow xenconsoled_t xend_t:fd use;
+domtrans_pattern(xend_t, xenconsoled_exec_t, xenconsoled_t)
 
 kernel_read_kernel_sysctls(xend_t)
 kernel_read_system_state(xend_t)
@@ -176,6 +187,7 @@
 files_manage_etc_runtime_files(xend_t)
 files_etc_filetrans_etc_runtime(xend_t,file)
 files_read_usr_files(xend_t)
+files_read_default_symlinks(xend_t)
 
 storage_raw_read_fixed_disk(xend_t)
 storage_raw_write_fixed_disk(xend_t)
@@ -207,11 +219,15 @@
 sysnet_read_dhcpc_pid(xend_t)
 sysnet_rw_dhcp_config(xend_t)
 
+sysadm_dontaudit_search_home_dirs(xend_t)
+
 xen_stream_connect_xenstore(xend_t)
 
 netutils_domtrans(xend_t)
 
-sysadm_dontaudit_search_home_dirs(xend_t)
+optional_policy(`
+	brctl_domtrans(xend_t)
+')
 
 optional_policy(`
 	consoletype_exec(xend_t)
@@ -224,7 +240,7 @@
 
 allow xenconsoled_t self:capability { dac_override fsetid ipc_lock };
 allow xenconsoled_t self:unix_stream_socket create_stream_socket_perms;
-allow xenconsoled_t self:fifo_file { read write };
+allow xenconsoled_t self:fifo_file  rw_fifo_file_perms;
 
 allow xenconsoled_t xen_devpts_t:chr_file rw_term_perms;
 
@@ -245,6 +261,8 @@
 
 files_read_usr_files(xenconsoled_t)
 
+fs_list_tmpfs(xenconsoled_t)
+
 term_create_pty(xenconsoled_t,xen_devpts_t);
 term_use_generic_ptys(xenconsoled_t)
 term_use_console(xenconsoled_t)
@@ -257,7 +275,7 @@
 
 miscfiles_read_localization(xenconsoled_t)
 
-xen_append_log(xenconsoled_t)
+xen_manage_log(xenconsoled_t)
 xen_stream_connect_xenstore(xenconsoled_t)
 
 ########################################
@@ -265,15 +283,25 @@
 # Xen store local policy
 #
 
-allow xenstored_t self:capability { dac_override mknod ipc_lock };
+allow xenstored_t self:capability { dac_override mknod ipc_lock sys_resource };
 allow xenstored_t self:unix_stream_socket create_stream_socket_perms;
 allow xenstored_t self:unix_dgram_socket create_socket_perms;
 
+manage_files_pattern(xenstored_t,xenstored_tmp_t,xenstored_tmp_t)
+manage_dirs_pattern(xenstored_t,xenstored_tmp_t,xenstored_tmp_t)
+files_tmp_filetrans(xenstored_t, xenstored_tmp_t, { file dir })
+
 # pid file
 manage_files_pattern(xenstored_t,xenstored_var_run_t,xenstored_var_run_t)
 manage_sock_files_pattern(xenstored_t,xenstored_var_run_t,xenstored_var_run_t)
 files_pid_filetrans(xenstored_t,xenstored_var_run_t, { file sock_file })
 
+# log files
+manage_dirs_pattern(xenstored_t,xenstored_var_log_t,xenstored_var_log_t)
+manage_files_pattern(xenstored_t,xenstored_var_log_t,xenstored_var_log_t)
+manage_sock_files_pattern(xenstored_t,xenstored_var_log_t,xenstored_var_log_t)
+logging_log_filetrans(xenstored_t,xenstored_var_log_t,{ sock_file file dir })
+
 # var/lib files for xenstored
 manage_dirs_pattern(xenstored_t,xenstored_var_lib_t,xenstored_var_lib_t)
 manage_files_pattern(xenstored_t,xenstored_var_lib_t,xenstored_var_lib_t)
@@ -318,12 +346,13 @@
 allow xm_t self:capability { dac_override ipc_lock sys_tty_config };
 
 # internal communication is often done using fifo and unix sockets.
-allow xm_t self:fifo_file { read write };
+allow xm_t self:fifo_file  rw_fifo_file_perms;
 allow xm_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow xm_t self:tcp_socket create_stream_socket_perms;
 
 manage_files_pattern(xm_t,xend_var_lib_t,xend_var_lib_t)
 manage_fifo_files_pattern(xm_t,xend_var_lib_t,xend_var_lib_t)
+manage_sock_files_pattern(xm_t,xend_var_lib_t,xend_var_lib_t)
 files_search_var_lib(xm_t)
 
 allow xm_t xen_image_t:dir rw_dir_perms;
@@ -336,6 +365,7 @@
 kernel_write_xen_state(xm_t)
 
 corecmd_exec_bin(xm_t)
+corecmd_exec_shell(xm_t)
 
 corenet_tcp_sendrecv_generic_if(xm_t)
 corenet_tcp_sendrecv_all_nodes(xm_t)
@@ -351,8 +381,11 @@
 
 storage_raw_read_fixed_disk(xm_t)
 
+fs_getattr_all_fs(xm_t)
+
 term_use_all_terms(xm_t)
 
+init_stream_connect_script(xm_t)
 init_rw_script_stream_sockets(xm_t)
 init_use_fds(xm_t)
 
@@ -363,6 +396,23 @@
 
 sysnet_read_config(xm_t)
 
+sysadm_dontaudit_search_home_dirs(xm_t)
+
 xen_append_log(xm_t)
 xen_stream_connect(xm_t)
 xen_stream_connect_xenstore(xm_t)
+
+#Should have a boolean wrapping these
+fs_list_auto_mountpoints(xend_t)
+files_search_mnt(xend_t)
+fs_getattr_all_fs(xend_t)
+fs_read_dos_files(xend_t)
+
+tunable_policy(`xen_use_nfs',`
+	fs_manage_nfs_files(xend_t)
+	fs_read_nfs_symlinks(xend_t)
+')
+
+optional_policy(`
+	unconfined_domain(xend_t)
+')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
