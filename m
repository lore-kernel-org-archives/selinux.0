Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA14053
	for <selinux@tycho.nsa.gov>; Wed, 1 Jan 2003 11:54:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h01GsTI13323
	for <selinux@tycho.nsa.gov>; Wed, 1 Jan 2003 16:54:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h01GsQf13319 for <selinux@tycho.nsa.gov>; Wed, 1 Jan 2003 16:54:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5F5CF9246B
	for <selinux@tycho.nsa.gov>; Thu,  2 Jan 2003 03:54:23 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1E51637F
	for <selinux@tycho.nsa.gov>; Wed,  1 Jan 2003 17:54:21 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: latest policy patch
Date: Wed, 1 Jan 2003 17:54:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_80xE+oD9a/d3zVv"
Message-Id: <200301011754.20570.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_80xE+oD9a/d3zVv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a policy patch against the latest CVS tree.

It contains a number of patches I've already posted here and a new patch for 
login.te that uses a macro for the local_login_t and remote_login_t domains.

This patch adds the attributes { mlstrustedreader mlstrustedwriter 
mlstrustedobject } to remote_login_t, I am not sure if this is OK.

Also I added a number of small things to remote_login_t (such as access to 
check for new mail) to make it have equivalent functionality to 
local_login_t.

I did this when I noticed that telnet logins to my system were not working due 
to policy deficiencies so I decided to do it right.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_80xE+oD9a/d3zVv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ruN /tmp/policy/domains/misc/auth-net.te ./domains/misc/auth-net.te
--- /tmp/policy/domains/misc/auth-net.te	1970-01-01 01:00:00.000000000 +0100
+++ ./domains/misc/auth-net.te	2002-12-28 21:46:38.000000000 +0100
@@ -0,0 +1,4 @@
+#DESC Policy for using network servers for authenticating users (IE PAM-LDAP)
+
+can_network(auth)
+allow auth resolv_conf_t:file { getattr read };
diff -ruN /tmp/policy/domains/program/bootloader.te ./domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-12-16 17:06:02.000000000 +0100
+++ ./domains/program/bootloader.te	2002-12-13 21:03:06.000000000 +0100
@@ -48,6 +48,7 @@
 
 # for ldd
 allow bootloader_t { insmod_exec_t fsadm_exec_t }:file { rx_file_perms execute_no_trans };
+allow bootloader_t insmod_exec_t:lnk_file { getattr read };
 
 dontaudit bootloader_t sysadm_home_dir_t:dir search;
 
diff -ruN /tmp/policy/domains/program/crack.te ./domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-12-03 15:56:39.000000000 +0100
+++ ./domains/program/crack.te	2002-12-13 21:03:18.000000000 +0100
@@ -35,4 +35,6 @@
 allow crack_t { etc_t etc_runtime_t }:file { getattr read };
 allow crack_t etc_t:dir r_dir_perms;
 
+allow crack_t fs_t:filesystem getattr;
+
 dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
diff -ruN /tmp/policy/domains/program/crond.te ./domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2002-12-03 15:56:39.000000000 +0100
+++ ./domains/program/crond.te	2002-12-13 21:03:38.000000000 +0100
@@ -37,7 +37,7 @@
 file_type_auto_trans(crond_t, var_log_t, cron_log_t)
 
 # Use capabilities.
-allow crond_t crond_t:capability { setgid setuid net_bind_service };
+allow crond_t crond_t:capability { setgid setuid net_bind_service dac_override };
 
 # Check entrypoint permission on crontab files.
 allow crond_t security_t:security compute_av;
