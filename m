Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8DlmIi015571
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 08:47:48 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8DkPC6005644
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 13:46:25 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iA8DobOv005930
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 08:50:37 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iA8Dobgh005929
	for selinux@tycho.nsa.gov; Mon, 8 Nov 2004 08:50:37 -0500
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA65XWIi005386
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 00:33:32 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA65W6gp026700
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 05:32:10 GMT
Message-ID: <418C621A.5060208@redhat.com>
Date: Sat, 06 Nov 2004 00:33:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: can_network patch
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070508080302010001090505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070508080302010001090505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the patch that eliminates connect from can_network.

The batch basically does a couple of things

can_network now calls
can_tcp_network
can_udp_network

All three functions take up to two parameters.  The first is the domain 
and the second is the ports that the
domain can send and receive messages from. If the ports are not provided 
then it defaults to port_type.

I have also added can_kerberos, can_resolve,  and can_ldap.
All three plus can_ypbind were added auth_chkpwd
can_kerberos(auth_chkpwd)
can_ldap(auth_chkpwd)
can_resolve(auth_chkpwd)
can_ypbind(auth_chkpwd)

So any domain that gets the auth_chkpwd attribute no longer needs these 
defined in its "te" file.

I have begun tightening up the ability to network on other daemons 
also.  These need further testing.

Dan


--------------070508080302010001090505
Content-Type: text/x-patch;
 name="policy-network.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-network.patch"

diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/crond.te policy-1.18.2.old/domains/program/crond.te
--- policy-1.18.2/domains/program/crond.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/crond.te	2004-11-05 23:57:55.322852943 -0500
@@ -23,7 +23,6 @@
 
 # Type for temporary files.
 tmp_domain(crond)
-can_ypbind(crond_t)
 
 crond_domain(system)
 
@@ -114,6 +113,8 @@
 # Use capabilities.
 allow system_crond_t self:capability { dac_read_search chown setgid setuid fowner net_bind_service fsetid };
 
+allow crond_t urandom_device_t:chr_file { getattr read };
+
 # Read the system crontabs.
 allow system_crond_t system_cron_spool_t:file r_file_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/initrc.te policy-1.18.2.old/domains/program/initrc.te
--- policy-1.18.2/domains/program/initrc.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/initrc.te	2004-11-05 23:57:55.323852830 -0500
@@ -303,8 +303,8 @@
 ')
 
 # for lsof in shutdown scripts
-allow initrc_t krb5_conf_t:file read;
-dontaudit initrc_t krb5_conf_t:file write;
+can_kerberos(initrc_t)
+
 #
 # Wants to remove udev.tbl
 #
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/login.te policy-1.18.2.old/domains/program/login.te
--- policy-1.18.2/domains/program/login.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/login.te	2004-11-05 23:57:55.324852717 -0500
@@ -117,8 +117,6 @@
 allow $1_login_t mail_spool_t:file getattr;
 allow $1_login_t mail_spool_t:lnk_file read;
 
-dontaudit $1_login_t krb5_conf_t:file { write };
-allow $1_login_t krb5_conf_t:file { getattr read };
 # Get security policy decisions.
 can_getsecurity($1_login_t)
 
@@ -127,8 +125,6 @@
 allow $1_login_t default_context_t:dir { search };
 r_dir_file($1_login_t, selinux_config_t)
 
-can_ypbind($1_login_t)
-
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
 dontaudit $1_login_t init_t:fd { use };
 ')dnl end login_domain macro
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/ssh.te policy-1.18.2.old/domains/program/ssh.te
--- policy-1.18.2/domains/program/ssh.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/ssh.te	2004-11-05 23:57:55.325852605 -0500
@@ -69,17 +69,17 @@
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 can_network($1_t)
+allow $1_t self:{ udp_socket tcp_socket } connect;
 
-allow $1_t self:capability { sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
+allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
-can_ypbind($1_t)
 if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')
 allow $1_t nfs_t:dir { search getattr };
 allow $1_t nfs_t:file { getattr read };
-}
+} dnl end if use_nfs_home_dirs
 
 # Set exec context.
 can_setexec($1_t)
