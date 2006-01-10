Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0AFm5Xf012811
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 10:48:05 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0AFl0Il011465
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 15:47:00 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k0AFlCZO018328
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 10:47:12 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k0AFlCXu018327
	for selinux@tycho.nsa.gov; Tue, 10 Jan 2006 10:47:12 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0AEFkXf011589
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 09:15:46 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0AEEfIl027345
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 14:14:41 GMT
Message-ID: <43C3C187.50502@redhat.com>
Date: Tue, 10 Jan 2006 09:15:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------050806040901040007080304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050806040901040007080304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Includes prelink changes

Lots of new kernel_read_proc_devices which was needed for the latest 
rawhide.

Fixes for readahead

Fixes for su, vpnc, automount

policy to allow java, wine to run with allow_execmem/allow_execmod 
turned off on a targeted policy machine.

Lots of changes to allow cron to transition to appropriate domains when 
running helper apps.

hal relocated it's heler apps,  needs access to fs_sysctl and needs mls 
read up.  Also hal now creates and delete directories in /media

Add locate and logwatch policy

Fixes for sendmail

Fixes to allow NetworkManager_vpnc to work

Major changes to hostname policy.  Basically I don't want anything 
except dhcpc to transition to hostname domain.  Everything else should 
just executed it.  You don't need the extra privs and stuff like 
redirection causes to many problems

hostname >> /tmp/mymachine


Remove some privs from initrc required for readahead

Change file context to add back the /usr/lib(64)? for x86_64 machines.

Add secadm_r to users files

I might have accidentally reversed some of your fixes.  When the patches 
get large it is sometimes hard to handle conflicts.

Dan




--------------050806040901040007080304
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.8/Makefile
--- nsaserefpolicy/Makefile	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/Makefile	2006-01-09 14:37:14.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.te serefpolicy-2.1.8/policy/modules/admin/amanda.te
--- nsaserefpolicy/policy/modules/admin/amanda.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/amanda.te	2006-01-09 14:37:14.000000000 -0500
@@ -165,6 +165,10 @@
 
 sysnet_read_config(amanda_t)
 
