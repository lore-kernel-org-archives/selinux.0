Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA07613
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 19:54:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA18254
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 23:53:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA18250
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 23:53:25 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E1EE392465
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 09:54:52 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6AB107F68
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 01:54:45 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: patch for home_root_t
Date: Sat, 28 Sep 2002 01:54:44 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8RF4O1VUKU62GF3HHB6P"
Message-Id: <200209280154.44998.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_8RF4O1VUKU62GF3HHB6P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch makes home_root_t work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_8RF4O1VUKU62GF3HHB6P
Content-Type: text/x-diff;
  charset="us-ascii";
  name="d"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="d"

diff -ru /usr/share/selinux/policy/default/domains/admin.te /usr/share/selinux/policy/current/domains/admin.te
--- /usr/share/selinux/policy/default/domains/admin.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/admin.te	2002-09-28 01:47:19.000000000 +0200
@@ -4,6 +4,7 @@
 
 # sysadm_t is the system administrator domain.
 type sysadm_t, domain, privlog, privowner, admin, userdomain, privhome;
+allow privhome home_root_t:dir search;
 
 # system_r is authorized for sysadm_t for single-user mode.
 role system_r types sysadm_t; 
diff -ru /usr/share/selinux/policy/default/domains/program/apache.te /usr/share/selinux/policy/current/domains/program/apache.te
--- /usr/share/selinux/policy/default/domains/program/apache.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/apache.te	2002-09-27 23:54:12.000000000 +0200
@@ -241,6 +241,7 @@
 # Allow the script process to search the cgi directory, and users directory
 ##############################################################################
 allow httpd_user_script_process_t httpd_user_script_t:dir {search add_name};
+allow httpd_user_script_process_t home_root_t:dir { getattr search };
 allow httpd_user_script_process_t user_home_dir_type:dir {getattr search};
 allow httpd_user_script_process_t httpd_user_content_t:dir {search};
 allow httpd_user_script_process_t httpd_sys_script_t:dir {search};
@@ -383,7 +384,8 @@
 ###################
 # Allow httpd to search users diretories
 ######################
-allow httpd_t { user_home_dir_type user_home_type }:dir { getattr search };
+allow httpd_t home_root_t:dir { getattr search };
+allow httpd_t user_home_dir_type:dir { getattr search };
 allow httpd_t user_home_type:dir { getattr search read };
 # need ioctl for php3
 allow httpd_t user_home_type:{ file lnk_file } { getattr read ioctl };
diff -ru /usr/share/selinux/policy/default/domains/program/crond.te /usr/share/selinux/policy/current/domains/program/crond.te
--- /usr/share/selinux/policy/default/domains/program/crond.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/crond.te	2002-09-27 23:54:35.000000000 +0200
@@ -83,6 +83,7 @@
 allow crond_t sysadm_home_dir_t:dir r_dir_perms;
 
 # to search /home
+allow crond_t home_root_t:dir { getattr search };
 allow crond_t user_home_dir_type:dir r_dir_perms;
 
 # Run a shell.
diff -ru /usr/share/selinux/policy/default/domains/program/fcron.te /usr/share/selinux/policy/current/domains/program/fcron.te
--- /usr/share/selinux/policy/default/domains/program/fcron.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/fcron.te	2002-09-27 23:55:06.000000000 +0200
@@ -44,7 +44,7 @@
 allow fcron_t etc_t:lnk_file read;
 allow fcron_t { etc_t resolv_conf_t }:file { read getattr };
 
-allow fcron_t { sysadm_home_dir_t user_home_dir_type }:dir search;
+allow fcron_t { home_root_t sysadm_home_dir_t user_home_dir_type }:dir search;
 
 # Permit fcron_t to transition to this domain.
 # The transition is requested explicitly by the modified crond
diff -ru /usr/share/selinux/policy/default/domains/program/fingerd.te /usr/share/selinux/policy/current/domains/program/fingerd.te
--- /usr/share/selinux/policy/default/domains/program/fingerd.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/fingerd.te	2002-09-27 23:55:24.000000000 +0200
@@ -55,7 +55,7 @@
 can_tcp_connect(userdomain, fingerd_t)
 
 # for .finger, .plan. etc
-allow fingerd_t user_home_dir_type:dir search;
+allow fingerd_t { home_root_t user_home_dir_type }:dir search;
 # should really have a different type for .plan etc
 allow fingerd_t user_home_type:file { getattr read };
 # stop it accessing sub-directories, prevents checking a Maildir for new mail,
diff -ru /usr/share/selinux/policy/default/domains/program/gpg.te /usr/share/selinux/policy/current/domains/program/gpg.te
--- /usr/share/selinux/policy/default/domains/program/gpg.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/gpg.te	2002-09-27 23:56:42.000000000 +0200
@@ -6,8 +6,7 @@
 # Type for gpg or pgp executables.
 type gpg_exec_t, file_type, sysadmfile, exec_type;
 
