Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89E4grT011789
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 10:04:42 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89E4fVJ026045
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 14:04:42 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i89E5OXZ007756
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 10:05:24 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i89E5OGp007755
	for selinux@tycho.nsa.gov; Thu, 9 Sep 2004 10:05:24 -0400
Message-ID: <413F7BA4.1060002@redhat.com>
Date: Wed, 08 Sep 2004 17:37:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: New policy to allow strict to run X again with tmpfs on /dev
Content-Type: multipart/mixed;
 boundary="------------070008050509080102020406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070008050509080102020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bigest change is xserver needs to create /dev/dri directory.  This 
should be fixed so Xorg uses udev in the future
but for now I have granted the privs.

ipsec seems to be a mess.

Dan

--------------070008050509080102020406
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.11/attrib.te
--- nsapolicy/attrib.te	2004-09-01 14:00:01.000000000 -0400
+++ policy-1.17.11/attrib.te	2004-09-08 11:52:35.000000000 -0400
@@ -347,9 +347,6 @@
 # For web clients such as netscape and squid
 attribute web_client_domain;
 
-# For a dbus client
-attribute dbus_client_domain;
-
 # For X Window System server domains
 attribute xserver;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.17.11/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2004-09-04 07:28:21.000000000 -0400
+++ policy-1.17.11/domains/program/fsadm.te	2004-09-08 17:02:23.319811971 -0400
@@ -121,3 +121,4 @@
 # Access to /initrd devices
 allow fsadm_t { file_t unlabeled_t }:dir rw_dir_perms;
 allow fsadm_t { file_t unlabeled_t }:blk_file rw_file_perms;
