Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0OLwPXf002348
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 16:58:25 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0OLwM7k029681
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 21:58:22 GMT
Message-ID: <43D6A307.4060801@redhat.com>
Date: Tue, 24 Jan 2006 16:58:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest  Diff
Content-Type: multipart/mixed;
 boundary="------------010502020409070602060105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010502020409070602060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alsa wants access to tty.
Also need to transiton from locallogin not pam_console.

kudzu wants to look at removable devices

prelink is writing files to /var/lib/misc
Also wants to read etc_t

readahead wants to read kcore and is not allowed to on MLS machine

lvm is putting up a symlink in tmpfs_t which a few domains want to read.

tmpreaper wants to look in the print spooler

slocate needs access to shared libraries, and localization files

automount wants to mount on /misc

cups seems to be looking for serial printers ???

dbus moved

I put some fixes in in order to build a default modules.conf file for 
strict policy.  Still needs lots of loving...

sulogin needs nscd

fixes for syslogd to work over the network

insmod needs to read file_context in order to setup removable_t

I want to eliminate sysadm_t from running "entry_point" applications.  
If a sysadm accidently starts a daemon, it will run under sysadm_t which 
could have dire ramifications in MLS/Strict policy

Fixes for users file for strict policy




--------------010502020409070602060105
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/alsa.te serefpolicy-2.2.5/policy/modules/admin/alsa.te
--- nsaserefpolicy/policy/modules/admin/alsa.te	2006-01-12 18:28:45.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/alsa.te	2006-01-24 13:48:54.000000000 -0500
@@ -34,6 +34,7 @@
 files_read_etc_files(alsa_t)
 
 term_use_generic_pty(alsa_t)
