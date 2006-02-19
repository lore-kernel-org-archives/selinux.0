Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1JDGLjp029464
	for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2006 08:16:21 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1JDGJPm002715
	for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2006 13:16:19 GMT
Message-ID: <43F86FA2.8010505@redhat.com>
Date: Sun, 19 Feb 2006 08:16:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latesr diffs
Content-Type: multipart/mixed;
 boundary="------------050105020309030308080007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050105020309030308080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add tunable for spam to read homedirs

Amanda needed some new features

vpnc role command was missing and wants to getattr on tmpfs

Add java_domtrans to eliminate some exec* messages in log files

Added router port for zebra

initrc needs to create a file on /dev

Automount wants to list the mnt_t directories

Avahi wants to read etc_runtime

Dontaudit fetchmail reading homedir.  This might be a bug since I think 
it wants to read ~/.fetchmailrc

hal now needs setgid

Add in.talkd to ktalkd policy

Spamd wants to talk to imaze

Add file_context for Xair

Many fixes for xserver to get it running on strict policy

Add customizable to swapfile

nvidia paths

lvm wants to look at removable_device_t - dontaudit

Cut and paste error in modutils

Transition to jave_t and vpnc_t from unconfined_t







--------------050105020309030308080007
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.2.16/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-02-16 09:05:13.000000000 -0500
+++ serefpolicy-2.2.16/policy/global_tunables	2006-02-19 07:09:54.000000000 -0500
@@ -469,3 +469,11 @@
 ## </desc>
 gen_tunable(xdm_sysadm_login,false)
 ')
+
+## <desc>
+## <p>
+## Allow spammd to read/write user home directories.
+## </p>
+## </desc>
+gen_tunable(spamd_enable_home_dirs,true)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.if serefpolicy-2.2.16/policy/modules/admin/amanda.if
--- nsaserefpolicy/policy/modules/admin/amanda.if	2006-02-10 21:34:11.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/admin/amanda.if	2006-02-19 07:09:54.000000000 -0500
@@ -90,3 +90,40 @@
 
 	dontaudit $1 amanda_dumpdates_t:file { getattr read };
 ')
