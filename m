Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIEWiIi013379
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 09:32:44 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIEWinn025998
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:32:47 GMT
Message-ID: <419CB27E.6080800@redhat.com>
Date: Thu, 18 Nov 2004 09:32:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patches without the can_network patch.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com> <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080704090107060105060305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080704090107060105060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Latest policy-small patch.   Many changes to make targeted policy work
better.

Lots of changes to apache policy.

Check out the changes to core_macros for create/rw socket_perms.  Maybe 
more acceptable. :^)

Many other minor changes.



--------------080704090107060105060305
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.2/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/ldconfig.te	2004-11-18 08:48:23.918139878 -0500
@@ -8,7 +8,7 @@
 #
 # Rules for the ldconfig_t domain.
 #
-type ldconfig_t, domain, privlog;
+type ldconfig_t, domain, privlog, etc_writer;
 type ldconfig_exec_t, file_type, sysadmfile, exec_type;
 
 role sysadm_r types ldconfig_t;
@@ -26,7 +26,7 @@
 allow ldconfig_t lib_t:lnk_file create_lnk_perms;
 
 allow ldconfig_t userdomain:fd use;
-allow ldconfig_t etc_t:file { getattr read };
+allow ldconfig_t etc_t:file { getattr read unlink };
 allow ldconfig_t etc_t:lnk_file read;
 
 allow ldconfig_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.19.2/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.2/domains/program/login.te	2004-11-18 08:48:23.919139766 -0500
@@ -182,6 +182,9 @@
 # Allow setting of attributes on sound devices.
 allow local_login_t sound_device_t:chr_file { getattr setattr };
 
+# Allow setting of attributes on power management devices.
+allow local_login_t power_device_t:chr_file { getattr setattr };
+
 #################################
 #
 # Rules for the remote_login_t domain.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.19.2/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/acct.te	2004-11-18 08:48:23.919139766 -0500
