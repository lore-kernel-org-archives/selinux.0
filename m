Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7FEpROb004967
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 10:51:27 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7FEgadf017213
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 14:42:36 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7FEgodM024112
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 10:42:50 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7FEgotf024111
	for selinux@tycho.nsa.gov; Mon, 15 Aug 2005 10:42:50 -0400
Message-ID: <4300A6CB.2000501@redhat.com>
Date: Mon, 15 Aug 2005 10:29:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------010209050608090700030500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010209050608090700030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove nfs_export_all_rw tunable in kernel.te (This is now a boolean).

Add audit_control to cron.

fsadm needs DAC capabilities for manipulating removable media (ZIP drives).

passwd needs access to sysctl

Lots of changes to alsa domain for strict policy.  Allowing it to 
communicate with userspace

Add new domain anonymous_domain so domains can share the ftpd_anon_t and 
ftpd_anon_rw_t types.  (ftpd, rsync, httpd, smbd)

Eliminate a few more transition of sysadm_t (unconfined_t) to domains 
for targeted policy.

Bluetooth needs to run helper apps in bin_t.

Add certwatch domain.

Cups confing needs to communicate with itself using unix_dgram_sockets.

Allow cvs to use kerberos.

Allow cyrus to use saslaudthd.

Fixes for latest version of dbus.

Allow NetworkManager and dhcpc to better communicate using dbus.

Cleanup firstboot.

Fixes for ipsec to allow netlink_route_socket and additional privs of 
unix_dgram_socketet.

Allow networkmanager to communicate with isakmp_port and use vpnc.


Lots of fixed for pppd and pptp.

Allow samba to commucate with smbd_port_t

Fixes for saslauthd.  Needs to be able to communicate with mysql.

Change vpnc to application_domain.

Several updates to file_contexts.

Created authentication_domain for anything that supports 
pam_authentication. 

Fixed for ethereal domain to handle fallback with new version of userhelper.

Allow evolution to read cert files.

Allow userspace to kill thunderbird

Add mcs stuff to Makefile.

Remove netifcon calls and default to netif_t.  So that we can start 
isolation individual ethernet devices.






















-- 



--------------010209050608090700030500
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/misc/kernel.te policy-1.25.4/domains/misc/kernel.te
--- nsapolicy/domains/misc/kernel.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.4/domains/misc/kernel.te	2005-08-11 23:07:13.000000000 -0400
@@ -11,7 +11,7 @@
 # kernel_t is the domain of kernel threads.
 # It is also the target type when checking permissions in the system class.
 # 
