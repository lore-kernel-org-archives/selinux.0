Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA02546
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 11:13:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA18948
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 16:11:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA18944
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 16:11:12 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 17B9B924EE
	for <selinux@tycho.nsa.gov>; Tue, 17 Dec 2002 03:13:17 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CF00A13B
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 17:13:11 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: policy patch for 2002121210
Date: Mon, 16 Dec 2002 17:13:11 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZPZ7AJBH5Q2NQFV9QVJ3"
Message-Id: <200212161713.11399.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_ZPZ7AJBH5Q2NQFV9QVJ3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached my first policy patch for the latest release.

It doesn't contain anything exciting, just small tweaks and some patches for 
things that have changed since the last patch I sent in.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_ZPZ7AJBH5Q2NQFV9QVJ3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/bootloader.te policy/domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-12-16 17:06:02.000000000 +0100
+++ policy/domains/program/bootloader.te	2002-12-13 21:03:06.000000000 +0100
@@ -48,6 +48,7 @@
 
 # for ldd
 allow bootloader_t { insmod_exec_t fsadm_exec_t }:file { rx_file_perms execute_no_trans };
+allow bootloader_t insmod_exec_t:lnk_file { getattr read };
 
 dontaudit bootloader_t sysadm_home_dir_t:dir search;
 
diff -ru /tmp/policy/domains/program/crack.te policy/domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2002-12-03 15:56:39.000000000 +0100
+++ policy/domains/program/crack.te	2002-12-13 21:03:18.000000000 +0100
@@ -35,4 +35,6 @@
 allow crack_t { etc_t etc_runtime_t }:file { getattr read };
 allow crack_t etc_t:dir r_dir_perms;
 
+allow crack_t fs_t:filesystem getattr;
+
 dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
diff -ru /tmp/policy/domains/program/crond.te policy/domains/program/crond.te
--- /tmp/policy/domains/program/crond.te	2002-12-03 15:56:39.000000000 +0100
+++ policy/domains/program/crond.te	2002-12-13 21:03:38.000000000 +0100
@@ -37,7 +37,7 @@
 file_type_auto_trans(crond_t, var_log_t, cron_log_t)
 
 # Use capabilities.
-allow crond_t crond_t:capability { setgid setuid net_bind_service };
+allow crond_t crond_t:capability { setgid setuid net_bind_service dac_override };
 
 # Check entrypoint permission on crontab files.
 allow crond_t security_t:security compute_av;
diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-12-03 15:56:40.000000000 +0100
+++ policy/domains/program/dpkg.te	2002-12-13 21:04:23.000000000 +0100
@@ -25,7 +25,7 @@
 can_exec(dpkg_t, init_exec_t)
 file_type_auto_trans(dpkg_t, tmp_t, tmp_dpkg_t)
 ifdef(`mta.te', `
-allow system_mail_t tmp_dpkg_t:file read;
+allow system_mail_t tmp_dpkg_t:file { getattr read };
 ')
 
 allow dpkg_t random_device_t:chr_file read;
diff -ru /tmp/policy/domains/program/fsadm.te policy/domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2002-11-04 13:27:51.000000000 +0100
+++ policy/domains/program/fsadm.te	2002-12-13 21:54:24.000000000 +0100
@@ -22,6 +22,9 @@
 type fsadm_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(fsadm_t, tmp_t, fsadm_tmp_t)
 
+# remount file system to apply changes
+allow fsadm_t fs_t:filesystem remount;
+
 # Use capabilities.
 allow fsadm_t fsadm_t:capability { sys_admin sys_rawio };
 
diff -ru /tmp/policy/domains/program/ftpd.te policy/domains/program/ftpd.te
--- /tmp/policy/domains/program/ftpd.te	2002-11-04 13:27:51.000000000 +0100
+++ policy/domains/program/ftpd.te	2002-12-13 21:05:01.000000000 +0100
@@ -18,7 +18,10 @@
 ifdef(`inetd.te', `domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)')
 ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
 
-ifdef(`crond.te', `system_crond_entry(ftpd_exec_t, ftpd_t)')
+ifdef(`crond.te', `
+system_crond_entry(ftpd_exec_t, ftpd_t)
+can_exec(ftpd_t, { bin_t sbin_t })
+')
 
 # Inherit and use descriptors from inetd.
 allow ftpd_t inetd_t:fd use;
diff -ru /tmp/policy/domains/program/hotplug.te policy/domains/program/hotplug.te
--- /tmp/policy/domains/program/hotplug.te	2002-12-03 15:56:40.000000000 +0100
+++ policy/domains/program/hotplug.te	2002-12-13 21:05:01.000000000 +0100
@@ -47,6 +47,7 @@
 
 domain_auto_trans(kmod_t, hotplug_exec_t, hotplug_t)
 domain_auto_trans_read(hotplug_t, insmod_exec_t, insmod_t)
+allow hotplug_t insmod_exec_t:lnk_file read;
 domain_auto_trans_read(hotplug_t, mount_exec_t, mount_t)
 domain_auto_trans_read(hotplug_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`pump.te', `domain_auto_trans_read(hotplug_t, pump_exec_t, pump_t)')
diff -ru /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-12-03 15:56:41.000000000 +0100
+++ policy/domains/program/postfix.te	2002-12-13 21:07:17.000000000 +0100
@@ -82,9 +82,9 @@
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
@@ -241,7 +241,7 @@
 type postfix_spool_bounce_t, file_type, sysadmfile;
 create_dir_file(postfix_bounce_t, postfix_spool_bounce_t)
 create_dir_file(postfix_bounce_t, postfix_spool_t)
-allow postfix_master_t postfix_spool_bounce_t:dir r_dir_perms;
+allow postfix_master_t postfix_spool_bounce_t:dir create_dir_perms;
 allow postfix_bounce_t self:capability { dac_read_search };
 allow postfix_bounce_t postfix_public_t:sock_file write;
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
diff -ru /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-12-03 15:56:42.000000000 +0100
+++ policy/domains/program/quota.te	2002-12-13 21:07:17.000000000 +0100
@@ -15,7 +15,7 @@
 rw_dir_create_file(initrc_t, quota_flag_t)
 
 allow quota_t fs_t:filesystem { getattr quotaget quotamod };
-allow quota_t home_root_t:dir getattr;
+allow quota_t { home_root_t var_t usr_t src_t }:dir getattr;
 allow quota_t self:capability sys_admin;
 allow quota_t file_t:file quotaon;
 
Only in /tmp/policy/domains: system
Only in /tmp/policy/domains: user
diff -ru /tmp/policy/file_contexts/program/fsadm.fc policy/file_contexts/program/fsadm.fc
--- /tmp/policy/file_contexts/program/fsadm.fc	2002-12-03 15:56:44.000000000 +0100
+++ policy/file_contexts/program/fsadm.fc	2002-12-13 21:56:43.000000000 +0100
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
diff -ru /tmp/policy/file_contexts/program/initrc.fc policy/file_contexts/program/initrc.fc
--- /tmp/policy/file_contexts/program/initrc.fc	2002-10-28 22:56:00.000000000 +0100
+++ policy/file_contexts/program/initrc.fc	2002-12-13 21:08:39.000000000 +0100
@@ -11,3 +11,4 @@
 /usr/local/selinux/sbin/open_init_pty	system_u:object_r:initrc_exec_t
 /usr/sbin/run_init		system_u:object_r:run_init_exec_t
 /usr/sbin/open_init_pty		system_u:object_r:initrc_exec_t
+/etc/nologin.boot		system_u:object_r:etc_runtime_t
diff -ru /tmp/policy/file_contexts/program/modutil.fc policy/file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2002-12-16 17:06:32.000000000 +0100
+++ policy/file_contexts/program/modutil.fc	2002-12-13 21:08:39.000000000 +0100
@@ -5,6 +5,6 @@
 /sbin/depmod.*			system_u:object_r:depmod_exec_t
 /sbin/modprobe.*		system_u:object_r:insmod_exec_t
 /sbin/insmod.*			system_u:object_r:insmod_exec_t
-/sbin/insmod.static		system_u:object_r:insmod_exec_t
+/sbin/insmod_ksymoops_clean	system_u:object_r:sbin_t
 /sbin/rmmod.*			system_u:object_r:insmod_exec_t
 /sbin/update-modules		system_u:object_r:update_modules_exec_t
diff -ru /tmp/policy/file_contexts/program/postgresql.fc policy/file_contexts/program/postgresql.fc
--- /tmp/policy/file_contexts/program/postgresql.fc	2002-08-23 20:44:20.000000000 +0200
+++ policy/file_contexts/program/postgresql.fc	2002-12-13 21:08:39.000000000 +0100
@@ -4,3 +4,4 @@
 /var/run/postgresql(/.*)?	system_u:object_r:var_run_postgresql_t
 /etc/postgresql(/.*)?		system_u:object_r:etc_postgresql_t
 /var/log/postgres.log.*		system_u:object_r:postgresql_log_t
+/var/log/postgresql(/.*)?	system_u:object_r:postgresql_log_t
diff -ru /tmp/policy/file_contexts/program/slapd.fc policy/file_contexts/program/slapd.fc
--- /tmp/policy/file_contexts/program/slapd.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/slapd.fc	2002-12-13 21:54:50.000000000 +0100
@@ -3,3 +3,4 @@
 /var/lib/ldap(/.*)?		system_u:object_r:slapd_db_t
 /var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd.args		system_u:object_r:var_run_slapd_t
+/etc/ldap/slapd.conf		system_u:object_r:etc_slapd_t
diff -ru /tmp/policy/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- /tmp/policy/macros/program/ssh_macros.te	2002-10-23 21:38:26.000000000 +0200
+++ policy/macros/program/ssh_macros.te	2002-12-13 21:10:46.000000000 +0100
@@ -69,7 +69,7 @@
 allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
 
 # Allow the user shell to signal the ssh program.
-allow $1_t $1_ssh_t:process signal;
+allow $1_t $1_ssh_t:process { signal setpgid };
 # allow ps to show ssh
 allow $1_t $1_ssh_t:dir { search getattr read };
 allow $1_t $1_ssh_t:{ file lnk_file } { read getattr };

--------------Boundary-00=_ZPZ7AJBH5Q2NQFV9QVJ3--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
