Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JB50Ns016526
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 07:05:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JB116H005003
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 11:01:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B4E7E61B01
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 21:01:06 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02695-04 for <selinux@tycho.nsa.gov>;
	Mon, 19 Sep 2005 21:01:06 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E619C61B00
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 21:01:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: misc policy patches
Date: Mon, 19 Sep 2005 21:00:56 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wppLDTi1X0bbmUq"
Message-Id: <200509192101.04722.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_wppLDTi1X0bbmUq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch has a bunch of small changes that are fairly obvious (and 
the less obvious ones have comments).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_wppLDTi1X0bbmUq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /tmp/t/domains/program/fsadm.te ./domains/program/fsadm.te
--- /tmp/t/domains/program/fsadm.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/fsadm.te	2005-08-29 14:44:56.000000000 +1000
@@ -118,3 +118,6 @@
 allow fsadm_t usbfs_t:dir { getattr search };
 allow fsadm_t ramfs_t:fifo_file rw_file_perms;
 allow fsadm_t device_type:chr_file getattr;
+
+# for tune2fs
+allow fsadm_t file_type:dir { getattr search };
diff -ru /tmp/t/domains/program/load_policy.te ./domains/program/load_policy.te
--- /tmp/t/domains/program/load_policy.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/load_policy.te	2005-09-18 09:17:32.000000000 +1000
@@ -45,6 +49,9 @@
 allow load_policy_t root_t:dir search;
 allow load_policy_t etc_t:dir search;
 
+# for mcs.conf
+allow load_policy_t etc_t:file { getattr read };
+
 # Other access
 can_access_pty(load_policy_t, initrc)
 allow load_policy_t { admin_tty_type devtty_t }:chr_file { read write ioctl getattr };
diff -ru /tmp/t/domains/program/mount.te ./domains/program/mount.te
--- /tmp/t/domains/program/mount.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/mount.te	2005-09-18 09:03:58.000000000 +1000
@@ -23,7 +23,7 @@
 allow mount_t init_t:fd use;
 allow mount_t privfd:fd use;
 
-allow mount_t self:capability { ipc_lock dac_override };
+allow mount_t self:capability { dac_override ipc_lock sys_tty_config };
 allow mount_t self:process { fork signal_perms };
 
 allow mount_t file_type:dir search;
