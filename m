Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18436
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 07:47:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA06325
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:45:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id LAA06321 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:45:32 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01273
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 07:47:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA15675
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 18:56:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05401
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 22:54:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA05397
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 22:54:25 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1717492465
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 08:55:53 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 50F77157D
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 00:55:39 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new policy
Date: Mon, 30 Sep 2002 00:55:38 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QC28JQL41YFQ29AOW354"
Message-Id: <200209300055.39193.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The archive newfiles.tar.gz of new policy files I've written which aren't yet 
in the CVS.

The patch can_net.diff which removes duplicate calls to can_network().  This 
makes the resulting policy.conf smaller and makes it easier to grep.

The patch mta.diff has some new changes related to mail servers.  Of 
particular note, I finally got qmail fully working in enforcing mode - and 
the policy has changed a lot.

The netscape changes in netscape.diff rely on the new file x_client_macros.te, 
it is about splitting the X access part of it into a separate file so the 
same policy is also used by other programs that use X but which are not 
entirely trusted.

The file diff contains other small patches, including some that are required 
for the netscape patch, and for the new xauth policy that is needed for a 
separate type for the ~/.Xauthority file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: application/x-tgz;
  name="newfiles.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="newfiles.tar.gz"

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

--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: text/x-diff;
  charset="us-ascii";
  name="can_net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="can_net.diff"

diff -ru /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/domains/program/crond.te	2002-09-29 23:46:30.000000000 +0200
@@ -15,7 +15,7 @@
 # The system_r role is authorized for this domain.
 role system_r types crond_t;
 
-# This domain is granted permissions common to most domains. 
+# This domain is granted permissions common to most domains (including can_net)
 every_domain(crond_t)
 
 # Type for the crond executable.
@@ -65,9 +65,6 @@
 # Inherit and use descriptors from init.
 allow crond_t init_t:fd use;
 
-# Use the network.
-can_network(crond_t)
-
 # Read from /var/spool/cron.
 allow crond_t cron_spool_t:dir r_dir_perms;
 allow crond_t cron_spool_t:file r_file_perms;
diff -ru /tmp/policy/domains/program/cups.te policy/domains/program/cups.te
--- /tmp/policy/domains/program/cups.te	2002-08-23 20:44:18.000000000 +0200
+++ policy/domains/program/cups.te	2002-09-29 22:39:01.000000000 +0200
@@ -46,9 +46,6 @@
 # Inherit and use descriptors from init.
 allow cupsd_t init_t:fd use;
 
-# Use the network.
-can_network(cupsd_t)
-
 # Bind to the cups/ipp port (631).
 allow cupsd_t ipp_port_t:tcp_socket name_bind;
 
diff -ru /tmp/policy/domains/program/dhcpc.te policy/domains/program/dhcpc.te
--- /tmp/policy/domains/program/dhcpc.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/dhcpc.te	2002-09-29 23:44:48.000000000 +0200
@@ -35,9 +35,6 @@
 # Inherit and use descriptors from init.
 allow dhcpc_t init_t:fd use;
 
-# Use the network.
-can_network(dhcpc_t)
-
 # Use capabilities
 allow dhcpc_t self:capability { net_admin net_raw net_bind_service };
 
diff -ru /tmp/policy/domains/program/ftpd.te policy/domains/program/ftpd.te
--- /tmp/policy/domains/program/ftpd.te	2002-08-23 21:04:28.000000000 +0200
+++ policy/domains/program/ftpd.te	2002-09-29 23:48:08.000000000 +0200
@@ -38,9 +38,6 @@
 # Use capabilities.
 allow ftpd_t ftpd_t:capability { net_bind_service setuid setgid fowner fsetid chown sys_resource sys_chroot };
 
-# Use the network.
-can_network(ftpd_t)
-
 # Connect to inetd.
 can_tcp_connect(ftpd_t,inetd_t)
 
diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/domains/program/initrc.te	2002-09-29 23:44:48.000000000 +0200
@@ -44,9 +44,6 @@
 # Set values in /proc/sys.
 can_sysctl(initrc_t)
 
-# Use the network.
-can_network(initrc_t)
-
 # Run helper programs in the initrc_t domain.
 can_exec_any(initrc_t)
 
diff -ru /tmp/policy/domains/program/login.te policy/domains/program/login.te
--- /tmp/policy/domains/program/login.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/domains/program/login.te	2002-09-29 22:40:39.000000000 +0200
@@ -30,9 +30,6 @@
 
 allow local_login_t shadow_t:file { read getattr };
 
-# Use the network.
-can_network(local_login_t)
-
 # Run shells in user_t by default.
 domain_auto_trans(local_login_t, shell_exec_t, user_t)
 # But also permit other user domains to be entered by login.
@@ -115,9 +112,6 @@
 # Use capabilities.
 allow remote_login_t remote_login_t:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override };
 
-# Use the network.
-can_network(remote_login_t)
-
 # Run shells in user_t by default.
 domain_auto_trans(remote_login_t, shell_exec_t, user_t)
 # Only permit unprivileged user domains to be entered via rlogin,
