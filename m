Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j29D0QDo023476
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 08:00:26 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j29Cr6hM013890
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 12:53:06 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j29CvB9s031354
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 07:57:11 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j29CvAHw031353
	for selinux@tycho.nsa.gov; Wed, 9 Mar 2005 07:57:10 -0500
Message-ID: <422E893D.1020802@redhat.com>
Date: Wed, 09 Mar 2005 00:27:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest policy
Content-Type: multipart/mixed;
 boundary="------------030501090405020703050002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030501090405020703050002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lots of policy cleanup via Ivan's Patches
       Use read_sysctl
       Cleanup of homedir macros
      
Fixes to allow amanda to read file system

Change apache stream sockets to use create_stream_socket_perms

Eliminate cyrus_r

Cleanup dhcpc.te so it can be used in targeted policy

Add ftpd_anon_rw_t so that upload can be made to work with anonymous ftp 
sites.

Additional rules to allow postfix to work correctly in targeted policy

Allow snmpd to communicate with its own fifo_file






-- 
Learn, Network and Experience Open Source.
Red Hat Summit, New Orleans 2005
http://www.redhat.com/promo/summit/


--------------030501090405020703050002
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.21.15/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/fsadm.te	2005-03-07 09:36:55.000000000 -0500
@@ -25,8 +25,7 @@
 r_dir_file(fsadm_t, proc_t)
 
 # Read system variables in /proc/sys
-allow fsadm_t sysctl_kernel_t:file r_file_perms;
-allow fsadm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(fsadm_t)
 
 # for /dev/shm
 allow fsadm_t tmpfs_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/logrotate.te policy-1.21.15/domains/program/logrotate.te
--- nsapolicy/domains/program/logrotate.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/logrotate.te	2005-03-07 09:36:55.000000000 -0500
@@ -61,10 +61,9 @@
 allow logrotate_t pidfile:file r_file_perms;
 
 # Read /proc/PID directories for all domains.
+read_sysctl(logrotate_t)
 allow logrotate_t proc_t:dir r_dir_perms;
 allow logrotate_t proc_t:{ file lnk_file } r_file_perms;
-allow logrotate_t { sysctl_t sysctl_kernel_t }:dir search;
-allow logrotate_t sysctl_kernel_t:file { getattr read };
 allow logrotate_t domain:notdevfile_class_set r_file_perms;
 allow logrotate_t domain:dir r_dir_perms;
 allow logrotate_t exec_type:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.21.15/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/modutil.te	2005-03-07 09:36:55.000000000 -0500
@@ -138,8 +138,10 @@
 allow insmod_t { usbfs_t usbdevfs_t }:filesystem mount;
 
 # Rules for /proc/sys/kernel/tainted
-allow insmod_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
+read_sysctl(insmod_t)
+allow insmod_t proc_t:dir search;
 allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
+
 allow insmod_t proc_t:file { getattr read };
 allow insmod_t proc_t:lnk_file read;
 
@@ -218,8 +220,7 @@
 allow update_modules_t proc_t:dir search;
 allow update_modules_t proc_t:file r_file_perms;
 allow update_modules_t { self proc_t }:lnk_file read;
-allow update_modules_t { sysctl_t sysctl_kernel_t }:dir search;
-allow update_modules_t sysctl_kernel_t:file { getattr read };
+read_sysctl(update_modules_t)
 allow update_modules_t self:dir search;
 allow update_modules_t self:unix_stream_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.21.15/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/acct.te	2005-03-07 09:36:55.000000000 -0500
@@ -46,8 +46,7 @@
 
 allow acct_t proc_t:file { read getattr };
 
-allow acct_t { sysctl_kernel_t sysctl_t }:dir search;
-allow acct_t sysctl_kernel_t:file read;
+read_sysctl(acct_t)
 
 dontaudit acct_t sysadm_home_dir_t:dir { getattr search };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.21.15/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/amanda.te	2005-03-07 09:36:55.000000000 -0500
@@ -31,7 +31,7 @@
 # General declarations
 ######################
 
-type amanda_t, domain, privlog;
+type amanda_t, domain, privlog, auth, nscd_client_domain ;
 role system_r types amanda_t;
 
 # type for the amanda executables
@@ -141,9 +141,7 @@
 allow amanda_t fs_t:filesystem getattr;
 
 # access to sysctl_kernel_t ( proc/sys/kernel/* )
-allow amanda_t sysctl_kernel_t:dir search;
-allow amanda_t sysctl_kernel_t:file read;
-
+read_sysctl(amanda_t)
 
 #####################
 # process permissions
@@ -275,8 +273,7 @@
 allow amanda_recover_t proc_t:file { getattr read };
 
 # access to sysctl_kernel_t
-allow amanda_recover_t sysctl_kernel_t:dir search;
-allow amanda_recover_t sysctl_kernel_t:file read;
+read_sysctl(amanda_recover_t)
 
 # access to dev_t and similar
 allow amanda_recover_t device_t:dir search;
@@ -304,3 +301,7 @@
 type amanda_port_t, port_type;
 allow inetd_t amanda_port_t:{ tcp_socket udp_socket } name_bind;
 
+allow amanda_t file_type:dir {getattr read search };
+allow amanda_t file_type:file {getattr read };
+logdir_domain(amanda)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.15/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/apache.te	2005-03-08 18:33:36.000000000 -0500
@@ -80,8 +80,7 @@
 
 allow httpd_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 
-allow httpd_t sysctl_kernel_t:dir search;
-allow httpd_t sysctl_kernel_t:file read;
+read_sysctl(httpd_t)
 
 # for modules that want to access /etc/mtab and /proc/meminfo
 allow httpd_t { proc_t etc_runtime_t }:file { getattr read };
@@ -108,7 +107,7 @@
 allow httpd_suexec_t httpd_log_t:dir search;
 allow httpd_suexec_t httpd_log_t:file { append getattr };
 allow httpd_suexec_t httpd_t:fifo_file getattr;
