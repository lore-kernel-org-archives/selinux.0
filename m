Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8RHQErT003018
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 13:26:15 -0400 (EDT)
Message-ID: <41584D2F.5020902@redhat.com>
Date: Mon, 27 Sep 2004 13:26:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch for strict policy
References: <41542FF5.2090502@redhat.com> <1096303384.3234.7.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1096303384.3234.7.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000706000906080301050902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000706000906080301050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Carter wrote:

>Shouldn't there be a ktalkd.te?  I don't think ktalkd_exec_t is defined
>anywhere.
>
>On Fri, 2004-09-24 at 10:32, Daniel J Walsh wrote:
>  
>
>>Added policy templates for swat, ktalkd, in.comcast, and rsyn daemons to 
>>be run by xinetd.
>>Separated out inetd_child_t context into a macro.
>>Mailman fixes
>>
>>______________________________________________________________________
>>diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ktalkd.fc policy-1.17.20/file_contexts/program/ktalkd.fc
>>--- nsapolicy/file_contexts/program/ktalkd.fc	1969-12-31 19:00:00.000000000 -0500
>>+++ policy-1.17.20/file_contexts/program/ktalkd.fc	2004-09-24 10:05:50.845362460 -0400
>>@@ -0,0 +1,2 @@
>>+# kde talk daemon 
>>+/usr/bin/ktalkd	--	system_u:object_r:ktalkd_exec_t
>>    
>>
>
>  
>
Oops, yes here is a new patch including ktalkd, some of russells fixes.

--------------000706000906080301050902
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/misc/screensaver.te policy-1.17.22/domains/misc/screensaver.te
--- nsapolicy/domains/misc/screensaver.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/misc/screensaver.te	2004-09-27 10:19:13.000000000 -0400
@@ -0,0 +1,18 @@
+#
+# Alias file to stop blow up during policy upgrade, since 
+# screensaver policy is being removed.
+#
+typealias bin_t alias screensaver_exec_t;
+typealias sysadm_home_t alias sysadm_screensaver_t;
+typealias sysadm_home_t alias sysadm_screensaver_rw_t;
+typealias sysadm_home_t alias sysadm_screensaver_ro_t;
+typealias sysadm_home_t alias sysadm_screensaver_tmpfs_t;
+typealias user_home_t alias user_screensaver_t;
+typealias user_home_t alias user_screensaver_rw_t;
+typealias user_home_t alias user_screensaver_ro_t;
+typealias user_home_t alias user_screensaver_tmpfs_t;
+typealias staff_home_t alias staff_screensaver_t;
+typealias staff_home_t alias staff_screensaver_rw_t;
+typealias staff_home_t alias staff_screensaver_ro_t;
+typealias staff_home_t alias staff_screensaver_tmpfs_t;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.22/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-09-20 15:40:58.000000000 -0400
+++ policy-1.17.22/domains/program/initrc.te	2004-09-27 10:16:53.000000000 -0400
@@ -48,6 +48,8 @@
 allow initrc_t usbdevfs_t:dir r_dir_perms;
 allow initrc_t usbdevfs_t:lnk_file r_file_perms;
 allow initrc_t usbdevfs_t:file getattr;
+allow initrc_t usbfs_t:dir r_dir_perms;
+allow initrc_t usbfs_t:file getattr;
 
 # allow initrc to fork and renice itself
 allow initrc_t self:process { fork sigchld setsched setpgid setrlimit };
@@ -199,6 +201,9 @@
 allow initrc_t boot_t:lnk_file rw_file_perms;
 file_type_auto_trans(initrc_t, boot_t, boot_runtime_t, file)
 
+allow initrc_t tmpfs_t:chr_file rw_file_perms;
+allow initrc_t tmpfs_t:dir r_dir_perms;
+
 #
 # readahead asks for these
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.22/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-09-13 15:58:18.000000000 -0400
+++ policy-1.17.22/domains/program/mount.te	2004-09-27 10:16:53.000000000 -0400
@@ -97,6 +97,6 @@
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
-dontaudit mount_t tmpfs_t:chr_file { read write };
+allow mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir { mounton };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.17.22/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2004-09-13 15:58:18.000000000 -0400
+++ policy-1.17.22/domains/program/unused/cardmgr.te	2004-09-27 10:16:53.000000000 -0400
@@ -23,7 +23,7 @@
 allow cardmgr_t home_root_t:dir search;
 
 # Use capabilities (net_admin for route), setuid for cardctl
