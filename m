Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2TKCYx6005024
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2003 15:12:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2TK8xlY019845
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2003 20:09:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2TK8uKX019842
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2003 20:08:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 2C29FBF47
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2003 06:12:13 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 16522-07
 for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2003 06:12:11 +1000 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id CFBFCBF45
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2003 06:12:11 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EACF392704
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2003 06:12:09 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E0D2314A
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2003 21:12:02 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: latest policy patches
Date: Sat, 29 Mar 2003 21:12:02 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_S4fh+V0IySbJmS1"
Message-Id: <200303292112.02116.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_S4fh+V0IySbJmS1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Following the latest kernel change which results in kernel threads running as 
kernel_t instead of init_t more policy changes are required.

I have attached a patch that makes the necessary changes for kernel_t, for the 
modutils programs, and some minor changes for file_contexts as well.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_S4fh+V0IySbJmS1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/misc/kernel.te ./domains/misc/kernel.te
--- /tmp/policy/domains/misc/kernel.te	2003-03-28 22:38:59.000000000 +0100
+++ ./domains/misc/kernel.te	2003-03-29 20:50:33.000000000 +0100
@@ -59,10 +59,17 @@
 # Reload the policy from the real root.
 allow kernel_t security_t:security load_policy;
 
+ifdef(`modutil.te', `
 # Run insmod (for kernel module loader).
 domain_auto_trans_read(kernel_t,insmod_exec_t,insmod_t)
+allow kernel_t insmod_exec_t:lnk_file read;
+')
 
 # /proc/sys/kernel/modprobe is set to /bin/true if not using modules.
 can_exec(kernel_t, bin_t)
 
+can_exec(kernel_t, shell_exec_t)
 
+# nfs kernel server needs kernel UDP access.  It is less risky and painful
+# to just give it everything.
+can_network(kernel_t)
diff -ru /tmp/policy/domains/program/klogd.te ./domains/program/klogd.te
--- /tmp/policy/domains/program/klogd.te	2003-03-28 18:51:59.000000000 +0100
+++ ./domains/program/klogd.te	2003-03-29 13:37:34.000000000 +0100
@@ -21,6 +21,7 @@
 file_type_auto_trans(klogd_t, var_run_t, klogd_var_run_t)
 allow klogd_t proc_t:dir r_dir_perms;
 allow klogd_t proc_t:lnk_file r_file_perms;
+allow klogd_t proc_t:file { getattr read };
 allow klogd_t self:dir r_dir_perms;
 allow klogd_t self:lnk_file r_file_perms;
 
@@ -29,6 +30,8 @@
 allow klogd_t etc_t:lnk_file read;
 allow klogd_t etc_t:file r_file_perms;
 
+allow klogd_t etc_runtime_t:file { getattr read };
+
 # Create unix sockets
 allow klogd_t self:unix_dgram_socket create_socket_perms;
 
diff -ru /tmp/policy/domains/program/logrotate.te ./domains/program/logrotate.te
--- /tmp/policy/domains/program/logrotate.te	2003-03-28 18:52:00.000000000 +0100
+++ ./domains/program/logrotate.te	2003-03-29 13:40:14.000000000 +0100
@@ -24,6 +24,7 @@
 
 # access files in /etc
 allow logrotate_t etc_t:file { getattr read };
+can_exec(logrotate_t, etc_t)
 allow logrotate_t etc_t:lnk_file read;
 allow logrotate_t etc_runtime_t:{ file lnk_file } r_file_perms;
 
@@ -39,8 +40,7 @@
 # Run helper programs.
 allow logrotate_t { bin_t sbin_t }:dir r_dir_perms;
 allow logrotate_t { bin_t sbin_t }:lnk_file read;
-can_exec(logrotate_t, bin_t);
-can_exec(logrotate_t, sbin_t);
+can_exec(logrotate_t, { bin_t sbin_t ls_exec_t });
 
 # Read PID files.
 allow logrotate_t pidfile:file r_file_perms;
@@ -48,6 +48,8 @@
 # Read /proc/PID directories for all domains.
 allow logrotate_t proc_t:dir r_dir_perms;
 allow logrotate_t proc_t:{ file lnk_file } r_file_perms;
+allow logrotate_t { sysctl_t sysctl_kernel_t }:dir search;
+allow logrotate_t sysctl_kernel_t:file { getattr read };
 allow logrotate_t domain:notdevfile_class_set r_file_perms;
 allow logrotate_t domain:dir r_dir_perms;
 
@@ -101,3 +103,6 @@
 ifdef(`backup.te', `
 rw_dir_create_file(logrotate_t, backup_store_t)
 ')
+
+allow logrotate_t fs_t:filesystem getattr;
+can_exec(logrotate_t, shell_exec_t)
diff -ru /tmp/policy/domains/program/modutil.te ./domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2003-03-28 22:39:01.000000000 +0100
+++ ./domains/program/modutil.te	2003-03-29 20:51:04.000000000 +0100
@@ -24,11 +24,18 @@
 
 type depmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans(initrc_t, depmod_exec_t, depmod_t)
+allow depmod_t sbin_t:dir search;
+dontaudit depmod_t bin_t:dir search;
 can_exec(depmod_t, depmod_exec_t)
 domain_auto_trans(sysadm_t, depmod_exec_t, depmod_t)
 
-# Inherit and use descriptors from init.
-allow depmod_t init_t:fd use;
+# Inherit and use descriptors from init and login programs.
+allow depmod_t { init_t privfd }:fd use;
+
+allow depmod_t { etc_t etc_runtime_t }:file { getattr read };
+allow depmod_t { device_t proc_t }:dir search;
+allow depmod_t proc_t:file { getattr read };
+allow depmod_t fs_t:filesystem getattr;
 
 # Read conf.modules.
 allow depmod_t modules_conf_t:file r_file_perms;
@@ -52,29 +59,30 @@
 #
 # Rules for the insmod_t domain.
 #
-# Rules for /proc/sys/kernel/tainted
 
 type insmod_t, domain, privlog;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
 
 uses_shlib(insmod_t)
+allow insmod_t self:udp_socket create_socket_perms;
 
 type insmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans({ initrc_t kernel_t }, insmod_exec_t, insmod_t)
 allow initrc_t insmod_exec_t:lnk_file read;
 can_exec(insmod_t, insmod_exec_t)
+allow insmod_t sbin_t:dir search;
+dontaudit insmod_t bin_t:dir search;
+allow insmod_t sbin_t:lnk_file read;
 allow insmod_t init_t:fd use;
 domain_auto_trans(sysadm_t, insmod_exec_t, insmod_t)
+allow insmod_t fs_t:filesystem getattr;
+allow insmod_t { modules_conf_t modules_dep_t }:file { getattr read };
 
 # Read module objects.
 allow insmod_t modules_object_t:dir r_dir_perms;
 allow insmod_t modules_object_t:{ file lnk_file } r_file_perms;
 
-# Read module config and dependency files.
-allow insmod_t modules_conf_t:file r_file_perms;
-allow insmod_t modules_dep_t:file r_file_perms;
-
 # Use the sys_module capability.
 allow insmod_t self:capability { sys_module kill };
 
@@ -87,29 +95,36 @@
 # I do not know why insmod sends signals or what signals it sends
 allow insmod_t domain:process signal;
 
+# Rules for /proc/sys/kernel/tainted
+allow insmod_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
 allow insmod_t sysctl_t:file write;
+allow insmod_t proc_t:file { getattr read };
 
 # /var/log/ksymoops/*
 allow insmod_t var_t:dir r_dir_perms;
 allow insmod_t var_log_t:dir r_dir_perms;
+allow insmod_t var_log_ksyms_t:file create_file_perms;
 allow insmod_t var_log_ksyms_t:dir create_dir_perms;
 
 ifdef(`crond.te', `
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)
 ')
+
 ifdef(`ipsec.te',
 `# Rules for ipsec Domain 
 allow insmod_t ipsec_t:process signal;')
 
+allow insmod_t device_t:dir search;
+allow insmod_t etc_runtime_t:file { getattr read };
+allow insmod_t self:process { fork signal_perms };
+
 # Access terminals.
 allow insmod_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow insmod_t sysadm_gph_t:fd use;')
 
 uses_shlib(insmod_t)
 
-allow insmod_t initctl_t:fifo_file rw_file_perms;
-
 #################################
 #
 # Rules for the update_modules_t domain.
@@ -134,14 +149,13 @@
 allow update_modules_t self:process { fork sigchld };
 allow update_modules_t self:fifo_file rw_file_perms;
 allow update_modules_t modules_dep_t:file rw_file_perms;
-
 file_type_auto_trans(update_modules_t, modules_object_t, modules_conf_t)
 domain_auto_trans_read(update_modules_t, depmod_exec_t, depmod_t)
-can_exec(update_modules_t, { shell_exec_t bin_t sbin_t update_modules_exec_t })
-
+can_exec(update_modules_t, { shell_exec_t bin_t sbin_t update_modules_exec_t etc_t })
 allow update_modules_t bin_t:lnk_file read;
 allow update_modules_t { sbin_t bin_t }:dir search;
 allow update_modules_t { etc_t etc_runtime_t }:file r_file_perms;
+allow update_modules_t etc_t:lnk_file read;
 allow update_modules_t fs_t:filesystem getattr;
 
 allow update_modules_t proc_t:dir search;
diff -ru /tmp/policy/file_contexts/program/nsd.fc ./file_contexts/program/nsd.fc
--- /tmp/policy/file_contexts/program/nsd.fc	2003-03-16 12:33:45.000000000 +0100
+++ ./file_contexts/program/nsd.fc	2003-03-27 16:42:15.000000000 +0100
@@ -1,4 +1,9 @@
 # nsd
 /etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
+/etc/nsd/primary(/.*)?		system_u:object_r:nsd_zone_t
+/etc/nsd/secondary(/.*)?	system_u:object_r:nsd_zone_t
+/etc/nsd/nsd.db			system_u:object_r:nsd_zone_t
 /usr/sbin/nsd      		system_u:object_r:nsd_exec_t
+/usr/sbin/nsdc      		system_u:object_r:nsd_exec_t
+/usr/sbin/nsd-notify		system_u:object_r:nsd_exec_t
 /var/run/nsd\.pid		system_u:object_r:var_run_nsd_t
diff -ru /tmp/policy/file_contexts/program/ntpd.fc ./file_contexts/program/ntpd.fc
--- /tmp/policy/file_contexts/program/ntpd.fc	2003-03-16 12:33:45.000000000 +0100
+++ ./file_contexts/program/ntpd.fc	2003-03-26 00:00:03.000000000 +0100
@@ -1,6 +1,7 @@
 /var/lib/ntp(/.*)?			system_u:object_r:var_lib_ntp_t
 /etc/ntp\.conf				system_u:object_r:etc_ntp_t
 /usr/sbin/ntpd				system_u:object_r:ntpd_exec_t
+/usr/sbin/ntpdate			system_u:object_r:ntpd_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:var_log_ntp_t
 /var/log/ntpd.*				system_u:object_r:var_log_ntp_t
 /etc/cron\.(daily|weekly)/ntp-simple	system_u:object_r:ntpd_exec_t
diff -ru /tmp/policy/file_contexts/program/sysstat.fc ./file_contexts/program/sysstat.fc
--- /tmp/policy/file_contexts/program/sysstat.fc	2002-07-12 17:19:44.000000000 +0200
+++ ./file_contexts/program/sysstat.fc	2003-03-29 13:43:31.000000000 +0100
@@ -1,5 +1,5 @@
 # sysstat and other sar programs
-/usr/lib/atsar/atsadc		system_u:object_r:sysstat_exec_t
+/usr/lib/atsar/atsa.*		system_u:object_r:sysstat_exec_t
 /usr/lib/sysstat/sa.*		system_u:object_r:sysstat_exec_t
 /var/log/atsar(/.*)?		system_u:object_r:var_log_sysstat_t
 /var/log/sysstat(/.*)?		system_u:object_r:var_log_sysstat_t
diff -ru /tmp/policy/fs_use ./fs_use
--- /tmp/policy/fs_use	2003-03-27 13:57:55.000000000 +0100
+++ ./fs_use	2003-03-28 02:39:08.000000000 +0100
@@ -10,6 +10,7 @@
 fs_use_psid ext3;
 fs_use_psid reiserfs;
 fs_use_psid jfs;
+fs_use_psid jffs2;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.

--Boundary-00=_S4fh+V0IySbJmS1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
