Message-ID: <4266BFF9.10906@redhat.com>
Date: Wed, 20 Apr 2005 16:47:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: This weeks diffs
Content-Type: multipart/mixed;
 boundary="------------080406030503000806000407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080406030503000806000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Several fixes to get MLS policy working better around initrc_tty files. 

Change hostname_t to only transition when run by dhcpc_t.  (Added to 
targeted)

Several fixes to allow dhclient to work properly.

More fixes for initrc_t for removal of unconfined_domain.

Several fixes for amanda to be able to backup a system.

Allow httpd_suexec_t to create httpd_log files.

Split auditd policy out into auditd_t for audit daemon and auditctl_t 
for autoctl program

Allow cups to communicate with desktop in targeted policy.

Fix prelink to be able to be run by admin.

Misc file_context fixes.

fix ypbind_macros.te to use name_connect.




 

-- 



--------------080406030503000806000407
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.23.11/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/getty.te	2005-04-20 15:31:44.000000000 -0400
@@ -51,6 +51,7 @@
 # Chown, chmod, read and write ttys.
 allow getty_t tty_device_t:chr_file { setattr rw_file_perms };
 allow getty_t ttyfile:chr_file { setattr rw_file_perms };
+allow getty_t initrc_devpts_t:chr_file rw_file_perms; 
 
 # for error condition handling
 allow getty_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.23.11/domains/program/hostname.te
--- nsapolicy/domains/program/hostname.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.11/domains/program/hostname.te	2005-04-20 15:13:49.000000000 -0400
@@ -4,13 +4,11 @@
 # X-Debian-Packages: hostname
 
 # for setting the hostname
-daemon_base_domain(hostname, , nosysadm)
-role sysadm_r types hostname_t;
-
+daemon_core_rules(hostname, , nosysadm)
 allow hostname_t self:capability sys_admin;
 allow hostname_t etc_t:file { getattr read };
 
-allow hostname_t { user_tty_type admin_tty_type }:chr_file { getattr read write };
+allow hostname_t { user_tty_type admin_tty_type }:chr_file rw_file_perms;
 read_locale(hostname_t)
 can_resolve(hostname_t)
 allow hostname_t userdomain:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.11/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-04-20 15:40:34.000000000 -0400
+++ policy-1.23.11/domains/program/initrc.te	2005-04-20 15:40:05.000000000 -0400
@@ -208,6 +208,10 @@
 file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
 
 file_type_auto_trans(initrc_t, device_t, fixed_disk_device_t, blk_file)
+allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
+allow initrc_t self:capability sys_admin;
+allow initrc_t device_t:dir create;
+
 ')dnl end distro_redhat
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
@@ -287,10 +291,6 @@
 
 r_dir_file(initrc_t,selinux_config_t)
 
