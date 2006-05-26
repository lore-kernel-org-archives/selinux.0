Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k55IcFkb005035
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 14:38:15 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k55IcEhb022477
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 18:38:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k55IcQw7016932
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 14:38:26 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k55IcQGc016931
	for selinux@tycho.nsa.gov; Mon, 5 Jun 2006 14:38:26 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4QIFniX027834
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 14:15:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4QIFmMO018410
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 18:15:48 GMT
Message-ID: <447745D2.5000705@redhat.com>
Date: Fri, 26 May 2006 14:15:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policy diffs
Content-Type: multipart/mixed;
 boundary="------------080007020909050306030104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080007020909050306030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add ftp booleans to allow use of anonymous ftp sites on NFS/CIFS file 
systems.

Allow rpm_script to transition to the execmem friendly domains.

Setup mplayer and valgrind as unconfined_execmem

Something in the glibc libraries has changed which requires a lot more 
domains to read netlink_route_socket


Remove bogus jvm file_context that was causing java to be labeled 
incorrectly

More amavis changes

Allow bluetooth to work when you login from terminal and run startx

More changes for clamscan. 

mysql needs to be able to read certs.  nss_ldap.

New directory for NetworkManager

Make xen and nscd play together

Postfix wants to write mailman mail.

Fixes for pyzor

Fixes for samba

Added a directory to allow users to setup spamassassin so it does not 
need to write to users home directory.

Cleanup of file_context for /lib64 and /usr/lib/acroread

Many fixes for xen








--------------080007020909050306030104
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-strict-mls/default_type serefpolicy-2.2.43/config/appconfig-strict-mls/default_type
--- nsaserefpolicy/config/appconfig-strict-mls/default_type	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.43/config/appconfig-strict-mls/default_type	2006-05-26 14:03:15.000000000 -0400
@@ -2,3 +2,4 @@
 secadm_r:secadm_t
 staff_r:staff_t
 user_r:user_t
+auditadm_r:auditadm_t
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.2.43/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/global_tunables	2006-05-26 14:03:15.000000000 -0400
@@ -58,6 +58,22 @@
 
 ## <desc>
 ## <p>
+## Allow ftp servers to use nfs
+## used for public file transfer services.
+## </p>
+## </desc>
+gen_tunable(allow_ftpd_use_nfs,false)
+
+## <desc>
+## <p>
+## Allow ftp servers to use cifs
+## used for public file transfer services.
+## </p>
+## </desc>
+gen_tunable(allow_ftpd_use_cifs,false)
+
+## <desc>
+## <p>
 ## Allow gssd to read temp directory.
 ## </p>
 ## </desc>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.2.43/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/admin/consoletype.te	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.2.43/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-04-19 17:43:32.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/admin/rpm.te	2006-05-26 14:03:15.000000000 -0400