+
+########################################
+## <summary>
+##	Allow read/writing /etc/dumpdates.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow
+##	</summary>
+## </param>
+#
+interface(`amanda_rw_dumpdates_files',`
+	gen_require(`
+		type amanda_dumpdates_t;
+	')
+
+	allow $1 amanda_dumpdates_t:file rw_file_perms;
+')
+########################################
+## <summary>
+##	Allow read/writing amanda logs
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow
+##	</summary>
+## </param>
+#
+interface(`amanda_append_log_files',`
+	gen_require(`
+		type amanda_log_t;
+	')
+
+	allow $1 amanda_log_t:file ra_file_perms;
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.te serefpolicy-2.2.16/policy/modules/admin/amanda.te
--- nsaserefpolicy/policy/modules/admin/amanda.te	2006-02-03 15:45:54.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/admin/amanda.te	2006-02-19 07:09:54.000000000 -0500
@@ -86,7 +86,7 @@
 # Amanda local policy
 #
 
-allow amanda_t self:capability { chown dac_override setuid };
+allow amanda_t self:capability { chown dac_override setuid kill };
 allow amanda_t self:process { setpgid signal };
 allow amanda_t self:fifo_file { getattr read write ioctl lock };
 allow amanda_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/vpn.te serefpolicy-2.2.16/policy/modules/admin/vpn.te
--- nsaserefpolicy/policy/modules/admin/vpn.te	2006-02-16 16:42:39.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/admin/vpn.te	2006-02-19 07:13:16.000000000 -0500
@@ -11,6 +11,7 @@
 
 type vpnc_exec_t;
 domain_entry_file(vpnc_t,vpnc_exec_t)
+role system_r types vpnc_t;
 
 type vpnc_tmp_t;
 files_tmp_file(vpnc_tmp_t)
@@ -69,6 +70,7 @@
 dev_read_sysfs(vpnc_t)
 
 fs_getattr_xattr_fs(vpnc_t)
+fs_getattr_tmpfs(vpnc_t)
 
 term_use_all_user_ptys(vpnc_t)
 term_use_all_user_ttys(vpnc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.2.16/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	2006-01-17 13:22:13.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/apps/java.fc	2006-02-19 07:09:54.000000000 -0500
@@ -3,3 +3,4 @@
 #
 /usr(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
 /usr/bin/gij		--	gen_context(system_u:object_r:java_exec_t,s0)
+/usr/bin/gcj-dbtool	--	gen_context(system_u:object_r:java_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.if serefpolicy-2.2.16/policy/modules/apps/java.if
--- nsaserefpolicy/policy/modules/apps/java.if	2006-02-16 09:05:14.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/apps/java.if	2006-02-19 07:09:54.000000000 -0500
@@ -178,3 +178,28 @@
 		xserver_user_client_template($1,$1_javaplugin_t,$1_javaplugin_tmpfs_t)
 	')
 ')
+
+########################################
+## <summary>
+##	Execute the java program in the java domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
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
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.te serefpolicy-2.2.16/policy/modules/apps/java.te
--- nsaserefpolicy/policy/modules/apps/java.te	2006-01-12 18:28:45.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/apps/java.te	2006-02-19 07:09:54.000000000 -0500
@@ -6,5 +6,19 @@
 # Declarations
 #
 
+type java_t;
+domain_type(java_t)
+
 type java_exec_t;
 files_type(java_exec_t)
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow java_t self:process { execstack execmem };
+	unconfined_domain_noaudit(java_t)
+	role system_r types java_t;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.2.16/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/kernel/corenetwork.te.in	2006-02-19 07:09:54.000000000 -0500
@@ -73,6 +73,7 @@
 network_port(imaze, tcp,5323,s0, udp,5323,s0)
 network_port(inetd_child, tcp,7,s0, udp,7,s0, tcp,9,s0, udp,9,s0, tcp,13,s0, udp,13,s0, tcp,19,s0, udp,19,s0, tcp,37,s0, udp,37,s0, tcp,512,s0, tcp,543,s0, tcp,544,s0, tcp,891,s0, udp,891,s0, tcp,892,s0, udp,892,s0, tcp,2105,s0, tcp,5666,s0)
 network_port(innd, tcp,119,s0)
+network_port(router, udp,520,s0)
 network_port(ipp, tcp,631,s0, udp,631,s0)
 network_port(ircd, tcp,6667,s0)
 network_port(isakmp, udp,500,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.16/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/kernel/devices.if	2006-02-19 07:33:14.000000000 -0500
@@ -393,6 +393,25 @@
 
 ########################################
 ## <summary>
+##	Create a file in the device directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to create the files.
+##	</summary>
+## </param>
+#
+interface(`dev_manage_generic_files',`
+	gen_require(`
+		type device_t;
+	')
+
+	allow $1 device_t:dir rw_dir_perms;
+	allow $1 device_t:file create_file_perms;
+')
+
+########################################
+## <summary>
 ##	Create, delete, read, and write symbolic links in device directories.
 ## </summary>
 ## <param name="domain">
@@ -2675,3 +2694,4 @@
 	typeattribute $1 memory_raw_write, memory_raw_read;
 ')
 
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.16/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/automount.te	2006-02-19 07:09:54.000000000 -0500
@@ -92,7 +92,7 @@
 
 files_dontaudit_write_var_dirs(automount_t)
 files_search_var_lib(automount_t)
-files_search_mnt(automount_t)
+files_list_mnt(automount_t)
 files_getattr_home_dir(automount_t)
 files_read_etc_files(automount_t)
 files_read_etc_runtime_files(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/avahi.te serefpolicy-2.2.16/policy/modules/services/avahi.te
--- nsaserefpolicy/policy/modules/services/avahi.te	2006-02-03 08:55:53.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/avahi.te	2006-02-19 07:09:54.000000000 -0500
@@ -63,6 +63,7 @@
 domain_use_wide_inherit_fd(avahi_t)
 
 files_read_etc_files(avahi_t)
+files_read_etc_runtime_files(avahi_t)
 
 init_use_fd(avahi_t)
 init_use_script_ptys(avahi_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/fetchmail.te serefpolicy-2.2.16/policy/modules/services/fetchmail.te
--- nsaserefpolicy/policy/modules/services/fetchmail.te	2006-02-14 07:20:26.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/fetchmail.te	2006-02-19 07:09:54.000000000 -0500
@@ -67,6 +67,7 @@
 
 files_read_etc_files(fetchmail_t)
 files_read_etc_runtime_files(fetchmail_t)
+files_dontaudit_search_home(fetchmail_t)
 
 fs_getattr_all_fs(fetchmail_t)
 fs_search_auto_mountpoints(fetchmail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.16/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/hal.te	2006-02-19 07:09:54.000000000 -0500
@@ -22,7 +22,7 @@
 #
 
 # execute openvt which needs setuid
-allow hald_t self:capability { setuid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio };
+allow hald_t self:capability { setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio };
 dontaudit hald_t self:capability sys_tty_config;
 allow hald_t self:process signal_perms;
 allow hald_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ktalk.fc serefpolicy-2.2.16/policy/modules/services/ktalk.fc
--- nsaserefpolicy/policy/modules/services/ktalk.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/ktalk.fc	2006-02-19 07:10:20.000000000 -0500
@@ -1,2 +1,2 @@
-
 /usr/bin/ktalkd		--	gen_context(system_u:object_r:ktalkd_exec_t,s0)
+/usr/bin/in.talkd		--	gen_context(system_u:object_r:ktalkd_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.16/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-14 07:20:28.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/spamassassin.te	2006-02-19 07:09:54.000000000 -0500
@@ -77,7 +77,9 @@
 # DnsResolver.pm module which binds to
 # random ports >= 1024.
 corenet_udp_bind_generic_port(spamd_t)
+corenet_udp_bind_imaze_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
+sysnet_use_ldap(spamd_t)
 
 dev_read_sysfs(spamd_t)
 dev_read_urand(spamd_t)
@@ -122,8 +124,11 @@
 	term_dontaudit_use_unallocated_ttys(spamd_t)
 	term_dontaudit_use_generic_ptys(spamd_t)
 	files_dontaudit_read_root_files(spamd_t)
-	userdom_manage_generic_user_home_dirs(spamd_t)
-	userdom_manage_generic_user_home_files(spamd_t)
+	tunable_policy(`spamd_enable_home_dirs',`
+		userdom_manage_generic_user_home_dirs(spamd_t)
+		userdom_manage_generic_user_home_files(spamd_t)
+		userdom_manage_generic_user_home_symlinks(spamd_t)
+	')
 ')
 
 tunable_policy(`use_nfs_home_dirs',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.fc serefpolicy-2.2.16/policy/modules/services/xserver.fc
--- nsaserefpolicy/policy/modules/services/xserver.fc	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/xserver.fc	2006-02-19 07:09:54.000000000 -0500
@@ -54,6 +54,7 @@
 /usr/bin/iceauth		--	gen_context(system_u:object_r:iceauth_exec_t,s0)
 /usr/bin/xauth    	--      gen_context(system_u:object_r:xauth_exec_t,s0)
 /usr/bin/Xorg		--	gen_context(system_u:object_r:xserver_exec_t,s0)
+/usr/bin/Xair		--	gen_context(system_u:object_r:xserver_exec_t,s0)
 
 /usr/lib(64)?/qt-.*/etc/settings(/.*)?	gen_context(system_u:object_r:xdm_var_run_t,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.16/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-02-16 09:05:14.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/xserver.if	2006-02-19 07:49:52.000000000 -0500
@@ -44,6 +44,8 @@
 	dontaudit $1_xserver_t self:capability chown;
 	allow $1_xserver_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 	allow $1_xserver_t self:process { execmem execheap setsched };
+	# NVIDIA Needs this ....
+	allow $1_xserver_t self:process { execstack };
 	allow $1_xserver_t self:fd use;
 	allow $1_xserver_t self:fifo_file rw_file_perms;
 	allow $1_xserver_t self:sock_file r_file_perms;
@@ -61,6 +63,7 @@
 	allow $1_xserver_t $1_xserver_tmp_t:sock_file manage_file_perms;
 	files_filetrans_tmp($1_xserver_t, $1_xserver_tmp_t, { file dir sock_file })
 
+	allow $1_xserver_t self:netlink_route_socket r_netlink_socket_perms;
 	allow $1_xserver_t xdm_xserver_tmp_t:dir rw_dir_perms;
 	type_transition $1_xserver_t xdm_xserver_tmp_t:sock_file $1_xserver_tmp_t;
 
@@ -86,6 +89,7 @@
 	kernel_read_modprobe_sysctls($1_xserver_t)
 	# Xorg wants to check if kernel is tainted
 	kernel_read_kernel_sysctls($1_xserver_t)
+	kernel_write_proc_files($1_xserver_t)
 
 	# Run helper programs in $1_xserver_t.
 	corecmd_search_sbin($1_xserver_t)
@@ -122,9 +126,12 @@
 	dev_rw_xserver_misc($1_xserver_t)
 	# read events - the synaptics touchpad driver reads raw events
 	dev_rw_input_dev($1_xserver_t)
+	dev_rwx_zero($1_xserver_t)
 
 	files_read_etc_files($1_xserver_t)
 	files_read_etc_runtime_files($1_xserver_t)
+	files_read_usr_files($1_xserver_t)
+
 	# brought on by rhgb
 	files_search_mnt($1_xserver_t)
 	# for nscd
@@ -134,6 +141,8 @@
 	fs_search_nfs($1_xserver_t)
 	fs_search_auto_mountpoints($1_xserver_t)
 
+	init_getpgid($1_xserver_t)
+
 	term_setattr_unallocated_ttys($1_xserver_t)
 	term_use_unallocated_ttys($1_xserver_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/zebra.te serefpolicy-2.2.16/policy/modules/services/zebra.te
--- nsaserefpolicy/policy/modules/services/zebra.te	2006-02-14 07:20:29.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/services/zebra.te	2006-02-19 07:09:54.000000000 -0500
@@ -73,6 +73,7 @@
 corenet_tcp_bind_all_nodes(zebra_t)
 corenet_udp_bind_all_nodes(zebra_t)
 corenet_tcp_bind_zebra_port(zebra_t)
+corenet_udp_bind_router_port(zebra_t)
 
 dev_associate_usbfs(zebra_var_run_t)
 dev_list_all_dev_nodes(zebra_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.16/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-02-14 07:20:29.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/fstools.te	2006-02-19 07:09:54.000000000 -0500
@@ -15,7 +15,7 @@
 type fsadm_tmp_t;
 files_tmp_file(fsadm_tmp_t)
 
-type swapfile_t;
+type swapfile_t; # customizable
 files_type(swapfile_t)
 
 ########################################
@@ -162,3 +162,8 @@
 optional_policy(`nis',`
 	nis_use_ypbind(fsadm_t)
 ')
+
+optional_policy(`amanda',`
+	amanda_rw_dumpdates_files(fsadm_t)
+	amanda_append_log_files(fsadm_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.16/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-02-16 16:42:39.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/init.te	2006-02-19 07:55:08.000000000 -0500
@@ -231,6 +231,8 @@
 allow initrc_t initrc_tmp_t:dir create_dir_perms;
 files_filetrans_tmp(initrc_t,initrc_tmp_t, { file dir })
 
+init_write_initctl(initrc_t)
+
 kernel_read_system_state(initrc_t)
 kernel_read_software_raid_state(initrc_t)
 kernel_read_network_state(initrc_t)
@@ -272,6 +274,7 @@
 dev_read_lvm_control(initrc_t)
 dev_delete_lvm_control_dev(initrc_t)
 dev_manage_generic_symlinks(initrc_t)
+dev_manage_generic_files(initrc_t)
 # Wants to remove udev.tbl:
 dev_delete_generic_symlinks(initrc_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.16/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-02-03 08:55:55.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/libraries.fc	2006-02-19 07:09:54.000000000 -0500
@@ -62,7 +62,7 @@
 /usr/lib(64)?/im/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 /usr/lib(64)?/iiim/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr/lib(64)?/libGL(core)?\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-2.2.16/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2006-02-07 10:43:26.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/lvm.te	2006-02-19 08:02:44.000000000 -0500
@@ -203,6 +203,7 @@
 fs_getattr_xattr_fs(lvm_t)
 fs_search_auto_mountpoints(lvm_t)
 fs_read_tmpfs_symlinks(lvm_t)
+fs_donaudit_read_removable_files(lvm_t)
 
 storage_relabel_fixed_disk(lvm_t)
 # LVM creates block devices in /dev/mapper or /dev/<vg>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/modutils.if serefpolicy-2.2.16/policy/modules/system/modutils.if
--- nsaserefpolicy/policy/modules/system/modutils.if	2006-02-10 21:34:15.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/modutils.if	2006-02-19 07:09:55.000000000 -0500
@@ -204,7 +204,7 @@
 	')
 
 	modutils_domtrans_depmod($1)
-	role $2 types insmod_t;
+	role $2 types depmod_t;
 	allow insmod_t $3:chr_file rw_term_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.16/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-01-09 11:32:54.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/selinuxutil.fc	2006-02-19 07:09:55.000000000 -0500
@@ -39,3 +39,5 @@
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
 ')
+
+/usr/sbin/semodule		--	gen_context(system_u:object_r:semodule_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.16/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/selinuxutil.if	2006-02-19 07:09:55.000000000 -0500
@@ -671,7 +671,7 @@
 
 	files_search_etc($1)
 	allow $1 selinux_config_t:dir search;
-	allow $1 policy_config_t:dir rw_dir_perms;
+	allow $1 policy_config_t:dir create_dir_perms;
 	allow $1 policy_config_t:file create_file_perms;
 	typeattribute $1 can_write_binary_policy;
 ')
@@ -705,3 +705,28 @@
 	allow $1 policy_src_t:dir create_dir_perms;
 	allow $1 policy_src_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Execute a domain transition to run semodule.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`semodule_domtrans',`
+	gen_require(`
+		type semodule_t, semodule_exec_t;
+	')
+	files_search_usr($1)
+	corecmd_search_bin($1)
+
+	domain_auto_trans($1,semodule_exec_t,semodule_t)
+
+	allow $1 semodule_t:fd use;
+	allow semodule_t $1:fd use;
+	allow semodule_t $1:fifo_file rw_file_perms;
+	allow semodule_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.16/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/selinuxutil.te	2006-02-19 07:09:55.000000000 -0500
@@ -535,3 +535,53 @@
 # scripts will put things in a state such that setfiles can not be run!
 allow setfiles_t lib_t:file { read execute };
 ') dnl endif TODO
+
+########################################
+#
+# Declarations
+#
+
+type semodule_t;
+domain_type(semodule_t)
+type semodule_exec_t;
+domain_entry_file(semodule_t, semodule_exec_t)
+role system_r types semodule_t;
+
+term_use_all_terms(semodule_t)
+allow semodule_t policy_config_t:file { read write };
+
+########################################
+#
+# semodule local policy
+#
+corecmd_exec_bin(semodule_t)
+corecmd_exec_sbin(semodule_t)
+
+files_read_etc_files(semodule_t)
+files_search_etc(semodule_t)
+files_list_usr(semodule_t)
+files_list_pids(semodule_t)
+files_read_usr_files(semodule_t)
+
+kernel_read_system_state(semodule_t)
+kernel_read_kernel_sysctls(semodule_t)
+
+libs_use_ld_so(semodule_t)
+libs_use_shared_libs(semodule_t)
+libs_use_lib_files(semodule_t)
+
+mls_rangetrans_target(semodule_t)
+
+optional_policy(`selinux', `
+	selinux_get_enforce_mode(semodule_t)
+')
+
+seutil_search_default_contexts(semodule_t)
+seutil_rw_file_contexts(semodule_t)
+seutil_domtrans_setfiles(semodule_t)
+seutil_domtrans_loadpolicy(semodule_t)
+seutil_read_config(semodule_t)
+seutil_manage_bin_policy(semodule_t)
+seutil_use_newrole_fd(semodule_t)
+
+allow semodule_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.16/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/unconfined.te	2006-02-19 07:09:55.000000000 -0500
@@ -157,6 +157,14 @@
 		wine_domtrans(unconfined_t)
 	')
 
+	optional_policy(`java',`
+		java_domtrans(unconfined_t)
+	')
+
+	optional_policy(`vpn',`
+		vpn_domtrans(unconfined_t)
+	')
+
 	optional_policy(`xserver',`
 		xserver_domtrans_xdm_xserver(unconfined_t)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.16/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-02-16 14:46:56.000000000 -0500
+++ serefpolicy-2.2.16/policy/modules/system/userdomain.te	2006-02-19 07:09:55.000000000 -0500
@@ -358,6 +358,8 @@
 			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
 			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
+			semodule_domtrans(secadm_t)
+			role secadm_r types semodule_t;
 			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
 		', `
 			selinux_set_enforce_mode(sysadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/support/Makefile.devel serefpolicy-2.2.16/support/Makefile.devel
--- nsaserefpolicy/support/Makefile.devel	2006-02-16 16:42:39.000000000 -0500
+++ serefpolicy-2.2.16/support/Makefile.devel	2006-02-19 07:09:55.000000000 -0500
@@ -1,3 +1,6 @@
+# installation paths
+SHAREDIR := $(PREFIX)/share/selinux
+HEADERDIR := $(SHAREDIR)/refpolicy/include
 
 include $(HEADERDIR)/build.conf
 
@@ -19,8 +22,13 @@
 PYTHON ?= python
 
 # set default build options if missing
-TYPE ?= strict
-NAME ?= $(TYPE)
+NAME ?= $(shell . /etc/selinux/config; echo $$SELINUXTYPE)
+MLSENABLED := $(shell cat /selinux/mls)
+ifeq ($(MLSENABLED),1)
+MCSFLAG=-mcs
+endif
+
+TYPE ?= $(NAME)${MCSFLAG}
 DIRECT_INITRC ?= n
 POLY ?= n
 QUIET ?= y

--------------050105020309030308080007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