@@ -213,8 +213,6 @@
 ifdef(`automount.te', `
 allow sshd_t autofs_t:dir { search };
 ')
-dontaudit sshd_t krb5_conf_t:file { write };
-allow sshd_t krb5_conf_t:file { getattr read };
 
 # ssh_keygen_t is the type of the ssh-keygen program when run at install time
 # and by sysadm_t
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/syslogd.te policy-1.18.2.old/domains/program/syslogd.te
--- policy-1.18.2/domains/program/syslogd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/syslogd.te	2004-11-05 23:57:55.326852492 -0500
@@ -19,9 +19,13 @@
 daemon_domain(syslogd, `, privmem')
 ')
 
+# Allow name_bind for remote logging
+type syslogd_port_t, port_type, reserved_port_type;
 # can_network is for the UDP socket
-can_network(syslogd_t)
+can_udp_network(syslogd_t, `syslogd_port_t')
 can_ypbind(syslogd_t)
+allow syslogd_t syslogd_port_t:udp_socket name_bind;
+allow syslogd_t self:udp_socket connect;
 
 r_dir_file(syslogd_t, sysfs_t)
 
@@ -87,13 +92,10 @@
 # Allow syslog to a terminal
 allow syslogd_t tty_device_t:chr_file { getattr write ioctl append };
 
-# Allow name_bind for remote logging
-type syslogd_port_t, port_type, reserved_port_type;
-allow syslogd_t syslogd_port_t:udp_socket name_bind;
 #
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
-dontaudit syslogd_t devpts_t:chr_file getattr;
+dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/anaconda.te policy-1.18.2.old/domains/program/unused/anaconda.te
--- policy-1.18.2/domains/program/unused/anaconda.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/anaconda.te	2004-11-05 23:57:55.327852379 -0500
@@ -242,8 +242,7 @@
 ifdef(`udev.te', `
 domain_auto_trans(anaconda_t, udev_exec_t, udev_t)
 ')
-allow anaconda_t krb5_conf_t:file read;
-dontaudit anaconda_t krb5_conf_t:file write;
+can_kerberos(anaconda_t)
 
 ifdef(`ssh-agent.te', `
 role system_r types sysadm_ssh_agent_t;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/apache.te policy-1.18.2.old/domains/program/unused/apache.te
--- policy-1.18.2/domains/program/unused/apache.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/apache.te	2004-11-05 23:57:55.328852266 -0500
@@ -136,6 +136,7 @@
 
 can_network(httpd_t)
 can_ypbind(httpd_t)
+allow httpd_t self:{ tcp_socket udp_socket } connect;
 
 ###################
 # Allow httpd to search users diretories
@@ -269,8 +270,7 @@
 ##################################################
 dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
 
-allow httpd_t krb5_conf_t:file { getattr read };
-dontaudit httpd_t krb5_conf_t:file { write };
+can_kerberos(httpd_t)
 
 ifdef(`targeted_policy', `
 typealias httpd_sys_content_t alias httpd_user_content_t;
@@ -298,5 +298,6 @@
 # Customer reported the following
 #
 ifdef(`snmpd.te', `
+dontaudit httpd_t snmpd_var_lib_t:dir { search };
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
 ')
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/canna.te policy-1.18.2.old/domains/program/unused/canna.te
--- policy-1.18.2/domains/program/unused/canna.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/canna.te	2004-11-05 23:57:55.329852154 -0500
@@ -28,8 +28,9 @@
 
 rw_dir_create_file(canna_t, canna_var_lib_t)
 
-can_network(canna_t)
+can_tcp_network(canna_t)
 can_ypbind(canna_t)
+allow canna_t self:tcp_socket connect;
 
 allow userdomain canna_var_run_t:dir search;
 allow userdomain canna_var_run_t:sock_file write;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/courier.te policy-1.18.2.old/domains/program/unused/courier.te
--- policy-1.18.2/domains/program/unused/courier.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/courier.te	2004-11-05 23:57:55.330852041 -0500
@@ -47,7 +47,6 @@
 
 # Use the network.
 can_network(courier_$1_t)
-can_ypbind(courier_$1_t)
 allow courier_$1_t self:fifo_file { read write getattr };
 allow courier_$1_t self:unix_stream_socket create_stream_socket_perms;
 allow courier_$1_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/cups.te policy-1.18.2.old/domains/program/unused/cups.te
--- policy-1.18.2/domains/program/unused/cups.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/cups.te	2004-11-05 23:57:55.331851928 -0500
@@ -19,7 +19,8 @@
 typealias cupsd_rw_etc_t alias etc_cupsd_rw_t;
 
 can_network(cupsd_t)
-can_ypbind(cupsd_t)
+allow cupsd_t self:{ tcp_socket udp_socket } connect;
+
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/cyrus.te policy-1.18.2.old/domains/program/unused/cyrus.te
--- policy-1.18.2/domains/program/unused/cyrus.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/cyrus.te	2004-11-05 23:57:55.332851816 -0500
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/dhcpc.te policy-1.18.2.old/domains/program/unused/dhcpc.te
--- policy-1.18.2/domains/program/unused/dhcpc.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/dhcpc.te	2004-11-05 23:57:55.333851703 -0500
@@ -22,8 +22,9 @@
 # for SSP
 allow dhcpc_t urandom_device_t:chr_file read;
 
-can_network(dhcpc_t)
+can_udp_network(dhcpc_t, `dhcpc_port_t')
 can_ypbind(dhcpc_t)
+allow dhcpc_t self:tcp_socket connect;
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
 allow dhcpc_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/dhcpd.te policy-1.18.2.old/domains/program/unused/dhcpd.te
--- policy-1.18.2/domains/program/unused/dhcpd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/dhcpd.te	2004-11-05 23:57:55.334851590 -0500
@@ -29,8 +29,10 @@
 typealias dhcp_etc_t alias { etc_dhcp_t etc_dhcpc_t etc_dhcpd_t };
 
 # Use the network.
-can_network(dhcpd_t)
+can_udp_network(dhcpd_t, `dhcpd_port_t')
+can_tcp_network(dhcpd_t, `dns_port_t')
 can_ypbind(dhcpd_t)
+allow dhcpd_t self:tcp_socket connect;
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/dovecot.te policy-1.18.2.old/domains/program/unused/dovecot.te
--- policy-1.18.2/domains/program/unused/dovecot.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/dovecot.te	2004-11-05 23:57:55.334851590 -0500
@@ -15,6 +15,8 @@
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
+allow dovecot_t self:tcp_socket connect;
+
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
@@ -31,8 +33,7 @@
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
 
-dontaudit dovecot_t krb5_conf_t:file { write };
-allow dovecot_t krb5_conf_t:file { getattr read };
+can_kerberos(dovecot_t)
 
 daemon_sub_domain(dovecot_t, dovecot_auth, `, auth')
 allow dovecot_auth_t self:process { fork signal_perms };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/firstboot.te policy-1.18.2.old/domains/program/unused/firstboot.te
--- policy-1.18.2/domains/program/unused/firstboot.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/firstboot.te	2004-11-05 23:57:55.335851478 -0500
@@ -55,8 +55,7 @@
 # Allow write to utmp file
 allow firstboot_t initrc_var_run_t:file { write };
 
-allow firstboot_t krb5_conf_t:file { getattr read };
-allow firstboot_t net_conf_t:file { getattr read };
+can_kerberos(firstboot_t)
 
 ifdef(`samba.te', `
 rw_dir_file(firstboot_t, samba_etc_t)
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/ftpd.te policy-1.18.2.old/domains/program/unused/ftpd.te
--- policy-1.18.2/domains/program/unused/ftpd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/ftpd.te	2004-11-05 23:57:55.335851478 -0500
@@ -16,7 +16,7 @@
 typealias ftpd_etc_t alias etc_ftpd_t;
 
 can_network(ftpd_t)
-can_ypbind(ftpd_t)
+allow ftpd_t self:udp_socket connect;
 allow ftpd_t self:unix_dgram_socket { sendto create_socket_perms };
 allow ftpd_t self:unix_stream_socket create_socket_perms;
 allow ftpd_t self:process { getcap setcap setsched setrlimit };
@@ -32,11 +32,13 @@
 
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
@@ -85,9 +87,7 @@
 allow ftpd_t proc_t:file { getattr read };
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
-dontaudit ftpd_t krb5_conf_t:file { write };
 dontaudit ftpd_t selinux_config_t:dir search;
-allow ftpd_t krb5_conf_t:file { getattr read };
 ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir { search };
 ')
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/hald.te policy-1.18.2.old/domains/program/unused/hald.te
--- policy-1.18.2/domains/program/unused/hald.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/hald.te	2004-11-05 23:57:55.336851365 -0500
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/i18n_input.te policy-1.18.2.old/domains/program/unused/i18n_input.te
--- policy-1.18.2/domains/program/unused/i18n_input.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/i18n_input.te	2004-11-05 23:57:55.336851365 -0500
@@ -11,6 +11,7 @@
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
 can_ypbind(i18n_input_t)
+allow i18n_input_t self:udp_socket connect;
 
 can_tcp_connect(userdomain, i18n_input_t)
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/inetd.te policy-1.18.2.old/domains/program/unused/inetd.te
--- policy-1.18.2/domains/program/unused/inetd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/inetd.te	2004-11-05 23:57:55.337851252 -0500
@@ -21,6 +21,8 @@
 daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
+allow inetd_t self:udp_socket connect;
+
 allow inetd_t self:unix_dgram_socket create_socket_perms;
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/innd.te policy-1.18.2.old/domains/program/unused/innd.te
--- policy-1.18.2/domains/program/unused/innd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/innd.te	2004-11-05 23:57:55.338851140 -0500
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/mailman.te policy-1.18.2.old/domains/program/unused/mailman.te
--- policy-1.18.2/domains/program/unused/mailman.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/mailman.te	2004-11-05 23:57:55.339851027 -0500
@@ -20,7 +20,7 @@
 can_exec_any(mailman_$1_t)
 allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
-allow mailman_$1_t var_lib_t:dir { getattr search };
+allow mailman_$1_t var_lib_t:dir { getattr search read };
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
 allow mailman_$1_t etc_runtime_t:file { read getattr };
@@ -29,14 +29,16 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
-can_ypbind(mailman_$1_t)
+allow mailman_$1_t self:udp_socket connect;
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
 ')
 
 mailman_domain(queue, `, auth_chkpwd, nscd_client_domain')
 can_tcp_connect(mailman_queue_t, mail_server_domain)
+allow mailman_queue_t self:tcp_socket connect;
 
+dontaudit mailman_queue_t src_t:dir { search };
 can_exec(mailman_queue_t, su_exec_t)
 allow mailman_queue_t self:capability { setgid setuid };
 allow mailman_queue_t self:fifo_file rw_file_perms;
@@ -72,8 +74,9 @@
 domain_auto_trans({ httpd_t httpd_suexec_t }, mailman_cgi_exec_t, mailman_cgi_t)
 # should have separate types for public and private archives
 r_dir_file(httpd_t, mailman_archive_t)
-allow httpd_t mailman_data_t:dir search;
-r_dir_file(mailman_cgi_t, mailman_archive_t)
+allow httpd_t mailman_data_t:dir { getattr search };
+rw_dir_file(mailman_cgi_t, mailman_archive_t)
+allow mailman_cgi_t mailman_archive_t:lnk_file create_lnk_perms;
 
 dontaudit mailman_cgi_t httpd_log_t:file append;
 allow httpd_t mailman_cgi_t:process signal;
@@ -83,6 +86,8 @@
 allow mailman_cgi_t httpd_sys_script_t:dir search;
 allow mailman_cgi_t devtty_t:chr_file { read write };
 allow mailman_cgi_t self:process { fork sigchld };
+allow mailman_cgi_t var_spool_t:dir { search };
+dontaudit mailman_cgi_t src_t:dir { search };
 ')
 
 allow mta_delivery_agent mailman_data_t:dir search;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/named.te policy-1.18.2.old/domains/program/unused/named.te
--- policy-1.18.2/domains/program/unused/named.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/named.te	2004-11-05 23:57:55.340850914 -0500
@@ -49,8 +49,10 @@
 allow named_t etc_runtime_t:{ file lnk_file } { getattr read };
 
 #Named can use network
-can_network(named_t)
+can_network(named_t, `dns_port_t')
 can_ypbind(named_t)
+allow named_t self:tcp_socket connect;
+
 # allow UDP transfer to/from any program
 can_udp_send(domain, named_t)
 can_udp_send(named_t, domain)
@@ -101,6 +103,7 @@
 uses_shlib(ndc_t)
 can_network(ndc_t)
 can_ypbind(ndc_t)
+allow ndc_t self:tcp_socket connect;
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/nscd.te policy-1.18.2.old/domains/program/unused/nscd.te
--- policy-1.18.2/domains/program/unused/nscd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/nscd.te	2004-11-05 23:57:55.341850801 -0500
@@ -24,6 +24,7 @@
 allow nscd_t etc_t:lnk_file read;
 can_network(nscd_t)
 can_ypbind(nscd_t)
+allow nscd_t self:{ tcp_socket udp_socket } connect;
 
 file_type_auto_trans(nscd_t, var_run_t, nscd_var_run_t, sock_file)
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/ntpd.te policy-1.18.2.old/domains/program/unused/ntpd.te
--- policy-1.18.2/domains/program/unused/ntpd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/ntpd.te	2004-11-05 23:57:55.341850801 -0500
@@ -12,6 +12,9 @@
 type ntp_drift_t, file_type, sysadmfile;
 type ntp_port_t, port_type, reserved_port_type;
 
+type ntpdate_exec_t, file_type, sysadmfile, exec_type;
+domain_auto_trans(initrc_t, ntpdate_exec_t, ntpd_t)
+
 logdir_domain(ntpd)
 
 allow ntpd_t var_lib_t:dir r_dir_perms;
@@ -34,8 +37,10 @@
 allow ntpd_t etc_t:file { read getattr };
 
 # Use the network.
-can_network(ntpd_t)
+can_network(ntpd_t, `ntp_port_t')
 can_ypbind(ntpd_t)
+can_resolve(ntpd_t)
+allow ntpd_t self:{ tcp_socket udp_socket } connect;
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/ping.te policy-1.18.2.old/domains/program/unused/ping.te
--- policy-1.18.2/domains/program/unused/ping.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/ping.te	2004-11-05 23:57:55.342850689 -0500
@@ -35,6 +35,7 @@
 can_ypbind(ping_t)
 allow ping_t etc_t:file { getattr read };
 allow ping_t self:unix_stream_socket create_socket_perms;
+allow ping_t self:{ tcp_socket udp_socket } connect;
 
 # Let ping create raw ICMP packets.
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
@@ -55,3 +56,5 @@
 # it tries to access /var/run
 dontaudit ping_t var_t:dir search;
 
+dontaudit ping_t devtty_t:chr_file { read write };
+dontaudit ping_t ping_t:capability { sys_tty_config };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/portmap.te policy-1.18.2.old/domains/program/unused/portmap.te
--- policy-1.18.2/domains/program/unused/portmap.te	2004-11-06 00:10:58.306027721 -0500
+++ policy-1.18.2.old/domains/program/unused/portmap.te	2004-11-05 23:57:55.343850576 -0500
@@ -53,4 +53,3 @@
 # Use capabilities
 allow portmap_t self:capability { net_bind_service setuid setgid };
 allow portmap_t self:netlink_route_socket r_netlink_socket_perms;
-
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/postfix.te policy-1.18.2.old/domains/program/unused/postfix.te
--- policy-1.18.2/domains/program/unused/postfix.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/postfix.te	2004-11-05 23:57:55.343850576 -0500
@@ -119,6 +119,8 @@
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
 can_ypbind(postfix_master_t)
+allow postfix_master_t self:{ tcp_socket udp_socket } connect;
+
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/postgresql.te policy-1.18.2.old/domains/program/unused/postgresql.te
--- policy-1.18.2/domains/program/unused/postgresql.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/postgresql.te	2004-11-05 23:57:55.344850463 -0500
@@ -13,6 +13,8 @@
 type postgresql_port_t, port_type;
 daemon_domain(postgresql)
 allow initrc_t postgresql_exec_t:lnk_file read;
+allow postgresql_t usr_t:file { getattr read };
+allow postgresql_t self:udp_socket connect;
 
 allow postgresql_t postgresql_var_run_t:sock_file create_file_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/rlogind.te policy-1.18.2.old/domains/program/unused/rlogind.te
--- policy-1.18.2/domains/program/unused/rlogind.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/rlogind.te	2004-11-05 23:57:55.344850463 -0500
@@ -14,7 +14,6 @@
 role system_r types rlogind_t;
 uses_shlib(rlogind_t)
 can_network(rlogind_t)
-can_ypbind(rlogind_t)
 type rlogind_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(inetd_t, rlogind_exec_t, rlogind_t)
 ifdef(`tcpd.te', `
@@ -75,8 +74,6 @@
 # Modify /var/log/wtmp.
 allow rlogind_t var_log_t:dir search;
 allow rlogind_t wtmp_t:file rw_file_perms;
-allow rlogind_t krb5_conf_t:file { getattr read };
-dontaudit rlogind_t krb5_conf_t:file write;
 allow rlogind_t urandom_device_t:chr_file { getattr read };
 dontaudit rlogind_t selinux_config_t:dir search;
 allow rlogind_t staff_home_dir_t:dir search;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/rpcd.te policy-1.18.2.old/domains/program/unused/rpcd.te
--- policy-1.18.2/domains/program/unused/rpcd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/rpcd.te	2004-11-05 23:57:55.345850351 -0500
@@ -14,6 +14,7 @@
 daemon_base_domain($1)
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/rshd.te policy-1.18.2.old/domains/program/unused/rshd.te
--- policy-1.18.2/domains/program/unused/rshd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/rshd.te	2004-11-05 23:57:55.346850238 -0500
@@ -31,8 +31,9 @@
 allow rshd_t self:unix_dgram_socket create_socket_perms;
 allow rshd_t self:unix_stream_socket create_stream_socket_perms;
 allow rshd_t { home_root_t home_dir_type }:dir { search getattr };
-allow rshd_t krb5_conf_t:file { getattr read };
-dontaudit rshd_t krb5_conf_t:file write;
+can_kerberos(rshd_t)
 allow rshd_t tmp_t:dir { search };
+ifdef(`rlogind.te', `
 allow rshd_t rlogind_tmp_t:file rw_file_perms;
+')
 allow rshd_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/samba.te policy-1.18.2.old/domains/program/unused/samba.te
--- policy-1.18.2/domains/program/unused/samba.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/samba.te	2004-11-05 23:57:55.347850125 -0500
@@ -49,7 +49,6 @@
 
 # Use the network.
 can_network(smbd_t)
-can_ypbind(smbd_t)
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/sendmail.te policy-1.18.2.old/domains/program/unused/sendmail.te
--- policy-1.18.2/domains/program/unused/sendmail.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/sendmail.te	2004-11-05 23:57:55.347850125 -0500
@@ -27,6 +27,7 @@
 # Use the network.
 can_network(sendmail_t)
 can_ypbind(sendmail_t)
+allow sendmail_t self:{ tcp_socket udp_socket } connect;
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
 allow sendmail_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/slapd.te policy-1.18.2.old/domains/program/unused/slapd.te
--- policy-1.18.2/domains/program/unused/slapd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/slapd.te	2004-11-05 23:57:55.348850013 -0500
@@ -30,6 +30,7 @@
 allow slapd_t self:unix_dgram_socket create_socket_perms;
 # allow any domain to connect to the LDAP server
 can_tcp_connect(domain, slapd_t)
+allow slapd_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities  should not need kill...
 allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/slocate.te policy-1.18.2.old/domains/program/unused/slocate.te
--- policy-1.18.2/domains/program/unused/slocate.te	2004-11-06 00:11:31.375539016 -0500
+++ policy-1.18.2.old/domains/program/unused/slocate.te	2004-11-05 23:57:55.348850013 -0500
@@ -2,7 +2,6 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
-# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/snmpd.te policy-1.18.2.old/domains/program/unused/snmpd.te
--- policy-1.18.2/domains/program/unused/snmpd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/snmpd.te	2004-11-05 23:57:55.349849900 -0500
@@ -15,6 +15,7 @@
 
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
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/spamd.te policy-1.18.2.old/domains/program/unused/spamd.te
--- policy-1.18.2/domains/program/unused/spamd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/spamd.te	2004-11-05 23:57:55.349849900 -0500
@@ -24,6 +24,7 @@
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
 
 can_network(spamd_t)
+allow spamd_t self:{ tcp_socket udp_socket } connect;
 allow spamd_t self:capability { net_bind_service };
 
 allow spamd_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/squid.te policy-1.18.2.old/domains/program/unused/squid.te
--- policy-1.18.2/domains/program/unused/squid.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/squid.te	2004-11-05 23:57:55.350849787 -0500
@@ -55,6 +55,7 @@
 can_network(squid_t)
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
+allow squid_t self:{ tcp_socket udp_socket } connect;
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
 allow squid_t http_cache_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/swat.te policy-1.18.2.old/domains/program/unused/swat.te
--- policy-1.18.2/domains/program/unused/swat.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/swat.te	2004-11-05 23:57:55.350849787 -0500
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/traceroute.te policy-1.18.2.old/domains/program/unused/traceroute.te
--- policy-1.18.2/domains/program/unused/traceroute.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/traceroute.te	2004-11-05 23:57:55.351849675 -0500
@@ -20,6 +20,7 @@
 uses_shlib(traceroute_t)
 can_network(traceroute_t)
 can_ypbind(traceroute_t)
+allow traceroute_t self:{ tcp_socket udp_socket } connect;
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/uwimapd.te policy-1.18.2.old/domains/program/unused/uwimapd.te
--- policy-1.18.2/domains/program/unused/uwimapd.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/uwimapd.te	2004-11-05 23:57:55.352849562 -0500
@@ -9,7 +9,6 @@
 tmp_domain(imapd)
 
 can_network(imapd_t)
-can_ypbind(imapd_t)
 
 #declare our own services
 allow imapd_t self:capability { dac_override net_bind_service setgid setuid sys_resource };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/vpnc.te policy-1.18.2.old/domains/program/unused/vpnc.te
--- policy-1.18.2/domains/program/unused/vpnc.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/vpnc.te	2004-11-05 23:57:55.352849562 -0500
@@ -17,6 +17,8 @@
 # Use the network.
 can_network(vpnc_t)
 can_ypbind(vpnc_t)
+allow vpnc_t self:udp_socket connect;
+allow vpnc_t self:socket create_socket_perms;
 
 # Use capabilities.
 allow vpnc_t self:capability { net_admin ipc_lock net_bind_service net_raw };
@@ -28,3 +30,12 @@
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
 allow vpnc_t admin_tty_type:chr_file rw_file_perms;
+allow vpnc_t port_t:udp_socket { name_bind };
+allow vpnc_t etc_runtime_t:file { getattr read };
+allow vpnc_t proc_t:file { getattr read };
+dontaudit vpnc_t selinux_config_t:dir search;
+can_exec(vpnc_t, {bin_t sbin_t ifconfig_exec_t shell_exec_t })
+allow vpnc_t sysctl_net_t:dir { search };
+allow vpnc_t sbin_t:dir { search };
+allow vpnc_t bin_t:dir { search };
+allow vpnc_t bin_t:lnk_file { read };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/xdm.te policy-1.18.2.old/domains/program/unused/xdm.te
--- policy-1.18.2/domains/program/unused/xdm.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/xdm.te	2004-11-05 23:57:55.353849449 -0500
@@ -46,7 +46,7 @@
 allow xdm_t default_context_t:file { read getattr };
 
 can_network(xdm_t)
-can_ypbind(xdm_t)
+allow xdm_t self:udp_socket connect;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
@@ -287,7 +287,7 @@
 }
 
 # for .dmrc
-allow xdm_t user_home_dir_type:dir search;
+allow xdm_t user_home_dir_type:dir { getattr search };
 allow xdm_t user_home_type:file { getattr read };
 
 allow xdm_t mnt_t:dir { getattr read search };
@@ -309,8 +309,6 @@
 ')
 
 allow xdm_t var_log_t:file { read };
-dontaudit xdm_t krb5_conf_t:file { write };
-allow xdm_t krb5_conf_t:file { getattr read };
 allow xdm_t self:capability { sys_nice sys_rawio net_bind_service };
 allow xdm_t self:process { setrlimit };
 allow xdm_t wtmp_t:file { getattr read };
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/program/unused/ypbind.te policy-1.18.2.old/domains/program/unused/ypbind.te
--- policy-1.18.2/domains/program/unused/ypbind.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/program/unused/ypbind.te	2004-11-05 23:57:55.354849337 -0500
@@ -12,8 +12,6 @@
 #
 daemon_domain(ypbind)
 
-bool allow_ypbind true;
-
 tmp_domain(ypbind)
 
 # Use capabilities.
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/domains/user.te policy-1.18.2.old/domains/user.te
--- policy-1.18.2/domains/user.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/domains/user.te	2004-11-05 23:57:55.355849224 -0500
@@ -15,6 +15,9 @@
 # and may change other protocols 
 bool user_tcp_server false;
 
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/base_user_macros.te policy-1.18.2.old/macros/base_user_macros.te
--- policy-1.18.2/macros/base_user_macros.te	2004-11-06 00:09:29.744360784 -0500
+++ policy-1.18.2.old/macros/base_user_macros.te	2004-11-05 23:58:27.899181436 -0500
@@ -196,12 +196,19 @@
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
 dbusd_client(system, $1)
 can_network($1_dbusd_t)
-allow $1_dbusd_t reserved_port_t:tcp_socket name_bind;
+allow $1_dbusd_t reserved_port_t:tcp_socket { name_bind };
 
 allow $1_t system_dbusd_t:dbus { send_msg acquire_svc };
 dbusd_client($1, $1)
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/core_macros.te policy-1.18.2.old/macros/core_macros.te
--- policy-1.18.2/macros/core_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/core_macros.te	2004-11-05 23:57:55.360848660 -0500
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/global_macros.te policy-1.18.2.old/macros/global_macros.te
--- policy-1.18.2/macros/global_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/global_macros.te	2004-11-05 23:57:55.361848548 -0500
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
@@ -271,6 +213,7 @@
 define(`daemon_core_rules', `
 type $1_t, domain, privlog, daemon $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
+dontaudit $1_t self:capability sys_tty_config;
 
 role system_r types $1_t;
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/network_macros.te policy-1.18.2.old/macros/network_macros.te
--- policy-1.18.2/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.18.2.old/macros/network_macros.te	2004-11-05 23:57:55.362848435 -0500
@@ -0,0 +1,108 @@
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
+can_tcp_network($1, `$2')
+can_udp_network($1, `$2')
+
+#
+# Allow the domain to send NFS client requests via the socket
+# created by mount.
+#
+allow $1 mount_t:udp_socket rw_socket_perms;
+
+')dnl end can_network definition
+
+define(`can_resolve',`
+can_udp_network($1, `dns_port_t')
+allow $1 self:udp_socket connect;
+')
+define(`can_ldap',`
+can_tcp_network($1, `ldap_port_t')
+allow $1 self:tcp_socket connect;
+')
+define(`can_kerberos',`
+can_network($1, `kerberos_port_t')
+allow $1 self:{ udp_socket tcp_socket } connect;
+dontaudit $1 krb5_conf_t:file { write };
+allow $1 krb5_conf_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/cdrecord_macros.te policy-1.18.2.old/macros/program/cdrecord_macros.te
--- policy-1.18.2/macros/program/cdrecord_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/cdrecord_macros.te	2004-11-05 23:57:55.363848322 -0500
@@ -32,9 +32,9 @@
 
 # allow cdrecord to read user files
 r_dir_file($1_cdrecord_t, { $1_home_t $1_tmp_t })
-if (use_nfs_home_dirs) {
+ifdef(`nfs_home_dirs', `
 r_dir_file($1_cdrecord_t, nfs_t)
-}
+')dnl end if nfs_home_dirs
 
 # allow searching for cdrom-drive
 allow $1_cdrecord_t device_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/chkpwd_macros.te policy-1.18.2.old/macros/program/chkpwd_macros.te
--- policy-1.18.2/macros/program/chkpwd_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/chkpwd_macros.te	2004-11-05 23:57:55.363848322 -0500
@@ -21,13 +21,20 @@
 allow $1_chkpwd_t proc_t:file read;
 can_getcon($1_chkpwd_t)
 can_ypbind($1_chkpwd_t)
+can_kerberos($1_chkpwd_t)
+can_ldap($1_chkpwd_t)
+can_resolve($1_chkpwd_t)
 # Transition from the user domain to this domain.
 ifelse($1, system, `
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
 role system_r types system_chkpwd_t;
 dontaudit auth_chkpwd shadow_t:file { getattr read };
 allow auth_chkpwd sbin_t:dir search;
-dontaudit $1_chkpwd_t tty_device_t:chr_file rw_file_perms;
+dontaudit $1_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
+can_ypbind(auth_chkpwd)
+can_kerberos(auth_chkpwd)
+can_ldap(auth_chkpwd)
+can_resolve(auth_chkpwd)
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/crond_macros.te policy-1.18.2.old/macros/program/crond_macros.te
--- policy-1.18.2/macros/program/crond_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/crond_macros.te	2004-11-05 23:57:55.364848210 -0500
@@ -68,6 +68,7 @@
 # This domain is granted permissions common to most domains.
 can_network($1_crond_t)
 can_ypbind($1_crond_t)
+allow $1_crond_t self:{ tcp_socket udp_socket } connect;
 r_dir_file($1_crond_t, self)
 allow $1_crond_t self:fifo_file rw_file_perms;
 allow $1_crond_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/inetd_macros.te policy-1.18.2.old/macros/program/inetd_macros.te
--- policy-1.18.2/macros/program/inetd_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/inetd_macros.te	2004-11-05 23:57:55.364848210 -0500
@@ -43,8 +43,7 @@
 allow $1_t home_root_t:dir { search };
 allow $1_t self:dir { search };
 allow $1_t self:file { getattr read };
-allow $1_t krb5_conf_t:file r_file_perms;
-dontaudit $1_t krb5_conf_t:file write;
+can_kerberos($1_t)
 allow $1_t urandom_device_t:chr_file { getattr read };
 type $1_port_t, port_type, reserved_port_type;
 # Use sockets inherited from inetd.
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/mozilla_macros.te policy-1.18.2.old/macros/program/mozilla_macros.te
--- policy-1.18.2/macros/program/mozilla_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/mozilla_macros.te	2004-11-05 23:57:55.365848097 -0500
@@ -17,6 +17,7 @@
 #
 define(`mozilla_domain',`
 x_client_domain($1, mozilla, `, web_client_domain, privlog')
+allow $1_mozilla_t self:{ tcp_socket udp_socket } { connect };
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
@@ -112,6 +113,7 @@
 # Eliminate errors from scanning with the 
 #
 dontaudit $1_mozilla_t file_type:dir getattr;
+allow $1_mozilla_t self:sem create_sem_perms;
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/mta_macros.te policy-1.18.2.old/macros/program/mta_macros.te
--- policy-1.18.2/macros/program/mta_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/mta_macros.te	2004-11-05 23:57:55.366847984 -0500
@@ -37,6 +37,7 @@
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
+allow $1_mail_t self:{ tcp_socket udp_socket } connect;
 
 read_locale($1_mail_t)
 read_sysctl($1_mail_t)
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/newrole_macros.te policy-1.18.2.old/macros/program/newrole_macros.te
--- policy-1.18.2/macros/program/newrole_macros.te	2004-11-06 00:09:29.766358467 -0500
+++ policy-1.18.2.old/macros/program/newrole_macros.te	2004-11-05 23:57:55.366847984 -0500
@@ -34,9 +34,6 @@
 allow $1_t bin_t:lnk_file read;
 allow $1_t shell_exec_t:file r_file_perms;
 
-can_ypbind($1_t)
-dontaudit $1_t krb5_conf_t:file { write };
-allow $1_t krb5_conf_t:file { getattr read };
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 # Allow $1_t to transition to user domains.
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/ssh_macros.te policy-1.18.2.old/macros/program/ssh_macros.te
--- policy-1.18.2/macros/program/ssh_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/ssh_macros.te	2004-11-05 23:57:55.367847872 -0500
@@ -84,6 +84,7 @@
 # to access the network.
 can_network($1_ssh_t)
 can_ypbind($1_ssh_t)
+allow $1_ssh_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
@@ -157,8 +158,7 @@
 allow $1_ssh_t xdm_xserver_t:shm r_shm_perms;
 allow $1_ssh_t xdm_xserver_t:fd use;
 allow $1_ssh_t xdm_xserver_tmpfs_t:file read;
-allow $1_ssh_t krb5_conf_t:file { getattr read };
-dontaudit $1_ssh_t krb5_conf_t:file { write };
+can_kerberos($1_ssh_t)
 ')dnl end if xdm.te
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/su_macros.te policy-1.18.2.old/macros/program/su_macros.te
--- policy-1.18.2/macros/program/su_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/su_macros.te	2004-11-05 23:57:55.368847759 -0500
@@ -87,8 +87,7 @@
 # Write to utmp.
 allow $1_su_t { var_t var_run_t }:dir search;
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
-dontaudit $1_su_t krb5_conf_t:file { write };
-allow $1_su_t krb5_conf_t:file { getattr read };
+can_kerberos($1_su_t)
 ') dnl end su_restricted_domain
 
 define(`su_mini_domain', `
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/userhelper_macros.te policy-1.18.2.old/macros/program/userhelper_macros.te
--- policy-1.18.2/macros/program/userhelper_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/userhelper_macros.te	2004-11-05 23:57:55.369847646 -0500
@@ -123,7 +123,6 @@
 ')
 allow $1_userhelper_t sysctl_t:dir { search };
 role system_r types $1_userhelper_t;
-allow $1_userhelper_t krb5_conf_t:file { getattr read };
 r_dir_file($1_userhelper_t, nfs_t)
 
 ifdef(`xdm.te', `
@@ -139,6 +138,9 @@
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
 allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
 ')
+
+ifdef(`pamconsole.te', `
 allow $1_userhelper_t pam_var_console_t:dir { search };
+')
 
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/xserver_macros.te policy-1.18.2.old/macros/program/xserver_macros.te
--- policy-1.18.2/macros/program/xserver_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/xserver_macros.te	2004-11-05 23:57:55.370847533 -0500
@@ -27,10 +27,11 @@
 ifdef(`distro_redhat', `
 type $1_xserver_t, domain, privlog, privmem, privmodule, nscd_client_domain;
 allow $1_xserver_t sysctl_modprobe_t:file { getattr read };
+ifdef(`rpm.te', `
 allow $1_xserver_t rpm_t:shm { unix_read unix_write read write associate getattr };
 allow $1_xserver_t rpm_tmpfs_t:file { read write };
 allow $1_xserver_t rpm_t:fd { use };
-
+')
 ', `
 type $1_xserver_t, domain, privlog, privmem, nscd_client_domain;
 ')
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/program/ypbind_macros.te policy-1.18.2.old/macros/program/ypbind_macros.te
--- policy-1.18.2/macros/program/ypbind_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/program/ypbind_macros.te	2004-11-05 23:57:55.370847533 -0500
@@ -4,12 +4,16 @@
 can_network($1)
 r_dir_file($1,var_yp_t)
 allow $1 { reserved_port_t port_t }:{ tcp_socket udp_socket } name_bind;
+allow $1 self:{ tcp_socket udp_socket } connect;
+dontaudit $1 self:capability net_bind_service;
 ')
 
 define(`can_ypbind', `
 ifdef(`ypbind.te', `
 if (allow_ypbind) {
 uncond_can_ypbind($1)
+} else {
+dontaudit $1 var_yp_t:dir { search };
 }
 ') dnl ypbind.te
 ') dnl can_ypbind
diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/user_macros.te policy-1.18.2.old/macros/user_macros.te
--- policy-1.18.2/macros/user_macros.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/macros/user_macros.te	2004-11-05 23:57:55.371847421 -0500
@@ -57,7 +57,7 @@
 ifdef(`apache.te', `apache_domain($1)')
 ifdef(`slocate.te', `locate_domain($1)')
 
-allow $1_t krb5_conf_t:file { getattr read };
+can_kerberos($1_t)
 # allow port_t name binding for UDP because it is not very usable otherwise
 allow $1_t port_t:udp_socket name_bind;
 
@@ -142,11 +142,6 @@
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
@@ -224,9 +219,11 @@
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
diff --exclude-from=exclude -N -u -r policy-1.18.2/targeted/domains/unconfined.te policy-1.18.2.old/targeted/domains/unconfined.te
--- policy-1.18.2/targeted/domains/unconfined.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/targeted/domains/unconfined.te	2004-11-05 23:57:55.375846970 -0500
@@ -42,4 +42,7 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/tunables/distro.tun policy-1.18.2.old/tunables/distro.tun
--- policy-1.18.2/tunables/distro.tun	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.old/tunables/distro.tun	2004-11-05 23:57:55.375846970 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r policy-1.18.2/tunables/tunable.tun policy-1.18.2.old/tunables/tunable.tun
--- policy-1.18.2/tunables/tunable.tun	2004-11-06 00:12:58.735313440 -0500
+++ policy-1.18.2.old/tunables/tunable.tun	2004-11-05 23:57:55.376846857 -0500
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

--------------070508080302010001090505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