@@ -334,6 +334,15 @@
 
 ifdef(`targeted_policy',`
 	unconfined_domain(rpm_script_t)
+	optional_policy(`
+		java_domtrans(rpm_script_t)
+	')
+	optional_policy(`
+		mono_domtrans(rpm_script_t)
+	')
+	optional_policy(`
+		unconfined_execmem_domtrans(rpm_script_t)
+	')
 ',`
 	optional_policy(`
 		bootloader_domtrans(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.fc serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.fc
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.fc	2006-05-26 14:03:15.000000000 -0400
@@ -0,0 +1,3 @@
+/usr/lib/openoffice.org.*/program/.*\.bin	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/valgrind 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/mplayer 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.if serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.if
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.if	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/unconfined_execmem.te serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.te
--- nsaserefpolicy/policy/modules/apps/unconfined_execmem.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/apps/unconfined_execmem.te	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/webalizer.te serefpolicy-2.2.43/policy/modules/apps/webalizer.te
--- nsaserefpolicy/policy/modules/apps/webalizer.te	2006-03-24 11:15:44.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/apps/webalizer.te	2006-05-26 14:03:15.000000000 -0400
@@ -45,6 +45,7 @@
 allow webalizer_t self:unix_stream_socket connectto;
 allow webalizer_t self:tcp_socket connected_stream_socket_perms;
 allow webalizer_t self:udp_socket { connect connected_socket_perms };
+allow webalizer_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow webalizer_t webalizer_etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.2.43/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/kernel/corecommands.fc	2006-05-26 14:03:15.000000000 -0400
@@ -120,11 +120,6 @@
 /usr/lib/ccache/bin(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib/pgsql/test/regress/.*\.sh --	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib/qt.*/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
-# these two lines are separate because of a
-# sorting issue with the java module
-/usr/lib/jvm/java.*/bin -d		gen_context(system_u:object_r:bin_t,s0)
-/usr/lib/jvm/java.*/bin/.*		gen_context(system_u:object_r:bin_t,s0)
-
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox -- gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/apt/methods.+	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/courier(/.*)?		gen_context(system_u:object_r:bin_t,s0)
@@ -135,6 +130,7 @@
 /usr/lib(64)?/emacsen-common/.*		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/ipsec/.*		--	gen_context(system_u:object_r:sbin_t,s0)
 /usr/lib(64)?/mailman/bin(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/mailman/mail(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/misc/sftp-server	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/nagios/plugins(/.*)?	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/netsaint/plugins(/.*)?	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.43/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/kernel/files.if	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.43/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/kernel/filesystem.if	2006-05-26 14:03:15.000000000 -0400
@@ -434,6 +434,26 @@
 
 ########################################
 ## <summary>
+##	Read directories of binary file types.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_getattr_binfmt_misc_dirs',`
+	gen_require(`
+		type binfmt_misc_t;
+	')
+
+	allow $1 binfmt_misc_t:dir getattr;
+
+')
+
+
+########################################
+## <summary>
 ##	Mount a CIFS or SMB network filesystem.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.43/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-05-26 14:02:27.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/kernel/kernel.te	2006-05-26 14:03:15.000000000 -0400
@@ -28,6 +28,7 @@
 
 ifdef(`enable_mls',`
 	role secadm_r;
+	role auditadm_r;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.fc serefpolicy-2.2.43/policy/modules/services/amavis.fc
--- nsaserefpolicy/policy/modules/services/amavis.fc	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/amavis.fc	2006-05-26 14:03:15.000000000 -0400
@@ -7,6 +7,6 @@
 /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
-/var/run/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?(/.*)?		gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.if serefpolicy-2.2.43/policy/modules/services/amavis.if
--- nsaserefpolicy/policy/modules/services/amavis.if	2006-03-07 16:19:28.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/services/amavis.if	2006-05-26 14:03:15.000000000 -0400
@@ -104,3 +104,65 @@
 	allow $1 amavis_var_run_t:file setattr;
 	files_search_pids($1)
 ')
+
+########################################
+## <summary>
+##	Create socket files under the amavis spool
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="socket_type">
+##	<summary>
+##	Type for socket file
+##	</summary>
+## </param>
+#
+interface(`amavis_spool_create_socket',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:dir rw_dir_perms;
+	allow $1 $2:sock_file manage_file_perms;
+	type_transition $1 amavis_spool_t:sock_file $2;
+')
+
+########################################
+## <summary>
+##	Read amavis spool files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_read_spool_file',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:file { getattr read };
+')
+
+########################################
+## <summary>
+##	Manage amavis spool files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_manage_spool_files',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+	files_search_spool($1)
+	allow $1 amavis_spool_t:dir create_dir_perms;
+	allow $1 amavis_spool_t:file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.te serefpolicy-2.2.43/policy/modules/services/amavis.te
--- nsaserefpolicy/policy/modules/services/amavis.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/amavis.te	2006-05-26 14:03:15.000000000 -0400
@@ -64,6 +64,7 @@
 # Spool Files
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
+allow amavis_t amavis_spool_t:sock_file create_file_perms;
 files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
 
 # tmp files
@@ -93,13 +94,21 @@
 kernel_read_kernel_sysctls(amavis_t)
 # amavis tries to access /proc/self/stat, /etc/shadow and /root - perl...
 kernel_dontaudit_list_proc(amavis_t)
+kernel_dontaudit_read_proc_symlinks(amavis_t)
 kernel_dontaudit_read_system_state(amavis_t)
 
+# dontaudit terminal access
+ifdef(`targeted_policy',`
+	term_dontaudit_use_generic_ptys(amavis_t)
+')
+
 # find perl
 corecmd_exec_bin(amavis_t)
 corecmd_search_sbin(amavis_t)
 
 corenet_non_ipsec_sendrecv(amavis_t)
+corenet_tcp_bind_all_nodes(amavis_t)
+corenet_udp_bind_all_nodes(amavis_t)
 corenet_tcp_sendrecv_all_if(amavis_t)
 corenet_tcp_sendrecv_all_nodes(amavis_t)
 # amavis uses well-defined ports
@@ -111,6 +120,7 @@
 corenet_tcp_connect_amavisd_send_port(amavis_t)
 # bind to incoming port
 corenet_tcp_bind_amavisd_recv_port(amavis_t)
+corenet_udp_bind_generic_port(amavis_t)
 
 dev_read_rand(amavis_t)
 dev_read_urand(amavis_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.43/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/bluetooth.te	2006-05-26 14:03:15.000000000 -0400
@@ -129,6 +129,8 @@
 
 logging_send_syslog_msg(bluetooth_t)
 
+locallogin_dontaudit_use_fds(bluetooth_helper_t)
+
 miscfiles_read_localization(bluetooth_t)
 miscfiles_read_fonts(bluetooth_t)
 
@@ -225,6 +227,9 @@
 		xserver_stream_connect_xdm(bluetooth_helper_t)
 		xserver_use_xdm_fds(bluetooth_helper_t)
 		xserver_rw_xdm_pipes(bluetooth_helper_t)
+		# when started via startx 
+		xserver_stream_connect(bluetooth_helper_t)
+		xserver_write_xdm_xserver_tmp_sockets(bluetooth_helper_t)
 	')
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.te serefpolicy-2.2.43/policy/modules/services/clamav.te
--- nsaserefpolicy/policy/modules/services/clamav.te	2006-05-17 16:57:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/clamav.te	2006-05-26 14:03:15.000000000 -0400
@@ -39,6 +39,10 @@
 type clamscan_exec_t;
 init_daemon_domain(clamscan_t, clamscan_exec_t)
 
+# tmp files
+type clamscan_tmp_t;
+files_tmp_file(clamscan_tmp_t)
+
 type freshclam_t;
 type freshclam_exec_t;
 init_daemon_domain(freshclam_t, freshclam_exec_t)
@@ -63,6 +67,13 @@
 allow clamd_t clamd_etc_t:file r_file_perms;
 allow clamd_t clamd_etc_t:lnk_file { getattr read };
 
+# Spool Files
+files_search_spool(clamd_t)
+optional_policy(`
+	amavis_spool_create_socket(clamd_t, clamd_var_run_t)
+	amavis_read_spool_file(clamd_t)
+')
+
 # socket file
 allow clamd_t clamd_sock_t:file manage_file_perms;
 allow clamd_t clamd_sock_t:sock_file manage_file_perms;
@@ -86,6 +97,7 @@
 allow clamd_t clamd_var_log_t:sock_file create_file_perms;
 allow clamd_t clamd_var_log_t:dir { rw_dir_perms setattr };
 logging_log_filetrans(clamd_t,clamd_var_log_t,file)
+logging_send_syslog_msg(clamd_t)
 
 # pid file
 allow clamd_t clamd_var_run_t:file manage_file_perms;
@@ -94,6 +106,10 @@
 files_pid_filetrans(clamd_t,clamd_var_run_t,file)
 
 kernel_dontaudit_list_proc(clamd_t)
+# dontaudit terminal access
+ifdef(`targeted_policy',`
+	term_dontaudit_use_generic_ptys(clamd_t)
+')
 
 corenet_non_ipsec_sendrecv(clamd_t)
 corenet_tcp_sendrecv_all_if(clamd_t)
@@ -217,6 +233,11 @@
 allow clamscan_t clamd_var_lib_t:sock_file rw_file_perms;
 allow clamscan_t clamd_var_lib_t:dir r_dir_perms;
 
+# tmp files
+allow clamscan_t clamscan_tmp_t:file create_file_perms;
+allow clamscan_t clamscan_tmp_t:dir create_dir_perms;
+files_tmp_filetrans(clamscan_t,clamscan_tmp_t,{ file dir })
+
 kernel_read_kernel_sysctls(clamscan_t)
 
 files_read_etc_files(clamscan_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.43/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-05-26 14:02:27.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/cups.te	2006-05-26 14:03:15.000000000 -0400
@@ -565,6 +565,7 @@
 allow hplip_t self:unix_stream_socket create_socket_perms;
 allow hplip_t self:tcp_socket create_stream_socket_perms;
 allow hplip_t self:udp_socket create_socket_perms;
+allow hplip_t self:netlink_route_socket r_netlink_socket_perms;
 # cjp: raw?
 allow hplip_t self:rawip_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.2.43/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-05-17 16:57:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/dovecot.te	2006-05-26 14:03:15.000000000 -0400
@@ -42,6 +42,7 @@
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
 
 domain_auto_trans(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 allow dovecot_t dovecot_auth_t:fd use;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.2.43/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-05-17 16:57:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/ftp.te	2006-05-26 14:03:15.000000000 -0400
@@ -162,15 +162,35 @@
 ')
 
 tunable_policy(`use_nfs_home_dirs && ftp_home_dir',`
+	fs_manage_nfs_files(ftpd_t)
+	fs_read_nfs_symlinks(ftpd_t)
+')
+
+tunable_policy(`allow_ftpd_use_cifs',`
 	fs_read_nfs_files(ftpd_t)
 	fs_read_nfs_symlinks(ftpd_t)
 ')
 
+tunable_policy(`allow_ftpd_use_nfs && allow_ftpd_anon_write',`
+	fs_manage_nfs_files(ftpd_t)
+	fs_read_nfs_symlinks(ftpd_t)
+')
+
 tunable_policy(`use_samba_home_dirs && ftp_home_dir',`
+	fs_manage_cifs_files(ftpd_t)
+	fs_read_cifs_symlinks(ftpd_t)
+')
+
+tunable_policy(`allow_ftpd_use_cifs',`
 	fs_read_cifs_files(ftpd_t)
 	fs_read_cifs_symlinks(ftpd_t)
 ')
 
+tunable_policy(`allow_ftpd_use_cifs && allow_ftpd_anon_write',`
+	fs_manage_cifs_files(ftpd_t)
+	fs_read_cifs_symlinks(ftpd_t)
+')
+
 optional_policy(`
 	corecmd_exec_shell(ftpd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ldap.fc serefpolicy-2.2.43/policy/modules/services/ldap.fc
--- nsaserefpolicy/policy/modules/services/ldap.fc	2005-10-06 17:29:17.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/ldap.fc	2006-05-26 14:03:15.000000000 -0400
@@ -8,3 +8,4 @@
 
 /var/run/slapd\.args	--	gen_context(system_u:object_r:slapd_var_run_t,s0)
 /var/run/slapd\.pid	--	gen_context(system_u:object_r:slapd_var_run_t,s0)
+/var/run/openldap(/.*)?		gen_context(system_u:object_r:slapd_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mysql.te serefpolicy-2.2.43/policy/modules/services/mysql.te
--- nsaserefpolicy/policy/modules/services/mysql.te	2006-04-12 12:59:10.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/mysql.te	2006-05-26 14:03:15.000000000 -0400
@@ -33,6 +33,7 @@
 allow mysqld_t self:capability { dac_override setgid setuid sys_resource net_bind_service };
 dontaudit mysqld_t self:capability sys_tty_config;
 allow mysqld_t self:process { setsched getsched setrlimit signal_perms };
+allow mysqld_t self:process { setsched getsched setrlimit signal_perms rlimitinh };
 allow mysqld_t self:fifo_file { read write };
 allow mysqld_t self:netlink_route_socket r_netlink_socket_perms;
 allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
@@ -103,6 +104,7 @@
 logging_send_syslog_msg(mysqld_t)
 
 miscfiles_read_localization(mysqld_t)
+miscfiles_read_certs(mysqld_t)
 
 sysnet_use_ldap(mysqld_t)
 sysnet_read_config(mysqld_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.fc serefpolicy-2.2.43/policy/modules/services/networkmanager.fc
--- nsaserefpolicy/policy/modules/services/networkmanager.fc	2006-02-06 17:51:14.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/services/networkmanager.fc	2006-05-26 14:03:15.000000000 -0400
@@ -2,3 +2,4 @@
 /usr/(s)?bin/NetworkManager	--	gen_context(system_u:object_r:NetworkManager_exec_t,s0)
 /var/run/NetworkManager.pid	--	gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
 /var/run/wpa_supplicant(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
+/var/run/NetworkManager(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.te serefpolicy-2.2.43/policy/modules/services/nscd.te
--- nsaserefpolicy/policy/modules/services/nscd.te	2006-04-12 12:59:10.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/nscd.te	2006-05-26 14:03:15.000000000 -0400
@@ -133,3 +133,8 @@
 optional_policy(`
 	udev_read_db(nscd_t)
 ')
+
+optional_policy(`
+	xen_dontaudit_rw_unix_stream_sockets(nscd_t)
+	xen_append_log(nscd_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.43/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/postfix.te	2006-05-26 14:03:15.000000000 -0400
@@ -289,12 +289,12 @@
 mta_read_config(postfix_local_t)
 
 optional_policy(`
-#	for postalias
-	mailman_read_data_files(postfix_local_t)
+	procmail_domtrans(postfix_local_t)
 ')
 
 optional_policy(`
-	procmail_domtrans(postfix_local_t)
+#	for postalias
+	mailman_manage_data_files(postfix_local_t)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pyzor.te serefpolicy-2.2.43/policy/modules/services/pyzor.te
--- nsaserefpolicy/policy/modules/services/pyzor.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/pyzor.te	2006-05-26 14:03:15.000000000 -0400
@@ -35,10 +35,20 @@
 allow pyzor_t pyzor_var_lib_t:file r_file_perms;
 files_search_var_lib(pyzor_t)
 
+corenet_udp_sendrecv_all_if(pyzor_t)
+corenet_udp_sendrecv_all_ports(pyzor_t)
+
 files_read_etc_files(pyzor_t)
 
 auth_use_nsswitch(pyzor_t)
 
+dev_read_urand(pyzor_t)
+
+corecmd_list_bin(pyzor_t)
+corecmd_getattr_bin_files(pyzor_t)
+kernel_read_kernel_sysctls(pyzor_t)  
+kernel_read_system_state(pyzor_t)
+
 libs_use_ld_so(pyzor_t)
 libs_use_shared_libs(pyzor_t)
 
@@ -46,6 +56,7 @@
 
 optional_policy(`
 	amavis_manage_lib_files(pyzor_t)
+	amavis_manage_spool_files(pyzor_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.43/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-05-02 18:59:59.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/samba.te	2006-05-26 14:03:15.000000000 -0400
@@ -222,9 +222,13 @@
 
 allow smbd_t winbind_var_run_t:sock_file { read write getattr };
 
+rpc_search_nfs_state_data(smbd_t)
+fs_getattr_rpc_dirs(smbd_t)
+
 kernel_getattr_core_if(smbd_t)
 kernel_getattr_message_if(smbd_t)
 kernel_read_network_state(smbd_t)
+kernel_read_fs_sysctls(smbd_t)
 kernel_read_kernel_sysctls(smbd_t)
 kernel_read_software_raid_state(smbd_t)
 kernel_read_system_state(smbd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.fc serefpolicy-2.2.43/policy/modules/services/spamassassin.fc
--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2006-04-19 11:26:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/spamassassin.fc	2006-05-26 14:03:15.000000000 -0400
@@ -5,6 +5,7 @@
 
 /usr/sbin/spamd		--	gen_context(system_u:object_r:spamd_exec_t,s0)
 /usr/bin/spamassassin	--	gen_context(system_u:object_r:spamassassin_exec_t,s0)
+/var/spool/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_spool_t,s0)
 
 ifdef(`strict_policy',`
 HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:ROLE_spamassassin_home_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.43/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-05-05 16:44:48.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/spamassassin.te	2006-05-26 14:03:15.000000000 -0400
@@ -20,6 +20,9 @@
 type spamd_var_run_t;
 files_pid_file(spamd_var_run_t)
 
+type spamd_spool_t;
+files_type(spamd_spool_t)
+
 type spamassassin_exec_t;
 corecmd_executable_file(spamassassin_exec_t)
 
@@ -57,6 +60,10 @@
 allow spamd_t spamd_var_run_t:dir rw_dir_perms;
 files_pid_filetrans(spamd_t,spamd_var_run_t,file)
 
+allow spamd_t spamd_spool_t:file create_file_perms;
+allow spamd_t spamd_spool_t:dir create_dir_perms;
+files_spool_filetrans(spamd_t,spamd_spool_t, { file dir })
+
 kernel_read_all_sysctls(spamd_t)
 kernel_read_system_state(spamd_t)
 kernel_tcp_recvfrom(spamd_t)
@@ -98,6 +105,7 @@
 files_read_usr_files(spamd_t)
 files_read_etc_files(spamd_t)
 files_read_etc_runtime_files(spamd_t)
+files_search_var_lib(spamd_t)
 
 init_use_fds(spamd_t)
 init_use_script_ptys(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.43/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/services/xserver.if	2006-05-26 14:03:15.000000000 -0400
@@ -1109,3 +1110,45 @@
 
 	dontaudit $1 xdm_xserver_t:tcp_socket { read write };
 ')
+
+
+########################################
+## <summary>
+##	Connect to xdm_xserver over a unix domain
+##	stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_stream_connect',`
+	gen_require(`
+		type xdm_xserver_t;
+	')
+
+	allow $1 xdm_xserver_t:unix_stream_socket connectto;
+')
+
+
+
+########################################
+## <summary>
+##	write xdm temporary socket files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit
+##	</summary>
+## </param>
+#
+interface(`xserver_write_xdm_xserver_tmp_sockets',`
+	gen_require(`
+		type xdm_xserver_tmp_t;
+	')
+
+	allow $1 xdm_xserver_tmp_t:sock_file write;
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.2.43/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.43/policy/modules/system/hostname.te	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.43/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-05-19 13:46:37.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/init.te	2006-05-26 14:03:15.000000000 -0400
@@ -348,6 +348,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.43/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/libraries.fc	2006-05-26 14:03:15.000000000 -0400
@@ -35,7 +35,8 @@
 /lib(/.*)?					gen_context(system_u:object_r:lib_t,s0)
 /lib64(/.*)?					gen_context(system_u:object_r:lib_t,s0)
 /lib(64)?/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
-/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
+/lib(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
+/lib64(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
 
 ifdef(`distro_gentoo',`
 /lib32(/.*)?					gen_context(system_u:object_r:lib_t,s0)
@@ -227,6 +228,13 @@
 /usr/(local/)?acroread/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?Adobe/.*\.api		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(.*/)?intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+
+/usr/lib/acroread/(.*/)?nppdf\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/acroread/(.*/)?sidecars/* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/acroread/(.*/)?nppdf\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/acroread/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/acroread/.*\.api		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/acroread/(.*/)?ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 ') dnl end distro_redhat
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.43/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/logging.te	2006-05-26 14:03:15.000000000 -0400
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
@@ -134,7 +138,11 @@
 term_dontaudit_use_console(auditd_t)
 
 # cjp: why?
+# Needs to be able to run dispatcher.  see /etc/audit/auditd.conf
+# Probably want a transition, and a new auditd_helper app
 corecmd_exec_sbin(auditd_t)
+corecmd_exec_bin(auditd_t)
+kernel_read_system_state(auditd_t)
 
 domain_use_interactive_fds(auditd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.43/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/unconfined.te	2006-05-26 14:03:15.000000000 -0400
@@ -107,6 +107,10 @@
 	')
 
 	optional_policy(`
+		unconfined_execmem_domtrans(unconfined_t)
+	')
+
+	optional_policy(`
 		lpd_domtrans_checkpc(unconfined_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.43/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-05-17 10:54:31.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/userdomain.te	2006-05-26 14:03:15.000000000 -0400
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
 
@@ -428,6 +461,7 @@
 	optional_policy(`
 		sysnet_run_ifconfig(sysadm_t,sysadm_r,admin_terminal)
 		sysnet_run_dhcpc(sysadm_t,sysadm_r,admin_terminal)
+		consoletype_run(sysadm_t,sysadm_r,admin_terminal)
 	')
 
 	optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.fc serefpolicy-2.2.43/policy/modules/system/xen.fc
--- nsaserefpolicy/policy/modules/system/xen.fc	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/xen.fc	2006-05-26 14:03:15.000000000 -0400
@@ -16,3 +16,4 @@
 /var/run/xend\.pid	--      gen_context(system_u:object_r:xend_var_run_t,s0)
 /var/run/xenstore\.pid	--	gen_context(system_u:object_r:xenstored_var_run_t,s0)
 /var/run/xenstored(/.*)?	gen_context(system_u:object_r:xenstored_var_run_t,s0)
+/xen(/.*)?			gen_context(system_u:object_r:xen_image_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.if serefpolicy-2.2.43/policy/modules/system/xen.if
--- nsaserefpolicy/policy/modules/system/xen.if	2006-05-03 16:01:26.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/xen.if	2006-05-26 14:03:15.000000000 -0400
@@ -124,6 +124,6 @@
 
 	domain_auto_trans($1,xm_exec_t,xm_t)
 	allow xm_t $1:fd use;
-	allow xm_t:$1:fifo_file rw_file_perms;
+	allow xm_t $1:fifo_file rw_file_perms;
 	allow xm_t $1:process sigchld;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.2.43/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/modules/system/xen.te	2006-05-26 14:03:15.000000000 -0400
@@ -50,6 +50,10 @@
 domain_entry_file(xenconsoled_t,xenconsoled_exec_t)
 role system_r types xenconsoled_t;
 
+# Xen Image files
+type xen_image_t; # customizable
+files_type(xen_image_t)
+
 # pid files
 type xenconsoled_var_run_t;
 files_pid_file(xenconsoled_var_run_t)
@@ -74,6 +78,11 @@
 allow xend_t self:tcp_socket create_stream_socket_perms;
 allow xend_t self:packet_socket create_socket_perms;
 
+files_etc_filetrans_etc_runtime(xend_t,file)
+
+allow xend_t xen_image_t:dir r_dir_perms;
+allow xend_t xen_image_t:file r_file_perms;
+
 # pid file
 allow xend_t xend_var_run_t:file manage_file_perms;
 allow xend_t xend_var_run_t:sock_file manage_file_perms;
@@ -89,8 +98,9 @@
 # var/lib files for xend
 allow xend_t xend_var_lib_t:file create_file_perms;
 allow xend_t xend_var_lib_t:sock_file create_file_perms;
+allow xend_t xend_var_lib_t:fifo_file create_file_perms;
 allow xend_t xend_var_lib_t:dir create_dir_perms;
-files_var_lib_filetrans(xend_t,xend_var_lib_t,{ file dir sock_file })
+files_var_lib_filetrans(xend_t,xend_var_lib_t,{ file dir })
 
 # transition to store
 domain_auto_trans(xend_t, xenstored_exec_t, xenstored_t)
@@ -113,6 +123,7 @@
 corecmd_exec_bin(xend_t)
 corecmd_exec_shell(xend_t)
 
+corenet_tcp_bind_all_nodes(xend_t)
 corenet_tcp_sendrecv_all_if(xend_t)
 corenet_tcp_sendrecv_all_nodes(xend_t)
 corenet_tcp_sendrecv_all_ports(xend_t)
@@ -242,7 +253,7 @@
 # xm local policy
 #
 
-allow xm_t self:capability dac_override;
+allow xm_t self:capability { dac_override ipc_lock };
 # internal communication is often done using fifo and unix sockets.
 allow xm_t self:fifo_file { read write };
 allow xm_t self:unix_stream_socket create_stream_socket_perms;
@@ -270,3 +281,15 @@
 xen_append_log(xm_t)
 xen_stream_connect(xm_t)
 xen_stream_connect_xenstore(xm_t)
+
+files_list_mnt(xm_t)
+
+init_rw_script_stream_sockets(xm_t)
+
+files_read_etc_runtime_files(xm_t)
+files_read_usr_files(xm_t)
+
+files_search_var_lib(xm_t)
+allow xm_t xend_var_lib_t:dir rw_dir_perms;
+allow xm_t xend_var_lib_t:fifo_file create_file_perms;
+allow xm_t xend_var_lib_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/rolemap serefpolicy-2.2.43/policy/rolemap
--- nsaserefpolicy/policy/rolemap	2006-01-26 15:38:41.000000000 -0500
+++ serefpolicy-2.2.43/policy/rolemap	2006-05-26 14:03:15.000000000 -0400
@@ -15,5 +15,6 @@
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
+		auditadm_r auditadm auditadm_t
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/support/misc_macros.spt serefpolicy-2.2.43/policy/support/misc_macros.spt
--- nsaserefpolicy/policy/support/misc_macros.spt	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.43/policy/support/misc_macros.spt	2006-05-26 14:03:15.000000000 -0400
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.43/policy/users
--- nsaserefpolicy/policy/users	2006-02-15 17:02:30.000000000 -0500
+++ serefpolicy-2.2.43/policy/users	2006-05-26 14:03:15.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.modular serefpolicy-2.2.43/Rules.modular
--- nsaserefpolicy/Rules.modular	2006-05-26 14:02:26.000000000 -0400
+++ serefpolicy-2.2.43/Rules.modular	2006-05-26 14:03:15.000000000 -0400
@@ -31,7 +31,7 @@
 vpath %.if $(ALL_LAYERS)
 vpath %.fc $(ALL_LAYERS)
 
-.SECONDARY:
+#.SECONDARY:
 
 ########################################
 #

--------------080007020909050306030104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
