Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3KI5rD4032169
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 14:05:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3KI5qOt021619
	for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2006 18:05:52 GMT
Message-ID: <4447CD8B.6030704@redhat.com>
Date: Thu, 20 Apr 2006 14:06:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------000000050707040301060202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000000050707040301060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added and fixed Russells patch to add auditadm_r.

Give ping access to packed_socket.

useradd needs to create files in user_home_dir_t

File context for authconfig-tui

More fixes to allow xen to run

Fixes to allow pegasus to pass configuration testing.

Samba typo

pam_console uses all terminals

remove some .so defs from libraries.fc that are covered by others defs.





--------------000000050707040301060202
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-strict-mls/default_type serefpolicy-2.2.34/config/appconfig-strict-mls/default_type
--- nsaserefpolicy/config/appconfig-strict-mls/default_type	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.34/config/appconfig-strict-mls/default_type	2006-04-20 14:04:12.000000000 -0400
@@ -2,3 +2,4 @@
 secadm_r:secadm_t
 staff_r:staff_t
 user_r:user_t
+auditadm_r:auditadm_t
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.2.34/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2006-04-06 14:05:24.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/admin/netutils.te	2006-04-20 14:04:12.000000000 -0400
@@ -97,7 +97,7 @@
 
 allow ping_t self:tcp_socket create_socket_perms;
 allow ping_t self:udp_socket create_socket_perms;
-allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
+allow ping_t self:{ rawip_socket packet_socket } { create ioctl read write bind getopt setopt };
 
 corenet_tcp_sendrecv_all_if(ping_t)
 corenet_udp_sendrecv_all_if(ping_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.2.34/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/admin/usermanage.te	2006-04-20 14:04:12.000000000 -0400
@@ -514,6 +514,7 @@
 # Add/remove user home directories
 userdom_home_filetrans_generic_user_home_dir(useradd_t)
 userdom_manage_generic_user_home_content_dirs(useradd_t)
+userdom_manage_generic_user_home_content_files(useradd_t)
 userdom_manage_staff_home_dirs(useradd_t)
 userdom_generic_user_home_dir_filetrans_generic_user_home_content(useradd_t,notdevfile_class_set)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.2.34/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/kernel/corecommands.fc	2006-04-20 14:04:12.000000000 -0400
@@ -177,6 +177,7 @@
 ifdef(`distro_redhat', `
 /usr/lib/.*/program(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/share/authconfig/authconfig-gtk\.py -- gen_context(system_u:object_r:bin_t,s0)
+/usr/share/authconfig/authconfig-tui\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/cvs/contrib/rcs2log	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/share/hwbrowser/hwbrowser -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/pwlib/make/ptlib-config --	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/domain.te serefpolicy-2.2.34/policy/modules/kernel/domain.te
--- nsaserefpolicy/policy/modules/kernel/domain.te	2006-04-20 08:17:36.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/kernel/domain.te	2006-04-20 14:04:12.000000000 -0400
@@ -96,6 +96,7 @@
 	# workaround until role dominance is fixed in
 	# the module compiler
 	role secadm_r types domain;
+	role auditadm_r types domain;
 	role sysadm_r types domain;
 	role user_r types domain;
 	role staff_r types domain;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.34/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/kernel/files.if	2006-04-20 14:04:12.000000000 -0400
@@ -1679,6 +1679,21 @@
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
@@ -3905,3 +3920,23 @@
 
 	typeattribute $1 files_unconfined_type;
 ')
+
+########################################
+## <summary>
+##     Read kernel files in the /boot directory.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain allowed access.
+##     </summary>
+## </param>
+#
+interface(`files_read_kernel_img',`
+       gen_require(`
+               type boot_t;
+       ')
+
+       allow $1 boot_t:dir r_dir_perms;
+       allow $1 boot_t:file { getattr read };
+       allow $1 boot_t:lnk_file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.34/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/kernel/kernel.te	2006-04-20 14:04:12.000000000 -0400
@@ -28,6 +28,7 @@
 
 ifdef(`enable_mls',`
 	role secadm_r;
+	role auditadm_r;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.2.34/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-02-13 17:05:45.000000000 -0500
+++ serefpolicy-2.2.34/policy/modules/kernel/terminal.if	2006-04-20 14:04:12.000000000 -0400
@@ -174,7 +174,7 @@
 	')
 
 	dev_list_all_dev_nodes($1)
-	allow $1 console_device_t:chr_file write;
+	allow $1 console_device_t:chr_file { getattr write append };
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.2.34/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/services/pegasus.te	2006-04-20 14:04:12.000000000 -0400
@@ -79,11 +79,16 @@
 corenet_tcp_connect_pegasus_https_port(pegasus_t)
 corenet_tcp_connect_generic_port(pegasus_t)
 
+corecmd_exec_sbin(pegasus_t)
+corecmd_exec_bin(pegasus_t)
+corecmd_exec_shell(pegasus_t)
+
 dev_read_sysfs(pegasus_t)
 dev_read_urand(pegasus_t)
 
 fs_getattr_all_fs(pegasus_t)
 fs_search_auto_mountpoints(pegasus_t)
+files_getattr_all_dirs(pegasus_t)
 
 term_dontaudit_use_console(pegasus_t)
 
@@ -98,6 +103,8 @@
 files_read_var_lib_files(pegasus_t)
 files_read_var_lib_symlinks(pegasus_t)
 
+hostname_exec(pegasus_t)
+
 init_use_fds(pegasus_t)
 init_use_script_ptys(pegasus_t)
 init_rw_utmp(pegasus_t)
@@ -116,6 +123,7 @@
 	term_dontaudit_use_unallocated_ttys(pegasus_t)
 	term_dontaudit_use_generic_ptys(pegasus_t)
 	files_dontaudit_read_root_files(pegasus_t)
+	unconfined_signull(pegasus_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.34/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-04-19 12:23:07.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/services/samba.te	2006-04-20 14:04:12.000000000 -0400
@@ -106,8 +106,8 @@
 files_tmp_filetrans(samba_net_t, samba_net_tmp_t, { file dir })
 
 allow samba_net_t samba_var_t:dir rw_dir_perms;
+allow samba_net_t samba_var_t:file create_file_perms;
 allow samba_net_t samba_var_t:lnk_file create_lnk_perms;
-allow samba_net_t samba_var_t:file create_lnk_perms;
 
 kernel_read_proc_symlinks(samba_net_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.2.34/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-04-19 12:23:07.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/authlogin.te	2006-04-20 14:04:12.000000000 -0400
@@ -188,6 +188,8 @@
 storage_setattr_scsi_generic_dev(pam_console_t)
 
 term_use_console(pam_console_t)
+term_use_all_user_ttys(pam_console_t)
+term_use_all_user_ptys(pam_console_t)
 term_setattr_console(pam_console_t)
 term_getattr_unallocated_ttys(pam_console_t)
 term_setattr_unallocated_ttys(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.34/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-04-20 08:17:40.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/init.te	2006-04-20 14:04:12.000000000 -0400
@@ -348,6 +348,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.34/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-04-19 12:23:07.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/libraries.fc	2006-04-20 14:04:21.000000000 -0400
@@ -66,13 +66,8 @@
 
 /usr/(.*/)?nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/lib(64)?/pgsql/test/regress/.*\.so	--	gen_context(system_u:object_r:shlib_t,s0)
-
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr/lib(64)?/im/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
-/usr/lib(64)?/iiim/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
-
 /usr/(.*/)?lib(64)?(/.*)?/nvidia/.*\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -99,7 +94,6 @@
 /usr/lib(64)?/xorg/modules/extensions/nvidia(-[^/]*)?/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_redhat',`
-/usr/lib(64)?/.*/program/.*\.so.*		gen_context(system_u:object_r:shlib_t,s0)
 /usr/share/rhn/rhn_applet/eggtrayiconmodule\.so -- gen_context(system_u:object_r:shlib_t,s0)
 
 # The following are libraries with text relocations in need of execmod permissions
@@ -113,7 +107,7 @@
 /usr/lib(64)?/libstdc\+\+\.so\.2\.7\.2\.8 --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libg\+\+\.so\.2\.7\.2\.8	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libglide3\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/libglide-v[0-9]*\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libglide3-v[0-9]*\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libdv\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/helix/plugins/oggfformat\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/helix/plugins/theorarend\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -198,16 +192,12 @@
 /usr/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(.*/)?jre.*/libjvm.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/(.*/)?intellinux/nppdf\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr/(.*/)?intellinux/lib/\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr/(.*/)?intellinux/plug_ins/.*\.api	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(local/)?Adobe/(.*/)?intellinux/nppdf\.so	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(local/)?Adobe/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/(local/)?Adobe/.*\.api	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/(.*/)?intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 ') dnl end distro_redhat
 
-ifdef(`distro_suse',`
-/usr/lib(64)?/samba/classic/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:shlib_t,s0)
-')
-
 #
 # /var
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.34/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-04-06 15:32:43.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/logging.te	2006-04-20 14:04:12.000000000 -0400
@@ -140,7 +140,7 @@
 init_use_fds(auditd_t)
 init_exec(auditd_t)
 init_write_initctl(auditd_t)
-init_use_script_ptys(auditd_t)
+init_dontaudit_use_script_ptys(auditd_t)
 
 logging_send_syslog_msg(auditd_t)
 
@@ -293,7 +293,7 @@
 
 fs_search_auto_mountpoints(syslogd_t)
 
-term_dontaudit_use_console(syslogd_t)
+term_write_console(syslogd_t)
 # Allow syslog to a terminal
 term_write_unallocated_ttys(syslogd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/sysnetwork.te serefpolicy-2.2.34/policy/modules/system/sysnetwork.te
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2006-03-24 11:15:53.000000000 -0500
+++ serefpolicy-2.2.34/policy/modules/system/sysnetwork.te	2006-04-20 14:04:12.000000000 -0400
@@ -248,6 +248,7 @@
 
 optional_policy(`
 	xen_append_log(dhcpc_t)
+	xen_dontaudit_rw_unix_stream_sockets(dhcpc_t)
 ')
 
 ########################################
@@ -346,4 +347,5 @@
 
 optional_policy(`
 	xen_append_log(ifconfig_t)
+	xen_dontaudit_rw_unix_stream_sockets(ifconfig_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.34/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-04-12 13:44:38.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/unconfined.if	2006-04-20 14:04:12.000000000 -0400
@@ -224,6 +224,24 @@
 
 ########################################
 ## <summary>
+##	Send a SIGNULL signal to the unconfined domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`unconfined_signull',`
+	gen_require(`
+		type unconfined_t;
+	')
+
+	allow $1 unconfined_t:process signull;
+')
+
+########################################
+## <summary>
 ##	Send generic signals to the unconfined domain.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.34/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-04-20 08:17:40.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/userdomain.te	2006-04-20 14:04:12.000000000 -0400
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
@@ -105,9 +108,10 @@
 
 	ifdef(`enable_mls',`
 		allow secadm_r system_r;
+		allow auditadm_r system_r;
 		allow secadm_r user_r;
-		allow user_r secadm_r;
 		allow staff_r secadm_r;
+		allow staff_r auditadm_r;
 	')
 
 	optional_policy(`
@@ -128,8 +132,19 @@
 
 	ifdef(`enable_mls',`
 		admin_user_template(secadm)
+		admin_user_template(auditadm)
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
+		role_change(secadm,sysadm)
 	')
 
 	# this should be tunable_policy, but
@@ -179,10 +194,13 @@
 		mls_file_downgrade(secadm_t)
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
-		logging_run_auditctl(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
 		files_relabel_all_files(secadm_t)
 		auth_relabel_shadow(secadm_t)
+
+		corecmd_exec_shell(auditadm_t)
+		logging_read_audit_log(auditadm_t)
+		logging_run_auditctl(auditadm_t,auditadm_r,{ auditadm_tty_device_t auditadm_devpts_t })
 	', `
 		logging_read_audit_log(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
@@ -236,6 +254,7 @@
 
 		ifdef(`enable_mls',`
 			consoletype_exec(secadm_t)
+			consoletype_exec(auditadm_t)
 		')
 	')
 
@@ -248,6 +267,7 @@
 
 		ifdef(`enable_mls',`
 			dmesg_exec(secadm_t)
+			dmesg_exec(auditadm_t)
 		')
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.if serefpolicy-2.2.34/policy/modules/system/xen.if
--- nsaserefpolicy/policy/modules/system/xen.if	2006-03-23 16:08:51.000000000 -0500
+++ serefpolicy-2.2.34/policy/modules/system/xen.if	2006-04-20 14:04:12.000000000 -0400
@@ -47,6 +47,24 @@
 
 ########################################
 ## <summary>
+##     Don't audit leaked file descriptor.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain to don't audit.
+##     </summary>
+## </param>
+#
+interface(`xen_dontaudit_rw_unix_stream_sockets',`
+       gen_require(`
+               type xend_t;
+       ')
+
+       dontaudit $1 xend_t:unix_stream_socket { read write };
+')
+
+########################################
+## <summary>
 ##	Connect to xenstored over an unix stream socket.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.2.34/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-04-18 22:50:01.000000000 -0400
+++ serefpolicy-2.2.34/policy/modules/system/xen.te	2006-04-20 14:04:12.000000000 -0400
@@ -125,6 +125,7 @@
 
 files_read_etc_files(xend_t)
 files_read_kernel_symbol_table(xend_t)
+files_read_kernel_img(xend_t)
 
 storage_raw_read_fixed_disk(xend_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/rolemap serefpolicy-2.2.34/policy/rolemap
--- nsaserefpolicy/policy/rolemap	2006-01-26 15:38:41.000000000 -0500
+++ serefpolicy-2.2.34/policy/rolemap	2006-04-20 14:04:12.000000000 -0400
@@ -15,5 +15,6 @@
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
+		auditadm_t auditadm auditadm_t
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.34/policy/users
--- nsaserefpolicy/policy/users	2006-02-15 17:02:30.000000000 -0500
+++ serefpolicy-2.2.34/policy/users	2006-04-20 14:04:12.000000000 -0400
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

--------------000000050707040301060202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