+term_dontaudit_use_unallocated_tty(alsa_t)
 
 libs_use_ld_so(alsa_t)
 libs_use_shared_libs(alsa_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/kudzu.te serefpolicy-2.2.5/policy/modules/admin/kudzu.te
--- nsaserefpolicy/policy/modules/admin/kudzu.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/kudzu.te	2006-01-24 13:54:24.000000000 -0500
@@ -73,6 +73,7 @@
 storage_read_tape_device(kudzu_t)
 storage_raw_write_fixed_disk(kudzu_t)
 storage_raw_read_fixed_disk(kudzu_t)
+storage_raw_read_removable_device(kudzu_t)
 
 term_search_ptys(kudzu_t)
 term_dontaudit_use_console(kudzu_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.fc serefpolicy-2.2.5/policy/modules/admin/prelink.fc
--- nsaserefpolicy/policy/modules/admin/prelink.fc	2006-01-11 18:41:32.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/prelink.fc	2006-01-24 12:45:29.000000000 -0500
@@ -4,3 +4,4 @@
 /usr/sbin/prelink(\.bin)?	--	gen_context(system_u:object_r:prelink_exec_t,s0)
 
 /var/log/prelink\.log		--	gen_context(system_u:object_r:prelink_log_t,s0)
+/var/lib/misc/prelink\.*	--	gen_context(system_u:object_r:prelink_cache_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.te serefpolicy-2.2.5/policy/modules/admin/prelink.te
--- nsaserefpolicy/policy/modules/admin/prelink.te	2006-01-13 17:06:02.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/prelink.te	2006-01-24 12:47:49.000000000 -0500
@@ -28,6 +28,7 @@
 
 allow prelink_t prelink_cache_t:file manage_file_perms;
 files_filetrans_etc(prelink_t, prelink_cache_t, file)
+files_filetrans_var_lib(prelink_t, prelink_cache_t, file)
 
 allow prelink_t prelink_log_t:dir { setattr rw_dir_perms };
 allow prelink_t prelink_log_t:file { create ra_file_perms };
@@ -58,6 +59,7 @@
 files_list_all(prelink_t)
 files_getattr_all_files(prelink_t)
 files_write_non_security_dir(prelink_t)
+files_read_etc_files(prelink_t)
 files_read_etc_runtime_files(prelink_t)
 
 fs_getattr_xattr_fs(prelink_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.2.5/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/readahead.te	2006-01-24 16:51:20.000000000 -0500
@@ -27,7 +27,7 @@
 
 kernel_read_kernel_sysctl(readahead_t)
 kernel_read_system_state(readahead_t)
-kernel_getattr_core(readahead_t)
+kernel_dontaudit_getattr_core(readahead_t)
 
 dev_read_sysfs(readahead_t)
 dev_getattr_generic_chr_file(readahead_t)
@@ -48,6 +48,7 @@
 fs_getattr_all_pipes(readahead_t)
 fs_getattr_all_files(readahead_t)
 fs_search_ramfs(readahead_t)
+fs_read_tmpfs_symlinks(readahead_t)
 
 term_dontaudit_use_console(readahead_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/tmpreaper.te serefpolicy-2.2.5/policy/modules/admin/tmpreaper.te
--- nsaserefpolicy/policy/modules/admin/tmpreaper.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/admin/tmpreaper.te	2006-01-24 12:53:38.000000000 -0500
@@ -44,6 +44,10 @@
 
 cron_system_entry(tmpreaper_t,tmpreaper_exec_t)
 
+optional_policy(`lpd',`
+	lpd_manage_spool(tmpreaper_t)
+')
+
 ifdef(`TODO',`
 allow tmpreaper_t { home_type file_t }:notdevfile_class_set { getattr unlink };
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/slocate.te serefpolicy-2.2.5/policy/modules/apps/slocate.te
--- nsaserefpolicy/policy/modules/apps/slocate.te	2006-01-16 13:55:42.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/apps/slocate.te	2006-01-24 13:16:12.000000000 -0500
@@ -34,13 +34,16 @@
 
 corecmd_exec_bin(locate_t)
 
+libs_use_shared_libs(locate_t)
+libs_use_ld_so(locate_t)
+
 files_list_all(locate_t)
 files_getattr_all_files(locate_t)
 files_read_etc_runtime_files(locate_t)
 files_read_etc_files(locate_t)
 
 fs_getattr_xattr_fs(locate_t)
-
+miscfiles_read_localization(locate_t)
 optional_policy(`cron',`
 	cron_system_entry(locate_t, locate_exec_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/bootloader.te serefpolicy-2.2.5/policy/modules/kernel/bootloader.te
--- nsaserefpolicy/policy/modules/kernel/bootloader.te	2006-01-19 10:00:40.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/kernel/bootloader.te	2006-01-24 12:28:24.000000000 -0500
@@ -115,6 +115,7 @@
 dev_read_raw_memory(bootloader_t)
 
 fs_getattr_xattr_fs(bootloader_t)
+fs_read_tmpfs_symlinks(bootloader_t)
 
 term_getattr_all_user_ttys(bootloader_t)
 term_dontaudit_manage_pty_dir(bootloader_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.5/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-01-19 10:00:40.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/kernel/files.if	2006-01-24 12:48:54.000000000 -0500
@@ -354,10 +354,12 @@
 		attribute file_type;
 		class dir search;
 		class file getattr;
+		class lnk_file getattr;
 	')
 
 	allow $1 file_type:dir search;
 	allow $1 file_type:file getattr;
+	allow $1 file_type:lnk_file getattr;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.5/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-01-20 10:02:32.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/kernel/filesystem.if	2006-01-24 13:39:15.000000000 -0500
@@ -2295,6 +2295,23 @@
 
 ########################################
 ## <summary>
+##	Read tmpfs link files.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`fs_read_tmpfs_symlinks',`
+	gen_require(`
+		type tmpfs_t;
+	')
+
+	fs_search_tmpfs($1)
+	allow $1 tmpfs_t:lnk_file read;
+')
+
+########################################
+## <summary>
 ##	Read and write character nodes on tmpfs filesystems.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.fc serefpolicy-2.2.5/policy/modules/services/automount.fc
--- nsaserefpolicy/policy/modules/services/automount.fc	2005-12-09 16:09:22.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/services/automount.fc	2006-01-24 11:56:59.000000000 -0500
@@ -14,3 +14,7 @@
 #
 
 /var/run/autofs(/.*)?		gen_context(system_u:object_r:automount_var_run_t,s0)
+#
+# /misc
+#
+/misc		-d 		gen_context(system_u:object_r:mnt_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.5/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-01-17 17:08:53.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/services/cups.te	2006-01-24 11:56:59.000000000 -0500
@@ -148,6 +148,7 @@
 fs_search_auto_mountpoints(cupsd_t)
 
 term_dontaudit_use_console(cupsd_t)
+term_write_unallocated_ttys(cupsd_t)
 
 auth_domtrans_chk_passwd(cupsd_t)
 auth_dontaudit_read_pam_pid(cupsd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.fc serefpolicy-2.2.5/policy/modules/services/dbus.fc
--- nsaserefpolicy/policy/modules/services/dbus.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/services/dbus.fc	2006-01-24 11:56:59.000000000 -0500
@@ -1,5 +1,6 @@
 /etc/dbus-1(/.*)?		gen_context(system_u:object_r:dbusd_etc_t,s0)
 
+# Sorting does not work correctly if I combine these next two roles
 /usr/bin/dbus-daemon(-1)? --	gen_context(system_u:object_r:system_dbusd_exec_t,s0)
-
+/bin/dbus-daemon 	--	gen_context(system_u:object_r:system_dbusd_exec_t,s0)
 /var/run/dbus(/.*)?		gen_context(system_u:object_r:system_dbusd_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.2.5/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/services/procmail.te	2006-01-24 13:19:41.000000000 -0500
@@ -66,6 +66,7 @@
 userdom_priveleged_home_dir_manager(procmail_t)
 # Do not audit attempts to access /root.
 userdom_dontaudit_search_sysadm_home_dir(procmail_t)
+userdom_dontaudit_search_staff_home_dir(procmail_t)
 
 mta_manage_spool(procmail_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.5/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-01-23 08:26:51.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/services/xserver.if	2006-01-24 11:56:59.000000000 -0500
@@ -6,6 +6,9 @@
 	#
 	# Declarations
 	#
+	gen_require(`
+		type xkb_var_lib_t, xserver_log_t;
+	')
 
 	type $1_xserver_t;
 	domain_type($1_xserver_t)
@@ -202,6 +205,12 @@
 	# Declarations
 	#
 
+	gen_require(`
+		type xauth_exec_t;
+		type xserver_exec_t;
+		type iceauth_exec_t;
+	')
+
 	xserver_common_domain_template($1)
 	role $3 types $1_xserver_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.2.5/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/authlogin.te	2006-01-24 13:17:33.000000000 -0500
@@ -221,10 +221,6 @@
 	files_dontaudit_read_root_file(pam_console_t)
 ')
 
-optional_policy(`alsa',`
-	alsa_domtrans(pam_console_t)
-')
-
 optional_policy(`gpm',`
 	gpm_getattr_gpmctl(pam_console_t)
 	gpm_setattr_gpmctl(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.5/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-01-17 17:08:56.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/fstools.te	2006-01-24 13:39:56.000000000 -0500
@@ -81,6 +81,7 @@
 # for /dev/shm
 fs_search_tmpfs(fsadm_t)
 fs_getattr_tmpfs_dir(fsadm_t)
+fs_read_tmpfs_symlinks(fsadm_t)
 
 mls_file_write_down(fsadm_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.2.5/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/locallogin.te	2006-01-24 13:17:56.000000000 -0500
@@ -210,13 +210,13 @@
 	usermanage_read_crack_db(local_login_t)
 ')
 
+optional_policy(`alsa',`
+	alsa_domtrans(local_login_t)
+')
+
 ifdef(`TODO',`
 # Login can polyinstantiate
 polyinstantiater(local_login_t)
-
-ifdef(`alsa.te', `
-domain_auto_trans($1_login_t, alsa_exec_t, alsa_t)
-')
 ') dnl endif TODO
 
 #################################
@@ -266,6 +266,10 @@
 ifdef(`distro_suse', `define(`sulogin_no_pam')')
 ifdef(`distro_debian', `define(`sulogin_no_pam')')
 
+optional_policy(`nscd',`
+	nscd_use_socket(sulogin_t)
+')
+
 ifdef(`sulogin_no_pam', `
 	allow sulogin_t self:capability sys_tty_config;
 	init_get_process_group(sulogin_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.5/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/logging.te	2006-01-24 11:56:59.000000000 -0500
@@ -98,10 +98,12 @@
 audit_manager_domain(secadm_t)
 
 ifdef(`targeted_policy', `', `
-ifdef(`separate_secadm', `', `
+ifdef(`enable_mls', `
+audit_manager_domain(secadm_t)
+', `
 audit_manager_domain(sysadm_t)
-allow auditctl_t admin_tty_type:chr_file rw_file_perms;
 ') 
+allow auditctl_t admin_tty_type:chr_file rw_file_perms;
 ')
 ') dnl end TODO
 
@@ -272,9 +274,6 @@
 # Create and bind to /dev/log or /var/run/log.
 allow syslogd_t devlog_t:sock_file create_file_perms;
 files_filetrans_pid(syslogd_t,devlog_t,sock_file)
-# cjp: I belive these are not needed:
-allow syslogd_t devlog_t:unix_stream_socket name_bind;
-allow syslogd_t devlog_t:unix_dgram_socket name_bind;
 
 # create/append log files.
 allow syslogd_t var_log_t:dir rw_dir_perms;
@@ -325,8 +324,7 @@
 corenet_non_ipsec_sendrecv(syslogd_t)
 corenet_udp_bind_all_nodes(syslogd_t)
 corenet_tcp_bind_syslogd_port(syslogd_t)
-#cjp: why?
-corenet_tcp_connect_rsh_port(syslogd_t)
+corenet_udp_bind_syslogd_port(syslogd_t)
 
 fs_getattr_all_fs(syslogd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-2.2.5/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2006-01-17 17:08:57.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/lvm.te	2006-01-24 13:39:43.000000000 -0500
@@ -198,6 +198,7 @@
 
 fs_getattr_xattr_fs(lvm_t)
 fs_search_auto_mountpoints(lvm_t)
+fs_read_tmpfs_symlinks(lvm_t)
 
 storage_relabel_fixed_disk(lvm_t)
 # LVM creates block devices in /dev/mapper or /dev/<vg>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/modutils.te serefpolicy-2.2.5/policy/modules/system/modutils.te
--- nsaserefpolicy/policy/modules/system/modutils.te	2006-01-13 17:06:08.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/modutils.te	2006-01-24 13:41:16.000000000 -0500
@@ -113,6 +113,8 @@
 
 miscfiles_read_localization(insmod_t)
 
+seutil_read_file_contexts(insmod_t)
+
 if( ! secure_mode_insmod ) {
 	kernel_userland_entry(insmod_t,insmod_exec_t)
 }
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.5/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-01-17 17:08:57.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/mount.te	2006-01-24 12:28:29.000000000 -0500
@@ -46,6 +46,7 @@
 fs_relabelfrom_all_fs(mount_t)
 fs_search_auto_mountpoints(mount_t)
 fs_use_tmpfs_chr_dev(mount_t)
+fs_read_tmpfs_symlinks(mount_t)
 
 term_use_all_terms(mount_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.5/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-01-23 08:26:51.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/userdomain.if	2006-01-24 13:20:21.000000000 -0500
@@ -219,7 +219,7 @@
 	corecmd_exec_sbin($1_t)
 	corecmd_exec_ls($1_t)
 
-	domain_exec_all_entry_files($1_t)
+#	domain_exec_all_entry_files($1_t)
 	domain_use_wide_inherit_fd($1_t)
 	# When the user domain runs ps, there will be a number of access
 	# denials when ps tries to search /proc.  Do not audit these denials.
@@ -533,6 +533,7 @@
 
 	typeattribute $1_t unpriv_userdomain;
 	domain_wide_inherit_fd($1_t)
+	domain_exec_all_entry_files($1_t)
 
 	typeattribute $1_devpts_t user_ptynode;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.5/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-01-19 10:00:42.000000000 -0500
+++ serefpolicy-2.2.5/policy/modules/system/userdomain.te	2006-01-24 13:52:39.000000000 -0500
@@ -145,6 +145,8 @@
 	allow sysadm_t user_home_dir_t:dir create_dir_perms;
 	files_filetrans_home(sysadm_t,user_home_dir_t)
 
+	corecmd_exec_shell(sysadm_t)
+
 	mls_process_read_up(sysadm_t)
 
 	logging_read_audit_log(sysadm_t)
@@ -214,6 +216,10 @@
 		hostname_run(sysadm_t,sysadm_r,admin_terminal)
 	')
 
+	optional_policy(`consoletype',`
+		consoletype_exec(sysadm_t)
+	')
+
 	optional_policy(`ipsec',`
 		# allow system administrator to use the ipsec script to look
 		# at things (e.g., ipsec auto --status)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.5/policy/users
--- nsaserefpolicy/policy/users	2006-01-20 10:02:31.000000000 -0500
+++ serefpolicy-2.2.5/policy/users	2006-01-24 11:56:59.000000000 -0500
@@ -27,7 +27,7 @@
 gen_user(user_u, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 gen_user(user_u, user_r, s0, s0)
-gen_user(staff_u, staff_r secadm_r sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(staff_u, staff_r ifdef(`enable_mls', `secadm_r')  sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 gen_user(sysadm_u, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
@@ -41,9 +41,6 @@
 ifdef(`targeted_policy',`
 	gen_user(root, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
-	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm_r staff_r secadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
-	',`
-		gen_user(root, sysadm_r staff_r secadm_r , s0, s0 - s15:c0.c255, c0.c255)
-	')
+	
+	gen_user(root, sysadm_r staff_r ifdef(`enable_mls',`secadm_r') ifdef(`direct_sysadm_daemon',`system_r'), s0, s0 - s15:c0.c255, c0.c255)
 ')

--------------010502020409070602060105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
