Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4FKNAjs031204
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 16:23:10 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4FKN9eI004444
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 20:23:09 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k4FKNR8m012292
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 16:23:27 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k4FKNRGe012291
	for selinux@tycho.nsa.gov; Mon, 15 May 2006 16:23:27 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4FFw3pK023621
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 11:58:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4FFw2eI029306
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 15:58:02 GMT
Message-ID: <4468A509.50207@redhat.com>
Date: Mon, 15 May 2006 11:58:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs in policy
Content-Type: multipart/mixed;
 boundary="------------050408010709060905080705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050408010709060905080705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add boolean to allow mount to mount any file/filesystem.  (Bind Mounts).

More fixes for auditadm role.  Any chance of getting this into ref 
policy or should I separate out the patch?

Fixes for traceroute

prelink wants to read sbin symlinks

Mono needs to chat with unconfined_t (acquire_svc).

Fix label on scsi_id to stop matchpathcon error message


Lots of new network ports for hplib and http.

Traceroute port range defined.

Add setrans domain

Want to associate all files with tmpfs so the user can mv /etc/FILE /tmp 
and not blow up.

Add clamscan policy

Allow bluetooth to communicate with xdm pipes.

Allow sysadm to run cvs and rdisk

Dovecod wants quota support

ftpd needs dav override when logging in to users homedirs

Hal wants to search all directories in case they are mount points

Fixes to inn.if for executing inn and allowin domtrans

ypbind needs to be able to bind to rpc ports

postgresql wants to look at the routing table.

pyzor domain for strict/mls policy

rpc wants to red /dev/random
nfsd needs dac privs

Added some corecmd_executable_file for prelink to work correctly

sshd wants to read routing table

Only want dhcp to transition to hostname everyone else should just 
execute it.

More fixes for textrel_shlib_t. will they ever end

Separation of the auditadm from secadm and sysadm changes for auditd files.

semanage is now translated.

semodule needs to be able to read home dir and /tmp dir since this is 
where people are creating modules.

ifconfig wants to read urand for ipsec setup

unconfined domtrans to prelink and inn












--------------050408010709060905080705
Content-Type: text/x-patch;
 name="policy-20060505.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20060505.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-strict-mls/default_type serefpolicy-2.2.38/config/appconfig-strict-mls/default_type
--- nsaserefpolicy/config/appconfig-strict-mls/default_type	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.38/config/appconfig-strict-mls/default_type	2006-05-11 22:39:48.000000000 -0400
@@ -2,3 +2,4 @@
 secadm_r:secadm_t
 staff_r:staff_t
 user_r:user_t
+auditadm_r:auditadm_t
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_booleans serefpolicy-2.2.38/policy/global_booleans
--- nsaserefpolicy/policy/global_booleans	2006-02-10 17:05:17.000000000 -0500
+++ serefpolicy-2.2.38/policy/global_booleans	2006-05-11 22:39:48.000000000 -0400
@@ -28,3 +28,11 @@
 ## </p>
 ## </desc>
 gen_bool(secure_mode_policyload,false)
+
+## <desc>
+## <p>
+## Allow mount to mount any file
+## </p>
+## </desc>
+gen_bool(allow_mount_anyfile,false)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.2.38/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2006-04-27 10:31:31.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/admin/netutils.te	2006-05-11 22:39:48.000000000 -0400
@@ -187,6 +187,7 @@
 # traceroute needs this but not tracepath
 corenet_raw_bind_all_nodes(traceroute_t)
 corenet_tcp_connect_all_ports(traceroute_t)
+corenet_udp_bind_traceroute_port(traceroute_t)
 
 fs_dontaudit_getattr_xattr_fs(traceroute_t)
 
@@ -195,6 +196,8 @@
 files_read_etc_files(traceroute_t)
 files_dontaudit_search_var(traceroute_t)
 
