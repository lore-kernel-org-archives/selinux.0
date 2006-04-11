Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3BDPSoS020425
	for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2006 09:25:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3BDPQiP022079
	for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2006 13:25:26 GMT
Message-ID: <443BAE44.3060508@redhat.com>
Date: Tue, 11 Apr 2006 09:25:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Updates
Content-Type: multipart/mixed;
 boundary="------------090104040103050100060307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090104040103050100060307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

rpm needs to downgrade files in the policy package.

Added policy for ada to be allowed execmem privs (gnat)

Java is installed in yet another directory

New mono apps are communicating with userspace via dbus.  So need dbus 
capabilities.

/dev/dvb/* v41 devices

pam needs to be able to setattr on usbfs

Apache can_network_connect_db for scripts was missing.

automount wants to read certs

bluetooth needs ipc_lock, also wants to communicate with X

cupsd needs setattr on cupsd_var_run_t

bug in gpm policy

Hal continues to grow towards unconfined ...

mysql wants to talk to ldap

networkmanager needs to signal nscd (Reread /etc/resolv.conf ???)

rsync policy was broken.

snmp wants to read kernel device sysctls

bluetooth wants to read/write xdm sock file.  (This might be a FD Leak)

getty want to write to /var/spool/fax
getty wants to send mail

Lots more textrel_shlib_t changes

mount cifs needs setuid setgid.

Commenting out execstack execmem auditallows for now, to prevent 
flooding log files.

secadm needs to be able to relabel anything.

q









--------------090104040103050100060307
Content-Type: text/x-patch;
 name="policy-20060323.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20060323.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.2.30/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-04-04 18:06:37.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/admin/rpm.te	2006-04-11 07:05:00.000000000 -0400
@@ -117,6 +117,7 @@
 mls_file_read_up(rpm_t)
 mls_file_write_down(rpm_t)
 mls_file_upgrade(rpm_t)
+mls_file_downgrade(rpm_t)
 
 selinux_get_fs_mount(rpm_t)
 selinux_validate_context(rpm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/ada.fc serefpolicy-2.2.30/policy/modules/apps/ada.fc
--- nsaserefpolicy/policy/modules/apps/ada.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/apps/ada.fc	2006-04-11 07:05:00.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# /usr
+#
+/usr/libexec/gcc(/.*)?/gnat1 	--	gen_context(system_u:object_r:ada_exec_t,s0)
+/usr/bin/gnatbind	--	gen_context(system_u:object_r:ada_exec_t,s0)
+/usr/bin/gnatls		--	gen_context(system_u:object_r:ada_exec_t,s0)
+/usr/bin/gnatmake	--	gen_context(system_u:object_r:ada_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/ada.if serefpolicy-2.2.30/policy/modules/apps/ada.if
--- nsaserefpolicy/policy/modules/apps/ada.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/apps/ada.if	2006-04-11 07:05:43.000000000 -0400
@@ -0,0 +1,29 @@
+## <summary>Java virtual machine</summary>
+
+########################################
+## <summary>
+##	Execute the ada program in the ada domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ada_domtrans',`
+	ifdef(`targeted_policy',`
+		gen_require(`
+			type ada_t, ada_exec_t;
+		')
+
+		corecmd_search_bin($1)
+		domain_auto_trans($1, ada_exec_t, ada_t)
+
+		allow $1 ada_t:fd use;
+		allow ada_t $1:fd use;
+		allow ada_t $1:fifo_file rw_file_perms;
+		allow ada_t $1:process sigchld;
+	',`
+		errprint(`Warning: $0($1) has no effect in strict policy.'__endline__)
+	')
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/ada.te serefpolicy-2.2.30/policy/modules/apps/ada.te
--- nsaserefpolicy/policy/modules/apps/ada.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/apps/ada.te	2006-04-11 07:05:00.000000000 -0400
@@ -0,0 +1,24 @@
+
+policy_module(ada,1.1.0)
+
+########################################
+#
+# Declarations
+#
+
+type ada_t;
+domain_type(ada_t)
+
+type ada_exec_t;
+files_type(ada_exec_t)
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow ada_t self:process { execstack execmem };
+	unconfined_domain_noaudit(ada_t)
+	role system_r types ada_t;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.2.30/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	2006-02-20 11:33:04.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/apps/java.fc	2006-04-11 07:05:00.000000000 -0400
@@ -4,3 +4,4 @@
 /usr(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
 /usr/bin/gcj-dbtool	--	gen_context(system_u:object_r:java_exec_t,s0)
 /usr/bin/gij		--	gen_context(system_u:object_r:java_exec_t,s0)
+/opt(/.*)?/bin/java.* 	--	gen_context(system_u:object_r:java_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.if serefpolicy-2.2.30/policy/modules/apps/mono.if
--- nsaserefpolicy/policy/modules/apps/mono.if	2006-02-10 17:05:18.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/apps/mono.if	2006-04-11 07:05:00.000000000 -0400
@@ -23,3 +23,26 @@
 	allow mono_t $1:fifo_file rw_file_perms;
 	allow mono_t $1:process sigchld;
 ')
+
+
+########################################
+## <summary>
+##	Send and receive messages from
+##	mono over dbus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mono_dbus_chat',`
+	gen_require(`
+		type mono_t;
+		class dbus send_msg;
+	')
+
+	allow $1 mono_t:dbus send_msg;
+	allow mono_t $1:dbus send_msg;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.fc serefpolicy-2.2.30/policy/modules/kernel/devices.fc
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2006-03-23 14:33:29.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/kernel/devices.fc	2006-04-11 07:05:00.000000000 -0400
@@ -59,6 +59,7 @@
 ')
 /dev/vbi.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
 /dev/video.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
+/dev/dvb/.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
 /dev/vttuner		-c	gen_context(system_u:object_r:v4l_device_t,s0)
 /dev/vtx.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
 /dev/winradio.		-c	gen_context(system_u:object_r:v4l_device_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.30/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-04-10 17:05:09.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/kernel/devices.if	2006-04-11 07:08:48.000000000 -0400
@@ -2439,6 +2439,26 @@
 
 ########################################
 ## <summary>
+##	Set the attributes of usbfs filesystem.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_setattr_usbfs',`
+	gen_require(`
+		type device_t, usbfs_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 usbfs_t:file setattr;
+')
+
+
+########################################
+## <summary>
 ##	Associate a file to a usbfs filesystem.
 ## </summary>
 ## <param name="file_type">
@@ -2855,3 +2875,23 @@
 
 	typeattribute $1 devices_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Dontaudit getattr on all device nodes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`dev_dontaudit_getattr_all_device_nodes',`
+	gen_require(`
+		attribute device_node;
+	')
+
+	dontaudit $1 device_t:dir_file_class_set getattr;
+	dontaudit $1 device_node:dir_file_class_set getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.30/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-04-10 17:05:10.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/kernel/files.if	2006-04-11 07:05:00.000000000 -0400
@@ -1661,6 +1661,21 @@
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.30/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-03-07 10:31:09.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/kernel/mls.te	2006-04-11 07:05:00.000000000 -0400
@@ -60,6 +60,7 @@
 
 ifdef(`enable_mls',`
 range_transition initrc_t auditd_exec_t s15:c0.c255;
+range_transition secadm_t auditctl_exec_t s15:c0.c255;
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.if serefpolicy-2.2.30/policy/modules/services/apache.if
--- nsaserefpolicy/policy/modules/services/apache.if	2006-04-06 14:05:25.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/apache.if	2006-04-11 07:05:00.000000000 -0400
@@ -197,6 +197,26 @@
 		allow httpd_$1_script_t self:lnk_file read;
 	')
 
+	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+		corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
+		corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
+		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
+		allow httpd_$1_script_t self:udp_socket create_socket_perms;
+
+		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
+		corenet_udp_sendrecv_all_if(httpd_$1_script_t)
+		corenet_raw_sendrecv_all_if(httpd_$1_script_t)
+		corenet_tcp_sendrecv_all_nodes(httpd_$1_script_t)
+		corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
+		corenet_raw_sendrecv_all_nodes(httpd_$1_script_t)
+		corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
+		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
+		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
+		corenet_tcp_bind_all_nodes(httpd_$1_script_t)
+		corenet_udp_bind_all_nodes(httpd_$1_script_t)
+		sysnet_read_config(httpd_$1_script_t)
+	')
+
 	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.30/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/automount.te	2006-04-11 07:05:00.000000000 -0400
@@ -123,6 +123,7 @@
 logging_search_logs(automount_t)
 
 miscfiles_read_localization(automount_t)
+miscfiles_read_certs(automount_t)
 
 # Run mount in the mount_t domain.
 mount_domtrans(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/avahi.te serefpolicy-2.2.30/policy/modules/services/avahi.te
--- nsaserefpolicy/policy/modules/services/avahi.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/avahi.te	2006-04-11 07:05:00.000000000 -0400
@@ -92,6 +92,10 @@
 	dbus_system_bus_client_template(avahi,avahi_t)
 	dbus_connect_system_bus(avahi_t)
 	dbus_send_system_bus(avahi_t)
+	optional_policy(`
+		mono_dbus_chat(avahi_t)
+	')
+
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.30/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/bluetooth.te	2006-04-11 07:05:00.000000000 -0400
@@ -41,7 +41,7 @@
 # Bluetooth services local policy
 #
 
-allow bluetooth_t self:capability { net_admin net_raw sys_tty_config };
+allow bluetooth_t self:capability { net_admin net_raw sys_tty_config ipc_lock };
 dontaudit bluetooth_t self:capability sys_tty_config;
 allow bluetooth_t self:process { getsched signal_perms };
 allow bluetooth_t self:fifo_file rw_file_perms;
@@ -178,7 +178,7 @@
 
 allow bluetooth_helper_t bluetooth_helper_tmp_t:dir create_dir_perms;
 allow bluetooth_helper_t bluetooth_helper_tmp_t:file create_file_perms;
-files_tmp_filetrans(bluetooth_helper_t, bluetooth_helper_tmp_t, { file dir })
+files_tmp_filetrans(bluetooth_helper_t, bluetooth_helper_tmp_t, { file dir sock_file })
 
 kernel_read_system_state(bluetooth_helper_t)
 kernel_read_kernel_sysctls(bluetooth_helper_t)
@@ -217,6 +217,8 @@
 
 	userdom_read_all_users_home_content_files(bluetooth_helper_t)
 
+	term_dontaudit_use_generic_ptys(bluetooth_helper_t)
+
 	optional_policy(`
 		xserver_stream_connect_xdm(bluetooth_helper_t)
 	')
@@ -226,6 +228,7 @@
 	dbus_system_bus_client_template(bluetooth_helper,bluetooth_helper_t)
 	dbus_connect_system_bus(bluetooth_helper_t)
 	dbus_send_system_bus(bluetooth_helper_t)
+	bluetooth_dbus_chat(bluetooth_helper_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.30/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/cups.te	2006-04-11 07:05:00.000000000 -0400
@@ -110,7 +110,7 @@
 files_tmp_filetrans(cupsd_t, cupsd_tmp_t, { file dir fifo_file })
 
 allow cupsd_t cupsd_var_run_t:file create_file_perms;
-allow cupsd_t cupsd_var_run_t:dir rw_dir_perms;
+allow cupsd_t cupsd_var_run_t:dir { setattr rw_dir_perms };
 allow cupsd_t cupsd_var_run_t:sock_file create_file_perms;
 files_pid_filetrans(cupsd_t,cupsd_var_run_t,file)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.te serefpolicy-2.2.30/policy/modules/services/dbus.te
--- nsaserefpolicy/policy/modules/services/dbus.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/dbus.te	2006-04-11 07:05:00.000000000 -0400
@@ -102,6 +102,7 @@
 logging_send_syslog_msg(system_dbusd_t)
 
 miscfiles_read_localization(system_dbusd_t)
+miscfiles_read_certs(system_dbusd_t)
 
 seutil_read_config(system_dbusd_t)
 seutil_read_default_contexts(system_dbusd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.2.30/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/ftp.te	2006-04-11 07:05:00.000000000 -0400
@@ -62,6 +62,7 @@
 files_pid_filetrans(ftpd_t,ftpd_var_run_t,file)
 
 # Create and modify /var/log/xferlog.
+allow ftpd_t xferlog_t:dir search_dir_perms;
 allow ftpd_t xferlog_t:file create_file_perms;
 logging_log_filetrans(ftpd_t,xferlog_t,file)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/gpm.te serefpolicy-2.2.30/policy/modules/services/gpm.te
--- nsaserefpolicy/policy/modules/services/gpm.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/gpm.te	2006-04-11 07:05:00.000000000 -0400
@@ -54,8 +54,7 @@
 
 dev_read_sysfs(gpm_t)
 # Access the mouse.
-# cjp: why write?
-dev_rw_input_dev(event_device_t)
+dev_rw_input_dev(gpm_t)
 dev_rw_mouse(gpm_t)
 
 fs_getattr_all_fs(gpm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.30/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/hal.te	2006-04-11 07:05:00.000000000 -0400
@@ -22,7 +22,7 @@
 #
 
 # execute openvt which needs setuid
-allow hald_t self:capability { setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
+allow hald_t self:capability { chown setuid setgid kill net_admin sys_admin sys_nice dac_override dac_read_search mknod sys_rawio sys_tty_config };
 dontaudit hald_t self:capability sys_tty_config;
 allow hald_t self:process signal_perms;
 allow hald_t self:fifo_file rw_file_perms;
@@ -52,6 +52,9 @@
 kernel_write_proc_files(hald_t)
 
 files_search_boot(hald_t)
+files_getattr_home_dir(hald_t)
+
+auth_read_pam_console_data(hald_t)
 
 corecmd_exec_bin(hald_t)
 corecmd_exec_sbin(hald_t)
@@ -77,6 +80,8 @@
 dev_getattr_all_chr_files(hald_t)
 dev_manage_generic_chr_files(hald_t)
 dev_rw_generic_usb_dev(hald_t)
+dev_setattr_generic_usb_dev(hald_t)
+dev_setattr_usbfs(hald_t)
 
 # hal is now execing pm-suspend
 dev_rw_sysfs(hald_t)
@@ -93,6 +98,7 @@
 files_read_usr_files(hald_t)
 # hal is now execing pm-suspend
 files_create_boot_flag(hald_t)
+files_getattr_default_dirs(hald_t)
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
@@ -187,6 +193,11 @@
 	optional_policy(`
 		networkmanager_dbus_chat(hald_t)
 	')
+
+	optional_policy(`
+		mono_dbus_chat(hald_t)
+	')
+
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mysql.te serefpolicy-2.2.30/policy/modules/services/mysql.te
--- nsaserefpolicy/policy/modules/services/mysql.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/mysql.te	2006-04-11 07:05:00.000000000 -0400
@@ -104,6 +104,7 @@
 
 miscfiles_read_localization(mysqld_t)
 
+sysnet_use_ldap(mysqld_t)
 sysnet_read_config(mysqld_t)
 
 userdom_dontaudit_use_unpriv_user_fds(mysqld_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.30/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/networkmanager.te	2006-04-11 07:05:00.000000000 -0400
@@ -155,6 +155,7 @@
 
 optional_policy(`
 	nscd_socket_use(NetworkManager_t)
+	nscd_signal(NetworkManager_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.if serefpolicy-2.2.30/policy/modules/services/nscd.if
--- nsaserefpolicy/policy/modules/services/nscd.if	2006-03-23 14:33:30.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/nscd.if	2006-04-11 07:05:00.000000000 -0400
@@ -126,3 +126,23 @@
 
 	allow $1 nscd_t:nscd *;
 ')
+
+
+########################################
+## <summary>
+##	signal NSCD 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nscd_signal',`
+	gen_require(`
+		type nscd_t;
+	')
+
+	allow $1 nscd_t:process signal;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-2.2.30/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2006-03-24 11:15:50.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/services/rsync.te	2006-04-11 07:05:00.000000000 -0400
@@ -50,6 +50,8 @@
 allow rsync_t rsync_var_run_t:dir rw_dir_perms;
 files_pid_filetrans(rsync_t,rsync_var_run_t,file)
 
+init_dontaudit_use_fds(rsync_t)
+
 kernel_read_kernel_sysctls(rsync_t)
 kernel_read_system_state(rsync_t)
 kernel_read_network_state(rsync_t)
@@ -65,6 +67,7 @@
 corenet_non_ipsec_sendrecv(rsync_t)
 corenet_tcp_bind_all_nodes(rsync_t)
 corenet_udp_bind_all_nodes(rsync_t)
+corenet_tcp_bind_rsync_port(rsync_t)
 
 dev_read_urand(rsync_t)
 
@@ -77,6 +80,7 @@
 libs_use_shared_libs(rsync_t)
 
 logging_send_syslog_msg(rsync_t)
+logging_dontaudit_search_logs(rsync_t)
 
 miscfiles_read_localization(rsync_t)
 miscfiles_read_public_files(rsync_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.30/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/samba.te	2006-04-11 07:05:00.000000000 -0400
@@ -105,6 +105,8 @@
 allow samba_net_t samba_net_tmp_t:file create_file_perms;
 files_tmp_filetrans(samba_net_t, samba_net_tmp_t, { file dir })
 
+allow smbd_t samba_net_tmp_t:file getattr;
+
 allow samba_net_t samba_var_t:dir rw_dir_perms;
 allow samba_net_t samba_var_t:lnk_file create_lnk_perms;
 allow samba_net_t samba_var_t:file create_lnk_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/snmp.te serefpolicy-2.2.30/policy/modules/services/snmp.te
--- nsaserefpolicy/policy/modules/services/snmp.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/snmp.te	2006-04-11 07:05:00.000000000 -0400
@@ -49,6 +49,7 @@
 allow snmpd_t snmpd_var_run_t:dir rw_dir_perms;
 files_pid_filetrans(snmpd_t,snmpd_var_run_t,file)
 
+kernel_read_device_sysctls(snmpd_t)
 kernel_read_kernel_sysctls(snmpd_t)
 kernel_read_net_sysctls(snmpd_t)
 kernel_read_proc_symlinks(snmpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.30/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-04-06 15:31:54.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/services/xserver.if	2006-04-11 07:05:00.000000000 -0400
@@ -1070,3 +1070,24 @@
 
 	dontaudit $1 xdm_xserver_t:tcp_socket { read write };
 ')
+
+########################################
+## <summary>
+##	Allow read and write to
+##	a XDM X server socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow
+##	</summary>
+## </param>
+#
+interface(`xserver_rw_xdm_sockets',`
+	gen_require(`
+		type xdm_xserver_tmp_t;
+	')
+
+	allow $1 xdm_xserver_tmp_t:dir search;
+	allow $1 xdm_xserver_tmp_t:sock_file { read write };
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.30/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/fstools.te	2006-04-11 07:05:00.000000000 -0400
@@ -77,6 +77,7 @@
 dev_getattr_usbfs_dirs(fsadm_t)
 # Access to /dev/mapper/control
 dev_rw_lvm_control(fsadm_t)
+dev_dontaudit_getattr_all_device_nodes(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/getty.fc serefpolicy-2.2.30/policy/modules/system/getty.fc
--- nsaserefpolicy/policy/modules/system/getty.fc	2005-10-06 17:29:17.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/getty.fc	2006-04-11 07:05:00.000000000 -0400
@@ -6,3 +6,4 @@
 /var/log/mgetty\.log.*	--	gen_context(system_u:object_r:getty_log_t,s0)
 
 /var/run/mgetty\.pid.*	--	gen_context(system_u:object_r:getty_var_run_t,s0)
+/var/spool/fax		--	gen_context(system_u:object_r:getty_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/getty.te serefpolicy-2.2.30/policy/modules/system/getty.te
--- nsaserefpolicy/policy/modules/system/getty.te	2006-03-29 11:23:41.000000000 -0500
+++ serefpolicy-2.2.30/policy/modules/system/getty.te	2006-04-11 07:05:00.000000000 -0400
@@ -104,6 +104,8 @@
 
 miscfiles_read_localization(getty_t)
 
+mta_send_mail(getty_t)
+
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(getty_t)
 	term_dontaudit_use_generic_ptys(getty_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.30/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-04-06 15:32:43.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/init.te	2006-04-11 07:05:00.000000000 -0400
@@ -352,6 +352,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.30/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-04-05 11:35:09.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/libraries.fc	2006-04-11 07:20:26.000000000 -0400
@@ -33,6 +33,8 @@
 #
 /opt(/.*)?/lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
 /opt(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/.*/jre.*/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/.*/jre.*/libjvm.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 #
 # /sbin
