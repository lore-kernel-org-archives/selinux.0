Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUHt0Ii019396
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 12:55:00 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUHt2oh014755
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 17:55:02 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iAUHverD031125
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 12:57:40 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iAUHve99031124
	for selinux@tycho.nsa.gov; Tue, 30 Nov 2004 12:57:40 -0500
Message-ID: <41ACA2D9.1040503@redhat.com>
Date: Tue, 30 Nov 2004 11:42:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: policy patch
References: <200411260027.41899.russell@coker.com.au>
In-Reply-To: <200411260027.41899.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------000809010203090009060905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000809010203090009060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove root_type_dir totally from package

Change many can_network calls to can_network_server, can_network_client 
or more specific.

Removing alot of code from anaconda.te (It just runs unconfined_t 
anyways, in permissive mode).

Added some proc_net_t fixes.

Cleanup and fixes for kudzu

Minor fixes for postgres

Other minor fixes and some changes to make Targeted policy work...



--------------000809010203090009060905
Content-Type: text/x-patch;
 name="policy-20041130.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20041130.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.19.7/attrib.te
--- nsapolicy/attrib.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/attrib.te	2004-11-30 11:29:15.963154568 -0500
@@ -225,14 +225,6 @@
 # overall filesystem statistics.
 attribute fs_type;
 
-# The root_dir_type attribute identifies all types assigned to 
-# root directories of filesystems (not limited to persistent
-# filesystems).
-# XXX This attribute was used to grant mountassociate permission,
-# XXX but this permission is no longer defined.  We can likely
-# XXX remove this attribute.
-attribute root_dir_type;
-
 # The exec_type attribute identifies all types assigned
 # to entrypoint executables for domains.  This attribute is 
 # used in TE rules and assertions that should be applied to all 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.19.7/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/domains/program/crond.te	2004-11-30 11:28:52.772764771 -0500
@@ -147,7 +147,7 @@
 ')
 
 # Stat any file and search any directory for find.
-allow system_crond_t { root_dir_type file_type fs_type }:notdevfile_class_set getattr;
+allow system_crond_t { file_type fs_type }:notdevfile_class_set getattr;
 allow system_crond_t device_type:{ chr_file blk_file } getattr;
 allow system_crond_t file_type:dir { read search getattr };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.19.7/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.7/domains/program/ldconfig.te	2004-11-30 06:18:45.000000000 -0500
@@ -42,3 +42,4 @@
 allow ldconfig_t { var_lib_t bin_t }:dir search;
 ')
 
