Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1GwKXZ027693
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 11:58:20 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1GuxCC013014
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:56:59 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iA1Hv732024042
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 12:57:07 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iA1Hv7Mt024041
	for selinux@tycho.nsa.gov; Mon, 1 Nov 2004 12:57:07 -0500
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1GIfXZ027352
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 11:18:41 -0500 (EST)
Message-ID: <418661C8.8000801@redhat.com>
Date: Mon, 01 Nov 2004 11:18:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Patch to make can_network stronger and remove nscd tunable.
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>	 <20041018143842.GP19398@lkcl.net>  <20041018215802.GD2536@jmh.mhn.de> <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010405090108080905080402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010405090108080905080402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010405090108080905080402
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.36/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-10-19 16:03:04.000000000 -0400
+++ policy-1.17.36/domains/program/crond.te	2004-10-28 09:05:15.000000000 -0400
@@ -24,6 +24,7 @@
 # Type for temporary files.
 tmp_domain(crond)
 can_ypbind(crond_t)
+allow crond_t self:{ tcp_socket udp_socket } connect;
 
 crond_domain(system)
 
@@ -114,6 +115,10 @@
 # Use capabilities.
 allow system_crond_t self:capability { dac_read_search chown setgid setuid fowner net_bind_service fsetid };
 
+allow crond_t krb5_conf_t:file { getattr read };
+dontaudit crond_t krb5_conf_t:file { write };
+allow crond_t urandom_device_t:chr_file { getattr read };
+
 # Read the system crontabs.
 allow system_crond_t system_cron_spool_t:file r_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.17.36/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.36/domains/program/login.te	2004-10-28 17:14:48.000000000 -0400
@@ -21,6 +21,8 @@
 dontaudit $1_login_t shadow_t:file { getattr read };
 
 general_domain_access($1_login_t);
+allow $1_login_t self:{ tcp_socket udp_socket } create_socket_perms;
+can_network($1_login_t) 
 
 # Read system information files in /proc.
 allow $1_login_t proc_t:dir r_dir_perms;
