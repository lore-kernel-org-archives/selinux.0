Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1PGFEDo013114
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2005 11:15:14 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1PGCPew017189
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2005 16:12:25 GMT
Subject: Read_sysctl macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-JyMVIADCPi3Q1RyHufnl"
Date: Fri, 25 Feb 2005 11:15:36 -0500
Message-Id: <1109348137.10467.27.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JyMVIADCPi3Q1RyHufnl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I like macros. Macros are good, because
1) Guaranteed consistency, no typos
2) Change in one place, change everywhere
3) Reduce number of primitives to work with

In the spirit of macros, how about actually
making use of the read_sysctl macro 
(the non-full portion of it)

Currently it looks like this:

##################################
# read_sysctl(domain)
#
# Permissions for reading sysctl variables.
# If the second parameter is 'full', allow
# reading of any sysctl variables, else only
# sysctl_kernel_t.
#
define(`read_sysctl', `
# Read system variables in /sys.
ifelse($2,`full', `
allow $1 sysctl_type:dir r_dir_perms;
allow $1 sysctl_type:file r_file_perms;
', `
allow $1 sysctl_t:dir search;
allow $1 sysctl_kernel_t:dir search;
allow $1 sysctl_kernel_t:file { getattr read };
')

')dnl read_sysctl

patch attached.
It gives some domains less privs than before, and
some more, but I don't know if that's a problem.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-JyMVIADCPi3Q1RyHufnl
Content-Disposition: attachment; filename=read_sysctl.diff
Content-Type: text/x-patch; name=read_sysctl.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aur policy/domains/program/acct.te policy.new2/domains/program/acct.te
--- policy/domains/program/acct.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/acct.te	2005-02-25 02:16:17.000000000 -0500
@@ -46,8 +46,7 @@
 
 allow acct_t proc_t:file { read getattr };
 
-allow acct_t { sysctl_kernel_t sysctl_t }:dir search;
-allow acct_t sysctl_kernel_t:file read;
+read_sysctl(acct_t)
 
 dontaudit acct_t sysadm_home_dir_t:dir { getattr search };
 
diff -aur policy/domains/program/amanda.te policy.new2/domains/program/amanda.te
--- policy/domains/program/amanda.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/amanda.te	2005-02-25 02:16:41.000000000 -0500
@@ -141,9 +141,7 @@
 allow amanda_t fs_t:filesystem getattr;
 
 # access to sysctl_kernel_t ( proc/sys/kernel/* )
-allow amanda_t sysctl_kernel_t:dir search;
-allow amanda_t sysctl_kernel_t:file read;
-
+read_sysctl(amanda_t)
 
 #####################
 # process permissions
@@ -275,8 +273,7 @@
 allow amanda_recover_t proc_t:file { getattr read };
 
 # access to sysctl_kernel_t
-allow amanda_recover_t sysctl_kernel_t:dir search;
-allow amanda_recover_t sysctl_kernel_t:file read;
+read_sysctl(amanda_recover_t)
 
 # access to dev_t and similar
 allow amanda_recover_t device_t:dir search;
diff -aur policy/domains/program/apache.te policy.new2/domains/program/apache.te
--- policy/domains/program/apache.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/apache.te	2005-02-25 02:09:14.000000000 -0500
@@ -80,8 +80,7 @@
 
 allow httpd_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 
-allow httpd_t sysctl_kernel_t:dir search;
-allow httpd_t sysctl_kernel_t:file read;
+read_sysctl(httpd_t)
 
 # for modules that want to access /etc/mtab and /proc/meminfo
 allow httpd_t { proc_t etc_runtime_t }:file { getattr read };
diff -aur policy/domains/program/apmd.te policy.new2/domains/program/apmd.te
--- policy/domains/program/apmd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/apmd.te	2005-02-25 02:14:09.000000000 -0500
@@ -31,8 +31,7 @@
 
 allow apmd_t device_t:lnk_file read;
 allow apmd_t proc_t:file { getattr read };
-allow apmd_t sysctl_kernel_t:dir search;
-allow apmd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(apmd_t)
 allow apmd_t self:unix_dgram_socket create_socket_perms;
 allow apmd_t self:unix_stream_socket create_stream_socket_perms;
 allow apmd_t self:fifo_file rw_file_perms;
diff -aur policy/domains/program/bootloader.te policy.new2/domains/program/bootloader.te
--- policy/domains/program/bootloader.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/bootloader.te	2005-02-25 02:12:16.000000000 -0500
@@ -144,8 +144,7 @@
 allow bootloader_t proc_t:lnk_file { getattr read };
 allow bootloader_t proc_mdstat_t:file r_file_perms;
 allow bootloader_t self:dir { getattr search read };
-allow bootloader_t sysctl_kernel_t:dir search;
-allow bootloader_t sysctl_kernel_t:file { getattr read };
+read_sysctl(bootloader_t)
 allow bootloader_t etc_runtime_t:file r_file_perms;
 
 allow bootloader_t devtty_t:chr_file rw_file_perms;
diff -aur policy/domains/program/cups.te policy.new2/domains/program/cups.te
--- policy/domains/program/cups.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/cups.te	2005-02-25 02:12:58.000000000 -0500
@@ -60,8 +60,9 @@
 allow cupsd_t proc_t:file r_file_perms;
 allow cupsd_t proc_t:dir r_dir_perms;
 allow cupsd_t self:file { getattr read };
-allow cupsd_t { sysctl_t sysctl_kernel_t sysctl_dev_t }:dir search;
-allow cupsd_t { sysctl_kernel_t sysctl_dev_t }:file { getattr read };
+read_sysctl(cupsd_t)
+allow cupsd_t sysctl_dev_t:dir search;
+allow cupsd_t sysctl_dev_t:file { getattr read };
 
 # for /etc/printcap
 dontaudit cupsd_t etc_t:file write;
diff -aur policy/domains/program/dhcpc.te policy.new2/domains/program/dhcpc.te
--- policy/domains/program/dhcpc.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/dhcpc.te	2005-02-25 02:08:54.000000000 -0500
@@ -78,8 +78,7 @@
 allow dhcpc_t proc_net_t:dir search;
 allow dhcpc_t { proc_t proc_net_t }:file { getattr read };
 allow dhcpc_t self:file { getattr read };
-allow dhcpc_t sysctl_kernel_t:dir search;
-allow dhcpc_t sysctl_kernel_t:file read;
+read_sysctl(dhcpc_t)
 allow dhcpc_t { userdomain run_init_t }:fd use;
 
 # Use capabilities
diff -aur policy/domains/program/dovecot.te policy.new2/domains/program/dovecot.te
--- policy/domains/program/dovecot.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/dovecot.te	2005-02-25 02:08:35.000000000 -0500
@@ -49,8 +49,7 @@
 allow dovecot_auth_t etc_t:file { getattr read };
 allow dovecot_auth_t { self proc_t }:file { getattr read };
 read_locale(dovecot_auth_t)
-allow dovecot_auth_t sysctl_kernel_t:dir search;
-allow dovecot_auth_t sysctl_kernel_t:file read;
+read_sysctl(dovecot_auth_t)
 allow dovecot_auth_t sysctl_t:dir search;
 dontaudit dovecot_auth_t selinux_config_t:dir search;
 
diff -aur policy/domains/program/fingerd.te policy.new2/domains/program/fingerd.te
--- policy/domains/program/fingerd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/fingerd.te	2005-02-25 02:14:31.000000000 -0500
@@ -79,5 +79,4 @@
 allow fingerd_t proc_t:file { read getattr };
 
 # for date command
-allow fingerd_t sysctl_kernel_t:dir search;
-allow fingerd_t sysctl_kernel_t:file { read getattr };
+read_sysctl(fingerd_t)
diff -aur policy/domains/program/fsadm.te policy.new2/domains/program/fsadm.te
--- policy/domains/program/fsadm.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/fsadm.te	2005-02-25 02:06:18.000000000 -0500
@@ -25,8 +25,7 @@
 r_dir_file(fsadm_t, proc_t)
 
 # Read system variables in /proc/sys
-allow fsadm_t sysctl_kernel_t:file r_file_perms;
-allow fsadm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(fsadm_t)
 
 # for /dev/shm
 allow fsadm_t tmpfs_t:dir { getattr search };
diff -aur policy/domains/program/ftpd.te policy.new2/domains/program/ftpd.te
--- policy/domains/program/ftpd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/ftpd.te	2005-02-25 02:05:53.000000000 -0500
@@ -24,8 +24,7 @@
 allow ftpd_t bin_t:dir search;
 can_exec(ftpd_t, bin_t)
 allow ftpd_t bin_t:lnk_file read;
-allow ftpd_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ftpd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ftpd_t)
 
 allow ftpd_t urandom_device_t:chr_file { getattr read };
 
diff -aur policy/domains/program/hotplug.te policy.new2/domains/program/hotplug.te
--- policy/domains/program/hotplug.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/hotplug.te	2005-02-25 02:39:39.000000000 -0500
@@ -23,6 +23,7 @@
 allow hotplug_t self:unix_stream_socket create_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 
+read_sysctl(hotplug_t)
 allow hotplug_t sysctl_net_t:dir r_dir_perms;
 allow hotplug_t sysctl_net_t:file { getattr read };
 
@@ -81,10 +82,6 @@
 allow hotplug_t self:process { getsession getattr };
 allow hotplug_t self:file getattr;
 
-# for sleep
-allow hotplug_t sysctl_kernel_t:dir search;
-allow hotplug_t sysctl_kernel_t:file { getattr read };
-
 domain_auto_trans(kernel_t, hotplug_exec_t, hotplug_t)
 domain_auto_trans(hotplug_t, mount_exec_t, mount_t)
 domain_auto_trans(hotplug_t, ifconfig_exec_t, ifconfig_t)
diff -aur policy/domains/program/kudzu.te policy.new2/domains/program/kudzu.te
--- policy/domains/program/kudzu.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/kudzu.te	2005-02-25 02:11:52.000000000 -0500
@@ -30,10 +30,10 @@
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
 allow kudzu_t { bin_t sbin_t }:dir { getattr search };
 allow kudzu_t { bin_t sbin_t }:lnk_file read;
-allow kudzu_t { sysctl_t sysctl_kernel_t }:dir search;
+read_sysctl(kudzu_t)
 allow kudzu_t sysctl_dev_t:dir { getattr search read };
 allow kudzu_t sysctl_dev_t:file { getattr read };
-allow kudzu_t sysctl_kernel_t:file { getattr read write };
+allow kudzu_t sysctl_kernel_t:file write;
 allow kudzu_t usbdevfs_t:dir search;
 allow kudzu_t usbdevfs_t:file { getattr read };
 allow kudzu_t usbfs_t:dir search;
diff -aur policy/domains/program/logrotate.te policy.new2/domains/program/logrotate.te
--- policy/domains/program/logrotate.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/logrotate.te	2005-02-25 02:03:10.000000000 -0500
@@ -61,10 +61,9 @@
 allow logrotate_t pidfile:file r_file_perms;
 
 # Read /proc/PID directories for all domains.
+read_sysctl(logrotate_t)
 allow logrotate_t proc_t:dir r_dir_perms;
 allow logrotate_t proc_t:{ file lnk_file } r_file_perms;
-allow logrotate_t { sysctl_t sysctl_kernel_t }:dir search;
-allow logrotate_t sysctl_kernel_t:file { getattr read };
 allow logrotate_t domain:notdevfile_class_set r_file_perms;
 allow logrotate_t domain:dir r_dir_perms;
 allow logrotate_t exec_type:file getattr;
diff -aur policy/domains/program/lvm.te policy.new2/domains/program/lvm.te
--- policy/domains/program/lvm.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/lvm.te	2005-02-25 02:03:30.000000000 -0500
@@ -38,8 +38,7 @@
 allow lvm_t self:file r_file_perms;
 
 # Read system variables in /proc/sys
-allow lvm_t sysctl_kernel_t:file r_file_perms;
-allow lvm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(lvm_t)
 
 # Read /sys/block. Device mapper metadata is kept there.
 r_dir_file(lvm_t, sysfs_t) 
diff -aur policy/domains/program/mailman.te policy.new2/domains/program/mailman.te
--- policy/domains/program/mailman.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/mailman.te	2005-02-25 02:13:47.000000000 -0500
@@ -18,8 +18,9 @@
 create_dir_file(mailman_$1_t, mailman_data_t)
 uses_shlib(mailman_$1_t)
 can_exec_any(mailman_$1_t)
-allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
-allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
+read_sysctl(mailman_$1_t)
+allow mailman_$1_t proc_t:dir search;
+allow mailman_$1_t proc_t:file { read getattr };
 allow mailman_$1_t var_lib_t:dir r_dir_perms;
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
diff -aur policy/domains/program/mdadm.te policy.new2/domains/program/mdadm.te
--- policy/domains/program/mdadm.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/mdadm.te	2005-02-25 02:07:56.000000000 -0500
@@ -11,8 +11,7 @@
 # Kernel filesystem permissions
 r_dir_file(mdadm_t, proc_t)
 allow mdadm_t proc_mdstat_t:file rw_file_perms;
-allow mdadm_t sysctl_kernel_t:file r_file_perms;
-allow mdadm_t sysctl_kernel_t:dir r_dir_perms;
+read_sysctl(mdadm_t)
 r_dir_file(mdadm_t, sysfs_t) 
 
 # Configuration
diff -aur policy/domains/program/modutil.te policy.new2/domains/program/modutil.te
--- policy/domains/program/modutil.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/modutil.te	2005-02-25 02:10:45.000000000 -0500
@@ -138,8 +138,10 @@
 allow insmod_t { usbfs_t usbdevfs_t }:filesystem mount;
 
 # Rules for /proc/sys/kernel/tainted
-allow insmod_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
-allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };
+read_sysctl(insmod_t)
+allow insmod_t proc_t:dir search;
+allow insmod_t sysctl_kernel_t:file { setattr w_file_perms };
+
 allow insmod_t proc_t:file { getattr read };
 allow insmod_t proc_t:lnk_file read;
 