@@ -55,14 +57,16 @@
 
 /usr(/.*)?/nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/lib(64)?/pgsql/test/regress/.*\.so --	gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib(64)?/pgsql/test/regress/.*\.so	--	gen_context(system_u:object_r:shlib_t,s0)
 
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
 
 /usr/lib(64)?/im/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 /usr/lib(64)?/iiim/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr(/.*)?/lib(64)?(/.*)?/nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/nvidia_drv.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -70,10 +74,15 @@
 /usr/(local/)?lib/wine/.*\.so  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?lib/libfame-.*\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/local/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
-
+/usr/lib(64)?/libjs\.so.*     		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libGL\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/vmware(.*/)?/VmPerl\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
+/usr/lib(64)?/nvidia-graphics(-[^/]*/)?libGL(core)?\.so(\.[^/]*)*             --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/nvidia-graphics(-[^/]*/)?libnvidia.*\.so(\.[^/]*)*              --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/nvidia-graphics(-[^/]*/)?libXvMCNVIDIA\.so.*            --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xorg/modules/extensions/nvidia(-[^/]*)?/libglx\.so(\.[^/]*)*	--		gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/x11R6/lib/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xorg/modules/extensions/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
@@ -92,6 +101,7 @@
 /usr/lib(64)?/libstdc\+\+\.so\.2\.7\.2\.8 --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libg\+\+\.so\.2\.7\.2\.8	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libglide3\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libglide-v[0-9]*\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libdv\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/helix/plugins/oggfformat\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/helix/plugins/theorarend\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -167,16 +177,18 @@
 /usr/lib(64)?/libdivxdecore.so.0	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libdivxencore.so.0	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-# vmware
