Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34IvBDo002806
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 14:57:11 -0400 (EDT)
Message-ID: <42518C8A.7040200@redhat.com>
Date: Mon, 04 Apr 2005 14:50:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: New Policy Patch
References: <41E57081.4090500@redhat.com> <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020303060305040303000407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020303060305040303000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Major regrouping of apache_policy

Now use apache_domain and apache_user_domain
Added boolean httpd_builtin_scripting.   Which when turned off only allows
running of external apache scripts, not built in modules like PHP.
Users can now create their own scripts using apache_domain(myscript)

More fixes of can_network and named_connect

Added NetworkManager policy.

A few fixes submitted from Ivan  for hal, kudzu





-- 



--------------020303060305040303000407
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.23.6/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.6/domains/program/ifconfig.te	2005-04-04 10:44:54.000000000 -0400
@@ -66,3 +66,4 @@
 rhgb_domain(ifconfig_t)
 allow ifconfig_t userdomain:fd use;
 dontaudit ifconfig_t root_t:file read;
+r_dir_file(ifconfig_t, sysfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/logrotate.te policy-1.23.6/domains/program/logrotate.te
--- nsapolicy/domains/program/logrotate.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.6/domains/program/logrotate.te	2005-04-04 10:44:54.000000000 -0400
@@ -141,5 +141,10 @@
 
 domain_auto_trans(logrotate_t, initrc_exec_t, initrc_t)
 
+# Supress libselinux initialization denials
 dontaudit logrotate_t selinux_config_t:dir search;
+dontaudit logrotate_t selinux_config_t:file { read getattr };
 
+# Allow selinux_getenforce 
+allow logrotate_t security_t:dir search;
+allow logrotate_t security_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.6/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.6/domains/program/unused/apache.te	2005-04-04 10:44:54.000000000 -0400
@@ -28,6 +28,9 @@
 
 bool httpd_unified false;
 
+# Allow httpd to use built in scripting (usually php)
+bool httpd_builtin_scripting false;
+
 # Allow httpd cgi support
 bool httpd_enable_cgi false;
 
@@ -86,54 +89,6 @@
 # for modules that want to access /etc/mtab and /proc/meminfo
 allow httpd_t { proc_t etc_runtime_t }:file { getattr read };
 
-# setup the system domain for system CGI scripts
-apache_domain(sys)
-
-# The following are types for SUEXEC,which runs user scripts as their
-# own user ID
-#
-daemon_sub_domain(httpd_t, httpd_suexec)
-allow httpd_t httpd_suexec_exec_t:file read;
-
-#########################################################
-# Permissions for running child processes and scripts
-##########################################################
-
-allow httpd_suexec_t self:capability { setuid setgid };
-
-dontaudit httpd_suexec_t var_run_t:dir search;
-allow httpd_suexec_t { var_t var_log_t }:dir search;
-allow httpd_suexec_t home_root_t:dir search;
-
-allow httpd_suexec_t httpd_log_t:dir search;
-allow httpd_suexec_t httpd_log_t:file { append getattr };
-allow httpd_suexec_t httpd_t:fifo_file getattr;
-allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
-
-allow httpd_suexec_t etc_t:file { getattr read };
-read_locale(httpd_suexec_t)
-read_sysctl(httpd_suexec_t)
-allow httpd_suexec_t urandom_device_t:chr_file { getattr read };
-
-# for shell scripts
-allow httpd_suexec_t bin_t:dir search;
-allow httpd_suexec_t bin_t:lnk_file read;
-can_exec(httpd_suexec_t, { bin_t shell_exec_t })
-
-if (httpd_can_network_connect) {
-can_network(httpd_suexec_t)
-allow httpd_suexec_t port_type:tcp_socket name_connect;
-}
-
-can_ypbind(httpd_suexec_t)
-allow httpd_suexec_t { usr_t lib_t }:file { getattr read ioctl };
-
-ifdef(`mta.te', `
-# apache should set close-on-exec
-dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
-dontaudit { system_mail_t mta_user_agent } { httpd_t httpd_sys_script_t }:unix_stream_socket { read write };
-')
-
 uses_shlib(httpd_t)
 allow httpd_t { usr_t lib_t }:file { getattr read ioctl };
 allow httpd_t usr_t:lnk_file { getattr read };
@@ -149,15 +104,24 @@
 can_exec(httpd_t, { bin_t sbin_t })
 allow httpd_t bin_t:lnk_file read;
 
-can_network(httpd_t)
+########################################
+# Set up networking
+########################################
+
+can_network_server(httpd_t)
+can_kerberos(httpd_t)
+can_resolve(httpd_t)
+can_ypbind(httpd_t)
+allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;
+
 if (httpd_can_network_connect) {
+can_network_client(httpd_t)
 allow httpd_t port_type:tcp_socket name_connect;
 }
-can_ypbind(httpd_t)
 
-###################
-# Allow httpd to search users diretories
-######################
+#########################################
+# Allow httpd to search users directories
+#########################################
 allow httpd_t home_root_t:dir { getattr search };
 dontaudit httpd_t sysadm_home_dir_t:dir getattr;
 
@@ -171,7 +135,6 @@
 # Allow the httpd_t to read the web servers config files
 ###################################################
 r_dir_file(httpd_t, httpd_config_t)
-dontaudit httpd_sys_script_t httpd_config_t:dir search;
 # allow logrotate to read the config files for restart
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, httpd_config_t)
@@ -181,11 +144,6 @@
 r_dir_file(initrc_t, httpd_config_t)
 ##################################################
 
-########################################
-# Allow httpd_t to bind to the HTTP port
-########################################
-allow httpd_t { http_port_t http_cache_port_t }:tcp_socket name_bind;
-
 ###############################
 # Allow httpd_t to put files in /var/cache/httpd etc
 ##############################
@@ -217,13 +175,14 @@
 allow httpd_t etc_t:file { read getattr ioctl };
 allow httpd_t etc_t:lnk_file { getattr read };
 
+# setup the system domain for system CGI scripts
+apache_domain(sys)
+dontaudit httpd_sys_script_t httpd_config_t:dir search;
+
 # Run SSI execs in system CGI script domain.
 if (httpd_ssi_exec) {
 domain_auto_trans(httpd_t, shell_exec_t, httpd_sys_script_t)
 }
-r_dir_file(httpd_t, httpd_sys_script_ro_t)
-create_dir_file(httpd_t, httpd_sys_script_rw_t)
-ra_dir_file(httpd_t, httpd_sys_script_ra_t)
 allow httpd_sys_script_t httpd_t:tcp_socket { read write };
 
 ##################################################
@@ -250,7 +209,6 @@
 # access to /tmp
 tmp_domain(httpd)
 tmp_domain(httpd_php)
-tmp_domain(httpd_suexec)
 
 # Creation of lock files for apache2
 lock_domain(httpd)
@@ -269,11 +227,11 @@
 allow httpd_t bin_t:dir search;
 allow httpd_t sbin_t:dir search;
 allow httpd_t httpd_log_t:dir remove_name;
+r_dir_file(httpd_t, fonts_t)
 
 allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 
 allow httpd_t autofs_t:dir { search getattr };
-allow httpd_suexec_t autofs_t:dir { search getattr };
 
 if (use_nfs_home_dirs && httpd_enable_homedirs) {
 httpd_home_dirs(nfs_t)
@@ -281,23 +239,12 @@
 if (use_samba_home_dirs && httpd_enable_homedirs) {
 httpd_home_dirs(cifs_t)
 }
-r_dir_file(httpd_t, fonts_t)
 
 #
 # Allow users to mount additional directories as http_source
 #
 allow httpd_t mnt_t:dir r_dir_perms;
 
-########################################
-# When the admin starts the server, the server wants to acess
-# the TTY or PTY associated with the session. The httpd appears
-# to run correctly without this permission, so the permission
-# are dontaudited here. 
-##################################################
-dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
-
-can_kerberos(httpd_t)
-
 ifdef(`targeted_policy', `
 typealias httpd_sys_content_t alias httpd_user_content_t;
 typealias httpd_sys_script_exec_t alias httpd_user_script_exec_t;
@@ -308,6 +255,9 @@
 }
 ') dnl targeted policy
 
+# We no longer call httpd_domain(sysadm), but need httpd_sysadm_content_t for file context
+typealias httpd_sys_content_t alias httpd_sysadm_content_t;
+
 ifdef(`distro_redhat', `
 #
 # mod_jk2 creates /var/log/httpd/jk2.shm to communicate with tomcat
@@ -327,33 +277,27 @@
 dontaudit httpd_t usr_t:dir write;
 ')
 
-type httpd_squirrelmail_t, file_type, sysadmfile;
-create_dir_file(httpd_t, httpd_squirrelmail_t)
-allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
-# File Type of squirrelmail attachments
-type squirrelmail_spool_t, file_type, sysadmfile, tmpfile;
-allow { httpd_t httpd_sys_script_t } var_spool_t:dir { getattr search };
-create_dir_file(httpd_t, squirrelmail_spool_t)
-r_dir_file(httpd_sys_script_t, squirrelmail_spool_t)
-
-ifdef(`mta.te', `
-dontaudit system_mail_t httpd_log_t:file { append getattr };
-allow system_mail_t httpd_squirrelmail_t:file { append read };
-dontaudit system_mail_t httpd_t:tcp_socket { read write };
-')
-
 application_domain(httpd_helper)
 role system_r types httpd_helper_t;
 domain_auto_trans(httpd_t, httpd_helper_exec_t, httpd_helper_t)
 allow httpd_helper_t httpd_config_t:file { getattr read };
 allow httpd_helper_t httpd_log_t:file { append };
 
+########################################
+# When the admin starts the server, the server wants to acess
+# the TTY or PTY associated with the session. The httpd appears
+# to run correctly without this permission, so the permission
+# are dontaudited here. 
+##################################################
+
 if (httpd_tty_comm) {
 allow { httpd_t httpd_helper_t } devpts_t:dir { search };
 ifdef(`targeted_policy', `
 allow { httpd_helper_t httpd_t } { devtty_t devpts_t }:chr_file { read write };
 ')
 allow { httpd_t httpd_helper_t } admin_tty_type:chr_file { read write };
+} else {
+dontaudit httpd_t admin_tty_type:chr_file rw_file_perms;
 }
 
 read_sysctl(httpd_sys_script_t)
@@ -368,6 +312,64 @@
 type httpd_unconfined_script_t, domain, nscd_client_domain;
 role system_r types httpd_unconfined_script_t;
 unconfined_domain(httpd_unconfined_script_t)
+
+# The following are types for SUEXEC,which runs user scripts as their
+# own user ID
+#
+daemon_sub_domain(httpd_t, httpd_suexec)
+allow httpd_t httpd_suexec_exec_t:file read;
+
+#########################################################
+# Permissions for running child processes and scripts
+##########################################################
+
+allow httpd_suexec_t self:capability { setuid setgid };
+
+dontaudit httpd_suexec_t var_run_t:dir search;
+allow httpd_suexec_t { var_t var_log_t }:dir search;
+allow httpd_suexec_t home_root_t:dir search;
+
+allow httpd_suexec_t httpd_log_t:dir search;
+allow httpd_suexec_t httpd_log_t:file { append getattr };
+allow httpd_suexec_t httpd_t:fifo_file getattr;
+allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
+
+allow httpd_suexec_t etc_t:file { getattr read };
+read_locale(httpd_suexec_t)
+read_sysctl(httpd_suexec_t)
+allow httpd_suexec_t urandom_device_t:chr_file { getattr read };
+
+# for shell scripts
+allow httpd_suexec_t bin_t:dir search;
+allow httpd_suexec_t bin_t:lnk_file read;
+can_exec(httpd_suexec_t, { bin_t shell_exec_t })
+
+if (httpd_can_network_connect) {
+can_network(httpd_suexec_t)
+allow httpd_suexec_t port_type:tcp_socket name_connect;
+}
+
+can_ypbind(httpd_suexec_t)
+allow httpd_suexec_t { usr_t lib_t }:file { getattr read ioctl };
+
+allow httpd_suexec_t autofs_t:dir { search getattr };
+tmp_domain(httpd_suexec)
+
+ifdef(`mta.te', `
+# apache should set close-on-exec
+dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
+dontaudit { system_mail_t mta_user_agent } { httpd_t httpd_sys_script_t }:unix_stream_socket { read write };
+')
+
+if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
+domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
+domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
+}
+if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
+domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
+create_dir_file(httpd_t, httpdcontent)
+can_exec(httpd_t, httpdcontent )
+}
 if (httpd_enable_cgi) {
 domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
 domain_auto_trans(httpd_suexec_t, httpd_unconfined_script_exec_t, httpd_unconfined_script_t)
@@ -375,3 +377,21 @@
 allow httpd_t httpd_unconfined_script_exec_t:dir r_dir_perms;
 }
 
+#
+# Types for squirrelmail
+#
+type httpd_squirrelmail_t, file_type, sysadmfile;
+create_dir_file(httpd_t, httpd_squirrelmail_t)
+allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
+# File Type of squirrelmail attachments
+type squirrelmail_spool_t, file_type, sysadmfile, tmpfile;
+allow { httpd_t httpd_sys_script_t } var_spool_t:dir { getattr search };
+create_dir_file(httpd_t, squirrelmail_spool_t)
+r_dir_file(httpd_sys_script_t, squirrelmail_spool_t)
+
+ifdef(`mta.te', `
+dontaudit system_mail_t httpd_log_t:file { append getattr };
+allow system_mail_t httpd_squirrelmail_t:file { append read };
+dontaudit system_mail_t httpd_t:tcp_socket { read write };
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.23.6/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-03-24 08:58:26.000000000 -0500
+++ policy-1.23.6/domains/program/unused/dhcpc.te	2005-04-04 10:44:54.000000000 -0400
@@ -44,6 +44,8 @@
 domain_auto_trans(cardmgr_t, dhcpc_exec_t, dhcpc_t)
 allow cardmgr_t dhcpc_var_run_t:file { getattr read };
 allow cardmgr_t dhcpc_t:process signal_perms;
+allow cardmgr_t dhcpc_var_run_t:file unlink;
+allow dhcpc_t cardmgr_dev_t:chr_file { read write };
 ')
 ifdef(`hotplug.te', `
 domain_auto_trans(hotplug_t, dhcpc_exec_t, dhcpc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.6/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.6/domains/program/unused/hald.te	2005-04-04 10:44:54.000000000 -0400
@@ -43,6 +43,9 @@
 allow hald_t event_device_t:chr_file { getattr read ioctl };
 allow hald_t printer_device_t:chr_file rw_file_perms;
 allow hald_t urandom_device_t:chr_file read;
+allow hald_t mouse_device_t:chr_file r_file_perms;
+
+can_getsecurity(hald_t)
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
@@ -73,3 +76,20 @@
 tmp_domain(hald)
 allow hald_t mnt_t:dir search;
 r_dir_file(hald_t, proc_net_t)
+
+
+# For /usr/libxexc/hald-addon-acpi - writes to /var/run/acpid.socket
+ifdef(`apmd.te', `
+allow hald_t apmd_var_run_t:sock_file write;
+allow hald_t apmd_t:unix_stream_socket connectto;
+')
+
+# For /usr/sbin/dmidecode
+# Violates assertion
+#allow hald_t memory_device_t:chr_file read;
+allow hald_t self:capability sys_rawio;
+
+# ??
+ifdef(`lvm.te', `
+allow hald_t lvm_control_t:chr_file r_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.23.6/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.6/domains/program/unused/kudzu.te	2005-04-04 10:44:54.000000000 -0400
@@ -100,3 +100,8 @@
 allow kudzu_t xserver_exec_t:file getattr;
 ')
 
+ifdef(`userhelper.te', `
+role system_r types sysadm_userhelper_t;
+domain_auto_trans(kudzu_t, userhelper_exec_t, sysadm_userhelper_t)
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.23.6/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.6/domains/program/unused/NetworkManager.te	2005-04-04 10:44:54.000000000 -0400
@@ -0,0 +1,76 @@
+#DESC NetworkManager - 
+#
+# Authors: Dan Walsh <dwalsh@redhat.com>
+#
+#
+
+#################################
+#
+# Rules for the NetworkManager_t domain.
+#
+# NetworkManager_t is the domain for the NetworkManager daemon. 
+# NetworkManager_exec_t is the type of the NetworkManager executable.
+#
+daemon_domain(NetworkManager, `, nscd_client_domain' )
+
+can_network(NetworkManager_t)
+allow NetworkManager_t port_type:tcp_socket name_connect;
+allow NetworkManager_t dhcpc_port_t:udp_socket name_bind;
+allow NetworkManager_t dhcpc_t:process signal;
+
+can_ypbind(NetworkManager_t)
+uses_shlib(NetworkManager_t)
+allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service };
+
+allow NetworkManager_t { random_device_t urandom_device_t }:chr_file { getattr read };
+
+allow NetworkManager_t self:process { setcap getsched };
+allow NetworkManager_t self:fifo_file rw_file_perms;
+allow NetworkManager_t self:unix_dgram_socket create_socket_perms;
+allow NetworkManager_t self:file { getattr read };
+allow NetworkManager_t self:packet_socket create_socket_perms;
+allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;
+
+
+#
+# Communicate with Caching Name Server
+#
+allow NetworkManager_t named_zone_t:dir search;
+rw_dir_create_file(NetworkManager_t, named_cache_t)
+domain_auto_trans(NetworkManager_t, named_exec_t, named_t)
+allow named_t NetworkManager_t:udp_socket { read write };
+allow NetworkManager_t named_t:process signal;
+
+allow NetworkManager_t selinux_config_t:dir search;
+allow NetworkManager_t selinux_config_t:file { getattr read };
+
+ifdef(`dbusd.te', `
+dbusd_client(system, NetworkManager)
+allow NetworkManager_t system_dbusd_t:dbus { acquire_svc send_msg };
+allow NetworkManager_t hald_t:dbus send_msg;
+allow hald_t NetworkManager_t:dbus send_msg;
+')
+
+allow NetworkManager_t usr_t:file { getattr read };
+
+ifdef(`ifconfig.te', `
+domain_auto_trans(NetworkManager_t, ifconfig_exec_t, ifconfig_t)
+')dnl end if def ifconfig
+
+allow NetworkManager_t { sbin_t bin_t }:dir search;
+allow NetworkManager_t bin_t:lnk_file read;
+can_exec(NetworkManager_t, { ls_exec_t bin_t shell_exec_t })
+
+# in /etc created by NetworkManager will be labelled net_conf_t.
+file_type_auto_trans(NetworkManager_t, etc_t, net_conf_t, file)
+
+allow NetworkManager_t { etc_t etc_runtime_t }:file { getattr read };
+allow NetworkManager_t proc_t:file { getattr read };
+
+allow NetworkManager_t domain:dir search;
+allow NetworkManager_t domain:file { getattr read };
+
+allow NetworkManager_t howl_t:process signal;
+allow NetworkManager_t initrc_var_run_t:file { getattr read };
+
+domain_auto_trans(NetworkManager_t, insmod_exec_t, insmod_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.23.6/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.6/domains/program/unused/ntpd.te	2005-04-04 10:44:54.000000000 -0400
@@ -41,7 +41,7 @@
 
 # Use the network.
 can_network(ntpd_t)
-allow ntpd_t port_type:tcp_socket name_connect;
+allow ntpd_t ntp_port_t:tcp_socket name_connect;
 can_ypbind(ntpd_t)
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pam.te policy-1.23.6/domains/program/unused/pam.te
--- nsapolicy/domains/program/unused/pam.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.6/domains/program/unused/pam.te	2005-04-04 10:44:54.000000000 -0400
@@ -37,4 +37,4 @@
 
 allow initrc_t pam_var_run_t:dir rw_dir_perms;
 allow initrc_t pam_var_run_t:file { getattr read unlink };
-dontaudit pam_t initrc_var_run_t:file { read write };
+dontaudit pam_t initrc_var_run_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.23.6/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/domains/program/unused/postgresql.te	2005-04-04 10:44:54.000000000 -0400
@@ -124,11 +124,15 @@
 
 ifdef(`distro_gentoo', `
 # "su - postgres ..." is called from initrc_t
-allow initrc_su_t postgresql_db_t:dir { search };
-allow postgresql_t initrc_su_t:process { sigchld };
+allow initrc_su_t postgresql_db_t:dir search;
+allow postgresql_t initrc_su_t:process sigchld;
 dontaudit initrc_su_t sysadm_devpts_t:chr_file rw_file_perms;
 ')
 
 dontaudit postgresql_t home_root_t:dir search;
 can_kerberos(postgresql_t)
 allow postgresql_t urandom_device_t:chr_file { getattr read };
+
+if (allow_execmem) {
+allow postgresql_t self:process execmem;
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/publicfile.te policy-1.23.6/domains/program/unused/publicfile.te
--- nsapolicy/domains/program/unused/publicfile.te	2005-03-15 12:54:54.000000000 -0500
+++ policy-1.23.6/domains/program/unused/publicfile.te	2005-04-04 10:46:35.000000000 -0400
@@ -12,11 +12,6 @@
 type ftp_data_port_t, port_type, reserved_port_type;
 ')
 
-ifdef(`apache.te', `
-', `
-type http_port_t, port_type, reserved_port_type;
-')
-
 daemon_domain(publicfile)
 type publicfile_content_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, publicfile_exec_t, publicfile_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.23.6/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.6/domains/program/unused/snmpd.te	2005-04-04 10:44:54.000000000 -0400
@@ -45,7 +45,9 @@
 allow snmpd_t proc_t:dir search;
 allow snmpd_t proc_t:file r_file_perms;
 allow snmpd_t self:file { getattr read };
-allow snmpd_t self:fifo_file { read write };
+allow snmpd_t self:fifo_file rw_file_perms;
+allow snmpd_t { bin_t sbin_t }:dir search;
+can_exec(snmpd_t, { bin_t sbin_t shell_exec_t })
 
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.6/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/file_contexts/distros.fc	2005-04-04 10:44:54.000000000 -0400
@@ -141,6 +141,10 @@
 # Jai, Sun Microsystems (Jpackage SPRM)
 /usr/lib/libmlib_jai\.so			-- system_u:object_r:texrel_shlib_t
 /usr/lib/libdivxdecore.so.0			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libdivxencore.so.0			-- system_u:object_r:texrel_shlib_t
+
+# Java, Sun Microsystems (JPackage SRPM)
+/usr/.*/jre/lib/i386/libdeploy.so		-- system_u:object_r:texrel_shlib_t
 
 /usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/.*\.api	-- system_u:object_r:shlib_t
 /usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/AcroForm\.api	-- system_u:object_r:texrel_shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/NetworkManager.fc policy-1.23.6/file_contexts/program/NetworkManager.fc
--- nsapolicy/file_contexts/program/NetworkManager.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.6/file_contexts/program/NetworkManager.fc	2005-04-04 10:44:54.000000000 -0400
@@ -0,0 +1,2 @@
+# NetworkManager 
+/usr/bin/NetworkManager	--	system_u:object_r:NetworkManager_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.6/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/macros/program/apache_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -4,14 +4,11 @@
 #This type is for webpages
 #
 type httpd_$1_content_t, file_type, httpdcontent, sysadmfile, customizable;
-ifelse($1, sys, `
-typealias httpd_sys_content_t alias httpd_sysadm_content_t;
-')
-ifelse($1, sys, `',`typeattribute httpd_$1_content_t $1_file_type;') 
 
 # This type is used for .htaccess files
 #
-type httpd_$1_htaccess_t, file_type, sysadmfile;
+type httpd_$1_htaccess_t, file_type, sysadmfile, customizable;
+allow httpd_t httpd_$1_htaccess_t: file r_file_perms;
 
 # This type is used for executable scripts files
 #
@@ -68,13 +65,6 @@
 type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile, customizable;
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
 
-ifdef(`slocate.te', `
-ifelse($1, `sys', `', `
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:dir { getattr search };
-allow $1_locate_t { httpd_$1_content_t httpd_$1_htaccess_t httpd_$1_script_exec_t httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:file { getattr read };
-')dnl end ifelse
-')dnl end slocate.te
-
 #########################################################
 # Permissions for running child processes and scripts
 ##########################################################
@@ -117,20 +107,9 @@
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
 
 if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
-ifelse($1, sys, `
-domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
-domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
-domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
-create_dir_file(httpd_t, httpdcontent)
-can_exec(httpd_t, httpdcontent )
-', `
-can_exec(httpd_$1_script_t, httpdcontent )
-domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
-')
 create_dir_file(httpd_$1_script_t, httpdcontent)
 }
 
-ifelse($1, sys, `
 #
 # If a user starts a script by hand it gets the proper context
 #
@@ -138,7 +117,38 @@
 domain_auto_trans(sysadm_t, httpd_$1_script_exec_t, httpd_$1_script_t)
 }
 role sysadm_r types httpd_$1_script_t;
-', `
+
+dontaudit httpd_$1_script_t sysctl_kernel_t:dir search;
+dontaudit httpd_$1_script_t sysctl_t:dir search;
+
+############################################
+# Allow scripts to append to http logs
+#########################################
+allow httpd_$1_script_t httpd_log_t:file { getattr append };
+
+# apache should set close-on-exec
+dontaudit  httpd_$1_script_t httpd_t:unix_stream_socket { read write };
+
+################################################################
+# Allow the web server to run scripts and serve pages
+##############################################################
+if (httpd_builtin_scripting) {
+r_dir_file(httpd_t, httpd_$1_script_ro_t)
+create_dir_file(httpd_t, httpd_$1_script_rw_t)
+ra_dir_file(httpd_t, httpd_$1_script_ra_t)
+r_dir_file(httpd_t, httpd_$1_content_t)
+}
+
+')
+define(`apache_user_domain', `
+
+apache_domain($1)
+
+typeattribute httpd_$1_content_t $1_file_type;
+
+if (httpd_enable_cgi && httpd_unified ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
+domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
+}
 
 if (httpd_enable_cgi ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 # If a user starts a script by hand it gets the proper context
@@ -151,11 +161,7 @@
 #########################################
 
 create_dir_file($1_t, { httpd_$1_content_t httpd_$1_script_exec_t })
-create_dir_file($1_crond_t, httpd_$1_content_t)
 allow $1_t { httpd_$1_content_t httpd_$1_script_exec_t }:{ dir file lnk_file } { relabelto relabelfrom };
-ifdef(`mozilla.te', `
-r_dir_file($1_mozilla_t, { httpd_$1_script_exec_t httpd_$1_content_t })
-')
 
 ######################################################################
 # Allow the user to create htaccess files
@@ -178,26 +184,8 @@
 r_dir_file(httpd_$1_script_t, nfs_t)
 ')dnl end if nfs_home_dirs
 }
-')dnl end ifelse sys
-
-dontaudit httpd_$1_script_t sysctl_kernel_t:dir search;
-dontaudit httpd_$1_script_t sysctl_t:dir search;
-
-################################################################
-# Allow the web server to run scripts and serve pages
-##############################################################
-r_dir_file(httpd_t, httpd_$1_content_t)
-
-allow httpd_t httpd_$1_htaccess_t: file r_file_perms;
-
-r_dir_file(httpd_t, httpd_$1_script_rw_t)
-
-############################################
-# Allow scripts to append to http logs
-#########################################
-allow httpd_$1_script_t httpd_log_t:file { getattr append };
-
-# apache should set close-on-exec
-dontaudit  httpd_$1_script_t httpd_t:unix_stream_socket { read write };
+ifdef(`crond.te', `
+create_dir_file($1_crond_t, httpd_$1_content_t)
+')
 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.6/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/macros/program/gift_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -90,6 +90,13 @@
 uses_shlib($1_giftd_t)
 access_terminal($1_giftd_t, $1)
 
+# Read /proc/meminfo
+allow $1_giftd_t proc_t:dir search;
+allow $1_giftd_t proc_t:file read;
+
+# Read /etc/mtab
+allow $1_giftd_t etc_runtime_t:file { getattr read };
+
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
 	
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.23.6/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.6/macros/program/java_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -31,7 +31,7 @@
 can_network_client($1_javaplugin_t)
 allow $1_javaplugin_t port_type:tcp_socket name_connect;
 can_ypbind($1_javaplugin_t)
-allow $1_javaplugin_t self:process { fork signal_perms getsched setsched };
+allow $1_javaplugin_t self:process { execmem fork signal_perms getsched setsched };
 allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow $1_javaplugin_t self:fifo_file rw_file_perms;
 allow $1_javaplugin_t etc_runtime_t:file { getattr read };
@@ -42,6 +42,7 @@
 allow $1_javaplugin_t self:file { getattr read };
 
 read_sysctl($1_javaplugin_t)
+allow $1_javaplugin_t sysctl_vm_t:dir search;
 
 tmp_domain($1_javaplugin)
 r_dir_file($1_javaplugin_t,{ fonts_t usr_t etc_t })
@@ -50,6 +51,11 @@
 allow $1_javaplugin_t bin_t:dir search;
 can_exec($1_javaplugin_t, java_exec_t)
 
+# libdeploy.so legacy
+if (allow_execmod) {
+allow $1_javaplugin_t texrel_shlib_t:file execmod;
+}
+
 # Allow connections to X server.
 ifdef(`xserver.te', `
 
@@ -111,4 +117,6 @@
 dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
 dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
+# Do not audit read/getattr of .fonts-cache-1
+dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.6/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/macros/program/mozilla_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -55,6 +55,7 @@
 
 # for bash - old mozilla binary
 can_exec($1_mozilla_t, mozilla_exec_t)
+can_exec($1_mozilla_t, shell_exec_t)
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
@@ -155,6 +156,11 @@
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
 dbusd_client(system, $1_mozilla)
+ifdef(`apache.te', `
+ifelse($1, sysadm, `', `
+r_dir_file($1_mozilla_t, { httpd_$1_script_exec_t httpd_$1_content_t })
+')
+')
 
 ')dnl end mozilla macro
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.23.6/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.6/macros/program/ssh_agent_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -49,6 +49,7 @@
 allow $1_ssh_agent_t proc_t:dir search;
 dontaudit $1_ssh_agent_t proc_t:{ lnk_file file } { getattr read };
 dontaudit $1_ssh_agent_t selinux_config_t:dir search;
+dontaudit $1_ssh_agent_t selinux_config_t:file { read getattr };
 read_sysctl($1_ssh_agent_t)
 
 # Access the ssh temporary files. Should we have an own type here
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.23.6/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/macros/user_macros.te	2005-04-04 10:44:54.000000000 -0400
@@ -44,7 +44,9 @@
 # user domain and the program, and allow us to maintain separation
 # between different instances of the program being run by different
 # user domains.
-ifdef(`apache.te', `apache_domain($1)')
+ifelse($1, sysadm, `',`
+ifdef(`apache.te', `apache_user_domain($1)')
+')
 ifdef(`slocate.te', `locate_domain($1)')
 ifdef(`lockdev.te', `lockdev_domain($1)')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.6/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.6/tunables/distro.tun	2005-04-04 10:44:54.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.6/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.6/tunables/tunable.tun	2005-04-04 10:44:54.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.6/types/network.te
--- nsapolicy/types/network.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.6/types/network.te	2005-04-04 10:44:54.000000000 -0400
@@ -27,7 +27,7 @@
 type dhcpd_port_t, port_type, reserved_port_type;
 type smbd_port_t, port_type, reserved_port_type;
 type nmbd_port_t, port_type, reserved_port_type;
-type http_cache_port_t, port_type;
+type http_cache_port_t, port_type, reserved_port_type;
 type http_port_t, port_type, reserved_port_type;
 
 ifdef(`cyrus.te', `define(`use_pop')')

--------------020303060305040303000407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