-allow cardmgr_t self:capability { dac_override setuid net_admin sys_admin sys_nice sys_tty_config mknod };
+allow cardmgr_t self:capability { dac_read_search dac_override setuid net_admin sys_admin sys_nice sys_tty_config mknod };
 
 # for /etc/resolv.conf
 file_type_auto_trans(cardmgr_t, etc_t, net_conf_t, file)
@@ -78,7 +78,7 @@
 domain_auto_trans(apmd_t, { cardctl_exec_t cardmgr_exec_t }, cardmgr_t)
 ')
 
-ifdef(`hide_broken_symptoms', `', `
+ifdef(`hide_broken_symptoms', `
 dontaudit insmod_t cardmgr_dev_t:chr_file { read write };
 dontaudit ifconfig_t cardmgr_dev_t:chr_file { read write };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.22/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/program/unused/comsat.te	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,14 @@
+#DESC comsat - biff server
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the comsat_t domain.
+#
+# comsat_exec_t is the type of the comsat executable.
+#
+
+type comsat_port_t, port_type;
+inetd_child_domain(comsat)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.22/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.22/domains/program/unused/consoletype.te	2004-09-27 10:16:53.000000000 -0400
@@ -54,3 +54,6 @@
 ifdef(`distro_redhat', `
 allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
 ')
+allow consoletype_t firstboot_t:fifo_file { write };
+dontaudit consoletype_t proc_t:file { read };
+dontaudit consoletype_t root_t:file { read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.22/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.22/domains/program/unused/cups.te	2004-09-27 11:04:53.179361344 -0400
@@ -31,7 +31,6 @@
 allow cupsd_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t urandom_device_t:chr_file { getattr read };
 dontaudit cupsd_t random_device_t:chr_file ioctl;
-dontaudit cupsd_t device_t:lnk_file { read }; 
 
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
@@ -156,6 +155,7 @@
 allow ptal_t printer_device_t:chr_file { ioctl read write };
 allow ptal_t { etc_t etc_runtime_t }:file { getattr read };
 r_dir_file(ptal_t, usbdevfs_t)
+r_dir_file(ptal_t, usbfs_t)
 allow cupsd_t ptal_var_run_t:sock_file { write setattr };
 allow cupsd_t ptal_t:unix_stream_socket { connectto };
 allow cupsd_t ptal_var_run_t:dir { search };
@@ -167,4 +167,8 @@
 ifdef(`hald.te', `
 allow cupsd_t hald_t:dbus { send_msg };
 allow hald_t cupsd_t:dbus { send_msg };
+allow hald_t cupsd_etc_t:dir search;
+allow hald_t printconf_t:file { getattr read };
+domain_auto_trans(hald_t, cupsd_exec_t, cupsd_t)
 ')
+allow cupsd_t userdomain:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbskkd.te policy-1.17.22/domains/program/unused/dbskkd.te
--- nsapolicy/domains/program/unused/dbskkd.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/program/unused/dbskkd.te	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,14 @@
+#DESC dbskkd - A dictionary server for the SKK Japanese input method system.
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the dbskkd_t domain.
+#
+# dbskkd_exec_t is the type of the dbskkd executable.
+#
+
+type dbskkd_port_t, port_type;
+inetd_child_domain(dbskkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.22/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-23 15:08:59.000000000 -0400
+++ policy-1.17.22/domains/program/unused/hald.te	2004-09-27 11:02:13.033982220 -0400
@@ -38,6 +38,8 @@
 allow hald_t device_t:lnk_file read;
 allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
 allow hald_t event_device_t:chr_file { getattr read ioctl };
+allow hald_t printer_device_t:chr_file rw_file_perms;
+allow hald_t urandom_device_t:chr_file { read };
 
 ifdef(`updfstab.te', `
 domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)
@@ -50,6 +52,9 @@
 allow hald_t udev_tbl_t:file { getattr read };
 ')
 
+ifdef(`udev.te', `
+r_dir_file(hald_t, hotplug_etc_t)
+')
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
 allow hald_t usbfs_t:dir search;
@@ -57,4 +62,3 @@
 allow hald_t bin_t:lnk_file read;
 dontaudit hald_t selinux_config_t:dir { search };
 dontaudit hald_t userdomain:fd { use };
-
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.22/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.22/domains/program/unused/hotplug.te	2004-09-27 10:16:53.000000000 -0400
@@ -47,6 +47,9 @@
 ifdef(`distro_redhat', `
 # for arping used for static IP addresses on PCMCIA ethernet
 domain_auto_trans(hotplug_t, netutils_exec_t, netutils_t)
+
+allow hotplug_t tmpfs_t:dir search;
+allow hotplug_t tmpfs_t:chr_file rw_file_perms;
 ')dnl end if distro_redhat
 ')dnl end if netutils.te
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.22/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.17.22/domains/program/unused/inetd.te	2004-09-27 10:16:53.000000000 -0400
@@ -44,8 +44,6 @@
 # Run other daemons in the inetd_child_t domain.
 allow inetd_t { bin_t sbin_t }:dir search;
 allow inetd_t sbin_t:lnk_file read;
-domain_auto_trans(inetd_t, inetd_child_exec_t, inetd_child_t)
-allow inetd_t inetd_child_t:process sigkill;
 
 # Bind to the telnet, ftp, rlogin and rsh ports.
 allow inetd_t telnet_port_t:tcp_socket name_bind;
@@ -71,53 +69,7 @@
 ifdef(`portmap.te', `can_udp_send(inetd_t, portmap_t)')
 
 
-#################################
-#
-# Rules for the inetd_child_t domain.
-#
-# inetd_child_t is a general domain for daemons started
-# by inetd that do not have their own individual domains yet.
-# inetd_child_exec_t is the type of the corresponding
-# programs.
-#
-type inetd_child_t, domain, privlog;
-role system_r types inetd_child_t;
-
-can_network(inetd_child_t)
-can_ypbind(inetd_child_t)
-uses_shlib(inetd_child_t)
-allow inetd_child_t self:unix_dgram_socket create_socket_perms;
-allow inetd_child_t self:unix_stream_socket create_socket_perms;
-allow inetd_child_t self:fifo_file rw_file_perms;
-type inetd_child_exec_t, file_type, sysadmfile, exec_type;
-read_locale(inetd_child_t)
-allow inetd_child_t device_t:dir search;
-allow inetd_child_t proc_t:dir search;
-allow inetd_child_t proc_t:{ file lnk_file } { getattr read };
-allow inetd_child_t self:process { fork signal_perms };
-allow inetd_child_t fs_t:filesystem getattr;
-
-allow inetd_child_t sysctl_kernel_t:dir search;
-allow inetd_child_t sysctl_kernel_t:file { getattr read };
-
-allow inetd_child_t etc_t:file { getattr read };
-
-tmp_domain(inetd_child)
-allow inetd_child_t var_t:dir search;
-var_run_domain(inetd_child)
-
-# Use sockets inherited from inetd.
-allow inetd_child_t inetd_t:tcp_socket rw_stream_socket_perms;
-
-# for identd
-allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow inetd_child_t self:capability { setuid setgid };
-allow inetd_child_t home_root_t:dir { search };
-allow inetd_child_t self:dir { search };
-allow inetd_child_t self:file { getattr read };
-allow inetd_child_t krb5_conf_t:file r_file_perms;
-dontaudit inetd_child_t krb5_conf_t:file write;
-allow inetd_child_t urandom_device_t:chr_file { getattr read };
+inetd_child_domain(inetd_child)
 
 ifdef(`unconfined.te', `
 domain_auto_trans(inetd_t, unconfined_exec_t, unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iptables.te policy-1.17.22/domains/program/unused/iptables.te
--- nsapolicy/domains/program/unused/iptables.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.22/domains/program/unused/iptables.te	2004-09-27 10:16:53.000000000 -0400
@@ -56,3 +56,6 @@
 
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file { append };
+ifdef(`firstboot.te', `
+allow iptables_t firstboot_t:fifo_file { write };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.22/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/program/unused/ktalkd.te	2004-09-27 13:24:01.429584334 -0400
@@ -0,0 +1,14 @@
+#DESC ktalkd -  KDE version of the talk server 
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the ktalkd_t domain.
+#
+# ktalkd_exec_t is the type of the ktalkd executable.
+#
+
+type ktalkd_port_t, port_type;
+inetd_child_domain(ktalkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.22/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2004-09-15 15:59:55.000000000 -0400
+++ policy-1.17.22/domains/program/unused/ntpd.te	2004-09-27 10:16:53.000000000 -0400
@@ -66,3 +66,6 @@
 can_udp_send(ntpd_t, sysadm_t)
 can_udp_send(sysadm_t, ntpd_t)
 can_udp_send(ntpd_t, ntpd_t)
+ifdef(`firstboot.te', `
+dontaudit ntpd_t firstboot_t:fd { use };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.22/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-09-22 16:19:12.000000000 -0400
+++ policy-1.17.22/domains/program/unused/rhgb.te	2004-09-27 10:16:53.000000000 -0400
@@ -34,7 +34,7 @@
 allow insmod_t rhgb_t:fd use;
 
 allow rhgb_t ramfs_t:filesystem { mount unmount };
-allow rhgb_t mnt_t:dir { mounton };
+allow rhgb_t mnt_t:dir { search mounton };
 allow rhgb_t rhgb_t:capability { sys_admin };
 dontaudit rhgb_t var_run_t:dir { search };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.17.22/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-08-27 16:51:30.000000000 -0400
+++ policy-1.17.22/domains/program/unused/rpcd.te	2004-09-27 10:16:53.000000000 -0400
@@ -91,14 +91,19 @@
 type nfsd_rw_t, file_type, sysadmfile, usercanread;
 type nfsd_ro_t, file_type, sysadmfile, usercanread;
 
-ifdef(`nfs_export_all_rw', `
+bool nfs_export_all_rw false;
+
+if(nfs_export_all_rw) {
 allow nfsd_t { file_type -shadow_t }:dir r_dir_perms;
 create_dir_file(kernel_t,{ file_type -shadow_t })
-')
-ifdef(`nfs_export_all_ro', `
+}
+
+bool nfs_export_all_ro false;
+
+if(nfs_export_all_ro) {
 allow nfsd_t { file_type -shadow_t }:dir r_dir_perms;
 r_dir_file(kernel_t,{ file_type -shadow_t })
-')
+}
 allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir r_dir_perms;
 create_dir_file(kernel_t, nfsd_rw_t);
 r_dir_file(kernel_t, nfsd_ro_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.22/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/program/unused/rsync.te	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,14 @@
+#DESC rsync - flexible replacement for rcp
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the rsync_t domain.
+#
+# rsync_exec_t is the type of the rsync executable.
+#
+
+type rsync_port_t, port_type;
+inetd_child_domain(rsync)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/screensaver.te policy-1.17.22/domains/program/unused/screensaver.te
--- nsapolicy/domains/program/unused/screensaver.te	2004-03-31 12:59:08.000000000 -0500
+++ policy-1.17.22/domains/program/unused/screensaver.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#DESC screensaver - X Windows screensaver needs access to password
-#
-# Authors:  Dan Walsh <dwalsh@redhat.com> 
-#
-
-#################################
-# 
-# Rules for the screensaver_t domain
-#
-
-type screensaver_exec_t, file_type, sysadmfile, exec_type;
-
-# Everything else is in the screensaver_domain macro in
-# macros/program/screensaver_macros.te.
-
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.17.22/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/domains/program/unused/swat.te	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,14 @@
+#DESC swat - Samba Web Administration Tool
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the swat_t domain.
+#
+# swat_exec_t is the type of the swat executable.
+#
+
+type swat_port_t, port_type;
+inetd_child_domain(swat)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.22/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-15 15:59:55.000000000 -0400
+++ policy-1.17.22/domains/program/unused/udev.te	2004-09-27 10:16:53.000000000 -0400
@@ -23,7 +23,7 @@
 #
 type udev_tbl_t, file_type, sysadmfile, dev_fs;
 file_type_auto_trans(udev_t, device_t, udev_tbl_t, file)
-allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod };
+allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod net_raw net_admin };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
@@ -103,3 +103,5 @@
 dbusd_client(system, udev_t)
 
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
+allow udev_t sysctl_modprobe_t:file { getattr read };
+allow udev_t udev_t:rawip_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/comsat.fc policy-1.17.22/file_contexts/program/comsat.fc
--- nsapolicy/file_contexts/program/comsat.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/file_contexts/program/comsat.fc	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,2 @@
+# biff server
+/usr/sbin/in.comsat	--	system_u:object_r:comsat_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dbskkd.fc policy-1.17.22/file_contexts/program/dbskkd.fc
--- nsapolicy/file_contexts/program/dbskkd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/file_contexts/program/dbskkd.fc	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,2 @@
+# A dictionary server for the SKK Japanese input method system.
+/usr/sbin/dbskkd-cdb	--	system_u:object_r:dbskkd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ktalkd.fc policy-1.17.22/file_contexts/program/ktalkd.fc
--- nsapolicy/file_contexts/program/ktalkd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/file_contexts/program/ktalkd.fc	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,2 @@
+# kde talk daemon 
+/usr/bin/ktalkd	--	system_u:object_r:ktalkd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mailman.fc policy-1.17.22/file_contexts/program/mailman.fc
--- nsapolicy/file_contexts/program/mailman.fc	2004-09-01 11:17:49.000000000 -0400
+++ policy-1.17.22/file_contexts/program/mailman.fc	2004-09-27 10:16:53.000000000 -0400
@@ -7,6 +7,7 @@
 /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
 /var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
+/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
 /etc/cron\.daily/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /etc/cron\.monthly/mailman 	-- system_u:object_r:mailman_queue_exec_t
 ')
@@ -19,5 +20,8 @@
 /var/mailman/archives(/.*)?	   system_u:object_r:mailman_archive_t
 /var/mailman/scripts/mailman 	-- system_u:object_r:mailman_mail_exec_t
 /var/mailman/bin/qrunner     	-- system_u:object_r:mailman_queue_exec_t
+/var/mailman/bin/mailmanctl     -- system_u:object_r:mailman_mail_exec_t
 /var/mailman/mail/mailman 	-- system_u:object_r:mailman_mail_exec_t
+/var/mailman/Mailman(/.*?)	   system_u:object_r:lib_t
+/var/mailman/pythonlib(/.*?)	   system_u:object_r:lib_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rsync.fc policy-1.17.22/file_contexts/program/rsync.fc
--- nsapolicy/file_contexts/program/rsync.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/file_contexts/program/rsync.fc	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,2 @@
+# rsync program
+/usr/bin/rsync	--	system_u:object_r:rsync_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/screensaver.fc policy-1.17.22/file_contexts/program/screensaver.fc
--- nsapolicy/file_contexts/program/screensaver.fc	2004-07-26 16:16:11.000000000 -0400
+++ policy-1.17.22/file_contexts/program/screensaver.fc	1969-12-31 19:00:00.000000000 -0500
@@ -1,7 +0,0 @@
-# screensaver
-/usr/X11R6/bin/xscreensaver		--	system_u:object_r:screensaver_exec_t
-/usr/X11R6/bin/xscreensaver-demo	--      system_u:object_r:screensaver_exec_t
-/opt/kde3/bin/kdesktop_lock		--	system_u:object_r:screensaver_exec_t
-/usr/bin/kdesktop_lock			--	system_u:object_r:screensaver_exec_t
-/usr/X11R6/lib(64)?/xscreensaver(.*)?	system_u:object_r:bin_t
-HOME_DIR/\.xscreensaver	system_u:object_r:ROLE_screensaver_rw_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/swat.fc policy-1.17.22/file_contexts/program/swat.fc
--- nsapolicy/file_contexts/program/swat.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/file_contexts/program/swat.fc	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,2 @@
+# samba management tool
+/usr/sbin/swat	--	system_u:object_r:swat_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.22/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-09-23 15:08:59.000000000 -0400
+++ policy-1.17.22/file_contexts/types.fc	2004-09-27 10:56:34.336171167 -0400
@@ -144,6 +144,9 @@
 /dev/par.*		-c	system_u:object_r:printer_device_t
 /dev/usb/lp.*		-c	system_u:object_r:printer_device_t
 /dev/usblp.*		-c	system_u:object_r:printer_device_t
+ifdef(`distro_redhat', `
+/dev/root		-b	system_u:object_r:fixed_disk_device_t
+')
 /u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.22/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-24 11:42:14.000000000 -0400
+++ policy-1.17.22/macros/base_user_macros.te	2004-09-27 10:17:09.000000000 -0400
@@ -153,7 +153,6 @@
 
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
-ifdef(`screensaver.te', `screensaver_domain($1)')
 ifdef(`use_games', `ifdef(`games.te', `games_domain($1)')')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.17.22/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.22/macros/program/inetd_macros.te	2004-09-27 10:16:53.000000000 -0400
@@ -0,0 +1,52 @@
+#################################
+#
+# Rules for the $1_t domain.
+#
+# $1_t is a general domain for daemons started
+# by inetd that do not have their own individual domains yet.
+# $1_exec_t is the type of the corresponding
+# programs.
+#
+define(`inetd_child_domain', `
+type $1_t, domain, privlog;
+role system_r types $1_t;
+
+domain_auto_trans(inetd_t, $1_exec_t, $1_t)
+allow inetd_t $1_t:process sigkill;
+
+can_network($1_t)
+can_ypbind($1_t)
+uses_shlib($1_t)
+allow $1_t self:unix_dgram_socket create_socket_perms;
+allow $1_t self:unix_stream_socket create_socket_perms;
+allow $1_t self:fifo_file rw_file_perms;
+type $1_exec_t, file_type, sysadmfile, exec_type;
+read_locale($1_t)
+allow $1_t device_t:dir search;
+allow $1_t proc_t:dir search;
+allow $1_t proc_t:{ file lnk_file } { getattr read };
+allow $1_t self:process { fork signal_perms };
+allow $1_t fs_t:filesystem getattr;
+
+allow $1_t sysctl_kernel_t:dir search;
+allow $1_t sysctl_kernel_t:file { getattr read };
+
+allow $1_t etc_t:file { getattr read };
+
+tmp_domain($1)
+allow $1_t var_t:dir search;
+var_run_domain($1)
+
+# Use sockets inherited from inetd.
+allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;
+
+# for identd
+allow $1_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
+allow $1_t self:capability { setuid setgid };
+allow $1_t home_root_t:dir { search };
+allow $1_t self:dir { search };
+allow $1_t self:file { getattr read };
+allow $1_t krb5_conf_t:file r_file_perms;
+dontaudit $1_t krb5_conf_t:file write;
+allow $1_t urandom_device_t:chr_file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.22/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-22 16:19:14.000000000 -0400
+++ policy-1.17.22/macros/program/mozilla_macros.te	2004-09-27 10:16:53.000000000 -0400
@@ -115,6 +115,8 @@
 dontaudit $1_mozilla_t bin_t:dir { getattr };
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
+# Mozilla tries to delete .fonts.cache-1
+dontaudit $1_mozilla_t $1_home_t:file { unlink };
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screensaver_macros.te policy-1.17.22/macros/program/screensaver_macros.te
--- nsapolicy/macros/program/screensaver_macros.te	2004-08-12 13:21:12.000000000 -0400
+++ policy-1.17.22/macros/program/screensaver_macros.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,83 +0,0 @@
-#DESC screensaver - X Windows screensaver needs access to password
-#
-# Macros for xscreensaver 
-#
-#
-# Authors:  Dan Walsh <dwalsh@redhat.com> 
-#
-
-#
-# screensaver_domain(domain_prefix)
-#
-# Define a derived domain for the xscreensaver program when executed by
-# a user domain.  
-#
-# The type declaration for the executable type for this program is
-# provided separately in domains/program/screensaver.te. 
-#
-define(`screensaver_domain',`
-x_client_domain($1, screensaver, `, auth_chkpwd');
-dontaudit $1_screensaver_t shadow_t:file { getattr read };
-allow $1_screensaver_t krb5_conf_t:file { getattr read };
-dontaudit $1_screensaver_t krb5_conf_t:file { write };
-
-# Read system information files in /proc.
-dontaudit $1_screensaver_t proc_t:dir r_dir_perms;
-allow $1_screensaver_t proc_t:file  r_file_perms;
-
-allow $1_screensaver_t devpts_t:dir r_dir_perms;
-base_file_read_access($1_screensaver_t)
-
-dontaudit $1_screensaver_t port_type:tcp_socket name_bind;
-
-allow $1_screensaver_t etc_t:file { getattr read };
-allow $1_screensaver_t self:unix_stream_socket create_socket_perms;
-
-domain_trans($1_screensaver_t, shell_exec_t, $1_t)
-domain_trans($1_screensaver_t, bin_t, $1_t)
-
-allow $1_screensaver_t initrc_var_run_t:file { lock read };
-# 
-# Looking for icons
-dontaudit $1_screensaver_t $1_home_t:dir r_dir_perms;
-dontaudit $1_screensaver_t $1_home_t:file r_file_perms;
-
-# Fortune data
-ifdef(`games.te',`
-dontaudit $1_screensaver_t games_data_t:dir { getattr search };
-')
-
-allow $1_screensaver_t initrc_var_run_t:file { lock read };
-
-#
-# Need to fix the starwars not to read /usr/src dir
-#
-dontaudit $1_screensaver_t src_t:dir { search };
-dontaudit $1_screensaver_t src_t:file { getattr read };
-
-#
-# Worse performance but safer
-#
-dontaudit $1_screensaver_t device_t:dir rw_dir_perms;
-dontaudit $1_screensaver_t dri_device_t:chr_file rw_file_perms;
-allow $1_screensaver_t self:file { getattr read };
-allow $1_screensaver_t self:process { setsched };
-allow $1_screensaver_t urandom_device_t:chr_file { getattr ioctl read };
-
-# Screen savers request the following
-dontaudit $1_screensaver_t $1_t:rawip_socket { create };
-
-ifdef(`xdm.te', `
-allow $1_screensaver_t xdm_tmp_t:dir { search };
-allow $1_screensaver_t xdm_tmp_t:file { getattr read };
-allow $1_screensaver_t xdm_xserver_t:unix_stream_socket { connectto };
-')
-dontaudit $1_screensaver_t var_t:dir { search };
-
-ifdef(`nfs_home_dirs', `
-create_dir_file($1_screensaver_t, nfs_t)
-')dnl end if nfs_home_dirs
-dontaudit $1_screensaver_t $1_screensaver_t:rawip_socket { create };
-
-') dnl screesaver_domain
-
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.17.22/net_contexts
--- nsapolicy/net_contexts	2004-08-23 14:54:50.000000000 -0400
+++ policy-1.17.22/net_contexts	2004-09-27 10:16:53.000000000 -0400
@@ -35,7 +35,6 @@
 portcon udp 891 system_u:object_r:inetd_port_t
 portcon tcp 892 system_u:object_r:inetd_port_t
 portcon udp 892 system_u:object_r:inetd_port_t
-portcon tcp 901 system_u:object_r:biff_port_t
 ')
 ifdef(`ftpd.te', `
 portcon tcp 20 system_u:object_r:ftp_data_port_t
@@ -105,6 +104,7 @@
 portcon udp 631 system_u:object_r:ipp_port_t
 ')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
+ifdef(`swat.te', `portcon tcp 901 system_u:object_r:swat_port_t')
 ifdef(`named.te', `portcon tcp 953 system_u:object_r:rndc_port_t')
 ifdef(`use_pop', `
 portcon tcp 993 system_u:object_r:pop_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.22/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.22/tunables/distro.tun	2004-09-27 10:16:53.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.22/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-23 15:09:01.000000000 -0400
+++ policy-1.17.22/tunables/tunable.tun	2004-09-27 10:16:53.000000000 -0400
@@ -1,48 +1,42 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
-
-# Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
-
-# Allow the reading on any NFS file system
-dnl define(`nfs_export_all_ro')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------000706000906080301050902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
