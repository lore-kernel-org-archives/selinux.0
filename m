From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: inetd and login
Date: Mon, 20 Jan 2003 01:33:05 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BP0K+KSbujEymVu"
Message-Id: <200301200133.05142.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_BP0K+KSbujEymVu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch to re-write the inetd and login policy using macros.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_BP0K+KSbujEymVu
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rewrite.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rewrite.diff"

diff -ruwN /tmp/policy/domains/program/inetd.te policy/domains/program/inetd.te
--- /tmp/policy/domains/program/inetd.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/inetd.te	2003-01-19 11:20:30.000000000 +0100
@@ -1,6 +1,7 @@
 #DESC Inetd - Internet services daemon
 #
 # Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
+# re-written with daemon_domain by Russell Coker <russell@coker.com.au>
 #
 
 #################################
@@ -13,22 +14,17 @@
 #
 # Rules for the inetd_t domain.
 #
-type inetd_t, domain, privlog;
-role system_r types inetd_t;
-every_domain(inetd_t)
-type inetd_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(initrc_t, inetd_exec_t, inetd_t)
-type_transition init_t inetd_exec_t:process inetd_t;
-
-type inetd_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(inetd_t, tmp_t, inetd_tmp_t)
-type inetd_var_run_t, file_type, sysadmfile, pidfile;
-file_type_auto_trans(inetd_t, var_run_t, inetd_var_run_t)
-type var_log_inetd_t, file_type, sysadmfile;
-file_type_auto_trans(inetd_t, var_log_t, var_log_inetd_t)
+daemon_domain(inetd)
 
-# Inherit and use descriptors from init.
-allow inetd_t init_t:fd use;
+can_network(inetd_t)
+allow inetd_t self:unix_dgram_socket create_socket_perms;
+allow inetd_t self:unix_stream_socket create_socket_perms;
+allow inetd_t etc_t:lnk_file read;
+allow inetd_t inetd_t:process setsched;
+allow inetd_t resolv_conf_t:file { getattr read };
+
+log_domain(inetd)
+tmp_domain(inetd)
 
 # Use capabilities.
 allow inetd_t self:capability { setuid setgid net_bind_service };
diff -ruwN /tmp/policy/domains/program/login.te policy/domains/program/login.te
--- /tmp/policy/domains/program/login.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/login.te	2003-01-18 14:42:29.000000000 +0100
@@ -1,6 +1,7 @@
 #DESC Login - Local/remote login utilities
 #
 # Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
+# Macroised by Russell Coker <russell@coker.com.au>
 #
 
 #################################
@@ -9,37 +10,74 @@
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
@@ -53,29 +91,11 @@
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
@@ -95,65 +115,24 @@
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

--Boundary-00=_BP0K+KSbujEymVu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