@@ -63,8 +63,7 @@
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
-allow logrotate_t acct_data_t:dir search;
-allow logrotate_t acct_data_t:file { create_file_perms };
+rw_dir_create_file(logrotate_t, acct_data_t)
 can_exec(logrotate_t, acct_data_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.2/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.2/domains/program/unused/apache.te	2004-11-18 08:50:10.113157831 -0500
@@ -32,6 +32,9 @@
 # Run SSI execs in system CGI script domain.
 bool httpd_ssi_exec false;
 
+# Allow http daemon to communicate with the TTY
+bool httpd_tty_comm false;
+
 #########################################################
 # Apache types
 #########################################################
@@ -239,10 +242,12 @@
 # connect to mysql
 ifdef(`mysqld.te', `
 can_unix_connect(httpd_php_t, mysqld_t)
+can_unix_connect(httpd_t, mysqld_t)
 allow httpd_php_t mysqld_var_run_t:dir search;
 allow httpd_php_t mysqld_var_run_t:sock_file write;
 allow httpd_t mysqld_db_t:dir search;
 allow httpd_t mysqld_db_t:sock_file rw_file_perms;
+allow httpd_t mysqld_var_run_t:sock_file rw_file_perms;
 ')
 allow httpd_t bin_t:dir search;
 allow httpd_t sbin_t:dir search;
@@ -297,6 +302,7 @@
 #
 type httpd_runtime_t, file_type, sysadmfile;
 file_type_auto_trans(httpd_t, httpd_log_t, httpd_runtime_t, file)
+allow httpd_sys_script_t httpd_runtime_t:file { getattr append };
 ') dnl distro_redhat
 #
 # Customer reported the following
@@ -306,9 +312,28 @@
 dontaudit httpd_t snmpd_var_lib_t:file { getattr write read };
 ')
 
-# Running squirrelmail requires this permissions
+#
+# The following is needed to make squirrelmail work
+type httpd_squirrelmail_t, file_type, sysadmfile;
+create_dir_file(httpd_t, httpd_squirrelmail_t)
+allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
 ifdef(`mta.te', `
-allow system_mail_t httpd_log_t:file { append getattr };
-allow system_mail_t httpd_sys_script_rw_t:file { append read };
-allow system_mail_t httpd_t:tcp_socket { read write };
+dontaudit system_mail_t httpd_log_t:file { append getattr };
+allow system_mail_t httpd_squirrelmail_t:file { append read };
+dontaudit system_mail_t httpd_t:tcp_socket { read write };
+')
+
+application_domain(httpd_helper)
+role system_r types httpd_helper_t;
+domain_auto_trans(httpd_t, httpd_helper_exec_t, httpd_helper_t)
+
+allow httpd_helper_t devpts_t:dir { search };
+allow httpd_helper_t devtty_t:chr_file rw_file_perms;
+allow httpd_helper_t httpd_config_t:file { getattr read };
+allow httpd_helper_t httpd_log_t:file { append };
+if (httpd_tty_comm) {
+ifdef(`targeted_policy', `
+allow { httpd_helper_t httpd_t } devpts_t:chr_file { read write };
 ')
+allow { httpd_t httpd_helper_t } admin_tty_type:chr_file { read write };
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.19.2/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/apmd.te	2004-11-18 08:48:23.920139653 -0500
@@ -114,7 +114,10 @@
 allow consoletype_t apmd_t:fifo_file write;
 ')
 ifdef(`mount.te', `allow mount_t apmd_t:fd use;')
-ifdef(`crond.te', `domain_auto_trans(apmd_t, anacron_exec_t, system_crond_t)')
+ifdef(`crond.te', `
+domain_auto_trans(apmd_t, anacron_exec_t, system_crond_t)
+allow apmd_t crond_t:fifo_file { getattr read write ioctl };
+')
 
 ifdef(`mta.te', `
 domain_auto_trans(apmd_t, sendmail_exec_t, system_mail_t) 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.19.2/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/consoletype.te	2004-11-18 08:48:23.921139540 -0500
@@ -59,5 +59,6 @@
 ')
 dontaudit consoletype_t proc_t:file read;
 dontaudit consoletype_t root_t:file read;
-allow consoletype_t crond_t:fifo_file read;
+allow consoletype_t crond_t:fifo_file { read getattr ioctl };
+allow consoletype_t system_crond_t:fd use;
 allow consoletype_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.2/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.2/domains/program/unused/cups.te	2004-11-18 08:51:22.563983161 -0500
@@ -59,7 +60,6 @@
 
 allow cupsd_t { etc_t etc_runtime_t }:file { getattr read ioctl };
 can_exec(cupsd_t, initrc_exec_t)
-can_exec(cupsd_t, hostname_exec_t)
 allow cupsd_t proc_t:file r_file_perms;
 allow cupsd_t proc_t:dir r_dir_perms;
 allow cupsd_t self:file { getattr read };
@@ -185,7 +185,7 @@
 allow cupsd_config_t cupsd_var_run_t:file { getattr read };
 allow cupsd_config_t cupsd_t:process { signal };
 allow cupsd_config_t cupsd_t:{ file lnk_file } { getattr read };
-allow cupsd_config_t cupsd_t:dir search;
+r_dir_file(cupsd_config_t, cupsd_t)
 
 allow cupsd_config_t self:capability chown;
 
@@ -212,8 +212,17 @@
 ')
 
 can_exec(cupsd_config_t, { bin_t sbin_t shell_exec_t })
+ifdef(`hostname.te', `
+can_exec(cupsd_t, hostname_exec_t)
+can_exec(cupsd_config_t, hostname_exec_t)
+')
 allow cupsd_config_t { bin_t sbin_t }:dir { search getattr };
 allow cupsd_config_t { bin_t sbin_t }:lnk_file read;
+# killall causes the following
+dontaudit cupsd_config_t domain:dir { getattr search };
+dontaudit cupsd_config_t selinux_config_t:dir search;
+
+can_exec(cupsd_config_t, cupsd_config_exec_t) 
 
 allow cupsd_config_t usr_t:file { getattr read };
 allow cupsd_config_t var_lib_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.19.2/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/cyrus.te	2004-11-18 08:51:47.260196672 -0500
@@ -45,3 +45,4 @@
 allow system_crond_t cyrus_var_lib_t:file create_file_perms;
 allow system_crond_su_t cyrus_var_lib_t:dir search;
 ')
+allow cyrus_t mail_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.19.2/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.19.2/domains/program/unused/dhcpd.te	2004-11-18 08:53:24.057275000 -0500
@@ -33,6 +33,7 @@
 can_ypbind(dhcpd_t)
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
+allow dhcpd_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow dhcpd_t var_lib_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.19.2/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/domains/program/unused/ftpd.te	2004-11-18 08:54:09.695125653 -0500
@@ -31,11 +31,13 @@
 
 ifdef(`crond.te', `
 system_crond_entry(ftpd_exec_t, ftpd_t)
+allow system_crond_t xferlog_t:file r_file_perms;
 can_exec(ftpd_t, { sbin_t shell_exec_t })
 allow ftpd_t usr_t:file { getattr read };
 ')
 
 allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
+allow ftpd_t port_t:tcp_socket name_bind;
 
 # Allow ftpd to run directly without inetd.
 bool ftpd_is_daemon false;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.19.2/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.2/domains/program/unused/innd.te	2004-11-18 08:54:50.625507454 -0500
@@ -64,6 +64,9 @@
 
 ifdef(`crond.te', `
 system_crond_entry(innd_exec_t, innd_t)
+allow system_crond_t innd_etc_t:file { getattr read };
+rw_dir_create_file(system_crond_t, innd_log_t)
+rw_dir_create_file(system_crond_t, innd_var_run_t)
 ')
 ifdef(`syslogd.te', `
 allow syslogd_t innd_log_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.19.2/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/kudzu.te	2004-11-18 08:48:23.921139540 -0500
@@ -21,7 +21,7 @@
 allow kudzu_t proc_t:file { getattr read };
 allow kudzu_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
-allow kudzu_t { bin_t sbin_t }:dir search;
+allow kudzu_t { bin_t sbin_t }:dir { getattr search };
 allow kudzu_t { bin_t sbin_t }:lnk_file read;
 allow kudzu_t { sysctl_t sysctl_kernel_t }:dir search;
 allow kudzu_t sysctl_dev_t:dir { getattr search read };
@@ -85,3 +85,7 @@
 
 # for file systems that are not yet mounted
 dontaudit kudzu_t file_t:dir search;
+ifdef(`lpd.te', `
+allow kudzu_t printconf_t:file { getattr read };
+')
+allow kudzu_t zero_device_t:chr_file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.19.2/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.19.2/domains/program/unused/mta.te	2004-11-18 08:48:23.922139427 -0500
@@ -20,6 +20,7 @@
 # "mail user@domain"
 mail_domain(system)
 
+ifelse(`targeted-policy', `', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
 # then does system things with it.
@@ -32,11 +33,13 @@
 # allow the sysadmin to do "mail someone < /home/user/whatever"
 allow sysadm_mail_t user_home_dir_type:dir search;
 r_dir_file(sysadm_mail_t, user_home_type)
-
+')
 # for a mail server process that does things in response to a user command
 allow mta_user_agent userdomain:process sigchld;
 allow mta_user_agent { userdomain privfd }:fd use;
+ifdef(`crond.te', `
 allow mta_user_agent crond_t:process sigchld;
+')
 allow mta_user_agent sysadm_t:fifo_file { read write };
 
 allow { system_mail_t mta_user_agent } privmail:fd use;
@@ -57,3 +60,13 @@
 allow mta_delivery_agent devtty_t:chr_file rw_file_perms;
 allow mta_delivery_agent { etc_runtime_t proc_t }:file { getattr read };
 
+# rules are currently defined in sendmail.te, but it is not included in 
+# targeted policy.  We could move these rules permanantly here.
+ifdef(`targeted_policy', `
+allow system_mail_t self:dir { search };
+allow system_mail_t proc_t:dir search;
+allow system_mail_t proc_t:{ file lnk_file } { getattr read };
+allow system_mail_t fs_t:filesystem getattr;
+allow system_mail_t { var_t var_spool_t }:dir getattr;
+create_dir_file( system_mail_t, mqueue_spool_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.19.2/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.2/domains/program/unused/named.te	2004-11-18 08:55:41.707743815 -0500
@@ -77,6 +77,7 @@
 
 allow named_t self:unix_stream_socket create_stream_socket_perms;
 allow named_t self:unix_dgram_socket create_socket_perms;
+allow named_t self:netlink_route_socket r_netlink_socket_perms;
 
 # Read sysctl kernel variables.
 allow named_t sysctl_t:dir r_dir_perms;
@@ -149,7 +150,7 @@
 allow ndc_t named_zone_t:file getattr;
 dontaudit ndc_t sysadm_home_t:dir { getattr search read };
 ')
-allow ndc_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
+allow ndc_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit ndc_t sysadm_tty_device_t:chr_file { ioctl };
 # Allow init script to cp localtime to named_conf_t
 allow initrc_t named_conf_t:file { write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.19.2/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/domains/program/unused/ntpd.te	2004-11-18 09:16:48.946760475 -0500
@@ -42,18 +42,18 @@
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
+allow ntpd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # so the start script can change firewall entries
 allow initrc_t net_conf_t:file { getattr read ioctl };
 
 # for cron jobs
 # system_crond_t is not right, cron is not doing what it should
-ifdef(`crond.te', `
-system_crond_entry(ntpd_exec_t, ntpd_t)
+ifdef(`crond.te', `system_crond_entry(ntpd_exec_t, ntpd_t)')
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;
@@ -63,7 +63,6 @@
 allow ntpd_t self:file { getattr read };
 dontaudit ntpd_t domain:dir search;
 ifdef(`logrotate.te', `can_exec(ntpd_t, logrotate_exec_t)')
-')
 
 allow ntpd_t devtty_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.2/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/domains/program/unused/postgresql.te	2004-11-18 08:57:40.718315780 -0500
@@ -42,10 +42,11 @@
 
 logdir_domain(postgresql)
 
+ifdef(`crond.te', `
 # allow crond to find /usr/lib/postgresql/bin/do.maintenance
 allow crond_t postgresql_db_t:dir search;
-
 system_crond_entry(postgresql_exec_t, postgresql_t)
+')
 
 tmp_domain(postgresql);
 file_type_auto_trans(postgresql_t, tmpfs_t, postgresql_tmp_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.19.2/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.2/domains/program/unused/rpcd.te	2004-11-18 08:58:17.120208533 -0500
@@ -24,6 +24,7 @@
 allow $1_t var_lib_nfs_t:file create_file_perms;
 # do not log when it tries to bind to a port belonging to another domain
 dontaudit $1_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
+allow $1_t reserved_port_t:{ udp_socket tcp_socket } name_bind;
 allow $1_t self:netlink_route_socket r_netlink_socket_perms;
 allow $1_t self:unix_dgram_socket create_socket_perms;
 allow $1_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.19.2/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/domains/program/unused/snmpd.te	2004-11-18 08:58:52.256244113 -0500
@@ -38,7 +38,7 @@
 allow snmpd_t self:unix_dgram_socket create_socket_perms;
 allow snmpd_t self:unix_stream_socket create_socket_perms;
 allow snmpd_t etc_t:lnk_file read;
-allow snmpd_t { etc_t etc_runtime_t }:file { getattr read };
+allow snmpd_t { etc_t etc_runtime_t }:file r_file_perms;
 allow snmpd_t urandom_device_t:chr_file read;
 allow snmpd_t self:capability { dac_override kill net_bind_service net_admin sys_nice sys_tty_config };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.19.2/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/domains/program/unused/squid.te	2004-11-18 08:59:29.988986705 -0500
@@ -62,10 +62,12 @@
 
 # to allow running programs from /usr/lib/squid (IE unlinkd)
 # also allow exec()ing itself
-can_exec(squid_t, { lib_t squid_exec_t } )
+can_exec(squid_t, { lib_t squid_exec_t bin_t sbin_t } )
 allow squid_t { bin_t sbin_t }:dir search;
+allow squid_t { bin_t sbin_t }:lnk_file read;
 
 dontaudit squid_t { home_root_t security_t devpts_t }:dir getattr;
 ifdef(`targeted_policy', `
 dontaudit squid_t tty_device_t:chr_file { read write };
 ')
+allow squid_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.19.2/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.19.2/domains/program/unused/vpnc.te	2004-11-18 09:17:37.765252256 -0500
@@ -17,6 +17,7 @@
 # Use the network.
 can_network(vpnc_t)
 can_ypbind(vpnc_t)
+allow vpnc_t self:socket create_socket_perms;
 
 # Use capabilities.
 allow vpnc_t self:capability { net_admin ipc_lock net_bind_service net_raw };
@@ -28,3 +29,12 @@
 allow vpnc_t self:unix_dgram_socket create_socket_perms;
 allow vpnc_t self:unix_stream_socket create_socket_perms;
 allow vpnc_t admin_tty_type:chr_file rw_file_perms;
+allow vpnc_t port_t:udp_socket name_bind;
+allow vpnc_t etc_runtime_t:file { getattr read };
+allow vpnc_t proc_t:file { getattr read };
+dontaudit vpnc_t selinux_config_t:dir search;
+can_exec(vpnc_t, {bin_t sbin_t ifconfig_exec_t shell_exec_t })
+allow vpnc_t sysctl_net_t:dir search;
+allow vpnc_t sbin_t:dir search;
+allow vpnc_t bin_t:dir search;
+allow vpnc_t bin_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.19.2/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/domains/program/unused/xdm.te	2004-11-18 09:01:02.054598887 -0500
@@ -241,6 +241,9 @@
 # Access sound device.
 allow xdm_t sound_device_t:chr_file { setattr getattr };
 
+# Allow setting of attributes on power management devices.
+allow xdm_t power_device_t:chr_file { getattr setattr };
+
 # Run the X server in a derived domain.
 xserver_domain(xdm)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.19.2/domains/user.te
--- nsapolicy/domains/user.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.2/domains/user.te	2004-11-18 08:48:23.922139427 -0500
@@ -18,6 +18,9 @@
 # Allow system to run with NIS
 bool allow_ypbind false;
 
+# Allow system to run with kerberos
+bool allow_kerberos false;
+
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.19.2/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2004-10-06 16:21:13.000000000 -0400
+++ policy-1.19.2/file_contexts/distros.fc	2004-11-18 08:48:23.923139314 -0500
@@ -30,5 +30,6 @@
 /usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
 /usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
+/usr/share/pwlib/make/ptlib-config --	system_u:object_r:bin_t
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.19.2/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/file_contexts/program/apache.fc	2004-11-18 08:48:23.924139201 -0500
@@ -27,6 +27,7 @@
 /var/cache/mod_ssl(/.*)?	system_u:object_r:httpd_cache_t
 /var/run/apache(2)?.pid.* --	system_u:object_r:httpd_var_run_t
 /var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
+/var/lib/php/session(/.*)?	system_u:object_r:httpd_var_run_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
 /usr/lib/apache-ssl(/.*)? --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
@@ -37,4 +38,5 @@
 # suse puts shell scripts there :-(
 /usr/share/apache2/.*	--	system_u:object_r:bin_t
 ')
-/var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_sys_script_rw_t
+/var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_squirrelmail_t
+/usr/bin/htsslpass --	system_u:object_r:httpd_helper_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.19.2/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2004-10-14 23:25:19.000000000 -0400
+++ policy-1.19.2/file_contexts/program/cups.fc	2004-11-18 08:48:23.924139201 -0500
@@ -1,7 +1,7 @@
 # cups printing
 /etc/cups(/.*)?			system_u:object_r:cupsd_etc_t
 /usr/share/cups(/.*)?		system_u:object_r:cupsd_etc_t
-/etc/alchemist/namespace/printconf/local.adl system_u:object_r:cupsd_rw_etc_t
+/etc/alchemist/namespace/printconf(/.*)? system_u:object_r:cupsd_rw_etc_t
 /var/cache/alchemist/printconf.* system_u:object_r:cupsd_rw_etc_t
 /etc/cups/client\.conf	--	system_u:object_r:etc_t
 /etc/cups/cupsd.conf.* --	system_u:object_r:cupsd_rw_etc_t
@@ -33,3 +33,4 @@
 /usr/sbin/ptal-mlcd	--	system_u:object_r:ptal_exec_t
 /var/run/ptal-printd(/.*)?	system_u:object_r:ptal_var_run_t
 /var/run/ptal-mlcd(/.*)?	system_u:object_r:ptal_var_run_t
+/usr/share/foomatic/db/oldprinterids 	--	system_u:object_r:cupsd_rw_etc_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/hald.fc policy-1.19.2/file_contexts/program/hald.fc
--- nsapolicy/file_contexts/program/hald.fc	2004-09-22 16:19:13.000000000 -0400
+++ policy-1.19.2/file_contexts/program/hald.fc	2004-11-18 08:48:23.925139089 -0500
@@ -3,3 +3,4 @@
 /usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
 /etc/hal/device.d/printer_remove.hal -- system_u:object_r:hald_exec_t
 /etc/hal/capability.d/printer_update.hal -- system_u:object_r:hald_exec_t
+/usr/share/hal/device-manager/hal-device-manager -- system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/sendmail.fc policy-1.19.2/file_contexts/program/sendmail.fc
--- nsapolicy/file_contexts/program/sendmail.fc	2004-10-07 08:02:02.000000000 -0400
+++ policy-1.19.2/file_contexts/program/sendmail.fc	2004-11-18 08:48:23.925139089 -0500
@@ -1,6 +1,5 @@
 # sendmail
 /etc/mail(/.*)?				system_u:object_r:etc_mail_t
-/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
 /var/run/sendmail.pid		--	system_u:object_r:sendmail_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.2/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/file_contexts/types.fc	2004-11-18 08:48:23.927138863 -0500
@@ -334,6 +334,7 @@
 /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
+/usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
 /usr(/.*)?/sbin(/.*)?		system_u:object_r:sbin_t
 /usr/etc(/.*)?			system_u:object_r:etc_t
 /usr/inclu.e(/.*)?		system_u:object_r:usr_t
@@ -392,6 +393,7 @@
 #
 /var/spool(/.*)?		system_u:object_r:var_spool_t
 /var/spool/texmf(/.*)?		system_u:object_r:tetex_data_t
+/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 
 # 
 # /var/log
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.19.2/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/macros/admin_macros.te	2004-11-18 08:48:23.927138863 -0500
@@ -196,6 +196,11 @@
 # Grant read and write access to /dev/console.
 allow $1_t console_device_t:chr_file rw_file_perms;
 
+# Allow MAKEDEV to work
+allow $1_t device_t:dir rw_dir_perms;
+allow $1_t device_type:{ blk_file chr_file } { create unlink rename };
+allow $1_t device_t:lnk_file { create read };
+
 # for lsof
 allow $1_t domain:socket_class_set getattr;
 allow $1_t eventpollfs_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.19.2/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/macros/base_user_macros.te	2004-11-18 09:01:27.432735456 -0500
@@ -291,6 +291,9 @@
 # Access the sound device.
 allow $1_t sound_device_t:chr_file { getattr read write ioctl };
 
+# Access the power device.
+allow $1_t power_device_t:chr_file { getattr read write ioctl };
+
 allow $1_t var_log_t:dir { getattr search };
 dontaudit $1_t logfile:file getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.19.2/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/macros/core_macros.te	2004-11-18 09:05:47.706368626 -0500
@@ -137,17 +137,27 @@
 #
 # Permissions for creating and using sockets.
 # 
-define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
+define(`create_socket_perms', `{ create rw_socket_perms }')
 
 #
 # Permissions for using stream sockets.
 # 
-define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+define(`rw_stream_socket_perms', `{ rw_socket_perms listen accept }')
 
 #
 # Permissions for creating and using stream sockets.
 # 
-define(`create_stream_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
+define(`create_stream_socket_perms', `{ create_socket_perms listen accept }')
+
+#
+# Permissions for creating and using sockets.
+# 
+define(`connected_socket_perms', `{ create_socket_perms -connect }')
+
+#
+# Permissions for creating and using sockets.
+# 
+define(`connected_stream_socket_perms', `{ create_stream_socket_perms -connect }')
 
 
 #
@@ -158,12 +168,12 @@
 #
 # Permissions for using netlink sockets for operations that modify state.
 # 
-define(`rw_netlink_socket_perms', `{ create rw_socket_perms nlmsg_read nlmsg_write }')
+define(`rw_netlink_socket_perms', `{ create_socket_perms nlmsg_read nlmsg_write }')
 
 #
 # Permissions for using netlink sockets for operations that observe state.
 # 
-define(`r_netlink_socket_perms', `{ create rw_socket_perms nlmsg_read }')
+define(`r_netlink_socket_perms', `{ create_socket_perms nlmsg_read }')
 
 #
 # Permissions for sending all signals.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.19.2/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.2/macros/program/apache_macros.te	2004-11-18 09:06:46.828697818 -0500
@@ -110,11 +110,12 @@
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
 
-if (httpd_enable_cgi) && (httpd_unified) {
+if (httpd_enable_cgi) && (httpd_unified) ifdef(`targeted_policy', ` && ! (httpd_disable_trans)') {
 ifelse($1, sys, `
 domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
 domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
 domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
+create_dir_file(httpd_t, httpdcontent)
 ', `
 create_dir_file(httpd_$1_script_t, httpdcontent)
 can_exec(httpd_$1_script_t, httpdcontent )
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.19.2/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.2/macros/program/inetd_macros.te	2004-11-18 09:07:36.065142440 -0500
@@ -44,7 +44,7 @@
 allow $1_t self:dir search;
 allow $1_t self:file { getattr read };
 can_kerberos($1_t)
-allow $1_t urandom_device_t:chr_file { getattr read };
+allow $1_t urandom_device_t:chr_file r_file_perms;
 type $1_port_t, port_type, reserved_port_type;
 # Use sockets inherited from inetd.
 ifelse($2, `', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/kerberos_macros.te policy-1.19.2/macros/program/kerberos_macros.te
--- nsapolicy/macros/program/kerberos_macros.te	2004-11-17 14:51:55.000000000 -0500
+++ policy-1.19.2/macros/program/kerberos_macros.te	2004-11-18 09:08:04.893889675 -0500
@@ -1,7 +1,9 @@
 define(`can_kerberos',`
 ifdef(`kerberos.te',`
+if (allow_kerberos) {
 can_network($1)
 dontaudit $1 krb5_conf_t:file write;
 allow $1 krb5_conf_t:file { getattr read };
+}
 ') dnl kerberos.te
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.19.2/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/macros/program/lpr_macros.te	2004-11-18 09:09:14.527032926 -0500
@@ -18,7 +18,7 @@
 undefine(`lpr_domain')
 define(`lpr_domain',`
 # Derived domain based on the calling user domain and the program
-type $1_lpr_t, domain, privlog;
+type $1_lpr_t, domain, privlog, nscd_client_domain;
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, lpr_exec_t, $1_lpr_t)
@@ -104,6 +104,7 @@
 # Connect to lpd via a TCP socket.
 can_tcp_connect($1_lpr_t, lpd_t)
 
+allow $1_lpr_t fs_t:filesystem getattr;
 # Send SIGHUP to lpd.
 allow $1_lpr_t lpd_t:process signal;
 
@@ -120,5 +121,11 @@
 can_tcp_connect({ $1_lpr_t $1_t }, cupsd_t)
 ')dnl end ifdef cups.te
 
+ifdef(`hide_broken_symptoms', `
+# thunderbird causes these
+dontaudit $1_lpr_t $1_t:tcp_socket { read write };
+dontaudit $1_lpr_t { $1_home_t $1_tmp_t }:file write;
+')
+
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.2/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.2/macros/program/mozilla_macros.te	2004-11-18 09:10:42.462111158 -0500
@@ -105,6 +105,8 @@
 dontaudit $1_mozilla_t bin_t:dir getattr;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
+# running mplayer within firefox asks for this
+allow $1_mozilla_t clock_device_t:chr_file r_file_perms;
 # Mozilla tries to delete .fonts.cache-1
 dontaudit $1_mozilla_t $1_home_t:file unlink;
 dontaudit $1_mozilla_t tmpfile:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.19.2/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.2/macros/program/mta_macros.te	2004-11-18 09:11:15.394395389 -0500
@@ -61,9 +61,11 @@
 domain_auto_trans(privmail, sendmail_exec_t, system_mail_t)
 allow privmail sendmail_exec_t:lnk_file { getattr read };
 
+ifdef(`crond.te', `
 # Read cron temporary files.
 allow system_mail_t system_crond_tmp_t:file { read getattr ioctl };
 allow mta_user_agent system_crond_tmp_t:file { read getattr };
+')
 allow system_mail_t initrc_devpts_t:chr_file { read write getattr };
 
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.19.2/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/macros/program/xserver_macros.te	2004-11-18 09:12:18.809240254 -0500
@@ -27,9 +27,11 @@
 ifdef(`distro_redhat', `
 type $1_xserver_t, domain, privlog, privmem, privmodule, nscd_client_domain;
 allow $1_xserver_t sysctl_modprobe_t:file { getattr read };
+ifdef(`rpm.te', `
 allow $1_xserver_t rpm_t:shm { unix_read unix_write read write associate getattr };
 allow $1_xserver_t rpm_tmpfs_t:file { read write };
 allow $1_xserver_t rpm_t:fd use;
+')
 
 ', `
 type $1_xserver_t, domain, privlog, privmem, nscd_client_domain;
@@ -148,6 +150,7 @@
 allow xdm_xserver_t xdm_t:process signal;
 allow xdm_xserver_t xdm_t:shm rw_shm_perms;
 allow xdm_t xdm_xserver_t:shm rw_shm_perms;
+dontaudit xdm_xserver_t sysadm_t:shm { unix_read unix_write };
 ')
 ', `
 allow $1_t xdm_xserver_tmp_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.19.2/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-11-18 08:14:00.000000000 -0500
+++ policy-1.19.2/targeted/domains/unconfined.te	2004-11-18 08:48:23.928138750 -0500
@@ -45,4 +45,7 @@
 # Allow system to run with NIS
 bool allow_ypbind false;
 
+# Allow system to run with Kerberos
+bool allow_kerberos false;
+
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.2/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.2/tunables/distro.tun	2004-11-18 08:48:23.929138637 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.2/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.2/tunables/tunable.tun	2004-11-18 08:48:23.929138637 -0500
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

--------------080704090107060105060305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
