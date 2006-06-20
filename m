Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LCLnHJ021094
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 08:21:49 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LCLmYv010706
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 12:21:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5LCLsXJ027324
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 08:21:54 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5LCLsBh027323
	for selinux@tycho.nsa.gov; Wed, 21 Jun 2006 08:21:54 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5KKJCtf007226
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 16:19:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5KKJA9b012577
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 20:19:11 GMT
Message-ID: <44985841.7080703@redhat.com>
Date: Tue, 20 Jun 2006 16:19:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------040405090908060609010807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040405090908060609010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

bootloader has gotten more powerfull, needs more privs

Added allow_httpd_mod_auth_pam
 boolean but can't use it because of limitation of policy compiler

logwatch needs dac override privs

netutils binds to arbitrary udp ports.

prelink is changine location of log file.

Add ibmasmfs_t

Dontaudit restorecon walking some kernel types

I have made several changes to allow me to build a webadm_r.
Label all httpd_$1_script_exec_t as httpd_script_exec_type

Then add that type to httpd_manage_all_content.

Add httpd_manage_config and httpd_manage_log

Add domain for rotatelogs (httpd_rotatelogs_t)

automount moved to 5.0 and needs a lot of privs that mount.te has.

New minor changes to cups

cups needs to read tmp files of hal

ntp needs to read network state for IPV6.

cron runs postfix

clamav reads postfix lib

More commands want to look at ldap

spelling mistake on fglrx_drv

Split base_user_template into two

base_user_template (This can be used by extended roles, some privs were 
moved here from unpriv_userdomain also).

base_login_user_template

Also added some gen_require to get template working

Added role_change_template so we can change from one role to another.

xen needs more privs



--------------040405090908060609010807
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.2.48/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-06-08 08:45:56.000000000 -0400
+++ serefpolicy-2.2.48/policy/global_tunables	2006-06-20 10:16:12.000000000 -0400
@@ -89,6 +89,13 @@
 
 ## <desc>
 ## <p>
+## Allow Apache to use mod_auth_pam
+## </p>
+## </desc>
+gen_tunable(allow_httpd_mod_auth_pam,false)
+
+## <desc>
+## <p>
 ## Allow java executable stack
 ## </p>
 ## </desc>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/bootloader.te serefpolicy-2.2.48/policy/modules/admin/bootloader.te
--- nsaserefpolicy/policy/modules/admin/bootloader.te	2006-05-02 18:59:59.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/admin/bootloader.te	2006-06-20 10:16:12.000000000 -0400
@@ -49,7 +49,7 @@
 #
 
 allow bootloader_t self:capability { dac_read_search fsetid sys_rawio sys_admin mknod chown };
-allow bootloader_t self:process { sigkill sigstop signull signal };
+allow bootloader_t self:process { sigkill sigstop signull signal execmem };
 allow bootloader_t self:fifo_file rw_file_perms;
 
 allow bootloader_t bootloader_etc_t:file r_file_perms;
@@ -111,6 +111,7 @@
 # for blkid.tab
 files_manage_etc_runtime_files(bootloader_t)
 files_etc_filetrans_etc_runtime(bootloader_t,file)
+files_dontaudit_search_home(bootloader_t)
 
 init_getattr_initctl(bootloader_t)
 init_use_script_ptys(bootloader_t)
@@ -127,6 +128,8 @@
 
 miscfiles_read_localization(bootloader_t)
 
+modutils_domtrans_insmod_uncond(bootloader_t)
+
 seutil_read_bin_policy(bootloader_t)
 seutil_read_loadpolicy(bootloader_t)
 seutil_dontaudit_search_config(bootloader_t)
@@ -207,3 +210,7 @@
 	userdom_dontaudit_search_staff_home_dirs(bootloader_t)
 	userdom_dontaudit_search_sysadm_home_dirs(bootloader_t)
 ')
