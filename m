Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2TKWso7011067
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 15:32:54 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2TKWq77023838
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 20:32:53 GMT
Message-ID: <442AEEF3.70406@redhat.com>
Date: Wed, 29 Mar 2006 15:32:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policy
Content-Type: multipart/mixed;
 boundary="------------030408000303030200010404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030408000303030200010404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added restorecond policy

fixed samba_selinux man page

logwatch looks for mounted files system on /mnt

file context for yumex

groupadd and useradd need to read nsswitch

hplib_port_t needed for 9100

add 6000 as valid xserver port


pam console needs to getattr/setattr usb_dev

bluetooth tools want to read resolver

hplib_t fixes to work with additional devices (Usb  printers

dovecot wants to talk to postgresql and use inotify

hal needs to comunicate with ntp

pegasus needs to connect to random non reserved ports

privoxy wants to use nscd and communicate with tor

xfs needs to read fonts in usr_t

fstools need to be able to work with blk devices.  (fsck)

libmpg123 is moving

mount using some certificates stored in usr_t

setfiles needs trans_lock



--------------030408000303030200010404
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/man/man8/samba_selinux.8 serefpolicy-2.2.28/man/man8/samba_selinux.8
--- nsaserefpolicy/man/man8/samba_selinux.8	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.28/man/man8/samba_selinux.8	2006-03-29 14:44:17.000000000 -0500
@@ -23,7 +23,7 @@
 .SH SHARING FILES
 If you want to share files with multiple domains (Apache, FTP, rsync, Samba), you can set a file context of public_content_t and public_content_rw_t.  These context allow any of the above domains to read the content.  If you want a particular domain to write to the public_content_rw_t domain, you must set the appropriate boolean.  allow_DOMAIN_anon_write.  So for samba you would execute:
 
-setsebool -P allow_smb_anon_write=1
+setsebool -P allow_smbd_anon_write=1
 
 .SH BOOLEANS
 .br 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logwatch.te serefpolicy-2.2.28/policy/modules/admin/logwatch.te
--- nsaserefpolicy/policy/modules/admin/logwatch.te	2006-03-24 11:54:26.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/admin/logwatch.te	2006-03-29 14:44:17.000000000 -0500
@@ -52,6 +52,7 @@
 files_read_etc_runtime_files(logwatch_t)
 files_read_usr_files(logwatch_t)
 files_search_spool(logwatch_t)
+files_search_mnt(logwatch_t)
 files_dontaudit_search_home(logwatch_t)
 
 fs_getattr_all_fs(logwatch_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.2.28/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-03-23 16:02:02.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/admin/rpm.fc	2006-03-29 14:44:17.000000000 -0500
@@ -3,6 +3,7 @@
 /usr/bin/smart 			--	gen_context(system_u:object_r:rpm_exec_t,s0)
 
 /usr/bin/yum 			--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/share/yumex/yumex		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 
 /usr/lib(64)?/rpm/rpmd		-- 	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/rpm/rpmq		-- 	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.2.28/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-03-24 11:54:26.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/admin/usermanage.te	2006-03-29 14:44:17.000000000 -0500
@@ -225,6 +225,7 @@
 
 files_manage_etc_files(groupadd_t)
 files_relabel_etc_files(groupadd_t)
+files_read_etc_runtime_files(groupadd_t)
 
 libs_use_ld_so(groupadd_t)
 libs_use_shared_libs(groupadd_t)
@@ -492,6 +493,7 @@
 files_manage_etc_files(useradd_t)
 files_search_var_lib(useradd_t)
 files_relabel_etc_files(useradd_t)
+files_read_etc_runtime_files(useradd_t)
 
 init_use_fds(useradd_t)
 init_rw_utmp(useradd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.2.28/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-03-23 16:02:03.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/kernel/corenetwork.te.in	2006-03-29 14:44:17.000000000 -0500
@@ -68,7 +68,7 @@
 network_port(http_cache, tcp,3128,s0, udp,3130,s0, tcp,8080,s0, tcp,8118,s0) # 8118 is for privoxy
 network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0)
 network_port(howl, tcp,5335,s0, udp,5353,s0)
-network_port(hplip, tcp,50000,s0, tcp,50002,s0)
+network_port(hplip, tcp,50000,s0, tcp,50002,s0, tcp,9100,s0)
 network_port(i18n_input, tcp,9010,s0)
 network_port(imaze, tcp,5323,s0, udp,5323,s0)
 network_port(inetd_child, tcp,7,s0, udp,7,s0, tcp,9,s0, udp,9,s0, tcp,13,s0, udp,13,s0, tcp,19,s0, udp,19,s0, tcp,37,s0, udp,37,s0, tcp,512,s0, tcp,543,s0, tcp,544,s0, tcp,891,s0, udp,891,s0, tcp,892,s0, udp,892,s0, tcp,2105,s0, tcp,5666,s0)
@@ -127,7 +127,7 @@
 network_port(uucpd, tcp,540,s0)
 network_port(vnc, tcp,5900,s0)
 network_port(xen, tcp,8002,s0)
-network_port(xserver, tcp,6001,s0, tcp,6002,s0, tcp,6003,s0, tcp,6004,s0, tcp,6005,s0, tcp,6006,s0, tcp,6007,s0, tcp,6008,s0, tcp,6009,s0, tcp,6010,s0, tcp,6011,s0, tcp,6012,s0, tcp,6013,s0, tcp,6014,s0, tcp,6015,s0, tcp,6016,s0, tcp,6017,s0, tcp,6018,s0, tcp,6019,s0)
+network_port(xserver, tcp, 6000, s0, tcp,6001,s0, tcp,6002,s0, tcp,6003,s0, tcp,6004,s0, tcp,6005,s0, tcp,6006,s0, tcp,6007,s0, tcp,6008,s0, tcp,6009,s0, tcp,6010,s0, tcp,6011,s0, tcp,6012,s0, tcp,6013,s0, tcp,6014,s0, tcp,6015,s0, tcp,6016,s0, tcp,6017,s0, tcp,6018,s0, tcp,6019,s0)
 network_port(zebra, tcp,2601,s0)
 network_port(zope, tcp,8021,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.28/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-03-28 23:09:36.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/kernel/devices.if	2006-03-29 14:44:17.000000000 -0500
@@ -2383,6 +2383,44 @@
 
 ########################################
 ## <summary>
+##	Getattr generic the USB devices.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_getattr_generic_usb_dev',`
+	gen_require(`
+		type usb_device_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 usb_device_t:chr_file getattr;
+')
+
+########################################
+## <summary>
+##	Setattr generic the USB devices.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dev_setattr_generic_usb_dev',`
+	gen_require(`
+		type usb_device_t;
+	')
+
+	allow $1 device_t:dir r_dir_perms;
+	allow $1 usb_device_t:chr_file setattr;
+')
+
+########################################
+## <summary>
 ##	Mount a usbfs filesystem.
 ## </summary>
 ## <param name="domain">
@@ -2822,3 +2860,23 @@
 	allow $1 self:capability sys_rawio;
 	typeattribute $1 memory_raw_write, memory_raw_read;
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.28/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-03-28 23:09:36.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/kernel/files.if	2006-03-29 14:44:17.000000000 -0500
@@ -1643,6 +1643,21 @@
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
@@ -2152,6 +2167,18 @@
 
 ########################################
 #
+# files_dontaudit_search_mnt(domain)
+#
+interface(`files_dontaudit_search_mnt',`
+	gen_require(`
+		type mnt_t;
+	')
+
+	dontaudit $1 mnt_t:dir search_dir_perms;
+')
+
+########################################
+#
 # files_list_mnt(domain)
 #
 interface(`files_list_mnt',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.2.28/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-03-23 16:02:03.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/kernel/kernel.if	2006-03-29 14:44:17.000000000 -0500
@@ -1148,7 +1148,7 @@
 
 	allow $1 proc_t:dir search;
 	allow $1 sysctl_t:dir r_dir_perms;
-	allow $1 sysctl_vm_t:dir list_dir_perms;
+	allow $1 sysctl_vm_t:dir rw_dir_perms;
 	allow $1 sysctl_vm_t:file rw_file_perms;
 ')
 
@@ -1433,7 +1433,7 @@
 
 	allow $1 proc_t:dir search;
 	allow $1 sysctl_t:dir r_dir_perms;
-	allow $1 sysctl_kernel_t:dir r_dir_perms;
+	allow $1 sysctl_kernel_t:dir rw_dir_perms;
 	allow $1 sysctl_kernel_t:file rw_file_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.te serefpolicy-2.2.28/policy/modules/services/apm.te
--- nsaserefpolicy/policy/modules/services/apm.te	2006-03-24 11:54:27.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/apm.te	2006-03-29 14:44:17.000000000 -0500
@@ -226,6 +226,10 @@
 ')
 
 optional_policy(`
+	xserver_domtrans_xdm_xserver(apmd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(apmd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.2.28/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-03-29 14:26:02.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/bluetooth.te	2006-03-29 14:44:17.000000000 -0500
@@ -220,6 +220,8 @@
 	')
 ')
 
+sysnet_read_config(bluetooth_helper_t)
+
 optional_policy(`
 	dbus_system_bus_client_template(bluetooth_helper,bluetooth_helper_t)
 	dbus_connect_system_bus(bluetooth_helper_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.28/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-03-24 11:54:27.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/cups.te	2006-03-29 14:44:17.000000000 -0500
@@ -375,7 +375,9 @@
 # HPLIP local policy
 #
 
+allow hplip_t self:capability net_raw;
 dontaudit hplip_t self:capability sys_tty_config;
+allow hplip_t self:fifo_file rw_file_perms;
 allow hplip_t self:process signal_perms;
 allow hplip_t self:unix_dgram_socket create_socket_perms;
 allow hplip_t self:unix_stream_socket create_socket_perms;
@@ -418,6 +420,7 @@
 dev_read_sysfs(hplip_t)
 dev_rw_printer(hplip_t)
 dev_read_urand(hplip_t)
+dev_rw_generic_usb_dev(hplip_t)
 
 fs_getattr_all_fs(hplip_t)
 fs_search_auto_mountpoints(hplip_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.2.28/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-03-24 11:54:28.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/dovecot.te	2006-03-29 14:44:17.000000000 -0500
@@ -79,12 +79,14 @@
 corenet_tcp_bind_all_nodes(dovecot_t)
 corenet_tcp_bind_pop_port(dovecot_t)
 corenet_tcp_connect_all_ports(dovecot_t)
+corenet_tcp_connect_postgresql_port(dovecot_t)
 
 dev_read_sysfs(dovecot_t)
 dev_read_urand(dovecot_t)
 
 fs_getattr_all_fs(dovecot_t)
 fs_search_auto_mountpoints(dovecot_t)
+fs_list_inotifyfs(dovecot_t)
 
 term_dontaudit_use_console(dovecot_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.28/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-03-24 11:54:28.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/hal.te	2006-03-29 14:44:17.000000000 -0500
@@ -211,6 +211,10 @@
 ')
 
 optional_policy(`
+        ntp_domtrans(hald_t)
+')
+
+optional_policy(`
 	nscd_socket_use(hald_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.2.28/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-03-24 11:54:28.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/pegasus.te	2006-03-29 14:44:17.000000000 -0500
@@ -77,6 +77,7 @@
 corenet_tcp_bind_pegasus_https_port(pegasus_t)
 corenet_tcp_connect_pegasus_http_port(pegasus_t)
 corenet_tcp_connect_pegasus_https_port(pegasus_t)
+corenet_tcp_connect_generic_port(pegasus_t)
 
 dev_read_sysfs(pegasus_t)
 dev_read_urand(pegasus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/privoxy.te serefpolicy-2.2.28/policy/modules/services/privoxy.te
--- nsaserefpolicy/policy/modules/services/privoxy.te	2006-03-24 11:54:28.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/privoxy.te	2006-03-29 14:44:17.000000000 -0500
@@ -51,6 +51,7 @@
 corenet_tcp_bind_http_cache_port(privoxy_t)
 corenet_tcp_connect_http_port(privoxy_t)
 corenet_tcp_connect_ftp_port(privoxy_t)
+corenet_tcp_connect_tor_port(privoxy_t)
 
 dev_read_sysfs(privoxy_t)
 
@@ -95,6 +96,10 @@
 ')
 
 optional_policy(`
+       nscd_socket_use(privoxy_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(privoxy_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xfs.te serefpolicy-2.2.28/policy/modules/services/xfs.te
--- nsaserefpolicy/policy/modules/services/xfs.te	2006-03-24 11:54:29.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/xfs.te	2006-03-29 14:44:17.000000000 -0500
@@ -53,6 +53,7 @@
 
 files_read_etc_files(xfs_t)
 files_read_etc_runtime_files(xfs_t)
+files_read_usr_files(xfs_t)
 
 init_use_fds(xfs_t)
 init_use_script_ptys(xfs_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.28/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-03-28 23:09:36.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/services/xserver.if	2006-03-29 14:44:17.000000000 -0500
@@ -1015,3 +1015,23 @@
 
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.2.28/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-03-24 11:54:29.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/authlogin.te	2006-03-29 14:44:17.000000000 -0500
@@ -171,6 +171,8 @@
 dev_setattr_video_dev(pam_console_t)
 dev_getattr_xserver_misc_dev(pam_console_t)
 dev_setattr_xserver_misc_dev(pam_console_t)
+dev_getattr_generic_usb_dev(pam_console_t)
+dev_setattr_generic_usb_dev(pam_console_t)
 
 fs_search_auto_mountpoints(pam_console_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.28/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-03-24 11:54:29.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/fstools.te	2006-03-29 14:44:17.000000000 -0500
@@ -67,6 +67,10 @@
 dev_read_urand(fsadm_t)
 # Recreate /dev/cdrom.
 dev_manage_generic_symlinks(fsadm_t)
+
+# fdisk needs this for early boot
+dev_manage_generic_blk_files(fsadm_t)
+
 # Access to /initrd devices
 dev_search_usbfs(fsadm_t)
 # for swapon
@@ -75,6 +79,7 @@
 dev_getattr_usbfs_dirs(fsadm_t)
 # Access to /dev/mapper/control
 dev_rw_lvm_control(fsadm_t)
+dev_dontaudit_getattr_all_device_nodes(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.28/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-03-29 14:26:03.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/init.te	2006-03-29 14:44:17.000000000 -0500
@@ -353,6 +353,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.28/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-03-23 16:02:04.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/libraries.fc	2006-03-29 14:44:17.000000000 -0500
@@ -148,7 +148,7 @@
 /usr/lib(64)?/php/modules/.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Livna.org packages: xmms-mp3, ffmpeg, xvidcore, xine-lib, gsm, lame
-/usr/lib(64)?/xmms/Input/libmpg123\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?.*/libmpg123\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavformat-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavcodec-.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.28/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-03-24 11:54:29.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/mount.te	2006-03-29 14:44:17.000000000 -0500
@@ -72,6 +72,8 @@
 # for when /etc/mtab loses its type
 # cjp: this seems wrong, the type should probably be etc
 files_read_isid_type_files(mount_t)
+# For reading cert files
+files_read_usr_files(mount_t)
 
 init_use_fds(mount_t)
 init_use_script_ptys(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.2.28/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-03-23 16:02:04.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/selinuxutil.fc	2006-03-29 14:44:17.000000000 -0500
@@ -33,6 +33,7 @@
 /usr/lib(64)?/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
 
 /usr/sbin/load_policy		--	gen_context(system_u:object_r:load_policy_exec_t,s0)
+/usr/sbin/restorecond		--	gen_context(system_u:object_r:restorecond_exec_t,s0)
 /usr/sbin/run_init		--	gen_context(system_u:object_r:run_init_exec_t,s0)
 /usr/sbin/setfiles.*		--	gen_context(system_u:object_r:setfiles_exec_t,s0)
 /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
@@ -40,3 +41,8 @@
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?		gen_context(system_u:object_r:policy_src_t,s0)
 ')
+
+#
+# /var/run
+#
+/var/run/restorecond.pid	--	gen_context(system_u:object_r:restorecond_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.28/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-03-29 14:26:03.000000000 -0500
+++ serefpolicy-2.2.28/policy/modules/system/selinuxutil.te	2006-03-29 14:44:24.000000000 -0500
@@ -83,6 +83,15 @@
 init_system_domain(restorecon_t,restorecon_exec_t)
 role system_r types restorecon_t;
 
+type restorecond_t;
+type restorecond_exec_t;
+init_daemon_domain(restorecond_t,restorecond_exec_t)
+domain_obj_id_change_exemption(restorecond_t)
+role system_r types restorecond_t;
+
+type restorecond_var_run_t;
+files_pid_file(restorecond_var_run_t)
+
 type run_init_t;
 type run_init_exec_t;
 domain_type(run_init_t)
@@ -415,6 +424,48 @@
 
 allow restorecon_t kernel_t:unix_dgram_socket { read write };
 
+########################################
+#
+# Restorecond local policy
+#
+
+allow restorecond_t self:capability { dac_override dac_read_search fowner };
+allow restorecond_t self:fifo_file rw_file_perms;
+
+auth_relabel_all_files_except_shadow(restorecond_t )
+auth_read_all_files_except_shadow(restorecond_t)
+
+allow restorecond_t restorecond_var_run_t:file create_file_perms;
+files_pid_filetrans(restorecond_t,restorecond_var_run_t, file)
+
+kernel_use_fds(restorecond_t)
+kernel_rw_pipes(restorecond_t)
+kernel_read_system_state(restorecond_t)
+
+fs_getattr_xattr_fs(restorecond_t)
+fs_list_inotifyfs(restorecond_t)
+
+selinux_get_fs_mount(restorecond_t)
+selinux_validate_context(restorecond_t)
+selinux_compute_access_vector(restorecond_t)
+selinux_compute_create_context(restorecond_t)
+selinux_compute_relabel_context(restorecond_t)
+selinux_compute_user_contexts(restorecond_t)
+
+term_dontaudit_use_generic_ptys(restorecond_t)
+
+sysnet_dns_name_resolve(restorecond_t)
+
+init_use_fds(restorecond_t)
+
+libs_use_ld_so(restorecond_t)
+libs_use_shared_libs(restorecond_t)
+
+logging_send_syslog_msg(restorecond_t)
+
+miscfiles_read_localization(run_init_t)
+
+
 #################################
 #
 # Run_init local policy
@@ -595,6 +646,7 @@
 miscfiles_read_localization(setfiles_t)
 
 seutil_get_semanage_read_lock(setfiles_t)
+seutil_get_semanage_trans_lock(setfiles_t)
 
 userdom_use_all_users_fds(setfiles_t)
 # for config files in a home directory

--------------030408000303030200010404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
