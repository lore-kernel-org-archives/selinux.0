From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: last policy patch for the evening
Date: Mon, 20 Jan 2003 01:34:19 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LQ0K+ampUlX9Os/"
Message-Id: <200301200134.19634.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_LQ0K+ampUlX9Os/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached the final patch that's needed to take a CVS copy of the SE Linux 
policy to the policy that I am distributing in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_LQ0K+ampUlX9Os/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ruwN /tmp/policy/domains/program/backup.te policy/domains/program/backup.te
--- /tmp/policy/domains/program/backup.te	2003-01-20 01:03:59.000000000 +0100
+++ policy/domains/program/backup.te	2003-01-18 12:10:15.000000000 +0100
@@ -28,14 +28,15 @@
 
 allow backup_t devtty_t:chr_file rw_file_perms;
 
-allow backup_t file_type:dir r_dir_perms;
+allow backup_t { file_type fs_type }:dir r_dir_perms;
 allow backup_t file_type:{ file lnk_file } r_file_perms;
 allow backup_t file_type:{ sock_file fifo_file chr_file blk_file } getattr;
 allow backup_t var_t:file create_file_perms;
 
 allow backup_t proc_t:dir r_dir_perms;
 allow backup_t proc_t:file r_file_perms;
-allow backup_t { sysctl_t sysctl_kernel_t }:dir search;
+allow backup_t proc_t:lnk_file { getattr read };
+allow backup_t { sysctl_t sysctl_kernel_t }:dir r_dir_perms;
 allow backup_t sysctl_kernel_t:file read;
 
 allow backup_t self:fifo_file rw_file_perms;
diff -ruwN /tmp/policy/domains/program/bootloader.te policy/domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2003-01-20 01:03:59.000000000 +0100
+++ policy/domains/program/bootloader.te	2003-01-18 13:11:14.000000000 +0100
@@ -49,6 +49,7 @@
 
 # for ldd
 allow bootloader_t { insmod_exec_t fsadm_exec_t }:file { rx_file_perms execute_no_trans };
+allow bootloader_t insmod_exec_t:lnk_file { getattr read };
 
 dontaudit bootloader_t sysadm_home_dir_t:dir search;
 
diff -ruwN /tmp/policy/domains/program/crack.te policy/domains/program/crack.te
--- /tmp/policy/domains/program/crack.te	2003-01-20 01:04:00.000000000 +0100
+++ policy/domains/program/crack.te	2003-01-18 13:13:32.000000000 +0100
@@ -36,4 +36,6 @@
 allow crack_t { etc_t etc_runtime_t }:file { getattr read };
 allow crack_t etc_t:dir r_dir_perms;
 
+allow crack_t fs_t:filesystem getattr;
+
 dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