-allow sysadm_gpg_t user_home_dir_t:dir search;
-allow sysadm_gpg_t newrole_t:fd use;
+allow sysadm_gpg_t { home_root_t user_home_dir_t }:dir search;
 allow sysadm_gpg_t ptyfile:chr_file rw_file_perms;
 
 # Everything else is in the gpg_domain macro in
diff -ru /usr/share/selinux/policy/default/domains/program/initrc.te /usr/share/selinux/policy/current/domains/program/initrc.te
--- /usr/share/selinux/policy/default/domains/program/initrc.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/initrc.te	2002-09-27 23:57:21.000000000 +0200
@@ -213,7 +213,7 @@
 allow initrc_t file_t:file { unlink getattr };
 
 # Read user home directories.
-allow initrc_t home_type:dir r_dir_perms;
+allow initrc_t { home_root_t home_type }:dir r_dir_perms;
 allow initrc_t home_type:file r_file_perms;
 
 # for system start scripts
diff -ru /usr/share/selinux/policy/default/domains/program/login.te /usr/share/selinux/policy/current/domains/program/login.te
--- /usr/share/selinux/policy/default/domains/program/login.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/login.te	2002-09-27 23:58:01.000000000 +0200
@@ -39,6 +39,7 @@
 domain_trans(local_login_t, shell_exec_t, userdomain)
 
 # Permit login to search the user home directories.
+allow local_login_t home_root_t:dir search;
 allow local_login_t home_dir_type:dir search;
 
 # Do not audit denied attempts to access devices.
@@ -122,6 +123,7 @@
 # Only permit unprivileged user domains to be entered via rlogin,
 # since very weak authentication is used.
 domain_trans(remote_login_t, shell_exec_t, unpriv_userdomain)
+allow remote_login_t home_root_t:dir search;
 allow remote_login_t home_dir_type:dir search;
 
 # Use the pty created by rlogind.
