Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CECqrT002301
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 10:12:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CECRDC009079
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 14:12:28 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 46C4C61C9D
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:12:47 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07600-02 for <selinux@tycho.nsa.gov>;
	Tue, 13 Jul 2004 00:12:45 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 584D561BD6
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:12:45 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 99044B59A3
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 00:12:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patch
Date: Tue, 13 Jul 2004 00:12:43 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bxp8AB1zMG3Tt5x"
Message-Id: <200407130012.43087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_bxp8AB1zMG3Tt5x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We don't have any sym-link under /boot for klogd to read.

Added some use of create_lnk_perms.

Allow load_policy_t to run in system_r for scripts to load policy.

var_log_t:chr_file is wrong.  syslogd_t can already write to terminal devices.

More cleaning up device_type stuff.

Fixed a couple of minor bugs in cpucontrol and lvm policy.

allow mdadm_t proc_t:file rw_file_perms;
I believe that the above is bogus.  The file can't be opened for write access 
on any system I have running regardless of what SE Linux does.

Fixed some mistakes in .fc files.

Made mysql work properly.

A few other small things.


Steve, I believe that this is worthy of CVS inclusion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bxp8AB1zMG3Tt5x
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/klogd.te ./domains/program/klogd.te
--- /usr/src/se/policy/domains/program/klogd.te	2004-07-08 13:09:33.000000000 +1000
+++ ./domains/program/klogd.te	2004-06-17 03:07:45.000000000 +1000
@@ -43,5 +43,3 @@
 # Read /boot/System.map*
 allow klogd_t system_map_t:file r_file_perms;
 allow klogd_t boot_t:dir r_dir_perms;
-allow klogd_t boot_t:lnk_file { read };
-
diff -ru /usr/src/se/policy/domains/program/ldconfig.te ./domains/program/ldconfig.te
--- /usr/src/se/policy/domains/program/ldconfig.te	2004-05-12 05:10:34.000000000 +1000
+++ ./domains/program/ldconfig.te	2004-07-08 23:42:59.000000000 +1000
@@ -23,7 +23,7 @@
 
 file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t, file)
 allow ldconfig_t lib_t:dir rw_dir_perms;
-allow ldconfig_t lib_t:lnk_file create_file_perms;
+allow ldconfig_t lib_t:lnk_file create_lnk_perms;
 
 allow ldconfig_t userdomain:fd use;
 allow ldconfig_t etc_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/load_policy.te ./domains/program/load_policy.te
--- /usr/src/se/policy/domains/program/load_policy.te	2004-06-17 15:10:38.000000000 +1000
+++ ./domains/program/load_policy.te	2004-07-04 18:19:12.000000000 +1000
@@ -11,6 +11,7 @@
 
 type load_policy_t, domain;
 role sysadm_r types load_policy_t;
+role system_r types load_policy_t;
 
 type load_policy_exec_t, file_type, exec_type, sysadmfile;
 
diff -ru /usr/src/se/policy/domains/program/modutil.te ./domains/program/modutil.te
--- /usr/src/se/policy/domains/program/modutil.te	2004-05-12 05:10:34.000000000 +1000
+++ ./domains/program/modutil.te	2004-07-04 23:42:54.000000000 +1000
@@ -81,6 +81,9 @@
 in_user_role(insmod_t)
 uses_shlib(insmod_t)
 read_locale(insmod_t)
+
+# for SSP
+allow insmod_t urandom_device_t:chr_file read;
 allow insmod_t lib_t:file { getattr read };
 
 allow insmod_t { bin_t sbin_t }:dir search;
diff -ru /usr/src/se/policy/domains/program/netutils.te ./domains/program/netutils.te
--- /usr/src/se/policy/domains/program/netutils.te	2004-06-18 10:47:55.000000000 +1000
+++ ./domains/program/netutils.te	2004-07-04 23:43:46.000000000 +1000
@@ -55,3 +55,6 @@
 allow netutils_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow netutils_t sysadm_gph_t:fd use;')
 allow netutils_t proc_t:dir { search };
+
+# for nscd
+dontaudit netutils_t var_t:dir search;
diff -ru /usr/src/se/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /usr/src/se/policy/domains/program/syslogd.te	2004-07-08 13:09:33.000000000 +1000
+++ ./domains/program/syslogd.te	2004-07-08 21:30:48.000000000 +1000
@@ -39,10 +39,6 @@
 
 # Modify/create log files.
 create_append_log_file(syslogd_t, var_log_t)