+allow fsadm_t usbfs_t:dir { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.17.11/domains/program/hostname.te
--- nsapolicy/domains/program/hostname.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/hostname.te	2004-09-08 11:52:35.000000000 -0400
@@ -22,3 +22,4 @@
 
 # for when /usr is not mounted
 dontaudit hostname_t file_t:dir search;
+dontaudit hostname_t tmpfs_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.11/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.11/domains/program/initrc.te	2004-09-08 17:17:57.419460417 -0400
@@ -209,10 +209,12 @@
 # for /halt /.autofsck and other flag files
 file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
 
+ifdef(`rpm.te', `
 # Access /var/lib/rpm.
 allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
 allow initrc_t var_lib_rpm_t:file create_file_perms;
 ')
+')
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
 
@@ -314,3 +316,6 @@
 #
 allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };
+ifdef(`dbusd.te', `
+allow initrc_t system_dbusd_t:dbus { send_msg };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.17.11/domains/program/init.te
--- nsapolicy/domains/program/init.te	2004-09-02 08:03:26.000000000 -0400
+++ policy-1.17.11/domains/program/init.te	2004-09-08 11:52:35.000000000 -0400
@@ -49,7 +49,7 @@
 ')
 
 # Create /dev/initctl.
-file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
+file_type_auto_trans(init_t, { device_t tmpfs_t }, initctl_t, fifo_file)
 
 # Create ioctl.save.
 file_type_auto_trans(init_t, etc_t, etc_runtime_t, file)
@@ -114,8 +114,7 @@
 can_setbool(init_t)
 
 # Read and write the console and ttys.
-allow init_t console_device_t:chr_file rw_file_perms;
-allow init_t tty_device_t:chr_file rw_file_perms;
+allow init_t { tmpfs_t tty_device_t console_device_t } :chr_file rw_file_perms;
 allow init_t ttyfile:chr_file rw_file_perms;
 allow init_t ptyfile:chr_file rw_file_perms;
 
@@ -140,3 +139,5 @@
 
 # file descriptors inherited from the rootfs.
 dontaudit init_t root_t:{ file chr_file } { read write }; 
+
+rw_dir_file(init_t, tmpfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.17.11/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.11/domains/program/login.te	2004-09-08 17:01:51.509233567 -0400
@@ -130,6 +130,7 @@
 can_ypbind($1_login_t)
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
+dontaudit $1_login_t init_t:fd { use };
 ')dnl end login_domain macro
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.11/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.11/domains/program/mount.te	2004-09-08 17:01:40.155180930 -0400
@@ -98,3 +98,6 @@
 allow mount_t mnt_t:dir { getattr };
 dontaudit mount_t { userdomain kernel_t}:fd use;
 can_exec(mount_t, { sbin_t bin_t })
+dontaudit mount_t tmpfs_t:chr_file { read write };
+allow mount_t device_t:dir r_dir_perms;
+allow mount_t tmpfs_t:dir { mounton };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/restorecon.te policy-1.17.11/domains/program/restorecon.te
--- nsapolicy/domains/program/restorecon.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/restorecon.te	2004-09-08 11:52:35.000000000 -0400
@@ -41,7 +41,9 @@
 allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom };
 allow restorecon_t unlabeled_t:dir read;
 allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfrom relabelto };
-allow restorecon_t device_t:{ chr_file blk_file } { getattr relabelfrom };
+allow restorecon_t { tmpfs_t device_t device_type }:{chr_file blk_file} { getattr relabelfrom relabelto };
+allow restorecon_t tmpfs_t:{chr_file blk_file} { read write };
+
 allow restorecon_t ptyfile:chr_file getattr;
 
 allow restorecon_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.11/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.11/domains/program/syslogd.te	2004-09-08 11:54:04.000000000 -0400
@@ -95,3 +95,6 @@
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t devpts_t:dir { search };
+
+dontaudit syslogd_t kernel_t:fd use;
+dontaudit syslogd_t kernel_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.17.11/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/anaconda.te	2004-09-08 17:18:38.932630923 -0400
@@ -185,11 +185,13 @@
 ifdef(`sound.te', `allow anaconda_t sound_file_t:file { setattr write };')
 
 ifdef(`distro_redhat', `
+ifdef(`rpm.te', `
 # Access /var/lib/rpm.
 allow anaconda_t var_lib_rpm_t:dir rw_dir_perms;
 allow anaconda_t var_lib_rpm_t:file create_file_perms;
 domain_auto_trans(anaconda_t, rpm_exec_t, rpm_t)
 ')
+')
 
 # Update /var/log/ksyms.*.
 # badly named type, /var/log/boot gets the same name too which is confusing
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.17.11/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/apmd.te	2004-09-08 17:01:24.739835578 -0400
@@ -122,3 +122,4 @@
 
 # for a find /dev operation that gets /dev/shm
 dontaudit apmd_t tmpfs_t:dir r_dir_perms;
+dontaudit apmd_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.17.11/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/bluetooth.te	2004-09-08 11:52:35.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the bluetooth_t domain.
 #
-daemon_domain(bluetooth, `, dbus_client_domain')
+daemon_domain(bluetooth)
 
 file_type_auto_trans(bluetooth_t, var_run_t, bluetooth_var_run_t, sock_file)
 
@@ -22,6 +22,7 @@
 # Use the network.
 can_network(bluetooth_t)
 can_ypbind(bluetooth_t)
+dbusd_client(system, bluetooth_t)
 allow bluetooth_t self:socket { create setopt ioctl bind listen };
 allow bluetooth_t self:unix_dgram_socket create_socket_perms;
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.11/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/consoletype.te	2004-09-08 17:01:16.574246875 -0400
@@ -51,3 +51,4 @@
 ifdef(`pam.te', `
 allow consoletype_t pam_var_run_t:file { getattr read };
 ')
+dontaudit consoletype_t tmpfs_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.11/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.11/domains/program/unused/cups.te	2004-09-08 17:20:59.777799778 -0400
@@ -2,7 +2,7 @@
 #
 # Created cups policy from lpd policy: Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: cupsys cupsys-client cupsys-bsd
-# Depends: lpd.te
+# Depends: lpd.te lpr.te
 
 #################################
 #
@@ -12,7 +12,7 @@
 # cupsd_exec_t is the type of the cupsd executable.
 #
 type ipp_port_t, port_type;
-daemon_domain(cupsd, `, auth_chkpwd, dbus_client_domain')
+daemon_domain(cupsd, `, auth_chkpwd')
 etcdir_domain(cupsd)
 typealias cupsd_etc_t alias etc_cupsd_t;
 type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
@@ -20,6 +20,7 @@
 
 can_network(cupsd_t)
 can_ypbind(cupsd_t)
+dbusd_client(system, cupsd_t)
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
@@ -35,6 +36,7 @@
 
 ifdef(`usbmodules.te', `
 r_dir_file(cupsd_t, usbdevfs_t)
+r_dir_file(cupsd_t, usbfs_t)
 ')
 
 ifdef(`logrotate.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.11/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.11/domains/program/unused/dbusd.te	2004-09-08 11:52:35.000000000 -0400
@@ -2,34 +2,17 @@
 #
 # Author:  Russell Coker <russell@coker.com.au>
 
-daemon_domain(dbusd, `, userspace_objmgr')
-type etc_dbusd_t, file_type, sysadmfile;
+dbusd_domain(system)
 
-allow dbusd_t dbusd_var_run_t:sock_file create_file_perms;
+allow system_dbusd_t dbusd_var_run_t:sock_file create_file_perms;
 
 ifdef(`pamconsole.te', `
-r_dir_file(dbusd_t, pam_var_console_t)
+r_dir_file(system_dbusd_t, pam_var_console_t)
 ')
 
-r_dir_file(dbusd_t, etc_dbusd_t)
-allow dbusd_t self:unix_stream_socket create_stream_socket_perms;
-allow dbusd_t self:unix_dgram_socket create_socket_perms;
-
-allow dbusd_t etc_t:file { getattr read };
 # dac_override: /var/run/dbus is owned by messagebus on Debian
-allow dbusd_t self:capability { dac_override setgid setuid };
-allow dbusd_t self:file { getattr read };
-allow dbusd_t proc_t:file { read };
-can_ypbind(dbusd_t)
+allow system_dbusd_t self:capability { dac_override setgid setuid };
+can_ypbind(system_dbusd_t)
 
 # I expect we need more than this
-allow { dbus_client_domain userdomain } { var_run_t dbusd_var_run_t }:dir search;
-allow { dbus_client_domain userdomain } dbusd_var_run_t:sock_file { write };
-allow { dbus_client_domain userdomain } dbusd_t:unix_stream_socket { connectto };
-
-# Permissions for SE-DBus operation
-r_dir_file(dbusd_t,selinux_config_t)
-
-# SE-DBus specific permissions
-allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
-domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.17.11/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/dhcpc.te	2004-09-08 17:00:48.867062937 -0400
@@ -128,3 +128,4 @@
 
 allow dhcpc_t home_root_t:dir { search };
 allow initrc_t dhcpc_state_t:file { getattr read };
+dontaudit dhcpc_t var_lock_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.11/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-08 09:44:50.000000000 -0400
+++ policy-1.17.11/domains/program/unused/hald.te	2004-09-08 17:23:29.567470542 -0400
@@ -10,15 +10,18 @@
 #
 # hald_exec_t is the type of the hald executable.
 #
-daemon_domain(hald, `, dbus_client_domain, fs_domain')
+daemon_domain(hald, `, fs_domain')
 
-can_exec(hald_t, hald_exec_t)
+can_exec(hald_t, { hald_exec_t shell_exec_t } )
 
 allow hald_t { etc_t etc_runtime_t }:file { getattr read };
 allow hald_t self:unix_stream_socket create_stream_socket_perms;
 allow hald_t self:unix_dgram_socket create_socket_perms;
 
-allow hald_t dbusd_t:dbus { acquire_svc };
+ifdef(`dbus.te', `
+allow hald_t system_dbusd_t:dbus { acquire_svc };
+dbusd_client(system, hald_t)
+')
 
 allow hald_t { self proc_t }:file { getattr read };
 
@@ -39,6 +42,7 @@
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
 allow updfstab_t hald_t:dbus { send_msg };
+allow hald_t updfstab_t:dbus { send_msg };
 ')
 ifdef(`udev.te', `
 domain_auto_trans(hald_t, udev_exec_t, udev_t)
@@ -49,3 +53,5 @@
 allow hald_t usbdevfs_t:file { getattr read };
 allow hald_t usbfs_t:dir search;
 allow hald_t usbfs_t:file { getattr read };
+allow hald_t bin_t:lnk_file read;
+can_exec(hald_t, sbin_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.11/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.11/domains/program/unused/hotplug.te	2004-09-08 11:52:35.000000000 -0400
@@ -11,7 +11,7 @@
 # hotplug_exec_t is the type of the hotplug executable.
 #
 ifdef(`unlimitedUtils', `
-daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, dbus_client_domain, unrestricted')
+daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, unrestricted')
 ', `
 daemon_domain(hotplug, `, privmodule, dbus_client_domain')
 ')
@@ -143,6 +143,7 @@
 
 can_network(hotplug_t)
 can_ypbind(hotplug_t)
+dbusd_client(system, hotplug_t)
 
 # Allow hotplug (including /sbin/ifup-local) to start/stop services and # run sendmail -q
 domain_auto_trans(hotplug_t, initrc_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.11/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-09-04 07:28:22.000000000 -0400
+++ policy-1.17.11/domains/program/unused/ipsec.te	2004-09-08 17:24:30.007441496 -0400
@@ -29,6 +29,7 @@
 type ipsec_mgmt_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(ipsec_mgmt_t, ipsec_exec_t, ipsec_t)
 file_type_auto_trans(ipsec_mgmt_t, var_run_t, ipsec_var_run_t, sock_file)
+file_type_auto_trans(ipsec_t, var_run_t, ipsec_var_run_t, sock_file)
 
 allow ipsec_mgmt_t modules_object_t:dir search;
 allow ipsec_mgmt_t modules_object_t:file getattr;
@@ -71,6 +72,7 @@
 allow ipsec_mgmt_t ipsec_mgmt_exec_t:lnk_file read;
 can_exec(ipsec_mgmt_t, shell_exec_t)
 can_exec(ipsec_t, shell_exec_t)
+can_exec(ipsec_t, bin_t)
 can_exec(ipsec_t, ipsec_mgmt_exec_t)
 can_exec(ipsec_mgmt_t, ifconfig_exec_t)
 
@@ -89,12 +91,13 @@
 
 # need access to /proc/sys/net/ipsec/icmp
 allow ipsec_mgmt_t sysctl_t:file write;
+allow ipsec_mgmt_t sysctl_net_t:dir { search };
 allow ipsec_mgmt_t sysctl_net_t:file { write setattr };
 
 # whack needs to be able to read/write pluto.ctl
 allow ipsec_mgmt_t ipsec_var_run_t:sock_file { read write };
 # and it wants to connect to a socket...
-allow ipsec_mgmt_t ipsec_mgmt_t:unix_stream_socket { create connect read write };
+allow ipsec_mgmt_t ipsec_mgmt_t:unix_stream_socket { create connect read write setopt };
 allow ipsec_mgmt_t ipsec_t:unix_stream_socket { connectto read write };
 
 # allow system administrator to use the ipsec script to look
@@ -162,7 +165,7 @@
 allow { ipsec_t ipsec_mgmt_t } bin_t:lnk_file read;
 
 #
-allow ipsec_mgmt_t self:process { sigchld signal };
+allow ipsec_mgmt_t self:process { sigchld signal setrlimit };
 
 # Allow read/write access to /var/run/pluto.ctl
 allow ipsec_t ipsec_t:unix_stream_socket {create setopt bind listen accept read write };
@@ -204,3 +207,20 @@
 allow ipsec_t initrc_devpts_t:chr_file { getattr read write };
 allow ipsec_mgmt_t self:lnk_file read;
 
+allow ipsec_mgmt_t ipsec_mgmt_t:capability { sys_tty_config dac_read_search };
+read_locale(ipsec_mgmt_t)
+var_run_domain(ipsec_mgmt)
+dontaudit ipsec_mgmt_t default_t:dir { getattr };
+dontaudit ipsec_mgmt_t default_t:file { getattr };
+allow ipsec_mgmt_t tmpfs_t:dir { getattr read };
+allow ipsec_mgmt_t self:key_socket { create setopt };
+can_exec(ipsec_mgmt_t, initrc_exec_t)
+allow ipsec_t self:netlink_xfrm_socket create_socket_perms;
+read_locale(ipsec_t)
+ifdef(`consoletype.te', `
+can_exec(ipsec_mgmt_t, consoletype_exec_t )
+')
+dontaudit ipsec_mgmt_t selinux_config_t:dir { search };
+dontaudit ipsec_t ttyfile:chr_file { read write };
+allow ipsec_t ipsec_t:capability { dac_override dac_read_search };
+allow ipsec_t reserved_port_t:udp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.11/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-09-08 09:44:50.000000000 -0400
+++ policy-1.17.11/domains/program/unused/rpm.te	2004-09-08 17:34:48.993021252 -0400
@@ -132,8 +132,10 @@
 role sysadm_r types rpm_script_t;
 domain_trans(rpm_t, shell_exec_t, rpm_script_t)
 ifdef(`hide_broken_symptoms', `
+ifdef(`pamconsole.te', `
 domain_trans(rpm_t, pam_console_exec_t, rpm_script_t)
 ')
+')
 
 tmp_domain(rpm_script)
 
@@ -161,7 +163,6 @@
 ')
 ifdef(`crond.te', `
 allow crond_t rpm_t:fifo_file r_file_perms;
-allow rpm_script_t self:passwd crontab;
 ')
 
 allow rpm_script_t proc_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.11/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/sendmail.te	2004-09-08 17:33:46.401210768 -0400
@@ -43,8 +43,10 @@
 #  Need this transition to create /etc/aliases.db 
 #
 ifdef(`distro_redhat', `
+ifdef(`rpm.te', `
 domain_auto_trans(rpm_script_t, sendmail_exec_t, system_mail_t)
 ')
+')
 
 allow sendmail_t etc_mail_t:dir rw_dir_perms;
 allow sendmail_t etc_mail_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.11/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/domains/program/unused/snmpd.te	2004-09-08 17:33:16.630135317 -0400
@@ -46,10 +46,12 @@
 allow snmpd_t self:file { getattr read };
 
 ifdef(`distro_redhat', `
+ifdef(`rpm.te', `
 r_dir_file(snmpd_t, rpm_var_lib_t)
 dontaudit snmpd_t rpm_var_lib_t:dir { write };
 dontaudit snmpd_t rpm_var_lib_t:file { write };
 ')
+')
 
 allow snmpd_t home_root_t:dir search;
 allow snmpd_t initrc_var_run_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.11/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.11/domains/program/unused/udev.te	2004-09-08 16:59:58.319964054 -0400
@@ -9,7 +9,7 @@
 #
 # udev_exec_t is the type of the udev executable.
 #
-daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd, dbus_client_domain')
+daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd')
 
 general_domain_access(udev_t)
 
@@ -28,10 +28,10 @@
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
-allow udev_t device_t:blk_file create_file_perms;
-allow udev_t device_t:chr_file create_file_perms;
-allow udev_t device_t:sock_file create_file_perms;
-allow udev_t device_t:lnk_file create_lnk_perms;
+allow udev_t { tmpfs_t device_t }:blk_file create_file_perms;
+allow udev_t { tmpfs_t device_t }:chr_file create_file_perms;
+allow udev_t { tmpfs_t device_t }:sock_file create_file_perms;
+allow udev_t { tmpfs_t device_t }:lnk_file create_lnk_perms;
 allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
 allow udev_t { sbin_t bin_t }:lnk_file read;
@@ -40,7 +40,7 @@
 can_exec(udev_t, udev_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
-allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
+allow udev_t { tmpfs_t device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
 # to read the file_contexts file
 r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
@@ -96,3 +96,11 @@
 ifdef(`dhcpc.te', `
 domain_auto_trans(udev_t, dhcpc_exec_t, dhcpc_t)
 ')
+
+allow udev_t tmpfs_t:dir { search };
+rw_dir_create_file(udev_t, { device_t tmpfs_t })
+allow udev_t udev_helper_exec_t:dir r_dir_perms;
+
+dbusd_client(system, udev_t)
+
+allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.11/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-09-02 08:03:26.000000000 -0400
+++ policy-1.17.11/domains/program/unused/updfstab.te	2004-09-08 11:52:35.000000000 -0400
@@ -3,7 +3,7 @@
 # Author:  Russell Coker <russell@coker.com.au>
 #
 
-daemon_base_domain(updfstab, `, fs_domain, etc_writer, dbus_client_domain')
+daemon_base_domain(updfstab, `, fs_domain, etc_writer')
 
 rw_dir_create_file(updfstab_t, etc_t)
 create_dir_file(updfstab_t, mnt_t)
@@ -28,6 +28,8 @@
 
 read_locale(updfstab_t)
 
+dbusd_client(system, updfstab_t)
+
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
 # I will not allow it
 dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/zebra.te policy-1.17.11/domains/program/zebra.te
--- nsapolicy/domains/program/zebra.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.11/domains/program/zebra.te	2004-09-08 09:59:01.000000000 -0400
@@ -0,0 +1,34 @@
+#DESC Zebra - BGP server
+#
+# Author:  Russell Coker <russell@coker.com.au>
+# X-Debian-Packages: zebra
+#
+type zebra_port_t, port_type;
+
+daemon_domain(zebra, `, sysctl_net_writer')
+type zebra_conf_t, file_type, sysadmfile;
+r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
+
+can_network(zebra_t)
+can_ypbind(zebra_t)
+allow zebra_t { etc_t etc_runtime_t }:file { getattr read };
+
+allow zebra_t self:process setcap;
+allow zebra_t self:capability { setgid setuid net_bind_service net_admin net_raw };
+file_type_auto_trans(zebra_t, var_run_t, zebra_var_run_t, sock_file)
+
+logdir_domain(zebra)
+
+# /tmp/.bgpd is such a bad idea!
+type zebra_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans(zebra_t, tmp_t, zebra_tmp_t, sock_file)
+
+allow zebra_t self:unix_dgram_socket create_socket_perms;
+allow zebra_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow zebra_t self:rawip_socket create_socket_perms;
+allow zebra_t self:netlink_route_socket r_netlink_socket_perms;
+allow zebra_t zebra_port_t:tcp_socket name_bind;
+
+allow zebra_t proc_t:file { getattr read };
+allow zebra_t { sysctl_t sysctl_net_t }:dir search;
+allow zebra_t sysctl_net_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/file_contexts policy-1.17.11/file_contexts/file_contexts
--- nsapolicy/file_contexts/file_contexts	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.11/file_contexts/file_contexts	2004-09-08 17:28:47.308950505 -0400
@@ -0,0 +1,788 @@
+# Distro-specific customizations.
+
+# Comment out all but the one that matches your distro.
+# The policy .te files can then wrap distro-specific customizations with
+# appropriate ifdefs.
+
+
+
+
+
+
+# Allow all domains to connect to nscd
+
+# Allow users to control network interfaces (also needs USERCTL=true)
+
+# Allow users to execute the mount command
+
+
+# Allow rpm to run unconfined.
+
+
+# Allow privileged utilities like hotplug and insmod to run unconfined.
+
+
+# Support NFS home directories
+
+
+# Allow users to run games
+
+
+# Allow ypbind to run with NIS
+
+
+# Allow rc scripts to run unconfined, including any daemon
+# started by an rc script that does not have a domain transition
+# explicitly defined.
+
+
+# Allow sysadm_t to directly start daemons
+
+
+# Do not audit things that we know to be broken but which
+# are not security risks
+
+
+# Allow sysadm_t to do almost everything
+
+# Allow the read/write/create on any NFS file system
+
+
+# Allow the reading on any NFS file system
+
+# Allow user_r to reach sysadm_r via su, sudo, or userhelper.
+# Otherwise, only staff_r can do so.
+
+
+# Allow xinetd to run unconfined, including any services it starts
+# that do not have a domain transition explicitly defined.
+
+#
+# This file describes the security contexts to be applied to files
+# when the security policy is installed.  The setfiles program
+# reads this file and labels files accordingly.
+#
+# Each specification has the form:
+#       regexp [ -type ] ( context | <<none>> )
+#
+# By default, the regexp is an anchored match on both ends (i.e. a 
+# caret (^) is prepended and a dollar sign ($) is appended automatically).
+# This default may be overridden by using .* at the beginning and/or
+# end of the regular expression.  
+#
+# The optional type field specifies the file type as shown in the mode
+# field by ls, e.g. use -d to match only directories or -- to match only
+# regular files.
+#
+# The value of <<none> may be used to indicate that matching files
+# should not be relabeled.
+#
+# The last matching specification is used.
+#
+# If there are multiple hard links to a file that match
+# different specifications and those specifications indicate
+# different security contexts, then a warning is displayed
+# but the file is still labeled based on the last matching
+# specification other than <<none>>.
+#
+# Some of the files listed here get re-created during boot and therefore
+# need type transition rules to retain the correct type. These files are
+# listed here anyway so that if the setfiles program is used on a running
+# system it does not relabel them to something we do not want. An example of
+# this is /var/run/utmp.
+#
+
+#
+# The security context for all files not otherwise specified.
+#
+/.*				system_u:object_r:default_t
+
+#
+# The root directory.
+#
+/			-d	system_u:object_r:root_t
+
+#
+# Ordinary user home directories.
+# HOME_ROOT expands to all valid home directory prefixes found in /etc/passwd
+# HOME_DIR expands to each user's home directory,
+#                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
+# ROLE expands to each user's role when role != user_r, and to "user" otherwise.
+#
+/home		-d	system_u:object_r:home_root_t
+/home/[^/]+		-d	system_u:object_r:user_home_dir_t
+/home/[^/]+/.+			system_u:object_r:user_home_t
+
+#
+# A common mount point
+/mnt(/.*)?		-d	system_u:object_r:mnt_t
+/media(/.*)?		-d	system_u:object_r:mnt_t
+
+#
+# /var
+#
+/var(/.*)?			system_u:object_r:var_t
+/var/catman(/.*)?		system_u:object_r:catman_t
+/var/cache/man(/.*)?		system_u:object_r:catman_t
+/var/yp(/.*)?			system_u:object_r:var_yp_t
+/var/lib(/.*)?			system_u:object_r:var_lib_t
+/var/lib/nfs(/.*)?		system_u:object_r:var_lib_nfs_t
+/var/lib/texmf(/.*)?		system_u:object_r:tetex_data_t
+/var/cache/fonts(/.*)?		system_u:object_r:tetex_data_t
+/var/lock(/.*)?			system_u:object_r:var_lock_t
+/var/tmp		-d	system_u:object_r:tmp_t
+/var/tmp/.*			<<none>>
+/var/tmp/vi\.recover	-d	system_u:object_r:tmp_t
+/var/lib/nfs/rpc_pipefs(/*)?	<<none>>
+/var/mailman/bin(/.*)?		system_u:object_r:bin_t
+/var/mailman/pythonlib(/.*)?/.*\.so(\..*)?	-- system_u:object_r:shlib_t
+
+#
+# /var/ftp
+#
+/var/ftp/bin(/.*)?		system_u:object_r:bin_t
+/var/ftp/bin/ls		--	system_u:object_r:ls_exec_t
+/var/ftp/lib(64)?(/.*)?		system_u:object_r:lib_t
+/var/ftp/lib(64)?/ld[^/]*\.so(\.[^/]*)* --	system_u:object_r:ld_so_t
+/var/ftp/lib(64)?/lib[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+/var/ftp/etc(/.*)?		system_u:object_r:etc_t
+
+#
+# /bin
+#
+/bin(/.*)?			system_u:object_r:bin_t
+/bin/tcsh		--	system_u:object_r:shell_exec_t
+/bin/bash		--	system_u:object_r:shell_exec_t
+/bin/bash2		--	system_u:object_r:shell_exec_t
+/bin/sash		--	system_u:object_r:shell_exec_t
+/bin/d?ash		--	system_u:object_r:shell_exec_t
+/bin/zsh.*		--	system_u:object_r:shell_exec_t
+/usr/sbin/sesh		--	system_u:object_r:shell_exec_t
+/bin/ls			--	system_u:object_r:ls_exec_t
+
+#
+# /boot
+#
+/boot(/.*)?			system_u:object_r:boot_t
+/boot/System\.map-.*	--	system_u:object_r:system_map_t
+/boot/kernel\.h.*	--	system_u:object_r:boot_runtime_t
+
+#
+# /dev
+#
+/u?dev(/.*)?			system_u:object_r:device_t
+/u?dev/pts(/.*)?		<<none>>
+/u?dev/cpu/.*		-c	system_u:object_r:cpu_device_t
+/u?dev/microcode	-c	system_u:object_r:cpu_device_t
+/u?dev/MAKEDEV		--	system_u:object_r:sbin_t
+/u?dev/null		-c	system_u:object_r:null_device_t
+/u?dev/full		-c	system_u:object_r:null_device_t
+/u?dev/zero		-c	system_u:object_r:zero_device_t
+/u?dev/console		-c	system_u:object_r:console_device_t
+/u?dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
+/u?dev/nvram		-c	system_u:object_r:memory_device_t
+/u?dev/random		-c	system_u:object_r:random_device_t
+/u?dev/urandom		-c	system_u:object_r:urandom_device_t
+/u?dev/capi.*		-c	system_u:object_r:tty_device_t
+/u?dev/dcbri[0-9]+	-c	system_u:object_r:tty_device_t
+/u?dev/irlpt[0-9]+	-c	system_u:object_r:printer_device_t
+/u?dev/ircomm[0-9]+	-c	system_u:object_r:tty_device_t
+/u?dev/isdn.*		-c	system_u:object_r:tty_device_t
+/u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
+/u?dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c system_u:object_r:bsdpty_device_t
+/u?dev/cu.*		-c	system_u:object_r:tty_device_t
+/u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
+/u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
+/u?dev/tty		-c	system_u:object_r:devtty_t
+/dev/lp.*		-c	system_u:object_r:printer_device_t
+/dev/par.*		-c	system_u:object_r:printer_device_t
+/dev/usb/lp.*		-c	system_u:object_r:printer_device_t
+/dev/usblp.*		-c	system_u:object_r:printer_device_t
+/u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
+/u?dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/net/.*		-c	system_u:object_r:tun_tap_device_t
+/u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
+/u?dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
+/u?dev/scramdisk/.*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/initrd		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/js.*		-c	system_u:object_r:mouse_device_t
+/u?dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
+/u?dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
+/u?dev/usb/rio500	-c	system_u:object_r:removable_device_t
+/u?dev/fd[^/]+		-b	system_u:object_r:removable_device_t
+# I think a parallel port disk is a removable device...
+/u?dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
+/u?dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
+/u?dev/aztcd		-b	system_u:object_r:removable_device_t
+/u?dev/bpcd		-b	system_u:object_r:removable_device_t
+/u?dev/gscd		-b	system_u:object_r:removable_device_t
+/u?dev/hitcd		-b	system_u:object_r:removable_device_t
+/u?dev/pcd[0-3]		-b	system_u:object_r:removable_device_t
+/u?dev/mcdx?		-b	system_u:object_r:removable_device_t
+/u?dev/cdu.*		-b	system_u:object_r:removable_device_t
+/u?dev/cm20.*		-b	system_u:object_r:removable_device_t
+/u?dev/optcd		-b	system_u:object_r:removable_device_t
+/u?dev/sbpcd.*		-b	system_u:object_r:removable_device_t
+/u?dev/sjcd		-b	system_u:object_r:removable_device_t
+/u?dev/sonycd		-b	system_u:object_r:removable_device_t
+# parallel port ATAPI generic device
+/u?dev/pg[0-3]		-c	system_u:object_r:removable_device_t
+/u?dev/rtc		-c	system_u:object_r:clock_device_t
+/u?dev/psaux		-c	system_u:object_r:mouse_device_t
+/u?dev/atibm		-c	system_u:object_r:mouse_device_t
+/u?dev/logibm		-c	system_u:object_r:mouse_device_t
+/u?dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
+/u?dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
+/u?dev/input/event.*	-c	system_u:object_r:event_device_t
+/u?dev/input/mice	-c	system_u:object_r:mouse_device_t
+/u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
+/u?dev/ptmx		-c	system_u:object_r:ptmx_t
+/u?dev/sequencer	-c	system_u:object_r:misc_device_t
+/u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
+/u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
+/u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
+/u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
+/u?dev/winradio.	-c	system_u:object_r:v4l_device_t
+/u?dev/vttuner		-c	system_u:object_r:v4l_device_t
+/u?dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
+/u?dev/adsp		-c	system_u:object_r:sound_device_t
+/u?dev/mixer.*		-c	system_u:object_r:sound_device_t
+/u?dev/dsp.*		-c	system_u:object_r:sound_device_t
+/u?dev/audio.*		-c	system_u:object_r:sound_device_t
+/u?dev/r?midi.*		-c	system_u:object_r:sound_device_t
+/u?dev/sequencer2	-c	system_u:object_r:sound_device_t
+/u?dev/smpte.*		-c	system_u:object_r:sound_device_t
+/u?dev/sndstat		-c	system_u:object_r:sound_device_t
+/u?dev/beep		-c	system_u:object_r:sound_device_t
+/u?dev/patmgr[01]	-c	system_u:object_r:sound_device_t
+/u?dev/mpu401.*		-c	system_u:object_r:sound_device_t
+/u?dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
+/u?dev/aload.*		-c	system_u:object_r:sound_device_t
+/u?dev/amidi.*		-c	system_u:object_r:sound_device_t
+/u?dev/amixer.*		-c	system_u:object_r:sound_device_t
+/u?dev/snd/.*		-c	system_u:object_r:sound_device_t
+/u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
+/u?dev/n?(raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
+/u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
+/u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
+/u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
+/u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
+/u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
+/u?dev/tape.*		-c	system_u:object_r:tape_device_t
+/u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
+/u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
+/u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
+/u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
+/u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
+/u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
+/u?dev/dri/.+		-c	system_u:object_r:dri_device_t
+/u?dev/radeon		-c	system_u:object_r:dri_device_t
+/u?dev/agpgart		-c	system_u:object_r:agp_device_t
+
+/proc(/.*)?			<<none>>
+/sys(/.*)?			<<none>>
+/selinux(/.*)?			<<none>>
+/opt(/.*)?			system_u:object_r:usr_t
+/opt/[^/]*/bin(/.*)?		system_u:object_r:bin_t
+/opt/[^/]*/lib(/.*)?		system_u:object_r:lib_t
+/opt/[^/]*/lib/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/[^/]*/lib/.*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/[^/]*/man(/.*)?		system_u:object_r:man_t
+/opt/[^/]*/libexec(/.*)?	system_u:object_r:bin_t
+
+#
+# /etc
+#
+/etc(/.*)?			system_u:object_r:etc_t
+/etc/\.pwd\.lock	--	system_u:object_r:shadow_t
+/etc/passwd\.lock	--	system_u:object_r:shadow_t
+/etc/group\.lock	--	system_u:object_r:shadow_t
+/etc/shadow.*		--	system_u:object_r:shadow_t
+/etc/gshadow.*		--	system_u:object_r:shadow_t
+/etc/blkid\.tab		--	system_u:object_r:etc_runtime_t
+/etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
+/etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
+/etc/ioctl\.save	--	system_u:object_r:etc_runtime_t
+/etc/mtab		--	system_u:object_r:etc_runtime_t
+/etc/motd		--	system_u:object_r:etc_runtime_t
+/etc/issue		--	system_u:object_r:etc_runtime_t
+/etc/issue\.net		--	system_u:object_r:etc_runtime_t
+/etc/sysconfig/hwconf	--	system_u:object_r:etc_runtime_t
+/etc/sysconfig/iptables.save -- system_u:object_r:etc_runtime_t
+/etc/sysconfig/firstboot --	system_u:object_r:etc_runtime_t
+/etc/asound\.state	--	system_u:object_r:etc_runtime_t
+/etc/ptal/ptal-printd-like -- 	system_u:object_r:etc_runtime_t
+/etc/ld\.so\.cache	--	system_u:object_r:ld_so_cache_t
+/etc/ld\.so\.preload	--	system_u:object_r:ld_so_cache_t
+/etc/yp\.conf.*		--	system_u:object_r:net_conf_t
+/etc/resolv\.conf.*	--	system_u:object_r:net_conf_t
+
+/etc/selinux(/.*)?		system_u:object_r:selinux_config_t
+/etc/security/selinux(/.*)?	system_u:object_r:policy_config_t	
+/etc/security/selinux/src(/.*)?	system_u:object_r:policy_src_t
+/etc/security/default_contexts.*	system_u:object_r:default_context_t
+/etc/services		--	system_u:object_r:etc_t
+
+/etc/selinux/[^/]*/policy(/.*)?	system_u:object_r:policy_config_t
+/etc/selinux/[^/]*/src(/.*)?	system_u:object_r:policy_src_t
+/etc/selinux/[^/]*/contexts(/.*)?	system_u:object_r:default_context_t
+/etc/selinux/[^/]*/contexts/files(/.*)? system_u:object_r:file_context_t
+
+
+#
+# /lib(64)?
+#
+/lib(64)?(/.*)?			system_u:object_r:lib_t
+/lib(64)?/ld[^/]*\.so(\.[^/]*)*		--	system_u:object_r:ld_so_t
+/lib(64)?/tls/ld[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
+/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/lib(64)?/[^/]*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/lib(64)?/security/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/lib(64)?/tls/i686/cmov/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+
+#
+# /sbin
+#
+/sbin(/.*)?			system_u:object_r:sbin_t
+
+#
+# /tmp
+#
+/tmp			-d	system_u:object_r:tmp_t
+/tmp/.*				<<none>>
+
+#
+# /usr
+#
+/usr(/.*)?			system_u:object_r:usr_t
+/usr/etc(/.*)?			system_u:object_r:etc_t
+/usr/libexec(/.*)?		system_u:object_r:bin_t
+/usr/src(/.*)?			system_u:object_r:src_t
+/usr/tmp(/.*)?			system_u:object_r:tmp_t
+/usr/man(/.*)?			system_u:object_r:man_t
+/usr/share/man(/.*)?		system_u:object_r:man_t
+/usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
+/usr/share/texmf/teTeX/bin(/.*)?	system_u:object_r:bin_t
+/usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
+
+#
+# /usr/bin
+#
+/usr/bin(/.*)?			system_u:object_r:bin_t
+
+#
+# /usr/lib(64)?
+#
+/usr/lib(64)?(/.*)?			system_u:object_r:lib_t
+/usr/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr/lib(64)?/python.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/.*/lib[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+/usr/lib(64)?/.*/.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/autofs/.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/perl5/man(/.*)?	system_u:object_r:man_t
+/usr/lib(64)?/perl.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/selinux(/.*)?		system_u:object_r:policy_src_t
+/usr/lib(64)?/emacsen-common/.*	system_u:object_r:bin_t
+/usr/lib(64)?/.*/bin(/.*)?		system_u:object_r:bin_t
+/usr/lib(64)?/gconv/.*\.so	--	system_u:object_r:shlib_t
+/usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
+
+#
+# /usr/.*glibc.*-linux/lib(64)?
+#
+/usr/.*glibc.*-linux/lib(64)?(/.*)?	system_u:object_r:lib_t
+/usr/.*glibc.*-linux/lib(64)?/ld[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
+/usr/.*glibc.*-linux/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+
+# /usr/.*redhat-linux/lib(64)?
+#
+/usr/.*redhat-linux/lib(64)?(/.*)?	system_u:object_r:lib_t
+/usr/.*redhat-linux/lib(64)?/ld[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
+/usr/.*redhat-linux/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+
+#
+# /usr/.*linux-libc.*/lib(64)?
+#
+/usr/.*linux-libc.*/lib(64)?(/.*)? system_u:object_r:lib_t
+/usr/.*linux-libc.*/lib(64)?/ld[^/]*\.so(\.[^/]*)*	-- system_u:object_r:ld_so_t
+/usr/.*linux-libc.*/lib(64)?/lib[^/]*\.so(\.[^/]*)*	-- system_u:object_r:shlib_t
+
+#
+# /usr/local
+#
+/usr/local/etc(/.*)?		system_u:object_r:etc_t
+/usr/local/src(/.*)?		system_u:object_r:src_t
+/usr/local/sbin(/.*)?		system_u:object_r:sbin_t
+/usr/local/man(/.*)?		system_u:object_r:man_t
+
+#
+# /usr/local/bin
+#
+/usr/local/bin(/.*)?		system_u:object_r:bin_t
+
+#
+# /usr/local/lib(64)?
+#
+/usr/local/lib(64)?(/.*)?		system_u:object_r:lib_t
+/usr/local/lib(64)?(/.*)+\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+
+#
+# /usr/sbin
+#
+/usr/sbin(/.*)?			system_u:object_r:sbin_t
+
+#
+# /usr/X11R6/(.*/)?bin
+#
+/usr/X11R6/(.*/)?bin(/.*)?	system_u:object_r:bin_t
+
+#
+# /usr/X11R6/(.*/)?lib(64)?
+#
+/usr/X11R6/(.*/)?lib(64)?(/.*)?		system_u:object_r:lib_t
+/usr/X11R6/(.*/)?lib(64)?(/.*)+\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+
+#
+# /usr/X11R6/man
+#
+/usr/X11R6/man(/.*)?		system_u:object_r:man_t
+
+#
+# /usr/kerberos
+#
+/usr/kerberos/bin(/.*)?		system_u:object_r:bin_t
+/usr/kerberos/sbin(/.*)?	system_u:object_r:sbin_t
+/usr/kerberos/lib(64)?(/.*)?		system_u:object_r:lib_t
+/usr/kerberos/lib(64)?/lib[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
+
+#
+# Fonts dir
+#
+/usr/X11R6/lib/X11/fonts(/.*)?		system_u:object_r:fonts_t
+
+/usr/share/fonts(/.*)?			system_u:object_r:fonts_t
+/usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
+
+#
+# /var/run
+#
+/var/run(/.*)?			system_u:object_r:var_run_t
+/var/run/.*\.*pid		<<none>>
+
+#
+# /var/spool
+#
+/var/spool(/.*)?		system_u:object_r:var_spool_t
+/var/spool/texmf(/.*)?		system_u:object_r:tetex_data_t
+
+# 
+# /var/log
+#
+/var/log(/.*)?			system_u:object_r:var_log_t
+/var/log/wtmp.*		--	system_u:object_r:wtmp_t
+/var/log/btmp.*		--	system_u:object_r:faillog_t
+/var/log/faillog	--	system_u:object_r:faillog_t
+/var/log/ksyms.*	--	system_u:object_r:var_log_ksyms_t
+/var/log/dmesg		--	system_u:object_r:var_log_t
+/var/log/lastlog	--	system_u:object_r:lastlog_t
+/var/log/ksymoops(/.*)?		system_u:object_r:var_log_ksyms_t
+/var/log/syslog		--	system_u:object_r:var_log_t
+
+#
+# Journal files
+#
+/\.journal			<<none>>
+/usr/\.journal			<<none>>
+/boot/\.journal			<<none>>
+/home/\.journal		<<none>>
+/var/\.journal			<<none>>
+/tmp/\.journal			<<none>>
+/usr/local/\.journal		<<none>>
+
+#
+# Lost and found directories.
+#
+/lost\+found(/.*)?		system_u:object_r:lost_found_t
+/usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
+/boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
+/home/lost\+found(/.*)?	system_u:object_r:lost_found_t
+/var/lost\+found(/.*)?		system_u:object_r:lost_found_t
+/tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
+/usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
+
+#
+# system localization
+#
+/usr/share/zoneinfo(/.*)?	system_u:object_r:locale_t
+/usr/share/locale(/.*)?		system_u:object_r:locale_t
+/usr/lib/locale(/.*)?		system_u:object_r:locale_t
+/etc/localtime		--	system_u:object_r:locale_t
+/etc/localtime		-l	system_u:object_r:etc_t
+
+#
+# Gnu Cash
+#
+/usr/share/gnucash/finance-quote-check -- system_u:object_r:bin_t
+/usr/share/gnucash/finance-quote-helper -- system_u:object_r:bin_t
+
+#
+# initrd mount point, only used during boot
+#
+/initrd			-d	system_u:object_r:root_t
+
+#
+# The Sun Java development kit, RPM install
+#
+/usr/java/j2.*/bin(/.*)?		system_u:object_r:bin_t
+/usr/java/j2.*/jre/lib(64)?/i386(/.*)?	system_u:object_r:lib_t
+/usr/java/j2.*/jre/lib(64)?/i386(/.*)?[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
+/usr/java/j2.*/plugin/i386(/.*)?/lib[^/]*\.so(\.[^/]*)* -- system_u:object_r:shlib_t
+
+#
+#  The krb5.conf file is always being tested for writability, so
+#  we defined a type to dontautit
+#
+/etc/krb5\.conf		--	system_u:object_r:krb5_conf_t
+# checkpolicy
+/usr/bin/checkpolicy		--	system_u:object_r:checkpolicy_exec_t
+/etc/selinux/policy/policy.* -- system_u:object_r:policy_config_t
+/etc/selinux/.*/src/policy/policy.* -- system_u:object_r:policy_config_t	
+# chkpwd
+/sbin/unix_chkpwd	--	system_u:object_r:chkpwd_exec_t
+/sbin/unix_verify	--	system_u:object_r:chkpwd_exec_t
+# crond
+/etc/crontab		--	system_u:object_r:system_cron_spool_t
+/etc/cron\.d(/.*)?		system_u:object_r:system_cron_spool_t
+/usr/sbin/cron(d)?	--	system_u:object_r:crond_exec_t
+/usr/sbin/anacron	--	system_u:object_r:anacron_exec_t
+/var/spool/cron		-d	system_u:object_r:cron_spool_t
+/var/spool/cron/crontabs -d	system_u:object_r:cron_spool_t
+/var/spool/cron/crontabs/.* -- <<none>>
+/var/spool/cron/crontabs/root -- system_u:object_r:sysadm_cron_spool_t
+/var/spool/cron/root	--	system_u:object_r:sysadm_cron_spool_t
+/var/spool/cron/[^/]*	--	<<none>>
+/var/log/cron.*		--	system_u:object_r:crond_log_t
+/var/run/crond\.reboot	--	system_u:object_r:crond_var_run_t
+/var/run/crond\.pid	--	system_u:object_r:crond_var_run_t
+# fcron
+/usr/sbin/fcron		--	system_u:object_r:crond_exec_t
+/var/spool/fcron	-d	system_u:object_r:cron_spool_t
+/var/spool/fcron/.*		<<none>>
+/var/spool/fcron/systab.orig --	system_u:object_r:system_cron_spool_t
+/var/spool/fcron/systab	 --	system_u:object_r:system_cron_spool_t
+/var/spool/fcron/new.systab --	system_u:object_r:system_cron_spool_t
+/var/run/fcron\.fifo	-s	system_u:object_r:crond_var_run_t
+/var/run/fcron\.pid	--	system_u:object_r:crond_var_run_t
+# atd
+/usr/sbin/atd		--	system_u:object_r:crond_exec_t
+/var/spool/at		-d	system_u:object_r:cron_spool_t
+/var/spool/at/spool	-d	system_u:object_r:cron_spool_t
+/var/spool/at/[^/]*	--	<<none>>
+/var/run/atd\.pid	--	system_u:object_r:crond_var_run_t
+# crontab
+/usr/bin/(f)?crontab	--	system_u:object_r:crontab_exec_t
+/usr/bin/at		--	system_u:object_r:crontab_exec_t
+# dmesg
+/bin/dmesg	--	system_u:object_r:dmesg_exec_t
+# fs admin utilities
+/sbin/fsck.*		--	system_u:object_r:fsadm_exec_t
+/sbin/mkfs.*		--	system_u:object_r:fsadm_exec_t
+/sbin/e2fsck		--	system_u:object_r:fsadm_exec_t
+/sbin/mkdosfs		--	system_u:object_r:fsadm_exec_t
+/sbin/dosfsck		--	system_u:object_r:fsadm_exec_t
+/sbin/reiserfs(ck|tune)	--	system_u:object_r:fsadm_exec_t
+/sbin/mkreiserfs	--	system_u:object_r:fsadm_exec_t
+/sbin/resize.*fs	--	system_u:object_r:fsadm_exec_t
+/sbin/e2label		--	system_u:object_r:fsadm_exec_t
+/sbin/findfs		--	system_u:object_r:fsadm_exec_t
+/sbin/mkfs		--	system_u:object_r:fsadm_exec_t
+/sbin/mke2fs		--	system_u:object_r:fsadm_exec_t
+/sbin/mkswap		--	system_u:object_r:fsadm_exec_t
+/sbin/scsi_info		--	system_u:object_r:fsadm_exec_t
+/sbin/sfdisk		--	system_u:object_r:fsadm_exec_t
+/sbin/cfdisk		--	system_u:object_r:fsadm_exec_t
+/sbin/fdisk		--	system_u:object_r:fsadm_exec_t
+/sbin/parted		--	system_u:object_r:fsadm_exec_t
+/sbin/tune2fs		--	system_u:object_r:fsadm_exec_t
+/sbin/dumpe2fs		--	system_u:object_r:fsadm_exec_t
+/sbin/swapon.*		--	system_u:object_r:fsadm_exec_t
+/sbin/hdparm		--	system_u:object_r:fsadm_exec_t
+/sbin/raidstart		--	system_u:object_r:fsadm_exec_t
+/sbin/mkraid		--	system_u:object_r:fsadm_exec_t
+/sbin/blockdev		--	system_u:object_r:fsadm_exec_t
+/sbin/losetup.*		--	system_u:object_r:fsadm_exec_t
+/sbin/jfs_.*		--	system_u:object_r:fsadm_exec_t
+/sbin/lsraid		--	system_u:object_r:fsadm_exec_t
+/usr/sbin/smartctl	--	system_u:object_r:fsadm_exec_t
+/sbin/install-mbr	--	system_u:object_r:fsadm_exec_t
+/usr/bin/scsi_unique_id	--	system_u:object_r:fsadm_exec_t
+/usr/bin/raw		--	system_u:object_r:fsadm_exec_t
+/sbin/partx		--	system_u:object_r:fsadm_exec_t
+/usr/bin/partition_uuid	--	system_u:object_r:fsadm_exec_t
+# getty
+/sbin/.*getty		--	system_u:object_r:getty_exec_t
+/etc/mgetty(/.*)?		system_u:object_r:getty_etc_t
+/bin/hostname		--	system_u:object_r:hostname_exec_t
+# ifconfig
+/sbin/ifconfig		--	system_u:object_r:ifconfig_exec_t
+/sbin/iwconfig		--	system_u:object_r:ifconfig_exec_t
+/sbin/ip		--	system_u:object_r:ifconfig_exec_t
+/sbin/tc		--	system_u:object_r:ifconfig_exec_t
+/bin/ip			--	system_u:object_r:ifconfig_exec_t
+/sbin/ethtool		--	system_u:object_r:ifconfig_exec_t
+/sbin/mii-tool		--	system_u:object_r:ifconfig_exec_t
+# init rc scripts
+/etc/X11/prefdm		--	system_u:object_r:initrc_exec_t
+/etc/rc\.d/rc		--	system_u:object_r:initrc_exec_t
+/etc/rc\.d/rc\.sysinit	--	system_u:object_r:initrc_exec_t
+/etc/rc\.d/rc\.local	--	system_u:object_r:initrc_exec_t
+/etc/rc\.d/init\.d/.*	--	system_u:object_r:initrc_exec_t
+/etc/rc\.d/init\.d/functions -- system_u:object_r:etc_t
+/etc/init\.d/.*		--	system_u:object_r:initrc_exec_t
+/etc/init\.d/functions	--	system_u:object_r:etc_t
+/var/run/utmp		--	system_u:object_r:initrc_var_run_t
+/var/run/runlevel\.dir		system_u:object_r:initrc_var_run_t
+/var/run/random-seed	--	system_u:object_r:initrc_var_run_t
+/var/run/setmixer_flag	--	system_u:object_r:initrc_var_run_t
+# run_init
+/usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
+
+/etc/nologin.*		--	system_u:object_r:etc_runtime_t
+/etc/nohotplug		--	system_u:object_r:etc_runtime_t
+
+/halt                   --      system_u:object_r:etc_runtime_t
+/\.autofsck             --      system_u:object_r:etc_runtime_t
+
+# init
+/dev/initctl		-p	system_u:object_r:initctl_t
+/sbin/init		--	system_u:object_r:init_exec_t
+# klogd
+/sbin/klogd		--	system_u:object_r:klogd_exec_t
+/usr/sbin/klogd		--	system_u:object_r:klogd_exec_t
+/var/run/klogd\.pid	--	system_u:object_r:klogd_var_run_t
+/sbin/ldconfig		--	system_u:object_r:ldconfig_exec_t
+# load_policy
+/usr/sbin/load_policy		--	system_u:object_r:load_policy_exec_t
+/sbin/load_policy		--	system_u:object_r:load_policy_exec_t
+# login
+/bin/login		--	system_u:object_r:login_exec_t
+# logrotate
+/usr/sbin/logrotate	--	system_u:object_r:logrotate_exec_t
+/usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
+
+/etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
+/var/lib/logrotate.status --	system_u:object_r:logrotate_var_lib_t
+/var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
+# using a hard-coded name under /var/tmp is a bug - new version fixes it
+/var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t
+# module utilities
+/etc/modules\.conf.*	--	system_u:object_r:modules_conf_t
+/etc/modprobe\.conf.*	--	system_u:object_r:modules_conf_t
+/lib(64)?/modules/modprobe.conf --	system_u:object_r:modules_conf_t
+/lib(64)?/modules(/.*)?		system_u:object_r:modules_object_t
+/lib(64)?/modules/[^/]+/modules\..+ -- system_u:object_r:modules_dep_t
+/lib(64)?/modules/modprobe\.conf.* -- system_u:object_r:modules_conf_t
+/sbin/depmod.*		--	system_u:object_r:depmod_exec_t
+/sbin/modprobe.*	--	system_u:object_r:insmod_exec_t
+/sbin/insmod.*		--	system_u:object_r:insmod_exec_t
+/sbin/insmod_ksymoops_clean --	system_u:object_r:sbin_t
+/sbin/rmmod.*		--	system_u:object_r:insmod_exec_t
+/sbin/update-modules	--	system_u:object_r:update_modules_exec_t
+/sbin/generate-modprobe.conf -- system_u:object_r:update_modules_exec_t
+# mount
+/bin/mount.*			--	system_u:object_r:mount_exec_t
+/bin/umount.*			--	system_u:object_r:mount_exec_t
+# network utilities
+/sbin/arping		--	system_u:object_r:netutils_exec_t
+/usr/sbin/tcpdump	--	system_u:object_r:netutils_exec_t
+/etc/network/ifstate	--	system_u:object_r:etc_runtime_t
+# newrole
+/usr/bin/newrole	--		system_u:object_r:newrole_exec_t
+# spasswd
+/usr/bin/passwd		--	system_u:object_r:passwd_exec_t
+/usr/bin/chsh		--	system_u:object_r:chfn_exec_t
+/usr/bin/chfn		--	system_u:object_r:chfn_exec_t
+/usr/sbin/vipw		--	system_u:object_r:admin_passwd_exec_t
+/usr/sbin/vigr		--	system_u:object_r:admin_passwd_exec_t
+/usr/bin/vipw		--	system_u:object_r:admin_passwd_exec_t
+/usr/bin/vigr		--	system_u:object_r:admin_passwd_exec_t
+/usr/sbin/pwconv	--	system_u:object_r:admin_passwd_exec_t
+/usr/sbin/pwunconv	--	system_u:object_r:admin_passwd_exec_t
+/usr/sbin/grpconv	--	system_u:object_r:admin_passwd_exec_t
+/usr/sbin/grpunconv	--	system_u:object_r:admin_passwd_exec_t
+# restorecon
+/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
+# setfiles
+/usr/sbin/setfiles.*	--	system_u:object_r:setfiles_exec_t
+
+# ssh
+/usr/bin/ssh		--	system_u:object_r:ssh_exec_t
+/usr/bin/ssh-keygen	--	system_u:object_r:ssh_keygen_exec_t
+# sshd
+/etc/ssh/primes		--	system_u:object_r:sshd_key_t
+/etc/ssh/ssh_host_key 	--	system_u:object_r:sshd_key_t
+/etc/ssh/ssh_host_dsa_key --	system_u:object_r:sshd_key_t
+/etc/ssh/ssh_host_rsa_key --	system_u:object_r:sshd_key_t
+/usr/sbin/sshd	        --	system_u:object_r:sshd_exec_t
+/home/[^/]+/\.ssh(/.*)?		system_u:object_r:user_home_ssh_t
+# subsystems
+/usr/lib(64)?/misc/sftp-server --	system_u:object_r:bin_t
+/usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t
+/usr/lib(64)?/sftp-server	--	system_u:object_r:bin_t
+# sulogin
+/sbin/sulogin		--	system_u:object_r:sulogin_exec_t
+# su
+/bin/su			--	system_u:object_r:su_exec_t
+# syslogd
+/sbin/syslogd		--	system_u:object_r:syslogd_exec_t
+/sbin/minilogd		--	system_u:object_r:syslogd_exec_t
+/usr/sbin/syslogd	--	system_u:object_r:syslogd_exec_t
+/sbin/syslog-ng		--	system_u:object_r:syslogd_exec_t
+/dev/log		-s	system_u:object_r:devlog_t
+/var/run/log		-s	system_u:object_r:devlog_t
+/var/run/syslogd\.pid	--	system_u:object_r:syslogd_var_run_t
+# tmpreaper or tmpwatch
+/usr/sbin/tmpreaper	--	system_u:object_r:tmpreaper_exec_t
+/usr/sbin/tmpwatch	--	system_u:object_r:tmpreaper_exec_t
+# Add programs here which should not be confined by SELinux
+# e.g.:
+# /usr/local/bin/appsrv	--	system_u:object_r:unconfined_exec_t
+#useradd
+/usr/sbin/usermod	--	system_u:object_r:useradd_exec_t
+/usr/sbin/useradd	--	system_u:object_r:useradd_exec_t
+/usr/sbin/userdel	--	system_u:object_r:useradd_exec_t
+#groupadd
+/usr/sbin/groupmod	--	system_u:object_r:groupadd_exec_t
+/usr/sbin/groupadd	--	system_u:object_r:groupadd_exec_t
+/usr/sbin/groupdel	--	system_u:object_r:groupadd_exec_t
+/usr/bin/gpasswd	--	system_u:object_r:groupadd_exec_t
+/usr/sbin/gpasswd	--	system_u:object_r:groupadd_exec_t
+# Zebra - BGP daemon
+/usr/sbin/zebra		--	system_u:object_r:zebra_exec_t
+/usr/sbin/bgpd		--	system_u:object_r:zebra_exec_t
+/var/log/zebra(/.*)?		system_u:object_r:zebra_log_t
+/etc/zebra(/.*)?		system_u:object_r:zebra_conf_t
+/var/run/.zserv		-s	system_u:object_r:zebra_var_run_t
+/var/run/.zebra		-s	system_u:object_r:zebra_var_run_t
+
+#
+# User-specific file contexts
+#
+
+/root		-d	root:object_r:staff_home_dir_t
+/root/.+			root:object_r:staff_home_t
+/root/\.ssh(/.*)?		root:object_r:staff_home_ssh_t
+/root/.default_contexts	-- 	system_u:object_r:default_context_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/hald.fc policy-1.17.11/file_contexts/program/hald.fc
--- nsapolicy/file_contexts/program/hald.fc	2004-09-02 08:03:26.000000000 -0400
+++ policy-1.17.11/file_contexts/program/hald.fc	2004-09-08 17:04:56.067904600 -0400
@@ -1,3 +1,4 @@
 # hald - hardware informationd daemon
 /usr/sbin/hald		--	system_u:object_r:hald_exec_t
 /usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
+/etc/hal/device.d/printer_remove.hal -- system_u:object_r:hald_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.17.11/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2004-08-31 10:55:37.000000000 -0400
+++ policy-1.17.11/file_contexts/program/named.fc	2004-09-08 11:52:35.000000000 -0400
@@ -14,7 +14,7 @@
 ') dnl distro_debian
 
 /etc/rndc.*		--	system_u:object_r:named_conf_t
-/usr/sbin/named.*      	--	system_u:object_r:named_exec_t
+/usr/sbin/named      	--	system_u:object_r:named_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
 /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.11/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-04 07:28:25.000000000 -0400
+++ policy-1.17.11/macros/base_user_macros.te	2004-09-08 17:17:09.106752883 -0400
@@ -185,6 +185,17 @@
 can_network($1_t)
 can_ypbind($1_t)
 
+# Grant permissions to access the system DBus
+ifdef(`dbus.te', `
+dbusd_client(system, $1_t)
+dbusd_client($1, $1_t)
+dbusd_domain($1)
+ifdef(`hald.te', `
+allow $1_t hald_t:dbus { send_msg };
+allow hald_t $1_t:dbus { send_msg };
+') dnl end ifdef hald.te
+') dnl end ifdef dbus.te
+
 # allow port_t name binding for UDP because it is not very usable otherwise
 allow $1_t port_t:udp_socket name_bind;
 
@@ -222,6 +233,10 @@
 dontaudit $1_t domain:dir r_dir_perms;
 dontaudit $1_t domain:notdevfile_class_set r_file_perms;
 dontaudit $1_t domain:process { getattr getsession };
+#
+# Cups daemon running as user tries to write /etc/printcap
+#
+dontaudit $1_t usr_t:file { setattr };
 
 ifdef(`xserver.te', `
 # for /tmp/.ICE-unix
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.17.11/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/macros/program/chkpwd_macros.te	2004-09-08 17:04:11.194382931 -0400
@@ -51,6 +51,7 @@
 allow $1_chkpwd_t etc_t:file { getattr read };
 allow $1_chkpwd_t self:unix_dgram_socket create_socket_perms;
 allow $1_chkpwd_t self:unix_stream_socket create_socket_perms;
+allow $1_chkpwd_t tty_device_t:chr_file { read write };
 read_locale($1_chkpwd_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.17.11/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.11/macros/program/dbusd_macros.te	2004-09-08 17:03:58.650428142 -0400
@@ -0,0 +1,69 @@
+#
+# Macros for Dbus
+#
+# Author: Colin Walters <walters@redhat.com>
+
+# dbusd_domain(domain_prefix)
+#
+# Define a derived domain for the DBus daemon.
+
+define(`dbusd_domain', `
+ifelse(`system', `$1',`
+daemon_domain(system_dbusd, `, userspace_objmgr')
+# For backwards compatibility
+typealias system_dbusd_t alias dbusd_t;
+typealias system_dbusd_exec_t alias dbusd_exec_t;
+typealias system_dbusd_var_run_t alias dbusd_var_run_t;
+type etc_dbusd_t, file_type, sysadmfile;
+',`
+ifdef(`single_userdomain', `
+typealias $1_t alias $1_dbusd_t;
+', `
+type $1_dbusd_t, domain, privlog, userspace_objmgr;
+role $1_r types $1_dbusd_t;
+domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
+read_locale($1_dbusd_t)
+dontaudit $1_dbusd_t var_t:dir { getattr search };
+')dnl end ifdef single_userdomain
+')dnl end ifelse system
+
+base_file_read_access($1_dbusd_t)
+uses_shlib($1_dbusd_t)
+allow $1_dbusd_t etc_t:file { getattr read };
+r_dir_file($1_dbusd_t, etc_dbusd_t)
+tmp_domain($1_dbusd) 
+allow $1_dbusd_t self:process { fork };
+ifdef(`xdm.te', `
+allow $1_dbusd_t xdm_t:fd { use };
+allow $1_dbusd_t xdm_t:fifo_file { write };
+')
+
+allow $1_dbusd_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_dbusd_t self:unix_dgram_socket create_socket_perms;
+
+allow $1_dbusd_t urandom_device_t:chr_file { getattr read };
+allow $1_dbusd_t self:file { getattr read };
+allow $1_dbusd_t proc_t:file { read };
+
+')dnl end dbusd_domain definition
+
+# dbusd_client(dbus_type, domain)
+# Example: dbusd_client_domain(system, user_t)
+#
+# Grant permissions for connecting to the specified DBus type
+# from domain.
+define(`dbusd_client',`')
+ifdef(`dbusd.te',`
+undefine(`dbusd_client')
+define(`dbusd_client',`
+# For connecting to the bus
+allow $2 $1_dbusd_t:unix_stream_socket { connectto };
+ifelse(`system', `$1', `
+allow { $2 } { var_run_t system_dbusd_var_run_t }:dir search;
+allow { $2 } system_dbusd_var_run_t:sock_file { write };
+',`
+') dnl endif system
+# SE-DBus specific permissions
+allow $2 { $1_dbusd_t self }:dbus { send_msg };
+') dnl endif dbusd.te
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.17.11/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/macros/program/userhelper_macros.te	2004-09-08 17:32:29.340753830 -0400
@@ -63,9 +63,11 @@
 can_setexec($1_userhelper_t)
 
 ifdef(`distro_redhat', `
+ifdef(`rpm.te', `
 # Allow transitioning to rpm_t, for up2date
 allow $1_userhelper_t rpm_t:process { transition siginh rlimitinh noatsecure };
 ')
+')
 
 # Use capabilities.
 allow $1_userhelper_t self:capability { setuid setgid net_bind_service dac_override chown sys_tty_config };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.11/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-09-04 07:28:25.000000000 -0400
+++ policy-1.17.11/macros/program/xserver_macros.te	2004-09-08 17:31:29.799519751 -0400
@@ -65,6 +65,7 @@
 
 allow xdm_xserver_t init_t:fd use;
 
+dontaudit xdm_xserver_t user_home_dir_t:dir { read search };
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
 ', `
 # The user role is authorized for this domain.
@@ -162,6 +163,7 @@
 ifdef(`xdm.te', `
 allow $1_t xdm_tmp_t:sock_file { unlink };
 allow $1_xserver_t xdm_var_run_t:dir { search };
+allow xdm_t xserver_misc_device_t:chr_file { getattr };
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
 ')
@@ -248,6 +250,7 @@
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
 dontaudit $1_xserver_t selinux_config_t:dir { search };
+allow $1_xserver_t device_t:dir { create };
 
 # for fonts
 r_dir_file($1_xserver_t, fonts_t)
Binary files nsapolicy/policy.18 and policy-1.17.11/policy.18 differ
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.11/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/tunables/distro.tun	2004-09-08 11:52:35.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.11/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.11/tunables/tunable.tun	2004-09-08 11:52:35.000000000 -0400
@@ -5,50 +5,47 @@
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
-
-# Allow users to unrestricted access
-dnl define(`unlimitedUsers')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.11/types/file.te
--- nsapolicy/types/file.te	2004-08-30 09:49:16.000000000 -0400
+++ policy-1.17.11/types/file.te	2004-09-08 11:52:35.000000000 -0400
@@ -258,6 +258,7 @@
 # the default file system type.
 #
 allow { file_type device_type } fs_t:filesystem associate;
+allow { file_type device_type } tmpfs_t:filesystem associate;
 
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;

--------------070008050509080102020406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
