Message-ID: <41542FF5.2090502@redhat.com>
Date: Fri, 24 Sep 2004 10:32:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Patch for strict policy
Content-Type: multipart/mixed;
 boundary="------------020104050106030104000802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020104050106030104000802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Added policy templates for swat, ktalkd, in.comcast, and rsyn daemons to 
be run by xinetd.
Separated out inetd_child_t context into a macro.
Mailman fixes

--------------020104050106030104000802
Content-Type: text/plain;
 name="policy-20040924.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20040924.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.20/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-09-21 12:51:05.000000000 -0400
+++ policy-1.17.20/domains/program/initrc.te	2004-09-23 13:57:50.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.20/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.20/domains/program/mount.te	2004-09-23 13:57:50.000000000 -0400
@@ -97,6 +97,6 @@
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
-dontaudit mount_t tmpfs_t:chr_file { read write };
+allow mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir { mounton };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.17.20/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.20/domains/program/unused/cardmgr.te	2004-09-24 10:01:56.156856947 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.20/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/domains/program/unused/comsat.te	2004-09-24 10:02:23.453775339 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.20/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-09-23 09:01:00.000000000 -0400
+++ policy-1.17.20/domains/program/unused/cups.te	2004-09-24 10:01:49.701585696 -0400
@@ -168,3 +168,4 @@
 allow cupsd_t hald_t:dbus { send_msg };
 allow hald_t cupsd_t:dbus { send_msg };
 ')
+allow cupsd_t userdomain:dbus { send_msg };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbskkd.te policy-1.17.20/domains/program/unused/dbskkd.te
--- nsapolicy/domains/program/unused/dbskkd.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/domains/program/unused/dbskkd.te	2004-09-24 10:02:33.858600716 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.20/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-24 10:06:08.297392263 -0400
+++ policy-1.17.20/domains/program/unused/hald.te	2004-09-23 09:01:17.000000000 -0400
@@ -50,6 +50,9 @@
 allow hald_t udev_tbl_t:file { getattr read };
 ')
 
+ifdef(`udev.te', `
+r_dir_file(hald_t, hotplug_etc_t)
+')
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
 allow hald_t usbfs_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.20/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-23 09:01:00.000000000 -0400
+++ policy-1.17.20/domains/program/unused/hotplug.te	2004-09-23 13:57:50.000000000 -0400
@@ -47,6 +47,9 @@
 ifdef(`distro_redhat', `
 # for arping used for static IP addresses on PCMCIA ethernet
 domain_auto_trans(hotplug_t, netutils_exec_t, netutils_t)
+
+allow hotplug_t tmpfs_t:dir search;
+allow hotplug_t tmpfs_t:chr_file rw_file_perms;
 ')dnl end if distro_redhat
 ')dnl end if netutils.te
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.20/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-09-10 16:10:36.000000000 -0400
+++ policy-1.17.20/domains/program/unused/inetd.te	2004-09-24 10:01:29.025919816 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.17.20/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.20/domains/program/unused/rpcd.te	2004-09-23 12:21:36.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.20/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/domains/program/unused/rsync.te	2004-09-24 10:02:54.773239618 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.17.20/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/domains/program/unused/swat.te	2004-09-24 10:02:28.230236114 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.20/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-16 09:48:15.000000000 -0400
+++ policy-1.17.20/domains/program/unused/udev.te	2004-09-24 10:00:38.925575751 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/comsat.fc policy-1.17.20/file_contexts/program/comsat.fc
--- nsapolicy/file_contexts/program/comsat.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/file_contexts/program/comsat.fc	2004-09-24 10:05:50.835363588 -0400
@@ -0,0 +1,2 @@
+# biff server
+/usr/sbin/in.comsat	--	system_u:object_r:comsat_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dbskkd.fc policy-1.17.20/file_contexts/program/dbskkd.fc
--- nsapolicy/file_contexts/program/dbskkd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/file_contexts/program/dbskkd.fc	2004-09-24 10:05:50.837363363 -0400
@@ -0,0 +1,2 @@
+# A dictionary server for the SKK Japanese input method system.
+/usr/sbin/dbskkd-cdb	--	system_u:object_r:dbskkd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ktalkd.fc policy-1.17.20/file_contexts/program/ktalkd.fc
--- nsapolicy/file_contexts/program/ktalkd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/file_contexts/program/ktalkd.fc	2004-09-24 10:05:50.845362460 -0400
@@ -0,0 +1,2 @@
+# kde talk daemon 
+/usr/bin/ktalkd	--	system_u:object_r:ktalkd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mailman.fc policy-1.17.20/file_contexts/program/mailman.fc
--- nsapolicy/file_contexts/program/mailman.fc	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.20/file_contexts/program/mailman.fc	2004-09-24 10:05:50.847362234 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rsync.fc policy-1.17.20/file_contexts/program/rsync.fc
--- nsapolicy/file_contexts/program/rsync.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/file_contexts/program/rsync.fc	2004-09-24 10:05:50.854361444 -0400
@@ -0,0 +1,2 @@
+# rsync program
+/usr/bin/rsync	--	system_u:object_r:rsync_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/swat.fc policy-1.17.20/file_contexts/program/swat.fc
--- nsapolicy/file_contexts/program/swat.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/file_contexts/program/swat.fc	2004-09-24 10:05:50.859360879 -0400
@@ -0,0 +1,2 @@
+# samba management tool
+/usr/sbin/swat	--	system_u:object_r:swat_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.20/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-23 09:01:00.000000000 -0400
+++ policy-1.17.20/macros/base_user_macros.te	2004-09-24 10:04:26.394896253 -0400
@@ -291,6 +291,7 @@
 #
 allow $1_t rpc_pipefs_t:dir { getattr };
 allow $1_t nfsd_fs_t:dir { getattr };
+allow $1_t binfmt_misc_fs_t:dir { getattr };
 
 # /initrd is left mounted, various programs try to look at it
 dontaudit $1_t ramfs_t:dir { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.17.20/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.20/macros/program/inetd_macros.te	2004-09-24 10:06:57.702814779 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.20/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-23 09:01:00.000000000 -0400
+++ policy-1.17.20/macros/program/mozilla_macros.te	2004-09-24 10:04:03.854440893 -0400
@@ -115,6 +115,8 @@
 dontaudit $1_mozilla_t bin_t:dir { getattr };
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
+# Mozilla tries to delete .fonts.cache-1
+dontaudit $1_mozilla_t $1_home_t:file { unlink };
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.17.20/net_contexts
--- nsapolicy/net_contexts	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.20/net_contexts	2004-09-24 10:03:30.156245155 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.20/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.20/tunables/distro.tun	2004-09-23 09:26:44.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.20/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-24 10:06:25.077497921 -0400
+++ policy-1.17.20/tunables/tunable.tun	2004-09-23 12:22:29.000000000 -0400
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

--------------020104050106030104000802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
