Message-ID: <417D72B8.5040008@redhat.com>
Date: Mon, 25 Oct 2004 17:40:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: latest diffs.
Content-Type: multipart/mixed;
 boundary="------------080807000800060907040909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080807000800060907040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removed more tunables
use_games not needed, if you do not want games, don't include games.te
Added boolean disable_games to disable games transition.

Change nfs_home_dirs to a boolean.

Change user_net_control to a boolean.

Turn off nscd_all_connect (Hopefully eliminate).

Cleanup nscd.

Dan

--------------080807000800060907040909
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.34/attrib.te
--- nsapolicy/attrib.te	2004-10-09 21:06:13.000000000 -0400
+++ policy-1.17.34/attrib.te	2004-10-25 16:45:50.000000000 -0400
@@ -400,4 +400,6 @@
 # For clients of nscd that can use shmem interface.
 attribute nscd_shmem_domain;
 
+# For labeling of content for httpd
+attribute httpdcontent;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.17.34/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.34/domains/program/ssh.te	2004-10-25 17:03:53.000000000 -0400
@@ -73,13 +73,13 @@
 allow $1_t self:capability { sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 can_ypbind($1_t)
-ifdef(`nfs_home_dirs', `
+if (nfs_home_dirs) {
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')
 allow $1_t nfs_t:dir { search getattr };
 allow $1_t nfs_t:file { getattr read };
-')dnl end if nfs_home_dirs
+} dnl end if nfs_home_dirs
 
 ifdef(`single_userdomain', `
 if (ssh_sysadm_login) {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.34/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.34/domains/program/syslogd.te	2004-10-25 16:45:50.000000000 -0400
@@ -96,3 +96,4 @@
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
+dontaudit syslogd_t devpts_t:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.34/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.17.34/domains/program/unused/apache.te	2004-10-25 17:04:37.000000000 -0400
@@ -21,6 +21,8 @@
 ###############################################################################
 type http_port_t, port_type, reserved_port_type;
 
+bool httpd_unified false;
+
 # Allow httpd cgi support
 bool httpd_enable_cgi false;
 
@@ -130,7 +132,7 @@
 
 # execute perl
 allow httpd_t { bin_t sbin_t }:dir r_dir_perms;
-can_exec(httpd_t, bin_t)
+can_exec(httpd_t, { bin_t sbin_t })
 
 can_network(httpd_t)
 can_ypbind(httpd_t)
@@ -247,13 +249,12 @@
 allow httpd_t autofs_t:dir { search getattr };
 allow httpd_suexec_t autofs_t:dir { search getattr };
 ')
-ifdef(`nfs_home_dirs', `
-if (httpd_enable_homedirs) {
+if (nfs_home_dirs && httpd_enable_homedirs) {
 r_dir_file(httpd_t, nfs_t)
 r_dir_file(httpd_suexec_t, nfs_t)
 can_exec(httpd_suexec_t, nfs_t)
 }
-')dnl end if nfs_home_dirs
+
 
 #
 # Allow users to mount additional directories as http_source
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.34/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.34/domains/program/unused/ftpd.te	2004-10-25 17:05:40.000000000 -0400
@@ -96,13 +96,12 @@
 
 # Allow ftp to read/write files in the user home directories.
 bool ftp_home_dir false;
-if (ftp_home_dir) {
-ifdef(`nfs_home_dirs', `
+
+if (ftp_home_dir && nfs_home_dirs) {
 allow ftpd_t nfs_t:dir r_dir_perms;
 allow ftpd_t nfs_t:file r_file_perms;
 # dont allow access to /home
 dontaudit ftpd_t home_root_t:dir { getattr search };
-')dnl end if nfs_home_dirs
 } 
 else 
 {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.34/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.34/domains/program/unused/nscd.te	2004-10-25 16:45:50.000000000 -0400
@@ -3,7 +3,16 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: nscd
 #
-
+define(`nscd_socket_domain', `
+can_unix_connect($1, nscd_t)
+allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
+allow $1 { var_run_t var_t }:dir search;
+allow $1 nscd_t:nscd { getpwd getgrp gethost };
+dontaudit $1 nscd_t:fd { use };
+dontaudit $1 nscd_var_run_t:dir { search getattr };
+dontaudit $1 nscd_var_run_t:file { getattr read };
+dontaudit $1 nscd_t:nscd { shmempwd shmemgrp shmemhost };
+')
 #################################
 #
 # Rules for the nscd_t domain.
@@ -22,31 +31,17 @@
 
 # Clients that can get information via the socket interface.
 ifdef(`nscd_all_connect', `
-can_unix_connect(domain, nscd_t)
-allow domain nscd_var_run_t:sock_file rw_file_perms;
-allow domain { var_run_t var_t }:dir search;
-allow domain nscd_t:nscd { getpwd getgrp gethost };
-dontaudit domain nscd_t:fd { use };
-dontaudit domain nscd_var_run_t:file { getattr read };
-dontaudit domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
+nscd_socket_domain(domain)
 ', `
-can_unix_connect(nscd_client_domain, nscd_t)
-allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
-allow nscd_client_domain { var_run_t var_t }:dir search;
-allow nscd_client_domain nscd_t:nscd { getpwd getgrp gethost };
-dontaudit nscd_client_domain nscd_t:fd { use };
-dontaudit nscd_client_domain nscd_var_run_t:file { getattr read };
-dontaudit nscd_client_domain nscd_t:nscd { shmempwd  shmemgrp shmemhost };
+nscd_socket_domain(nscd_client_domain)
 ')dnl nscd_all_connect
 
 # Clients that are allowed to map the database via a fd obtained from nscd.
-can_unix_connect(nscd_shmem_domain, nscd_t)
-allow nscd_shmem_domain nscd_var_run_t:sock_file rw_file_perms;
-allow nscd_shmem_domain { var_run_t var_t }:dir search;
+nscd_socket_domain(nscd_shmem_domain)
+allow nscd_shmem_domain nscd_var_run_t:dir r_dir_perms;
 allow nscd_shmem_domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
 # Receive fd from nscd and map the backing file with read access.
 allow nscd_shmem_domain nscd_t:fd use;
-allow nscd_shmem_domain nscd_var_run_t:file r_file_perms;
 
 # For client program operation, invoked from sysadm_t.
 # Transition occurs to nscd_t due to direct_sysadm_daemon. 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.17.34/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.17.34/domains/program/unused/spamd.te	2004-10-25 17:06:54.000000000 -0400
@@ -58,10 +58,11 @@
 ifdef(`automount.te', `
 allow spamd_t autofs_t:dir { search getattr };
 ')
-ifdef(`nfs_home_dirs', `
+
+if (nfs_home_dirs) {
 allow spamd_t nfs_t:dir rw_dir_perms;
 allow spamd_t nfs_t:file create_file_perms;
-')dnl end if nfs_home_dirs
+}
 
 allow spamd_t home_root_t:dir { getattr };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.17.34/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.34/domains/program/unused/squid.te	2004-10-25 16:45:50.000000000 -0400
@@ -18,6 +18,7 @@
 
 allow { squid_t initrc_t } squid_conf_t:file r_file_perms;
 allow squid_t squid_conf_t:dir r_dir_perms;
+allow squid_t squid_conf_t:lnk_file read;
 
 logdir_domain(squid)
 typealias squid_log_t alias var_log_squid_t;
@@ -27,7 +28,7 @@
 # type for /var/cache/squid
 type squid_cache_t, file_type, sysadmfile;
 
-allow squid_t self:capability { setgid setuid };
+allow squid_t self:capability { setgid setuid net_bind_service };
 allow squid_t { etc_t etc_runtime_t }:file r_file_perms;
 allow squid_t etc_t:lnk_file read;
 allow squid_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/usernetctl.te policy-1.17.34/domains/program/unused/usernetctl.te
--- nsapolicy/domains/program/unused/usernetctl.te	2004-05-27 14:52:35.000000000 -0400
+++ policy-1.17.34/domains/program/unused/usernetctl.te	2004-10-25 16:52:33.000000000 -0400
@@ -4,10 +4,13 @@
 
 type usernetctl_exec_t, file_type, sysadmfile, exec_type;
 
-ifdef(`user_net_control',`
 type usernetctl_t, domain, privfd;
 
+if (user_net_control) {
 domain_auto_trans(userdomain, usernetctl_exec_t, usernetctl_t)
+} else {
+can_exec(userdomain, usernetctl_exec_t)
+}
 in_user_role(usernetctl_t)
 role sysadm_r types usernetctl_t;
 
@@ -58,7 +61,4 @@
 allow usernetctl_t { var_t var_run_t }:dir { getattr read search };
 allow usernetctl_t etc_runtime_t:file r_file_perms;
 allow usernetctl_t net_conf_t:file r_file_perms;
-',`
-can_exec(userdomain, usernetctl_exec_t)
-')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.17.34/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.34/domains/program/unused/xdm.te	2004-10-25 17:07:13.000000000 -0400
@@ -276,14 +276,14 @@
 allow xdm_xserver_t user_home_type:dir search;
 allow xdm_xserver_t user_home_type:file { getattr read };
 
-ifdef(`nfs_home_dirs', `
+if (nfs_home_dirs) {
 ifdef(`automount.te', `
 allow { xdm_t xdm_xserver_t } autofs_t:dir { search getattr };
 ')
 allow { xdm_t xdm_xserver_t } nfs_t:dir create_dir_perms;
 allow { xdm_t xdm_xserver_t } nfs_t:{file lnk_file} create_file_perms;
 can_exec(xdm_t, nfs_t)
-')dnl end if nfs_home_dirs
+}
 
 # for .dmrc
 allow xdm_t user_home_dir_type:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.17.34/domains/user.te
--- nsapolicy/domains/user.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.17.34/domains/user.te	2004-10-25 17:27:38.000000000 -0400
@@ -7,6 +7,9 @@
 # Allow users to read system messages.
 bool user_dmesg false;
 
+# Support NFS home directories
+bool nfs_home_dirs false;
+
 # Allow users to run TCP servers (bind to ports and accept connection from
 # the same domain and outside users)  disabling this forces FTP passive mode
 # and may change other protocols 
@@ -15,6 +18,12 @@
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
+# Allow users to control network interfaces (also needs USERCTL=true)
+bool user_net_control false;
+
+# Disable games transitions
+bool disable_games false;
+
 # Allow regular users direct mouse access 
 bool user_direct_mouse false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.17.34/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2004-09-09 16:22:13.000000000 -0400
+++ policy-1.17.34/file_contexts/program/named.fc	2004-10-25 16:45:50.000000000 -0400
@@ -18,7 +18,7 @@
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
 /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
-/var/run/named.*		system_u:object_r:named_var_run_t
+/var/run/named(/.*)?		system_u:object_r:named_var_run_t
 /usr/sbin/lwresd	--	system_u:object_r:named_exec_t
 ifdef(`distro_redhat', `
 /var/named/named\.ca	--	system_u:object_r:named_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/nscd.fc policy-1.17.34/file_contexts/program/nscd.fc
--- nsapolicy/file_contexts/program/nscd.fc	2003-11-26 13:01:07.000000000 -0500
+++ policy-1.17.34/file_contexts/program/nscd.fc	2004-10-25 16:45:50.000000000 -0400
@@ -2,3 +2,5 @@
 /usr/sbin/nscd		--	system_u:object_r:nscd_exec_t
 /var/run/\.nscd_socket	-s	system_u:object_r:nscd_var_run_t
 /var/run/nscd\.pid	--	system_u:object_r:nscd_var_run_t
+/var/db/nscd(/.*)?		system_u:object_r:nscd_var_run_t
+/var/run/nscd(/.*)?		system_u:object_r:nscd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pppd.fc policy-1.17.34/file_contexts/program/pppd.fc
--- nsapolicy/file_contexts/program/pppd.fc	2004-07-12 12:15:22.000000000 -0400
+++ policy-1.17.34/file_contexts/program/pppd.fc	2004-10-25 16:45:50.000000000 -0400
@@ -5,6 +5,7 @@
 /dev/pppox.*		-c	system_u:object_r:ppp_device_t
 /dev/ippp.*		-c	system_u:object_r:ppp_device_t
 /var/run/pppd\.tdb	--	system_u:object_r:pppd_var_run_t
+/var/run/ppp(/.*)?		system_u:object_r:pppd_var_run_t
 /etc/ppp		-d	system_u:object_r:pppd_etc_t
 /etc/ppp/.*		--	system_u:object_r:pppd_etc_rw_t
 /etc/ppp/.*secrets	--	system_u:object_r:pppd_secret_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.34/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-10-14 23:25:19.000000000 -0400
+++ policy-1.17.34/file_contexts/types.fc	2004-10-25 16:45:50.000000000 -0400
@@ -266,11 +266,13 @@
 # /etc
 #
 /etc(/.*)?			system_u:object_r:etc_t
+/var/db/.*\.db		--	system_u:object_r:etc_t
 /etc/\.pwd\.lock	--	system_u:object_r:shadow_t
 /etc/passwd\.lock	--	system_u:object_r:shadow_t
 /etc/group\.lock	--	system_u:object_r:shadow_t
 /etc/shadow.*		--	system_u:object_r:shadow_t
 /etc/gshadow.*		--	system_u:object_r:shadow_t
+/var/db/shadow.*	--	system_u:object_r:shadow_t
 /etc/blkid\.tab		--	system_u:object_r:etc_runtime_t
 /etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
 /etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.34/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-10-19 16:03:08.000000000 -0400
+++ policy-1.17.34/macros/base_user_macros.te	2004-10-25 17:00:17.000000000 -0400
@@ -58,10 +58,10 @@
 allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
 can_setfscreate($1_t)
 
-ifdef(`nfs_home_dirs', `
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
+ifdef(`nfs_home_dirs', `
 create_dir_file($1_t, nfs_t)
 can_exec($1_t, nfs_t)
 allow $1_t nfs_t:{ sock_file fifo_file } create_file_perms;
@@ -158,7 +158,7 @@
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
-ifdef(`use_games', `ifdef(`games.te', `games_domain($1)')')
+ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`startx.te', `xserver_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.17.34/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-10-14 23:25:20.000000000 -0400
+++ policy-1.17.34/macros/program/apache_macros.te	2004-10-25 16:45:50.000000000 -0400
@@ -1,26 +1,9 @@
 
 define(`apache_domain', `
 
-undefine(`apache_single_user')
-ifdef(`single_userdomain', `
-ifelse($1, sys, `', `
-define(`apache_single_user')
-')dnl end if
-')dnl end ifdef single_userdomain
-
-ifdef(`apache_single_user', `
-typealias $1_home_t alias httpd_$1_content_t;
-typealias $1_home_t alias httpd_$1_htaccess_t;
-typealias $1_home_t alias httpd_$1_script_exec_t;
-typealias $1_home_t alias httpd_$1_script_ro_t;
-typealias $1_home_t alias httpd_$1_script_rw_t;
-typealias $1_home_t alias httpd_$1_script_ra_t;
-file_type_auto_trans(httpd_$1_script_t, tmp_t, $1_tmp_t)
-', `
-
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
+type httpd_$1_content_t, file_type, homedirfile, httpdcontent, sysadmfile;
 ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 ')
@@ -29,6 +12,8 @@
 #
 type httpd_$1_htaccess_t, file_type, sysadmfile;
 
+# This type is used for executable scripts files
+#
 type httpd_$1_script_exec_t, file_type, sysadmfile;
 
 # Type that CGI scripts run as
@@ -72,10 +57,10 @@
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
-type httpd_$1_script_ro_t, file_type, sysadmfile;
-type httpd_$1_script_rw_t, file_type, sysadmfile;
+type httpd_$1_script_ro_t, file_type, httpdcontent, sysadmfile;
+type httpd_$1_script_rw_t, file_type, httpdcontent, sysadmfile;
+type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile;
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
-type httpd_$1_script_ra_t, file_type, sysadmfile;
 
 ifdef(`slocate.te', `
 ifelse($1, `sys', `', `
@@ -113,6 +98,7 @@
 # Allow the script process to search the cgi directory, and users directory
 ##############################################################################
 allow httpd_$1_script_t httpd_$1_script_exec_t:dir { search getattr };
+can_exec(httpd_$1_script_t, httpd_$1_script_exec_t)
 allow httpd_$1_script_t home_root_t:dir { getattr search };
 allow httpd_$1_script_t httpd_$1_content_t:dir { getattr search };
 
@@ -124,6 +110,18 @@
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
 
+if (httpd_enable_cgi) && (httpd_unified) {
+ifelse($1, sys, `
+domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
+domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
+domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
+', `
+create_dir_file(httpd_$1_script_t, httpdcontent)
+can_exec(httpd_$1_script_t, httpdcontent )
+domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
+')
+}
+
 ifelse($1, sys, `
 #
 # If a user starts a script by hand it gets the proper context
@@ -132,7 +130,6 @@
 role sysadm_r types httpd_$1_script_t;
 ', `
 
-ifdef(`single_userdomain', `', `
 # If a user starts a script by hand it gets the proper context
 domain_auto_trans($1_t, httpd_$1_script_exec_t, httpd_$1_script_t)
 role $1_r types httpd_$1_script_t;
@@ -161,7 +158,6 @@
 
 create_dir_file($1_t, { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t })
 allow $1_t { httpd_$1_script_ro_t httpd_$1_script_rw_t httpd_$1_script_ra_t }:{ file dir lnk_file } { relabelto relabelfrom };
-')dnl end ifdef single_userdomain
 
 # allow accessing files/dirs below the users home dir
 if (httpd_enable_homedirs) {
@@ -184,5 +180,4 @@
 #########################################
 allow httpd_$1_script_t httpd_log_t:file append;
 
-')dnl end apache_single_user
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.17.34/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2004-09-10 10:45:57.000000000 -0400
+++ policy-1.17.34/macros/program/x_client_macros.te	2004-10-25 16:45:50.080029701 -0400
@@ -36,8 +36,15 @@
 ')
 
 # Transition from the user domain to the derived domain.
+ifelse($2, games, `
+if (! disable_games) {
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
 can_exec($1_$2_t, $2_exec_t)
+}
+', `
+domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
+can_exec($1_$2_t, $2_exec_t)
+')
 
 # The user role is authorized for this domain.
 role $1_r types $1_$2_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.17.34/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-10-14 23:25:21.000000000 -0400
+++ policy-1.17.34/targeted/domains/unconfined.te	2004-10-25 17:27:45.000000000 -0400
@@ -38,3 +38,7 @@
 
 allow unconfined_t unlabeled_t:filesystem *;
 allow unlabeled_t self:filesystem { associate };
+
+# Support NFS home directories
+bool nfs_home_dirs false;
+
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.34/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.34/tunables/distro.tun	2004-10-25 16:45:50.080029701 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.34/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-14 23:25:21.000000000 -0400
+++ policy-1.17.34/tunables/tunable.tun	2004-10-25 17:11:52.768849890 -0400
@@ -1,39 +1,30 @@
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
-
-# Support NFS home directories
-dnl define(`nfs_home_dirs')
-
-# Allow users to run games
-dnl define(`use_games')
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

--------------080807000800060907040909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
