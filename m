Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13Cp853029517
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 07:51:09 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13Cp7f1028060
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 12:51:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6D2CD61AFF
	for <selinux@tycho.nsa.gov>; Thu,  3 Feb 2005 23:51:03 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30933-10 for <selinux@tycho.nsa.gov>;
	Thu, 3 Feb 2005 23:51:02 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EDBE061AD9
	for <selinux@tycho.nsa.gov>; Thu,  3 Feb 2005 23:51:01 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 98B812E
	for <selinux@tycho.nsa.gov>; Thu,  3 Feb 2005 23:50:41 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: some policy patches
Date: Thu, 3 Feb 2005 23:50:39 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g4hAC5TJruTCg87"
Message-Id: <200502032350.40924.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_g4hAC5TJruTCg87
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nothing really exciting in this patch.  Just some minor fixes and sorting out 
some of the distro-specific stuff.

-- 
US IT executives rate Red Hat #1 for value
http://www.redhat.com/promo/vendor/index.html

--Boundary-00=_g4hAC5TJruTCg87
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/crond.te ./domains/program/crond.te
--- /usr/src/se/policy/domains/program/crond.te	2005-01-14 22:26:51.000000000 +1100
+++ ./domains/program/crond.te	2005-02-02 07:29:28.000000000 +1100
@@ -26,6 +26,7 @@
 
 crond_domain(system)
 
+allow system_crond_t proc_mdstat_t:file { getattr read };
 allow system_crond_t proc_t:lnk_file read;
 allow system_crond_t proc_t:filesystem getattr;
 allow system_crond_t usbdevfs_t:filesystem getattr;
@@ -160,7 +161,6 @@
 # /sbin/runlevel needs lock access however
 dontaudit system_crond_t initrc_var_run_t:file write;
 allow system_crond_t initrc_var_run_t:file { getattr read lock };
-allow initrc_t system_cron_spool_t:file { getattr read };
 
 # Access other spool directories like
 # /var/spool/anacron and /var/spool/slrnpull.
diff -ru /usr/src/se/policy/domains/program/getty.te ./domains/program/getty.te
--- /usr/src/se/policy/domains/program/getty.te	2005-01-30 06:23:21.000000000 +1100
+++ ./domains/program/getty.te	2005-01-30 13:09:22.000000000 +1100
@@ -58,4 +58,3 @@
 
 rw_dir_create_file(getty_t, var_lock_t)
 r_dir_file(getty_t, sysfs_t)
-allow getty_t initrc_devpts_t:chr_file { read write };
diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2005-01-30 06:23:22.000000000 +1100
+++ ./domains/program/initrc.te	2005-02-03 22:09:02.000000000 +1100
@@ -49,7 +56,7 @@
 allow initrc_t usbfs_t:file getattr;
 
 # allow initrc to fork and renice itself
-allow initrc_t self:process { fork sigchld setsched setpgid setrlimit getsched };
+allow initrc_t self:process { fork sigchld getpgid setsched setpgid setrlimit getsched };
 
 # Can create ptys for open_init_pty
 can_create_pty(initrc)