diff -ru /usr/share/selinux/policy/default/domains/program/modutil.te /usr/share/selinux/policy/current/domains/program/modutil.te
--- /usr/share/selinux/policy/default/domains/program/modutil.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/modutil.te	2002-09-27 23:58:38.000000000 +0200
@@ -43,7 +43,7 @@
 ifdef(`gnome-pty-helper.te', `allow depmod_t sysadm_gph_t:fd use;')
 
 # Read System.map from home directories.
-allow depmod_t { user_home_dir_type sysadm_home_dir_t }:dir r_dir_perms;
+allow depmod_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir r_dir_perms;
 r_dir_file(depmod_t, { user_home_type sysadm_home_t })
 
 # Rules for /proc/sys/kernel/tainted
diff -ru /usr/share/selinux/policy/default/domains/program/portslave.te /usr/share/selinux/policy/current/domains/program/portslave.te
--- /usr/share/selinux/policy/default/domains/program/portslave.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/portslave.te	2002-09-27 23:59:18.000000000 +0200
@@ -49,7 +49,7 @@
 allow portslave_t ppp_device_t:chr_file rw_file_perms;
 
 # for ~/.ppprc - if it actually exists then you need some policy to read it
-allow portslave_t { sysadm_home_dir_t user_home_dir_type }:dir search;
+allow portslave_t { sysadm_home_dir_t home_root_t user_home_dir_type }:dir search;
 
 file_type_auto_trans(portslave_t, var_run_t, var_run_pppd_t)
 can_exec(portslave_t, { etc_t shell_exec_t })
diff -ru /usr/share/selinux/policy/default/domains/program/pppd.te /usr/share/selinux/policy/current/domains/program/pppd.te
--- /usr/share/selinux/policy/default/domains/program/pppd.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/pppd.te	2002-09-27 23:59:25.000000000 +0200
@@ -66,7 +66,7 @@
 allow pppd_t etc_t:lnk_file read;
 
 # for ~/.ppprc - if it actually exists then you need some policy to read it
-allow pppd_t { sysadm_home_dir_t user_home_dir_type }:dir search;
+allow pppd_t { sysadm_home_dir_t home_root_t user_home_dir_type }:dir search;
 
 ifdef(`pppd_for_user', `
 # Run pppd in pppd_t by default for user
diff -ru /usr/share/selinux/policy/default/domains/program/ssh.te /usr/share/selinux/policy/current/domains/program/ssh.te
--- /usr/share/selinux/policy/default/domains/program/ssh.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/ssh.te	2002-09-28 00:00:03.000000000 +0200
@@ -12,7 +12,7 @@
 allow $1 self:capability { chown dac_override fowner fsetid setgid setuid net_bind_service sys_tty_config };
 can_network($1)
 allow $1 shadow_t:file { read getattr };
-allow $1 { user_home_dir_type sysadm_home_dir_t }:dir { search getattr };
+allow $1 { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };
 
 # Run shells in user_t by default
 domain_auto_trans($1, shell_exec_t, user_t)
diff -ru /usr/share/selinux/policy/default/domains/program/xdm.te /usr/share/selinux/policy/current/domains/program/xdm.te
--- /usr/share/selinux/policy/default/domains/program/xdm.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/domains/program/xdm.te	2002-09-28 00:01:22.000000000 +0200
@@ -111,6 +111,7 @@
 allow xdm_t userdomain:{ file lnk_file } r_file_perms;
 
 # Allow xdm access to the user domains
+allow xdm_t home_root_t:dir search;
 allow xdm_t home_type:dir { write search add_name remove_name create setattr };
 allow xdm_t home_type:file { create link read append  write setattr unlink };
 allow xdm_t userdomain:shm { unix_read unix_write read write getattr associate  };
diff -ru /usr/share/selinux/policy/default/macros/program/crontab_macros.te /usr/share/selinux/policy/current/macros/program/crontab_macros.te
--- /usr/share/selinux/policy/default/macros/program/crontab_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/crontab_macros.te	2002-09-27 23:49:27.000000000 +0200
@@ -65,6 +65,7 @@
 can_network($1_crontab_t)
 
 # Read user crontabs 
+allow $1_crontab_t home_root_t:dir search;
 allow $1_crontab_t { $1_home_t $1_home_dir_t }:dir r_dir_perms;  
 allow $1_crontab_t $1_home_t:file r_file_perms;  
 
diff -ru /usr/share/selinux/policy/default/macros/program/gpg_macros.te /usr/share/selinux/policy/current/macros/program/gpg_macros.te
--- /usr/share/selinux/policy/default/macros/program/gpg_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/gpg_macros.te	2002-09-27 23:47:38.000000000 +0200
@@ -57,6 +57,8 @@
 
 uses_shlib($1_gpg_t)
 
+allow $1_gpg_t home_root_t:dir search;
+
 # use $1_gpg_secret_t for files it creates
 # NB we are doing the type transition for directory creation only!
 # so ~/.gnupg will be of $1_gpg_secret_t, then files created under it such as
diff -ru /usr/share/selinux/policy/default/macros/program/gph_macros.te /usr/share/selinux/policy/current/macros/program/gph_macros.te
--- /usr/share/selinux/policy/default/macros/program/gph_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/gph_macros.te	2002-09-27 23:50:10.000000000 +0200
@@ -66,6 +66,7 @@
 allow $1_gph_t lastlog_t:file rw_file_perms;
 
 # Allow gnome-pty-helper to write the .xsession-errors file.
+allow $1_gph_t home_root_t:dir search;
 allow $1_gph_t $1_home_t:dir { search add_name };
 allow $1_gph_t $1_home_t:file { create write };
 ')
diff -ru /usr/share/selinux/policy/default/macros/program/lpr_macros.te /usr/share/selinux/policy/current/macros/program/lpr_macros.te
--- /usr/share/selinux/policy/default/macros/program/lpr_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/lpr_macros.te	2002-09-27 23:50:31.000000000 +0200
@@ -56,6 +56,7 @@
 ifdef(`gnome-pty-helper.te', `allow $1_lpr_t $1_gph_t:fd use;')
 
 # Read user files. 
+allow $1_lpr_t home_root_t:dir search;
 allow $1_lpr_t { $1_home_t $1_home_dir_t }:dir search;  
 allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
 
diff -ru /usr/share/selinux/policy/default/macros/program/mta_macros.te /usr/share/selinux/policy/current/macros/program/mta_macros.te
--- /usr/share/selinux/policy/default/macros/program/mta_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/mta_macros.te	2002-09-27 23:50:47.000000000 +0200
@@ -72,6 +72,7 @@
 ifdef(`gnome-pty-helper.te', `allow $1_mail_t $1_gph_t:fd use;')
 
 # Create dead.letter in user home directories.
+allow $1_mail_t home_root_t:dir search;
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t)
 
 # if you do not want to allow dead.letter then use the following instead
diff -ru /usr/share/selinux/policy/default/macros/program/netscape_macros.te /usr/share/selinux/policy/current/macros/program/netscape_macros.te
--- /usr/share/selinux/policy/default/macros/program/netscape_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/netscape_macros.te	2002-09-27 23:51:17.000000000 +0200
@@ -100,6 +100,7 @@
 allow $1_netscape_t $1_devpts_t:chr_file rw_file_perms;
 
 # Read the home directory, e.g. for .Xauthority and to get to .netscape.
+allow $1_netscape_t home_root_t:dir search;
 file_type_auto_trans($1_netscape_t, $1_home_dir_t, $1_netscape_rw_t)
 # for .Xauthority - need different perms for this
 allow $1_netscape_t $1_home_t:file { read getattr };
diff -ru /usr/share/selinux/policy/default/macros/program/xserver_macros.te /usr/share/selinux/policy/current/macros/program/xserver_macros.te
--- /usr/share/selinux/policy/default/macros/program/xserver_macros.te	2002-09-27 23:44:35.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/xserver_macros.te	2002-09-27 23:51:52.000000000 +0200
@@ -123,6 +123,8 @@
 # Use the mouse.
 allow $1_xserver_t mouse_device_t:chr_file rw_file_perms;
 
+allow $1_xserver_t home_root_t:dir search;
+
 ifelse($1, xdm, `
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
 ', `

--------------Boundary-00=_8RF4O1VUKU62GF3HHB6P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
