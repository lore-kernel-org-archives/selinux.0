Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9GVZIi013650
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 11:31:35 -0500 (EST)
Message-ID: <41B87DDD.3060204@redhat.com>
Date: Thu, 09 Dec 2004 11:31:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux ML <selinux@tycho.nsa.gov>
Subject: Some more fixes
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050704090005030903040000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050704090005030903040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Many fixes for initrc required by turning off unlimitedRC

Fixes for ipsec

Fixes for ifdefs of targeted policy

Added new booleans to replace tunables

allow_user_mysql_connect &  allow_user_postgresql_connect &  pppd_for_user

Fixed some can_network_* calls.

Added support for winbindd

Added a portmap_helper domain for pmap_dump and pmap_set.  Not sure if I 
like this?  Looking for comments.

Remove user_can_mount tunable



--------------050704090005030903040000
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.19.12/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-12-09 10:26:08.583499181 -0500
+++ policy-1.19.12/domains/program/initrc.te	2004-12-09 11:03:11.335553650 -0500
@@ -12,7 +12,7 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer;
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
 ifdef(`sendmail.te', `
 allow system_mail_t initrc_t:fd use;
 allow system_mail_t initrc_t:fifo_file write;
@@ -20,6 +20,7 @@
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);
+can_network(initrc_t)
 can_ypbind(initrc_t)
 type initrc_exec_t, file_type, sysadmfile, exec_type;
 
@@ -217,6 +218,9 @@
 allow initrc_t tmpfs_t:chr_file rw_file_perms;
 allow initrc_t tmpfs_t:dir r_dir_perms;
 
+# Allow initrc domain to set the enforcing flag.
+can_setenforce(initrc_t)
+
 #
 # readahead asks for these
 #
@@ -362,3 +366,4 @@
 # Gentoo integrated run_init+open_init_pty-runscript:
 domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
 ')
+allow initrc_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.12/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2004-12-09 10:26:08.603496932 -0500
+++ policy-1.19.12/domains/program/ldconfig.te	2004-12-09 11:05:48.845841826 -0500
@@ -44,3 +44,4 @@
 ')
 
 allow ldconfig_t proc_t:file read;
+dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.19.12/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-12-09 10:26:08.614495695 -0500
+++ policy-1.19.12/domains/program/login.te	2004-12-09 11:03:11.336553537 -0500
@@ -183,6 +183,10 @@
 # Allow setting of attributes on power management devices.
 allow local_login_t power_device_t:chr_file { getattr setattr };
 