-type kernel_t, domain, privmodule, privlog, sysctl_kernel_writer, mlsprocread, mlsprocwrite, privsysmod ifdef(`nfs_export_all_rw',`,etc_writer'), privrangetrans ;
+type kernel_t, domain, privmodule, privlog, sysctl_kernel_writer, mlsprocread, mlsprocwrite, privsysmod, etc_writer, privrangetrans ;
 role system_r types kernel_t;
 general_domain_access(kernel_t)
 general_proc_read_access(kernel_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.25.4/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-08-11 06:57:10.000000000 -0400
+++ policy-1.25.4/domains/program/crond.te	2005-08-11 23:07:13.000000000 -0400
@@ -44,7 +44,7 @@
 read_locale(crond_t)
 
 # Use capabilities.
-allow crond_t self:capability { dac_override setgid setuid net_bind_service sys_nice };
+allow crond_t self:capability { dac_override setgid setuid net_bind_service sys_nice audit_control };
 dontaudit crond_t self:capability sys_resource;
 
 # Get security policy decisions.
@@ -207,5 +207,8 @@
 #
 ifdef(`apache.te', `
 allow system_crond_t { httpd_log_t httpd_config_t }:file { getattr read };
+allow system_crond_t httpd_modules_t:lnk_file read;
 ')
 dontaudit crond_t self:capability sys_tty_config;
+# Needed for certwatch
+can_exec(system_crond_t, httpd_modules_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.25.4/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-08-11 06:57:12.000000000 -0400
+++ policy-1.25.4/domains/program/fsadm.te	2005-08-11 23:07:13.000000000 -0400
@@ -64,7 +64,7 @@
 allow fsadm_t { urandom_device_t random_device_t }:chr_file { getattr read };
 
 # Use capabilities.  ipc_lock is for losetup
-allow fsadm_t self:capability { ipc_lock sys_rawio sys_admin sys_tty_config };
+allow fsadm_t self:capability { ipc_lock sys_rawio sys_admin sys_tty_config dac_override dac_read_search };
 
 # Write to /etc/mtab.
 file_type_auto_trans(fsadm_t, etc_t, etc_runtime_t, file)
@@ -117,3 +117,4 @@
 allow fsadm_t { file_t unlabeled_t }:blk_file rw_file_perms;
 allow fsadm_t usbfs_t:dir { getattr search };
 allow fsadm_t ramfs_t:fifo_file rw_file_perms;
+allow fsadm_t device_type:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/hostname.te policy-1.25.4/domains/program/hostname.te
--- nsapolicy/domains/program/hostname.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.25.4/domains/program/hostname.te	2005-08-11 23:07:13.000000000 -0400
@@ -25,3 +25,4 @@
 allow hostname_t tmpfs_t:chr_file rw_file_perms;
 ')
 allow hostname_t initrc_devpts_t:chr_file { read write };
+allow hostname_t initrc_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.25.4/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-08-11 06:57:13.000000000 -0400
+++ policy-1.25.4/domains/program/ifconfig.te	2005-08-11 23:07:13.000000000 -0400
@@ -34,7 +34,7 @@
 allow ifconfig_t self:socket create_socket_perms;
 
 # Use capabilities.
-allow ifconfig_t self:capability net_admin;
+allow ifconfig_t self:capability { net_raw net_admin };
 dontaudit ifconfig_t self:capability sys_module;
 allow ifconfig_t self:capability sys_tty_config;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.25.4/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-08-11 06:57:13.000000000 -0400
+++ policy-1.25.4/domains/program/initrc.te	2005-08-11 23:07:13.000000000 -0400
@@ -319,3 +319,6 @@
 ')
 allow initrc_t self:netlink_route_socket r_netlink_socket_perms;
 allow initrc_t device_t:lnk_file create_file_perms;
+ifdef(`dbusd.te', `
+allow initrc_t system_dbusd_var_run_t:sock_file write;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/passwd.te policy-1.25.4/domains/program/passwd.te
--- nsapolicy/domains/program/passwd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/passwd.te	2005-08-11 23:07:13.000000000 -0400
@@ -64,6 +64,7 @@
 dontaudit $1_t { proc_t device_t }:dir { search read };
 
 allow $1_t device_t:dir getattr;
+read_sysctl($1_t)
 ')
 
 #################################
@@ -152,5 +153,5 @@
 
 ifdef(`targeted_policy', `
 role system_r types sysadm_passwd_t;
-allow sysadm_passwd_t devpts_t:chr_file { read write };
+allow sysadm_passwd_t devpts_t:chr_file rw_file_perms;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/alsa.te policy-1.25.4/domains/program/unused/alsa.te
--- nsapolicy/domains/program/unused/alsa.te	2005-07-05 15:25:45.000000000 -0400
+++ policy-1.25.4/domains/program/unused/alsa.te	2005-08-11 23:07:13.000000000 -0400
@@ -6,12 +6,17 @@
 type alsa_t, domain, privlog, daemon;
 type alsa_exec_t, file_type, sysadmfile, exec_type;
 uses_shlib(alsa_t)
-allow alsa_t self:sem  create_sem_perms;
-allow alsa_t self:shm  create_shm_perms;
+allow alsa_t { unpriv_userdomain self }:sem  create_sem_perms;
+allow alsa_t { unpriv_userdomain self }:shm  create_shm_perms;
 allow alsa_t self:unix_stream_socket create_stream_socket_perms;
+allow alsa_t self:unix_dgram_socket create_socket_perms;
+allow unpriv_userdomain alsa_t:sem { unix_read unix_write associate read write };
 type alsa_etc_rw_t, file_type, sysadmfile, usercanread;
 rw_dir_create_file(alsa_t,alsa_etc_rw_t)
 allow alsa_t self:capability { setgid setuid ipc_owner };
+dontaudit alsa_t self:capability sys_admin;
 allow alsa_t devpts_t:chr_file { read write };
 allow alsa_t etc_t:file { getattr read };
 domain_auto_trans(pam_console_t, alsa_exec_t, alsa_t)
+role system_r types alsa_t;
+read_locale(alsa_t) 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.25.4/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/apache.te	2005-08-11 23:07:13.000000000 -0400
@@ -222,6 +222,9 @@
 # Creation of lock files for apache2
 lock_domain(httpd)
 
+# Allow apache to used ftpd_anon_t
+anonymous_domain(httpd)
+
 # connect to mysql
 ifdef(`mysqld.te', `
 can_unix_connect(httpd_php_t, mysqld_t)
@@ -300,7 +303,7 @@
 ##################################################
 
 if (httpd_tty_comm) {
-allow { httpd_t httpd_helper_t } devpts_t:dir { search };
+allow { httpd_t httpd_helper_t } devpts_t:dir search;
 ifdef(`targeted_policy', `
 allow { httpd_helper_t httpd_t } { devtty_t devpts_t }:chr_file { read write };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.25.4/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/apmd.te	2005-08-11 23:07:13.000000000 -0400
@@ -16,7 +16,9 @@
 
 type apm_t, domain, privlog;
 type apm_exec_t, file_type, sysadmfile, exec_type;
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, apm_exec_t, apm_t)
+')
 uses_shlib(apm_t)
 allow apm_t privfd:fd use;
 allow apm_t admin_tty_type:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/backup.te policy-1.25.4/domains/program/unused/backup.te
--- nsapolicy/domains/program/unused/backup.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.25.4/domains/program/unused/backup.te	2005-08-11 23:07:13.000000000 -0400
@@ -16,7 +16,9 @@
 role system_r types backup_t;
 role sysadm_r types backup_t;
 
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, backup_exec_t, backup_t)
+')
 allow backup_t privfd:fd use;
 ifdef(`crond.te', `
 system_crond_entry(backup_exec_t, backup_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.25.4/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/bluetooth.te	2005-08-12 07:55:43.000000000 -0400
@@ -43,3 +43,6 @@
 allow initrc_t usbfs_t:file { getattr read };
 allow bluetooth_t usbfs_t:dir r_dir_perms;
 allow bluetooth_t usbfs_t:file rw_file_perms; 
+allow bluetooth_t bin_t:dir search;
+can_exec(bluetooth_t, bin_t)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.25.4/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.25.4/domains/program/unused/bootloader.te	2005-08-11 23:07:13.000000000 -0400
@@ -24,7 +24,9 @@
 # for nscd
 dontaudit bootloader_t var_run_t:dir search;
 
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, bootloader_exec_t, bootloader_t)
+')
 allow bootloader_t { initrc_t privfd }:fd use;
 
 tmp_domain(bootloader, `, device_type', { dir file lnk_file chr_file blk_file })
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.25.4/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2005-05-02 14:06:54.000000000 -0400
+++ policy-1.25.4/domains/program/unused/cardmgr.te	2005-08-11 23:07:13.000000000 -0400
@@ -15,7 +15,9 @@
 allow cardmgr_t urandom_device_t:chr_file read;
 
 type cardctl_exec_t, file_type, sysadmfile, exec_type;
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, cardctl_exec_t, cardmgr_t)
+')
 role sysadm_r types cardmgr_t;
 allow cardmgr_t admin_tty_type:chr_file { read write };
 
@@ -85,3 +87,4 @@
 rw_dir_file(hald_t, cardmgr_var_run_t)
 allow hald_t cardmgr_var_run_t:chr_file create_file_perms;
 ')
+allow cardmgr_t device_t:lnk_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/certwatch.te policy-1.25.4/domains/program/unused/certwatch.te
--- nsapolicy/domains/program/unused/certwatch.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.25.4/domains/program/unused/certwatch.te	2005-08-11 23:07:13.000000000 -0400
@@ -0,0 +1,11 @@
+#DESC certwatch - generate SSL certificate expiry warnings
+#
+# Domains for the certwatch process 
+# Authors:  Dan Walsh <dwalsh@redhat.com>,
+#
+application_domain(certwatch)
+role system_r types certwatch_t;
+r_dir_file(certwatch_t, cert_t)
+can_exec(certwatch_t, httpd_modules_t)
+system_crond_entry(certwatch_exec_t, certwatch_t)
+read_locale(certwatch_t) 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clockspeed.te policy-1.25.4/domains/program/unused/clockspeed.te
--- nsapolicy/domains/program/unused/clockspeed.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.4/domains/program/unused/clockspeed.te	2005-08-11 23:07:13.000000000 -0400
@@ -21,5 +21,6 @@
 
 # sysadm can play with clockspeed
 role sysadm_r types clockspeed_t;
+ifdef(`targeted_policy', `', `
 domain_auto_trans( sysadm_t, clockspeed_exec_t, clockspeed_t)
-
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.25.4/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/cups.te	2005-08-11 23:07:13.000000000 -0400
@@ -245,6 +245,7 @@
 allow cupsd_config_t self:fifo_file rw_file_perms;
 
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
+allow cupsd_config_t self:unix_dgram_socket create_socket_perms;
 ifdef(`dbusd.te', `
 dbusd_client(system, cupsd_config)
 allow cupsd_config_t userdomain:dbus send_msg;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cvs.te policy-1.25.4/domains/program/unused/cvs.te
--- nsapolicy/domains/program/unused/cvs.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/cvs.te	2005-08-11 23:07:13.000000000 -0400
@@ -15,12 +15,14 @@
 typeattribute cvs_t privmail;
 typeattribute cvs_t auth_chkpwd;
 
-type cvs_data_t, file_type, sysadmfile;
+type cvs_data_t, file_type, sysadmfile, customizable;
 create_dir_file(cvs_t, cvs_data_t)
 can_exec(cvs_t, { bin_t sbin_t shell_exec_t })
+allow cvs_t bin_t:dir search;
+allow cvs_t { bin_t sbin_t }:lnk_file read;
 allow cvs_t etc_runtime_t:file { getattr read };
 allow system_mail_t cvs_data_t:file { getattr read };
 dontaudit cvs_t devtty_t:chr_file { read write };
-allow cvs_t default_t:dir search;
-allow cvs_t default_t:lnk_file read;
-
+# Allow kerberos to work
+allow cvs_t { krb5_keytab_t krb5_conf_t }:file r_file_perms;
+dontaudit cvs_t krb5_conf_t:file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.25.4/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/cyrus.te	2005-08-11 23:07:13.000000000 -0400
@@ -20,7 +20,7 @@
 can_ypbind(cyrus_t)
 can_exec(cyrus_t, bin_t)
 allow cyrus_t cyrus_var_lib_t:dir create_dir_perms;
-allow cyrus_t cyrus_var_lib_t:{file sock_file } create_file_perms;
+allow cyrus_t cyrus_var_lib_t:{file sock_file lnk_file} create_file_perms;
 allow cyrus_t etc_t:file { getattr read };
 allow cyrus_t lib_t:file { execute execute_no_trans getattr read };
 read_locale(cyrus_t)
@@ -42,3 +42,11 @@
 create_dir_file(cyrus_t, mail_spool_t)
 allow cyrus_t var_spool_t:dir search;
 
+ifdef(`saslaudthd.te', `
+allow cyrus_t saslauthd_var_run_t:dir search;
+allow cyrus_t saslauthd_var_run_t:sock_file { read write };
+allow cyrus_t saslauthd_t:unix_stream_socket { connectto };
+')
+
+r_dir_file(cyrus_t, cert_t)
+allow cyrus_t { urandom_device_t random_device_t }:chr_file { read getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.25.4/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2005-04-27 10:28:50.000000000 -0400
+++ policy-1.25.4/domains/program/unused/dbusd.te	2005-08-11 23:07:13.000000000 -0400
@@ -17,4 +17,9 @@
 # I expect we need more than this
 
 allow initrc_t system_dbusd_t:dbus { send_msg acquire_svc };
+allow initrc_t system_dbusd_t:unix_stream_socket connectto;
+allow initrc_t system_dbusd_var_run_t:sock_file write;
 
+can_exec(system_dbusd_t, sbin_t)
+allow system_dbusd_t self:fifo_file { read write };
+allow system_dbusd_t self:unix_stream_socket connectto;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddclient.te policy-1.25.4/domains/program/unused/ddclient.te
--- nsapolicy/domains/program/unused/ddclient.te	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.4/domains/program/unused/ddclient.te	2005-08-11 23:07:13.000000000 -0400
@@ -38,5 +38,7 @@
 
 # allow access to ddclient.conf and ddclient.cache
 allow ddclient_t ddclient_etc_t:file r_file_perms;
-allow ddclient_t ddclient_var_t:dir rw_dir_perms;
-allow ddclient_t ddclient_var_t:file create_file_perms;
+file_type_auto_trans(ddclient_t, var_t, ddclient_var_t)
+dontaudit ddclient_t devpts_t:dir search;
+dontaudit ddclient_t { devtty_t admin_tty_type user_tty_type }:chr_file rw_file_perms;
+dontaudit httpd_t selinux_config_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.25.4/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/dhcpc.te	2005-08-11 23:07:13.000000000 -0400
@@ -156,6 +156,6 @@
 domain_auto_trans(system_dbusd_t, dhcpc_exec_t, dhcpc_t)
 allow dhcpc_t system_dbusd_t:dbus { acquire_svc send_msg };
 allow dhcpc_t self:dbus send_msg;
-allow { NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
-allow dhcpc_t { NetworkManager_t initrc_t }:dbus send_msg;
+allow { unconfined_t NetworkManager_t initrc_t } dhcpc_t:dbus send_msg;
+allow dhcpc_t { unconfined_t NetworkManager_t initrc_t }:dbus send_msg;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.25.4/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2005-06-01 06:11:22.000000000 -0400
+++ policy-1.25.4/domains/program/unused/firstboot.te	2005-08-11 23:07:13.000000000 -0400
@@ -57,9 +57,6 @@
 # Allow write to utmp file
 allow firstboot_t initrc_var_run_t:file write;
 
-allow firstboot_t krb5_conf_t:file { getattr read };
-allow firstboot_t net_conf_t:file { getattr read };
-
 ifdef(`samba.te', `
 rw_dir_file(firstboot_t, samba_etc_t)
 ')
@@ -95,10 +92,6 @@
 allow firstboot_t modules_conf_t:file { getattr read };
 allow firstboot_t modules_dep_t:file { getattr read };
 allow firstboot_t modules_object_t:dir search;
-allow firstboot_t net_conf_t:file rw_file_perms;
-allow firstboot_t netif_lo_t:netif { tcp_recv tcp_send };
-allow firstboot_t node_t:node { tcp_recv tcp_send };
-
 allow firstboot_t port_t:tcp_socket { recv_msg send_msg };
 allow firstboot_t proc_t:lnk_file read;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.25.4/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/ftpd.te	2005-08-11 23:07:13.000000000 -0400
@@ -110,9 +110,5 @@
 	r_dir_file(ftpd_t, cifs_t)
 }
 dontaudit ftpd_t selinux_config_t:dir search;
-#
-# Type for access to anon ftp
-#
-r_dir_file(ftpd_t,ftpd_anon_t)
-type ftpd_anon_rw_t, file_type, sysadmfile, customizable;
-create_dir_file(ftpd_t,ftpd_anon_rw_t)
+anonymous_domain(ftpd)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.25.4/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/hald.te	2005-08-11 23:07:13.000000000 -0400
@@ -47,6 +47,7 @@
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file read;
 allow hald_t mouse_device_t:chr_file r_file_perms;
+allow hald_t device_type:chr_file getattr;
 
 can_getsecurity(hald_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hwclock.te policy-1.25.4/domains/program/unused/hwclock.te
--- nsapolicy/domains/program/unused/hwclock.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/hwclock.te	2005-08-11 23:07:13.000000000 -0400
@@ -17,7 +17,9 @@
 #
 daemon_base_domain(hwclock)
 role sysadm_r types hwclock_t;
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, hwclock_exec_t, hwclock_t)
+')
 type adjtime_t, file_type, sysadmfile;
 
 allow hwclock_t fs_t:filesystem getattr;
@@ -44,3 +46,4 @@
 
 # for when /usr is not mounted
 dontaudit hwclock_t file_t:dir search;
+allow hwclock_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.25.4/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2005-04-27 10:28:51.000000000 -0400
+++ policy-1.25.4/domains/program/unused/ipsec.te	2005-08-11 23:07:13.000000000 -0400
@@ -60,8 +60,8 @@
 # it in its own domain?)
 can_exec(ipsec_mgmt_t, bin_t)
 # logger, running in ipsec_mgmt_t needs to use sockets
-allow ipsec_mgmt_t self:unix_dgram_socket { create connect write };
-allow ipsec_mgmt_t ipsec_t:unix_dgram_socket { create connect write };
+allow ipsec_mgmt_t self:unix_dgram_socket create_socket_perms;
+allow ipsec_mgmt_t ipsec_t:unix_dgram_socket create_socket_perms;
 
 # also need to run things like whack and shell scripts
 can_exec(ipsec_mgmt_t, ipsec_exec_t)
@@ -169,7 +169,7 @@
 # Pluto needs network access
 can_network_server(ipsec_t)
 can_ypbind(ipsec_t)
-allow ipsec_t self:unix_dgram_socket { create connect write };
+allow ipsec_t self:unix_dgram_socket create_socket_perms;
 
 # for sleep
 allow ipsec_mgmt_t fs_t:filesystem getattr;
@@ -211,6 +211,7 @@
 allow ipsec_mgmt_t self:key_socket { create setopt };
 can_exec(ipsec_mgmt_t, initrc_exec_t)
 allow ipsec_t self:netlink_xfrm_socket create_socket_perms;
+allow ipsec_t self:netlink_route_socket r_netlink_socket_perms;
 read_locale(ipsec_t)
 ifdef(`consoletype.te', `
 can_exec(ipsec_mgmt_t, consoletype_exec_t )
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.25.4/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/kudzu.te	2005-08-11 23:07:13.000000000 -0400
@@ -48,7 +48,9 @@
 allow kudzu_t { tty_device_t devtty_t admin_tty_type }:chr_file rw_file_perms;
 
 role sysadm_r types kudzu_t;
+ifdef(`targeted_policy', `', `
 domain_auto_trans(sysadm_t, kudzu_exec_t, kudzu_t)
+')
 ifdef(`anaconda.te', `
 domain_auto_trans(anaconda_t, kudzu_exec_t, kudzu_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.25.4/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/mta.te	2005-08-11 23:07:13.000000000 -0400
@@ -22,7 +22,7 @@
 # rules are currently defined in sendmail.te, but it is not included in 
 # targeted policy.  We could move these rules permanantly here.
 ifdef(`postfix.te', `', `can_exec_any(system_mail_t)')
-allow system_mail_t self:dir { search };
+allow system_mail_t self:dir search;
 allow system_mail_t self:lnk_file read;
 r_dir_file(system_mail_t, { proc_t proc_net_t })
 allow system_mail_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.25.4/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	2005-08-11 06:57:14.000000000 -0400
+++ policy-1.25.4/domains/program/unused/NetworkManager.te	2005-08-11 23:07:13.000000000 -0400
@@ -15,12 +15,12 @@
 
 can_network(NetworkManager_t)
 allow NetworkManager_t port_type:tcp_socket name_connect;
-allow NetworkManager_t dhcpc_port_t:udp_socket name_bind;
+allow NetworkManager_t { isakmp_port_t dhcpc_port_t }:udp_socket name_bind;
 allow NetworkManager_t dhcpc_t:process signal;
 
 can_ypbind(NetworkManager_t)
 uses_shlib(NetworkManager_t)
-allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service sys_module};
+allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service sys_module ipc_lock};
 
 allow NetworkManager_t { random_device_t urandom_device_t }:chr_file { getattr read };
 
@@ -93,6 +93,9 @@
 
 domain_auto_trans(NetworkManager_t, insmod_exec_t, insmod_t)
 allow NetworkManager_t self:netlink_route_socket r_netlink_socket_perms;
+# allow vpnc connections
+allow NetworkManager_t self:rawip_socket create_socket_perms;
+allow NetworkManager_t tun_tap_device_t:chr_file rw_file_perms;
 
 domain_auto_trans(NetworkManager_t, initrc_exec_t, initrc_t)
 domain_auto_trans(NetworkManager_t, dhcpc_exec_t, dhcpc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.25.4/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/ping.te	2005-08-11 23:07:13.000000000 -0400
@@ -17,7 +17,9 @@
 in_user_role(ping_t)
 type ping_exec_t, file_type, sysadmfile, exec_type;
 
-ifdef(`targeted_policy', `', `
+ifdef(`targeted_policy', `
+	allow ping_t { devpts_t ttyfile ptyfile }:chr_file rw_file_perms;
+', `
 bool user_ping false;
 
 if (user_ping) {
@@ -42,9 +44,6 @@
 # Let ping create raw ICMP packets.
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
 
-allow ping_t netif_type:netif { rawip_send rawip_recv };
-allow ping_t node_type:node { rawip_send rawip_recv };
-
 # Use capabilities.
 allow ping_t self:capability { net_raw setuid };
 
@@ -52,11 +51,13 @@
 allow ping_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')
 allow ping_t privfd:fd use;
-
 dontaudit ping_t fs_t:filesystem getattr;
 
 # it tries to access /var/run
 dontaudit ping_t var_t:dir search;
 dontaudit ping_t devtty_t:chr_file { read write };
 dontaudit ping_t self:capability sys_tty_config;
+ifdef(`hide_broken_symptoms', `
+allow ping_t init_t:fd use;
+')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.25.4/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/postgresql.te	2005-08-11 23:07:13.000000000 -0400
@@ -110,8 +110,8 @@
 allow postgresql_t self:sem create_sem_perms;
 
 allow postgresql_t initrc_var_run_t:file { getattr read lock };
-dontaudit postgresql_t selinux_config_t:dir { search };
-allow postgresql_t mail_spool_t:dir { search };
+dontaudit postgresql_t selinux_config_t:dir search;
+allow postgresql_t mail_spool_t:dir search;
 lock_domain(postgresql)
 can_exec(postgresql_t, { shell_exec_t bin_t postgresql_exec_t ls_exec_t } )
 ifdef(`apache.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.25.4/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/pppd.te	2005-08-11 23:07:13.000000000 -0400
@@ -32,12 +32,9 @@
 log_domain(pppd)
 
 # Use the network.
-can_network(pppd_t)
+can_network_server(pppd_t)
 can_ypbind(pppd_t)
 
-allow pppd_t fingerd_port_t:tcp_socket name_connect;
-
-
 # Use capabilities.
 allow pppd_t self:capability { net_admin setuid setgid fsetid fowner net_raw dac_override };
 lock_domain(pppd)
@@ -55,8 +52,6 @@
 
 # allow running ip-up and ip-down scripts and running chat.
 can_exec(pppd_t, { shell_exec_t bin_t sbin_t etc_t ifconfig_exec_t })
-can_exec(pppd_t, pppd_etc_rw_t)
-can_exec(pppd_t, hostname_exec_t)
 allow pppd_t { bin_t sbin_t }:dir search;
 allow pppd_t { sbin_t bin_t }:lnk_file read;
 
@@ -115,7 +110,6 @@
 domain_auto_trans(pppd_t, insmod_exec_t, insmod_t)
 ')
 }
-domain_auto_trans(pppd_t, named_exec_t, named_t)
 
 daemon_domain(pptp)
 can_network_client_tcp(pptp_t)
@@ -136,4 +130,17 @@
 allow pptp_t self:fifo_file { read write };
 allow pptp_t ptmx_t:chr_file rw_file_perms;
 log_domain(pptp)
+
+# Fix sockets
+allow pptp_t pptp_var_run_t:sock_file create_file_perms;
+
+# Allow pptp to append to pppd log files
 allow pptp_t pppd_log_t:file append;
+
+ifdef(`named.te', `
+dontaudit ndc_t pppd_t:fd use;
+')
+
+# Allow /etc/ppp/ip-{up,down} to run most anything
+type pppd_script_exec_t, file_type, sysadmfile;
+domain_auto_trans(pppd_t, pppd_script_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.25.4/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/rlogind.te	2005-08-11 23:07:13.000000000 -0400
@@ -35,4 +35,4 @@
 allow rlogind_t default_t:dir search;
 typealias rlogind_port_t alias rlogin_port_t;
 read_sysctl(rlogind_t);
-allow rlogind_t krb5_keytab_t:file { getattr read };
+allow rlogind_t krb5_keytab_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.25.4/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/rpm.te	2005-08-11 23:07:13.000000000 -0400
@@ -114,7 +114,7 @@
 
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
 
-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role;
+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, privrole, priv_system_role;
 # policy for rpm scriptlet
 role system_r types rpm_script_t;
 uses_shlib(rpm_script_t)
@@ -194,6 +194,7 @@
 
 domain_auto_trans(rpm_script_t, ldconfig_exec_t, ldconfig_t)
 domain_auto_trans(rpm_script_t, depmod_exec_t, depmod_t)
+role sysadm_r types initrc_t;
 domain_auto_trans(rpm_script_t, initrc_exec_t, initrc_t)
 ifdef(`bootloader.te', `
 domain_auto_trans(rpm_script_t, bootloader_exec_t, bootloader_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.25.4/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2005-04-27 10:28:52.000000000 -0400
+++ policy-1.25.4/domains/program/unused/rsync.te	2005-08-11 23:07:13.000000000 -0400
@@ -14,4 +14,6 @@
 inetd_child_domain(rsync)
 type rsync_data_t, file_type, sysadmfile;
 r_dir_file(rsync_t, rsync_data_t)
-r_dir_file(rsync_t, ftpd_anon_t)
+anonymous_domain(rsync)
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.25.4/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/domains/program/unused/samba.te	2005-08-11 23:07:13.000000000 -0400
@@ -50,7 +50,7 @@
 can_ldap(smbd_t)
 can_kerberos(smbd_t)
 can_winbind(smbd_t)
-allow smbd_t ipp_port_t:tcp_socket name_connect;
+allow smbd_t { smbd_port_t ipp_port_t }:tcp_socket name_connect;
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
 
@@ -79,6 +79,7 @@
 
 # Access Samba shares.
 create_dir_file(smbd_t, samba_share_t)
+anonymous_domain(smbd)
 
 ifdef(`logrotate.te', `
 # the application should be changed
@@ -189,6 +190,8 @@
 ')
 # Derive from app. domain. Transition from mount.
 application_domain(samba_net, `, nscd_client_domain')
+role system_r types samba_net_t;
+in_user_role(samba_net_t)
 file_type_auto_trans(samba_net_t, samba_etc_t, samba_secrets_t, file)
 read_locale(samba_net_t) 
 allow samba_net_t samba_etc_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/saslauthd.te policy-1.25.4/domains/program/unused/saslauthd.te
--- nsapolicy/domains/program/unused/saslauthd.te	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.4/domains/program/unused/saslauthd.te	2005-08-11 23:07:13.000000000 -0400
@@ -9,6 +9,7 @@
 allow saslauthd_t self:unix_dgram_socket create_socket_perms;
 allow saslauthd_t self:unix_stream_socket create_stream_socket_perms;
 allow saslauthd_t saslauthd_var_run_t:sock_file create_file_perms;
+allow saslauthd_t var_lib_t:dir search;
 
 allow saslauthd_t etc_t:dir { getattr search };
 allow saslauthd_t etc_t:file r_file_perms;
@@ -29,3 +30,12 @@
 if (allow_saslauthd_read_shadow) {
 allow saslauthd_t shadow_t:file r_file_perms;
 }
+dontaudit saslauthd_t selinux_config_t:dir search;
+dontaudit saslauthd_t selinux_config_t:file { getattr read };
+
+
+dontaudit saslauthd_t initrc_t:unix_stream_socket connectto;
+ifdef(`mysqld.te', `
+allow saslauthd_t mysqld_db_t:dir search;
+allow saslauthd_t mysqld_var_run_t:sock_file rw_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slocate.te policy-1.25.4/domains/program/unused/slocate.te
--- nsapolicy/domains/program/unused/slocate.te	2005-04-27 10:28:53.000000000 -0400
+++ policy-1.25.4/domains/program/unused/slocate.te	2005-08-11 23:07:13.000000000 -0400
@@ -10,7 +10,8 @@
 # locate_exec_t is the type of the locate executable.
 #
 daemon_base_domain(locate)
-
+role system_r types locate_t;
+role sysadm_r types locate_t;
 allow locate_t fs_t:filesystem getattr;
 
 ifdef(`crond.te', `
@@ -23,6 +24,7 @@
 allow locate_t { userpty_type admin_tty_type }:chr_file rw_file_perms;
 
 allow locate_t { fs_type file_type }:dir r_dir_perms;
+dontaudit locate_t sysctl_t:dir getattr;
 allow locate_t file_type:lnk_file r_file_perms;
 allow locate_t { file_type -shadow_t }:{ lnk_file sock_file fifo_file file } getattr;
 dontaudit locate_t { file_type -shadow_t }:{ lnk_file sock_file fifo_file file } read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.25.4/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/udev.te	2005-08-11 23:07:13.000000000 -0400
@@ -33,7 +33,7 @@
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
 allow udev_t self:fifo_file rw_file_perms;
-allow udev_t self:netlink_kobject_uevent_socket { create bind read }; 
+allow udev_t self:netlink_kobject_uevent_socket { create bind read setopt }; 
 allow udev_t device_t:file { unlink rw_file_perms };
 allow udev_t device_t:sock_file create_file_perms;
 allow udev_t device_t:lnk_file create_lnk_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.25.4/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/domains/program/unused/vpnc.te	2005-08-12 07:29:25.000000000 -0400
@@ -10,9 +10,9 @@
 # vpnc_t is the domain for the vpnc program.
 # vpnc_exec_t is the type of the vpnc executable.
 #
-daemon_domain(vpnc, `, sysctl_net_writer')
+application_domain(vpnc, `, sysctl_net_writer, nscd_client_domain')
 
-allow vpnc_t { random_device_t urandom_device_t }:chr_file read;
+allow vpnc_t { random_device_t urandom_device_t }:chr_file { getattr read };
 
 # Use the network.
 can_network(vpnc_t)
@@ -31,7 +31,7 @@
 allow vpnc_t self:rawip_socket create_socket_perms;
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
-allow vpnc_t { user_tty_type admin_tty_type }:chr_file rw_file_perms;
+allow vpnc_t { devtty_t user_tty_type admin_tty_type }:chr_file rw_file_perms;
 allow vpnc_t port_t:udp_socket name_bind;
 allow vpnc_t etc_runtime_t:file { getattr read };
 allow vpnc_t proc_t:file { getattr read };
@@ -42,6 +42,8 @@
 allow vpnc_t sbin_t:dir search;
 allow vpnc_t bin_t:dir search;
 allow vpnc_t bin_t:lnk_file read;
+allow vpnc_t self:dir search;
+r_dir_file(vpnc_t, proc_t)
 r_dir_file(vpnc_t, proc_net_t)
 tmp_domain(vpnc)
 allow vpnc_t self:fifo_file { getattr ioctl read write };
@@ -49,3 +51,12 @@
 allow vpnc_t self:netlink_route_socket rw_netlink_socket_perms;
 file_type_auto_trans(vpnc_t, etc_t, net_conf_t, file)
 allow vpnc_t etc_t:file { execute execute_no_trans ioctl };
+dontaudit vpnc_t home_root_t:dir search;
+dontaudit vpnc_t user_home_dir_type:dir search;
+var_run_domain(vpnc)
+allow vpnc_t userdomain:fd use;
+r_dir_file(vpnc_t, sysfs_t)
+allow vpnc_t self:process { fork sigchld };
+read_locale(vpnc_t)
+read_sysctl(vpnc_t)
+allow vpnc_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/useradd.te policy-1.25.4/domains/program/useradd.te
--- nsapolicy/domains/program/useradd.te	2005-04-27 10:28:49.000000000 -0400
+++ policy-1.25.4/domains/program/useradd.te	2005-08-11 23:07:13.000000000 -0400
@@ -102,3 +102,4 @@
 allow useradd_t default_context_t:dir search;
 allow useradd_t file_context_t:dir search;
 allow useradd_t file_context_t:file { getattr read };
+allow useradd_t var_lib_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.25.4/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.4/file_contexts/program/apache.fc	2005-08-11 23:07:13.000000000 -0400
@@ -7,6 +7,8 @@
 /var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
 /var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
+/var/cache/php-eaccelerator(/.*)? system_u:object_r:httpd_cache_t
+/var/cache/php-mmcache(/.*)?	system_u:object_r:httpd_cache_t
 /etc/httpd		-d	system_u:object_r:httpd_config_t
 /etc/httpd/conf.*		system_u:object_r:httpd_config_t
 /etc/httpd/logs			system_u:object_r:httpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/certwatch.fc policy-1.25.4/file_contexts/program/certwatch.fc
--- nsapolicy/file_contexts/program/certwatch.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.25.4/file_contexts/program/certwatch.fc	2005-08-11 23:07:13.000000000 -0400
@@ -0,0 +1,3 @@
+# certwatch.fc
+/usr/bin/certwatch	-- system_u:object_r:certwatch_exec_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.25.4/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/file_contexts/program/cups.fc	2005-08-11 23:07:13.000000000 -0400
@@ -5,6 +5,7 @@
 /var/cache/alchemist/printconf.* system_u:object_r:cupsd_rw_etc_t
 /etc/cups/client\.conf	--	system_u:object_r:etc_t
 /etc/cups/cupsd\.conf.* --	system_u:object_r:cupsd_rw_etc_t
+/etc/cups/classes\.conf.* --	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/lpoptions	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/printers\.conf.* --	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/ppd/.*	--	system_u:object_r:cupsd_rw_etc_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.25.4/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.25.4/file_contexts/program/postgresql.fc	2005-08-11 23:07:13.000000000 -0400
@@ -14,3 +14,7 @@
 /usr/lib/pgsql/test/regress/.*\.so	-- system_u:object_r:shlib_t
 /usr/lib/pgsql/test/regress/.*\.sh	-- system_u:object_r:bin_t
 /usr/lib/pgsql/test/regress/pg_regress	-- system_u:object_r:postgresql_exec_t
+ifdef(`distro_redhat', `
+/usr/share/jonas/pgsql(/.*)?       system_u:object_r:postgresql_db_t
+/var/log/rhdb/rhdb(/.*)?           system_u:object_r:postgresql_log_t 
+')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pppd.fc policy-1.25.4/file_contexts/program/pppd.fc
--- nsapolicy/file_contexts/program/pppd.fc	2005-08-11 06:57:15.000000000 -0400
+++ policy-1.25.4/file_contexts/program/pppd.fc	2005-08-11 23:07:13.000000000 -0400
@@ -13,9 +13,13 @@
 /var/run/(i)?ppp.*pid	--	system_u:object_r:pppd_var_run_t
 /var/log/ppp-connect-errors.* -- system_u:object_r:pppd_log_t
 /var/log/ppp/.*	--	system_u:object_r:pppd_log_t
-/etc/ppp/ip-down.*	--	system_u:object_r:bin_t
-/etc/ppp/ip-up.*	--	system_u:object_r:bin_t
-/etc/ppp/ipv6-up	--	system_u:object_r:bin_t
-/etc/ppp/ipv6-down	--	system_u:object_r:bin_t
+/etc/ppp/ip-down\..*	--	system_u:object_r:bin_t
+/etc/ppp/ip-up\..*	--	system_u:object_r:bin_t
+/etc/ppp/ipv6-up\..*	--	system_u:object_r:bin_t
+/etc/ppp/ipv6-down\..*	--	system_u:object_r:bin_t
 /etc/ppp/plugins/rp-pppoe\.so 	--	system_u:object_r:shlib_t
-/etc/ppp/resolv\.conf 	--   system_u:object_r:pppd_etc_rw_t
+/etc/ppp/resolv\.conf 	--	system_u:object_r:pppd_etc_rw_t
+# Fix pptp sockets
+/var/run/pptp(/.*)?	--	system_u:object_r:pptp_var_run_t
+# Fix /etc/ppp {up,down} family scripts (see man pppd)
+/etc/ppp/(auth|ip(v6|x)?)-(up|down)	--	system_u:object_r:pppd_script_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/radvd.fc policy-1.25.4/file_contexts/program/radvd.fc
--- nsapolicy/file_contexts/program/radvd.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.4/file_contexts/program/radvd.fc	2005-08-15 10:01:10.000000000 -0400
@@ -2,3 +2,4 @@
 /etc/radvd\.conf	--	system_u:object_r:radvd_etc_t
 /usr/sbin/radvd		--	system_u:object_r:radvd_exec_t
 /var/run/radvd\.pid	--	system_u:object_r:radvd_var_run_t
+/var/run/radvd(/.*)?		system_u:object_r:radvd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.25.4/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/file_contexts/types.fc	2005-08-11 23:07:13.000000000 -0400
@@ -503,8 +503,8 @@
 /usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird --      system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird-bin -- system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/open-browser\.sh -- system_u:object_r:bin_t
-/usr/lib(64)?/[^/]*thunderbird[^/]*/run-mozilla\.sh -- system_u:object_r:bin_t
-/usr/lib(64)?/[^/]*thunderbird[^/]*/mozilla-xremote-client -- system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*/run-mozilla\.sh -- system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*/mozilla-xremote-client -- system_u:object_r:bin_t
 
 #
 # /srv
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.25.4/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/base_user_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -21,8 +21,8 @@
 type $1_untrusted_content_tmp_t, file_type, $1_file_type, sysadmfile, tmpfile, customizable, polymember;
 
 # Allow user to relabel untrusted content
-allow $1_t $1_untrusted_content_t:{ dir file } { getattr unlink relabelto relabelfrom };
-allow $1_t $1_untrusted_content_tmp_t:{ dir file } { getattr unlink relabelto relabelfrom };
+allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
+allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
 
 # Read content
 read_content($1_t, $1)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.25.4/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/global_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -595,6 +595,18 @@
 ')dnl end polyinstantiater
 
 # 
+# Domain that is allow to read anonymous data off the network
+# without providing authentication.
+# Also define boolean to allow anonymous writing
+#
+define(`anonymous_domain', `
+r_dir_file($1_t, ftpd_anon_t)
+bool allow_$1_anon_write false;
+if (allow_$1_anon_write) {
+create_dir_file($1_t,ftpd_anon_rw_t)
+}
+')
+# 
 # Define a domain that can do anything, so that it is
 # effectively unconfined by the SELinux policy.  This
 # means that it is only restricted by the normal Linux 
@@ -727,3 +739,15 @@
 allow $1 removable_t:filesystem getattr;
 
 ')
+
+define(`authentication_domain', `
+can_ypbind($1)
+can_kerberos($1)
+can_ldap($1)
+can_resolve($1)
+can_winbind($1)
+r_dir_file($1, cert_t)
+allow $1 { random_device_t urandom_device_t }:chr_file { getattr read };
+allow $1 self:capability { audit_write audit_control };
+dontaudit $1 shadow_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.25.4/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/macros/network_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -16,9 +16,7 @@
 # Allow the domain to send or receive using any network interface.
 # netif_type is a type attribute for all network interface types.
 #
-allow $1 netif_type:netif { $2_send rawip_send };
-allow $1 netif_type:netif { $2_recv rawip_recv };
-
+allow $1 netif_t:netif { $2_recv $2_send rawip_send rawip_recv };
 #
 # Allow the domain to send to or receive from any node.
 # node_type is a type attribute for all node types.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.25.4/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-07-12 08:50:43.000000000 -0400
+++ policy-1.25.4/macros/program/apache_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -23,6 +23,7 @@
 domain_auto_trans(httpd_t, httpd_$1_script_exec_t, httpd_$1_script_t)
 allow httpd_t httpd_$1_script_t:process { signal sigkill sigstop };
 allow httpd_t httpd_$1_script_exec_t:dir r_dir_perms;
+allow httpd_t httpd_$1_script_exec_t:file r_file_perms;
 
 allow httpd_$1_script_t httpd_t:fd use;
 allow httpd_$1_script_t httpd_t:process sigchld;
@@ -101,7 +102,9 @@
 read_fonts(httpd_$1_script_t)
 r_dir_file(httpd_$1_script_t, httpd_$1_script_ro_t)
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
+allow httpd_$1_script_t httpd_$1_script_rw_t:sock_file rw_file_perms;
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
+anonymous_domain(httpd_$1_script)
 
 if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 create_dir_file(httpd_$1_script_t, httpdcontent)
@@ -136,9 +139,10 @@
 if (httpd_builtin_scripting) {
 r_dir_file(httpd_t, httpd_$1_script_ro_t)
 create_dir_file(httpd_t, httpd_$1_script_rw_t)
+allow httpd_t httpd_$1_script_rw_t:sock_file rw_file_perms;
 ra_dir_file(httpd_t, httpd_$1_script_ra_t)
-}
 r_dir_file(httpd_t, httpd_$1_content_t)
+}
 
 ')
 define(`apache_user_domain', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.25.4/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/cdrecord_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -27,16 +27,8 @@
 
 can_resmgrd_connect($1_cdrecord_t)
 
-allow $1_cdrecord_t { tmp_t home_root_t }:dir search;
+read_content($1_cdrecord_t, $1, cdrecord) 
 
-# allow cdrecord to read user files
-r_dir_file($1_cdrecord_t, { $1_home_t $1_tmp_t })
-if (use_nfs_home_dirs) {
-r_dir_file($1_cdrecord_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-r_dir_file($1_cdrecord_t, cifs_t)
-}
 allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
@@ -50,6 +42,8 @@
 allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid dac_override sys_rawio };
 allow $1_cdrecord_t self:process { getsched setsched fork sigchld sigkill };
 allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
-read_content($1_cdrecord_t, $1)
+allow $1_cdrecord_t $1_home_t:dir search;
+allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
+allow $1_cdrecord_t $1_home_t:file r_file_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.25.4/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-07-19 10:57:05.000000000 -0400
+++ policy-1.25.4/macros/program/chkpwd_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -23,28 +23,15 @@
 allow $1_chkpwd_t proc_t:file read;
 
 can_getcon($1_chkpwd_t)
-can_ypbind($1_chkpwd_t)
-can_kerberos($1_chkpwd_t)
-can_ldap($1_chkpwd_t)
-can_resolve($1_chkpwd_t)
+authentication_domain($1_chkpwd_t)
 
 ifelse($1, system, `
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
 allow auth_chkpwd sbin_t:dir search;
 allow auth_chkpwd self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
-allow auth_chkpwd self:capability { audit_write audit_control };
 
 dontaudit system_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
-dontaudit auth_chkpwd shadow_t:file { getattr read };
-can_ypbind(auth_chkpwd)
-can_kerberos(auth_chkpwd)
-can_ldap(auth_chkpwd)
-ifdef(`winbind.te', `
-r_dir_file(auth_chkpwd, winbind_var_run_t)
-')
-r_dir_file(auth_chkpwd, cert_t)
-r_dir_file($1_chkpwd_t, cert_t)
-allow $1_chkpwd_t { random_device_t urandom_device_t }:chr_file { getattr read };
+authentication_domain(auth_chkpwd)
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ethereal_macros.te policy-1.25.4/macros/program/ethereal_macros.te
--- nsapolicy/macros/program/ethereal_macros.te	2005-07-05 15:25:49.000000000 -0400
+++ policy-1.25.4/macros/program/ethereal_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -38,11 +38,10 @@
 role $1_r types $1_ethereal_t;
 
 # Manual transition from userhelper 
-# FIXME: Need to handle the fallback case, which requires userhelper support
 ifdef(`userhelper.te', `
-allow userhelperdomain sysadm_ethereal_t:process { transition siginh rlimitinh noatsecure };
-allow sysadm_ethereal_t userhelperdomain:fd use;
-allow sysadm_ethereal_t userhelperdomain:process sigchld;
+allow userhelperdomain $1_ethereal_t:process { transition siginh rlimitinh noatsecure };
+allow $1_ethereal_t userhelperdomain:fd use;
+allow $1_ethereal_t userhelperdomain:process sigchld;
 ') dnl userhelper
 
 # X, GNOME
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/evolution_macros.te policy-1.25.4/macros/program/evolution_macros.te
--- nsapolicy/macros/program/evolution_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/evolution_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -64,7 +64,7 @@
 allow $1_evolution_server_t ldap_port_t:tcp_socket name_connect;
 
 # Look in /etc/pki
-allow $1_evolution_server_t cert_t:dir r_dir_perms;
+r_dir_file($1_evolution_server_t, cert_t)
 
 ') dnl evolution_data_server
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mail_client_macros.te policy-1.25.4/macros/program/mail_client_macros.te
--- nsapolicy/macros/program/mail_client_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/mail_client_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -54,10 +54,15 @@
 ') 
 ifdef(`dbusd.te', `
 dbusd_client(system, $1)
+allow $1_t system_dbusd_t:dbus send_msg;
 dbusd_client($2, $1)
 allow $1_t $2_dbusd_t:dbus send_msg;
 ifdef(`cups.te', `
 allow cupsd_t $1_t:dbus send_msg;
 ') 
 ') 
+# Allow the user domain to signal/ps.
+can_ps($2_t, $1_t)
+allow $2_t $1_t:process signal_perms;
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.25.4/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/mozilla_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -139,7 +139,14 @@
 }
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 
+ifdef(`dbusd.te', `
 dbusd_client(system, $1_mozilla)
+allow $1_mozilla_t system_dbusd_t:dbus send_msg;
+ifdef(`cups.te', `
+allow cupsd_t $1_mozilla_t:dbus send_msg;
+')
+')
+
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `
 r_dir_file($1_mozilla_t, { httpd_$1_script_exec_t httpd_$1_content_t })
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.25.4/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/spamassassin_macros.te	2005-08-12 08:02:44.000000000 -0400
@@ -85,7 +85,7 @@
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
 can_resolve($1_spamassassin_t)
-# set tunable if you give spamassassin full network access.
+# set tunable if you have spamassassin do DNS lookups
 if (spamassasin_can_network) {
 can_network($1_spamassassin_t)
 allow $1_spamassassin_t port_type:tcp_socket name_connect;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.25.4/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-05-25 11:28:11.000000000 -0400
+++ policy-1.25.4/macros/program/su_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -23,9 +23,13 @@
 
 define(`su_restricted_domain', `
 # Derived domain based on the calling user domain and the program.
-ifdef(`support_polyinstantiation', `
-type $1_su_t, domain, privlog, privrole, privuser, privowner, privfd, nscd_client_domain, mlsfileread, mlsfilewrite, mlsfileupgrade, mlsfiledowngrade, mlsprocsetsl;',`
 type $1_su_t, domain, privlog, privrole, privuser, privowner, privfd, nscd_client_domain;
+ifdef(`support_polyinstantiation', `
+typeattribute $1_su_t mlsfileread;
+typeattribute $1_su_t mlsfilewrite;
+typeattribute $1_su_t mlsfileupgrade;
+typeattribute $1_su_t mlsfiledowngrade;
+typeattribute $1_su_t mlsprocsetsl;
 ')
 
 # for SSP
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/thunderbird_macros.te policy-1.25.4/macros/program/thunderbird_macros.te
--- nsapolicy/macros/program/thunderbird_macros.te	2005-08-11 06:57:18.000000000 -0400
+++ policy-1.25.4/macros/program/thunderbird_macros.te	2005-08-11 23:07:13.000000000 -0400
@@ -38,6 +38,7 @@
 x_client_domain($1_thunderbird, $1)
 mail_client_domain($1_thunderbird, $1)
 
+allow $1_thunderbird_t self:process signull;
 allow $1_thunderbird_t fs_t:filesystem getattr;
 
 # GNOME support
@@ -54,9 +55,6 @@
 can_network_client_tcp($1_thunderbird_t, http_port_t) 
 allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
 
-allow $1_thunderbird_t self:process { execheap execstack };
-if (allow_execmem) {
-allow $1_thunderbird_t self:process execmem;
-}
+allow $1_thunderbird_t self:process { execheap execmem execstack };
 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.25.4/Makefile
--- nsapolicy/Makefile	2005-07-06 17:15:06.000000000 -0400
+++ policy-1.25.4/Makefile	2005-08-11 23:14:04.000000000 -0400
@@ -15,6 +15,9 @@
 # Set to y if MLS is enabled in the policy.
 MLS=n
 
+# Set to y if MCS is enabled in the policy
+MCS=n
+
 FLASKDIR = flask/
 PREFIX = /usr
 BINDIR = $(PREFIX)/bin
@@ -24,14 +27,18 @@
 GENHOMEDIRCON = $(SBINDIR)/genhomedircon
 SETFILES = $(SBINDIR)/setfiles
 VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
+PREVERS := 19
 KERNVERS := $(shell cat /selinux/policyvers)
 POLICYVER := policy.$(VERS)
 TOPDIR = $(DESTDIR)/etc/selinux
+TYPE=strict
 ifeq ($(MLS),y)
 TYPE=mls
-else
-TYPE=strict
 endif
+ifeq ($(MCS),y)
+TYPE=mcs
+endif
+
 INSTALLDIR = $(TOPDIR)/$(TYPE)
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
@@ -54,6 +61,10 @@
 POLICYFILES += mls
 CHECKPOLMLS += -M
 endif
+ifeq ($(MCS), y)
+POLICYFILES += mcs
+CHECKPOLMLS += -M
+endif
 DEFCONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
@@ -148,8 +159,10 @@
 	@echo "Compiling policy ..."
 	@mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
-ifneq ($(MLS),y)
+ifneq ($(VERS),$(PREVERS))
+	$(CHECKPOLICY) -c $(PREVERS) -o $(POLICYPATH)/policy.$(PREVERS) policy.conf
 endif
+
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
 
@@ -162,7 +175,11 @@
 
 reload tmp/load: $(LOADPATH) 
 	@echo "Loading Policy ..."
+ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
+else
+	$(LOADPOLICY) $(POLICYPATH)/policy.$(PREVERS)
+endif
 	touch tmp/load
 
 load: tmp/load $(FCPATH) 
@@ -328,3 +345,22 @@
 	@sed "s/MLS=n/MLS=y/" Makefile > Makefile.new
 	@mv Makefile.new Makefile
 	@echo "Done"
+
+mcsconvert: 
+	@for file in $(CONTEXTFILES); do \
+		echo "Converting $$file"; \
+		sed -e 's/_t\b/_t:s0/g' $$file > $$file.new && \
+		mv $$file.new $$file; \
+	done
+	@for file in $(USER_FILES); do \
+		echo "Converting $$file"; \
+		sed -r -e 's/\;/ level s0 range s0;/' $$file | \
+		sed -r -e 's/(user (root|system_u).*);/\1 - s0:c0.c127;/' > $$file.new; \
+		mv $$file.new $$file; \
+	done
+	@sed -e '/sid kernel/s/s0/s0 - s0:c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@echo "Enabling MCS in the Makefile"
+	@sed "s/MCS=y/MCS=y/" Makefile > Makefile.new
+	@mv Makefile.new Makefile
+	@echo "Done"
+
diff --exclude-from=exclude -N -u -r nsapolicy/mcs policy-1.25.4/mcs
--- nsapolicy/mcs	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.25.4/mcs	2005-08-11 23:15:17.000000000 -0400
@@ -0,0 +1,212 @@
+#
+# Define sensitivities 
+#
+# Each sensitivity has a name and zero or more aliases.
+#
+# MCS is single-sensitivity.
+#
+sensitivity s0;
+
+#
+# Define the ordering of the sensitivity levels (least to greatest)
+#
+dominance { s0 }
+
+
+#
+# Define the categories
+#
+# Each category has a name and zero or more aliases.
+#
+category c0;
+category c1;
+category c2;
+category c3;
+category c4;
+category c5;
+category c6;
+category c7;
+category c8;
+category c9;
+category c10;
+category c11;
+category c12;
+category c13;
+category c14;
+category c15;
+category c16;
+category c17;
+category c18;
+category c19;
+category c20;
+category c21;
+category c22;
+category c23;
+category c24;
+category c25;
+category c26;
+category c27;
+category c28;
+category c29;
+category c30;
+category c31;
+category c32;
+category c33;
+category c34;
+category c35;
+category c36;
+category c37;
+category c38;
+category c39;
+category c40;
+category c41;
+category c42;
+category c43;
+category c44;
+category c45;
+category c46;
+category c47;
+category c48;
+category c49;
+category c50;
+category c51;
+category c52;
+category c53;
+category c54;
+category c55;
+category c56;
+category c57;
+category c58;
+category c59;
+category c60;
+category c61;
+category c62;
+category c63;
+category c64;
+category c65;
+category c66;
+category c67;
+category c68;
+category c69;
+category c70;
+category c71;
+category c72;
+category c73;
+category c74;
+category c75;
+category c76;
+category c77;
+category c78;
+category c79;
+category c80;
+category c81;
+category c82;
+category c83;
+category c84;
+category c85;
+category c86;
+category c87;
+category c88;
+category c89;
+category c90;
+category c91;
+category c92;
+category c93;
+category c94;
+category c95;
+category c96;
+category c97;
+category c98;
+category c99;
+category c100;
+category c101;
+category c102;
+category c103;
+category c104;
+category c105;
+category c106;
+category c107;
+category c108;
+category c109;
+category c110;
+category c111;
+category c112;
+category c113;
+category c114;
+category c115;
+category c116;
+category c117;
+category c118;
+category c119;
+category c120;
+category c121;
+category c122;
+category c123;
+category c124;
+category c125;
+category c126;
+category c127;
+
+
+#
+# Each MCS level specifies a sensitivity and zero or more categories which may
+# be associated with that sensitivity.
+#
+level s0:c0.c127;
+
+#
+# Define the MCS policy
+#
+# mlsconstrain class_set perm_set expression ;
+#
+# mlsvalidatetrans class_set expression ;
+#
+# expression : ( expression )
+#	     | not expression
+#	     | expression and expression
+#	     | expression or expression
+#	     | u1 op u2
+#	     | r1 role_mls_op r2
+#	     | t1 op t2
+#	     | l1 role_mls_op l2
+#	     | l1 role_mls_op h2
+#	     | h1 role_mls_op l2
+#	     | h1 role_mls_op h2
+#	     | l1 role_mls_op h1
+#	     | l2 role_mls_op h2
+#	     | u1 op names
+#	     | u2 op names
+#	     | r1 op names
+#	     | r2 op names
+#	     | t1 op names
+#	     | t2 op names
+#	     | u3 op names (NOTE: this is only available for mlsvalidatetrans)
+#	     | r3 op names (NOTE: this is only available for mlsvalidatetrans)
+#	     | t3 op names (NOTE: this is only available for mlsvalidatetrans)
+#
+# op : == | !=
+# role_mls_op : == | != | eq | dom | domby | incomp
+#
+# names : name | { name_list }
+# name_list : name | name_list name
+#
+
+#
+# MCS policy for the file classes
+#
+# Constrain file access so that the high range of the process dominates
+# the high range of the file.  We use the high range of the process so
+# that processes can always simply run at s0.
+#
+# Only files are constrained by MCS at this stage.
+#
+mlsconstrain file { read write setattr append unlink link rename
+		    create ioctl lock execute } (h1 dom h2);
+
+
+# XXX
+#
+# For some reason, we need to reference the mlsfileread attribute
+# or we get a build error.  Below is a dummy entry to do this.
+mlsconstrain xextension query ( t1 == mlsfileread );
+
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.25.4/net_contexts
--- nsapolicy/net_contexts	2005-08-11 06:57:10.000000000 -0400
+++ policy-1.25.4/net_contexts	2005-08-11 23:07:13.000000000 -0400
@@ -223,14 +223,6 @@
 #
 # interface netif_context default_msg_context
 #
-netifcon lo system_u:object_r:netif_lo_t system_u:object_r:unlabeled_t
-netifcon eth0 system_u:object_r:netif_eth0_t system_u:object_r:unlabeled_t
-netifcon eth1 system_u:object_r:netif_eth1_t system_u:object_r:unlabeled_t
-netifcon eth2 system_u:object_r:netif_eth2_t system_u:object_r:unlabeled_t
-netifcon ippp0 system_u:object_r:netif_ippp0_t system_u:object_r:unlabeled_t
-netifcon ipsec0 system_u:object_r:netif_ipsec0_t system_u:object_r:unlabeled_t
-netifcon ipsec1 system_u:object_r:netif_ipsec1_t system_u:object_r:unlabeled_t
-netifcon ipsec2 system_u:object_r:netif_ipsec2_t system_u:object_r:unlabeled_t
 
 # Nodes (default = initial SID "node")
 #
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.25.4/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.25.4/tunables/distro.tun	2005-08-11 23:07:13.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.25.4/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-08-11 06:57:20.000000000 -0400
+++ policy-1.25.4/tunables/tunable.tun	2005-08-11 23:07:13.000000000 -0400
@@ -1,5 +1,5 @@
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -17,7 +17,7 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.25.4/types/file.te
--- nsapolicy/types/file.te	2005-08-11 06:57:20.000000000 -0400
+++ policy-1.25.4/types/file.te	2005-08-11 23:07:13.000000000 -0400
@@ -333,6 +333,7 @@
 
 # Type for anonymous FTP data, used by ftp and rsync
 type ftpd_anon_t, file_type, sysadmfile, customizable;
+type ftpd_anon_rw_t, file_type, sysadmfile, customizable;
 
 allow customizable self:filesystem associate;
 
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.25.4/types/network.te
--- nsapolicy/types/network.te	2005-08-11 06:57:20.000000000 -0400
+++ policy-1.25.4/types/network.te	2005-08-11 23:07:13.000000000 -0400
@@ -74,15 +74,6 @@
 # interfaces in net_contexts or net_contexts.mls.
 #
 type netif_t, netif_type;
-type netif_eth0_t, netif_type;
-type netif_eth1_t, netif_type;
-type netif_eth2_t, netif_type;
-type netif_lo_t, netif_type;
-type netif_ippp0_t, netif_type;
-
-type netif_ipsec0_t, netif_type;
-type netif_ipsec1_t, netif_type;
-type netif_ipsec2_t, netif_type;
 
 #
 # node_t is the default type of network nodes.

--------------010209050608090700030500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
