Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFEHMIi023016
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:17:22 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFEHOuA004060
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 14:17:25 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iAFEK6Xf024613
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:20:06 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iAFEK6ux024612
	for selinux@tycho.nsa.gov; Mon, 15 Nov 2004 09:20:06 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAANC1Ii003547
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 18:12:02 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAANAYxb011751
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 23:10:37 GMT
Message-ID: <4192A029.5050909@redhat.com>
Date: Wed, 10 Nov 2004 18:11:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Patches without the can_network patch.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070506050508080702070506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070506050508080702070506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removal of alot of kerberos and can_ypbind calls.  (Centralized under 
the auth call).

Several apache fixes to make squirrelmail work as well as mod_perl and 
mod_python.

Fixes to dovecot to get it to work with squirrelmail

Fixes to hal to allow it to create a chr_file device for pcmcia card 
communication.

Added lockdev policy

Fixes for mailman policy

A few more nscd_client_domains



--------------070506050508080702070506
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.19.1/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/crond.te	2004-11-10 17:30:03.409889426 -0500
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.19.1/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/initrc.te	2004-11-10 17:30:03.410889314 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.19.1/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/login.te	2004-11-10 17:30:03.411889201 -0500
@@ -117,8 +117,6 @@
 allow $1_login_t mail_spool_t:file getattr;
 allow $1_login_t mail_spool_t:lnk_file read;
 
-dontaudit $1_login_t krb5_conf_t:file write;
-allow $1_login_t krb5_conf_t:file { getattr read };
 # Get security policy decisions.
 can_getsecurity($1_login_t)
 
@@ -127,8 +125,6 @@
 allow $1_login_t default_context_t:dir search;
 r_dir_file($1_login_t, selinux_config_t)
 
-can_ypbind($1_login_t)
-
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
 dontaudit $1_login_t init_t:fd use;
 ')dnl end login_domain macro
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.19.1/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/ssh.te	2004-11-10 17:34:01.995972995 -0500
@@ -70,9 +70,8 @@
 
 can_network($1_t)
 