-/usr/lib/vmware/lib/libgdk-x11-2.0.so.0/libgdk-x11-2.0.so.0 -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+# vmware 
+/usr/lib(64)?/vmware/lib(/.*)?/libgdk-x11-.*\.so.*  -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Java, Sun Microsystems (JPackage SRPM)
-/usr/.*/jre.*/lib/i386/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/.*/jre.*/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/.*/jre.*/libjvm.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
+/usr(/.*)?/intellinux/nppdf\.so -- gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr(/.*)?/intellinux/lib/\.so -- gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr(/.*)?/intellinux/plug_ins/.*\.api -- gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr(/.*)?/intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr(/.*)?/Reader/intellinux/plug_ins/.*\.api -- gen_context(system_u:object_r:shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/plug_ins/AcroForm\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/plug_ins/EScript\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 ') dnl end distro_redhat
 
 ifdef(`distro_suse',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.30/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/mount.te	2006-04-11 07:05:00.000000000 -0400
@@ -19,7 +19,8 @@
 # mount local policy
 #
 
-allow mount_t self:capability { ipc_lock sys_rawio sys_admin dac_override chown sys_tty_config };
+# setuid/setgid needed to mount cifs 
+allow mount_t self:capability { ipc_lock sys_rawio sys_admin dac_override chown sys_tty_config setuid setgid };
 
 allow mount_t mount_tmp_t:file create_file_perms;
 allow mount_t mount_tmp_t:dir create_dir_perms;
@@ -44,6 +45,7 @@
 storage_raw_write_removable_device(mount_t)
 
 fs_getattr_xattr_fs(mount_t)
+fs_getattr_cifs(mount_t)
 fs_mount_all_fs(mount_t)
 fs_unmount_all_fs(mount_t)
 fs_remount_all_fs(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.30/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-04-10 17:05:11.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/unconfined.if	2006-04-11 07:05:00.000000000 -0400
@@ -55,7 +55,7 @@
 	tunable_policy(`allow_execmem && allow_execstack',`
 		# Allow making the stack executable via mprotect.
 		allow $1 self:process execstack;
-		auditallow $1 self:process execstack;
+#		auditallow $1 self:process execstack;
 	', `
 		# These are fairly common but seem to be harmless
 		# caused by using shared libraries built with old tool chains
@@ -88,6 +88,7 @@
 	optional_policy(`
 		storage_unconfined($1)
 	')
+
 ')
 
 ########################################
@@ -109,9 +110,10 @@
 		auditallow $1 self:process execheap;
 	')
 
-	tunable_policy(`allow_execmem',`
-		auditallow $1 self:process execmem;
-	')
+# Turn off this audit for FC5
+#	tunable_policy(`allow_execmem',`
+#		auditallow $1 self:process execmem;
+#	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.30/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-04-10 17:05:11.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/unconfined.te	2006-04-11 07:23:35.000000000 -0400
@@ -102,11 +102,11 @@
 	')
 
 	optional_policy(`
-		mono_domtrans(unconfined_t)
+		ada_domtrans(unconfined_t)
 	')
 
 	optional_policy(`
-		netutils_domtrans_ping(unconfined_t)
+		mono_domtrans(unconfined_t)
 	')
 
 	optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.30/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-04-05 17:08:56.000000000 -0400
+++ serefpolicy-2.2.30/policy/modules/system/userdomain.te	2006-04-11 07:05:00.000000000 -0400
@@ -181,10 +181,11 @@
 		logging_read_audit_log(secadm_t)
 		logging_run_auditctl(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
+		auth_relabel_all_files_except_shadow(secadm_t)
+		auth_relabel_shadow(secadm_t)
 	', `
-		logging_domtrans_auditctl(sysadm_t)
-		logging_read_audit_log(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
+		logging_read_audit_log(sysadm_t)
 	')
 
 	tunable_policy(`allow_ptrace',`

--------------090104040103050100060307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
