Message-ID: <42DD6CBE.7090506@redhat.com>
Date: Tue, 19 Jul 2005 17:12:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------090809050306060306030504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090809050306060306030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allow fsadm_t to look at console_device
Dontaudit system_crond_t looking at removable_t.  We are removing access 
to removable_t devices from userspace for mls
policy to help get lspp approval.

Allow getty to run pppd


initrc needs to write to default_t while booting.

Change insmod to nscd_client_domain

Apm needs more access to proc_t

Lots of fixes for cvs domain.

Cyrus needs access to mail spool directotry

Add disable booleans to evolution and thunderbird.  (Both are still a 
pain to run under strict policy.  OpenOffice launch is painfull)

Hal needs to run umount

Hotplug requires sys_rawio

Kudzu needs additional access

Mailer needs to getattr random devices

Network manager needs to communicate with userspace via dbus.
Also needs read access to dhcpc info

remove user_ping boolean from targeted policy (not used)

Lots of fixes for pppd and added pptp domain

Squid and windbind_helper need to communicate

udev needs sys_rawio, and to be able to write to sysfs_t

Additional rules to get vpnc to run under strict policy

Open office has some more texrel_shlib_t files

Add hugetlbfs and mqueue file systems

Many fixes for strict policy gnome, gnome_vfs, thunderbird, evolution

Add isakmp_port for vpnc

Remove user_can_mount tunable.















-- 



--------------090809050306060306030504
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.25.3/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.3/domains/program/crond.te	2005-07-19 15:41:44.000000000 -0400
@@ -201,7 +201,7 @@
 r_dir_file(system_crond_t, file_context_t)
 can_getsecurity(system_crond_t)
 }
-allow system_crond_t removable_t:filesystem getattr;
+dontaudit system_crond_t removable_t:filesystem getattr;
 #
 # Required for webalizer
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.25.3/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.3/domains/program/fsadm.te	2005-07-19 15:41:44.000000000 -0400
@@ -102,7 +102,7 @@
 allow fsadm_t kernel_t:system syslog_console;
 
 # Access terminals.
-allow fsadm_t { initrc_devpts_t admin_tty_type devtty_t }:chr_file rw_file_perms;
+allow fsadm_t { initrc_devpts_t admin_tty_type devtty_t console_device_t }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
 allow fsadm_t privfd:fd use;
 allow fsadm_t devpts_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.25.3/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2005-07-12 08:50:42.000000000 -0400
+++ policy-1.25.3/domains/program/getty.te	2005-07-19 15:41:44.000000000 -0400
@@ -29,7 +29,7 @@
 read_locale(getty_t)
 
 # Run login in local_login_t domain.
-allow getty_t bin_t:dir search;
+allow getty_t { sbin_t bin_t }:dir search;
 domain_auto_trans(getty_t, login_exec_t, local_login_t)
 
 # Write to /var/run/utmp.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.25.3/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.3/domains/program/ifconfig.te	2005-07-19 15:41:44.000000000 -0400
@@ -36,6 +36,7 @@
 # Use capabilities.
 allow ifconfig_t self:capability net_admin;
 dontaudit ifconfig_t self:capability sys_module;
+allow ifconfig_t self:capability sys_tty_config;
 
 # Inherit and use descriptors from init.
 allow ifconfig_t { kernel_t init_t }:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.25.3/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.3/domains/program/initrc.te	2005-07-19 15:41:44.000000000 -0400
@@ -123,7 +123,7 @@
 allow initrc_t file_t:dir { read search getattr mounton };
 
 # during boot up initrc needs to do the following
-allow initrc_t default_t:dir { read search getattr mounton };
+allow initrc_t default_t:dir { write read search getattr mounton };
 
 # rhgb-console writes to ramfs
 allow initrc_t ramfs_t:fifo_file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.25.3/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.3/domains/program/modutil.te	2005-07-19 15:41:44.000000000 -0400
@@ -72,7 +72,7 @@
 # Rules for the insmod_t domain.
 #
 
-type insmod_t, domain, privlog, sysctl_kernel_writer, privmem, privsysmod ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule' ), mlsfilewrite
+type insmod_t, domain, privlog, sysctl_kernel_writer, privmem, privsysmod ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule' ), mlsfilewrite, nscd_client_domain
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.25.3/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/domains/program/unused/apmd.te	2005-07-19 15:41:44.000000000 -0400
@@ -23,7 +23,7 @@
 allow apm_t device_t:dir search;
 allow apm_t self:capability { dac_override sys_admin };
 allow apm_t proc_t:dir search;
-allow apm_t proc_t:file { read getattr };
+allow apm_t proc_t:file r_file_perms;
 allow apm_t fs_t:filesystem getattr;
 allow apm_t apm_bios_t:chr_file rw_file_perms;
 role sysadm_r types apm_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cvs.te policy-1.25.3/domains/program/unused/cvs.te
