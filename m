Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SDrvXZ029865
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 09:53:57 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SDrnW1014355
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 13:53:49 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i9SDtUn3016765
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 09:55:30 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i9SDtTx7016764
	for selinux@tycho.nsa.gov; Thu, 28 Oct 2004 09:55:29 -0400
Message-ID: <4180F274.7020007@redhat.com>
Date: Thu, 28 Oct 2004 09:21:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Update policy with tighter can_network as well as elimination of
 nscd tunables.
Content-Type: multipart/mixed;
 boundary="------------070107040502050108040601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070107040502050108040601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This may cause some problems as this tightens up the policy quite a 
bit.   I have tried
many daemons out but only starting an stopping them.  Please test this 
policy out.
It is available on ftp://people.redhat.com/dwalsh/Fedora

selinux-policy-*-1.17.36-1

Biggest change is removal of nscd and ability to connect provided in 
can_network.
So if you have an Application or daemon that needs to do a network connect,
it will have to call
can_network(app_t)
allow app_t self:{ tcp_socket udp_network } connect;

can_network now calls can_tcp_network and can_udp_network.  I have begun 
to break
daemons out to call can_tcp_network or can_udp_network where 
appropriate.  Any help
on this would be great.

A tcp only app that needs to connect can be written as
can_tcp_network(app_t)
allow app_t self:tcp_socket connect;



--------------070107040502050108040601
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.17.36/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-10-19 16:03:04.000000000 -0400
+++ policy-1.17.36/domains/program/crond.te	2004-10-28 09:05:15.864731271 -0400
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
+++ policy-1.17.36/domains/program/login.te	2004-10-28 09:05:15.865731159 -0400
@@ -21,6 +21,7 @@
 dontaudit $1_login_t shadow_t:file { getattr read };
 
 general_domain_access($1_login_t);
+allow $1_login_t self:{ tcp_socket udp_socket } connect;
 
 # Read system information files in /proc.
 allow $1_login_t proc_t:dir r_dir_perms;
@@ -81,9 +82,9 @@
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
+++ policy-1.17.36/domains/program/logrotate.te	2004-10-28 09:05:15.865731159 -0400
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
+++ policy-1.17.36/domains/program/mount.te	2004-10-28 09:05:15.866731046 -0400
@@ -11,7 +11,7 @@
 
 type mount_exec_t, file_type, sysadmfile, exec_type;
 