diff -ru /tmp/policy/domains/program/newrole.te policy/domains/program/newrole.te
--- /tmp/policy/domains/program/newrole.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/newrole.te	2002-09-29 22:40:59.000000000 +0200
@@ -25,9 +25,6 @@
 # Execute /sbin/pwdb_chkpwd to check the password.
 can_exec(newrole_t, chkpwd_exec_t)
 
-# Use the network.
-can_network(newrole_t)
-
 # Allow newrole_t to transition to user domains.
 domain_trans(newrole_t, shell_exec_t, userdomain)
 
diff -ru /tmp/policy/domains/program/portmap.te policy/domains/program/portmap.te
--- /tmp/policy/domains/program/portmap.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/portmap.te	2002-09-29 23:48:08.000000000 +0200
@@ -23,8 +23,6 @@
 # Inherit and use descriptors from init.
 allow portmap_t init_t:fd use;
 
-# Use the network.
-can_network(portmap_t)
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
 
 # Send to ypbind, initrc, rpc.statd, xinetd.
diff -ru /tmp/policy/domains/program/rlogind.te policy/domains/program/rlogind.te
--- /tmp/policy/domains/program/rlogind.te	2002-09-26 13:37:04.000000000 +0200
+++ policy/domains/program/rlogind.te	2002-09-29 22:41:28.000000000 +0200
@@ -27,9 +27,6 @@
 # Use capabilities.
 allow rlogind_t rlogind_t:capability { net_bind_service setuid setgid fowner fsetid chown dac_override };
 
-# Use the network.
-can_network(rlogind_t)
-
 # Run login in remote_login_t.
 domain_auto_trans(rlogind_t, login_exec_t, remote_login_t)
 
diff -ru /tmp/policy/domains/program/sendmail.te policy/domains/program/sendmail.te
diff -ru /tmp/policy/domains/program/ssh.te policy/domains/program/ssh.te
--- /tmp/policy/domains/program/ssh.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/domains/program/ssh.te	2002-09-29 22:33:48.000000000 +0200
@@ -10,7 +10,6 @@
 role system_r types $1;
 every_domain($1)
 allow $1 self:capability { chown dac_override fowner fsetid setgid setuid net_bind_service sys_tty_config };
-can_network($1)
 allow $1 shadow_t:file { read getattr };
 allow $1 { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };
 
diff -ru /tmp/policy/domains/program/tcpd.te policy/domains/program/tcpd.te
--- /tmp/policy/domains/program/tcpd.te	2002-03-15 14:01:19.000000000 +0100
+++ policy/domains/program/tcpd.te	2002-09-29 22:34:03.000000000 +0200
@@ -18,9 +18,6 @@
 # Use sockets inherited from inetd.
 allow tcpd_t inetd_t:tcp_socket rw_stream_socket_perms;
 
-# Use the network
-can_network(tcpd_t)
-
 # Run each daemon with a defined domain in its own domain.
 # These rules have been moved to each target domain's .te file.
 
diff -ru /tmp/policy/macros/program/chkpwd_macros.te policy/macros/program/chkpwd_macros.te
--- /tmp/policy/macros/program/chkpwd_macros.te	2002-08-26 19:13:06.000000000 +0200
+++ policy/macros/program/chkpwd_macros.te	2002-09-29 23:45:03.000000000 +0200
@@ -23,7 +23,7 @@
 # The user role is authorized for this domain.
 role $1_r types $1_chkpwd_t;
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (includes can_net)
 every_domain($1_chkpwd_t)
 
 # Use capabilities.
