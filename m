Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA17710
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 12:05:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA19916
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 16:03:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA19911 for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 16:03:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id BF53A92465
	for <selinux@tycho.nsa.gov>; Fri, 11 Oct 2002 02:04:56 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B90F6874
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 18:04:47 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: another policy patch
Date: Thu, 10 Oct 2002 18:04:46 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YNWRJ1IHESY2SS66MDSF"
Message-Id: <200210101804.46869.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_YNWRJ1IHESY2SS66MDSF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

This one has:

Postfix changes Carsten requested

Some named changes that are needed for the latest bind9 (didn't seem to be 
needed for the previous version of bind9 though).

Makes rlogind.te work

Has the Apache2 changes Tom sent me

Has the /proc change to fix that problem that bit Tom

Has some ssh changes (mainly from Brian)

Defines shell_exec_t in types.te (has to be also removed from user.te).  This 
is necessary because sometimes you don't want any users on a system but you 
still need a file type for the shell.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_YNWRJ1IHESY2SS66MDSF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/calamaris.te policy/domains/program/calamaris.te
--- /tmp/policy/domains/program/calamaris.te	2002-10-10 17:50:11.000000000 +0200
+++ policy/domains/program/calamaris.te	2002-10-04 17:19:21.000000000 +0200
@@ -15,7 +15,7 @@
 system_crond_entry(calamaris_exec_t, calamaris_t)
 ')
 
-allow calamaris_t var_t:dir { getattr search };
+allow calamaris_t { var_t var_run_t }:dir { getattr search };
 allow calamaris_t var_log_squid_t:dir search;
 allow calamaris_t var_log_squid_t:file { getattr read };
 type calamaris_www_t, file_type, sysadmfile;
diff -ru /tmp/policy/domains/program/ldconfig.te policy/domains/program/ldconfig.te
--- /tmp/policy/domains/program/ldconfig.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/ldconfig.te	2002-10-10 16:40:32.000000000 +0200
@@ -21,6 +21,8 @@
 
 file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t)
 file_type_auto_trans(ldconfig_t, lib_t, shlib_t)
+# allow removing mis-labelled links
+allow ldconfig_t lib_t:lnk_file unlink;
 
 allow ldconfig_t userdomain:fd use;
 allow ldconfig_t etc_t:file { getattr read };
diff -ru /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2002-10-10 17:50:16.000000000 +0200
+++ policy/domains/program/mrtg.te	2002-10-10 17:53:04.000000000 +0200
@@ -55,6 +55,7 @@
 dontaudit mrtg_t etc_mrtg_t:dir write;
 allow mrtg_t etc_t:lnk_file read;
 
+# for /.autofsck
 dontaudit mrtg_t root_t:file getattr;
 
 allow mrtg_t { sysctl_t sysctl_kernel_t }:dir search;
diff -ru /tmp/policy/domains/program/mta.te policy/domains/program/mta.te
--- /tmp/policy/domains/program/mta.te	2002-10-01 19:28:44.000000000 +0200
+++ policy/domains/program/mta.te	2002-10-10 17:33:27.000000000 +0200
@@ -38,7 +38,7 @@
 allow { system_mail_t mta_user_agent } privmail:fifo_file { read write };
 allow { system_mail_t mta_user_agent } admin_tty_type:chr_file { read write };
 
-allow mta_delivery_agent home_root_t:dir search;
+allow mta_delivery_agent home_root_t:dir { getattr search };
 
 # for piping mail to a command
 can_exec(mta_delivery_agent, shell_exec_t)
diff -ru /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-10-10 17:53:39.000000000 +0200
+++ policy/domains/program/named.te	2002-10-10 16:55:20.000000000 +0200
@@ -110,6 +110,10 @@
 allow ndc_t sysctl_kernel_t:dir r_dir_perms;
 allow ndc_t sysctl_kernel_t:file r_file_perms;
 
+allow ndc_t self:process { fork signal_perms };
+allow ndc_t self:fifo_file { read write getattr ioctl };
+allow ndc_t named_zone_t:dir search;
+
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
 allow ndc_t crond_t:fd use;
@@ -119,11 +123,9 @@
 allow ndc_t etc_runtime_t:file { getattr read };
 allow ndc_t proc_t:dir search;
 allow ndc_t proc_t:file { getattr read };