diff -ruwN /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2003-01-20 01:04:00.000000000 +0100
+++ policy/domains/program/dpkg.te	2003-01-20 01:07:29.000000000 +0100
@@ -26,7 +26,7 @@
 can_exec(dpkg_t, init_exec_t)
 file_type_auto_trans(dpkg_t, tmp_t, tmp_dpkg_t)
 ifdef(`mta.te', `
-allow system_mail_t tmp_dpkg_t:file read;
+allow system_mail_t tmp_dpkg_t:file { getattr read };
 ')
 
 allow dpkg_t random_device_t:chr_file read;
@@ -71,6 +71,22 @@
 domain_auto_trans(dpkg_t, klogd_exec_t, klogd_t)
 domain_auto_trans(dpkg_t, syslogd_exec_t, syslogd_t)
 ')
+# mysqld is broken too
+ifdef(`mysqld.te', `
+domain_auto_trans(dpkg_t, mysqld_exec_t, mysqld_t)
+')
+ifdef(`postgresql.te', `
+# because postgresql postinst creates scripts in /tmp and then runs them
+# also the init scripts do more than they should
+allow { initrc_t postgresql_t } tmp_dpkg_t:file write;
+# for "touch" when it tries to create the log file
+# this works for upgrades, maybe we should allow create access for first install
+allow initrc_t postgresql_log_t:file { write setattr };
+# because scripts run "id"
+allow postgresql_t security_t:security sid_to_context;
+# for dumpall
+can_exec(postgresql_t, postgresql_db_t)
+')
 
 # for apt
 type apt_t, domain, admin, privmail;
@@ -232,7 +248,6 @@
 type install_menu_t, domain, admin;
 type install_menu_exec_t, file_type, sysadmfile, exec_type;
 type install_menu_var_run_t, file_type, sysadmfile, pidfile;
-type install_menu_tmp_t, file_type, sysadmfile;
 type debian_menu_t, file_type, sysadmfile;
 
 r_dir_file(userdomain, debian_menu_t)
@@ -249,7 +264,7 @@
 
 allow install_menu_t var_t:dir search;
 file_type_auto_trans(install_menu_t, var_run_t, install_menu_var_run_t)
-file_type_auto_trans(install_menu_t, tmp_t, install_menu_tmp_t)
+tmp_domain(install_menu)
 
 allow install_menu_t { var_lib_t var_spool_t etc_t }:dir rw_dir_perms;
 allow install_menu_t { var_lib_t var_spool_t etc_t }:file create_file_perms;
diff -ruwN /tmp/policy/domains/program/fsadm.te policy/domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2003-01-20 01:04:00.000000000 +0100
+++ policy/domains/program/fsadm.te	2003-01-18 13:28:45.000000000 +0100
@@ -23,6 +23,9 @@
 type fsadm_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(fsadm_t, tmp_t, fsadm_tmp_t)
 
+# remount file system to apply changes
+allow fsadm_t fs_t:filesystem remount;
+
 # Use capabilities.
 allow fsadm_t fsadm_t:capability { sys_admin sys_rawio };
 
diff -ruwN /tmp/policy/domains/program/hotplug.te policy/domains/program/hotplug.te
--- /tmp/policy/domains/program/hotplug.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/hotplug.te	2003-01-18 13:30:12.000000000 +0100
@@ -48,6 +48,7 @@
 
 domain_auto_trans(kmod_t, hotplug_exec_t, hotplug_t)
 domain_auto_trans_read(hotplug_t, insmod_exec_t, insmod_t)
+allow hotplug_t insmod_exec_t:lnk_file read;
 domain_auto_trans_read(hotplug_t, mount_exec_t, mount_t)
 domain_auto_trans_read(hotplug_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`pump.te', `domain_auto_trans_read(hotplug_t, pump_exec_t, pump_t)')
diff -ruwN /tmp/policy/domains/program/ifconfig.te policy/domains/program/ifconfig.te
--- /tmp/policy/domains/program/ifconfig.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/ifconfig.te	2003-01-18 13:44:13.000000000 +0100
@@ -35,3 +35,5 @@
 # Access terminals.
 allow ifconfig_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ifconfig_t sysadm_gph_t:fd use;')
+
+allow ifconfig_t tun_tap_device_t:chr_file { read write };
diff -ruwN /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/modutil.te	2003-01-18 14:44:28.000000000 +0100
@@ -56,10 +56,7 @@
 allow insmod_t var_log_ksyms_t:dir create_dir_perms;
 
 ifdef(`crond.te', `
-# for old modutils
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)
-# for new modutils that is 2.5 compatable
-can_exec(insmod_t, bin_t)
 ')
 
 #################################
@@ -127,9 +124,10 @@
 allow update_modules_t self:process { fork sigchld };
 allow update_modules_t self:fifo_file rw_file_perms;
 allow update_modules_t modules_dep_t:file rw_file_perms;
-r_dir_file(update_modules_t, modules_object_t)
+file_type_auto_trans(update_modules_t, modules_object_t, modules_conf_t)
 domain_auto_trans_read(update_modules_t, depmod_exec_t, depmod_t)
-can_exec(update_modules_t, bin_t)
+can_exec(update_modules_t, { shell_exec_t bin_t update_modules_exec_t })
+allow update_modules_t bin_t:lnk_file read;
 allow update_modules_t { sbin_t bin_t }:dir search;
 allow update_modules_t { etc_t etc_runtime_t }:file r_file_perms;
 allow update_modules_t fs_t:filesystem getattr;
diff -ruwN /tmp/policy/domains/program/mrtg.te policy/domains/program/mrtg.te
--- /tmp/policy/domains/program/mrtg.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/mrtg.te	2003-01-18 14:45:45.000000000 +0100
@@ -34,11 +34,11 @@
 allow mrtg_t { bin_t sbin_t }:dir { getattr search };
 allow mrtg_t bin_t:lnk_file read;
 allow mrtg_t var_t:dir { getattr search };
-r_dir_file(mrtg_t, var_lib_snmpd_t)
 
 ifdef(`snmpd.te', `
 can_udp_send(mrtg_t, snmpd_t)
 can_udp_send(snmpd_t, mrtg_t)
+r_dir_file(mrtg_t, var_lib_snmpd_t)
 ')
 
 allow mrtg_t proc_t:file { read getattr };
diff -ruwN /tmp/policy/domains/program/passwd.te policy/domains/program/passwd.te
--- /tmp/policy/domains/program/passwd.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/passwd.te	2003-01-18 14:51:01.000000000 +0100
@@ -18,7 +18,7 @@
 role sysadm_r types passwd_t;
 every_domain(passwd_t)
 type passwd_exec_t, file_type, sysadmfile, exec_type;
-type admin_passwd_exec_t, file_type, sysadmfile, exec_type;
+type admin_passwd_exec_t, file_type, sysadmfile;
 domain_auto_trans(userdomain, passwd_exec_t, passwd_t)
 domain_auto_trans(sysadm_t, admin_passwd_exec_t, passwd_t)
 
diff -ruwN /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/postfix.te	2003-01-18 14:52:42.000000000 +0100
@@ -82,14 +82,15 @@
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
 allow postfix_master_t random_device_t:chr_file { read getattr };
 allow postfix_master_t postfix_prng_t:file rw_file_perms;
+file_type_auto_trans(postfix_master_t, var_spool_t, postfix_spool_t, dir)
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
@@ -125,6 +126,7 @@
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:dir search;
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:sock_file rw_file_perms;
 allow postfix_smtpd_t postfix_master_t:unix_stream_socket connectto;
+allow postfix_smtpd_t etc_aliases_t:file r_file_perms;
 
 allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms;
 
@@ -134,7 +136,7 @@
 # for a bug in the postfix local program
 dontaudit procmail_t postfix_local_t:tcp_socket { read write };
 ')
-allow postfix_local_t { etc_aliases_t }:file r_file_perms;
+allow postfix_local_t etc_aliases_t:file r_file_perms;
 allow postfix_local_t self:fifo_file rw_file_perms;
 allow postfix_local_t postfix_spool_t:dir r_dir_perms;
 allow postfix_local_t postfix_spool_t:file rw_file_perms;
@@ -241,7 +243,7 @@
 type postfix_spool_bounce_t, file_type, sysadmfile;
 create_dir_file(postfix_bounce_t, postfix_spool_bounce_t)
 create_dir_file(postfix_bounce_t, postfix_spool_t)
-allow postfix_master_t postfix_spool_bounce_t:dir r_dir_perms;
+allow postfix_master_t postfix_spool_bounce_t:dir create_dir_perms;
 allow postfix_bounce_t self:capability { dac_read_search };
 allow postfix_bounce_t postfix_public_t:sock_file write;
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
diff -ruwN /tmp/policy/domains/program/pppd.te policy/domains/program/pppd.te
--- /tmp/policy/domains/program/pppd.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/pppd.te	2003-01-19 12:33:03.000000000 +0100
@@ -70,3 +70,8 @@
 role sysadm_r types pppd_t;
 allow userdomain pppd_t:process signal;
 ')
+
+# for pppoe
+can_create_pty(pppd)
+allow pppd_t self:capability { fowner net_raw };
+allow pppd_t pppd_t:packet_socket create_socket_perms;
diff -ruwN /tmp/policy/domains/program/procmail.te policy/domains/program/procmail.te
--- /tmp/policy/domains/program/procmail.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/procmail.te	2003-01-18 14:54:34.000000000 +0100
@@ -22,12 +22,14 @@
 allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
 
 allow procmail_t etc_t:dir r_dir_perms;
-allow procmail_t { etc_t resolv_conf_t }:file r_file_perms;
+allow procmail_t { etc_t etc_runtime_t resolv_conf_t }:file { getattr read };
 allow procmail_t etc_t:lnk_file read;
 
-allow procmail_t self:process { setsched fork sigchld };
+allow procmail_t self:process { setsched fork sigchld signal };
 can_exec(procmail_t, { bin_t shell_exec_t })
-allow procmail_t self:fifo_file { read write getattr };
+allow procmail_t bin_t:dir search;
+allow procmail_t bin_t:lnk_file read;
+allow procmail_t self:fifo_file rw_file_perms;
 
 allow procmail_t self:unix_stream_socket create_socket_perms;
 allow procmail_t self:unix_dgram_socket create_socket_perms;
@@ -50,3 +52,5 @@
 
 # Do not audit attempts to access /root.
 dontaudit procmail_t sysadm_home_dir_t:dir { getattr search };
+
+allow procmail_t devtty_t:chr_file { read write };
diff -ruwN /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/quota.te	2003-01-18 14:55:12.000000000 +0100
@@ -15,7 +15,7 @@
 rw_dir_create_file(initrc_t, quota_flag_t)
 
 allow quota_t fs_t:filesystem { getattr quotaget quotamod };
-allow quota_t home_root_t:dir getattr;
+allow quota_t { home_root_t var_t usr_t src_t }:dir getattr;
 allow quota_t self:capability sys_admin;
 allow quota_t file_t:file quotaon;
 
diff -ruwN /tmp/policy/domains/program/radvd.te policy/domains/program/radvd.te
--- /tmp/policy/domains/program/radvd.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/radvd.te	2003-01-18 14:55:41.000000000 +0100
@@ -23,7 +23,6 @@
 allow radvd_t proc_t:dir r_dir_perms;
 allow radvd_t { proc_t etc_radvd_t }:file r_file_perms;
 allow radvd_t etc_t:lnk_file read;
-allow radvd_t null_device_t:chr_file rw_file_perms;
 
 allow radvd_t sysctl_net_t:file r_file_perms;
 allow radvd_t sysctl_net_t:dir r_dir_perms;
diff -ruwN /tmp/policy/domains/program/samba.te policy/domains/program/samba.te
--- /tmp/policy/domains/program/samba.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/samba.te	2003-01-18 14:56:43.000000000 +0100
@@ -20,7 +20,7 @@
 allow smbd_t var_run_nmbd_t:file rw_file_perms;
 
 ifdef(`crond.te', `
-allow system_crond_t samba_etc_t:file { read getattr };
+allow system_crond_t samba_etc_t:file { read getattr lock };
 ')
 
 #################################
@@ -48,7 +48,7 @@
 #allow smbd_t samba_etc_t:dir { search getattr };
 file_type_auto_trans(smbd_t, samba_etc_t, samba_secrets_t, file)
 
-allow smbd_t samba_etc_t:file { getattr read };
+allow smbd_t samba_etc_t:file { getattr read lock };
 
 # Permissions for Samba cache files in /var/cache/samba
 allow smbd_t samba_var_t:dir { write remove_name add_name lock getattr search };
diff -ruwN /tmp/policy/domains/program/slapd.te policy/domains/program/slapd.te
--- /tmp/policy/domains/program/slapd.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/slapd.te	2003-01-18 14:57:44.000000000 +0100
@@ -44,6 +44,9 @@
 # read config files
 allow slapd_t { etc_t etc_slapd_t resolv_conf_t etc_runtime_t }:{ file lnk_file } r_file_perms;
 
+# for startup script
+allow initrc_t etc_slapd_t:file read;
+
 allow slapd_t etc_t:dir r_dir_perms;
 
 allow slapd_t sysctl_kernel_t:dir search;
diff -ruwN /tmp/policy/domains/program/tmpreaper.te policy/domains/program/tmpreaper.te
--- /tmp/policy/domains/program/tmpreaper.te	2003-01-20 01:04:01.000000000 +0100
+++ policy/domains/program/tmpreaper.te	2003-01-18 14:59:02.000000000 +0100
@@ -21,6 +21,7 @@
 allow tmpreaper_t home_type:notdevfile_class_set { getattr unlink };
 allow tmpreaper_t self:process { fork sigchld };
 allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
+allow tmpreaper_t fs_t:filesystem getattr;
 
 r_dir_file(tmpreaper_t, etc_t)
 allow tmpreaper_t var_t:dir { getattr search };
diff -ruwN /tmp/policy/file_contexts/program/crond.fc policy/file_contexts/program/crond.fc
--- /tmp/policy/file_contexts/program/crond.fc	2002-11-29 12:19:36.000000000 +0100
+++ policy/file_contexts/program/crond.fc	2003-01-18 15:04:41.000000000 +0100
@@ -16,4 +16,5 @@
 /var/spool/fcron		system_u:object_r:cron_spool_t
 /var/spool/fcron/.*		<<none>>
 /var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
+/var/spool/fcron/systab		system_u:object_r:sysadm_cron_spool_t
 /var/run/fcron.fifo		system_u:object_r:var_run_crond_t
diff -ruwN /tmp/policy/file_contexts/program/fsadm.fc policy/file_contexts/program/fsadm.fc
--- /tmp/policy/file_contexts/program/fsadm.fc	2002-12-03 15:56:44.000000000 +0100
+++ policy/file_contexts/program/fsadm.fc	2003-01-18 15:04:51.000000000 +0100
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
@@ -22,3 +24,4 @@
 /sbin/losetup			system_u:object_r:fsadm_exec_t
 /usr/sbin/updfstab		system_u:object_r:fsadm_exec_t
 /usr/sbin/smart(d|ctl)		system_u:object_r:fsadm_exec_t
+/sbin/lvmiopversion		system_u:object_r:fsadm_exec_t
diff -ruwN /tmp/policy/file_contexts/program/initrc.fc policy/file_contexts/program/initrc.fc
--- /tmp/policy/file_contexts/program/initrc.fc	2002-10-28 22:56:00.000000000 +0100
+++ policy/file_contexts/program/initrc.fc	2003-01-18 15:05:08.000000000 +0100
@@ -11,3 +11,4 @@
 /usr/local/selinux/sbin/open_init_pty	system_u:object_r:initrc_exec_t
 /usr/sbin/run_init		system_u:object_r:run_init_exec_t
 /usr/sbin/open_init_pty		system_u:object_r:initrc_exec_t
+/etc/nologin.boot		system_u:object_r:etc_runtime_t
diff -ruwN /tmp/policy/file_contexts/program/postfix.fc policy/file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2002-12-03 15:56:45.000000000 +0100
+++ policy/file_contexts/program/postfix.fc	2003-01-18 15:05:43.000000000 +0100
@@ -25,6 +25,7 @@
 /usr/sbin/postsuper		system_u:object_r:postfix_master_exec_t
 /usr/sbin/rmail			system_u:object_r:postfix_master_exec_t
 /var/spool/postfix/active(/.*)?	system_u:object_r:postfix_spool_t
+/var/spool/postfix/hold(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/incoming(/.*)? system_u:object_r:postfix_spool_t
 /var/spool/postfix/maildrop(/.*)? system_u:object_r:postfix_spool_maildrop_t
 /var/spool/postfix/pid		system_u:object_r:var_run_t
diff -ruwN /tmp/policy/file_contexts/program/postgresql.fc policy/file_contexts/program/postgresql.fc
--- /tmp/policy/file_contexts/program/postgresql.fc	2002-08-23 20:44:20.000000000 +0200
+++ policy/file_contexts/program/postgresql.fc	2003-01-18 15:05:50.000000000 +0100
@@ -4,3 +4,4 @@
 /var/run/postgresql(/.*)?	system_u:object_r:var_run_postgresql_t
 /etc/postgresql(/.*)?		system_u:object_r:etc_postgresql_t
 /var/log/postgres.log.*		system_u:object_r:postgresql_log_t
+/var/log/postgresql(/.*)?	system_u:object_r:postgresql_log_t
diff -ruwN /tmp/policy/file_contexts/program/slapd.fc policy/file_contexts/program/slapd.fc
--- /tmp/policy/file_contexts/program/slapd.fc	2002-07-12 17:19:44.000000000 +0200
+++ policy/file_contexts/program/slapd.fc	2003-01-18 15:06:05.000000000 +0100
@@ -3,3 +3,4 @@
 /var/lib/ldap(/.*)?		system_u:object_r:slapd_db_t
 /var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd.args		system_u:object_r:var_run_slapd_t
+/etc/ldap/slapd.conf		system_u:object_r:etc_slapd_t
diff -ruwN /tmp/policy/file_contexts/program/syslogd.fc policy/file_contexts/program/syslogd.fc
--- /tmp/policy/file_contexts/program/syslogd.fc	2002-09-09 19:54:22.000000000 +0200
+++ policy/file_contexts/program/syslogd.fc	2003-01-18 15:06:11.000000000 +0100
@@ -2,6 +2,7 @@
 /sbin/syslogd			system_u:object_r:syslogd_exec_t
 /sbin/minilogd			system_u:object_r:syslogd_exec_t
 /usr/sbin/syslogd		system_u:object_r:syslogd_exec_t
+/sbin/syslog-ng			system_u:object_r:syslogd_exec_t
 /dev/log			system_u:object_r:devlog_t
 /var/run/log			system_u:object_r:devlog_t
 /var/run/klogd.pid		system_u:object_r:klogd_var_run_t
diff -ruwN /tmp/policy/genfs_contexts policy/genfs_contexts
--- /tmp/policy/genfs_contexts	2003-01-20 01:03:58.000000000 +0100
+++ policy/genfs_contexts	2003-01-18 15:08:03.000000000 +0100
@@ -80,6 +80,7 @@
 genfscon devfs /ataraid	-b		system_u:object_r:fixed_disk_device_t
 genfscon devfs /loop	-b		system_u:object_r:fixed_disk_device_t
 genfscon devfs /misc/rtc		system_u:object_r:clock_device_t
+genfscon devfs /net/tun			system_u:object_r:tun_tap_device_t
 ifdef(`watchdog.te', `
 genfscon devfs /misc/watchdog		system_u:object_r:watchdog_device_t
 ')
diff -ruwN /tmp/policy/macros/admin_macros.te policy/macros/admin_macros.te
--- /tmp/policy/macros/admin_macros.te	2002-10-23 21:38:25.000000000 +0200
+++ policy/macros/admin_macros.te	2003-01-18 15:08:27.000000000 +0100
@@ -61,6 +61,9 @@
 allow $1_t ttyfile:chr_file rw_file_perms;
 allow $1_t ptyfile:chr_file rw_file_perms;
 
+# allow setting up tunnels
+allow $1_t tun_tap_device_t:chr_file rw_file_perms;
+
 # Run init (telinit).
 can_exec($1_t, init_exec_t)
 
diff -ruwN /tmp/policy/macros/program/mta_macros.te policy/macros/program/mta_macros.te
--- /tmp/policy/macros/program/mta_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/mta_macros.te	2003-01-18 15:10:26.000000000 +0100
@@ -50,6 +50,7 @@
 # Read cron temporary files.
 allow system_mail_t system_crond_tmp_t:file { read getattr };
 allow mta_user_agent system_crond_tmp_t:file { read getattr };
+allow system_mail_t initrc_devpts_t:chr_file { read write getattr };
 
 ', `
 # Read user temporary files.
diff -ruwN /tmp/policy/macros/program/su_macros.te policy/macros/program/su_macros.te
--- /tmp/policy/macros/program/su_macros.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/macros/program/su_macros.te	2003-01-18 15:12:07.000000000 +0100
@@ -54,15 +54,14 @@
 # The user role is authorized for this domain.
 role $1_r types $1_su_t;
 
-# Execute xauth.
-can_exec($1_su_t, bin_t)
-
 # Write to the user domain tty.
 allow $1_su_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_su_t $1_devpts_t:chr_file rw_file_perms;
 
+allow $1_su_t $1_home_dir_t:dir search;
+
 # Modify .Xauthority file (via xauth program).
-file_type_auto_trans($1_su_t, $1_home_dir_t, $1_home_t)
+domain_auto_trans($1_su_t, xauth_exec_t, $1_xauth_t)
 
 # Access sshd cookie files.
 allow $1_su_t sshd_tmp_t:dir rw_dir_perms;
diff -ruwN /tmp/policy/net_contexts policy/net_contexts
--- /tmp/policy/net_contexts	2002-09-21 06:04:22.000000000 +0200
+++ policy/net_contexts	2003-01-18 15:13:32.000000000 +0100
@@ -18,6 +18,7 @@
 # protocol low-high context
 #
 ifdef(`courier.te', `define(`use_pop')')
+ifdef(`perdition.te', `define(`use_pop')')
 ifdef(`ftpd.te', `portcon tcp 21 system_u:object_r:ftp_port_t')
 ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
 ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnet_port_t')
diff -ruwN /tmp/policy/types/device.te policy/types/device.te
--- /tmp/policy/types/device.te	2003-01-20 01:04:03.000000000 +0100
+++ policy/types/device.te	2003-01-18 15:13:55.000000000 +0100
@@ -68,6 +68,11 @@
 type clock_device_t, file_type;
 
 #
+# tun_tap_device_t is the type of /dev/net/tun/* and /dev/net/tap/*
+#
+type tun_tap_device_t, file_type;
+
+#
 # misc_device_t is the type of miscellaneous devices.
 # XXX:  FIXME!  Appropriate access to these devices need to be identified.
 #

--Boundary-00=_LQ0K+ampUlX9Os/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