@@ -218,8 +220,7 @@
 allow update_modules_t proc_t:dir search;
 allow update_modules_t proc_t:file r_file_perms;
 allow update_modules_t { self proc_t }:lnk_file read;
-allow update_modules_t { sysctl_t sysctl_kernel_t }:dir search;
-allow update_modules_t sysctl_kernel_t:file { getattr read };
+read_sysctl(update_modules_t)
 allow update_modules_t self:dir search;
 allow update_modules_t self:unix_stream_socket create_socket_perms;
 
diff -aur policy/domains/program/mrtg.te policy.new2/domains/program/mrtg.te
--- policy/domains/program/mrtg.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/mrtg.te	2005-02-25 01:52:11.000000000 -0500
@@ -75,8 +75,7 @@
 
 dontaudit mrtg_t security_t:dir getattr;
 
-allow mrtg_t { sysctl_t sysctl_kernel_t }:dir search;
-allow mrtg_t sysctl_kernel_t:file read;
+read_sysctl(mrtg_t)
 
 # for uptime
 allow mrtg_t var_run_t:dir search;
diff -aur policy/domains/program/mysqld.te policy.new2/domains/program/mysqld.te
--- policy/domains/program/mysqld.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/mysqld.te	2005-02-25 02:03:57.000000000 -0500
@@ -53,8 +53,7 @@
 
 allow mysqld_t etc_t:dir search;
 
