Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IFuIU9011702
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 11:56:18 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IFuH7v001770
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 15:56:17 GMT
Message-ID: <446C9926.5070802@redhat.com>
Date: Thu, 18 May 2006 11:56:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------030803090208000405020503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030803090208000405020503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add boolean allow_nfsd_anon_write to it can write to public_content_rw_t

Stop transition to consoletype from initrc_t.  Maybe we need an 
ifdef(targeted_policy)  But hostname and consoletype transitioning is a 
pain in the but.  Lots of init scripts do stuff like

consoletype >> MYLOG.log

prelink needs to be able to change the context even if the user part is 
different.

Added unconfined_execmem_exec_t so that I can change the global 
allow_execmem to off.  OpenOffice, valgrind and mplayer need it.  
Probably could eliminate java, and wine domain and change to this.

Additinional dontaudit for ioctl on terminals

Fixes for amavis domain

named needs access to ldap when running with nss_ldap  (Seems lots of 
domains need this if you set up nss_ldap.)

Allow bluetooth helper access to users homedir and tmp files.

cupsd_lpd_t wants to look at the routing table and communicate with the 
cupsd socket

Want to label cvs and rsync as being executables so sysadm_r can run 
them.  (No transition).

Hal wants to look at the kernel image file

nfs needs access to rand/urand probably caused by nss_ldap.

xfs wants to execute itself if it has greater than 10 displays.

xdm is creating .Xauthority file with wrong context.

auditadm_r which is running as SystemHigh wants to be able to restart 
auditd through init scripts.  So it needs to be able to 
mls_range_transition run_init down to SystemLow-SystemHigh

Major bug in that we were not running semanage and setsebool as 
semanage_t.  This is what is causing the mislabeled 
/etc/selinux/targeted/modules directory

semanage_t needed fixes so that setsebool and semanage could run.

More fixes for xen domain.

auditadm_ stuff, but I agree that this is still in flux so don't add it.


















--------------030803090208000405020503
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-strict-mls/default_type serefpolicy-2.2.41/config/appconfig-strict-mls/default_type
--- nsaserefpolicy/config/appconfig-strict-mls/default_type	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.41/config/appconfig-strict-mls/default_type	2006-05-18 11:41:22.000000000 -0400
@@ -2,3 +2,4 @@
 secadm_r:secadm_t
 staff_r:staff_t
 user_r:user_t
+auditadm_r:auditadm_t
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.2.41/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/global_tunables	2006-05-18 11:41:22.000000000 -0400
@@ -73,6 +73,14 @@
 
 ## <desc>
 ## <p>