-#
-# This allows someone to set the context of a terminal for syslog output
-#
-allow syslogd_t var_log_t:chr_file { append };
 
 # Create and bind to /dev/log or /var/run/log.
 file_type_auto_trans(syslogd_t, { device_t var_run_t }, devlog_t, sock_file)
diff -ru /usr/src/se/policy/domains/program/tmpreaper.te ./domains/program/tmpreaper.te
--- /usr/src/se/policy/domains/program/tmpreaper.te	2004-04-07 13:32:14.000000000 +1000
+++ ./domains/program/tmpreaper.te	2004-07-08 23:42:30.000000000 +1000
@@ -17,7 +17,7 @@
 uses_shlib(tmpreaper_t)
 # why does it need setattr?
 allow tmpreaper_t tmpfile:dir { setattr rw_dir_perms rmdir };
-allow tmpreaper_t tmpfile:file_class_set { getattr unlink };
+allow tmpreaper_t tmpfile:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t { home_type file_t }:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t self:process { fork sigchld };
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
diff -ru /usr/src/se/policy/domains/program/unused/apmd.te ./domains/program/unused/apmd.te
--- /usr/src/se/policy/domains/program/unused/apmd.te	2004-06-17 15:10:39.000000000 +1000
+++ ./domains/program/unused/apmd.te	2004-07-05 00:02:14.000000000 +1000
@@ -75,7 +75,7 @@
 dontaudit apmd_t { file_type fs_type }:dir_file_class_set getattr;
 dontaudit apmd_t home_type:dir { search getattr };
 dontaudit apmd_t domain:key_socket getattr;