--- nsapolicy/domains/program/unused/cvs.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.25.3/domains/program/unused/cvs.te	2005-07-19 15:41:44.000000000 -0400
@@ -12,5 +12,15 @@
 #
 
 inetd_child_domain(cvs, tcp)
+typeattribute cvs_t privmail;
+typeattribute cvs_t auth_chkpwd;
+
 type cvs_data_t, file_type, sysadmfile;
 create_dir_file(cvs_t, cvs_data_t)
+can_exec(cvs_t, { bin_t sbin_t shell_exec_t })
+allow cvs_t etc_runtime_t:file { getattr read };
+allow system_mail_t cvs_data_t:file { getattr read };
+dontaudit cvs_t devtty_t:chr_file { read write };
+allow cvs_t default_t:dir search;
+allow cvs_t default_t:lnk_file read;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.25.3/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/domains/program/unused/cyrus.te	2005-07-19 15:41:44.000000000 -0400
@@ -40,4 +40,5 @@
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
 ')
 create_dir_file(cyrus_t, mail_spool_t)
+allow cyrus_t var_spool_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/evolution.te policy-1.25.3/domains/program/unused/evolution.te
--- nsapolicy/domains/program/unused/evolution.te	2005-07-05 15:25:46.000000000 -0400
+++ policy-1.25.3/domains/program/unused/evolution.te	2005-07-19 15:41:44.000000000 -0400
@@ -11,3 +11,4 @@
 type evolution_exchange_exec_t, file_type, exec_type, sysadmfile;
 
 # Everything else is in macros/evolution_macros.te
+bool disable_evolution_trans false;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.25.3/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/domains/program/unused/hald.te	2005-07-19 15:41:44.000000000 -0400
@@ -96,3 +96,7 @@
 allow unconfined_t hald_t:dbus send_msg;
 allow hald_t unconfined_t:dbus send_msg;
 ')
