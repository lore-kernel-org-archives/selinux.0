Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HHdnrT015281
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:39:49 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HHdmKV024582
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 17:39:48 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i7HHe10A023004
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:40:01 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i7HHe1QR023003
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 13:40:01 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H4OLrT011406
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 00:24:21 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H4OJKV005744
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 04:24:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7H4OKe1027135
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 00:24:20 -0400
Received: from [10.0.0.246] (vpn83-135.boston.redhat.com [172.16.83.135])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7H4OEa17269
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 00:24:15 -0400
Subject: hald
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-qdyeal/3N8Rny5j6HoWz"
Message-Id: <1092716467.1684.304.camel@vpn>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 14:21:07 +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qdyeal/3N8Rny5j6HoWz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hald is a daemon that manages hardware via dbus, which is now a
mandatory feature of the latest rawhide.

I have attached the main policy files for it and a patch for a couple of
other programs which it depends on along with many other trivial
patches.

--=-qdyeal/3N8Rny5j6HoWz
Content-Disposition: attachment; filename=hald.te
Content-Type: text/plain; name=hald.te; charset=UTF-8
Content-Transfer-Encoding: 7bit

#DESC hald - server for device info
#
# Author:  Russell Coker <rcoker@redhat.com>
# X-Debian-Packages: 
#

#################################
#
# Rules for the hald_t domain.
#
# hald_exec_t is the type of the hald executable.
#
daemon_domain(hald, `, dbus_client_domain')

allow hald_t etc_t:file { getattr read };
allow hald_t self:unix_stream_socket create_stream_socket_perms;

allow hald_t dbusd_t:dbus { acquire_svc };

allow hald_t self:file { getattr read };

allow hald_t { bin_t sbin_t }:dir search;
allow hald_t hald_t:fifo_file rw_file_perms;
allow hald_t usr_t:file { getattr read };

allow hald_t bin_t:file { getattr };
allow hald_t self:netlink_route_socket r_netlink_socket_perms;
allow hald_t self:capability { net_admin sys_admin };
can_network(hald_t)

ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
ifdef(`udev.te', `domain_auto_trans(hald_t, udev_exec_t, udev_t)')

allow hald_t usbdevfs_t:dir search;
allow hald_t usbdevfs_t:file { getattr read };

--=-qdyeal/3N8Rny5j6HoWz
Content-Disposition: attachment; filename=hald.fc
Content-Type: text/plain; name=hald.fc; charset=UTF-8
Content-Transfer-Encoding: 7bit

# hald - hardware informationd daemon
/usr/sbin/hald		--	system_u:object_r:hald_exec_t

--=-qdyeal/3N8Rny5j6HoWz
Content-Disposition: attachment; filename=diff
Content-Type: text/x-patch; name=diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ru /usr/src/se/policy/domains/program/crond.te ./domains/program/crond.te
--- /usr/src/se/policy/domains/program/crond.te	2004-08-04 20:26:43.000000000 +1000
+++ ./domains/program/crond.te	2004-08-15 15:47:49.000000000 +1000
@@ -148,7 +148,7 @@
 
 # Stat any file and search any directory for find.
 allow system_crond_t { root_dir_type file_type fs_type }:notdevfile_class_set getattr;
-allow system_crond_t device_type:{ chr_file blk_file dir } getattr;
+allow system_crond_t device_type:{ chr_file blk_file } getattr;
 allow system_crond_t file_type:dir { read search getattr };
 
 # Create temporary files.
diff -ru /usr/src/se/policy/domains/program/mount.te ./domains/program/mount.te
--- /usr/src/se/policy/domains/program/mount.te	2004-05-30 16:26:57.000000000 +1000
+++ ./domains/program/mount.te	2004-08-17 13:39:04.000000000 +1000
@@ -30,6 +30,7 @@
 # Access disk devices.
 allow mount_t fixed_disk_device_t:devfile_class_set rw_file_perms;
 allow mount_t removable_device_t:devfile_class_set rw_file_perms;
+allow mount_t device_t:lnk_file read;
 
 # for when /etc/mtab loses its type
 allow mount_t file_t:file { getattr read unlink };
diff -ru /usr/src/se/policy/domains/program/unused/cardmgr.te ./domains/program/unused/cardmgr.te
--- /usr/src/se/policy/domains/program/unused/cardmgr.te	2004-08-02 16:59:48.000000000 +1000
+++ ./domains/program/unused/cardmgr.te	2004-07-22 00:13:24.000000000 +1000
@@ -35,10 +35,7 @@
 allow cardmgr_t self:unix_stream_socket create_socket_perms;
 allow cardmgr_t self:fifo_file rw_file_perms;
 
-file_type_auto_trans(cardmgr_t, { cardmgr_var_run_t var_run_t device_t tmp_t }, cardmgr_dev_t, { blk_file chr_file })
-
-# Create stab file and device nodes.
-file_type_auto_trans(cardmgr_t, var_lib_t, cardmgr_dev_t, { blk_file chr_file })
+# Create stab file
 var_lib_domain(cardmgr)
 
 # for /var/lib/misc/pcmcia-scheme
@@ -47,17 +44,14 @@
 
 # Create device files in /tmp.
 type cardmgr_dev_t, file_type, sysadmfile, tmpfile, device_type;