-allow ndc_t self:process { fork signal_perms };
 can_exec(ndc_t, { bin_t sbin_t shell_exec_t })
 allow ndc_t var_run_named_t:file getattr;
-allow ndc_t self:fifo_file { read write getattr ioctl };
-allow ndc_t named_zone_t:dir { read search getattr };
+allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
 dontaudit ndc_t sysadm_home_t:dir { getattr search read };
 ')
diff -ru /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/postfix.te	2002-10-02 23:35:52.000000000 +0200
@@ -79,7 +79,7 @@
 allow postfix_master_t postfix_public_t:dir rw_dir_perms;
 allow postfix_master_t postfix_private_t:dir rw_dir_perms;
 allow postfix_master_t postfix_private_t:sock_file create_file_perms;
-allow postfix_master_t postfix_private_t:fifo_file getattr;
+allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir r_dir_perms;
@@ -88,8 +88,10 @@
 allow postfix_master_t privfd:fd use;
 allow postfix_master_t etc_aliases_t:file r_file_perms;
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
+allow postfix_master_t random_device_t:chr_file { read getattr };
+allow postfix_master_t postfix_prng_t:file rw_file_perms;
 # should not need read, getattr does not matter
-#allow postfix_master_t admin_tty_type:chr_file { getattr read write };
+allow postfix_master_t admin_tty_type:chr_file { getattr read write };
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
@@ -108,13 +110,13 @@
 domain_auto_trans_read(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
 allow postfix_$1_t self:capability { setuid setgid dac_override };
+can_network(postfix_$1_t)
 ')
 
 postfix_server_domain(smtp)
 allow postfix_smtp_t postfix_spool_t:dir r_dir_perms;
 allow postfix_smtp_t postfix_spool_t:file rw_file_perms;
 allow postfix_smtp_t { postfix_private_t postfix_public_t }:dir search;
-can_network(postfix_smtp_t)
 allow postfix_smtp_t { postfix_private_t postfix_public_t }:sock_file write;
 allow postfix_smtp_t random_device_t:chr_file r_file_perms;
 allow postfix_smtp_t postfix_master_t:unix_stream_socket connectto;
@@ -125,12 +127,10 @@
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:dir search;
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:sock_file rw_file_perms;
 allow postfix_smtpd_t postfix_master_t:unix_stream_socket connectto;
-can_network(postfix_smtpd_t)
 
 allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms;
 
 postfix_server_domain(local, `, mta_delivery_agent')
-can_network(postfix_local_t)
 ifdef(`procmail.te', `
 domain_auto_trans_read(postfix_local_t, procmail_exec_t, procmail_t)
 dontaudit procmail_t postfix_local_t:tcp_socket { read write };
@@ -155,10 +155,10 @@
 postfix_public_domain(cleanup)
 create_dir_file(postfix_cleanup_t, postfix_spool_t)
 allow postfix_cleanup_t postfix_public_t:fifo_file rw_file_perms;
+allow postfix_cleanup_t postfix_public_t:sock_file { getattr write };
 allow postfix_cleanup_t postfix_private_t:dir search;
 allow postfix_cleanup_t postfix_private_t:sock_file rw_file_perms;
 allow postfix_cleanup_t postfix_master_t:unix_stream_socket connectto;
-can_network(postfix_cleanup_t)
 allow postfix_cleanup_t { postfix_spool_bounce_t }:dir r_dir_perms;
 
 allow user_mail_domain etc_postfix_t:dir r_dir_perms;
@@ -218,6 +218,8 @@
 postfix_public_domain(pickup)
 allow postfix_pickup_t postfix_public_t:fifo_file rw_file_perms;
 allow postfix_pickup_t postfix_public_t:sock_file rw_file_perms;
+allow postfix_pickup_t postfix_private_t:dir search;
+allow postfix_pickup_t postfix_private_t:sock_file write;
 allow postfix_pickup_t postfix_master_t:unix_stream_socket connectto;
 allow postfix_pickup_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_pickup_t postfix_spool_maildrop_t:file r_file_perms;
@@ -230,7 +232,6 @@
 allow postfix_qmgr_t postfix_private_t:dir search;
 allow postfix_qmgr_t postfix_private_t:sock_file rw_file_perms;
 allow postfix_qmgr_t postfix_master_t:unix_stream_socket connectto;
-can_network(postfix_qmgr_t)
 
 # for /var/spool/postfix/active
 create_dir_file(postfix_qmgr_t, postfix_spool_t)
diff -ru /tmp/policy/domains/program/qmail.te policy/domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-10-10 17:50:17.000000000 +0200
+++ policy/domains/program/qmail.te	2002-10-04 17:13:55.000000000 +0200
@@ -99,6 +99,8 @@
 allow qmail_local_t qmail_spool_t:file { ioctl read };
 allow qmail_local_t self:fifo_file write;
 allow qmail_local_t sbin_t:dir search;
+allow qmail_local_t self:unix_stream_socket create_stream_socket_perms;
+allow qmail_local_t etc_t:file { getattr read };
 
 # for piping mail to a command
 can_exec(qmail_local_t, shell_exec_t)
diff -ru /tmp/policy/domains/program/rlogind.te policy/domains/program/rlogind.te
--- /tmp/policy/domains/program/rlogind.te	2002-10-10 17:50:18.000000000 +0200
+++ policy/domains/program/rlogind.te	2002-10-02 01:39:47.000000000 +0200
@@ -8,7 +8,7 @@
 # Rules for the rlogind_t domain.
 #
 type rlogin_port_t, port_type;
-type rlogind_t, domain, privlog, auth;
+type rlogind_t, domain, privlog, auth, privfd;
 role system_r types rlogind_t;
 every_domain(rlogind_t)
 type rlogind_exec_t, file_type, sysadmfile, exec_type;
@@ -38,6 +38,7 @@
 
 # Create ptys.
 can_create_pty(rlogind)
+allow rlogind_t userpty_type:chr_file setattr;
 
 # Modify /var/run/utmp.
 allow rlogind_t initrc_var_run_t:file rw_file_perms;
diff -ru /tmp/policy/domains/program/ssh.te policy/domains/program/ssh.te
--- /tmp/policy/domains/program/ssh.te	2002-10-01 19:28:47.000000000 +0200
+++ policy/domains/program/ssh.te	2002-10-10 16:53:05.000000000 +0200
@@ -57,12 +57,18 @@
 type_transition init_t sshd_exec_t:process sshd_t;
 type sshd_key_t, file_type, sysadmfile;
 
+# so a tunnel can point to another ssh tunnel...
+can_tcp_connect(sshd_t, sshd_t)
+
 type sshd_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(sshd_t, tmp_t, sshd_tmp_t)
 
 # Inherit and use descriptors from init.
 allow sshd_t init_t:fd use;
 
+# for startup error messages
+#allow sshd_t admin_tty_type:chr_file { read write };
+
 # Can create ptys
 can_create_pty(sshd)
 
diff -ru /tmp/policy/file_contexts/program/apache.fc policy/file_contexts/program/apache.fc
--- /tmp/policy/file_contexts/program/apache.fc	2002-09-27 22:27:39.000000000 +0200
+++ policy/file_contexts/program/apache.fc	2002-10-08 18:59:15.000000000 +0200
@@ -2,6 +2,7 @@
 /var/www/html(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/mrtg(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/www/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
+/usr/lib/cgi-bin(/.*)?		system_u:object_r:httpd_sys_script_t
 /var/www/perl(/.*)?		system_u:object_r:httpd_sys_script_t
 /var/www/icons(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/cache/httpd(/.*)?		system_u:object_r:httpd_cache_t
@@ -9,14 +10,17 @@
 /etc/httpd/conf(/.*)?		system_u:object_r:httpd_config_t
 /etc/httpd/logs			system_u:object_r:httpd_log_files_t
 /etc/httpd/modules		system_u:object_r:httpd_modules_t
+/etc/apache(2)?(/.*)?		system_u:object_r:httpd_config_t
+/etc/vhosts			system_u:object_r:httpd_config_t
 /usr/lib/apache(/.*)?		system_u:object_r:httpd_modules_t
+/usr/lib/apache2/modules(/.*)?	system_u:object_r:httpd_modules_t
 /usr/sbin/httpd			system_u:object_r:httpd_exec_t
-/usr/sbin/apache		system_u:object_r:httpd_exec_t
+/usr/sbin/apache(2)?		system_u:object_r:httpd_exec_t
 /usr/sbin/suexec		system_u:object_r:httpd_suexec_exec_t
 /usr/lib/cgi-bin/(nph-)?cgiwrap(d)? system_u:object_r:httpd_suexec_exec_t
-/usr/lib/apache/suexec		system_u:object_r:httpd_suexec_exec_t
+/usr/lib/apache(2)?/suexec(2)?	system_u:object_r:httpd_suexec_exec_t
 /var/log/httpd(/.*)?		system_u:object_r:httpd_log_files_t
-/var/log/apache(/.*)?		system_u:object_r:httpd_log_files_t
+/var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_files_t
 /var/log/cgiwrap.log.*		system_u:object_r:httpd_log_files_t
 /var/cache/ssl.*\.sem		system_u:object_r:httpd_cache_t
-/var/run/apache.pid		system_u:object_r:httpd_var_run_t
+/var/run/apache(2)?.pid.*	system_u:object_r:httpd_var_run_t
diff -ru /tmp/policy/file_contexts/program/dpkg.fc policy/file_contexts/program/dpkg.fc
--- /tmp/policy/file_contexts/program/dpkg.fc	2002-09-21 05:01:29.000000000 +0200
+++ policy/file_contexts/program/dpkg.fc	2002-10-10 17:00:13.000000000 +0200
@@ -31,3 +31,4 @@
 /etc/kde2/.*\.sh		system_u:object_r:install_menu_exec_t
 # run_deb
 /usr/sbin/se_dpkg		system_u:object_r:run_deb_exec_t
+/var/run/update-menus.pid	system_u:object_r:install_menu_var_run_t
diff -ru /tmp/policy/file_contexts/types.fc policy/file_contexts/types.fc
--- /tmp/policy/file_contexts/types.fc	2002-09-27 22:27:39.000000000 +0200
+++ policy/file_contexts/types.fc	2002-10-08 19:11:43.000000000 +0200
@@ -143,6 +144,8 @@
 /dev/cpu/mtrr			system_u:object_r:mtrr_device_t
 /dev/(radio|video|vbi|vtx).*	system_u:object_r:v4l_device_t
 
+/proc(/.*)?			<<none>>
+
 #
 # /etc
 #
diff -ru /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2002-10-01 19:28:53.000000000 +0200
+++ policy/macros/program/ssh_macros.te	2002-10-10 17:31:30.000000000 +0200
@@ -50,6 +50,7 @@
 # Access the users .ssh directory.
 type $1_home_ssh_t, file_type, sysadmfile;
 file_type_auto_trans({ sysadm_ssh_t $1_ssh_t }, $1_home_dir_t, $1_home_ssh_t)
+allow { sysadm_ssh_t $1_ssh_t } $1_home_ssh_t:lnk_file { getattr read };
 dontaudit $1_ssh_t $1_home_t:dir search;
 r_dir_file(sshd_t, $1_home_ssh_t)
 rw_dir_create_file($1_t, $1_home_ssh_t)
@@ -73,6 +74,7 @@
 # Allow the ssh program to communicate with ssh-agent.
 allow $1_ssh_t $1_tmp_t:sock_file write;
 allow $1_ssh_t $1_t:unix_stream_socket connectto;
+allow $1_ssh_t sshd_t:unix_stream_socket connectto;
 
 ifdef(`xserver.te', `
 # Communicate with the X server.
diff -ru /tmp/policy/types/file.te policy/types/file.te
--- /tmp/policy/types/file.te	2002-09-27 22:27:44.000000000 +0200
+++ policy/types/file.te	2002-10-10 17:57:16.000000000 +0200
@@ -131,6 +131,11 @@
 type ls_exec_t, file_type, exec_type, sysadmfile;
 
 #
+# shell_exec_t is the type of user shells such as /bin/bash.
+#
+type shell_exec_t, file_type, exec_type, sysadmfile;
+
+#
 # sbin_t is the type of files in the system sbin directories.
 #
 type sbin_t, file_type, sysadmfile;

--------------Boundary-00=_YNWRJ1IHESY2SS66MDSF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
