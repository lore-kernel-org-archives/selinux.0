Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j68CtJgA020768
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 08:55:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j68CquGt025386
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 12:52:56 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j68CrUjo002450
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 08:53:30 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j68CrUSV002449
	for selinux@tycho.nsa.gov; Fri, 8 Jul 2005 08:53:30 -0400
Message-ID: <42CDD2D5.6070408@redhat.com>
Date: Thu, 07 Jul 2005 21:11:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------050308080108080509080007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050308080108080509080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add boolean to allow sysadm_t to ptrace and debug apps.

Allow getty to start up pppd connections

Change to allow auth_chkpwd the audit_control capability

Stop transitioning from unconfined_t to netutils for target

fixes to make passwd and associated utilities work in targeted policy

Since Russell eliminate catman_t context, tmpreaper needs to handle man_t

Allow httpd to communicate with ldap.

Add additiona capabilities to apm and apmd.

Allow apmd to execute hwclock.

Cups needs to audit messages

Fixes for hplip and cupsd_lpd_t

Allow cyrus to bind to pop and mail ports.

Allow dovecot access to cert_t files

hald needs better access to usbfs

Hotplug needs sigpgid and to read netlink_route_sockets.

Additional fixes for pppd.

Allow prelink execheap execmem and execstack by default

Add can_winbind boolean and functions to better handle samba and winbind 
communications.

Add transitional bool functions for nfs daemons

Allow squid to communicate with winbind.

Fix file_context for /opt

Eliminate allow_execmod checks around texrel_shlib_t libraries.

Add additional ports for http














 

-- 



--------------050308080108080509080007
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/admin.te policy-1.25.1/domains/admin.te
--- nsapolicy/domains/admin.te	2005-04-27 10:28:48.000000000 -0400
+++ policy-1.25.1/domains/admin.te	2005-07-07 15:44:45.000000000 -0400
@@ -36,3 +36,8 @@
 typeattribute secadm_tty_device_t admin_tty_type;
 typeattribute secadm_devpts_t admin_tty_type;
 