-
+dontaudit apmd_t domain:dir search;
 
 ifdef(`rpm.te', `
 can_exec(apmd_t, apmd_var_run_t)
diff -ru /usr/src/se/policy/domains/program/unused/backup.te ./domains/program/unused/backup.te
--- /usr/src/se/policy/domains/program/unused/backup.te	2004-03-18 15:36:08.000000000 +1100
+++ ./domains/program/unused/backup.te	2004-07-05 00:02:53.000000000 +1000
@@ -30,7 +30,9 @@
 
 allow backup_t { file_type fs_type }:dir r_dir_perms;
 allow backup_t file_type:{ file lnk_file } r_file_perms;
-allow backup_t file_type:{ sock_file fifo_file chr_file blk_file } getattr;
+allow backup_t file_type:{ sock_file fifo_file } getattr;
+allow backup_t { device_t device_type ttyfile }:chr_file getattr;
+allow backup_t { device_t device_type }:blk_file getattr;
 allow backup_t var_t:file create_file_perms;
 
 allow backup_t proc_t:dir r_dir_perms;
diff -ru /usr/src/se/policy/domains/program/unused/bootloader.te ./domains/program/unused/bootloader.te
--- /usr/src/se/policy/domains/program/unused/bootloader.te	2004-06-30 13:03:13.000000000 +1000
+++ ./domains/program/unused/bootloader.te	2004-07-05 00:10:20.000000000 +1000
@@ -28,7 +28,7 @@
 domain_auto_trans(sysadm_t, bootloader_exec_t, bootloader_t)
 allow bootloader_t { initrc_t privfd }:fd use;
 
-tmp_domain(bootloader)
+tmp_domain(bootloader, `, device_type')
 allow bootloader_t bootloader_tmp_t:devfile_class_set create_file_perms;
 
 read_locale(bootloader_t)
@@ -78,7 +78,8 @@
 dontaudit bootloader_t { staff_home_dir_t sysadm_home_dir_t }:dir search;
 
 allow bootloader_t boot_t:dir { create rw_dir_perms };
-allow bootloader_t boot_t:{ file lnk_file } create_file_perms;
+allow bootloader_t boot_t:file create_file_perms;
+allow bootloader_t boot_t:lnk_file create_lnk_perms;
 
 allow bootloader_t load_policy_exec_t:file { getattr read };
 
@@ -91,7 +92,8 @@
 
 # new file system defaults to file_t, granting file_t access is still bad.
 allow bootloader_t file_t:dir create_dir_perms;
-allow bootloader_t file_t:{ file lnk_file blk_file chr_file } create_file_perms;
+allow bootloader_t file_t:{ file blk_file chr_file } create_file_perms;
+allow bootloader_t file_t:lnk_file create_lnk_perms;
 allow bootloader_t self:unix_stream_socket create_socket_perms;
 allow bootloader_t boot_runtime_t:file { read getattr unlink };
 
@@ -102,7 +104,8 @@
 
 allow bootloader_t self:capability { fsetid sys_rawio sys_admin mknod chown };
 # allow bootloader to get attributes of any device node
-allow bootloader_t file_type:dir_file_class_set getattr;
+allow bootloader_t { device_type ttyfile }:chr_file getattr;
+allow bootloader_t device_type:blk_file getattr;
 dontaudit bootloader_t devpts_t:dir create_dir_perms;
 
 allow bootloader_t self:process { fork signal_perms };
@@ -144,5 +147,5 @@
 allow bootloader_t urandom_device_t:chr_file read;
 allow bootloader_t { usr_t var_t }:file { getattr read };
 r_dir_file(bootloader_t, src_t)
-dontaudit bootloader_t selinux_config_t:dir { search };
-dontaudit bootloader_t sysctl_t:dir { search };
+dontaudit bootloader_t selinux_config_t:dir search;
+dontaudit bootloader_t sysctl_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/cardmgr.te ./domains/program/unused/cardmgr.te
--- /usr/src/se/policy/domains/program/unused/cardmgr.te	2004-07-08 13:09:33.000000000 +1000
+++ ./domains/program/unused/cardmgr.te	2004-07-05 00:35:05.000000000 +1000
@@ -35,27 +35,29 @@
 allow cardmgr_t self:unix_stream_socket create_socket_perms;
 allow cardmgr_t self:fifo_file rw_file_perms;
 
-file_type_auto_trans(cardmgr_t, { var_run_t device_t }, cardmgr_var_run_t, { blk_file chr_file file })
+file_type_auto_trans(cardmgr_t, { var_run_t device_t }, cardmgr_dev_t, { blk_file chr_file })
 
 # Create stab file and device nodes.
-type cardmgr_var_lib_t, file_type, sysadmfile;
-file_type_auto_trans(cardmgr_t, var_lib_t, cardmgr_var_lib_t, { blk_file chr_file file })
+file_type_auto_trans(cardmgr_t, var_lib_t, cardmgr_dev_t, { blk_file chr_file })
+var_lib_domain(cardmgr)
 
 # for /var/lib/misc/pcmcia-scheme
 # would be better to have it in a different type if I knew how it was created..
 allow cardmgr_t var_lib_t:file { getattr read };
 
 # Create device files in /tmp.
-type cardmgr_dev_t, file_type, sysadmfile, tmpfile;
-allow cardmgr_t tmp_t:dir { search };
+type cardmgr_dev_t, file_type, sysadmfile, tmpfile, device_type;
 type_transition cardmgr_t tmp_t:chr_file cardmgr_dev_t;
 allow cardmgr_t cardmgr_dev_t:chr_file create_file_perms;
+ifdef(`tmpreaper.te', `
+allow tmpreaper_t cardmgr_dev_t:chr_file { getattr unlink };
+')
 
 # Create symbolic links in /dev.
 type cardmgr_lnk_t, file_type, sysadmfile;
 type_transition cardmgr_t device_t:lnk_file cardmgr_lnk_t;
 allow cardmgr_t device_t:dir rw_dir_perms;
-allow cardmgr_t cardmgr_lnk_t:lnk_file create_file_perms;
+allow cardmgr_t cardmgr_lnk_t:lnk_file create_lnk_perms;
 
 # Run a shell, normal commands, /etc/pcmcia scripts. 
 can_exec_any(cardmgr_t)
@@ -83,6 +85,6 @@
 ')
 
 ifdef(`hide_broken_symptoms', `', `
-dontaudit insmod_t cardmgr_var_run_t:chr_file { read write };
-dontaudit ifconfig_t cardmgr_var_run_t:chr_file { read write };
+dontaudit insmod_t cardmgr_dev_t:chr_file { read write };
+dontaudit ifconfig_t cardmgr_dev_t:chr_file { read write };
 ')
diff -ru /usr/src/se/policy/domains/program/unused/cpucontrol.te ./domains/program/unused/cpucontrol.te
--- /usr/src/se/policy/domains/program/unused/cpucontrol.te	2003-10-02 23:40:03.000000000 +1000
+++ ./domains/program/unused/cpucontrol.te	2004-07-11 17:25:01.000000000 +1000
@@ -9,6 +9,7 @@
 
 # Access cpu devices.
 allow cpucontrol_t cpu_device_t:chr_file rw_file_perms;
+allow initrc_t cpu_device_t:chr_file getattr;
 
 allow cpucontrol_t self:capability sys_rawio;
 
diff -ru /usr/src/se/policy/domains/program/unused/dpkg.te ./domains/program/unused/dpkg.te
--- /usr/src/se/policy/domains/program/unused/dpkg.te	2004-06-17 15:10:39.000000000 +1000
+++ ./domains/program/unused/dpkg.te	2004-07-11 19:27:39.000000000 +1000
@@ -155,6 +155,9 @@
 domain_auto_trans(dpkg_t, groupadd_exec_t, groupadd_t)
 role system_r types { useradd_t groupadd_t };
 ')
+ifdef(`passwd.te', `
+domain_auto_trans(dpkg_t, chfn_exec_t, chfn_t)
+')
 ifdef(`ldconfig.te', `
 domain_auto_trans(dpkg_t, ldconfig_exec_t, ldconfig_t)
 ')
@@ -285,10 +288,11 @@
 
 # read/write/create any files in the system
 allow dpkg_t sysadmfile:dir create_dir_perms;
-allow dpkg_t sysadmfile:{ file lnk_file fifo_file sock_file } create_file_perms;
-allow dpkg_t file_type:{ chr_file blk_file } getattr;
+allow dpkg_t sysadmfile:{ file fifo_file sock_file } create_file_perms;
+allow dpkg_t sysadmfile:lnk_file create_lnk_perms;
+allow dpkg_t device_type:{ chr_file blk_file } getattr;
 ifdef(`devfsd.te', `', `
-allow dpkg_t file_type:{ chr_file blk_file } { create setattr rename };
+allow dpkg_t device_type:{ chr_file blk_file } { create setattr rename };
 ')
 dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
 allow dpkg_t proc_kmsg_t:file getattr;
@@ -308,7 +312,7 @@
 rw_dir_create_file(apt_t, lib_t)
 
 # for apt-listbugs
-allow apt_t usr_t:file { getattr read };
+allow apt_t usr_t:file { getattr read ioctl };
 allow apt_t usr_t:lnk_file read;
 
 # allow /var/cache/apt/archives to be owned by non-root
@@ -359,8 +363,7 @@
 
 r_dir_file(userdomain, debian_menu_t)
 dontaudit install_menu_t sysadm_home_dir_t:dir search;
-allow install_menu_t debian_menu_t:dir create_dir_perms;
-allow install_menu_t debian_menu_t:{ file lnk_file } create_file_perms;
+create_dir_file(install_menu_t, debian_menu_t)
 allow install_menu_t dpkg_lock_t:file { setattr rw_file_perms };
 allow install_menu_t self:process signal;
 allow install_menu_t proc_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-07-11 17:21:36.000000000 +1000
@@ -52,7 +52,7 @@
 # LVM(2) needs to create directores (/dev/mapper, /dev/<vg>)
 # and links from /dev/<vg> to /dev/mapper/<vg>-<lv>
 allow lvm_t device_t:dir create_dir_perms;
-allow lvm_t device_t:lnk_file create_file_perms;
+allow lvm_t device_t:lnk_file create_lnk_perms;
 
 # /lib/lvm-<version> holds the actual LVM binaries (and symlinks)
 allow lvm_t lvm_exec_t:dir search;
@@ -104,7 +104,7 @@
 dontaudit lvm_t initctl_t:fifo_file getattr;
 dontaudit lvm_t sbin_t:file getattr;
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
-allow initrc_t lvm_control_t:chr_file unlink;
+allow initrc_t lvm_control_t:chr_file { getattr unlink };
 allow initrc_t device_t:chr_file create;
 dontaudit lvm_t var_run_t:dir getattr;
 
diff -ru /usr/src/se/policy/domains/program/unused/mdadm.te ./domains/program/unused/mdadm.te
--- /usr/src/se/policy/domains/program/unused/mdadm.te	2004-06-18 10:47:56.000000000 +1000
+++ ./domains/program/unused/mdadm.te	2004-07-06 08:29:36.000000000 +1000
@@ -11,8 +11,6 @@
 allow mdadm_t sysctl_kernel_t:file r_file_perms;
 allow mdadm_t sysctl_kernel_t:dir r_dir_perms;
 r_dir_file(mdadm_t, sysfs_t) 
-# Allow writes to /proc/mdstat - TODO: specific type for that file
-allow mdadm_t proc_t:file rw_file_perms;
 
 # Configuration
 allow mdadm_t { etc_t etc_runtime_t }:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/mysqld.te ./domains/program/unused/mysqld.te
--- /usr/src/se/policy/domains/program/unused/mysqld.te	2004-04-03 21:37:22.000000000 +1000
+++ ./domains/program/unused/mysqld.te	2004-07-05 22:52:04.000000000 +1000
@@ -12,6 +12,9 @@
 #
 daemon_domain(mysqld)
 
+type mysqld_port_t, port_type;
+allow mysqld_t mysqld_port_t:tcp_socket name_bind;
+
 allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;
 
 etcdir_domain(mysqld)
@@ -65,3 +68,14 @@
 can_unix_connect(logrotate_t, mysqld_t)
 ')
 
+ifdef(`user_db_connect', `
+allow userdomain mysqld_var_run_t:dir search;
+allow userdomain mysqld_var_run_t:sock_file write;
+')
+
+ifdef(`rpm.te', `
+allow initrc_t mysqld_db_t:dir create_dir_perms;
+
+# because Fedora has the sock_file in the database directory
+file_type_auto_trans(mysqld_t, mysqld_db_t, mysqld_var_run_t, sock_file)
+')
diff -ru /usr/src/se/policy/file_contexts/program/bootloader.fc ./file_contexts/program/bootloader.fc
--- /usr/src/se/policy/file_contexts/program/bootloader.fc	2004-03-18 15:36:09.000000000 +1100
+++ ./file_contexts/program/bootloader.fc	2004-07-07 21:11:42.000000000 +1000
@@ -9,4 +9,4 @@
 /etc/mkinitrd/scripts/.* --	system_u:object_r:bootloader_exec_t
 /sbin/ybin.*		--	system_u:object_r:bootloader_exec_t
 /etc/yaboot\.conf.*	--	system_u:object_r:bootloader_etc_t
-/boot/grub/.*		--	system_u:object_r:boot_runtime_t
+/boot/grub/menu.lst	--	system_u:object_r:boot_runtime_t
diff -ru /usr/src/se/policy/file_contexts/program/courier.fc ./file_contexts/program/courier.fc
--- /usr/src/se/policy/file_contexts/program/courier.fc	2004-03-18 15:36:09.000000000 +1100
+++ ./file_contexts/program/courier.fc	2004-07-05 23:05:08.000000000 +1000
@@ -13,5 +13,5 @@
 /usr/sbin/courierlogger		--	system_u:object_r:courier_exec_t
 /usr/sbin/courierldapaliasd	--	system_u:object_r:courier_exec_t
 /usr/sbin/couriertcpd		--	system_u:object_r:courier_tcpd_exec_t
-/var/run/courier(.*)?			system_u:object_r:courier_var_run_t
+/var/run/courier(/.*)?			system_u:object_r:courier_var_run_t
 /etc/courier(/.*)?			system_u:object_r:courier_etc_t
diff -ru /usr/src/se/policy/file_contexts/program/cyrus.fc ./file_contexts/program/cyrus.fc
--- /usr/src/se/policy/file_contexts/program/cyrus.fc	2004-06-17 15:10:42.000000000 +1000
+++ ./file_contexts/program/cyrus.fc	2004-07-05 23:06:05.000000000 +1000
@@ -1,4 +1,4 @@
 # cyrus
 /var/lib/imap(/.*)?				system_u:object_r:cyrus_var_lib_t
-/usr/lib(64)?/cyrus-imapd/(.*)?		 	--	system_u:object_r:bin_t
+/usr/lib(64)?/cyrus-imapd/.*		 	--	system_u:object_r:bin_t
 /usr/lib(64)?/cyrus-imapd/cyrus-master 		--	system_u:object_r:cyrus_exec_t	
diff -ru /usr/src/se/policy/file_contexts/program/dovecot.fc ./file_contexts/program/dovecot.fc
--- /usr/src/se/policy/file_contexts/program/dovecot.fc	2004-04-06 03:48:16.000000000 +1000
+++ ./file_contexts/program/dovecot.fc	2004-07-05 22:45:46.000000000 +1000
@@ -4,3 +4,4 @@
 /usr/share/ssl/certs/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /usr/share/ssl/private/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
+/usr/lib/dovecot/.+	--		system_u:object_r:bin_t
diff -ru /usr/src/se/policy/file_contexts/program/dpkg.fc ./file_contexts/program/dpkg.fc
--- /usr/src/se/policy/file_contexts/program/dpkg.fc	2004-06-17 15:10:42.000000000 +1000
+++ ./file_contexts/program/dpkg.fc	2004-07-08 13:50:06.000000000 +1000
@@ -39,10 +39,12 @@
 /usr/share/dlint/digparse --	system_u:object_r:bin_t
 /usr/share/gimp/1.2/user_install -- system_u:object_r:bin_t
 /usr/share/openoffice.org-debian-files/install-hook -- system_u:object_r:bin_t
-/var/lib/defoma(/.*)?		system_u:object_r:readable_t
+/var/lib/defoma(/.*)?		system_u:object_r:fonts_t
 /usr/lib(64)?/doc-rfc/register-doc-rfc-docs -- system_u:object_r:bin_t
 /usr/share/intltool-debian/.* -- system_u:object_r:bin_t
 /usr/share/po-debconf/intltool-merge -- system_u:object_r:bin_t
 /usr/share/linuxdoc-tools/sgmlswhich -- system_u:object_r:bin_t
 /usr/share/shorewall/.*	--	system_u:object_r:bin_t
 /usr/share/reportbug/.*	--	system_u:object_r:bin_t
+/etc/network/ifstate.*	--	system_u:object_r:etc_runtime_t
+/usr/lib/gconf2/gconfd-2 --	system_u:object_r:bin_t
diff -ru /usr/src/se/policy/file_contexts/program/lrrd.fc ./file_contexts/program/lrrd.fc
--- /usr/src/se/policy/file_contexts/program/lrrd.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/lrrd.fc	2004-07-05 23:07:55.000000000 +1000
@@ -6,5 +6,5 @@
 /var/run/lrrd(/.*)?			system_u:object_r:lrrd_var_run_t
 /var/log/lrrd.*			--	system_u:object_r:lrrd_log_t
 /var/lib/lrrd(/.*)?			system_u:object_r:lrrd_var_lib_t
-/var/www/lrrd(.*)?			system_u:object_r:lrrd_var_lib_t
+/var/www/lrrd(/.*)?			system_u:object_r:lrrd_var_lib_t
 /etc/lrrd(/.*)?				system_u:object_r:lrrd_etc_t
diff -ru /usr/src/se/policy/file_contexts/program/lvm.fc ./file_contexts/program/lvm.fc
--- /usr/src/se/policy/file_contexts/program/lvm.fc	2004-05-12 05:10:48.000000000 +1000
+++ ./file_contexts/program/lvm.fc	2004-07-07 22:20:31.000000000 +1000
@@ -14,9 +14,8 @@
 /dev/lvm		-c	system_u:object_r:fixed_disk_device_t
 /dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t
 /dev/mapper/control	-c	system_u:object_r:lvm_control_t
-/lib(64)?/lvm-10(/.*)		system_u:object_r:lvm_exec_t
-/lib(64)?/lvm-200(/.*)		system_u:object_r:lvm_exec_t
-/lib(64)?/lvm-default		system_u:object_r:bin_t
+/lib/lvm-10(/.*)	--	system_u:object_r:lvm_exec_t
+/lib/lvm-200(/.*)	--	system_u:object_r:lvm_exec_t
 /sbin/e2fsadm		--	system_u:object_r:lvm_exec_t
 /sbin/lvchange		--	system_u:object_r:lvm_exec_t
 /sbin/lvcreate		--	system_u:object_r:lvm_exec_t
@@ -55,10 +54,12 @@
 /sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
+/usr/bin/cryptsetup	--	system_u:object_r:lvm_exec_t
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
 /sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t
 /sbin/lvm.static   --      system_u:object_r:lvm_exec_t
+/usr/sbin/lvm		--	system_u:object_r:lvm_exec_t
 /sbin/lvresize     --      system_u:object_r:lvm_exec_t
 /sbin/lvs          --      system_u:object_r:lvm_exec_t
 /sbin/pvremove     --      system_u:object_r:lvm_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/mozilla.fc ./file_contexts/program/mozilla.fc
--- /usr/src/se/policy/file_contexts/program/mozilla.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/mozilla.fc	2004-07-05 23:11:37.000000000 +1000
@@ -2,6 +2,8 @@
 HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
 HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
 HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
 HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/mysqld.fc ./file_contexts/program/mysqld.fc
--- /usr/src/se/policy/file_contexts/program/mysqld.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/mysqld.fc	2004-07-05 23:12:05.000000000 +1000
@@ -1,7 +1,9 @@
 # mysql database server
 /usr/sbin/mysqld	--	system_u:object_r:mysqld_exec_t
+/usr/libexec/mysqld	--	system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
 /var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
+/var/lib/mysql/mysql.sock -s	system_u:object_r:mysqld_var_run_t
 /etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
 /etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t
diff -ru /usr/src/se/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /usr/src/se/policy/file_contexts/program/postfix.fc	2004-06-18 10:47:58.000000000 +1000
+++ ./file_contexts/program/postfix.fc	2004-07-05 23:12:53.000000000 +1000
@@ -30,6 +30,7 @@
 /var/spool/postfix/active(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/hold(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/incoming(/.*)? system_u:object_r:postfix_spool_t
+/var/spool/postfix/corrupt(/.*)? system_u:object_r:postfix_spool_t
 /var/spool/postfix/maildrop(/.*)? system_u:object_r:postfix_spool_maildrop_t
 /var/spool/postfix/pid	-d	system_u:object_r:var_run_t
 /var/spool/postfix/pid/.*	system_u:object_r:postfix_var_run_t
diff -ru /usr/src/se/policy/file_contexts/program/pppd.fc ./file_contexts/program/pppd.fc
--- /usr/src/se/policy/file_contexts/program/pppd.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/pppd.fc	2004-07-05 23:13:17.000000000 +1000
@@ -10,6 +10,7 @@
 /etc/ppp/.*secrets	--	system_u:object_r:pppd_secret_t
 /var/run/(i)?ppp.*pid	--	system_u:object_r:pppd_var_run_t
 /var/log/ppp-connect-errors.* -- system_u:object_r:pppd_log_t
+/var/log/ppp(/.*)?	--	system_u:object_r:pppd_log_t
 /etc/ppp/ip-down.*	--	system_u:object_r:bin_t
 /etc/ppp/ip-up.*	--	system_u:object_r:bin_t
 /etc/ppp/ipv6-up	--	system_u:object_r:bin_t
diff -ru /usr/src/se/policy/file_contexts/program/udev.fc ./file_contexts/program/udev.fc
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-05-12 05:10:51.000000000 +1000
+++ ./file_contexts/program/udev.fc	2004-07-05 23:14:35.000000000 +1000
@@ -4,3 +4,4 @@
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /etc/dev.d(/.*)? 	system_u:object_r:udev_helper_exec_t
 /etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/dev/udev.tbl	--	system_u:object_r:udev_tbl_t
diff -ru /usr/src/se/policy/file_contexts/types.fc ./file_contexts/types.fc
--- /usr/src/se/policy/file_contexts/types.fc	2004-06-30 13:03:16.000000000 +1000
+++ ./file_contexts/types.fc	2004-07-08 21:20:32.000000000 +1000
@@ -227,6 +227,8 @@
 #
 /etc(/.*)?			system_u:object_r:etc_t
 /etc/\.pwd\.lock	--	system_u:object_r:shadow_t
+/etc/passwd\.lock	--	system_u:object_r:shadow_t
+/etc/group\.lock	--	system_u:object_r:shadow_t
 /etc/shadow.*		--	system_u:object_r:shadow_t
 /etc/gshadow.*		--	system_u:object_r:shadow_t
 /etc/blkid.tab		--	system_u:object_r:etc_runtime_t
@@ -267,7 +269,6 @@
 /lib(64)?/tls/ld[^/]*\.so(\.[^/]*)*	--	system_u:object_r:ld_so_t
 /lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/[^/]*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/lib(64)?/devfsd/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/security/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/tls/i686/cmov/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
 

--Boundary-00=_bxp8AB1zMG3Tt5x--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
