Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA05248
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 17:43:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10724
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 21:41:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10714
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 21:41:29 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3DD7492465
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 07:42:57 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A87109F6A
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 23:42:49 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new policy patch
Date: Fri, 27 Sep 2002 23:42:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DN94ZB6WVJS8BQOTDNH9"
Message-Id: <200209272342.49247.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_DN94ZB6WVJS8BQOTDNH9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch has my latest changes.  A minor dpkg patch, some qmail 
changes that are particularly needed for mailman and other things that 
require mail being piped, samba changes for /etc/samba/secrets.tdb, type 
labelling for the suseradd program, a squid cron job policy change, and a 
change that hopefully fixes the su gph problem Brian reported.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_DN94ZB6WVJS8BQOTDNH9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="new.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="new.diff"

diff -ru /tmp/policy/domains/program/dpkg.te ./domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-27 22:27:37.000000000 +0200
+++ ./domains/program/dpkg.te	2002-09-27 17:39:34.000000000 +0200
@@ -59,7 +59,7 @@
 ')
 
 # for apt
-type apt_t, domain, admin;
+type apt_t, domain, admin, privmail;
 type apt_exec_t, file_type, sysadmfile, exec_type;
 type var_lib_apt_t, file_type, sysadmfile;
 type var_cache_apt_t, file_type, sysadmfile;
@@ -71,6 +71,7 @@
 file_type_auto_trans(apt_t, tmp_t, tmp_apt_t)
 
 dontaudit apt_t var_log_t:dir getattr;
+dontaudit apt_t var_run_t:dir search;
 
 # for rc files such as ~/.less
 r_dir_file(apt_t, sysadm_home_t)
