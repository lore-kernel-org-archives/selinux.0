Message-ID: <425ED759.7070800@redhat.com>
Date: Thu, 14 Apr 2005 16:49:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------050003070602080007050001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050003070602080007050001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some cleanups in strict to handle turning off unlimitedRC

Add CVS and uucpd policy.  These need work if someone want s to play 
with them.

Added audit_control to login domains to handle pam_loginuid.so

Fixes for syslogng

Cleanup of auditd.te

Netlink changes to handle new auditing pam modules

Fix locations of acrobat

Handle /srv file systems

Add Russell's Compat stuff to make transitioning from targeted to strict 
cleaner

Change location of crack lib

Minor fixes to tighten up name_connect

Eliminate sysadmfile from policy files to separate sysadm_t from secadm_t




-- 



--------------050003070602080007050001
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.23.11/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-03-21 22:32:18.000000000 -0500
+++ policy-1.23.11/domains/program/crond.te	2005-04-14 15:20:16.000000000 -0400
@@ -88,6 +88,8 @@
 
 system_crond_entry(rpm_exec_t, rpm_t)
 allow system_crond_t rpm_log_t:file create_file_perms;
+#read ahead wants to read this
+allow initrc_t system_cron_spool_t:file { getattr read };
 ')
 ')
 
@@ -210,6 +212,6 @@
 # Required for webalizer
 #
 ifdef(`apache.te', `
-allow system_crond_t httpd_log_t:file { getattr read };
+allow system_crond_t { httpd_log_t httpd_config_t }:file { getattr read };
 ')
 dontaudit crond_t self:capability sys_tty_config;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/cvs.te policy-1.23.11/domains/program/cvs.te
--- nsapolicy/domains/program/cvs.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/domains/program/cvs.te	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,16 @@
+#DESC cvs - Concurrent Versions System
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+# Depends: inetd.te
+
+#################################
+#
+# Rules for the cvs_t domain.
+#
+# cvs_exec_t is the type of the cvs executable.
+#
+
+inetd_child_domain(cvs, tcp)
+type cvs_data_t, file_type, sysadmfile;
+create_dir_file(cvs_t, cvs_data_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.11/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.11/domains/program/initrc.te	2005-04-14 15:30:19.000000000 -0400
@@ -12,7 +12,7 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
+type initrc_t, fs_domain, ifdef(`unlimitedRC', `admin, etc_writer, privmem, auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);
@@ -195,10 +195,8 @@
 allow initrc_t tmpfs_t:chr_file rw_file_perms;
 allow initrc_t tmpfs_t:dir r_dir_perms;
 
-ifdef(`distro_redhat', ` 
 # Allow initrc domain to set the enforcing flag.
 can_setenforce(initrc_t)
-')
 
 #
 # readahead asks for these
@@ -209,6 +207,7 @@
 # for /halt /.autofsck and other flag files
 file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
 
+file_type_auto_trans(initrc_t, device_t, fixed_disk_device_t, blk_file)
 ')dnl end distro_redhat
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
@@ -310,3 +309,4 @@
 domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
 ')
 allow initrc_t self:netlink_route_socket r_netlink_socket_perms;
+allow initrc_t device_t:lnk_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/load_policy.te policy-1.23.11/domains/program/load_policy.te
--- nsapolicy/domains/program/load_policy.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/load_policy.te	2005-04-14 15:20:16.000000000 -0400
@@ -58,3 +58,4 @@
 
 read_locale(load_policy_t)
 r_dir_file(load_policy_t, selinux_config_t)
+allow load_policy_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.23.11/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.11/domains/program/login.te	2005-04-14 15:20:16.000000000 -0400
@@ -65,7 +65,7 @@
 ')
 
 # Use capabilities
-allow $1_login_t self:capability { dac_override chown fowner fsetid kill setgid setuid net_bind_service sys_nice sys_resource sys_tty_config };
+allow $1_login_t self:capability { audit_control dac_override chown fowner fsetid kill setgid setuid net_bind_service sys_nice sys_resource sys_tty_config };
 allow $1_login_t self:process setrlimit;
 dontaudit $1_login_t sysfs_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.23.11/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/modutil.te	2005-04-14 15:20:16.000000000 -0400
@@ -54,6 +54,7 @@
 # Read module objects.
 allow depmod_t modules_object_t:dir r_dir_perms;
 allow depmod_t modules_object_t:{ file lnk_file } r_file_perms;
+allow depmod_t modules_object_t:file unlink;
 
 # Access terminals.
 allow depmod_t { console_device_t initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.23.11/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.11/domains/program/ssh.te	2005-04-14 15:20:16.000000000 -0400
@@ -71,7 +71,7 @@
 can_network($1_t)
 allow $1_t port_type:tcp_socket name_connect;
 
-allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
+allow $1_t self:capability { audit_control kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 if (use_nfs_home_dirs) {
 allow $1_t autofs_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.23.11/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-04-04 10:21:10.000000000 -0400
+++ policy-1.23.11/domains/program/syslogd.te	2005-04-14 15:20:16.000000000 -0400
@@ -111,4 +111,6 @@
 allow syslogd_t kernel_t:system { syslog_mod syslog_console };
 allow syslogd_t self:capability { sys_admin chown fsetid };
 allow syslogd_t var_log_t:dir { create setattr };
+allow syslogd_t syslogd_port_t:tcp_socket name_bind;
+allow syslogd_t rsh_port_t:tcp_socket name_connect;
 }
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.11/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-04-07 22:22:55.000000000 -0400
+++ policy-1.23.11/domains/program/unused/apache.te	2005-04-14 15:20:16.000000000 -0400
@@ -401,3 +401,4 @@
 dontaudit system_mail_t httpd_t:tcp_socket { read write };
 ')
 
+allow httpd_t var_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.23.11/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.11/domains/program/unused/auditd.te	2005-04-14 15:20:16.000000000 -0400
@@ -2,11 +2,33 @@
 #
 # Authors: Colin Walters <walters@verbum.org>
 #
+define(`audit_manager_domain', `
+allow $1 auditd_etc_t:file rw_file_perms;
+create_dir_file($1, auditd_log_t)
+')
+
+type auditd_etc_t, file_type, secure_file_type;
 
 daemon_domain(auditd)
-allow auditd_t self:netlink_audit_socket { bind create getattr nlmsg_read nlmsg_write read write };
+
+allow auditd_t self:netlink_audit_socket create_netlink_socket_perms;
 allow auditd_t self:capability { audit_write audit_control };
 allow auditd_t sysadm_tty_device_t:chr_file rw_file_perms;
 allow auditd_t self:unix_dgram_socket create_socket_perms;
 allow auditd_t etc_t:file { getattr read };
-log_domain(auditd)
+
+# Don't use logdir_domain since this is a security file
+type auditd_log_t, file_type, secure_file_type;
+file_type_auto_trans(auditd_t, var_log_t, auditd_log_t, file)
+allow auditd_t auditd_log_t:dir { setattr rw_dir_perms };
+
+can_exec(auditd_t, init_exec_t)
+allow auditd_t auditd_etc_t:file r_file_perms;
+
+audit_manager_domain(secadm_t)
+
+ifdef(`separate_secadm', `', `
+audit_manager_domain(sysadm_t)
+')
+can_exec(auditd_t, init_exec_t)
+allow auditd_t initctl_t:fifo_file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.11/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/unused/cups.te	2005-04-14 15:20:16.000000000 -0400
@@ -166,7 +166,11 @@
 
 allow cupsd_t printconf_t:file { getattr read };
 
+ifdef(`dbusd.te', `
 dbusd_client(system, cupsd)
+allow cupsd_t system_dbusd_t:dbus send_msg;
+allow cupsd_t userdomain:dbus send_msg;
+')
 
 ifdef(`hald.te', `
 
@@ -208,12 +212,10 @@
 dbusd_client(system, cupsd_config)
 allow cupsd_config_t userdomain:dbus send_msg;
 allow cupsd_config_t system_dbusd_t:dbus { send_msg acquire_svc };
-allow cupsd_t system_dbusd_t:dbus send_msg;
+allow cupsd_t hald_t:dbus send_msg;
 allow userdomain cupsd_config_t:dbus send_msg;
 allow cupsd_config_t hald_t:dbus send_msg;
 allow hald_t cupsd_config_t:dbus send_msg;
-allow cupsd_t userdomain:dbus send_msg;
-allow cupsd_t hald_t:dbus send_msg;
 allow hald_t cupsd_t:dbus send_msg;
 ')dnl end if dbusd.te
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dmidecode.te policy-1.23.11/domains/program/unused/dmidecode.te
--- nsapolicy/domains/program/unused/dmidecode.te	2005-04-07 13:17:30.000000000 -0400
+++ policy-1.23.11/domains/program/unused/dmidecode.te	2005-04-14 15:20:16.000000000 -0400
@@ -8,6 +8,7 @@
 
 # Allow execution by the sysadm
 role sysadm_r types dmidecode_t;
+role system_r types dmidecode_t;
 domain_auto_trans(sysadm_t, dmidecode_exec_t, dmidecode_t)
 
 uses_shlib(dmidecode_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.23.11/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/unused/ftpd.te	2005-04-14 15:23:37.000000000 -0400
@@ -9,8 +9,6 @@
 #
 # Rules for the ftpd_t domain 
 #
-type ftp_port_t, port_type, reserved_port_type;
-type ftp_data_port_t, port_type, reserved_port_type;
 daemon_domain(ftpd, `, auth_chkpwd')
 etc_domain(ftpd)
 
@@ -113,7 +111,6 @@
 #
 # Type for access to anon ftp
 #
-type ftpd_anon_t, file_type, sysadmfile, customizable;
 r_dir_file(ftpd_t,ftpd_anon_t)
 type ftpd_anon_rw_t, file_type, sysadmfile, customizable;
 create_dir_file(ftpd_t,ftpd_anon_rw_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.23.11/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	2005-04-14 15:01:53.000000000 -0400
+++ policy-1.23.11/domains/program/unused/NetworkManager.te	2005-04-14 15:20:16.000000000 -0400
@@ -53,6 +53,10 @@
 ')
 allow NetworkManager_t initrc_t:dbus send_msg;
 allow initrc_t NetworkManager_t:dbus send_msg;
+ifdef(`targeted_policy', `
+allow NetworkManager_t unconfined_t:dbus send_msg;
+allow unconfined_t NetworkManager_t:dbus send_msg;
+')
 ')
 
 allow NetworkManager_t usr_t:file { getattr read };
@@ -70,6 +74,7 @@
 
 allow NetworkManager_t { etc_t etc_runtime_t }:file { getattr read };
 allow NetworkManager_t proc_t:file { getattr read };
+r_dir_file(NetworkManager_t, proc_net_t)
 
 allow NetworkManager_t { domain -unrestricted }:dir search;
 allow NetworkManager_t { domain -unrestricted }:file { getattr read };
@@ -80,3 +85,5 @@
 allow NetworkManager_t initrc_var_run_t:file { getattr read };
 
 domain_auto_trans(NetworkManager_t, insmod_exec_t, insmod_t)
+allow NetworkManager_t self:netlink_route_socket r_netlink_socket_perms;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.23.11/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.11/domains/program/unused/ntpd.te	2005-04-14 15:20:16.000000000 -0400
@@ -84,4 +84,4 @@
 allow ntpd_t winbind_var_run_t:dir r_dir_perms;
 allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
 ')
-
+allow sysadm_t ntp_port_t:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/publicfile.te policy-1.23.11/domains/program/unused/publicfile.te
--- nsapolicy/domains/program/unused/publicfile.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.11/domains/program/unused/publicfile.te	2005-04-14 15:20:16.000000000 -0400
@@ -6,12 +6,6 @@
 # this policy depends on ucspi-tcp
 #
 
-ifdef(`ftpd.te', `
-', `
-type ftp_port_t, port_type, reserved_port_type;
-type ftp_data_port_t, port_type, reserved_port_type;
-')
-
 daemon_domain(publicfile)
 type publicfile_content_t, file_type, sysadmfile;
 domain_auto_trans(initrc_t, publicfile_exec_t, publicfile_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.23.11/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.11/domains/program/unused/rshd.te	2005-04-14 15:20:16.000000000 -0400
@@ -9,7 +9,6 @@
 #
 # Rules for the rshd_t domain.
 #
-type rsh_port_t, port_type, reserved_port_type;
 daemon_sub_domain(inetd_t, rshd, `, auth_chkpwd, privuser, privrole')
 
 ifdef(`tcpd.te', `
@@ -24,8 +23,7 @@
 
 # Use the network.
 can_network_server(rshd_t)
-allow rshd_t reserved_port_t:tcp_socket name_bind;
-dontaudit rshd_t reserved_port_type:tcp_socket name_bind;
+allow rshd_t rsh_port_t:tcp_socket name_bind;
 
 can_ypbind(rshd_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.23.11/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.11/domains/program/unused/rsync.te	2005-04-14 15:20:16.000000000 -0400
@@ -14,6 +14,4 @@
 inetd_child_domain(rsync)
 type rsync_data_t, file_type, sysadmfile;
 r_dir_file(rsync_t, rsync_data_t)
-ifdef(`ftpd.te', `
 r_dir_file(rsync_t, ftpd_anon_t)
-')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.23.11/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.11/domains/program/unused/xdm.te	2005-04-14 15:20:16.000000000 -0400
@@ -69,7 +69,7 @@
 
 #
 # Use capabilities.
-allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner };
+allow xdm_t self:capability { audit_control setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner };
 
 allow xdm_t { urandom_device_t random_device_t }:chr_file { getattr read ioctl };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/useradd.te policy-1.23.11/domains/program/useradd.te
--- nsapolicy/domains/program/useradd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.11/domains/program/useradd.te	2005-04-14 15:20:16.000000000 -0400
@@ -98,3 +98,7 @@
 allow groupadd_t self:process setrlimit;
 allow groupadd_t initrc_var_run_t:file r_file_perms;
 dontaudit groupadd_t initrc_var_run_t:file write;
+
+allow useradd_t default_context_t:dir search;
+allow useradd_t file_context_t:dir search;
+allow useradd_t file_context_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/uucpd.te policy-1.23.11/domains/program/uucpd.te
--- nsapolicy/domains/program/uucpd.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/domains/program/uucpd.te	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,24 @@
+#DESC uucpd - UUCP file transfer daemon
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+# Depends: inetd.te
+
+#################################
+#
+# Rules for the uucpd_t domain.
+#
+# uucpd_exec_t is the type of the uucpd executable.
+#
+
+inetd_child_domain(uucpd, tcp)
+type uucpd_rw_t, file_type, sysadmfile;
+type uucpd_ro_t, file_type, sysadmfile;
+type uucpd_spool_t, file_type, sysadmfile;
+create_dir_file(uucpd_t, uucpd_rw_t)
+r_dir_file(uucpd_t, uucpd_ro_t)
+allow uucpd_t sbin_t:dir search;
+can_exec(uucpd_t, sbin_t)
+logdir_domain(uucpd)
+allow uucpd_t var_spool_t:dir search;
+create_dir_file(uucpd_t, uucpd_spool_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.11/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/file_contexts/distros.fc	2005-04-14 15:20:16.000000000 -0400
@@ -150,9 +150,9 @@
 # Java, Sun Microsystems (JPackage SRPM)
 /usr/.*/jre/lib/i386/libdeploy.so		-- system_u:object_r:texrel_shlib_t
 
-/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/.*\.api	-- system_u:object_r:shlib_t
-/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/AcroForm\.api	-- system_u:object_r:texrel_shlib_t
-/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/EScript\.api	-- system_u:object_r:texrel_shlib_t
+/usr(/.*)?/Reader/intellinux/plug_ins/.*\.api	-- system_u:object_r:shlib_t
+/usr(/.*)?/Reader/intellinux/plug_ins/AcroForm\.api	-- system_u:object_r:texrel_shlib_t
+/usr(/.*)?/Reader/intellinux/plug_ins/EScript\.api	-- system_u:object_r:texrel_shlib_t
 
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.23.11/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/file_contexts/program/apache.fc	2005-04-14 15:20:16.000000000 -0400
@@ -1,6 +1,7 @@
 # apache
 HOME_DIR/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_ROLE_content_t
 /var/www(/.*)?			system_u:object_r:httpd_sys_content_t
+/srv/([^/]*/)?www(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
 /usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_exec_t
 /var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/auditd.fc policy-1.23.11/file_contexts/program/auditd.fc
--- nsapolicy/file_contexts/program/auditd.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/file_contexts/program/auditd.fc	2005-04-14 15:20:16.000000000 -0400
@@ -1,4 +1,8 @@
 # auditd
-/sbin/auditd		--	system_u:object_r:auditd_exec_t
 /sbin/auditctl		--	system_u:object_r:auditd_exec_t
-/var/log/audit(/.*)? 	 	system_u:object_r:auditd_log_t
+/sbin/auditd		--	system_u:object_r:auditd_exec_t
+/var/log/audit.log 	-- 	system_u:object_r:auditd_log_t
+/var/log/audit(/.*)?  	 	system_u:object_r:auditd_log_t
+/etc/auditd.conf	--	system_u:object_r:auditd_etc_t
+/etc/audit.rules	--	system_u:object_r:auditd_etc_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/compat.fc policy-1.23.11/file_contexts/program/compat.fc
--- nsapolicy/file_contexts/program/compat.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/file_contexts/program/compat.fc	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,55 @@
+# setfiles
+/usr/sbin/setfiles.*	--	system_u:object_r:setfiles_exec_t
+
+# mount
+/bin/mount.*			--	system_u:object_r:mount_exec_t
+/bin/umount.*			--	system_u:object_r:mount_exec_t
+# restorecon
+/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
+/bin/hostname		--	system_u:object_r:hostname_exec_t
+# consoletype
+/sbin/consoletype	--	system_u:object_r:consoletype_exec_t
+# loadkeys
+/bin/unikeys		--	system_u:object_r:loadkeys_exec_t
+/bin/loadkeys		--	system_u:object_r:loadkeys_exec_t
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
+# kudzu
+/usr/sbin/kudzu	--	system_u:object_r:kudzu_exec_t
+/sbin/kmodule	--	system_u:object_r:kudzu_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/crack.fc policy-1.23.11/file_contexts/program/crack.fc
--- nsapolicy/file_contexts/program/crack.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/file_contexts/program/crack.fc	2005-04-14 15:20:16.000000000 -0400
@@ -2,3 +2,4 @@
 /usr/sbin/crack_[a-z]*	--	system_u:object_r:crack_exec_t
 /var/cache/cracklib(/.*)?	system_u:object_r:crack_db_t
 /usr/lib(64)?/cracklib_dict.* --	system_u:object_r:crack_db_t
+/usr/share/cracklib(/.*)?	system_u:object_r:crack_db_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cvs.fc policy-1.23.11/file_contexts/program/cvs.fc
--- nsapolicy/file_contexts/program/cvs.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/file_contexts/program/cvs.fc	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,2 @@
+# cvs program
+/usr/bin/cvs	--	system_u:object_r:cvs_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ftpd.fc policy-1.23.11/file_contexts/program/ftpd.fc
--- nsapolicy/file_contexts/program/ftpd.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/file_contexts/program/ftpd.fc	2005-04-14 15:20:16.000000000 -0400
@@ -13,3 +13,4 @@
 /var/log/xferreport.*	--	system_u:object_r:xferlog_t
 /etc/cron\.monthly/proftpd --	system_u:object_r:ftpd_exec_t
 /var/ftp(/.*)?			system_u:object_r:ftpd_anon_t
+/srv/([^/]*/)?ftp(/.*)?		system_u:object_r:ftpd_anon_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/i18n_input.fc policy-1.23.11/file_contexts/program/i18n_input.fc
--- nsapolicy/file_contexts/program/i18n_input.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.11/file_contexts/program/i18n_input.fc	2005-04-14 15:20:16.000000000 -0400
@@ -1,6 +1,7 @@
 # i18n_input.fc
 /usr/sbin/htt                   --     system_u:object_r:i18n_input_exec_t
 /usr/sbin/htt_server            --     system_u:object_r:i18n_input_exec_t
+/usr/sbin/iiimd		        --     system_u:object_r:i18n_input_exec_t
 /usr/bin/httx                   --     system_u:object_r:i18n_input_exec_t
 /usr/bin/htt_xbe                --     system_u:object_r:i18n_input_exec_t
 /usr/lib(64)?/im/.*\.so.*       --     system_u:object_r:shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/lvm.fc policy-1.23.11/file_contexts/program/lvm.fc
--- nsapolicy/file_contexts/program/lvm.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/file_contexts/program/lvm.fc	2005-04-14 15:20:16.000000000 -0400
@@ -65,3 +65,4 @@
 /sbin/pvremove     --      system_u:object_r:lvm_exec_t
 /sbin/pvs          --      system_u:object_r:lvm_exec_t
 /sbin/vgs          --      system_u:object_r:lvm_exec_t
+/sbin/multipathd   --      system_u:object_r:lvm_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rsync.fc policy-1.23.11/file_contexts/program/rsync.fc
--- nsapolicy/file_contexts/program/rsync.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/file_contexts/program/rsync.fc	2005-04-14 15:20:16.000000000 -0400
@@ -1,2 +1,3 @@
 # rsync program
 /usr/bin/rsync	--	system_u:object_r:rsync_exec_t
+/srv/([^/]*/)?rsync(/.*)?	system_u:object_r:ftpd_anon_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/uucpd.fc policy-1.23.11/file_contexts/program/uucpd.fc
--- nsapolicy/file_contexts/program/uucpd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/file_contexts/program/uucpd.fc	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,5 @@
+# uucico program
+/usr/sbin/uucico	--	system_u:object_r:uucpd_exec_t
+/var/spool/uucp(/.*)?		system_u:object_r:uucpd_spool_t
+/var/spool/uucppublic(/.*)?	system_u:object_r:uucpd_spool_t
+/var/log/uucp(/.*)?		system_u:object_r:uucpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.23.11/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/file_contexts/types.fc	2005-04-14 15:20:16.000000000 -0400
@@ -478,3 +478,9 @@
 /usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird-bin -- system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/run-mozilla\.sh -- system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/mozilla-xremote-client -- system_u:object_r:bin_t
+
+#
+# /srv
+#
+/srv(/.*)?			system_u:object_r:var_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.11/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-04-07 22:22:55.000000000 -0400
+++ policy-1.23.11/macros/program/apache_macros.te	2005-04-14 15:20:16.000000000 -0400
@@ -39,7 +39,7 @@
 allow httpd_$1_script_t fs_t:filesystem getattr;
 allow httpd_$1_script_t self:unix_stream_socket create_stream_socket_perms;
 
-allow httpd_$1_script_t { self proc_t }:file { getattr read };
+allow httpd_$1_script_t { self proc_t }:file r_file_perms;
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
 allow httpd_$1_script_t { self proc_t }:lnk_file read;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.23.11/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/macros/program/chkpwd_macros.te	2005-04-14 15:20:16.000000000 -0400
@@ -35,6 +35,7 @@
 can_kerberos(auth_chkpwd)
 can_ldap(auth_chkpwd)
 can_resolve(auth_chkpwd)
+allow auth_chkpwd self:netlink_audit_socket create_netlink_socket_perms;
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.11/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-04-07 22:22:55.000000000 -0400
+++ policy-1.23.11/macros/program/mozilla_macros.te	2005-04-14 15:20:16.000000000 -0400
@@ -31,7 +31,10 @@
 # Browse files
 file_browse_domain($1_mozilla_t)
 
-can_network($1_mozilla_t)
+can_network_client($1_mozilla_t)
+allow $1_mozilla_t { ftp_port_t http_port_t }:tcp_socket name_connect;
+#allow $1_mozilla_t port_type:tcp_socket name_connect;
+
 uses_shlib($1_mozilla_t)
 read_locale($1_mozilla_t)
 read_sysctl($1_mozilla_t)
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.23.11/Makefile
--- nsapolicy/Makefile	2005-04-14 15:01:52.000000000 -0400
+++ policy-1.23.11/Makefile	2005-04-14 15:20:16.000000000 -0400
@@ -163,7 +163,7 @@
 	@echo "Validating file contexts files ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
 
-reload tmp/load: $(FCPATH) $(LOADPATH)
+reload tmp/load: $(LOADPATH) 
 	@echo "Loading Policy ..."
 ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
@@ -172,7 +172,7 @@
 endif
 	touch tmp/load
 
-load: tmp/load
+load: tmp/load $(FCPATH) 
 
 enableaudit: policy.conf 
 	grep -v dontaudit policy.conf > policy.audit
@@ -213,8 +213,8 @@
 $(FCPATH): tmp/valid_fc $(USERPATH)/system.users  $(APPDIR)/customizable_types
 	@echo "Installing file contexts files..."
 	@mkdir -p $(CONTEXTPATH)/files
-	install -m 644 $(FC) $(FCPATH)
 	install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
+	install -m 644 $(FC) $(FCPATH)
 	@$(GENHOMEDIRCON) -d $(TOPDIR) -t $(TYPE) $(USEPWD)
 
 $(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.23.11/net_contexts
--- nsapolicy/net_contexts	2005-04-06 06:57:43.000000000 -0400
+++ policy-1.23.11/net_contexts	2005-04-14 15:20:16.000000000 -0400
@@ -38,10 +38,8 @@
 portcon udp 892 system_u:object_r:inetd_child_port_t
 portcon tcp 2105 system_u:object_r:inetd_child_port_t
 ')
-ifdef(`use_ftpd', `
 portcon tcp 20 system_u:object_r:ftp_data_port_t
 portcon tcp 21 system_u:object_r:ftp_port_t
-')
 ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
 ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnetd_port_t')
 
@@ -98,7 +96,8 @@
 portcon udp 636 system_u:object_r:ldap_port_t
 
 ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogind_port_t')
-ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
+portcon tcp 514 system_u:object_r:rsh_port_t
+
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
 ifdef(`syslogd.te', `
 portcon udp 514 system_u:object_r:syslogd_port_t
@@ -121,6 +120,13 @@
 portcon tcp 4444 system_u:object_r:kerberos_master_port_t
 portcon udp 4444 system_u:object_r:kerberos_master_port_t
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
+ifdef(`uucpd.te', `
+portcon tcp 540 system_u:object_r:uucpd_port_t
+')
+ifdef(`cvs.te', `
+portcon tcp 2401 system_u:object_r:cvs_port_t
+portcon udp 2401 system_u:object_r:cvs_port_t
+')
 ifdef(`rsync.te', `
 portcon tcp 873 system_u:object_r:rsync_port_t
 portcon udp 873 system_u:object_r:rsync_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/compat.te policy-1.23.11/targeted/domains/program/compat.te
--- nsapolicy/targeted/domains/program/compat.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.11/targeted/domains/program/compat.te	2005-04-14 15:20:16.000000000 -0400
@@ -0,0 +1,9 @@
+typealias sbin_t alias setfiles_exec_t;
+typealias bin_t alias mount_exec_t;
+typealias sbin_t alias restorecon_exec_t;
+typealias bin_t alias hostname_exec_t;
+typealias sbin_t alias consoletype_exec_t;
+typealias bin_t alias loadkeys_exec_t;
+typealias bin_t alias dmesg_exec_t;
+typealias sbin_t alias fsadm_exec_t;
+typealias sbin_t alias kudzu_exec_t;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.23.11/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.11/targeted/domains/unconfined.te	2005-04-14 15:20:16.000000000 -0400
@@ -15,11 +15,9 @@
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
 typealias bin_t alias su_exec_t;
-typealias unconfined_t alias { kernel_t logrotate_t sendmail_t sshd_t sysadm_t rpm_t rpm_script_t xdm_t };
-define(`admin_tty_type', `{ tty_device_t devpts_t }')
-
-#type of rundir to communicate with dbus
-type system_dbusd_var_run_t, file_type, sysadmfile;
+typealias unconfined_t alias { kernel_t logrotate_t sendmail_t sshd_t secadm_t sysadm_t rpm_t rpm_script_t xdm_t };
+typeattribute tty_device_t admin_tty_type;
+typeattribute devpts_t admin_tty_type;
 
 # User home directory type.
 type user_home_t, file_type, sysadmfile, home_type;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.11/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.11/tunables/distro.tun	2005-04-14 15:20:16.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.11/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/tunables/tunable.tun	2005-04-14 15:21:06.000000000 -0400
@@ -2,7 +2,7 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
 dnl define(`unlimitedUtils')
@@ -20,11 +20,11 @@
 
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.23.11/types/file.te
--- nsapolicy/types/file.te	2005-04-14 15:01:54.000000000 -0400
+++ policy-1.23.11/types/file.te	2005-04-14 15:20:16.000000000 -0400
@@ -318,4 +318,5 @@
 allow file_type removable_t:filesystem associate;
 allow file_type noexattrfile:filesystem associate;
 
-
+# Type for anonymous FTP data, used by ftp and rsync
+type ftpd_anon_t, file_type, sysadmfile, customizable;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.11/types/network.te
--- nsapolicy/types/network.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.11/types/network.te	2005-04-14 15:20:16.000000000 -0400
@@ -22,6 +22,7 @@
 #
 # Defines used by the te files need to be defined outside of net_constraints
 #
+type rsh_port_t, port_type, reserved_port_type;
 type dns_port_t, port_type, reserved_port_type;
 type smtp_port_t, port_type, reserved_port_type;
 type dhcpd_port_t, port_type, reserved_port_type;
@@ -39,12 +40,9 @@
 ifdef(`use_pop', `
 type pop_port_t, port_type, reserved_port_type;
 ')
-ifdef(`ftpd.te', `
-define(`use_ftpd')
-')
-ifdef(`publicfile.te', `
-define(`use_ftpd')
-')
+
+type ftp_port_t, port_type, reserved_port_type;
+type ftp_data_port_t, port_type, reserved_port_type;
 
 ifdef(`dhcpd.te', `define(`use_pxe')')
 ifdef(`pxe.te', `define(`use_pxe')')
diff --exclude-from=exclude -N -u -r nsapolicy/types/security.te policy-1.23.11/types/security.te
--- nsapolicy/types/security.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.11/types/security.te	2005-04-14 15:20:16.000000000 -0400
@@ -24,20 +24,20 @@
 # policy_src_t is the type of the policy source
 # files.
 #
-type policy_src_t, file_type, sysadmfile;
+type policy_src_t, file_type;
 
 
 #
 # default_context_t is the type applied to 
 # /etc/selinux/*/contexts/*
 #
-type default_context_t, file_type, sysadmfile, login_contexts;
+type default_context_t, file_type, login_contexts;
 
 #
 # file_context_t is the type applied to 
 # /etc/selinux/*/contexts/files
 #
-type file_context_t, file_type, sysadmfile;
+type file_context_t, file_type;
 
 #
 # no_access_t is the type for objects that should
@@ -49,6 +49,6 @@
 # selinux_config_t is the type applied to 
 # /etc/selinux/config
 #
-type selinux_config_t, file_type, sysadmfile;
+type selinux_config_t, file_type;
 
 

--------------050003070602080007050001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
