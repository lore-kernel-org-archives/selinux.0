Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7I7f8Ob026342
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 03:41:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7I7UjsQ002422
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 07:30:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AA42761AFD
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:31:35 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05251-08 for <selinux@tycho.nsa.gov>;
	Thu, 18 Aug 2005 17:31:34 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8D93A61AF9
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:31:34 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 008AF44
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:31:32 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policy patch
Date: Thu, 18 Aug 2005 17:31:29 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UlDBD2DG4Z6tqo3"
Message-Id: <200508181731.32481.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_UlDBD2DG4Z6tqo3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a policy patch for some minor things that are missing.  The most 
important patches are the ones for postfix.fc and dhcpd.fc as they are the 
most likely to break systems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_UlDBD2DG4Z6tqo3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- selinux-policy-strict-1.24.orig/domains/program/restorecon.te
+++ selinux-policy-strict-1.24/domains/program/restorecon.te
@@ -45,6 +45,9 @@
 ifdef(`distro_redhat', `
 allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relabelfrom relabelto };
 ')
+ifdef(`dpkg.te', `
+domain_auto_trans(dpkg_t, restorecon_exec_t, restorecon_t)
+')
 
 allow restorecon_t ptyfile:chr_file getattr;
 
--- selinux-policy-strict-1.24.orig/domains/program/ssh.te
+++ selinux-policy-strict-1.24/domains/program/ssh.te
@@ -113,6 +113,14 @@
 can_create_pty($1, `, server_pty')
 allow $1_t $1_devpts_t:chr_file { setattr getattr relabelfrom };
 dontaudit sshd_t userpty_type:chr_file relabelfrom;
+
+allow $1_t faillog_t:file { append getattr };
+allow $1_t sbin_t:file getattr;
+
+# Allow checking users mail at login
+allow $1_t { var_spool_t mail_spool_t }:dir search;
+allow $1_t mail_spool_t:lnk_file read;
+allow $1_t mail_spool_t:file getattr;
 ')dnl end sshd_program_domain
 
 # macro for defining which domains a sshd can spawn
@@ -161,11 +169,6 @@
 # for when the network connection breaks after running newrole -r sysadm_r
 dontaudit sshd_t sysadm_devpts_t:chr_file setattr;
 
-# Allow checking users mail at login
-allow sshd_t { var_spool_t mail_spool_t }:dir search;
-allow sshd_t mail_spool_t:lnk_file read;
-allow sshd_t mail_spool_t:file getattr;
-
 ifdef(`inetd.te', `
 if (run_ssh_inetd) {
 allow inetd_t ssh_port_t:tcp_socket name_bind;
@@ -229,5 +232,3 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
-allow sshd_t faillog_t:file { append getattr };
-allow sshd_t sbin_t:file getattr;
--- selinux-policy-strict-1.24.orig/domains/program/unused/acct.te
+++ selinux-policy-strict-1.24/domains/program/unused/acct.te
@@ -23,10 +23,11 @@
 
 type acct_data_t, file_type, sysadmfile;
 
-allow acct_t self:capability sys_pacct;
+# not sure why we need this, the command "last" is reported as using it
+dontaudit acct_t self:capability kill;
 
 # gzip needs chown capability for some reason
-allow acct_t self:capability chown;
+allow acct_t self:capability { chown fsetid sys_pacct };
 
 allow acct_t var_t:dir { getattr search };
 rw_dir_create_file(acct_t, acct_data_t)
@@ -37,14 +38,13 @@
 
 read_locale(acct_t)
 
-allow acct_t self:capability fsetid;
 allow acct_t fs_t:filesystem getattr;
 
 allow acct_t self:unix_stream_socket create_socket_perms;
 
 allow acct_t self:fifo_file { read write getattr };
 
-allow acct_t proc_t:file { read getattr };
+allow acct_t { self proc_t }:file { read getattr };
 
 read_sysctl(acct_t)
 
@@ -53,8 +53,6 @@
 # for nscd
 dontaudit acct_t var_run_t:dir search;
 
-# not sure why we need this, the command "last" is reported as using it
-dontaudit acct_t self:capability kill;
 
 allow acct_t devtty_t:chr_file { read write };
 
--- selinux-policy-strict-1.24.orig/domains/program/unused/dpkg.te
+++ selinux-policy-strict-1.24/domains/program/unused/dpkg.te
@@ -178,6 +178,9 @@
 type apt_rw_etc_t, file_type, sysadmfile;
 tmp_domain(apt, `', `{ dir file lnk_file }')
 can_exec(apt_t, apt_tmp_t)
+ifdef(`crond.te', `
+allow system_crond_t apt_etc_t:file { getattr read };
+')
 
 rw_dir_create_file(apt_t, apt_rw_etc_t)
 
--- selinux-policy-strict-1.24.orig/domains/program/unused/fs_daemon.te
+++ selinux-policy-strict-1.24/domains/program/unused/fs_daemon.te
@@ -15,6 +15,8 @@
 allow fsdaemon_t self:capability { setgid sys_rawio sys_admin };
 allow fsdaemon_t etc_runtime_t:file { getattr read };
 
+allow fsdaemon_t proc_mdstat_t:file { getattr read };
+
 can_exec_any(fsdaemon_t)
 allow fsdaemon_t self:fifo_file rw_file_perms;
 can_network_udp(fsdaemon_t)
--- selinux-policy-strict-1.24.orig/domains/program/unused/lvm.te
+++ selinux-policy-strict-1.24/domains/program/unused/lvm.te
@@ -101,6 +101,7 @@
 dontaudit lvm_t ttyfile:chr_file getattr;
 dontaudit lvm_t device_t:{ fifo_file dir chr_file blk_file } getattr;
 dontaudit lvm_t devpts_t:dir { getattr read };
+dontaudit lvm_t xconsole_device_t:fifo_file getattr;
 
 ifdef(`gpm.te', `
 dontaudit lvm_t gpmctl_t:sock_file getattr;
--- selinux-policy-strict-1.24.orig/domains/program/unused/mailman.te
+++ selinux-policy-strict-1.24/domains/program/unused/mailman.te
@@ -91,6 +91,8 @@
 
 allow mta_delivery_agent mailman_data_t:dir search;
 allow mta_delivery_agent mailman_data_t:lnk_file read;
+allow initrc_t mailman_data_t:lnk_file read;
+allow initrc_t mailman_data_t:dir r_dir_perms;
 domain_auto_trans({ mta_delivery_agent initrc_t }, mailman_mail_exec_t, mailman_mail_t)
 ifdef(`direct_sysadm_daemon', `
 domain_auto_trans(sysadm_t, mailman_mail_exec_t, mailman_mail_t)
--- selinux-policy-strict-1.24.orig/domains/program/unused/mysqld.te
+++ selinux-policy-strict-1.24/domains/program/unused/mysqld.te
@@ -89,3 +89,6 @@
 }
 ')
 
+ifdef(`crond.te', `
+allow system_crond_t mysqld_etc_t:file { getattr read };
+')
--- selinux-policy-strict-1.24.orig/domains/program/unused/ntpd.te
+++ selinux-policy-strict-1.24/domains/program/unused/ntpd.te
@@ -27,7 +27,7 @@
 # for SSP
 allow ntpd_t urandom_device_t:chr_file { getattr read };
 
-allow ntpd_t self:capability { kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot };
+allow ntpd_t self:capability { chown dac_override kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot };
 dontaudit ntpd_t self:capability { net_admin };
 allow ntpd_t self:process { setcap setsched };
 # ntpdate wants sys_nice
--- selinux-policy-strict-1.24.orig/domains/program/unused/sxid.te
+++ selinux-policy-strict-1.24/domains/program/unused/sxid.te
@@ -32,6 +32,7 @@
 allow sxid_t ttyfile:chr_file getattr;
 allow sxid_t file_type:dir { getattr read search };
 allow sxid_t sysadmfile:file { getattr read };
+dontaudit sxid_t devpts_t:dir r_dir_perms;
 allow sxid_t fs_type:dir { getattr read search };
 
 # Use the network.
--- selinux-policy-strict-1.24.orig/file_contexts/program/apache.fc
+++ selinux-policy-strict-1.24/file_contexts/program/apache.fc
@@ -26,15 +26,17 @@
 /var/log/cgiwrap\.log.*	--	system_u:object_r:httpd_log_t
 /var/cache/ssl.*\.sem	--	system_u:object_r:httpd_cache_t
 /var/cache/mod_ssl(/.*)?	system_u:object_r:httpd_cache_t
-/var/run/apache(2)?\.pid.* --	system_u:object_r:httpd_var_run_t
+/var/run/apache.*		system_u:object_r:httpd_var_run_t
 /var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
 /var/lib/php/session(/.*)?	system_u:object_r:httpd_var_run_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
 /usr/lib/apache-ssl/.+	 --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
-/var/run/apache-ssl(2)?\.pid.* -- system_u:object_r:httpd_var_run_t
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
+ifdef(`distro_debian', `
+/var/log/horde2(/.*)?		system_u:object_r:httpd_log_t
+')
 ifdef(`distro_suse', `
 # suse puts shell scripts there :-(
 /usr/share/apache2/[^/]*	--	system_u:object_r:bin_t
--- selinux-policy-strict-1.24.orig/file_contexts/program/clamav.fc
+++ selinux-policy-strict-1.24/file_contexts/program/clamav.fc
@@ -12,4 +12,4 @@
 /var/run/clamd\.ctl	-s	system_u:object_r:clamd_sock_t
 /var/run/clamd\.pid	--	system_u:object_r:clamd_var_run_t
 /var/run/clamav(/.*)?		system_u:object_r:clamd_var_run_t
-/var/run/clamav/clamd.sock -s	system_u:object_r:clamd_sock_t
+/var/run/clamav/clamd\.sock -s	system_u:object_r:clamd_sock_t
--- selinux-policy-strict-1.24.orig/file_contexts/program/dhcpd.fc
+++ selinux-policy-strict-1.24/file_contexts/program/dhcpd.fc
@@ -3,7 +3,7 @@
 /etc/dhcp3(/.*)?		system_u:object_r:dhcp_etc_t
 /usr/sbin/dhcpd.*	--	system_u:object_r:dhcpd_exec_t
 /var/lib/dhcp(3)?/dhcpd\.leases.* -- system_u:object_r:dhcpd_state_t
-/var/run/dhcpd\.pid	-d	system_u:object_r:dhcpd_var_run_t
+/var/run/dhcpd\.pid	--	system_u:object_r:dhcpd_var_run_t
 ifdef(`dhcp_defined', `', `
 /var/lib/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
 define(`dhcp_defined')
--- selinux-policy-strict-1.24.orig/file_contexts/program/postfix.fc
+++ selinux-policy-strict-1.24/file_contexts/program/postfix.fc
@@ -10,6 +10,7 @@
 /usr/libexec/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
 /usr/libexec/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
 /usr/libexec/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
+/usr/libexec/postfix/scache	--	system_u:object_r:postfix_smtp_exec_t
 /usr/libexec/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
 /usr/libexec/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
 /usr/libexec/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
@@ -22,6 +23,7 @@
 /usr/lib/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
 /usr/lib/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
 /usr/lib/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
+/usr/lib/postfix/scache	--	system_u:object_r:postfix_smtp_exec_t
 /usr/lib/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
 /usr/lib/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
 /usr/lib/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
--- selinux-policy-strict-1.24.orig/file_contexts/program/radvd.fc
+++ selinux-policy-strict-1.24/file_contexts/program/radvd.fc
@@ -2,3 +2,4 @@
 /etc/radvd\.conf	--	system_u:object_r:radvd_etc_t
 /usr/sbin/radvd		--	system_u:object_r:radvd_exec_t
 /var/run/radvd\.pid	--	system_u:object_r:radvd_var_run_t
+/var/run/radvd/saved-settings -- system_u:object_r:radvd_var_run_t
--- selinux-policy-strict-1.24.orig/macros/program/gpg_macros.te
+++ selinux-policy-strict-1.24/macros/program/gpg_macros.te
@@ -61,7 +61,7 @@
 allow { $1_t $1_gpg_t } $1_gpg_t:process signal;
 
 # setrlimit is for ulimit -c 0
-allow $1_gpg_t self:process { setrlimit setcap };
+allow $1_gpg_t self:process { setrlimit setcap setpgid };
 
 # allow ps to show gpg
 can_ps($1_t, $1_gpg_t)

--Boundary-00=_UlDBD2DG4Z6tqo3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