diff -ru /tmp/policy/domains/program/qmail.te ./domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-09-27 22:27:38.000000000 +0200
+++ ./domains/program/qmail.te	2002-09-26 19:23:10.000000000 +0200
@@ -27,7 +27,7 @@
 # qmail_$1_exec_t is the type of the qmail_$1 executables.
 #
 define(`qmail_daemon_domain', `
-daemon_sub_domain(qmail_start_t, qmail_$1)
+daemon_sub_domain(qmail_start_t, qmail_$1, `$2')
 allow qmail_$1_t qmail_start_t:fifo_file { read write };
 
 ')dnl
@@ -36,7 +36,7 @@
 
 allow qmail_start_t self:capability setgid;
 
-qmail_daemon_domain(lspawn)
+qmail_daemon_domain(lspawn, `, mta_delivery_agent')
 allow qmail_lspawn_t self:fifo_file { read write };
 allow qmail_lspawn_t self:capability { setuid setgid };
 allow qmail_lspawn_t self:process fork;
@@ -95,10 +95,17 @@
 allow qmail_local_t qmail_queue_exec_t:file read;
 allow qmail_local_t etc_qmail_t:dir { getattr read search };
 allow qmail_local_t etc_qmail_t:file { getattr read };
-allow qmail_local_t qmail_spool_t:file read;
+allow qmail_local_t qmail_spool_t:file { ioctl read };
 allow qmail_local_t self:fifo_file write;
 allow qmail_local_t sbin_t:dir search;
 
+# for piping mail to a command
+can_exec(qmail_local_t, shell_exec_t)
+allow qmail_local_t bin_t:dir search;
+allow qmail_local_t bin_t:lnk_file read;
+allow qmail_local_t devtty_t:chr_file rw_file_perms;
+allow qmail_local_t { etc_runtime_t proc_t }:file { getattr read };
+
 daemon_sub_domain(tcpd_t, qmail_tcp_env)
 allow qmail_tcp_env_t inetd_t:fd use;
 allow qmail_tcp_env_t inetd_t:tcp_socket { read write getattr };
diff -ru /tmp/policy/domains/program/samba.te ./domains/program/samba.te
--- /tmp/policy/domains/program/samba.te	2002-08-23 21:04:28.000000000 +0200
+++ ./domains/program/samba.te	2002-09-27 22:58:07.000000000 +0200
@@ -14,6 +14,7 @@
 type samba_log_t, file_type, sysadmfile, logfile;
 type samba_var_t, file_type, sysadmfile;
 type samba_share_t, file_type, sysadmfile;
+type samba_secrets_t, file_type, sysadmfile;
 
 #################################
 #
@@ -35,9 +36,12 @@
 can_network(smbd_t)
 
 # Permissions for Samba files in /etc/samba
-#allow smbd_t samba_etc_t:file { write setattr getattr read lock };
+# either allow read access to the directory or allow the auto_trans rule to
+# allow creation of the secrets.tdb file
+#allow smbd_t samba_etc_t:dir { search getattr };
+file_type_auto_trans(smbd_t, samba_etc_t, samba_secrets_t, file)
+
 allow smbd_t samba_etc_t:file { getattr read };
-allow smbd_t samba_etc_t:dir { search getattr };
 
 # Permissions for Samba cache files in /var/cache/samba
 allow smbd_t samba_var_t:dir { write remove_name add_name lock getattr search };
diff -ru /tmp/policy/domains/program/squid.te ./domains/program/squid.te
--- /tmp/policy/domains/program/squid.te	2002-08-23 21:04:28.000000000 +0200
+++ ./domains/program/squid.te	2002-09-22 22:39:19.000000000 +0200
@@ -50,6 +50,7 @@
 allow squid_t var_log_squid_t:file create_file_perms;
 ifdef(`logrotate.te',
 `domain_auto_trans(logrotate_t, squid_exec_t, squid_t)')
+ifdef(`crond.te', `domain_auto_trans(system_crond_t, squid_exec_t, squid_t)')
 
 # Use the network
 can_network(squid_t)
diff -ru /tmp/policy/file_contexts/program/passwd.fc ./file_contexts/program/passwd.fc
--- /tmp/policy/file_contexts/program/passwd.fc	2002-09-27 22:27:40.000000000 +0200
+++ ./file_contexts/program/passwd.fc	2002-08-22 21:49:40.000000000 +0200
@@ -3,9 +3,11 @@
 /usr/local/selinux/bin/schsh	system_u:object_r:passwd_exec_t
 /usr/local/selinux/bin/schfn	system_u:object_r:passwd_exec_t
 /usr/local/selinux/bin/svipw    system_u:object_r:admin_passwd_exec_t
+/usr/local/selinux/bin/suseradd system_u:object_r:admin_passwd_exec_t
 /usr/local/selinux/bin/sadminpasswd system_u:object_r:admin_passwd_exec_t
 /usr/bin/spasswd		system_u:object_r:passwd_exec_t
 /usr/bin/schsh			system_u:object_r:passwd_exec_t
 /usr/bin/schfn			system_u:object_r:passwd_exec_t
 /usr/bin/svipw                 system_u:object_r:admin_passwd_exec_t
+/usr/bin/suseradd              system_u:object_r:admin_passwd_exec_t
 /usr/bin/sadminpasswd          system_u:object_r:admin_passwd_exec_t
diff -ru /tmp/policy/file_contexts/program/samba.fc ./file_contexts/program/samba.fc
--- /tmp/policy/file_contexts/program/samba.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/samba.fc	2002-09-27 22:58:30.000000000 +0200
@@ -4,5 +4,4 @@
 /etc/samba(/.*)?		system_u:object_r:samba_etc_t
 /var/log/samba(/.*)?		system_u:object_r:samba_log_t
 /var/cache/samba(/.*)?		system_u:object_r:samba_var_t
-#/net/music(/.*)?		system_u:object_r:samba_share_t
-#/net/pub(/.*)?			system_u:object_r:samba_share_t
+/etc/samba/secrets.tdb		system_u:object_r:samba_secrets_t
diff -ru /tmp/policy/macros/program/su_macros.te ./macros/program/su_macros.te
--- /tmp/policy/macros/program/su_macros.te	2002-09-27 22:27:44.000000000 +0200
+++ ./macros/program/su_macros.te	2002-09-27 12:52:43.000000000 +0200
@@ -34,11 +34,6 @@
 # Revert to the user domain when a shell is executed.
 domain_auto_trans($1_su_t, shell_exec_t, $1_t)
 
-# Inherit and use descriptors from gnome-pty-helper.
-ifdef(`gnome-pty-helper.te',
-`allow $1_su_t $1_gph_t:fd use;
-allow $1_t $1_gph_t:fd use;')
-
 allow $1_su_t privfd:fd use;
 
 # Write to utmp.
@@ -53,6 +48,11 @@
 # Run chkpwd.
 can_exec($1_su_t, chkpwd_exec_t)
 
+# Inherit and use descriptors from gnome-pty-helper.
+ifdef(`gnome-pty-helper.te', `
+allow { $1_su_t $1_t } $1_gph_t:fd use;
+')
+
 # The user role is authorized for this domain.
 role $1_r types $1_su_t;
 

--------------Boundary-00=_DN94ZB6WVJS8BQOTDNH9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