+## Allow nfs servers to modify public files
+## used for public file transfer services.
+## </p>
+## </desc>
+gen_tunable(allow_nfsd_anon_write,false)
+
+## <desc>
+## <p>
 ## Allow java executable stack
 ## </p>
 ## </desc>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.2.41/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-04-04 18:06:37.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/admin/consoletype.te	2006-05-18 11:41:22.000000000 -0400
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
@@ -107,3 +112,12 @@
 optional_policy(`
 	userdom_use_unpriv_users_fds(consoletype_t)
 ')
+
+optional_policy(`
+	xen_append_log(consoletype_t)
+	xen_dontaudit_rw_unix_stream_sockets(consoletype_t)
+	kernel_read_xen_state(consoletype_t)
+	kernel_write_xen_state(consoletype_t)
+
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.te serefpolicy-2.2.41/policy/modules/admin/prelink.te
--- nsaserefpolicy/policy/modules/admin/prelink.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/admin/prelink.te	2006-05-18 11:41:22.000000000 -0400
@@ -48,6 +48,8 @@
 corecmd_mmap_all_executables(prelink_t)
 corecmd_read_sbin_symlinks(prelink_t)
 
+domain_obj_id_change_exemption(prelink_t)
+
 dev_read_urand(prelink_t)
 
 files_list_all(prelink_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.fc serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.fc
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.fc	2006-05-18 11:41:22.000000000 -0400
@@ -0,0 +1,3 @@
+/usr/lib/openoffice.org.*/program/.*\.bin	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/valgrind 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/mplayer 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.if serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.if
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.if	2006-05-18 11:41:22.000000000 -0400
@@ -0,0 +1,29 @@
+## <summary>Unconfined domain with execmem/execstack privs</summary>
+
+########################################
+## <summary>
+##	Execute the application that requires dexecmem program in the unconfined_execmem domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`unconfined_execmem_domtrans',`
+	ifdef(`targeted_policy',`
+		gen_require(`
+			type unconfined_execmem_t, unconfined_execmem_exec_t;
+		')
+
+		corecmd_search_bin($1)
+		domain_auto_trans($1, unconfined_execmem_exec_t, unconfined_execmem_t)
+
+		allow $1 unconfined_execmem_t:fd use;
+		allow unconfined_execmem_t $1:fd use;
+		allow unconfined_execmem_t $1:fifo_file rw_file_perms;
+		allow unconfined_execmem_t $1:process sigchld;
+	',`
+		errprint(`Warning: $0($1) has no effect in strict policy.'__endline__)
+	')
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.te serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.te
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/apps/unconfined_execmem.te	2006-05-18 11:41:42.000000000 -0400
@@ -0,0 +1,21 @@
+
+policy_module(unconfined_execmem,1.1.2)
+
+########################################
+#
+# Declarations
+#
+
+type unconfined_execmem_t;
+type unconfined_execmem_exec_t;
+init_system_domain(unconfined_execmem_t,unconfined_execmem_exec_t)
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow unconfined_execmem_t self:process { execstack execmem };
+	unconfined_domain_noaudit(unconfined_execmem_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.41/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/kernel/files.if	2006-05-18 11:41:22.000000000 -0400
@@ -1882,6 +1882,21 @@
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.41/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-04-29 11:17:34.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/kernel/kernel.te	2006-05-18 11:41:22.000000000 -0400
@@ -28,6 +28,7 @@
 
 ifdef(`enable_mls',`
 	role secadm_r;
+	role auditadm_r;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.41/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/kernel/mls.te	2006-05-18 11:41:22.000000000 -0400
@@ -64,4 +64,5 @@
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 range_transition initrc_t setrans_exec_t s15:c0.c255;
+range_transition run_init_t initrc_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.2.41/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-04-26 11:23:32.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/kernel/terminal.if	2006-05-18 11:41:22.000000000 -0400
@@ -430,7 +430,7 @@
 		type devpts_t;
 	')
 
-	dontaudit $1 devpts_t:chr_file { getattr read write };
+	dontaudit $1 devpts_t:chr_file { getattr read write ioctl };
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.fc serefpolicy-2.2.41/policy/modules/services/amavis.fc
--- nsaserefpolicy/policy/modules/services/amavis.fc	2006-03-07 16:19:28.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/services/amavis.fc	2006-05-18 11:41:22.000000000 -0400
@@ -9,3 +9,4 @@
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
 /var/run/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
+/var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.te serefpolicy-2.2.41/policy/modules/services/amavis.te
--- nsaserefpolicy/policy/modules/services/amavis.te	2006-05-05 16:44:48.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/amavis.te	2006-05-18 11:41:22.000000000 -0400
@@ -31,6 +31,9 @@
 type amavis_tmp_t;
 files_tmp_file(amavis_tmp_t)
 
+type amavis_spool_t;
+files_type(amavis_spool_t)
+
 # virus quarantine
 type amavis_quarantine_t;
 files_type(amavis_quarantine_t)
@@ -40,7 +43,7 @@
 # amavis local policy
 #
 
-allow amavis_t self:capability { chown dac_override setgid setuid };
+allow amavis_t self:capability { kill chown dac_override setgid setuid };
 dontaudit amavis_t self:capability sys_tty_config;
 allow amavis_t self:process { signal sigchld signull };
 allow amavis_t self:fifo_file rw_file_perms;
@@ -70,6 +73,11 @@
 files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
 files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
+# Spool Files
+files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
+allow amavis_t amavis_spool_t:dir manage_dir_perms;
+allow amavis_t amavis_spool_t:file manage_file_perms;
+
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
 allow amavis_t amavis_var_log_t:sock_file create_file_perms;
@@ -84,6 +92,7 @@
 
 # amavis tries to access /proc/self/stat, /etc/shadow and /root - perl...
 kernel_dontaudit_list_proc(amavis_t)
+kernel_dontaudit_read_system_state(amavis_t)
 
 # find perl
 corecmd_exec_bin(amavis_t)
@@ -115,6 +124,7 @@
 
 init_use_fds(amavis_t)
 init_use_script_ptys(amavis_t)
+init_stream_connect_script(amavis_t)
 
 libs_use_ld_so(amavis_t)
 libs_use_shared_libs(amavis_t)
@@ -132,10 +142,15 @@
 cron_use_system_job_fds(amavis_t)
 cron_rw_pipes(amavis_t)
 
+kernel_read_kernel_sysctls(amavis_t)
+
 mta_read_config(amavis_t)
 
+term_dontaudit_use_generic_ptys(amavis_t)
+
 optional_policy(`
 	clamav_stream_connect(amavis_t)
+	clamav_domtrans_clamscan(amavis_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bind.te serefpolicy-2.2.41/policy/modules/services/bind.te
--- nsaserefpolicy/policy/modules/services/bind.te	2006-05-17 16:57:08.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/bind.te	2006-05-18 11:41:22.000000000 -0400
@@ -125,6 +125,8 @@
 
 domain_use_interactive_fds(named_t)
 
+dev_read_urand(named_t)
+
 files_read_etc_files(named_t)
 files_read_etc_runtime_files(named_t)
 
@@ -137,6 +139,7 @@
 logging_send_syslog_msg(named_t)
 
 miscfiles_read_localization(named_t)
+miscfiles_read_certs(named_t)
 
 sysnet_read_config(named_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.41/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/bluetooth.te	2006-05-18 11:41:22.000000000 -0400
@@ -218,13 +218,14 @@
 
 	unconfined_stream_connect(bluetooth_helper_t)
 
-	userdom_read_all_users_home_content_files(bluetooth_helper_t)
+	userdom_manage_generic_user_home_content_files(bluetooth_helper_t)
 
 	optional_policy(`
 		xserver_stream_connect_xdm(bluetooth_helper_t)
 		xserver_use_xdm_fds(bluetooth_helper_t)
 		xserver_rw_xdm_pipes(bluetooth_helper_t)
 	')
+	files_manage_generic_tmp_files(bluetooth_helper_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.41/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-05-04 16:43:40.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/cups.te	2006-05-18 11:41:22.000000000 -0400
@@ -672,6 +672,7 @@
 allow cupsd_lpd_t self:fifo_file rw_file_perms;
 allow cupsd_lpd_t self:tcp_socket connected_stream_socket_perms;
 allow cupsd_lpd_t self:udp_socket create_socket_perms;
+allow cupsd_lpd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # for identd
 # cjp: this should probably only be inetd_child rules?
@@ -699,6 +700,8 @@
 allow cupsd_lpd_t cupsd_rw_etc_t:file r_file_perms;
 allow cupsd_lpd_t cupsd_rw_etc_t:lnk_file { getattr read };
 
+cups_stream_connect(cupsd_lpd_t)
+
 kernel_read_kernel_sysctls(cupsd_lpd_t)
 kernel_read_system_state(cupsd_lpd_t)
 kernel_read_network_state(cupsd_lpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.te serefpolicy-2.2.41/policy/modules/services/cvs.te
--- nsaserefpolicy/policy/modules/services/cvs.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/services/cvs.te	2006-05-18 11:41:22.000000000 -0400
@@ -8,6 +8,7 @@
 
 type cvs_t;
 type cvs_exec_t;
+corecmd_executable_file(cvs_exec_t)
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
 role system_r types cvs_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.41/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/hal.te	2006-05-18 11:41:22.000000000 -0400
@@ -93,6 +93,7 @@
 # hal is now execing pm-suspend
 files_create_boot_flag(hald_t)
 files_getattr_all_dirs(hald_t)
+files_read_kernel_img(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pyzor.fc serefpolicy-2.2.41/policy/modules/services/pyzor.fc
--- nsaserefpolicy/policy/modules/services/pyzor.fc	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/pyzor.fc	2006-05-18 11:41:22.000000000 -0400
@@ -5,3 +5,7 @@
 
 /var/lib/pyzord(/.*)?		gen_context(system_u:object_r:pyzor_var_lib_t,s0)
 /var/log/pyzord.log	--	gen_context(system_u:object_r:pyzord_log_t,s0)
+ifdef(`strict_policy',`
+HOME_DIR/\.pyzor(/.*)?		gen_context(system_u:object_r:ROLE_pyzor_home_t,s0)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rpc.te serefpolicy-2.2.41/policy/modules/services/rpc.te
--- nsaserefpolicy/policy/modules/services/rpc.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/rpc.te	2006-05-18 11:41:22.000000000 -0400
@@ -65,6 +65,8 @@
 files_manage_mounttab(rpcd_t)
 
 miscfiles_read_certs(rpcd_t)
+dev_read_urand(rpcd_t)
+dev_read_rand(rpcd_t)
 
 seutil_dontaudit_search_config(rpcd_t)
 
@@ -114,6 +116,12 @@
 portmap_tcp_connect(nfsd_t) 
 portmap_udp_chat(nfsd_t)
 
+# Access to public_content_t and public_content_rw_t
+miscfiles_read_public_files(nfsd_t)
+tunable_policy(`allow_nfsd_anon_write',`
+	miscfiles_manage_public_files(nfsd_t)
+') 
+
 tunable_policy(`nfs_export_all_rw',`
 	fs_read_noxattr_fs_files(nfsd_t) 
 	auth_manage_all_files_except_shadow(nfsd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-2.2.41/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2006-04-28 14:40:40.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/rsync.te	2006-05-18 11:41:22.000000000 -0400
@@ -8,6 +8,7 @@
 
 type rsync_t;
 type rsync_exec_t;
+corecmd_executable_file(rsync_exec_t)
 init_daemon_domain(rsync_t,rsync_exec_t)
 role system_r types rsync_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xfs.if serefpolicy-2.2.41/policy/modules/services/xfs.if
--- nsaserefpolicy/policy/modules/services/xfs.if	2006-02-10 17:05:19.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/services/xfs.if	2006-05-18 11:41:22.000000000 -0400
@@ -41,3 +41,22 @@
 	allow $1 xfs_tmp_t:sock_file write;
 	allow $1 xfs_t:unix_stream_socket connectto;
 ')
+
+
+########################################
+## <summary>
+##	Allow the specified domain to execute xfs
+##	in the caller domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xfs_exec',`
+	gen_require(`
+		type xfs_exec_t;
+	')
+	can_exec($1,xfs_exec_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xfs.te serefpolicy-2.2.41/policy/modules/services/xfs.te
--- nsaserefpolicy/policy/modules/services/xfs.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/xfs.te	2006-05-18 11:41:22.000000000 -0400
@@ -34,6 +34,7 @@
 allow xfs_t xfs_var_run_t:file create_file_perms;
 allow xfs_t xfs_var_run_t:dir rw_dir_perms;
 files_pid_filetrans(xfs_t,xfs_var_run_t,file)
+xfs_exec(xfs_t)
 
 # Bind to /tmp/.font-unix/fs-1.
 # cjp: I do not believe this has an effect.
@@ -49,6 +50,8 @@
 
 term_dontaudit_use_console(xfs_t)
 
+corecmd_list_bin(xfs_t)
+corecmd_list_sbin(xfs_t)
 domain_use_interactive_fds(xfs_t)
 
 files_read_etc_files(xfs_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.te serefpolicy-2.2.41/policy/modules/services/xserver.te
--- nsaserefpolicy/policy/modules/services/xserver.te	2006-04-19 17:43:32.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/services/xserver.te	2006-05-18 11:41:22.000000000 -0400
@@ -311,6 +311,8 @@
 	allow xdm_t self:process { execheap execmem };
 	unconfined_domain(xdm_t)
 	unconfined_domtrans(xdm_t)
+	userdom_generic_user_home_dir_filetrans_generic_user_home_content(xdm_t, {file dir })
+
 ')
 
 tunable_policy(`use_nfs_home_dirs',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.2.41/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.41/policy/modules/system/hostname.te	2006-05-18 11:41:22.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.41/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-05-12 16:31:53.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/init.te	2006-05-18 11:41:22.000000000 -0400
@@ -350,6 +350,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
@@ -374,6 +375,7 @@
 mls_process_read_up(initrc_t)
 mls_process_write_down(initrc_t)
 mls_rangetrans_source(initrc_t)
+mls_rangetrans_target(initrc_t)
 
 modutils_read_module_config(initrc_t)
 modutils_domtrans_insmod(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.41/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/logging.te	2006-05-18 11:41:22.000000000 -0400
@@ -14,10 +14,14 @@
 role system_r types auditctl_t;
 
 type auditd_etc_t;
+ifdef(`enable_mls',`', `
 files_security_file(auditd_etc_t)
+')
 
 type auditd_log_t;
+ifdef(`enable_mls',`', `
 files_security_file(auditd_log_t)
+')
 
 type auditd_t;
 # real declaration moved to mls until
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.41/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/selinuxutil.fc	2006-05-18 11:41:22.000000000 -0400
@@ -37,6 +37,8 @@
 /usr/sbin/run_init		--	gen_context(system_u:object_r:run_init_exec_t,s0)
 /usr/sbin/setfiles.*		--	gen_context(system_u:object_r:setfiles_exec_t,s0)
 /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
+/usr/sbin/setsebool		--	gen_context(system_u:object_r:semanage_exec_t,s0)
+/usr/sbin/semanage		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.41/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/selinuxutil.te	2006-05-18 11:41:22.000000000 -0400
@@ -447,7 +447,7 @@
 
 logging_send_syslog_msg(restorecond_t)
 
-miscfiles_read_localization(run_init_t)
+miscfiles_read_localization(restorecond_t)
 
 #################################
 #
@@ -461,6 +461,8 @@
 selinux_compute_relabel_context(run_init_t)
 selinux_compute_user_contexts(run_init_t)
 
+mls_rangetrans_source(run_init_t)
+
 ifdef(`direct_sysadm_daemon',`',`
 	ifdef(`distro_gentoo',`
 		# Gentoo integrated run_init:
@@ -526,6 +528,8 @@
 #
 
 allow semanage_t self:unix_stream_socket create_stream_socket_perms;
+allow semanage_t self:unix_dgram_socket create_socket_perms;
+allow semanage_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 allow semanage_t policy_config_t:file { read write };
 
@@ -535,10 +539,18 @@
 corecmd_exec_bin(semanage_t)
 corecmd_exec_sbin(semanage_t)
 
+dev_read_urand(semanage_t)
+
 files_read_etc_files(semanage_t)
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
 
+logging_send_syslog_msg(semanage_t)
+
+miscfiles_read_localization(semanage_t)
+
+selinux_set_boolean(semanage_t)
+
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
 mls_file_read_up(semanage_t)
@@ -551,8 +563,6 @@
 libs_use_shared_libs(semanage_t)
 libs_use_lib_files(semanage_t)
 
-miscfiles_read_localization(semanage_t)
-
 seutil_search_default_contexts(semanage_t)
 seutil_manage_file_contexts(semanage_t)
 seutil_manage_selinux_config(semanage_t)
@@ -565,10 +575,12 @@
 seutil_get_semanage_trans_lock(semanage_t)
 seutil_get_semanage_read_lock(semanage_t)
 
+userdom_search_sysadm_home_dirs(semanage_t)
+
 ifdef(`targeted_policy',`
 # Handle pp files created in homedir and /tmp
-	files_read_generic_tmp_files(semanage_t)
 	userdom_read_generic_user_home_content_files(semanage_t)
+	files_read_generic_tmp_files(semanage_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.te serefpolicy-2.2.41/policy/modules/system/setrans.te
--- nsaserefpolicy/policy/modules/system/setrans.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/setrans.te	2006-05-18 11:41:22.000000000 -0400
@@ -23,7 +23,8 @@
 # setrans local policy
 #
 
-allow setrans_t self:process { setcap signal_perms };
+allow setrans_t self:capability sys_resource;
+allow setrans_t self:process { setrlimit setcap signal_perms };
 allow setrans_t self:unix_stream_socket create_stream_socket_perms;
 allow setrans_t self:unix_dgram_socket create_socket_perms;
 allow setrans_t self:netlink_selinux_socket create_socket_perms;
@@ -57,6 +58,7 @@
 term_dontaudit_use_generic_ptys(setrans_t)
 
 init_use_fds(setrans_t)
+init_dontaudit_use_script_ptys(setrans_t)
 
 libs_use_ld_so(setrans_t)
 libs_use_shared_libs(setrans_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/sysnetwork.te serefpolicy-2.2.41/policy/modules/system/sysnetwork.te
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2006-05-17 16:57:08.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/sysnetwork.te	2006-05-18 11:41:22.000000000 -0400
@@ -249,6 +249,8 @@
 optional_policy(`
 	xen_append_log(dhcpc_t)
 	xen_dontaudit_rw_unix_stream_sockets(dhcpc_t)
+	kernel_read_xen_state(dhcpc_t)
+	kernel_write_xen_state(dhcpc_t)
 ')
 
 ########################################
@@ -351,4 +353,6 @@
 optional_policy(`
 	xen_append_log(ifconfig_t)
 	xen_dontaudit_rw_unix_stream_sockets(ifconfig_t)
+	kernel_read_xen_state(ifconfig_t)
+	kernel_write_xen_state(ifconfig_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.41/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/unconfined.te	2006-05-18 11:41:22.000000000 -0400
@@ -107,6 +107,10 @@
 	')
 
 	optional_policy(`
+		unconfined_execmem_domtrans(unconfined_t)
+	')
+
+	optional_policy(`
 		lpd_domtrans_checkpc(unconfined_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.41/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/userdomain.te	2006-05-18 11:41:22.000000000 -0400
@@ -6,6 +6,7 @@
 
 	ifdef(`enable_mls',`
 		role secadm_r;
+		role auditadm_r;
 	')
 ')
 
@@ -67,6 +68,7 @@
 	# Define some type aliases to help with compatibility with
 	# macros and domains from the "strict" policy.
 	unconfined_alias_domain(secadm_t)
+	unconfined_alias_domain(auditadm_t)
 	unconfined_alias_domain(sysadm_t)
 
 	# User home directory type.
@@ -82,6 +84,7 @@
 
 	# compatibility for switching from strict
 #	dominance { role secadm_r { role system_r; }}
+#	dominance { role auditadm_r { role system_r; }}
 #	dominance { role sysadm_r { role system_r; }}
 #	dominance { role user_r { role system_r; }}
 #	dominance { role staff_r { role system_r; }}
@@ -105,8 +108,10 @@
 
 	ifdef(`enable_mls',`
 		allow secadm_r system_r;
+		allow auditadm_r system_r;
 		allow secadm_r user_r;
 		allow staff_r secadm_r;
+		allow staff_r auditadm_r;
 	')
 
 	optional_policy(`
@@ -126,9 +131,21 @@
 	role_change(staff, sysadm)
 
 	ifdef(`enable_mls',`
-		admin_user_template(secadm)
+#		admin_user_template(secadm)
+#		admin_user_template(auditadm)
+		unpriv_user_template(secadm)
+		unpriv_user_template(auditadm)
+
+		role_change(staff,auditadm)
 		role_change(staff,secadm)
+
 		role_change(sysadm,secadm)
+		role_change(sysadm,auditadm)
+
+		role_change(auditadm,secadm)
+		role_change(auditadm,sysadm)
+
+		role_change(secadm,auditadm)
 		role_change(secadm,sysadm)
 	')
 
@@ -172,19 +189,33 @@
 	')
 
 	ifdef(`enable_mls',`
+		allow secadm_t self:capability dac_override;
 		corecmd_exec_shell(secadm_t)
 		mls_process_read_up(secadm_t)
+		mls_file_read_up(secadm_t)
 		mls_file_write_down(secadm_t)
 		mls_file_upgrade(secadm_t)
 		mls_file_downgrade(secadm_t)
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
-		logging_run_auditctl(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
-		files_relabel_all_files(secadm_t)
+	        auth_relabel_all_files_except_shadow(secadm_t)
 		auth_relabel_shadow(secadm_t)
+		domain_obj_id_change_exemption(secadm_t)
+	        logging_read_generic_logs(secadm_t)
+
+		seutil_run_runinit(auditadm_t, auditadm_r, { auditadm_tty_device_t auditadm_devpts_t })
+		domain_kill_all_domains(auditadm_t)
+	        seutil_read_bin_policy(auditadm_t)
+		corecmd_exec_shell(auditadm_t)
+	        logging_read_generic_logs(auditadm_t)
+		logging_manage_audit_log(auditadm_t)
+		logging_manage_audit_config(auditadm_t)
+		logging_run_auditctl(auditadm_t,auditadm_r,{ auditadm_tty_device_t auditadm_devpts_t })
+		logging_run_auditd(auditadm_t, auditadm_r, { auditadm_tty_device_t auditadm_devpts_t })
 	', `
-		logging_read_audit_log(sysadm_t)
+		logging_manage_audit_log(sysadm_t)
+		logging_manage_audit_config(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
 	')
 
@@ -248,6 +279,7 @@
 
 		ifdef(`enable_mls',`
 			consoletype_exec(secadm_t)
+			consoletype_exec(auditadm_t)
 		')
 	')
 
@@ -266,6 +298,7 @@
 
 		ifdef(`enable_mls',`
 			dmesg_exec(secadm_t)
+			dmesg_exec(auditadm_t)
 		')
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.fc serefpolicy-2.2.41/policy/modules/system/xen.fc
--- nsaserefpolicy/policy/modules/system/xen.fc	2006-05-03 16:01:26.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/xen.fc	2006-05-18 11:41:22.000000000 -0400
@@ -13,5 +13,6 @@
 
 /var/run/xenconsoled\.pid --	gen_context(system_u:object_r:xenconsoled_var_run_t,s0)
 /var/run/xend\.pid	--      gen_context(system_u:object_r:xend_var_run_t,s0)
+/var/run/xend(/.*)?		gen_context(system_u:object_r:xend_var_run_t,s0)
 /var/run/xenstore\.pid	--	gen_context(system_u:object_r:xenstored_var_run_t,s0)
 /var/run/xenstored(/.*)?	gen_context(system_u:object_r:xenstored_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.2.41/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-05-03 16:01:26.000000000 -0400
+++ serefpolicy-2.2.41/policy/modules/system/xen.te	2006-05-18 11:41:22.000000000 -0400
@@ -77,7 +77,7 @@
 # pid file
 allow xend_t xend_var_run_t:file manage_file_perms;
 allow xend_t xend_var_run_t:sock_file manage_file_perms;
-allow xend_t xend_var_run_t:dir rw_dir_perms;
+allow xend_t xend_var_run_t:dir { setattr rw_dir_perms };
 files_pid_filetrans(xend_t,xend_var_run_t, { file sock_file })
 
 # log files
@@ -92,6 +92,10 @@
 allow xend_t xend_var_lib_t:dir create_dir_perms;
 files_var_lib_filetrans(xend_t,xend_var_lib_t,{ file dir sock_file })
 
+optional_policy(`
+	consoletype_domtrans(xend_t)
+')
+
 # transition to store
 domain_auto_trans(xend_t, xenstored_exec_t, xenstored_t)
 allow xenstored_t xend_t:fd use;
@@ -153,8 +157,6 @@
 sysnet_delete_dhcpc_pid(xend_t)
 sysnet_read_dhcpc_pid(xend_t)
 
-consoletype_exec(xend_t)
-
 xen_stream_connect_xenstore(xend_t)
 
 ########################################
@@ -180,6 +182,7 @@
 
 term_create_pty(xenconsoled_t,xen_devpts_t);
 term_dontaudit_use_generic_ptys(xenconsoled_t)
+term_use_console(xenconsoled_t)
 
 init_use_fds(xenconsoled_t)
 
@@ -198,6 +201,7 @@
 
 allow xenstored_t self:capability { dac_override mknod ipc_lock };
 allow xenstored_t self:unix_stream_socket create_stream_socket_perms;
+allow xenstored_t self:unix_dgram_socket create_socket_perms;
 
 # pid file
 allow xenstored_t xenstored_var_run_t:file manage_file_perms;
@@ -220,12 +224,15 @@
 dev_rw_xen(xenstored_t)
 
 term_dontaudit_use_generic_ptys(xenstored_t)
+term_dontaudit_use_console(xenconsoled_t)
 
 init_use_fds(xenstored_t)
 
 libs_use_ld_so(xenstored_t)
 libs_use_shared_libs(xenstored_t)
 
+logging_send_syslog_msg(xenstored_t)
+
 miscfiles_read_localization(xenstored_t)
 
 xen_append_log(xenstored_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/rolemap serefpolicy-2.2.41/policy/rolemap
--- nsaserefpolicy/policy/rolemap	2006-01-26 15:38:41.000000000 -0500
+++ serefpolicy-2.2.41/policy/rolemap	2006-05-18 11:41:22.000000000 -0400
@@ -15,5 +15,6 @@
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
+		auditadm_r auditadm auditadm_t
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.41/policy/users
--- nsaserefpolicy/policy/users	2006-02-15 17:02:30.000000000 -0500
+++ serefpolicy-2.2.41/policy/users	2006-05-18 11:41:22.000000000 -0400
@@ -29,7 +29,7 @@
 gen_user(user_u, user, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 gen_user(user_u, user, user_r, s0, s0)
-gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r'), s0, s0 - s15:c0.c255, c0.c255)
+gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - s15:c0.c255, c0.c255)
 gen_user(sysadm_u, sysadm, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
@@ -44,8 +44,8 @@
 	gen_user(root, user, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r') system_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r') system_r, s0, s0 - s15:c0.c255, c0.c255)
 	',`
-		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r'), s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - s15:c0.c255, c0.c255)
 	')
 ')

--------------030803090208000405020503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