-allow mysqld_t sysctl_kernel_t:dir search;
-allow mysqld_t sysctl_kernel_t:file read;
+read_sysctl(mysqld_t)
 
 can_unix_connect(sysadm_t, mysqld_t)
 
diff -aur policy/domains/program/named.te policy.new2/domains/program/named.te
--- policy/domains/program/named.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/named.te	2005-02-25 02:04:25.000000000 -0500
@@ -84,9 +84,7 @@
 allow named_t self:netlink_route_socket r_netlink_socket_perms;
 
 # Read sysctl kernel variables.
-allow named_t sysctl_t:dir r_dir_perms;
-allow named_t sysctl_kernel_t:dir r_dir_perms;
-allow named_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(named_t)
 
 # Read /proc/cpuinfo and /proc/net
 r_dir_file(named_t, proc_t)
@@ -133,9 +131,7 @@
 allow ndc_t fs_t:filesystem getattr;
 
 # Read sysctl kernel variables.
-allow ndc_t sysctl_t:dir r_dir_perms;
-allow ndc_t sysctl_kernel_t:dir r_dir_perms;
-allow ndc_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(ndc_t)
 
 allow ndc_t self:process { fork signal_perms };
 allow ndc_t self:fifo_file { read write getattr ioctl };
diff -aur policy/domains/program/nscd.te policy.new2/domains/program/nscd.te
--- policy/domains/program/nscd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/nscd.te	2005-02-25 01:51:10.000000000 -0500
@@ -44,8 +44,7 @@
 allow nscd_t self:nscd { admin getstat };
 allow nscd_t admin_tty_type:chr_file rw_file_perms;
 
