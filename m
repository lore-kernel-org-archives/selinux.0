Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJkifD025838
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:46:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PJjdAk011756
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:45:41 GMT
Message-ID: <45183220.8090106@redhat.com>
Date: Mon, 25 Sep 2006 15:46:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs.  Trimmed down this time.
Content-Type: multipart/mixed;
 boundary="------------010600080008070608040403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010600080008070608040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Unlinking the /etc/prelink.cache file requires ability
allow $1 etc_t:dir rw_dir_perms;

slocate needs to getattr on rpc_pipefs

mdadm does a getattr on everything in /dev.  Need to dontaudit 
device_t:file getattr;

Adding a cron_var_lib_t and cron_log_t so that sysadm_cron_t can write 
to these directories.
Policy explains which scripts need these privs

Additional lpr_exec_t applications

Corrected oddjob policy


Sendmail needs to read netlink_route_socket

Switch fsdaemon to mls_read_up

Doesn't ssh need
+       userdom_search_all_users_home_dirs(sshd_t)


Cups init script wants to clear the error_log

auditd_log_t is supposed to be able to have a device mounted on it for 
compliance reasons.

mdadm wants to getattr_core_if


--------------010600080008070608040403
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.if serefpolicy-2.3.16/policy/modules/admin/prelink.if
--- nsaserefpolicy/policy/modules/admin/prelink.if	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/prelink.if	2006-09-25 15:27:25.000000000 -0400
@@ -76,7 +76,7 @@
 	gen_require(`
 		type prelink_cache_t;
 	')
-
+	files_rw_etc_dir($1)
 	allow $1 prelink_cache_t:file unlink;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.3.16/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/readahead.te	2006-09-25 15:27:25.000000000 -0400
@@ -36,6 +36,8 @@
 dev_getattr_all_blk_files(readahead_t)
 dev_dontaudit_read_all_blk_files(readahead_t)
 dev_dontaudit_getattr_memory_dev(readahead_t)
+dev_dontaudit_getattr_nvram(readahead_t)
+storage_dontaudit_getattr_fixed_disk_dev(readahead_t)
 
 domain_use_interactive_fds(readahead_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/slocate.te serefpolicy-2.3.16/policy/modules/apps/slocate.te
--- nsaserefpolicy/policy/modules/apps/slocate.te	2006-07-14 17:04:31.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/apps/slocate.te	2006-09-25 15:27:25.000000000 -0400
@@ -45,6 +45,7 @@
 files_dontaudit_getattr_all_dirs(locate_t)
 
 fs_getattr_xattr_fs(locate_t)
+fs_getattr_rpc_pipefs(locate_t)
 
 libs_use_shared_libs(locate_t)
 libs_use_ld_so(locate_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.3.16/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-09-22 09:35:44.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/devices.if	2006-09-25 15:27:25.000000000 -0400
@@ -3211,3 +3211,23 @@
 
 	typeattribute $1 devices_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	dontaudit getattr generic files in /dev.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`dev_dontaudit_getattr_generic_files',`
+	gen_require(`
+		type device_t;
+	')
+
+	allow $1 device_t:dir search;
+	dontaudit $1 device_t:file getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.3.16/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-09-22 14:07:03.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/files.if	2006-09-25 15:27:25.000000000 -0400
@@ -4541,3 +4541,23 @@
 
 	typealias etc_runtime_t alias $1;
 ')
+
+########################################
+## <summary>
+##	Read and write files in /etc.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`files_rw_etc_dir',`
+	gen_require(`
+		type etc_t;
+	')
+
+	allow $1 etc_t:dir rw_dir_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/storage.if serefpolicy-2.3.16/policy/modules/kernel/storage.if
--- nsaserefpolicy/policy/modules/kernel/storage.if	2006-07-14 17:04:29.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/storage.if	2006-09-25 15:27:25.000000000 -0400
@@ -37,6 +37,7 @@
 	')
 
 	dontaudit $1 fixed_disk_device_t:blk_file getattr;
+	dontaudit $1 fixed_disk_device_t:chr_file getattr; # /dev/rawctl
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.3.16/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-09-22 14:07:05.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/automount.te	2006-09-25 15:27:25.000000000 -0400
@@ -74,6 +76,7 @@
 files_mounton_all_mountpoints(automount_t)
 files_mount_all_file_type_fs(automount_t)
 files_unmount_all_file_type_fs(automount_t)
+files_manage_non_security_dirs(automount_t)
 
 fs_mount_all_fs(automount_t)
 fs_unmount_all_fs(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.3.16/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/cron.te	2006-09-25 15:27:25.000000000 -0400
@@ -17,6 +17,14 @@
 type cron_spool_t;
 files_type(cron_spool_t)
 
+# var/lib files
+type cron_var_lib_t;
+files_type(cron_var_lib_t)
+
+# var/log files
+type cron_log_t;
+logging_log_file(cron_log_t)
+
 type crond_t;
 # real declaration moved to mls until
 # range_transition works in loadable modules
@@ -184,6 +192,17 @@
 	files_tmp_filetrans(crond_t, crond_tmp_t, { file dir })
 ')
 
+# This is to handle /var/lib/misc directory.  Used currently by prelink
+# var/lib files for cron 
+allow system_crond_t cron_var_lib_t:file create_file_perms;
+files_var_lib_filetrans(system_crond_t,cron_var_lib_t,file)
+
+# This is to handle creation of files in /var/log directory.  Used currently by rpm script
+# log files
+allow system_crond_t cron_log_t:file create_file_perms;
+logging_log_filetrans(system_crond_t,cron_log_t,{ file })
+
+
 tunable_policy(`fcron_crond', `
 	allow crond_t system_cron_spool_t:file create_file_perms;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/lpd.fc serefpolicy-2.3.16/policy/modules/services/lpd.fc
--- nsaserefpolicy/policy/modules/services/lpd.fc	2006-09-22 14:07:06.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/lpd.fc	2006-09-25 15:27:25.000000000 -0400
@@ -8,11 +8,14 @@
 #
 /usr/sbin/checkpc	--	gen_context(system_u:object_r:checkpc_exec_t,s0)
 /usr/sbin/lpd		--	gen_context(system_u:object_r:lpd_exec_t,s0)
+/usr/sbin/lpadmin	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/sbin/lpc(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/share/printconf/.* --	gen_context(system_u:object_r:printconf_t,s0)
 /usr/bin/lp(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/bin/lpr(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/bin/lpq(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/bin/lprm(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lpstat(\.cups)? --	gen_context(system_u:object_r:lpr_exec_t,s0)
 
 #
 # /var
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.fc serefpolicy-2.3.16/policy/modules/services/oddjob.fc
--- nsaserefpolicy/policy/modules/services/oddjob.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/services/oddjob.fc	2006-09-25 15:27:25.000000000 -0400
@@ -0,0 +1,8 @@
+# oddjob executable will have:
+# label: system_u:object_r:oddjob_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/sbin/oddjobd		--	gen_context(system_u:object_r:oddjob_exec_t,s0)
+/var/run/oddjobd.pid			gen_context(system_u:object_r:oddjob_var_run_t,s0)
+/usr/lib/oddjob/mkhomedir	--	gen_context(system_u:object_r:oddjob_mkhomedir_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.if serefpolicy-2.3.16/policy/modules/services/oddjob.if
--- nsaserefpolicy/policy/modules/services/oddjob.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/services/oddjob.if	2006-09-25 15:27:25.000000000 -0400
@@ -0,0 +1,99 @@
+## <summary>policy for oddjob</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run oddjob.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`oddjob_domtrans',`
+	gen_require(`
+		type oddjob_t, oddjob_exec_t;
+	')
+
+	domain_auto_trans($1,oddjob_exec_t,oddjob_t)
+
+	allow $1 oddjob_t:fd use;
+	allow oddjob_t $1:fd use;
+	allow oddjob_t $1:fifo_file rw_file_perms;
+	allow oddjob_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Make the specified program domain accessable
+##	from the oddjob.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process to transition to.
+##	</summary>
+## </param>
+## <param name="entrypoint">
+##	<summary>
+##	The type of the file used as an entrypoint to this domain.
+##	</summary>
+## </param>
+#
+interface(`oddjob_system_entry',`
+	gen_require(`
+		type oddjob_t;
+	')
+
+	domain_auto_trans(oddjob_t, $2, $1)
+
+	allow oddjob_t $1:fd use;
+	allow $1 oddjob_t:fd use;
+	allow $1 oddjob_t:fifo_file rw_file_perms;
+	allow $1 oddjob_t:process sigchld;
+
+')
+
+
+########################################
+## <summary>
+##	Send and receive messages from
+##	oddjob over dbus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`oddjob_dbus_chat',`
+	gen_require(`
+		type oddjob_t;
+		class dbus send_msg;
+	')
+
+	allow $1 oddjob_t:dbus send_msg;
+	allow oddjob_t $1:dbus send_msg;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run oddjob_mkhomedir.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`oddjob_mkhomedir_domtrans',`
+	gen_require(`
+		type oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t;
+	')
+
+	domain_auto_trans($1,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)
+
+	allow $1 oddjob_mkhomedir_t:fd use;
+	allow oddjob_mkhomedir_t $1:fd use;
+	allow oddjob_mkhomedir_t $1:fifo_file rw_file_perms;
+	allow oddjob_mkhomedir_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.te serefpolicy-2.3.16/policy/modules/services/oddjob.te
--- nsaserefpolicy/policy/modules/services/oddjob.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/services/oddjob.te	2006-09-25 15:27:25.000000000 -0400
@@ -0,0 +1,85 @@
+policy_module(oddjob,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type oddjob_t;
+type oddjob_exec_t;
+domain_type(oddjob_t)
+init_daemon_domain(oddjob_t, oddjob_exec_t)
+
+# pid files
+type oddjob_var_run_t;
+files_pid_file(oddjob_var_run_t)
+
+type oddjob_mkhomedir_t;
+type oddjob_mkhomedir_exec_t;
+domain_type(oddjob_mkhomedir_t)
+init_daemon_domain(oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t)
+
+########################################
+#
+# oddjob local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(oddjob_t)
+libs_use_ld_so(oddjob_t)
+libs_use_shared_libs(oddjob_t)
+miscfiles_read_localization(oddjob_t)
+## internal communication is often done using fifo and unix sockets.
+allow oddjob_t self:fifo_file { read write };
+allow oddjob_t self:unix_stream_socket create_stream_socket_perms;
+
+# pid file
+allow oddjob_t oddjob_var_run_t:file manage_file_perms;
+allow oddjob_t oddjob_var_run_t:sock_file manage_file_perms;
+allow oddjob_t oddjob_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(oddjob_t,oddjob_var_run_t, { file sock_file })
+
+init_dontaudit_use_fds(oddjob_t)
+allow oddjob_t self:capability { audit_write setgid } ;
+allow oddjob_t self:process setexec;
+
+locallogin_dontaudit_use_fds(oddjob_t)
+
+optional_policy(`
+	dbus_system_bus_client_template(oddjob,oddjob_t)
+	dbus_send_system_bus(oddjob_t)
+	dbus_connect_system_bus(oddjob_t)
+')
+
+corecmd_search_sbin(oddjob_t)
+corecmd_exec_shell(oddjob_t)
+
+selinux_compute_create_context(oddjob_t)
+
+kernel_read_system_state(oddjob_t)
+
+unconfined_domtrans(oddjob_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_generic_ptys(oddjob_t)
+	term_dontaudit_use_unallocated_ttys(oddjob_t)
+')
+
+########################################
+#
+# oddjob_mkhomedir local policy
+#
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(oddjob_mkhomedir_t)
+libs_use_ld_so(oddjob_mkhomedir_t)
+libs_use_shared_libs(oddjob_mkhomedir_t)
+miscfiles_read_localization(oddjob_mkhomedir_t)
+## internal communication is often done using fifo and unix sockets.
+allow oddjob_mkhomedir_t self:fifo_file { read write };
+allow oddjob_mkhomedir_t self:unix_stream_socket create_stream_socket_perms;
+
+oddjob_system_entry(oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t)
+domain_auto_trans(unconfined_t,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sendmail.te serefpolicy-2.3.16/policy/modules/services/sendmail.te
--- nsaserefpolicy/policy/modules/services/sendmail.te	2006-09-22 14:07:06.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/sendmail.te	2006-09-25 15:27:25.000000000 -0400
@@ -32,6 +32,7 @@
 allow sendmail_t self:unix_dgram_socket create_socket_perms;
 allow sendmail_t self:tcp_socket create_stream_socket_perms;
 allow sendmail_t self:udp_socket create_socket_perms;
+allow sendmail_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow sendmail_t sendmail_log_t:file create_file_perms;
 allow sendmail_t sendmail_log_t:dir { rw_dir_perms setattr };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/smartmon.te serefpolicy-2.3.16/policy/modules/services/smartmon.te
--- nsaserefpolicy/policy/modules/services/smartmon.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/smartmon.te	2006-09-25 15:30:14.000000000 -0400
@@ -60,8 +60,11 @@
 fs_getattr_all_fs(fsdaemon_t)
 fs_search_auto_mountpoints(fsdaemon_t)
 
+mls_file_read_up(fsdaemon_t)
+
 storage_raw_read_fixed_disk(fsdaemon_t)
 storage_raw_write_fixed_disk(fsdaemon_t)
+storage_raw_read_removable_device(fsdaemon_t)
 
 term_dontaudit_use_console(fsdaemon_t)
 term_dontaudit_search_ptys(fsdaemon_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.te serefpolicy-2.3.16/policy/modules/services/ssh.te
--- nsaserefpolicy/policy/modules/services/ssh.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/ssh.te	2006-09-25 15:27:25.000000000 -0400
@@ -72,18 +72,19 @@
 	# so a tunnel can point to another ssh tunnel
 	allow sshd_t self:netlink_route_socket r_netlink_socket_perms;
 	allow sshd_t self:key { search link write };
-
 	allow sshd_t sshd_tmp_t:dir create_dir_perms;
 	allow sshd_t sshd_tmp_t:file create_file_perms;
 	allow sshd_t sshd_tmp_t:sock_file create_file_perms;
 	files_tmp_filetrans(sshd_t, sshd_tmp_t, { dir file sock_file })
 
-	kernel_link_key(sshd_t)
-
 	# for X forwarding
 	corenet_tcp_bind_xserver_port(sshd_t)
 	corenet_sendrecv_xserver_server_packets(sshd_t)
 
+	kernel_link_key(sshd_t)
+
+	userdom_search_all_users_home_dirs(sshd_t)
+
 	tunable_policy(`ssh_sysadm_login',`
 		# Relabel and access ptys created by sshd
 		# ioctl is necessary for logout() processing for utmp entry and for w to
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.3.16/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/init.te	2006-09-25 15:27:25.000000000 -0400
@@ -579,6 +580,8 @@
 	dev_getattr_printer_dev(initrc_t)
 
 	cups_read_log(initrc_t)
+#cups init script clears error log
+	cups_write_log(initrc_t)
 	cups_read_rw_config(initrc_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.3.16/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/logging.te	2006-09-25 15:27:25.000000000 -0400
@@ -18,6 +18,7 @@
 
 type auditd_log_t;
 files_security_file(auditd_log_t)
+files_mountpoint(auditd_log_t)
 
 type auditd_t;
 # real declaration moved to mls until
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/raid.te serefpolicy-2.3.16/policy/modules/system/raid.te
--- nsaserefpolicy/policy/modules/system/raid.te	2006-07-14 17:04:44.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/raid.te	2006-09-25 15:27:25.000000000 -0400
@@ -29,11 +29,13 @@
 kernel_read_system_state(mdadm_t)
 kernel_read_kernel_sysctls(mdadm_t)
 kernel_rw_software_raid_state(mdadm_t)
+kernel_getattr_core_if(mdadm_t)
 
 dev_read_sysfs(mdadm_t)
 # Ignore attempts to read every device file
 dev_dontaudit_getattr_all_blk_files(mdadm_t)
 dev_dontaudit_getattr_all_chr_files(mdadm_t)
+dev_dontaudit_getattr_generic_files(mdadm_t)
 
 fs_search_auto_mountpoints(mdadm_t)
 fs_dontaudit_list_tmpfs(mdadm_t)

--------------010600080008070608040403--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