-ifdef(`distro_redhat', `
-allow initrc_t file_type:{ dir_file_class_set socket_class_set } getattr;
-')
-
 ifdef(`unlimitedRC', `
 unconfined_domain(initrc_t) 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.23.11/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-04-20 15:40:34.000000000 -0400
+++ policy-1.23.11/domains/program/modutil.te	2005-04-20 15:32:42.000000000 -0400
@@ -95,7 +97,7 @@
 allow insmod_t usr_t:file { getattr read };
 
 allow insmod_t privfd:fd use;
-allow insmod_t { initrc_devpts_t admin_tty_type }:chr_file { getattr read write };
+allow insmod_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow insmod_t sysadm_gph_t:fd use;')
 
 allow insmod_t { agp_device_t apm_bios_t }:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.23.11/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.11/domains/program/unused/amanda.te	2005-04-15 14:13:03.000000000 -0400
@@ -128,10 +128,7 @@
 
 # access to device_t and similar
 allow amanda_t device_t:dir search;
-allow amanda_t null_device_t:chr_file { getattr read write };
 allow amanda_t devpts_t:dir getattr;
-allow amanda_t fixed_disk_device_t:blk_file getattr;
-allow amanda_t removable_device_t:blk_file getattr;
 allow amanda_t devtty_t:chr_file { read write };
 
 # access to boot_t
@@ -251,6 +248,9 @@
 allow amanda_recover_t self:fifo_file { getattr ioctl read write };
 allow amanda_recover_t self:unix_stream_socket { connect create read write };
 
+allow amanda_t self:dir search;
+allow amanda_t self:file { getattr read };
+
 
 # amrecover file permissions
 ############################
@@ -302,6 +302,16 @@
 allow inetd_t amanda_port_t:{ tcp_socket udp_socket } name_bind;
 
 allow amanda_t file_type:dir {getattr read search };
-allow amanda_t file_type:file {getattr read };
+allow amanda_t file_type:{ lnk_file file chr_file blk_file } {getattr read };
+dontaudit amanda_t file_type:sock_file getattr;
 logdir_domain(amanda)
 
+dontaudit amanda_t autofs_t:dir { getattr read };
+dontaudit amanda_t binfmt_misc_fs_t:dir getattr;
+dontaudit amanda_t nfs_t:dir { getattr read };
+dontaudit amanda_t proc_t:dir read;
+dontaudit amanda_t rpc_pipefs_t:dir { getattr read };
+dontaudit amanda_t security_t:dir { getattr read };
+dontaudit amanda_t sysfs_t:dir { getattr read };
+dontaudit amanda_t unlabeled_t:file getattr;
+dontaudit amanda_t usbfs_t:dir getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.11/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-04-20 15:40:34.000000000 -0400
+++ policy-1.23.11/domains/program/unused/apache.te	2005-04-19 14:29:04.000000000 -0400
@@ -335,8 +335,8 @@
 allow httpd_suexec_t { var_t var_log_t }:dir search;
 allow httpd_suexec_t home_root_t:dir search;
 
-allow httpd_suexec_t httpd_log_t:dir search;
-allow httpd_suexec_t httpd_log_t:file { append getattr };
+allow httpd_suexec_t httpd_log_t:dir ra_dir_perms;
+allow httpd_suexec_t httpd_log_t:file { create ra_file_perms };
 allow httpd_suexec_t httpd_t:fifo_file getattr;
 allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.11/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-04-20 15:40:34.000000000 -0400
+++ policy-1.23.11/domains/program/unused/auditd.te	2005-04-19 16:05:58.000000000 -0400
@@ -5,16 +5,14 @@
 define(`audit_manager_domain', `
 allow $1 auditd_etc_t:file rw_file_perms;
 create_dir_file($1, auditd_log_t)
+domain_auto_trans($1, auditctl_exec_t, auditctl_t)
 ')
 
-type auditd_etc_t, file_type, secure_file_type;
-
 daemon_domain(auditd)
 
 allow auditd_t self:netlink_audit_socket create_netlink_socket_perms;
-allow auditd_t self:capability { audit_write audit_control };
-allow auditd_t sysadm_tty_device_t:chr_file rw_file_perms;
 allow auditd_t self:unix_dgram_socket create_socket_perms;
+allow auditd_t self:capability { audit_write audit_control sys_nice };
 allow auditd_t etc_t:file { getattr read };
 
 # Don't use logdir_domain since this is a security file
@@ -23,12 +21,29 @@
 allow auditd_t auditd_log_t:dir { setattr rw_dir_perms };
 
 can_exec(auditd_t, init_exec_t)
-allow auditd_t auditd_etc_t:file r_file_perms;
 
+can_exec(auditd_t, init_exec_t)
+allow auditd_t initctl_t:fifo_file write;
+
+type auditctl_t, domain, privlog;
+type auditctl_exec_t, file_type, sysadmfile;
+uses_shlib(auditctl_t)
+allow auditctl_t self:netlink_audit_socket create_netlink_socket_perms;
+allow auditctl_t self:capability { audit_write audit_control };
+allow auditctl_t etc_t:file { getattr read };
+allow auditctl_t admin_tty_type:chr_file rw_file_perms;
+
+type auditd_etc_t, file_type, secure_file_type;
+allow { auditd_t auditctl_t } auditd_etc_t:file r_file_perms;
+
+role secadm_r types auditctl_t;
+role sysadm_r types auditctl_t;
 audit_manager_domain(secadm_t)
 
 ifdef(`separate_secadm', `', `
 audit_manager_domain(sysadm_t)
 ')
-can_exec(auditd_t, init_exec_t)
-allow auditd_t initctl_t:fifo_file write;
+dontaudit auditctl_t local_login_t:fd use;
+allow auditctl_t proc_t:dir search;
+allow auditctl_t sysctl_kernel_t:dir search;
+allow auditctl_t sysctl_kernel_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.11/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.11/domains/program/unused/cups.te	2005-04-15 14:26:15.000000000 -0400
@@ -254,4 +254,5 @@
 can_unix_connect(cupsd_t, initrc_t)
 allow cupsd_t initrc_t:dbus send_msg;
 allow initrc_t cupsd_t:dbus send_msg;
+allow cupsd_t unconfined_t:dbus send_msg;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.23.11/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/unused/dhcpc.te	2005-04-20 15:15:39.000000000 -0400
@@ -17,7 +17,7 @@
 #
 type dhcpc_port_t, port_type, reserved_port_type;
 
-daemon_domain(dhcpc)
+daemon_domain(dhcpc, `, privuser')
 
 # for SSP
 allow dhcpc_t urandom_device_t:chr_file read;
@@ -39,6 +39,7 @@
 ')
 ifdef(`nscd.te', `
 domain_auto_trans(dhcpc_t, nscd_exec_t, nscd_t)
+allow dhcpc_t nscd_var_run_t:file { getattr read };
 ')
 ifdef(`cardmgr.te', `
 domain_auto_trans(cardmgr_t, dhcpc_exec_t, dhcpc_t)
@@ -88,7 +89,6 @@
 
 # Use capabilities
 allow dhcpc_t self:capability { dac_override fsetid net_admin net_raw net_bind_service sys_resource sys_tty_config };
-dontaudit dhcpc_t self:capability sys_admin;
 
 # for access("/etc/bashrc", X_OK) on Red Hat
 dontaudit dhcpc_t self:capability { dac_read_search sys_module };
@@ -120,14 +119,14 @@
 allow dhcpc_t var_lib_t:dir search;
 file_type_auto_trans(dhcpc_t, dhcp_state_t, dhcpc_state_t, file)
 
-allow dhcpc_t bin_t:dir search;
+allow dhcpc_t bin_t:dir { getattr search };
 allow dhcpc_t bin_t:lnk_file read;
 can_exec(dhcpc_t, { bin_t shell_exec_t })
 
 ifdef(`hostname.te', `
 domain_auto_trans(dhcpc_t, hostname_exec_t, hostname_t)
 ')
-dontaudit dhcpc_t { ttyfile ptyfile tty_device_t }:chr_file { read write };
+dontaudit dhcpc_t { ttyfile ptyfile tty_device_t }:chr_file rw_file_perms;
 allow dhcpc_t { userdomain kernel_t }:fd use;
 
 allow dhcpc_t home_root_t:dir search;
@@ -143,7 +142,10 @@
 can_exec(dhcpc_t, initrc_exec_t)
 ifdef(`ypbind.te', `
 domain_auto_trans(dhcpc_t, ypbind_exec_t, ypbind_t)
+allow dhcpc_t ypbind_var_run_t:file r_file_perms;
 ')
 ifdef(`ntpd.te', `
 domain_auto_trans(dhcpc_t, ntpd_exec_t, ntpd_t)
 ')
+role sysadm_r types dhcpc_t;
+domain_auto_trans(sysadm_t, dhcpc_exec_t, dhcpc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/prelink.te policy-1.23.11/domains/program/unused/prelink.te
--- nsapolicy/domains/program/unused/prelink.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.11/domains/program/unused/prelink.te	2005-04-15 18:15:23.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # prelink_exec_t is the type of the prelink executable.
 #
-daemon_base_domain(prelink, `, admin')
+daemon_base_domain(prelink, `, admin, privowner')
 
 if (allow_execmem) {
 allow prelink_t self:process execmem;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.23.11/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/domains/program/unused/udev.te	2005-04-20 15:36:54.000000000 -0400
@@ -33,6 +33,7 @@
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
+allow udev_t device_t:file rw_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
 allow udev_t device_t:lnk_file create_lnk_perms;
 allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/auditd.fc policy-1.23.11/file_contexts/program/auditd.fc
--- nsapolicy/file_contexts/program/auditd.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.11/file_contexts/program/auditd.fc	2005-04-19 13:37:34.000000000 -0400
@@ -1,5 +1,5 @@
 # auditd
-/sbin/auditctl		--	system_u:object_r:auditd_exec_t
+/sbin/auditctl		--	system_u:object_r:auditctl_exec_t
 /sbin/auditd		--	system_u:object_r:auditd_exec_t
 /var/log/audit.log 	-- 	system_u:object_r:auditd_log_t
 /var/log/audit(/.*)?  	 	system_u:object_r:auditd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/i18n_input.fc policy-1.23.11/file_contexts/program/i18n_input.fc
--- nsapolicy/file_contexts/program/i18n_input.fc	2005-04-20 15:40:35.000000000 -0400
+++ policy-1.23.11/file_contexts/program/i18n_input.fc	2005-04-19 13:41:08.000000000 -0400
@@ -1,7 +1,7 @@
 # i18n_input.fc
 /usr/sbin/htt                   --     system_u:object_r:i18n_input_exec_t
 /usr/sbin/htt_server            --     system_u:object_r:i18n_input_exec_t
-/usr/sbin/iiimd		        --     system_u:object_r:i18n_input_exec_t
+/usr/bin/iiimd		        --     system_u:object_r:i18n_input_exec_t
 /usr/bin/httx                   --     system_u:object_r:i18n_input_exec_t
 /usr/bin/htt_xbe                --     system_u:object_r:i18n_input_exec_t
 /usr/lib(64)?/im/.*\.so.*       --     system_u:object_r:shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/traceroute.fc policy-1.23.11/file_contexts/program/traceroute.fc
--- nsapolicy/file_contexts/program/traceroute.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.11/file_contexts/program/traceroute.fc	2005-04-20 15:28:25.000000000 -0400
@@ -1,5 +1,8 @@
 # traceroute
 /bin/traceroute.*	--	system_u:object_r:traceroute_exec_t
+/bin/tracepath.*	--	system_u:object_r:traceroute_exec_t
+/sbin/rdisc		--	system_u:object_r:traceroute_exec_t
+/sbin/arping		--	system_u:object_r:traceroute_exec_t
 /usr/(s)?bin/traceroute.* --	system_u:object_r:traceroute_exec_t
 /usr/bin/lft		--	system_u:object_r:traceroute_exec_t
 /usr/bin/nmap		--	system_u:object_r:traceroute_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.23.11/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/file_contexts/program/udev.fc	2005-04-15 15:16:26.000000000 -0400
@@ -3,6 +3,7 @@
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /sbin/start_udev --	system_u:object_r:udev_exec_t
+/sbin/udevstart  --	system_u:object_r:udev_exec_t
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
 /etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.23.11/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/macros/program/ypbind_macros.te	2005-04-20 12:59:45.000000000 -0400
@@ -1,10 +1,12 @@
 
 define(`uncond_can_ypbind', `
-dontaudit $1 reserved_port_type:{ tcp_socket udp_socket } name_bind;
 can_network($1)
 r_dir_file($1,var_yp_t)
 allow $1 { reserved_port_t port_t }:{ tcp_socket udp_socket } name_bind;
+allow $1 { portmap_port_t reserved_port_t port_t }:tcp_socket name_connect;
 dontaudit $1 self:capability net_bind_service;
+dontaudit $1 reserved_port_type:tcp_socket name_connect;
+dontaudit $1 reserved_port_type:{ tcp_socket udp_socket } name_bind;
 ')
 
 define(`can_ypbind', `
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/compat.te policy-1.23.11/targeted/domains/program/compat.te
--- nsapolicy/targeted/domains/program/compat.te	2005-04-20 08:58:43.000000000 -0400
+++ policy-1.23.11/targeted/domains/program/compat.te	2005-04-20 12:55:32.000000000 -0400
@@ -1,7 +1,6 @@
 typealias sbin_t alias setfiles_exec_t;
 typealias bin_t alias mount_exec_t;
 typealias sbin_t alias restorecon_exec_t;
-typealias bin_t alias hostname_exec_t;
 typealias sbin_t alias consoletype_exec_t;
 typealias bin_t alias loadkeys_exec_t;
 typealias bin_t alias dmesg_exec_t;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.11/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/tunables/distro.tun	2005-04-14 15:20:16.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.11/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/tunables/tunable.tun	2005-04-14 15:21:06.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,11 +20,11 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------080406030503000806000407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
