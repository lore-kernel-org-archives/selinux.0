Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GLNirT028342
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 17:23:44 -0400 (EDT)
Message-ID: <414A0454.2060304@redhat.com>
Date: Thu, 16 Sep 2004 17:23:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Policy patches
References: <200409162151.44819.russell@coker.com.au> <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060300000404060305070604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060300000404060305070604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

New patches to allow hald to add a lines to the /etc/fstab with 
fscontext=system_u:object_r:removable_t.

Dan

--------------060300000404060305070604
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/appconfig/removable_context policy-1.17.17/appconfig/removable_context
--- nsapolicy/appconfig/removable_context	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.17/appconfig/removable_context	2004-09-16 10:54:46.000000000 -0400
@@ -0,0 +1 @@
+system_u:object_r:removable_t
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.17.17/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.17/domains/program/mount.te	2004-09-16 13:50:45.899174425 -0400
@@ -93,7 +93,8 @@
 allow mount_t file_type:filesystem { unmount mount relabelto };
 
 allow mount_t mnt_t:dir { getattr };
-dontaudit mount_t { userdomain kernel_t}:fd use;
+allow mount_t { userdomain }:fd use;
+dontaudit mount_t { kernel_t}:fd use;
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
 ifdef(`distro_redhat', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.17.17/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.17/domains/program/unused/consoletype.te	2004-09-16 16:59:49.161755104 -0400
@@ -52,5 +52,5 @@
 allow consoletype_t pam_var_run_t:file { getattr read };
 ')
 ifdef(`distro_redhat', `
-dontaudit consoletype_t tmpfs_t:chr_file { read write };
+allow consoletype_t tmpfs_t:chr_file { getattr ioctl read write };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.17/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-16 16:57:34.930259111 -0400
+++ policy-1.17.17/domains/program/unused/hald.te	2004-09-16 13:36:57.631159098 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mozilla.te policy-1.17.17/domains/program/unused/mozilla.te
--- nsapolicy/domains/program/unused/mozilla.te	2004-09-09 15:36:13.000000000 -0400
+++ policy-1.17.17/domains/program/unused/mozilla.te	2004-09-16 10:54:46.000000000 -0400
@@ -6,6 +6,7 @@
 
 # Type for the netscape, mozilla or other browser executables.
 type mozilla_exec_t, file_type, sysadmfile, exec_type;
+type mozilla_conf_t, file_type, sysadmfile;
 
 # Allow mozilla to read files in the user home directory
 bool mozilla_readhome false;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.17/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-09-16 09:48:15.000000000 -0400
+++ policy-1.17.17/domains/program/unused/nscd.te	2004-09-16 15:02:07.387150095 -0400
@@ -70,4 +70,8 @@
 #
 dontaudit nscd_t var_run_t:sock_file rw_file_perms;
 
+allow nscd_t self:file { getattr read };
+allow nscd_t proc_t:file { getattr read };
+allow nscd_t selinux_config_t:dir { search };
+r_dir_file(nscd_t, default_context_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.17/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-09-16 09:48:15.000000000 -0400
+++ policy-1.17.17/domains/program/unused/portmap.te	2004-09-16 11:55:04.363237680 -0400
@@ -54,3 +54,4 @@
 
 # do not log when it tries to bind to a port belonging to another domain
 #dontaudit portmap_t port_type:{ tcp_socket udp_socket } name_bind;
+dontaudit portmap_t tty_device_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.17/domains/program/unused/updfstab.te
--- nsapolicy/domains/program/unused/updfstab.te	2004-09-10 10:17:49.000000000 -0400
+++ policy-1.17.17/domains/program/unused/updfstab.te	2004-09-16 13:36:58.170098295 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.17.17/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2004-09-09 15:36:12.000000000 -0400
+++ policy-1.17.17/file_contexts/program/mozilla.fc	2004-09-16 10:54:46.000000000 -0400
@@ -17,3 +17,4 @@
 /usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t
+/etc/mozpluggerrc system_u:object_r:mozilla_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rhgb.fc policy-1.17.17/file_contexts/program/rhgb.fc
--- nsapolicy/file_contexts/program/rhgb.fc	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.17/file_contexts/program/rhgb.fc	2004-09-16 17:07:57.275857767 -0400
@@ -1,2 +1,3 @@
 /usr/bin/rhgb		--	system_u:object_r:rhgb_exec_t
 #/etc/dbus-1(/.*)?		system_u:object_r:etc_dbusd_t
+/etc/rhgb		-d	system_u:object_r:mnt_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.17.17/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-09-14 09:18:10.000000000 -0400
+++ policy-1.17.17/file_contexts/types.fc	2004-09-16 10:54:46.000000000 -0400
@@ -298,6 +298,7 @@
 /lib(64)?/[^/]*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/security/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /lib(64)?/tls/i686/cmov/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
+/lib(64)?/tls/i486/[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
 
 #
 # /sbin
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.17/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-10 10:17:50.000000000 -0400
+++ policy-1.17.17/macros/base_user_macros.te	2004-09-16 10:54:46.000000000 -0400
@@ -64,6 +64,7 @@
 ')dnl end if nfs_home_dirs
 if (user_rw_noexattrfile) {
 create_dir_file($1_t, noexattrfile)
+create_dir_file($1_t, removable_t)
 # Write floppies 
 allow $1_t removable_device_t:blk_file rw_file_perms;
 allow $1_t usbtty_device_t:chr_file write;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.17/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-16 09:48:16.000000000 -0400
+++ policy-1.17.17/macros/program/mozilla_macros.te	2004-09-16 10:54:46.000000000 -0400
@@ -111,6 +111,8 @@
 ')
 allow $1_mozilla_t $1_t:tcp_socket { read write };
 
+allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
+dontaudit $1_mozilla_t bin_t:dir { getattr };
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.17/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-09-14 09:18:11.000000000 -0400
+++ policy-1.17.17/macros/user_macros.te	2004-09-16 13:38:06.207431159 -0400
@@ -230,6 +230,12 @@
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
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.17/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-09-09 15:36:11.000000000 -0400
+++ policy-1.17.17/tunables/distro.tun	2004-09-16 10:54:46.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.17/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-15 09:15:39.000000000 -0400
+++ policy-1.17.17/tunables/tunable.tun	2004-09-16 10:54:46.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.17.17/types/file.te
--- nsapolicy/types/file.te	2004-09-14 09:18:14.000000000 -0400
+++ policy-1.17.17/types/file.te	2004-09-16 10:54:46.000000000 -0400
@@ -264,6 +264,7 @@
 
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;
+allow ttyfile tmpfs_t:filesystem { associate };
 
 type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
 allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
@@ -298,3 +299,6 @@
 type cifs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
 allow cifs_t cifs_t:filesystem associate;
 typealias cifs_t alias sambafs_t;
+
+# removable_t is the default type of all removable media
+type removable_t, file_type, sysadmfile, usercanread;

--------------060300000404060305070604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