+ifdef(`mount.te', `
+domain_auto_trans(hald_t, mount_exec_t, mount_t)
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.25.3/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/domains/program/unused/hotplug.te	2005-07-19 15:41:44.000000000 -0400
@@ -128,7 +128,7 @@
 # Read /usr/lib/gconv/.*
 allow hotplug_t lib_t:file { getattr read };
 
-allow hotplug_t self:capability { net_admin sys_tty_config mknod };
+allow hotplug_t self:capability { net_admin sys_tty_config mknod sys_rawio };
 allow hotplug_t sysfs_t:dir { getattr read search write };
 allow hotplug_t sysfs_t:file rw_file_perms;
 allow hotplug_t sysfs_t:lnk_file { getattr read };
@@ -159,3 +159,4 @@
 allow { insmod_t kernel_t } hotplug_etc_t:dir { search getattr };
 allow hotplug_t self:netlink_route_socket r_netlink_socket_perms;
 
+dontaudit hotplug_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.25.3/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.3/domains/program/unused/kudzu.te	2005-07-19 15:41:44.000000000 -0400
@@ -20,7 +20,7 @@
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-allow kudzu_t modules_conf_t:file { getattr read };
+allow kudzu_t modules_conf_t:file { getattr read unlink };
 allow kudzu_t modules_object_t:dir r_dir_perms;
 allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
 allow kudzu_t mouse_device_t:chr_file { read write };
@@ -38,7 +38,7 @@
 allow kudzu_t usbdevfs_t:file { getattr read };
 allow kudzu_t usbfs_t:dir search;
 allow kudzu_t usbfs_t:file { getattr read };
-allow kudzu_t var_t:dir search;
+var_run_domain(kudzu)
 allow kudzu_t kernel_t:system syslog_console;
 allow kudzu_t self:udp_socket { create ioctl };
 allow kudzu_t var_lock_t:dir search;
@@ -109,3 +109,4 @@
 
 allow kudzu_t initrc_t:unix_stream_socket connectto;
 allow kudzu_t net_conf_t:file { getattr read };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lvm.te policy-1.25.3/domains/program/unused/lvm.te
--- nsapolicy/domains/program/unused/lvm.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.3/domains/program/unused/lvm.te	2005-07-19 15:41:44.000000000 -0400
@@ -97,7 +97,7 @@
 read_locale(lvm_t)
 
 # LVM (vgscan) scans for devices by stating every file in /dev and applying a regex...
-dontaudit lvm_t device_type:{ chr_file blk_file } getattr;
+dontaudit lvm_t device_type:{ chr_file blk_file } { getattr read };
 dontaudit lvm_t ttyfile:chr_file getattr;
 dontaudit lvm_t device_t:{ fifo_file dir chr_file blk_file } getattr;
 dontaudit lvm_t devpts_t:dir { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.25.3/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.3/domains/program/unused/mta.te	2005-07-19 15:41:44.000000000 -0400
@@ -71,4 +71,4 @@
 allow mta_delivery_agent { etc_runtime_t proc_t }:file { getattr read };
 
 allow system_mail_t etc_runtime_t:file { getattr read };
-allow system_mail_t { random_device_t urandom_device_t }:chr_file read;
+allow system_mail_t { random_device_t urandom_device_t }:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.25.3/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.3/domains/program/unused/NetworkManager.te	2005-07-19 15:41:44.000000000 -0400
@@ -62,6 +62,8 @@
 allow NetworkManager_t unconfined_t:dbus send_msg;
 allow unconfined_t NetworkManager_t:dbus send_msg;
 ')
+allow NetworkManager_t userdomain:dbus send_msg;
+allow userdomain NetworkManager_t:dbus send_msg;
 ')
 
 allow NetworkManager_t usr_t:file { getattr read };
@@ -98,3 +100,9 @@
 domain_auto_trans(NetworkManager_t, vpnc_exec_t, vpnc_t)
 ')
 
+ifdef(`dhcpc.te', `
+allow NetworkManager_t dhcp_state_t:dir search;
+allow NetworkManager_t dhcpc_var_run_t:file { getattr read unlink };
+')
+allow NetworkManager_t var_lib_t:dir search;
+dontaudit NetworkManager_t user_tty_type:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.25.3/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/domains/program/unused/pamconsole.te	2005-07-19 15:41:44.000000000 -0400
@@ -19,7 +19,7 @@
 allow pam_console_t self:capability { chown fowner fsetid };
 
 # Allow access to /dev/console through the fd:
-allow pam_console_t console_device_t:chr_file { read write };
+allow pam_console_t console_device_t:chr_file { read write setattr };
 allow pam_console_t { kernel_t init_t }:fd use;
 
 # for /var/run/console.lock checking
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.25.3/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/domains/program/unused/ping.te	2005-07-19 15:41:44.000000000 -0400
@@ -17,6 +17,7 @@
 in_user_role(ping_t)
 type ping_exec_t, file_type, sysadmfile, exec_type;
 
+ifdef(`targeted_policy', `', `
 bool user_ping false;
 
 if (user_ping) {
@@ -25,6 +26,7 @@
 	allow ping_t { ttyfile ptyfile }:chr_file rw_file_perms;
 	ifdef(`gnome-pty-helper.te', `allow ping_t gphdomain:fd use;')
 }
+')
 
 # Transition into this domain when you run this program.
 domain_auto_trans(sysadm_t, ping_exec_t, ping_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.25.3/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/domains/program/unused/postgresql.te	2005-07-19 15:41:44.000000000 -0400
@@ -67,6 +67,7 @@
 can_tcp_connect(userdomain, postgresql_t)
 allow userdomain postgresql_t:unix_stream_socket connectto;
 allow userdomain postgresql_var_run_t:sock_file write;
+allow userdomain postgresql_tmp_t:sock_file write;
 }
 ')
 ifdef(`consoletype.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.25.3/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.3/domains/program/unused/pppd.te	2005-07-19 15:41:44.000000000 -0400
@@ -32,9 +32,12 @@
 log_domain(pppd)
 
 # Use the network.
-can_network_server(pppd_t)
+can_network(pppd_t)
 can_ypbind(pppd_t)
 
+allow pppd_t fingerd_port_t:tcp_socket name_connect;
+
+
 # Use capabilities.
 allow pppd_t self:capability { net_admin setuid setgid fsetid fowner net_raw dac_override };
 lock_domain(pppd)
@@ -52,6 +55,8 @@
 
 # allow running ip-up and ip-down scripts and running chat.
 can_exec(pppd_t, { shell_exec_t bin_t sbin_t etc_t ifconfig_exec_t })
+can_exec(pppd_t, pppd_etc_rw_t)
+can_exec(pppd_t, hostname_exec_t)
 allow pppd_t { bin_t sbin_t }:dir search;
 allow pppd_t { sbin_t bin_t }:lnk_file read;
 
@@ -110,3 +115,25 @@
 domain_auto_trans(pppd_t, insmod_exec_t, insmod_t)
 ')
 }
+domain_auto_trans(pppd_t, named_exec_t, named_t)
+
+daemon_domain(pptp)
+can_network_client_tcp(pptp_t)
+allow pptp_t { reserved_port_type port_t }:tcp_socket name_connect;
+can_exec(pptp_t, hostname_exec_t)
+domain_auto_trans(pppd_t, pptp_exec_t, pptp_t)
+allow pptp_t self:rawip_socket create_socket_perms;
+allow pptp_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow pptp_t self:unix_dgram_socket create_socket_perms;
+can_exec(pptp_t, pppd_etc_rw_t)
+allow pptp_t devpts_t:chr_file ioctl;
+r_dir_file(pptp_t, pppd_etc_rw_t)
+r_dir_file(pptp_t, pppd_etc_t)
+allow pptp_t devpts_t:dir search;
+allow pppd_t devpts_t:chr_file ioctl;
+allow pppd_t pptp_t:process signal;
+allow pptp_t self:capability net_raw;
+allow pptp_t self:fifo_file { read write };
+allow pptp_t ptmx_t:chr_file rw_file_perms;
+log_domain(pptp)
+allow pptp_t pppd_log_t:file append;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.25.3/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.25.3/domains/program/unused/rlogind.te	2005-07-19 15:41:44.000000000 -0400
@@ -35,3 +35,4 @@
 allow rlogind_t default_t:dir search;
 typealias rlogind_port_t alias rlogin_port_t;
 read_sysctl(rlogind_t);
+allow rlogind_t krb5_keytab_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.25.3/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/domains/program/unused/squid.te	2005-07-19 15:41:44.000000000 -0400
@@ -80,4 +80,5 @@
 r_dir_file(squid_t, cert_t)
 ifdef(`winbind.te', `
 domain_auto_trans(squid_t, winbind_helper_exec_t, winbind_helper_t)
+allow winbind_helper_t squid_t:tcp_socket rw_socket_perms;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/thunderbird.te policy-1.25.3/domains/program/unused/thunderbird.te
--- nsapolicy/domains/program/unused/thunderbird.te	2005-07-05 15:25:47.000000000 -0400
+++ policy-1.25.3/domains/program/unused/thunderbird.te	2005-07-19 15:41:44.000000000 -0400
@@ -7,3 +7,4 @@
 type thunderbird_exec_t, file_type, exec_type, sysadmfile;
 
 # Everything else is in macros/thunderbird_macros.te
+bool disable_thunderbird_trans false;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.25.3/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/domains/program/unused/udev.te	2005-07-19 15:41:44.000000000 -0400
@@ -28,11 +28,12 @@
 type udev_tdb_t, file_type, sysadmfile, dev_fs;
 typealias udev_tdb_t alias udev_tbl_t;
 file_type_auto_trans(udev_t, device_t, udev_tdb_t, file)
-allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin };
+allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin sys_rawio };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
+allow udev_t self:netlink_kobject_uevent_socket { create bind read }; 
 allow udev_t device_t:file { unlink rw_file_perms };
 allow udev_t device_t:sock_file create_file_perms;
 allow udev_t device_t:lnk_file create_lnk_perms;
@@ -53,7 +54,7 @@
 allow udev_t bin_t:lnk_file read;
 can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
 can_exec(udev_t, udev_exec_t)
-r_dir_file(udev_t, sysfs_t)
+rw_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 
 # to read the file_contexts file
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.25.3/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2005-04-27 10:28:54.000000000 -0400
+++ policy-1.25.3/domains/program/unused/vpnc.te	2005-07-19 15:41:44.000000000 -0400
@@ -10,13 +10,15 @@
 # vpnc_t is the domain for the vpnc program.
 # vpnc_exec_t is the type of the vpnc executable.
 #
-daemon_domain(vpnc)
+daemon_domain(vpnc, `, sysctl_net_writer')
 
 allow vpnc_t { random_device_t urandom_device_t }:chr_file read;
 
 # Use the network.
 can_network(vpnc_t)
 allow vpnc_t port_type:tcp_socket name_connect;
+allow vpnc_t isakmp_port_t:udp_socket name_bind;
+
 can_ypbind(vpnc_t)
 allow vpnc_t self:socket create_socket_perms;
 
@@ -29,14 +31,23 @@
 allow vpnc_t self:rawip_socket create_socket_perms;
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
-allow vpnc_t admin_tty_type:chr_file rw_file_perms;
+allow vpnc_t { user_tty_type admin_tty_type }:chr_file rw_file_perms;
 allow vpnc_t port_t:udp_socket name_bind;
 allow vpnc_t etc_runtime_t:file { getattr read };
 allow vpnc_t proc_t:file { getattr read };
 dontaudit vpnc_t selinux_config_t:dir search;
 can_exec(vpnc_t, {bin_t sbin_t ifconfig_exec_t shell_exec_t })
 allow vpnc_t sysctl_net_t:dir search;
+allow vpnc_t sysctl_net_t:file write;
 allow vpnc_t sbin_t:dir search;
 allow vpnc_t bin_t:dir search;
 allow vpnc_t bin_t:lnk_file read;
 r_dir_file(vpnc_t, proc_net_t)
+tmp_domain(vpnc)
+allow vpnc_t self:fifo_file { getattr ioctl read write };
+allow vpnc_t self:file { getattr read };
+allow vpnc_t self:netlink_route_socket rw_netlink_socket_perms;
+file_type_auto_trans(vpnc_t, etc_t, net_conf_t, file)
+allow vpnc_t etc_t:file { execute execute_no_trans ioctl };
+allow vpnc_t user_home_dir_t:dir search;
+allow vpnc_t user_home_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.25.3/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.3/domains/program/unused/winbind.te	2005-07-19 15:41:44.000000000 -0400
@@ -37,6 +37,7 @@
 allow initrc_t winbind_var_run_t:file r_file_perms;
 
 application_domain(winbind_helper, `, nscd_client_domain')
+role system_r types winbind_helper_t;
 access_terminal(winbind_helper_t, sysadm)
 read_locale(winbind_helper_t) 
 r_dir_file(winbind_helper_t, samba_etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.25.3/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/file_contexts/distros.fc	2005-07-19 15:41:44.000000000 -0400
@@ -84,15 +84,21 @@
 /usr/lib/libSDL-.*\.so.*			-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/modules/dri/.*\.so		-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libOSMesa\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/X11R6/lib/libfglrx_gamma\.so.* 		--  system_u:object_r:texrel_shlib_t
 /usr/lib/libHermes\.so.*			-- system_u:object_r:texrel_shlib_t
 /usr/lib/valgrind/hp2ps				-- system_u:object_r:texrel_shlib_t
 /usr/lib/valgrind/stage2			-- system_u:object_r:texrel_shlib_t
 /usr/lib/valgrind/vg.*\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/program(/.*)?			system_u:object_r:bin_t
+/usr/lib/.*/program/.*\.so.*			system_u:object_r:shlib_t
 /usr/lib/.*/program/libicudata\.so.*		-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libsts645li\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libvclplug_gen645li\.so	-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libwrp645li\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libswd680li\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib(64)?/.*/program/librecentfile\.so 	--  system_u:object_r:texrel_shlib_t
+/usr/lib(64)?/.*/program/libsvx680li\.so	--  system_u:object_r:texrel_shlib_t
+/usr/lib(64)?/.*/program/libcomphelp4gcc3\.so  	--  system_u:object_r:texrel_shlib_t
 
 # Fedora Extras packages: ladspa, imlib2, ocaml
 /usr/lib/ladspa/analogue_osc_1416\.so		-- system_u:object_r:texrel_shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pppd.fc policy-1.25.3/file_contexts/program/pppd.fc
--- nsapolicy/file_contexts/program/pppd.fc	2005-06-01 06:11:22.000000000 -0400
+++ policy-1.25.3/file_contexts/program/pppd.fc	2005-07-19 15:41:44.000000000 -0400
@@ -1,5 +1,6 @@
 # pppd
 /usr/sbin/pppd		--	system_u:object_r:pppd_exec_t
+/usr/sbin/pptp 		--	system_u:object_r:pptp_exec_t
 /usr/sbin/ipppd		--	system_u:object_r:pppd_exec_t
 /dev/ppp		-c	system_u:object_r:ppp_device_t
 /dev/pppox.*		-c	system_u:object_r:ppp_device_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/vpnc.fc policy-1.25.3/file_contexts/program/vpnc.fc
--- nsapolicy/file_contexts/program/vpnc.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.3/file_contexts/program/vpnc.fc	2005-07-19 15:41:44.000000000 -0400
@@ -1,3 +1,4 @@
 # vpnc
 /usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
 /sbin/vpnc		--	system_u:object_r:vpnc_exec_t
+/etc/vpnc/vpnc-script	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.25.3/genfs_contexts
--- nsapolicy/genfs_contexts	2005-05-07 00:41:08.000000000 -0400
+++ policy-1.25.3/genfs_contexts	2005-07-19 15:41:44.000000000 -0400
@@ -92,6 +92,9 @@
 genfscon afs /				system_u:object_r:nfs_t
 
 genfscon debugfs /			system_u:object_r:debugfs_t
+genfscon inotifyfs /			system_u:object_r:inotifyfs_t
+genfscon hugetlbfs /			system_u:object_r:hugetlbfs_t
+genfscon mqueue /			system_u:object_r:mqueue_t
 
 # needs more work
 genfscon eventpollfs / system_u:object_r:eventpollfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.25.3/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/macros/admin_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -32,6 +32,7 @@
 
 # Inherit rules for ordinary users.
 base_user_domain($1)
+access_removable_media($1_t)
 
 allow $1_t self:capability setuid;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.25.3/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/macros/base_user_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -101,18 +101,6 @@
 r_dir_file($1_t, default_context_t)
 r_dir_file($1_t, file_context_t)
 
-can_exec($1_t, { removable_t noexattrfile } )
-if (user_rw_noexattrfile) {
-create_dir_file($1_t, noexattrfile)
-create_dir_file($1_t, removable_t)
-# Write floppies 
-allow $1_t removable_device_t:blk_file rw_file_perms;
-allow $1_t usbtty_device_t:chr_file write;
-} else {
-r_dir_file($1_t, noexattrfile)
-r_dir_file($1_t, removable_t)
-allow $1_t removable_device_t:blk_file r_file_perms;
-}
 allow $1_t usbtty_device_t:chr_file read;
 
 # GNOME checks for usb and other devices
@@ -342,7 +330,6 @@
 
 # Get attributes of file systems.
 allow $1_t fs_type:filesystem getattr;
-allow $1_t removable_t:filesystem getattr;
 
 # Read and write /dev/tty and /dev/null.
 allow $1_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/content_macros.te policy-1.25.3/macros/content_macros.te
--- nsapolicy/macros/content_macros.te	2005-07-05 15:25:48.000000000 -0400
+++ policy-1.25.3/macros/content_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -55,7 +55,10 @@
 ifelse($3, `', `', 
 `if ($3_read_content) {')
 allow $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
-r_dir_file($1, { removable_t $2_tmp_t $2_home_t } )
+r_dir_file($1, { $2_tmp_t $2_home_t } )
+ifdef(`mls_policy', `', `
+r_dir_file($1, removable_t)
+')
 
 ifelse($3, `', `', 
 `} else {
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.25.3/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/macros/global_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -708,3 +708,22 @@
 ')
 
 ')dnl end unconfined_domain
+
+
+define(`access_removable_media', `
+
+can_exec($1, { removable_t noexattrfile } )
+if (user_rw_noexattrfile) {
+create_dir_file($1, noexattrfile)
+create_dir_file($1, removable_t)
+# Write floppies 
+allow $1 removable_device_t:blk_file rw_file_perms;
+allow $1 usbtty_device_t:chr_file write;
+} else {
+r_dir_file($1, noexattrfile)
+r_dir_file($1, removable_t)
+allow $1 removable_device_t:blk_file r_file_perms;
+}
+allow $1 removable_t:filesystem getattr;
+
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.25.3/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2005-05-02 14:06:57.000000000 -0400
+++ policy-1.25.3/macros/program/cdrecord_macros.te	2005-07-19 15:43:50.000000000 -0400
@@ -47,8 +47,11 @@
 allow $1_cdrecord_t removable_device_t:blk_file { getattr read write ioctl };
 allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write ioctl };
 
-allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
+allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid dac_override sys_rawio };
 allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill };
-
+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+allow $1_cdrecord_t $1_home_t:dir search;
+allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
+allow $1_cdrecord_t $1_home_t:file r_file_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/evolution_macros.te policy-1.25.3/macros/program/evolution_macros.te
--- nsapolicy/macros/program/evolution_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/macros/program/evolution_macros.te	2005-07-19 15:43:41.000000000 -0400
@@ -37,7 +37,9 @@
 type $1_evolution_server_t, domain, nscd_client_domain;
 
 # Transition from user type
+if (! disable_evolution_trans) {
 domain_auto_trans($1_t, evolution_server_exec_t, $1_evolution_server_t)
+}
 role $1_r types $1_evolution_server_t;
 
 # Evolution common stuff
@@ -168,12 +170,9 @@
 domain_auto_trans($1_t, evolution_exec_t, $1_evolution_t)
 role $1_r types $1_evolution_t;
 
-# X, mail, evolution, Dbus common stuff 
+# X, mail, evolution common stuff 
 x_client_domain($1_evolution, $1)
 mail_client_domain($1_evolution, $1)
-dbusd_client(system, $1_evolution)
-dbusd_client($1, $1_evolution)
-allow $1_evolution_t $1_dbusd_t:dbus send_msg;
 gnome_file_dialog($1_evolution, $1)
 evolution_common($1_evolution, $1)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gconf_macros.te policy-1.25.3/macros/program/gconf_macros.te
--- nsapolicy/macros/program/gconf_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.3/macros/program/gconf_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -33,6 +33,7 @@
 
 ifdef(`xdm.te', `
 can_pipe_xdm($1_gconfd_t)
+allow xdm_t $1_gconfd_t:process signal;
 ')
 
 ') dnl gconf_domain
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gnome_vfs_macros.te policy-1.25.3/macros/program/gnome_vfs_macros.te
--- nsapolicy/macros/program/gnome_vfs_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.3/macros/program/gnome_vfs_macros.te	2005-07-19 15:43:32.000000000 -0400
@@ -16,6 +16,11 @@
 # GNOME, dbus
 gnome_application($1_gnome_vfs, $1)
 dbusd_client(system, $1_gnome_vfs)
+allow $1_gnome_vfs_t system_dbusd_t:dbus send_msg;
+ifdef(`hald.te', `
+allow $1_gnome_vfs_t hald_t:dbus send_msg;
+allow hald_t $1_gnome_vfs_t:dbus send_msg;
+')
 
 # Transition from user type
 domain_auto_trans($1_t, gnome_vfs_exec_t, $1_gnome_vfs_t)
@@ -34,6 +39,7 @@
 
 # Search libexec (??)
 allow $1_gnome_vfs_t bin_t:dir search;
+can_exec($1_gnome_vfs_t, bin_t)
 
 ') dnl gnome_vfs_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mail_client_macros.te policy-1.25.3/macros/program/mail_client_macros.te
--- nsapolicy/macros/program/mail_client_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/macros/program/mail_client_macros.te	2005-07-19 15:42:58.000000000 -0400
@@ -11,7 +11,9 @@
 define(`mail_client_domain', `
 
 # Allow netstat
-allow $1_t bin_t:dir search;
+# Startup shellscripts
+allow $1_t bin_t:dir r_dir_perms;
+allow $1_t bin_t:lnk_file r_file_perms;
 can_exec($1_t, bin_t)
 r_dir_file($1_t, proc_net_t)
 allow $1_t sysctl_net_t:dir search;
@@ -50,5 +52,12 @@
 can_exec($1_t, shell_exec_t)
 domain_auto_trans($1_t, mozilla_exec_t, $2_mozilla_t)
 ') 
-
+ifdef(`dbusd.te', `
+dbusd_client(system, $1)
+dbusd_client($2, $1)
+allow $1_t $2_dbusd_t:dbus send_msg;
+ifdef(`cups.te', `
+allow cupsd_t $1_t:dbus send_msg;
+') 
+') 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.25.3/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.3/macros/program/mozilla_macros.te	2005-07-19 15:43:10.000000000 -0400
@@ -130,8 +130,12 @@
 domain_auto_trans($1_mozilla_t, evolution_webcal_exec_t, $1_evolution_webcal_t)
 ') dnl if evolution.te
 
+ifdef(`thunderbird.te', `
+domain_auto_trans($1_mozilla_t, thunderbird_exec_t, $1_thunderbird_t)
+') dnl if evolution.te
+
 if (allow_execmem) {
-allow $1_mozilla_t self:process execmem;
+allow $1_mozilla_t self:process { execmem execstack };
 }
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/thunderbird_macros.te policy-1.25.3/macros/program/thunderbird_macros.te
--- nsapolicy/macros/program/thunderbird_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.3/macros/program/thunderbird_macros.te	2005-07-19 15:42:51.000000000 -0400
@@ -18,15 +18,11 @@
 type $1_thunderbird_t, domain, nscd_client_domain;
 
 # Transition from user type
+if (! disable_thunderbird_trans) {
 domain_auto_trans($1_t, thunderbird_exec_t, $1_thunderbird_t)
+}
 role $1_r types $1_thunderbird_t;
 
-# Startup shellscripts
-allow $1_thunderbird_t bin_t:dir r_dir_perms;
-allow $1_thunderbird_t bin_t:lnk_file r_file_perms;
-can_exec($1_thunderbird_t, bin_t)
-can_exec($1_thunderbird_t, shell_exec_t)
-
 # FIXME: Why does it try to do that?
 dontaudit $1_thunderbird_t evolution_exec_t:file { getattr execute };
 
@@ -42,10 +38,13 @@
 x_client_domain($1_thunderbird, $1)
 mail_client_domain($1_thunderbird, $1)
 
+allow $1_thunderbird_t fs_t:filesystem getattr;
+
 # GNOME support
 ifdef(`gnome.te', `
 gnome_application($1_thunderbird, $1)
 gnome_file_dialog($1_thunderbird, $1)
+allow $1_thunderbird_t $1_gnome_settings_t:file { read write };
 ')
 
 # Access ~/.thunderbird
@@ -54,4 +53,7 @@
 # RSS feeds
 can_network_client_tcp($1_thunderbird_t, http_port_t) 
 allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
+
+allow $1_thunderbird_t self:process { execheap execmem execstack };
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.25.3/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/macros/user_macros.te	2005-07-19 15:41:44.000000000 -0400
@@ -102,6 +102,9 @@
 ')
 
 base_user_domain($1)
+ifdef(`mls_policy', `', `
+access_removable_media($1_t)
+')
 
 # do not allow privhome access to sysadm_home_dir_t
 file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
@@ -304,21 +307,6 @@
 dontaudit $1_t init_t:fd use;
 dontaudit $1_t initrc_t:fd use;
 allow $1_t initrc_t:fifo_file write;
-ifdef(`user_can_mount', `
-#
-#  Allow users to mount file systems like floppies and cdrom
-#
-mount_domain($1, $1_mount, `, fs_domain')
-r_dir_file($1_t, mnt_t)
-allow $1_mount_t device_t:lnk_file read;
-allow $1_mount_t removable_device_t:blk_file read;
-allow $1_mount_t iso9660_t:filesystem relabelfrom;
-allow $1_mount_t removable_t:filesystem { mount relabelto };
-allow $1_mount_t removable_t:dir mounton;
-ifdef(`xdm.te', `
-can_pipe_xdm($1_mount_t)
-')
-')
 
 #
 # Rules used to associate a homedir as a mountpoint
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.25.3/net_contexts
--- nsapolicy/net_contexts	2005-07-12 08:50:42.000000000 -0400
+++ policy-1.25.3/net_contexts	2005-07-19 15:41:44.000000000 -0400
@@ -45,6 +45,7 @@
 portcon tcp 465 system_u:object_r:smtp_port_t
 portcon tcp 587 system_u:object_r:smtp_port_t
 
+portcon udp 500 system_u:object_r:isakmp_port_t
 portcon udp 53 system_u:object_r:dns_port_t
 portcon tcp 53 system_u:object_r:dns_port_t
 
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.25.3/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-06-29 16:36:19.000000000 -0400
+++ policy-1.25.3/targeted/domains/program/crond.te	2005-07-19 15:41:44.000000000 -0400
@@ -11,7 +11,7 @@
 # This domain is defined just for targeted policy.
 #
 type crond_exec_t, file_type, sysadmfile, exec_type;
-type crond_t, domain, privuser, privrole, privowner;
+type crond_t, domain, privuser, privrole, privfd, privowner;
 typealias crond_t alias system_crond_t;
 type anacron_exec_t, file_type, sysadmfile, exec_type;
 type system_crond_tmp_t, file_type, tmpfile, sysadmfile;
@@ -20,11 +20,14 @@
 role system_r types crond_t;
 domain_auto_trans(initrc_t, crond_exec_t, crond_t)
 domain_auto_trans(initrc_t, anacron_exec_t, crond_t)
-unconfined_domain(crond_t)
 # Access log files
 file_type_auto_trans(crond_t, user_home_dir_t, user_home_t)
 file_type_auto_trans(crond_t, tmp_t, system_crond_tmp_t)
+var_run_domain(crond)
+
+ifdef(`targeted_policy', `
+unconfined_domain(crond_t)
 allow crond_t initrc_t:dbus send_msg;
 allow crond_t unconfined_t:dbus send_msg;
 allow crond_t unconfined_t:process transition;
-var_run_domain(crond)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.25.3/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.3/tunables/distro.tun	2005-07-19 15:41:44.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.25.3/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-05-25 11:28:11.000000000 -0400
+++ policy-1.25.3/tunables/tunable.tun	2005-07-19 15:41:44.000000000 -0400
@@ -1,8 +1,5 @@
-# Allow users to execute the mount command
-dnl define(`user_can_mount')
-
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,7 +17,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.25.3/types/file.te
--- nsapolicy/types/file.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.3/types/file.te	2005-07-19 15:41:44.000000000 -0400
@@ -304,6 +304,12 @@
 type dosfs_t, fs_type, noexattrfile, sysadmfile;
 allow dosfs_t self:filesystem associate;
 
+type hugetlbfs_t, mount_point, fs_type,  sysadmfile;
+allow hugetlbfs_t self:filesystem associate;
+
+type mqueue_t, mount_point, fs_type,  sysadmfile;
+allow mqueue_t self:filesystem associate;
+
 # udev_runtime_t is the type of the udev table file
 type udev_runtime_t, file_type, sysadmfile;
 
@@ -316,6 +322,9 @@
 type debugfs_t, fs_type, sysadmfile;
 allow debugfs_t self:filesystem associate;
 
+type inotifyfs_t, fs_type, sysadmfile;
+allow inotifyfs_t self:filesystem associate;
+
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
 allow removable_t self:filesystem associate;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.25.3/types/network.te
--- nsapolicy/types/network.te	2005-07-12 08:50:44.000000000 -0400
+++ policy-1.25.3/types/network.te	2005-07-19 15:41:44.000000000 -0400
@@ -22,6 +22,7 @@
 type http_port_t, port_type, reserved_port_type;
 type ipp_port_t, port_type, reserved_port_type;
 type gopher_port_t, port_type, reserved_port_type;
+type isakmp_port_t, port_type, reserved_port_type;
 
 allow web_client_domain { http_cache_port_t http_port_t }:tcp_socket name_connect;
 type pop_port_t, port_type, reserved_port_type;

--------------090809050306060306030504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