+init_use_fds(traceroute_t)
+
 libs_use_ld_so(traceroute_t)
 libs_use_shared_libs(traceroute_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.te serefpolicy-2.2.38/policy/modules/admin/prelink.te
--- nsaserefpolicy/policy/modules/admin/prelink.te	2006-04-20 08:17:35.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/admin/prelink.te	2006-05-11 22:39:48.000000000 -0400
@@ -46,6 +46,7 @@
 corecmd_manage_all_executables(prelink_t)
 corecmd_relabel_all_executables(prelink_t)
 corecmd_mmap_all_executables(prelink_t)
+corecmd_read_sbin_symlinks(prelink_t)
 
 dev_read_urand(prelink_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.2.38/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	2006-05-03 16:26:07.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/apps/mono.te	2006-05-11 23:13:08.000000000 -0400
@@ -22,6 +22,7 @@
 	unconfined_domain_noaudit(mono_t)
 	unconfined_dbus_chat(mono_t)
 
+	role system_r types mono_t;
 	init_dbus_chat_script(mono_t)
 
 	optional_policy(`
@@ -35,4 +36,8 @@
 	optional_policy(`
 		networkmanager_dbus_chat(mono_t)
 	')
+
+	optional_policy(`
+		unconfined_dbus_connect_bus(mono_t)
+	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.2.38/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-04-27 10:31:32.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/corecommands.fc	2006-05-11 22:39:48.000000000 -0400
@@ -76,7 +76,7 @@
 #
 
 /lib/udev/[^/]*			--	gen_context(system_u:object_r:bin_t,s0)
-
+/lib/udev/scsi_id		--	gen_context(system_u:object_r:sbin_t,s0)
 ifdef(`distro_gentoo',`
 /lib/rcscripts/addons(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /lib/rcscripts/sh(/.*)?			gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.2.38/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-05-03 16:26:07.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/corenetwork.te.in	2006-05-12 11:00:03.000000000 -0400
@@ -69,9 +69,9 @@
 network_port(giftd, tcp,1213,s0)
 network_port(gopher, tcp,70,s0, udp,70,s0)
 network_port(http_cache, tcp,3128,s0, udp,3130,s0, tcp,8080,s0, tcp,8118,s0) # 8118 is for privoxy
-network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0)
+network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0, tcp,8009,s0)
 network_port(howl, tcp,5335,s0, udp,5353,s0)
-network_port(hplip, tcp,50000,s0, tcp,50002,s0, tcp,9100,s0)
+network_port(hplip, tcp,50000,s0, tcp,50002,s0, tcp,1782,s0, tcp,8292,s0, tcp,9100,s0, tcp,9101,s0, tcp,9102,s0, tcp,9220,s0, tcp,9221,s0, tcp,9222,s0, tcp,9280,s0, tcp,9281,s0, tcp,9282,s0, tcp,9290,s0, tcp,9291,s0, tcp,9292,s0)
 network_port(i18n_input, tcp,9010,s0)
 network_port(imaze, tcp,5323,s0, udp,5323,s0)
 network_port(inetd_child, tcp,7,s0, udp,7,s0, tcp,9,s0, udp,9,s0, tcp,13,s0, udp,13,s0, tcp,19,s0, udp,19,s0, tcp,37,s0, udp,37,s0, tcp,512,s0, tcp,543,s0, tcp,544,s0, tcp,891,s0, udp,891,s0, tcp,892,s0, udp,892,s0, tcp,2105,s0, tcp,5666,s0)
@@ -125,6 +125,7 @@
 network_port(telnetd, tcp,23,s0)
 network_port(tftp, udp,69,s0)
 network_port(tor, tcp,9001,s0, tcp,9030,s0, tcp,9050,s0)
+network_port(traceroute, udp,64000-64010,s0)
 network_port(transproxy, tcp,8081,s0)
 type utcpserver_port_t, port_type; dnl network_port(utcpserver) # no defined portcon
 network_port(uucpd, tcp,540,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/domain.te serefpolicy-2.2.38/policy/modules/kernel/domain.te
--- nsaserefpolicy/policy/modules/kernel/domain.te	2006-04-20 08:17:36.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/domain.te	2006-05-11 22:39:48.000000000 -0400
@@ -87,6 +87,8 @@
 # list the root directory
 files_list_root(domain)
 
+setrans_translate_context(domain)
+
 ifdef(`targeted_policy',`
 	# RBAC is disabled in the targeted policy,
 	# as only one role is used, system_r.
@@ -96,6 +98,7 @@
 	# workaround until role dominance is fixed in
 	# the module compiler
 	role secadm_r types domain;
+	role auditadm_r types domain;
 	role sysadm_r types domain;
 	role user_r types domain;
 	role staff_r types domain;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.38/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-05-03 11:38:52.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/files.if	2006-05-11 22:39:48.000000000 -0400
@@ -1712,6 +1712,21 @@
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.te serefpolicy-2.2.38/policy/modules/kernel/files.te
--- nsaserefpolicy/policy/modules/kernel/files.te	2006-04-28 22:50:56.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/files.te	2006-05-11 22:39:48.000000000 -0400
@@ -181,6 +181,10 @@
 fs_associate(file_type)
 fs_associate_noxattr(file_type)
 
+ifdef(`targeted_policy', `
+	fs_associate_tmpfs(file_type)
+')
+
 ########################################
 #
 # Rules for all tmp file types
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.2.38/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-05-01 14:39:05.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/kernel.if	2006-05-11 22:39:48.000000000 -0400
@@ -1413,7 +1413,7 @@
 		type proc_t, sysctl_t, sysctl_kernel_t;
 	')
 
-	allow $1 proc_t:dir search;
+	allow $1 proc_t:dir search_dir_perms;
 	allow $1 sysctl_t:dir r_dir_perms;
 	allow $1 sysctl_kernel_t:dir r_dir_perms;
 	allow $1 sysctl_kernel_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.38/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-05-01 14:39:06.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/kernel/kernel.te	2006-05-11 22:39:48.000000000 -0400
@@ -28,6 +28,7 @@
 
 ifdef(`enable_mls',`
 	role secadm_r;
+	role auditadm_r;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.38/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-03-07 10:31:09.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/kernel/mls.te	2006-05-11 22:39:48.000000000 -0400
@@ -62,4 +62,5 @@
 range_transition initrc_t auditd_exec_t s15:c0.c255;
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
+range_transition initrc_t setrans_exec_t s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.2.38/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-05-03 11:38:52.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/apache.te	2006-05-11 22:39:48.000000000 -0400
@@ -454,11 +454,6 @@
 	yam_read_content(httpd_t)
 ')
 
-ifdef(`TODO',`
-can_tcp_connect(web_client_domain, httpd_t)
-
-') dnl end TODO
-
 ########################################
 #
 # Apache helper local policy
@@ -712,6 +707,10 @@
 	mysql_rw_db_sockets(httpd_sys_script_t)
 ')
 
+optional_policy(`
+	clamscan_domtrans(httpd_sys_script_t)
+')
+
 ########################################
 #
 # Apache unconfined script local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.38/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-04-12 13:44:36.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/bluetooth.te	2006-05-11 22:39:48.000000000 -0400
@@ -222,6 +222,8 @@
 
 	optional_policy(`
 		xserver_stream_connect_xdm(bluetooth_helper_t)
+		xserver_use_xdm_fds(bluetooth_helper_t)
+		xserver_rw_xdm_pipes(bluetooth_helper_t)
 	')
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.fc serefpolicy-2.2.38/policy/modules/services/clamav.fc
--- nsaserefpolicy/policy/modules/services/clamav.fc	2006-03-07 16:19:28.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/clamav.fc	2006-05-11 22:39:48.000000000 -0400
@@ -1,6 +1,8 @@
 /etc/clamav(/.*)?			gen_context(system_u:object_r:clamd_etc_t,s0)
 
 /usr/bin/freshclam		--	gen_context(system_u:object_r:freshclam_exec_t,s0)
+/usr/bin/clamscan		--	gen_context(system_u:object_r:clamscan_exec_t,s0)
+/usr/bin/clamdscan		--	gen_context(system_u:object_r:clamscan_exec_t,s0)
 
 /usr/sbin/clamd			--	gen_context(system_u:object_r:clamd_exec_t,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.if serefpolicy-2.2.38/policy/modules/services/clamav.if
--- nsaserefpolicy/policy/modules/services/clamav.if	2006-03-07 16:19:28.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/clamav.if	2006-05-11 22:39:48.000000000 -0400
@@ -61,3 +61,27 @@
 	files_search_etc($1)
 	allow $1 clamd_etc_t:file r_file_perms;
 ')
+
+########################################
+## <summary>
+##	Execute a domain transition to run clamscan.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`clamscan_domtrans',`
+	gen_require(`
+		type clamscan_t, clamscan_exec_t;
+	')
+
+	domain_auto_trans($1,clamscan_exec_t,clamscan_t)
+
+	allow $1 clamscan_t:fd use;
+	allow clamscan_t $1:fd use;
+	allow clamscan_t $1:fifo_file rw_file_perms;
+	allow clamscan_t $1:process sigchld;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.te serefpolicy-2.2.38/policy/modules/services/clamav.te
--- nsaserefpolicy/policy/modules/services/clamav.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/clamav.te	2006-05-11 22:39:48.000000000 -0400
@@ -39,6 +39,10 @@
 type freshclam_exec_t;
 init_daemon_domain(freshclam_t, freshclam_exec_t)
 
+type clamscan_t;
+type clamscan_exec_t;
+init_daemon_domain(clamscan_t, clamscan_exec_t)
+
 # log files
 type freshclam_var_log_t;
 logging_log_file(freshclam_var_log_t)
@@ -193,3 +197,44 @@
 cron_use_fds(freshclam_t)
 cron_use_system_job_fds(freshclam_t)
 cron_rw_pipes(freshclam_t)
+
+########################################
+#
+# clamscam local policy
+#
+
+allow clamscan_t self:capability { setgid setuid dac_override };
+allow clamscan_t self:fifo_file rw_file_perms;
+allow clamscan_t self:unix_stream_socket create_stream_socket_perms;
+allow clamscan_t self:unix_dgram_socket create_socket_perms;
+allow clamscan_t self:tcp_socket { listen accept };
+
+# configuration files
+allow clamscan_t clamd_etc_t:dir r_dir_perms;
+allow clamscan_t clamd_etc_t:file r_file_perms;
+allow clamscan_t clamd_etc_t:lnk_file { getattr read };
+
+# var/lib files together with clamd
+allow clamscan_t clamd_var_lib_t:file r_file_perms;
+allow clamscan_t clamd_var_lib_t:sock_file rw_file_perms;
+allow clamscan_t clamd_var_lib_t:dir r_dir_perms;
+
+files_search_var_lib(clamscan_t)
+
+files_read_etc_files(clamscan_t)
+files_read_etc_runtime_files(clamscan_t)
+
+kernel_read_kernel_sysctls(clamscan_t)
+
+libs_use_ld_so(clamscan_t)
+libs_use_shared_libs(clamscan_t)
+
+miscfiles_read_localization(clamscan_t)
+
+clamav_stream_connect(clamscan_t)
+
+miscfiles_read_public_files(clamscan_t)
+
+optional_policy(`
+	apache_read_sys_content(clamscan_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.if serefpolicy-2.2.38/policy/modules/services/cvs.if
--- nsaserefpolicy/policy/modules/services/cvs.if	2006-02-10 17:05:19.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/cvs.if	2006-05-11 22:39:48.000000000 -0400
@@ -17,3 +17,23 @@
 
 	allow $1 cvs_data_t:file { getattr read };
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to execute cvs
+##	in the caller domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cvs_exec',`
+	gen_require(`
+		type cvs_exec_t;
+	')
+
+	can_exec($1,cvs_exec_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.te serefpolicy-2.2.38/policy/modules/services/cvs.te
--- nsaserefpolicy/policy/modules/services/cvs.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/cvs.te	2006-05-11 22:39:48.000000000 -0400
@@ -8,6 +8,7 @@
 
 type cvs_t;
 type cvs_exec_t;
+corecmd_executable_file(cvs_exec_t)
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
 role system_r types cvs_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.2.38/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/dovecot.te	2006-05-12 13:26:57.000000000 -0400
@@ -95,6 +95,11 @@
 domain_use_interactive_fds(dovecot_t)
 
 files_read_etc_files(dovecot_t)
+
+# Dovecot now has quota support and it uses getmntent() to find the mountpoints.
+files_read_etc_runtime_files(dovecot_t)
+files_getattr_all_mountpoints(dovecot_t)
+
 files_search_spool(dovecot_t)
 files_search_tmp(dovecot_t)
 files_dontaudit_list_default(dovecot_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.2.38/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-04-19 12:23:07.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/ftp.te	2006-05-11 22:39:48.000000000 -0400
@@ -149,6 +149,7 @@
 	userdom_manage_all_users_home_content_dirs(ftpd_t)
 	userdom_manage_all_users_home_content_files(ftpd_t)
 	userdom_manage_all_users_home_content_symlinks(ftpd_t)
+	allow ftpd_t self:capability { dac_override dac_read_search };
 
 	ifdef(`targeted_policy',`
 		userdom_generic_user_home_dir_filetrans_generic_user_home_content(ftpd_t,{ dir file lnk_file sock_file fifo_file })
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.38/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-04-20 08:17:39.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/hal.te	2006-05-11 22:39:48.000000000 -0400
@@ -51,9 +51,6 @@
 kernel_rw_vm_sysctls(hald_t)
 kernel_write_proc_files(hald_t)
 
-files_search_boot(hald_t)
-files_getattr_home_dir(hald_t)
-
 auth_read_pam_console_data(hald_t)
 
 corecmd_exec_all_executables(hald_t)
@@ -95,7 +92,7 @@
 files_read_usr_files(hald_t)
 # hal is now execing pm-suspend
 files_create_boot_flag(hald_t)
-files_getattr_default_dirs(hald_t)
+files_getattr_all_dirs(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
@@ -154,7 +151,6 @@
 	term_dontaudit_use_unallocated_ttys(hald_t)
 	term_dontaudit_use_generic_ptys(hald_t)
 	files_dontaudit_read_root_files(hald_t)
-	files_dontaudit_getattr_home_dir(hald_t)
 ')
 
 optional_policy(`
@@ -164,10 +160,6 @@
 ')
 
 optional_policy(`
-	automount_dontaudit_getattr_tmp_dirs(hald_t)
-')
-
-optional_policy(`
 	bind_search_cache(hald_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/inn.if serefpolicy-2.2.38/policy/modules/services/inn.if
--- nsaserefpolicy/policy/modules/services/inn.if	2006-02-10 17:05:19.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/inn.if	2006-05-11 22:39:48.000000000 -0400
@@ -16,7 +16,7 @@
 		type innd_t;
 	')
 
-	can_exec($1,innd_t)
+	can_exec($1,innd_exec_t)
 ')
 
 ########################################
@@ -156,3 +156,29 @@
 
 	allow $1 innd_t:unix_dgram_socket sendto;
 ')
+
+
+########################################
+## <summary>
+##	Execute inn in the inn domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`inn_domtrans',`
+	gen_require(`
+		type innd_t, innd_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1,innd_exec_t,innd_t)
+
+	allow $1 innd_t:fd use;
+	allow innd_t $1:fd use;
+	allow innd_t $1:fifo_file rw_file_perms;
+	allow innd_t $1:process sigchld;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.te serefpolicy-2.2.38/policy/modules/services/nis.te
--- nsaserefpolicy/policy/modules/services/nis.te	2006-05-04 12:51:36.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/nis.te	2006-05-11 22:39:48.000000000 -0400
@@ -87,6 +87,7 @@
 corenet_udp_bind_generic_port(ypbind_t)
 corenet_tcp_bind_reserved_port(ypbind_t)
 corenet_udp_bind_reserved_port(ypbind_t)
+corenet_tcp_bind_all_rpc_ports(ypbind_t)
 corenet_tcp_connect_all_ports(ypbind_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(ypbind_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(ypbind_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postgresql.te serefpolicy-2.2.38/policy/modules/services/postgresql.te
--- nsaserefpolicy/policy/modules/services/postgresql.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/services/postgresql.te	2006-05-11 22:39:48.000000000 -0400
@@ -41,6 +41,7 @@
 allow postgresql_t self:udp_socket create_stream_socket_perms;
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
+allow postgresql_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit postgresql_t self:capability { sys_tty_config sys_admin };
 
 allow postgresql_t postgresql_db_t:dir create_dir_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pyzor.if serefpolicy-2.2.38/policy/modules/services/pyzor.if
--- nsaserefpolicy/policy/modules/services/pyzor.if	2006-05-03 16:01:26.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/pyzor.if	2006-05-11 22:39:48.000000000 -0400
@@ -44,3 +44,37 @@
 	corecmd_search_bin($1)
 	can_exec($1,pyzor_exec_t)
 ')
+
+#######################################
+## <summary>
+##	The per user domain template for the pyzor module.
+## </summary>
+## <desc>
+##	<p>
+##	This template allows pyzord to manage files in
+##	a user home directory, creating files with the
+##	correct type.
+##	</p>
+##	<p>
+##	This template is invoked automatically for each user, and
+##	generally does not need to be invoked directly
+##	by policy writers.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+#
+template(`pyzor_per_userdomain_template',`
+	type $1_pyzor_home_t;
+	files_type($1_pyzor_home_t)
+
+	userdom_search_user_home_dirs($1,pyzord_t)
+	userdom_user_home_dir_filetrans($1,pyzord_t,$1_pyzord_home_t,{ dir file lnk_file })
+	allow pyzord_t $1_pyzor_home_t:dir create_dir_perms;
+	allow pyzord_t $1_pyzor_home_t:file create_file_perms;
+	allow pyzord_t $1_pyzor_home_t:lnk_file create_lnk_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rpc.te serefpolicy-2.2.38/policy/modules/services/rpc.te
--- nsaserefpolicy/policy/modules/services/rpc.te	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/rpc.te	2006-05-12 14:19:20.000000000 -0400
@@ -65,6 +65,8 @@
 files_manage_mounttab(rpcd_t)
 
 miscfiles_read_certs(rpcd_t)
+dev_read_urand(rpcd_t)
+dev_read_rand(rpcd_t)
 
 seutil_dontaudit_search_config(rpcd_t)
 
@@ -83,7 +85,7 @@
 # NFSD local policy
 #
 
-allow nfsd_t self:capability { sys_admin sys_resource };
+allow nfsd_t self:capability { dac_override dac_read_search sys_admin sys_resource };
 
 allow nfsd_t exports_t:file { getattr read };
 allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-2.2.38/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2006-04-28 22:50:57.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/rsync.te	2006-05-11 22:39:48.000000000 -0400
@@ -8,6 +8,7 @@
 
 type rsync_t;
 type rsync_exec_t;
+corecmd_executable_file(rsync_exec_t)
 init_daemon_domain(rsync_t,rsync_exec_t)
 role system_r types rsync_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.te serefpolicy-2.2.38/policy/modules/services/ssh.te
--- nsaserefpolicy/policy/modules/services/ssh.te	2006-05-08 09:53:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/ssh.te	2006-05-12 16:25:44.000000000 -0400
@@ -17,6 +17,7 @@
 
 type ssh_keysign_exec_t;
 files_type(ssh_keysign_exec_t)
+corecmd_executable_file(ssh_keysign_exec_t)
 
 # real declaration moved to mls until
 # range_transition works in loadable modules
@@ -73,7 +74,7 @@
 ifdef(`strict_policy',`
 	# so a tunnel can point to another ssh tunnel
 	allow sshd_t self:tcp_socket { acceptfrom connectto recvfrom };
-
+	allow sshd_t self:netlink_route_socket r_netlink_socket_perms;
 	allow sshd_t sshd_tmp_t:dir create_dir_perms;
 	allow sshd_t sshd_tmp_t:file create_file_perms;
 	allow sshd_t sshd_tmp_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.38/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-05-03 11:38:54.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/services/xserver.if	2006-05-11 22:39:48.000000000 -0400
@@ -1073,3 +1073,41 @@
 
 	dontaudit $1 xdm_xserver_t:tcp_socket { read write };
 ')
+
+
+########################################
+## <summary>
+##	Use file descriptors for xdm.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`xserver_use_xdm_fds',`
+	gen_require(`
+		type xdm_t;
+	')
+
+	allow $1 xdm_t:fd use; 
+')
+
+########################################
+## <summary>
+##	Use file descriptors for xdm.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`xserver_rw_xdm_pipes',`
+	gen_require(`
+		type xdm_t;
+	')
+
+	allow $1 xdm_t:fifo_file { getattr read write }; 
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.2.38/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/system/hostname.te	2006-05-11 22:39:48.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.if serefpolicy-2.2.38/policy/modules/system/init.if
--- nsaserefpolicy/policy/modules/system/init.if	2006-04-05 17:08:56.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/init.if	2006-05-12 16:20:49.000000000 -0400
@@ -690,6 +690,25 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to read/write to
+##	init scripts with a unix socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_stream_rw_script',`
+	gen_require(`
+		type initrc_t;
+	')
+
+	allow $1 initrc_t:unix_stream_socket { read write };
+')
+
+########################################
+## <summary>
 ##	Dont audit the specified domain connecting to
 ##	init scripts with a unix domain stream socket.
 ## </summary>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.38/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-05-05 09:51:43.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/init.te	2006-05-11 22:39:48.000000000 -0400
@@ -350,6 +350,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.38/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/libraries.fc	2006-05-11 22:39:48.000000000 -0400
@@ -40,6 +40,8 @@
 /opt/(.*/)?lib64/.*\.so\.[^/]*		--	gen_context(system_u:object_r:shlib_t,s0)
 /opt/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/(.*/)?jre.*/libjvm.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/(.*/)?jre.*/libawt.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/netbeans(.*/)?jdk.*/linux/.*.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_gentoo',`
 /opt/netscape/plugins/libflashplayer.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -55,6 +57,7 @@
 # /usr
 #
 /usr/(.*/)?/HelixPlayer/.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?/RealPlayer/.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(.*/)?java/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(.*/)?java/.*\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
@@ -73,6 +76,7 @@
 
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
 
+/usr/lib(64)?/xulrunner-[^/]*/libxul.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(.*/)?lib(64)?(/.*)?/nvidia/.*\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/ati-fglrx/.*\.so(\..*)?	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -121,6 +125,7 @@
 /usr/lib(64)?/helix/codecs/colorcvt\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/helix/codecs/cvt1\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libSDL-.*\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xorg/modules/dri/.*\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/modules/dri/.*\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/dri/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libOSMesa\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -172,9 +177,9 @@
 # Livna.org packages: xmms-mp3, ffmpeg, xvidcore, xine-lib, gsm, lame
 /usr/lib(64)?.*/libmpg123\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/libavformat-.*\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/libavcodec-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/libavutil-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavformat-.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavcodec-.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavutil-.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libxvidcore\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xine/plugins/.*\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libgsm\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -183,6 +188,7 @@
 # Flash plugin, Macromedia
 HOME_DIR/.*/plugins/libflashplayer\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/libflashplayer\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/local/(.*/)?libflashplayer\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Jai, Sun Microsystems (Jpackage SPRM)
 /usr/lib(64)?/libmlib_jai\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -197,8 +203,11 @@
 # Java, Sun Microsystems (JPackage SRPM)
 /usr/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?(.*/)?jre.*/libjvm.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(local/)?(.*/)?jre.*/libawt.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(local/)?Adobe/(.*/)?intellinux/nppdf\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(local/)?Adobe/(.*/)?intellinux/sidecars/* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+
 /usr/(local/)?acroread/(.*/)?intellinux/nppdf\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?Adobe/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?acroread/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.if serefpolicy-2.2.38/policy/modules/system/logging.if
--- nsaserefpolicy/policy/modules/system/logging.if	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/logging.if	2006-05-12 15:49:11.000000000 -0400
@@ -399,3 +399,100 @@
 	allow $1 var_log_t:dir rw_dir_perms;
 	allow $1 var_log_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Manage the audit log.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_manage_audit_log',`
+	gen_require(`
+		type auditd_log_t;
+	')
+
+	files_search_var($1)
+	allow $1 auditd_log_t:dir create_dir_perms;
+	allow $1 auditd_log_t:file create_file_perms;
+')
+
+
+
+########################################
+## <summary>
+##	Manage the auditd configuration files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_manage_audit_config',`
+	gen_require(`
+		type auditd_etc_t;
+	')
+
+	files_search_etc($1)
+	allow $1 auditd_etc_t:file create_file_perms;
+')
+
+########################################
+## <summary>
+##	Execute auditd in the auditd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_domtrans_auditd',`
+	gen_require(`
+		type auditd_t, auditd_exec_t;
+	')
+
+	domain_auto_trans($1,auditd_exec_t,auditd_t)
+
+	allow $1 auditd_t:fd use;
+	allow auditd_t $1:fd use;
+	allow auditd_t $1:fifo_file rw_file_perms;
+	allow auditd_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute auditd in the auditd domain, and
+##	allow the specified role the auditd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the auditd domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the auditd domain to use.
+##	</summary>
+## </param>
+#
+interface(`logging_run_auditd',`
+	gen_require(`
+		type auditd_t;
+	')
+
+	logging_domtrans_auditd($1)
+	role $2 types auditd_t;
+	allow auditd_t $3:chr_file rw_term_perms;
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.38/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-04-27 10:31:33.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/logging.te	2006-05-12 16:30:18.000000000 -0400
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
@@ -72,6 +76,10 @@
 
 allow auditctl_t auditd_etc_t:file r_file_perms;
 
+# Needed for adding watches
+files_getattr_all_dirs(auditctl_t)
+files_read_etc_files(auditctl_t)
+
 kernel_read_kernel_sysctls(auditctl_t)
 kernel_read_proc_symlinks(auditctl_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.38/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/mount.te	2006-05-11 22:39:48.000000000 -0400
@@ -169,4 +169,8 @@
 ifdef(`targeted_policy',`
 	files_etc_filetrans_etc_runtime(unconfined_mount_t,file)
 	unconfined_domain(unconfined_mount_t)
+	tunable_policy(`allow_mount_anyfile',`
+		auth_read_all_dirs_except_shadow(mount_t)
+		auth_read_all_files_except_shadow(mount_t)
+	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.38/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/selinuxutil.te	2006-05-11 22:39:48.000000000 -0400
@@ -546,6 +546,8 @@
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
 
+miscfiles_read_localization(semanage_t)
+
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
 mls_file_read_up(semanage_t)
@@ -570,6 +572,12 @@
 seutil_get_semanage_trans_lock(semanage_t)
 seutil_get_semanage_read_lock(semanage_t)
 
+ifdef(`targeted_policy',`
+# Handle pp files created in homedir and /tmp
+	userdom_read_generic_user_home_content_files(semanage_t)
+	files_read_generic_tmp_files(semanage_t)
+')
+
 optional_policy(`
 	nscd_socket_use(semanage_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.fc serefpolicy-2.2.38/policy/modules/system/setrans.fc
--- nsaserefpolicy/policy/modules/system/setrans.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/system/setrans.fc	2006-05-11 22:39:48.000000000 -0400
@@ -0,0 +1,4 @@
+
+/sbin/mcstransd		--	gen_context(system_u:object_r:setrans_exec_t,s0)
+
+/var/run/setrans(/.*)?	gen_context(system_u:object_r:setrans_var_run_t,s15:c0.c255)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.if serefpolicy-2.2.38/policy/modules/system/setrans.if
--- nsaserefpolicy/policy/modules/system/setrans.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/system/setrans.if	2006-05-11 22:39:48.000000000 -0400
@@ -0,0 +1,24 @@
+## <summary>Policy for setrans.</summary>
+
+#######################################
+## <summary>
+##	Allow a domain to translate contexts.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`setrans_translate_context',`
+	gen_require(`
+		type setrans_t, setrans_var_run_t
+	')
+
+	allow $1 self:unix_stream_socket create_stream_socket_perms;
+	allow $1 setrans_t:unix_stream_socket connectto;
+	files_list_pids($1)
+	allow $1 setrans_var_run_t:dir search_dir_perms;
+	allow $1 setrans_var_run_t:sock_file rw_file_perms;
+	allow $1 setrans_var_run_t:unix_stream_socket rw_socket_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.te serefpolicy-2.2.38/policy/modules/system/setrans.te
--- nsaserefpolicy/policy/modules/system/setrans.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.38/policy/modules/system/setrans.te	2006-05-11 22:39:48.000000000 -0400
@@ -0,0 +1,67 @@
+
+policy_module(setrans,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type setrans_t;
+type setrans_exec_t;
+init_daemon_domain(setrans_t, setrans_exec_t)
+
+mls_file_read_up(setrans_t)
+mls_file_write_down(setrans_t)
+mls_net_receive_all_levels(setrans_t)
+mls_rangetrans_target(setrans_t)
+
+type setrans_var_run_t;
+files_pid_file(setrans_var_run_t)
+mls_trusted_object(setrans_var_run_t)
+
+########################################
+#
+# setrans local policy
+#
+
+init_use_fds(setrans_t)
+kernel_read_kernel_sysctls(setrans_t)
+kernel_read_proc_symlinks(setrans_t)
+allow setrans_t self:process { setcap signal_perms };
+
+libs_use_ld_so(setrans_t)
+libs_use_shared_libs(setrans_t)
+
+# create unix domain socket in /var
+allow setrans_t var_t:dir search_dir_perms;
+allow setrans_t var_run_t:dir search_dir_perms;
+allow setrans_t setrans_var_run_t:file manage_file_perms;
+allow setrans_t setrans_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(setrans_t,setrans_var_run_t,file)
+allow setrans_t setrans_var_run_t:sock_file create_file_perms;
+
+allow setrans_t self:unix_stream_socket create_stream_socket_perms;
+
+allow setrans_t self:unix_dgram_socket create_socket_perms;
+allow setrans_t self:netlink_selinux_socket create_socket_perms;
+
+miscfiles_read_localization(setrans_t)
+
+seutil_read_config(setrans_t)
+
+selinux_compute_access_vector(setrans_t)
+
+term_dontaudit_use_generic_ptys(setrans_t)
+
+files_read_etc_runtime_files(setrans_t)
+
+# allow performing getpidcon() on all processes
+domain_read_all_domains_state(setrans_t)
+#allow setrans_t domain:{ sock_file fifo_file } r_file_perms;
+domain_getattr_all_domains(setrans_t)
+domain_getsession_all_domains(setrans_t)
+
+corecmd_search_sbin(setrans_t)
+can_exec(setrans_t, setrans_exec_t)
+
+logging_send_syslog_msg(setrans_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/sysnetwork.te serefpolicy-2.2.38/policy/modules/system/sysnetwork.te
--- nsaserefpolicy/policy/modules/system/sysnetwork.te	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/sysnetwork.te	2006-05-11 22:39:48.000000000 -0400
@@ -86,6 +86,8 @@
 allow ifconfig_t dhcpc_t:fifo_file rw_file_perms;
 allow ifconfig_t dhcpc_t:process sigchld;
 
+dev_read_urand(ifconfig_t)
+
 kernel_read_system_state(dhcpc_t)
 kernel_read_network_state(dhcpc_t)
 kernel_read_kernel_sysctls(dhcpc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.38/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/unconfined.if	2006-05-11 22:39:48.000000000 -0400
@@ -431,3 +431,24 @@
 		errprint(`Warning: $0($1) has no effect in strict policy.'__endline__)
 	')
 ')
+
+########################################
+## <summary>
+##	Connect to the the unconfined DBUS
+##	for service (acquire_svc).
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`unconfined_dbus_connect_bus',`
+	gen_require(`
+		type unconfined_t;
+		class dbus acquire_svc;
+	')
+
+	allow $1 unconfined_t:dbus acquire_svc;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.38/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-05-03 16:26:08.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/unconfined.te	2006-05-11 22:39:48.000000000 -0400
@@ -65,6 +65,10 @@
 	')
 
 	optional_policy(`
+		inn_domtrans(unconfined_t)
+	')
+
+	optional_policy(`
 		init_dbus_chat_script(unconfined_t)
 
 		dbus_stub(unconfined_t)
@@ -115,6 +119,10 @@
 	')
 
 	optional_policy(`
+		prelink_domtrans(unconfined_t)
+	')
+
+	optional_policy(`
 		portmap_domtrans_helper(unconfined_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.38/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-05-03 11:38:54.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/userdomain.if	2006-05-11 22:39:48.000000000 -0400
@@ -4794,3 +4794,26 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
+
+########################################
+## <summary>
+##	read files
+##	in generic user home directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_read_generic_user_home_content_files',`
+	gen_require(`
+		type user_home_t;
+	')
+
+	files_search_home($1)
+	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_t:dir r_dir_perms;
+	allow $1 user_home_t:file r_file_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.38/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-05-05 09:51:43.000000000 -0400
+++ serefpolicy-2.2.38/policy/modules/system/userdomain.te	2006-05-12 16:30:38.000000000 -0400
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
@@ -179,12 +194,21 @@
 		mls_file_downgrade(secadm_t)
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
-		logging_run_auditctl(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
 		files_relabel_all_files(secadm_t)
 		auth_relabel_shadow(secadm_t)
+
+		corecmd_exec_shell(auditadm_t)
+		logging_manage_audit_log(auditadm_t)
+		logging_manage_audit_config(auditadm_t)
+		logging_run_auditctl(auditadm_t,auditadm_r,{ auditadm_tty_device_t auditadm_devpts_t })
+		logging_run_auditd(auditadm_t, auditadm_r, { auditadm_tty_device_t auditadm_devpts_t })
+		init_exec_script_files(auditadm_t)
+		files_manage_generic_locks(auditadm_t)
+		mls_file_write_down(auditadm_t)
 	', `
-		logging_read_audit_log(sysadm_t)
+		logging_manage_audit_log(sysadm_t)
+		logging_manage_audit_config(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
 	')
 
@@ -236,10 +260,19 @@
 	')
 
 	optional_policy(`
+		rsync_exec(sysadm_t)
+	')
+
+	optional_policy(`
+		cvs_exec(sysadm_t)
+	')
+
+	optional_policy(`
 		consoletype_exec(sysadm_t)
 
 		ifdef(`enable_mls',`
 			consoletype_exec(secadm_t)
+			consoletype_exec(auditadm_t)
 		')
 	')
 
@@ -258,6 +291,7 @@
 
 		ifdef(`enable_mls',`
 			dmesg_exec(secadm_t)
+			dmesg_exec(auditadm_t)
 		')
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/rolemap serefpolicy-2.2.38/policy/rolemap
--- nsaserefpolicy/policy/rolemap	2006-01-26 15:38:41.000000000 -0500
+++ serefpolicy-2.2.38/policy/rolemap	2006-05-12 14:58:36.000000000 -0400
@@ -15,5 +15,6 @@
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
+		auditadm_r auditadm auditadm_t
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.38/policy/users
--- nsaserefpolicy/policy/users	2006-02-15 17:02:30.000000000 -0500
+++ serefpolicy-2.2.38/policy/users	2006-05-11 22:39:48.000000000 -0400
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

--------------050408010709060905080705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