+
+optional_policy(`
+	kudzu_domtrans(bootloader_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.2.48/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/admin/consoletype.te	2006-06-20 10:16:12.000000000 -0400
@@ -8,7 +8,12 @@
 
 type consoletype_t;
 type consoletype_exec_t;
-init_domain(consoletype_t,consoletype_exec_t)
+#dont transition from initrc
+#init_domain(consoletype_t,consoletype_exec_t)
+domain_type(consoletype_t)
+domain_entry_file(consoletype_t,consoletype_exec_t)
+role system_r types consoletype_t;
+
 mls_file_read_up(consoletype_t)
 mls_file_write_down(consoletype_t)
 role system_r types consoletype_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logwatch.te serefpolicy-2.2.48/policy/modules/admin/logwatch.te
--- nsaserefpolicy/policy/modules/admin/logwatch.te	2006-04-04 18:06:37.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/admin/logwatch.te	2006-06-20 10:16:12.000000000 -0400
@@ -22,8 +22,7 @@
 #
 # Local policy
 #
-
-allow logwatch_t self:capability setgid;
+allow logwatch_t self:capability { dac_override dac_read_search setgid };
 allow logwatch_t self:fifo_file rw_file_perms;
 allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.2.48/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2006-06-06 22:21:51.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/admin/netutils.te	2006-06-20 10:16:12.000000000 -0400
@@ -54,6 +54,7 @@
 corenet_udp_sendrecv_all_ports(netutils_t)
 corenet_tcp_connect_all_ports(netutils_t)
 corenet_sendrecv_all_client_packets(netutils_t)
+corenet_udp_bind_generic_node(netutils_t)
 
 fs_getattr_xattr_fs(netutils_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.fc serefpolicy-2.2.48/policy/modules/admin/prelink.fc
--- nsaserefpolicy/policy/modules/admin/prelink.fc	2006-06-13 07:03:39.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/admin/prelink.fc	2006-06-20 10:16:12.000000000 -0400
@@ -3,6 +3,5 @@
 
 /usr/sbin/prelink(\.bin)?	--	gen_context(system_u:object_r:prelink_exec_t,s0)
 
-/var/lib/misc/prelink\..*	--	gen_context(system_u:object_r:prelink_cache_t,s0)
-
 /var/log/prelink\.log		--	gen_context(system_u:object_r:prelink_log_t,s0)
+/var/log/prelink(/.*)?			gen_context(system_u:object_r:prelink_log_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.48/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-06-08 23:00:29.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/kernel/files.if	2006-06-20 10:16:12.000000000 -0400
@@ -1931,6 +1931,21 @@
 ')
 
 ########################################
+#
+# files_unlink_boot_flag(domain)
+#
+# /halt, /.autofsck, etc
+#
+interface(`files_unlink_boot_flag',`
+	gen_require(`
+		type root_t;
+	')
+
+	allow $1 root_t:file unlink;
+')
+
+
+########################################
 ## <summary>
 ##	Read files in /etc that are dynamically
 ##	created on boot, such as mtab.
@@ -4379,3 +4394,23 @@
 
 	typeattribute $1 files_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Mount a filesystem on all files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`files_mounton_all_files',`
+	gen_require(`
+		attribute file_type, security_file_type;
+	')
+
+	allow $1 { file_type -security_file_type }:dir mounton;
+	allow $1 { file_type -security_file_type }:file mounton;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.2.48/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-06-20 09:54:01.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/kernel/filesystem.te	2006-06-20 10:16:12.000000000 -0400
@@ -48,6 +48,11 @@
 files_mountpoint(binfmt_misc_fs_t)
 genfscon binfmt_misc / gen_context(system_u:object_r:binfmt_misc_fs_t,s0)
 
+type ibmasmfs_t;
+fs_type(ibmasmfs_t)
+allow ibmasmfs_t self:filesystem associate;
+genfscon ibmasmfs / gen_context(system_u:object_r:ibmasmfs_t,s0)
+
 type capifs_t;
 fs_type(capifs_t)
 genfscon capifs / gen_context(system_u:object_r:capifs_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.2.48/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-05-26 14:02:27.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/kernel/kernel.if	2006-06-20 10:16:12.000000000 -0400
@@ -2096,3 +2096,41 @@
 
 	typeattribute $1 kern_unconfined;
 ')
+
+########################################
+## <summary>
+##	Do not audit attempts to list sysctl_type directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_list_sysctls',`
+	gen_require(`
+		attribute sysctl_type;
+	')
+
+	dontaudit $1 sysctl_type:dir list_dir_perms;
+')
+
+
+########################################
+## <summary>
+##	Do not audit attempts to list proc_type file/directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_list_all_proc',`
+	gen_require(`
+		attribute proc_type;
+	')
+
+	dontaudit $1 proc_type:dir list_dir_perms;
+	dontaudit $1 proc_type:file getattr;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.fc serefpolicy-2.2.48/policy/modules/services/apache.fc
--- nsaserefpolicy/policy/modules/services/apache.fc	2006-05-02 18:59:59.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/apache.fc	2006-06-20 10:16:12.000000000 -0400
@@ -78,3 +78,4 @@
 /var/www/icons(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/www/perl(/.*)?			gen_context(system_u:object_r:httpd_sys_script_exec_t,s0)
 /usr/share/selinux-policy([^/]*)?/html(/.*)?	gen_context(system_u:object_r:httpd_sys_content_t,s0)
+/usr/sbin/rotatelogs		--	gen_context(system_u:object_r:httpd_rotatelogs_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.if serefpolicy-2.2.48/policy/modules/services/apache.if
--- nsaserefpolicy/policy/modules/services/apache.if	2006-06-08 08:45:57.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/apache.if	2006-06-20 16:00:09.000000000 -0400
@@ -15,6 +15,7 @@
 	gen_require(`
 		attribute httpdcontent;
 		attribute httpd_exec_scripts;
+		attribute httpd_script_exec_type;
 		type httpd_t, httpd_suexec_t, httpd_log_t;
 	')
 	# allow write access to public file transfer
@@ -35,7 +36,7 @@
 	role system_r types httpd_$1_script_t;
 
 	# This type is used for executable scripts files
-	type httpd_$1_script_exec_t; # customizable;
+	type httpd_$1_script_exec_t, httpd_script_exec_type; # customizable;
 	corecmd_shell_entry_type(httpd_$1_script_t)
 	domain_entry_file(httpd_$1_script_t,httpd_$1_script_exec_t)
 
@@ -464,12 +465,17 @@
 #
 interface(`apache_manage_all_content',`
 	gen_require(`
-		attribute httpdcontent;
+		attribute httpdcontent, httpd_script_exec_type;
 	')
 
 	allow $1 httpdcontent:dir manage_dir_perms;
 	allow $1 httpdcontent:file manage_file_perms;
 	allow $1 httpdcontent:lnk_file create_lnk_perms;
+
+	allow $1 httpd_script_exec_type:dir manage_dir_perms;
+	allow $1 httpd_script_exec_type:file manage_file_perms;
+	allow $1 httpd_script_exec_type:lnk_file create_lnk_perms;
+
 ')
 
 ########################################
@@ -515,6 +521,28 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to manage
+##	apache configuration files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_manage_config',`
+	gen_require(`
+		type httpd_config_t;
+	')
+
+	files_search_etc($1)
+	allow $1 httpd_config_t:dir create_dir_perms;
+	allow $1 httpd_config_t:file create_file_perms;
+	allow $1 httpd_config_t:lnk_file { getattr read };
+')
+
+########################################
+## <summary>
 ##	Execute the Apache helper program with
 ##	a domain transition.
 ## </summary>
@@ -594,6 +622,28 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to manage
+##	to apache log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_manage_log',`
+	gen_require(`
+		type httpd_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 httpd_log_t:dir create_dir_perms;
+	allow $1 httpd_log_t:file create_file_perms;
+	allow $1 httpd_log_t:lnk_file { getattr read };
+')
+
+########################################
+## <summary>
 ##	Allow the specified domain to append
 ##	to apache log files.
 ## </summary>
@@ -955,3 +1005,28 @@
 	allow $2 httpd_$1_content_t:file r_file_perms;
 	allow $2 httpd_$1_content_t:lnk_file { getattr read };
 ')
+
+
+########################################
+## <summary>
+##	Execute a domain transition to run httpd_rotatelogs.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`apache_domtrans_rotatelogs',`
+	gen_require(`
+		type httpd_rotatelogs_t, httpd_rotatelogs_exec_t;
+	')
+
+	domain_auto_trans($1,httpd_rotatelogs_exec_t,httpd_rotatelogs_t)
+
+	allow $1 httpd_rotatelogs_t:fd use;
+	allow httpd_rotatelogs_t $1:fd use;
+	allow httpd_rotatelogs_t $1:fifo_file rw_file_perms;
+	allow httpd_rotatelogs_t $1:process sigchld;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.2.48/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-06-20 09:54:04.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/apache.te	2006-06-20 10:16:12.000000000 -0400
@@ -109,13 +109,10 @@
 type squirrelmail_spool_t;
 files_tmp_file(squirrelmail_spool_t)
 
-# mod_jk2 creates /var/log/httpd/jk2.shm to communicate with tomcat
-# This is a bug but it still exists in FC2
-# cjp: probably can remove this
-ifdef(`distro_redhat',`
-	typealias httpd_log_t alias httpd_runtime_t;
-	dontaudit httpd_t httpd_runtime_t:file ioctl;
-')
+type httpd_rotatelogs_t;
+type httpd_rotatelogs_exec_t;
+domain_type(httpd_rotatelogs_t)
+init_daemon_domain(httpd_rotatelogs_t, httpd_rotatelogs_exec_t)
 
 ifdef(`targeted_policy',`
 	typealias httpd_sys_content_t alias httpd_user_content_t;
@@ -293,6 +290,15 @@
 	miscfiles_manage_public_files(httpd_t)
 ') 
 
+ifdef(`TODO', `
+#
+# We need optionals to be able to be within booleans to make this work
+#
+tunable_policy(`allow_httpd_mod_auth_pam',`
+	auth_domtrans_chk_passwd(httpd_t)
+')
+')
+
 tunable_policy(`httpd_can_network_connect',`
 	corenet_tcp_connect_all_ports(httpd_t)
 ')
@@ -600,6 +606,10 @@
 	allow httpd_sys_script_t httpd_suexec_t:process sigchld;
 ')
 
+tunable_policy(`httpd_enable_cgi && httpd_unified && httpd_builtin_scripting',`
+	domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
+')
+
 tunable_policy(`httpd_enable_homedirs && use_nfs_home_dirs',`
 	fs_read_nfs_files(httpd_suexec_t)
 	fs_read_nfs_symlinks(httpd_suexec_t)
@@ -688,3 +698,29 @@
 optional_policy(`
 	nscd_socket_use(httpd_unconfined_script_t)
 ')
+
+########################################
+#
+# httpd_rotatelogs local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(httpd_rotatelogs_t)
+libs_use_ld_so(httpd_rotatelogs_t)
+libs_use_shared_libs(httpd_rotatelogs_t)
+miscfiles_read_localization(httpd_rotatelogs_t)
+kernel_read_kernel_sysctls(httpd_rotatelogs_t)
+kernel_dontaudit_list_proc(httpd_rotatelogs_t)
+kernel_dontaudit_read_proc_symlinks(httpd_rotatelogs_t)
+term_dontaudit_use_generic_ptys(httpd_rotatelogs_t)
+
+allow httpd_rotatelogs_t httpd_log_t:dir rw_dir_perms;
+allow httpd_rotatelogs_t httpd_log_t:file create_file_perms;
+
+#
+# Should we add a boolean?
+#
+apache_domtrans_rotatelogs(httpd_sys_script_t)
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.48/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-06-13 07:03:42.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/automount.te	2006-06-20 10:16:12.000000000 -0400
@@ -28,7 +28,7 @@
 # Local policy
 #
 
-allow automount_t self:capability { net_bind_service sys_nice sys_resource dac_override };
+allow automount_t self:capability { net_bind_service sys_nice sys_resource dac_override sys_admin };
 dontaudit automount_t self:capability sys_tty_config;
 allow automount_t self:process { signal_perms getpgid setpgid setsched setrlimit };
 allow automount_t self:fifo_file rw_file_perms;
@@ -64,9 +64,20 @@
 kernel_read_system_state(automount_t)
 kernel_read_network_state(automount_t)
 kernel_list_proc(automount_t)
+kernel_dontaudit_search_xen_state(automount_t)
 
 files_search_boot(automount_t)
 
+#
+# Automount is slowly adding all mount functionality internally
+#
+files_search_all(automount_t)
+files_mounton_all_mountpoints(automount_t)
+files_mount_all_file_type_fs(automount_t)
+files_unmount_all_file_type_fs(automount_t)
+fs_mount_all_fs(automount_t)
+fs_unmount_all_fs(automount_t)
+
 corecmd_exec_sbin(automount_t)
 corecmd_exec_bin(automount_t)
 corecmd_exec_shell(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.if serefpolicy-2.2.48/policy/modules/services/clamav.if
--- nsaserefpolicy/policy/modules/services/clamav.if	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/clamav.if	2006-06-20 10:16:12.000000000 -0400
@@ -84,3 +84,23 @@
 	allow clamscan_t $1:process sigchld;
 ')
 
+
+########################################
+## <summary>
+##	Search clamav Libraries dir
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`clamav_search_lib',`
+	gen_require(`
+		type clamd_var_lib_t;
+	')
+
+	files_search_var_lib($1)
+	allow $1 clamd_var_lib_t:dir search_dir_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.fc serefpolicy-2.2.48/policy/modules/services/cups.fc
--- nsaserefpolicy/policy/modules/services/cups.fc	2006-04-19 11:26:51.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/cups.fc	2006-06-20 10:16:12.000000000 -0400
@@ -24,6 +24,7 @@
 
 /usr/sbin/cupsd		--	gen_context(system_u:object_r:cupsd_exec_t,s0)
 /usr/sbin/hal_lpadmin --	gen_context(system_u:object_r:cupsd_config_exec_t,s0)
+/usr/libexec/hal_lpadmin --	gen_context(system_u:object_r:cupsd_config_exec_t,s0)
 /usr/sbin/hpiod		--	gen_context(system_u:object_r:hplip_exec_t,s0)
 /usr/sbin/printconf-backend --	gen_context(system_u:object_r:cupsd_config_exec_t,s0)
 /usr/sbin/ptal-printd	--	gen_context(system_u:object_r:ptal_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.if serefpolicy-2.2.48/policy/modules/services/cups.if
--- nsaserefpolicy/policy/modules/services/cups.if	2006-03-23 14:33:30.000000000 -0500
+++ serefpolicy-2.2.48/policy/modules/services/cups.if	2006-06-20 10:16:12.000000000 -0400
@@ -40,7 +40,7 @@
 
 	files_search_pids($1)
 	allow $1 cupsd_var_run_t:dir search;
-	allow $1 cupsd_var_run_t:sock_file write;
+	allow $1 cupsd_var_run_t:sock_file { getattr write };
 	allow $1 cupsd_t:unix_stream_socket connectto;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.48/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-06-20 09:54:04.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/cups.te	2006-06-20 10:37:06.000000000 -0400
@@ -313,6 +313,7 @@
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
 allow cupsd_config_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_config_t self:tcp_socket create_stream_socket_perms;
+allow cupsd_config_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow cupsd_config_t cupsd_t:tcp_socket { connectto recvfrom };
 allow cupsd_t cupsd_config_t:tcp_socket { acceptfrom recvfrom };
@@ -342,6 +343,7 @@
 allow cupsd_config_t cupsd_rw_etc_t:lnk_file create_lnk_perms;
 files_var_filetrans(cupsd_config_t,cupsd_rw_etc_t,file)
 
+cups_stream_connect(cupsd_config_t)
 allow cupsd_config_t cupsd_var_run_t:file { getattr read };
 
 kernel_read_system_state(cupsd_config_t)
@@ -357,6 +359,7 @@
 
 dev_read_sysfs(cupsd_config_t)
 dev_read_urand(cupsd_config_t)
+dev_read_rand(cupsd_config_t)
 
 fs_getattr_all_fs(cupsd_config_t)
 fs_search_auto_mountpoints(cupsd_config_t)
@@ -395,6 +398,9 @@
 userdom_dontaudit_use_unpriv_user_fds(cupsd_config_t)
 userdom_dontaudit_search_sysadm_home_dirs(cupsd_config_t)
 
+allow cupsd_config_t cupsd_tmp_t:file create_file_perms;
+files_tmp_filetrans(cupsd_config_t, cupsd_tmp_t, { file dir })
+
 lpd_read_config(cupsd_config_t)
 
 ifdef(`distro_redhat',`
@@ -430,6 +436,7 @@
 
 optional_policy(`
 	hal_domtrans(cupsd_config_t)
+	hal_read_tmp_files(cupsd_config_t)
 ')
 
 optional_policy(`
@@ -593,6 +600,7 @@
 dev_read_sysfs(hplip_t)
 dev_rw_printer(hplip_t)
 dev_read_urand(hplip_t)
+dev_read_rand(hplip_t)
 dev_rw_generic_usb_dev(hplip_t)
 
 fs_getattr_all_fs(hplip_t)
@@ -646,6 +654,8 @@
 	udev_read_db(hplip_t)
 ')
 
+term_use_generic_ptys(hplip_t)
+
 ########################################
 #
 # PTAL local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.if serefpolicy-2.2.48/policy/modules/services/hal.if
--- nsaserefpolicy/policy/modules/services/hal.if	2006-03-23 14:33:30.000000000 -0500
+++ serefpolicy-2.2.48/policy/modules/services/hal.if	2006-06-20 10:16:13.000000000 -0400
@@ -140,3 +140,23 @@
 	files_search_pids($1)
 	allow $1 hald_var_run_t:file rw_file_perms;
 ')
+
+
+########################################
+## <summary>
+##	Read hald tmp files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_read_tmp_files',`
+	gen_require(`
+		type hald_tmp_t;
+	')
+
+	allow $1 hald_tmp_t:file r_file_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.2.48/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-06-06 22:21:54.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/mta.te	2006-06-20 10:16:13.000000000 -0400
@@ -195,8 +195,3 @@
 	')
 ')
 
-ifdef(`TODO',`
-# for the start script to run make -C /etc/mail
-allow initrc_t etc_mail_t:dir rw_dir_perms;
-allow initrc_t etc_mail_t:file create_file_perms;
-')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.48/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-06-13 07:03:44.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/networkmanager.te	2006-06-20 10:16:13.000000000 -0400
@@ -92,6 +92,7 @@
 logging_send_syslog_msg(NetworkManager_t)
 
 miscfiles_read_localization(NetworkManager_t)
+miscfiles_read_certs(NetworkManager_t)
 
 modutils_domtrans_insmod(NetworkManager_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-2.2.48/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2006-06-13 07:03:44.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/ntp.te	2006-06-20 10:16:13.000000000 -0400
@@ -62,6 +62,7 @@
 
 kernel_read_kernel_sysctls(ntpd_t)
 kernel_read_system_state(ntpd_t)
+kernel_read_network_state(ntpd_t)
 
 corenet_non_ipsec_sendrecv(ntpd_t)
 corenet_tcp_sendrecv_all_if(ntpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/openvpn.te serefpolicy-2.2.48/policy/modules/services/openvpn.te
--- nsaserefpolicy/policy/modules/services/openvpn.te	2006-06-06 22:21:55.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/openvpn.te	2006-06-20 10:37:57.000000000 -0400
@@ -44,6 +44,7 @@
 allow openvpn_t openvpn_var_run_t:file create_file_perms;
 files_pid_filetrans(openvpn_t, openvpn_var_run_t, file)
 
+kernel_read_kernel_sysctls(openvpn_t)
 kernel_read_net_sysctls(openvpn_t)
 kernel_read_network_state(openvpn_t)
 kernel_read_system_state(openvpn_t)
@@ -81,6 +82,8 @@
 
 sysnet_exec_ifconfig(openvpn_t)
 
+term_dontaudit_use_generic_ptys(openvpn_t)
+
 optional_policy(`
 	daemontools_service_domain(openvpn_t,openvpn_exec_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.if serefpolicy-2.2.48/policy/modules/services/pegasus.if
--- nsaserefpolicy/policy/modules/services/pegasus.if	2005-10-25 13:40:18.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/pegasus.if	2006-06-20 10:16:13.000000000 -0400
@@ -1 +1,32 @@
 ## <summary>The Open Group Pegasus CIM/WBEM Server.</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run pegasus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`pegasus_domtrans',`
+	gen_require(`
+		type pegasus_t, pegasus_exec_t;
+	')
+
+	ifdef(`targeted_policy',`
+		if(pegasus_disable_trans) {
+			can_exec($1,pegasus_exec_t)
+		} else {
+			domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+		}
+	', `
+		domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+	')
+
+	allow $1 pegasus_t:fd use;
+	allow pegasus_t $1:fd use;
+	allow pegasus_t $1:fifo_file rw_file_perms;
+	allow pegasus_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.2.48/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/pegasus.te	2006-06-20 10:16:13.000000000 -0400
@@ -100,13 +100,12 @@
 
 auth_use_nsswitch(pegasus_t)
 auth_domtrans_chk_passwd(pegasus_t)
+auth_read_shadow(pegasus_t)
 
 domain_use_interactive_fds(pegasus_t)
 domain_read_all_domains_state(pegasus_t)
 
-files_read_etc_files(pegasus_t)
-files_list_var_lib(pegasus_t)
-files_read_var_lib_files(pegasus_t)
+files_read_all_files(pegasus_t)
 files_read_var_lib_symlinks(pegasus_t)
 
 hostname_exec(pegasus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.if serefpolicy-2.2.48/policy/modules/services/postfix.if
--- nsaserefpolicy/policy/modules/services/postfix.if	2006-06-06 22:21:55.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/postfix.if	2006-06-20 10:16:13.000000000 -0400
@@ -459,3 +459,28 @@
 
 	typeattribute $1 postfix_user_domtrans;
 ')
+
+
+########################################
+## <summary>
+##	Execute the master postfix program in the
+##	postfix_master domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`postfix_domtrans_smtp',`
+	gen_require(`
+		type postfix_smtp_t, postfix_smtp_exec_t;
+	')
+
+	domain_auto_trans($1,postfix_smtp_exec_t,postfix_smtp_t)
+
+	allow $1 postfix_smtp_t:fd use;
+	allow postfix_smtp_t $1:fd use;
+	allow postfix_smtp_t $1:fifo_file rw_file_perms;
+	allow postfix_smtp_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.48/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/postfix.te	2006-06-20 10:16:13.000000000 -0400
@@ -456,6 +456,7 @@
 ')
 
 optional_policy(`
+	cron_system_entry(postfix_postdrop_t, postfix_postdrop_exec_t)
 	cron_use_fds(postfix_postdrop_t)
 	cron_rw_pipes(postfix_postdrop_t)
 	cron_use_system_job_fds(postfix_postdrop_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ppp.te serefpolicy-2.2.48/policy/modules/services/ppp.te
--- nsaserefpolicy/policy/modules/services/ppp.te	2006-06-06 22:21:55.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/ppp.te	2006-06-20 10:16:13.000000000 -0400
@@ -68,6 +68,7 @@
 allow pppd_t self:tcp_socket create_stream_socket_perms;
 allow pppd_t self:udp_socket { connect connected_socket_perms };
 allow pppd_t self:packet_socket create_socket_perms;
+allow pppd_t self:process signal;
 
 domain_auto_trans(pppd_t, pptp_exec_t, pptp_t)
 allow pppd_t pptp_t:fd use;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.2.48/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-06-13 07:03:44.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/procmail.te	2006-06-20 10:16:13.000000000 -0400
@@ -78,6 +78,7 @@
 
 optional_policy(`
 	clamav_domtrans_clamscan(procmail_t)
+	clamav_search_lib(procmail_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/tftp.te serefpolicy-2.2.48/policy/modules/services/tftp.te
--- nsaserefpolicy/policy/modules/services/tftp.te	2006-06-06 22:21:56.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/services/tftp.te	2006-06-20 10:16:13.000000000 -0400
@@ -78,6 +78,7 @@
 miscfiles_read_localization(tftpd_t)
 
 sysnet_read_config(tftpd_t)
+sysnet_use_ldap(tftpd_t)
 
 userdom_dontaudit_use_unpriv_user_fds(tftpd_t)
 userdom_dontaudit_use_sysadm_ttys(tftpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.if serefpolicy-2.2.48/policy/modules/system/authlogin.if
--- nsaserefpolicy/policy/modules/system/authlogin.if	2006-06-13 07:03:45.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/authlogin.if	2006-06-20 10:16:13.000000000 -0400
@@ -1292,6 +1292,7 @@
 
 	sysnet_dns_name_resolve($1)
 	sysnet_use_ldap($1)
+	miscfiles_read_certs($1)
 
 	optional_policy(`
 		nis_use_ypbind($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.2.48/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.48/policy/modules/system/hostname.te	2006-06-20 10:16:13.000000000 -0400
@@ -8,7 +8,10 @@
 
 type hostname_t;
 type hostname_exec_t;
-init_system_domain(hostname_t,hostname_exec_t)
+
+#dont transition from initrc
+domain_type(hostname_t)
+domain_entry_file(hostname_t,hostname_exec_t)
 role system_r types hostname_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.if serefpolicy-2.2.48/policy/modules/system/init.if
--- nsaserefpolicy/policy/modules/system/init.if	2006-06-06 22:21:56.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/init.if	2006-06-20 10:16:13.000000000 -0400
@@ -158,13 +158,6 @@
 	allow $1 initrc_t:fifo_file rw_file_perms;
 	allow $1 initrc_t:process sigchld;
 
-	ifdef(`hide_broken_symptoms',`
-		# RHEL4 systems seem to have a stray
-		# fds open from the initrd
-		ifdef(`distro_rhel4',`
-			kernel_dontaudit_use_fds($1)
-		')
-	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.48/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-06-08 23:00:33.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/init.te	2006-06-20 10:16:13.000000000 -0400
@@ -345,6 +345,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.48/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/libraries.fc	2006-06-20 10:16:13.000000000 -0400
@@ -121,7 +121,7 @@
 
 /usr/x11R6/lib/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xorg/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/xorg/modules/drivers/fglx_drv\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xorg/modules/drivers/fglrx_drv\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xorg/modules/extensions/nvidia(-[^/]*)?/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_redhat',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.48/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-06-06 22:21:56.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/mount.te	2006-06-20 10:16:13.000000000 -0400
@@ -111,6 +111,7 @@
 	tunable_policy(`allow_mount_anyfile',`
 		auth_read_all_dirs_except_shadow(mount_t)
 		auth_read_all_files_except_shadow(mount_t)
+		files_mounton_all_files(mount_t)
 	')
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.48/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-06-13 07:03:48.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/selinuxutil.te	2006-06-20 10:16:13.000000000 -0400
@@ -352,6 +352,8 @@
 kernel_relabelfrom_unlabeled_symlinks(restorecon_t)
 kernel_relabelfrom_unlabeled_pipes(restorecon_t)
 kernel_relabelfrom_unlabeled_sockets(restorecon_t)
+kernel_dontaudit_list_all_proc(restorecon_t)
+kernel_dontaudit_list_sysctls(restorecon_t)
 
 dev_relabel_all_dev_nodes(restorecon_t)
 # cjp: why is this needed?
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.fc serefpolicy-2.2.48/policy/modules/system/unconfined.fc
--- nsaserefpolicy/policy/modules/system/unconfined.fc	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/unconfined.fc	2006-06-20 10:16:13.000000000 -0400
@@ -7,4 +7,6 @@
 ifdef(`targeted_policy',`
 /usr/lib/openoffice.org.*/program/.*\.bin -- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
 /usr/bin/valgrind 	--	gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/local/RealPlay/realplay.bin --	gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/mplayer	 	--	gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.48/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-06-20 09:54:08.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/userdomain.if	2006-06-20 15:18:00.000000000 -0400
@@ -8,11 +8,10 @@
 ## <desc>
 ##	<p>
 ##	This template creates a user domain, types, and
-##	rules for the user's tty, pty, home directories,
-##	tmp, and tmpfs files.
+##	rules for the user's tty, pty, tmp, and tmpfs files.
 ##	</p>
 ##	<p>
-##	This generally should not be used, rather the
+##	This should only be used for new non login user roles, rather the
 ##	unpriv_user_template or admin_user_template should
 ##	be used.
 ##	</p>
@@ -25,7 +24,9 @@
 ## </param>
 #
 template(`base_user_template',`
-
+	gen_require(`
+		attribute userdomain, unpriv_userdomain;
+	')
 	attribute $1_file_type;
 
 	type $1_t, userdomain;
@@ -42,44 +43,17 @@
 	term_user_pty($1_t,$1_devpts_t)
 	files_type($1_devpts_t)
 
-	# type for contents of home directory
-	type $1_home_t, $1_file_type, home_type;
-	files_type($1_home_t)
-	files_associate_tmp($1_home_t)
-	fs_associate_tmpfs($1_home_t)
-
-	# type of home directory
-	type $1_home_dir_t, home_dir_type, home_type;
-	files_type($1_home_dir_t)
-	files_associate_tmp($1_home_dir_t)
-	fs_associate_tmpfs($1_home_dir_t)
-
 	type $1_tmp_t, $1_file_type;
 	files_tmp_file($1_tmp_t)
 
 	type $1_tmpfs_t;
 	files_tmpfs_file($1_tmpfs_t)
 
-	# types for network-obtained content
-	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
-	files_type($1_untrusted_content_t)
-	files_poly_member($1_untrusted_content_t)
-
-	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
-	files_tmp_file($1_untrusted_content_tmp_t)
-
 	type $1_tty_device_t; 
 	term_tty($1_t,$1_tty_device_t)
 
 	##############################
 	#
-	# User home directory file rules
-	#
-
-	allow $1_file_type $1_home_t:filesystem associate;
-
-	##############################
-	#
 	# User domain Local policy
 	#
 
@@ -103,19 +77,6 @@
 	dontaudit $1_t self:netlink_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
 	dontaudit $1_t self:netlink_route_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown nlmsg_read nlmsg_write };
 
-	# execute files in the home directory
-	can_exec($1_t,$1_home_t)
-
-	# full control of the home directory
-	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
-	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
-	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-	files_search_home($1_t)
-
 	can_exec($1_t,$1_tmp_t)
 
 	# user temporary files
@@ -138,13 +99,13 @@
 	fs_tmpfs_filetrans($1_t,$1_tmpfs_t, { dir notdevfile_class_set } )
 
 	allow $1_t $1_tty_device_t:chr_file { setattr rw_file_perms };
-
-	# Allow user to relabel untrusted content
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+	allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
+	term_create_pty($1_t,$1_devpts_t)
 
 	allow $1_t unpriv_userdomain:fd use;
 
+	kernel_read_system_state($1_t)
+	kernel_read_network_state($1_t)
 	kernel_read_kernel_sysctls($1_t)
 	kernel_read_net_sysctls($1_t)
 	kernel_dontaudit_list_unlabeled($1_t)
@@ -165,8 +126,10 @@
 
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
+	corenet_raw_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
+	corenet_raw_sendrecv_all_nodes($1_t)
 	corenet_udp_sendrecv_all_nodes($1_t)
 	corenet_tcp_sendrecv_all_ports($1_t)
 	corenet_udp_sendrecv_all_ports($1_t)
@@ -234,6 +197,10 @@
 	files_dontaudit_getattr_non_security_sockets($1_t)
 	files_dontaudit_getattr_non_security_blk_files($1_t)
 	files_dontaudit_getattr_non_security_chr_files($1_t)
+	files_read_etc_files($1_t)
+	files_read_etc_runtime_files($1_t)
+	files_read_usr_files($1_t)
+	files_exec_usr_files($1_t)
 
 	# Caused by su - init scripts
 	init_dontaudit_use_script_ptys($1_t)
@@ -254,16 +221,86 @@
 	seutil_read_default_contexts($1_t)
 	seutil_run_newrole($1_t,$1_r,{ $1_devpts_t $1_tty_device_t })
 
-	tunable_policy(`allow_execmem',`
-		# Allow loading DSOs that require executable stack.
-		allow $1_t self:process execmem;
-	')
+')
+#######################################
+## <summary>
+##	The template containing rules common to unprivileged
+##	users and administrative users.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a user home directories,
+##	</p>
+##	<p>
+##	This generally should not be used, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+#
+template(`base_login_user_template',`
 
-	tunable_policy(`allow_execmem && allow_execstack',`
-		# Allow making the stack executable via mprotect.
-		allow $1_t self:process execstack;
+	gen_require(`
+		attribute $1_file_type;
+		attribute home_dir_type, home_type;
+		attribute untrusted_content_type;
 	')
 
+	# type for contents of home directory
+	type $1_home_t, $1_file_type, home_type;
+	files_type($1_home_t)
+	files_associate_tmp($1_home_t)
+	fs_associate_tmpfs($1_home_t)
+
+	# type of home directory
+	type $1_home_dir_t, home_dir_type, home_type;
+	files_type($1_home_dir_t)
+	files_associate_tmp($1_home_dir_t)
+	fs_associate_tmpfs($1_home_dir_t)
+
+	# types for network-obtained content
+	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
+	files_type($1_untrusted_content_t)
+	files_poly_member($1_untrusted_content_t)
+
+	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
+	files_tmp_file($1_untrusted_content_tmp_t)
+
+	##############################
+	#
+	# User home directory file rules
+	#
+
+	allow $1_file_type $1_home_t:filesystem associate;
+
+	##############################
+	#
+	# User domain Local policy
+	#
+
+	# execute files in the home directory
+	can_exec($1_t,$1_home_t)
+
+	# full control of the home directory
+	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
+	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
+	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
+	files_search_home($1_t)
+
+	# Allow user to relabel untrusted content
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+
 	tunable_policy(`read_default_t',`
 		files_list_default($1_t)
 		files_read_default_files($1_t)
@@ -501,6 +538,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t unpriv_userdomain;
 	domain_interactive_fd($1_t)
@@ -521,9 +559,6 @@
 	# Local policy
 	#
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
 	# Rules used to associate a homedir as a mountpoint
 	allow $1_home_t self:filesystem associate;
 	allow $1_file_type $1_home_t:filesystem associate;
@@ -535,10 +570,6 @@
 	allow privhome $1_home_t:sock_file create_file_perms;
 	allow privhome $1_home_t:fifo_file create_file_perms;
 	type_transition privhome $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
-
 	dev_read_sysfs($1_t)
 
 	corecmd_exec_all_executables($1_t)
@@ -546,11 +577,8 @@
 	# port access is audited even if dac would not have allowed it, so dontaudit it here
 	corenet_dontaudit_tcp_bind_all_reserved_ports($1_t)
 
-	files_read_etc_files($1_t)
-	files_read_etc_runtime_files($1_t)
+
 	files_list_home($1_t)
-	files_read_usr_files($1_t)
-	files_exec_usr_files($1_t)
 	# Read directories and files with the readable_t type.
 	# This type is a general type for "world"-readable files.
 	files_list_world_readable($1_t)
@@ -558,8 +586,6 @@
 	files_read_world_readable_symlinks($1_t)
 	files_read_world_readable_pipes($1_t)
 	files_read_world_readable_sockets($1_t)
-	# cjp: why?
-	files_read_kernel_symbol_table($1_t)
 
 	init_read_utmp($1_t)
 	# The library functions always try to open read-write first,
@@ -748,6 +774,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t privhome;
 	domain_obj_id_change_exemption($1_t)
@@ -783,11 +810,6 @@
 
 	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
 	kernel_read_software_raid_state($1_t)
 	kernel_getattr_core_if($1_t)
 	kernel_getattr_message_if($1_t)
@@ -4128,7 +4150,7 @@
 	gen_require(`
 		type user_home_dir_t;
 	')
-
+	allow $1 user_home_dir_t:dir manage_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
@@ -4767,3 +4789,37 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
+
+########################################
+## <summary>
+##	The template containing rules for changing from one role to another
+## </summary>
+## <desc>
+##	<p>
+##	This should only be used for new non login user roles, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing from 
+##	</summary>
+## </param>
+## <summary>
+##	Unconfined access to user domains.
+## </summary>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing to
+##	</summary>
+## </param>
+#
+template(`role_change_template',`
+        allow $1_r $2_r;
+        type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
+        type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
+        # avoid annoying messages on terminal hangup
+        dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.48/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-06-13 07:03:49.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/userdomain.te	2006-06-20 15:04:12.000000000 -0400
@@ -56,14 +56,6 @@
 # Local policy
 #
 
-define(`role_change',`
-	allow $1_r $2_r;
-	type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
-	type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
-	# avoid annoying messages on terminal hangup
-	dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
-')
-
 ifdef(`targeted_policy',`
 	# Define some type aliases to help with compatibility with
 	# macros and domains from the "strict" policy.
@@ -124,34 +116,34 @@
 
 	# user role change rules:
 	# sysadm_r can change to user roles
-	role_change(sysadm, user)
-	role_change(sysadm, staff)
+	role_change_template(sysadm, user)
+	role_change_template(sysadm, staff)
 
 	# only staff_r can change to sysadm_r
-	role_change(staff, sysadm)
+	role_change_template(staff, sysadm)
 
 	ifdef(`enable_mls',`
 		unpriv_user_template(secadm)
 		unpriv_user_template(auditadm)
 
-		role_change(staff,auditadm)
-		role_change(staff,secadm)
+		role_change_template(staff,auditadm)
+		role_change_template(staff,secadm)
 
-		role_change(sysadm,secadm)
-		role_change(sysadm,auditadm)
+		role_change_template(sysadm,secadm)
+		role_change_template(sysadm,auditadm)
 
-		role_change(auditadm,secadm)
-		role_change(auditadm,sysadm)
+		role_change_template(auditadm,secadm)
+		role_change_template(auditadm,sysadm)
 
-		role_change(secadm,auditadm)
-		role_change(secadm,sysadm)
+		role_change_template(secadm,auditadm)
+		role_change_template(secadm,sysadm)
 	')
 
 	# this should be tunable_policy, but
 	# currently type_change and RBAC allow
 	# do not work in conditionals
 	ifdef(`user_canbe_sysadm',`
-		role_change(user,sysadm)
+		role_change_template(user,sysadm)
 	')
 
 	allow privhome home_root_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.2.48/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.48/policy/modules/system/xen.te	2006-06-20 10:16:13.000000000 -0400
@@ -68,7 +68,8 @@
 # xend local policy
 #
 
-allow xend_t self:capability { dac_override ipc_lock net_admin setuid sys_nice sys_tty_config };
+allow xend_t self:capability { dac_override ipc_lock net_admin setuid sys_nice sys_tty_config net_raw };
+
 allow xend_t self:process { signal sigkill };
 # internal communication is often done using fifo and unix sockets.
 allow xend_t self:fifo_file rw_file_perms;
@@ -168,6 +169,8 @@
 
 xen_stream_connect_xenstore(xend_t)
 
+netutils_domtrans(xend_t)
+
 optional_policy(`
 	consoletype_domtrans(xend_t)
 ')
@@ -255,7 +258,8 @@
 # xm local policy
 #
 
-allow xm_t self:capability { dac_override ipc_lock };
+allow xm_t self:capability { dac_override ipc_lock sys_tty_config };
+
 # internal communication is often done using fifo and unix sockets.
 allow xm_t self:fifo_file { read write };
 allow xm_t self:unix_stream_socket create_stream_socket_perms;
@@ -265,6 +269,9 @@
 allow xm_t xend_var_lib_t:file create_file_perms;
 files_search_var_lib(xm_t)
 
+allow xm_t xen_image_t:dir rw_dir_perms;
+allow xm_t xen_image_t:file r_file_perms;
+
 kernel_read_system_state(xm_t)
 kernel_read_kernel_sysctls(xm_t)
 kernel_read_xen_state(xm_t)
@@ -284,6 +291,7 @@
 term_use_all_terms(xm_t)
 
 init_rw_script_stream_sockets(xm_t)
+init_use_fds(xm_t)
 
 libs_use_ld_so(xm_t)
 libs_use_shared_libs(xm_t)

--------------040405090908060609010807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