-mount_domain(sysadm, mount, `, fs_domain')
+mount_domain(sysadm, mount, `, fs_domain, nscd_client_domain')
 mount_loopback_privs(sysadm, mount)
 role sysadm_r types mount_t;
 role system_r types mount_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.36/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/ssh.te	2004-10-28 09:05:15.867730933 -0400
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
+++ policy-1.17.36/domains/program/syslogd.te	2004-10-28 09:05:15.867730933 -0400
@@ -96,4 +96,4 @@
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
-dontaudit syslogd_t devpts_t:chr_file getattr;
+dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.17.36/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.36/domains/program/unused/acct.te	2004-10-28 09:05:15.868730820 -0400
@@ -63,6 +63,7 @@
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
+allow logrotate_t acct_data_t:dir { search };
 allow logrotate_t acct_data_t:file { create_file_perms };
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.36/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/apache.te	2004-10-28 09:05:15.868730820 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.17.36/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.36/domains/program/unused/arpwatch.te	2004-10-28 09:05:15.869730707 -0400
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
@@ -25,10 +25,14 @@
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
+')
 ifdef(`postfix.te', `
 allow postfix_local_t arpwatch_data_t:dir { search };
 ')
-
+allow arpwatch_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.17.36/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2004-09-01 13:00:25.000000000 -0400
+++ policy-1.17.36/domains/program/unused/automount.te	2004-10-28 09:05:15.870730594 -0400
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
+++ policy-1.17.36/domains/program/unused/bluetooth.te	2004-10-28 09:05:15.870730594 -0400
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
+++ policy-1.17.36/domains/program/unused/canna.te	2004-10-28 09:05:15.871730481 -0400
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
+++ policy-1.17.36/domains/program/unused/cardmgr.te	2004-10-28 09:05:15.871730481 -0400
@@ -9,7 +9,7 @@
 #
 # Rules for the cardmgr_t domain.
 #
-daemon_domain(cardmgr, `, privmodule')
+daemon_domain(cardmgr, `, privmodule, nscd_client_domain')
 
 # for SSP
 allow cardmgr_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.36/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/consoletype.te	2004-10-28 09:05:15.872730368 -0400
@@ -59,3 +59,5 @@
 ')
 dontaudit consoletype_t proc_t:file { read };
 dontaudit consoletype_t root_t:file { read };
+allow consoletype_t crond_t:fifo_file { read };
+allow consoletype_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cpuspeed.te policy-1.17.36/domains/program/unused/cpuspeed.te
--- nsapolicy/domains/program/unused/cpuspeed.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.36/domains/program/unused/cpuspeed.te	2004-10-28 09:05:15.872730368 -0400
@@ -8,3 +8,5 @@
 allow cpuspeed_t sysfs_t:file rw_file_perms;
 allow cpuspeed_t proc_t:dir r_dir_perms;
 allow cpuspeed_t proc_t:file { getattr read };
+allow cpuspeed_t etc_runtime_t:file { getattr read };
+allow cpuspeed_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.36/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/cups.te	2004-10-28 09:05:15.873730255 -0400
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
+++ policy-1.17.36/domains/program/unused/cyrus.te	2004-10-28 09:05:15.874730142 -0400
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
+++ policy-1.17.36/domains/program/unused/dbskkd.te	2004-10-28 09:05:15.874730142 -0400
@@ -9,5 +9,6 @@
 #
 # dbskkd_exec_t is the type of the dbskkd executable.
 #
+# Depends: inetd.te
 
 inetd_child_domain(dbskkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbusd.te policy-1.17.36/domains/program/unused/dbusd.te
--- nsapolicy/domains/program/unused/dbusd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.36/domains/program/unused/dbusd.te	2004-10-28 09:05:15.874730142 -0400
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
+++ policy-1.17.36/domains/program/unused/dhcpc.te	2004-10-28 09:05:15.875730030 -0400
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
+++ policy-1.17.36/domains/program/unused/dictd.te	2004-10-28 09:05:15.876729917 -0400
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
+++ policy-1.17.36/domains/program/unused/dovecot.te	2004-10-28 09:05:15.876729917 -0400
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
+++ policy-1.17.36/domains/program/unused/ftpd.te	2004-10-28 09:05:15.877729804 -0400
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
--- nsapolicy/domains/program/unused/hald.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/hald.te	2004-10-28 09:05:15.877729804 -0400
@@ -19,8 +19,8 @@
 allow hald_t self:unix_dgram_socket create_socket_perms;
 
 ifdef(`dbusd.te', `
-allow hald_t system_dbusd_t:dbus { acquire_svc };
-dbusd_client(system, hald_t)
+allow hald_t system_dbusd_t:dbus { acquire_svc send_msg };
+dbusd_client(system, hald)
 ')
 
 allow hald_t { self proc_t }:file { getattr read };
@@ -37,6 +37,7 @@
 
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
+allow hald_t removable_device_t:blk_file { write };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.36/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.36/domains/program/unused/hotplug.te	2004-10-28 09:05:15.878729691 -0400
@@ -151,7 +151,7 @@
 
 can_network(hotplug_t)
 can_ypbind(hotplug_t)
-dbusd_client(system, hotplug_t)
+dbusd_client(system, hotplug)
 
 # Allow hotplug (including /sbin/ifup-local) to start/stop services and # run sendmail -q
 domain_auto_trans(hotplug_t, initrc_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.17.36/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/i18n_input.te	2004-10-28 09:05:15.879729578 -0400
@@ -6,7 +6,7 @@
 type i18n_input_port_t, port_type;
 
 # Establish i18n_input as a daemon
-daemon_domain(i18n_input)
+daemon_domain(i18n_input, `, nscd_client_domain')
 
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.36/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/inetd.te	2004-10-28 09:05:15.879729578 -0400
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
+++ policy-1.17.36/domains/program/unused/innd.te	2004-10-28 09:05:15.880729465 -0400
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
@@ -72,5 +73,7 @@
 allow innd_t self:file { getattr read };
 dontaudit innd_t selinux_config_t:dir { search };
 allow system_crond_t innd_etc_t:file { getattr read };
+rw_dir_create_file(system_crond_t, innd_log_t)
+rw_dir_create_file(system_crond_t, innd_var_lib_t)
 allow innd_t bin_t:lnk_file { read };
 allow innd_t sbin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.36/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ipsec.te	2004-10-28 09:05:15.880729465 -0400
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
+++ policy-1.17.36/domains/program/unused/ktalkd.te	2004-10-28 09:05:15.881729352 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.17.36/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.17.36/domains/program/unused/kudzu.te	2004-10-28 09:05:15.881729352 -0400
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
+++ policy-1.17.36/domains/program/unused/mailman.te	2004-10-28 09:05:15.882729239 -0400
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
+allow mailman_$1_t self:udp_socket { connect };
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
+++ policy-1.17.36/domains/program/unused/mdadm.te	2004-10-28 09:05:15.883729126 -0400
@@ -40,4 +40,4 @@
 dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
 dontaudit mdadm_t initctl_t:fifo_file { getattr };
 var_run_domain(mdadm)
-allow mdadm_t var_t:dir { getattr };
+allow mdadm_t var_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.17.36/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.17.36/domains/program/unused/mysqld.te	2004-10-28 09:05:15.883729126 -0400
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
+++ policy-1.17.36/domains/program/unused/named.te	2004-10-28 09:05:15.884729013 -0400
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
+++ policy-1.17.36/domains/program/unused/nscd.te	2004-10-28 09:05:15.884729013 -0400
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
+++ policy-1.17.36/domains/program/unused/ntpd.te	2004-10-28 09:05:15.885728901 -0400
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
+++ policy-1.17.36/domains/program/unused/ping.te	2004-10-28 09:05:15.886728788 -0400
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
+++ policy-1.17.36/domains/program/unused/portmap.te	2004-10-28 09:05:15.886728788 -0400
@@ -23,6 +23,7 @@
 tmp_domain(portmap)
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
+dontaudit portmap_t reserved_port_type:tcp_socket name_bind;
 
 # portmap binds to arbitary ports
 allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.17.36/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/postfix.te	2004-10-28 09:05:15.887728675 -0400
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
+++ policy-1.17.36/domains/program/unused/postgresql.te	2004-10-28 09:05:15.888728562 -0400
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
+++ policy-1.17.36/domains/program/unused/privoxy.te	2004-10-28 09:05:15.888728562 -0400
@@ -8,7 +8,7 @@
 #
 # Rules for the privoxy_t domain.
 #
-daemon_domain(privoxy)
+daemon_domain(privoxy, `, nscd_client_domain')
 
 logdir_domain(privoxy)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radius.te policy-1.17.36/domains/program/unused/radius.te
--- nsapolicy/domains/program/unused/radius.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/radius.te	2004-10-28 09:05:15.889728449 -0400
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
+++ policy-1.17.36/domains/program/unused/rpcd.te	2004-10-28 09:05:15.889728449 -0400
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
+++ policy-1.17.36/domains/program/unused/rshd.te	2004-10-28 09:05:15.890728336 -0400
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
+++ policy-1.17.36/domains/program/unused/rsync.te	2004-10-28 09:05:15.890728336 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.36/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/domains/program/unused/sendmail.te	2004-10-28 09:05:15.891728223 -0400
@@ -27,6 +27,7 @@
 # Use the network.
 can_network(sendmail_t)
 can_ypbind(sendmail_t)
+allow sendmail_t self:{ tcp_socket udp_socket } connect;
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
 allow sendmail_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.17.36/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/slapd.te	2004-10-28 09:05:15.891728223 -0400
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
+++ policy-1.17.36/domains/program/unused/slocate.te	2004-10-28 09:05:15.892728110 -0400
@@ -9,7 +9,7 @@
 #
 # locate_exec_t is the type of the locate executable.
 #
-daemon_base_domain(locate)
+daemon_base_domain(locate, `, nscd_client_domain' )
 
 allow locate_t fs_t:filesystem getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.36/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.36/domains/program/unused/snmpd.te	2004-10-28 09:05:15.893727997 -0400
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
+++ policy-1.17.36/domains/program/unused/spamd.te	2004-10-28 09:05:15.893727997 -0400
@@ -5,7 +5,7 @@
 # Depends: spamassassin.te
 #
 
-daemon_domain(spamd)
+daemon_domain(spamd, `, nscd_client_domain' )
 
 tmp_domain(spamd)
 
@@ -25,6 +25,7 @@
 
 can_network(spamd_t)
 allow spamd_t self:capability { net_bind_service };
+allow spamd_t self:tcp_socket connect;
 
 allow spamd_t proc_t:file { getattr read };
 
@@ -59,7 +60,7 @@
 allow spamd_t autofs_t:dir { search getattr };
 ')
 
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 allow spamd_t nfs_t:dir rw_dir_perms;
 allow spamd_t nfs_t:file create_file_perms;
 }
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.17.36/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/domains/program/unused/squid.te	2004-10-28 09:05:15.894727884 -0400
@@ -56,6 +56,7 @@
 can_network(squid_t)
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
+allow squid_t self:{ tcp_socket udp_socket } connect;
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
 allow squid_t http_cache_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.17.36/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.17.36/domains/program/unused/swat.te	2004-10-28 09:05:15.894727884 -0400
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.36/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.36/domains/program/unused/udev.te	2004-10-28 09:05:15.895727772 -0400
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
+++ policy-1.17.36/domains/program/unused/updfstab.te	2004-10-28 09:05:15.895727772 -0400
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
+++ policy-1.17.36/domains/program/unused/vpnc.te	2004-10-28 09:05:15.896727659 -0400
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
--- nsapolicy/domains/program/unused/xdm.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/domains/program/unused/xdm.te	2004-10-28 09:05:15.897727546 -0400
@@ -47,6 +47,7 @@
 
 can_network(xdm_t)
 can_ypbind(xdm_t)
+allow xdm_t self:udp_socket connect;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
@@ -276,7 +277,7 @@
 allow xdm_xserver_t user_home_type:dir search;
 allow xdm_xserver_t user_home_type:file { getattr read };
 
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow { xdm_t xdm_xserver_t } autofs_t:dir { search getattr };
 ')
@@ -286,7 +287,7 @@
 }
 
 # for .dmrc
-allow xdm_t user_home_dir_type:dir search;
+allow xdm_t user_home_dir_type:dir { getattr search };
 allow xdm_t user_home_type:file { getattr read };
 
 allow xdm_t mnt_t:dir { getattr read search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xfs.te policy-1.17.36/domains/program/unused/xfs.te
--- nsapolicy/domains/program/unused/xfs.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.36/domains/program/unused/xfs.te	2004-10-28 09:05:15.897727546 -0400
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
+++ policy-1.17.36/domains/program/unused/ypbind.te	2004-10-28 09:05:15.898727433 -0400
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
 
@@ -41,3 +40,4 @@
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow ypbind_t reserved_port_t:tcp_socket { name_bind };
 allow ypbind_t reserved_port_t:udp_socket { name_bind };
+dontaudit ypbind_t reserved_port_type:tcp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.17.36/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/domains/program/unused/ypserv.te	2004-10-28 09:05:15.898727433 -0400
@@ -40,3 +40,4 @@
 allow rpcd_t ypserv_conf_t:file { getattr read };
 ')
 allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
+dontaudit ypserv_t reserved_port_type:tcp_socket { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/zebra.te policy-1.17.36/domains/program/unused/zebra.te
--- nsapolicy/domains/program/unused/zebra.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.36/domains/program/unused/zebra.te	2004-10-28 09:05:15.946722014 -0400
@@ -5,7 +5,7 @@
 #
 type zebra_port_t, port_type;
 
-daemon_domain(zebra, `, sysctl_net_writer')
+daemon_domain(zebra, `, sysctl_net_writer, nscd_client_domain')
 type zebra_conf_t, file_type, sysadmfile;
 r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/zebra.te policy-1.17.36/domains/program/zebra.te
--- nsapolicy/domains/program/zebra.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.36/domains/program/zebra.te	2004-10-28 09:05:15.946722014 -0400
@@ -0,0 +1,34 @@
+#DESC Zebra - BGP server
+#
+# Author:  Russell Coker <russell@coker.com.au>
+# X-Debian-Packages: zebra
+#
+type zebra_port_t, port_type;
+
+daemon_domain(zebra, `, sysctl_net_writer, nscd_client_domain')
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.17.36/domains/user.te
--- nsapolicy/domains/user.te	2004-10-27 14:32:48.000000000 -0400
+++ policy-1.17.36/domains/user.te	2004-10-28 09:05:44.914451093 -0400
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/file_contexts policy-1.17.36/file_contexts/file_contexts
--- nsapolicy/file_contexts/file_contexts	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.36/file_contexts/file_contexts	2004-10-28 09:05:15.969719417 -0400
@@ -0,0 +1,795 @@
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
+# Allow users to execute the mount command
+
+
+# Allow rpm to run unconfined.
+
+
+# Allow privileged utilities like hotplug and insmod to run unconfined.
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
+# Allow user_r to reach sysadm_r via su, sudo, or userhelper.
+# Otherwise, only staff_r can do so.
+
+
+# Allow xinetd to run unconfined, including any services it starts
+# that do not have a domain transition explicitly defined.
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
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
+
+#
+# Mount points; do not relabel subdirectories, since
+# we don't want to change any removable media by default.
+/mnt(/[^/]*)?		-d	system_u:object_r:mnt_t
+/mnt/[^/]*/.*			<<none>>
+/media(/[^/]*)?		-d	system_u:object_r:mnt_t
+/media/[^/]*/.*			<<none>>
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
+
+/dev/root		-b	system_u:object_r:fixed_disk_device_t
+
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
+
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
+#
+# Misc
+#
+/proc(/.*)?			<<none>>
+/sys(/.*)?			<<none>>
+/selinux(/.*)?			<<none>>
+
+#
+# /opt
+#
+/opt(/.*)?			system_u:object_r:usr_t
+/opt/.*/lib(64)?(/.*)?				system_u:object_r:lib_t
+/opt/.*/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/.*/libexec(/.*)?	system_u:object_r:bin_t
+/opt/.*/bin(/.*)?		system_u:object_r:bin_t
+/opt/.*/man(/.*)?		system_u:object_r:man_t
+/opt/.*/var/lib(64)?(/.*)?		system_u:object_r:var_lib_t
+
+#
+# /etc
+#
+/etc(/.*)?			system_u:object_r:etc_t
+/var/db/.*\.db		--	system_u:object_r:etc_t
+/etc/\.pwd\.lock	--	system_u:object_r:shadow_t
+/etc/passwd\.lock	--	system_u:object_r:shadow_t
+/etc/group\.lock	--	system_u:object_r:shadow_t
+/etc/shadow.*		--	system_u:object_r:shadow_t
+/etc/gshadow.*		--	system_u:object_r:shadow_t
+/var/db/shadow.*	--	system_u:object_r:shadow_t
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
+
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
+/lib(64)?(/.*)?					system_u:object_r:lib_t
+/lib(64)?/.*\.so(\.[^/]*)*		--	system_u:object_r:shlib_t
+/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
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
+/usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
+/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
+/usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
+/usr(/.*)?/sbin(/.*)?		system_u:object_r:sbin_t
+/usr/etc(/.*)?			system_u:object_r:etc_t
+/usr/inclu.e(/.*)?		system_u:object_r:usr_t
+/usr/libexec(/.*)?		system_u:object_r:bin_t
+/usr/src(/.*)?			system_u:object_r:src_t
+/usr/tmp(/.*)?			system_u:object_r:tmp_t
+/usr/man(/.*)?			system_u:object_r:man_t
+/usr/share/man(/.*)?		system_u:object_r:man_t
+/usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
+/usr/share(/.*)?/lib(64)?(/.*)?	system_u:object_r:usr_t
+
+
+
+#
+# /usr/lib(64)?
+#
+/usr/lib(64)?/perl5/man(/.*)?	system_u:object_r:man_t
+/usr/lib(64)?/selinux(/.*)?		system_u:object_r:policy_src_t
+/usr/lib(64)?/emacsen-common/.*	system_u:object_r:bin_t
+
+#
+# /usr/local
+#
+/usr/local/etc(/.*)?		system_u:object_r:etc_t
+/usr/local/src(/.*)?		system_u:object_r:src_t
+/usr/local/man(/.*)?		system_u:object_r:man_t
+
+#
+# /usr/X11R6/man
+#
+/usr/X11R6/man(/.*)?		system_u:object_r:man_t
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
+#  The krb5.conf file is always being tested for writability, so
+#  we defined a type to dontautit
+#
+/etc/krb5\.conf		--	system_u:object_r:krb5_conf_t
+
+/usr/share/system-config-network(/netconfig)?/[^/]+.py -- system_u:object_r:bin_t
+/etc/sysconfig/networking/profiles/.*/resolv.conf -- system_u:object_r:net_conf_t
+/etc/sysconfig/network-scripts/.*resolv.conf -- system_u:object_r:net_conf_t
+/usr/share/rhn/rhn_applet/applet.py -- system_u:object_r:bin_t
+/usr/share/rhn/rhn_applet/eggtrayiconmodule.so -- system_u:object_r:shlib_t
+/usr/share/rhn/rhn_applet/needed-packages.py	--	system_u:object_r:bin_t
+/usr/share/authconfig/authconfig-gtk.py -- system_u:object_r:bin_t
+/usr/share/hwbrowser/hwbrowser -- system_u:object_r:bin_t
+/usr/share/system-config-httpd/system-config-httpd -- system_u:object_r:bin_t
+/usr/share/system-config-services/system-config-services -- system_u:object_r:bin_t
+/usr/share/system-logviewer/system-logviewer.py -- system_u:object_r:bin_t
+/usr/share/system-config-date/system-config-date.py -- system_u:object_r:bin_t
+/usr/share/system-config-display/system-config-display -- system_u:object_r:bin_t
+/usr/share/system-config-keyboard/system-config-keyboard -- system_u:object_r:bin_t
+/usr/share/system-config-language/system-config-language -- system_u:object_r:bin_t
+/usr/share/system-config-mouse/system-config-mouse -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/system-config-netboot.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeos.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeboot.py -- system_u:object_r:bin_t
+/usr/share/system-config-nfs/system-config-nfs.py -- system_u:object_r:bin_t
+/usr/share/system-config-rootpassword/system-config-rootpassword -- system_u:object_r:bin_t
+/usr/share/system-config-samba/system-config-samba.py -- system_u:object_r:bin_t
+/usr/share/system-config-securitylevel/system-config-securitylevel.py -- system_u:object_r:bin_t
+/usr/share/system-config-services/serviceconf.py -- system_u:object_r:bin_t
+/usr/share/system-config-soundcard/system-config-soundcard -- system_u:object_r:bin_t
+/usr/share/system-config-users/system-config-users -- system_u:object_r:bin_t
+/usr/share/switchdesk/switchdesk-gui.py	--	system_u:object_r:bin_t
+/usr/share/system-config-network/neat-control.py	--	system_u:object_r:bin_t
+/usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
+/usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
+/usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+
+
+# checkpolicy
+/usr/bin/checkpolicy		--	system_u:object_r:checkpolicy_exec_t
+/etc/selinux/policy/policy.* -- system_u:object_r:policy_config_t
+/etc/selinux/.*/src/policy/policy.* -- system_u:object_r:policy_config_t	
+# chkpwd
+/sbin/unix_chkpwd	--	system_u:object_r:chkpwd_exec_t
+/sbin/unix_verify	--	system_u:object_r:chkpwd_exec_t
+
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
+/sbin/partprobe		--	system_u:object_r:fsadm_exec_t
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
+
+
+
+
+# run_init
+/usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
+
+/etc/nologin.*		--	system_u:object_r:etc_runtime_t
+/etc/nohotplug		--	system_u:object_r:etc_runtime_t
+
+/halt			--	system_u:object_r:etc_runtime_t
+/\.autofsck		--	system_u:object_r:etc_runtime_t
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
+/usr/bin/chage		--	system_u:object_r:passwd_exec_t
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
+
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
+# Quagga
+/usr/sbin/rip.*  	--	system_u:object_r:zebra_exec_t
+/usr/sbin/ospf.*  	--	system_u:object_r:zebra_exec_t
+/etc/quagga(/.*)?		system_u:object_r:zebra_conf_t
+/var/log/quagga(/.*)?		system_u:object_r:zebra_log_t
+/var/run/quagga(/.*)?		system_u:object_r:zebra_var_run_t
+
+#
+# User-specific file contexts
+#
+
+/root		-d	root:object_r:staff_home_dir_t
+/root/.+			root:object_r:staff_home_t
+/root/\.ssh(/.*)?		root:object_r:staff_home_ssh_t
+/root/.default_contexts	-- 	system_u:object_r:default_context_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ntpd.fc policy-1.17.36/file_contexts/program/ntpd.fc
--- nsapolicy/file_contexts/program/ntpd.fc	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.36/file_contexts/program/ntpd.fc	2004-10-28 09:05:15.970719304 -0400
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
+++ policy-1.17.36/file_contexts/program/vpnc.fc	2004-10-28 09:05:15.970719304 -0400
@@ -1,2 +1,3 @@
 # vpnc
 /usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
+/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.36/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/macros/base_user_macros.te	2004-10-28 09:05:15.971719191 -0400
@@ -61,7 +61,7 @@
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
-if (nfs_home_dirs) {
+if (use_nfs_home_dirs) {
 create_dir_file($1_t, nfs_t)
 can_exec($1_t, nfs_t)
 allow $1_t nfs_t:{ sock_file fifo_file } create_file_perms;
@@ -190,11 +190,23 @@
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
+++ policy-1.17.36/macros/core_macros.te	2004-10-28 09:05:15.972719078 -0400
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
+++ policy-1.17.36/macros/global_macros.te	2004-10-28 09:05:15.973718965 -0400
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
+++ policy-1.17.36/macros/network_macros.te	2004-10-28 09:05:15.974718852 -0400
@@ -0,0 +1,90 @@
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
+allow $1 port_type:{ $2_socket } { send_msg recv_msg };
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
+base_can_network($1, tcp)
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
+base_can_network($1, udp)
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
+++ policy-1.17.36/macros/program/crond_macros.te	2004-10-28 09:05:15.974718852 -0400
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
+++ policy-1.17.36/macros/program/dbusd_macros.te	2004-10-28 09:05:15.975718740 -0400
@@ -50,26 +50,44 @@
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
+++ policy-1.17.36/macros/program/gpg_agent_macros.te	2004-10-28 09:05:15.976718627 -0400
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
+++ policy-1.17.36/macros/program/gpg_macros.te	2004-10-28 09:05:15.976718627 -0400
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
+++ policy-1.17.36/macros/program/gph_macros.te	2004-10-28 09:05:15.977718514 -0400
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
+++ policy-1.17.36/macros/program/lpr_macros.te	2004-10-28 09:05:15.977718514 -0400
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
+++ policy-1.17.36/macros/program/mount_macros.te	2004-10-28 09:05:15.978718401 -0400
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
+++ policy-1.17.36/macros/program/mozilla_macros.te	2004-10-28 09:05:15.978718401 -0400
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
+++ policy-1.17.36/macros/program/mta_macros.te	2004-10-28 09:05:15.979718288 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.17.36/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.36/macros/program/screen_macros.te	2004-10-28 09:05:15.980718175 -0400
@@ -50,9 +50,9 @@
 allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
 allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
 allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-ifdef(`nfs_home_dirs', `
+if (use_nfs_home_dirs) {
 r_dir_file($1_screen_t, nfs_t)
-')dnl end if nfs_home_dirs
+} dnl end if use_nfs_home_dirs
 
 allow $1_screen_t privfd:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.17.36/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2004-10-07 08:02:03.000000000 -0400
+++ policy-1.17.36/macros/program/ssh_agent_macros.te	2004-10-28 09:05:15.980718175 -0400
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
+++ policy-1.17.36/macros/program/ssh_macros.te	2004-10-28 09:05:15.981718062 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.17.36/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2004-10-26 10:58:57.000000000 -0400
+++ policy-1.17.36/macros/program/su_macros.te	2004-10-28 09:05:15.982717949 -0400
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
+++ policy-1.17.36/macros/program/tvtime_macros.te	2004-10-28 09:05:15.982717949 -0400
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
+++ policy-1.17.36/macros/program/userhelper_macros.te	2004-10-28 09:05:15.983717836 -0400
@@ -142,7 +142,10 @@
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
 allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
 ')
+
+ifdef(`pamconsole.te', `
 allow $1_userhelper_t pam_var_console_t:dir { search };
+')
 
 ')dnl end ifdef single_userdomain
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.17.36/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2004-06-16 13:33:38.000000000 -0400
+++ policy-1.17.36/macros/program/xauth_macros.te	2004-10-28 09:05:15.983717836 -0400
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
+++ policy-1.17.36/macros/program/xserver_macros.te	2004-10-28 09:05:15.984717723 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.17.36/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.17.36/macros/program/ypbind_macros.te	2004-10-28 09:05:15.984717723 -0400
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
+++ policy-1.17.36/macros/user_macros.te	2004-10-28 09:05:15.985717611 -0400
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
@@ -233,9 +229,11 @@
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
+++ policy-1.17.36/net_contexts	2004-10-28 09:05:15.986717498 -0400
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
+++ policy-1.17.36/targeted/domains/unconfined.te	2004-10-28 09:05:57.790997075 -0400
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
+++ policy-1.17.36/tunables/distro.tun	2004-10-28 09:05:15.987717385 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.36/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.17.36/tunables/tunable.tun	2004-10-28 09:05:15.987717385 -0400
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
+++ policy-1.17.36/types/network.te	2004-10-28 09:05:15.988717272 -0400
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

--------------070107040502050108040601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