-allow httpd_suexec_t self:unix_stream_socket create_socket_perms;
+allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
 
 allow httpd_suexec_t etc_t:file { getattr read };
 read_locale(httpd_suexec_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.21.15/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/apmd.te	2005-03-07 09:36:55.000000000 -0500
@@ -31,8 +31,7 @@
 
 allow apmd_t device_t:lnk_file read;
 allow apmd_t proc_t:file { getattr read };
-allow apmd_t sysctl_kernel_t:dir search;
-allow apmd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(apmd_t)
 allow apmd_t self:unix_dgram_socket create_socket_perms;
 allow apmd_t self:unix_stream_socket create_stream_socket_perms;
 allow apmd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/backup.te policy-1.21.15/domains/program/unused/backup.te
--- nsapolicy/domains/program/unused/backup.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/backup.te	2005-03-07 09:36:55.000000000 -0500
@@ -42,8 +42,7 @@
 allow backup_t proc_t:dir r_dir_perms;
 allow backup_t proc_t:file r_file_perms;
 allow backup_t proc_t:lnk_file { getattr read };
-allow backup_t { sysctl_t sysctl_kernel_t }:dir r_dir_perms;
-allow backup_t sysctl_kernel_t:file read;
+read_sysctl(backup_t)
 
 allow backup_t self:fifo_file rw_file_perms;
 allow backup_t self:process { signal sigchld fork };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bootloader.te policy-1.21.15/domains/program/unused/bootloader.te
--- nsapolicy/domains/program/unused/bootloader.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/bootloader.te	2005-03-07 09:36:55.000000000 -0500
@@ -144,8 +144,7 @@
 allow bootloader_t proc_t:lnk_file { getattr read };
 allow bootloader_t proc_mdstat_t:file r_file_perms;
 allow bootloader_t self:dir { getattr search read };
-allow bootloader_t sysctl_kernel_t:dir search;
-allow bootloader_t sysctl_kernel_t:file { getattr read };
+read_sysctl(bootloader_t)
 allow bootloader_t etc_runtime_t:file r_file_perms;
 
 allow bootloader_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/calamaris.te policy-1.21.15/domains/program/unused/calamaris.te
--- nsapolicy/domains/program/unused/calamaris.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/calamaris.te	2005-03-07 09:36:55.000000000 -0500
@@ -41,8 +41,9 @@
 allow calamaris_t urandom_device_t:chr_file { getattr read };
 
 allow calamaris_t self:process { fork signal_perms setsched };
-allow calamaris_t { proc_t sysctl_kernel_t }:dir search;
-allow calamaris_t { proc_t sysctl_kernel_t }:file { getattr read };
+read_sysctl(calamaris_t)
+allow calamaris_t proc_t:dir search;
+allow calamaris_t proc_t:file { getattr read };
 allow calamaris_t { proc_t self }:lnk_file read;
 allow calamaris_t self:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clamav.te policy-1.21.15/domains/program/unused/clamav.te
--- nsapolicy/domains/program/unused/clamav.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/clamav.te	2005-03-07 09:36:55.000000000 -0500
@@ -19,8 +19,7 @@
 read_locale(freshclam_t)
 
 # not sure why it needs this
-allow freshclam_t sysctl_kernel_t:dir search;
-allow freshclam_t sysctl_kernel_t:file { getattr read };
+read_sysctl(freshclam_t)
 
 can_network_server(freshclam_t)
 can_ypbind(freshclam_t)
@@ -79,9 +78,8 @@
 allow clamd_t var_lib_t:dir search;
 r_dir_file(clamd_t, clamav_var_lib_t)
 r_dir_file(clamd_t, etc_t)
-allow clamd_t sysctl_t:dir r_dir_perms;
 # allow access /proc/sys/kernel/version
-r_dir_file(clamd_t, sysctl_kernel_t);
+read_sysctl(clamd_t)
 allow clamd_t self:unix_stream_socket create_stream_socket_perms;
 allow clamd_t self:unix_dgram_socket create_stream_socket_perms;
 allow clamd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/courier.te policy-1.21.15/domains/program/unused/courier.te
--- nsapolicy/domains/program/unused/courier.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/courier.te	2005-03-07 09:36:55.000000000 -0500
@@ -137,5 +137,4 @@
 ifdef(`crond.te', `
 system_crond_entry(sqwebmail_cron_exec_t, courier_sqwebmail_t)
 ')
-allow courier_sqwebmail_t { sysctl_t sysctl_kernel_t }:dir search;
-allow courier_sqwebmail_t sysctl_kernel_t:file { getattr read };
+read_sysctl(courier_sqwebmail_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.21.15/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/cups.te	2005-03-07 09:36:55.000000000 -0500
@@ -60,8 +60,9 @@
 allow cupsd_t proc_t:file r_file_perms;
 allow cupsd_t proc_t:dir r_dir_perms;
 allow cupsd_t self:file { getattr read };
-allow cupsd_t { sysctl_t sysctl_kernel_t sysctl_dev_t }:dir search;
-allow cupsd_t { sysctl_kernel_t sysctl_dev_t }:file { getattr read };
+read_sysctl(cupsd_t)
+allow cupsd_t sysctl_dev_t:dir search;
+allow cupsd_t sysctl_dev_t:file { getattr read };
 
 # for /etc/printcap
 dontaudit cupsd_t etc_t:file write;
@@ -239,6 +240,8 @@
 allow cupsd_config_t logrotate_t:fd use;
 ')dnl end if logrotate.te
 allow cupsd_config_t system_crond_t:fd use;
+allow cupsd_config_t crond_t:fifo_file read;
+allow cupsd_t crond_t:fifo_file read;
 
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;
@@ -246,6 +249,7 @@
 ifdef(`targeted_policy', `
 can_unix_connect(cupsd_t, initrc_t)
 allow cupsd_t initrc_t:dbus send_msg;
+allow initrc_t cupsd_t:dbus send_msg;
 ')
 
 ifdef(`targeted_policy', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.21.15/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/cyrus.te	2005-03-07 09:36:55.000000000 -0500
@@ -6,7 +6,6 @@
 # cyrusd_exec_t is the type of the cyrusd executable.
 # cyrusd_key_t is the type of the cyrus private key files
 daemon_domain(cyrus)
-role cyrus_r types cyrus_t;
 
 general_domain_access(cyrus_t)
 file_type_auto_trans(cyrus_t, var_run_t, cyrus_var_run_t, sock_file)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.21.15/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/dhcpc.te	2005-03-08 19:06:31.000000000 -0500
@@ -78,9 +78,11 @@
 allow dhcpc_t proc_net_t:dir search;
 allow dhcpc_t { proc_t proc_net_t }:file { getattr read };
 allow dhcpc_t self:file { getattr read };
-allow dhcpc_t sysctl_kernel_t:dir search;
-allow dhcpc_t sysctl_kernel_t:file read;
-allow dhcpc_t { userdomain run_init_t }:fd use;
+read_sysctl(dhcpc_t)
+allow dhcpc_t userdomain:fd use;
+ifdef(`run_init.te', `
+allow dhcpc_t run_init_t:fd use;
+')
 
 # Use capabilities
 allow dhcpc_t self:capability { dac_override fsetid net_admin net_raw net_bind_service sys_resource sys_tty_config };
@@ -119,7 +121,9 @@
 allow dhcpc_t bin_t:lnk_file read;
 can_exec(dhcpc_t, { bin_t shell_exec_t })
 
+ifdef(`hostname.te', `
 domain_auto_trans(dhcpc_t, hostname_exec_t, hostname_t)
+')
 dontaudit dhcpc_t { ttyfile ptyfile tty_device_t }:chr_file { read write };
 allow dhcpc_t { userdomain kernel_t }:fd use;
 
@@ -130,3 +134,13 @@
 allow dhcpc_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit dhcpc_t domain:dir getattr;
 allow dhcpc_t initrc_var_run_t:file rw_file_perms;
+#
+# dhclient sometimes starts ypbind and ntdp
+#
+can_exec(dhcpc_t, initrc_exec_t)
+ifdef(`ypbind.te', `
+domain_auto_trans(dhcpc_t, ypbind_exec_t, ypbind_t)
+')
+ifdef(`ntpd.te', `
+domain_auto_trans(dhcpc_t, ntpd_exec_t, ntpd_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.21.15/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/dovecot.te	2005-03-07 09:36:55.000000000 -0500
@@ -49,8 +49,7 @@
 allow dovecot_auth_t etc_t:file { getattr read };
 allow dovecot_auth_t { self proc_t }:file { getattr read };
 read_locale(dovecot_auth_t)
-allow dovecot_auth_t sysctl_kernel_t:dir search;
-allow dovecot_auth_t sysctl_kernel_t:file read;
+read_sysctl(dovecot_auth_t)
 allow dovecot_auth_t sysctl_t:dir search;
 dontaudit dovecot_auth_t selinux_config_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dpkg.te policy-1.21.15/domains/program/unused/dpkg.te
--- nsapolicy/domains/program/unused/dpkg.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/dpkg.te	2005-03-07 09:36:55.000000000 -0500
@@ -199,10 +199,8 @@
 r_dir_file(userdomain, debconf_cache_t)
 
 # for python
-allow { apt_t dpkg_t } sysctl_kernel_t:dir { getattr search };
-allow { apt_t dpkg_t } sysctl_kernel_t:file r_file_perms;
-
-allow dpkg_t sysctl_t:dir search;
+read_sysctl(apt_t)
+read_sysctl(dpkg_t)
 
 allow dpkg_t console_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fingerd.te policy-1.21.15/domains/program/unused/fingerd.te
--- nsapolicy/domains/program/unused/fingerd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/fingerd.te	2005-03-07 09:36:55.000000000 -0500
@@ -79,5 +79,4 @@
 allow fingerd_t proc_t:file { read getattr };
 
 # for date command
-allow fingerd_t sysctl_kernel_t:dir search;
-allow fingerd_t sysctl_kernel_t:file { read getattr };
+read_sysctl(fingerd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.21.15/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/ftpd.te	2005-03-08 13:56:41.000000000 -0500
@@ -24,8 +24,7 @@
 allow ftpd_t bin_t:dir search;
 can_exec(ftpd_t, bin_t)
 allow ftpd_t bin_t:lnk_file read;
-allow ftpd_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ftpd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ftpd_t)
 
 allow ftpd_t urandom_device_t:chr_file { getattr read };
 
@@ -113,3 +112,5 @@
 #
 type ftpd_anon_t, file_type, sysadmfile, customizable;
 r_dir_file(ftpd_t,ftpd_anon_t)
+type ftpd_anon_rw_t, file_type, sysadmfile, customizable;
+create_dir_file(ftpd_t,ftpd_anon_rw_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gatekeeper.te policy-1.21.15/domains/program/unused/gatekeeper.te
--- nsapolicy/domains/program/unused/gatekeeper.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/gatekeeper.te	2005-03-07 09:36:55.000000000 -0500
@@ -31,8 +31,7 @@
 tmp_domain(gatekeeper)
 
 # pthreads wants to know the kernel version
-allow gatekeeper_t sysctl_kernel_t:dir r_dir_perms;
-allow gatekeeper_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(gatekeeper_t)
 
 allow gatekeeper_t etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gpg.te policy-1.21.15/domains/program/unused/gpg.te
--- nsapolicy/domains/program/unused/gpg.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/gpg.te	2005-03-07 09:36:55.000000000 -0500
@@ -11,5 +11,8 @@
 allow sysadm_gpg_t { home_root_t user_home_dir_t }:dir search;
 allow sysadm_gpg_t ptyfile:chr_file rw_file_perms;
 
+# Allow gpg exec stack
+bool allow_gpg_execstack false;
+
 # Everything else is in the gpg_domain macro in
 # macros/program/gpg_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.21.15/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/hotplug.te	2005-03-07 09:36:55.000000000 -0500
@@ -23,6 +23,7 @@
 allow hotplug_t self:unix_stream_socket create_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 
+read_sysctl(hotplug_t)
 allow hotplug_t sysctl_net_t:dir r_dir_perms;
 allow hotplug_t sysctl_net_t:file { getattr read };
 
@@ -81,10 +82,6 @@
 allow hotplug_t self:process { getsession getattr };
 allow hotplug_t self:file getattr;
 
-# for sleep
-allow hotplug_t sysctl_kernel_t:dir search;
-allow hotplug_t sysctl_kernel_t:file { getattr read };
-
 domain_auto_trans(kernel_t, hotplug_exec_t, hotplug_t)
 domain_auto_trans(hotplug_t, mount_exec_t, mount_t)
 domain_auto_trans(hotplug_t, ifconfig_exec_t, ifconfig_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/java.te policy-1.21.15/domains/program/unused/java.te
--- nsapolicy/domains/program/unused/java.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/java.te	2005-03-07 09:36:55.000000000 -0500
@@ -7,8 +7,8 @@
 # Type for the netscape, java or other browser executables.
 type java_exec_t, file_type, sysadmfile, exec_type;
 
-# Allow java to read files in the user home directory
-bool disable_java false;
+# Allow java executable stack
+bool allow_java_execstack false;
 
 # Everything else is in the java_domain macro in
 # macros/program/java_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.21.15/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/kudzu.te	2005-03-07 09:36:55.000000000 -0500
@@ -30,10 +30,10 @@
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
 allow kudzu_t { bin_t sbin_t }:dir { getattr search };
 allow kudzu_t { bin_t sbin_t }:lnk_file read;
-allow kudzu_t { sysctl_t sysctl_kernel_t }:dir search;
+read_sysctl(kudzu_t)
 allow kudzu_t sysctl_dev_t:dir { getattr search read };
 allow kudzu_t sysctl_dev_t:file { getattr read };
-allow kudzu_t sysctl_kernel_t:file { getattr read write };
+allow kudzu_t sysctl_kernel_t:file write;
 allow kudzu_t usbdevfs_t:dir search;
 allow kudzu_t usbdevfs_t:file { getattr read };
 allow kudzu_t usbfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lvm.te policy-1.21.15/domains/program/unused/lvm.te
--- nsapolicy/domains/program/unused/lvm.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/lvm.te	2005-03-07 09:36:55.000000000 -0500
@@ -38,8 +38,7 @@
 allow lvm_t self:file r_file_perms;
 
 # Read system variables in /proc/sys
-allow lvm_t sysctl_kernel_t:file r_file_perms;
-allow lvm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(lvm_t)
 
 # Read /sys/block. Device mapper metadata is kept there.
 r_dir_file(lvm_t, sysfs_t) 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.21.15/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mailman.te	2005-03-07 09:36:55.000000000 -0500
@@ -18,8 +18,9 @@
 create_dir_file(mailman_$1_t, mailman_data_t)
 uses_shlib(mailman_$1_t)
 can_exec_any(mailman_$1_t)
-allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
-allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
+read_sysctl(mailman_$1_t)
+allow mailman_$1_t proc_t:dir search;
+allow mailman_$1_t proc_t:file { read getattr };
 allow mailman_$1_t var_lib_t:dir r_dir_perms;
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
@@ -106,3 +107,4 @@
 # Handle mailman log files
 rw_dir_create_file(logrotate_t, mailman_log_t)
 allow logrotate_t mailman_data_t:dir search;
+can_exec(logrotate_t, mailman_mail_exec_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mdadm.te policy-1.21.15/domains/program/unused/mdadm.te
--- nsapolicy/domains/program/unused/mdadm.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mdadm.te	2005-03-07 09:36:55.000000000 -0500
@@ -11,8 +11,7 @@
 # Kernel filesystem permissions
 r_dir_file(mdadm_t, proc_t)
 allow mdadm_t proc_mdstat_t:file rw_file_perms;
-allow mdadm_t sysctl_kernel_t:file r_file_perms;
-allow mdadm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(mdadm_t)
 r_dir_file(mdadm_t, sysfs_t) 
 
 # Configuration
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mplayer.te policy-1.21.15/domains/program/unused/mplayer.te
--- nsapolicy/domains/program/unused/mplayer.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mplayer.te	2005-03-07 09:36:55.000000000 -0500
@@ -8,5 +8,8 @@
 type mencoder_exec_t, file_type, exec_type, sysadmfile;
 type mplayer_etc_t, file_type, sysadmfile;
 
+# Allow mplayer executable stack
+bool allow_mplayer_execstack false;
+
 # Everything else is in the mplayer_domain macro in
 # macros/program/mplayer_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.21.15/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mrtg.te	2005-03-07 09:36:55.000000000 -0500
@@ -75,8 +75,7 @@
 
 dontaudit mrtg_t security_t:dir getattr;
 
-allow mrtg_t { sysctl_t sysctl_kernel_t }:dir search;
-allow mrtg_t sysctl_kernel_t:file read;
+read_sysctl(mrtg_t)
 
 # for uptime
 allow mrtg_t var_run_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.21.15/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mta.te	2005-03-08 09:48:02.000000000 -0500
@@ -21,7 +21,17 @@
 mail_domain(system)
 
 ifdef(`targeted_policy', `
+# rules are currently defined in sendmail.te, but it is not included in 
+# targeted policy.  We could move these rules permanantly here.
 ifdef(`postfix.te', `', `can_exec_any(system_mail_t)')
+allow system_mail_t self:dir { search };
+r_dir_file(system_mail_t, { proc_t proc_net_t })
+allow system_mail_t fs_t:filesystem getattr;
+allow system_mail_t { var_t var_spool_t }:dir getattr;
+create_dir_file(system_mail_t, mqueue_spool_t)
+create_dir_file(system_mail_t, mail_spool_t)
+allow system_mail_t mail_spool_t:fifo_file rw_file_perms;
+allow system_mail_t etc_mail_t:file { getattr read };
 ', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
@@ -61,8 +71,7 @@
 allow mta_delivery_agent home_root_t:dir { getattr search };
 
 # for /var/spool/mail
-ra_dir_file(mta_delivery_agent, mail_spool_t)
-allow mta_delivery_agent mail_spool_t:file create;
+ra_dir_create_file(mta_delivery_agent, mail_spool_t)
 
 # for piping mail to a command
 can_exec(mta_delivery_agent, shell_exec_t)
@@ -71,15 +80,5 @@
 allow mta_delivery_agent devtty_t:chr_file rw_file_perms;
 allow mta_delivery_agent { etc_runtime_t proc_t }:file { getattr read };
 
-# rules are currently defined in sendmail.te, but it is not included in 
-# targeted policy.  We could move these rules permanantly here.
-ifdef(`targeted_policy', `
-allow system_mail_t self:dir { search };
-r_dir_file(system_mail_t, { proc_t proc_net_t })
-allow system_mail_t fs_t:filesystem getattr;
-allow system_mail_t { var_t var_spool_t }:dir getattr;
-create_dir_file( system_mail_t, mqueue_spool_t)
-allow system_mail_t mail_spool_t:fifo_file rw_file_perms;
-')
 allow system_mail_t etc_runtime_t:file { getattr read };
 allow system_mail_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.21.15/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/mysqld.te	2005-03-07 09:36:55.000000000 -0500
@@ -53,8 +53,7 @@
 
 allow mysqld_t etc_t:dir search;
 
-allow mysqld_t sysctl_kernel_t:dir search;
-allow mysqld_t sysctl_kernel_t:file read;
+read_sysctl(mysqld_t)
 
 can_unix_connect(sysadm_t, mysqld_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.21.15/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/named.te	2005-03-07 09:36:55.000000000 -0500
@@ -84,9 +84,7 @@
 allow named_t self:netlink_route_socket r_netlink_socket_perms;
 
 # Read sysctl kernel variables.
-allow named_t sysctl_t:dir r_dir_perms;
-allow named_t sysctl_kernel_t:dir r_dir_perms;
-allow named_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(named_t)
 
 # Read /proc/cpuinfo and /proc/net
 r_dir_file(named_t, proc_t)
@@ -133,9 +131,7 @@
 allow ndc_t fs_t:filesystem getattr;
 
 # Read sysctl kernel variables.
-allow ndc_t sysctl_t:dir r_dir_perms;
-allow ndc_t sysctl_kernel_t:dir r_dir_perms;
-allow ndc_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(ndc_t)
 
 allow ndc_t self:process { fork signal_perms };
 allow ndc_t self:fifo_file { read write getattr ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.21.15/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/nscd.te	2005-03-07 09:36:55.000000000 -0500
@@ -44,8 +44,7 @@
 allow nscd_t self:nscd { admin getstat };
 allow nscd_t admin_tty_type:chr_file rw_file_perms;
 
-allow nscd_t sysctl_kernel_t:dir search;
-allow nscd_t sysctl_kernel_t:file read;
+read_sysctl(nscd_t)
 allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.21.15/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/ntpd.te	2005-03-07 09:36:55.000000000 -0500
@@ -62,8 +62,7 @@
 can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
-allow ntpd_t sysctl_kernel_t:dir search;
-allow ntpd_t sysctl_kernel_t:file read;
+read_sysctl(ntpd_t);
 allow ntpd_t proc_t:file r_file_perms;
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
 allow ntpd_t self:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.21.15/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/postfix.te	2005-03-07 09:36:55.000000000 -0500
@@ -60,8 +60,7 @@
 
 file_type_auto_trans(postfix_$1_t, var_run_t, postfix_var_run_t, file)
 
-allow postfix_$1_t { sysctl_t sysctl_kernel_t }:dir search;
-allow postfix_$1_t sysctl_kernel_t:file { getattr read };
+read_sysctl(postfix_$1_t)
 
 ')dnl end postfix_domain
 
@@ -73,19 +72,22 @@
 
 read_sysctl(postfix_master_t)
 
-ifdef(`direct_sysadm_daemon', `
-dontaudit postfix_master_t admin_tty_type:chr_file { read write };
-')
-
 domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
 allow initrc_t postfix_master_t:process { noatsecure siginh rlimitinh };
+
 ifdef(`direct_sysadm_daemon', `
+
 domain_auto_trans(sysadm_t, postfix_master_exec_t, postfix_master_t)
 allow sysadm_t postfix_master_t:process { noatsecure siginh rlimitinh };
 role_transition sysadm_r postfix_master_exec_t system_r;
+allow postfix_master_t postfix_etc_t:file rw_file_perms;
+dontaudit postfix_master_t admin_tty_type:chr_file { read write };
+allow postfix_master_t devpts_t:dir search;
+
 domain_auto_trans(sysadm_mail_t, postfix_master_exec_t, system_mail_t)
 allow system_mail_t sysadm_t:process sigchld;
 allow system_mail_t privfd:fd use;
+
 ')dnl end direct_sysadm_daemon
 
 allow postfix_master_t privfd:fd use;
@@ -106,8 +108,6 @@
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
 can_exec(postfix_master_t, { ls_exec_t sbin_t })
-allow postfix_master_t sysctl_kernel_t:dir r_dir_perms;
-allow postfix_master_t sysctl_kernel_t:file r_file_perms;
 allow postfix_master_t self:fifo_file rw_file_perms;
 allow postfix_master_t usr_t:file r_file_perms;
 can_exec(postfix_master_t, { shell_exec_t bin_t postfix_exec_t })
@@ -139,10 +139,6 @@
 allow postfix_master_t postfix_prng_t:file rw_file_perms;
 # for ls to get the current context
 allow postfix_master_t self:file { getattr read };
-ifdef(`direct_sysadm_daemon', `
-allow postfix_master_t postfix_etc_t:file rw_file_perms;
-allow postfix_master_t devpts_t:dir search;
-')
 
 # for SSP
 allow postfix_master_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.21.15/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/postgresql.te	2005-03-07 09:36:55.000000000 -0500
@@ -98,8 +98,7 @@
 
 allow postgresql_t etc_t:dir rw_dir_perms;
 
-allow postgresql_t { sysctl_t sysctl_kernel_t }:dir search;
-allow postgresql_t sysctl_kernel_t:file read;
+read_sysctl(postgresql_t)
 
 allow postgresql_t devtty_t:chr_file { read write };
 allow postgresql_t devpts_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radius.te policy-1.21.15/domains/program/unused/radius.te
--- nsapolicy/domains/program/unused/radius.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/radius.te	2005-03-07 09:36:55.000000000 -0500
@@ -26,8 +26,8 @@
 dontaudit radiusd_t sysadm_home_dir_t:dir getattr;
 
 # allow pthreads to read kernel version
-allow radiusd_t sysctl_kernel_t:dir r_dir_perms;
-allow radiusd_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(radiusd_t)
+
 # read config files
 allow radiusd_t etc_t:dir r_dir_perms;
 allow radiusd_t { etc_t etc_runtime_t }:file { read getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.21.15/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/sendmail.te	2005-03-08 09:49:28.000000000 -0500
@@ -81,14 +81,15 @@
 allow sendmail_t bin_t:dir { getattr search };
 ')
 
+read_sysctl(sendmail_t)
+read_sysctl(system_mail_t)
+
 allow system_mail_t etc_mail_t:dir { getattr search };
 allow system_mail_t etc_runtime_t:file { getattr read };
 allow system_mail_t proc_t:dir search;
 allow system_mail_t proc_t:file { getattr read };
 allow system_mail_t proc_t:lnk_file read;
 dontaudit system_mail_t proc_net_t:dir search;
-allow sendmail_t sysctl_kernel_t:dir search;
-allow sendmail_t sysctl_kernel_t:file { getattr read };
 allow system_mail_t fs_t:filesystem getattr;
 allow system_mail_t self:dir { getattr search };
 allow system_mail_t var_t:dir getattr;
@@ -99,7 +100,6 @@
 allow system_mail_t mqueue_spool_t:dir rw_dir_perms;
 allow system_mail_t mqueue_spool_t:file create_file_perms;
 
-allow system_mail_t sysctl_kernel_t:file read;
 ifdef(`crond.te', `
 dontaudit system_mail_t system_crond_tmp_t:file append;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.21.15/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/slapd.te	2005-03-07 09:36:55.000000000 -0500
@@ -54,8 +54,7 @@
 
 allow slapd_t etc_t:dir r_dir_perms;
 
-allow slapd_t sysctl_kernel_t:dir search;
-allow slapd_t sysctl_kernel_t:file read;
+read_sysctl(slapd_t)
 
 allow slapd_t usr_t:file { read getattr };
 allow slapd_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.21.15/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/snmpd.te	2005-03-07 09:36:55.000000000 -0500
@@ -45,6 +45,7 @@
 allow snmpd_t proc_t:dir search;
 allow snmpd_t proc_t:file r_file_perms;
 allow snmpd_t self:file { getattr read };
+allow snmpd_t self:fifo_file { read write };
 
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.21.15/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/spamd.te	2005-03-07 09:36:55.000000000 -0500
@@ -15,10 +15,10 @@
 general_domain_access(spamd_t)
 uses_shlib(spamd_t)
 can_ypbind(spamd_t)
+read_sysctl(spamd_t)
 
 # Various Perl bits
 allow spamd_t lib_t:file rx_file_perms;
-dontaudit spamd_t { sysctl_t sysctl_kernel_t }:dir search;
 dontaudit spamd_t shadow_t:file { getattr read };
 dontaudit spamd_t initrc_var_run_t:file { read write lock };
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
@@ -48,7 +48,6 @@
 rw_dir_create_file(spamd_t, amavisd_lib_t)
 ')
 
-allow spamd_t sysctl_kernel_t:file { getattr read };
 allow spamd_t usr_t:file { getattr ioctl read };
 allow spamd_t usr_t:lnk_file { getattr read };
 allow spamd_t urandom_device_t:chr_file { getattr read };
@@ -68,4 +67,6 @@
 }
 
 allow spamd_t home_root_t:dir getattr;
+allow spamd_t user_home_dir_type:dir { search getattr };
+
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.21.15/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/squid.te	2005-03-07 09:36:55.000000000 -0500
@@ -35,8 +35,7 @@
 allow squid_t self:unix_dgram_socket create_socket_perms;
 allow squid_t self:fifo_file rw_file_perms;
 
-allow squid_t { sysctl_t sysctl_kernel_t }:dir search;
-allow squid_t sysctl_kernel_t:file read;
+read_sysctl(squid_t)
 
 allow squid_t devtty_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sxid.te policy-1.21.15/domains/program/unused/sxid.te
--- nsapolicy/domains/program/unused/sxid.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/sxid.te	2005-03-07 09:36:55.000000000 -0500
@@ -40,8 +40,7 @@
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
 allow sxid_t { proc_t self }:{ file lnk_file } { read getattr };
-allow sxid_t { sysctl_kernel_t sysctl_t }:dir search;
-allow sxid_t sysctl_kernel_t:file read;
+read_sysctl(sxid_t)
 allow sxid_t devtty_t:chr_file rw_file_perms;
 
 allow sxid_t self:capability { dac_override dac_read_search fsetid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.21.15/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/traceroute.te	2005-03-07 09:36:55.000000000 -0500
@@ -12,7 +12,7 @@
 # traceroute_t is the domain for the traceroute program.
 # traceroute_exec_t is the type of the corresponding program.
 #
-type traceroute_t, domain, privlog;
+type traceroute_t, domain, privlog, nscd_client_domain;
 role sysadm_r types traceroute_t;
 role system_r types traceroute_t;
 # for user_ping:
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/transproxy.te policy-1.21.15/domains/program/unused/transproxy.te
--- nsapolicy/domains/program/unused/transproxy.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/transproxy.te	2005-03-07 09:36:55.000000000 -0500
@@ -34,6 +34,5 @@
 
 #allow transproxy_t etc_t:dir r_dir_perms;
 
-#allow transproxy_t sysctl_kernel_t:dir search;
-#allow transproxy_t sysctl_kernel_t:file read;
+#read_sysctl(transproxy_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.21.15/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/updfstab.te	2005-03-07 09:36:55.000000000 -0500
@@ -35,9 +35,8 @@
 
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
 # I will not allow it
-dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
+read_sysctl(updfstab_t)
 dontaudit updfstab_t sysctl_kernel_t:file write;
-allow updfstab_t sysctl_kernel_t:file { getattr read };
 allow updfstab_t modules_conf_t:file { getattr read };
 allow updfstab_t sbin_t:dir search;
 allow updfstab_t sbin_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/utempter.te policy-1.21.15/domains/program/unused/utempter.te
--- nsapolicy/domains/program/unused/utempter.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.21.15/domains/program/unused/utempter.te	2005-03-07 09:36:55.000000000 -0500
@@ -12,7 +12,7 @@
 # executed by xterm to update utmp and wtmp.
 # utempter_exec_t is the type of the utempter binary.
 #
-type utempter_t, domain;
+type utempter_t, domain, nscd_client_domain;
 in_user_role(utempter_t)
 role sysadm_r types utempter_t;
 uses_shlib(utempter_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.21.15/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/xdm.te	2005-03-07 09:36:55.000000000 -0500
@@ -200,8 +200,7 @@
 
 allow xdm_t proc_t:file { getattr read };
 
-allow xdm_t sysctl_kernel_t:dir search;
-allow xdm_t sysctl_kernel_t:file read;
+read_sysctl(xdm_t)
 
 # Search /proc for any user domain processes.
 allow xdm_t userdomain:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.21.15/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/ypbind.te	2005-03-07 09:36:55.000000000 -0500
@@ -23,8 +23,7 @@
 
 allow ypbind_t self:fifo_file rw_file_perms;
 
-allow ypbind_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ypbind_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ypbind_t)
 
 # Send to portmap and initrc.
 can_udp_send(ypbind_t, portmap_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.21.15/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/unused/ypserv.te	2005-03-07 09:36:55.000000000 -0500
@@ -20,8 +20,7 @@
 
 allow ypserv_t self:fifo_file rw_file_perms;
 
-allow ypserv_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ypserv_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ypserv_t)
 
 # Send to portmap and initrc.
 can_udp_send(ypserv_t, portmap_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/useradd.te policy-1.21.15/domains/program/useradd.te
--- nsapolicy/domains/program/useradd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/domains/program/useradd.te	2005-03-07 09:36:55.000000000 -0500
@@ -71,8 +71,7 @@
 user_group_add_program(useradd)
 
 # for getting the number of groups
-allow useradd_t { sysctl_t sysctl_kernel_t }:dir search;
-allow useradd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(useradd_t)
 
 # Add/remove user home directories
 file_type_auto_trans(useradd_t, home_root_t, user_home_dir_t, dir)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/amanda.fc policy-1.21.15/file_contexts/program/amanda.fc
--- nsapolicy/file_contexts/program/amanda.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/file_contexts/program/amanda.fc	2005-03-07 09:36:55.000000000 -0500
@@ -67,3 +67,4 @@
 /var/lib/amanda/disklist	--	system_u:object_r:amanda_data_t
 /var/lib/amanda/gnutar-lists(/.*)?	system_u:object_r:amanda_gnutarlists_t
 /var/lib/amanda/index			system_u:object_r:amanda_data_t
+/var/log/amanda(/.*)?			system_u:object_r:amanda_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.21.15/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/mozilla.fc	2005-03-07 09:36:55.000000000 -0500
@@ -1,13 +1,13 @@
 #  netscape/mozilla
-HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_home_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mplayer.fc policy-1.21.15/file_contexts/program/mplayer.fc
--- nsapolicy/file_contexts/program/mplayer.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/mplayer.fc	2005-03-07 09:36:55.000000000 -0500
@@ -3,4 +3,4 @@
 /usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
 
 /etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
-HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
+HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_home_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/nrpe.fc policy-1.21.15/file_contexts/program/nrpe.fc
--- nsapolicy/file_contexts/program/nrpe.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/nrpe.fc	2005-03-07 09:36:55.000000000 -0500
@@ -1,3 +1,5 @@
 # nrpe
 /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
 /etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
+/usr/lib(64)?/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib(64)?/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.21.15/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/postgresql.fc	2005-03-08 11:42:47.000000000 -0500
@@ -9,6 +9,7 @@
 /etc/postgresql(/.*)?		system_u:object_r:postgresql_etc_t
 /var/log/postgres\.log.* --	system_u:object_r:postgresql_log_t
 /var/log/postgresql(/.*)?	system_u:object_r:postgresql_log_t
+/var/lib/pgsql/pgstartup.log	system_u:object_r:postgresql_log_t
 /usr/lib/pgsql/test/regres(/.*)?	system_u:object_r:postgresql_db_t
 /usr/lib/pgsql/test/regress/.*\.so	-- system_u:object_r:shlib_t
 /usr/lib/pgsql/test/regress/.*\.sh	-- system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/screen.fc policy-1.21.15/file_contexts/program/screen.fc
--- nsapolicy/file_contexts/program/screen.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/file_contexts/program/screen.fc	2005-03-07 09:36:55.000000000 -0500
@@ -1,5 +1,5 @@
 # screen
 /usr/bin/screen		--	system_u:object_r:screen_exec_t
-HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_home_screen_t
+HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_screen_ro_home_t
 /var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
 /var/run/screen/S-[^/]+/.*	<<none>>
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/spamassassin.fc policy-1.21.15/file_contexts/program/spamassassin.fc
--- nsapolicy/file_contexts/program/spamassassin.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/spamassassin.fc	2005-03-07 09:36:55.000000000 -0500
@@ -1,3 +1,3 @@
 # spamassasin
 /usr/bin/spamassassin	--	system_u:object_r:spamassassin_exec_t
-HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:ROLE_home_spamassassin_t
+HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:ROLE_spamassassin_home_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xauth.fc policy-1.21.15/file_contexts/program/xauth.fc
--- nsapolicy/file_contexts/program/xauth.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/program/xauth.fc	2005-03-07 09:36:55.000000000 -0500
@@ -1,3 +1,3 @@
 # xauth
 /usr/X11R6/bin/xauth	--	system_u:object_r:xauth_exec_t
-HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_home_xauth_t
+HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_xauth_home_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.21.15/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/file_contexts/types.fc	2005-03-08 08:47:29.000000000 -0500
@@ -79,7 +79,7 @@
 /var/tmp		-d	system_u:object_r:tmp_t
 /var/tmp/.*			<<none>>
 /var/tmp/vi\.recover	-d	system_u:object_r:tmp_t
-/var/lib/nfs/rpc_pipefs(/*)?	<<none>>
+/var/lib/nfs/rpc_pipefs(/.*)?	<<none>>
 /var/mailman/bin(/.*)?		system_u:object_r:bin_t
 /var/mailman/pythonlib(/.*)?/.*\.so(\..*)?	-- system_u:object_r:shlib_t
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.21.15/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/admin_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -38,7 +38,7 @@
 
 # Violates the goal of limiting write access to checkpolicy.
 # But presently necessary for installing the file_contexts file.
-rw_dir_create_file($1_t, policy_config_t)
+create_dir_file($1_t, policy_config_t)
 r_dir_file($1_t, selinux_config_t)
 
 # Let admin stat the shadow file.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.15/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/base_user_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -187,10 +187,7 @@
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
-ifdef(`mplayer.te', `
-mplayer_domain($1)
-mencoder_domain($1)
-')
+ifdef(`mplayer.te', `mplayer_domains($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
@@ -301,7 +298,7 @@
 allow $1_t xdm_var_lib_t:file { getattr read };
 allow xdm_t $1_home_dir_t:dir getattr;
 ifdef(`xauth.te', `
-file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_xauth_t, file)
+file_type_auto_trans(xdm_t, $1_home_dir_t, $1_xauth_home_t, file)
 ')
 
 # for shared memory
@@ -357,9 +354,7 @@
 allow $1_t default_t:notdevfile_class_set r_file_perms;
 }
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
-allow $1_t sysctl_t:dir search;
+read_sysctl($1_t);
 
 #
 # Caused by su - init scripts
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.15/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/global_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -474,6 +474,105 @@
 file_type_auto_trans($1_t, var_lock_t, $1_lock_t, file)
 ')
 
+####################################################################
+# home_domain_ro_access(source, user, app) 
+# 
+# Gives source access to the read-only home
+# domain of app for the given user type
+#
+
+define(`home_domain_ro_access', `
+
+allow $1 home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+r_dir_file($1, nfs_t)
+}
+if (use_samba_home_dirs) {
+r_dir_file($1, cifs_t)
+}
+allow $1 autofs_t:dir { search getattr };
+
+r_dir_file($1, $2_$3_ro_home_t)
+
+') dnl home_domain_ro_access
+
+####################################################################
+# home_domain_access(source, user, app)
+#
+# Gives source full access to the home
+# domain of app for the given user type
+#
+
+define(`home_domain_access', `
+
+allow $1 home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+create_dir_file($1, nfs_t)
+}
+if (use_samba_home_dirs) {
+create_dir_file($1, cifs_t)
+}
+allow $1 autofs_t:dir { search getattr };
+
+file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t)
+
+') dnl home_domain_access
+
+####################################################################
+# home_domain (prefix, app)
+#
+# Creates a domain in the prefix home where an application can
+# store its settings. It's accessible by the prefix domain.
+#
+
+define(`home_domain', `
+
+# Declare home domain
+# FIXME: the second alias is problematic because
+# home_domain and home_domain_ro cannot be used in parallel
+# Remove the second alias when compatibility is no longer an issue
+
+type $1_$2_home_t, file_type, $1_file_type, sysadmfile;
+typealias $1_$2_home_t alias $1_$2_rw_t;
+typealias $1_$2_home_t alias $1_home_$2_t;
+
+# User side access
+create_dir_file($1_t, $1_$2_home_t)
+allow $1_t $1_$2_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+# App side access
+home_domain_access($1_$2_t, $1, $2)
+')
+
+####################################################################
+# home_domain_ro (user, app)
+#
+# Creates a read-only domain in the user home where an application can
+# store its settings. It's fully accessible by the user, but
+# it's read-only for the application.
+#
+
+define(`home_domain_ro', `
+
+# Declare home domain
+# FIXME: the second alias is problematic because
+# home_domain and home_domain_ro cannot be used in parallel
+# Remove the second alias when compatibility is no longer an issue
+
+type $1_$2_ro_home_t, file_type, $1_file_type, sysadmfile;
+typealias $1_$2_ro_home_t alias $1_$2_ro_t;
+typealias $1_$2_ro_home_t alias $1_home_$2_t;
+
+# User side access
+create_dir_file($1_t, $1_$2_ro_home_t)
+allow $1_t $1_$2_ro_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+# App side access
+home_domain_ro_access($1_$2_t, $1, $2)
+')
+
 #######################
 # application_domain(domain_prefix)
 #
@@ -530,15 +629,10 @@
 # shlib_t and ld_so_t unlike non-legacy binaries.
 
 define(`legacy_domain', `
-bool allow_$1_legacy false;
-if (allow_$1_legacy && allow_execmem) {
 allow $1_t self:process { execmem };
-}
-if (allow_$1_legacy && allow_execmod) {
-#Required when starting with /lib/tls/libc-
 allow $1_t { texrel_shlib_t shlib_t }:file execmod;
 allow $1_t ld_so_t:file execmod;
-}
+allow $1_t ld_so_cache_t:file execute;
 ')
 
 # 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.21.15/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/apache_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -40,7 +40,7 @@
 allow httpd_$1_script_t etc_runtime_t:file { getattr read };
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
-allow httpd_$1_script_t self:unix_stream_socket create_socket_perms;
+allow httpd_$1_script_t self:unix_stream_socket create_stream_socket_perms;
 
 allow httpd_$1_script_t { self proc_t }:file { getattr read };
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/clamav_macros.te policy-1.21.15/macros/program/clamav_macros.te
--- nsapolicy/macros/program/clamav_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/clamav_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -39,8 +39,7 @@
 # Why is this required?
 allow $1_clamscan_t proc_t:dir r_dir_perms;
 allow $1_clamscan_t proc_t:file r_file_perms;
-allow $1_clamscan_t sysctl_kernel_t:dir r_dir_perms;
-allow $1_clamscan_t sysctl_kernel_t:file r_file_perms;
+read_sysctl($1_clamscan_t)
 allow $1_clamscan_t self:unix_stream_socket { connect create read write };
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/crond_macros.te policy-1.21.15/macros/program/crond_macros.te
--- nsapolicy/macros/program/crond_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/crond_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -77,8 +77,7 @@
 allow $1_crond_t proc_t:dir r_dir_perms;
 allow $1_crond_t proc_t:file { getattr read ioctl };
 read_locale($1_crond_t)
-allow $1_crond_t { sysctl_t sysctl_kernel_t }:dir search;
-allow $1_crond_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_crond_t)
 allow $1_crond_t var_spool_t:dir search;
 allow $1_crond_t fs_type:filesystem getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.21.15/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/games_domain.te	2005-03-07 09:36:55.000000000 -0500
@@ -11,13 +11,18 @@
 #
 define(`games_domain', `
 x_client_domain($1, `games', `, transitionbool')
+
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
 r_dir_file($1_games_t, usr_t)
 can_udp_send($1_games_t, $1_games_t)
 can_tcp_connect($1_games_t, $1_games_t)
+
+# Access /home/user/.gnome2
 create_dir_file($1_games_t, $1_home_t)
+allow $1_games_t $1_home_dir_t:dir search;
+allow $1_games_t $1_home_t:dir { read getattr };
 
 create_dir_file($1_games_t, $1_tmp_t)
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
@@ -48,9 +53,6 @@
 # kpat spews errors
 dontaudit $1_games_t bin_t:dir getattr;
 dontaudit $1_games_t var_run_t:dir search;
-ifdef(`xdm.te', `
-dontaudit $1_games_t xdm_xserver_tmp_t:dir getattr;
-')
 
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.15/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/gpg_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -33,6 +33,15 @@
 # The user role is authorized for this domain.
 role $1_r types $1_gpg_t;
 
+# Legacy
+if (allow_gpg_execstack) {
+legacy_domain($1_gpg)
+allow $1_gpg_t locale_t:file execute;
+
+# Not quite sure why this is needed... 
+allow $1_gpg_t gpg_exec_t:file execmod;
+}
+
 allow $1_t $1_gpg_secret_t:file getattr;
 
 allow $1_gpg_t device_t:dir r_dir_perms;
@@ -44,7 +53,6 @@
 allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
 
 access_terminal($1_gpg_t, $1)
-allow $1_gpg_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 ifdef(`gnome-pty-helper.te', `allow $1_gpg_t $1_gph_t:fd use;')
 
 # Inherit and use descriptors
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.21.15/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/inetd_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -37,8 +37,7 @@
 allow $1_t self:process { fork signal_perms };
 allow $1_t fs_t:filesystem getattr;
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_t)
 
 allow $1_t etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.21.15/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/irc_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -18,12 +18,15 @@
 undefine(`irc_domain')
 ifdef(`irc.te', `
 define(`irc_domain',`
+
+# Home domain
+home_domain($1, irc)
+
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, $1_file_type, sysadmfile;
 type $1_irc_exec_t, file_type, sysadmfile, $1_file_type;
 
-allow $1_t { $1_home_irc_t $1_irc_exec_t }:file { relabelfrom relabelto create_file_perms };
+allow $1_t $1_irc_exec_t:file { relabelfrom relabelto create_file_perms };
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, { irc_exec_t $1_irc_exec_t }, $1_irc_t)
@@ -65,10 +68,6 @@
 allow $1_irc_t initrc_var_run_t:file read;
 dontaudit $1_irc_t initrc_var_run_t:file lock;
 
-# access config files
-allow $1_irc_t home_root_t:dir search;
-file_type_auto_trans($1_irc_t, $1_home_dir_t, $1_home_irc_t, file)
-
 # access files under /tmp
 file_type_auto_trans($1_irc_t, tmp_t, $1_tmp_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.21.15/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/java_macros.te	2005-03-08 17:04:06.000000000 -0500
@@ -1,117 +1,113 @@
 #
-# Macros for java/java (or other browser) domains.
+# Authors:  Dan Walsh <dwalsh@redhat.com> 
 #
-
-#
-# Authors:  Dan Walsh <dwalsh@redhat.com> and Timothy Fraser 
+# Macros for javaplugin (java plugin) domains.
 #
-
 #
-# java_domain(domain_prefix, user)
+# javaplugin_domain(domain_prefix, user)
 #
-# Define a derived domain for the java/java program when executed by
+# Define a derived domain for the javaplugin program when executed by
 # a web browser.  
 #
 # The type declaration for the executable type for this program is
 # provided separately in domains/program/java.te. 
 #
-define(`java_domain',`
-type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
+define(`javaplugin_domain',`
+type $1_javaplugin_t, domain, privlog , nscd_client_domain, transitionbool;
 
 # The user role is authorized for this domain.
-role $2_r types $1_java_t;
-domain_auto_trans($1_t, java_exec_t, $1_java_t)
+role $2_r types $1_javaplugin_t;
+domain_auto_trans($1_t, java_exec_t, $1_javaplugin_t)
 
-allow $1_java_t sound_device_t:chr_file rw_file_perms;
+allow $1_javaplugin_t sound_device_t:chr_file rw_file_perms;
 # Unrestricted inheritance from the caller.
-allow $1_t $1_java_t:process { noatsecure siginh rlimitinh };
-allow $1_java_t $1_t:process signull;
+allow $1_t $1_javaplugin_t:process { noatsecure siginh rlimitinh };
+allow $1_javaplugin_t $1_t:process signull;
 
-can_unix_connect($1_java_t, $1_t)
-allow $1_java_t $1_t:unix_stream_socket { read write };
+can_unix_connect($1_javaplugin_t, $1_t)
+allow $1_javaplugin_t $1_t:unix_stream_socket { read write };
 
 # This domain is granted permissions common to most domains (including can_net)
-can_network_client($1_java_t)
-can_ypbind($1_java_t)
-allow $1_java_t self:process { fork signal_perms getsched setsched };
-allow $1_java_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow $1_java_t self:fifo_file rw_file_perms;
-allow $1_java_t etc_runtime_t:file { getattr read };
-allow $1_java_t fs_t:filesystem getattr;
-read_locale($1_java_t)
-r_dir_file($1_java_t, { proc_t proc_net_t })
-allow $1_java_t self:dir search;
-allow $1_java_t self:lnk_file read;
-allow $1_java_t self:file { getattr read };
-
-read_sysctl($1_java_t)
-
-tmp_domain($1_java)
-r_dir_file($1_java_t,{ fonts_t usr_t etc_t })
-
-# Search bin directory under java for java executable
-allow $1_java_t bin_t:dir search;
-can_exec($1_java_t, java_exec_t)
+can_network_client($1_javaplugin_t)
+can_ypbind($1_javaplugin_t)
+allow $1_javaplugin_t self:process { fork signal_perms getsched setsched };
+allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow $1_javaplugin_t self:fifo_file rw_file_perms;
+allow $1_javaplugin_t etc_runtime_t:file { getattr read };
+allow $1_javaplugin_t fs_t:filesystem getattr;
+r_dir_file($1_javaplugin_t, { proc_t proc_net_t })
+allow $1_javaplugin_t self:dir search;
+allow $1_javaplugin_t self:lnk_file read;
+allow $1_javaplugin_t self:file { getattr read };
+
+read_sysctl($1_javaplugin_t)
+
+tmp_domain($1_javaplugin)
+r_dir_file($1_javaplugin_t,{ fonts_t usr_t etc_t })
+
+# Search bin directory under javaplugin for javaplugin executable
+allow $1_javaplugin_t bin_t:dir search;
+can_exec($1_javaplugin_t, java_exec_t)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
 
 ifdef(`xdm.te', `
 # for when /tmp/.X11-unix is created by the system
-allow $1_java_t xdm_xserver_tmp_t:dir search;
-allow $1_java_t xdm_t:fifo_file rw_file_perms;
-allow $1_java_t xdm_tmp_t:dir search;
-allow $1_java_t xdm_tmp_t:sock_file write;
+allow $1_javaplugin_t xdm_xserver_tmp_t:dir search;
+allow $1_javaplugin_t xdm_t:fifo_file rw_file_perms;
+allow $1_javaplugin_t xdm_tmp_t:dir search;
+allow $1_javaplugin_t xdm_tmp_t:sock_file write;
 ')
 
 ifdef(`startx.te', `
 # for when /tmp/.X11-unix is created by the X server
-allow $1_java_t $2_xserver_tmp_t:dir search;
+allow $1_javaplugin_t $2_xserver_tmp_t:dir search;
 
 # for /tmp/.X0-lock
-allow $1_java_t $2_xserver_tmp_t:file getattr;
+allow $1_javaplugin_t $2_xserver_tmp_t:file getattr;
 
-allow $1_java_t $2_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_java_t, $2_xserver_t)
+allow $1_javaplugin_t $2_xserver_tmp_t:sock_file rw_file_perms;
+can_unix_connect($1_javaplugin_t, $2_xserver_t)
 ')dnl end startx
 
-can_unix_connect($1_java_t, xdm_xserver_t)
-allow xdm_xserver_t $1_java_t:fd use;
-allow xdm_xserver_t $1_java_t:shm { associate getattr read unix_read };
-dontaudit xdm_xserver_t $1_java_t:shm { unix_write write };
+can_unix_connect($1_javaplugin_t, xdm_xserver_t)
+allow xdm_xserver_t $1_javaplugin_t:fd use;
+allow xdm_xserver_t $1_javaplugin_t:shm { associate getattr read unix_read };
+dontaudit xdm_xserver_t $1_javaplugin_t:shm { unix_write write };
 
 ')dnl end xserver
 
-allow $1_java_t self:shm create_shm_perms;
-
-legacy_domain($1_java)
+allow $1_javaplugin_t self:shm create_shm_perms;
 
-uses_shlib($1_java_t)
-read_locale($1_java_t)
-rw_dir_file($1_java_t, $1_rw_t)
-
-allow $1_java_t ld_so_cache_t:file execute;
-allow $1_java_t lib_t:file execute;
-allow $1_java_t locale_t:file execute;
-allow $1_java_t $1_java_tmp_t:file execute;
-
-allow $1_java_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
-
-allow $1_java_t home_root_t:dir { getattr search };
-file_type_auto_trans($1_java_t, $2_home_dir_t, $1_rw_t)
-allow $1_java_t $2_home_xauth_t:file { getattr read };
-allow $1_java_t $2_tmp_t:sock_file write;
-allow $1_java_t $2_t:fd use;
-
-allow $1_java_t var_t:dir getattr;
-allow $1_java_t var_lib_t:dir { getattr search };
-
-dontaudit $1_java_t fonts_t:file execute;
-dontaudit $1_java_t sound_device_t:chr_file execute;
-dontaudit $1_java_t $2_devpts_t:chr_file { read write };
-dontaudit $1_java_t sysadm_devpts_t:chr_file { read write };
-dontaudit $1_java_t devtty_t:chr_file { read write };
-dontaudit $1_java_t tmpfs_t:file { execute read write };
-dontaudit $1_java_t $1_rw_t:file { execute setattr };
+uses_shlib($1_javaplugin_t)
+read_locale($1_javaplugin_t)
+rw_dir_file($1_javaplugin_t, $1_home_t)
+
+if (allow_java_execstack) {
+legacy_domain($1_javaplugin)
+allow $1_javaplugin_t lib_t:file execute;
+allow $1_javaplugin_t locale_t:file execute;
+allow $1_javaplugin_t $1_javaplugin_tmp_t:file execute;
+allow $1_javaplugin_t fonts_t:file execute;
+allow $1_javaplugin_t sound_device_t:chr_file execute;
+}
+
+allow $1_javaplugin_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
+
+allow $1_javaplugin_t home_root_t:dir { getattr search };
+file_type_auto_trans($1_javaplugin_t, $2_home_dir_t, $1_home_t)
+allow $1_javaplugin_t $2_xauth_home_t:file { getattr read };
+allow $1_javaplugin_t $2_tmp_t:sock_file write;
+allow $1_javaplugin_t $2_t:fd use;
+
+allow $1_javaplugin_t var_t:dir getattr;
+allow $1_javaplugin_t var_lib_t:dir { getattr search };
+
+dontaudit $1_javaplugin_t $2_devpts_t:chr_file { read write };
+dontaudit $1_javaplugin_t sysadm_devpts_t:chr_file { read write };
+dontaudit $1_javaplugin_t devtty_t:chr_file { read write };
+dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
+dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.15/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/mozilla_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -18,6 +18,9 @@
 define(`mozilla_domain',`
 x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
 
+# Configuration
+home_domain($1, mozilla)
+
 # Allow mozilla to browse files
 file_browse_domain($1_mozilla_t)
 
@@ -36,18 +39,6 @@
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
 
-# for the orbit files of mozilla
-allow $1_t $1_mozilla_rw_t:sock_file create_file_perms;
-can_unix_connect($1_t, $1_mozilla_t)
-
-if (use_nfs_home_dirs) {
-create_dir_file($1_mozilla_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1_mozilla_t, cifs_t)
-}
-allow $1_mozilla_t autofs_t:dir { search getattr };
-
 # for bash
 allow $1_mozilla_t device_t:dir r_dir_perms;
 allow $1_mozilla_t devpts_t:dir r_dir_perms;
@@ -59,36 +50,44 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Execute downloaded programs.
-can_exec($1_mozilla_t, $1_mozilla_rw_t)
+# Write files to tmp
+tmp_domain($1_mozilla)
 
-dontaudit $1_mozilla_t tmpfile:dir setattr;
+# Execute downloaded programs.
+can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
 # Use printer
 ifdef(`lpr.te', `
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-# $1_lpr_t should only need read access to the tmp files
-allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
+
+# Print document
+allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
+
+# Suppress history.fop denial
+dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+
 dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
 dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
 ')
 
-#
-# This is another place where I sould like to allow system customization.
-# We need to allow the admin to select whether then want to allow mozilla
-# access to the users home directories.
-#
+# ORBit sockets
+file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
+can_unix_connect($1_t, $1_mozilla_t)
+allow $1_t $1_mozilla_tmp_t:sock_file write;
+allow $1_mozilla_t $1_tmp_t:file { read write lock };
+allow $1_mozilla_t $1_tmp_t:sock_file { read write };
+dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
+
+# Allow mozilla to read user home content
 if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, { $1_home_t $1_tmp_t })
+r_dir_file($1_mozilla_t, $1_home_t)
 } else {
 dontaudit $1_mozilla_t $1_home_t:dir setattr;
 dontaudit $1_mozilla_t $1_home_t:file setattr;
 }
-file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
-file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_rw_t)
 
 if (mozilla_writehome) {
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
+file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t)
 allow $1_mozilla_t $1_home_t:dir setattr;
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
 } dnl end if writehome
@@ -109,17 +108,20 @@
 dontaudit $1_mozilla_t $1_home_t:file unlink;
 allow $1_mozilla_t self:sem create_sem_perms;
 
-#
-# Rules needed to run java apps
-
-java_domain($1_mozilla, $1)
+# Java plugin
+ifdef(`java.te', `
+javaplugin_domain($1_mozilla, $1)
+')
 
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
-# Read temporary content - mozilla saves stuff there
-r_dir_file($1_mplayer_t, $1_mozilla_rw_t);
-dontaudit $1_mplayer_t $1_mozilla_rw_t:file write;
+
+# Read mozilla content in /tmp
+r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
+
+# FIXME: why does it need this?
+dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
 allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.21.15/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/mplayer_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -3,28 +3,15 @@
 #
 # Author: Ivan Gyurdiev <ivg2@cornell.edu>
 #
-#
-# mplayer_domain(domain_prefix)
-# mencoder_domain(domain_prefix)
+# mplayer_domains(user) declares domains for mplayer, gmplayer,
+# and mencoder
 
-################################################
-#    mplayer_common(prefix, mplayer domain)    #
-################################################
+##############################################
+#    mplayer_common(user, mplayer domain)    #
+##############################################
 
 define(`mplayer_common',`
 
-# Home directory stuff
-if (use_nfs_home_dirs) {
-create_dir_file($1_$2_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1_$2_t, cifs_t)
-}
-allow $1_$2_t autofs_t:dir { search getattr };
-
-# Read local config
-r_dir_file($1_$2_t, $1_mplayer_rw_t)
-
 # Read global config
 r_dir_file($1_$2_t, mplayer_etc_t)
 
@@ -37,15 +24,13 @@
 allow $1_$2_t proc_t:file { getattr read };
 
 # Sysctl on kernel version 
-allow $1_$2_t sysctl_kernel_t:dir search;
-allow $1_$2_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_$2_t)
 
 # Allow ps, shared libs, locale, terminal access
 can_ps($1_t, $1_$2_t)
 uses_shlib($1_$2_t)
 read_locale($1_$2_t)
 access_terminal($1_$2_t, $1)
-allow $1_$2_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 
 # Required for win32 binary loader 
 allow $1_$2_t zero_device_t:chr_file { read write execute };
@@ -63,17 +48,28 @@
 allow $1_$2_t device_t:lnk_file { getattr read };
 allow $1_$2_t removable_device_t:blk_file { getattr read };
 allow $1_$2_t v4l_device_t:chr_file { getattr read };
+
+# Legacy domain issues
+if (allow_mplayer_execstack) {
+legacy_domain($1_$2)
+allow $1_$2_t lib_t:file execute;
+allow $1_$2_t locale_t:file execute;
+allow $1_$2_t sound_device_t:chr_file execute;
+}
 ')
 
-##############################
-#  mplayer_domain(prefix)    #
-##############################
+############################
+#  mplayer_domain(user)    #
+############################
 
 define(`mplayer_domain',`
 
 # Derive from X client domain
 x_client_domain($1, `mplayer', `')
 
+# Mplayer configuration here
+home_domain($1, mplayer)
+
 # Allow mplayer to browse files
 file_browse_domain($1_mplayer_t)
 
@@ -91,21 +87,34 @@
 
 ') dnl end mplayer_domain
 
-##############################
-#  mencoder_domain(prefix)   #
-##############################
+############################
+#  mencoder_domain(user)   #
+############################
 
 define(`mencoder_domain',`
 
-# Privhome type transitions to $1_home_t in home dir.
-type $1_mencoder_t, domain, privhome;
+# FIXME: privhome temporarily removed...
+type $1_mencoder_t, domain;
 
 # Transition
 domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
 can_exec($1_mencoder_t, mencoder_exec_t)
 role $1_r types $1_mencoder_t;
 
+# Read home config
+home_domain_access($1_mencoder_t, $1, mplayer)
+
 # Mplayer common stuff
 mplayer_common($1, mencoder)
 
 ') dnl end mencoder_domain
+
+#############################
+#  mplayer_domains(user)    #
+#############################
+
+define(`mplayer_domains', `
+mplayer_domain($1)
+mencoder_domain($1)
+') dnl end mplayer_domains
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.21.15/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/screen_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -22,7 +22,6 @@
 define(`screen_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, $1_file_type, sysadmfile;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
@@ -50,15 +49,7 @@
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
 
-allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
-allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
-allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-if (use_nfs_home_dirs) {
-r_dir_file($1_screen_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-r_dir_file($1_screen_t, cifs_t)
-}
+home_domain_ro($1, screen)
 
 allow $1_screen_t privfd:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/slocate_macros.te policy-1.21.15/macros/program/slocate_macros.te
--- nsapolicy/macros/program/slocate_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/slocate_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -42,8 +42,7 @@
 allow $1_locate_t privfd:fd use;
 
 # allow ps to show locate
-allow $1_t $1_locate_t:dir { search getattr read };
-allow $1_t $1_locate_t:{ file lnk_file } { read getattr };
+can_ps($1_t, $1_locate_t)
 allow $1_t $1_locate_t:process signal;
 
 uses_shlib($1_locate_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.21.15/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/spamassassin_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -45,7 +45,6 @@
 read_locale($1_$2_t)
 dontaudit $1_$2_t var_t:dir search;
 allow $1_$2_t $1_home_dir_t:dir r_dir_perms;
-r_dir_file($1_$2_t, $1_home_t)
 tmp_domain($1_$2)
 allow $1_$2_t privfd:fd use;
 allow $1_$2_t userpty_type:chr_file rw_file_perms;
@@ -59,8 +58,8 @@
 #
 define(`spamassassin_agent_privs',`
 allow $1 home_root_t:dir r_dir_perms;
-file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t)
-create_dir_file($1, $2_home_spamassassin_t)
+file_type_auto_trans($1, $2_home_dir_t, $2_spamassassin_home_t)
+create_dir_file($1, $2_spamassassin_home_t)
 
 allow $1 urandom_device_t:chr_file r_file_perms;
 ')
@@ -79,11 +78,8 @@
 dontaudit $1_spamassassin_t proc_t:dir search;
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
-# The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, $1_file_type, sysadmfile;
-create_dir_file($1_t, $1_home_spamassassin_t)
-allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
-allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
+# For ~/.spamassassin
+home_domain($1, spamassassin)
 
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.15/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/ssh_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -138,7 +138,8 @@
 allow $1_ssh_t $1_xserver_tmp_t:dir search;
 ')dnl end if startx
 ifdef(`xdm.te', `
-allow $1_ssh_t xdm_xserver_tmp_t:dir search;
+allow $1_ssh_t { xdm_xserver_tmp_t xdm_tmp_t }:dir search;
+allow $1_ssh_t { xdm_tmp_t }:sock_file write;
 ')
 ')dnl end if xserver
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.21.15/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/su_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -122,7 +122,6 @@
 
 # Write to the user domain tty.
 access_terminal($1_su_t, $1)
-allow $1_su_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 
 allow $1_su_t { home_root_t $1_home_dir_t }:dir search;
 allow $1_su_t $1_home_t:file create_file_perms;
@@ -142,9 +141,9 @@
 
 # Modify .Xauthority file (via xauth program).
 ifdef(`xauth.te', `
-file_type_auto_trans($1_su_t, staff_home_dir_t, staff_home_xauth_t, file)
-file_type_auto_trans($1_su_t, user_home_dir_t, user_home_xauth_t, file)
-file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_home_xauth_t, file)
+file_type_auto_trans($1_su_t, staff_home_dir_t, staff_xauth_home_t, file)
+file_type_auto_trans($1_su_t, user_home_dir_t, user_xauth_home_t, file)
+file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_xauth_home_t, file)
 domain_auto_trans($1_su_t, xauth_exec_t, $1_xauth_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.21.15/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/tvtime_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -18,9 +18,8 @@
 undefine(`tvtime_domain')
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
-# Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, $1_file_type, sysadmfile;
 
+home_domain($1, tvtime)
 x_client_domain($1, tvtime)
 
 allow $1_tvtime_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/uml_macros.te policy-1.21.15/macros/program/uml_macros.te
--- nsapolicy/macros/program/uml_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/uml_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -25,8 +25,6 @@
 type $1_uml_ro_t, file_type, sysadmfile, $1_file_type;
 type $1_uml_rw_t, file_type, sysadmfile, $1_file_type;
 
-can_ptrace($1_t, $1_uml_t)
-
 # for X
 ifdef(`startx.te', `
 ifelse($1, sysadm, `', `
@@ -57,9 +55,9 @@
 # Inherit and use descriptors from newrole.
 ifdef(`newrole.te', `allow $1_uml_t newrole_t:fd use;')
 
-# allow ps to show uml
-allow $1_t $1_uml_t:dir { search getattr read };
-allow $1_t $1_uml_t:{ file lnk_file } { read getattr };
+# allow ps, ptrace, signal
+can_ps($1_t, $1_uml_t)
+can_ptrace($1_t, $1_uml_t)
 allow $1_t $1_uml_t:process signal_perms;
 
 # allow the UML thing to happen
@@ -103,7 +101,7 @@
 dontaudit $1_uml_t etc_runtime_t:file read;
 can_tcp_connect($1_uml_t, sshd_t)
 ifdef(`xauth.te', `
-allow $1_uml_t $1_home_xauth_t:file { getattr read };
+allow $1_uml_t $1_xauth_home_t:file { getattr read };
 ')
 allow $1_uml_t var_run_t:dir search;
 allow $1_uml_t initrc_var_run_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.21.15/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/userhelper_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -116,7 +116,6 @@
 allow $1_userhelper_t urandom_device_t:chr_file { getattr read };
 
 allow $1_userhelper_t autofs_t:dir search;
-allow $1_userhelper_t sysctl_t:dir search;
 role system_r types $1_userhelper_t;
 r_dir_file($1_userhelper_t, nfs_t)
 
@@ -131,7 +130,7 @@
 
 ifdef(`xauth.te', `
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
-allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
+allow $1_userhelper_t $1_xauth_home_t:file { getattr read };
 ')
 
 ifdef(`pamconsole.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.21.15/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/xauth_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -20,11 +20,10 @@
 define(`xauth_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, $1_file_type, sysadmfile;
 
 allow $1_xauth_t self:process signal;
 
-allow $1_t $1_home_xauth_t:file { relabelfrom relabelto create_file_perms };
+home_domain($1, xauth)
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, xauth_exec_t, $1_xauth_t)
@@ -47,8 +46,7 @@
 allow $1_xauth_t ptmx_t:chr_file { read write };
 
 # allow ps to show xauth
-allow $1_t $1_xauth_t:dir { search getattr read };
-allow $1_t $1_xauth_t:{ file lnk_file } { read getattr };
+can_ps($1_t, $1_xauth_t)
 allow $1_t $1_xauth_t:process signal;
 
 uses_shlib($1_xauth_t)
@@ -72,23 +70,9 @@
 allow $1_xauth_t var_t:dir search;
 allow $1_xauth_t var_run_t:dir search; 
 
-# this is what we are here for
-allow $1_xauth_t home_root_t:dir search;
-file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_home_xauth_t, file)
-
 tmp_domain($1_xauth)
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
 
-if (use_nfs_home_dirs) {
-allow $1_xauth_t autofs_t:dir { search getattr };
-rw_dir_create_file($1_xauth_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-rw_dir_create_file($1_xauth_t, cifs_t)
-}
-if (use_samba_home_dirs) {
-rw_dir_create_file($1_xauth_t, cifs_t)
-}
 ')dnl end xauth_domain macro
 
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.21.15/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/x_client_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -8,6 +8,34 @@
 # and Timothy Fraser 
 #
 
+define(`xsession_domain', `
+
+# Connect to xserver
+can_unix_connect($1_t, $2_xserver_t)
+
+# /tmp/.ICE_unix
+allow $1_t $2_xserver_tmp_t:dir search;
+allow $1_t $2_xserver_tmp_t:sock_file rw_file_perms;
+
+# Stat /tmp/.X0-lock
+allow $1_t $2_xserver_tmp_t:file getattr;
+
+# Signal Xserver
+allow $1_t $2_xserver_t:process signal;
+
+# Use file descriptors created by each other.
+allow $1_t $2_xserver_t:fd use;
+allow $2_xserver_t $1_t:fd use;
+
+# Xserver read/write parent shm
+allow $2_xserver_t $1_t:shm rw_shm_perms;
+allow $2_xserver_t $1_tmpfs_t:file rw_file_perms;
+
+# Parent read xserver shm
+allow $1_t $2_xserver_t:shm r_shm_perms;
+allow $1_t $2_xserver_tmpfs_t:file r_file_perms;
+')
+
 #
 # x_client_domain(domain_prefix)
 #
@@ -24,10 +52,6 @@
 define(`x_client_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_$2_t, domain, nscd_client_domain $3;
-# Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, $1_file_type, sysadmfile, tmpfile;
-# Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, $1_file_type, sysadmfile;
 
 ifelse(index(`$3', `transitionbool'), -1, `
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
@@ -64,28 +88,12 @@
 allow $1_$2_t proc_t:lnk_file read;
 allow $1_$2_t self:dir search;
 allow $1_$2_t self:lnk_file read;
-allow $1_$2_t sysctl_kernel_t:dir search;
-allow $1_$2_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_$2_t)
 
 ifdef(`xauth.te',`
-allow $1_$2_t $1_home_xauth_t:file { getattr read };
+allow $1_$2_t $1_xauth_home_t:file { getattr read };
 ')
 
-# Allow the user domain to relabel to or create files with this type
-# to provide the domain with write access to particular files.
-allow $1_t $1_$2_rw_t:{ dir file lnk_file } { relabelfrom relabelto };
-# allow $1_t to create dirs and files in the rw type (the auto_trans rule above
-# does it for $1_$2_t)
-allow $1_t $1_$2_rw_t:dir create_dir_perms;
-allow $1_t $1_$2_rw_t:file create_file_perms;
-allow $1_t $1_$2_rw_t:lnk_file create_lnk_perms;
-
-r_dir_file($1_$2_t, $1_$2_ro_t)
-allow $1_$2_t $1_$2_ro_t:fifo_file { read write };
-create_dir_file($1_t, $1_$2_ro_t)
-allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
-allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
-
 # Allow the user domain to send any signal to the $2 process.
 allow $1_t $1_$2_t:process signal_perms;
 
@@ -110,31 +118,6 @@
 ifdef(`gnome-pty-helper.te', `allow $1_$2_t $1_gph_t:fd use;')
 allow $1_$2_t privfd:fd use;
 
-# Connect to sshd.
-ifdef(`sshd.te', `can_tcp_connect($1_$2_t, sshd_t)')
-
-# Allow connections to X server.
-ifdef(`xserver.te', `
-allow $1_$2_t tmp_t:dir search;
-
-ifdef(`xdm.te', `
-# for when /tmp/.X11-unix is created by the system
-allow $1_$2_t xdm_xserver_tmp_t:dir search;
-allow $1_$2_t xdm_t:fifo_file rw_file_perms;
-')
-
-ifdef(`startx.te', `
-# for when /tmp/.X11-unix is created by the X server
-allow $1_$2_t $1_xserver_tmp_t:dir search;
-
-# for /tmp/.X0-lock
-allow $1_$2_t $1_xserver_tmp_t:file getattr;
-
-allow $1_$2_t $1_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_$2_t, $1_xserver_t)
-')dnl end startx
-')dnl end xserver
-
 # for .xsession-errors
 dontaudit $1_$2_t $1_home_t:file write;
 
@@ -145,47 +128,34 @@
 
 # Read the home directory, e.g. for .Xauthority and to get to config files
 allow $1_$2_t home_root_t:dir { search getattr };
-file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_rw_t)
 
 # Use a separate type for tmpfs/shm pseudo files.
 tmpfs_domain($1_$2)
 
 allow $1_$2_t self:shm create_shm_perms;
 
-# Communicate via shared memory.
-ifdef(`startx.te', `
-# Allow the $2 domain to signal the X server.
-allow $1_$2_t $1_xserver_t:process signal;
-# Use descriptors created by each other.
-allow $1_$2_t $1_xserver_t:fd use;
-allow $1_xserver_t $1_$2_t:fd use;
-
-allow $1_xserver_t $1_$2_t:shm rw_shm_perms;
-allow $1_xserver_t $1_$2_tmpfs_t:file rw_file_perms;
-allow $1_$2_t $1_xserver_t:shm r_shm_perms;
-allow $1_$2_t $1_xserver_tmpfs_t:file r_file_perms;
-')dnl end startx.te policy
+# allow X client to read all font files
+r_dir_file($1_$2_t, fonts_t)
+
+# Allow connections to X server.
+ifdef(`xserver.te', `
+allow $1_$2_t tmp_t:dir search;
 
 ifdef(`xdm.te', `
-# Allow the $2 domain to signal the X server.
-allow $1_$2_t xdm_xserver_t:process signal;
-# Use descriptors created by each other.
-allow $1_$2_t xdm_xserver_t:fd use;
-allow xdm_xserver_t $1_$2_t:fd use;
-
-allow xdm_xserver_t $1_$2_t:shm rw_shm_perms;
-allow xdm_xserver_t $1_$2_tmpfs_t:file rw_file_perms;
-allow $1_$2_t xdm_xserver_t:shm r_shm_perms;
-allow $1_$2_t xdm_xserver_tmpfs_t:file r_file_perms;
-
-can_unix_connect($1_$2_t, xdm_xserver_t)
-allow $1_$2_t { xdm_xserver_tmp_t xdm_tmp_t }:dir search;
-allow $1_$2_t { xdm_xserver_tmp_t xdm_tmp_t }:sock_file { read write };
+xsession_domain($1_$2, xdm)
+
+# for when /tmp/.X11-unix is created by the system
+allow $1_$2_t xdm_t:fifo_file rw_file_perms;
+allow $1_$2_t xdm_tmp_t:dir search;
+allow $1_$2_t xdm_tmp_t:sock_file { read write };
 allow $1_$2_t xdm_t:fd use;
 dontaudit $1_$2_t xdm_t:tcp_socket { read write };
-')dnl end xdm.te
+')
 
-# allow X client to read all font files
-r_dir_file($1_$2_t, fonts_t)
+ifdef(`startx.te', `
+xsession_domain($1_$2, $1)
+')dnl end startx
+
+')dnl end xserver
 
 ')dnl end x_client macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.21.15/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/program/xserver_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -97,7 +97,7 @@
 }
 ifdef(`xauth.te', `
 domain_auto_trans($1_xserver_t, xauth_exec_t, $1_xauth_t)
-allow $1_xserver_t $1_home_xauth_t:file { getattr read };
+allow $1_xserver_t $1_xauth_home_t:file { getattr read };
 ', `
 allow $1_xserver_t $1_home_t:file { getattr read };
 ')dnl end ifdef xauth
@@ -111,9 +111,7 @@
 allow $1_xserver_t fs_t:filesystem getattr;
 
 # Xorg wants to check if kernel is tainted
-allow $1_xserver_t { sysctl_t sysctl_kernel_t }:dir search;
-allow $1_xserver_t sysctl_kernel_t:file { getattr read };
-
+read_sysctl($1_xserver_t)
 
 # Use capabilities.
 # allow setuid/setgid for the wrapper program to change UID
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.21.15/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/macros/user_macros.te	2005-03-07 09:36:55.000000000 -0500
@@ -143,8 +143,7 @@
 allow $1_t var_lib_t:dir r_dir_perms;
 allow $1_t var_lib_t:file { getattr read };
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_t)
 
 # Read /etc.
 allow $1_t etc_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.15/Makefile
--- nsapolicy/Makefile	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.21.15/Makefile	2005-03-07 09:36:55.000000000 -0500
@@ -48,7 +48,7 @@
 ALLTEFILES := attrib.te tmp/program_used_flags.te $(ALL_MACROS) $(ALL_TYPES) $(ALL_DOMAINS) assert.te 
 TE_RBAC_FILES := $(ALLTEFILES) rbac
 ALL_TUNABLES := $(wildcard tunables/*.tun )
-USER_FILES := users serviceusers
+USER_FILES := users 
 POLICYFILES = $(addprefix $(FLASKDIR),security_classes initial_sids access_vectors)
 ifeq ($(MLS),y)
 POLICYFILES += mls
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/ftpd_selinux.8 policy-1.21.15/man/man8/ftpd_selinux.8
--- nsapolicy/man/man8/ftpd_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.21.15/man/man8/ftpd_selinux.8	2005-03-09 00:19:37.000000000 -0500
@@ -11,13 +11,20 @@
 If you want to share files anonymously, you must label the files and directories ftpd_anon_t.  So if you created a special directory /var/ftp, you 
 would need to label the directory with the chcon tool.
 .TP
-chcon -t ftpd_anon_t /var/ftp
+chcon -R -t ftpd_anon_t /var/ftp
+.TP
+If you want to setup a directory where you can upload files to you must label the files and directories ftpd_anon_rw_t.  So if you created a special directory /var/ftp/incoming, you 
+would need to label the directory with the chcon tool.
+.TP
+chcon -t ftpd_anon_rw_t /var/ftp/incoming
+
 .TP
 If you want to make this permanant, i.e. survive a relabel, you must add an entry to the file_contexts.local file.
 .TP
 /etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
 .br
 /var/ftp(/.*)? system_u:object_r:ftpd_anon_t
+/var/ftp/incoming(/.*)? system_u:object_r:ftpd_anon_rw_t
 
 .SH BOOLEANS
 SELinux ftp daemon policy is customizable based on least access required.  So by 
diff --exclude-from=exclude -N -u -r nsapolicy/serviceusers policy-1.21.15/serviceusers
--- nsapolicy/serviceusers	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.21.15/serviceusers	1969-12-31 19:00:00.000000000 -0500
@@ -1,6 +0,0 @@
-ifdef(`cyrus.te', `
-user cyrus roles cyrus_r;
-')
-ifdef(`mailman.te', `
-#user mailman roles mailman_r;
-')
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.21.15/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.21.15/targeted/domains/program/crond.te	2005-03-08 11:15:53.000000000 -0500
@@ -27,3 +27,6 @@
 file_type_auto_trans(crond_t, var_log_t, crond_log_t, file)
 file_type_auto_trans(crond_t, user_home_dir_t, user_home_t)
 file_type_auto_trans(crond_t, tmp_t, system_crond_tmp_t)
+allow crond_t initrc_t:dbus send_msg;
+allow crond_t unconfined_t:dbus send_msg;
+allow crond_t unconfined_t:process transition;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/hotplug.te policy-1.21.15/targeted/domains/program/hotplug.te
--- nsapolicy/targeted/domains/program/hotplug.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.21.15/targeted/domains/program/hotplug.te	2005-03-08 19:06:03.000000000 -0500
@@ -11,6 +11,7 @@
 # This domain is defined just for targeted policy to allow easy conversion to
 # strict policy.  
 #
+type hotplug_t, domain;
 type hotplug_exec_t, file_type, sysadmfile, exec_type;
 typealias var_run_t alias hotplug_var_run_t;
 typealias etc_t alias hotplug_etc_t;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.15/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/tunables/distro.tun	2005-03-07 09:36:55.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.15/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/tunables/tunable.tun	2005-03-07 09:36:55.000000000 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
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
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/security.te policy-1.21.15/types/security.te
--- nsapolicy/types/security.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.21.15/types/security.te	2005-03-07 17:10:37.000000000 -0500
@@ -24,7 +24,8 @@
 # policy_src_t is the type of the policy source
 # files.
 #
-type policy_src_t, file_type;
+type policy_src_t, file_type, sysadmfile;
+
 
 #
 # default_context_t is the type applied to 

--------------030501090405020703050002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