-allow nscd_t sysctl_kernel_t:dir search;
-allow nscd_t sysctl_kernel_t:file read;
+read_sysctl(nscd_t)
 allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
diff -aur policy/domains/program/ntpd.te policy.new2/domains/program/ntpd.te
--- policy/domains/program/ntpd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/ntpd.te	2005-02-25 01:50:41.000000000 -0500
@@ -62,8 +62,7 @@
 can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
-allow ntpd_t sysctl_kernel_t:dir search;
-allow ntpd_t sysctl_kernel_t:file read;
+read_sysctl(ntpd_t);
 allow ntpd_t proc_t:file r_file_perms;
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
 allow ntpd_t self:file { getattr read };
diff -aur policy/domains/program/postfix.te policy.new2/domains/program/postfix.te
--- policy/domains/program/postfix.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/postfix.te	2005-02-25 02:01:52.000000000 -0500
@@ -60,8 +60,7 @@
 
 file_type_auto_trans(postfix_$1_t, var_run_t, postfix_var_run_t, file)
 
-allow postfix_$1_t { sysctl_t sysctl_kernel_t }:dir search;
-allow postfix_$1_t sysctl_kernel_t:file { getattr read };
+read_sysctl(postfix_$1_t)
 
 ')dnl end postfix_domain
 
@@ -73,19 +72,22 @@
 
 read_sysctl(postfix_master_t)
 