-allow cardmgr_t cardmgr_dev_t:chr_file create_file_perms;
-
 ifdef(`tmpreaper.te', `
 allow tmpreaper_t cardmgr_dev_t:chr_file { getattr unlink };
 ')
+file_type_auto_trans(cardmgr_t, { var_run_t cardmgr_var_run_t device_t tmp_t }, cardmgr_dev_t, { blk_file chr_file })
 
 # Create symbolic links in /dev.
 type cardmgr_lnk_t, file_type, sysadmfile;
-type_transition cardmgr_t device_t:lnk_file cardmgr_lnk_t;
-allow cardmgr_t device_t:dir rw_dir_perms;
-allow cardmgr_t cardmgr_lnk_t:lnk_file create_lnk_perms;
+file_type_auto_trans(cardmgr_t, device_t, cardmgr_lnk_t, lnk_file)
 
 # Run a shell, normal commands, /etc/pcmcia scripts. 
 can_exec_any(cardmgr_t)
diff -ru /usr/src/se/policy/domains/program/unused/clamav.te ./domains/program/unused/clamav.te
--- /usr/src/se/policy/domains/program/unused/clamav.te	2004-06-17 15:10:39.000000000 +1000
+++ ./domains/program/unused/clamav.te	2004-08-16 20:14:39.000000000 +1000
@@ -25,7 +25,7 @@
 can_network(freshclam_t)
 
 # Access virus signatures
-allow freshclam_t var_lib_t:dir search;
+allow freshclam_t { var_t var_lib_t }:dir search;
 rw_dir_create_file(freshclam_t, clamav_var_lib_t)
 
 allow freshclam_t devtty_t:chr_file { read write };
@@ -36,6 +36,9 @@
 allow freshclam_t urandom_device_t:chr_file { getattr read };
 dontaudit freshclam_t urandom_device_t:chr_file ioctl;
 
+# for nscd
+dontaudit freshclam_t var_run_t:dir search;
+
 # setuid/getuid used (although maybe not required...)
 allow freshclam_t self:capability { setgid setuid };
 
@@ -50,7 +53,7 @@
 allow freshclam_t self:fifo_file rw_file_perms;
 
 # Log files for freshclam executable
-log_domain(freshclam)
+logdir_domain(freshclam)
 allow initrc_t freshclam_log_t:file append;
 
 system_crond_entry(freshclam_exec_t, freshclam_t)
@@ -66,10 +69,11 @@
 daemon_domain(clamd)
 
 tmp_domain(clamd)
+logdir_domain(clamd)
 
 file_type_auto_trans(clamd_t, var_run_t, clamd_var_run_t, sock_file)
 
-allow clamd_t self:capability kill;
+allow clamd_t self:capability { kill setgid setuid };
 
 allow clamd_t var_lib_t:dir search;
 r_dir_file(clamd_t, clamav_var_lib_t)
diff -ru /usr/src/se/policy/domains/program/unused/courier.te ./domains/program/unused/courier.te
--- /usr/src/se/policy/domains/program/unused/courier.te	2004-03-18 15:36:08.000000000 +1100
+++ ./domains/program/unused/courier.te	2004-08-11 17:53:19.000000000 +1000
@@ -6,6 +6,7 @@
 
 # Type for files created during execution of courier.
 type courier_var_run_t, file_type, sysadmfile, pidfile;
+type courier_var_lib_t, file_type, sysadmfile;
 
 type courier_etc_t, file_type, sysadmfile;
 typealias courier_etc_t alias etc_courier_t;
@@ -73,6 +74,8 @@
 allow courier_authdaemon_t tmp_t:dir getattr;
 allow courier_authdaemon_t self:file { getattr read };
 read_locale(courier_authdaemon_t)
+can_exec(courier_authdaemon_t, courier_exec_t)
+dontaudit courier_authdaemon_t selinux_config_t:dir search;
 
 # for SSP
 allow courier_authdaemon_t urandom_device_t:chr_file read;
@@ -85,7 +88,7 @@
 allow courier_authdaemon_t self:capability { setuid setgid sys_tty_config };
 
 courier_domain(tcpd)
-allow courier_tcpd_t self:capability net_bind_service;
+allow courier_tcpd_t self:capability { kill net_bind_service };
 allow courier_tcpd_t pop_port_t:tcp_socket name_bind;
 allow courier_tcpd_t sbin_t:dir search;
 allow courier_tcpd_t var_lib_t:dir search;
@@ -97,6 +100,7 @@
 allow courier_authdaemon_t courier_tcpd_t:process sigchld;
 
 can_tcp_connect(userdomain, courier_tcpd_t)
+rw_dir_create_file(courier_tcpd_t, courier_var_lib_t)
 
 # domain for pop and imap
 courier_domain(pop)
@@ -111,6 +115,9 @@
 allow courier_pop_t courier_authdaemon_t:process sigchld;
 domain_auto_trans(courier_authdaemon_t, courier_pop_exec_t, courier_pop_t)
 
+# inherits file handle - should it?
+allow courier_pop_t courier_var_lib_t:file { read write };
+
 # do the actual work (read the Maildir)
 # imap needs to write files
 allow courier_pop_t home_root_t:dir { getattr search };
diff -ru /usr/src/se/policy/domains/program/unused/dpkg.te ./domains/program/unused/dpkg.te
--- /usr/src/se/policy/domains/program/unused/dpkg.te	2004-07-13 09:08:00.000000000 +1000
+++ ./domains/program/unused/dpkg.te	2004-08-03 12:23:33.000000000 +1000
@@ -18,7 +18,7 @@
 
 tmp_domain(dpkg)
 can_setfscreate(dpkg_t)
-can_exec(dpkg_t, { dpkg_exec_t bin_t shell_exec_t dpkg_tmp_t ls_exec_t dpkg_var_lib_t dpkg_etc_t sbin_t lib_t })
+can_exec(dpkg_t, { dpkg_exec_t bin_t shell_exec_t dpkg_tmp_t ls_exec_t dpkg_var_lib_t dpkg_etc_t sbin_t lib_t fsadm_exec_t })
 
 ifdef(`load_policy.te', `
 domain_auto_trans(dpkg_t, load_policy_exec_t, load_policy_t)
@@ -34,6 +34,9 @@
 ifdef(`mta.te', `
 allow system_mail_t dpkg_tmp_t:file { getattr read };
 ')
+ifdef(`logrotate.te', `
+allow logrotate_t dpkg_var_lib_t:file create_file_perms;
+')
 
 # for open office
 can_exec(dpkg_t, usr_t)
@@ -129,6 +132,7 @@
 domain_auto_trans(dpkg_t, checkpolicy_exec_t, checkpolicy_t)
 role system_r types checkpolicy_t;
 allow checkpolicy_t initrc_t:fd use;
+allow checkpolicy_t initrc_t:fifo_file write;
 allow checkpolicy_t initrc_devpts_t:chr_file { read write };
 ')
 ifdef(`amavis.te', `
@@ -316,7 +320,7 @@
 allow apt_t usr_t:lnk_file read;
 
 # allow /var/cache/apt/archives to be owned by non-root
-allow apt_t self:capability { chown dac_override fsetid };
+allow apt_t self:capability { chown dac_override fowner fsetid };
 
 can_exec(apt_t, { apt_exec_t bin_t sbin_t shell_exec_t })
 allow apt_t { bin_t sbin_t }:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/fingerd.te ./domains/program/unused/fingerd.te
--- /usr/src/se/policy/domains/program/unused/fingerd.te	2004-03-18 15:36:08.000000000 +1100
+++ ./domains/program/unused/fingerd.te	2004-08-15 14:06:58.000000000 +1000
@@ -21,6 +21,7 @@
 
 log_domain(fingerd)
 system_crond_entry(fingerd_exec_t, fingerd_t)
+ifdef(`logrotate.te', `can_exec(fingerd_t, logrotate_exec_t)')
 
 allow fingerd_t fingerd_port_t:tcp_socket name_bind;
 ifdef(`inetd.te', `
diff -ru /usr/src/se/policy/domains/program/unused/hwclock.te ./domains/program/unused/hwclock.te
--- /usr/src/se/policy/domains/program/unused/hwclock.te	2004-03-18 15:36:08.000000000 +1100
+++ ./domains/program/unused/hwclock.te	2004-07-27 17:04:10.000000000 +1000
@@ -44,3 +44,6 @@
 ifdef(`gnome-pty-helper.te', `allow hwclock_t sysadm_gph_t:fd use;')
 
 read_locale(hwclock_t)
+
+# for when /usr is not mounted
+dontaudit hwclock_t file_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/inetd.te ./domains/program/unused/inetd.te
--- /usr/src/se/policy/domains/program/unused/inetd.te	2004-07-13 09:08:00.000000000 +1000
+++ ./domains/program/unused/inetd.te	2004-08-11 12:59:19.000000000 +1000
@@ -110,6 +110,7 @@
 allow inetd_child_t inetd_t:tcp_socket rw_stream_socket_perms;
 
 # for identd
+allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow inetd_child_t self:capability { setuid setgid };
 allow inetd_child_t home_root_t:dir { search };
 allow inetd_child_t self:dir { search };
diff -ru /usr/src/se/policy/domains/program/unused/lpd.te ./domains/program/unused/lpd.te
--- /usr/src/se/policy/domains/program/unused/lpd.te	2004-03-27 00:46:44.000000000 +1100
+++ ./domains/program/unused/lpd.te	2004-08-10 17:39:12.000000000 +1000
@@ -13,22 +13,23 @@
 # lpd_t is the domain of lpd.
 # lpd_exec_t is the type of the lpd executable.
 # printer_t is the type of the Unix domain socket created
-# by lpd.  printer_device_t is for /dev/lp0
+# by lpd.
 #
 type printer_port_t, port_type;
 daemon_domain(lpd)
 
 allow lpd_t lpd_var_run_t:sock_file create_file_perms;
 
+r_dir_file(lpd_t, fonts_t)
+
 type printer_t, file_type, sysadmfile;
-type printer_device_t, file_type, device_type;
 
 type printconf_t, file_type, sysadmfile;   # Type for files in /usr/share/printconf.
 
 tmp_domain(lpd);
 
 # for postscript include files
-allow lpd_t usr_t:file { getattr read };
+allow lpd_t usr_t:{ file lnk_file } { getattr read };
 
 # Allow checkpc to access the lpd spool so it can check & fix it.
 # This requires that /usr/sbin/checkpc have type checkpc_t.
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-08-15 15:45:15.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-08-15 00:16:59.000000000 +1000
@@ -26,6 +26,7 @@
 # but runs as the identity of the sysadmin
 daemon_base_domain(lvm, `, fs_domain, privowner')
 role sysadm_r types lvm_t;
+domain_auto_trans(sysadm_t, lvm_exec_t, lvm_t)
 
 # LVM will complain a lot if it cannot set its priority.
 allow lvm_t self:process { setsched };
@@ -42,6 +43,8 @@
 # Read /sys/block. Device mapper metadata is kept there.
 r_dir_file(lvm_t, sysfs_t) 
 
+allow lvm_t fs_t:filesystem getattr;
+
 # Read configuration files in /etc.
 allow lvm_t { etc_t etc_runtime_t }:file { getattr read };
 
@@ -67,7 +70,7 @@
 # Write to /etc/lvm, /etc/lvmtab, /etc/lvmtab.d
 file_type_auto_trans(lvm_t, { etc_t lvm_etc_t }, lvm_metadata_t, file)
 
-allow lvm_t lvm_metadata_t:dir r_dir_perms;
+allow lvm_t lvm_metadata_t:dir rw_dir_perms;
 
 # Inherit and use descriptors from init.
 allow lvm_t init_t:fd use;
@@ -96,23 +99,25 @@
 
 # LVM (vgscan) scans for devices by stating every file in /dev and applying a regex...
 dontaudit lvm_t device_type:{ chr_file blk_file } getattr;
+dontaudit lvm_t ttyfile:chr_file getattr;
 dontaudit lvm_t device_t:{ fifo_file dir chr_file blk_file } getattr;
 dontaudit lvm_t devpts_t:dir { getattr read };
 ifdef(`gpm.te', `
 dontaudit lvm_t gpmctl_t:sock_file getattr;
 ')
 dontaudit lvm_t initctl_t:fifo_file getattr;
+allow lvm_t sbin_t:dir search;
 dontaudit lvm_t sbin_t:file getattr;
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
 allow initrc_t lvm_control_t:chr_file { getattr unlink };
 allow initrc_t device_t:chr_file create;
 dontaudit lvm_t var_run_t:dir getattr;
 
-allow lvm_t tmpfs_t:dir getattr;
-dontaudit lvm_t device_t:dir r_dir_perms;
+# for when /usr is not mounted
+dontaudit lvm_t file_t:dir search;
+
+allow lvm_t tmpfs_t:dir r_dir_perms;
 r_dir_file(lvm_t, selinux_config_t)
-allow lvm_t var_run_t:dir { search };
-ifdef(`cups.te', `
-dontaudit lvm_t ptal_var_run_t:dir { getattr };
-')
 
+# it has no reason to need this
+dontaudit lvm_t proc_kcore_t:file getattr;
diff -ru /usr/src/se/policy/domains/program/unused/mailman.te ./domains/program/unused/mailman.te
--- /usr/src/se/policy/domains/program/unused/mailman.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/mailman.te	2004-08-17 13:12:21.000000000 +1000
@@ -8,13 +8,11 @@
 
 type mailman_log_t, file_type, sysadmfile, logfile;
 type mailman_lock_t, file_type, sysadmfile, lockfile;
-role mailman_r types user_crond_t;
 
 define(`mailman_domain', `
 type mailman_$1_t, domain, privlog $2;
 type mailman_$1_exec_t, file_type, sysadmfile, exec_type;
 role system_r types mailman_$1_t;
-allow mailman_$1_t var_t:dir search;
 file_type_auto_trans(mailman_$1_t, var_log_t, mailman_log_t, file)
 allow mailman_$1_t mailman_log_t:dir rw_dir_perms;
 rw_dir_create_file(mailman_$1_t, mailman_data_t)
@@ -28,10 +26,11 @@
 allow mailman_$1_t etc_runtime_t:file { read getattr };
 read_locale(mailman_$1_t)
 file_type_auto_trans(mailman_$1_t, var_lock_t, mailman_lock_t, file)
+allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
-allow mailman_$1_t var_t:dir { getattr search };
+allow mailman_$1_t var_t:dir r_dir_perms;
 ')
 
 mailman_domain(queue, `, auth_chkpwd')
@@ -41,6 +40,14 @@
 allow mailman_queue_t self:capability { setgid setuid };
 allow mailman_queue_t self:fifo_file rw_file_perms;
 dontaudit mailman_queue_t var_run_t:dir search;
+allow mailman_queue_t proc_t:lnk_file { getattr read };
+
+# for su
+dontaudit mailman_queue_t selinux_config_t:dir search;
+allow mailman_queue_t self:dir search;
+allow mailman_queue_t self:file { getattr read };
+allow mailman_queue_t self:unix_dgram_socket create_socket_perms;
+allow mailman_queue_t self:lnk_file { getattr read };
 
 # some of the following could probably be changed to dontaudit, someone who
 # knows mailman well should test this out and send the changes
@@ -83,10 +90,6 @@
 allow mailman_mail_t self:unix_dgram_socket create_socket_perms;
 
 system_crond_entry(mailman_queue_exec_t, mailman_queue_t)
-type mailman_t, domain;
-role mailman_r types mailman_t;
-allow mailman_t mailman_log_t:file { append getattr read };
-
 allow mailman_queue_t devtty_t:chr_file { read write };
 allow mailman_queue_t self:process { fork signal sigchld };
 
diff -ru /usr/src/se/policy/domains/program/unused/mrtg.te ./domains/program/unused/mrtg.te
--- /usr/src/se/policy/domains/program/unused/mrtg.te	2004-08-02 16:59:49.000000000 +1000
+++ ./domains/program/unused/mrtg.te	2004-08-03 13:07:52.000000000 +1000
@@ -20,7 +20,8 @@
 allow system_crond_t mrtg_log_t:file { create append getattr };
 ')
 
-allow mrtg_t usr_t:file { getattr read };
+allow mrtg_t usr_t:{ file lnk_file } { getattr read };
+dontaudit mrtg_t usr_t:file ioctl;
 
 logdir_domain(mrtg)
 etcdir_domain(mrtg)
diff -ru /usr/src/se/policy/domains/program/unused/mysqld.te ./domains/program/unused/mysqld.te
--- /usr/src/se/policy/domains/program/unused/mysqld.te	2004-08-02 16:59:49.000000000 +1000
+++ ./domains/program/unused/mysqld.te	2004-08-16 20:32:14.000000000 +1000
@@ -34,14 +34,14 @@
 
 allow initrc_t mysqld_log_t:file { write append setattr ioctl };
 
-allow mysqld_t self:capability { setgid setuid };
+allow mysqld_t self:capability { dac_override setgid setuid };
 allow mysqld_t self:process getsched;
 
 allow mysqld_t proc_t:file { getattr read };
 
 # Allow access to the mysqld databases
 create_dir_file(mysqld_t, mysqld_db_t)
-allow mysqld_t var_lib_t:dir search;
+allow mysqld_t var_lib_t:dir { getattr search };
 
 can_network(mysqld_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/named.te ./domains/program/unused/named.te
--- /usr/src/se/policy/domains/program/unused/named.te	2004-08-15 15:45:15.000000000 +1000
+++ ./domains/program/unused/named.te	2004-08-14 17:00:44.000000000 +1000
@@ -30,12 +29,12 @@
 
 # A type for configuration files of named.
 type named_conf_t, file_type, sysadmfile;
-type rndc_conf_t, file_type, sysadmfile;
+typealias named_conf_t alias rndc_conf_t;
 
 # for primary zone files
 type named_zone_t, file_type, sysadmfile;
 
-# for named.ca root hints file
+# for secondary zone files
 type named_cache_t, file_type, sysadmfile;
 
 # Use capabilities. Surplus capabilities may be allowed.
diff -ru /usr/src/se/policy/domains/program/unused/nsd.te ./domains/program/unused/nsd.te
--- /usr/src/se/policy/domains/program/unused/nsd.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/nsd.te	2004-08-17 09:04:48.000000000 +1000
@@ -12,6 +12,9 @@
 
 daemon_domain(nsd)
 
+# a type for nsd.db
+type nsd_db_t, file_type, sysadmfile;
+
 # for zone update cron job
 type nsd_crond_t, domain, privlog;
 role system_r types nsd_crond_t;
@@ -21,6 +24,7 @@
 allow nsd_crond_t self:process { fork signal_perms };
 system_crond_entry(nsd_exec_t, nsd_crond_t)
 allow nsd_crond_t { proc_t etc_runtime_t }:file { getattr read };
+allow nsd_crond_t proc_t:lnk_file { getattr read };
 allow nsd_crond_t { bin_t sbin_t }:dir search;
 can_exec(nsd_crond_t, { nsd_exec_t bin_t sbin_t shell_exec_t })
 allow nsd_crond_t { bin_t sbin_t shell_exec_t }:file getattr;
@@ -28,14 +32,16 @@
 read_locale(nsd_crond_t)
 allow nsd_crond_t self:fifo_file rw_file_perms;
 # kill capability for root cron job and non-root daemon
-allow nsd_crond_t self:capability kill;
+allow nsd_crond_t self:capability { dac_override kill };
 allow nsd_crond_t nsd_t:process signal;
 dontaudit nsd_crond_t sysadm_home_dir_t:dir { search getattr };
 dontaudit nsd_crond_t self:capability sys_nice;
 dontaudit nsd_crond_t domain:dir search;
 allow nsd_crond_t self:process { setsched };
+can_ps(nsd_crond_t, nsd_t)
 
 file_type_auto_trans(nsd_crond_t, nsd_conf_t, nsd_zone_t, file)
+file_type_auto_trans({ nsd_t nsd_crond_t }, nsd_zone_t, nsd_db_t, file)
 allow nsd_crond_t var_lib_t:dir search;
 
 allow nsd_crond_t nsd_conf_t:file { getattr read ioctl };
@@ -66,7 +72,7 @@
 can_exec(nsd_t, { nsd_exec_t bin_t })
 
 # Use capabilities.  chown is for chowning /var/run/nsd.pid
-allow nsd_t self:capability { chown setuid setgid net_bind_service };
+allow nsd_t self:capability { dac_override chown setuid setgid net_bind_service };
 
 allow nsd_t etc_t:{ file lnk_file } { getattr read };
 
diff -ru /usr/src/se/policy/domains/program/unused/ntpd.te ./domains/program/unused/ntpd.te
--- /usr/src/se/policy/domains/program/unused/ntpd.te	2004-08-06 19:08:12.000000000 +1000
+++ ./domains/program/unused/ntpd.te	2004-08-05 13:40:26.000000000 +1000
@@ -19,6 +19,9 @@
 allow ntpd_t ntp_drift_t:dir rw_dir_perms;
 allow ntpd_t ntp_drift_t:file create_file_perms;
 
+# for SSP
+allow ntpd_t urandom_device_t:chr_file read;
+
 allow ntpd_t self:capability { setgid setuid sys_time net_bind_service ipc_lock };
 allow ntpd_t self:process { setcap setsched };
 # ntpdate wants sys_nice
@@ -54,7 +57,7 @@
 allow ntpd_t sysctl_kernel_t:file read;
 allow ntpd_t proc_t:file r_file_perms;
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
-allow ntpd_t self:file read;
+allow ntpd_t self:file { getattr read };
 dontaudit ntpd_t domain:dir search;
 ')
 
diff -ru /usr/src/se/policy/domains/program/unused/portslave.te ./domains/program/unused/portslave.te
--- /usr/src/se/policy/domains/program/unused/portslave.te	2004-03-18 15:36:09.000000000 +1100
+++ ./domains/program/unused/portslave.te	2004-08-07 01:40:57.000000000 +1000
@@ -27,6 +27,9 @@
 read_locale(portslave_t)
 r_dir_file(portslave_t, portslave_etc_t)
 
+allow portslave_t pppd_etc_t:dir r_dir_perms;
+allow portslave_t pppd_etc_rw_t:file { getattr read };
+
 allow portslave_t proc_t:file { getattr read };
 
 allow portslave_t { var_t var_log_t devpts_t }:dir search;
@@ -43,8 +46,8 @@
 ')
 # for rlogin etc
 can_exec(portslave_t, { bin_t ssh_exec_t })
-# for rlogin
-allow portslave_t self:capability net_bind_service;
+# net_bind_service for rlogin
+allow portslave_t self:capability { net_bind_service sys_tty_config };
 # for ssh
 allow portslave_t urandom_device_t:chr_file read;
 ifdef(`sshd.te', `can_tcp_connect(portslave_t, sshd_t)')
@@ -56,6 +59,9 @@
 # for ~/.ppprc - if it actually exists then you need some policy to read it
 allow portslave_t { sysadm_home_dir_t home_root_t user_home_dir_type }:dir search;
 
+# for ctlportslave
+dontaudit portslave_t self:capability sys_admin;
+
 file_type_auto_trans(portslave_t, var_run_t, pppd_var_run_t, file)
 can_exec(portslave_t, { etc_t shell_exec_t })
 
diff -ru /usr/src/se/policy/domains/program/unused/postfix.te ./domains/program/unused/postfix.te
--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-06-30 13:03:15.000000000 +1000
+++ ./domains/program/unused/postfix.te	2004-08-04 15:38:54.000000000 +1000
@@ -42,8 +42,7 @@
 allow postfix_$1_t self:unix_stream_socket connectto;
 
 allow postfix_$1_t { sbin_t bin_t }:dir r_dir_perms;
-allow postfix_$1_t bin_t:lnk_file r_file_perms;
-allow postfix_$1_t usr_t:lnk_file r_file_perms;
+allow postfix_$1_t { bin_t usr_t }:lnk_file { getattr read };
 allow postfix_$1_t shell_exec_t:file rx_file_perms;
 allow postfix_$1_t { var_t var_spool_t }:dir { search getattr };
 allow postfix_$1_t postfix_exec_t:file rx_file_perms;
@@ -334,4 +333,7 @@
 dontaudit postfix_map_t proc_t:dir { getattr read search };
 dontaudit postfix_map_t local_login_t:fd { use };
 allow postfix_master_t postfix_map_exec_t:file rx_file_perms;
-
+read_locale(postfix_map_t)
+allow postfix_map_t self:capability setgid;
+allow postfix_map_t self:unix_dgram_socket create_socket_perms;
+dontaudit postfix_map_t var_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/postgresql.te ./domains/program/unused/postgresql.te
--- /usr/src/se/policy/domains/program/unused/postgresql.te	2004-08-02 16:59:50.000000000 +1000
+++ ./domains/program/unused/postgresql.te	2004-07-08 17:43:23.000000000 +1000
@@ -24,8 +24,8 @@
 
 dontaudit postgresql_t sysadm_home_dir_t:dir search;
 
-# quiet ps
-dontaudit postgresql_t domain:dir getattr;
+# quiet ps and killall
+dontaudit postgresql_t domain:dir { getattr search };
 
 # for currect directory of scripts
 allow postgresql_t { var_spool_t cron_spool_t }:dir search;
@@ -56,8 +56,17 @@
 
 allow postgresql_t self:shm create_shm_perms;
 
+ifdef(`user_db_connect', `
 # allow any user domain to connect to the database server
 can_tcp_connect(userdomain, postgresql_t)
+allow userdomain postgresql_t:unix_stream_socket connectto;
+allow userdomain postgresql_var_run_t:sock_file write;
+')
+
+ifdef(`consoletype.te', `
+can_exec(postgresql_t, consoletype_exec_t)
+')
+
 allow postgresql_t postgresql_port_t:tcp_socket name_bind;
 
 allow postgresql_t { proc_t self }:file { getattr read };
@@ -85,12 +94,9 @@
 
 can_exec(postgresql_t, { postgresql_exec_t bin_t sbin_t ls_exec_t su_exec_t shell_exec_t etc_t })
 allow postgresql_t { bin_t sbin_t }:dir search;
-allow postgresql_t bin_t:lnk_file read;
+allow postgresql_t { bin_t sbin_t }:lnk_file read;
 allow postgresql_t postgresql_exec_t:lnk_file read;
 
 allow postgresql_t self:sem create_sem_perms;
 
 allow postgresql_t initrc_var_run_t:file { getattr read lock };
-
-allow userdomain postgresql_t:unix_stream_socket connectto;
-allow userdomain postgresql_var_run_t:sock_file write;
diff -ru /usr/src/se/policy/domains/program/unused/pppd.te ./domains/program/unused/pppd.te
--- /usr/src/se/policy/domains/program/unused/pppd.te	2004-05-30 16:26:58.000000000 +1000
+++ ./domains/program/unused/pppd.te	2004-07-05 22:55:21.000000000 +1000
@@ -95,4 +95,3 @@
 
 file_type_auto_trans(pppd_t, etc_t, net_conf_t, file)
 tmp_domain(pppd)
-allow pppd_t var_run_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/qmail.te ./domains/program/unused/qmail.te
--- /usr/src/se/policy/domains/program/unused/qmail.te	2004-03-27 00:46:44.000000000 +1100
+++ ./domains/program/unused/qmail.te	2004-08-02 14:20:36.000000000 +1000
@@ -22,7 +22,7 @@
 daemon_sub_domain($1, $2, `$3')
 allow $2_t qmail_etc_t:dir { getattr search };
 allow $2_t qmail_etc_t:{ lnk_file file } { getattr read };
-allow $2_t var_spool_t:dir search;
+allow $2_t { var_t var_spool_t }:dir search;
 allow $2_t console_device_t:chr_file rw_file_perms;
 allow $2_t fs_t:filesystem getattr;
 ')
diff -ru /usr/src/se/policy/domains/program/unused/radius.te ./domains/program/unused/radius.te
--- /usr/src/se/policy/domains/program/unused/radius.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/radius.te	2004-08-03 12:21:33.000000000 +1000
@@ -59,6 +59,9 @@
 ifdef(`snmpd.te', `
 can_tcp_connect(radiusd_t, snmpd_t)
 ')
+ifdef(`logrotate.te', `
+can_exec(radiusd_t, logrotate_exec_t)
+')
 can_udp_send(sysadm_t, radiusd_t)
 can_udp_send(radiusd_t, sysadm_t)
 
diff -ru /usr/src/se/policy/domains/program/unused/rpcd.te ./domains/program/unused/rpcd.te
--- /usr/src/se/policy/domains/program/unused/rpcd.te	2004-08-02 16:59:50.000000000 +1000
+++ ./domains/program/unused/rpcd.te	2004-08-16 20:22:50.000000000 +1000
@@ -30,9 +30,9 @@
 #
 rpc_domain(rpcd)
 var_run_domain(rpcd)
-#can_udp_send({ init_t initrc_t }, rpcd_t)
-#can_udp_send(rpcd_t, { init_t initrc_t })
-#allow init_t rpcd_t:udp_socket write;
+
+# for rpc.rquotad
+allow rpcd_t sysctl_t:dir r_dir_perms;
 
 allow rpcd_t self:unix_dgram_socket create_socket_perms;
 allow rpcd_t self:unix_stream_socket create_socket_perms;
@@ -51,10 +51,12 @@
 allow rpcd_t rpcd_var_run_t:dir { setattr rw_dir_perms };
 r_dir_file(rpcd_t, var_yp_t);
 
-ifdef(`redhat', `
+ifdef(`redhat', `
 allow rpcd_t self:capability { chown dac_override setgid setuid };
 # for /etc/rc.d/init.d/nfs to create /etc/exports
 allow initrc_t exports_t:file rw_file_perms;
+', `
+allow initrc_t exports_t:file r_file_perms;
 ')
 
 allow rpcd_t self:file { getattr read };
@@ -66,10 +68,14 @@
 #can_udp_send(rpcd_t, kernel_t)
 
 rpc_domain(nfsd)
+domain_auto_trans(sysadm_t, nfsd_exec_t, nfsd_t)
+role sysadm_r types nfsd_t;
+
 # for /proc/fs/nfs/exports - should we have a new type?
 allow nfsd_t proc_t:file r_file_perms;
 allow nfsd_t self:unix_dgram_socket create_socket_perms;
 allow nfsd_t self:unix_stream_socket create_stream_socket_perms;
+allow nfsd_t exports_t:file { getattr read };
 
 allow nfsd_t nfsd_fs_t:filesystem mount;
 allow nfsd_t nfsd_fs_t:dir search;
@@ -115,4 +121,3 @@
 # for exportfs and rpc.mountd
 allow nfsd_t tmp_t:dir getattr;
 r_dir_file(rpcd_t, rpc_pipefs_t)
-allow nfsd_t exports_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-08-15 15:45:15.000000000 +1000
+++ ./domains/program/unused/rpm.te	2004-08-14 23:12:02.000000000 +1000
@@ -91,9 +90,9 @@
 general_domain_access(rpm_script_t)
 
 # read/write/create any files in the system
-allow rpm_t { file_type -shadow_t }:{ file lnk_file dir fifo_file sock_file chr_file blk_file } { relabelfrom relabelto };
+allow rpm_t { file_type -shadow_t }:{ file lnk_file dir fifo_file sock_file } { relabelfrom relabelto };
 allow rpm_t { file_type - shadow_t }:dir create_dir_perms;
-allow rpm_t { file_type - shadow_t }:{ file lnk_file fifo_file sock_file chr_file blk_file } create_file_perms;
+allow rpm_t { file_type - shadow_t }:{ file lnk_file fifo_file sock_file } create_file_perms;
 allow rpm_t sysfs_t:filesystem getattr;
 allow rpm_t tmpfs_t:filesystem getattr;
 dontaudit rpm_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
@@ -108,7 +107,7 @@
 can_getsecurity({ rpm_t rpm_script_t })
 dontaudit rpm_t shadow_t:file { getattr read };
 allow rpm_t urandom_device_t:chr_file read;
-allow rpm_script_t { device_t device_type }:{ chr_file blk_file } create_file_perms;
+allow rpm_t { device_t device_type }:{ chr_file blk_file } { create_file_perms relabelfrom relabelto };
 allow rpm_script_t tty_device_t:chr_file getattr;
 allow rpm_script_t devpts_t:dir { search };
 allow rpm_script_t {devpts_t devtty_t}:chr_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/samba.te ./domains/program/unused/samba.te
--- /usr/src/se/policy/domains/program/unused/samba.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/samba.te	2004-08-11 12:15:00.000000000 +1000
@@ -71,6 +71,8 @@
 allow smbd_t var_log_t:dir search;
 allow smbd_t samba_log_t:dir ra_dir_perms;
 
+allow smbd_t usr_t:file { getattr read };
+
 # Access Samba shares.
 allow smbd_t samba_share_t:dir create_dir_perms;
 allow smbd_t samba_share_t:file create_file_perms;
@@ -105,6 +107,8 @@
 allow nmbd_t samba_var_t:dir { write remove_name add_name lock getattr search };
 allow nmbd_t samba_var_t:file { lock unlink create write setattr read getattr rename };
 
+allow nmbd_t usr_t:file { getattr read };
+
 # Permissions to write log files.
 allow nmbd_t samba_log_t:file { create ra_file_perms };
 allow nmbd_t var_log_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/slapd.te ./domains/program/unused/slapd.te
--- /usr/src/se/policy/domains/program/unused/slapd.te	2004-06-17 15:10:40.000000000 +1000
+++ ./domains/program/unused/slapd.te	2004-07-08 23:43:44.000000000 +1000
@@ -33,7 +33,6 @@
 # Use capabilities  should not need kill...
 allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw };
 allow slapd_t self:process setsched;
-allow slapd_t staff_home_dir_t:dir { search };
 
 allow slapd_t proc_t:file r_file_perms;
 
diff -ru /usr/src/se/policy/domains/program/unused/spamd.te ./domains/program/unused/spamd.te
--- /usr/src/se/policy/domains/program/unused/spamd.te	2004-05-12 05:10:41.000000000 +1000
+++ ./domains/program/unused/spamd.te	2004-07-16 12:30:05.000000000 +1000
@@ -40,7 +40,7 @@
 allow spamd_t etc_mail_t:dir { getattr read search };
 allow spamd_t etc_mail_t:file { getattr ioctl read };
 ')
-allow spamd_t { etc_t etc_runtime_t }:file { getattr read };
+allow spamd_t { etc_t etc_runtime_t }:file { getattr ioctl read };
 
 ifdef(`amavis.te', `
 # for bayes tokens
@@ -50,6 +50,7 @@
 
 allow spamd_t sysctl_kernel_t:file { getattr read };
 allow spamd_t usr_t:file { getattr ioctl read };
+allow spamd_t usr_t:lnk_file { getattr read };
 allow spamd_t urandom_device_t:chr_file { getattr read };
 
 system_crond_entry(spamd_exec_t, spamd_t)
diff -ru /usr/src/se/policy/domains/program/unused/squid.te ./domains/program/unused/squid.te
--- /usr/src/se/policy/domains/program/unused/squid.te	2004-07-08 13:09:34.000000000 +1000
+++ ./domains/program/unused/squid.te	2004-07-11 19:26:53.000000000 +1000
@@ -46,8 +46,7 @@
 
 # Grant permissions to create, access, and delete cache files.
 # No type transitions required, as the files inherit the parent directory type.
-allow squid_t squid_cache_t:dir create_dir_perms;
-allow squid_t squid_cache_t:{ file lnk_file } create_file_perms;
+create_dir_file(squid_t, squid_cache_t)
 ifdef(`logrotate.te',
 `domain_auto_trans(logrotate_t, squid_exec_t, squid_t)')
 ifdef(`crond.te', `domain_auto_trans(system_crond_t, squid_exec_t, squid_t)')
diff -ru /usr/src/se/policy/domains/program/unused/sxid.te ./domains/program/unused/sxid.te
--- /usr/src/se/policy/domains/program/unused/sxid.te	2004-02-03 14:20:17.000000000 +1100
+++ ./domains/program/unused/sxid.te	2004-08-09 10:22:42.000000000 +1000
@@ -27,8 +27,9 @@
 
 log_domain(sxid)
 
-allow sxid_t file_type:dir_file_class_set getattr;
-allow sxid_t file_type:dir { read search };
+allow sxid_t file_type:notdevfile_class_set getattr;
+allow sxid_t { device_t device_type }:{ chr_file blk_file } getattr;
+allow sxid_t file_type:dir { getattr read search };
 allow sxid_t sysadmfile:file read;
 allow sxid_t root_dir_type:dir { getattr read search };
 
@@ -37,7 +38,7 @@
 allow sxid_t self:fifo_file rw_file_perms;
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
-allow sxid_t { proc_t self }:file { read getattr };
+allow sxid_t { proc_t self }:{ file lnk_file } { read getattr };
 allow sxid_t { sysctl_kernel_t sysctl_t }:dir search;
 allow sxid_t sysctl_kernel_t:file read;
 allow sxid_t devtty_t:chr_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/udev.te ./domains/program/unused/udev.te
--- /usr/src/se/policy/domains/program/unused/udev.te	2004-08-08 22:16:27.000000000 +1000
+++ ./domains/program/unused/udev.te	2004-08-17 10:55:18.000000000 +1000
@@ -32,10 +32,11 @@
 allow udev_t device_t:blk_file create_file_perms;
 allow udev_t device_t:chr_file create_file_perms;
 allow udev_t device_t:sock_file create_file_perms;
+allow udev_t device_t:lnk_file create_file_perms;
 allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
-allow udev_t { sbin_t bin_t }:lnk_file read;
-can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
+allow udev_t { bin_t sbin_t }:lnk_file read;
+can_exec(udev_t, { shell_exec_t bin_t sbin_t etc_t } )
 can_exec(udev_t, udev_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
diff -ru /usr/src/se/policy/domains/program/unused/uml.te ./domains/program/unused/uml.te
--- /usr/src/se/policy/domains/program/unused/uml.te	2004-03-04 07:53:51.000000000 +1100
+++ ./domains/program/unused/uml.te	2004-08-16 20:11:41.000000000 +1000
@@ -10,4 +10,5 @@
 allow uml_switch_t self:unix_dgram_socket create_socket_perms;
 allow uml_switch_t self:unix_stream_socket create_stream_socket_perms;
 allow uml_switch_t uml_switch_var_run_t:sock_file create_file_perms;
+allow initrc_t uml_switch_var_run_t:sock_file setattr;
 rw_dir_create_file(initrc_t, uml_switch_var_run_t)
diff -ru /usr/src/se/policy/domains/program/unused/updfstab.te ./domains/program/unused/updfstab.te
--- /usr/src/se/policy/domains/program/unused/updfstab.te	2004-03-18 15:36:09.000000000 +1100
+++ ./domains/program/unused/updfstab.te	2004-08-17 13:10:58.000000000 +1000
@@ -3,7 +3,7 @@
 # Author:  Russell Coker <russell@coker.com.au>
 #
 
-daemon_base_domain(updfstab, `, fs_domain, etc_writer')
+daemon_base_domain(updfstab, `, fs_domain, etc_writer, dbus_client_domain')
 
 rw_dir_create_file(updfstab_t, etc_t)
 create_dir_file(updfstab_t, mnt_t)
@@ -37,6 +37,8 @@
 
 allow updfstab_t kernel_t:fd use;
 
+allow updfstab_t self:unix_stream_socket create_stream_socket_perms;
+
 ifdef(`modutil.te', `
 dnl domain_auto_trans(updfstab_t, insmod_exec_t, insmod_t)
 can_exec(updfstab_t, insmod_exec_t)
diff -ru /usr/src/se/policy/domains/program/unused/zebra.te ./domains/program/unused/zebra.te
--- /usr/src/se/policy/domains/program/unused/zebra.te	2004-08-02 16:59:51.000000000 +1000
+++ ./domains/program/unused/zebra.te	2004-07-16 23:19:25.000000000 +1000
@@ -3,17 +3,17 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: zebra
 #
-
 type zebra_port_t, port_type;
+
 daemon_domain(zebra, `, sysctl_net_writer')
 type zebra_conf_t, file_type, sysadmfile;
 r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
 
 can_network(zebra_t)
 allow zebra_t { etc_t etc_runtime_t }:file { getattr read };
-allow zebra_t zebra_port_t:tcp_socket name_bind;
 
-allow zebra_t self:capability { net_admin net_bind_service };
+allow zebra_t self:process setcap;
+allow zebra_t self:capability { setgid setuid net_bind_service net_admin net_raw };
 file_type_auto_trans(zebra_t, var_run_t, zebra_var_run_t, sock_file)
 
 logdir_domain(zebra)
@@ -22,7 +22,11 @@
 type zebra_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(zebra_t, tmp_t, zebra_tmp_t, sock_file)
 
-allow zebra_t self:unix_stream_socket create_stream_socket_perms;
+allow zebra_t self:unix_dgram_socket create_socket_perms;
+allow zebra_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow zebra_t self:rawip_socket create_socket_perms;
+allow zebra_t self:netlink_route_socket r_netlink_socket_perms;
+allow zebra_t zebra_port_t:tcp_socket name_bind;
 
 allow zebra_t proc_t:file { getattr read };
 allow zebra_t { sysctl_t sysctl_net_t }:dir search;
diff -ru /usr/src/se/policy/file_contexts/program/amavis.fc ./file_contexts/program/amavis.fc
--- /usr/src/se/policy/file_contexts/program/amavis.fc	2004-06-17 15:10:42.000000000 +1000
+++ ./file_contexts/program/amavis.fc	2004-07-25 18:54:19.000000000 +1000
@@ -1,6 +1,6 @@
 # amavis
 /usr/sbin/amavisd.*		--	system_u:object_r:amavisd_exec_t
-/etc/amavisd.conf		--	system_u:object_r:amavisd_etc_t
-/var/log/amavisd.log 		--	system_u:object_r:amavisd_log_t
+/etc/amavisd\.conf		--	system_u:object_r:amavisd_etc_t
+/var/log/amavisd\.log 		--	system_u:object_r:amavisd_log_t
 /var/lib/amavis(/.*)?	 		system_u:object_r:amavisd_lib_t
 /var/run/amavis(/.*)?	 		system_u:object_r:amavisd_var_run_t
diff -ru /usr/src/se/policy/file_contexts/program/bootloader.fc ./file_contexts/program/bootloader.fc
--- /usr/src/se/policy/file_contexts/program/bootloader.fc	2004-07-15 10:22:53.000000000 +1000
+++ ./file_contexts/program/bootloader.fc	2004-07-07 21:11:42.000000000 +1000
@@ -10,4 +10,3 @@
 /sbin/ybin.*		--	system_u:object_r:bootloader_exec_t
 /etc/yaboot\.conf.*	--	system_u:object_r:bootloader_etc_t
 /boot/grub/menu.lst	--	system_u:object_r:boot_runtime_t
-/boot/grub/.*           --      system_u:object_r:boot_runtime_t
diff -ru /usr/src/se/policy/file_contexts/program/checkpolicy.fc ./file_contexts/program/checkpolicy.fc
--- /usr/src/se/policy/file_contexts/program/checkpolicy.fc	2004-06-17 15:10:42.000000000 +1000
+++ ./file_contexts/program/checkpolicy.fc	2004-07-13 13:51:11.000000000 +1000
@@ -1,3 +1,4 @@
 # checkpolicy
 /usr/bin/checkpolicy		--	system_u:object_r:checkpolicy_exec_t
+/etc/selinux/policy/policy.* -- system_u:object_r:policy_config_t
 /etc/selinux/.*/src/policy/policy.* -- system_u:object_r:policy_config_t	
diff -ru /usr/src/se/policy/file_contexts/program/clamav.fc ./file_contexts/program/clamav.fc
--- /usr/src/se/policy/file_contexts/program/clamav.fc	2004-06-17 15:10:42.000000000 +1000
+++ ./file_contexts/program/clamav.fc	2004-07-22 00:20:06.000000000 +1000
@@ -8,3 +8,5 @@
 /var/log/clamav-freshclam.log.* -- system_u:object_r:freshclam_log_t
 /var/run/clamd.ctl	-s	system_u:object_r:clamd_var_run_t
 /var/run/clamd.pid	--	system_u:object_r:clamd_var_run_t
+/var/log/clamav(/.*)?		system_u:object_r:freshclam_log_t
+/var/run/clamav(/.*)?		system_u:object_r:clamd_var_run_t
diff -ru /usr/src/se/policy/file_contexts/program/courier.fc ./file_contexts/program/courier.fc
--- /usr/src/se/policy/file_contexts/program/courier.fc	2004-07-13 09:08:03.000000000 +1000
+++ ./file_contexts/program/courier.fc	2004-08-11 15:27:04.000000000 +1000
@@ -9,6 +9,7 @@
 /usr/lib(64)?/courier/imapd		--	system_u:object_r:courier_pop_exec_t
 /usr/lib(64)?/courier/pop3d		--	system_u:object_r:courier_pop_exec_t
 /usr/lib(64)?/courier/sqwebmail/cleancache.pl -- system_u:object_r:sqwebmail_cron_exec_t
+/var/lib/courier(/.*)?			system_u:object_r:courier_var_lib_t
 /usr/bin/imapd			--	system_u:object_r:courier_pop_exec_t
 /usr/sbin/courierlogger		--	system_u:object_r:courier_exec_t
 /usr/sbin/courierldapaliasd	--	system_u:object_r:courier_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/cups.fc ./file_contexts/program/cups.fc
--- /usr/src/se/policy/file_contexts/program/cups.fc	2004-08-02 16:59:52.000000000 +1000
+++ ./file_contexts/program/cups.fc	2004-07-29 16:32:38.000000000 +1000
@@ -10,8 +10,8 @@
 /etc/cups/ppd/.*	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/certs		-d	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/certs/.*	--	system_u:object_r:cupsd_rw_etc_t
-/var/lib/cups/certs     -d      system_u:object_r:cupsd_rw_etc_t
-/var/lib/cups/certs/.*  --      system_u:object_r:cupsd_rw_etc_t
+/var/lib/cups/certs	-d	system_u:object_r:cupsd_rw_etc_t
+/var/lib/cups/certs/.*	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/ppds.dat	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/lpoptions.* 	--	system_u:object_r:cupsd_rw_etc_t
 /etc/printcap.* 	--	system_u:object_r:cupsd_rw_etc_t
diff -ru /usr/src/se/policy/file_contexts/program/dpkg.fc ./file_contexts/program/dpkg.fc
--- /usr/src/se/policy/file_contexts/program/dpkg.fc	2004-07-13 09:08:03.000000000 +1000
+++ ./file_contexts/program/dpkg.fc	2004-07-13 13:47:33.000000000 +1000
@@ -48,3 +48,4 @@
 /usr/share/reportbug/.*	--	system_u:object_r:bin_t
 /etc/network/ifstate.*	--	system_u:object_r:etc_runtime_t
 /usr/lib/gconf2/gconfd-2 --	system_u:object_r:bin_t
+/bin/mountpoint		--	system_u:object_r:fsadm_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/inetd.fc ./file_contexts/program/inetd.fc
--- /usr/src/se/policy/file_contexts/program/inetd.fc	2004-08-02 16:59:52.000000000 +1000
+++ ./file_contexts/program/inetd.fc	2004-07-21 16:59:37.000000000 +1000
@@ -4,14 +4,5 @@
 /usr/sbin/rlinetd	--	system_u:object_r:inetd_exec_t
 /usr/sbin/identd	--	system_u:object_r:inetd_child_exec_t
 /usr/sbin/in\..*d	--	system_u:object_r:inetd_child_exec_t
+/usr/sbin/stunnel	--	system_u:object_r:inetd_child_exec_t
 /var/log/(x)?inetd\.log	--	system_u:object_r:inetd_log_t
-ifdef(`redhat', `
-/usr/sbin/swat		--	system_u:object_r:inetd_child_exec_t
-/usr/sbin/in\.comsat	--	system_u:object_r:inetd_child_exec_t
-/usr/bin/fam		--	system_u:object_r:inetd_child_exec_t
-/usr/sbin/dbskkd-cdb	--	system_u:object_r:inetd_child_exec_t
-/usr/sbin/ipop2d	--	system_u:object_r:inetd_child_exec_t
-/usr/bin/ktalkd		--	system_u:object_r:inetd_child_exec_t
-/usr/sbin/ipop3d	--	system_u:object_r:inetd_child_exec_t
-/usr/bin/rsync		--	system_u:object_r:inetd_child_exec_t
-')
diff -ru /usr/src/se/policy/file_contexts/program/lpd.fc ./file_contexts/program/lpd.fc
--- /usr/src/se/policy/file_contexts/program/lpd.fc	2004-07-15 10:22:53.000000000 +1000
+++ ./file_contexts/program/lpd.fc	2004-08-10 22:12:59.000000000 +1000
@@ -1,13 +1,8 @@
 # lpd
 /dev/printer		-s	system_u:object_r:printer_t
-/dev/lp.*		-c	system_u:object_r:printer_device_t
-/dev/par.*		-c	system_u:object_r:printer_device_t
-/dev/usb/lp.*		-c	system_u:object_r:printer_device_t
-/dev/usblp.*		-c	system_u:object_r:printer_device_t
 /usr/sbin/lpd		--	system_u:object_r:lpd_exec_t
 /usr/sbin/checkpc	--	system_u:object_r:checkpc_exec_t
 /var/spool/lpd(/.*)?		system_u:object_r:print_spool_t
 /usr/share/printconf/.* --	system_u:object_r:printconf_t
 /usr/share/printconf/util/print\.py -- system_u:object_r:bin_t
 /var/run/lprng(/.*)?		system_u:object_r:lpd_var_run_t
-/var/run/lpd.*                 system_u:object_r:lpd_var_run_t
diff -ru /usr/src/se/policy/file_contexts/program/lvm.fc ./file_contexts/program/lvm.fc
--- /usr/src/se/policy/file_contexts/program/lvm.fc	2004-07-13 09:08:04.000000000 +1000
+++ ./file_contexts/program/lvm.fc	2004-08-10 21:58:29.000000000 +1000
@@ -54,7 +54,12 @@
 /sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
+ifdef(`redhat', `
 /usr/bin/cryptsetup	--	system_u:object_r:lvm_exec_t
+')
+ifdef(`debian', `
+/sbin/cryptsetup	--	system_u:object_r:lvm_exec_t
+')
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
 /sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/mailman.fc ./file_contexts/program/mailman.fc
--- /usr/src/se/policy/file_contexts/program/mailman.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/mailman.fc	2004-08-16 20:01:32.000000000 +1000
@@ -1,19 +1,27 @@
 # mailman list server
-/usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
 /var/log/mailman(/.*)?		   system_u:object_r:mailman_log_t
-/usr/lib/mailman/cron/qrunner -- system_u:object_r:mailman_queue_exec_t
-/var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
-/var/lib/mailman/cron	-- system_u:object_r:bin_t
+ifdef(`debian', `
+/usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
+/usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
 /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
+/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
+/usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
+/var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
 /etc/cron\.daily/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /etc/cron\.monthly/mailman 	-- system_u:object_r:mailman_queue_exec_t
+')
+ifdef(`redhat', `
+/var/mailman/cgi-bin/.*		-- system_u:object_r:mailman_cgi_exec_t
 /var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
+/var/mailman/pythonlib(/.*)?	   system_u:object_r:mailman_data_t
+/var/mailman/Mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
-/var/mailman/cron		-- system_u:object_r:bin_t
-/usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
+/var/mailman/cron		-d system_u:object_r:bin_t
+/var/mailman/cron/.+		-- system_u:object_r:mailman_queue_exec_t
 /var/mailman/archives(/.*)?	   system_u:object_r:mailman_archive_t
 /var/mailman/scripts/mailman 	-- system_u:object_r:mailman_mail_exec_t
 /var/mailman/bin/qrunner     	-- system_u:object_r:mailman_queue_exec_t
 /var/mailman/cgi-bin/.* 	-- system_u:object_r:mailman_cgi_exec_t
 /var/mailman/mail/mailman 	-- system_u:object_r:mailman_mail_exec_t
+')
diff -ru /usr/src/se/policy/file_contexts/program/mount.fc ./file_contexts/program/mount.fc
--- /usr/src/se/policy/file_contexts/program/mount.fc	2004-03-27 00:46:44.000000000 +1100
+++ ./file_contexts/program/mount.fc	2004-07-13 13:50:26.000000000 +1000
@@ -1,4 +1,3 @@
 # mount
 /bin/mount.*			--	system_u:object_r:mount_exec_t
-/bin/mountpoint			--	system_u:object_r:bin_t
 /bin/umount.*			--	system_u:object_r:mount_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/mysqld.fc ./file_contexts/program/mysqld.fc
--- /usr/src/se/policy/file_contexts/program/mysqld.fc	2004-07-13 09:08:05.000000000 +1000
+++ ./file_contexts/program/mysqld.fc	2004-08-16 20:13:46.000000000 +1000
@@ -7,3 +7,6 @@
 /var/lib/mysql/mysql.sock -s	system_u:object_r:mysqld_var_run_t
 /etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
 /etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t
+ifdef(`debian', `
+/etc/mysql/debian-start	--	system_u:object_r:bin_t
+')
diff -ru /usr/src/se/policy/file_contexts/program/nsd.fc ./file_contexts/program/nsd.fc
--- /usr/src/se/policy/file_contexts/program/nsd.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/nsd.fc	2004-08-17 08:42:12.000000000 +1000
@@ -2,8 +2,9 @@
 /etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
 /etc/nsd/primary(/.*)?		system_u:object_r:nsd_zone_t
 /etc/nsd/secondary(/.*)?	system_u:object_r:nsd_zone_t
-/etc/nsd/nsd.db		--	system_u:object_r:nsd_zone_t
+/etc/nsd/nsd.db		--	system_u:object_r:nsd_db_t
 /var/lib/nsd(/.*)?		system_u:object_r:nsd_zone_t
+/var/lib/nsd/nsd.db	--	system_u:object_r:nsd_db_t
 /usr/sbin/nsd      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsdc      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsd-notify	--	system_u:object_r:nsd_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/restorecon.fc ./file_contexts/program/restorecon.fc
--- /usr/src/se/policy/file_contexts/program/restorecon.fc	2004-06-17 15:10:43.000000000 +1000
+++ ./file_contexts/program/restorecon.fc	2004-07-05 23:13:43.000000000 +1000
@@ -1,3 +1,2 @@
 # restorecon
-/usr/sbin/restorecon	--	system_u:object_r:restorecon_exec_t
 /sbin/restorecon	--	system_u:object_r:restorecon_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/udev.fc ./file_contexts/program/udev.fc
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-08-02 16:59:52.000000000 +1000
+++ ./file_contexts/program/udev.fc	2004-08-17 13:24:19.000000000 +1000
@@ -2,6 +2,8 @@
 /sbin/udevsend	--	system_u:object_r:udev_exec_t
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
+/usr/bin/udevinfo --	system_u:object_r:udev_exec_t
 /etc/dev.d(/.*)? 	system_u:object_r:udev_helper_exec_t
 /etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
-/dev/\.udev\.tdb	--	system_u:object_r:udev_tbl_t
+/dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
+/dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
diff -ru /usr/src/se/policy/file_contexts/program/updfstab.fc ./file_contexts/program/updfstab.fc
--- /usr/src/se/policy/file_contexts/program/updfstab.fc	2004-01-24 12:15:54.000000000 +1100
+++ ./file_contexts/program/updfstab.fc	2004-08-17 12:42:44.000000000 +1000
@@ -1,2 +1,3 @@
 # updfstab
 /usr/sbin/updfstab	--	system_u:object_r:updfstab_exec_t
+/usr/sbin/fstab-sync	--	system_u:object_r:updfstab_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/webalizer.fc ./file_contexts/program/webalizer.fc
--- /usr/src/se/policy/file_contexts/program/webalizer.fc	2004-08-06 22:23:52.000000000 +1000
+++ ./file_contexts/program/webalizer.fc	2004-08-09 20:05:55.000000000 +1000
@@ -0,0 +1 @@
+#
diff -ru /usr/src/se/policy/file_contexts/program/zebra.fc ./file_contexts/program/zebra.fc
--- /usr/src/se/policy/file_contexts/program/zebra.fc	2004-02-03 03:58:19.000000000 +1100
+++ ./file_contexts/program/zebra.fc	2004-08-08 14:44:35.000000000 +1000
@@ -3,3 +3,5 @@
 /usr/sbin/bgpd		--	system_u:object_r:zebra_exec_t
 /var/log/zebra(/.*)?		system_u:object_r:zebra_log_t
 /etc/zebra(/.*)?		system_u:object_r:zebra_conf_t
+/var/run/.zserv		-s	system_u:object_r:zebra_var_run_t
+/var/run/.zebra		-s	system_u:object_r:zebra_var_run_t
diff -ru /usr/src/se/policy/file_contexts/types.fc ./file_contexts/types.fc
--- /usr/src/se/policy/file_contexts/types.fc	2004-08-15 15:45:16.000000000 +1000
+++ ./file_contexts/types.fc	2004-08-10 17:40:15.000000000 +1000
@@ -136,6 +136,10 @@
 /u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
 /u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
 /u?dev/tty		-c	system_u:object_r:devtty_t
+/dev/lp.*		-c	system_u:object_r:printer_device_t
+/dev/par.*		-c	system_u:object_r:printer_device_t
+/dev/usb/lp.*		-c	system_u:object_r:printer_device_t
+/dev/usblp.*		-c	system_u:object_r:printer_device_t
 /u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
diff -ru /usr/src/se/policy/macros/core_macros.te ./macros/core_macros.te
--- /usr/src/se/policy/macros/core_macros.te	2004-08-15 15:45:18.000000000 +1000
+++ ./macros/core_macros.te	2004-08-10 13:37:44.000000000 +1000
@@ -156,14 +156,14 @@
 define(`create_netlink_socket_perms', `{ create_socket_perms nlmsg_read nlmsg_write }')
 
 #
-# Permissions for using netlink sockets for operations that modify state.
+# Permissions for using netlink sockets for operations that modify state.
 # 
-define(`rw_netlink_socket_perms', `{ rw_socket_perms nlmsg_read nlmsg_write }')
+define(`rw_netlink_socket_perms', `{ create rw_socket_perms nlmsg_read nlmsg_write }')
 
 #
-# Permissions for using netlink sockets for operations that observe state.
+# Permissions for using netlink sockets for operations that observe state.
 # 
-define(`r_netlink_socket_perms', `{ rw_socket_perms nlmsg_read }')
+define(`r_netlink_socket_perms', `{ create rw_socket_perms nlmsg_read }')
 
 #
 # Permissions for sending all signals.
diff -ru /usr/src/se/policy/macros/program/clamav_macros.te ./macros/program/clamav_macros.te
--- /usr/src/se/policy/macros/program/clamav_macros.te	2004-02-03 14:20:17.000000000 +1100
+++ ./macros/program/clamav_macros.te	2004-08-02 01:53:47.000000000 +1000
@@ -10,6 +10,7 @@
 # Define a domain that can access clamd
 #
 define(`can_clamd_connect',`
+allow $1_t clamd_var_run_t:dir search;
 allow $1_t clamd_var_run_t:sock_file { write };
 can_unix_connect($1_t, clamd_t)
 ')
diff -ru /usr/src/se/policy/macros/program/crond_macros.te ./macros/program/crond_macros.te
--- /usr/src/se/policy/macros/program/crond_macros.te	2004-06-17 15:10:45.000000000 +1000
+++ ./macros/program/crond_macros.te	2004-08-02 16:17:02.000000000 +1000
@@ -109,6 +109,8 @@
 dontaudit $1_crond_t boot_t:dir search;
 # quiet other ps operations
 dontaudit $1_crond_t domain:dir { getattr search };
+# for nscd
+dontaudit $1_crond_t var_run_t:dir search;
 ')
 
 # When system_crond_t domain executes a type $1 executable then transition to
diff -ru /usr/src/se/policy/macros/program/gpg_macros.te ./macros/program/gpg_macros.te
--- /usr/src/se/policy/macros/program/gpg_macros.te	2004-08-02 16:59:54.000000000 +1000
+++ ./macros/program/gpg_macros.te	2004-08-01 17:50:06.000000000 +1000
@@ -52,15 +52,13 @@
 allow $1_gpg_t devpts_t:dir search;
 allow $1_gpg_t { $1_devpts_t $1_tty_device_t }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow $1_gpg_t $1_gph_t:fd use;')
-allow $1_gpg_t privfd:fd use;
 
 # Inherit and use descriptors
-allow $1_gpg_t $1_t:fd use;
-allow $1_gpg_t $1_t:process sigchld;
+allow $1_gpg_t { privfd $1_t }:fd use;
 allow { $1_t $1_gpg_t } $1_gpg_t:process signal;
 
-# for ulimit -c 0
-allow $1_gpg_t self:process setrlimit;
+# setrlimit is for ulimit -c 0
+allow $1_gpg_t self:process { setrlimit setcap };
 
 # allow ps to show gpg
 can_ps($1_t, $1_gpg_t)
diff -ru /usr/src/se/policy/net_contexts ./net_contexts
--- /usr/src/se/policy/net_contexts	2004-08-02 16:59:45.000000000 +1000
+++ ./net_contexts	2004-08-06 22:52:57.000000000 +1000
@@ -195,6 +195,7 @@
 portcon tcp 10082 system_u:object_r:amandaidx_port_t
 portcon tcp 10083 system_u:object_r:amidxtape_port_t
 ')
+ifdef(`postgrey.te', `portcon tcp 60000 system_u:object_r:postgrey_port_t')
 
 # Network interfaces (default = initial SID "netif" and "netmsg")
 #
diff -ru /usr/src/se/policy/serviceusers ./serviceusers
--- /usr/src/se/policy/serviceusers	2004-04-16 00:59:52.000000000 +1000
+++ ./serviceusers	2004-07-05 23:41:30.000000000 +1000
@@ -2,5 +2,5 @@
 user cyrus roles cyrus_r;
 ')
 ifdef(`mailman.te', `
-user mailman roles mailman_r;
+#user mailman roles mailman_r;
 ')
diff -ru /usr/src/se/policy/types/device.te ./types/device.te
--- /usr/src/se/policy/types/device.te	2004-08-15 15:45:19.000000000 +1000
+++ ./types/device.te	2004-08-10 17:38:53.000000000 +1000
@@ -60,6 +60,11 @@
 type usbtty_device_t, serial_device, device_type;
 
 #
+# printer_device_t is the type for printer devices
+#
+type printer_device_t, file_type, device_type;
+
+#
 # fixed_disk_device_t is the type of 
 # /dev/hd* and /dev/sd*.
 #

--=-qdyeal/3N8Rny5j6HoWz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