@@ -81,9 +83,9 @@
 ')
 allow $1_login_t mnt_t:dir r_dir_perms;
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 r_dir_file($1_login_t, nfs_t)
-')dnl end if nfs_home_dirs
+}
 
 # FIXME: what is this for?
 ifdef(`xdm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/logrotate.te policy-1.17.36/domains/program/logrotate.te
--- nsapolicy/domains/program/logrotate.te	2004-09-02 14:45:45.000000000 -0400
+++ policy-1.17.36/domains/program/logrotate.te	2004-10-28 09:05:15.000000000 -0400
@@ -13,7 +13,7 @@
 # logrotate_t is the domain for the logrotate program.
 # logrotate_exec_t is the type of the corresponding program.
 #
-type logrotate_t, domain, privowner, privmail, priv_system_role;
+type logrotate_t, domain, privowner, privmail, priv_system_role, nscd_client_domain;
 role system_r types logrotate_t;
 role sysadm_r types logrotate_t;
 uses_shlib(logrotate_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.36/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-10-09 21:06:13.000000000 -0400
+++ policy-1.17.36/domains/program/mount.te	2004-10-28 09:05:15.000000000 -0400
@@ -11,7 +11,7 @@
 
 type mount_exec_t, file_type, sysadmfile, exec_type;
 
-mount_domain(sysadm, mount, `, fs_domain')
+mount_domain(sysadm, mount, `, fs_domain, nscd_client_domain')
 mount_loopback_privs(sysadm, mount)
 role sysadm_r types mount_t;
 role system_r types mount_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.36/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/ssh.te	2004-10-28 09:05:15.000000000 -0400
@@ -69,17 +69,18 @@
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 can_network($1_t)
+allow $1_t self:{ udp_socket tcp_socket } connect;
 
-allow $1_t self:capability { sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
+allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 can_ypbind($1_t)
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')
 allow $1_t nfs_t:dir { search getattr };
 allow $1_t nfs_t:file { getattr read };
-} dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 ifdef(`single_userdomain', `
 if (ssh_sysadm_login) {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.36/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/syslogd.te	2004-10-28 09:05:15.000000000 -0400
@@ -96,4 +96,4 @@
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
-dontaudit syslogd_t devpts_t:chr_file getattr;
+dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.17.36/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.36/domains/program/unused/acct.te	2004-10-28 09:05:15.000000000 -0400
@@ -63,6 +63,7 @@
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
+allow logrotate_t acct_data_t:dir { search };
 allow logrotate_t acct_data_t:file { create_file_perms };
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.36/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/apache.te	2004-10-28 09:05:15.000000000 -0400
@@ -61,7 +61,7 @@
 
 # httpd_exec_t is the type give to the httpd executable.
 #
-daemon_domain(httpd, `, privmail')
+daemon_domain(httpd, `, privmail, nscd_client_domain')
 
 can_exec(httpd_t, httpd_exec_t)
 file_type_auto_trans(httpd_t, var_run_t, httpd_var_run_t, sock_file)
@@ -136,6 +136,7 @@
 
 can_network(httpd_t)
 can_ypbind(httpd_t)
+allow httpd_t self:{ tcp_socket udp_socket } connect;
 
 ###################
 # Allow httpd to search users diretories
@@ -249,7 +250,7 @@
 allow httpd_t autofs_t:dir { search getattr };
 allow httpd_suexec_t autofs_t:dir { search getattr };
 ')
-if (nfs_home_dirs && httpd_enable_homedirs) {
+if (use_nfs_home_dirs && httpd_enable_homedirs) {
 r_dir_file(httpd_t, nfs_t)
 r_dir_file(httpd_suexec_t, nfs_t)
 can_exec(httpd_suexec_t, nfs_t)
@@ -298,5 +299,6 @@
 # Customer reported the following
 #
 ifdef(`snmpd.te', `
+dontaudit httpd_t snmpd_var_lib_t:dir { search };
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.17.36/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.36/domains/program/unused/apmd.te	2004-10-28 16:31:24.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the apmd_t domain.
 #
-daemon_domain(apmd, `, privmodule')
+daemon_domain(apmd, `, privmodule, nscd_client_domain')
 
 # for SSP
 allow apmd_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.17.36/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.36/domains/program/unused/arpwatch.te	2004-10-28 16:34:05.000000000 -0400
@@ -9,10 +9,10 @@
 #
 # arpwatch_exec_t is the type of the arpwatch executable.
 #
-daemon_domain(arpwatch, `, privmail')
+daemon_domain(arpwatch, `, privmail, nscd_client_domain')
 type arpwatch_data_t, file_type, sysadmfile;
 allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
-allow arpwatch_t self:capability { net_admin net_raw };
+allow arpwatch_t self:capability { net_admin net_raw net_bind_service };
 allow arpwatch_t self:udp_socket create_socket_perms;
 allow arpwatch_t self:unix_dgram_socket create_socket_perms;
 allow arpwatch_t arpwatch_t:capability { setgid setuid };
@@ -25,10 +25,15 @@
 allow arpwatch_t netif_lo_t:netif { udp_send };
 allow arpwatch_t sbin_t:dir { search };
 allow arpwatch_t sbin_t:lnk_file { read };
-can_network(arpwatch_t)
+can_tcp_network(arpwatch_t)
 can_ypbind(arpwatch_t)
+allow arpwatch_t self:tcp_socket connect;
+
+ifdef(`mta.te', `
 allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
+allow system_mail_t arpwatch_data_t:dir { getattr search };
+')
 ifdef(`postfix.te', `
 allow postfix_local_t arpwatch_data_t:dir { search };
 ')
-
+allow arpwatch_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.17.36/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2004-09-01 13:00:25.000000000 -0400
+++ policy-1.17.36/domains/program/unused/automount.te	2004-10-28 09:05:15.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the automount_t domain.
 #
-daemon_domain(automount)
+daemon_domain(automount, `, nscd_client_domain')
 
 etc_domain(automount)
 
@@ -26,7 +26,7 @@
 allow automount_t { etc_t etc_runtime_t }:file { getattr read };
 allow automount_t proc_t:file { getattr read };
 allow automount_t self:process { setpgid setsched };
-allow automount_t self:capability { sys_nice };
+allow automount_t self:capability { sys_nice net_bind_service };
 allow automount_t self:unix_stream_socket create_socket_perms;
 allow automount_t self:unix_dgram_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.17.36/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/bluetooth.te	2004-10-28 09:05:15.000000000 -0400
@@ -22,7 +22,7 @@
 # Use the network.
 can_network(bluetooth_t)
 can_ypbind(bluetooth_t)
-dbusd_client(system, bluetooth_t)
+dbusd_client(system, bluetooth)
 allow bluetooth_t self:socket { create setopt ioctl bind listen };
 allow bluetooth_t self:unix_dgram_socket create_socket_perms;
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.17.36/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/canna.te	2004-10-28 09:05:15.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the canna_t domain.
 #
-daemon_domain(canna)
+daemon_domain(canna, `, nscd_client_domain' )
 
 file_type_auto_trans(canna_t, var_run_t, canna_var_run_t, sock_file)
 
@@ -28,8 +28,9 @@
 
 rw_dir_create_file(canna_t, canna_var_lib_t)
 
-can_network(canna_t)
+can_tcp_network(canna_t)
 can_ypbind(canna_t)
+allow canna_t self:tcp_socket connect;
 
 allow userdomain canna_var_run_t:dir search;
 allow userdomain canna_var_run_t:sock_file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.17.36/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.36/domains/program/unused/cardmgr.te	2004-10-28 17:16:53.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the cardmgr_t domain.
 #
-daemon_domain(cardmgr, `, privmodule')
+daemon_domain(cardmgr, `, privmodule, nscd_client_domain')
 
 # for SSP
 allow cardmgr_t urandom_device_t:chr_file read;
@@ -82,3 +82,7 @@
 dontaudit insmod_t cardmgr_dev_t:chr_file { read write };
 dontaudit ifconfig_t cardmgr_dev_t:chr_file { read write };
 ')
+ifdef(`hald.te', `
+rw_dir_file(hald_t, cardmgr_var_run_t)
+allow hald_t cardmgr_var_run_t:chr_file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.36/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/consoletype.te	2004-10-28 09:05:15.000000000 -0400
@@ -59,3 +59,5 @@
 ')
 dontaudit consoletype_t proc_t:file { read };
 dontaudit consoletype_t root_t:file { read };
+allow consoletype_t crond_t:fifo_file { read };
+allow consoletype_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cpuspeed.te policy-1.17.36/domains/program/unused/cpuspeed.te
--- nsapolicy/domains/program/unused/cpuspeed.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.36/domains/program/unused/cpuspeed.te	2004-10-28 09:05:15.000000000 -0400
@@ -8,3 +8,5 @@
 allow cpuspeed_t sysfs_t:file rw_file_perms;
 allow cpuspeed_t proc_t:dir r_dir_perms;
 allow cpuspeed_t proc_t:file { getattr read };
+allow cpuspeed_t etc_runtime_t:file { getattr read };
+allow cpuspeed_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.36/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/cups.te	2004-10-28 09:05:15.000000000 -0400
@@ -20,6 +20,8 @@
 
 can_network(cupsd_t)
 can_ypbind(cupsd_t)
+allow cupsd_t self:{ tcp_socket udp_socket } connect;
+
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
@@ -167,8 +169,7 @@
 ifdef(`hald.te', `
 
 # CUPS configuration daemon
-daemon_domain(cupsd_config)
-
+daemon_domain(cupsd_config, `, nscd_client_domain')
 allow cupsd_config_t devpts_t:dir search;
 
 ifdef(`distro_redhat', `
@@ -188,7 +189,7 @@
 allow cupsd_config_t cupsd_t:{ file lnk_file } { getattr read };
 allow cupsd_config_t cupsd_t:dir { search };
 
-allow cupsd_config_t self:capability { chown };
+allow cupsd_config_t self:capability { chown sys_tty_config };
 
 rw_dir_create_file(cupsd_config_t, cupsd_etc_t)
 rw_dir_create_file(cupsd_config_t, cupsd_rw_etc_t)
@@ -199,9 +200,11 @@
 
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
 ifdef(`dbusd.te', `
-dbusd_client(system, cupsd_t)
-dbusd_client(system, cupsd_config_t)
+dbusd_client(system, cupsd)
+dbusd_client(system, cupsd_config)
 allow cupsd_config_t userdomain:dbus { send_msg };
+allow cupsd_config_t system_dbusd_t:dbus { send_msg acquire_svc };
+allow cupsd_t system_dbusd_t:dbus { send_msg };
 allow userdomain cupsd_config_t:dbus { send_msg };
 allow cupsd_config_t hald_t:dbus { send_msg };
 allow hald_t cupsd_config_t:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.17.36/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2004-05-04 15:35:53.000000000 -0400
+++ policy-1.17.36/domains/program/unused/cyrus.te	2004-10-28 09:05:15.000000000 -0400
@@ -5,7 +5,7 @@
 
 # cyrusd_exec_t is the type of the cyrusd executable.
 # cyrusd_key_t is the type of the cyrus private key files
-daemon_domain(cyrus)
+daemon_domain(cyrus, `, nscd_client_domain')
 role cyrus_r types cyrus_t;
 
 general_domain_access(cyrus_t)
@@ -20,6 +20,7 @@
 
 can_network(cyrus_t)
 can_ypbind(cyrus_t)
+allow cyrus_t self:{ tcp_socket udp_socket } connect;
 can_exec(cyrus_t, bin_t)
 allow cyrus_t cyrus_var_lib_t:dir create_dir_perms;
 allow cyrus_t cyrus_var_lib_t:{file sock_file } create_file_perms;
@@ -45,3 +46,4 @@
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
 allow system_crond_su_t cyrus_var_lib_t:dir { search };
 ')
+allow cyrus_t mail_port_t:tcp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbskkd.te policy-1.17.36/domains/program/unused/dbskkd.te
--- nsapolicy/domains/program/unused/dbskkd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dbskkd.te	2004-10-28 09:05:15.000000000 -0400
@@ -9,5 +9,6 @@
 #
 # dbskkd_exec_t is the type of the dbskkd executable.
 #
+# Depends: inetd.te
 
 inetd_child_domain(dbskkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.36/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dbusd.te	2004-10-28 09:05:15.000000000 -0400
@@ -11,8 +11,9 @@
 ')
 
 # dac_override: /var/run/dbus is owned by messagebus on Debian
-allow system_dbusd_t self:capability { dac_override setgid setuid };
+allow system_dbusd_t self:capability { dac_override setgid setuid net_bind_service };
 can_ypbind(system_dbusd_t)
+allow system_dbusd_t self:tcp_socket connect;
 
 # I expect we need more than this
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.17.36/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dhcpc.te	2004-10-28 09:05:15.000000000 -0400
@@ -17,13 +17,14 @@
 #
 type dhcpc_port_t, port_type, reserved_port_type;
 
-daemon_domain(dhcpc)
+daemon_domain(dhcpc, `, nscd_client_domain')
 
 # for SSP
 allow dhcpc_t urandom_device_t:chr_file read;
 
 can_network(dhcpc_t)
 can_ypbind(dhcpc_t)
+allow dhcpc_t self:tcp_socket connect;
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
 allow dhcpc_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dictd.te policy-1.17.36/domains/program/unused/dictd.te
--- nsapolicy/domains/program/unused/dictd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dictd.te	2004-10-28 09:05:15.000000000 -0400
@@ -28,7 +28,7 @@
 allow dictd_t var_lib_dictd_t:dir r_dir_perms;
 allow dictd_t var_lib_dictd_t:file r_file_perms;
 
-allow dictd_t self:capability { setuid setgid };
+allow dictd_t self:capability { setuid setgid net_bind_service };
 
 allow dictd_t usr_t:file r_file_perms;
 
@@ -45,5 +45,6 @@
 can_network(dictd_t)
 can_ypbind(dictd_t)
 can_tcp_connect(userdomain, dictd_t)
+allow dictd_t self:tcp_socket connect;
 
 allow dictd_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.17.36/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dovecot.te	2004-10-28 09:05:15.000000000 -0400
@@ -3,7 +3,7 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: dovecot-imapd, dovecot-pop3d
 
-daemon_domain(dovecot, `, privhome')
+daemon_domain(dovecot, `, privhome, nscd_client_domain')
 
 allow dovecot_t dovecot_var_run_t:sock_file create_file_perms;
 
@@ -15,6 +15,8 @@
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
+allow dovecot_t self:tcp_socket connect;
+
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
@@ -34,7 +36,7 @@
 dontaudit dovecot_t krb5_conf_t:file { write };
 allow dovecot_t krb5_conf_t:file { getattr read };
 
-daemon_sub_domain(dovecot_t, dovecot_auth, `, auth')
+daemon_sub_domain(dovecot_t, dovecot_auth, `, auth, nscd_client_domain')
 allow dovecot_auth_t self:process { fork signal_perms };
 allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
 allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.36/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ftpd.te	2004-10-28 09:05:15.000000000 -0400
@@ -4,6 +4,7 @@
 #           Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: proftpd-common bsd-ftpd ftpd vsftpd
 #
+# Depends: inetd.te
 
 #################################
 #
@@ -11,12 +12,13 @@
 #
 type ftp_port_t, port_type, reserved_port_type;
 type ftp_data_port_t, port_type, reserved_port_type;
-daemon_domain(ftpd, `, auth_chkpwd')
+daemon_domain(ftpd, `, auth_chkpwd, nscd_client_domain')
 etc_domain(ftpd)
 typealias ftpd_etc_t alias etc_ftpd_t;
 
 can_network(ftpd_t)
 can_ypbind(ftpd_t)
+allow ftpd_t self:udp_socket connect;
 allow ftpd_t self:unix_dgram_socket { sendto create_socket_perms };
 allow ftpd_t self:unix_stream_socket create_socket_perms;
 allow ftpd_t self:process { getcap setcap setsched setrlimit };
@@ -32,11 +34,13 @@
 
 ifdef(`crond.te', `
 system_crond_entry(ftpd_exec_t, ftpd_t)
+allow system_crond_t xferlog_t:file r_file_perms;
 can_exec(ftpd_t, { sbin_t shell_exec_t })
 allow ftpd_t usr_t:file { getattr read };
 ')
 
 allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
+allow ftpd_t port_t:tcp_socket { name_bind };
 
 # Allow ftpd to run directly without inetd.
 bool ftpd_is_daemon false;
@@ -97,7 +101,7 @@
 # Allow ftp to read/write files in the user home directories.
 bool ftp_home_dir false;
 
-if (ftp_home_dir && nfs_home_dirs) {
+if (ftp_home_dir && use_nfs_home_dirs) {
 allow ftpd_t nfs_t:dir r_dir_perms;
 allow ftpd_t nfs_t:file r_file_perms;
 # dont allow access to /home
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.36/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-11-01 11:04:36.492173950 -0500
+++ policy-1.17.36/domains/program/unused/hald.te	2004-10-28 17:16:42.000000000 -0400
@@ -19,8 +19,8 @@
 allow hald_t self:unix_dgram_socket create_socket_perms;
 
 ifdef(`dbusd.te', `
-allow hald_t system_dbusd_t:dbus { acquire_svc };
-dbusd_client(system, hald_t)
+allow hald_t system_dbusd_t:dbus { acquire_svc send_msg };
+dbusd_client(system, hald)
 ')
 
 allow hald_t { self proc_t }:file { getattr read };
@@ -31,12 +31,13 @@
 
 allow hald_t bin_t:file { getattr };
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
-allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search };
+allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
 can_network(hald_t)
 can_ypbind(hald_t)
 
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
+allow hald_t removable_device_t:blk_file { write };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file { read };
@@ -60,7 +61,11 @@
 allow hald_t usbfs_t:dir search;
 allow hald_t usbfs_t:file { getattr read };
 allow hald_t bin_t:lnk_file read;
-r_dir_file(hald_t, { selinux_config_t default_context_t } )
+dontaudit hald_t selinux_config_t:dir { search };
 allow hald_t initrc_t:dbus { send_msg };
 allow initrc_t hald_t:dbus { send_msg };
 allow hald_t etc_runtime_t:file rw_file_perms;
+allow hald_t var_lib_t:dir search;
+allow hald_t device_t:dir { create_dir_perms };
+allow hald_t { device_t }:{ chr_file } { create_file_perms };
+tmp_domain(hald)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.36/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/hotplug.te	2004-10-28 09:05:15.000000000 -0400
@@ -151,7 +151,7 @@
 
 can_network(hotplug_t)
 can_ypbind(hotplug_t)
-dbusd_client(system, hotplug_t)
+dbusd_client(system, hotplug)
 
 # Allow hotplug (including /sbin/ifup-local) to start/stop services and # run sendmail -q
 domain_auto_trans(hotplug_t, initrc_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.17.36/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/i18n_input.te	2004-10-28 16:33:27.000000000 -0400
@@ -6,11 +6,12 @@
 type i18n_input_port_t, port_type;
 
 # Establish i18n_input as a daemon
-daemon_domain(i18n_input)
+daemon_domain(i18n_input, `, nscd_client_domain')
 
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
 can_ypbind(i18n_input_t)
+allow i18n_input_t self:udp_socket connect;
 
 can_tcp_connect(userdomain, i18n_input_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.36/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/inetd.te	2004-10-28 09:05:15.000000000 -0400
@@ -21,6 +21,8 @@
 daemon_domain(inetd, `, nscd_client_domain ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
+allow inetd_t self:udp_socket connect;
+
 allow inetd_t self:unix_dgram_socket create_socket_perms;
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.17.36/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/innd.te	2004-10-28 17:16:26.000000000 -0400
@@ -12,7 +12,7 @@
 
 
 # need privmail attribute so innd can access system_mail_t
-daemon_domain(innd, `, privmail')
+daemon_domain(innd, `, privmail, nscd_client_domain')
 
 # allow innd to create files and directories of type news_spool_t
 create_dir_file(innd_t, news_spool_t)
@@ -30,6 +30,7 @@
 
 can_network(innd_t)
 can_ypbind(innd_t)
+allow innd_t self:udp_socket connect;
 
 can_unix_send( { innd_t sysadm_t }, { innd_t sysadm_t } )
 allow innd_t self:unix_dgram_socket create_socket_perms;
@@ -64,6 +65,9 @@
 
 ifdef(`crond.te', `
 system_crond_entry(innd_exec_t, innd_t)
+allow system_crond_t innd_etc_t:file { getattr read };
+rw_dir_create_file(system_crond_t, innd_log_t)
+rw_dir_create_file(system_crond_t, innd_var_run_t)
 ')
 ifdef(`syslogd.te', `
 allow syslogd_t innd_log_t:dir search;
@@ -71,6 +75,5 @@
 ')
 allow innd_t self:file { getattr read };
 dontaudit innd_t selinux_config_t:dir { search };
-allow system_crond_t innd_etc_t:file { getattr read };
 allow innd_t bin_t:lnk_file { read };
 allow innd_t sbin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.36/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ipsec.te	2004-10-28 09:05:15.000000000 -0400
@@ -25,7 +25,7 @@
 # lots of strange stuff for the ipsec_var_run_t - need to check it
 var_run_domain(ipsec)
 
-type ipsec_mgmt_t, domain, privlog, admin, privmodule;
+type ipsec_mgmt_t, domain, privlog, admin, privmodule, nscd_client_domain;
 type ipsec_mgmt_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(ipsec_mgmt_t, ipsec_exec_t, ipsec_t)
 file_type_auto_trans(ipsec_mgmt_t, var_run_t, ipsec_var_run_t, sock_file)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.36/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ktalkd.te	2004-10-28 09:05:15.000000000 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.17.36/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/kudzu.te	2004-10-28 09:05:15.000000000 -0400
@@ -13,7 +13,7 @@
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
 allow kudzu_t etc_t:file { getattr read };
-allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config };
+allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
 allow kudzu_t modules_conf_t:file { getattr read };
 allow kudzu_t modules_object_t:dir r_dir_perms;
 allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
@@ -80,7 +80,8 @@
 allow kudzu_t sysfs_t:lnk_file read;
 file_type_auto_trans(kudzu_t, etc_t, etc_runtime_t, file)
 allow kudzu_t tape_device_t:chr_file r_file_perms;
-allow kudzu_t tmp_t:dir { search };
+tmp_domain(kudzu)
+file_type_auto_trans(kudzu_t, tmp_t, kudzu_tmp_t, chr_file)
 
 # for file systems that are not yet mounted
 dontaudit kudzu_t file_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.17.36/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/mailman.te	2004-10-28 14:35:22.000000000 -0400
@@ -20,7 +20,7 @@
 can_exec_any(mailman_$1_t)
 allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
-allow mailman_$1_t var_lib_t:dir { getattr search };
+allow mailman_$1_t var_lib_t:dir { getattr search read };
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
 allow mailman_$1_t etc_runtime_t:file { read getattr };
@@ -30,12 +30,16 @@
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
 can_ypbind(mailman_$1_t)
+allow mailman_$1_t self:udp_socket connect;
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
 ')
 
-mailman_domain(queue, `, auth_chkpwd')
+mailman_domain(queue, `, auth_chkpwd, nscd_client_domain')
 can_tcp_connect(mailman_queue_t, mail_server_domain)
+allow mailman_queue_t self:tcp_socket connect;
+
+dontaudit mailman_queue_t src_t:dir { search };
 
 can_exec(mailman_queue_t, su_exec_t)
 allow mailman_queue_t self:capability { setgid setuid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mdadm.te policy-1.17.36/domains/program/unused/mdadm.te
--- nsapolicy/domains/program/unused/mdadm.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/mdadm.te	2004-10-28 09:05:15.000000000 -0400
@@ -40,4 +40,4 @@
 dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
 dontaudit mdadm_t initctl_t:fifo_file { getattr };
 var_run_domain(mdadm)
-allow mdadm_t var_t:dir { getattr };
+allow mdadm_t var_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.17.36/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.36/domains/program/unused/mysqld.te	2004-10-28 09:05:15.000000000 -0400
@@ -10,7 +10,7 @@
 #
 # mysqld_exec_t is the type of the mysqld executable.
 #
-daemon_domain(mysqld)
+daemon_domain(mysqld, `, nscd_client_domain' )
 
 type mysqld_port_t, port_type;
 allow mysqld_t mysqld_port_t:tcp_socket name_bind;
@@ -35,7 +35,7 @@
 
 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
 
-allow mysqld_t self:capability { dac_override setgid setuid };
+allow mysqld_t self:capability { dac_override setgid setuid net_bind_service };
 allow mysqld_t self:process getsched;
 
 allow mysqld_t proc_t:file { getattr read };
@@ -46,6 +46,7 @@
 
 can_network(mysqld_t)
 can_ypbind(mysqld_t)
+allow mysqld_t self:tcp_socket connect;
 
 # read config files
 r_dir_file(initrc_t, mysqld_etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.36/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/named.te	2004-10-28 09:05:15.000000000 -0400
@@ -19,7 +19,7 @@
 file_type_auto_trans(named_t, var_run_t, named_var_run_t, sock_file)
 
 # ndc_t is the domain for the ndc program
-type ndc_t, domain, privlog;
+type ndc_t, domain, privlog, nscd_client_domain;
 role sysadm_r types ndc_t;
 role system_r types ndc_t;
 
@@ -52,6 +52,8 @@
 #Named can use network
 can_network(named_t)
 can_ypbind(named_t)
+allow named_t self:tcp_socket connect;
+
 # allow UDP transfer to/from any program
 can_udp_send(domain, named_t)
 can_udp_send(named_t, domain)
@@ -102,6 +104,7 @@
 uses_shlib(ndc_t)
 can_network(ndc_t)
 can_ypbind(ndc_t)
+allow ndc_t self:tcp_socket connect;
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.36/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/nscd.te	2004-10-28 09:05:15.000000000 -0400
@@ -24,6 +24,7 @@
 allow nscd_t etc_t:lnk_file read;
 can_network(nscd_t)
 can_ypbind(nscd_t)
+allow nscd_t self:{ tcp_socket udp_socket } connect;
 
 file_type_auto_trans(nscd_t, var_run_t, nscd_var_run_t, sock_file)
 
@@ -53,7 +54,7 @@
 allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
-allow nscd_t self:capability { kill setgid setuid net_bind_service net_admin };
+allow nscd_t self:capability { kill setgid setuid net_bind_service net_admin sys_tty_config };
 
 # for when /etc/passwd has just been updated and has the wrong type
 allow nscd_t shadow_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.36/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ntpd.te	2004-10-28 09:05:15.000000000 -0400
@@ -12,6 +12,9 @@
 type ntp_drift_t, file_type, sysadmfile;
 type ntp_port_t, port_type, reserved_port_type;
 
+type ntpdate_exec_t, file_type, sysadmfile, exec_type;
+domain_auto_trans(initrc_t, ntpdate_exec_t, ntpd_t)
+
 logdir_domain(ntpd)
 
 allow ntpd_t var_lib_t:dir r_dir_perms;
@@ -36,6 +39,7 @@
 # Use the network.
 can_network(ntpd_t)
 can_ypbind(ntpd_t)
+allow ntpd_t self:{ tcp_socket udp_socket } connect;
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.17.36/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2004-06-16 13:33:36.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ping.te	2004-10-28 09:05:15.000000000 -0400
@@ -35,6 +35,7 @@
 can_ypbind(ping_t)
 allow ping_t etc_t:file { getattr read };
 allow ping_t self:unix_stream_socket create_socket_perms;
+allow ping_t self:{ tcp_socket udp_socket } connect;
 
 # Let ping create raw ICMP packets.
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
@@ -43,7 +44,7 @@
 allow ping_t node_type:node { rawip_send rawip_recv };
 
 # Use capabilities.
-allow ping_t self:capability { net_raw setuid };
+allow ping_t self:capability { net_raw setuid net_bind_service };
 
 # Access the terminal.
 allow ping_t admin_tty_type:chr_file rw_file_perms;
@@ -55,3 +56,5 @@
 # it tries to access /var/run
 dontaudit ping_t var_t:dir search;
 
+dontaudit ping_t devtty_t:chr_file { read write };
+dontaudit ping_t ping_t:capability { sys_tty_config };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.36/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.36/domains/program/unused/portmap.te	2004-10-31 06:59:56.000000000 -0500
@@ -23,6 +23,7 @@
 tmp_domain(portmap)
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
+dontaudit portmap_t reserved_port_type:tcp_socket name_bind;
 
 # portmap binds to arbitary ports
 allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
@@ -51,4 +52,4 @@
 
 # Use capabilities
 allow portmap_t self:capability { net_bind_service setuid setgid };
-
+allow portmap_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.17.36/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/postfix.te	2004-10-28 09:05:15.000000000 -0400
@@ -66,7 +66,7 @@
 ifdef(`crond.te',
 `allow system_mail_t crond_t:tcp_socket { read write create };')
 
-postfix_domain(master, `, mail_server_domain')
+postfix_domain(master, `, mail_server_domain, nscd_client_domain')
 rhgb_domain(postfix_master_t)
 
 read_sysctl(postfix_master_t)
@@ -119,6 +119,8 @@
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
 can_ypbind(postfix_master_t)
+allow postfix_master_t self:{ tcp_socket udp_socket } connect;
+
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
@@ -155,9 +157,10 @@
 postfix_domain($1, `$2')
 domain_auto_trans(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
-allow postfix_$1_t self:capability { setuid setgid dac_override };
+allow postfix_$1_t self:capability { setuid setgid dac_override net_bind_service };
 can_network(postfix_$1_t)
 can_ypbind(postfix_$1_t)
+allow postfix_$1_t self:{ tcp_socket udp_socket } connect;
 ')
 
 postfix_server_domain(smtp, `, mail_server_sender')
@@ -207,7 +210,7 @@
 can_exec(postfix_local_t, shell_exec_t)
 
 define(`postfix_public_domain',`
-postfix_server_domain($1)
+postfix_server_domain($1, `$2')
 allow postfix_$1_t postfix_public_t:dir search;
 ')
 
@@ -286,7 +289,7 @@
 allow postfix_postdrop_t self:udp_socket create_socket_perms;
 allow postfix_postdrop_t self:capability sys_resource;
 
-postfix_public_domain(pickup)
+postfix_public_domain(pickup, `, nscd_client_domain' )
 allow postfix_pickup_t postfix_public_t:fifo_file rw_file_perms;
 allow postfix_pickup_t postfix_public_t:sock_file rw_file_perms;
 allow postfix_pickup_t postfix_private_t:dir search;
@@ -297,7 +300,7 @@
 allow postfix_pickup_t postfix_spool_maildrop_t:file unlink;
 allow postfix_pickup_t self:tcp_socket create_socket_perms;
 
-postfix_public_domain(qmgr)
+postfix_public_domain(qmgr, `, nscd_client_domain' )
 allow postfix_qmgr_t postfix_public_t:fifo_file rw_file_perms;
 allow postfix_qmgr_t postfix_public_t:sock_file write;
 allow postfix_qmgr_t postfix_private_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.17.36/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/postgresql.te	2004-10-28 09:05:15.000000000 -0400
@@ -11,8 +11,10 @@
 # postgresql_exec_t is the type of the postgresql executable.
 #
 type postgresql_port_t, port_type;
-daemon_domain(postgresql)
+daemon_domain(postgresql, `, nscd_client_domain ' )
 allow initrc_t postgresql_exec_t:lnk_file read;
+allow postgresql_t usr_t:file { getattr read };
+allow postgresql_t self:udp_socket connect;
 
 allow postgresql_t postgresql_var_run_t:sock_file create_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/privoxy.te policy-1.17.36/domains/program/unused/privoxy.te
--- nsapolicy/domains/program/unused/privoxy.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.36/domains/program/unused/privoxy.te	2004-10-28 09:05:15.000000000 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the privoxy_t domain.
 #
-daemon_domain(privoxy)
+daemon_domain(privoxy, `, nscd_client_domain')
 
 logdir_domain(privoxy)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radius.te policy-1.17.36/domains/program/unused/radius.te
--- nsapolicy/domains/program/unused/radius.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/radius.te	2004-10-28 09:05:15.000000000 -0400
@@ -12,7 +12,7 @@
 #
 type radius_port_t, port_type;
 type radacct_port_t, port_type;
-daemon_domain(radiusd, `, auth')
+daemon_domain(radiusd, `, auth, nscd_client_domain')
 
 etcdir_domain(radiusd)
 typealias radiusd_etc_t alias etc_radiusd_t;
@@ -48,11 +48,12 @@
 allow radiusd_t self:fifo_file rw_file_perms;
 # fsetid is for gzip which needs it when run from scripts
 # gzip also needs chown access to preserve GID for radwtmp files
-allow radiusd_t self:capability { chown dac_override fsetid kill setgid setuid sys_resource sys_tty_config };
+allow radiusd_t self:capability { chown dac_override fsetid kill setgid setuid sys_resource sys_tty_config net_bind_service };
 
 can_network(radiusd_t)
 can_ypbind(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
+allow radiusd_t self:tcp_socket connect;
 
 # for RADIUS proxy port
 allow radiusd_t port_t:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.17.36/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/rpcd.te	2004-10-28 09:05:15.000000000 -0400
@@ -11,9 +11,10 @@
 # Rules for the rpcd_t and nfsd_t domain.
 #
 define(`rpc_domain', `
-daemon_base_domain($1)
+daemon_base_domain($1, `, nscd_client_domain' )
 can_network($1_t)
 can_ypbind($1_t)
+allow $1_t self:{ udp_socket tcp_socket } connect;
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
 allow $1_t self:capability net_bind_service;
@@ -24,6 +25,7 @@
 allow $1_t var_lib_nfs_t:file create_file_perms;
 # do not log when it tries to bind to a port belonging to another domain
 dontaudit $1_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+allow $1_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
 allow $1_t self:netlink_route_socket r_netlink_socket_perms;
 allow $1_t self:unix_dgram_socket create_socket_perms;
 allow $1_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.17.36/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/rshd.te	2004-10-28 09:05:15.000000000 -0400
@@ -34,5 +34,7 @@
 allow rshd_t krb5_conf_t:file { getattr read };
 dontaudit rshd_t krb5_conf_t:file write;
 allow rshd_t tmp_t:dir { search };
+ifdef(`rlogind.te', `
 allow rshd_t rlogind_tmp_t:file rw_file_perms;
+')
 allow rshd_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.36/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/rsync.te	2004-10-28 09:05:15.000000000 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.36/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/domains/program/unused/sendmail.te	2004-10-28 09:05:15.000000000 -0400
@@ -27,6 +27,7 @@
 # Use the network.
 can_network(sendmail_t)
 can_ypbind(sendmail_t)
+allow sendmail_t self:{ tcp_socket udp_socket } connect;
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
 allow sendmail_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.17.36/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/slapd.te	2004-10-28 09:05:15.000000000 -0400
@@ -10,7 +10,7 @@
 #
 # slapd_exec_t is the type of the slapd executable.
 #
-daemon_domain(slapd)
+daemon_domain(slapd, `, nscd_client_domain' )
 
 type ldap_port_t, port_type, reserved_port_type;
 allow slapd_t ldap_port_t:tcp_socket name_bind;
@@ -30,6 +30,7 @@
 allow slapd_t self:unix_dgram_socket create_socket_perms;
 # allow any domain to connect to the LDAP server
 can_tcp_connect(domain, slapd_t)
+allow slapd_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities  should not need kill...
 allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slocate.te policy-1.17.36/domains/program/unused/slocate.te
--- nsapolicy/domains/program/unused/slocate.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/slocate.te	2004-10-28 09:05:15.000000000 -0400
@@ -9,7 +9,7 @@
 #
 # locate_exec_t is the type of the locate executable.
 #
-daemon_base_domain(locate)
+daemon_base_domain(locate, `, nscd_client_domain' )
 
 allow locate_t fs_t:filesystem getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.36/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.36/domains/program/unused/snmpd.te	2004-10-28 09:05:15.000000000 -0400
@@ -8,13 +8,14 @@
 #
 # Rules for the snmpd_t domain.
 #
-daemon_domain(snmpd)
+daemon_domain(snmpd, `, nscd_client_domain' )
 
 #temp
 allow snmpd_t var_t:dir getattr;
 
 can_network(snmpd_t)
 can_ypbind(snmpd_t)
+allow snmpd_t self:{ tcp_socket udp_socket } connect;
 
 type snmp_port_t, port_type, reserved_port_type;
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
@@ -38,7 +39,7 @@
 allow snmpd_t self:unix_dgram_socket create_socket_perms;
 allow snmpd_t self:unix_stream_socket create_socket_perms;
 allow snmpd_t etc_t:lnk_file read;
-allow snmpd_t { etc_t etc_runtime_t }:file { getattr read };
+allow snmpd_t { etc_t etc_runtime_t }:file r_file_perms;
 allow snmpd_t urandom_device_t:chr_file read;
 allow snmpd_t self:capability { dac_override kill net_bind_service net_admin sys_nice sys_tty_config };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.17.36/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/domains/program/unused/spamd.te	2004-10-28 16:33:17.000000000 -0400
@@ -5,7 +5,7 @@
 # Depends: spamassassin.te
 #
 
-daemon_domain(spamd)
+daemon_domain(spamd, `, nscd_client_domain' )
 
 tmp_domain(spamd)
 
@@ -24,7 +24,9 @@
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
 
 can_network(spamd_t)
+allow spamd_t self:udp_socket connect;
 allow spamd_t self:capability { net_bind_service };
+allow spamd_t self:tcp_socket connect;
 
 allow spamd_t proc_t:file { getattr read };
 
@@ -59,7 +61,7 @@
 allow spamd_t autofs_t:dir { search getattr };
 ')
 
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 allow spamd_t nfs_t:dir rw_dir_perms;
 allow spamd_t nfs_t:file create_file_perms;
 }
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.17.36/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/domains/program/unused/squid.te	2004-10-28 09:05:15.000000000 -0400
@@ -56,6 +56,7 @@
 can_network(squid_t)
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
+allow squid_t self:{ tcp_socket udp_socket } connect;
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
 allow squid_t http_cache_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.17.36/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.36/domains/program/unused/swat.te	2004-10-28 09:05:15.000000000 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.17.36/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/traceroute.te	2004-10-28 13:35:45.000000000 -0400
@@ -20,6 +20,7 @@
 uses_shlib(traceroute_t)
 can_network(traceroute_t)
 can_ypbind(traceroute_t)
+allow traceroute_t self:{ tcp_socket udp_socket } connect;
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.36/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/udev.te	2004-10-28 09:05:15.000000000 -0400
@@ -81,6 +81,7 @@
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')
+dontaudit udev_t staff_home_dir_t:dir { search };
 
 ifdef(`hotplug.te', `
 r_dir_file(udev_t, hotplug_etc_t)
@@ -108,7 +109,7 @@
 
 allow udev_t udev_helper_exec_t:dir r_dir_perms;
 
-dbusd_client(system, udev_t)
+dbusd_client(system, udev)
 
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
 allow udev_t sysctl_dev_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.36/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/domains/program/unused/updfstab.te	2004-10-28 09:05:15.000000000 -0400
@@ -28,7 +28,10 @@
 
 read_locale(updfstab_t)
 
-dbusd_client(system, updfstab_t)
+ifdef(`dbusd.te', `
+dbusd_client(system, updfstab)
+allow updfstab_t system_dbusd_t:dbus { send_msg };
+')
 
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
 # I will not allow it
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.17.36/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/vpnc.te	2004-10-28 09:05:15.000000000 -0400
@@ -10,13 +10,15 @@
 # vpnc_t is the domain for the vpnc program.
 # vpnc_exec_t is the type of the vpnc executable.
 #
-daemon_domain(vpnc)
+daemon_domain(vpnc, `, nscd_client_domain' )
 
 allow vpnc_t { random_device_t urandom_device_t }:chr_file read;
 
 # Use the network.
 can_network(vpnc_t)
 can_ypbind(vpnc_t)
+allow vpnc_t self:udp_socket connect;
+allow vpnc_t self:socket create_socket_perms;
 
 # Use capabilities.
 allow vpnc_t self:capability { net_admin ipc_lock net_bind_service net_raw };
@@ -28,3 +30,13 @@
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
 allow vpnc_t admin_tty_type:chr_file rw_file_perms;
+allow vpnc_t self:socket connect;
+allow vpnc_t port_t:udp_socket { name_bind };
+allow vpnc_t etc_runtime_t:file { getattr read };
+allow vpnc_t proc_t:file { getattr read };
+dontaudit vpnc_t selinux_config_t:dir search;
+can_exec(vpnc_t, {bin_t sbin_t ifconfig_exec_t shell_exec_t })
+allow vpnc_t sysctl_net_t:dir { search };
+allow vpnc_t sbin_t:dir { search };
+allow vpnc_t bin_t:dir { search };
+allow vpnc_t bin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.17.36/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-11-01 11:04:36.821136743 -0500
+++ policy-1.17.36/domains/program/unused/xdm.te	2004-10-28 09:05:15.000000000 -0400
@@ -47,6 +47,7 @@
 
 can_network(xdm_t)
 can_ypbind(xdm_t)
+allow xdm_t self:udp_socket connect;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
@@ -277,7 +277,7 @@
 allow xdm_xserver_t user_home_type:dir search;
 allow xdm_xserver_t user_home_type:file { getattr read };
 
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow { xdm_t xdm_xserver_t } autofs_t:dir { search getattr };
 ')
@@ -287,7 +287,7 @@
 }
 
 # for .dmrc
-allow xdm_t user_home_dir_type:dir search;
+allow xdm_t user_home_dir_type:dir { getattr search };
 allow xdm_t user_home_type:file { getattr read };
 
 allow xdm_t mnt_t:dir { getattr read search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xfs.te policy-1.17.36/domains/program/unused/xfs.te
--- nsapolicy/domains/program/unused/xfs.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/xfs.te	2004-10-28 09:05:15.000000000 -0400
@@ -12,7 +12,7 @@
 # xfs_t is the domain of the X font server.
 # xfs_exec_t is the type of the xfs executable.
 #
-daemon_domain(xfs)
+daemon_domain(xfs, `, nscd_client_domain' )
 
 # for /tmp/.font-unix/fs7100
 ifdef(`distro_debian', `
@@ -29,8 +29,10 @@
 allow xfs_t self:process setpgid;
 can_ypbind(xfs_t)
 
+allow xfs_t self:tcp_socket connect;
+
 # Use capabilities.
-allow xfs_t self:capability { setgid setuid };
+allow xfs_t self:capability { setgid setuid net_bind_service };
 
 # Bind to /tmp/.font-unix/fs-1.
 allow xfs_t xfs_tmp_t:unix_stream_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.17.36/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-10-14 23:25:19.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ypbind.te	2004-10-28 16:11:51.000000000 -0400
@@ -10,9 +10,7 @@
 #
 # Rules for the ypbind_t domain.
 #
-daemon_domain(ypbind)
-
-bool allow_ypbind true;
+daemon_domain(ypbind, `, nscd_client_domain' )
 
 tmp_domain(ypbind)
 
@@ -22,6 +20,7 @@
 # Use the network.
 can_network(ypbind_t)
 allow ypbind_t port_t:{ tcp_socket udp_socket } name_bind;
+allow ypbind_t self:{ tcp_socket udp_socket } connect;
 
 allow ypbind_t self:fifo_file rw_file_perms;
 
@@ -39,5 +38,5 @@
 allow ypbind_t etc_t:file { getattr read };
 allow ypbind_t self:{ unix_dgram_socket unix_stream_socket } create_socket_perms;
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
-allow ypbind_t reserved_port_t:tcp_socket { name_bind };
-allow ypbind_t reserved_port_t:udp_socket { name_bind };
+allow ypbind_t reserved_port_t:{ tcp_socket udp_socket } { name_bind };
+dontaudit ypbind_t reserved_port_type:{udp_socket tcp_socket} { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.17.36/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ypserv.te	2004-10-28 16:12:37.000000000 -0400
@@ -40,3 +40,4 @@
 allow rpcd_t ypserv_conf_t:file { getattr read };
 ')
 allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
+dontaudit ypserv_t reserved_port_type:{ tcp_socket udp_socket } { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/zebra.te policy-1.17.36/domains/program/unused/zebra.te
--- nsapolicy/domains/program/unused/zebra.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/zebra.te	2004-10-28 09:05:15.000000000 -0400
@@ -5,7 +5,7 @@
 #
 type zebra_port_t, port_type;
 
-daemon_domain(zebra, `, sysctl_net_writer')
+daemon_domain(zebra, `, sysctl_net_writer, nscd_client_domain')
 type zebra_conf_t, file_type, sysadmfile;
 r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.17.36/domains/user.te
--- nsapolicy/domains/user.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/user.te	2004-10-28 09:05:44.000000000 -0400
@@ -8,13 +8,16 @@
 bool user_dmesg false;
 
 # Support NFS home directories
-bool nfs_home_dirs false;
+bool use_nfs_home_dirs false;
 
 # Allow users to run TCP servers (bind to ports and accept connection from
 # the same domain and outside users)  disabling this forces FTP passive mode
 # and may change other protocols 
 bool user_tcp_server false;
 
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ntpd.fc policy-1.17.36/file_contexts/program/ntpd.fc
--- nsapolicy/file_contexts/program/ntpd.fc	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.36/file_contexts/program/ntpd.fc	2004-10-28 09:05:15.000000000 -0400
@@ -3,7 +3,7 @@
 /etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
-/usr/sbin/ntpdate		--	system_u:object_r:ntpd_exec_t
+/usr/sbin/ntpdate		--	system_u:object_r:ntpdate_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
 /var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/vpnc.fc policy-1.17.36/file_contexts/program/vpnc.fc
--- nsapolicy/file_contexts/program/vpnc.fc	2004-10-05 10:43:34.000000000 -0400
+++ policy-1.17.36/file_contexts/program/vpnc.fc	2004-10-28 09:05:15.000000000 -0400
@@ -1,2 +1,3 @@
 # vpnc
 /usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
+/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.36/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/file_contexts/types.fc	2004-10-29 11:57:08.000000000 -0400
@@ -339,7 +339,8 @@
 /usr/inclu.e(/.*)?		system_u:object_r:usr_t
 /usr/libexec(/.*)?		system_u:object_r:bin_t
 /usr/src(/.*)?			system_u:object_r:src_t
-/usr/tmp(/.*)?			system_u:object_r:tmp_t
+/usr/tmp		-d	system_u:object_r:tmp_t
+/usr/tmp/.*			<<none>>
 /usr/man(/.*)?			system_u:object_r:man_t
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.17.36/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.36/macros/admin_macros.te	2004-10-28 11:33:38.000000000 -0400
@@ -195,4 +195,5 @@
 
 # for lsof
 allow $1_t domain:socket_class_set getattr;
+allow $1_t eventpollfs_t:file getattr;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.36/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-01 11:04:37.640044119 -0500
+++ policy-1.17.36/macros/base_user_macros.te	2004-10-28 13:18:07.000000000 -0400
@@ -47,8 +47,10 @@
 
 # open office is looking for the following
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
-# Do not flood message log, if the user does ls /dev 
+# Do not flood message log, if the user does ls -lR /
 dontaudit $1_t dev_fs:dir_file_class_set getattr;
+dontaudit $1_t sysadmfile:file getattr;
+dontaudit $1_t sysadmfile:dir read;
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
@@ -61,7 +63,7 @@
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 create_dir_file($1_t, nfs_t)
 can_exec($1_t, nfs_t)
 allow $1_t nfs_t:{ sock_file fifo_file } create_file_perms;
@@ -193,11 +192,23 @@
 # Use the network.
 can_network($1_t)
 can_ypbind($1_t)
+allow $1_t self:{ tcp_socket udp_socket } connect;
+
+ifdef(`pamconsole.te', `
+allow $1_t pam_var_console_t:dir { search };
+')
+
+allow $1_t var_lock_t:dir { search };
 
 # Grant permissions to access the system DBus
 ifdef(`dbusd.te', `
-dbusd_client(system, $1_t)
-dbusd_client($1, $1_t)
+dbusd_client(system, $1)
+can_network($1_dbusd_t)
+allow user_dbusd_t reserved_port_t:tcp_socket { name_bind };
+
+allow $1_t system_dbusd_t:dbus { send_msg acquire_svc };
+dbusd_client($1, $1)
+allow $1_t $1_dbusd_t:dbus { send_msg acquire_svc };
 dbusd_domain($1)
 ifdef(`hald.te', `
 allow $1_t hald_t:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.17.36/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-09-22 16:19:13.000000000 -0400
+++ policy-1.17.36/macros/core_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -132,22 +132,32 @@
 #
 # Permissions for using sockets.
 # 
-define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
+define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind getopt setopt shutdown }')
 
 #
 # Permissions for creating and using sockets.
 # 
-define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
+define(`connected_socket_perms', `{ create rw_socket_perms }')
+
+#
+# Permissions for creating, connecting and using sockets.
+# 
+define(`create_socket_perms', `{ connected_socket_perms connect }')
 
 #
 # Permissions for using stream sockets.
 # 
-define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+define(`rw_stream_socket_perms', `{ rw_socket_perms listen accept }')
+
+#
+# Permissions for creating and using stream sockets.
+# 
+define(`connected_stream_socket_perms', `{ create rw_stream_socket_perms }')
 
 #
 # Permissions for creating and using stream sockets.
 # 
-define(`create_stream_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+define(`create_stream_socket_perms', `{ connect connected_stream_socket_perms }')
 
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.36/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/macros/global_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -118,64 +118,6 @@
 
 #################################
 #
-# can_network(domain)
-#
-# Permissions for accessing the network.
-# See types/network.te for the network types.
-# See net_contexts for security contexts for network entities.
-#
-define(`can_network',`
-#
-# Allow the domain to create and use UDP and TCP sockets.
-# Other kinds of sockets must be separately authorized for use.
-allow $1 self:udp_socket create_socket_perms;
-allow $1 self:tcp_socket create_stream_socket_perms;
-
-#
-# Allow the domain to send or receive using any network interface.
-# netif_type is a type attribute for all network interface types.
-#
-allow $1 netif_type:netif { tcp_send udp_send rawip_send };
-allow $1 netif_type:netif { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any node.
-# node_type is a type attribute for all node types.
-#
-allow $1 node_type:node { tcp_send udp_send rawip_send };
-allow $1 node_type:node { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any port.
-# port_type is a type attribute for all port types.
-#
-allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
-
-#
-# Allow the domain to send NFS client requests via the socket
-# created by mount.
-#
-allow $1 mount_t:udp_socket rw_socket_perms;
-
-#
-# Bind to the default port type.
-# Other port types must be separately authorized.
-#
-#allow $1 port_t:udp_socket name_bind;
-#allow $1 port_t:tcp_socket name_bind;
-
-# XXX Allow binding to any node type.  Remove once
-# individual rules have been added to all domains that 
-# bind sockets. 
-allow $1 node_type: { tcp_socket udp_socket } node_bind;
-#
-# Allow access to network files including /etc/resolv.conf
-#
-allow $1 net_conf_t:file r_file_perms;
-')dnl end can_network definition
-
-#################################
-#
 # can_sysctl(domain)
 #
 # Permissions for modifying sysctl parameters.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.17.36/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.36/macros/network_macros.te	2004-10-28 11:37:50.000000000 -0400
@@ -0,0 +1,94 @@
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`base_can_network',`
+#
+# Allow the domain to create and use $2 sockets.
+# Other kinds of sockets must be separately authorized for use.
+allow $1 self:$2_socket connected_socket_perms;
+
+#
+# Allow the domain to send or receive using any network interface.
+# netif_type is a type attribute for all network interface types.
+#
+allow $1 netif_type:netif { $2_send rawip_send };
+allow $1 netif_type:netif { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any node.
+# node_type is a type attribute for all node types.
+#
+allow $1 node_type:node { $2_send rawip_send };
+allow $1 node_type:node { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any port.
+# port_type is a type attribute for all port types.
+#
+ifelse($3, `', `
+allow $1 port_type:{ $2_socket } { send_msg recv_msg };
+', `
+allow $1 $3:{ $2_socket } { send_msg recv_msg };
+')
+
+# XXX Allow binding to any node type.  Remove once
+# individual rules have been added to all domains that 
+# bind sockets. 
+allow $1 node_type: { $2_socket } node_bind;
+#
+# Allow access to network files including /etc/resolv.conf
+#
+allow $1 net_conf_t:file r_file_perms;
+')dnl end can_network definition
+
+#################################
+#
+# can_tcp_network(domain)
+#
+# Permissions for accessing a tcp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_tcp_network',`
+base_can_network($1, tcp, `$2')
+allow $1 self:tcp_socket { listen accept };
+')
+
+#################################
+#
+# can_udp_network(domain)
+#
+# Permissions for accessing a udp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_udp_network',`
+base_can_network($1, udp, `$2')
+')
+
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network',`
+
+can_tcp_network($1)
+can_udp_network($1)
+
+#
+# Allow the domain to send NFS client requests via the socket
+# created by mount.
+#
+allow $1 mount_t:udp_socket rw_socket_perms;
+
+')dnl end can_network definition
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/crond_macros.te policy-1.17.36/macros/program/crond_macros.te
--- nsapolicy/macros/program/crond_macros.te	2004-09-02 14:45:47.000000000 -0400
+++ policy-1.17.36/macros/program/crond_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -20,7 +20,7 @@
 define(`crond_domain',`
 # Derived domain for user cron jobs, user user_crond_domain if not system
 ifelse(`system', `$1', `
-type $1_crond_t, domain, privlog, privmail;
+type $1_crond_t, domain, privlog, privmail, nscd_client_domain;
 ', `
 type $1_crond_t, domain, user_crond_domain;
 
@@ -68,6 +68,7 @@
 # This domain is granted permissions common to most domains.
 can_network($1_crond_t)
 can_ypbind($1_crond_t)
+allow $1_crond_t self:{ tcp_socket udp_socket } connect;
 r_dir_file($1_crond_t, self)
 allow $1_crond_t self:fifo_file rw_file_perms;
 allow $1_crond_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/dbusd_macros.te policy-1.17.36/macros/program/dbusd_macros.te
--- nsapolicy/macros/program/dbusd_macros.te	2004-10-07 08:02:02.000000000 -0400
+++ policy-1.17.36/macros/program/dbusd_macros.te	2004-10-29 14:29:32.000000000 -0400
@@ -24,6 +24,7 @@
 domain_auto_trans($1_t, dbusd_exec_t, $1_dbusd_t)
 read_locale($1_dbusd_t)
 allow $1_t $1_dbusd_t:process { sigkill signal };
+allow $1_dbusd_t self:process { sigkill signal };
 dontaudit $1_dbusd_t var_t:dir { getattr search };
 ')dnl end ifdef single_userdomain
 ')dnl end ifelse system
@@ -50,26 +51,44 @@
 r_dir_file($1_dbusd_t, pam_var_console_t)
 ')
 
+allow $1_dbusd_t self:dbus { send_msg acquire_svc };
+
 ')dnl end dbusd_domain definition
 
-# dbusd_client(dbus_type, domain)
-# Example: dbusd_client_domain(system, user_t)
+# dbusd_client(dbus_type, domain_prefix)
+# Example: dbusd_client_domain(system, user)
 #
-# Grant permissions for connecting to the specified DBus type
-# from domain.
+# Define a new derived domain for connecting to dbus_type
+# from domain_prefix_t. 
 define(`dbusd_client',`')
 ifdef(`dbusd.te',`
 undefine(`dbusd_client')
 define(`dbusd_client',`
+
+# Derived type used for connection
+type $2_dbusd_$1_t;
+type_change $2_t $1_dbusd_t:dbus $2_dbusd_$1_t;
+
 # For connecting to the bus
-allow $2 $1_dbusd_t:unix_stream_socket { connectto };
+allow $2_t $1_dbusd_t:unix_stream_socket { connectto };
 ifelse(`system', `$1', `
-allow { $2 } { var_run_t system_dbusd_var_run_t }:dir search;
-allow { $2 } system_dbusd_var_run_t:sock_file { write };
+allow { $2_t } { var_run_t system_dbusd_var_run_t }:dir search;
+allow { $2_t } system_dbusd_var_run_t:sock_file { write };
 ',`
 ') dnl endif system
 # SE-DBus specific permissions
-allow $2 { $1_dbusd_t self }:dbus { send_msg };
-allow $2 $1_dbusd_t:dbus { acquire_svc };
+allow $2_dbusd_$1_t { $1_dbusd_t self }:dbus { send_msg };
+') dnl endif dbusd.te
+')
+
+# can_dbusd_converse(dbus_type, domain_prefix_a, domain_prefix_b)
+# Example: can_dbusd_converse(system, hald, updfstab)
+# Example: can_dbusd_converse(session, user, user)
+define(`can_dbusd_converse',`')
+ifdef(`dbusd.te',`
+undefine(`can_dbusd_converse')
+define(`can_dbusd_converse',`
+allow $2_dbusd_$1_t $3_dbusd_$1_t:dbus { send_msg };
+allow $3_dbusd_$1_t $2_dbusd_$1_t:dbus { send_msg };
 ') dnl endif dbusd.te
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_agent_macros.te policy-1.17.36/macros/program/gpg_agent_macros.te
--- nsapolicy/macros/program/gpg_agent_macros.te	2004-09-20 15:41:01.000000000 -0400
+++ policy-1.17.36/macros/program/gpg_agent_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -48,11 +48,11 @@
 # read ~/.gnupg
 allow $1_gpg_agent_t { home_root_t $1_home_dir_t }:dir search;
 r_dir_file($1_gpg_agent_t, $1_gpg_secret_t)
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 r_dir_file($1_gpg_agent_t, nfs_t)
 # write ~/.xsession-errors
 allow $1_gpg_agent_t nfs_t:file write;
-')
+}
 
 allow $1_gpg_agent_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_gpg_agent_t self:fifo_file { getattr read write };
@@ -107,12 +107,12 @@
 # wants to put some lock files into the user home dir, seems to work fine without
 dontaudit $1_gpg_pinentry_t $1_home_t:dir { read write };
 dontaudit $1_gpg_pinentry_t $1_home_t:file write;
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 allow $1_gpg_pinentry_t nfs_t:dir { getattr search };
 allow $1_gpg_pinentry_t nfs_t:file { getattr read };
 dontaudit $1_gpg_pinentry_t nfs_t:dir { read write };
 dontaudit $1_gpg_pinentry_t nfs_t:file write;
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 # read /etc/X11/qtrc
 allow $1_gpg_pinentry_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.17.36/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2004-08-27 09:30:30.000000000 -0400
+++ policy-1.17.36/macros/program/gpg_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -83,9 +83,9 @@
 # allow the usual access to /tmp
 file_type_auto_trans($1_gpg_t, tmp_t, $1_tmp_t)
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 create_dir_file($1_gpg_t, nfs_t)
-')dnl end if nfs_home_dirs
+}dnl end if use_nfs_home_dirs
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
 allow $1_gpg_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gph_macros.te policy-1.17.36/macros/program/gph_macros.te
--- nsapolicy/macros/program/gph_macros.te	2004-03-17 13:26:06.000000000 -0500
+++ policy-1.17.36/macros/program/gph_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -25,7 +25,7 @@
 undefine(`gph_domain')
 define(`gph_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_gph_t, domain, gphdomain;
+type $1_gph_t, domain, gphdomain, nscd_client_domain;
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gph_exec_t, $1_gph_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.17.36/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2004-07-26 16:16:11.000000000 -0400
+++ policy-1.17.36/macros/program/lpr_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -80,9 +80,9 @@
 allow $1_lpr_t { home_root_t $1_home_t $1_home_dir_t }:dir search;  
 allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 r_dir_file($1_lpr_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 # Read and write shared files in the spool directory.
 allow $1_lpr_t print_spool_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.17.36/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-10-19 16:03:08.000000000 -0400
+++ policy-1.17.36/macros/program/mount_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -67,9 +67,11 @@
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 
 ifdef(`distro_redhat',`
+ifdef(`pamconsole.te',`
 r_dir_file($2_t,pam_var_console_t)
 # mount config by default sets fscontext=removable_t
 allow $2_t dosfs_t:filesystem { relabelfrom };
+') dnl end pamconsole.te
 ') dnl end distro_redhat
 ') dnl end mount_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.36/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-10-19 16:03:08.000000000 -0400
+++ policy-1.17.36/macros/program/mozilla_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -16,11 +16,8 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-ifdef(`single_userdomain', `
-typealias $1_home_t alias { $1_home_mozilla_rw_t $1_home_mozilla_ro_t };
-typealias $1_t alias $1_mozilla_t;
-', `
 x_client_domain($1, mozilla, `, web_client_domain, privlog')
+allow $1_mozilla_t self:{ tcp_socket udp_socket } { connect };
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
@@ -40,9 +37,9 @@
 allow $1_t $1_mozilla_rw_t:sock_file create_file_perms;
 can_unix_connect($1_t, $1_mozilla_t)
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 create_dir_file($1_mozilla_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 ifdef(`automount.te', `
 allow $1_mozilla_t autofs_t:dir { search getattr };
 ')dnl end if automount
@@ -123,6 +120,5 @@
 allow $1_mozilla_t xdm_tmp_t:file { getattr read };
 allow $1_mozilla_t xdm_tmp_t:sock_file { write };
 ')dnl end if xdm.te
-')dnl end ifdef single_userdomain
 ')dnl end mozilla macro
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.17.36/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-07-26 16:16:11.000000000 -0400
+++ policy-1.17.36/macros/program/mta_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -37,6 +37,7 @@
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
+allow $1_mail_t self:{ tcp_socket udp_socket } connect;
 
 read_locale($1_mail_t)
 read_sysctl($1_mail_t)
@@ -96,9 +97,9 @@
 # Create dead.letter in user home directories.
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t, file)
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 rw_dir_create_file($1_mail_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 # if you do not want to allow dead.letter then use the following instead
 #allow $1_mail_t { $1_home_dir_t $1_home_t }:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/newrole_macros.te policy-1.17.36/macros/program/newrole_macros.te
--- nsapolicy/macros/program/newrole_macros.te	2004-11-01 11:04:37.852020143 -0500
+++ policy-1.17.36/macros/program/newrole_macros.te	2004-10-27 14:38:36.000000000 -0400
@@ -23,6 +23,9 @@
 # for when the user types "exec newrole" at the command line
 allow $1_t privfd:process sigchld;
 
+type $1_exec_t, file_type, exec_type, sysadmfile;
+domain_auto_trans(userdomain, $1_exec_t, $1_t)
+
 # Inherit descriptors from the current session.
 allow $1_t privfd:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.17.36/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2004-11-01 11:04:37.855019804 -0500
+++ policy-1.17.36/macros/program/screen_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -42,11 +42,7 @@
 allow $1_screen_t urandom_device_t:chr_file read;
 
 # Revert to the user domain when a shell is executed.
-domain_auto_trans($1_screen_t, { shell_exec_t bin_t }, $1_t)
-domain_auto_trans($1_screen_t, $1_home_t, $1_t)
-ifdef(`nfs_home_dirs', `
-domain_auto_trans($1_screen_t, nfs_t, $1_t)
-')
+domain_auto_trans($1_screen_t, shell_exec_t, $1_t)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
@@ -54,9 +50,9 @@
 allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
 allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
 allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 r_dir_file($1_screen_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 allow $1_screen_t privfd:fd use;
 
@@ -104,6 +100,7 @@
 allow $1_screen_t self:unix_stream_socket create_socket_perms;
 allow $1_screen_t self:unix_dgram_socket create_socket_perms;
 
+can_exec($1_screen_t, shell_exec_t)
 allow $1_screen_t bin_t:dir search;
 allow $1_screen_t bin_t:lnk_file read;
 read_locale($1_screen_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.17.36/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2004-10-07 08:02:03.000000000 -0400
+++ policy-1.17.36/macros/program/ssh_agent_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -37,12 +37,12 @@
 can_ps($1_t, $1_ssh_agent_t)
 
 can_ypbind($1_ssh_agent_t)
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_ssh_agent_t autofs_t:dir { search getattr };
 ')
 rw_dir_create_file($1_ssh_agent_t, nfs_t)
-')dnl end nfs_home_dirs
+} dnl end use_nfs_home_dirs
 
 uses_shlib($1_ssh_agent_t)
 read_locale($1_ssh_agent_t)
@@ -70,9 +70,9 @@
 
 # transition back to normal privs upon exec
 domain_auto_trans($1_ssh_agent_t, { bin_t shell_exec_t $1_home_t }, $1_t)
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 domain_auto_trans($1_ssh_agent_t, nfs_t, $1_t)
-')
+}
 allow $1_ssh_agent_t bin_t:dir search;
 
 # allow reading of /usr/bin/X11 (is a symlink)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.17.36/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-10-14 23:25:20.000000000 -0400
+++ policy-1.17.36/macros/program/ssh_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -20,20 +20,16 @@
 undefine(`ssh_domain')
 ifdef(`ssh.te', `
 define(`ssh_domain',`
-ifdef(`single_userdomain', `
-typealias $1_home_t alias $1_home_ssh_t;
-typealias $1_t alias $1_ssh_t;
-', `
 # Derived domain based on the calling user domain and the program.
-type $1_ssh_t, domain, privlog;
+type $1_ssh_t, domain, privlog, nscd_client_domain;
 type $1_home_ssh_t, file_type, homedirfile, sysadmfile;
 
 ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
 ')
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 create_dir_file($1_ssh_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, ssh_exec_t, $1_ssh_t)
@@ -88,6 +84,7 @@
 # to access the network.
 can_network($1_ssh_t)
 can_ypbind($1_ssh_t)
+allow $1_ssh_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
@@ -164,7 +161,6 @@
 allow $1_ssh_t krb5_conf_t:file { getattr read };
 dontaudit $1_ssh_t krb5_conf_t:file { write };
 ')dnl end if xdm.te
-')dnl end if single_userdomain
 ')dnl end macro definition
 
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/sudo_macros.te policy-1.17.36/macros/program/sudo_macros.te
--- nsapolicy/macros/program/sudo_macros.te	2004-11-01 11:04:37.875017542 -0500
+++ policy-1.17.36/macros/program/sudo_macros.te	2004-10-27 14:38:36.000000000 -0400
@@ -31,4 +31,5 @@
 rw_dir_create_file($1_sudo_t, $1_tmp_t)
 rw_dir_create_file($1_sudo_t, $1_home_t)
 domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
+r_dir_file($1_sudo_t, selinux_config_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.17.36/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2004-10-26 10:58:57.000000000 -0400
+++ policy-1.17.36/macros/program/su_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -62,7 +62,7 @@
 ')
 
 # Use capabilities.
-allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override fowner sys_nice sys_resource };
+allow $1_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_nice sys_resource };
 dontaudit $1_su_t self:capability sys_tty_config;
 #
 # Caused by su - init scripts
@@ -137,16 +137,16 @@
 ifdef(`automount.te', `
 allow $1_su_t autofs_t:dir { search getattr };
 ')
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 allow $1_su_t nfs_t:dir search;
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 # Modify .Xauthority file (via xauth program).
 ifdef(`single_userdomain', `
 file_type_auto_trans($1_su_t, $1_home_dir_t, $1_home_t, file)
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 rw_dir_create_file($1_su_t, nfs_t)
-')
+}
 ', `
 ifdef(`xauth.te', `
 file_type_auto_trans($1_su_t, staff_home_dir_t, staff_home_xauth_t, file)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.17.36/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2004-10-05 14:52:36.000000000 -0400
+++ policy-1.17.36/macros/program/tvtime_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -33,7 +33,9 @@
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
 allow $1_tvtime_t self:process { setsched };
 allow $1_tvtime_t usr_t:file { getattr read };
+ifdef(`xdm.te', `
 allow $1_tvtime_t xdm_tmp_t:dir { search };
+')
 
 ')dnl end tvtime_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.17.36/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/macros/program/userhelper_macros.te	2004-10-28 15:05:06.000000000 -0400
@@ -14,10 +14,7 @@
 # provided separately in domains/program/userhelper.te. 
 #
 define(`userhelper_domain',`
-ifdef(`single_userdomain', `
-typealias $1_t alias $1_userhelper_t;
-', `
-type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser;
+type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser, nscd_client_domain;
 
 in_user_role($1_userhelper_t)
 role sysadm_r types $1_userhelper_t;
@@ -142,7 +139,9 @@
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
 allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
 ')
+
+ifdef(`pamconsole.te', `
 allow $1_userhelper_t pam_var_console_t:dir { search };
+')
 
-')dnl end ifdef single_userdomain
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.17.36/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2004-06-16 13:33:38.000000000 -0400
+++ policy-1.17.36/macros/program/xauth_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -87,12 +87,12 @@
 tmp_domain($1_xauth)
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
 
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_xauth_t autofs_t:dir { search getattr };
 ')
 rw_dir_create_file($1_xauth_t, nfs_t)
-')dnl end nfs_home_dirs
+} dnl end use_nfs_home_dirs
 ')dnl end ifdef single_userdomain
 ')dnl end xauth_domain macro
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.36/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/macros/program/xserver_macros.te	2004-10-29 14:45:28.000000000 -0400
@@ -25,14 +25,15 @@
 define(`xserver_domain',`
 # Derived domain based on the calling user domain and the program.
 ifdef(`distro_redhat', `
-type $1_xserver_t, domain, privlog, privmem, privmodule;
+type $1_xserver_t, domain, privlog, privmem, privmodule, nscd_client_domain;
 allow $1_xserver_t sysctl_modprobe_t:file { getattr read };
+ifdef(`rpm.te', `
 allow $1_xserver_t rpm_t:shm { unix_read unix_write read write associate getattr };
 allow $1_xserver_t rpm_tmpfs_t:file { read write };
 allow $1_xserver_t rpm_t:fd { use };
-
+')
 ', `
-type $1_xserver_t, domain, privlog, privmem;
+type $1_xserver_t, domain, privlog, privmem, nscd_client_domain;
 ')
 
 # for SSP
@@ -51,6 +52,7 @@
 uses_shlib($1_xserver_t)
 can_network($1_xserver_t)
 can_ypbind($1_xserver_t)
+allow $1_xserver_t self:udp_socket connect;
 allow $1_xserver_t xserver_port_t:tcp_socket name_bind;
 
 # for access within the domain
@@ -148,6 +150,7 @@
 allow xdm_xserver_t xdm_t:process signal;
 allow xdm_xserver_t xdm_t:shm rw_shm_perms;
 allow xdm_t xdm_xserver_t:shm rw_shm_perms;
+dontaudit xdm_xserver_t sysadm_t:shm { unix_read unix_write };
 ')
 ', `
 allow $1_t xdm_xserver_tmp_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.17.36/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/macros/program/ypbind_macros.te	2004-10-28 09:05:15.000000000 -0400
@@ -10,6 +10,8 @@
 ifdef(`ypbind.te', `
 if (allow_ypbind) {
 uncond_can_ypbind($1)
+} else {
+dontaudit $1 var_yp_t:dir { search };
 }
 ') dnl ypbind.te
 ') dnl can_ypbind
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.36/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-10-19 16:03:08.000000000 -0400
+++ policy-1.17.36/macros/user_macros.te	2004-10-29 14:51:09.000000000 -0400
@@ -103,16 +103,12 @@
 dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file {getattr read};
 
 ifdef(`xdm.te', `
-ifdef(`single_userdomain', `
-file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_t, file)
-', `
 allow xdm_t $1_home_t:lnk_file read;
 allow xdm_t $1_home_t:dir search;
 #
 # Changing this to dontaudit should cause the .xsession-errors file to be written to /tmp
 # 
 dontaudit xdm_t $1_home_t:file rw_file_perms;
-')dnl end else single_userdomain
 ')dnl end ifdef xdm.te
 
 ifdef(`ftpd.te', `
@@ -151,11 +147,6 @@
 # Stat lost+found.
 allow $1_t lost_found_t:dir getattr;
 
-# Read the /tmp directory and any /tmp files with the base type.
-# Temporary files created at runtime will typically use derived types.
-allow $1_t tmp_t:dir r_dir_perms;
-allow $1_t tmp_t:{ file lnk_file } r_file_perms;
-
 # Read /var, /var/spool, /var/run.
 allow $1_t var_t:dir r_dir_perms;
 allow $1_t var_t:notdevfile_class_set r_file_perms;
@@ -233,9 +224,11 @@
 allow $1_mount_t iso9660_t:filesystem { relabelfrom };
 allow $1_mount_t removable_t:filesystem { mount relabelto };
 allow $1_mount_t removable_t:dir { mounton };
+ifdef(`xdm.te', `
 allow $1_mount_t xdm_t:fd { use };
 allow $1_mount_t xdm_t:fifo_file { write };
 ')
+')
 
 #
 # Rules used to associate a homedir as a mountpoint
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.17.36/net_contexts
--- nsapolicy/net_contexts	2004-10-19 16:03:01.000000000 -0400
+++ policy-1.17.36/net_contexts	2004-10-28 09:05:15.000000000 -0400
@@ -143,12 +143,12 @@
 ')
 ifdef(`asterisk.te', `
 portcon tcp 1720 system_u:object_r:asterisk_port_t
-portcon tcp 2000 system_u:object_r:asterisk_port_t
 portcon udp 2427 system_u:object_r:asterisk_port_t
 portcon udp 2727 system_u:object_r:asterisk_port_t
 portcon udp 4569 system_u:object_r:asterisk_port_t
 portcon udp 5060 system_u:object_r:asterisk_port_t
 ')
+portcon tcp 2000 system_u:object_r:mail_port_t
 ifdef(`zebra.te', `portcon tcp 2601 system_u:object_r:zebra_port_t')
 ifdef(`dictd.te', `portcon tcp 2628 system_u:object_r:dict_port_t')
 ifdef(`mysqld.te', `portcon tcp 3306 system_u:object_r:mysqld_port_t')
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.17.36/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/targeted/domains/unconfined.te	2004-10-28 09:05:57.000000000 -0400
@@ -40,5 +40,9 @@
 allow unlabeled_t self:filesystem { associate };
 
 # Support NFS home directories
-bool nfs_home_dirs false;
+bool use_nfs_home_dirs false;
+
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.36/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.36/tunables/distro.tun	2004-10-28 09:05:15.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.36/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/tunables/tunable.tun	2004-10-28 09:05:15.000000000 -0400
@@ -1,33 +1,30 @@
 # Allow all domains to connect to nscd
 dnl define(`nscd_all_connect')
 
-# Allow users to control network interfaces (also needs USERCTL=true)
-dnl define(`user_net_control')
-
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.17.36/types/network.te
--- nsapolicy/types/network.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/types/network.te	2004-10-28 09:05:15.000000000 -0400
@@ -59,6 +59,11 @@
 #
 
 #
+# mail_port_t is for generic mail ports shared by different mail servers
+#
+type mail_port_t, port_type;
+
+#
 # port_t is the default type of INET port numbers.
 # The *_port_t types are used for specific port
 # numbers in net_contexts or net_contexts.mls.

--------------010405090108080905080402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