+allow ldconfig_t proc_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.19.7/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/modutil.te	2004-11-30 06:18:45.000000000 -0500
@@ -77,7 +77,6 @@
 ifdef(`unlimitedUtils', `
 unconfined_domain(insmod_t) 
 ')
-can_network(insmod_t)
 can_ypbind(insmod_t)
 uses_shlib(insmod_t)
 read_locale(insmod_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.19.7/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/mount.te	2004-11-30 06:18:45.000000000 -0500
@@ -64,7 +64,7 @@
 
 ifdef(`portmap.te', `
 # for nfs
-can_network(mount_t)
+can_network_server(mount_t)
 can_ypbind(mount_t)
 allow mount_t port_t:{ tcp_socket udp_socket } name_bind;
 allow mount_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.19.7/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/domains/program/ssh.te	2004-11-30 06:18:45.000000000 -0500
@@ -68,7 +68,7 @@
 # Read /dev/urandom
 allow $1_t urandom_device_t:chr_file { getattr read };
 
-can_network($1_t)
+can_network_client($1_t)
 
 allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.19.7/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.7/domains/program/syslogd.te	2004-11-30 06:18:45.000000000 -0500
@@ -20,7 +20,7 @@
 ')
 
 # can_network is for the UDP socket
-can_network(syslogd_t)
+can_network_udp(syslogd_t)
 can_ypbind(syslogd_t)
 
 r_dir_file(syslogd_t, sysfs_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.19.7/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/amanda.te	2004-11-30 06:18:45.000000000 -0500
@@ -170,7 +170,7 @@
 # Network and process communication
 ###################################
 
-can_network(amanda_t);
+can_network_server(amanda_t);
 can_ypbind(amanda_t);
 
 allow amanda_t self:fifo_file { getattr read write ioctl lock };
@@ -247,7 +247,7 @@
 # amrecover network and process communication
 #############################################
 
-can_network(amanda_recover_t);
+can_network_server(amanda_recover_t);
 can_ypbind(amanda_recover_t);
 
 allow amanda_recover_t self:fifo_file { getattr ioctl read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.19.7/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/domains/program/unused/anaconda.te	2004-11-30 07:09:53.000000000 -0500
@@ -12,241 +12,36 @@
 #
 type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted;
 role system_r types anaconda_t;
-uses_shlib(anaconda_t);
+unconfined_domain(anaconda_t);
 
-# for halt to down interfaces
-allow anaconda_t self:udp_socket create_socket_perms;
-
-# read files in /etc/init.d
-allow anaconda_t etc_t:lnk_file r_file_perms;
-
-allow anaconda_t self:passwd rootok;
-read_locale(anaconda_t)
-
-r_dir_file(anaconda_t, usr_t)
-
-# Read system information files in /proc.
-allow anaconda_t proc_t:dir r_dir_perms;
-allow anaconda_t proc_t:{ file lnk_file } r_file_perms;
-
-# Allow IPC with self
-allow anaconda_t self:unix_dgram_socket create_socket_perms;
-allow anaconda_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow anaconda_t self:fifo_file rw_file_perms;
-
-# Read the root directory of a usbdevfs filesystem, and
-# the devices and drivers files.  Permit stating of the
-# device nodes, but nothing else.
-allow anaconda_t usbdevfs_t:dir r_dir_perms;
-allow anaconda_t usbdevfs_t:lnk_file r_file_perms;
-allow anaconda_t usbdevfs_t:file getattr;
-
-# allow anaconda to fork and renice itself
-allow anaconda_t self:process { fork sigchld setsched setpgid };
-
-# Can create ptys for open_init_pty
-can_create_pty(anaconda)
-
-tmp_domain(anaconda)
-
-var_run_domain(anaconda)
-allow anaconda_t var_run_t:{ file sock_file lnk_file } unlink;
-allow anaconda_t var_run_t:dir { create rmdir };
-
-allow anaconda_t framebuf_device_t:chr_file r_file_perms;
-
-# Use capabilities.
-allow anaconda_t self:capability ~{ sys_admin sys_module };
-
-# Use system operations.
-allow anaconda_t kernel_t:system *;
-
-# Run helper programs in the anaconda_t domain.
-allow anaconda_t { bin_t sbin_t }:dir r_dir_perms;
-allow anaconda_t { bin_t sbin_t }:lnk_file read;
-can_exec(anaconda_t, etc_t)
-can_exec(anaconda_t, lib_t)
-can_exec(anaconda_t, bin_t)
-can_exec(anaconda_t, sbin_t)
-can_exec(anaconda_t, exec_type)
-#
-#  These rules are here to allow init scripts to su
-#
 role system_r types ldconfig_t;
 domain_auto_trans(anaconda_t, ldconfig_exec_t, ldconfig_t)
 
 role system_r types sysadm_su_t;
 domain_auto_trans(anaconda_t, su_exec_t, sysadm_su_t)
-allow anaconda_t self:passwd rootok;
-
-# read /lib/modules
-allow anaconda_t modules_object_t:dir { search read };
-
-# Read conf.modules.
-allow anaconda_t modules_conf_t:file r_file_perms;
 
 # Run other rc scripts in the anaconda_t domain.
 domain_auto_trans(anaconda_t, initrc_exec_t, initrc_t)
 
-# Run init (telinit) in the anaconda_t domain.
-can_exec(anaconda_t, init_exec_t)
-
-# Communicate with the init process.
-allow anaconda_t initctl_t:fifo_file rw_file_perms;
-
-# Read /proc/PID directories for all domains.
-can_ps(anaconda_t, domain)
-allow anaconda_t domain:process getsession;
-
-# Mount and unmount file systems.
-allow anaconda_t fs_type:filesystem mount_fs_perms;
-allow anaconda_t file_t:dir { read search getattr mounton };
-
-# Update /etc/ld.so.cache.
-allow anaconda_t ld_so_cache_t:file rw_file_perms;
-
-ifdef(`sendmail.te', `
-# Update /etc/mail.
-allow anaconda_t etc_mail_t:file { setattr rw_file_perms };
-')
-
-# Update /var/log/wtmp and /var/log/dmesg.
-allow anaconda_t wtmp_t:file { setattr rw_file_perms };
-allow anaconda_t var_log_t:file { setattr rw_file_perms };
-allow anaconda_t lastlog_t:file { setattr rw_file_perms };
 domain_auto_trans(anaconda_t, dmesg_exec_t, dmesg_t)
 
-# remove old locks
-allow anaconda_t lockfile:dir rw_dir_perms;
-allow anaconda_t lockfile:file { getattr unlink };
-
-# Access /var/lib/random-seed.
-allow anaconda_t var_lib_t:file rw_file_perms;
-allow anaconda_t var_lib_t:file unlink;
-
-# Create lock file.
-allow anaconda_t var_lock_t:dir create_dir_perms;
-allow anaconda_t var_lock_t:file create_file_perms;
-
-# Set the clock.
-allow anaconda_t clock_device_t:devfile_class_set rw_file_perms;
-
-# Kill all processes.
-allow anaconda_t domain:process signal_perms;
-
-# Write to /dev/urandom.
-allow anaconda_t urandom_device_t:chr_file rw_file_perms;
-
-# Set device ownerships/modes.
-allow anaconda_t framebuf_device_t:lnk_file read;
-allow anaconda_t framebuf_device_t:devfile_class_set setattr;
-allow anaconda_t misc_device_t:devfile_class_set setattr;
-allow anaconda_t device_t:devfile_class_set setattr;
-allow anaconda_t fixed_disk_device_t:devfile_class_set setattr;
-allow anaconda_t removable_device_t:devfile_class_set setattr;
-
-# Stat any file.
-allow anaconda_t file_type:file_class_set getattr;
-allow anaconda_t file_type:dir { search getattr };
-
-# Read and write console and ttys.
-allow anaconda_t devtty_t:chr_file rw_file_perms;
-allow anaconda_t console_device_t:chr_file rw_file_perms;
-allow anaconda_t tty_device_t:chr_file rw_file_perms;
-allow anaconda_t ttyfile:chr_file rw_file_perms;
-allow anaconda_t ptyfile:chr_file rw_file_perms;
-
-# Reset tty labels.
-allow anaconda_t ttyfile:chr_file relabelfrom;
-allow anaconda_t tty_device_t:chr_file relabelto;
-
 ifdef(`distro_redhat', `
-# Create and read /boot/kernel.h and /boot/System.map.
-# Redhat systems typically create this file at boot time.
-allow anaconda_t boot_t:lnk_file rw_file_perms;
 file_type_auto_trans(anaconda_t, boot_t, boot_runtime_t, file)
 ')
 
-allow anaconda_t system_map_t:{ file lnk_file } r_file_perms;
-
-# Unlink /halt.
-allow anaconda_t root_t:dir { search write remove_name };
-allow anaconda_t root_t:file { unlink write };
-
-allow anaconda_t var_spool_t:file rw_file_perms;
-
-# Allow access to the sysadm TTYs. Note that this will give access to the 
-# TTYs to any process in the anaconda_t domain. Therefore, daemons and such
-# started from init should be placed in their own domain.
-allow anaconda_t admin_tty_type:chr_file rw_file_perms;
-
-# Access sound device and files.
-allow anaconda_t sound_device_t:chr_file { setattr ioctl read write };
-ifdef(`sound.te', `allow anaconda_t sound_file_t:file { setattr write };')
-
-ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
 # Access /var/lib/rpm.
-allow anaconda_t rpm_var_lib_t:dir rw_dir_perms;
-allow anaconda_t rpm_var_lib_t:file create_file_perms;
 domain_auto_trans(anaconda_t, rpm_exec_t, rpm_t)
 ')
-')
 
-# Update /var/log/ksyms.*.
-# badly named type, /var/log/boot gets the same name too which is confusing
 file_type_auto_trans(anaconda_t, var_log_t, var_log_ksyms_t, file)
 
-ifdef(`apmd.te', `
-# Access /dev/apm_bios.
-allow anaconda_t apm_bios_t:chr_file { setattr getattr };')
-
-ifdef(`lpd.te', `
-# Read printconf files.
-allow anaconda_t printconf_t:dir r_dir_perms;
-allow anaconda_t printconf_t:file r_file_perms;')
-
-# Create and delete /.autofsck
-allow anaconda_t root_t:dir { search write add_name };
-allow anaconda_t root_t:file { create setattr unlink getattr };
-allow anaconda_t file_t:file { unlink getattr };
-
-# Read user home directories.
-allow anaconda_t { home_root_t home_type }:dir r_dir_perms;
-allow anaconda_t home_type:file r_file_perms;
-
-# for system start scripts
-allow anaconda_t pidfile:dir rw_dir_perms;
-allow anaconda_t pidfile:sock_file unlink;
-rw_dir_create_file(anaconda_t, var_lib_t)
-
-# allow start scripts to clean /tmp
-allow anaconda_t { unlabeled_t tmpfile }:dir { rw_dir_perms rmdir };
-allow anaconda_t { unlabeled_t tmpfile }:notdevfile_class_set { getattr unlink };
-
-# for lsof which is used by alsa shutdown
-dontaudit anaconda_t domain:{ udp_socket tcp_socket fifo_file unix_dgram_socket } getattr;
-dontaudit anaconda_t proc_kmsg_t:file getattr;
-
-# Rsync
-dontaudit anaconda_t mail_spool_t:lnk_file read;
-
-allow anaconda_t sysfs_t:dir { getattr read search };
-allow anaconda_t sysfs_t:file { getattr read };
-allow anaconda_t sysfs_t:lnk_file { getattr read };
-allow anaconda_t udev_runtime_t:file rw_file_perms;
-allow anaconda_t device_type:chr_file setattr;
-
-# for lsof in shutdown scripts
-allow anaconda_t security_t:dir getattr;
 ifdef(`udev.te', `
 domain_auto_trans(anaconda_t, udev_exec_t, udev_t)
 ')
-can_kerberos(anaconda_t)
 
 ifdef(`ssh-agent.te', `
 role system_r types sysadm_ssh_agent_t;
 domain_auto_trans(anaconda_t, ssh_agent_exec_t, sysadm_ssh_agent_t)
 ')
 domain_auto_trans(anaconda_t , admin_passwd_exec_t, sysadm_passwd_t)
-unconfined_domain(anaconda_t) 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.19.7/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.7/domains/program/unused/arpwatch.te	2004-11-30 06:18:45.000000000 -0500
@@ -18,7 +18,7 @@
 
 allow arpwatch_t self:capability { net_admin net_raw setgid setuid };
 
-can_network(arpwatch_t)
+can_network_server(arpwatch_t)
 allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
 allow arpwatch_t self:udp_socket create_socket_perms;
 allow arpwatch_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/asterisk.te policy-1.19.7/domains/program/unused/asterisk.te
--- nsapolicy/domains/program/unused/asterisk.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/asterisk.te	2004-11-30 06:18:45.000000000 -0500
@@ -39,7 +39,7 @@
 # are labeled usr_t
 allow asterisk_t usr_t:file r_file_perms;
 
-can_network(asterisk_t)
+can_network_server(asterisk_t)
 can_ypbind(asterisk_t)
 allow asterisk_t etc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/automount.te policy-1.19.7/domains/program/unused/automount.te
--- nsapolicy/domains/program/unused/automount.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/automount.te	2004-11-30 06:18:45.000000000 -0500
@@ -33,7 +33,7 @@
 # because config files can be shell scripts
 can_exec(automount_t, { etc_t automount_etc_t })
 
-can_network(automount_t)
+can_network_server(automount_t)
 can_ypbind(automount_t)
 
 ifdef(`fsadm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/backup.te policy-1.19.7/domains/program/unused/backup.te
--- nsapolicy/domains/program/unused/backup.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/backup.te	2004-11-30 06:18:45.000000000 -0500
@@ -26,7 +26,7 @@
 # for SSP
 allow backup_t urandom_device_t:chr_file read;
 
-can_network(backup_t)
+can_network_server(backup_t)
 can_ypbind(backup_t)
 uses_shlib(backup_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.19.7/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/domains/program/unused/bluetooth.te	2004-11-30 06:18:45.000000000 -0500
@@ -20,7 +20,7 @@
 rw_dir_create_file(bluetooth_t, var_lock_t)
 
 # Use the network.
-can_network(bluetooth_t)
+can_network_server(bluetooth_t)
 can_ypbind(bluetooth_t)
 ifdef(`dbusd.te', `
 dbusd_client(system, bluetooth)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/calamaris.te policy-1.19.7/domains/program/unused/calamaris.te
--- nsapolicy/domains/program/unused/calamaris.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.7/domains/program/unused/calamaris.te	2004-11-30 06:18:45.000000000 -0500
@@ -59,7 +59,7 @@
 allow calamaris_t etc_t:lnk_file read;
 dontaudit calamaris_t etc_t:file ioctl;
 dontaudit calamaris_t sysadm_home_dir_t:dir { getattr search };
-can_network(calamaris_t)
+can_network_server(calamaris_t)
 can_ypbind(calamaris_t)
 ifdef(`named.te', `
 can_udp_send(calamaris_t, named_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.19.7/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.7/domains/program/unused/canna.te	2004-11-30 06:18:45.000000000 -0500
@@ -28,7 +28,7 @@
 
 rw_dir_create_file(canna_t, canna_var_lib_t)
 
-can_network(canna_t)
+can_network_tcp(canna_t)
 can_ypbind(canna_t)
 
 allow userdomain canna_var_run_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ciped.te policy-1.19.7/domains/program/unused/ciped.te
--- nsapolicy/domains/program/unused/ciped.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/ciped.te	2004-11-30 06:18:45.000000000 -0500
@@ -7,7 +7,7 @@
 
 type cipe_port_t, port_type;
 
-can_network(ciped_t)
+can_network_server(ciped_t)
 can_ypbind(ciped_t)
 allow ciped_t cipe_port_t:udp_socket name_bind;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clamav.te policy-1.19.7/domains/program/unused/clamav.te
--- nsapolicy/domains/program/unused/clamav.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/clamav.te	2004-11-30 06:18:45.000000000 -0500
@@ -22,7 +22,7 @@
 allow freshclam_t sysctl_kernel_t:dir search;
 allow freshclam_t sysctl_kernel_t:file { getattr read };
 
-can_network(freshclam_t)
+can_network_server(freshclam_t)
 can_ypbind(freshclam_t)
 
 # Access virus signatures
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/courier.te policy-1.19.7/domains/program/unused/courier.te
--- nsapolicy/domains/program/unused/courier.te	2004-11-18 08:13:57.000000000 -0500
+++ policy-1.19.7/domains/program/unused/courier.te	2004-11-30 06:18:45.000000000 -0500
@@ -46,7 +46,7 @@
 allow courier_$1_t self:capability dac_override;
 
 # Use the network.
-can_network(courier_$1_t)
+can_network_server(courier_$1_t)
 allow courier_$1_t self:fifo_file { read write getattr };
 allow courier_$1_t self:unix_stream_socket create_stream_socket_perms;
 allow courier_$1_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.19.7/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/cups.te	2004-11-30 06:20:21.000000000 -0500
@@ -191,7 +191,7 @@
 rw_dir_create_file(cupsd_config_t, cupsd_etc_t)
 rw_dir_create_file(cupsd_config_t, cupsd_rw_etc_t)
 
-can_network(cupsd_config_t)
+can_network_server_tcp(cupsd_config_t)
 can_tcp_connect(cupsd_config_t, cupsd_t)
 allow cupsd_config_t self:fifo_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dante.te policy-1.19.7/domains/program/unused/dante.te
--- nsapolicy/domains/program/unused/dante.te	2004-11-19 14:25:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/dante.te	2004-11-30 06:18:45.000000000 -0500
@@ -7,7 +7,7 @@
 type socks_port_t, port_type;
 
 daemon_domain(dante)
-can_network(dante_t)
+can_network_server(dante_t)
 
 allow dante_t self:fifo_file { read write };
 allow dante_t self:capability { setuid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddclient.te policy-1.19.7/domains/program/unused/ddclient.te
--- nsapolicy/domains/program/unused/ddclient.te	2004-10-29 14:33:17.000000000 -0400
+++ policy-1.19.7/domains/program/unused/ddclient.te	2004-11-30 06:18:45.000000000 -0500
@@ -29,7 +29,7 @@
 allow ddclient_t sysctl_net_t:dir { search };
 
 # network-related goodies
-can_network(ddclient_t)
+can_network_server(ddclient_t)
 allow ddclient_t self:unix_dgram_socket create_socket_perms;
 
 # allow access to ddclient.conf and ddclient.cache
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddt-client.te policy-1.19.7/domains/program/unused/ddt-client.te
--- nsapolicy/domains/program/unused/ddt-client.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/ddt-client.te	2004-11-30 06:18:45.000000000 -0500
@@ -23,7 +23,7 @@
 file_type_trans(ddt_client_t, var_lib_t, var_lib_ddt_client_t)
 
 # Use the network.
-can_network(ddt_client_t)
+can_network_server(ddt_client_t)
 can_ypbind(ddt_client_t)
 allow ddt_client_t self:unix_stream_socket create_socket_perms;
 allow ddt_client_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/devfsd.te policy-1.19.7/domains/program/unused/devfsd.te
--- nsapolicy/domains/program/unused/devfsd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/devfsd.te	2004-11-30 06:18:45.000000000 -0500
@@ -89,6 +89,5 @@
 allow kernel_t device_t:filesystem mount;
 
 # for nss-ldap etc
-can_network(devfsd_t)
+can_network_client_tcp(devfsd_t)
 can_ypbind(devfsd_t)
-allow devfsd_t self:tcp_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.19.7/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/dhcpc.te	2004-11-30 06:18:45.000000000 -0500
@@ -22,7 +22,7 @@
 # for SSP
 allow dhcpc_t urandom_device_t:chr_file read;
 
-can_network(dhcpc_t)
+can_network_client(dhcpc_t, `{ dhcpc_port_t dhcpd_port_t }')
 can_ypbind(dhcpc_t)
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.19.7/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.7/domains/program/unused/dhcpd.te	2004-11-30 06:18:45.000000000 -0500
@@ -29,7 +29,7 @@
 typealias dhcp_etc_t alias { etc_dhcp_t etc_dhcpc_t etc_dhcpd_t };
 
 # Use the network.
-can_network(dhcpd_t)
+can_network_client(dhcpd_t)
 can_ypbind(dhcpd_t)
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dictd.te policy-1.19.7/domains/program/unused/dictd.te
--- nsapolicy/domains/program/unused/dictd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/dictd.te	2004-11-30 06:18:45.000000000 -0500
@@ -42,7 +42,7 @@
 
 allow dictd_t self:unix_stream_socket create_stream_socket_perms;
 
-can_network(dictd_t)
+can_network_server(dictd_t)
 can_ypbind(dictd_t)
 can_tcp_connect(userdomain, dictd_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/distcc.te policy-1.19.7/domains/program/unused/distcc.te
--- nsapolicy/domains/program/unused/distcc.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.7/domains/program/unused/distcc.te	2004-11-30 06:18:45.000000000 -0500
@@ -4,7 +4,7 @@
 #
 
 daemon_domain(distccd)
-can_network(distccd_t)
+can_network_server(distccd_t)
 can_ypbind(distccd_t)
 log_domain(distccd)
 tmp_domain(distccd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dnsmasq.te policy-1.19.7/domains/program/unused/dnsmasq.te
--- nsapolicy/domains/program/unused/dnsmasq.te	2004-09-29 07:36:46.000000000 -0400
+++ policy-1.19.7/domains/program/unused/dnsmasq.te	2004-11-30 06:18:45.000000000 -0500
@@ -16,7 +16,7 @@
 allow dnsmasq_t urandom_device_t:chr_file read;
 
 # network-related goodies
-can_network(dnsmasq_t)
+can_network_server(dnsmasq_t)
 can_ypbind(dnsmasq_t)
 allow dnsmasq_t self:packet_socket create_socket_perms;
 allow dnsmasq_t self:rawip_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.19.7/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/dovecot.te	2004-11-30 06:21:01.000000000 -0500
@@ -13,7 +13,7 @@
 
 allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
 allow dovecot_t self:process setrlimit;
-can_network(dovecot_t)
+can_network_client_tcp(dovecot_t)
 can_ypbind(dovecot_t)
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dpkg.te policy-1.19.7/domains/program/unused/dpkg.te
--- nsapolicy/domains/program/unused/dpkg.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/dpkg.te	2004-11-30 11:27:40.181935261 -0500
@@ -297,7 +297,7 @@
 allow dpkg_t device_type:{ chr_file blk_file } getattr;
 dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
 allow dpkg_t proc_kmsg_t:file getattr;
-allow dpkg_t root_dir_type:dir getattr;
+allow dpkg_t fs_type:dir getattr;
 
 # allow compiling and loading new policy
 create_dir_file(dpkg_t, { policy_src_t policy_config_t })
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fingerd.te policy-1.19.7/domains/program/unused/fingerd.te
--- nsapolicy/domains/program/unused/fingerd.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.19.7/domains/program/unused/fingerd.te	2004-11-30 06:18:45.000000000 -0500
@@ -47,7 +47,7 @@
 allow fingerd_t { ttyfile ptyfile }:chr_file getattr;
 
 # Use the network.
-can_network(fingerd_t)
+can_network_server(fingerd_t)
 can_ypbind(fingerd_t)
 
 allow fingerd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.19.7/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/firstboot.te	2004-11-30 06:18:45.000000000 -0500
@@ -114,7 +114,7 @@
 allow iptables_t firstboot_t:fd use;
 allow iptables_t firstboot_t:fifo_file write;
 ')
-can_network(firstboot_t)
+can_network_server(firstboot_t)
 can_ypbind(firstboot_t)
 ifdef(`printconf.te', `
 can_exec(firstboot_t, printconf_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gatekeeper.te policy-1.19.7/domains/program/unused/gatekeeper.te
--- nsapolicy/domains/program/unused/gatekeeper.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.7/domains/program/unused/gatekeeper.te	2004-11-30 06:18:45.000000000 -0500
@@ -22,7 +22,7 @@
 logdir_domain(gatekeeper)
 
 # Use the network.
-can_network(gatekeeper_t)
+can_network_server(gatekeeper_t)
 can_ypbind(gatekeeper_t)
 allow gatekeeper_t gatekeeper_port_t:{ udp_socket tcp_socket } name_bind;
 allow gatekeeper_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.19.7/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/hald.te	2004-11-30 06:18:45.000000000 -0500
@@ -33,7 +33,7 @@
 allow hald_t bin_t:file getattr;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
-can_network(hald_t)
+can_network_server(hald_t)
 can_ypbind(hald_t)
 
 allow hald_t device_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.19.7/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/hotplug.te	2004-11-30 11:41:09.943792198 -0500
@@ -149,7 +149,7 @@
 
 file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
 
-can_network(hotplug_t)
+can_network_server(hotplug_t)
 can_ypbind(hotplug_t)
 dbusd_client(system, hotplug)
 
@@ -165,3 +165,4 @@
 unconfined_domain(hotplug_t) 
 ')
 
+ allow kernel_t hotplug_etc_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/howl.te policy-1.19.7/domains/program/unused/howl.te
--- nsapolicy/domains/program/unused/howl.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.19.7/domains/program/unused/howl.te	2004-11-30 06:18:45.000000000 -0500
@@ -5,7 +5,7 @@
 
 daemon_domain(howl)
 allow howl_t proc_t:file { getattr read };
-can_network(howl_t)
+can_network_server(howl_t)
 can_ypbind(howl_t)
 allow howl_t self:capability { kill net_admin };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.19.7/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.19.7/domains/program/unused/i18n_input.te	2004-11-30 06:18:45.000000000 -0500
@@ -9,7 +9,7 @@
 daemon_domain(i18n_input)
 
 can_exec(i18n_input_t, i18n_input_exec_t)
-can_network(i18n_input_t)
+can_network_client(i18n_input_t)
 can_ypbind(i18n_input_t)
 
 can_tcp_connect(userdomain, i18n_input_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/imazesrv.te policy-1.19.7/domains/program/unused/imazesrv.te
--- nsapolicy/domains/program/unused/imazesrv.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/imazesrv.te	2004-11-30 06:18:45.000000000 -0500
@@ -21,7 +21,7 @@
 
 create_append_log_file(imazesrv_t,imazesrv_log_t)
 
-can_network(imazesrv_t)
+can_network_server(imazesrv_t)
 
 allow imazesrv_t self:capability net_bind_service;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.19.7/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.19.7/domains/program/unused/inetd.te	2004-11-30 06:18:45.000000000 -0500
@@ -20,7 +20,8 @@
 
 daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
-can_network(inetd_t)
+can_network_client(inetd_t)
+
 allow inetd_t self:unix_dgram_socket create_socket_perms;
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.19.7/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/ipsec.te	2004-11-30 06:18:45.000000000 -0500
@@ -167,7 +167,7 @@
 allow ipsec_t self:unix_stream_socket {create setopt bind listen accept read write };
 
 # Pluto needs network access
-can_network(ipsec_t)
+can_network_server(ipsec_t)
 can_ypbind(ipsec_t)
 allow ipsec_t self:unix_dgram_socket { create connect write };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iptables.te policy-1.19.7/domains/program/unused/iptables.te
--- nsapolicy/domains/program/unused/iptables.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/iptables.te	2004-11-30 06:18:45.000000000 -0500
@@ -36,7 +36,7 @@
 
 # for iptables -L
 allow iptables_t self:unix_stream_socket create_socket_perms;
-can_network(iptables_t)
+can_network_server(iptables_t)
 can_ypbind(iptables_t)
 
 allow iptables_t bin_t:file { execute execute_no_trans };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ircd.te policy-1.19.7/domains/program/unused/ircd.te
--- nsapolicy/domains/program/unused/ircd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/ircd.te	2004-11-30 06:18:45.000000000 -0500
@@ -23,7 +23,7 @@
 var_lib_domain(ircd)
 
 # Use the network.
-can_network(ircd_t)
+can_network_server(ircd_t)
 can_ypbind(ircd_t)
 #allow ircd_t self:fifo_file { read write };
 allow ircd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/jabberd.te policy-1.19.7/domains/program/unused/jabberd.te
--- nsapolicy/domains/program/unused/jabberd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/jabberd.te	2004-11-30 06:18:45.000000000 -0500
@@ -19,7 +19,7 @@
 # For SSL
 allow jabberd_t random_device_t:file r_file_perms;
 
-can_network(jabberd_t)
+can_network_server(jabberd_t)
 can_ypbind(jabberd_t)
 
 allow jabberd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.19.7/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.7/domains/program/unused/kerberos.te	2004-11-30 06:18:45.000000000 -0500
@@ -16,10 +16,6 @@
 #
 # Rules for the krb5kdc_t,kadmind_t domains.
 #
-type kerberos_port_t, port_type, reserved_port_type;
-type kerberos_admin_port_t, port_type, reserved_port_type;
-type kerberos_master_port_t, port_type;
-
 daemon_domain(krb5kdc)
 daemon_domain(kadmind)
 
@@ -38,7 +34,7 @@
 allow kadmind_t self:capability { setuid setgid net_bind_service chown fowner dac_override sys_nice };
 
 # krb5kdc and kadmind can use network
-can_network( { krb5kdc_t kadmind_t } )
+can_network_server( { krb5kdc_t kadmind_t } )
 can_ypbind( { krb5kdc_t kadmind_t } )
 
 # allow UDP transfer to/from any program
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.19.7/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/kudzu.te	2004-11-30 06:22:11.000000000 -0500
@@ -22,7 +22,8 @@
 allow kudzu_t modules_object_t:dir r_dir_perms;
 allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
 allow kudzu_t mouse_device_t:chr_file { read write };
-allow kudzu_t proc_t:file { getattr read };
+allow kudzu_t proc_net_t:dir r_dir_perms;
+allow kudzu_t { proc_net_t proc_t }:file { getattr read };
 allow kudzu_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
 allow kudzu_t scsi_generic_device_t:chr_file r_file_perms;
 allow kudzu_t { bin_t sbin_t }:dir { getattr search };
@@ -92,4 +93,5 @@
 ifdef(`lpd.te', `
 allow kudzu_t printconf_t:file { getattr read };
 ')
-allow kudzu_t zero_device_t:chr_file r_file_perms;
+allow kudzu_t cupsd_rw_etc_t:dir r_dir_perms;
+dontaudit kudzu_t src_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.19.7/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/lpd.te	2004-11-30 06:18:45.000000000 -0500
@@ -36,7 +36,7 @@
 type checkpc_t, domain, privlog;
 role system_r types checkpc_t;
 uses_shlib(checkpc_t)
-can_network(checkpc_t)
+can_network_server(checkpc_t)
 can_ypbind(checkpc_t)
 log_domain(checkpc)
 type checkpc_exec_t, file_type, sysadmfile, exec_type;
@@ -103,7 +103,7 @@
 allow lpd_t self:capability { setgid setuid net_bind_service dac_read_search dac_override chown fowner };
 
 # Use the network.
-can_network(lpd_t)
+can_network_server(lpd_t)
 can_ypbind(lpd_t)
 allow lpd_t self:fifo_file rw_file_perms;
 allow lpd_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lrrd.te policy-1.19.7/domains/program/unused/lrrd.te
--- nsapolicy/domains/program/unused/lrrd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/lrrd.te	2004-11-30 06:18:45.000000000 -0500
@@ -58,7 +58,7 @@
 can_unix_connect(sysadm_t, lrrd_t)
 can_unix_connect(lrrd_t, lrrd_t)
 can_unix_send(lrrd_t, lrrd_t)
-can_network(lrrd_t)
+can_network_server(lrrd_t)
 can_ypbind(lrrd_t)
 
 ifdef(`logrotate.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/monopd.te policy-1.19.7/domains/program/unused/monopd.te
--- nsapolicy/domains/program/unused/monopd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/monopd.te	2004-11-30 06:18:45.000000000 -0500
@@ -15,7 +15,7 @@
 type share_monopd_t, file_type, sysadmfile;
 
 # Use the network.
-can_network(monopd_t)
+can_network_server(monopd_t)
 can_ypbind(monopd_t)
 
 type monopd_port_t, port_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.19.7/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/mrtg.te	2004-11-30 06:18:45.000000000 -0500
@@ -31,7 +31,7 @@
 r_dir_file(mrtg_t, lib_t)
 
 # Use the network.
-can_network(mrtg_t)
+can_network_server(mrtg_t)
 can_ypbind(mrtg_t)
 
 allow mrtg_t self:fifo_file { getattr read write ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.19.7/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/mysqld.te	2004-11-30 06:18:45.000000000 -0500
@@ -44,7 +44,7 @@
 create_dir_file(mysqld_t, mysqld_db_t)
 allow mysqld_t var_lib_t:dir { getattr search };
 
-can_network(mysqld_t)
+can_network_server(mysqld_t)
 can_ypbind(mysqld_t)
 
 # read config files
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nagios.te policy-1.19.7/domains/program/unused/nagios.te
--- nsapolicy/domains/program/unused/nagios.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/nagios.te	2004-11-30 06:18:45.000000000 -0500
@@ -41,7 +41,7 @@
 
 allow nagios_t proc_t:file { getattr read };
 
-can_network(nagios_t)
+can_network_server(nagios_t)
 can_ypbind(nagios_t)
 
 # read config files
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.19.7/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/named.te	2004-11-30 06:18:45.000000000 -0500
@@ -49,8 +49,9 @@
 allow named_t etc_runtime_t:{ file lnk_file } { getattr read };
 
 #Named can use network
-can_network(named_t)
+can_network_client(named_t)
 can_ypbind(named_t)
+
 # allow UDP transfer to/from any program
 can_udp_send(domain, named_t)
 can_udp_send(named_t, domain)
@@ -100,8 +101,9 @@
 type ndc_exec_t, file_type,sysadmfile, exec_type;
 domain_auto_trans({ sysadm_t initrc_t }, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
-can_network(ndc_t)
+can_network_client_tcp(ndc_t)
 can_ypbind(ndc_t)
+can_resolve(ndc_t)
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nessusd.te policy-1.19.7/domains/program/unused/nessusd.te
--- nsapolicy/domains/program/unused/nessusd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/nessusd.te	2004-11-30 06:18:45.000000000 -0500
@@ -22,7 +22,7 @@
 #tmp_domain(nessusd)
 
 # Use the network.
-can_network(nessusd_t)
+can_network_server(nessusd_t)
 can_ypbind(nessusd_t)
 allow nessusd_t self:unix_stream_socket create_socket_perms;
 #allow nessusd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.19.7/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/nscd.te	2004-11-30 06:18:45.000000000 -0500
@@ -22,7 +22,7 @@
 
 allow nscd_t etc_t:file r_file_perms;
 allow nscd_t etc_t:lnk_file read;
-can_network(nscd_t)
+can_network_client(nscd_t)
 can_ypbind(nscd_t)
 
 file_type_auto_trans(nscd_t, var_run_t, nscd_var_run_t, sock_file)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nsd.te policy-1.19.7/domains/program/unused/nsd.te
--- nsapolicy/domains/program/unused/nsd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/nsd.te	2004-11-30 06:18:45.000000000 -0500
@@ -19,7 +19,7 @@
 type nsd_crond_t, domain, privlog;
 role system_r types nsd_crond_t;
 uses_shlib(nsd_crond_t)
-can_network(nsd_crond_t)
+can_network_server(nsd_crond_t)
 can_ypbind(nsd_crond_t)
 allow nsd_crond_t self:unix_dgram_socket create_socket_perms;
 allow nsd_crond_t self:process { fork signal_perms };
@@ -78,7 +78,7 @@
 allow nsd_t etc_t:{ file lnk_file } { getattr read };
 
 # nsd can use network
-can_network(nsd_t)
+can_network_server(nsd_t)
 can_ypbind(nsd_t)
 # allow client access from caching BIND
 ifdef(`named.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.19.7/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/ntpd.te	2004-11-30 06:18:45.000000000 -0500
@@ -37,7 +37,7 @@
 allow ntpd_t etc_t:file { read getattr };
 
 # Use the network.
-can_network(ntpd_t)
+can_network_client(ntpd_t)
 can_ypbind(ntpd_t)
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/oav-update.te policy-1.19.7/domains/program/unused/oav-update.te
--- nsapolicy/domains/program/unused/oav-update.te	2003-08-14 08:37:36.000000000 -0400
+++ policy-1.19.7/domains/program/unused/oav-update.te	2004-11-30 06:18:45.000000000 -0500
@@ -35,4 +35,4 @@
 allow oav_update_t oav_update_var_lib_t:lnk_file r_file_perms;
 
 # Can download via network
-can_network(oav_update_t)
+can_network_server(oav_update_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/openvpn.te policy-1.19.7/domains/program/unused/openvpn.te
--- nsapolicy/domains/program/unused/openvpn.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/openvpn.te	2004-11-30 06:18:45.000000000 -0500
@@ -24,7 +24,7 @@
 allow openvpn_t self:capability net_admin;
 r_dir_file(openvpn_t, sysctl_net_t)
 
-can_network(openvpn_t)
+can_network_server(openvpn_t)
 allow openvpn_t openvpn_port_t:udp_socket name_bind;
 
 # OpenVPN executes a lot of helper programs and scripts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/perdition.te policy-1.19.7/domains/program/unused/perdition.te
--- nsapolicy/domains/program/unused/perdition.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.19.7/domains/program/unused/perdition.te	2004-11-30 06:18:45.000000000 -0500
@@ -16,7 +16,7 @@
 typealias perdition_etc_t alias etc_perdition_t;
 
 # Use the network.
-can_network(perdition_t)
+can_network_server(perdition_t)
 allow perdition_t self:unix_stream_socket create_socket_perms;
 allow perdition_t self:unix_dgram_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.19.7/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/program/unused/ping.te	2004-11-30 06:18:45.000000000 -0500
@@ -31,7 +31,7 @@
 domain_auto_trans(initrc_t, ping_exec_t, ping_t)
 
 uses_shlib(ping_t)
-can_network(ping_t)
+can_network_client(ping_t)
 can_ypbind(ping_t)
 allow ping_t etc_t:file { getattr read };
 allow ping_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.19.7/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/portmap.te	2004-11-30 06:18:45.000000000 -0500
@@ -13,7 +13,7 @@
 #
 daemon_domain(portmap, `, nscd_client_domain')
 
-can_network(portmap_t)
+can_network_server(portmap_t)
 can_ypbind(portmap_t)
 allow portmap_t self:unix_dgram_socket create_socket_perms;
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portslave.te policy-1.19.7/domains/program/unused/portslave.te
--- nsapolicy/domains/program/unused/portslave.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.19.7/domains/program/unused/portslave.te	2004-11-30 06:18:45.000000000 -0500
@@ -38,7 +38,7 @@
 
 allow portslave_t pppd_secret_t:file r_file_perms;
 
-can_network(portslave_t)
+can_network_server(portslave_t)
 allow portslave_t fs_t:filesystem getattr;
 ifdef(`radius.te', `
 can_udp_send(portslave_t, radiusd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.19.7/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/postfix.te	2004-11-30 06:18:45.000000000 -0500
@@ -117,8 +117,9 @@
 allow postfix_master_t postfix_private_t:dir rw_dir_perms;
 allow postfix_master_t postfix_private_t:sock_file create_file_perms;
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
-can_network(postfix_master_t)
+can_network_client(postfix_master_t)
 can_ypbind(postfix_master_t)
+
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
@@ -156,7 +157,7 @@
 domain_auto_trans(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
 allow postfix_$1_t self:capability { setuid setgid dac_override };
-can_network(postfix_$1_t)
+can_network_client(postfix_$1_t)
 can_ypbind(postfix_$1_t)
 ')
 
@@ -349,6 +350,6 @@
 allow postfix_map_t self:capability setgid;
 allow postfix_map_t self:unix_dgram_socket create_socket_perms;
 dontaudit postfix_map_t var_t:dir search;
-can_network(postfix_map_t)
+can_network_server(postfix_map_t)
 allow postfix_local_t mail_spool_t:dir { remove_name };
 allow postfix_local_t mail_spool_t:file { unlink };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.7/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/postgresql.te	2004-11-30 06:18:45.000000000 -0500
@@ -52,7 +52,7 @@
 file_type_auto_trans(postgresql_t, tmpfs_t, postgresql_tmp_t)
 
 # Use the network.
-can_network(postgresql_t)
+can_network_server(postgresql_t)
 allow postgresql_t self:fifo_file { getattr read write ioctl };
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(postgresql_t, self)
@@ -126,3 +126,6 @@
 dontaudit initrc_su_t sysadm_devpts_t:chr_file rw_file_perms;
 ')
 
+dontaudit postgresql_t home_root_t:dir search;
+can_kerberos(postgresql_t)
+allow postgresql_t urandom_device_t:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgrey.te policy-1.19.7/domains/program/unused/postgrey.te
--- nsapolicy/domains/program/unused/postgrey.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/postgrey.te	2004-11-30 06:24:17.000000000 -0500
@@ -17,7 +17,7 @@
 allow postgrey_t { etc_t etc_runtime_t }:file { getattr read };
 etcdir_domain(postgrey)
 
-can_network(postgrey_t)
+can_network_server_tcp(postgrey_t)
 can_ypbind(postgrey_t)
 allow postgrey_t postgrey_port_t:tcp_socket name_bind;
 allow postgrey_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.19.7/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.19.7/domains/program/unused/pppd.te	2004-11-30 06:18:45.000000000 -0500
@@ -30,7 +30,7 @@
 log_domain(pppd)
 
 # Use the network.
-can_network(pppd_t)
+can_network_server(pppd_t)
 can_ypbind(pppd_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/privoxy.te policy-1.19.7/domains/program/unused/privoxy.te
--- nsapolicy/domains/program/unused/privoxy.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.19.7/domains/program/unused/privoxy.te	2004-11-30 06:18:45.000000000 -0500
@@ -16,7 +16,7 @@
 allow privoxy_t self:capability net_bind_service;
 
 # Use the network.
-can_network(privoxy_t)
+can_network_server(privoxy_t)
 allow privoxy_t port_t:{ tcp_socket udp_socket } name_bind;
 allow privoxy_t etc_t:file { getattr read };
 allow privoxy_t self:capability { setgid setuid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/procmail.te policy-1.19.7/domains/program/unused/procmail.te
--- nsapolicy/domains/program/unused/procmail.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.7/domains/program/unused/procmail.te	2004-11-30 06:18:45.000000000 -0500
@@ -18,7 +18,7 @@
 
 uses_shlib(procmail_t)
 allow procmail_t device_t:dir search;
-can_network(procmail_t)
+can_network_server(procmail_t)
 can_ypbind(procmail_t)
 
 allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/qmail.te policy-1.19.7/domains/program/unused/qmail.te
--- nsapolicy/domains/program/unused/qmail.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/qmail.te	2004-11-30 06:18:45.000000000 -0500
@@ -84,7 +84,7 @@
 
 qmaild_sub_domain(qmail_rspawn_t, qmail_remote)
 allow qmail_rspawn_t qmail_remote_exec_t:file read;
-can_network(qmail_remote_t)
+can_network_server(qmail_remote_t)
 can_ypbind(qmail_remote_t)
 allow qmail_remote_t qmail_spool_t:dir search;
 allow qmail_remote_t qmail_spool_t:file rw_file_perms;
@@ -125,12 +125,12 @@
 allow qmail_tcp_env_t inetd_t:tcp_socket { read write getattr };
 allow qmail_tcp_env_t inetd_t:process sigchld;
 allow qmail_tcp_env_t sbin_t:dir search;
-can_network(qmail_tcp_env_t)
+can_network_server(qmail_tcp_env_t)
 can_ypbind(qmail_tcp_env_t)
 
 qmaild_sub_domain(qmail_tcp_env_t, qmail_smtpd)
 allow qmail_tcp_env_t qmail_smtpd_exec_t:file read;
-can_network(qmail_smtpd_t)
+can_network_server(qmail_smtpd_t)
 can_ypbind(qmail_smtpd_t)
 allow qmail_smtpd_t inetd_t:fd use;
 allow qmail_smtpd_t inetd_t:tcp_socket { read write };
@@ -181,7 +181,7 @@
 
 qmaild_sub_domain(user_crond_t, qmail_serialmail)
 in_user_role(qmail_serialmail_t)
-can_network(qmail_serialmail_t)
+can_network_server(qmail_serialmail_t)
 can_ypbind(qmail_serialmail_t)
 can_exec(qmail_serialmail_t, qmail_serialmail_exec_t)
 allow qmail_serialmail_t self:process { fork signal_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radius.te policy-1.19.7/domains/program/unused/radius.te
--- nsapolicy/domains/program/unused/radius.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/radius.te	2004-11-30 06:18:45.000000000 -0500
@@ -50,7 +50,7 @@
 # gzip also needs chown access to preserve GID for radwtmp files
 allow radiusd_t self:capability { chown dac_override fsetid kill setgid setuid sys_resource sys_tty_config };
 
-can_network(radiusd_t)
+can_network_server(radiusd_t)
 can_ypbind(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radvd.te policy-1.19.7/domains/program/unused/radvd.te
--- nsapolicy/domains/program/unused/radvd.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.7/domains/program/unused/radvd.te	2004-11-30 06:18:45.000000000 -0500
@@ -19,7 +19,7 @@
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
 
-can_network(radvd_t)
+can_network_server(radvd_t)
 
 allow radvd_t proc_t:dir r_dir_perms;
 allow radvd_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.19.7/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/rhgb.te	2004-11-30 06:18:45.000000000 -0500
@@ -39,7 +39,7 @@
 allow rhgb_t self:capability { sys_admin sys_tty_config };
 dontaudit rhgb_t var_run_t:dir search;
 
-can_network(rhgb_t)
+can_network_server(rhgb_t)
 can_ypbind(rhgb_t)
 
 # for fonts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.19.7/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.7/domains/program/unused/rlogind.te	2004-11-30 06:18:45.000000000 -0500
@@ -13,7 +13,7 @@
 type rlogind_t, domain, privlog, auth_chkpwd, privfd;
 role system_r types rlogind_t;
 uses_shlib(rlogind_t)
-can_network(rlogind_t)
+can_network_server(rlogind_t)
 type rlogind_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(inetd_t, rlogind_exec_t, rlogind_t)
 ifdef(`tcpd.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.19.7/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-11-29 10:24:17.000000000 -0500
+++ policy-1.19.7/domains/program/unused/rpcd.te	2004-11-30 06:18:45.000000000 -0500
@@ -12,7 +12,7 @@
 #
 define(`rpc_domain', `
 daemon_base_domain($1)
-can_network($1_t)
+can_network_client($1_t)
 can_ypbind($1_t)
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
@@ -62,7 +62,7 @@
 
 # nfs kernel server needs kernel UDP access.  It is less risky and painful
 # to just give it everything.
-can_network(kernel_t)
+can_network_server(kernel_t)
 #can_udp_send(kernel_t, rpcd_t)
 #can_udp_send(rpcd_t, kernel_t)
 
@@ -125,3 +125,4 @@
 r_dir_file(rpcd_t, rpc_pipefs_t)
 allow rpcd_t rpc_pipefs_t:sock_file { read write };
 dontaudit rpcd_t selinux_config_t:dir { search };
+allow rpcd_t proc_net_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.19.7/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.7/domains/program/unused/rshd.te	2004-11-30 06:18:45.000000000 -0500
@@ -23,7 +23,7 @@
 allow rshd_t self:capability { net_bind_service setuid setgid fowner fsetid chown dac_override};
 
 # Use the network.
-can_network(rshd_t)
+can_network_server(rshd_t)
 can_ypbind(rshd_t)
 
 allow rshd_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.19.7/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.7/domains/program/unused/samba.te	2004-11-30 06:18:45.000000000 -0500
@@ -48,7 +48,7 @@
 allow smbd_t self:capability { setgid setuid sys_resource net_bind_service lease };
 
 # Use the network.
-can_network(smbd_t)
+can_network_server(smbd_t)
 
 allow smbd_t urandom_device_t:chr_file { getattr read };
 
@@ -96,7 +96,7 @@
 allow nmbd_t self:capability net_bind_service;
 
 # Use the network.
-can_network(nmbd_t)
+can_network_server(nmbd_t)
 
 # Permissions for Samba files in /etc/samba
 allow nmbd_t samba_etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/scannerdaemon.te policy-1.19.7/domains/program/unused/scannerdaemon.te
--- nsapolicy/domains/program/unused/scannerdaemon.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.19.7/domains/program/unused/scannerdaemon.te	2004-11-30 06:18:45.000000000 -0500
@@ -12,7 +12,7 @@
 
 #networking
 daemon_domain(scannerdaemon)
-can_network(scannerdaemon_t)
+can_network_server(scannerdaemon_t)
 ifdef(`postfix.te',
 `can_tcp_connect(postfix_bounce_t,scannerdaemon_t);')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.19.7/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/sendmail.te	2004-11-30 06:18:45.000000000 -0500
@@ -25,7 +25,7 @@
 allow sendmail_t self:capability { setuid setgid net_bind_service sys_nice chown sys_tty_config };
 
 # Use the network.
-can_network(sendmail_t)
+can_network_client(sendmail_t)
 can_ypbind(sendmail_t)
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.19.7/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.19.7/domains/program/unused/slapd.te	2004-11-30 06:18:45.000000000 -0500
@@ -23,7 +23,7 @@
 tmp_domain(slapd)
 
 # Use the network.
-can_network(slapd_t)
+can_network_client(slapd_t)
 can_ypbind(slapd_t)
 allow slapd_t self:fifo_file { read write };
 allow slapd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slocate.te policy-1.19.7/domains/program/unused/slocate.te
--- nsapolicy/domains/program/unused/slocate.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/domains/program/unused/slocate.te	2004-11-30 11:25:41.171330546 -0500
@@ -23,9 +23,9 @@
 
 allow locate_t { userpty_type admin_tty_type }:chr_file rw_file_perms;
 
-allow locate_t { root_dir_type file_type }:dir r_dir_perms;
+allow locate_t { fs_type file_type }:dir r_dir_perms;
 allow locate_t file_type:lnk_file r_file_perms;
-allow locate_t { root_dir_type file_type -shadow_t }:{ lnk_file sock_file fifo_file file } getattr;
+allow locate_t { file_type -shadow_t }:{ lnk_file sock_file fifo_file file } getattr;
 dontaudit locate_t { file_type -shadow_t }:{ lnk_file sock_file fifo_file file } read;
 dontaudit locate_t security_t:dir getattr;
 dontaudit locate_t shadow_t:file getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.19.7/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-11-29 10:24:17.000000000 -0500
+++ policy-1.19.7/domains/program/unused/snmpd.te	2004-11-30 06:18:45.000000000 -0500
@@ -13,7 +13,7 @@
 #temp
 allow snmpd_t var_t:dir getattr;
 
-can_network(snmpd_t)
+can_network_client(snmpd_t)
 can_ypbind(snmpd_t)
 
 type snmp_port_t, port_type, reserved_port_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snort.te policy-1.19.7/domains/program/unused/snort.te
--- nsapolicy/domains/program/unused/snort.te	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.19.7/domains/program/unused/snort.te	2004-11-30 06:18:45.000000000 -0500
@@ -9,7 +9,7 @@
 
 logdir_domain(snort)
 allow snort_t snort_log_t:dir create;
-can_network(snort_t)
+can_network_server(snort_t)
 type snort_etc_t, file_type, sysadmfile;
 
 # Create temporary files.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sound-server.te policy-1.19.7/domains/program/unused/sound-server.te
--- nsapolicy/domains/program/unused/sound-server.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.19.7/domains/program/unused/sound-server.te	2004-11-30 06:18:45.000000000 -0500
@@ -24,7 +24,7 @@
 allow soundd_t device_t:lnk_file read;
 
 # Use the network.
-can_network(soundd_t)
+can_network_server(soundd_t)
 allow soundd_t self:unix_stream_socket create_stream_socket_perms;
 allow soundd_t self:unix_dgram_socket create_socket_perms;
 # allow any domain to connect to the sound server
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.19.7/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/domains/program/unused/spamd.te	2004-11-30 06:18:45.000000000 -0500
@@ -23,7 +23,7 @@
 dontaudit spamd_t initrc_var_run_t:file { read write lock };
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
 
-can_network(spamd_t)
+can_network_server(spamd_t)
 allow spamd_t self:capability net_bind_service;
 
 allow spamd_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.19.7/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/squid.te	2004-11-30 06:18:45.000000000 -0500
@@ -62,7 +62,7 @@
 
 # to allow running programs from /usr/lib/squid (IE unlinkd)
 # also allow exec()ing itself
-can_exec(squid_t, { lib_t squid_exec_t bin_t sbin_t } )
+can_exec(squid_t, { lib_t squid_exec_t bin_t sbin_t shell_exec_t } )
 allow squid_t { bin_t sbin_t }:dir search;
 allow squid_t { bin_t sbin_t }:lnk_file read;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sxid.te policy-1.19.7/domains/program/unused/sxid.te
--- nsapolicy/domains/program/unused/sxid.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/sxid.te	2004-11-30 11:28:08.388760430 -0500
@@ -32,10 +32,10 @@
 allow sxid_t ttyfile:chr_file getattr;
 allow sxid_t file_type:dir { getattr read search };
 allow sxid_t sysadmfile:file read;
-allow sxid_t root_dir_type:dir { getattr read search };
+allow sxid_t fs_type:dir { getattr read search };
 
 # Use the network.
-can_network(sxid_t)
+can_network_server(sxid_t)
 allow sxid_t self:fifo_file rw_file_perms;
 allow sxid_t self:unix_stream_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sysstat.te policy-1.19.7/domains/program/unused/sysstat.te
--- nsapolicy/domains/program/unused/sysstat.te	2004-06-16 13:33:36.000000000 -0400
+++ policy-1.19.7/domains/program/unused/sysstat.te	2004-11-30 06:18:45.000000000 -0500
@@ -51,8 +51,8 @@
 allow sysstat_t fs_t:filesystem getattr;
 
 # get info from /proc
-allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:dir r_dir_perms;
-allow sysstat_t { proc_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:file { read getattr };
+allow sysstat_t { proc_t proc_net_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:dir r_dir_perms;
+allow sysstat_t { proc_t proc_net_t sysctl_kernel_t sysctl_t sysctl_fs_t sysctl_rpc_t }:file { read getattr };
 
 domain_auto_trans(initrc_t, sysstat_exec_t, sysstat_t)
 allow sysstat_t init_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tcpd.te policy-1.19.7/domains/program/unused/tcpd.te
--- nsapolicy/domains/program/unused/tcpd.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/tcpd.te	2004-11-30 06:18:45.000000000 -0500
@@ -21,7 +21,7 @@
 # no good reason for this, probably nscd
 dontaudit tcpd_t var_t:dir search;
 
-can_network(tcpd_t)
+can_network_server(tcpd_t)
 can_ypbind(tcpd_t)
 allow tcpd_t self:unix_dgram_socket create_socket_perms;
 allow tcpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tftpd.te policy-1.19.7/domains/program/unused/tftpd.te
--- nsapolicy/domains/program/unused/tftpd.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/domains/program/unused/tftpd.te	2004-11-30 11:17:39.333563985 -0500
@@ -22,7 +22,7 @@
 domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
 
 # Use the network.
-can_network(tftpd_t)
+can_network_udp(tftpd_t)
 allow tftpd_t tftp_port_t:udp_socket name_bind;
 ifdef(`inetd.te', `
 allow inetd_t tftp_port_t:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/timidity.te policy-1.19.7/domains/program/unused/timidity.te
--- nsapolicy/domains/program/unused/timidity.te	2004-10-29 14:33:17.000000000 -0400
+++ policy-1.19.7/domains/program/unused/timidity.te	2004-11-30 06:18:45.000000000 -0500
@@ -5,7 +5,7 @@
 # Note: You only need this policy if you want to run timidity as a server
 
 daemon_base_domain(timidity)
-can_network(timidity_t)
+can_network_server(timidity_t)
 
 allow timidity_t device_t:lnk_file read;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tinydns.te policy-1.19.7/domains/program/unused/tinydns.te
--- nsapolicy/domains/program/unused/tinydns.te	2004-07-07 16:46:41.000000000 -0400
+++ policy-1.19.7/domains/program/unused/tinydns.te	2004-11-30 06:18:45.000000000 -0500
@@ -30,7 +30,7 @@
 allow tinydns_t etc_runtime_t:{ file lnk_file } { getattr read };
 
 #tinydns can use network
-can_network(tinydns_t)
+can_network_server(tinydns_t)
 allow tinydns_t dns_port_t:{ udp_socket tcp_socket } name_bind;
 # allow UDP transfer to/from any program
 can_udp_send(domain, tinydns_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.19.7/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/traceroute.te	2004-11-30 06:18:45.000000000 -0500
@@ -18,7 +18,7 @@
 # for user_ping:
 in_user_role(traceroute_t)
 uses_shlib(traceroute_t)
-can_network(traceroute_t)
+can_network_client(traceroute_t)
 can_ypbind(traceroute_t)
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/transproxy.te policy-1.19.7/domains/program/unused/transproxy.te
--- nsapolicy/domains/program/unused/transproxy.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.19.7/domains/program/unused/transproxy.te	2004-11-30 06:18:45.000000000 -0500
@@ -15,7 +15,7 @@
 type transproxy_port_t, port_type;
 
 # Use the network.
-can_network(transproxy_t)
+can_network_server_tcp(transproxy_t)
 allow transproxy_t transproxy_port_t:tcp_socket name_bind;
 
 #allow transproxy_t self:fifo_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/uwimapd.te policy-1.19.7/domains/program/unused/uwimapd.te
--- nsapolicy/domains/program/unused/uwimapd.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.7/domains/program/unused/uwimapd.te	2004-11-30 06:18:45.000000000 -0500
@@ -8,7 +8,7 @@
 daemon_domain(imapd, `, auth_chkpwd, privhome')
 tmp_domain(imapd)
 
-can_network(imapd_t)
+can_network_server_tcp(imapd_t)
 
 #declare our own services
 allow imapd_t self:capability { dac_override net_bind_service setgid setuid sys_resource };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.19.7/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/domains/program/unused/vpnc.te	2004-11-30 06:18:45.000000000 -0500
@@ -15,7 +15,7 @@
 allow vpnc_t { random_device_t urandom_device_t }:chr_file read;
 
 # Use the network.
-can_network(vpnc_t)
+can_network_client(vpnc_t)
 can_ypbind(vpnc_t)
 allow vpnc_t self:socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/webalizer.te policy-1.19.7/domains/program/unused/webalizer.te
--- nsapolicy/domains/program/unused/webalizer.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/domains/program/unused/webalizer.te	2004-11-30 06:18:45.000000000 -0500
@@ -40,7 +40,7 @@
 allow webalizer_t proc_t:file r_file_perms;
 
 # network
-can_network(webalizer_t)
+can_network_server(webalizer_t)
 
 #process communication inside webalizer itself
 general_domain_access(webalizer_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xprint.te policy-1.19.7/domains/program/unused/xprint.te
--- nsapolicy/domains/program/unused/xprint.te	2004-08-27 16:51:30.000000000 -0400
+++ policy-1.19.7/domains/program/unused/xprint.te	2004-11-30 06:18:45.000000000 -0500
@@ -30,7 +30,7 @@
 ')
 
 # Use the network.
-can_network(xprint_t)
+can_network_server(xprint_t)
 can_ypbind(xprint_t)
 allow xprint_t self:fifo_file rw_file_perms;
 allow xprint_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.19.7/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/domains/program/unused/ypserv.te	2004-11-30 06:28:40.000000000 -0500
@@ -16,8 +16,7 @@
 allow ypserv_t self:capability { net_admin net_bind_service };
 
 # Use the network.
-can_network(ypserv_t)
-allow ypserv_t port_t:{ tcp_socket udp_socket } name_bind;
+can_network_server(ypserv_t)
 
 allow ypserv_t self:fifo_file rw_file_perms;
 
@@ -39,5 +38,5 @@
 ifdef(`rpcd.te', `
 allow rpcd_t ypserv_conf_t:file { getattr read };
 ')
-allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
+allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } name_bind;
 dontaudit ypserv_t reserved_port_type:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/zebra.te policy-1.19.7/domains/program/unused/zebra.te
--- nsapolicy/domains/program/unused/zebra.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.19.7/domains/program/unused/zebra.te	2004-11-30 06:18:45.000000000 -0500
@@ -9,7 +9,7 @@
 type zebra_conf_t, file_type, sysadmfile;
 r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
 
-can_network(zebra_t)
+can_network_server(zebra_t)
 can_ypbind(zebra_t)
 allow zebra_t { etc_t etc_runtime_t }:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.19.7/domains/user.te
--- nsapolicy/domains/user.te	2004-11-30 05:59:38.000000000 -0500
+++ policy-1.19.7/domains/user.te	2004-11-30 06:29:22.000000000 -0500
@@ -55,6 +55,7 @@
 # Reach sysadm_t via programs like userhelper/sudo/su
 undefine(`reach_sysadm')
 define(`reach_sysadm', `
+ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`sudo.te', `sudo_domain($1)')
 ifdef(`su.te', `
 su_domain($1)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/hotplug.fc policy-1.19.7/file_contexts/program/hotplug.fc
--- nsapolicy/file_contexts/program/hotplug.fc	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.7/file_contexts/program/hotplug.fc	2004-11-30 11:40:10.595472171 -0500
@@ -10,3 +10,4 @@
 /etc/hotplug/hotplug\.functions --	system_u:object_r:sbin_t
 /var/run/usb(/.*)?		system_u:object_r:hotplug_var_run_t
 /var/run/hotplug(/.*)?		system_u:object_r:hotplug_var_run_t
+/etc/hotplug/firmware.agent	--	system_u:object_r:hotplug_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/sendmail.fc policy-1.19.7/file_contexts/program/sendmail.fc
--- nsapolicy/file_contexts/program/sendmail.fc	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/file_contexts/program/sendmail.fc	2004-11-30 06:18:45.000000000 -0500
@@ -1,6 +1,5 @@
 # sendmail
 /etc/mail(/.*)?				system_u:object_r:etc_mail_t
-/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
 /var/run/sendmail\.pid		--	system_u:object_r:sendmail_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.7/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/file_contexts/types.fc	2004-11-30 06:18:45.000000000 -0500
@@ -334,9 +334,6 @@
 /usr(/.*)?			system_u:object_r:usr_t
 /usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
 /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
-/usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
 /usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
@@ -399,6 +396,7 @@
 #
 /var/spool(/.*)?		system_u:object_r:var_spool_t
 /var/spool/texmf(/.*)?		system_u:object_r:tetex_data_t
+/var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 
 # 
 # /var/log
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.19.7/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/macros/admin_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -33,6 +33,7 @@
 allow $1_t self:capability setuid;
 
 ifdef(`su.te', `su_domain($1)')
+ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`sudo.te', `sudo_domain($1)')
 
 # Violates the goal of limiting write access to checkpolicy.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.19.7/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/macros/base_user_macros.te	2004-11-30 11:26:55.861923717 -0500
@@ -43,7 +43,7 @@
 # for eject
 allow $1_t fixed_disk_device_t:blk_file getattr;
 
-allow $1_t root_dir_type:dir { getattr };
+allow $1_t fs_type:dir { getattr };
 
 # open office is looking for the following
 allow $1_t dri_device_t:chr_file getattr;
@@ -160,7 +160,6 @@
 
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`tvtime.te', `tvtime_domain($1)')
-ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
@@ -207,7 +206,7 @@
 # Grant permissions to access the system DBus
 ifdef(`dbusd.te', `
 dbusd_client(system, $1)
-can_network($1_dbusd_t)
+can_network_server_tcp($1_dbusd_t)
 allow $1_dbusd_t reserved_port_t:tcp_socket name_bind;
 
 allow $1_t system_dbusd_t:dbus { send_msg acquire_svc };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.19.7/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/macros/program/games_domain.te	2004-11-30 06:18:45.000000000 -0500
@@ -46,5 +46,13 @@
 allow $1_games_t event_device_t:chr_file getattr;
 allow $1_games_t mouse_device_t:chr_file getattr;
 allow $1_games_t self:file { getattr read };
+
+# kpat spews errors
+dontaudit $1_games_t bin_t:dir getattr;
+dontaudit $1_games_t var_run_t:dir search;
+ifdef(`xdm.te', `
+dontaudit $1_games_t xdm_xserver_tmp_t:dir getattr;
+')
+
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gph_macros.te policy-1.19.7/macros/program/gph_macros.te
--- nsapolicy/macros/program/gph_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/macros/program/gph_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -55,7 +55,7 @@
 allow $1_t $1_gph_t:fd use;
 
 # Use the network, e.g. for NIS lookups.
-can_network($1_gph_t)
+can_resolve($1_gph_t)
 can_ypbind($1_gph_t)
 
 allow $1_gph_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.19.7/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/macros/program/inetd_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -14,7 +14,7 @@
 domain_auto_trans(inetd_t, $1_exec_t, $1_t)
 allow inetd_t $1_t:process sigkill;
 
-can_network($1_t)
+can_network_server($1_t)
 can_ypbind($1_t)
 uses_shlib($1_t)
 allow $1_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.19.7/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.7/macros/program/irc_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -47,7 +47,7 @@
 allow $1_t $1_irc_t:process signal;
 
 # Use the network.
-can_network($1_irc_t)
+can_network_client($1_irc_t)
 can_ypbind($1_irc_t)
 
 allow $1_irc_t usr_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/kerberos_macros.te policy-1.19.7/macros/program/kerberos_macros.te
--- nsapolicy/macros/program/kerberos_macros.te	2004-11-29 10:24:17.000000000 -0500
+++ policy-1.19.7/macros/program/kerberos_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -3,8 +3,8 @@
 if (allow_kerberos) {
 can_network_client($1, `kerberos_port_t')
 can_resolve($1)
-dontaudit $1 krb5_conf_t:file write;
-allow $1 krb5_conf_t:file { getattr read };
 }
 ') dnl kerberos.te
+dontaudit $1 krb5_conf_t:file write;
+allow $1 krb5_conf_t:file { getattr read };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.19.7/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/macros/program/lpr_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -34,7 +34,7 @@
 role $1_r types $1_lpr_t;
 
 # This domain is granted permissions common to most domains (including can_net)
-can_network($1_lpr_t)
+can_network_client($1_lpr_t)
 can_ypbind($1_lpr_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.7/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.7/macros/program/mozilla_macros.te	2004-11-30 06:19:08.000000000 -0500
@@ -48,6 +48,7 @@
 allow $1_mozilla_t device_t:dir r_dir_perms;
 allow $1_mozilla_t devpts_t:dir r_dir_perms;
 allow $1_mozilla_t proc_t:file { getattr read };
+r_dir_file($1_mozilla_t, proc_net_t)
 dontaudit $1_mozilla_t tty_device_t:chr_file getattr;
 
 dontaudit $1_mozilla_t proc_t:dir read;
@@ -115,6 +116,20 @@
 dontaudit $1_mozilla_t file_type:dir getattr;
 allow $1_mozilla_t self:sem create_sem_perms;
 
+ifdef(`userhelper.te', `
+domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
+')
+dontaudit $1_mozilla_t selinux_config_t:dir search;
+
+#
+# Rules needed to run java apps
+#
+allow $1_mozilla_t ld_so_cache_t:file execute;
+allow $1_mozilla_t locale_t:file execute;
+dontaudit $1_mozilla_t *:{ chr_file file } execute;
+dontaudit $1_t ld_so_cache_t:file execute;
+dontaudit $1_t locale_t:file execute;
+
 dontaudit $1_mozilla_t selinux_config_t:dir search;
 
 ifdef(`xdm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.19.7/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.7/macros/program/mta_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -33,7 +33,7 @@
 role $1_r types $1_mail_t;
 
 uses_shlib($1_mail_t)
-can_network($1_mail_t)
+can_network_client_tcp($1_mail_t)
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/slocate_macros.te policy-1.19.7/macros/program/slocate_macros.te
--- nsapolicy/macros/program/slocate_macros.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.7/macros/program/slocate_macros.te	2004-11-30 11:26:11.101961692 -0500
@@ -57,8 +57,8 @@
 
 base_file_read_access($1_locate_t)
 r_dir_file($1_locate_t, { etc_t lib_t var_t })
-dontaudit $1_locate_t { root_dir_type file_type }:dir r_dir_perms;
-dontaudit $1_locate_t { root_dir_type file_type -shadow_t}:file { getattr read };
+dontaudit $1_locate_t { fs_type file_type }:dir r_dir_perms;
+dontaudit $1_locate_t { fs_type file_type -shadow_t}:file { getattr read };
 ')
 
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.19.7/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.7/macros/program/ssh_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -82,7 +82,7 @@
 
 # Grant permissions needed to create TCP and UDP sockets and
 # to access the network.
-can_network($1_ssh_t)
+can_network_client_tcp($1_ssh_t)
 can_ypbind($1_ssh_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.19.7/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.7/macros/program/userhelper_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -140,4 +140,8 @@
 allow $1_userhelper_t pam_var_console_t:dir { search };
 ')
 
+ifdef(`mozilla.te', `
+domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
+')
+
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.19.7/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.7/macros/program/xauth_macros.te	2004-11-30 06:18:45.000000000 -0500
@@ -54,7 +54,7 @@
 uses_shlib($1_xauth_t)
 
 # allow DNS lookups...
-can_network($1_xauth_t)
+can_resolve($1_xauth_t)
 can_ypbind($1_xauth_t)
 ifdef(`named.te', `
 can_udp_send($1_xauth_t, named_t)
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.19.7/net_contexts
--- nsapolicy/net_contexts	2004-11-09 13:35:11.000000000 -0500
+++ policy-1.19.7/net_contexts	2004-11-30 06:18:45.000000000 -0500
@@ -113,7 +113,6 @@
 portcon tcp 631 system_u:object_r:ipp_port_t
 portcon udp 631 system_u:object_r:ipp_port_t
 ')
-ifdef(`kerberos.te', `
 portcon tcp 88 system_u:object_r:kerberos_port_t
 portcon udp 88 system_u:object_r:kerberos_port_t
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
@@ -121,7 +120,6 @@
 portcon udp 750 system_u:object_r:kerberos_port_t
 portcon tcp 4444 system_u:object_r:kerberos_master_port_t
 portcon udp 4444 system_u:object_r:kerberos_master_port_t
-')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
 ifdef(`rsync.te', `
 portcon tcp 873 system_u:object_r:rsync_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.7/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.7/tunables/distro.tun	2004-11-30 06:18:45.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.7/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/tunables/tunable.tun	2004-11-30 06:31:15.000000000 -0500
@@ -2,10 +2,10 @@
 dnl define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
@@ -17,11 +17,11 @@
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/devpts.te policy-1.19.7/types/devpts.te
--- nsapolicy/types/devpts.te	2004-09-22 16:19:14.000000000 -0400
+++ policy-1.19.7/types/devpts.te	2004-11-30 11:31:48.561978748 -0500
@@ -16,6 +16,6 @@
 # devpts_t is the type of the devpts file system and 
 # the type of the root directory of the file system.
 #
-type devpts_t, fs_type, root_dir_type;
+type devpts_t, fs_type;
 
 
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.19.7/types/file.te
--- nsapolicy/types/file.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.7/types/file.te	2004-11-30 11:31:55.151237091 -0500
@@ -33,12 +33,12 @@
 # assigned an extended attribute (EA) value (when using a filesystem
 # that supports EAs).
 #
-type file_t, file_type, root_dir_type, sysadmfile;
+type file_t, file_type, sysadmfile;
 
 # default_t is the default type for files that do not
 # match any specification in the file_contexts configuration
 # other than the generic /.* specification.
-type default_t, file_type, root_dir_type, sysadmfile;
+type default_t, file_type, sysadmfile;
 
 #
 # root_t is the type for the root directory.
@@ -64,7 +64,7 @@
 # boot_t is the type for files in /boot,
 # including the kernel.
 #
-type boot_t, file_type, root_dir_type, sysadmfile;
+type boot_t, file_type, sysadmfile;
 # system_map_t is for the system.map files in /boot
 type system_map_t, file_type, sysadmfile;
 
@@ -157,7 +157,7 @@
 #
 # usr_t is the type for /usr.
 #
-type usr_t, file_type, root_dir_type, sysadmfile;
+type usr_t, file_type, sysadmfile;
 
 #
 # src_t is the type of files in the system src directories.
@@ -167,7 +167,7 @@
 #
 # var_t is the type for /var.
 #
-type var_t, file_type, root_dir_type, sysadmfile;
+type var_t, file_type,  sysadmfile;
 
 #
 # Types for subdirectories of /var.
@@ -264,28 +264,28 @@
 # Allow the pty to be associated with the file system.
 allow devpts_t self:filesystem associate;
 
-type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
+type tmpfs_t, file_type, sysadmfile, fs_type;
 allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
 
-type autofs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
+type autofs_t, fs_type, noexattrfile, sysadmfile;
 allow autofs_t self:filesystem associate;
 
-type usbdevfs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
+type usbdevfs_t, fs_type, noexattrfile, sysadmfile;
 allow usbdevfs_t self:filesystem associate;
 
-type sysfs_t, fs_type, root_dir_type, sysadmfile;
+type sysfs_t, fs_type,  sysadmfile;
 allow sysfs_t self:filesystem associate;
 
-type iso9660_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
+type iso9660_t, fs_type, noexattrfile, sysadmfile;
 allow iso9660_t self:filesystem associate;
 
-type romfs_t, fs_type, root_dir_type, sysadmfile;
+type romfs_t, fs_type, sysadmfile;
 allow romfs_t self:filesystem associate;
 
-type ramfs_t, fs_type, root_dir_type, sysadmfile;
+type ramfs_t, fs_type, sysadmfile;
 allow ramfs_t self:filesystem associate;
 
-type dosfs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
+type dosfs_t, fs_type, noexattrfile, sysadmfile;
 allow dosfs_t self:filesystem associate;
 
 # udev_runtime_t is the type of the udev table file
@@ -294,7 +294,7 @@
 # krb5_conf_t is the type of the /etc/krb5.conf file
 type krb5_conf_t, file_type, sysadmfile;
 
-type cifs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
+type cifs_t, fs_type, noexattrfile, sysadmfile;
 allow cifs_t self:filesystem associate;
 typealias cifs_t alias sambafs_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.19.7/types/network.te
--- nsapolicy/types/network.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.7/types/network.te	2004-11-30 06:18:45.000000000 -0500
@@ -64,6 +64,13 @@
 type mail_port_t, port_type;
 
 #
+# Ports used to communicate with kerberos server
+#
+type kerberos_port_t, port_type, reserved_port_type;
+type kerberos_admin_port_t, port_type, reserved_port_type;
+type kerberos_master_port_t, port_type;
+
+#
 # port_t is the default type of INET port numbers.
 # The *_port_t types are used for specific port
 # numbers in net_contexts or net_contexts.mls.
diff --exclude-from=exclude -N -u -r nsapolicy/types/nfs.te policy-1.19.7/types/nfs.te
--- nsapolicy/types/nfs.te	2004-09-22 16:19:14.000000000 -0400
+++ policy-1.19.7/types/nfs.te	2004-11-30 11:31:36.421345241 -0500
@@ -13,7 +13,7 @@
 # The nfs_*_t types are used for specific NFS
 # servers in net_contexts or net_contexts.mls.
 #
-type nfs_t, fs_type, root_dir_type;
+type nfs_t, fs_type;
 
 #
 # Allow NFS files to be associated with an NFS file system.
diff --exclude-from=exclude -N -u -r nsapolicy/types/procfs.te policy-1.19.7/types/procfs.te
--- nsapolicy/types/procfs.te	2004-11-29 10:24:18.000000000 -0500
+++ policy-1.19.7/types/procfs.te	2004-11-30 11:32:00.668616080 -0500
@@ -14,7 +14,7 @@
 # proc_mdstat_t is the type of /proc/mdstat.
 # proc_net_t is the type of /proc/net.
 #
-type proc_t, fs_type, proc_fs, root_dir_type;
+type proc_t, fs_type, proc_fs;
 type proc_kmsg_t, proc_fs;
 type proc_kcore_t, proc_fs;
 type proc_mdstat_t, proc_fs;

--------------000809010203090009060905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