@@ -35,9 +35,6 @@
 # Inherit and use descriptors from newrole.
 ifdef(`newrole.te', `allow $1_chkpwd_t newrole_t:fd use;')
 
-# Use the network.
-can_network($1_chkpwd_t)
-
 # Write to the user domain tty.
 allow $1_chkpwd_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_chkpwd_t $1_devpts_t:chr_file rw_file_perms;
diff -ru /tmp/policy/macros/program/crontab_macros.te policy/macros/program/crontab_macros.te
--- /tmp/policy/macros/program/crontab_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/crontab_macros.te	2002-09-29 23:45:17.000000000 +0200
@@ -27,7 +27,7 @@
 # The user role is authorized for this domain.
 role $1_r types $1_crontab_t;
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (including can_net)
 every_domain($1_crontab_t)
 
 # Use capabilities
@@ -61,9 +61,6 @@
 # Run helper programs.
 can_exec_any($1_crontab_t)
 
-# Use the network for NIS.
-can_network($1_crontab_t)
-
 # Read user crontabs 
 allow $1_crontab_t home_root_t:dir search;
 allow $1_crontab_t { $1_home_t $1_home_dir_t }:dir r_dir_perms;  
diff -ru /tmp/policy/macros/program/lpr_macros.te policy/macros/program/lpr_macros.te
--- /tmp/policy/macros/program/lpr_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/lpr_macros.te	2002-09-29 22:36:31.000000000 +0200
@@ -26,7 +26,7 @@
 # The user role is authorized for this domain.
 role $1_r types $1_lpr_t;
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (including can_net)
 every_domain($1_lpr_t)
 
 # Use capabilities.
@@ -45,9 +45,6 @@
 # Use this type when creating files in /var/spool/lpd.
 file_type_auto_trans($1_lpr_t, lpd_spool_t, $1_lpd_spool_t)
 
-# Use the network.
-can_network($1_lpr_t)
-
 # Access the terminal.
 allow $1_lpr_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_lpr_t $1_devpts_t:chr_file rw_file_perms;
diff -ru /tmp/policy/macros/program/mta_macros.te policy/macros/program/mta_macros.te
--- /tmp/policy/macros/program/mta_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/mta_macros.te	2002-09-29 22:36:59.000000000 +0200
@@ -34,15 +34,12 @@
 # The user role is authorized for this domain.
 role $1_r types $1_mail_t;
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (including can_net)
 every_domain($1_mail_t)
 
 # Use capabilities
 allow $1_mail_t self:capability { setuid setgid chown };
 
-# Use the network.
-can_network($1_mail_t)
-
 # Execute procmail.
 can_exec($1_mail_t, bin_t)
 ifdef(`procmail.te',`
diff -ru /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2002-09-09 19:54:24.000000000 +0200
+++ policy/macros/program/ssh_macros.te	2002-09-29 23:45:31.000000000 +0200
@@ -28,7 +28,7 @@
 # The user role is authorized for this domain.
 role $1_r types $1_ssh_t;
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (including can_net)
 every_domain($1_ssh_t)
 
 # Use capabilities.
@@ -57,9 +57,6 @@
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
-# Use the network
-can_network($1_ssh_t)
-
 # Connect to sshd.
 can_tcp_connect($1_ssh_t, sshd_t)
 
diff -ru /tmp/policy/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/xserver_macros.te	2002-09-29 22:33:19.000000000 +0200
@@ -37,7 +37,7 @@
 role $1_r types $1_xserver_t;
 ')dnl
 
-# This domain is granted permissions common to most domains.
+# This domain is granted permissions common to most domains (includes can_net)
 every_domain($1_xserver_t)
 
 # Use capabilities.  Access /dev/mem.  
@@ -88,9 +88,6 @@
 # Run helper programs in $1_xserver_t.
 can_exec_any($1_xserver_t)
 
-# Use the network
-can_network($1_xserver_t)
-
 # Connect to xfs.
 ifdef(`xfs.te',
 `can_unix_connect($1_xserver_t, xfs_t)

--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mta.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mta.diff"

diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/dpkg.te	2002-09-29 21:30:27.000000000 +0200
@@ -20,6 +20,9 @@
 can_exec(dpkg_t, { dpkg_exec_t bin_t shell_exec_t tmp_dpkg_t ls_exec_t var_lib_dpkg_t etc_dpkg_t sbin_t })
 can_exec(dpkg_t, init_exec_t)
 file_type_auto_trans(dpkg_t, tmp_t, tmp_dpkg_t)
+ifdef(`mta.te', `
+allow system_mail_t tmp_dpkg_t:file read;
+')
 
 allow dpkg_t random_device_t:chr_file read;
 
diff -ru /tmp/policy/domains/program/mta.te policy/domains/program/mta.te
--- /tmp/policy/domains/program/mta.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/mta.te	2002-09-29 17:09:23.000000000 +0200
@@ -34,7 +34,11 @@
 allow mta_user_agent sysadm_t:fifo_file { read write };
 
 allow { system_mail_t mta_user_agent } privmail:fd use;
-allow { system_mail_t mta_user_agent } privmail:fifo_file rw_file_perms;
+allow { system_mail_t mta_user_agent } privmail:process sigchld;
+allow { system_mail_t mta_user_agent } privmail:fifo_file { read write };
+allow { system_mail_t mta_user_agent } admin_tty_type:chr_file { read write };
+
+allow mta_delivery_agent home_root_t:dir search;
 
 # for piping mail to a command
 can_exec(mta_delivery_agent, shell_exec_t)
diff -ru /tmp/policy/domains/program/qmail.te policy/domains/program/qmail.te
--- /tmp/policy/domains/program/qmail.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/qmail.te	2002-09-29 13:36:39.000000000 +0200
@@ -20,6 +20,13 @@
 type qmail_spool_t, file_type, sysadmfile;
 type var_qmail_t, file_type, sysadmfile;
 
+define(`qmaild_sub_domain', `
+daemon_sub_domain($1, $2, `$3')
+allow $2_t etc_qmail_t:dir { getattr search };
+allow $2_t etc_qmail_t:{ lnk_file file } { getattr read };
+allow $2_t var_spool_t:dir search;
+')
+
 #################################
 #
 # Rules for the qmail_$1_t domain.
@@ -27,35 +34,33 @@
 # qmail_$1_exec_t is the type of the qmail_$1 executables.
 #
 define(`qmail_daemon_domain', `
-daemon_sub_domain(qmail_start_t, qmail_$1)
+qmaild_sub_domain(qmail_start_t, qmail_$1, `$2')
 allow qmail_$1_t qmail_start_t:fifo_file { read write };
-
+allow qmail_start_t qmail_$1_exec_t:file read;
 ')dnl
 
+
 daemon_base_domain(qmail_start)
 
-allow qmail_start_t self:capability setgid;
+allow qmail_start_t self:capability { setgid setuid };
+allow qmail_start_t { bin_t sbin_t }:dir search;
 
-qmail_daemon_domain(lspawn)
+qmail_daemon_domain(lspawn, `, mta_delivery_agent')
 allow qmail_lspawn_t self:fifo_file { read write };
 allow qmail_lspawn_t self:capability { setuid setgid };
-allow qmail_lspawn_t self:process fork;
+allow qmail_lspawn_t self:process { fork signal_perms };
 allow qmail_lspawn_t sbin_t:dir search;
 can_exec(qmail_lspawn_t, qmail_exec_t)
 allow qmail_lspawn_t self:unix_stream_socket create_socket_perms;
 allow qmail_lspawn_t qmail_spool_t:dir search;
 allow qmail_lspawn_t qmail_spool_t:file { read getattr };
 allow qmail_lspawn_t etc_t:file { getattr read };
-allow qmail_lspawn_t etc_qmail_t:dir { getattr search };
 dontaudit qmail_lspawn_t user_home_dir_type:dir { getattr search };
 
 qmail_daemon_domain(send)
-allow qmail_send_t var_spool_t:dir search;
 rw_dir_create_file(qmail_send_t, qmail_spool_t)
 allow qmail_send_t qmail_spool_t:fifo_file read;
-allow qmail_send_t etc_qmail_t:dir search;
-allow qmail_send_t etc_qmail_t:{ lnk_file file } read;
-allow qmail_send_t self:process fork;
+allow qmail_send_t self:process { fork signal_perms };
 allow qmail_send_t self:fifo_file write;
 domain_auto_trans_read(qmail_send_t, qmail_queue_exec_t, qmail_queue_t)
 allow qmail_send_t sbin_t:dir search;
@@ -63,22 +68,20 @@
 qmail_daemon_domain(splogger)
 allow qmail_splogger_t self:unix_dgram_socket create_socket_perms;
 allow qmail_splogger_t etc_t:lnk_file read;
+dontaudit qmail_splogger_t initrc_t:fd use;
 
 qmail_daemon_domain(rspawn)
 allow qmail_rspawn_t qmail_spool_t:dir search;
-allow qmail_rspawn_t qmail_spool_t:file { read getattr };
-allow qmail_rspawn_t self:process fork;
+allow qmail_rspawn_t qmail_spool_t:file rw_file_perms;
+allow qmail_rspawn_t self:process { fork signal_perms };
 allow qmail_rspawn_t self:fifo_file read;
 allow qmail_rspawn_t { bin_t sbin_t }:dir search;
 
-daemon_sub_domain(qmail_rspawn_t, qmail_remote)
+qmaild_sub_domain(qmail_rspawn_t, qmail_remote)
 allow qmail_rspawn_t qmail_remote_exec_t:file read;
 can_network(qmail_remote_t)
-allow qmail_remote_t var_spool_t:dir search;
 allow qmail_remote_t qmail_spool_t:dir search;
 allow qmail_remote_t qmail_spool_t:file rw_file_perms;
-allow qmail_remote_t etc_qmail_t:dir search;
-allow qmail_remote_t etc_qmail_t:{ file lnk_file } read;
 allow qmail_remote_t resolv_conf_t:file { getattr read };
 allow qmail_remote_t self:tcp_socket create_socket_perms;
 allow qmail_remote_t self:udp_socket create_socket_perms;
@@ -88,18 +91,23 @@
 allow qmail_clean_t qmail_spool_t:file { unlink read getattr };
 
 # privhome will do until we get a separate maildir type
-daemon_sub_domain(qmail_lspawn_t, qmail_local, `, privhome, mta_delivery_agent')
+qmaild_sub_domain(qmail_lspawn_t, qmail_local, `, privhome, mta_delivery_agent')
 allow qmail_lspawn_t qmail_local_exec_t:file read;
-allow qmail_local_t self:process fork;
+allow qmail_local_t self:process { fork signal_perms };
 domain_auto_trans(qmail_local_t, qmail_queue_exec_t, qmail_queue_t)
 allow qmail_local_t qmail_queue_exec_t:file read;
-allow qmail_local_t etc_qmail_t:dir { getattr read search };
-allow qmail_local_t etc_qmail_t:file { getattr read };
-allow qmail_local_t qmail_spool_t:file read;
+allow qmail_local_t qmail_spool_t:file { ioctl read };
 allow qmail_local_t self:fifo_file write;
 allow qmail_local_t sbin_t:dir search;
 
-daemon_sub_domain(tcpd_t, qmail_tcp_env)
+# for piping mail to a command
+can_exec(qmail_local_t, shell_exec_t)
+allow qmail_local_t bin_t:dir search;
+allow qmail_local_t bin_t:lnk_file read;
+allow qmail_local_t devtty_t:chr_file rw_file_perms;
+allow qmail_local_t { etc_runtime_t proc_t }:file { getattr read };
+
+qmaild_sub_domain(tcpd_t, qmail_tcp_env)
 allow qmail_tcp_env_t inetd_t:fd use;
 allow qmail_tcp_env_t inetd_t:tcp_socket { read write getattr };
 allow qmail_tcp_env_t inetd_t:process sigchld;
@@ -107,46 +115,37 @@
 allow qmail_tcp_env_t sbin_t:dir search;
 can_network(qmail_tcp_env_t)
 
-daemon_sub_domain(qmail_tcp_env_t, qmail_smtpd)
+qmaild_sub_domain(qmail_tcp_env_t, qmail_smtpd)
 allow qmail_tcp_env_t qmail_smtpd_exec_t:file read;
 can_network(qmail_smtpd_t)
 allow qmail_smtpd_t inetd_t:fd use;
 allow qmail_smtpd_t inetd_t:tcp_socket { read write };
-allow qmail_smtpd_t etc_qmail_t:dir search;
-allow qmail_smtpd_t etc_qmail_t:{ file lnk_file } read;
 allow qmail_smtpd_t inetd_t:process sigchld;
-allow qmail_smtpd_t self:process fork;
+allow qmail_smtpd_t self:process { fork signal_perms };
 allow qmail_smtpd_t self:fifo_file write;
 allow qmail_smtpd_t self:tcp_socket create_socket_perms;
 allow qmail_smtpd_t sbin_t:dir search;
 domain_auto_trans(qmail_smtpd_t, qmail_queue_exec_t, qmail_queue_t)
 allow qmail_smtpd_t qmail_queue_exec_t:file read;
 
-daemon_sub_domain({ system_mail_t sysadm_mail_t user_mail_t }, qmail_inject, `, mta_user_agent')
-allow qmail_inject_t etc_qmail_t:dir search;
-allow qmail_inject_t etc_qmail_t:{ lnk_file file } read;
-allow qmail_inject_t self:process fork;
+qmaild_sub_domain({ system_mail_t sysadm_mail_t user_mail_t }, qmail_inject, `, mta_user_agent')
+allow qmail_inject_t self:process { fork signal_perms };
 allow qmail_inject_t self:fifo_file { write };
 allow qmail_inject_t sbin_t:dir search;
 role sysadm_r types qmail_inject_t;
 in_user_role(qmail_inject_t)
 
-daemon_sub_domain(userdomain, qmail_qread, `, mta_user_agent')
+qmaild_sub_domain(userdomain, qmail_qread, `, mta_user_agent')
 in_user_role(qmail_qread_t)
+role sysadm_r types qmail_qread_t;
 r_dir_file(qmail_qread_t, qmail_spool_t)
 allow qmail_qread_t self:capability dac_override;
-allow qmail_qread_t var_spool_t:dir search;
-allow qmail_qread_t etc_qmail_t:lnk_file read;
-allow qmail_qread_t etc_qmail_t:dir search;
 allow qmail_qread_t privfd:fd use;
 
-daemon_sub_domain(qmail_inject_t, qmail_queue, `, mta_user_agent')
+qmaild_sub_domain(qmail_inject_t, qmail_queue, `, mta_user_agent')
 role sysadm_r types qmail_queue_t;
 in_user_role(qmail_queue_t)
 allow qmail_inject_t qmail_queue_exec_t:file read;
-allow qmail_queue_t etc_qmail_t:dir search;
-allow qmail_queue_t etc_qmail_t:{ lnk_file file } read;
-allow qmail_queue_t var_spool_t:dir search;
 rw_dir_create_file(qmail_queue_t, qmail_spool_t)
 allow qmail_queue_t qmail_spool_t:fifo_file { read write };
 allow qmail_queue_t { qmail_start_t qmail_lspawn_t }:fd use;
@@ -162,13 +161,11 @@
 allow user_crond_t etc_qmail_t:dir search;
 allow user_crond_t etc_qmail_t:file read;
 
-daemon_sub_domain(user_crond_t, qmail_serialmail)
+qmaild_sub_domain(user_crond_t, qmail_serialmail)
 in_user_role(qmail_serialmail_t)
 can_network(qmail_serialmail_t)
 can_exec(qmail_serialmail_t, qmail_serialmail_exec_t)
-allow qmail_serialmail_t etc_qmail_t:dir search;
-allow qmail_serialmail_t etc_qmail_t:{ file lnk_file } read;
-allow qmail_serialmail_t self:process fork;
+allow qmail_serialmail_t self:process { fork signal_perms };
 allow qmail_serialmail_t proc_t:file { getattr read };
 allow qmail_serialmail_t { resolv_conf_t etc_runtime_t }:file { getattr read };
 allow qmail_serialmail_t user_home_dir_type:dir { search read getattr };
diff -ru /tmp/policy/domains/program/sendmail.te policy/domains/program/sendmail.te
--- /tmp/policy/domains/program/sendmail.te	2002-09-21 05:01:28.000000000 +0200
+++ policy/domains/program/sendmail.te	2002-09-29 14:57:18.000000000 +0200
@@ -12,7 +12,7 @@
 #
 # depends on mta.te
 #
-type sendmail_t, domain, privlog, mta_user_agent;
+type sendmail_t, domain, privlog, mta_delivery_agent;
 role system_r types sendmail_t;
 every_domain(sendmail_t)
 
diff -ru /tmp/policy/macros/program/mta_macros.te policy/macros/program/mta_macros.te
--- /tmp/policy/macros/program/mta_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/mta_macros.te	2002-09-29 22:36:59.000000000 +0200
@@ -56,9 +53,10 @@
 ', `
 # Read user temporary files.
 allow $1_mail_t $1_tmp_t:file { read getattr };
-ifdef(`postfix.te', `
-# postfix asks for append access but does not need it
 dontaudit $1_mail_t $1_tmp_t:file append;
+ifdef(`postfix.te', `
+# postfix seems to need write access if the file handle is opened read/write
+allow $1_mail_t $1_tmp_t:file write;
 ')
 allow mta_user_agent $1_tmp_t:file { read getattr };
 

--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: text/x-diff;
  charset="us-ascii";
  name="netscape.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="netscape.diff"

diff -ru /tmp/policy/file_contexts/program/netscape.fc policy/file_contexts/program/netscape.fc
--- /tmp/policy/file_contexts/program/netscape.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/netscape.fc	2002-09-29 16:13:47.000000000 +0200
@@ -7,5 +7,6 @@
 /usr/bin/mozilla		system_u:object_r:netscape_exec_t
 /usr/bin/mozilla-[0-9].*	system_u:object_r:netscape_exec_t
 /usr/bin/mozilla-bin-[0-9].*	system_u:object_r:netscape_exec_t
+/usr/lib/netscape/.*/communicator/communicator-smotif.real system_u:object_r:netscape_exec_t
 /usr/lib/netscape/base-4/wrapper system_u:object_r:netscape_exec_t
 /usr/lib/mozilla/reg.*		system_u:object_r:netscape_exec_t
diff -ru /tmp/policy/macros/program/netscape_macros.te policy/macros/program/netscape_macros.te
--- /tmp/policy/macros/program/netscape_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/netscape_macros.te	2002-09-29 16:43:54.000000000 +0200
@@ -16,116 +16,14 @@
 # provided separately in domains/program/netscape.te. 
 #
 define(`netscape_domain',`
-# Derived domain based on the calling user domain and the program.
-type $1_netscape_t, domain, privlog;
-
-# Transition from the user domain to the derived domain.
-domain_auto_trans($1_t, netscape_exec_t, $1_netscape_t)
-
-# The user role is authorized for this domain.
-role $1_r types $1_netscape_t;
-
-# This domain is granted permissions common to most domains.
-every_domain($1_netscape_t)
+x_client_domain($1, netscape, `, privlog')
 
 # Use capabilities.
 allow $1_netscape_t self:capability { setuid setgid dac_override };
 
-# Type for files that are writeable by this domain.
-type $1_netscape_rw_t, file_type, sysadmfile, tmpfile;
-# Use this type for files created in /tmp.
-file_type_auto_trans($1_netscape_t, tmp_t, $1_netscape_rw_t)
-
-# Allow the user domain to relabel to or create files with this type
-# to provide the domain with write access to particular files.
-allow $1_t $1_netscape_rw_t:{ dir file lnk_file } { relabelfrom relabelto };
-allow $1_t $1_netscape_rw_t:dir create_dir_perms;
-allow $1_t $1_netscape_rw_t:{ file lnk_file } create_file_perms;
-
-# Type for files that are read-only for this domain
-type $1_netscape_ro_t, file_type, sysadmfile;
-r_dir_file($1_netscape_t, $1_netscape_ro_t)
-rw_dir_create_file($1_t, $1_netscape_ro_t)
-allow $1_t $1_netscape_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
-
-# Allow the user domain to send any signal to the netscape process.
-allow $1_t $1_netscape_t:process signal_perms;
-
-# Allow the user domain to read the /proc/PID directory for 
-# the netscape process.
-allow $1_t $1_netscape_t:dir r_dir_perms;
-allow $1_t $1_netscape_t:notdevfile_class_set r_file_perms;
-
-# Allow use of /dev/zero by ld.so.
-allow $1_netscape_t zero_device_t:chr_file rw_file_perms;
-allow $1_netscape_t zero_device_t:chr_file x_file_perms;
-
-# Execute system programs.
-can_exec_any($1_netscape_t)
-
 # Execute downloaded programs.
 can_exec($1_netscape_t, $1_netscape_rw_t)
 
-# Inherit and use descriptors from gnome-pty-helper.
-ifdef(`gnome-pty-helper.te', `allow $1_netscape_t $1_gph_t:fd use;')
-
-# Use the network.
-can_network($1_netscape_t)
-
-# Connect to sshd.
-ifdef(`sshd.te', `can_tcp_connect($1_netscape_t, sshd_t)')
-
-# Allow connections to X server.
-ifdef(`xserver.te',
-`allow $1_netscape_t $1_xserver_tmp_t:dir r_dir_perms;
-allow $1_netscape_t $1_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_netscape_t, $1_xserver_t)')
-
-ifdef(`xdm.te', `
-# Allow connections to X server run by an X Display Manager.
-#allow $1_netscape_t xdm_tmp_t:dir r_dir_perms;
-#allow $1_netscape_t xdm_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_netscape_t, xdm_xserver_t)
-allow $1_netscape_t xdm_xserver_tmp_t:dir search;
-allow $1_netscape_t xdm_xserver_tmp_t:sock_file { read write };
-allow $1_netscape_t xdm_t:fd use;
-dontaudit $1_netscape_t xdm_t:tcp_socket { read write };
-
-# for .xsession-errors
-dontaudit $1_netscape_t $1_home_t:file write;
-')
-
-# Access the terminal.
-allow $1_netscape_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_netscape_t $1_devpts_t:chr_file rw_file_perms;
-
-# Read the home directory, e.g. for .Xauthority and to get to .netscape.
-allow $1_netscape_t home_root_t:dir search;
-file_type_auto_trans($1_netscape_t, $1_home_dir_t, $1_netscape_rw_t)
-# for .Xauthority - need different perms for this
-allow $1_netscape_t $1_home_t:file { read getattr };
-
-# Allow the netscape domain to signal the X server.
-ifdef(`xserver.te', `
-allow $1_netscape_t $1_xserver_t:process signal;
-# Use descriptors created by each other.
-allow $1_netscape_t $1_xserver_t:fd use;
-allow $1_xserver_t $1_netscape_t:fd use;
-')
-
-# Use a separate type for tmpfs/shm pseudo files.
-type $1_netscape_tmpfs_t, file_type, sysadmfile;
-file_type_auto_trans($1_netscape_t, tmpfs_t, $1_netscape_tmpfs_t)
-allow $1_netscape_tmpfs_t tmpfs_t:filesystem associate;
-
-# Communicate via shared memory.
-ifdef(`xserver.te', `
-allow $1_xserver_t $1_netscape_t:shm rw_shm_perms;
-allow $1_xserver_t $1_netscape_tmpfs_t:file rw_file_perms;
-allow $1_netscape_t $1_xserver_t:shm r_shm_perms;
-allow $1_netscape_t $1_xserver_tmpfs_t:file r_file_perms;
-')
-
 ifdef(`apache.te', `
 # additions by Brian May <bam@snoopy.apana.org.au> 2002-07-16
 allow $1_netscape_t httpd_t:tcp_socket { recvfrom connectto };
@@ -135,4 +33,4 @@
 # Use printer
 ifdef(`lpr.te', `domain_auto_trans($1_netscape_t, lpr_exec_t, $1_lpr_t)')
 
-')
+')dnl end netscape macro

--------------Boundary-00=_QC28JQL41YFQ29AOW354
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/kcheckpass.te policy/domains/program/kcheckpass.te
--- /tmp/policy/domains/program/kcheckpass.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/kcheckpass.te	2002-09-29 17:08:24.000000000 +0200
@@ -32,7 +32,7 @@
 
 allow kcheckpass_t fs_t:filesystem getattr;
 
-dontaudit kcheckpass_t user_home_dir_type:dir search;
+dontaudit kcheckpass_t { home_root_t user_home_dir_type }:dir search;
 dontaudit kcheckpass_t user_home_type:dir read;
 dontaudit kcheckpass_t xdm_t:fd use;
 dontaudit kcheckpass_t user_tmpfile:file read;
diff -ru /tmp/policy/domains/program/mysqld.te policy/domains/program/mysqld.te
--- /tmp/policy/domains/program/mysqld.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/mysqld.te	2002-09-29 17:54:46.000000000 +0200
@@ -37,13 +37,16 @@
 allow mysqld_t var_lib_t:dir search;
 
 # read config files
-allow mysqld_t { etc_t etc_mysqld_t resolv_conf_t etc_runtime_t }:{ file lnk_file } { read getattr };
+r_dir_file(mysqld_t, etc_mysqld_t)
+allow mysqld_t { etc_t resolv_conf_t etc_runtime_t }:{ file lnk_file } { read getattr };
 
 allow mysqld_t etc_t:dir search;
 
 allow mysqld_t sysctl_kernel_t:dir search;
 allow mysqld_t sysctl_kernel_t:file read;
 
+can_unix_connect(sysadm_t, mysqld_t)
+
 # for /root/.my.cnf - should not be needed
 allow mysqld_t sysadm_home_dir_t:dir search;
 allow mysqld_t sysadm_home_t:file { read getattr };
diff -ru /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-09-27 22:27:38.000000000 +0200
+++ policy/domains/program/named.te	2002-09-29 23:15:00.000000000 +0200
@@ -104,6 +104,11 @@
 # seems to need read as well for some reason
 allow ndc_t admin_tty_type:chr_file { getattr read write };
 
+# Read sysctl kernel variables.
+allow ndc_t sysctl_t:dir r_dir_perms;
+allow ndc_t sysctl_kernel_t:dir r_dir_perms;
+allow ndc_t sysctl_kernel_t:file r_file_perms;
+
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
 allow ndc_t crond_t:fd use;
@@ -113,7 +118,7 @@
 allow ndc_t etc_runtime_t:file { getattr read };
 allow ndc_t proc_t:dir search;
 allow ndc_t proc_t:file { getattr read };
-allow ndc_t self:process { fork sigchld };
+allow ndc_t self:process { fork signal_perms };
 can_exec(ndc_t, { bin_t sbin_t shell_exec_t })
 allow ndc_t var_run_named_t:file getattr;
 allow ndc_t self:fifo_file { read write getattr ioctl };
diff -ru /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-09-09 19:54:14.000000000 +0200
+++ policy/domains/program/quota.te	2002-09-29 12:56:49.000000000 +0200
@@ -13,8 +13,12 @@
 
 rw_dir_create_file(initrc_t, quota_flag_t)
 
-allow quota_t fs_t:filesystem { getattr quotaget };
+allow quota_t fs_t:filesystem { getattr quotaget quotamod };
 allow quota_t self:capability sys_admin;
+allow quota_t file_t:file quotaon;
+
+# for /quota.* - should setup a new type for it
+allow quota_t file_t:file { read write };
 
 # Read /etc/mtab.
 allow quota_t etc_runtime_t:file { read getattr };
diff -ru /tmp/policy/file_contexts/program/named.fc policy/file_contexts/program/named.fc
--- /tmp/policy/file_contexts/program/named.fc	2002-09-21 06:04:24.000000000 +0200
+++ policy/file_contexts/program/named.fc	2002-09-29 22:19:41.000000000 +0200
@@ -5,7 +5,7 @@
 /etc/bind/named.conf		system_u:object_r:named_conf_t
 /etc/bind/rndc.key		system_u:object_r:rndc_conf_t
 /usr/sbin/named.*      		system_u:object_r:named_exec_t
-/usr/sbin/ndc			system_u:object_r:ndc_exec_t
+/usr/sbin/r?ndc			system_u:object_r:ndc_exec_t
 /var/cache/bind(/.*)?		system_u:object_r:named_cache_t
 /var/run/ndc			system_u:object_r:var_run_named_t
 /usr/sbin/lwresd		system_u:object_r:named_exec_t
diff -ru /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-09-27 22:27:44.000000000 +0200
+++ policy/macros/global_macros.te	2002-09-29 16:08:44.000000000 +0200
@@ -827,7 +827,7 @@
 
 # Read and write /dev/tty and /dev/null.
 allow $1 devtty_t:chr_file rw_file_perms;
-allow $1 null_device_t:chr_file rw_file_perms;
+allow $1 { null_device_t zero_device_t }:chr_file rw_file_perms;
 
 # Do not audit write denials to /etc/ld.so.cache.
 dontaudit $1 ld_so_cache_t:file write;
diff -ru /tmp/policy/macros/program/irc_macros.te policy/macros/program/irc_macros.te
--- /tmp/policy/macros/program/irc_macros.te	2002-09-09 19:54:24.000000000 +0200
+++ policy/macros/program/irc_macros.te	2002-09-29 23:47:02.000000000 +0200
@@ -22,6 +22,8 @@
 type $1_irc_t, domain;
 type $1_home_irc_t, file_type, sysadmfile;
 
+allow $1_t $1_home_irc_t:file { relabelfrom relabelto create_file_perms };
+
 ifdef(`ircd.te', `
 can_tcp_connect($1_irc_t, ircd_t)
 ')
@@ -72,6 +74,7 @@
 dontaudit $1_irc_t initrc_var_run_t:file lock;
 
 # access config files
+allow $1_irc_t home_root_t:dir search;
 file_type_auto_trans($1_irc_t, $1_home_dir_t, $1_home_irc_t)
 create_dir_file($1_t, $1_home_irc_t)
 
diff -ru /tmp/policy/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- /tmp/policy/macros/program/xserver_macros.te	2002-09-30 00:23:28.000000000 +0200
+++ policy/macros/program/xserver_macros.te	2002-09-29 22:33:19.000000000 +0200
@@ -130,13 +127,12 @@
 ', `
 # Access the home directory.
 allow $1_xserver_t $1_home_dir_t:dir { getattr read search };
-allow $1_xserver_t $1_home_t:dir r_dir_perms;
-allow $1_xserver_t $1_home_t:file r_file_perms;')
+file_type_auto_trans($1_xserver_t, $1_home_dir_t, $1_home_xauth_t, file)
+')dnl end ifelse xdm
 
 allow $1_xserver_t var_lib_xkb_t:dir rw_dir_perms;
 allow $1_xserver_t var_lib_xkb_t:file create_file_perms;
-
-')
+')dnl end macro definition
 
 ', `
 
diff -ru /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-09-27 22:27:44.000000000 +0200
+++ policy/macros/user_macros.te	2002-09-30 00:03:13.000000000 +0200
@@ -124,7 +124,9 @@
 ifdef(`chkpwd.te', `chkpwd_domain($1)')
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`netscape.te', `netscape_domain($1)')
+ifdef(`games.te', `x_client_domain($1, games)')
 ifdef(`gpg.te', `gpg_domain($1)')
+ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`xserver.te', `xserver_domain($1)')
 ifdef(`lpr.te', `lpr_domain($1)')
 ifdef(`mta.te', `mail_domain($1)')

--------------Boundary-00=_QC28JQL41YFQ29AOW354--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
