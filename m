Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8LKterT027762
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 16:55:40 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8LKsfaY021682
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 20:54:41 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i8LKteYk023660
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 16:55:40 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8LKter15214
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 16:55:40 -0400
Received: from [172.16.80.115] (IDENT:U2FsdGVkX18PujSm5pFeGRlzcSOqbiK4MU9PULFzb6M@celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i8LKtdCO007902
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 16:55:39 -0400
Message-ID: <4150954B.9000804@redhat.com>
Date: Tue, 21 Sep 2004 16:55:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy patches
References: <200409162151.44819.russell@coker.com.au>	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>	 <414A0454.2060304@redhat.com> <1095454617.4295.55.camel@moss-lions.epoch.ncsc.mil> <414ECE9E.8030001@redhat.com>
In-Reply-To: <414ECE9E.8030001@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010203040307060305050401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010203040307060305050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Policy patches off of latest policy.

nscd fixes mainly.

--------------010203040307060305050401
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/appconfig/removable_context policy-1.17.19/appconfig/removable_context
--- nsapolicy/appconfig/removable_context	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.19/appconfig/removable_context	2004-09-21 13:05:04.223318911 -0400
@@ -0,0 +1 @@
+system_u:object_r:removable_t
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.19/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.19/domains/program/unused/consoletype.te	2004-09-21 13:05:04.224318800 -0400
@@ -52,5 +52,5 @@
 allow consoletype_t pam_var_run_t:file { getattr read };
 ')
 ifdef(`distro_redhat', `
-dontaudit consoletype_t tmpfs_t:chr_file { read write };
+allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.19/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.19/domains/program/unused/cups.te	2004-09-21 13:05:04.224318800 -0400
@@ -30,6 +30,7 @@
 allow cupsd_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t urandom_device_t:chr_file { getattr read };
 dontaudit cupsd_t random_device_t:chr_file ioctl;
+dontaudit cupsd_t device_t:lnk_file { read }; 
 
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.19/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-16 16:57:34.000000000 -0400
+++ policy-1.17.19/domains/program/unused/hald.te	2004-09-21 13:05:04.225318690 -0400
@@ -51,8 +51,14 @@
 allow hald_t udev_tbl_t:file { getattr read };
 ')
 
+ifdef(`udev.te', `
+r_dir_file(hald_t, hotplug_etc_t)
+')
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };
 allow hald_t usbfs_t:dir search;
 allow hald_t usbfs_t:file { getattr read };
 allow hald_t bin_t:lnk_file read;
+dontaudit hald_t selinux_config_t:dir { search };
+dontaudit hald_t userdomain:fd { use };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mozilla.te policy-1.17.19/domains/program/unused/mozilla.te
--- nsapolicy/domains/program/unused/mozilla.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.19/domains/program/unused/mozilla.te	2004-09-21 13:05:04.225318690 -0400
@@ -6,6 +6,7 @@
 
 # Type for the netscape, mozilla or other browser executables.
 type mozilla_exec_t, file_type, sysadmfile, exec_type;
+type mozilla_conf_t, file_type, sysadmfile;
 
 # Allow mozilla to read files in the user home directory
 bool mozilla_readhome false;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.19/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-09-16 09:48:15.000000000 -0400
+++ policy-1.17.19/domains/program/unused/named.te	2004-09-21 13:48:16.136487414 -0400
@@ -31,7 +31,7 @@
 can_exec(named_t, named_exec_t)
 allow named_t sbin_t:dir search;
 
-allow named_t self:process setsched;
+allow named_t self:process { setsched setcap setrlimit };
 
 # A type for configuration files of named.
 type named_conf_t, file_type, sysadmfile;
@@ -96,8 +96,6 @@
 allow named_t self:fifo_file rw_file_perms;
 
 # Set own capabilities.
-allow named_t self:process setcap;
-
 #A type for /usr/sbin/ndc
 type ndc_exec_t, file_type,sysadmfile, exec_type;
 domain_auto_trans({ sysadm_t initrc_t }, ndc_exec_t, ndc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.19/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-09-16 09:48:15.000000000 -0400
+++ policy-1.17.19/domains/program/unused/nscd.te	2004-09-21 16:47:07.510447194 -0400
@@ -55,7 +55,7 @@
 
 allow nscd_t sysctl_kernel_t:dir search;
 allow nscd_t sysctl_kernel_t:file read;
-allow nscd_t self:process setsched;
+allow nscd_t self:process { getattr setsched };
 allow nscd_t self:unix_dgram_socket create_socket_perms;
 allow nscd_t self:fifo_file { read write };
 allow nscd_t self:capability { kill setgid setuid };
@@ -70,4 +70,6 @@
 #
 dontaudit nscd_t var_run_t:sock_file rw_file_perms;
 
-
+r_dir_file(nscd_t, selinux_config_t)
+can_getsecurity(nscd_t)
+allow nscd_t self:netlink_selinux_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.19/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.19/domains/program/unused/rhgb.te	2004-09-21 13:05:04.227318468 -0400
@@ -34,7 +34,7 @@
 allow insmod_t rhgb_t:fd use;
 
 allow rhgb_t ramfs_t:filesystem { mount unmount };
-allow rhgb_t root_t:dir { mounton };
+allow rhgb_t mnt_t:dir { mounton };
 allow rhgb_t rhgb_t:capability { sys_admin };
 dontaudit rhgb_t var_run_t:dir { search };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.19/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-09-10 10:17:49.000000000 -0400
+++ policy-1.17.19/domains/program/unused/updfstab.te	2004-09-21 13:05:04.228318357 -0400
@@ -62,3 +62,10 @@
 
 r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
 can_getsecurity(updfstab_t)
+
+allow updfstab_t { sbin_t bin_t }:dir { search getattr };
+dontaudit updfstab_t devtty_t:chr_file { read write };
+allow updfstab_t self:fifo_file { getattr read write ioctl };
+can_exec(updfstab_t, { sbin_t bin_t ls_exec_t } )
+dontaudit updfstab_t home_root_t:dir { getattr search };
+dontaudit updfstab_t { home_dir_type home_type }:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.17.19/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.19/file_contexts/program/mozilla.fc	2004-09-21 13:05:04.228318357 -0400
@@ -17,3 +17,4 @@
 /usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t
+/etc/mozpluggerrc system_u:object_r:mozilla_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rhgb.fc policy-1.17.19/file_contexts/program/rhgb.fc
--- nsapolicy/file_contexts/program/rhgb.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.19/file_contexts/program/rhgb.fc	2004-09-21 13:05:04.229318246 -0400
@@ -1,2 +1,3 @@
 /usr/bin/rhgb		--	system_u:object_r:rhgb_exec_t
 #/etc/dbus-1(/.*)?		system_u:object_r:etc_dbusd_t
+/etc/rhgb		-d	system_u:object_r:mnt_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.19/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-09-21 12:51:05.000000000 -0400
+++ policy-1.17.19/file_contexts/types.fc	2004-09-21 13:05:04.230318136 -0400
@@ -302,6 +302,7 @@
 /lib(64)?/[^/]*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/security/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/tls/i686/cmov/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+/lib(64)?/tls/i486/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
 
 #
 # /sbin
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.19/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-10 10:17:50.000000000 -0400
+++ policy-1.17.19/macros/base_user_macros.te	2004-09-21 13:05:04.230318136 -0400
@@ -64,6 +64,7 @@
 ')dnl end if nfs_home_dirs
 if (user_rw_noexattrfile) {
 create_dir_file($1_t, noexattrfile)
+create_dir_file($1_t, removable_t)
 # Write floppies 
 allow $1_t removable_device_t:blk_file rw_file_perms;
 allow $1_t usbtty_device_t:chr_file write;
@@ -72,6 +73,10 @@
 allow $1_t removable_device_t:blk_file r_file_perms;
 }
 allow $1_t usbtty_device_t:chr_file read;
+
+# GNOME checks for usb and other devices
+r_dir_file($1_t,usbfs_t)
+
 can_exec($1_t, noexattrfile)
 # Bind to a Unix domain socket in /tmp.
 allow $1_t $1_tmp_t:unix_stream_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.17.19/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-09-21 12:51:06.000000000 -0400
+++ policy-1.17.19/macros/core_macros.te	2004-09-21 16:44:32.697773308 -0400
@@ -271,7 +271,7 @@
 define(`can_getsecurity',`
 # Get the selinuxfs mount point via /proc/self/mounts.
 allow $1 proc_t:dir search;
-allow $1 proc_t:{ file lnk_file } read;
+allow $1 proc_t:{ file lnk_file } { getattr read };
 allow $1 self:dir search;
 allow $1 self:file { getattr read };
 # Access selinuxfs.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.19/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-09-16 09:48:16.000000000 -0400
+++ policy-1.17.19/macros/global_macros.te	2004-09-21 16:37:55.572191411 -0400
@@ -294,7 +294,7 @@
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
 ifdef(`targeted_policy', `
-dontaudit $1_t devpts_t:chr_file { read write };
+dontaudit $1_t { tty_device_t devpts_t }:chr_file { read write };
 dontaudit $1_t root_t:file { getattr read };
 ')dnl end if targeted_policy
  
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.19/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-21 12:51:06.000000000 -0400
+++ policy-1.17.19/macros/program/mozilla_macros.te	2004-09-21 13:05:04.231318025 -0400
@@ -71,6 +71,8 @@
 allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
 ')
 
+dontaudit $1_mozilla_t tmp_t:lnk_file read;
+
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
@@ -109,6 +111,8 @@
 ')
 allow $1_mozilla_t $1_t:tcp_socket { read write };
 
+allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
+dontaudit $1_mozilla_t bin_t:dir { getattr };
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.19/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-09-21 12:51:06.000000000 -0400
+++ policy-1.17.19/macros/user_macros.te	2004-09-21 13:05:04.232317914 -0400
@@ -181,9 +181,6 @@
 allow $1_t man_t:dir r_dir_perms;
 allow $1_t man_t:notdevfile_class_set r_file_perms;
 
-# GNOME checks for usb and other devices
-r_dir_file($1_t,usbfs_t)
-
 # Allow users to rw usb devices
 if (user_rw_usb) {
 rw_dir_create_file($1_t,usbdevfs_t)
@@ -230,6 +227,12 @@
 mount_domain($1, $1_mount, `, fs_domain')
 role $1_r types $1_mount_t;
 r_dir_file($1_t, mnt_t)
+allow $1_mount_t removable_device_t:blk_file { read };
+allow $1_mount_t iso9660_t:filesystem { relabelfrom };
+allow $1_mount_t removable_t:filesystem { mount relabelto };
+allow $1_mount_t removable_t:dir { mounton };
+allow $1_mount_t xdm_t:fd { use };
+allow $1_mount_t xdm_t:fifo_file { write };
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.19/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.19/tunables/distro.tun	2004-09-21 13:05:04.232317914 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.19/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-15 09:15:39.000000000 -0400
+++ policy-1.17.19/tunables/tunable.tun	2004-09-21 13:05:04.233317803 -0400
@@ -1,51 +1,51 @@
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
+define(`hide_broken_symptoms')
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.19/types/file.te
--- nsapolicy/types/file.te	2004-09-14 09:18:14.000000000 -0400
+++ policy-1.17.19/types/file.te	2004-09-21 13:06:27.444094270 -0400
@@ -259,7 +259,7 @@
 #
 allow { file_type device_type } fs_t:filesystem associate;
 ifdef(`distro_redhat', `
-allow dev_fs tmpfs_t:filesystem associate;
+allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
 ')
 
 # Allow the pty to be associated with the file system.
@@ -298,3 +298,6 @@
 type cifs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
 allow cifs_t cifs_t:filesystem associate;
 typealias cifs_t alias sambafs_t;
+
+# removable_t is the default type of all removable media
+type removable_t, file_type, sysadmfile, usercanread;
diff --exclude-from=exclude -N -u -r nsapolicy/types/nfs.te policy-1.17.19/types/nfs.te
--- nsapolicy/types/nfs.te	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.19/types/nfs.te	2004-09-21 13:05:04.234317692 -0400
@@ -18,4 +18,5 @@
 #
 # Allow NFS files to be associated with an NFS file system.
 #
-allow nfs_t nfs_t:filesystem associate;
+allow nfs_t self:filesystem associate;
+allow file_type nfs_t:filesystem associate;

--------------010203040307060305050401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
