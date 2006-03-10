Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2AGOFtP017870
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:24:15 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2AGMekb028200
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 16:22:41 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k2AGOE0U021730
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:24:14 -0500 (EST)
Date: Fri, 10 Mar 2006 10:23:59 -0600
From: Chad Hanson <chanson@TrustedCS.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] MLS interface update
Message-ID: <20060310162359.GC2949@dhcp-225.il.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch updates existing mls interfaces and summaries to reflect the
current mls constraints.  Also, there are also new interface definitions
for some mls attributes which were lacking interfaces.

-Chad 


diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/consoletype.te serefpolicy-2.2.23/policy/modules/admin/consoletype.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/consoletype.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/consoletype.te	2006-03-09 20:38:18.000000000 +0000
@@ -9,8 +9,8 @@
 type consoletype_t;
 type consoletype_exec_t;
 init_domain(consoletype_t,consoletype_exec_t)
-mls_file_read_up(consoletype_t)
-mls_file_write_down(consoletype_t)
+mls_file_read(consoletype_t)
+mls_file_write(consoletype_t)
 role system_r types consoletype_t;
 
 ifdef(`targeted_policy',`',`
diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/kudzu.te serefpolicy-2.2.23/policy/modules/admin/kudzu.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/kudzu.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/kudzu.te	2006-03-09 20:38:34.000000000 +0000
@@ -61,8 +61,8 @@
 fs_search_ramfs(kudzu_t)
 fs_write_ramfs_sockets(kudzu_t)
 
-mls_file_read_up(kudzu_t)
-mls_file_write_down(kudzu_t)
+mls_file_read(kudzu_t)
+mls_file_write(kudzu_t)
 
 modutils_read_module_deps(kudzu_t)
 modutils_read_module_config(kudzu_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/logrotate.te serefpolicy-2.2.23/policy/modules/admin/logrotate.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/logrotate.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/logrotate.te	2006-03-09 20:39:30.000000000 +0000
@@ -72,8 +72,8 @@
 fs_search_auto_mountpoints(logrotate_t)
 fs_getattr_xattr_fs(logrotate_t)
 
-mls_file_read_up(logrotate_t)
-mls_file_write_down(logrotate_t)
+mls_file_read(logrotate_t)
+mls_file_write(logrotate_t)
 mls_file_upgrade(logrotate_t)
 
 selinux_get_fs_mount(logrotate_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/rpm.te serefpolicy-2.2.23/policy/modules/admin/rpm.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/rpm.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/rpm.te	2006-03-09 20:38:55.000000000 +0000
@@ -114,8 +114,8 @@
 fs_getattr_all_fs(rpm_t)
 fs_search_auto_mountpoints(rpm_t)
 
-mls_file_read_up(rpm_t)
-mls_file_write_down(rpm_t)
+mls_file_read(rpm_t)
+mls_file_write(rpm_t)
 mls_file_upgrade(rpm_t)
 
 selinux_get_fs_mount(rpm_t)
@@ -273,8 +273,8 @@
 fs_unmount_xattr_fs(rpm_script_t)
 fs_search_auto_mountpoints(rpm_script_t)
 
-mls_file_read_up(rpm_script_t)
-mls_file_write_down(rpm_script_t)
+mls_file_read(rpm_script_t)
+mls_file_write(rpm_script_t)
 
 selinux_get_fs_mount(rpm_script_t)
 selinux_validate_context(rpm_script_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/tmpreaper.te serefpolicy-2.2.23/policy/modules/admin/tmpreaper.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/tmpreaper.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/tmpreaper.te	2006-03-09 20:39:14.000000000 +0000
@@ -31,8 +31,8 @@
 # why does it need setattr?
 files_setattr_all_tmp_dirs(tmpreaper_t)
 
-mls_file_read_up(tmpreaper_t)
-mls_file_write_down(tmpreaper_t)
+mls_file_read(tmpreaper_t)
+mls_file_write(tmpreaper_t)
 
 libs_use_ld_so(tmpreaper_t)
 libs_use_shared_libs(tmpreaper_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/admin/usermanage.te serefpolicy-2.2.23/policy/modules/admin/usermanage.te
--- serefpolicy-2.2.23.orig/policy/modules/admin/usermanage.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/admin/usermanage.te	2006-03-09 20:43:52.000000000 +0000
@@ -293,7 +293,7 @@
 fs_getattr_xattr_fs(passwd_t)
 fs_search_auto_mountpoints(passwd_t)
 
-mls_file_write_down(passwd_t)
+mls_file_write(passwd_t)
 mls_file_downgrade(passwd_t)
 
 selinux_get_fs_mount(passwd_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/kernel/kernel.te serefpolicy-2.2.23/policy/modules/kernel/kernel.te
--- serefpolicy-2.2.23.orig/policy/modules/kernel/kernel.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/kernel/kernel.te	2006-03-09 20:45:12.000000000 +0000
@@ -232,8 +232,8 @@
 files_list_home(kernel_t)
 files_read_usr_files(kernel_t)
 
-mls_process_read_up(kernel_t)
-mls_process_write_down(kernel_t)
+mls_process_read(kernel_t)
+mls_process_write(kernel_t)
 
 ifdef(`targeted_policy',`
 	unconfined_domain(kernel_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/kernel/mls.if serefpolicy-2.2.23/policy/modules/kernel/mls.if
--- serefpolicy-2.2.23.orig/policy/modules/kernel/mls.if	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/kernel/mls.if	2006-03-09 18:33:25.000000000 +0000
@@ -14,7 +14,7 @@
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
-##	for reading from files at higher levels.
+##	for reading from files at any level.
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -22,7 +22,7 @@
 ##	</summary>
 ## </param>
 #
-interface(`mls_file_read_up',`
+interface(`mls_file_read',`
 	gen_require(`
 		attribute mlsfileread;
 	')
@@ -33,7 +33,7 @@
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
-##	for writing to files at lower levels.
+##	for writing to files at any level.
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -41,7 +41,7 @@
 ##	</summary>
 ## </param>
 #
-interface(`mls_file_write_down',`
+interface(`mls_file_write',`
 	gen_require(`
 		attribute mlsfilewrite;
 	')
@@ -89,6 +89,122 @@
 
 ########################################
 ## <summary>
+##	Make specified domain MLS trusted
+##	for reading from sockets at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_net_read',`
+	gen_require(`
+		attribute mlsnetread;
+	')
+
+	typeattribute $1 mlsnetread;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for reading from sockets at any level
+##	that is dominated by the process clearance.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_net_read_to_clearance',`
+	gen_require(`
+		attribute mlsnetreadtoclr;
+	')
+
+	typeattribute $1 mlsnetreadtoclr;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for writing to sockets at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_net_write',`
+	gen_require(`
+		attribute mlsnetwrite;
+	')
+
+	typeattribute $1 mlsnetwrite;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for receiving network data from 
+##	network interfaces or hosts at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_net_receive_all',`
+	gen_require(`
+		attribute mlsnetrecvall;
+	')
+
+	typeattribute $1 mlsnetrecvall;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for reading from IPC objects at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_ipc_read',`
+	gen_require(`
+		attribute mlsipcread;
+	')
+
+	typeattribute $1 mlsipcread;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for writing to IPC objects at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_ipc_write',`
+	gen_require(`
+		attribute mlsipcwrite;
+	')
+
+	typeattribute $1 mlsipcwrite;
+')
+
+########################################
+## <summary>
 ##	Allow the specified domain to do a MLS
 ##	range transition that changes
 ##	the current level.
@@ -130,7 +246,7 @@
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
-##	for reading from processes at higher levels.
+##	for reading from processes at any level.
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -138,7 +254,7 @@
 ##	</summary>
 ## </param>
 #
-interface(`mls_process_read_up',`
+interface(`mls_process_read',`
 	gen_require(`
 		attribute mlsprocread;
 	')
@@ -149,7 +265,7 @@
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
-##	for writing to processes at lower levels.
+##	for writing to processes at any level.
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -157,7 +273,7 @@
 ##	</summary>
 ## </param>
 #
-interface(`mls_process_write_down',`
+interface(`mls_process_write',`
 	gen_require(`
 		attribute mlsprocwrite;
 	')
@@ -185,6 +301,82 @@
 	typeattribute $1 mlsprocsetsl;
 ')
 
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for reading from X objects at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_xwin_read',`
+	gen_require(`
+		attribute mlsxwinread;
+	')
+
+	typeattribute $1 mlsxwinread;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for writing to X objects at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_xwin_write',`
+	gen_require(`
+		attribute mlsxwinwrite;
+	')
+
+	typeattribute $1 mlsxwinwrite;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for reading from X colormaps at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_xwin_read_colormap',`
+	gen_require(`
+		attribute mlsxwinreadcolormap;
+	')
+
+	typeattribute $1 mlsxwinreadcolormap;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for writing to X colormaps at any level.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`mls_xwin_write_colormap',`
+	gen_require(`
+		attribute mlsxwinwritecolormap;
+	')
+
+	typeattribute $1 mlsxwinwritecolormap;
+')
+
 
 ########################################
 ## <summary>
diff -Nur serefpolicy-2.2.23.orig/policy/modules/services/hal.te serefpolicy-2.2.23/policy/modules/services/hal.te
--- serefpolicy-2.2.23.orig/policy/modules/services/hal.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/services/hal.te	2006-03-09 20:37:47.000000000 +0000
@@ -98,7 +98,7 @@
 fs_search_all(hald_t)
 fs_list_auto_mountpoints(hald_t)
 
-mls_file_read_up(hald_t)
+mls_file_read(hald_t)
 
 selinux_get_fs_mount(hald_t)
 selinux_validate_context(hald_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/services/networkmanager.te serefpolicy-2.2.23/policy/modules/services/networkmanager.te
--- serefpolicy-2.2.23.orig/policy/modules/services/networkmanager.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/services/networkmanager.te	2006-03-09 20:36:56.000000000 +0000
@@ -61,7 +61,7 @@
 fs_getattr_all_fs(NetworkManager_t)
 fs_search_auto_mountpoints(NetworkManager_t)
 
-mls_file_read_up(NetworkManager_t)
+mls_file_read(NetworkManager_t)
 
 selinux_dontaudit_search_fs(NetworkManager_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/services/remotelogin.te serefpolicy-2.2.23/policy/modules/services/remotelogin.te
--- serefpolicy-2.2.23.orig/policy/modules/services/remotelogin.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/services/remotelogin.te	2006-03-09 20:37:34.000000000 +0000
@@ -107,8 +107,8 @@
 
 logging_send_syslog_msg(remote_login_t)
 
-mls_file_read_up(remote_login_t)
-mls_file_write_down(remote_login_t)
+mls_file_read(remote_login_t)
+mls_file_write(remote_login_t)
 mls_file_upgrade(remote_login_t)
 mls_file_downgrade(remote_login_t)
 mls_process_set_level(remote_login_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/services/ssh.if serefpolicy-2.2.23/policy/modules/services/ssh.if
--- serefpolicy-2.2.23.orig/policy/modules/services/ssh.if	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/services/ssh.if	2006-03-09 20:37:15.000000000 +0000
@@ -504,8 +504,8 @@
 
 	miscfiles_read_localization($1_t)
 
-	mls_file_read_up($1_t)
-	mls_file_write_down($1_t)
+	mls_file_read($1_t)
+	mls_file_write($1_t)
 	mls_file_upgrade($1_t)
 	mls_file_downgrade($1_t)
 	mls_process_set_level($1_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/services/ssh.te serefpolicy-2.2.23/policy/modules/services/ssh.te
--- serefpolicy-2.2.23.orig/policy/modules/services/ssh.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/services/ssh.te	2006-03-09 20:38:02.000000000 +0000
@@ -87,8 +87,8 @@
 	# for X forwarding
 	corenet_tcp_bind_xserver_port(sshd_t)
 
-	mls_file_read_up(sshd_t)
-	mls_file_write_down(sshd_t)
+	mls_file_read(sshd_t)
+	mls_file_write(sshd_t)
 	mls_file_upgrade(sshd_t)
 	mls_file_downgrade(sshd_t)
 	mls_process_set_level(sshd_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/authlogin.te serefpolicy-2.2.23/policy/modules/system/authlogin.te
--- serefpolicy-2.2.23.orig/policy/modules/system/authlogin.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/authlogin.te	2006-03-09 20:39:47.000000000 +0000
@@ -204,8 +204,8 @@
 
 logging_send_syslog_msg(pam_console_t)
 
-mls_file_read_up(pam_console_t)
-mls_file_write_down(pam_console_t)
+mls_file_read(pam_console_t)
+mls_file_write(pam_console_t)
 
 seutil_read_file_contexts(pam_console_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/fstools.te serefpolicy-2.2.23/policy/modules/system/fstools.te
--- serefpolicy-2.2.23.orig/policy/modules/system/fstools.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/fstools.te	2006-03-09 20:42:03.000000000 +0000
@@ -9,7 +9,7 @@
 type fsadm_t;
 type fsadm_exec_t;
 init_system_domain(fsadm_t,fsadm_exec_t)
-mls_file_read_up(fsadm_t)
+mls_file_read(fsadm_t)
 role system_r types fsadm_t;
 
 type fsadm_tmp_t;
@@ -86,7 +86,7 @@
 fs_getattr_tmpfs_dirs(fsadm_t)
 fs_read_tmpfs_symlinks(fsadm_t)
 
-mls_file_write_down(fsadm_t)
+mls_file_write(fsadm_t)
 
 storage_raw_read_fixed_disk(fsadm_t)
 storage_raw_write_fixed_disk(fsadm_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/getty.te serefpolicy-2.2.23/policy/modules/system/getty.te
--- serefpolicy-2.2.23.orig/policy/modules/system/getty.te	2006-03-04 05:06:49.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/getty.te	2006-03-09 20:40:01.000000000 +0000
@@ -69,8 +69,8 @@
 # for error condition handling
 fs_getattr_xattr_fs(getty_t)
 
-mls_file_read_up(getty_t)
-mls_file_write_down(getty_t)
+mls_file_read(getty_t)
+mls_file_write(getty_t)
 
 # Chown, chmod, read and write ttys.
 term_use_all_user_ttys(getty_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/init.te serefpolicy-2.2.23/policy/modules/system/init.te
--- serefpolicy-2.2.23.orig/policy/modules/system/init.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/init.te	2006-03-09 20:43:11.000000000 +0000
@@ -121,7 +121,7 @@
 
 dev_read_sysfs(init_t)
 
-mls_process_write_down(init_t)
+mls_process_write(init_t)
 
 selinux_set_boolean(init_t)
 
@@ -157,8 +157,8 @@
 
 mcs_killall(init_t)
 
-mls_file_read_up(init_t)
-mls_file_write_down(init_t)
+mls_file_read(init_t)
+mls_file_write(init_t)
 mls_rangetrans_target(init_t)
 
 seutil_read_config(init_t)
@@ -368,10 +368,10 @@
 
 mcs_killall(initrc_t)
 
-mls_file_read_up(initrc_t)
-mls_file_write_down(initrc_t)
-mls_process_read_up(initrc_t)
-mls_process_write_down(initrc_t)
+mls_file_read(initrc_t)
+mls_file_write(initrc_t)
+mls_process_read(initrc_t)
+mls_process_write(initrc_t)
 mls_rangetrans_source(initrc_t)
 
 modutils_read_module_config(initrc_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/iptables.te serefpolicy-2.2.23/policy/modules/system/iptables.te
--- serefpolicy-2.2.23.orig/policy/modules/system/iptables.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/iptables.te	2006-03-09 20:41:25.000000000 +0000
@@ -48,7 +48,7 @@
 fs_getattr_xattr_fs(iptables_t)
 fs_search_auto_mountpoints(iptables_t)
 
-mls_file_read_up(iptables_t)
+mls_file_read(iptables_t)
 
 term_dontaudit_use_console(iptables_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/locallogin.te serefpolicy-2.2.23/policy/modules/system/locallogin.te
--- serefpolicy-2.2.23.orig/policy/modules/system/locallogin.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/locallogin.te	2006-03-09 20:41:43.000000000 +0000
@@ -155,8 +155,8 @@
 
 miscfiles_read_localization(local_login_t)
 
-mls_file_read_up(local_login_t)
-mls_file_write_down(local_login_t)
+mls_file_read(local_login_t)
+mls_file_write(local_login_t)
 mls_file_upgrade(local_login_t)
 mls_file_downgrade(local_login_t)
 mls_process_set_level(local_login_t)
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/logging.te serefpolicy-2.2.23/policy/modules/system/logging.te
--- serefpolicy-2.2.23.orig/policy/modules/system/logging.te	2006-03-04 05:06:49.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/logging.te	2006-03-09 20:42:28.000000000 +0000
@@ -78,7 +78,7 @@
 domain_read_all_domains_state(auditctl_t)
 domain_use_interactive_fds(auditctl_t)
 
-mls_file_read_up(auditctl_t)
+mls_file_read(auditctl_t)
 
 term_use_all_terms(auditctl_t)
 
@@ -164,7 +164,7 @@
 
 miscfiles_read_localization(auditd_t)
 
-mls_file_read_up(auditd_t)
+mls_file_read(auditd_t)
 mls_rangetrans_target(auditd_t)
 
 seutil_dontaudit_read_config(auditd_t)
@@ -238,7 +238,7 @@
 
 miscfiles_read_localization(klogd_t)
 
-mls_file_read_up(klogd_t)
+mls_file_read(klogd_t)
 
 userdom_dontaudit_search_sysadm_home_dirs(klogd_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/modutils.te serefpolicy-2.2.23/policy/modules/system/modutils.te
--- serefpolicy-2.2.23.orig/policy/modules/system/modutils.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/modutils.te	2006-03-09 20:44:12.000000000 +0000
@@ -21,7 +21,7 @@
 type insmod_t;
 type insmod_exec_t;
 init_system_domain(insmod_t,insmod_exec_t)
-mls_file_write_down(insmod_t)
+mls_file_write(insmod_t)
 role system_r types insmod_t;
 
 type depmod_t;
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/mount.te serefpolicy-2.2.23/policy/modules/system/mount.te
--- serefpolicy-2.2.23.orig/policy/modules/system/mount.te	2006-03-04 05:06:50.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/mount.te	2006-03-09 20:41:12.000000000 +0000
@@ -81,8 +81,8 @@
 
 miscfiles_read_localization(mount_t)
 
-mls_file_read_up(mount_t)
-mls_file_write_down(mount_t)
+mls_file_read(mount_t)
+mls_file_write(mount_t)
 
 sysnet_use_portmap(mount_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/selinuxutil.te serefpolicy-2.2.23/policy/modules/system/selinuxutil.te
--- serefpolicy-2.2.23.orig/policy/modules/system/selinuxutil.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/selinuxutil.te	2006-03-09 20:40:35.000000000 +0000
@@ -186,7 +186,7 @@
 
 fs_getattr_xattr_fs(load_policy_t)
 
-mls_file_read_up(load_policy_t)
+mls_file_read(load_policy_t)
 
 selinux_get_fs_mount(load_policy_t)
 selinux_load_policy(load_policy_t)
@@ -253,8 +253,8 @@
 fs_getattr_xattr_fs(newrole_t)
 fs_search_auto_mountpoints(newrole_t)
 
-mls_file_read_up(newrole_t)
-mls_file_write_down(newrole_t)
+mls_file_read(newrole_t)
+mls_file_write(newrole_t)
 mls_file_upgrade(newrole_t)
 mls_file_downgrade(newrole_t)
 mls_process_set_level(newrole_t)
@@ -353,8 +353,8 @@
 fs_getattr_xattr_fs(restorecon_t)
 fs_search_auto_mountpoints(restorecon_t)
 
-mls_file_read_up(restorecon_t)
-mls_file_write_down(restorecon_t)
+mls_file_read(restorecon_t)
+mls_file_write(restorecon_t)
 mls_file_upgrade(restorecon_t)
 mls_file_downgrade(restorecon_t)
 
@@ -501,7 +501,7 @@
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
 
-mls_file_write_down(semanage_t)
+mls_file_write(semanage_t)
 mls_rangetrans_target(semanage_t)
 
 selinux_get_enforce_mode(semanage_t)
@@ -547,8 +547,8 @@
 fs_getattr_xattr_fs(setfiles_t)
 fs_list_all(setfiles_t)
 
-mls_file_read_up(setfiles_t)
-mls_file_write_down(setfiles_t)
+mls_file_read(setfiles_t)
+mls_file_write(setfiles_t)
 mls_file_upgrade(setfiles_t)
 mls_file_downgrade(setfiles_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/udev.te serefpolicy-2.2.23/policy/modules/system/udev.te
--- serefpolicy-2.2.23.orig/policy/modules/system/udev.te	2006-03-09 17:06:09.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/udev.te	2006-03-09 20:40:57.000000000 +0000
@@ -127,11 +127,11 @@
 
 miscfiles_read_localization(udev_t)
 
-mls_file_read_up(udev_t)
-mls_file_write_down(udev_t)
+mls_file_read(udev_t)
+mls_file_write(udev_t)
 mls_file_upgrade(udev_t)
 mls_file_downgrade(udev_t)
-mls_process_write_down(udev_t)
+mls_process_write(udev_t)
 
 modutils_domtrans_insmod(udev_t)
 
diff -Nur serefpolicy-2.2.23.orig/policy/modules/system/userdomain.te serefpolicy-2.2.23/policy/modules/system/userdomain.te
--- serefpolicy-2.2.23.orig/policy/modules/system/userdomain.te	2006-03-04 05:06:49.000000000 +0000
+++ serefpolicy-2.2.23/policy/modules/system/userdomain.te	2006-03-09 20:44:36.000000000 +0000
@@ -154,7 +154,7 @@
 
 	corecmd_exec_shell(sysadm_t)
 
-	mls_process_read_up(sysadm_t)
+	mls_process_read(sysadm_t)
 
 	init_exec(sysadm_t)
 
@@ -172,8 +172,8 @@
 
 	ifdef(`enable_mls',`
 		corecmd_exec_shell(secadm_t)
-		mls_process_read_up(secadm_t)
-		mls_file_write_down(secadm_t)
+		mls_process_read(secadm_t)
+		mls_file_write(secadm_t)
 		mls_file_upgrade(secadm_t)
 		mls_file_downgrade(secadm_t)
 		logging_read_audit_log(secadm_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