-ifdef(`direct_sysadm_daemon', `
-dontaudit postfix_master_t admin_tty_type:chr_file { read write };
-')
-
 domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
 allow initrc_t postfix_master_t:process { noatsecure siginh rlimitinh };
+
 ifdef(`direct_sysadm_daemon', `
+
 domain_auto_trans(sysadm_t, postfix_master_exec_t, postfix_master_t)
 allow sysadm_t postfix_master_t:process { noatsecure siginh rlimitinh };
 role_transition sysadm_r postfix_master_exec_t system_r;
+allow postfix_master_t postfix_etc_t:file rw_file_perms;
+dontaudit postfix_master_t admin_tty_type:chr_file { read write };
+allow postfix_master_t devpts_t:dir search;
+
 domain_auto_trans(sysadm_mail_t, postfix_master_exec_t, system_mail_t)
 allow system_mail_t sysadm_t:process sigchld;
 allow system_mail_t privfd:fd use;
+
 ')dnl end direct_sysadm_daemon
 
 allow postfix_master_t privfd:fd use;
@@ -106,8 +108,6 @@
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
 can_exec(postfix_master_t, { ls_exec_t sbin_t })
-allow postfix_master_t sysctl_kernel_t:dir r_dir_perms;
-allow postfix_master_t sysctl_kernel_t:file r_file_perms;
 allow postfix_master_t self:fifo_file rw_file_perms;
 allow postfix_master_t usr_t:file r_file_perms;
 can_exec(postfix_master_t, { shell_exec_t bin_t postfix_exec_t })
@@ -139,10 +139,6 @@
 allow postfix_master_t postfix_prng_t:file rw_file_perms;
 # for ls to get the current context
 allow postfix_master_t self:file { getattr read };
-ifdef(`direct_sysadm_daemon', `
-allow postfix_master_t postfix_etc_t:file rw_file_perms;
-allow postfix_master_t devpts_t:dir search;
-')
 
 # for SSP
 allow postfix_master_t urandom_device_t:chr_file read;
diff -aur policy/domains/program/postgresql.te policy.new2/domains/program/postgresql.te
--- policy/domains/program/postgresql.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/postgresql.te	2005-02-25 01:55:55.000000000 -0500
@@ -98,8 +98,7 @@
 
 allow postgresql_t etc_t:dir rw_dir_perms;
 
-allow postgresql_t { sysctl_t sysctl_kernel_t }:dir search;
-allow postgresql_t sysctl_kernel_t:file read;
+read_sysctl(postgresql_t)
 
 allow postgresql_t devtty_t:chr_file { read write };
 allow postgresql_t devpts_t:dir search;
diff -aur policy/domains/program/radius.te policy.new2/domains/program/radius.te
--- policy/domains/program/radius.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/radius.te	2005-02-25 01:54:24.000000000 -0500
@@ -26,8 +26,8 @@
 dontaudit radiusd_t sysadm_home_dir_t:dir getattr;
 
 # allow pthreads to read kernel version
-allow radiusd_t sysctl_kernel_t:dir r_dir_perms;
-allow radiusd_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(radiusd_t)
+
 # read config files
 allow radiusd_t etc_t:dir r_dir_perms;
 allow radiusd_t { etc_t etc_runtime_t }:file { read getattr };
diff -aur policy/domains/program/sendmail.te policy.new2/domains/program/sendmail.te
--- policy/domains/program/sendmail.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/sendmail.te	2005-02-25 02:17:48.000000000 -0500
@@ -81,14 +81,15 @@
 allow sendmail_t bin_t:dir { getattr search };
 ')
 
+read_sysctl(sendmail_t)
+read_sysctl(system_mail_t)
+
 allow system_mail_t etc_mail_t:dir { getattr search };
 allow system_mail_t etc_runtime_t:file { getattr read };
 allow system_mail_t proc_t:dir search;
 allow system_mail_t proc_t:file { getattr read };
 allow system_mail_t proc_t:lnk_file read;
 dontaudit system_mail_t proc_net_t:dir search;
-allow sendmail_t sysctl_kernel_t:dir search;
-allow sendmail_t sysctl_kernel_t:file { getattr read };
 allow system_mail_t fs_t:filesystem getattr;
 allow system_mail_t self:dir { getattr search };
 allow system_mail_t var_t:dir getattr;
@@ -99,7 +100,6 @@
 allow system_mail_t mqueue_spool_t:dir rw_dir_perms;
 allow system_mail_t mqueue_spool_t:file create_file_perms;
 
-allow system_mail_t sysctl_kernel_t:file read;
 ifdef(`crond.te', `
 dontaudit system_mail_t system_crond_tmp_t:file append;
 ')
diff -aur policy/domains/program/slapd.te policy.new2/domains/program/slapd.te
--- policy/domains/program/slapd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/slapd.te	2005-02-25 01:55:30.000000000 -0500
@@ -54,8 +54,7 @@
 
 allow slapd_t etc_t:dir r_dir_perms;
 
-allow slapd_t sysctl_kernel_t:dir search;
-allow slapd_t sysctl_kernel_t:file read;
+read_sysctl(slapd_t)
 
 allow slapd_t usr_t:file { read getattr };
 allow slapd_t urandom_device_t:chr_file { getattr read };
diff -aur policy/domains/program/spamd.te policy.new2/domains/program/spamd.te
--- policy/domains/program/spamd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/spamd.te	2005-02-25 01:49:02.000000000 -0500
@@ -15,10 +15,10 @@
 general_domain_access(spamd_t)
 uses_shlib(spamd_t)
 can_ypbind(spamd_t)
+read_sysctl(spamd_t)
 
 # Various Perl bits
 allow spamd_t lib_t:file rx_file_perms;
-dontaudit spamd_t { sysctl_t sysctl_kernel_t }:dir search;
 dontaudit spamd_t shadow_t:file { getattr read };
 dontaudit spamd_t initrc_var_run_t:file { read write lock };
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
@@ -48,7 +48,6 @@
 rw_dir_create_file(spamd_t, amavisd_lib_t)
 ')
 
-allow spamd_t sysctl_kernel_t:file { getattr read };
 allow spamd_t usr_t:file { getattr ioctl read };
 allow spamd_t usr_t:lnk_file { getattr read };
 allow spamd_t urandom_device_t:chr_file { getattr read };
diff -aur policy/domains/program/squid.te policy.new2/domains/program/squid.te
--- policy/domains/program/squid.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/squid.te	2005-02-25 02:02:24.000000000 -0500
@@ -35,8 +35,7 @@
 allow squid_t self:unix_dgram_socket create_socket_perms;
 allow squid_t self:fifo_file rw_file_perms;
 
-allow squid_t { sysctl_t sysctl_kernel_t }:dir search;
-allow squid_t sysctl_kernel_t:file read;
+read_sysctl(squid_t)
 
 allow squid_t devtty_t:chr_file rw_file_perms;
 
diff -aur policy/domains/program/unused/backup.te policy.new2/domains/program/unused/backup.te
--- policy/domains/program/unused/backup.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/backup.te	2005-02-25 02:25:07.000000000 -0500
@@ -42,8 +42,7 @@
 allow backup_t proc_t:dir r_dir_perms;
 allow backup_t proc_t:file r_file_perms;
 allow backup_t proc_t:lnk_file { getattr read };
-allow backup_t { sysctl_t sysctl_kernel_t }:dir r_dir_perms;
-allow backup_t sysctl_kernel_t:file read;
+read_sysctl(backup_t)
 
 allow backup_t self:fifo_file rw_file_perms;
 allow backup_t self:process { signal sigchld fork };
diff -aur policy/domains/program/unused/calamaris.te policy.new2/domains/program/unused/calamaris.te
--- policy/domains/program/unused/calamaris.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/calamaris.te	2005-02-25 02:21:22.000000000 -0500
@@ -41,8 +41,9 @@
 allow calamaris_t urandom_device_t:chr_file { getattr read };
 
 allow calamaris_t self:process { fork signal_perms setsched };
-allow calamaris_t { proc_t sysctl_kernel_t }:dir search;
-allow calamaris_t { proc_t sysctl_kernel_t }:file { getattr read };
+read_sysctl(calamaris_t)
+allow calamaris_t proc_t:dir search;
+allow calamaris_t proc_t:file { getattr read };
 allow calamaris_t { proc_t self }:lnk_file read;
 allow calamaris_t self:dir search;
 
diff -aur policy/domains/program/unused/clamav.te policy.new2/domains/program/unused/clamav.te
--- policy/domains/program/unused/clamav.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/clamav.te	2005-02-25 02:24:41.000000000 -0500
@@ -19,8 +19,7 @@
 read_locale(freshclam_t)
 
 # not sure why it needs this
-allow freshclam_t sysctl_kernel_t:dir search;
-allow freshclam_t sysctl_kernel_t:file { getattr read };
+read_sysctl(freshclam_t)
 
 can_network_server(freshclam_t)
 can_ypbind(freshclam_t)
@@ -79,9 +78,8 @@
 allow clamd_t var_lib_t:dir search;
 r_dir_file(clamd_t, clamav_var_lib_t)
 r_dir_file(clamd_t, etc_t)
-allow clamd_t sysctl_t:dir r_dir_perms;
 # allow access /proc/sys/kernel/version
-r_dir_file(clamd_t, sysctl_kernel_t);
+read_sysctl(clamd_t)
 allow clamd_t self:unix_stream_socket create_stream_socket_perms;
 allow clamd_t self:unix_dgram_socket create_stream_socket_perms;
 allow clamd_t self:fifo_file rw_file_perms;
diff -aur policy/domains/program/unused/courier.te policy.new2/domains/program/unused/courier.te
--- policy/domains/program/unused/courier.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/courier.te	2005-02-25 02:23:08.000000000 -0500
@@ -137,5 +137,4 @@
 ifdef(`crond.te', `
 system_crond_entry(sqwebmail_cron_exec_t, courier_sqwebmail_t)
 ')
-allow courier_sqwebmail_t { sysctl_t sysctl_kernel_t }:dir search;
-allow courier_sqwebmail_t sysctl_kernel_t:file { getattr read };
+read_sysctl(courier_sqwebmail_t)
diff -aur policy/domains/program/unused/dpkg.te policy.new2/domains/program/unused/dpkg.te
--- policy/domains/program/unused/dpkg.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/dpkg.te	2005-02-25 02:22:21.000000000 -0500
@@ -199,10 +199,8 @@
 r_dir_file(userdomain, debconf_cache_t)
 
 # for python
-allow { apt_t dpkg_t } sysctl_kernel_t:dir { getattr search };
-allow { apt_t dpkg_t } sysctl_kernel_t:file r_file_perms;
-
-allow dpkg_t sysctl_t:dir search;
+read_sysctl(apt_t)
+read_sysctl(dpkg_t)
 
 allow dpkg_t console_device_t:chr_file rw_file_perms;
 
diff -aur policy/domains/program/unused/gatekeeper.te policy.new2/domains/program/unused/gatekeeper.te
--- policy/domains/program/unused/gatekeeper.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/gatekeeper.te	2005-02-25 02:22:44.000000000 -0500
@@ -31,8 +31,7 @@
 tmp_domain(gatekeeper)
 
 # pthreads wants to know the kernel version
-allow gatekeeper_t sysctl_kernel_t:dir r_dir_perms;
-allow gatekeeper_t sysctl_kernel_t:file r_file_perms;
+read_sysctl(gatekeeper_t)
 
 allow gatekeeper_t etc_t:file { getattr read };
 
diff -aur policy/domains/program/unused/sxid.te policy.new2/domains/program/unused/sxid.te
--- policy/domains/program/unused/sxid.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/sxid.te	2005-02-25 02:21:43.000000000 -0500
@@ -40,8 +40,7 @@
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
 allow sxid_t { proc_t self }:{ file lnk_file } { read getattr };
-allow sxid_t { sysctl_kernel_t sysctl_t }:dir search;
-allow sxid_t sysctl_kernel_t:file read;
+read_sysctl(sxid_t)
 allow sxid_t devtty_t:chr_file rw_file_perms;
 
 allow sxid_t self:capability { dac_override dac_read_search fsetid };
diff -aur policy/domains/program/unused/transproxy.te policy.new2/domains/program/unused/transproxy.te
--- policy/domains/program/unused/transproxy.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/unused/transproxy.te	2005-02-25 02:23:41.000000000 -0500
@@ -34,6 +34,5 @@
 
 #allow transproxy_t etc_t:dir r_dir_perms;
 
-#allow transproxy_t sysctl_kernel_t:dir search;
-#allow transproxy_t sysctl_kernel_t:file read;
+#read_sysctl(transproxy_t)
 
diff -aur policy/domains/program/updfstab.te policy.new2/domains/program/updfstab.te
--- policy/domains/program/updfstab.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/updfstab.te	2005-02-25 02:19:14.000000000 -0500
@@ -35,9 +35,8 @@
 
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
 # I will not allow it
-dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
+read_sysctl(updfstab_t)
 dontaudit updfstab_t sysctl_kernel_t:file write;
-allow updfstab_t sysctl_kernel_t:file { getattr read };
 allow updfstab_t modules_conf_t:file { getattr read };
 allow updfstab_t sbin_t:dir search;
 allow updfstab_t sbin_t:lnk_file read;
diff -aur policy/domains/program/useradd.te policy.new2/domains/program/useradd.te
--- policy/domains/program/useradd.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/useradd.te	2005-02-25 01:49:27.000000000 -0500
@@ -71,8 +71,7 @@
 user_group_add_program(useradd)
 
 # for getting the number of groups
-allow useradd_t { sysctl_t sysctl_kernel_t }:dir search;
-allow useradd_t sysctl_kernel_t:file { getattr read };
+read_sysctl(useradd_t)
 
 # Add/remove user home directories
 file_type_auto_trans(useradd_t, home_root_t, user_home_dir_t, dir)
diff -aur policy/domains/program/xdm.te policy.new2/domains/program/xdm.te
--- policy/domains/program/xdm.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/xdm.te	2005-02-25 02:16:00.000000000 -0500
@@ -200,8 +200,7 @@
 
 allow xdm_t proc_t:file { getattr read };
 
-allow xdm_t sysctl_kernel_t:dir search;
-allow xdm_t sysctl_kernel_t:file read;
+read_sysctl(xdm_t)
 
 # Search /proc for any user domain processes.
 allow xdm_t userdomain:dir r_dir_perms;
diff -aur policy/domains/program/ypbind.te policy.new2/domains/program/ypbind.te
--- policy/domains/program/ypbind.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/ypbind.te	2005-02-25 01:54:51.000000000 -0500
@@ -23,8 +23,7 @@
 
 allow ypbind_t self:fifo_file rw_file_perms;
 
-allow ypbind_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ypbind_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ypbind_t)
 
 # Send to portmap and initrc.
 can_udp_send(ypbind_t, portmap_t)
diff -aur policy/domains/program/ypserv.te policy.new2/domains/program/ypserv.te
--- policy/domains/program/ypserv.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/domains/program/ypserv.te	2005-02-25 02:18:34.000000000 -0500
@@ -20,8 +20,7 @@
 
 allow ypserv_t self:fifo_file rw_file_perms;
 
-allow ypserv_t { sysctl_t sysctl_kernel_t }:dir search;
-allow ypserv_t sysctl_kernel_t:file { getattr read };
+read_sysctl(ypserv_t)
 
 # Send to portmap and initrc.
 can_udp_send(ypserv_t, portmap_t)
diff -aur policy/macros/base_user_macros.te policy.new2/macros/base_user_macros.te
--- policy/macros/base_user_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/base_user_macros.te	2005-02-25 01:37:41.000000000 -0500
@@ -357,9 +357,7 @@
 allow $1_t default_t:notdevfile_class_set r_file_perms;
 }
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
-allow $1_t sysctl_t:dir search;
+read_sysctl($1_t);
 
 #
 # Caused by su - init scripts
diff -aur policy/macros/program/crond_macros.te policy.new2/macros/program/crond_macros.te
--- policy/macros/program/crond_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/program/crond_macros.te	2005-02-25 01:42:12.000000000 -0500
@@ -77,8 +77,7 @@
 allow $1_crond_t proc_t:dir r_dir_perms;
 allow $1_crond_t proc_t:file { getattr read ioctl };
 read_locale($1_crond_t)
-allow $1_crond_t { sysctl_t sysctl_kernel_t }:dir search;
-allow $1_crond_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_crond_t)
 allow $1_crond_t var_spool_t:dir search;
 allow $1_crond_t fs_type:filesystem getattr;
 
diff -aur policy/macros/program/inetd_macros.te policy.new2/macros/program/inetd_macros.te
--- policy/macros/program/inetd_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/program/inetd_macros.te	2005-02-25 01:44:35.000000000 -0500
@@ -37,8 +37,7 @@
 allow $1_t self:process { fork signal_perms };
 allow $1_t fs_t:filesystem getattr;
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_t)
 
 allow $1_t etc_t:file { getattr read };
 
diff -aur policy/macros/program/mplayer_macros.te policy.new2/macros/program/mplayer_macros.te
--- policy/macros/program/mplayer_macros.te	2005-02-25 11:00:07.000000000 -0500
+++ policy.new2/macros/program/mplayer_macros.te	2005-02-25 11:10:58.000000000 -0500
@@ -37,8 +37,7 @@
 allow $1_$2_t proc_t:file { getattr read };
 
 # Sysctl on kernel version 
-allow $1_$2_t sysctl_kernel_t:dir search;
-allow $1_$2_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_$2_t)
 
 # Allow ps, shared libs, locale, terminal access
 can_ps($1_t, $1_$2_t)