+ifdef(`hide_broken_symptoms', `
+dontaudit local_login_t init_t:fd use;
+')
+
 #################################
 #
 # Rules for the remote_login_t domain.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.12/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-12-03 14:42:06.000000000 -0500
+++ policy-1.19.12/domains/program/unused/apache.te	2004-12-09 11:09:45.666211688 -0500
@@ -297,8 +297,7 @@
 # This is a bug but it still exists in FC2
 #
 type httpd_runtime_t, file_type, sysadmfile;
-file_type_auto_trans(httpd_t, httpd_log_t, httpd_runtime_t, file)
-allow httpd_sys_script_t httpd_runtime_t:file { getattr append };
+allow { httpd_t httpd_sys_script_t } httpd_runtime_t:file { getattr append };
 ') dnl distro_redhat
 #
 # Customer reported the following
@@ -308,11 +307,14 @@
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
 ')
 
-#
-# The following is needed to make squirrelmail work
 type httpd_squirrelmail_t, file_type, sysadmfile;
 create_dir_file(httpd_t, httpd_squirrelmail_t)
 allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
+# File Type of squirrelmail attachments
+type squirrelmail_spool_t, file_type, sysadmfile;
+allow httpd_t var_spool_t:dir { getattr search };
+create_dir_file(httpd_t, squirrelmail_spool_t)
+
 ifdef(`mta.te', `
 dontaudit system_mail_t httpd_log_t:file { append getattr };
 allow system_mail_t httpd_squirrelmail_t:file { append read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.12/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-12-03 14:42:07.000000000 -0500
+++ policy-1.19.12/domains/program/unused/cups.te	2004-12-09 11:03:11.338553312 -0500
@@ -149,6 +149,7 @@
 allow ptal_t self:fifo_file rw_file_perms;
 allow ptal_t device_t:dir read;
 allow ptal_t printer_device_t:chr_file { ioctl read write };
+allow initrc_t printer_device_t:chr_file getattr;
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
 r_dir_file(ptal_t, usbfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.19.12/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.12/domains/program/unused/dhcpc.te	2004-12-09 11:03:11.359550951 -0500
@@ -136,3 +136,4 @@
 allow initrc_t dhcpc_state_t:file { getattr read };
 dontaudit dhcpc_t var_lock_t:dir search;
 dontaudit dhcpc_t selinux_config_t:dir search;
+allow dhcpc_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.19.12/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/ipsec.te	2004-12-09 11:03:11.360550839 -0500
@@ -51,7 +51,7 @@
 allow ipsec_mgmt_t ipsec_conf_file_t:file { getattr read ioctl };
 rw_dir_create_file(ipsec_mgmt_t, ipsec_key_file_t)
 
-allow ipsec_t self:key_socket { create write read };
+allow ipsec_t self:key_socket { create write read setopt };
 
 # for lsof
 allow sysadm_t ipsec_t:key_socket getattr;
@@ -225,3 +225,5 @@
 allow ipsec_mgmt_t self:{ tcp_socket udp_socket } create_socket_perms;
 allow ipsec_mgmt_t sysctl_net_t:file { getattr read };
 rw_dir_create_file(ipsec_mgmt_t, ipsec_var_run_t)
+rw_dir_create_file(initrc_t, ipsec_var_run_t)
+allow initrc_t ipsec_conf_file_t:file { getattr read ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.19.12/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/kerberos.te	2004-12-09 11:03:11.361550726 -0500
@@ -89,4 +89,4 @@
 # Allow user programs to talk to KDC
 allow krb5kdc_t userdomain:udp_socket recvfrom;
 allow userdomain krb5kdc_t:udp_socket recvfrom;
-
+allow initrc_t krb5_conf_t:file ioctl;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.19.12/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-12-09 10:26:09.150435429 -0500
+++ policy-1.19.12/domains/program/unused/kudzu.te	2004-12-09 11:03:11.362550614 -0500
@@ -16,6 +16,7 @@
 
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
+allow kudzu_t etc_t:file { getattr read };
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
 allow kudzu_t modules_conf_t:file { getattr read };
 allow kudzu_t modules_object_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.19.12/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.12/domains/program/unused/mailman.te	2004-12-09 11:03:11.362550614 -0500
@@ -15,7 +15,7 @@
 role system_r types mailman_$1_t;
 file_type_auto_trans(mailman_$1_t, var_log_t, mailman_log_t, file)
 allow mailman_$1_t mailman_log_t:dir rw_dir_perms;
-rw_dir_create_file(mailman_$1_t, mailman_data_t)
+create_dir_file(mailman_$1_t, mailman_data_t)
 uses_shlib(mailman_$1_t)
 can_exec_any(mailman_$1_t)
 allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
@@ -96,6 +96,7 @@
 system_crond_entry(mailman_queue_exec_t, mailman_queue_t)
 allow mailman_queue_t devtty_t:chr_file { read write };
 allow mailman_queue_t self:process { fork signal sigchld };
+allow mailman_queue_t self:netlink_route_socket r_netlink_socket_perms;
 
 # so MTA can access /var/lib/mailman/mail/wrapper
 allow mta_delivery_agent var_lib_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.19.12/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.12/domains/program/unused/mta.te	2004-12-09 11:03:11.363550501 -0500
@@ -20,7 +20,7 @@
 # "mail user@domain"
 mail_domain(system)
 
-ifelse(`targeted-policy', `', `
+ifdef(`targeted_policy', `', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
 # then does system things with it.
@@ -75,3 +75,4 @@
 allow system_mail_t { var_t var_spool_t }:dir getattr;
 create_dir_file( system_mail_t, mqueue_spool_t)
 ')
+allow system_mail_t etc_runtime_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.19.12/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/mysqld.te	2004-12-09 11:03:11.364550389 -0500
@@ -35,7 +35,7 @@
 
 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
 
-allow mysqld_t self:capability { dac_override setgid setuid };
+allow mysqld_t self:capability { dac_override setgid setuid net_bind_service };
 allow mysqld_t self:process getsched;
 
 allow mysqld_t proc_t:file { getattr read };
@@ -70,11 +70,6 @@
 can_unix_connect(logrotate_t, mysqld_t)
 ')
 
-ifdef(`user_db_connect', `
-allow userdomain mysqld_var_run_t:dir search;
-allow userdomain mysqld_var_run_t:sock_file write;
-')
-
 ifdef(`daemontools.te', `
 domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
 allow svc_start_t mysqld_t:process signal;
@@ -87,3 +82,12 @@
 # because Fedora has the sock_file in the database directory
 file_type_auto_trans(mysqld_t, mysqld_db_t, mysqld_var_run_t, sock_file)
 ')
+ifdef(`targeted_policy', `', `
+bool allow_user_mysql_connect false;
+
+if (allow_user_mysql_connect) {
+allow userdomain mysqld_var_run_t:dir search;
+allow userdomain mysqld_var_run_t:sock_file write;
+}
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.19.12/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/nscd.te	2004-12-09 11:03:11.364550389 -0500
@@ -67,5 +67,4 @@
 allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
-
-
+allow nscd_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.19.12/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/portmap.te	2004-12-09 11:03:11.365550277 -0500
@@ -13,7 +13,7 @@
 #
 daemon_domain(portmap, `, nscd_client_domain')
 
-can_network_server(portmap_t)
+can_network(portmap_t)
 can_ypbind(portmap_t)
 allow portmap_t self:unix_dgram_socket create_socket_perms;
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
@@ -54,3 +54,14 @@
 allow portmap_t self:capability { net_bind_service setuid setgid };
 allow portmap_t self:netlink_route_socket r_netlink_socket_perms;
 
+application_domain(portmap_helper)
+domain_auto_trans(initrc_t, portmap_helper_exec_t, portmap_helper_t)
+dontaudit portmap_helper_t self:capability { net_admin };
+allow portmap_helper_t { var_run_t initrc_var_run_t } :file rw_file_perms;
+allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
+can_network(portmap_helper_t)
+can_ypbind(portmap_helper_t)
+dontaudit portmap_helper_t admin_tty_type:chr_file rw_file_perms;
+allow portmap_helper_t etc_t:file { getattr read };
+dontaudit portmap_helper_t userdomain:fd use;
+allow portmap_helper_t reserved_port_t:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.12/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/postgresql.te	2004-12-09 11:03:11.366550164 -0500
@@ -60,13 +60,16 @@
 
 allow postgresql_t self:shm create_shm_perms;
 
-ifdef(`user_db_connect', `
+ifdef(`targeted_policy', `', `
+bool allow_user_postgresql_connect false;
+
+if (allow_user_postgresql_connect) {
 # allow any user domain to connect to the database server
 can_tcp_connect(userdomain, postgresql_t)
 allow userdomain postgresql_t:unix_stream_socket connectto;
 allow userdomain postgresql_var_run_t:sock_file write;
+}
 ')
-
 ifdef(`consoletype.te', `
 can_exec(postgresql_t, consoletype_exec_t)
 ')
@@ -85,8 +88,7 @@
 
 # because postgresql start scripts are broken and put the pid file in the DB
 # directory
-allow initrc_t postgresql_db_t:dir { write remove_name };
-allow initrc_t postgresql_db_t:file rw_file_perms;
+rw_dir_file(initrc_t, postgresql_db_t)
 
 # read config files
 allow postgresql_t { etc_t etc_runtime_t }:{ file lnk_file } { read getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.19.12/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/pppd.te	2004-12-09 11:03:11.366550164 -0500
@@ -12,6 +12,8 @@
 # pppd_exec_t is the type of the pppd executable.
 # pppd_secret_t is the type of the pap and chap password files
 #
+bool pppd_for_user false;
+
 daemon_domain(pppd, `, privmail')
 type pppd_secret_t, file_type, sysadmfile;
 
@@ -80,13 +82,12 @@
 # for ~/.ppprc - if it actually exists then you need some policy to read it
 allow pppd_t { sysadm_home_dir_t home_root_t user_home_dir_type }:dir search;
 
-ifdef(`pppd_for_user', `
-# Run pppd in pppd_t by default for user
-domain_auto_trans(userdomain, pppd_exec_t, pppd_t)
 in_user_role(pppd_t)
-role sysadm_r types pppd_t;
-allow userdomain pppd_t:process signal;
-')
+if (pppd_for_user)  {
+# Run pppd in pppd_t by default for user
+domain_auto_trans(unpriv_userdomain, pppd_exec_t, pppd_t)
+allow unpriv_userdomain pppd_t:process signal;
+}
 
 # for pppoe
 can_create_pty(pppd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.19.12/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/rhgb.te	2004-12-09 11:03:11.367550052 -0500
@@ -39,7 +39,7 @@
 allow rhgb_t self:capability { sys_admin sys_tty_config };
 dontaudit rhgb_t var_run_t:dir search;
 
-can_network_server(rhgb_t)
+can_network_client(rhgb_t)
 can_ypbind(rhgb_t)
 
 # for fonts
@@ -91,3 +91,5 @@
 ifdef(`fsadm.te', `
 dontaudit fsadm_t ramfs_t:fifo_file write;
 ')
+allow rhgb_t xdm_xserver_tmp_t:file { getattr read };
+dontaudit rhgb_t default_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.19.12/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.12/domains/program/unused/samba.te	2004-12-09 11:03:11.368549939 -0500
@@ -115,3 +115,5 @@
 ifdef(`cups.te', `
 allow smbd_t cupsd_rw_etc_t:file { getattr read };
 ')
+# Needed for winbindd
+allow smbd_t { samba_var_t smbd_var_run_t }:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.19.12/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.12/domains/program/unused/slapd.te	2004-12-09 11:03:11.368549939 -0500
@@ -59,3 +59,4 @@
 
 allow slapd_t usr_t:file { read getattr };
 allow slapd_t urandom_device_t:chr_file { getattr read };
+allow slapd_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.19.12/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.19.12/domains/program/unused/squid.te	2004-12-09 11:03:11.369549827 -0500
@@ -21,6 +21,7 @@
 allow squid_t squid_conf_t:lnk_file read;
 
 logdir_domain(squid)
+rw_dir_create_file(initrc_t, squid_log_t)
 
 allow squid_t usr_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.19.12/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.12/domains/program/unused/vpnc.te	2004-12-09 11:03:11.369549827 -0500
@@ -38,3 +38,4 @@
 allow vpnc_t sbin_t:dir search;
 allow vpnc_t bin_t:dir search;
 allow vpnc_t bin_t:lnk_file read;
+r_dir_file(vpnc_t, proc_net_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.19.12/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.12/domains/program/unused/ypbind.te	2004-12-09 11:03:11.370549714 -0500
@@ -39,3 +39,4 @@
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow ypbind_t reserved_port_t:tcp_socket name_bind;
 allow ypbind_t reserved_port_t:udp_socket name_bind;
+dontaudit ypbind_t reserved_port_type:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.19.12/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2004-12-09 10:26:09.571388094 -0500
+++ policy-1.19.12/file_contexts/program/apache.fc	2004-12-09 11:13:56.287029708 -0500
@@ -29,16 +29,17 @@
 /var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
 /var/lib/php/session(/.*)?	system_u:object_r:httpd_var_run_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
-/usr/lib/apache-ssl/.+ --	system_u:object_r:httpd_exec_t
+/usr/lib/apache-ssl/.+	 --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
 /var/run/apache-ssl(2)?\.pid.* -- system_u:object_r:httpd_var_run_t
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
 ifdef(`distro_suse', `
 # suse puts shell scripts there :-(
-/usr/share/apache2/[^/]*	--	system_u:object_r:bin_t
+/usr/share/apache2/[^/]*       --      system_u:object_r:bin_t
 ')
 /var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_squirrelmail_t
+/var/spool/squirrelmail(/.*)?	system_u:object_r:squirrelmail_spool_t
 /usr/bin/htsslpass --	system_u:object_r:httpd_helper_exec_t
 /usr/share/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/lib/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ipsec.fc policy-1.19.12/file_contexts/program/ipsec.fc
--- nsapolicy/file_contexts/program/ipsec.fc	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.12/file_contexts/program/ipsec.fc	2004-12-09 11:03:11.371549602 -0500
@@ -3,6 +3,7 @@
 /etc/ipsec\.secrets	--	system_u:object_r:ipsec_key_file_t
 /etc/ipsec\.conf	--	system_u:object_r:ipsec_conf_file_t
 /etc/ipsec\.d(/.*)?		system_u:object_r:ipsec_key_file_t
+/etc/ipsec\.d/examples(/.*)?		system_u:object_r:etc_t
 /usr/lib(64)?/ipsec/.*	--	system_u:object_r:sbin_t
 /usr/lib(64)?/ipsec/_plutoload -- 	system_u:object_r:ipsec_mgmt_exec_t
 /usr/lib(64)?/ipsec/_plutorun  --	system_u:object_r:ipsec_mgmt_exec_t
@@ -24,6 +25,7 @@
 # Kame
 /usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
 /usr/sbin/setkey	--	system_u:object_r:ipsec_exec_t
+/sbin/setkey		--	system_u:object_r:ipsec_exec_t
 /etc/racoon(/.*)?		system_u:object_r:ipsec_conf_file_t
 /etc/racoon/certs(/.*)?	system_u:object_r:ipsec_key_file_t
 /etc/racoon/psk\.txt	--	system_u:object_r:ipsec_key_file_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/portmap.fc policy-1.19.12/file_contexts/program/portmap.fc
--- nsapolicy/file_contexts/program/portmap.fc	2003-11-26 13:01:08.000000000 -0500
+++ policy-1.19.12/file_contexts/program/portmap.fc	2004-12-09 11:03:11.371549602 -0500
@@ -1,3 +1,4 @@
 # portmap
 /sbin/portmap		--	system_u:object_r:portmap_exec_t
-/sbin/pmap_dump		--	system_u:object_r:portmap_exec_t
+/usr/sbin/pmap_dump	--	system_u:object_r:portmap_helper_exec_t
+/usr/sbin/pmap_set	--	system_u:object_r:portmap_helper_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/samba.fc policy-1.19.12/file_contexts/program/samba.fc
--- nsapolicy/file_contexts/program/samba.fc	2004-06-16 13:33:37.000000000 -0400
+++ policy-1.19.12/file_contexts/program/samba.fc	2004-12-09 11:03:11.372549490 -0500
@@ -19,3 +19,5 @@
 /var/run/samba/smbd\.pid --	system_u:object_r:smbd_var_run_t
 /var/run/samba/nmbd\.pid --	system_u:object_r:nmbd_var_run_t
 /var/spool/samba(/.*)?		system_u:object_r:samba_var_t
+/usr/sbin/winbindd		--	system_u:object_r:smbd_exec_t
+/var/run/winbindd(/.*)?		system_u:object_r:smbd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.12/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-12-03 14:42:07.000000000 -0500
+++ policy-1.19.12/file_contexts/types.fc	2004-12-09 11:03:11.373549377 -0500
@@ -278,7 +278,7 @@
 /etc/shadow.*		--	system_u:object_r:shadow_t
 /etc/gshadow.*		--	system_u:object_r:shadow_t
 /var/db/shadow.*	--	system_u:object_r:shadow_t
-/etc/blkid\.tab		--	system_u:object_r:etc_runtime_t
+/etc/blkid\.tab.*	--	system_u:object_r:etc_runtime_t
 /etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
 /etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
 /etc/ioctl\.save	--	system_u:object_r:etc_runtime_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.19.12/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-11-29 10:24:17.000000000 -0500
+++ policy-1.19.12/macros/program/apache_macros.te	2004-12-09 11:03:11.375549152 -0500
@@ -41,9 +41,9 @@
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
 allow httpd_$1_script_t self:unix_stream_socket create_socket_perms;
-allow httpd_$1_script_t proc_t:file { getattr read };
 allow httpd_$1_script_t httpd_t:unix_stream_socket { read write };
 
+allow httpd_$1_script_t { self proc_t }:file { getattr read };
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
 allow httpd_$1_script_t { self proc_t }:lnk_file read;
 
@@ -92,6 +92,7 @@
 #########################################################################
 can_exec_any(httpd_$1_script_t)
 allow httpd_$1_script_t etc_t:file { getattr read };
+dontaudit httpd_$1_script_t selinux_config_t:dir search;
 
 ############################################################################
 # Allow the script process to search the cgi directory, and users directory
@@ -183,4 +184,7 @@
 #########################################
 allow httpd_$1_script_t httpd_log_t:file { getattr append };
 
+# apache should set close-on-exec
+dontaudit  httpd_$1_script_t httpd_t:unix_stream_socket { read write };
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.19.12/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.19.12/macros/program/inetd_macros.te	2004-12-09 11:03:11.376549040 -0500
@@ -61,4 +61,5 @@
 allow inetd_t $1_port_t:udp_socket name_bind;
 allow $1_t inetd_t:udp_socket rw_socket_perms;
 ')
+r_dir_file($1_t, proc_net_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.19.12/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.19.12/macros/program/mta_macros.te	2004-12-09 11:03:11.378548815 -0500
@@ -34,6 +34,7 @@
 
 uses_shlib($1_mail_t)
 can_network_client_tcp($1_mail_t)
+can_resolve($1_mail_t)
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.19.12/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-12-09 10:26:10.334302305 -0500
+++ policy-1.19.12/macros/user_macros.te	2004-12-09 11:03:11.384548140 -0500
@@ -134,6 +140,7 @@
 attribute $1_file_type;
 # Grant read/search permissions to some of /proc.
 r_dir_file($1_t, proc_t)
+r_dir_file($1_t, proc_net_t)
 
 base_file_read_access($1_t)
 
@@ -215,27 +222,11 @@
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
-allow $1_mount_t xdm_t:fd use;
-allow $1_mount_t xdm_t:fifo_file { read write };
-')
-')
 
 #
 # Rules used to associate a homedir as a mountpoint
 #
-allow $1_home_t self:filesystem associate;
+allow $1_home_t $1_home_t:filesystem associate;
 allow $1_file_type $1_home_t:filesystem associate;
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.19.12/net_contexts
--- nsapolicy/net_contexts	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.12/net_contexts	2004-12-09 11:03:11.385548028 -0500
@@ -115,6 +115,8 @@
 ')
 portcon tcp 88 system_u:object_r:kerberos_port_t
 portcon udp 88 system_u:object_r:kerberos_port_t
+portcon tcp 464 system_u:object_r:kerberos_admin_port_t
+portcon udp 464 system_u:object_r:kerberos_admin_port_t
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
 portcon tcp 750 system_u:object_r:kerberos_port_t
 portcon udp 750 system_u:object_r:kerberos_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.12/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.12/tunables/distro.tun	2004-12-09 11:03:11.385548028 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.12/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.12/tunables/tunable.tun	2004-12-09 11:17:03.670958633 -0500
@@ -1,29 +1,31 @@
-# Allow users to execute the mount command
-dnl define(`user_can_mount')
-
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
 dnl define(`unlimitedInetd')
 
+# for ndc_t to be used for restart shell scripts
+dnl define(`ndc_shell_script')
+
+# To allow staff and user to share the same homedirectory file labels
+dnl define(`single_user_file_type')

--------------050704090005030903040000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