-allow $1_t self:capability { sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
+allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
-can_ypbind($1_t)
 if (use_nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
@@ -213,8 +212,6 @@
 ifdef(`automount.te', `
 allow sshd_t autofs_t:dir search;
 ')
-dontaudit sshd_t krb5_conf_t:file write;
-allow sshd_t krb5_conf_t:file { getattr read };
 
 # ssh_keygen_t is the type of the ssh-keygen program when run at install time
 # and by sysadm_t
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.19.1/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/syslogd.te	2004-11-10 17:34:55.342954578 -0500
@@ -96,4 +96,4 @@
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir search;
 dontaudit syslogd_t unlabeled_t:file read;
-dontaudit syslogd_t devpts_t:chr_file getattr;
+dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.19.1/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/anaconda.te	2004-11-10 17:30:03.411889201 -0500
@@ -242,8 +242,7 @@
 ifdef(`udev.te', `
 domain_auto_trans(anaconda_t, udev_exec_t, udev_t)
 ')
-allow anaconda_t krb5_conf_t:file read;
-dontaudit anaconda_t krb5_conf_t:file write;
+can_kerberos(anaconda_t)
 
 ifdef(`ssh-agent.te', `
 role system_r types sysadm_ssh_agent_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.1/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/apache.te	2004-11-10 17:56:47.888877824 -0500
@@ -133,6 +133,7 @@
 # execute perl
 allow httpd_t { bin_t sbin_t }:dir r_dir_perms;
 can_exec(httpd_t, { bin_t sbin_t })
+allow httpd_t bin_t:lnk_file read;
 
 can_network(httpd_t)
 can_ypbind(httpd_t)
@@ -201,6 +202,10 @@
 if (httpd_ssi_exec) {
 domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)
 }
+r_dir_file(httpd_t, httpd_sys_script_ro_t)
+create_dir_file(httpd_t, httpd_sys_script_rw_t)
+ra_dir_file(httpd_t, httpd_sys_script_ra_t)
+allow httpd_sys_script_t httpd_t:tcp_socket { read write };
 
 ##################################################
 #
@@ -269,8 +274,7 @@
 ##################################################
 dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
 
-allow httpd_t krb5_conf_t:file { getattr read };
-dontaudit httpd_t krb5_conf_t:file write;
+can_kerberos(httpd_t)
 
 ifdef(`targeted_policy', `
 typealias httpd_sys_content_t alias httpd_user_content_t;
@@ -298,5 +302,13 @@
 # Customer reported the following
 #
 ifdef(`snmpd.te', `
+dontaudit httpd_t snmpd_var_lib_t:dir search;
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
 ')
+
+# Running squirrelmail requires this permissions
+ifdef(`mta.te', `
+allow system_mail_t httpd_log_t:file { append getattr };
+allow system_mail_t httpd_sys_script_rw_t:file { append read };
+allow system_mail_t httpd_t:tcp_socket { read write };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.19.1/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.1/domains/program/unused/arpwatch.te	2004-11-10 17:30:03.412889088 -0500
@@ -27,6 +27,7 @@
 
 allow arpwatch_t sbin_t:dir search;
 allow arpwatch_t sbin_t:lnk_file read;
+r_dir_file(arpwatch_t, etc_t)
 can_ypbind(arpwatch_t)
 allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
 ifdef(`postfix.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.19.1/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.1/domains/program/unused/bluetooth.te	2004-11-10 17:30:03.412889088 -0500
@@ -22,7 +22,10 @@
 # Use the network.
 can_network(bluetooth_t)
 can_ypbind(bluetooth_t)
+ifdef(`dbusd.te', `
 dbusd_client(system, bluetooth)
+allow bluetooth_t system_dbusd_t:dbus send_msg;
+')
 allow bluetooth_t self:socket { create setopt ioctl bind listen };
 allow bluetooth_t self:unix_dgram_socket create_socket_perms;
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/courier.te policy-1.19.1/domains/program/unused/courier.te
--- nsapolicy/domains/program/unused/courier.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.1/domains/program/unused/courier.te	2004-11-10 17:30:03.413888975 -0500
@@ -47,7 +47,6 @@
 
 # Use the network.
 can_network(courier_$1_t)
-can_ypbind(courier_$1_t)
 allow courier_$1_t self:fifo_file { read write getattr };
 allow courier_$1_t self:unix_stream_socket create_stream_socket_perms;
 allow courier_$1_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.1/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/cups.te	2004-11-10 17:36:49.019130037 -0500
@@ -19,7 +19,6 @@
 typealias cupsd_rw_etc_t alias etc_cupsd_rw_t;
 
 can_network(cupsd_t)
-can_ypbind(cupsd_t)
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.19.1/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/dovecot.te	2004-11-10 17:38:35.374131445 -0500
@@ -31,10 +31,14 @@
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
 
-dontaudit dovecot_t krb5_conf_t:file write;
-allow dovecot_t krb5_conf_t:file { getattr read };
+can_kerberos(dovecot_t)
 
-daemon_sub_domain(dovecot_t, dovecot_auth, `, auth')
+allow dovecot_t tmp_t:dir search;
+rw_dir_file(dovecot_t, mail_spool_t)
+allow dovecot_t mail_spool_t:lnk_file read;
+allow dovecot_t var_spool_t:dir { search };
+
+daemon_sub_domain(dovecot_t, dovecot_auth, `, auth, auth_chkpwd')
 allow dovecot_auth_t self:process { fork signal_perms };
 allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
 allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
@@ -47,3 +51,5 @@
 allow dovecot_auth_t sysctl_kernel_t:dir search;
 allow dovecot_auth_t sysctl_kernel_t:file read;
 allow dovecot_auth_t sysctl_t:dir search;
+dontaudit dovecot_auth_t selinux_config_t:dir search;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.19.1/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/ftpd.te	2004-11-10 17:39:19.706130067 -0500
@@ -16,7 +16,6 @@
 typealias ftpd_etc_t alias etc_ftpd_t;
 
 can_network(ftpd_t)
-can_ypbind(ftpd_t)
 allow ftpd_t self:unix_dgram_socket { sendto create_socket_perms };
 allow ftpd_t self:unix_stream_socket create_socket_perms;
 allow ftpd_t self:process { getcap setcap setsched setrlimit };
@@ -85,9 +84,7 @@
 allow ftpd_t proc_t:file { getattr read };
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
-dontaudit ftpd_t krb5_conf_t:file write;
 dontaudit ftpd_t selinux_config_t:dir search;
-allow ftpd_t krb5_conf_t:file { getattr read };
 ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir search;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.19.1/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/hald.te	2004-11-10 17:40:15.314856488 -0500
@@ -31,12 +31,13 @@
 
 allow hald_t bin_t:file getattr;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
-allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search };
+allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
 can_network(hald_t)
 can_ypbind(hald_t)
 
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
+allow hald_t removable_device_t:blk_file write;
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file read;
@@ -64,3 +65,7 @@
 allow hald_t initrc_t:dbus send_msg;
 allow initrc_t hald_t:dbus send_msg;
 allow hald_t etc_runtime_t:file rw_file_perms;
+allow hald_t var_lib_t:dir search;
+allow hald_t device_t:dir create_dir_perms;
+allow hald_t device_t:chr_file create_file_perms;
+tmp_domain(hald)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lockdev.te policy-1.19.1/domains/program/unused/lockdev.te
--- nsapolicy/domains/program/unused/lockdev.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.1/domains/program/unused/lockdev.te	2004-11-10 17:59:50.581267119 -0500
@@ -0,0 +1,11 @@
+#DESC Lockdev - libblockdev helper application
+#
+# Authors:  Daniel Walsh <dwalsh@redhat.com> 
+#
+
+
+# Type for the lockdev
+type lockdev_exec_t, file_type, sysadmfile, exec_type;
+
+# Everything else is in the lockdev_domain macro in
+# macros/program/lockdev_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.19.1/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/mailman.te	2004-11-10 17:44:21.526079815 -0500
@@ -20,7 +20,7 @@
 can_exec_any(mailman_$1_t)
 allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
-allow mailman_$1_t var_lib_t:dir { getattr search };
+allow mailman_$1_t var_lib_t:dir { getattr search read };
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
 allow mailman_$1_t etc_runtime_t:file { read getattr };
@@ -29,7 +29,6 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
-can_ypbind(mailman_$1_t)
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
 ')
@@ -72,8 +71,9 @@
 domain_auto_trans({ httpd_t httpd_suexec_t }, mailman_cgi_exec_t, mailman_cgi_t)
 # should have separate types for public and private archives
 r_dir_file(httpd_t, mailman_archive_t)
-allow httpd_t mailman_data_t:dir search;
-r_dir_file(mailman_cgi_t, mailman_archive_t)
+rw_dir_file(mailman_cgi_t, mailman_archive_t)
+allow mailman_cgi_t mailman_archive_t:lnk_file create_lnk_perms;
+allow httpd_t mailman_data_t:dir { getattr search };
 
 dontaudit mailman_cgi_t httpd_log_t:file append;
 allow httpd_t mailman_cgi_t:process signal;
@@ -83,6 +83,8 @@
 allow mailman_cgi_t httpd_sys_script_t:dir search;
 allow mailman_cgi_t devtty_t:chr_file { read write };
 allow mailman_cgi_t self:process { fork sigchld };
+allow mailman_cgi_t var_spool_t:dir search;
+dontaudit mailman_cgi_t src_t:dir search;
 ')
 
 allow mta_delivery_agent mailman_data_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.19.1/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/ntpd.te	2004-11-10 17:45:02.917410193 -0500
@@ -12,7 +12,10 @@
 type ntp_drift_t, file_type, sysadmfile;
 type ntp_port_t, port_type, reserved_port_type;
 
+type ntpdate_exec_t, file_type, sysadmfile, exec_type;
+domain_auto_trans(initrc_t, ntpdate_exec_t, ntpd_t)
+
 logdir_domain(ntpd)
 
 allow ntpd_t var_lib_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.19.1/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2004-06-16 13:33:36.000000000 -0400
+++ policy-1.19.1/domains/program/unused/ping.te	2004-11-10 17:45:38.999339558 -0500
@@ -54,4 +54,6 @@
 
 # it tries to access /var/run
 dontaudit ping_t var_t:dir search;
+dontaudit ping_t devtty_t:chr_file { read write };
+dontaudit ping_t ping_t:capability sys_tty_config;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.1/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.19.1/domains/program/unused/postgresql.te	2004-11-10 17:46:14.180370560 -0500
@@ -13,6 +13,7 @@
 type postgresql_port_t, port_type;
 daemon_domain(postgresql)
 allow initrc_t postgresql_exec_t:lnk_file read;
+allow postgresql_t usr_t:file { getattr read };
 
 allow postgresql_t postgresql_var_run_t:sock_file create_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.19.1/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.19.1/domains/program/unused/procmail.te	2004-11-10 17:30:03.458883899 -0500
@@ -11,7 +11,7 @@
 # procmail_exec_t is the type of the procmail executable.
 #
 # privhome only works until we define a different type for maildir
-type procmail_t, domain, privlog, privhome;
+type procmail_t, domain, privlog, privhome, nscd_client_domain;
 type procmail_exec_t, file_type, sysadmfile, exec_type;
 
 role system_r types procmail_t;
@@ -70,8 +70,9 @@
 
 ifdef(`sendmail.te', `
 r_dir_file(procmail_t, etc_mail_t)
+allow procmail_t sendmail_t:tcp_socket { read write };
 ')
 
 ifdef(`hide_broken_symptoms', `
-dontaudit procmail_t mqueue_spool_t:file { getattr read };
+dontaudit procmail_t mqueue_spool_t:file { getattr read write };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.19.1/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.1/domains/program/unused/rlogind.te	2004-11-10 17:30:03.459883786 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.19.1/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.1/domains/program/unused/rshd.te	2004-11-10 17:30:03.459883786 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.19.1/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.1/domains/program/unused/samba.te	2004-11-10 17:30:03.460883673 -0500
@@ -49,7 +49,6 @@
 
 # Use the network.
 can_network(smbd_t)
-can_ypbind(smbd_t)
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.19.1/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.19.1/domains/program/unused/swat.te	2004-11-10 17:30:03.460883673 -0500
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/uwimapd.te policy-1.19.1/domains/program/unused/uwimapd.te
--- nsapolicy/domains/program/unused/uwimapd.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/domains/program/unused/uwimapd.te	2004-11-10 17:30:03.461883561 -0500
@@ -9,7 +9,6 @@
 tmp_domain(imapd)
 
 can_network(imapd_t)
-can_ypbind(imapd_t)
 
 #declare our own services
 allow imapd_t self:capability { dac_override net_bind_service setgid setuid sys_resource };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.19.1/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/domains/program/unused/xdm.te	2004-11-10 17:47:38.531854326 -0500
@@ -46,7 +46,6 @@
 allow xdm_t default_context_t:file { read getattr };
 
 can_network(xdm_t)
-can_ypbind(xdm_t)
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
@@ -287,7 +286,7 @@
 }
 
 # for .dmrc
-allow xdm_t user_home_dir_type:dir search;
+allow xdm_t user_home_dir_type:dir { getattr search };
 allow xdm_t user_home_type:file { getattr read };
 
 allow xdm_t mnt_t:dir { getattr read search };
@@ -309,8 +308,6 @@
 ')
 
 allow xdm_t var_log_t:file read;
-dontaudit xdm_t krb5_conf_t:file write;
-allow xdm_t krb5_conf_t:file { getattr read };
 allow xdm_t self:capability { sys_nice sys_rawio net_bind_service };
 allow xdm_t self:process setrlimit;
 allow xdm_t wtmp_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.19.1/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/domains/program/unused/ypbind.te	2004-11-10 17:47:51.590381109 -0500
@@ -12,8 +12,6 @@
 #
 daemon_domain(ypbind)
 
-bool allow_ypbind true;
-
 tmp_domain(ypbind)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.19.1/domains/user.te
--- nsapolicy/domains/user.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.1/domains/user.te	2004-11-10 17:30:03.462883448 -0500
@@ -15,6 +15,9 @@
 # and may change other protocols 
 bool user_tcp_server false;
 
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.19.1/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2004-10-14 23:25:19.000000000 -0400
+++ policy-1.19.1/file_contexts/program/apache.fc	2004-11-10 17:30:03.463883335 -0500
@@ -37,3 +37,4 @@
 # suse puts shell scripts there :-(
 /usr/share/apache2/.*	--	system_u:object_r:bin_t
 ')
+/var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_sys_script_rw_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/bootloader.fc policy-1.19.1/file_contexts/program/bootloader.fc
--- nsapolicy/file_contexts/program/bootloader.fc	2004-08-18 08:42:50.000000000 -0400
+++ policy-1.19.1/file_contexts/program/bootloader.fc	2004-11-10 17:30:03.463883335 -0500
@@ -9,4 +9,3 @@
 /etc/mkinitrd/scripts/.* --	system_u:object_r:bootloader_exec_t
 /sbin/ybin.*		--	system_u:object_r:bootloader_exec_t
 /etc/yaboot\.conf.*	--	system_u:object_r:bootloader_etc_t
-/boot/grub/menu.lst	--	system_u:object_r:boot_runtime_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lockdev.fc policy-1.19.1/file_contexts/program/lockdev.fc
--- nsapolicy/file_contexts/program/lockdev.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.1/file_contexts/program/lockdev.fc	2004-11-10 17:30:03.464883222 -0500
@@ -0,0 +1,2 @@
+# lockdev 
+/usr/sbin/lockdev	--	system_u:object_r:lockdev_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ntpd.fc policy-1.19.1/file_contexts/program/ntpd.fc
--- nsapolicy/file_contexts/program/ntpd.fc	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.19.1/file_contexts/program/ntpd.fc	2004-11-10 17:30:03.464883222 -0500
@@ -3,7 +3,7 @@
 /etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
-/usr/sbin/ntpdate		--	system_u:object_r:ntpd_exec_t
+/usr/sbin/ntpdate		--	system_u:object_r:ntpdate_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
 /var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.1/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/file_contexts/types.fc	2004-11-10 17:30:03.465883109 -0500
@@ -111,7 +111,6 @@
 #
 /boot(/.*)?			system_u:object_r:boot_t
 /boot/System\.map-.*	--	system_u:object_r:system_map_t
-/boot/kernel\.h.*	--	system_u:object_r:boot_runtime_t
 
 #
 # /dev
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.19.1/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/admin_macros.te	2004-11-10 17:30:03.466882997 -0500
@@ -17,6 +17,7 @@
 # Type for home directory.
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
 type $1_home_t, file_type, sysadmfile, home_type;
+attribute $1_homedirfile;
 
 # Type and access for pty devices.
 can_create_pty($1)
@@ -106,6 +107,7 @@
 allow $1_t tty_device_t:chr_file rw_file_perms;
 allow $1_t ttyfile:chr_file rw_file_perms;
 allow $1_t ptyfile:chr_file rw_file_perms;
+allow $1_t serial_device:chr_file setattr;
 
 # allow setting up tunnels
 allow $1_t tun_tap_device_t:chr_file rw_file_perms;
@@ -155,6 +157,7 @@
 allow xdm_t $1_home_t:lnk_file read;
 allow xdm_t $1_home_t:dir search;
 }
+allow $1_t xdm_t:fifo_file rw_file_perms;
 ')dnl end ifdef xauth.te
 ')dnl end ifdef xdm.te
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.19.1/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/base_user_macros.te	2004-11-10 17:48:49.047898957 -0500
@@ -197,6 +197,12 @@
 can_network($1_t)
 can_ypbind($1_t)
 
+ifdef(`pamconsole.te', `
+allow $1_t pam_var_console_t:dir search;
+')
+
+allow $1_t var_lock_t:dir search;
+
 # Grant permissions to access the system DBus
 ifdef(`dbusd.te', `
 dbusd_client(system, $1)
@@ -269,7 +275,8 @@
 allow $1_t xdm_xserver_tmp_t:sock_file { read write };
 allow $1_t xdm_xserver_tmp_t:dir search;
 allow $1_t xdm_xserver_t:unix_stream_socket connectto;
-allow $1_t xdm_var_run_t:dir search;
+# certain apps want to read xdm.pid file
+r_dir_file($1_t, xdm_var_run_t)
 allow $1_t xdm_var_lib_t:file { getattr read };
 allow xdm_t $1_home_dir_t:dir getattr;
 ifdef(`xauth.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.19.1/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/global_macros.te	2004-11-10 17:49:34.622757364 -0500
@@ -271,6 +271,7 @@
 define(`daemon_core_rules', `
 type $1_t, domain, privlog, daemon $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
+dontaudit $1_t self:capability sys_tty_config;
 
 role system_r types $1_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.19.1/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.1/macros/network_macros.te	2004-11-10 17:50:28.419688186 -0500
@@ -0,0 +1,5 @@
+define(`can_kerberos',`
+can_network($1)
+dontaudit $1 krb5_conf_t:file write;
+allow $1 krb5_conf_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.19.1/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/apache_macros.te	2004-11-10 17:30:03.467882884 -0500
@@ -3,7 +3,7 @@
 
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, homedirfile, httpdcontent, sysadmfile;
+type httpd_$1_content_t, file_type, ifelse($1, sys, `', `$1_homedirfile, ') httpdcontent, sysadmfile;
 ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 ')
@@ -17,7 +17,7 @@
 type httpd_$1_script_exec_t, file_type, sysadmfile;
 
 # Type that CGI scripts run as
-type httpd_$1_script_t, domain, privmail;
+type httpd_$1_script_t, domain, privmail, nscd_client_domain;
 role system_r types httpd_$1_script_t;
 
 if (httpd_enable_cgi) {
@@ -91,7 +91,7 @@
 #########################################################################
 can_exec(httpd_$1_script_t, { bin_t shell_exec_t })
 allow httpd_$1_script_t { bin_t sbin_t }:dir { getattr search };
-allow httpd_$1_script_t bin_t:lnk_file read;
+allow httpd_$1_script_t { sbin_t bin_t }:lnk_file read;
 allow httpd_$1_script_t etc_t:file { getattr read };
 
 ############################################################################
@@ -178,6 +178,6 @@
 ############################################
 # Allow scripts to append to http logs
 #########################################
-allow httpd_$1_script_t httpd_log_t:file append;
+allow httpd_$1_script_t httpd_log_t:file { getattr append };
 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.19.1/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.19.1/macros/program/chkpwd_macros.te	2004-11-10 17:54:43.803876651 -0500
@@ -15,19 +15,22 @@
 ifdef(`chkpwd.te', `
 define(`chkpwd_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_chkpwd_t, domain, privlog, auth;
+type $1_chkpwd_t, domain, privlog, nscd_client_domain, auth;
 
 # is_selinux_enabled
 allow $1_chkpwd_t proc_t:file read;
 can_getcon($1_chkpwd_t)
 can_ypbind($1_chkpwd_t)
+can_kerberos($1_chkpwd_t)
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
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.19.1/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.19.1/macros/program/gpg_macros.te	2004-11-10 17:30:03.468882771 -0500
@@ -19,7 +19,7 @@
 define(`gpg_domain', `
 # Derived domain based on the calling user domain and the program.
 type $1_gpg_t, domain, privlog;
-type $1_gpg_secret_t, file_type, homedirfile, sysadmfile;
+type $1_gpg_secret_t, file_type, $1_homedirfile, sysadmfile;
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
@@ -82,6 +82,7 @@
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
 allow $1_gpg_t devtty_t:chr_file rw_file_perms;
+rw_dir_create_file($1_gpg_t, $1_homedirfile)
 
 allow $1_gpg_t { etc_t usr_t }:dir r_dir_perms;
 allow $1_gpg_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.19.1/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/inetd_macros.te	2004-11-10 17:30:03.469882658 -0500
@@ -43,8 +43,7 @@
 allow $1_t home_root_t:dir search;
 allow $1_t self:dir search;
 allow $1_t self:file { getattr read };
-allow $1_t krb5_conf_t:file r_file_perms;
-dontaudit $1_t krb5_conf_t:file write;
+can_kerberos($1_t)
 allow $1_t urandom_device_t:chr_file { getattr read };
 type $1_port_t, port_type, reserved_port_type;
 # Use sockets inherited from inetd.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.19.1/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.19.1/macros/program/irc_macros.te	2004-11-10 17:30:03.469882658 -0500
@@ -20,7 +20,7 @@
 define(`irc_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, homedirfile, sysadmfile;
+type $1_home_irc_t, file_type, $1_homedirfile, sysadmfile;
 type $1_irc_exec_t, file_type, sysadmfile;
 
 ifdef(`slocate.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lockdev_macros.te policy-1.19.1/macros/program/lockdev_macros.te
--- nsapolicy/macros/program/lockdev_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.1/macros/program/lockdev_macros.te	2004-11-10 17:30:03.470882545 -0500
@@ -0,0 +1,46 @@
+#
+# Macros for lockdev domains.
+#
+
+#
+# Authors:  Daniel Walsh <dwalsh@redhat.com> 
+#
+
+#
+# lockdev_domain(domain_prefix)
+#
+# Define a derived domain for the lockdev programs when executed
+# by a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/lockdev.te. 
+#
+undefine(`lockdev_domain')
+define(`lockdev_domain',`
+# Derived domain based on the calling user domain and the program
+type $1_lockdev_t, domain, privlog;
+# Transition from the user domain to the derived domain.
+domain_auto_trans($1_t, lockdev_exec_t, $1_lockdev_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_lockdev_t;
+# Use capabilities.
+allow $1_lockdev_t self:capability setgid;
+allow $1_lockdev_t $1_t:process signull;
+
+allow $1_lockdev_t var_t:dir search;
+
+lock_domain($1_lockdev)
+
+r_dir_file($1_lockdev_t, lockfile)
+
+allow $1_lockdev_t device_t:dir search;
+allow $1_lockdev_t null_device_t:chr_file rw_file_perms;
+allow $1_lockdev_t { $1_tty_device_t $1_devpts_t }:chr_file rw_file_perms;
+dontaudit $1_lockdev_t root_t:dir search;
+
+uses_shlib($1_lockdev_t)
+allow $1_lockdev_t fs_t:filesystem getattr;
+
+')dnl end macro definition
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.19.1/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/mount_macros.te	2004-11-10 17:30:03.470882545 -0500
@@ -81,7 +81,7 @@
 # mount domain. 
 #
 define(`mount_loopback_privs',`
-type $1_$2_source_t, file_type, sysadmfile, homedirfile;
+type $1_$2_source_t, file_type, sysadmfile, $1_homedirfile;
 allow $1_t $1_$2_source_t:file create_file_perms;
 allow $1_t $1_$2_source_t:file { relabelto relabelfrom };
 allow $2_t $1_$2_source_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.1/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/mozilla_macros.te	2004-11-10 17:51:41.396455207 -0500
@@ -78,7 +78,7 @@
 #
 if (mozilla_readhome || mozilla_writehome) {
 r_dir_file($1_mozilla_t, $1_home_t)
-dontaudit $1_mozilla_t homedirfile:{ file dir } getattr;
+dontaudit $1_mozilla_t $1_homedirfile:{ file dir } getattr;
 file_type_auto_trans($1_mozilla_t, tmp_t, $1_tmp_t)
 } else {
 file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
@@ -112,6 +112,7 @@
 # Eliminate errors from scanning with the 
 #
 dontaudit $1_mozilla_t file_type:dir getattr;
+allow $1_mozilla_t self:sem create_sem_perms;
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.19.1/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.19.1/macros/program/mta_macros.te	2004-11-10 17:51:56.986696371 -0500
@@ -20,7 +20,7 @@
 undefine(`mail_domain')
 define(`mail_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_mail_t, domain, privlog, user_mail_domain;
+type $1_mail_t, domain, privlog, user_mail_domain, nscd_client_domain;
 
 ifdef(`sendmail.te', `
 sendmail_user_domain($1)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/newrole_macros.te policy-1.19.1/macros/program/newrole_macros.te
--- nsapolicy/macros/program/newrole_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/newrole_macros.te	2004-11-10 17:30:03.493879951 -0500
@@ -34,9 +34,6 @@
 allow $1_t bin_t:lnk_file read;
 allow $1_t shell_exec_t:file r_file_perms;
 
-can_ypbind($1_t)
-dontaudit $1_t krb5_conf_t:file write;
-allow $1_t krb5_conf_t:file { getattr read };
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 # Allow $1_t to transition to user domains.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.19.1/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/screen_macros.te	2004-11-10 17:30:03.494879838 -0500
@@ -22,7 +22,7 @@
 define(`screen_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, homedirfile, sysadmfile;
+type $1_home_screen_t, file_type, $1_homedirfile, sysadmfile;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.19.1/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.19.1/macros/program/spamassassin_macros.te	2004-11-10 17:30:03.495879725 -0500
@@ -80,7 +80,7 @@
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
 # The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile;
+type $1_home_spamassassin_t, file_type, $1_homedirfile, sysadmfile;
 create_dir_file($1_t, $1_home_spamassassin_t)
 allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
 allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.19.1/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/ssh_macros.te	2004-11-10 17:52:36.231268938 -0500
@@ -22,7 +22,7 @@
 define(`ssh_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_ssh_t, domain, privlog, nscd_client_domain;
-type $1_home_ssh_t, file_type, homedirfile, sysadmfile;
+type $1_home_ssh_t, file_type, $1_homedirfile, sysadmfile;
 
 ifdef(`automount.te', `
 allow $1_ssh_t autofs_t:dir { search getattr };
@@ -157,8 +157,7 @@
 allow $1_ssh_t xdm_xserver_t:shm r_shm_perms;
 allow $1_ssh_t xdm_xserver_t:fd use;
 allow $1_ssh_t xdm_xserver_tmpfs_t:file read;
-allow $1_ssh_t krb5_conf_t:file { getattr read };
-dontaudit $1_ssh_t krb5_conf_t:file write;
+can_kerberos($1_ssh_t)
 ')dnl end if xdm.te
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.19.1/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/su_macros.te	2004-11-10 17:30:03.495879725 -0500
@@ -87,8 +87,7 @@
 # Write to utmp.
 allow $1_su_t { var_t var_run_t }:dir search;
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
-dontaudit $1_su_t krb5_conf_t:file write;
-allow $1_su_t krb5_conf_t:file { getattr read };
+can_kerberos($1_su_t)
 ') dnl end su_restricted_domain
 
 define(`su_mini_domain', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.19.1/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/tvtime_macros.te	2004-11-10 17:30:03.496879613 -0500
@@ -19,7 +19,7 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, homedirfile, sysadmfile;
+type $1_home_tvtime_t, file_type, $1_homedirfile, sysadmfile;
 
 x_client_domain($1, tvtime)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.19.1/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/userhelper_macros.te	2004-11-10 17:30:03.496879613 -0500
@@ -123,7 +123,6 @@
 ')
 allow $1_userhelper_t sysctl_t:dir search;
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/vmware_macros.te policy-1.19.1/macros/program/vmware_macros.te
--- nsapolicy/macros/program/vmware_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/program/vmware_macros.te	2004-11-10 17:30:03.497879500 -0500
@@ -23,10 +23,10 @@
 role $1_r types $1_vmware_t;
 
 # The user file type is for files created when the user is running VMWare
-type $1_vmware_file_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_file_t, $1_homedirfile, file_type, sysadmfile;
 
 # The user file type for the VMWare configuration files
-type $1_vmware_conf_t, homedirfile, file_type, sysadmfile;
+type $1_vmware_conf_t, $1_homedirfile, file_type, sysadmfile;
 
 # for compatibility with older policy versions
 typealias $1_vmware_t alias vmware_$1_t;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.19.1/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.19.1/macros/program/xauth_macros.te	2004-11-10 17:30:03.497879500 -0500
@@ -20,7 +20,7 @@
 define(`xauth_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, homedirfile, sysadmfile;
+type $1_home_xauth_t, file_type, $1_homedirfile, sysadmfile;
 
 ifdef(`slocate.te', `
 allow $1_locate_t $1_home_xauth_t:file { getattr read };
@@ -48,6 +48,7 @@
 ')
 
 allow $1_xauth_t privfd:fd use;
+allow $1_xauth_t ptmx_t:chr_file { read write };
 
 # allow ps to show xauth
 allow $1_t $1_xauth_t:dir { search getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.19.1/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.19.1/macros/program/x_client_macros.te	2004-11-10 17:30:03.498879387 -0500
@@ -25,9 +25,9 @@
 # Derived domain based on the calling user domain and the program.
 type $1_$2_t, domain $3;
 # Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, homedirfile, sysadmfile, tmpfile;
+type $1_$2_rw_t, file_type, $1_homedirfile, sysadmfile, tmpfile;
 # Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, homedirfile, sysadmfile;
+type $1_$2_ro_t, file_type, $1_homedirfile, sysadmfile;
 
 # Transition from the user domain to the derived domain.
 ifelse($2, games, `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ypbind_macros.te policy-1.19.1/macros/program/ypbind_macros.te
--- nsapolicy/macros/program/ypbind_macros.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.19.1/macros/program/ypbind_macros.te	2004-11-10 17:32:37.064554655 -0500
@@ -4,12 +4,15 @@
 can_network($1)
 r_dir_file($1,var_yp_t)
 allow $1 { reserved_port_t port_t }:{ tcp_socket udp_socket } name_bind;
+dontaudit $1 self:capability net_bind_service;
 ')
 
 define(`can_ypbind', `
 ifdef(`ypbind.te', `
 if (allow_ypbind) {
 uncond_can_ypbind($1)
+} else {
+dontaudit $1 var_yp_t:dir search;
 }
 ') dnl ypbind.te
 ') dnl can_ypbind
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.19.1/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/macros/user_macros.te	2004-11-10 17:30:03.499879274 -0500
@@ -56,8 +56,9 @@
 # user domains.
 ifdef(`apache.te', `apache_domain($1)')
 ifdef(`slocate.te', `locate_domain($1)')
+ifdef(`lockdev.te', `lockdev_domain($1)')
 
-allow $1_t krb5_conf_t:file { getattr read };
+can_kerberos($1_t)
 # allow port_t name binding for UDP because it is not very usable otherwise
 allow $1_t port_t:udp_socket name_bind;
 
@@ -123,9 +124,14 @@
 undefine(`full_user_role')
 define(`full_user_role', `
 
+# certain apps ask for this priv kdesu, fetchmail
+# dac controls force the user to only lower priority
+allow $1_t self:process setrlimit;
+
 # user_t/$1_t is an unprivileged users domain.
 type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, nscd_client_domain, privfd;
 
+attribute $1_homedirfile;
 # Grant read/search permissions to some of /proc.
 allow $1_t proc_t:dir r_dir_perms;
 allow $1_t proc_t:{ file lnk_file } r_file_perms;
@@ -142,11 +148,6 @@
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
@@ -224,15 +225,17 @@
 allow $1_mount_t iso9660_t:filesystem relabelfrom;
 allow $1_mount_t removable_t:filesystem { mount relabelto };
 allow $1_mount_t removable_t:dir mounton;
+ifdef(`xdm.te', `
 allow $1_mount_t xdm_t:fd use;
 allow $1_mount_t xdm_t:fifo_file write;
 ')
+')
 
 #
 # Rules used to associate a homedir as a mountpoint
 #
 allow $1_home_t $1_home_t:filesystem associate;
-allow homedirfile $1_home_t:filesystem associate;
+allow $1_homedirfile $1_home_t:filesystem associate;
 ')
 
 undefine(`in_user_role')
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.19.1/net_contexts
--- nsapolicy/net_contexts	2004-11-09 13:35:11.000000000 -0500
+++ policy-1.19.1/net_contexts	2004-11-10 17:30:03.500879161 -0500
@@ -113,7 +113,6 @@
 portcon tcp 631 system_u:object_r:ipp_port_t
 portcon udp 631 system_u:object_r:ipp_port_t
 ')
-ifdef(`kerberos.te', `
 portcon tcp 88 system_u:object_r:kerberos_port_t
 portcon udp 88 system_u:object_r:kerberos_port_t
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
@@ -121,7 +120,6 @@
 portcon udp 750 system_u:object_r:kerberos_port_t
 portcon tcp 4444 system_u:object_r:kerberos_master_port_t
 portcon udp 4444 system_u:object_r:kerberos_master_port_t
-')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
 ifdef(`rsync.te', `
 portcon tcp 873 system_u:object_r:rsync_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.19.1/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/targeted/domains/unconfined.te	2004-11-10 17:30:03.501879048 -0500
@@ -42,4 +42,7 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Allow system to run with NIS
+bool allow_ypbind false;
+
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.1/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.1/tunables/distro.tun	2004-11-10 17:30:03.501879048 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.1/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.1/tunables/tunable.tun	2004-11-10 17:30:03.502878936 -0500
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

--------------070506050508080702070506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