diff -ru /tmp/t/domains/program/named.te ./domains/program/named.te
--- /tmp/t/domains/program/named.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/named.te	2005-08-08 13:54:06.000000000 +1000
@@ -113,13 +113,19 @@
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 
-# for /etc/rndc.key
 ifdef(`distro_redhat', `
+# for /etc/rndc.key
 allow { ndc_t initrc_t } named_conf_t:dir search;
 # Allow init script to cp localtime to named_conf_t
 allow initrc_t named_conf_t:file { setattr write };
 allow initrc_t named_conf_t:dir create_dir_perms;
-')
+allow initrc_t var_run_t:lnk_file create_file_perms;
+ifdef(`automount.te', `
+# automount has no need to search the /proc file system for the named chroot
+dontaudit automount_t named_zone_t:dir search;
+')dnl end ifdef automount.te
+')dnl end ifdef distro_redhat
+
 allow { ndc_t initrc_t } named_conf_t:file { getattr read };
 
 allow ndc_t etc_t:dir r_dir_perms;
@@ -161,3 +167,5 @@
 ')
 allow ndc_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit ndc_t sysadm_tty_device_t:chr_file { ioctl };
+
+allow mount_t named_conf_t:dir mounton;
diff -ru /tmp/t/domains/program/ntpd.te ./domains/program/ntpd.te
--- /tmp/t/domains/program/ntpd.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/ntpd.te	2005-09-18 09:05:14.000000000 +1000
@@ -26,9 +26,10 @@
 # for SSP
 allow ntpd_t urandom_device_t:chr_file { getattr read };
 
-allow ntpd_t self:capability { chown dac_override kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot };
+# sys_resource and setrlimit is for locking memory
+allow ntpd_t self:capability { chown dac_override kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot sys_resource };
 dontaudit ntpd_t self:capability { net_admin };
-allow ntpd_t self:process { setcap setsched };
+allow ntpd_t self:process { setcap setsched setrlimit };
 # ntpdate wants sys_nice
 dontaudit ntpd_t self:capability { fsetid sys_nice };
 
diff -ru /tmp/t/domains/program/rlogind.te ./domains/program/rlogind.te
--- /tmp/t/domains/program/rlogind.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/rlogind.te	2005-07-19 16:50:09.000000000 +1000
@@ -35,4 +35,6 @@
 allow rlogind_t default_t:dir search;
 typealias rlogind_port_t alias rlogin_port_t;
 read_sysctl(rlogind_t);
-allow rlogind_t krb5_keytab_t:file r_file_perms;
+ifdef(`kerberos.te', `
+allow rlogind_t krb5_keytab_t:file { getattr read };
+')
diff -ru /tmp/t/domains/program/useradd.te ./domains/program/useradd.te
--- /tmp/t/domains/program/useradd.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/useradd.te	2005-09-18 20:51:38.000000000 +1000
@@ -55,7 +55,6 @@
 # useradd/userdel request read/write for /var/log/lastlog, and read of /dev, 
 # but will operate without them.
 dontaudit $1_t { device_t var_t var_log_t }:dir search;
-allow useradd_t lastlog_t:file { read write };
 
 # For userdel and groupadd
 allow $1_t fs_t:filesystem getattr;
@@ -68,8 +67,11 @@
 # for when /root is the cwd
 dontaudit $1_t sysadm_home_dir_t:dir search;
 nsswitch_domain($1_t)
+
+allow $1_t self:netlink_audit_socket { create_socket_perms nlmsg_relay };
 ')
 user_group_add_program(useradd)
+allow useradd_t lastlog_t:file { getattr read write };
 
 # for getting the number of groups
 read_sysctl(useradd_t)
diff -ru /tmp/t/domains/program/utempter.te ./domains/program/utempter.te
--- /tmp/t/domains/program/utempter.te	2005-09-19 14:54:58.000000000 +1000
+++ ./domains/program/utempter.te	2005-07-20 17:25:24.000000000 +1000
@@ -19,6 +19,8 @@
 type utempter_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(userdomain, utempter_exec_t, utempter_t)
 
+allow utempter_t urandom_device_t:chr_file { getattr read };
+
 # Use capabilities.
 allow utempter_t self:capability setgid;
 
diff -ru /tmp/t/file_contexts/program/backup.fc ./file_contexts/program/backup.fc
--- /tmp/t/file_contexts/program/backup.fc	2005-09-19 14:54:58.000000000 +1000
+++ ./file_contexts/program/backup.fc	2005-09-18 08:05:57.000000000 +1000
@@ -3,4 +3,4 @@
 # calls tar) in backup_exec_t and label the directory for storing them as
 # backup_store_t, Debian uses /var/backups
 #/usr/local/bin/backup-script -- system_u:object_r:backup_exec_t
-/var/backups(/.*)?		system_u:object_r:backup_store_t
+/var/backups(/.*)?		system_u:object_r:backup_store_t:s0
diff -ru /tmp/t/macros/program/newrole_macros.te ./macros/program/newrole_macros.te
--- /tmp/t/macros/program/newrole_macros.te	2005-09-19 14:54:58.000000000 +1000
+++ ./macros/program/newrole_macros.te	2005-04-16 14:35:04.000000000 +1000
@@ -20,6 +20,8 @@
 read_locale($1_t)
 read_sysctl($1_t)
 
+allow $1_t self:netlink_audit_socket { create bind write nlmsg_read read };
+
 # for when the user types "exec newrole" at the command line
 allow $1_t privfd:process sigchld;
 

--Boundary-00=_wppLDTi1X0bbmUq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