@@ -61,11 +68,13 @@
 allow initrc_t var_run_t:dir { create rmdir };
 
 ifdef(`distro_debian', `
-allow initrc_t etc_t:dir setattr;
+allow initrc_t { etc_t device_t }:dir setattr;
 
 # for storing state under /dev/shm
+allow initrc_t tmpfs_t:dir setattr;
 file_type_auto_trans(initrc_t, tmpfs_t, initrc_var_run_t, dir)
-allow initrc_var_run_t tmpfs_t:filesystem associate;
+file_type_auto_trans(initrc_t, tmpfs_t, fixed_disk_device_t, blk_file)
+allow { initrc_var_run_t fixed_disk_device_t } tmpfs_t:filesystem associate;
 ')
 
 allow initrc_t framebuf_device_t:chr_file r_file_perms;
diff -ru /usr/src/se/policy/domains/program/ldconfig.te ./domains/program/ldconfig.te
--- /usr/src/se/policy/domains/program/ldconfig.te	2005-01-30 06:23:22.000000000 +1100
+++ ./domains/program/ldconfig.te	2004-12-23 19:24:00.000000000 +1100
@@ -26,6 +26,7 @@
 allow ldconfig_t lib_t:lnk_file create_lnk_perms;
 
 allow ldconfig_t userdomain:fd use;
+# unlink for when /etc/ld.so.cache is mislabeled
 allow ldconfig_t etc_t:file { getattr read unlink };
 allow ldconfig_t etc_t:lnk_file read;
 
@@ -37,12 +38,14 @@
 dontaudit ldconfig_t httpd_modules_t:dir search;
 ')
 
+ifdef(`distro_suse', `
+# because of libraries in /var/lib/samba/bin
 allow ldconfig_t { var_t var_lib_t }:dir search;
+')
+
 allow ldconfig_t proc_t:file read;
+ifdef(`hide_broken_symptoms', `
 ifdef(`unconfined.te',`
 dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
-');
-ifdef(`targeted_policy', `
-allow ldconfig_t lib_t:file r_file_perms;
-unconfined_domain(ldconfig_t) 
 ')
+')dnl end hide_broken_symptoms
diff -ru /usr/src/se/policy/domains/program/login.te ./domains/program/login.te
--- /usr/src/se/policy/domains/program/login.te	2005-02-03 17:58:25.000000000 +1100
+++ ./domains/program/login.te	2005-02-03 22:15:23.000000000 +1100
@@ -73,7 +73,9 @@
 # Set exec context.
 can_setexec($1_login_t)
 
+ifdef(`automount.te', `
 allow $1_login_t autofs_t:dir { search read getattr };
+')
 allow $1_login_t mnt_t:dir r_dir_perms;
 
 if (use_nfs_home_dirs) {
@@ -188,10 +185,6 @@
 # Allow setting of attributes on power management devices.
 allow local_login_t power_device_t:chr_file { getattr setattr };
 
-ifdef(`hide_broken_symptoms', `
-dontaudit local_login_t init_t:fd use;
-')
-
 #################################
 #
 # Rules for the remote_login_t domain.
diff -ru /usr/src/se/policy/domains/program/logrotate.te ./domains/program/logrotate.te
--- /usr/src/se/policy/domains/program/logrotate.te	2005-01-14 22:26:53.000000000 +1100
+++ ./domains/program/logrotate.te	2005-02-03 15:57:46.000000000 +1100
@@ -21,12 +21,14 @@
 type logrotate_exec_t, file_type, sysadmfile, exec_type;
 
 system_crond_entry(logrotate_exec_t, logrotate_t)
+allow logrotate_t cron_spool_t:dir search;
 allow crond_t logrotate_var_lib_t:dir search;
 domain_auto_trans(sysadm_t, logrotate_exec_t, logrotate_t)
 allow logrotate_t self:unix_stream_socket create_socket_perms;
 allow logrotate_t devtty_t:chr_file rw_file_perms;
 
 ifdef(`distro_debian', `
+allow logrotate_t logrotate_tmp_t:file { relabelfrom relabelto };
 # for savelog
 can_exec(logrotate_t, logrotate_exec_t)
 ')
@@ -49,7 +51,6 @@
 # Create temporary files.
 tmp_domain(logrotate)
 can_exec(logrotate_t, logrotate_tmp_t)
-allow logrotate_t logrotate_tmp_t:file { relabelfrom relabelto };

 # Run helper programs.
 allow logrotate_t { bin_t sbin_t }:dir r_dir_perms;
diff -ru /usr/src/se/policy/domains/program/ssh.te ./domains/program/ssh.te
--- /usr/src/se/policy/domains/program/ssh.te	2005-02-03 17:58:25.000000000 +1100
+++ ./domains/program/ssh.te	2005-02-03 22:21:53.000000000 +1100
@@ -73,7 +73,9 @@
 allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
 if (use_nfs_home_dirs) {
+ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
+')
 allow $1_t nfs_t:dir { search getattr };
 allow $1_t nfs_t:file { getattr read };
 }
@@ -226,4 +228,3 @@
 allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
 allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
 allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
-dontaudit sshd_t sysadm_tty_device_t:chr_file { read write };
diff -ru /usr/src/se/policy/domains/program/sulogin.te ./domains/program/sulogin.te
--- /usr/src/se/policy/domains/program/sulogin.te	2004-12-13 09:55:22.000000000 +1100
+++ ./domains/program/sulogin.te	2005-02-03 16:01:51.000000000 +1100
@@ -16,9 +16,18 @@
 general_domain_access(sulogin_t)
 
 domain_auto_trans({ initrc_t init_t }, sulogin_exec_t, sulogin_t)
+allow sulogin_t initrc_t:process getpgid;
 uses_shlib(sulogin_t)
+
+# suse and debian do not use pam with sulogin...
 ifdef(`distro_suse', `
-# suse doesnt use pam with sulogin...
+define(`sulogin_no_pam', `')
+')
+ifdef(`distro_debian', `
+define(`sulogin_no_pam', `')
+')
+
+ifdef(`sulogin_no_pam', `
 domain_auto_trans(sulogin_t, shell_exec_t, sysadm_t)
 allow sulogin_t init_t:process getpgid;
 allow sulogin_t self:capability sys_tty_config;
diff -ru /usr/src/se/policy/domains/program/tmpreaper.te ./domains/program/tmpreaper.te
--- /usr/src/se/policy/domains/program/tmpreaper.te	2005-02-03 17:58:25.000000000 +1100
+++ ./domains/program/tmpreaper.te	2004-11-22 03:14:43.000000000 +1100
@@ -39,4 +37,4 @@
 allow tmpreaper_t catman_t:dir setattr;
 ')
 read_locale(tmpreaper_t)
-dontaudit tmpreaper_t init_t:fd use;
+
diff -ru /usr/src/se/policy/domains/program/unused/amanda.te ./domains/program/unused/amanda.te
--- /usr/src/se/policy/domains/program/unused/amanda.te	2005-01-14 22:26:57.000000000 +1100
+++ ./domains/program/unused/amanda.te	2004-12-03 19:56:13.000000000 +1100
@@ -241,6 +241,8 @@
 allow amanda_recover_t self:process { fork sigkill sigstop sigchld signal };
 allow amanda_recover_t self:capability { fowner fsetid setgid setuid chown dac_override net_bind_service };
 allow amanda_recover_t shell_exec_t:file { execute execute_no_trans getattr read };
+allow amanda_recover_t privfd:fd use;
+
 
 # amrecover network and process communication
 #############################################
diff -ru /usr/src/se/policy/domains/program/unused/asterisk.te ./domains/program/unused/asterisk.te
--- /usr/src/se/policy/domains/program/unused/asterisk.te	2004-12-03 19:49:22.000000000 +1100
+++ ./domains/program/unused/asterisk.te	2005-01-19 04:25:31.000000000 +1100
@@ -48,8 +48,8 @@
 allow asterisk_t self:sem create_sem_perms;
 allow asterisk_t self:shm create_shm_perms;
 
-# for /var/run/asterisk
-allow asterisk_t self:capability dac_override;
+# dac_override for /var/run/asterisk
+allow asterisk_t self:capability { dac_override setgid setuid sys_nice };
 
 # for shutdown
 dontaudit asterisk_t self:capability sys_tty_config;
diff -ru /usr/src/se/policy/domains/program/unused/backup.te ./domains/program/unused/backup.te
--- /usr/src/se/policy/domains/program/unused/backup.te	2004-12-03 19:49:23.000000000 +1100
+++ ./domains/program/unused/backup.te	2005-01-03 01:15:13.000000000 +1100
@@ -26,7 +26,7 @@
 # for SSP
 allow backup_t urandom_device_t:chr_file read;
 
-can_network_server(backup_t)
+can_network_client(backup_t)
 can_ypbind(backup_t)
 uses_shlib(backup_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/bootloader.te ./domains/program/unused/bootloader.te
--- /usr/src/se/policy/domains/program/unused/bootloader.te	2005-01-14 22:26:58.000000000 +1100
+++ ./domains/program/unused/bootloader.te	2005-02-03 15:56:03.000000000 +1100
@@ -10,7 +10,7 @@
 #
 # bootloader_exec_t is the type of the bootloader executable.
 #
-type bootloader_t, domain, privlog, privmem, fs_domain, nscd_client_domain ifdef(`direct_sysadm_daemon', `, priv_system_role');
+type bootloader_t, domain, privlog, privmem, fs_domain, nscd_client_domain ifdef(`direct_sysadm_daemon', `, priv_system_role') ifdef(`distro_debian', `, privowner, admin');
 type bootloader_exec_t, file_type, sysadmfile, exec_type;
 etc_domain(bootloader)
 typealias bootloader_etc_t alias etc_bootloader_t;
@@ -28,8 +28,7 @@
 domain_auto_trans(sysadm_t, bootloader_exec_t, bootloader_t)
 allow bootloader_t { initrc_t privfd }:fd use;
 
-tmp_domain(bootloader, `, device_type')
-allow bootloader_t bootloader_tmp_t:{ devfile_class_set lnk_file } create_file_perms;
+tmp_domain(bootloader, `, device_type', { dir file lnk_file chr_file blk_file })
 
 read_locale(bootloader_t)
 
@@ -39,12 +38,33 @@
 # for /vmlinuz sym link
 allow bootloader_t root_t:lnk_file read;
 
+# lilo would need read access to get BIOS data
+allow bootloader_t proc_kcore_t:file getattr;
+
 allow bootloader_t { etc_t device_t }:dir r_dir_perms;
 allow bootloader_t etc_t:file r_file_perms;
 allow bootloader_t etc_t:lnk_file read;
+allow bootloader_t initctl_t:fifo_file getattr;
 uses_shlib(bootloader_t)
 
+ifdef(`distro_debian', `
+allow bootloader_t bootloader_tmp_t:{ dir file } { relabelfrom relabelto };
+allow bootloader_t modules_object_t:file { relabelfrom relabelto unlink };
+allow bootloader_t boot_t:file relabelfrom;
+allow bootloader_t { usr_t lib_t fsadm_exec_t }:file relabelto;
+allow bootloader_t { usr_t lib_t fsadm_exec_t }:file create_file_perms;
+allow bootloader_t usr_t:lnk_file read;
+allow bootloader_t tmpfs_t:dir r_dir_perms;
+allow bootloader_t initrc_var_run_t:dir r_dir_perms;
+allow bootloader_t var_lib_t:dir search;
+allow bootloader_t dpkg_var_lib_t:dir r_dir_perms;
+allow bootloader_t dpkg_var_lib_t:file { getattr read };
+# for /usr/share/initrd-tools/scripts
+can_exec(bootloader_t, usr_t)
+')
+
 allow bootloader_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
+dontaudit bootloader_t device_t:{ chr_file blk_file } rw_file_perms;
 allow bootloader_t device_t:lnk_file { getattr read };
 
 # LVM2 / Device Mapper's /dev/mapper/control
@@ -52,6 +72,7 @@
 ifdef(`lvm.te', `
 allow bootloader_t lvm_control_t:chr_file rw_file_perms;
 domain_auto_trans(bootloader_t, lvm_exec_t, lvm_t)
+allow lvm_t bootloader_tmp_t:file rw_file_perms;
 r_dir_file(bootloader_t, lvm_etc_t)
 ')
 
diff -ru /usr/src/se/policy/domains/program/unused/ciped.te ./domains/program/unused/ciped.te
--- /usr/src/se/policy/domains/program/unused/ciped.te	2004-12-03 19:49:23.000000000 +1100
+++ ./domains/program/unused/ciped.te	2005-01-03 01:27:19.000000000 +1100
@@ -7,7 +7,7 @@
 
 type cipe_port_t, port_type;
 
-can_network_server(ciped_t)
+can_network_udp(ciped_t)
 can_ypbind(ciped_t)
 allow ciped_t cipe_port_t:udp_socket name_bind;
 
diff -ru /usr/src/se/policy/domains/program/unused/cups.te ./domains/program/unused/cups.te
--- /usr/src/se/policy/domains/program/unused/cups.te	2005-01-30 06:23:23.000000000 +1100
+++ ./domains/program/unused/cups.te	2005-01-02 23:09:50.000000000 +1100
@@ -33,8 +33,10 @@
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
 
+ifdef(`usbmodules.te', `
 r_dir_file(cupsd_t, usbdevfs_t)
 r_dir_file(cupsd_t, usbfs_t)
+')
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, cupsd_exec_t, cupsd_t)
diff -ru /usr/src/se/policy/domains/program/unused/dpkg.te ./domains/program/unused/dpkg.te
--- /usr/src/se/policy/domains/program/unused/dpkg.te	2004-12-03 19:49:23.000000000 +1100
+++ ./domains/program/unused/dpkg.te	2005-02-03 15:56:50.000000000 +1100
@@ -179,7 +179,7 @@
 typealias apt_etc_t alias etc_apt_t;
 type apt_rw_etc_t, file_type, sysadmfile;
 typealias apt_rw_etc_t alias etc_apt_rw_t;
-tmp_domain(apt)
+tmp_domain(apt, `', `{ dir file lnk_file }')
 can_exec(apt_t, apt_tmp_t)
 
 rw_dir_create_file(apt_t, apt_rw_etc_t)
diff -ru /usr/src/se/policy/domains/program/unused/ftpd.te ./domains/program/unused/ftpd.te
--- /usr/src/se/policy/domains/program/unused/ftpd.te	2005-02-03 17:58:25.000000000 +1100
+++ ./domains/program/unused/ftpd.te	2004-12-01 14:35:19.000000000 +1100
@@ -34,7 +34,10 @@
 allow system_crond_t xferlog_t:file r_file_perms;
 can_exec(ftpd_t, { sbin_t shell_exec_t })
 allow ftpd_t usr_t:file { getattr read };
-')
+ifdef(`logrotate.te', `
+can_exec(ftpd_t, logrotate_exec_t)
+')dnl end if logrotate.te
+')dnl end if crond.te
 
 allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
 allow ftpd_t port_t:tcp_socket name_bind;
@@ -87,7 +90,9 @@
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
 dontaudit ftpd_t selinux_config_t:dir search;
+ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir search;
+')
 allow ftpd_t self:file { getattr read };
 tmp_domain(ftpd)
 
diff -ru /usr/src/se/policy/domains/program/unused/hotplug.te ./domains/program/unused/hotplug.te
--- /usr/src/se/policy/domains/program/unused/hotplug.te	2005-01-30 06:23:23.000000000 +1100
+++ ./domains/program/unused/hotplug.te	2005-01-03 01:36:14.000000000 +1100
@@ -163,4 +163,4 @@
 unconfined_domain(hotplug_t) 
 ')
 
- allow kernel_t hotplug_etc_t:dir search;
+allow kernel_t hotplug_etc_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/inetd.te ./domains/program/unused/inetd.te
--- /usr/src/se/policy/domains/program/unused/inetd.te	2005-01-30 06:23:23.000000000 +1100
+++ ./domains/program/unused/inetd.te	2005-02-02 00:27:43.000000000 +1100
@@ -55,6 +58,8 @@
 
 
 inetd_child_domain(inetd_child)
+allow inetd_child_t proc_net_t:dir search;
+allow inetd_child_t proc_net_t:file { getattr read };
 
 ifdef(`unconfined.te', `
 domain_auto_trans(inetd_t, unconfined_exec_t, unconfined_t)
diff -ru /usr/src/se/policy/domains/program/unused/iptables.te ./domains/program/unused/iptables.te
--- /usr/src/se/policy/domains/program/unused/iptables.te	2005-01-14 22:26:59.000000000 +1100
+++ ./domains/program/unused/iptables.te	2005-01-03 01:11:29.000000000 +1100
@@ -36,7 +36,7 @@
 
 # for iptables -L
 allow iptables_t self:unix_stream_socket create_socket_perms;
-can_network_server(iptables_t)
+can_resolve(iptables_t)
 can_ypbind(iptables_t)
 
 allow iptables_t iptables_exec_t:file execute_no_trans;
diff -ru /usr/src/se/policy/domains/program/unused/lpd.te ./domains/program/unused/lpd.te
--- /usr/src/se/policy/domains/program/unused/lpd.te	2005-01-14 22:27:00.000000000 +1100
+++ ./domains/program/unused/lpd.te	2005-02-03 22:35:34.000000000 +1100
@@ -36,7 +36,7 @@
 type checkpc_t, domain, privlog;
 role system_r types checkpc_t;
 uses_shlib(checkpc_t)
-can_network_server(checkpc_t)
+can_network_client(checkpc_t)
 can_ypbind(checkpc_t)
 log_domain(checkpc)
 type checkpc_exec_t, file_type, sysadmfile, exec_type;
diff -ru /usr/src/se/policy/domains/program/unused/mdadm.te ./domains/program/unused/mdadm.te
--- /usr/src/se/policy/domains/program/unused/mdadm.te	2004-11-13 03:56:02.000000000 +1100
+++ ./domains/program/unused/mdadm.te	2005-02-03 22:36:28.000000000 +1100
@@ -27,6 +27,7 @@
 
 # RAID block device access
 allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;
+allow mdadm_t device_t:lnk_file { getattr read };
 
 # Ignore attempts to read every device file
 dontaudit mdadm_t device_type:{ chr_file blk_file } getattr;
diff -ru /usr/src/se/policy/domains/program/unused/mrtg.te ./domains/program/unused/mrtg.te
--- /usr/src/se/policy/domains/program/unused/mrtg.te	2004-12-03 19:49:24.000000000 +1100
+++ ./domains/program/unused/mrtg.te	2005-01-31 22:36:33.000000000 +1100
@@ -31,7 +31,7 @@
 r_dir_file(mrtg_t, lib_t)
 
 # Use the network.
-can_network_server(mrtg_t)
+can_network_client(mrtg_t)
 can_ypbind(mrtg_t)
 
 allow mrtg_t self:fifo_file { getattr read write ioctl };
@@ -53,7 +53,8 @@
 r_dir_file(mrtg_t, snmpd_var_lib_t)
 ')
 
-allow mrtg_t proc_t:file { read getattr };
+allow mrtg_t proc_net_t:dir search;
+allow mrtg_t { proc_t proc_net_t }:file { read getattr };
 dontaudit mrtg_t proc_t:file ioctl;
 
 allow mrtg_t { var_lock_t var_lib_t }:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/named.te ./domains/program/unused/named.te
--- /usr/src/se/policy/domains/program/unused/named.te	2005-01-30 06:23:23.000000000 +1100
+++ ./domains/program/unused/named.te	2005-02-03 22:38:57.000000000 +1100
@@ -84,7 +84,7 @@
 allow named_t sysctl_kernel_t:dir r_dir_perms;
 allow named_t sysctl_kernel_t:file r_file_perms;
 
-# Read /proc/cpuinfo.
+# Read /proc/cpuinfo and /proc/net
 r_dir_file(named_t, proc_t)
 r_dir_file(named_t, proc_net_t)
 
@@ -109,6 +109,8 @@
 # for /etc/rndc.key
 ifdef(`distro_redhat', `
 allow { ndc_t initrc_t } named_conf_t:dir search;
+# Allow init script to cp localtime to named_conf_t
+allow initrc_t named_conf_t:file { setattr write };
 ')
 allow { ndc_t initrc_t } named_conf_t:file { getattr read };
 
@@ -153,5 +155,3 @@
 ')
 allow ndc_t self:netlink_route_socket r_netlink_socket_perms;
 dontaudit ndc_t sysadm_tty_device_t:chr_file { ioctl };
-# Allow init script to cp localtime to named_conf_t
-allow initrc_t named_conf_t:file { write };
diff -ru /usr/src/se/policy/domains/program/unused/nessusd.te ./domains/program/unused/nessusd.te
--- /usr/src/se/policy/domains/program/unused/nessusd.te	2004-12-03 19:49:24.000000000 +1100
+++ ./domains/program/unused/nessusd.te	2005-01-03 01:29:31.000000000 +1100
@@ -22,7 +22,7 @@
 #tmp_domain(nessusd)
 
 # Use the network.
-can_network_server(nessusd_t)
+can_network(nessusd_t)
 can_ypbind(nessusd_t)
 allow nessusd_t self:unix_stream_socket create_socket_perms;
 #allow nessusd_t self:unix_dgram_socket create_socket_perms;
diff -ru /usr/src/se/policy/domains/program/unused/nscd.te ./domains/program/unused/nscd.te
--- /usr/src/se/policy/domains/program/unused/nscd.te	2005-01-14 22:27:00.000000000 +1100
+++ ./domains/program/unused/nscd.te	2005-01-30 12:47:20.000000000 +1100
@@ -56,6 +56,7 @@
 
 dontaudit nscd_t sysadm_home_dir_t:dir search;
 
+ifdef(`winbind.te', `
 #
 # Handle winbind for samba, Might only be needed for targeted policy
 #
@@ -63,6 +64,7 @@
 can_unix_connect(nscd_t, winbind_t)
 allow nscd_t samba_var_t:dir search;
 allow nscd_t winbind_var_run_t:dir { getattr search };
+')
 
 r_dir_file(nscd_t, selinux_config_t)
 can_getsecurity(nscd_t)
@@ -70,4 +72,4 @@
 allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
-allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
+allow nscd_t urandom_device_t:chr_file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/nsd.te ./domains/program/unused/nsd.te
--- /usr/src/se/policy/domains/program/unused/nsd.te	2004-12-03 19:49:24.000000000 +1100
+++ ./domains/program/unused/nsd.te	2005-01-03 01:26:19.000000000 +1100
@@ -19,7 +19,7 @@
 type nsd_crond_t, domain, privlog;
 role system_r types nsd_crond_t;
 uses_shlib(nsd_crond_t)
-can_network_server(nsd_crond_t)
+can_network_client(nsd_crond_t)
 can_ypbind(nsd_crond_t)
 allow nsd_crond_t self:unix_dgram_socket create_socket_perms;
 allow nsd_crond_t self:process { fork signal_perms };

--Boundary-00=_g4hAC5TJruTCg87--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