+optional_policy(`prelink', `
+	prelink_relabel(amanda_usr_lib_t)
+')
+
 optional_policy(`authlogin',`
 	auth_read_shadow(amanda_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.1.8/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/consoletype.te	2006-01-09 14:37:14.000000000 -0500
@@ -38,6 +38,7 @@
 
 kernel_use_fd(consoletype_t)
 kernel_dontaudit_read_system_state(consoletype_t)
+kernel_read_proc_devices(consoletype_t)
 
 fs_getattr_all_fs(consoletype_t)
 fs_search_auto_mountpoints(consoletype_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.1.8/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/netutils.te	2006-01-09 14:37:14.000000000 -0500
@@ -42,6 +42,7 @@
 files_create_tmp_files(netutils_t, netutils_tmp_t, { file dir })
 
 kernel_search_proc(netutils_t)
+kernel_read_proc_devices(netutils_t)
 
 corenet_tcp_sendrecv_all_if(netutils_t)
 corenet_raw_sendrecv_all_if(netutils_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/readahead.te serefpolicy-2.1.8/policy/modules/admin/readahead.te
--- nsaserefpolicy/policy/modules/admin/readahead.te	2006-01-04 16:55:14.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/readahead.te	2006-01-09 23:09:17.000000000 -0500
@@ -27,6 +27,7 @@
 
 kernel_read_kernel_sysctl(readahead_t)
 kernel_read_system_state(readahead_t)
+kernel_getattr_core(readahead_t)
 
 dev_read_sysfs(readahead_t)
 dev_getattr_generic_chr_file(readahead_t)
@@ -43,6 +44,8 @@
 
 fs_getattr_all_fs(readahead_t)
 fs_search_auto_mountpoints(readahead_t)
+fs_getattr_all_pipes(readahead_t)
+fs_getattr_all_files(readahead_t)
 
 term_dontaudit_use_console(readahead_t)
 
@@ -50,6 +53,7 @@
 
 init_use_fd(readahead_t)
 init_use_script_pty(readahead_t)
+init_getattr_initctl(readahead_t)
 
 libs_use_ld_so(readahead_t)
 libs_use_shared_libs(readahead_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.1.8/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/su.if	2006-01-09 14:37:14.000000000 -0500
@@ -193,7 +193,9 @@
 	domain_use_wide_inherit_fd($1_su_t)
 
 	files_read_etc_files($1_su_t)
+	files_read_etc_runtime_files($1_su_t)
 	files_search_var_lib($1_su_t)
+	files_dontaudit_getattr_tmp_dir($1_su_t)
 
 	init_dontaudit_use_fd($1_su_t)
 	# Write to utmp.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/vpn.te serefpolicy-2.1.8/policy/modules/admin/vpn.te
--- nsaserefpolicy/policy/modules/admin/vpn.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/admin/vpn.te	2006-01-09 14:37:14.000000000 -0500
@@ -24,6 +24,7 @@
 #
 
 allow vpnc_t self:capability { net_admin ipc_lock net_raw };
+allow vpnc_t self:process getsched;
 allow vpnc_t self:fifo_file { getattr ioctl read write };
 allow vpnc_t self:netlink_route_socket rw_netlink_socket_perms;
 allow vpnc_t self:tcp_socket create_stream_socket_perms;
@@ -88,6 +89,8 @@
 libs_use_ld_so(vpnc_t)
 libs_use_shared_libs(vpnc_t)
 
+logging_send_syslog_msg(vpnc_t)
+
 miscfiles_read_localization(vpnc_t)
 
 seutil_dontaudit_search_config(vpnc_t)
@@ -110,3 +113,7 @@
 optional_policy(`nscd',`
 	nscd_use_socket(vpnc_t)
 ')
+
+optional_policy(`dbus',`
+	dbus_system_bus_client_template(vpnc,vpnc_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.1.8/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/java.fc	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,4 @@
+
+/usr/.*/java	--	gen_context(system_u:object_r:java_exec_t,s0)
+/usr/bin/gij	--	gen_context(system_u:object_r:java_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.if serefpolicy-2.1.8/policy/modules/apps/java.if
--- nsaserefpolicy/policy/modules/apps/java.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/java.if	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,23 @@
+## <summary>Load keyboard mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the java program in the java domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`java_domtrans',`
+	gen_require(`
+		type java_t, java_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, java_exec_t, java_t)
+
+	allow $1 java_t:fd use;
+	allow java_t $1:fd use;
+	allow java_t $1:fifo_file rw_file_perms;
+	allow java_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.te serefpolicy-2.1.8/policy/modules/apps/java.te
--- nsaserefpolicy/policy/modules/apps/java.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/java.te	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,25 @@
+policy_module(java,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type java_t;
+domain_type(java_t)
+
+type java_exec_t;
+domain_entry_file(java_t,java_exec_t)
+
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow java_t self:process execmem;
+	unconfined_domain_template(java_t)
+	unconfined_domtrans(java_t)
+	role system_r types java_t;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.fc serefpolicy-2.1.8/policy/modules/apps/wine.fc
--- nsaserefpolicy/policy/modules/apps/wine.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/wine.fc	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,2 @@
+/usr/bin/wine	--	gen_context(system_u:object_r:wine_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.if serefpolicy-2.1.8/policy/modules/apps/wine.if
--- nsaserefpolicy/policy/modules/apps/wine.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/wine.if	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,23 @@
+## <summary>Load keyboard mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the wine program in the wine domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`wine_domtrans',`
+	gen_require(`
+		type wine_t, wine_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, wine_exec_t, wine_t)
+
+	allow $1 wine_t:fd use;
+	allow wine_t $1:fd use;
+	allow wine_t $1:fifo_file rw_file_perms;
+	allow wine_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.te serefpolicy-2.1.8/policy/modules/apps/wine.te
--- nsaserefpolicy/policy/modules/apps/wine.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/apps/wine.te	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,27 @@
+policy_module(wine,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type wine_t;
+domain_type(wine_t)
+
+type wine_exec_t;
+domain_entry_file(wine_t,wine_exec_t)
+
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow wine_t self:process execmem;
+	unconfined_domain_template(wine_t)
+	unconfined_domtrans(wine_t)
+	role system_r types wine_t;
+	allow wine_t file_type:file execmod;
+
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.te serefpolicy-2.1.8/policy/modules/kernel/corecommands.te
--- nsaserefpolicy/policy/modules/kernel/corecommands.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/corecommands.te	2006-01-09 14:37:14.000000000 -0500
@@ -35,3 +35,9 @@
 
 type chroot_exec_t;
 files_type(chroot_exec_t)
+
+optional_policy(`prelink', `
+	prelink_relabel({ sbin_t bin_t })
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/domain.if serefpolicy-2.1.8/policy/modules/kernel/domain.if
--- nsaserefpolicy/policy/modules/kernel/domain.if	2005-12-12 15:35:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/domain.if	2006-01-09 17:23:08.000000000 -0500
@@ -501,6 +501,7 @@
 	')
 
 	dontaudit $1 domain:dir search_dir_perms;
+	dontaudit $1 domain:{ file lnk_file } r_file_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/domain.te serefpolicy-2.1.8/policy/modules/kernel/domain.te
--- nsaserefpolicy/policy/modules/kernel/domain.te	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/domain.te	2006-01-09 14:37:14.000000000 -0500
@@ -67,3 +67,7 @@
 # cjp: also need to except correctly for SEFramework
 neverallow { domain unlabeled_t } file_type:process *;
 neverallow ~{ domain unlabeled_t } *:process *;
+
+optional_policy(`prelink', `
+	prelink_relabel(entry_type)
+')
\ No newline at end of file
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.1.8/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-01-04 17:28:52.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/files.if	2006-01-09 14:37:14.000000000 -0500
@@ -3183,3 +3183,20 @@
 		')
 	')
 ')
+
+
+########################################
+## <summary>
+##	Allow attempts to modify any directory
+## </summary>
+## <param name="domain">
+##	Domain to allow
+## </param>
+#
+interface(`files_write_non_security_dir',`
+	gen_require(`
+		attribute file_type, security_file_type;
+	')
+
+	allow $1 file_type:dir write;
+')
\ No newline at end of file
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.1.8/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/kernel.if	2006-01-09 14:37:14.000000000 -0500
@@ -662,6 +662,27 @@
 	allow $1 proc_mdstat_t:file rw_file_perms;
 ')
 
+#######################################
+## <summary>
+##	Allow caller to read the state information for device node numbers.
+## </summary>
+## <param name="domain">
+##	The process type reading device number state.
+## </param>
+#
+interface(`kernel_read_proc_devices',`
+	gen_require(`
+		type proc_t, proc_devices_t;
+		class dir r_dir_perms;
+		class file r_file_perms;
+	')
+
+	allow $1 kernel_t:fd use;
+	allow $1 device_t:chr_file getattr;
+	allow $1 proc_t:dir r_dir_perms;
+	allow $1 proc_devices_t:file r_file_perms;
+')
+
 ########################################
 ## <summary>
 ##	Allows caller to get attribues of core kernel interface.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.1.8/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/kernel.te	2006-01-09 14:37:14.000000000 -0500
@@ -72,6 +72,9 @@
 type proc_mdstat_t, proc_type;
 genfscon proc /mdstat gen_context(system_u:object_r:proc_mdstat_t,s0)
 
+type proc_devices_t, proc_type;
+genfscon proc /devices gen_context(system_u:object_r:proc_devices_t,s0)
+
 type proc_net_t, proc_type;
 genfscon proc /net gen_context(system_u:object_r:proc_net_t,s0)
 
@@ -184,6 +187,8 @@
 allow kernel_t proc_net_t:dir r_dir_perms;
 allow kernel_t proc_net_t:file r_file_perms;
 allow kernel_t proc_mdstat_t:file r_file_perms;
+allow kernel_t proc_devices_t:file r_file_perms;
+allow kernel_t proc_devices_t:file { read };
 allow kernel_t proc_kcore_t:file getattr;
 allow kernel_t proc_kmsg_t:file getattr;
 allow kernel_t sysctl_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.1.8/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/kernel/mls.te	2006-01-09 14:37:14.000000000 -0500
@@ -82,9 +82,11 @@
 # these might be targeted_policy only
 range_transition unconfined_t su_exec_t s0 - s0:c0.c255;
 range_transition unconfined_t initrc_exec_t s0;
+range_transition unconfined_t ping_exec_t s0;
 ')
 
 ifdef(`enable_mls',`
 # run init with maximum MLS range
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
+range_transition initrc_t auditd_exec_t s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.1.8/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2005-12-12 23:05:35.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/apache.te	2006-01-09 14:37:14.000000000 -0500
@@ -391,6 +391,10 @@
 	userdom_dontaudit_use_sysadm_terms(httpd_t)
 ')
 
+optional_policy(`prelink', `
+	prelink_relabel(httpd_modules_t)
+')
+
 optional_policy(`kerberos',`
 	kerberos_use(httpd_t)
 ')
@@ -685,3 +689,8 @@
 optional_policy(`nscd',`
 	nscd_use_socket(httpd_unconfined_script_t)
 ')
+
+optional_policy(`crond',`
+	cron_system_entry(httpd_t, httpd_exec_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.te serefpolicy-2.1.8/policy/modules/services/apm.te
--- nsaserefpolicy/policy/modules/services/apm.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/apm.te	2006-01-09 14:37:14.000000000 -0500
@@ -196,6 +196,7 @@
 ')
 
 optional_policy(`cron',`
+	cron_system_entry(apmd_t, apmd_exec_t)
 	cron_domtrans_anacron_system_job(apmd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.1.8/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/automount.te	2006-01-09 14:37:14.000000000 -0500
@@ -28,7 +28,7 @@
 # Local policy
 #
 
-allow automount_t self:capability { sys_nice dac_override };
+allow automount_t self:capability { net_bind_service sys_nice dac_override };
 dontaudit automount_t self:capability sys_tty_config;
 allow automount_t self:process { signal_perms getpgid setpgid setsched };
 allow automount_t self:fifo_file rw_file_perms;
@@ -80,7 +80,9 @@
 corenet_udp_sendrecv_all_ports(automount_t)
 corenet_tcp_bind_all_nodes(automount_t)
 corenet_udp_bind_all_nodes(automount_t)
+
 corenet_tcp_connect_portmap_port(automount_t)
+corenet_tcp_connect_all_ports(automount_t)
 corenet_dontaudit_tcp_connect_all_reserved_ports(automount_t)
 
 dev_read_sysfs(automount_t)
@@ -143,6 +145,11 @@
 	fstools_domtrans(automount_t)
 ')
 
+optional_policy(`bind',`
+	allow automount_t named_conf_t:dir search;
+	allow automount_t named_zone_t:dir search;
+')
+
 optional_policy(`nis',`
 	nis_use_ypbind(automount_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.1.8/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/bluetooth.te	2006-01-09 14:37:14.000000000 -0500
@@ -86,6 +86,7 @@
 
 kernel_read_kernel_sysctl(bluetooth_t)
 kernel_read_system_state(bluetooth_t)
+kernel_read_proc_devices(bluetooth_t)
 
 corenet_tcp_sendrecv_all_if(bluetooth_t)
 corenet_udp_sendrecv_all_if(bluetooth_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.1.8/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/cron.te	2006-01-09 14:37:14.000000000 -0500
@@ -407,43 +407,21 @@
 		sysstat_manage_log(system_crond_t)
 	')
 
+
+	optional_policy(`mta',`
+		dontaudit system_mail_t crond_t:fifo_file write;
+	')
+
 	ifdef(`TODO',`
 	dontaudit userdomain system_crond_t:fd use;
 
-	# Do not audit attempts to search unlabeled directories (e.g. slocate).
-	dontaudit system_crond_t unlabeled_t:dir r_dir_perms;
-	dontaudit system_crond_t unlabeled_t:file r_file_perms;
-
 	allow system_crond_t { sysfs_t rpc_pipefs_t }:dir getattr;
 
-	# Write to /var/lib/slocate.db.
-	allow system_crond_t var_lib_t:dir rw_dir_perms;
-	allow system_crond_t var_lib_t:file create_file_perms;
-
 	# for if /var/mail is a symlink
 	allow system_crond_t mail_spool_t:lnk_file read;
 
-	#
-	#  These rules are here to allow system cron jobs to su
-	#
-	ifdef(`su.te', `
-	su_restricted_domain(system_crond,system)
-	role system_r types system_crond_su_t;
-	allow system_crond_su_t crond_t:fifo_file ioctl;
-	')
-
-	#
-	# Required for webalizer
-	#
-	ifdef(`apache.te', `
-	allow system_crond_t { httpd_log_t httpd_config_t }:file r_file_perms;
-	')
-
 	ifdef(`mta.te', `
 	mta_send_mail_transition(system_crond_t)
-
-	# system_mail_t should only be reading from the cron fifo not needing to write
-	dontaudit system_mail_t crond_t:fifo_file write;
 	allow mta_user_agent system_crond_t:fd use;
 	r_dir_file(system_mail_t, crond_tmp_t)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.1.8/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-01-09 11:32:53.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/cups.te	2006-01-09 14:37:14.000000000 -0500
@@ -201,8 +201,7 @@
 ')
 
 optional_policy(`cron',`
-	cron_use_fd(cupsd_t)
-	cron_read_pipe(cupsd_t)
+	cron_system_entry(cupsd_t, cupsd_exec_t)
 ')
 
 optional_policy(`dbus',`
@@ -580,8 +579,7 @@
 ')
 
 optional_policy(`cron',`
-	cron_use_system_job_fd(cupsd_config_t)
-	cron_read_pipe(cupsd_config_t)
+	cron_system_entry(cupsd_config_t, cupsd_config_exec_t)
 ')
 
 optional_policy(`dbus',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.1.8/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/dovecot.te	2006-01-09 14:37:14.000000000 -0500
@@ -95,6 +95,7 @@
 files_read_etc_files(dovecot_t)
 files_search_spool(dovecot_t)
 files_search_tmp(dovecot_t)
+files_search_tmp(dovecot_auth_t)
 files_dontaudit_list_default(dovecot_t)
 
 init_use_fd(dovecot_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.fc serefpolicy-2.1.8/policy/modules/services/hal.fc
--- nsaserefpolicy/policy/modules/services/hal.fc	2005-11-14 18:24:07.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/hal.fc	2006-01-09 14:37:14.000000000 -0500
@@ -7,3 +7,4 @@
 /usr/sbin/hald		--			gen_context(system_u:object_r:hald_exec_t,s0)
 
 /usr/share/hal/device-manager/hal-device-manager -- gen_context(system_u:object_r:bin_t,s0)
+/usr/share/hal/scripts(/.*)?	 gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.1.8/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/hal.te	2006-01-09 23:10:48.000000000 -0500
@@ -47,8 +47,12 @@
 kernel_read_system_state(hald_t)
 kernel_read_network_state(hald_t)
 kernel_read_kernel_sysctl(hald_t)
+kernel_read_fs_sysctl(hald_t)
+
 kernel_write_proc_file(hald_t)
 
+mls_file_read_up(hald_t)
+
 corecmd_exec_bin(hald_t)
 corecmd_exec_sbin(hald_t)
 
@@ -82,6 +86,7 @@
 files_read_etc_files(hald_t)
 files_rw_etc_runtime_files(hald_t)
 files_search_mnt(hald_t)
+files_manage_mnt_dirs(hald_t)
 files_search_var_lib(hald_t)
 files_read_usr_files(hald_t)
 # hal is now execing pm-suspend
@@ -145,6 +150,10 @@
 	clock_domtrans(hald_t)
 ')
 
+optional_policy(`rpc',`
+	rpc_search_nfs_state_data(hald_t)
+')
+
 optional_policy(`cups',`
 	cups_domtrans_config(hald_t)
 	cups_signal_config(hald_t)
@@ -205,6 +214,3 @@
 	vbetool_domtrans(hald_t)
 ')
 
-ifdef(`TODO',`
-allow hald_t device_t:dir create_dir_perms;
-') dnl end TODO
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/irqbalance.te serefpolicy-2.1.8/policy/modules/services/irqbalance.te
--- nsaserefpolicy/policy/modules/services/irqbalance.te	2005-11-28 17:23:58.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/irqbalance.te	2006-01-09 14:37:14.000000000 -0500
@@ -28,6 +28,7 @@
 kernel_read_system_state(irqbalance_t)
 kernel_read_kernel_sysctl(irqbalance_t)
 kernel_rw_irq_sysctl(irqbalance_t)
+kernel_read_proc_devices(irqbalance_t)
 
 dev_read_sysfs(irqbalance_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kerberos.te serefpolicy-2.1.8/policy/modules/services/kerberos.te
--- nsaserefpolicy/policy/modules/services/kerberos.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/kerberos.te	2006-01-10 08:56:50.000000000 -0500
@@ -249,8 +249,3 @@
 	udev_read_db(krb5kdc_t)
 ')
 
-ifdef(`TODO',`
-# Allow user programs to talk to KDC
-allow krb5kdc_t userdomain:udp_socket recvfrom;
-allow userdomain krb5kdc_t:udp_socket recvfrom;
-') dnl end TODO
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/locate.fc serefpolicy-2.1.8/policy/modules/services/locate.fc
--- nsaserefpolicy/policy/modules/services/locate.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/locate.fc	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,4 @@
+# locate - file locater
+/usr/bin/updatedb		--	gen_context(system_u:object_r:locate_exec_t, s0)
+/var/lib/[sm]locate(/.*)?		gen_context(system_u:object_r:locate_var_lib_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/locate.if serefpolicy-2.1.8/policy/modules/services/locate.if
--- nsaserefpolicy/policy/modules/services/locate.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/locate.if	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1 @@
+## <summary>Update database for mlocate</summary>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/locate.te serefpolicy-2.1.8/policy/modules/services/locate.te
--- nsaserefpolicy/policy/modules/services/locate.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/locate.te	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,50 @@
+policy_module(locate,1.0.0)
+
+#DESC LOCATE - Security Enhanced version of the GNU Locate
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the locate_t domain.
+#
+# locate_exec_t is the type of the locate executable.
+#
+type locate_t;
+type locate_exec_t;
+init_daemon_domain(locate_t,locate_exec_t)
+
+type locate_log_t;
+logging_log_file(locate_log_t)
+
+type locate_var_lib_t;
+files_type(locate_var_lib_t)
+
+allow locate_t self:capability { chown dac_read_search dac_override fowner fsetid };
+allow locate_t self:process { execheap execmem execstack };
+allow locate_t self:fifo_file rw_file_perms;
+allow locate_t self:file { getattr read };
+allow locate_t self:unix_stream_socket create_socket_perms;
+
+allow locate_t locate_var_lib_t:dir create_dir_perms;
+allow locate_t locate_var_lib_t:file create_file_perms;
+
+fs_getattr_xattr_fs(locate_t)
+
+files_list_all(locate_t)
+files_getattr_all_files(locate_t)
+
+kernel_dontaudit_search_sysctl(locate_t)
+kernel_read_system_state(locate_t)
+
+corecmd_exec_bin(locate_t)
+
+files_read_etc_runtime_files(locate_t)
+files_read_etc_files(locate_t)
+
+optional_policy(`crond',`
+	cron_system_entry(locate_t, locate_exec_t)
+	allow system_crond_t locate_log_t:dir rw_dir_perms;
+	allow system_crond_t locate_log_t:file { create append getattr };
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/logwatch.fc serefpolicy-2.1.8/policy/modules/services/logwatch.fc
--- nsaserefpolicy/policy/modules/services/logwatch.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/logwatch.fc	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,3 @@
+# logwatch - file logwatchr
+/usr/share/logwatch/scripts/logwatch.pl	--	gen_context(system_u:object_r:logwatch_exec_t, s0)
+/var/cache/logwatch(/.*)?			gen_context(system_u:object_r:logwatch_cache_t, s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/logwatch.if serefpolicy-2.1.8/policy/modules/services/logwatch.if
--- nsaserefpolicy/policy/modules/services/logwatch.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/logwatch.if	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1 @@
+## <summary>Update database for mlogwatch</summary>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/logwatch.te serefpolicy-2.1.8/policy/modules/services/logwatch.te
--- nsaserefpolicy/policy/modules/services/logwatch.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/logwatch.te	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,107 @@
+policy_module(logwatch,1.0.0)
+
+#DESC LOGWATCH - system log analyzer and reporter
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the logwatch_t domain.
+#
+# logwatch_exec_t is the type of the logwatch executable.
+#
+type logwatch_t;
+domain_type(logwatch_t)
+role system_r types logwatch_t;
+
+type logwatch_exec_t;
+domain_entry_file(logwatch_t,logwatch_exec_t)
+
+type logwatch_cache_t;
+files_type(logwatch_cache_t)
+
+type logwatch_tmp_t;
+files_tmp_file(logwatch_tmp_t)
+
+allow logwatch_t self:capability setgid;
+allow logwatch_t self:fifo_file rw_file_perms;
+allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
+
+allow logwatch_t logwatch_tmp_t:dir create_dir_perms;
+allow logwatch_t logwatch_tmp_t:file create_file_perms;
+files_create_tmp_files(logwatch_t, logwatch_tmp_t, { file dir })
+
+allow logwatch_t logwatch_cache_t:dir create_dir_perms;
+allow logwatch_t logwatch_cache_t:file create_file_perms;
+
+auth_dontaudit_read_shadow(logwatch_t)
+
+corecmd_read_sbin_file(logwatch_t)
+corecmd_exec_bin(logwatch_t)
+corecmd_exec_shell(logwatch_t)
+
+dev_read_urand(logwatch_t)
+
+fs_getattr_all_fs(logwatch_t)
+
+kernel_read_fs_sysctl(logwatch_t)
+kernel_read_kernel_sysctl(logwatch_t)
+
+files_read_etc_files(logwatch_t)
+files_read_etc_runtime_files(logwatch_t)
+files_read_usr_files(logwatch_t)
+files_search_spool(logwatch_t)
+files_dontaudit_search_home(logwatch_t)
+
+kernel_read_system_state(logwatch_t)
+
+libs_use_ld_so(logwatch_t)
+libs_use_shared_libs(logwatch_t)
+libs_read_lib(logwatch_t)
+
+logging_read_all_logs(logwatch_t)
+
+miscfiles_read_localization(logwatch_t)
+
+nscd_use_socket(logwatch_t)
+
+rpc_search_nfs_state_data(logwatch_t)
+
+term_dontaudit_getattr_pty_dir(logwatch_t)
+term_dontaudit_list_ptys(logwatch_t)
+
+userdom_dontaudit_search_sysadm_home_dir(logwatch_t)
+userdom_dontaudit_getattr_sysadm_home_dir(logwatch_t)
+
+# Read /proc/PID directories for all domains.
+domain_read_all_domains_state(logwatch_t)
+
+mta_send_mail(logwatch_t)
+
+optional_policy(`cron',`
+	cron_system_entry(logwatch_t, logwatch_exec_t)
+')
+
+optional_policy(`samba',`
+	samba_read_log(logwatch_t)
+')
+
+optional_policy(`bind',`
+	bind_read_config(logwatch_t)
+	bind_read_zone(logwatch_t)
+')
+
+optional_policy(`mta',`
+	mta_getattr_spool(logwatch_t)
+	allow system_mail_t logwatch_tmp_t:file r_file_perms;
+')
+
+optional_policy(`apache',`
+	apache_read_log(logwatch_t)
+')
+
+optional_policy(`ntp',`
+	allow logwatch_t ntpd_exec_t:file getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.1.8/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-01-04 17:28:52.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/mta.te	2006-01-09 14:37:14.000000000 -0500
@@ -47,6 +47,9 @@
 allow system_mail_t etc_mail_t:dir { getattr search };
 allow system_mail_t etc_mail_t:file r_file_perms;
 
+allow initrc_t etc_mail_t:dir r_dir_perms;
+allow initrc_t etc_mail_t:file r_file_perms;
+
 kernel_read_system_state(system_mail_t)
 kernel_read_network_state(system_mail_t)
 
@@ -124,6 +127,10 @@
 	logrotate_read_tmp_files(system_mail_t)
 ')
 
+optional_policy(`sendmail',`
+	files_create_etc_config(sendmail_t,etc_aliases_t, file)
+')
+
 optional_policy(`postfix',`
 	allow system_mail_t etc_aliases_t:dir create_dir_perms;
 	allow system_mail_t etc_aliases_t:file create_file_perms;
@@ -174,3 +181,9 @@
 		cron_read_system_job_tmp_files(mta_user_agent)
 	')
 ')
+
+ifdef(`TODO',`
+# for the start script to run make -C /etc/mail
+allow initrc_t etc_mail_t:dir rw_dir_perms;
+allow initrc_t etc_mail_t:file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.1.8/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/networkmanager.te	2006-01-10 09:08:19.000000000 -0500
@@ -28,8 +28,6 @@
 allow NetworkManager_t self:tcp_socket create_stream_socket_perms;
 allow NetworkManager_t self:udp_socket create_socket_perms;
 allow NetworkManager_t self:packet_socket create_socket_perms;
-# allow vpnc connections
-allow NetworkManager_t self:rawip_socket create_socket_perms;
 
 allow NetworkManager_t NetworkManager_var_run_t:file create_file_perms;
 allow NetworkManager_t NetworkManager_var_run_t:dir rw_dir_perms;
@@ -54,8 +52,6 @@
 corenet_tcp_connect_all_ports(NetworkManager_t)
 corenet_udp_bind_isakmp_port(NetworkManager_t)
 corenet_udp_bind_dhcpc_port(NetworkManager_t)
-# vpn connections
-corenet_use_tun_tap_device(NetworkManager_t)
 
 dev_read_sysfs(NetworkManager_t)
 dev_read_rand(NetworkManager_t)
@@ -170,4 +166,5 @@
 
 optional_policy(`vpn',`
 	vpn_domtrans(NetworkManager_t)
+	allow NetworkManager_t vpnc_t:process signal;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.te serefpolicy-2.1.8/policy/modules/services/nscd.te
--- nsaserefpolicy/policy/modules/services/nscd.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/nscd.te	2006-01-09 14:37:14.000000000 -0500
@@ -128,7 +128,6 @@
 
 optional_policy(`samba',`
 	samba_connect_winbind(nscd_t)
-	samba_search_var(nscd_t)
 ')
 
 optional_policy(`udev',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-2.1.8/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/ntp.te	2006-01-09 14:37:14.000000000 -0500
@@ -148,8 +148,6 @@
 ')
 
 optional_policy(`samba',`
-	# cjp: the connect was previously missing
-	# so it might be ok to drop this
 	samba_connect_winbind(ntpd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/portmap.te serefpolicy-2.1.8/policy/modules/services/portmap.te
--- nsaserefpolicy/policy/modules/services/portmap.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/portmap.te	2006-01-09 14:37:14.000000000 -0500
@@ -47,6 +47,7 @@
 kernel_read_proc_symlinks(portmap_t)
 kernel_udp_sendfrom(portmap_t)
 kernel_tcp_recvfrom(portmap_t) 
+kernel_read_proc_devices(portmap_t)
 
 corenet_tcp_sendrecv_all_if(portmap_t)
 corenet_udp_sendrecv_all_if(portmap_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/prelink.fc serefpolicy-2.1.8/policy/modules/services/prelink.fc
--- nsaserefpolicy/policy/modules/services/prelink.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/prelink.fc	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,7 @@
+# prelink - prelink ELF shared libraries and binaries to speed up startup time
+/usr/sbin/prelink		--	gen_context(system_u:object_r:prelink_exec_t,s0)
+ifdef(`distro_debian', `
+/usr/sbin/prelink\.bin		--	gen_context(system_u:object_r:prelink_exec_t,s0)
+')
+/var/log/prelink\.log		--	gen_context(system_u:object_r:prelink_log_t,s0)
+/etc/prelink\.cache		--	gen_context(system_u:object_r:prelink_cache_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/prelink.if serefpolicy-2.1.8/policy/modules/services/prelink.if
--- nsaserefpolicy/policy/modules/services/prelink.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/prelink.if	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,39 @@
+## <summary>Prelink mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the prelink program in the prelink domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`prelink_domtrans',`
+	gen_require(`
+		type prelink_t, prelink_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, prelink_exec_t, prelink_t)
+
+	allow $1 prelink_t:fd use;
+	allow prelink_t $1:fd use;
+	allow prelink_t $1:fifo_file rw_file_perms;
+	allow prelink_t $1:process sigchld;
+')
+
+
+########################################
+## <summary>
+##	Allow prelink to rebuild the executable or library
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`prelink_relabel',`
+	gen_require(`
+		type prelink_t;
+	')
+	allow prelink_t $1:file { create_file_perms execute relabelto relabelfrom };
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/prelink.te serefpolicy-2.1.8/policy/modules/services/prelink.te
--- nsaserefpolicy/policy/modules/services/prelink.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/prelink.te	2006-01-09 14:37:14.000000000 -0500
@@ -0,0 +1,64 @@
+policy_module(prelink,1.0.0)
+
+#DESC PRELINK - Security Enhanced version of the GNU Prelink
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the prelink_t domain.
+#
+# prelink_exec_t is the type of the prelink executable.
+#
+type prelink_t;
+type prelink_exec_t;
+init_daemon_domain(prelink_t,prelink_exec_t)
+#
+# prelink_cache_t is the type of /etc/prelink.cache.
+#
+type prelink_cache_t;
+files_type(prelink_cache_t)
+
+type prelink_log_t;
+logging_log_file(prelink_log_t)
+
+allow prelink_t self:capability { chown dac_override fowner fsetid };
+allow prelink_t self:process { execheap execmem execstack };
+allow prelink_t self:fifo_file rw_file_perms;
+allow prelink_t self:file { getattr read };
+
+allow prelink_t prelink_log_t:dir { setattr rw_dir_perms };
+allow prelink_t prelink_log_t:file { create ra_file_perms };
+allow prelink_t prelink_log_t:lnk_file read;
+logging_create_log(prelink_t, prelink_log_t)
+
+fs_getattr_xattr_fs(prelink_t)
+
+libs_use_ld_so(prelink_t)
+libs_use_shared_libs(prelink_t)
+
+files_list_all(prelink_t)
+files_getattr_all_files(prelink_t)
+files_write_non_security_dir(prelink_t)
+files_create_etc_config(prelink_t, prelink_cache_t, file)
+
+kernel_dontaudit_search_kernel_sysctl(prelink_t)
+kernel_dontaudit_search_sysctl(prelink_t)
+kernel_read_system_state(prelink_t)
+
+files_read_etc_runtime_files(prelink_t)
+
+miscfiles_read_localization(prelink_t)
+
+dev_read_urand(prelink_t)
+
+optional_policy(`crond',`
+	cron_system_entry(prelink_t, prelink_exec_t)
+	allow system_crond_t prelink_log_t:dir rw_dir_perms;
+	allow system_crond_t prelink_log_t:file create_file_perms;
+	allow system_crond_t prelink_cache_t:file { getattr read unlink };
+	allow prelink_t crond_log_t:file append;
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rpc.te serefpolicy-2.1.8/policy/modules/services/rpc.te
--- nsaserefpolicy/policy/modules/services/rpc.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/rpc.te	2006-01-09 14:37:14.000000000 -0500
@@ -48,6 +48,7 @@
 kernel_search_network_state(rpcd_t) 
 # for rpc.rquotad
 kernel_read_sysctl(rpcd_t)  
+kernel_read_proc_devices(rpcd_t)
 
 corenet_udp_bind_generic_port(rpcd_t)
 corenet_udp_bind_reserved_port(rpcd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.if serefpolicy-2.1.8/policy/modules/services/samba.if
--- nsaserefpolicy/policy/modules/services/samba.if	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/samba.if	2006-01-09 14:37:14.000000000 -0500
@@ -342,7 +342,9 @@
 	')
 
 	files_search_pids($1)
+	samba_search_var($1)
 	allow $1 winbind_var_run_t:dir search_dir_perms;
 	allow $1 winbind_var_run_t:sock_file { getattr read write };
 	allow $1 winbind_t:unix_stream_socket connectto;
 ')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xdm.te serefpolicy-2.1.8/policy/modules/services/xdm.te
--- nsaserefpolicy/policy/modules/services/xdm.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/services/xdm.te	2006-01-09 14:37:14.000000000 -0500
@@ -319,6 +319,10 @@
 allow xdm_xserver_t xkb_var_lib_t:lnk_file read;
 can_exec(xdm_xserver_t, xkb_var_lib_t)
 
+optional_policy(`prelink', `
+	prelink_relabel(xkb_var_lib_t)
+')
+
 # Insert video drivers.  
 allow xdm_xserver_t self:capability mknod;
 allow xdm_xserver_t sysctl_modprobe_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.1.8/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/authlogin.te	2006-01-09 14:37:14.000000000 -0500
@@ -157,6 +157,7 @@
 kernel_use_fd(pam_console_t)
 # Read /proc/meminfo
 kernel_read_system_state(pam_console_t)
+kernel_read_proc_devices(pam_console_t)
 
 dev_read_sysfs(pam_console_t)
 dev_getattr_apm_bios(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/clock.te serefpolicy-2.1.8/policy/modules/system/clock.te
--- nsaserefpolicy/policy/modules/system/clock.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/clock.te	2006-01-09 14:37:14.000000000 -0500
@@ -33,6 +33,7 @@
 kernel_read_kernel_sysctl(hwclock_t)
 kernel_list_proc(hwclock_t)
 kernel_read_proc_symlinks(hwclock_t)
+kernel_read_proc_devices(hwclock_t)
 
 dev_read_sysfs(hwclock_t)
 dev_rw_realtime_clock(hwclock_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.1.8/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/fstools.te	2006-01-09 14:37:14.000000000 -0500
@@ -56,6 +56,8 @@
 # Access to /initrd devices
 kernel_rw_unlabeled_dir(fsadm_t)
 kernel_use_unlabeled_blk_dev(fsadm_t)
+# Access to /proc/devices
+kernel_read_proc_devices(fsadm_t)
 
 dev_getattr_all_chr_files(fsadm_t)
 # mkreiserfs and other programs need this for UUID
@@ -69,6 +71,8 @@
 dev_read_sysfs(fsadm_t)
 # Access to /initrd devices
 dev_getattr_usbfs_dir(fsadm_t)
+# Access to /dev/mapper/control
+dev_rw_lvm_control(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.1.8/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2005-12-09 23:35:06.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/hostname.te	2006-01-09 14:37:14.000000000 -0500
@@ -7,8 +7,10 @@
 #
 
 type hostname_t;
+domain_type(hostname_t)
+
 type hostname_exec_t;
-init_system_domain(hostname_t,hostname_exec_t)
+domain_entry_file(hostname_t,hostname_exec_t)
 role system_r types hostname_t;
 
 ########################################
@@ -24,6 +26,7 @@
 
 kernel_list_proc(hostname_t)
 kernel_read_proc_symlinks(hostname_t)
+kernel_read_proc_devices(hostname_t)
 
 dev_read_sysfs(hostname_t)
 
@@ -55,35 +58,6 @@
 sysnet_read_config(hostname_t)
 sysnet_dns_name_resolve(hostname_t)
 
-userdom_use_all_user_fd(hostname_t)
 
-ifdef(`distro_redhat', `
-	fs_use_tmpfs_chr_dev(hostname_t)
-')
-
-ifdef(`targeted_policy', `
-	term_dontaudit_use_unallocated_tty(hostname_t)
-	term_dontaudit_use_generic_pty(hostname_t)
-	files_dontaudit_read_root_file(hostname_t)
-')
-
-optional_policy(`firstboot',`
-	firstboot_use_fd(hostname_t)
-')
-
-optional_policy(`hotplug',`
-	hotplug_dontaudit_use_fd(hostname_t)
-')
-
-optional_policy(`nscd',`
-	nscd_use_socket(hostname_t)
-')
-
-optional_policy(`selinuxutil',`
-	seutil_sigchld_newrole(hostname_t)
-')
-
-optional_policy(`udev',`
-	udev_dontaudit_use_fd(hostname_t)
-	udev_read_db(hostname_t)
-')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.1.8/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/init.te	2006-01-09 14:37:14.000000000 -0500
@@ -449,7 +449,6 @@
 
 	# readahead asks for these
 	auth_dontaudit_read_shadow(initrc_t)
-	mta_read_aliases(initrc_t)
 
 	optional_policy(`bind',`
 		bind_manage_config_dir(initrc_t)
@@ -687,6 +686,10 @@
 	zebra_read_config(initrc_t)
 ')
 
+optional_policy(`hostname',`
+	hostname_exec(initrc_t)
+')
+
 ifdef(`TODO',`
 # Set device ownerships/modes.
 allow initrc_t xconsole_device_t:fifo_file setattr;
@@ -695,24 +698,13 @@
 allow initrc_t default_t:dir write;
 
 ifdef(`distro_redhat', `
-	# readahead asks for these
-	allow initrc_t var_lib_nfs_t:file r_file_perms;
-
-	allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
 	allow initrc_t device_t:dir create;
 
-	# wants to delete /poweroff and other files 
-	allow initrc_t root_t:file unlink;
 	ifdef(`xserver.te', `
 	# wants to cleanup xserver log dir
 	allow initrc_t xserver_log_t:dir rw_dir_perms;
 	allow initrc_t xserver_log_t:file unlink;
 	')
 
-	optional_policy(`rpm',`
-		rpm_stub(initrc_t)
-		#read ahead wants to read this
-		allow initrc_t system_cron_spool_t:file { getattr read };
-	')
 ')
 ') dnl end TODO
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.1.8/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/libraries.fc	2006-01-09 14:37:14.000000000 -0500
@@ -11,6 +11,9 @@
 /emul/ia32-linux/lib(/.*)?					gen_context(system_u:object_r:lib_t,s0)
 /emul/ia32-linux/lib/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
 /emul/ia32-linux/lib(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
+
+/usr/bin/fedora-rmdevelrpms --	gen_context(system_u:object_r:rpm_exec_t,s0)
+
 ')
 
 #
@@ -55,7 +58,7 @@
 
 /usr(/.*)?/nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/lib/pgsql/test/regress/.*\.so 	--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib(64)?/pgsql/test/regress/.*\.so 	--	gen_context(system_u:object_r:shlib_t,s0)
 
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
 
@@ -76,7 +79,7 @@
 /usr/x11R6/lib/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_redhat',`
-/usr/lib/.*/program/.*\.so.*			gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib(64)?/.*/program/.*\.so.*			gen_context(system_u:object_r:shlib_t,s0)
 /usr/share/rhn/rhn_applet/eggtrayiconmodule\.so -- gen_context(system_u:object_r:shlib_t,s0)
 
 # The following are libraries with text relocations in need of execmod permissions
@@ -84,32 +87,32 @@
 
 # Fedora Core packages: gstreamer-plugins, compat-libstdc++, Glide3, libdv
 # 	HelixPlayer, SDL, xorg-x11, xorg-x11-libs, Hermes, valgrind, openoffice.org-libs, httpd - php
-/usr/lib/gstreamer-.*/libgstffmpeg\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/gstreamer-.*/libgsthermescolorspace\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/gstreamer-.*/libgstmms\.so 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libstdc\+\+\.so\.2\.7\.2\.8 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libg\+\+\.so\.2\.7\.2\.8	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libglide3\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libdv\.so.* 			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/helix/plugins/oggfformat\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/helix/plugins/theorarend\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/helix/plugins/vorbisrend\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/helix/codecs/colorcvt\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/helix/codecs/cvt1\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libSDL-.*\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/gstreamer-.*/libgstffmpeg\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/gstreamer-.*/libgsthermescolorspace\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/gstreamer-.*/libgstmms\.so 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libstdc\+\+\.so\.2\.7\.2\.8 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libg\+\+\.so\.2\.7\.2\.8	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libglide3\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libdv\.so.* 			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/helix/plugins/oggfformat\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/helix/plugins/theorarend\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/helix/plugins/vorbisrend\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/helix/codecs/colorcvt\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/helix/codecs/cvt1\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libSDL-.*\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/modules/dri/.*\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/dri/.*\.so			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/dri/.*\.so			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libOSMesa\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libfglrx_gamma\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libHermes\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/valgrind/hp2ps			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/valgrind/stage2		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/valgrind/vg.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/program/libicudata\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/program/libsts645li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/program/libvclplug_gen645li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/program/libwrp645li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/program/libswd680li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libHermes\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/valgrind/hp2ps			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/valgrind/stage2		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/valgrind/vg.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/program/libicudata\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/program/libsts645li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/program/libvclplug_gen645li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/program/libwrp645li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/program/libswd680li\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/librecentfile\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libsvx680li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libcomphelp4gcc3\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -122,48 +125,48 @@
 /usr/lib(64)?/thunderbird.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Fedora Extras packages: ladspa, imlib2, ocaml
-/usr/lib/ladspa/analogue_osc_1416\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/bandpass_a_iir_1893\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/bandpass_iir_1892\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/butterworth_1902\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/fm_osc_1415\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/gsm_1215\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/gverb_1216\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/hermes_filter_1200\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/highpass_iir_1890\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/lowpass_iir_1891\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/notch_iir_1894\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/pitch_scale_1193\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/pitch_scale_1194\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/sc1_1425\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/sc2_1426\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/sc3_1427\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/sc4_1882\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ladspa/se4_1883\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libImlib2\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/ocaml/stublibs/dllnums\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/httpd/modules/libphp5\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/php/modules/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/analogue_osc_1416\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/bandpass_a_iir_1893\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/bandpass_iir_1892\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/butterworth_1902\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/fm_osc_1415\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/gsm_1215\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/gverb_1216\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/hermes_filter_1200\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/highpass_iir_1890\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/lowpass_iir_1891\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/notch_iir_1894\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/pitch_scale_1193\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/pitch_scale_1194\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/sc1_1425\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/sc2_1426\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/sc3_1427\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/sc4_1882\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ladspa/se4_1883\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libImlib2\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/ocaml/stublibs/dllnums\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/httpd/modules/libphp5\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/php/modules/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Livna.org packages: xmms-mp3, ffmpeg, xvidcore, xine-lib, gsm, lame
-/usr/lib/xmms/Input/libmpg123\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libavformat-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libavcodec-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libavutil-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libxvidcore\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/xine/plugins/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libgsm\.so.*			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libmp3lame\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xmms/Input/libmpg123\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavformat-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavcodec-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavutil-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libxvidcore\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xine/plugins/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libgsm\.so.*			--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libmp3lame\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Flash plugin, Macromedia
 HOME_DIR/.*/plugins/libflashplayer\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/.*/plugins/libflashplayer\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/.*/plugins/libflashplayer\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Jai, Sun Microsystems (Jpackage SPRM)
-/usr/lib/libmlib_jai\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libdivxdecore.so.0		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib/libdivxencore.so.0		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libmlib_jai\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libdivxdecore.so.0		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libdivxencore.so.0		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Java, Sun Microsystems (JPackage SRPM)
 /usr/.*/jre/lib/i386/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -175,7 +178,7 @@
 ') dnl end distro_redhat
 
 ifdef(`distro_suse',`
-/usr/lib/samba/classic/[^/]*\.so(\.[^/]*)* --	gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib(64)?/samba/classic/[^/]*\.so(\.[^/]*)* --	gen_context(system_u:object_r:shlib_t,s0)
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.te serefpolicy-2.1.8/policy/modules/system/libraries.te
--- nsaserefpolicy/policy/modules/system/libraries.te	2005-12-12 15:35:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/libraries.te	2006-01-09 14:37:14.000000000 -0500
@@ -94,6 +94,10 @@
 	unconfined_domain_template(ldconfig_t) 
 ')
 
+optional_policy(`prelink', `
+	prelink_relabel({ ld_so_t texrel_shlib_t shlib_t lib_t })
+')
+
 optional_policy(`apache',`
 	# dontaudit access to /usr/lib/apache, normal programs cannot read these libs anyway
 	apache_dontaudit_search_modules(ldconfig_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.1.8/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/locallogin.te	2006-01-09 14:37:14.000000000 -0500
@@ -165,6 +165,7 @@
 userdom_signal_all_users(local_login_t)
 userdom_search_all_users_home(local_login_t)
 userdom_use_unpriv_users_fd(local_login_t)
+userdom_all_users_sigchld(local_login_t)
 
 # Search for mail spool file.
 mta_getattr_spool(local_login_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.1.8/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/logging.te	2006-01-09 14:37:14.000000000 -0500
@@ -70,6 +70,7 @@
 
 kernel_read_kernel_sysctl(auditctl_t)
 kernel_read_proc_symlinks(auditctl_t)
+kernel_read_proc_devices(auditctl_t)
 
 domain_read_all_domains_state(auditctl_t)
 domain_use_wide_inherit_fd(auditctl_t)
@@ -128,6 +129,7 @@
 kernel_read_kernel_sysctl(auditd_t)
 kernel_list_proc(auditd_t)
 kernel_read_proc_symlinks(auditd_t)
+kernel_read_proc_devices(auditd_t)
 
 dev_read_sysfs(auditd_t)
 
@@ -203,6 +205,7 @@
 # Control syslog and console logging
 kernel_clear_ring_buffer(klogd_t)
 kernel_change_ring_buffer_level(klogd_t)
+kernel_read_proc_devices(klogd_t)
 
 bootloader_read_kernel_symbol_table(klogd_t)
 
@@ -298,6 +301,7 @@
 kernel_read_messages(syslogd_t)
 kernel_clear_ring_buffer(syslogd_t)
 kernel_change_ring_buffer_level(syslogd_t)
+kernel_read_proc_devices(syslogd_t)
 
 dev_create_dev_node(syslogd_t,devlog_t,sock_file)
 dev_read_sysfs(syslogd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-2.1.8/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2005-12-09 23:35:08.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/lvm.te	2006-01-09 14:37:14.000000000 -0500
@@ -155,6 +155,8 @@
 
 allow lvm_t lvm_etc_t:file r_file_perms;
 allow lvm_t lvm_etc_t:lnk_file r_file_perms;
+allow initrc_t lvm_etc_t:file r_file_perms;
+
 # Write to /etc/lvm, /etc/lvmtab, /etc/lvmtab.d
 allow lvm_t lvm_etc_t:dir rw_dir_perms;
 allow lvm_t lvm_metadata_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.1.8/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2005-12-12 23:05:35.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/mount.te	2006-01-09 14:37:14.000000000 -0500
@@ -26,12 +26,14 @@
 files_create_tmp_files(mount_t,mount_tmp_t,{ file dir })
 
 kernel_read_system_state(mount_t)
+kernel_read_proc_devices(mount_t)
 
 corenet_dontaudit_tcp_bind_all_reserved_ports(mount_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(mount_t)
 
 dev_getattr_all_blk_files(mount_t)
 dev_list_all_dev_nodes(mount_t)
+dev_rw_lvm_control(mount_t)
 
 storage_raw_read_fixed_disk(mount_t)
 storage_raw_write_fixed_disk(mount_t)
@@ -46,7 +48,7 @@
 fs_search_auto_mountpoints(mount_t)
 fs_use_tmpfs_chr_dev(mount_t)
 
-term_use_console(mount_t)
+term_use_all_terms(mount_t)
 
 # required for mount.smbfs
 corecmd_exec_sbin(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.1.8/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/selinuxutil.te	2006-01-09 14:37:14.000000000 -0500
@@ -324,6 +324,7 @@
 kernel_use_fd(restorecon_t)
 kernel_rw_pipe(restorecon_t)
 kernel_read_system_state(restorecon_t)
+kernel_read_proc_devices(restorecon_t)
 
 # cjp: why is this needed?
 dev_rw_generic_file(restorecon_t)
@@ -412,9 +413,11 @@
 ifdef(`targeted_policy',`',`
 	allow run_init_t self:process setexec;
 	allow run_init_t self:capability setuid;
-	allow run_init_t self:fifo_file rw_file_perms;
 	allow run_init_t self:netlink_audit_socket { create bind write nlmsg_read read };
 
+	allow run_init_t self:fifo_file rw_file_perms;
+	domain_auto_trans(run_init_t,initrc_exec_t,initrc_t)
+
 	# often the administrator runs such programs from a directory that is owned
 	# by a different user or has restrictive SE permissions, do not want to audit
 	# the failed access to the current directory
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/sysnetwork.te serefpolicy-2.1.8/policy/modules/system/sysnetwork.te
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2005-12-09 23:35:08.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/sysnetwork.te	2006-01-09 14:37:14.000000000 -0500
@@ -90,6 +90,7 @@
 kernel_read_network_state(dhcpc_t)
 kernel_read_kernel_sysctl(dhcpc_t)
 kernel_use_fd(dhcpc_t)
+kernel_read_proc_devices(dhcpc_t)
 
 corenet_tcp_sendrecv_all_if(dhcpc_t)
 corenet_raw_sendrecv_all_if(dhcpc_t)
@@ -281,6 +282,7 @@
 kernel_read_system_state(ifconfig_t)
 kernel_read_network_state(ifconfig_t)
 kernel_search_network_sysctl(ifconfig_t)
+kernel_read_proc_devices(ifconfig_t)
 
 corenet_use_tun_tap_device(ifconfig_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.1.8/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2005-12-13 15:51:50.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/unconfined.if	2006-01-09 17:22:51.000000000 -0500
@@ -33,6 +33,7 @@
 	corenet_unconfined($1)
 	dev_unconfined($1)
 	domain_unconfined($1)
+	domain_dontaudit_read_all_domains_state($1)
 	files_unconfined($1)
 	fs_unconfined($1)
 	selinux_unconfined($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.1.8/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/unconfined.te	2006-01-09 14:37:14.000000000 -0500
@@ -57,6 +57,10 @@
 		bluetooth_domtrans_helper(unconfined_t)
 	')
 
+	optional_policy(`java',`
+		java_domtrans(unconfined_t)
+	')
+
 	optional_policy(`dbus',`
 		dbus_stub(unconfined_t)
 
@@ -125,10 +129,6 @@
 		samba_domtrans_winbind_helper(unconfined_t)
 	')
 
-	optional_policy(`su',`
-		su_per_userdomain_template(sysadm,unconfined_t,system_r)
-	')
-
 	optional_policy(`sysnetwork',`
 		sysnet_domtrans_dhcpc(unconfined_t)
 	')
@@ -141,6 +141,10 @@
 		webalizer_domtrans(unconfined_t)
 	')
 
+	optional_policy(`sendmail',`
+		sendmail_domtrans(unconfined_t)
+	')
+
 	ifdef(`TODO',`
 	ifdef(`use_mcs',`
 	rw_dir_create_file(sysadm_su_t, home_dir_type)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.fc serefpolicy-2.1.8/policy/modules/system/userdomain.fc
--- nsaserefpolicy/policy/modules/system/userdomain.fc	2005-11-15 09:13:40.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/userdomain.fc	2006-01-09 14:37:14.000000000 -0500
@@ -4,6 +4,6 @@
 HOME_DIR		-d	gen_context(system_u:object_r:user_home_dir_t,s0)
 HOME_DIR/.+			gen_context(system_u:object_r:user_home_t,s0)
 ',`
-HOME_DIR		-d	gen_context(system_u:object_r:ROLE_home_dir_t,s0)
+HOME_DIR		-d	gen_context(system_u:object_r:ROLE_home_dir_t,s0-s15:c0.c255)
 HOME_DIR/.+			gen_context(system_u:object_r:ROLE_home_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.1.8/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/userdomain.if	2006-01-09 14:37:14.000000000 -0500
@@ -1881,19 +1881,16 @@
 ## </param>
 #
 interface(`userdom_dontaudit_getattr_sysadm_home_dir',`
-	ifdef(`targeted_policy',`
-		gen_require(`
-			type user_home_dir_t;
-		')
+	gen_require(`
+		type sysadm_home_dir_t;
+	')
 
-		dontaudit $1 user_home_dir_t:dir getattr;
-	', `
-		gen_require(`
-			type sysadm_home_dir_t;
-		')
+	dontaudit $1 sysadm_home_dir_t:dir getattr;
+
+ifdef(`targeted_policy', `
+	userdom_dontaudit_getattr_user_home_dirs($1)
+')
 
-		dontaudit $1 sysadm_home_dir_t:dir getattr;
-	')
 ')
 
 ########################################
@@ -1922,19 +1919,15 @@
 ## </param>
 #
 interface(`userdom_dontaudit_search_sysadm_home_dir',`
-	ifdef(`targeted_policy',`
 	gen_require(`
-		type user_home_dir_t;
+		type sysadm_home_dir_t;
 	')
 
-		dontaudit $1 user_home_dir_t:dir search_dir_perms;
-	',`
-		gen_require(`
-			type sysadm_home_dir_t;
-		')
+	dontaudit $1 sysadm_home_dir_t:dir search_dir_perms;
 
-		dontaudit $1 sysadm_home_dir_t:dir search_dir_perms;
-	')
+ifdef(`targeted_policy', `
+	userdom_dontaudit_search_user_home_dirs($1)
+')
 ')
 
 ########################################
@@ -2074,6 +2067,22 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to getattr all users home directories.
+## </summary>
+## <param name="domain">
+##	Domain to not audit.
+## </param>
+#
+interface(`userdom_dontaudit_getattr_user_home_dirs',`
+	gen_require(`
+		type user_home_dir_t;
+	')
+
+	dontaudit $1 user_home_dir_t:dir getattr;
+')
+
+########################################
+## <summary>
 ##	Read all files in all users home directories.
 ## </summary>
 ## <param name="domain">
@@ -2665,6 +2674,23 @@
 
 ########################################
 ## <summary>
+##	Send a chld signal to local login processes.
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`userdom_all_users_sigchld',`
+	gen_require(`
+		attribute userdomain;
+		class process sigchld;
+	')
+
+	allow userdomain $1:process sigchld;
+')
+
+########################################
+## <summary>
 ##	Send general signals to all user domains.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.1.8/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.1.8/policy/modules/system/userdomain.te	2006-01-09 14:37:14.000000000 -0500
@@ -205,6 +205,7 @@
 
 	optional_policy(`hostname',`
 		hostname_run(sysadm_t,sysadm_r,admin_terminal)
+		hostname_exec(userdomain)
 	')
 
 	optional_policy(`ipsec',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.1.8/policy/users
--- nsaserefpolicy/policy/users	2005-12-05 22:35:02.000000000 -0500
+++ serefpolicy-2.1.8/policy/users	2006-01-09 14:37:14.000000000 -0500
@@ -26,7 +26,9 @@
 ifdef(`targeted_policy',`
 gen_user(user_u, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
-gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(user_u, user_r, s0, s0 - s0, c0)
+gen_user(staff_u, staff_r secadm_r sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(sysadm_u, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
 #
@@ -40,8 +42,8 @@
 	gen_user(root, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm_r staff_r system_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 	',`
-		gen_user(root, sysadm_r staff_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r , s0, s0 - s15:c0.c255, c0.c255)
 	')
 ')

--------------050806040901040007080304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