diff -ruN /tmp/policy/domains/program/dpkg.te ./domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-12-03 15:56:40.000000000 +0100
+++ ./domains/program/dpkg.te	2002-12-28 21:24:16.000000000 +0100
@@ -25,7 +25,7 @@
 can_exec(dpkg_t, init_exec_t)
 file_type_auto_trans(dpkg_t, tmp_t, tmp_dpkg_t)
 ifdef(`mta.te', `
-allow system_mail_t tmp_dpkg_t:file read;
+allow system_mail_t tmp_dpkg_t:file { getattr read };
 ')
 
 allow dpkg_t random_device_t:chr_file read;
@@ -70,6 +70,10 @@
 domain_auto_trans(dpkg_t, klogd_exec_t, klogd_t)
 domain_auto_trans(dpkg_t, syslogd_exec_t, syslogd_t)
 ')
+# mysqld is broken too
+ifdef(`mysqld.te', `
+domain_auto_trans(dpkg_t, mysqld_exec_t, mysqld_t)
+')
 
 # for apt
 type apt_t, domain, admin, privmail;
diff -ruN /tmp/policy/domains/program/fsadm.te ./domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2002-11-04 13:27:51.000000000 +0100
+++ ./domains/program/fsadm.te	2002-12-13 21:54:24.000000000 +0100
@@ -22,6 +22,9 @@
 type fsadm_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(fsadm_t, tmp_t, fsadm_tmp_t)
 
+# remount file system to apply changes
+allow fsadm_t fs_t:filesystem remount;
+
 # Use capabilities.
 allow fsadm_t fsadm_t:capability { sys_admin sys_rawio };
 
diff -ruN /tmp/policy/domains/program/hotplug.te ./domains/program/hotplug.te
--- /tmp/policy/domains/program/hotplug.te	2002-12-03 15:56:40.000000000 +0100
+++ ./domains/program/hotplug.te	2002-12-13 21:05:01.000000000 +0100
@@ -47,6 +47,7 @@
 
 domain_auto_trans(kmod_t, hotplug_exec_t, hotplug_t)
 domain_auto_trans_read(hotplug_t, insmod_exec_t, insmod_t)
+allow hotplug_t insmod_exec_t:lnk_file read;
 domain_auto_trans_read(hotplug_t, mount_exec_t, mount_t)
 domain_auto_trans_read(hotplug_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`pump.te', `domain_auto_trans_read(hotplug_t, pump_exec_t, pump_t)')
diff -ruN /tmp/policy/domains/program/login.te ./domains/program/login.te
--- /tmp/policy/domains/program/login.te	2002-10-23 21:38:17.000000000 +0200
+++ ./domains/program/login.te	2003-01-01 17:50:12.000000000 +0100
@@ -1,5 +1,6 @@
 #
 # Authors:  Stephen Smalley <sds@tislabs.com> and Timothy Fraser <tfraser@tislabs.com> (NAI Labs) 
+# Macroised by Russell Coker <russell@coker.com.au>
 #
 
 #################################
@@ -8,37 +9,74 @@
 # and the remote_login_t domain.
 #
 
+# $1 is the name of the domain (local or remote)
+# I added "mlstrustedreader, mlstrustedwriter, mlstrustedobject" to
+# remote_login_t, not sure if this is right
+define(`login_domain', `
+type $1_login_t, domain, privuser, privrole, privlog, auth, privowner, mlstrustedreader, mlstrustedwriter, mlstrustedobject, privfd;
+role system_r types $1_login_t;
+every_domain($1_login_t)
+
+tmp_domain($1_login)
+
+# Use capabilities
+allow $1_login_t self:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override sys_nice sys_resource };
+
+# Run shells in user_t by default.
+domain_auto_trans($1_login_t, shell_exec_t, user_t)
+
+# Permit login to search the user home directories.
+allow $1_login_t home_root_t:dir search;
+allow $1_login_t home_dir_type:dir search;
+
+# Write to /var/run/utmp.
+allow $1_login_t initrc_var_run_t:file rw_file_perms;
+
+# Write to /var/log/wtmp.
+allow $1_login_t wtmp_t:file rw_file_perms;
+
+# Write to /var/log/lastlog.
+allow $1_login_t lastlog_t:file rw_file_perms;
+
+# Write to /var/log/btmp
+allow $1_login_t faillog_t:file { append read write };
+
+# Search for mail spool file.
+allow $1_login_t mail_spool_t:dir r_dir_perms;
+allow $1_login_t mail_spool_t:file getattr;
+allow $1_login_t mail_spool_t:lnk_file read;
+
+# Determine the set of legal user SIDs that can be reached.
+allow $1_login_t security_t:security get_user_sids;
+
+# Obtain the SID to use for relabeling terminals.
+allow $1_login_t security_t:security change_sid;
+
+# allow read access to default_contexts in /etc/security
+allow $1_login_t default_context_t:file r_file_perms;
+
+')
+
 #################################
 #
 # Rules for the local_login_t domain.
 #
 # local_login_t is the domain of a login process 
 # spawned by getty.
+#
+# remote_login_t is the domain of a login process 
+# spawned by rlogind.
+#
 # login_exec_t is the type of the login program
 #
-type local_login_t, domain, privuser, privrole, privlog, auth, privowner, mlstrustedreader, mlstrustedwriter, mlstrustedobject, privfd;
-role system_r types local_login_t;
-every_domain(local_login_t)
 type login_exec_t, file_type, sysadmfile, exec_type;
 type_transition init_t login_exec_t:process local_login_t;
 
-type local_login_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(local_login_t, tmp_t, local_login_tmp_t)
-
-# Use capabilities.
-allow local_login_t local_login_t:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override sys_resource };
+login_domain(local)
 
-allow local_login_t shadow_t:file { read getattr };
-
-# Run shells in user_t by default.
-domain_auto_trans(local_login_t, shell_exec_t, user_t)
 # But also permit other user domains to be entered by login.
 domain_trans(local_login_t, shell_exec_t, userdomain)
 
-# Permit login to search the user home directories.
-allow local_login_t home_root_t:dir search;
-allow local_login_t home_dir_type:dir search;
-
 # Do not audit denied attempts to access devices.
 dontaudit local_login_t fixed_disk_device_t:blk_file { getattr setattr };
 dontaudit local_login_t removable_device_t:blk_file { getattr setattr };
@@ -52,29 +90,11 @@
 # Do not audit denied attempts to access /mnt.
 dontaudit local_login_t file_t:dir r_dir_perms;
 
-# Write to /var/run/utmp.
-allow local_login_t initrc_var_run_t:file rw_file_perms;
-
-# Write to /var/log/wtmp.
-allow local_login_t wtmp_t:file rw_file_perms;
-
-# Write to /var/log/lastlog.
-allow local_login_t lastlog_t:file rw_file_perms;
-
-# Write to /var/log/btmp
-allow local_login_t faillog_t:file { append read write };
 
 # Create lock file.
 allow local_login_t var_lock_t:dir rw_dir_perms;
 allow local_login_t var_lock_t:file create_file_perms;
 
-# Search for mail spool file.
-allow local_login_t mail_spool_t:dir r_dir_perms;
-allow local_login_t mail_spool_t:file getattr;
-allow local_login_t mail_spool_t:lnk_file read;
-
-# Obtain the SID to use for relabeling terminals.
-allow local_login_t security_t:security change_sid;
 
 # Read and write ttys.
 allow local_login_t tty_device_t:chr_file { setattr rw_file_perms };
@@ -94,65 +114,24 @@
 allow local_login_t var_run_t:dir rw_dir_perms;
 allow local_login_t var_run_t:file create_file_perms;
 
-# allow read access to default_contexts in /etc/security
-allow local_login_t default_context_t:file r_file_perms;
-
-# Determine the set of legal user SIDs that can be reached.
-allow local_login_t security_t:security get_user_sids;
-
 #################################
 #
 # Rules for the remote_login_t domain.
 #
-# remote_login_t is the domain of a login process 
-# spawned by rlogind.
-#
-type remote_login_t, domain, privuser, privrole, privlog, auth, privowner, privfd;
-role system_r types remote_login_t;
-every_domain(remote_login_t)
-
-type remote_login_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(remote_login_t, tmp_t, remote_login_tmp_t)
 
-# Use capabilities.
-allow remote_login_t remote_login_t:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override };
+login_domain(remote)
 
-# Run shells in user_t by default.
-domain_auto_trans(remote_login_t, shell_exec_t, user_t)
 # Only permit unprivileged user domains to be entered via rlogin,
 # since very weak authentication is used.
 domain_trans(remote_login_t, shell_exec_t, unpriv_userdomain)
-allow remote_login_t home_root_t:dir search;
-allow remote_login_t home_dir_type:dir search;
 
 # Use the pty created by rlogind.
 ifdef(`rlogind.te', `
 allow remote_login_t rlogind_devpts_t:chr_file { setattr rw_file_perms };
 ')
 
-# Write to /var/run/utmp.
-allow remote_login_t initrc_var_run_t:file rw_file_perms;
-
-# Write to /var/log/wtmp.
-allow remote_login_t wtmp_t:file rw_file_perms;
-
-# Write to /var/log/lastlog.
-allow remote_login_t lastlog_t:file rw_file_perms;
-
-# Search for mail spool file.
-allow remote_login_t mail_spool_t:dir r_dir_perms;
-allow remote_login_t mail_spool_t:file getattr;
-
-# Obtain the SID to use for relabeling ptys.
-allow remote_login_t security_t:security change_sid;
-
 # Relabel ptys created by rlogind.
 ifdef(`rlogind.te',
 `allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };')
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto };
 
-# allow read access to default_context in /etc/security
-allow remote_login_t default_context_t:file r_file_perms;
-
-# Determine the set of legal user SIDs that can be reached.
-allow remote_login_t security_t:security get_user_sids;
diff -ruN /tmp/policy/domains/program/modutil.te ./domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2002-12-16 17:06:04.000000000 +0100
+++ ./domains/program/modutil.te	2002-12-29 21:47:13.000000000 +0100
@@ -55,10 +55,7 @@
 allow insmod_t var_log_ksyms_t:dir create_dir_perms;
 
 ifdef(`crond.te', `
-# for old modutils
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)
-# for new modutils that is 2.5 compatable
-can_exec(insmod_t, bin_t)
 ')
 
 #################################
@@ -126,7 +123,7 @@
 allow update_modules_t self:process { fork sigchld };
 allow update_modules_t self:fifo_file rw_file_perms;
 allow update_modules_t modules_dep_t:file rw_file_perms;
-r_dir_file(update_modules_t, modules_object_t)
+file_type_auto_trans(update_modules_t, modules_object_t, modules_conf_t)
 domain_auto_trans_read(update_modules_t, depmod_exec_t, depmod_t)
 can_exec(update_modules_t, bin_t)
 allow update_modules_t { sbin_t bin_t }:dir search;
diff -ruN /tmp/policy/domains/program/nsd.te ./domains/program/nsd.te
--- /tmp/policy/domains/program/nsd.te	1970-01-01 01:00:00.000000000 +0100
+++ ./domains/program/nsd.te	2002-12-28 21:40:01.000000000 +0100
@@ -0,0 +1,51 @@
+#DESC Authoritative only name server
+#
+# Author: Russell Coker
+# 
+#
+
+#################################
+#
+# Rules for the nsd_t domain.
+#
+ifdef(`named.te', `', `
+type named_port_t, port_type;
+')
+
+daemon_domain(nsd)
+
+# A type for configuration files of nsd
+type nsd_conf_t, file_type, sysadmfile;
+# A type for zone files
+type nsd_zone_t, file_type, sysadmfile;
+
+r_dir_file(nsd_t, { nsd_conf_t nsd_zone_t })
+r_dir_file(initrc_t, nsd_conf_t)
+
+# Use capabilities. Surplus capabilities may be allowed.
+allow nsd_t self:capability { setuid setgid net_bind_service };
+
+allow nsd_t etc_t:{ file lnk_file } { getattr read };
+allow nsd_t resolv_conf_t:file { getattr read };
+
+# nsd can use network
+can_network(nsd_t)
+# allow client access from caching BIND
+ifdef(`named.te', `
+can_udp_send(named_t, nsd_t)
+can_udp_send(nsd_t, named_t)
+can_tcp_connect(named_t, nsd_t)
+')
+
+# if you want to allow all programs to contact the primary name server
+#can_udp_send(domain, nsd_t)
+#can_udp_send(nsd_t, domain)
+#can_tcp_connect(domain, nsd_t)
+
+# Bind to the named port.
+allow nsd_t named_port_t:udp_socket name_bind;
+allow nsd_t named_port_t:tcp_socket name_bind;
+
+allow nsd_t self:unix_stream_socket create_stream_socket_perms;
+allow nsd_t self:unix_dgram_socket create_socket_perms;
+
diff -ruN /tmp/policy/domains/program/postfix.te ./domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-12-03 15:56:41.000000000 +0100
+++ ./domains/program/postfix.te	2002-12-28 21:07:50.000000000 +0100
@@ -82,14 +82,15 @@
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
-allow postfix_master_t postfix_spool_maildrop_t:dir r_dir_perms;
+allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
+allow postfix_master_t postfix_spool_maildrop_t:file { rename getattr };
 allow postfix_master_t postfix_prng_t:file getattr;
-allow postfix_master_t postfix_spool_maildrop_t:file getattr;
 allow postfix_master_t privfd:fd use;
 allow postfix_master_t etc_aliases_t:file r_file_perms;
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
 allow postfix_master_t random_device_t:chr_file { read getattr };
 allow postfix_master_t postfix_prng_t:file rw_file_perms;
+file_type_auto_trans(postfix_master_t, var_spool_t, postfix_spool_t, dir)
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
@@ -125,6 +126,7 @@
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:dir search;
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:sock_file rw_file_perms;
 allow postfix_smtpd_t postfix_master_t:unix_stream_socket connectto;
+allow postfix_smtpd_t etc_aliases_t:file r_file_perms;
 
 allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms;
 
@@ -134,7 +136,7 @@
 # for a bug in the postfix local program
 dontaudit procmail_t postfix_local_t:tcp_socket { read write };
 ')
-allow postfix_local_t { etc_aliases_t }:file r_file_perms;
+allow postfix_local_t etc_aliases_t:file r_file_perms;
 allow postfix_local_t self:fifo_file rw_file_perms;
 allow postfix_local_t postfix_spool_t:dir r_dir_perms;
 allow postfix_local_t postfix_spool_t:file rw_file_perms;
@@ -241,7 +243,7 @@
 type postfix_spool_bounce_t, file_type, sysadmfile;
 create_dir_file(postfix_bounce_t, postfix_spool_bounce_t)
 create_dir_file(postfix_bounce_t, postfix_spool_t)
-allow postfix_master_t postfix_spool_bounce_t:dir r_dir_perms;
+allow postfix_master_t postfix_spool_bounce_t:dir create_dir_perms;
 allow postfix_bounce_t self:capability { dac_read_search };
 allow postfix_bounce_t postfix_public_t:sock_file write;
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
diff -ruN /tmp/policy/domains/program/procmail.te ./domains/program/procmail.te
--- /tmp/policy/domains/program/procmail.te	2002-12-03 15:56:41.000000000 +0100
+++ ./domains/program/procmail.te	2002-12-16 17:19:07.000000000 +0100
@@ -22,12 +22,14 @@
 allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
 
 allow procmail_t etc_t:dir r_dir_perms;
-allow procmail_t { etc_t resolv_conf_t }:file r_file_perms;
+allow procmail_t { etc_t etc_runtime_t resolv_conf_t }:file { getattr read };
 allow procmail_t etc_t:lnk_file read;
 
-allow procmail_t self:process { setsched fork sigchld };
+allow procmail_t self:process { setsched fork sigchld signal };
 can_exec(procmail_t, { bin_t shell_exec_t })
-allow procmail_t self:fifo_file { read write getattr };
+allow procmail_t bin_t:dir search;
+allow procmail_t bin_t:lnk_file read;
+allow procmail_t self:fifo_file rw_file_perms;
 
 allow procmail_t self:unix_stream_socket create_socket_perms;
 allow procmail_t self:unix_dgram_socket create_socket_perms;
@@ -50,3 +52,6 @@
 
 # Do not audit attempts to access /root.
 dontaudit procmail_t sysadm_home_dir_t:dir { getattr search };
+
+allow procmail_t devtty_t:chr_file { read write };
+
diff -ruN /tmp/policy/domains/program/quota.te ./domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-12-03 15:56:42.000000000 +0100
+++ ./domains/program/quota.te	2002-12-13 21:07:17.000000000 +0100
@@ -15,7 +15,7 @@
 rw_dir_create_file(initrc_t, quota_flag_t)
 
 allow quota_t fs_t:filesystem { getattr quotaget quotamod };
-allow quota_t home_root_t:dir getattr;
+allow quota_t { home_root_t var_t usr_t src_t }:dir getattr;
 allow quota_t self:capability sys_admin;
 allow quota_t file_t:file quotaon;
 
diff -ruN /tmp/policy/domains/program/samba.te ./domains/program/samba.te
--- /tmp/policy/domains/program/samba.te	2002-10-28 21:31:46.000000000 +0100
+++ ./domains/program/samba.te	2002-12-26 15:33:14.000000000 +0100
@@ -20,7 +20,7 @@
 allow smbd_t var_run_nmbd_t:file rw_file_perms;
 
 ifdef(`crond.te', `
-allow system_crond_t samba_etc_t:file { read getattr };
+allow system_crond_t samba_etc_t:file { read getattr lock };
 ')
 
 #################################
@@ -48,7 +48,7 @@
 #allow smbd_t samba_etc_t:dir { search getattr };
 file_type_auto_trans(smbd_t, samba_etc_t, samba_secrets_t, file)
 
-allow smbd_t samba_etc_t:file { getattr read };
+allow smbd_t samba_etc_t:file { getattr read lock };
 
 # Permissions for Samba cache files in /var/cache/samba
 allow smbd_t samba_var_t:dir { write remove_name add_name lock getattr search };
diff -ruN /tmp/policy/domains/program/slapd.te ./domains/program/slapd.te
--- /tmp/policy/domains/program/slapd.te	2002-10-28 22:55:57.000000000 +0100
+++ ./domains/program/slapd.te	2002-12-28 21:07:50.000000000 +0100
@@ -44,6 +44,9 @@
 # read config files
 allow slapd_t { etc_t etc_slapd_t resolv_conf_t etc_runtime_t }:{ file lnk_file } r_file_perms;
 
+# for startup script
+allow initrc_t etc_slapd_t:file read;
+
 allow slapd_t etc_t:dir r_dir_perms;
 
 allow slapd_t sysctl_kernel_t:dir search;
diff -ruN /tmp/policy/file_contexts/program/crond.fc ./file_contexts/program/crond.fc
--- /tmp/policy/file_contexts/program/crond.fc	2002-11-29 12:19:36.000000000 +0100
+++ ./file_contexts/program/crond.fc	2002-12-28 21:08:31.000000000 +0100
@@ -16,4 +16,5 @@
 /var/spool/fcron		system_u:object_r:cron_spool_t
 /var/spool/fcron/.*		<<none>>
 /var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
+/var/spool/fcron/systab		system_u:object_r:sysadm_cron_spool_t
 /var/run/fcron.fifo		system_u:object_r:var_run_crond_t
diff -ruN /tmp/policy/file_contexts/program/fsadm.fc ./file_contexts/program/fsadm.fc
--- /tmp/policy/file_contexts/program/fsadm.fc	2002-12-03 15:56:44.000000000 +0100
+++ ./file_contexts/program/fsadm.fc	2002-12-13 21:56:43.000000000 +0100
@@ -4,6 +4,7 @@
 /sbin/e2fsck			system_u:object_r:fsadm_exec_t
 /sbin/reiserfs(ck|tune)		system_u:object_r:fsadm_exec_t
 /sbin/mkreiserfs		system_u:object_r:fsadm_exec_t
+/sbin/resize.*fs		system_u:object_r:fsadm_exec_t
 /sbin/e2label			system_u:object_r:fsadm_exec_t
 /sbin/mkfs			system_u:object_r:fsadm_exec_t
 /sbin/mke2fs			system_u:object_r:fsadm_exec_t
@@ -12,6 +13,7 @@
 /sbin/sfdisk			system_u:object_r:fsadm_exec_t
 /sbin/cfdisk			system_u:object_r:fsadm_exec_t
 /sbin/fdisk			system_u:object_r:fsadm_exec_t
+/sbin/parted			system_u:object_r:fsadm_exec_t
 /sbin/tune2fs			system_u:object_r:fsadm_exec_t
 /sbin/dumpe2fs			system_u:object_r:fsadm_exec_t
 /sbin/swapon			system_u:object_r:fsadm_exec_t
diff -ruN /tmp/policy/file_contexts/program/initrc.fc ./file_contexts/program/initrc.fc
--- /tmp/policy/file_contexts/program/initrc.fc	2002-10-28 22:56:00.000000000 +0100
+++ ./file_contexts/program/initrc.fc	2002-12-13 21:08:39.000000000 +0100
@@ -11,3 +11,4 @@
 /usr/local/selinux/sbin/open_init_pty	system_u:object_r:initrc_exec_t
 /usr/sbin/run_init		system_u:object_r:run_init_exec_t
 /usr/sbin/open_init_pty		system_u:object_r:initrc_exec_t
+/etc/nologin.boot		system_u:object_r:etc_runtime_t
diff -ruN /tmp/policy/file_contexts/program/modutil.fc ./file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2002-12-16 17:06:32.000000000 +0100
+++ ./file_contexts/program/modutil.fc	2002-12-29 21:48:19.000000000 +0100
@@ -2,9 +2,10 @@
 /etc/modules.conf(.old)?	system_u:object_r:modules_conf_t
 /lib/modules(/.*)?		system_u:object_r:modules_object_t
 /lib/modules/[^/]*/modules\..* system_u:object_r:modules_dep_t
+/lib/modules/modprobe.conf	system_u:object_r:modules_conf_t
 /sbin/depmod.*			system_u:object_r:depmod_exec_t
 /sbin/modprobe.*		system_u:object_r:insmod_exec_t
 /sbin/insmod.*			system_u:object_r:insmod_exec_t
-/sbin/insmod.static		system_u:object_r:insmod_exec_t
+/sbin/insmod_ksymoops_clean	system_u:object_r:sbin_t
 /sbin/rmmod.*			system_u:object_r:insmod_exec_t
 /sbin/update-modules		system_u:object_r:update_modules_exec_t
diff -ruN /tmp/policy/file_contexts/program/nsd.fc ./file_contexts/program/nsd.fc
--- /tmp/policy/file_contexts/program/nsd.fc	1970-01-01 01:00:00.000000000 +0100
+++ ./file_contexts/program/nsd.fc	2002-12-28 21:32:56.000000000 +0100
@@ -0,0 +1,4 @@
+# nsd
+/etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
+/usr/sbin/nsd      		system_u:object_r:nsd_exec_t
+/var/run/nsd.pid		system_u:object_r:var_run_nsd_t
diff -ruN /tmp/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2002-12-03 15:56:45.000000000 +0100
+++ ./file_contexts/program/postfix.fc	2002-12-28 21:08:31.000000000 +0100
@@ -25,6 +25,7 @@
 /usr/sbin/postsuper		system_u:object_r:postfix_master_exec_t
 /usr/sbin/rmail			system_u:object_r:postfix_master_exec_t
 /var/spool/postfix/active(/.*)?	system_u:object_r:postfix_spool_t
+/var/spool/postfix/hold(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/incoming(/.*)? system_u:object_r:postfix_spool_t
 /var/spool/postfix/maildrop(/.*)? system_u:object_r:postfix_spool_maildrop_t
 /var/spool/postfix/pid		system_u:object_r:var_run_t
diff -ruN /tmp/policy/file_contexts/program/postgresql.fc ./file_contexts/program/postgresql.fc
--- /tmp/policy/file_contexts/program/postgresql.fc	2002-08-23 20:44:20.000000000 +0200
+++ ./file_contexts/program/postgresql.fc	2002-12-13 21:08:39.000000000 +0100
@@ -4,3 +4,4 @@
 /var/run/postgresql(/.*)?	system_u:object_r:var_run_postgresql_t
 /etc/postgresql(/.*)?		system_u:object_r:etc_postgresql_t
 /var/log/postgres.log.*		system_u:object_r:postgresql_log_t
+/var/log/postgresql(/.*)?	system_u:object_r:postgresql_log_t
diff -ruN /tmp/policy/file_contexts/program/slapd.fc ./file_contexts/program/slapd.fc
--- /tmp/policy/file_contexts/program/slapd.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/slapd.fc	2002-12-13 21:54:50.000000000 +0100
@@ -3,3 +3,4 @@
 /var/lib/ldap(/.*)?		system_u:object_r:slapd_db_t
 /var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd.args		system_u:object_r:var_run_slapd_t
+/etc/ldap/slapd.conf		system_u:object_r:etc_slapd_t
diff -ruN /tmp/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2002-10-23 21:38:26.000000000 +0200
+++ ./macros/program/ssh_macros.te	2002-12-13 21:10:46.000000000 +0100
@@ -69,7 +69,7 @@
 allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
 
 # Allow the user shell to signal the ssh program.
-allow $1_t $1_ssh_t:process signal;
+allow $1_t $1_ssh_t:process { signal setpgid };
 # allow ps to show ssh
 allow $1_t $1_ssh_t:dir { search getattr read };
 allow $1_t $1_ssh_t:{ file lnk_file } { read getattr };

--Boundary-00=_80xE+oD9a/d3zVv--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