+bool allow_ptrace false;
+
+if (allow_ptrace) {
+can_ptrace(sysadm_t, domain)
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.25.1/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.25.1/domains/program/getty.te	2005-07-07 15:44:45.000000000 -0400
@@ -52,3 +52,10 @@
 # for mgetty
 var_run_domain(getty)
 allow getty_t self:capability { fowner fsetid };
+
+#
+# getty needs to be able to run pppd
+#
+ifdef(`pppd.te', `
+domain_auto_trans(getty_t, pppd_exec_t, pppd_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.25.1/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/login.te	2005-07-07 15:44:45.000000000 -0400
@@ -65,7 +65,7 @@
 ')
 
 # Use capabilities
-allow $1_login_t self:capability { audit_control dac_override chown fowner fsetid kill setgid setuid net_bind_service sys_nice sys_resource sys_tty_config };
+allow $1_login_t self:capability { dac_override chown fowner fsetid kill setgid setuid net_bind_service sys_nice sys_resource sys_tty_config };
 allow $1_login_t self:process setrlimit;
 dontaudit $1_login_t sysfs_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/netutils.te policy-1.25.1/domains/program/netutils.te
--- nsapolicy/domains/program/netutils.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.25.1/domains/program/netutils.te	2005-07-07 15:44:45.000000000 -0400
@@ -21,7 +21,9 @@
 tmp_domain(netutils)
 
 domain_auto_trans(initrc_t, netutils_exec_t, netutils_t)
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, netutils_exec_t, netutils_t)
+')
 
 # Inherit and use descriptors from init.
 allow netutils_t { userdomain init_t }:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/passwd.te policy-1.25.1/domains/program/passwd.te
--- nsapolicy/domains/program/passwd.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.25.1/domains/program/passwd.te	2005-07-07 15:44:45.000000000 -0400
@@ -149,3 +149,8 @@
 allow passwd_t userdomain:process getattr;
 
 allow passwd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+
+ifdef(`targeted_policy', `
+role system_r types sysadm_passwd_t;
+allow sysadm_passwd_t devpts_t:chr_file { read write };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.25.1/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/ssh.te	2005-07-07 15:44:45.000000000 -0400
@@ -73,7 +73,7 @@
 allow $1_t port_type:tcp_socket name_connect;
 can_kerberos($1_t)
 
-allow $1_t self:capability { audit_control kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
+allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 if (use_nfs_home_dirs) {
 allow $1_t autofs_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/tmpreaper.te policy-1.25.1/domains/program/tmpreaper.te
--- nsapolicy/domains/program/tmpreaper.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.25.1/domains/program/tmpreaper.te	2005-07-07 15:44:45.000000000 -0400
@@ -16,8 +16,8 @@
 system_crond_entry(tmpreaper_exec_t, tmpreaper_t)
 uses_shlib(tmpreaper_t)
 # why does it need setattr?
-allow tmpreaper_t tmpfile:dir { setattr rw_dir_perms rmdir };
-allow tmpreaper_t tmpfile:notdevfile_class_set { getattr unlink };
+allow tmpreaper_t { man_t tmpfile }:dir { setattr rw_dir_perms rmdir };
+allow tmpreaper_t { man_t tmpfile }:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t { home_type file_t }:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t self:process { fork sigchld };
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.25.1/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/apache.te	2005-07-07 15:44:45.000000000 -0400
@@ -114,6 +114,7 @@
 can_kerberos(httpd_t)
 can_resolve(httpd_t)
 can_ypbind(httpd_t)
+can_ldap(httpd_t)
 allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;
 
 if (httpd_can_network_connect) {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.25.1/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/apmd.te	2005-07-07 15:44:45.000000000 -0400
@@ -21,7 +21,7 @@
 allow apm_t privfd:fd use;
 allow apm_t admin_tty_type:chr_file rw_file_perms;
 allow apm_t device_t:dir search;
-allow apm_t self:capability sys_admin;
+allow apm_t self:capability { dac_override sys_admin };
 allow apm_t proc_t:dir search;
 allow apm_t proc_t:file { read getattr };
 allow apm_t fs_t:filesystem getattr;
@@ -54,7 +54,7 @@
 allow apmd_t self:process getsession;
 
 # Use capabilities.
-allow apmd_t self:capability { sys_admin sys_nice sys_time };
+allow apmd_t self:capability { sys_admin sys_nice sys_time kill };
 
 # controlling an orderly resume of PCMCIA requires creating device
 # nodes 254,{0,1,2} for some reason.
@@ -69,7 +69,10 @@
 # apmd calls hwclock.sh on suspend and resume
 allow apmd_t clock_device_t:chr_file r_file_perms;
 ifdef(`hwclock.te', `
+domain_auto_trans(apmd_t, hwclock_exec_t, hwclock_t)
 allow apmd_t adjtime_t:file rw_file_perms;
+allow hwclock_t apmd_log_t:file append;
+allow hwclock_t apmd_t:unix_stream_socket { read write };
 ')
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.25.1/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.25.1/domains/program/unused/bluetooth.te	2005-07-07 15:44:45.000000000 -0400
@@ -26,7 +26,8 @@
 dbusd_client(system, bluetooth)
 allow bluetooth_t system_dbusd_t:dbus send_msg;
 ')
-allow bluetooth_t self:socket { create setopt ioctl bind listen };
+allow bluetooth_t self:socket create_stream_socket_perms;
+
 allow bluetooth_t self:unix_dgram_socket create_socket_perms;
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.25.1/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/cups.te	2005-07-07 15:44:45.000000000 -0400
@@ -77,7 +77,7 @@
 allow cupsd_t self:fifo_file rw_file_perms;
 
 # Use capabilities.
-allow cupsd_t self:capability { dac_read_search kill setgid setuid fsetid net_bind_service fowner chown dac_override sys_tty_config };
+allow cupsd_t self:capability { dac_read_search kill setgid setuid fsetid net_bind_service fowner chown dac_override sys_tty_config audit_write };
 dontaudit cupsd_t self:capability net_admin;
 
 #
@@ -125,7 +125,9 @@
 #
 # lots of errors generated requiring the following
 #
-allow cupsd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
+allow cupsd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+allow cupsd_t self:netlink_route_socket { r_netlink_socket_perms };
+
 #
 # Satisfy readahead
 #
@@ -175,6 +177,7 @@
 daemon_domain(hplip)
 etcdir_domain(hplip)
 allow hplip_t etc_t:file r_file_perms;
+allow hplip_t etc_runtime_t:file { read getattr };
 allow hplip_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t hplip_var_run_t:file { read getattr };
 allow hplip_t cupsd_etc_t:dir search;
@@ -305,4 +308,5 @@
 inetd_child_domain(cupsd_lpd)
 allow inetd_t printer_port_t:tcp_socket name_bind;
 r_dir_file(cupsd_lpd_t, cupsd_etc_t)
+r_dir_file(cupsd_lpd_t, cupsd_rw_etc_t)
 allow cupsd_lpd_t ipp_port_t:tcp_socket name_connect;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.25.1/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/cyrus.te	2005-07-07 15:44:45.000000000 -0400
@@ -26,9 +26,7 @@
 read_locale(cyrus_t)
 read_sysctl(cyrus_t)
 tmp_domain(cyrus)
-ifdef(`use_pop', `
-allow cyrus_t pop_port_t:tcp_socket name_bind;
-')
+allow cyrus_t { mail_port_t pop_port_t }:tcp_socket name_bind;
 allow cyrus_t proc_t:dir search;
 allow cyrus_t proc_t:file { getattr read };
 allow cyrus_t sysadm_devpts_t:chr_file { read write };
@@ -41,6 +39,5 @@
 allow system_crond_t cyrus_var_lib_t:dir rw_dir_perms;
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
 ')
-allow cyrus_t mail_port_t:tcp_socket name_bind;
 create_dir_file(cyrus_t, mail_spool_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.25.1/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/dhcpc.te	2005-07-07 15:44:45.000000000 -0400
@@ -153,6 +153,7 @@
 domain_auto_trans(sysadm_t, dhcpc_exec_t, dhcpc_t)
 ifdef(`dbusd.te', `
 dbusd_client(system, dhcpc)
+domain_auto_trans(system_dbusd_t, dhcpc_exec_t, dhcpc_t)
 allow dhcpc_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow dhcpc_t self:dbus send_msg;
 allow { NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.25.1/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/dovecot.te	2005-07-07 15:44:45.000000000 -0400
@@ -35,6 +35,7 @@
 allow dovecot_t urandom_device_t:chr_file { getattr read };
 allow dovecot_t cert_t:dir search;
 r_dir_file(dovecot_t, dovecot_cert_t)
+r_dir_file(dovecot_t, cert_t)
 
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.25.1/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-05-25 11:28:09.000000000 -0400
+++ policy-1.25.1/domains/program/unused/ftpd.te	2005-07-07 15:44:45.000000000 -0400
@@ -69,7 +69,7 @@
 tmpfs_domain(ftpd)
 
 # Use capabilities.
-allow ftpd_t self:capability { chown fowner fsetid setgid setuid net_bind_service sys_chroot sys_nice sys_resource audit_control };
+allow ftpd_t self:capability { chown fowner fsetid setgid setuid net_bind_service sys_chroot sys_nice sys_resource };
 
 # Append to /var/log/wtmp.
 allow ftpd_t wtmp_t:file { getattr append };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.25.1/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.1/domains/program/unused/hald.te	2005-07-07 15:44:45.000000000 -0400
@@ -65,7 +65,8 @@
 r_dir_file(hald_t, hotplug_etc_t)
 ')
 allow hald_t fs_type:dir { search getattr };
-allow hald_t { usbdevfs_t usbfs_t }:file { getattr read };
+allow hald_t usbfs_t:dir r_dir_perms;
+allow hald_t { usbdevfs_t usbfs_t }:file rw_file_perms;
 allow hald_t bin_t:lnk_file read;
 r_dir_file(hald_t, { selinux_config_t default_context_t } )
 allow hald_t initrc_t:dbus send_msg;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.25.1/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/domains/program/unused/hotplug.te	2005-07-07 15:44:45.000000000 -0400
@@ -65,7 +65,7 @@
 allow hotplug_t etc_t:dir r_dir_perms;
 allow hotplug_t etc_t:{ file lnk_file } r_file_perms;
 
-allow hotplug_t kernel_t:process sigchld;
+allow hotplug_t kernel_t:process { sigchld setpgid };
 
 ifdef(`distro_redhat', `
 allow hotplug_t var_lock_t:dir search;
@@ -157,3 +157,5 @@
 ')
 
 allow { insmod_t kernel_t } hotplug_etc_t:dir { search getattr };
+allow hotplug_t self:netlink_route_socket r_netlink_socket_perms;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hwclock.te policy-1.25.1/domains/program/unused/hwclock.te
--- nsapolicy/domains/program/unused/hwclock.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.25.1/domains/program/unused/hwclock.te	2005-07-07 15:44:45.000000000 -0400
@@ -19,9 +19,6 @@
 role sysadm_r types hwclock_t;
 domain_auto_trans(sysadm_t, hwclock_exec_t, hwclock_t)
 type adjtime_t, file_type, sysadmfile;
-ifdef(`apmd.te', `
-domain_auto_trans(apmd_t, hwclock_exec_t, hwclock_t)
-')
 
 allow hwclock_t fs_t:filesystem getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iceauth.te policy-1.25.1/domains/program/unused/iceauth.te
--- nsapolicy/domains/program/unused/iceauth.te	2005-07-05 15:25:46.000000000 -0400
+++ policy-1.25.1/domains/program/unused/iceauth.te	2005-07-07 15:44:45.000000000 -0400
@@ -6,7 +6,7 @@
 #
 # iceauth_exec_t is the type of the xauth executable.
 #
-type iceauth_exec_t, file_type, sysadmfile;
+type iceauth_exec_t, file_type, exec_type, sysadmfile;
 
 # Everything else is in the iceauth_domain macro in
 # macros/program/iceauth_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.25.1/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/nscd.te	2005-07-07 15:44:45.000000000 -0400
@@ -75,3 +75,4 @@
 allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
 log_domain(nscd)
 r_dir_file(nscd_t, cert_t)
+allow nscd_t tun_tap_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.25.1/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/pppd.te	2005-07-07 15:44:45.000000000 -0400
@@ -36,8 +36,7 @@
 can_ypbind(pppd_t)
 
 # Use capabilities.
-allow pppd_t self:capability { net_admin setuid setgid fsetid };
-
+allow pppd_t self:capability { net_admin setuid setgid fsetid fowner net_raw dac_override };
 lock_domain(pppd)
 
 # Access secret files
@@ -93,7 +92,7 @@
 # for pppoe
 can_create_pty(pppd)
 allow pppd_t self:file { read getattr };
-allow pppd_t self:capability { fowner net_raw };
+
 allow pppd_t self:packet_socket create_socket_perms;
 
 file_type_auto_trans(pppd_t, etc_t, net_conf_t, file)
@@ -101,3 +100,5 @@
 allow pppd_t sysctl_net_t:dir search;
 allow pppd_t sysctl_net_t:file r_file_perms;
 allow pppd_t self:netlink_route_socket r_netlink_socket_perms;
+allow pppd_t initrc_var_run_t:file r_file_perms;
+dontaudit pppd_t initrc_var_run_t:file { lock write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/prelink.te policy-1.25.1/domains/program/unused/prelink.te
--- nsapolicy/domains/program/unused/prelink.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.25.1/domains/program/unused/prelink.te	2005-07-07 15:44:45.000000000 -0400
@@ -11,13 +11,8 @@
 #
 daemon_base_domain(prelink, `, admin, privowner')
 
-if (allow_execmem) {
-allow prelink_t self:process execmem;
-}
-if (allow_execmod) {
+allow prelink_t self:process { execheap execmem execstack };
 allow prelink_t texrel_shlib_t:file execmod;
-}
-
 allow prelink_t fs_t:filesystem getattr;
 
 ifdef(`crond.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.25.1/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.1/domains/program/unused/procmail.te	2005-07-07 15:44:45.000000000 -0400
@@ -20,6 +20,7 @@
 allow procmail_t device_t:dir search;
 can_network_server(procmail_t)
 can_ypbind(procmail_t)
+can_winbind(procmail_t)
 
 allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radvd.te policy-1.25.1/domains/program/unused/radvd.te
--- nsapolicy/domains/program/unused/radvd.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.25.1/domains/program/unused/radvd.te	2005-07-07 15:44:45.000000000 -0400
@@ -15,11 +15,12 @@
 
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 
-allow radvd_t self:capability net_raw;
+allow radvd_t self:capability { net_raw setgid };
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
 
 can_network_server(radvd_t)
+can_ypbind(radvd_t)
 
 allow radvd_t proc_t:dir r_dir_perms;
 allow radvd_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.25.1/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/rpcd.te	2005-07-07 15:44:45.000000000 -0400
@@ -11,7 +11,11 @@
 # Rules for the rpcd_t and nfsd_t domain.
 #
 define(`rpc_domain', `
+ifdef(`targeted_policy', `
+daemon_base_domain($1, `, transitionbool')
+', `
 daemon_base_domain($1)
+')
 can_network($1_t)
 allow $1_t port_type:tcp_socket name_connect;
 can_ypbind($1_t)
@@ -114,7 +118,7 @@
 allow nfsd_t var_run_t:dir search;
 
 allow nfsd_t self:capability { sys_admin sys_resource };
-allow nfsd_t fs_t:filesystem getattr;
+allow nfsd_t fs_type:filesystem getattr;
 
 can_udp_send(nfsd_t, portmap_t)
 can_udp_send(portmap_t, nfsd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.25.1/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.25.1/domains/program/unused/rpm.te	2005-07-07 15:44:45.000000000 -0400
@@ -253,4 +253,7 @@
 typeattribute rpm_script_t auth_write;
 unconfined_domain(rpm_script_t)
 ')
+if (allow_execmem) {
+allow rpm_script_t self:process execmem;
+}
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.25.1/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/samba.te	2005-07-07 15:44:45.000000000 -0400
@@ -47,6 +47,9 @@
 
 # Use the network.
 can_network(smbd_t)
+can_ldap(smbd_t)
+can_kerberos(smbd_t)
+can_winbind(smbd_t)
 allow smbd_t ipp_port_t:tcp_socket name_connect;
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
@@ -61,8 +64,10 @@
 
 # Permissions for Samba cache files in /var/cache/samba and /var/lib/samba
 allow smbd_t var_lib_t:dir search;
-allow smbd_t samba_var_t:dir create_dir_perms;
-allow smbd_t samba_var_t:file create_file_perms;
+create_dir_file(smbd_t, samba_var_t)
+
+# Needed for shared printers
+allow smbd_t var_spool_t:dir search;
 
 # Permissions to write log files.
 allow smbd_t samba_log_t:file { create ra_file_perms };
@@ -182,3 +187,28 @@
 allow smbmount_t userdomain:fd use;
 allow smbmount_t local_login_t:fd use;
 ')
+# Derive from app. domain. Transition from mount.
+application_domain(samba_net, `, nscd_client_domain')
+file_type_auto_trans(samba_net_t, samba_etc_t, samba_secrets_t, file)
+read_locale(samba_net_t) 
+allow samba_net_t samba_etc_t:file r_file_perms;
+r_dir_file(samba_net_t, samba_var_t)
+can_network_udp(samba_net_t)
+access_terminal(samba_net_t, sysadm)
+allow samba_net_t self:unix_dgram_socket create_socket_perms;
+allow samba_net_t self:unix_stream_socket create_stream_socket_perms;
+rw_dir_create_file(samba_net_t, samba_var_t)
+allow samba_net_t etc_t:file { getattr read };
+can_network_client(samba_net_t)
+allow samba_net_t smbd_port_t:tcp_socket name_connect;
+can_ldap(samba_net_t)
+can_kerberos(samba_net_t)
+allow samba_net_t urandom_device_t:chr_file r_file_perms;
+allow samba_net_t proc_t:dir search;
+allow samba_net_t proc_t:lnk_file read;
+allow samba_net_t self:dir search;
+allow samba_net_t self:file read;
+allow samba_net_t self:process signal;
+tmp_domain(samba_net)
+dontaudit samba_net_t sysadm_home_dir_t:dir search;
+allow samba_net_t privfd:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.25.1/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/squid.te	2005-07-07 15:44:45.000000000 -0400
@@ -78,3 +78,6 @@
 #squid requires the following when run in diskd mode, the recommended setting
 allow squid_t tmpfs_t:file { read write };
 r_dir_file(squid_t, cert_t)
+ifdef(`winbind.te', `
+domain_auto_trans(squid_t, winbind_helper_exec_t, winbind_helper_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.25.1/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-05-25 11:28:10.000000000 -0400
+++ policy-1.25.1/domains/program/unused/winbind.te	2005-07-07 15:44:45.000000000 -0400
@@ -22,7 +22,7 @@
 type samba_var_t, file_type, sysadmfile;
 type samba_secrets_t, file_type, sysadmfile;
 ')
-rw_dir_file(winbind_t, samba_etc_t)
+file_type_auto_trans(winbind_t, samba_etc_t, samba_secrets_t, file)
 rw_dir_create_file(winbind_t, samba_log_t)
 allow winbind_t samba_secrets_t:file rw_file_perms;
 allow winbind_t self:unix_dgram_socket create_socket_perms;
@@ -33,3 +33,15 @@
 can_kerberos(winbind_t)
 allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow winbind_t winbind_var_run_t:sock_file create_file_perms;
+allow initrc_t winbind_var_run_t:file r_file_perms;
+
+application_domain(winbind_helper, `, nscd_client_domain')
+access_terminal(winbind_helper_t, sysadm)
+read_locale(winbind_helper_t) 
+r_dir_file(winbind_helper_t, samba_etc_t)
+r_dir_file(winbind_t, samba_etc_t)
+allow winbind_helper_t self:unix_dgram_socket create_socket_perms;
+allow winbind_helper_t self:unix_stream_socket create_stream_socket_perms;
+allow winbind_helper_t winbind_var_run_t:dir r_dir_perms;
+can_winbind(winbind_helper_t)
+allow winbind_helper_t privfd:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.25.1/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/domains/program/unused/xdm.te	2005-07-07 15:44:45.000000000 -0400
@@ -69,7 +69,7 @@
 
 #
 # Use capabilities.
-allow xdm_t self:capability { audit_control setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner };
+allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner };
 
 allow xdm_t { urandom_device_t random_device_t }:chr_file { getattr read ioctl };
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.25.1/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/file_contexts/program/cups.fc	2005-07-07 15:44:45.000000000 -0400
@@ -41,3 +41,5 @@
 /usr/share/hplip/hpssd.py	--	system_u:object_r:hplip_exec_t
 /usr/share/foomatic/db/oldprinterids 	--	system_u:object_r:cupsd_rw_etc_t
 /var/cache/foomatic(/.*)? 	--	system_u:object_r:cupsd_rw_etc_t
+/var/run/hp.*\.pid		--	system_u:object_r:hplip_var_run_t
+/var/run/hp.*\.port		--	system_u:object_r:hplip_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpcd.fc policy-1.25.1/file_contexts/program/rpcd.fc
--- nsapolicy/file_contexts/program/rpcd.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.1/file_contexts/program/rpcd.fc	2005-07-07 15:44:45.000000000 -0400
@@ -1,6 +1,6 @@
 # RPC daemons
 /sbin/rpc\..*		--	system_u:object_r:rpcd_exec_t
-/usr/sbin/rpc\..*	--	system_u:object_r:rpcd_exec_t
+/usr/sbin/rpc.idmapd	--	system_u:object_r:rpcd_exec_t
 /usr/sbin/rpc\.nfsd	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/exportfs	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/rpc\.gssd	--	system_u:object_r:gssd_exec_t
@@ -9,3 +9,4 @@
 /var/run/rpc\.statd\.pid	--	system_u:object_r:rpcd_var_run_t
 /var/run/rpc\.statd(/.*)?	system_u:object_r:rpcd_var_run_t
 /etc/exports		--	system_u:object_r:exports_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/samba.fc policy-1.25.1/file_contexts/program/samba.fc
--- nsapolicy/file_contexts/program/samba.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.25.1/file_contexts/program/samba.fc	2005-07-07 15:44:45.000000000 -0400
@@ -1,6 +1,7 @@
 # samba scripts
 /usr/sbin/smbd		--	system_u:object_r:smbd_exec_t
 /usr/sbin/nmbd		--	system_u:object_r:nmbd_exec_t
+/usr/bin/net		--	system_u:object_r:samba_net_exec_t
 /etc/samba(/.*)?		system_u:object_r:samba_etc_t
 /var/log/samba(/.*)?		system_u:object_r:samba_log_t
 /var/cache/samba(/.*)?		system_u:object_r:samba_var_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/winbind.fc policy-1.25.1/file_contexts/program/winbind.fc
--- nsapolicy/file_contexts/program/winbind.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.1/file_contexts/program/winbind.fc	2005-07-07 15:44:45.000000000 -0400
@@ -8,3 +8,4 @@
 /var/cache/samba(/.*)?		system_u:object_r:samba_var_t
 ')
 /var/cache/samba/winbindd_privileged(/.*)?	system_u:object_r:winbind_var_run_t
+/usr/bin/ntlm_auth --	system_u:object_r:winbind_helper_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.25.1/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/file_contexts/types.fc	2005-07-07 15:44:45.000000000 -0400
@@ -261,13 +261,13 @@
 # /opt
 #
 /opt(/.*)?			system_u:object_r:usr_t
-/opt/.*/lib(64)?(/.*)?				system_u:object_r:lib_t
-/opt/.*/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/opt/.*/libexec(/.*)?	system_u:object_r:bin_t
-/opt/.*/bin(/.*)?		system_u:object_r:bin_t
-/opt/.*/sbin(/.*)?		system_u:object_r:sbin_t
-/opt/.*/man(/.*)?		system_u:object_r:man_t
-/opt/.*/var/lib(64)?(/.*)?		system_u:object_r:var_lib_t
+/opt(/.*)?/lib(64)?(/.*)?				system_u:object_r:lib_t
+/opt(/.*)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt(/.*)?/libexec(/.*)?	system_u:object_r:bin_t
+/opt(/.*)?/bin(/.*)?		system_u:object_r:bin_t
+/opt(/.*)?/sbin(/.*)?		system_u:object_r:sbin_t
+/opt(/.*)?/man(/.*)?		system_u:object_r:man_t
+/opt(/.*)?/var/lib(64)?(/.*)?		system_u:object_r:var_lib_t
 
 #
 # /etc
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.25.1/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/admin_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -49,9 +49,6 @@
 # Allow system log read
 allow $1_t kernel_t:system syslog_read;
 
-# Allow autrace
-# allow sysadm_t self:netlink_audit_socket nlmsg_readpriv;
-
 # Use capabilities other than sys_module.
 allow $1_t self:capability ~sys_module;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.25.1/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/base_user_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -63,10 +63,8 @@
 allow $1_t self:process execstack;
 }
 
-if (allow_execmod) {
 # Allow text relocations on system shared libraries, e.g. libGL.
 allow $1_t texrel_shlib_t:file execmod;
-}
 
 #
 # kdeinit wants this access
@@ -244,6 +242,7 @@
 can_network($1_t)
 allow $1_t port_type:tcp_socket name_connect;
 can_ypbind($1_t)
+can_winbind($1_t)
 
 ifdef(`pamconsole.te', `
 allow $1_t pam_var_console_t:dir search;
@@ -349,7 +348,7 @@
 allow $1_t devtty_t:chr_file rw_file_perms;
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t zero_device_t:chr_file { rw_file_perms execute };
-allow $1_t { random_device_t urandom_device_t }:chr_file { getattr read ioctl };
+allow $1_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
 #
 # Added to allow reading of cdrom
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.25.1/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/global_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -106,6 +106,7 @@
 allow $1 ld_so_t:lnk_file r_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:file rx_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:lnk_file r_file_perms;
+allow $1 texrel_shlib_t:file execmod;
 allow $1 ld_so_cache_t:file r_file_perms;
 allow $1 device_t:dir search;
 allow $1 null_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.25.1/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/network_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -168,3 +168,10 @@
 allow $1 ldap_port_t:tcp_socket name_connect;
 ')
 
+define(`can_winbind',`
+ifdef(`winbind.te', `
+allow $1 winbind_var_run_t:dir { getattr search };
+allow $1 winbind_t:unix_stream_socket connectto;
+allow $1 winbind_var_run_t:sock_file { getattr read write };
+')
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.25.1/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/apache_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -78,9 +78,6 @@
 
 allow httpd_$1_script_t { urandom_device_t random_device_t }:chr_file r_file_perms;
 
-# for nscd
-dontaudit httpd_$1_script_t var_t:dir search;
-
 ###########################################################################
 # Allow the script interpreters to run the scripts.  So
 # the perl executable will be able to run a perl script
@@ -108,6 +105,7 @@
 
 if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 create_dir_file(httpd_$1_script_t, httpdcontent)
+can_exec(httpd_$1_script_t, httpdcontent)
 }
 
 #
@@ -126,6 +124,7 @@
 ############################################
 # Allow scripts to append to http logs
 #########################################
+allow httpd_$1_script_t { var_t var_log_t httpd_log_t }:dir  search;
 allow httpd_$1_script_t httpd_log_t:file { getattr append };
 
 # apache should set close-on-exec
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.25.1/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-06-01 06:11:23.000000000 -0400
+++ policy-1.25.1/macros/program/chkpwd_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -32,9 +32,16 @@
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
 allow auth_chkpwd sbin_t:dir search;
 allow auth_chkpwd self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+allow auth_chkpwd self:capability { audit_write audit_control };
+
 dontaudit system_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
 dontaudit auth_chkpwd shadow_t:file { getattr read };
 can_ypbind(auth_chkpwd)
+can_kerberos(auth_chkpwd)
+can_ldap(auth_chkpwd)
+ifdef(`winbind.te', `
+r_dir_file(auth_chkpwd, winbind_var_run_t)
+')
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.25.1/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/dbusd_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -37,7 +37,7 @@
 allow $1_dbusd_t self:unix_dgram_socket create_socket_perms;
 
 allow $1_dbusd_t urandom_device_t:chr_file { getattr read };
-allow $1_dbusd_t self:file { getattr read };
+allow $1_dbusd_t self:file { getattr read write };
 allow $1_dbusd_t proc_t:file read;
 
 can_getsecurity($1_dbusd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/evolution_macros.te policy-1.25.1/macros/program/evolution_macros.te
--- nsapolicy/macros/program/evolution_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.1/macros/program/evolution_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -221,12 +221,6 @@
 domain_auto_trans($1_evolution_t, spamassassin_exec_t, $1_spamassassin_t)
 ') dnl spamassasin.te
 
-### Start links in web browser
-ifdef(`mozilla.te', `
-can_exec($1_evolution_t, shell_exec_t)
-domain_auto_trans($1_evolution_t, mozilla_exec_t, $1_mozilla_t)
-') dnl mozilla.te
-
 ') dnl evolution_domain
 
 #################################
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.25.1/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/games_domain.te	2005-07-07 15:44:45.000000000 -0400
@@ -33,10 +33,7 @@
 allow $1_games_t self:process execmem;
 }
 
-if (allow_execmod) {
 allow $1_games_t texrel_shlib_t:file execmod;
-}
-
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.25.1/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-06-01 06:11:23.000000000 -0400
+++ policy-1.25.1/macros/program/java_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -52,9 +52,7 @@
 can_exec($1_javaplugin_t, java_exec_t)
 
 # libdeploy.so legacy
-if (allow_execmod) {
 allow $1_javaplugin_t texrel_shlib_t:file execmod;
-}
 if (allow_execmem) {
 allow $1_javaplugin_t self:process execmem;
 }
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mail_client_macros.te policy-1.25.1/macros/program/mail_client_macros.te
--- nsapolicy/macros/program/mail_client_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.1/macros/program/mail_client_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -21,8 +21,8 @@
 
 # Allow POP/IMAP/SMTP/NNTP/LDAP/IPP(printing)
 can_ypbind($1_t)
-can_network_client_tcp($1_t, { pop_port_t smtp_port_t ifdef(`innd.te', `innd_port_t') ldap_port_t ipp_port_t })
-allow $1_t { pop_port_t smtp_port_t ifdef(`innd.te', `innd_port_t') ldap_port_t ipp_port_t }:tcp_socket name_connect;
+can_network_client_tcp($1_t, { pop_port_t smtp_port_t innd_port_t ldap_port_t ipp_port_t })
+allow $1_t { pop_port_t smtp_port_t innd_port_t ldap_port_t ipp_port_t }:tcp_socket name_connect;
 
 # Allow printing the mail
 ifdef(`cups.te',`
@@ -45,4 +45,10 @@
 allow $1_t $2_gpg_t:process signal;
 ')
 
+# Start links in web browser
+ifdef(`mozilla.te', `
+can_exec($1_t, shell_exec_t)
+domain_auto_trans($1_t, mozilla_exec_t, $2_mozilla_t)
+') 
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.25.1/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/mozilla_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -133,9 +133,7 @@
 if (allow_execmem) {
 allow $1_mozilla_t self:process execmem;
 }
-if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
-}
 
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.25.1/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/mplayer_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -44,8 +44,8 @@
 
 if (allow_execmod) {
 allow $1_$2_t zero_device_t:chr_file execmod;
-allow $1_$2_t texrel_shlib_t:file execmod;
 }
+allow $1_$2_t texrel_shlib_t:file execmod;
 
 # Access to DVD/CD/V4L
 allow $1_$2_t device_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.25.1/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/macros/program/xserver_macros.te	2005-07-07 15:44:45.000000000 -0400
@@ -52,9 +52,7 @@
 
 uses_shlib($1_xserver_t)
 
-if (allow_execmod) {
 allow $1_xserver_t texrel_shlib_t:file execmod;
-}
 
 can_network($1_xserver_t)
 allow $1_xserver_t port_type:tcp_socket name_connect;
@@ -64,11 +62,9 @@
 # for access within the domain
 general_domain_access($1_xserver_t)
 
-if (allow_execmem) {
 allow $1_xserver_t self:process execmem;
 # Until the X module loader is fixed.
 allow $1_xserver_t self:process execheap;
-}
 
 allow $1_xserver_t etc_runtime_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.25.1/net_contexts
--- nsapolicy/net_contexts	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.1/net_contexts	2005-07-07 15:44:45.000000000 -0400
@@ -58,6 +58,8 @@
 
 portcon tcp 80  system_u:object_r:http_port_t
 portcon tcp 443  system_u:object_r:http_port_t
+portcon tcp 488  system_u:object_r:http_port_t
+portcon tcp 8008  system_u:object_r:http_port_t
 
 portcon tcp 106 system_u:object_r:pop_port_t
 portcon tcp 109 system_u:object_r:pop_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.25.1/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/targeted/domains/unconfined.te	2005-07-07 15:44:45.000000000 -0400
@@ -72,3 +72,8 @@
 
 # allow reading of default file context
 bool read_default_t true;
+
+if (allow_execmem) {
+allow domain self:process execmem;
+}
+
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.25.1/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.1/tunables/distro.tun	2005-07-07 15:44:45.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.25.1/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-05-25 11:28:11.000000000 -0400
+++ policy-1.25.1/tunables/tunable.tun	2005-07-07 15:44:45.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,7 +20,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.25.1/types/network.te
--- nsapolicy/types/network.te	2005-07-06 17:15:07.000000000 -0400
+++ policy-1.25.1/types/network.te	2005-07-07 15:44:45.000000000 -0400
@@ -158,7 +158,6 @@
 type snmp_port_t, port_type, reserved_port_type;
 type biff_port_t, port_type, reserved_port_type;
 type hplip_port_t, port_type;
-type cipe_port_t, port_type;
 
 #inetd_child_ports
 

--------------050308080108080509080007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