diff -aur policy/macros/program/userhelper_macros.te policy.new2/macros/program/userhelper_macros.te
--- policy/macros/program/userhelper_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/program/userhelper_macros.te	2005-02-25 01:46:32.000000000 -0500
@@ -116,7 +116,6 @@
 allow $1_userhelper_t urandom_device_t:chr_file { getattr read };
 
 allow $1_userhelper_t autofs_t:dir search;
-allow $1_userhelper_t sysctl_t:dir search;
 role system_r types $1_userhelper_t;
 r_dir_file($1_userhelper_t, nfs_t)
 
diff -aur policy/macros/program/x_client_macros.te policy.new2/macros/program/x_client_macros.te
--- policy/macros/program/x_client_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/program/x_client_macros.te	2005-02-25 01:44:05.000000000 -0500
@@ -78,8 +78,7 @@
 allow $1_$2_t proc_t:lnk_file read;
 allow $1_$2_t self:dir search;
 allow $1_$2_t self:lnk_file read;
-allow $1_$2_t sysctl_kernel_t:dir search;
-allow $1_$2_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_$2_t)
 
 ifdef(`xauth.te',`
 allow $1_$2_t $1_home_xauth_t:file { getattr read };
diff -aur policy/macros/user_macros.te policy.new2/macros/user_macros.te
--- policy/macros/user_macros.te	2005-02-23 11:12:51.000000000 -0500
+++ policy.new2/macros/user_macros.te	2005-02-25 01:39:09.000000000 -0500
@@ -143,8 +143,7 @@
 allow $1_t var_lib_t:dir r_dir_perms;
 allow $1_t var_lib_t:file { getattr read };
 
-allow $1_t sysctl_kernel_t:dir search;
-allow $1_t sysctl_kernel_t:file { getattr read };
+read_sysctl($1_t)
 
 # Read /etc.
 allow $1_t etc_t:dir r_dir_perms;

--=-JyMVIADCPi3Q1RyHufnl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
