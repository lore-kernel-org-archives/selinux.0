Message-ID: <41768337.3080303@redhat.com>
Date: Wed, 20 Oct 2004 11:24:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------020501060503030704050405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020501060503030704050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added boolean for httpd_unified

Added boolean for disable_games

Fixes for squid and new nscd problems.

Fixes for file_contexts on /var/run directories.

--------------020501060503030704050405
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.17.33/attrib.te
--- nsapolicy/attrib.te	2004-10-09 21:06:13.000000000 -0400
+++ policy-1.17.33/attrib.te	2004-10-19 17:00:46.000000000 -0400
@@ -400,4 +400,6 @@
 # For clients of nscd that can use shmem interface.
 attribute nscd_shmem_domain;
 
+# For labeling of content for httpd
+attribute httpdcontent;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.33/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.17.33/domains/program/syslogd.te	2004-10-20 10:46:38.653452761 -0400
@@ -96,3 +96,4 @@
 dontaudit syslogd_t file_t:dir search;
 allow syslogd_t { tmpfs_t devpts_t }:dir { search };
 dontaudit syslogd_t unlabeled_t:file read;
+dontaudit syslogd_t devpts_t:chr_file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.33/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.17.33/domains/program/unused/apache.te	2004-10-19 17:00:14.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.33/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.17.33/domains/program/unused/nscd.te	2004-10-19 16:54:22.000000000 -0400
@@ -27,10 +27,12 @@
 allow domain { var_run_t var_t }:dir search;
 allow domain nscd_t:nscd { getpwd getgrp gethost };
 dontaudit domain nscd_t:fd { use };
+dontaudit domain nscd_var_run_t:dir { search getattr };
 dontaudit domain nscd_var_run_t:file { getattr read };
 dontaudit domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
 ', `
 can_unix_connect(nscd_client_domain, nscd_t)
+allow nscd_client_domain nscd_var_run_t:dir r_dir_perms;
 allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
 allow nscd_client_domain { var_run_t var_t }:dir search;
 allow nscd_client_domain nscd_t:nscd { getpwd getgrp gethost };
@@ -41,6 +43,7 @@
 
 # Clients that are allowed to map the database via a fd obtained from nscd.
 can_unix_connect(nscd_shmem_domain, nscd_t)
+allow nscd_shmem_domain nscd_var_run_t:dir r_dir_perms;
 allow nscd_shmem_domain nscd_var_run_t:sock_file rw_file_perms;
 allow nscd_shmem_domain { var_run_t var_t }:dir search;
 allow nscd_shmem_domain nscd_t:nscd { shmempwd shmemgrp shmemhost };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.17.33/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.17.33/domains/program/unused/squid.te	2004-10-20 10:49:03.047157346 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.17.33/domains/user.te
--- nsapolicy/domains/user.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.17.33/domains/user.te	2004-10-20 10:57:19.233222439 -0400
@@ -15,6 +15,9 @@
 # Allow users to rw usb devices
 bool user_rw_usb false;
 
+# Disable games transitions
+bool disable_games false;
+
 # Allow regular users direct mouse access 
 bool user_direct_mouse false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.17.33/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2004-09-09 16:22:13.000000000 -0400
+++ policy-1.17.33/file_contexts/program/named.fc	2004-10-19 16:26:50.000000000 -0400
@@ -18,7 +18,7 @@
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
 /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
-/var/run/named.*		system_u:object_r:named_var_run_t
+/var/run/named(/.*)?		system_u:object_r:named_var_run_t
 /usr/sbin/lwresd	--	system_u:object_r:named_exec_t
 ifdef(`distro_redhat', `
 /var/named/named\.ca	--	system_u:object_r:named_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/nscd.fc policy-1.17.33/file_contexts/program/nscd.fc
--- nsapolicy/file_contexts/program/nscd.fc	2003-11-26 13:01:07.000000000 -0500
+++ policy-1.17.33/file_contexts/program/nscd.fc	2004-10-19 16:26:50.000000000 -0400
@@ -2,3 +2,5 @@
 /usr/sbin/nscd		--	system_u:object_r:nscd_exec_t
 /var/run/\.nscd_socket	-s	system_u:object_r:nscd_var_run_t
 /var/run/nscd\.pid	--	system_u:object_r:nscd_var_run_t
+/var/db/nscd(/.*)?		system_u:object_r:nscd_var_run_t
+/var/run/nscd(/.*)?		system_u:object_r:nscd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/pppd.fc policy-1.17.33/file_contexts/program/pppd.fc
--- nsapolicy/file_contexts/program/pppd.fc	2004-07-12 12:15:22.000000000 -0400
+++ policy-1.17.33/file_contexts/program/pppd.fc	2004-10-19 16:26:50.000000000 -0400
@@ -5,6 +5,7 @@
 /dev/pppox.*		-c	system_u:object_r:ppp_device_t
 /dev/ippp.*		-c	system_u:object_r:ppp_device_t
 /var/run/pppd\.tdb	--	system_u:object_r:pppd_var_run_t
+/var/run/ppp(/.*)?		system_u:object_r:pppd_var_run_t
 /etc/ppp		-d	system_u:object_r:pppd_etc_t
 /etc/ppp/.*		--	system_u:object_r:pppd_etc_rw_t
 /etc/ppp/.*secrets	--	system_u:object_r:pppd_secret_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.17.33/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-10-14 23:25:20.000000000 -0400
+++ policy-1.17.33/macros/program/apache_macros.te	2004-10-19 16:58:32.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.17.33/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2004-09-10 10:45:57.000000000 -0400
+++ policy-1.17.33/macros/program/x_client_macros.te	2004-10-20 10:56:22.716592051 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.33/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.33/tunables/distro.tun	2004-10-19 16:26:50.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.33/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-14 23:25:21.000000000 -0400
+++ policy-1.17.33/tunables/tunable.tun	2004-10-19 16:26:50.000000000 -0400
@@ -1,39 +1,39 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
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

--------------020501060503030704050405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
