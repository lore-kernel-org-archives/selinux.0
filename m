Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j42EVugA019471
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2005 10:31:57 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j42EUmEY014941
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2005 14:30:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j42EVmum018560
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2005 10:31:48 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j42EVmuU018559
	for selinux@tycho.nsa.gov; Mon, 2 May 2005 10:31:48 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3UF7qgA010685
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 11:07:52 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3UF7CXo023457
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 15:07:13 GMT
Received: from [192.168.2.105] (cpe-69-202-105-200.twcny.res.rr.com [69.202.105.200])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j3UF77Sl016673
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2005 11:07:07 -0400 (EDT)
Subject: Re: Restrict Home v. 4
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
In-Reply-To: <1114819155.18710.4.camel@localhost.localdomain>
References: <1114806411.15876.2.camel@localhost.localdomain>
	 <1114819155.18710.4.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-NPF6RqkSNF0xLm2wZbN+"
Date: Sat, 30 Apr 2005 11:07:05 -0400
Message-Id: <1114873625.19665.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-NPF6RqkSNF0xLm2wZbN+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New version - I am now running in enforcing mode w/ this patch,
and there's very few denials - some complaints from xdm when it
logs in that it can't read gnome icons...

Other than that, it seems to mostly work. 
However, it requires restorecon on both /tmp and /home,
and I'm sure a lot of newly created folders will be the wrong type.

==============================================================

V4 Changelog:

- Prevent gnome_vfs_daemon from starting bonobo_activation_server,
because that's a major problem - all things it starts inherit
from its type, causing chaos - not sure how to confine it,
but if started together w/ gnome_vfs it gets staff_t type.

- Rework file_browse_domain macros - separate into three macros,
to be invoked when necessary. For example, mozilla doesn't
need to suppress read denials, because the GNOME file dialog
hides inaccessible folders. Also, add more types to finally
get rid of *all* the denials. All, except the "secure_file_type"
ones, but I lost that argument...

- Add labeling of $HOME/downloads and Mozilla's built-in
"My Downloads" as ROLE_untrusted_content_t

- Make gmplayer work better.

- Fix bugs.

TODO:
======

Mozilla's still talking to ROLE_t over ORBit - find out
what it's talking to, and confine it - gnome_settings_daemon ?

The Places menu in the file dialog is not working - why?

GNOME (Places) bookmark saving erases the old file,
and writes it over - this is a problem - how to set the type?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-NPF6RqkSNF0xLm2wZbN+
Content-Disposition: attachment; filename=restrict_home4.diff
Content-Type: text/x-patch; name=restrict_home4.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru policy.old/attrib.te policy/attrib.te
--- policy.old/attrib.te	2005-04-29 18:42:44.000000000 -0400
+++ policy/attrib.te	2005-04-29 18:58:53.000000000 -0400
@@ -265,6 +265,12 @@
 # overall filesystem statistics.
 attribute fs_type;
 
+# The mount_point attribute identifies all types that can serve
+# as a mount point (for the mount binary). It is used in the mount 
+# policy to grant mounton permission, and in other domains to grant 
+# getattr permission over all the mount points.
+attribute mount_point;
+
 # The exec_type attribute identifies all types assigned
 # to entrypoint executables for domains.  This attribute is 
 # used in TE rules and assertions that should be applied to all 
diff -aru policy.old/domains/program/apache.te policy/domains/program/apache.te
--- policy.old/domains/program/apache.te	2005-04-29 13:38:29.000000000 -0400
+++ policy/domains/program/apache.te	2005-04-29 13:38:49.000000000 -0400
@@ -233,7 +233,9 @@
 allow httpd_t bin_t:dir search;
 allow httpd_t sbin_t:dir search;
 allow httpd_t httpd_log_t:dir remove_name;
-r_dir_file(httpd_t, fonts_t)
+
+read_fonts(httpd_t)
+read_mime_types(httpd_t)
 
 allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 
diff -aru policy.old/domains/program/cups.te policy/domains/program/cups.te
--- policy.old/domains/program/cups.te	2005-04-29 13:41:57.000000000 -0400
+++ policy/domains/program/cups.te	2005-04-29 13:42:09.000000000 -0400
@@ -112,7 +112,7 @@
 can_exec(cupsd_t, { shell_exec_t bin_t sbin_t })
 
 # They will also invoke ghostscript, which needs to read fonts
-r_dir_file(cupsd_t, fonts_t)
+read_fonts(cupsd_t)
 
 # Read /usr/lib/gconv/gconv-modules.* and /usr/lib/python2.2/.*
 allow cupsd_t lib_t:file { read getattr };
diff -aru policy.old/domains/program/fontconfig.te policy/domains/program/fontconfig.te
--- policy.old/domains/program/fontconfig.te	2005-04-13 21:52:20.000000000 -0400
+++ policy/domains/program/fontconfig.te	2005-04-13 20:00:52.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in fontconfig_macros.te
diff -aru policy.old/domains/program/gconf.te policy/domains/program/gconf.te
--- policy.old/domains/program/gconf.te	2005-04-18 10:34:55.000000000 -0400
+++ policy/domains/program/gconf.te	2005-04-18 11:18:23.000000000 -0400
@@ -0,0 +1,12 @@
+# DESC - GConf preference daemon
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executable
+type gconfd_exec_t, file_type, exec_type, sysadmfile;
+
+# Type for /etc files
+type gconf_etc_t, file_type, sysadmfile;
+
+# Everything else is in macros/gconfd_macros.te
diff -aru policy.old/domains/program/gnome.te policy/domains/program/gnome.te
--- policy.old/domains/program/gnome.te	2005-04-13 21:52:20.000000000 -0400
+++ policy/domains/program/gnome.te	2005-04-13 19:30:07.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in gnome_macros.te
diff -aru policy.old/domains/program/gnome_vfs.te policy/domains/program/gnome_vfs.te
--- policy.old/domains/program/gnome_vfs.te	2005-04-29 17:14:21.000000000 -0400
+++ policy/domains/program/gnome_vfs.te	2005-04-29 17:12:48.000000000 -0400
@@ -0,0 +1,9 @@
+# DESC - GNOME-vfs daemon
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executable
+type gnome_vfsd_exec_t, file_type, exec_type, sysadmfile;
+
+# Everything else is in macros/gnome_vfsd_macros.te
diff -aru policy.old/domains/program/lpd.te policy/domains/program/lpd.te
--- policy.old/domains/program/lpd.te	2005-04-29 13:41:38.000000000 -0400
+++ policy/domains/program/lpd.te	2005-04-29 13:41:47.000000000 -0400
@@ -20,7 +20,7 @@
 
 allow lpd_t lpd_var_run_t:sock_file create_file_perms;
 
-r_dir_file(lpd_t, fonts_t)
+read_fonts(lpd_t)
 
 type printer_t, file_type, sysadmfile, dev_fs;
 
diff -aru policy.old/domains/program/mailcap.te policy/domains/program/mailcap.te
--- policy.old/domains/program/mailcap.te	2005-04-14 20:17:32.000000000 -0400
+++ policy/domains/program/mailcap.te	2005-04-14 21:10:34.000000000 -0400
@@ -0,0 +1,9 @@
+#
+# Mailcap related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+type mime_types_t, file_type, sysadmfile;
+
+# Look in mailcap_macros.te
diff -aru policy.old/domains/program/mount.te policy/domains/program/mount.te
--- policy.old/domains/program/mount.te	2005-04-29 19:05:18.000000000 -0400
+++ policy/domains/program/mount.te	2005-04-29 19:09:37.000000000 -0400
@@ -37,29 +37,9 @@
 
 # Mount, remount and unmount file systems.
 allow mount_t fs_type:filesystem mount_fs_perms;
-allow mount_t default_t:dir mounton;
-allow mount_t file_t:dir mounton;
-allow mount_t usr_t:dir mounton;
-allow mount_t src_t:dir mounton;
-allow mount_t var_t:dir mounton;
-allow mount_t proc_t:dir mounton;
-allow mount_t root_t:dir mounton;
-allow mount_t home_root_t:dir mounton;
-allow mount_t tmp_t:dir mounton;
-allow mount_t mnt_t:dir mounton;
-allow mount_t devpts_t:dir mounton;
-allow mount_t usbdevfs_t:dir mounton;
-allow mount_t sysfs_t:dir mounton;
-allow mount_t nfs_t:dir mounton;
+allow mount_t mount_point:dir mounton;
 allow mount_t nfs_t:dir search;
-# nfsv4 has a filesystem to mount for its userspace daemons
-allow mount_t var_lib_nfs_t:dir mounton;
-
-# On some RedHat systems, /boot is a mount point
-allow mount_t boot_t:dir mounton;
-allow mount_t device_t:dir mounton;
-# mount binfmt_misc on /proc/sys/fs/binfmt_misc
-allow mount_t sysctl_t:dir { mounton search };
+allow mount_t sysctl_t:dir search;
 
 allow mount_t root_t:filesystem unmount;
 
@@ -99,11 +79,7 @@
 allow mount_t userdomain:fd use;
 can_exec(mount_t, { sbin_t bin_t })
 allow mount_t device_t:dir r_dir_perms;
-ifdef(`distro_redhat', `
 allow mount_t tmpfs_t:chr_file { read write };
-allow mount_t tmpfs_t:dir mounton;
-')
-
 
 # tries to read /init
 dontaudit mount_t root_t:file { getattr read };
diff -aru policy.old/domains/program/orbit.te policy/domains/program/orbit.te
--- policy.old/domains/program/orbit.te	2005-04-29 15:02:05.000000000 -0400
+++ policy/domains/program/orbit.te	2005-04-29 15:01:13.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in orbit_macros.te
diff -aru policy.old/domains/program/rhgb.te policy/domains/program/rhgb.te
--- policy.old/domains/program/rhgb.te	2005-04-29 13:39:22.000000000 -0400
+++ policy/domains/program/rhgb.te	2005-04-29 13:41:16.000000000 -0400
@@ -43,9 +43,6 @@
 allow rhgb_t port_type:tcp_socket name_connect;
 can_ypbind(rhgb_t)
 
-# for fonts
-allow rhgb_t usr_t:{ file lnk_file } { getattr read };
-
 # for running setxkbmap
 r_dir_file(rhgb_t, xkb_var_lib_t)
 
@@ -68,8 +65,7 @@
 tmpfs_domain(rhgb)
 allow xdm_xserver_t rhgb_tmpfs_t:file { read write };
 
-allow rhgb_t fonts_t:dir { getattr read search };
-allow rhgb_t fonts_t:file { getattr read };
+read_fonts(rhgb_t)
 
 # for nscd
 dontaudit rhgb_t var_t:dir search;
diff -aru policy.old/domains/program/xdm.te policy/domains/program/xdm.te
--- policy.old/domains/program/xdm.te	2005-04-29 13:42:37.000000000 -0400
+++ policy/domains/program/xdm.te	2005-04-30 08:09:36.000000000 -0400
@@ -225,7 +225,9 @@
 
 # Read /usr/share/terminfo/l/linux and /usr/share/icons/default/index.theme...
 allow xdm_t usr_t:{ lnk_file file } { getattr read };
-r_dir_file(xdm_t, fonts_t)
+
+# Read fonts
+read_fonts(xdm_t)
 
 # Do not audit attempts to write to index files under /usr
 dontaudit xdm_t usr_t:file write;
diff -aru policy.old/domains/program/xfs.te policy/domains/program/xfs.te
--- policy.old/domains/program/xfs.te	2005-04-29 13:43:48.000000000 -0400
+++ policy/domains/program/xfs.te	2005-04-29 13:44:23.000000000 -0400
@@ -37,9 +37,8 @@
 allow xfs_t self:unix_stream_socket create_stream_socket_perms;
 allow xfs_t self:unix_dgram_socket create_socket_perms;
 
-# Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
-allow xfs_t fonts_t:dir search;
-allow xfs_t fonts_t:file { getattr read };
+# Read fonts
+read_fonts(xfs_t)
 
 # Unlink the xfs socket.
 allow initrc_t xfs_tmp_t:dir rw_dir_perms;
diff -aru policy.old/file_contexts/program/gconf.fc policy/file_contexts/program/gconf.fc
--- policy.old/file_contexts/program/gconf.fc	2005-04-18 10:39:41.000000000 -0400
+++ policy/file_contexts/program/gconf.fc	2005-04-27 16:04:00.000000000 -0400
@@ -0,0 +1,5 @@
+/usr/libexec/gconfd-2	--	system_u:object_r:gconfd_exec_t
+/etc/gconf(/.*)?		system_u:object_r:gconf_etc_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_gconf_data_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_gconfd_home_t
+/tmp/gconfd-USER	system_u:object_r:ROLE_gconfd_tmp_t
diff -aru policy.old/file_contexts/program/gnome.fc policy/file_contexts/program/gnome.fc
--- policy.old/file_contexts/program/gnome.fc	2005-04-13 21:52:10.000000000 -0400
+++ policy/file_contexts/program/gnome.fc	2005-04-29 14:45:45.000000000 -0400
@@ -0,0 +1,9 @@
+HOME_DIR/\.gnome(2)?(/.*)?		system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?_private?(/.*)?		system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome2/share/fonts(/.*)?             system_u:object_r:ROLE_fonts_t
+HOME_DIR/\.gnome2/share/cursor-fonts(/.*)?      system_u:object_r:ROLE_fonts_t
+HOME_DIR/\.gtk-bookmarks	--	system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.local(/.*)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.themes(/.)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.icons(/.*)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.thumbnails(/.*)?	system_u:object_r:ROLE_gnome_data_t
diff -aru policy.old/file_contexts/program/gnome_vfs.fc policy/file_contexts/program/gnome_vfs.fc
--- policy.old/file_contexts/program/gnome_vfs.fc	2005-04-29 17:14:28.000000000 -0400
+++ policy/file_contexts/program/gnome_vfs.fc	2005-04-29 17:15:50.000000000 -0400
@@ -0,0 +1 @@
+/usr/libexec/gnome-vfs-daemon	--	system_u:object_r:gnome_vfsd_exec_t
diff -aru policy.old/file_contexts/program/mailcap.fc policy/file_contexts/program/mailcap.fc
--- policy.old/file_contexts/program/mailcap.fc	2005-04-14 20:17:39.000000000 -0400
+++ policy/file_contexts/program/mailcap.fc	2005-04-15 03:36:56.000000000 -0400
@@ -0,0 +1,8 @@
+#
+# Mime types
+#
+
+/etc/mailcap	--	system_u:object_r:mime_types_t
+/etc/mime.types	--	system_u:object_r:mime_types_t
+HOME_DIR/\.mailcap	--	system_u:object_r:ROLE_mime_types_t
+HOME_DIR/\.mime\.types	--	system_u:object_r:ROLE_mime_types_t
diff -aru policy.old/file_contexts/program/mozilla.fc policy/file_contexts/program/mozilla.fc
--- policy.old/file_contexts/program/mozilla.fc	2005-04-13 21:02:52.000000000 -0400
+++ policy/file_contexts/program/mozilla.fc	2005-04-18 10:49:45.000000000 -0400
@@ -3,9 +3,6 @@
 HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_home_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
diff -aru policy.old/file_contexts/program/orbit.fc policy/file_contexts/program/orbit.fc
--- policy.old/file_contexts/program/orbit.fc	2005-04-29 10:47:07.000000000 -0400
+++ policy/file_contexts/program/orbit.fc	2005-04-29 15:02:32.000000000 -0400
@@ -0,0 +1,2 @@
+/tmp/orbit-USER         -d      system_u:object_r:ROLE_orbit_tmp_t
+/tmp/orbit-USER/bonobo.*        --      system_u:object_r:ROLE_orbit_tmp_t
diff -aru policy.old/file_contexts/types.fc policy/file_contexts/types.fc
--- policy.old/file_contexts/types.fc	2005-04-29 12:29:34.000000000 -0400
+++ policy/file_contexts/types.fc	2005-04-30 09:52:46.000000000 -0400
@@ -53,12 +53,14 @@
 HOME_ROOT		-d	system_u:object_r:home_root_t
 HOME_DIR		-d	system_u:object_r:ROLE_home_dir_t
 HOME_DIR/.+			system_u:object_r:ROLE_home_t
+HOME_DIR/downloads(/.*)?	system_u:object_r:ROLE_untrusted_content_t
+HOME_DIR/.*Downloads(/.*)?	system_u:object_r:ROLE_untrusted_content_t
 
 /root/\.default_contexts	-- 	system_u:object_r:default_context_t
 
 #
 # Mount points; do not relabel subdirectories, since
-# we don not want to change any removable media by default.
+# we don't want to change any removable media by default.
 /mnt(/[^/]*)?		-d	system_u:object_r:mnt_t
 /mnt/[^/]*/.*			<<none>>
 /media(/[^/]*)?		-d	system_u:object_r:mnt_t
@@ -388,17 +390,6 @@
 /usr/X11R6/man(/.*)?		system_u:object_r:man_t
 
 #
-# Fonts dir
-#
-/usr/X11R6/lib/X11/fonts(/.*)?		system_u:object_r:fonts_t
-ifdef(`distro_debian', `
-/var/lib/msttcorefonts(/.*)?		system_u:object_r:fonts_t
-')
-/usr/share/fonts(/.*)?			system_u:object_r:fonts_t
-/usr/share/ghostscript/fonts(/.*)?	system_u:object_r:fonts_t
-/usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
-
-#
 # /var/run
 #
 /var/run(/.*)?			system_u:object_r:var_run_t
diff -aru policy.old/macros/admin_macros.te policy/macros/admin_macros.te
--- policy.old/macros/admin_macros.te	2005-04-12 12:23:17.000000000 -0400
+++ policy/macros/admin_macros.te	2005-04-29 14:50:57.000000000 -0400
@@ -14,11 +14,17 @@
 #
 undefine(`admin_domain')
 define(`admin_domain',`
+
 # Type for home directory.
 attribute $1_file_type;
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
 type $1_home_t, file_type, sysadmfile, home_type, $1_file_type;
 
+# Type for network content.
+type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
+create_dir_file($1_t, $1_untrusted_content_t)
+allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+
 # Type and access for pty devices.
 can_create_pty($1, `, admin_tty_type')
 
diff -aru policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-04-29 12:20:50.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-04-30 10:10:18.000000000 -0400
@@ -68,14 +68,21 @@
 allow $1_t dri_device_t:chr_file getattr;
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
 
-file_browse_domain($1_t)
+# Supress ls denials:
+# getattr() - ls -l
+# search_dir() - symlink path resolution
+# read_dir() - deep ls: ls parent/...
+
+dontaudit_getattr($1_t)
+dontaudit_search_dir($1_t)
+dontaudit_read_dir($1_t)
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
 can_setfscreate($1_t)
 
 allow $1_t autofs_t:dir { search getattr };
@@ -176,7 +183,6 @@
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`samba.te', `samba_domain($1)')
-ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`startx.te', `xserver_domain($1)')
@@ -189,7 +195,17 @@
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
+
+# GNOME
+ifdef(`gnome.te', `
+gnome_domain($1)
+ifdef(`games.te', `games_domain($1)')
 ifdef(`gift.te', `gift_domains($1)')
+')
+
+# Fonts, mailcap - required stuff
+mailcap_domain($1)
+fontconfig_domain($1)
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
@@ -350,6 +366,10 @@
 allow $1_t default_t:notdevfile_class_set r_file_perms;
 }
 
+# Read mime types
+read_mime_types($1_t, $1)
+read_fonts($1_t, $1)
+
 read_sysctl($1_t);
 
 #
diff -aru policy.old/macros/global_macros.te policy/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-04-29 12:17:51.000000000 -0400
+++ policy/macros/global_macros.te	2005-04-30 10:05:12.000000000 -0400
@@ -156,7 +156,6 @@
 r_dir_file($1, locale_t)
 ')
 
-
 ###################################
 #
 # access_terminal(domain, typeprefix)
@@ -620,23 +619,25 @@
 allow $1_t etc_t:dir r_dir_perms;
 ')
 
-# Do not flood message log, if the user does a browse
-define(`file_browse_domain', `
+# Dontaudit macros to prevent flooding the log
 
-# Regular files/directories that are not security sensitive
+define(`dontaudit_getattr', `
 dontaudit $1 file_type - secure_file_type:dir_file_class_set getattr; 
-dontaudit $1 file_type - secure_file_type:dir { read search };
-
-# /dev
-dontaudit $1 dev_fs:dir_file_class_set getattr;
-dontaudit $1 dev_fs:dir { read search };
-
-# /proc
-dontaudit $1 sysctl_t:dir_file_class_set getattr;
-dontaudit $1 proc_fs:dir { read search };
-
-')dnl end file_browse_domain
-
+dontaudit $1 unlabeled_t:dir_file_class_set getattr;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir_file_class_set getattr;
+')dnl end dontaudit_getattr 
+
+define(`dontaudit_search_dir', `
+dontaudit $1 file_type - secure_file_type:dir search;
+dontaudit $1 unlabeled_t:dir search;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir search;
+')dnl end dontaudit_search_dir
+
+define(`dontaudit_read_dir', `
+dontaudit $1 file_type - secure_file_type:dir read;
+dontaudit $1 unlabeled_t:dir read;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir read;
+')dnl end dontaudit_read_dir
 
 # Define legacy_domain  for legacy binaries (java)
 # "legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
diff -aru policy.old/macros/program/apache_macros.te policy/macros/program/apache_macros.te
--- policy.old/macros/program/apache_macros.te	2005-04-29 13:45:39.000000000 -0400
+++ policy/macros/program/apache_macros.te	2005-04-29 13:46:23.000000000 -0400
@@ -101,7 +101,7 @@
 # Allow the scripts to read, read/write, append to the specified directories
 # or files
 ############################################################################
-r_dir_file(httpd_$1_script_t, fonts_t)
+read_fonts(httpd_$1_script_t)
 r_dir_file(httpd_$1_script_t, httpd_$1_script_ro_t)
 create_dir_file(httpd_$1_script_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_$1_script_t, httpd_$1_script_ra_t)
diff -aru policy.old/macros/program/fontconfig_macros.te policy/macros/program/fontconfig_macros.te
--- policy.old/macros/program/fontconfig_macros.te	2005-04-13 21:51:58.000000000 -0400
+++ policy/macros/program/fontconfig_macros.te	2005-04-30 10:11:53.000000000 -0400
@@ -0,0 +1,42 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# fontconfig_domain(role_prefix) - create fontconfig domain
+#
+# read_fonts(domain, role_prefix) - 
+#         allow domain to read fonts, optionally per/user
+#  
+# dontaudit_home_fonts(domain, role_prefix) - 
+#	block the denials of home fonts - hack for X
+
+define(`fontconfig_domain', `
+
+type $1_fonts_t, file_type, $1_file_type, sysadmfile, customizable;
+type $1_fonts_cache_t, file_type, $1_file_type, sysadmfile;
+
+allow $1_t $1_fonts_cache_t:file create_file_perms;
+create_dir_file($1_t, $1_fonts_t)
+
+') dnl gnome_domain
+
+define(`read_fonts', `
+r_dir_file($1, fonts_t)
+
+ifelse(`$2', `', `', `
+r_dir_file($1, $2_fonts_t)
+allow $1 $2_fonts_cache_t:file r_file_perms;
+dontaudit $1 $2_fonts_cache_t:file unlink;
+
+# There are some fonts in the .gnome2 folder
+allow $1 $2_gnome_settings_t:dir { getattr search };
+')
+')
+
+define(`dontaudit_home_fonts', `
+dontaudit $1 $2_gnome_settings_t:dir { getattr search };
+dontaudit $1 $2_fonts_cache_t:file r_file_perms;
+dontaudit $1 $2_fonts_t:dir r_dir_perms;
+dontaudit $1 $2_fonts_t:file r_file_perms;
+')
diff -aru policy.old/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.old/macros/program/games_domain.te	2005-04-14 16:34:49.000000000 -0400
+++ policy/macros/program/games_domain.te	2005-04-29 14:28:55.000000000 -0400
@@ -43,10 +43,14 @@
 can_udp_send($1_games_t, $1_games_t)
 can_tcp_connect($1_games_t, $1_games_t)
 
-# Access /home/user/.gnome2
-create_dir_file($1_games_t, $1_home_t)
+# Access /home/user/.gnome2, /home/user/.themes
+allow $1_games_t $1_gnome_settings_t:dir rw_dir_perms;
+allow $1_games_t $1_gnome_settings_t:file create_file_perms;
 allow $1_games_t $1_home_dir_t:dir { read getattr search };
-allow $1_games_t $1_home_t:dir { read getattr };
+r_dir_file($1_games_t, $1_gnome_data_t)
+
+# Connect to gconf
+gconf_client($1_games, $1)
 
 create_dir_file($1_games_t, $1_tmp_t)
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
diff -aru policy.old/macros/program/gconf_macros.te policy/macros/program/gconf_macros.te
--- policy.old/macros/program/gconf_macros.te	2005-04-18 10:34:50.000000000 -0400
+++ policy/macros/program/gconf_macros.te	2005-04-30 07:43:33.000000000 -0400
@@ -0,0 +1,67 @@
+#
+# GConfd daemon  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+#######################################
+# gconfd_domain(role_prefix)
+#
+
+define(`gconfd_domain', `
+
+# Type for daemon
+type $1_gconfd_t, domain, nscd_client_domain, privlog;
+
+# Type for .gconf data
+type $1_gconf_data_t, file_type, sysadmfile;
+
+# Transition from user type
+domain_auto_trans($1_t, gconfd_exec_t, $1_gconfd_t)
+role $1_r types $1_gconfd_t;
+
+allow $1_gconfd_t self:process getsched;
+
+uses_shlib($1_gconfd_t)
+read_locale($1_gconfd_t)
+read_sysctl($1_gconfd_t)
+
+# Access .gconfd and .gconf
+home_domain($1, gconfd)
+create_dir_file($1_gconfd_t, $1_gconf_data_t)
+
+# Access /etc/gconf
+r_dir_file($1_gconfd_t, gconf_etc_t)
+
+# Access /etc/nsswitch.conf
+allow $1_gconfd_t etc_t:file { read getattr };
+
+# /tmp/gconfd-USER
+tmp_domain($1_gconfd)
+
+# ORBit
+orbit_domain($1_gconfd, $1)
+
+# Read random device
+allow $1_gconfd_t urandom_device_t:chr_file { read getattr ioctl };
+
+') dnl gconf_domain
+
+#####################################
+# gconf_client(prefix, role_prefix)
+#
+
+define(`gconf_client', `
+
+# Launch the gconf daemon if necessary
+domain_auto_trans($1_t, gconfd_exec_t, $2_gconfd_t)
+
+# ORBit connection
+orbit_domain($1, $2)
+orbit_connect($1, $2_gconfd)
+
+# Read lock/ior
+allow $1_t $2_gconfd_tmp_t:dir { getattr search };
+allow $1_t $2_gconfd_tmp_t:file { getattr read }; 
+
+') dnl gconf_client 
diff -aru policy.old/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.old/macros/program/gift_macros.te	2005-04-13 19:31:36.000000000 -0400
+++ policy/macros/program/gift_macros.te	2005-04-29 16:21:53.000000000 -0400
@@ -32,9 +32,15 @@
 
 # Self permissions
 allow $1_gift_t self:process getsched;
+allow $1_gift_t self:fifo_file { read write };
 
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
+r_dir_file($1_gift_t, $1_gnome_data_t)
+read_fonts($1_gift_t)
+
+# Connect to gconf
+gconf_client($1_gift, $1)
 
 # Launch gift daemon
 allow $1_gift_t bin_t:dir search;
@@ -53,23 +59,9 @@
 allow $1_gift_t etc_t:file { getattr read };
 allow $1_gift_t etc_runtime_t:file { getattr read };
 
-# Tmp/ORBit
-tmp_domain($1_gift)
-file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
-can_unix_connect($1_t, $1_gift_t)
-can_unix_connect($1_gift_t, $1_t)
-allow $1_t $1_gift_tmp_t:sock_file write;
-allow $1_gift_t $1_tmp_t:file { getattr read write lock };
-allow $1_gift_t $1_tmp_t:sock_file { read write };
-dontaudit $1_gift_t $1_tmp_t:dir setattr;
-
 # Access random device
 allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
 
-# giftui looks in .icons, .themes, .fonts-cache.
-dontaudit $1_gift_t $1_home_t:dir { getattr read search };
-dontaudit $1_gift_t $1_home_t:file { getattr read unlink };
-
 ') dnl gift_domain
 
 ##########################
@@ -102,9 +94,12 @@
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
+
+# Allow gift to create untrusted content
+create_dir_file($1_giftd_t, $1_untrusted_content_t)
 	
 # Allow networking
-allow $1_giftd_t port_t:tcp_socket name_bind;
+allow $1_giftd_t port_t:tcp_socket { name_bind name_connect };
 allow $1_giftd_t port_t:udp_socket name_bind;
 can_network_server($1_giftd_t)
 can_network_client($1_giftd_t)
diff -aru policy.old/macros/program/gnome_macros.te policy/macros/program/gnome_macros.te
--- policy.old/macros/program/gnome_macros.te	2005-04-13 21:51:55.000000000 -0400
+++ policy/macros/program/gnome_macros.te	2005-04-30 07:48:18.000000000 -0400
@@ -0,0 +1,22 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# gnome_domain(role_prefix) - create GNOME domain
+
+define(`gnome_domain', `
+
+type $1_gnome_settings_t, file_type, $1_file_type, sysadmfile;
+type $1_gnome_data_t, file_type, $1_file_type, sysadmfile;
+
+create_dir_file($1_t, $1_gnome_settings_t)
+create_dir_file($1_t, $1_gnome_data_t)
+
+gconfd_domain($1)
+gconf_client($1, $1)
+gnome_vfs_domain($1)
+gnome_vfs_client($1, $1)
+orbit_domain($1)
+
+') dnl gnome_domain
diff -aru policy.old/macros/program/gnome_vfs_macros.te policy/macros/program/gnome_vfs_macros.te
--- policy.old/macros/program/gnome_vfs_macros.te	2005-04-29 17:14:13.000000000 -0400
+++ policy/macros/program/gnome_vfs_macros.te	2005-04-30 07:55:47.000000000 -0400
@@ -0,0 +1,76 @@
+#
+# Gnome-vfs daemon  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+#######################################
+# gnome_vfs_domain(role_prefix)
+#
+
+define(`gnome_vfs_domain', `
+
+# Type for daemon
+type $1_gnome_vfsd_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, gnome_vfsd_exec_t, $1_gnome_vfsd_t)
+role $1_r types $1_gnome_vfsd_t;
+
+uses_shlib($1_gnome_vfsd_t)
+read_locale($1_gnome_vfsd_t)
+read_sysctl($1_gnome_vfsd_t)
+
+# Read /proc/mounts
+allow $1_gnome_vfsd_t self:dir search;
+allow $1_gnome_vfsd_t self:file { getattr read };
+allow $1_gnome_vfsd_t proc_t:dir search;
+allow $1_gnome_vfsd_t proc_t:{ file lnk_file } read ;
+
+# Read /etc/fstab, /etc/nsswitch.conf, /etc/mtab
+allow $1_gnome_vfsd_t etc_t:file { read getattr };
+allow $1_gnome_vfsd_t etc_runtime_t:file { read getattr };
+
+# Allow getattr on mount points
+allow $1_gnome_vfsd_t mount_point:dir getattr;
+
+# Connect to dbus
+dbusd_client(system, $1_gnome_vfsd)
+
+# Connect to gconf
+gconf_client($1_gnome_vfsd, $1)
+
+# Access .gnome2
+allow $1_gnome_vfsd_t home_root_t:dir search;
+allow $1_gnome_vfsd_t $1_home_dir_t:dir search;
+allow $1_gnome_vfsd_t $1_gnome_settings_t:dir { getattr search };
+
+# ORBit domain. 
+orbit_domain($1_gnome_vfsd, $1)
+
+# Read random device
+allow $1_gnome_vfsd_t urandom_device_t:chr_file { read getattr ioctl };
+
+# /tmp access (?) 
+allow $1_gnome_vfsd_t tmp_t:dir { read getattr search };
+
+# Fork
+allow $1_gnome_vfsd_t self:process { getsched fork sigchld };
+allow $1_gnome_vfsd_t self:fifo_file rw_file_perms;
+
+') dnl gnome_vfs_domain
+
+#####################################
+# gnome_vfs_client(prefix, role_prefix)
+#
+
+define(`gnome_vfs_client', `
+
+# Launch the gnome vfs daemon if necessary
+domain_auto_trans($1_t, gnome_vfsd_exec_t, $2_gnome_vfsd_t)
+
+# ORBit connection
+orbit_domain($1, $2)
+orbit_connect($1, $2_gnome_vfsd)
+
+') dnl gnome_vfs_client 
diff -aru policy.old/macros/program/gpg_agent_macros.te policy/macros/program/gpg_agent_macros.te
--- policy.old/macros/program/gpg_agent_macros.te	2005-04-14 20:57:52.000000000 -0400
+++ policy/macros/program/gpg_agent_macros.te	2005-04-14 20:58:18.000000000 -0400
@@ -89,7 +89,7 @@
 allow $1_gpg_pinentry_t xdm_t:fd use;
 ')dnl end ig xdm.te
 
-r_dir_file($1_gpg_pinentry_t, fonts_t)
+read_fonts($1_gpg_pinentry_t, $1)
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
 
diff -aru policy.old/macros/program/java_macros.te policy/macros/program/java_macros.te
--- policy.old/macros/program/java_macros.te	2005-04-14 20:56:47.000000000 -0400
+++ policy/macros/program/java_macros.te	2005-04-29 14:42:57.000000000 -0400
@@ -4,7 +4,7 @@
 # Macros for javaplugin (java plugin) domains.
 #
 #
-# javaplugin_domain(domain_prefix, user)
+# javaplugin_domain(domain_prefix, role)
 #
 # Define a derived domain for the javaplugin program when executed by
 # a web browser.  
@@ -44,7 +44,8 @@
 allow $1_javaplugin_t sysctl_vm_t:dir search;
 
 tmp_domain($1_javaplugin)
-r_dir_file($1_javaplugin_t,{ fonts_t usr_t etc_t })
+read_fonts($1_javaplugin_t, $2)
+r_dir_file($1_javaplugin_t,{ usr_t etc_t })
 
 # Search bin directory under javaplugin for javaplugin executable
 allow $1_javaplugin_t bin_t:dir search;
@@ -91,7 +92,4 @@
 dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
 dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
-# Do not audit read/getattr of .fonts-cache-1
-dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
-
 ')
diff -aru policy.old/macros/program/mailcap_macros.te policy/macros/program/mailcap_macros.te
--- policy.old/macros/program/mailcap_macros.te	2005-04-14 20:17:26.000000000 -0400
+++ policy/macros/program/mailcap_macros.te	2005-04-29 15:32:36.000000000 -0400
@@ -0,0 +1,25 @@
+#
+# Mailcap related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# mailcap_domain(role_prefix) - create mailcap domain
+#
+# read_mime_types(domain, role_prefix) - 
+#         allow domain to read mime types, optionally per/user
+
+define(`mailcap_domain', `
+
+type $1_mime_types_t, file_type, $1_file_type, sysadmfile;
+
+create_dir_file($1_t, $1_mime_types_t)
+
+') dnl gnome_domain
+
+define(`read_mime_types', `
+allow $1 mime_types_t:file r_file_perms;
+ifelse(`$2', `', `', `
+allow $1 $2_mime_types_t:file r_file_perms;
+')
+')
+
diff -aru policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-04-23 20:25:40.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-04-30 10:15:40.000000000 -0400
@@ -16,7 +16,9 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-type $1_mozilla_t, domain, web_client_domain, privlog;
+
+type $1_mozilla_t, domain, web_client_domain, nscd_client_domain, privlog;
+type $1_mozilla_tmp_t, file_type, sysadmfile, tmpfile;
 
 # Type transition
 if (! disable_mozilla_trans) {
@@ -28,8 +30,12 @@
 home_domain($1, mozilla)
 x_client_domain($1_mozilla, $1)
 
-# Browse files
-file_browse_domain($1_mozilla_t)
+# GNOME Open/Save As dialogs
+dontaudit_getattr($1_mozilla_t)
+dontaudit_search_dir($1_mozilla_t)
+
+# Look for plugins 
+allow $1_mozilla_t bin_t:dir { getattr read search };
 
 can_network_client($1_mozilla_t)
 allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
@@ -53,7 +59,24 @@
 # Fork, set resource limits and scheduling info.
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
+# Fonts, icons
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
+read_fonts($1_mozilla_t, $1)
+read_mime_types($1_mozilla_t, $1)
+
+# GNOME integration
+ifdef(`gnome.te', `
+allow $1_mozilla_t $1_gnome_settings_t:dir { search getattr };
+r_dir_file($1_mozilla_t, $1_gnome_data_t)
+gconf_client($1_mozilla, $1)
+gnome_vfs_client($1_mozilla, $1)
+')
+
+# Access /proc
+allow $1_mozilla_t proc_t:dir search;
+allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
@@ -66,8 +89,6 @@
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t proc_t:file { getattr read };
-allow $1_mozilla_t proc_t:lnk_file read;
 allow $1_mozilla_t self:dir search;
 allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
@@ -81,47 +102,12 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Write files to tmp
-tmp_domain($1_mozilla)
+# Allow mozilla to create untrusted content
+create_dir_file($1_mozilla_t, $1_untrusted_content_t)
+file_type_auto_trans($1_mozilla_t, tmp_t, $1_untrusted_content_t)
 
 # Execute downloaded programs.
-can_exec($1_mozilla_t, $1_mozilla_tmp_t)
-
-# Use printer
-ifdef(`lpr.te', `
-domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-
-# Print document
-allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
-
-# Suppress history.fop denial
-dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
-
-dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
-dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
-')
-
-# ORBit sockets
-file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
-can_unix_connect($1_t, $1_mozilla_t)
-allow $1_t $1_mozilla_tmp_t:sock_file write;
-allow $1_mozilla_t $1_tmp_t:file { read write lock };
-allow $1_mozilla_t $1_tmp_t:sock_file { read write };
-dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
-
-# Allow mozilla to read user home content
-if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, $1_home_t)
-} else {
-dontaudit $1_mozilla_t $1_home_t:dir setattr;
-dontaudit $1_mozilla_t $1_home_t:file setattr;
-}
-
-if (mozilla_writehome) {
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t)
-allow $1_mozilla_t $1_home_t:dir setattr;
-allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
-} dnl end if writehome
+can_exec($1_mozilla_t, $1_untrusted_content_t)
 
 allow $1_mozilla_t $1_t:unix_stream_socket connectto;
 allow $1_mozilla_t sysctl_net_t:dir search;
@@ -135,8 +121,7 @@
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
-# Mozilla tries to delete .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file unlink;
+
 allow $1_mozilla_t self:sem create_sem_perms;
 
 # Java plugin
@@ -144,16 +129,32 @@
 javaplugin_domain($1_mozilla, $1)
 ')
 
+
+# Use printer
+ifdef(`lpr.te', `
+domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
+
+# Print document
+allow $1_lpr_t $1_untrusted_content_t:file rw_file_perms;
+
+# Suppress history.fop denial
+dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+
+dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
+dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
+')
+
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
 
 # Read mozilla content in /tmp
-r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
+r_dir_file($1_mplayer_t, $1_untrusted_content_t);
 
-# FIXME: why does it need this?
+# Suppress history.fop denial
 dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
-allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+
+dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
 if (allow_execmem) {
@@ -162,6 +163,7 @@
 if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
+
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `
diff -aru policy.old/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-04-30 09:13:55.000000000 -0400
+++ policy/macros/program/mplayer_macros.te	2005-04-30 10:50:58.000000000 -0400
@@ -6,9 +6,9 @@
 # mplayer_domains(user) declares domains for mplayer, gmplayer,
 # and mencoder
 
-##############################################
-#    mplayer_common(user, mplayer domain)    #
-##############################################
+#####################################################
+#    mplayer_common(role_prefix, mplayer_domain)    #
+#####################################################
 
 define(`mplayer_common',`
 
@@ -62,28 +62,28 @@
 }
 ')
 
-############################
-#  mplayer_domain(user)    #
-############################
+###################################
+#  mplayer_domain(role_prefix)    #
+###################################
 
 define(`mplayer_domain',`
 
-type $1_mplayer_t, domain;
+type $1_mplayer_t, domain, nscd_client_domain;
 
 # Type transition
 domain_auto_trans($1_t, mplayer_exec_t, $1_mplayer_t)
 role $1_r types $1_mplayer_t;
 
-# Home access, X access, Browse files
+# Home access, X access
 home_domain($1, mplayer)
 x_client_domain($1_mplayer, $1)
-file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
 mplayer_common($1, mplayer)
 
 # Fork 
 allow $1_mplayer_t self:process { fork signal_perms getsched };
+allow $1_mplayer_t self:fifo_file rw_file_perms;
 
 # Audio, alsa.conf
 allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
@@ -101,11 +101,35 @@
 allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
 }
 
+#======gmplayer gui==========#
+# File dialogs
+dontaudit_getattr($1_mplayer_t)
+dontaudit_read_dir($1_mplayer_t)
+dontaudit_search_dir($1_mplayer_t)
+
+# Unfortunately the ancient file dialog starts in /
+allow $1_mplayer_t home_root_t:dir read;
+
+# Icons..
+ifdef(`gnome.te', `
+r_dir_file($1_mplayer_t, $1_gnome_data_t)
+')
+
+# Read /etc/mtab
+allow $1_mplayer_t etc_runtime_t:file { read getattr };
+
+# Run bash/sed (??) 
+allow $1_mplayer_t bin_t:dir search;
+allow $1_mplayer_t bin_t:lnk_file read;
+can_exec($1_mplayer_t, bin_t)
+can_exec($1_mplayer_t, shell_exec_t)
+#============================#
+
 ') dnl end mplayer_domain
 
-############################
-#  mencoder_domain(user)   #
-############################
+###################################
+#  mencoder_domain(role_prefix)   #
+###################################
 
 define(`mencoder_domain',`
 
@@ -125,7 +149,7 @@
 ') dnl end mencoder_domain
 
 #############################
-#  mplayer_domains(user)    #
+#  mplayer_domains(role)    #
 #############################
 
 define(`mplayer_domains', `
diff -aru policy.old/macros/program/orbit_macros.te policy/macros/program/orbit_macros.te
--- policy.old/macros/program/orbit_macros.te	2005-04-29 15:01:27.000000000 -0400
+++ policy/macros/program/orbit_macros.te	2005-04-30 08:06:42.000000000 -0400
@@ -0,0 +1,28 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# orbit_domain(prefix, role) - create ORBit sockets
+# orbit_connect(type1, type2) - allow communication through ORBit sockets 
+
+define(`orbit_domain', `
+ifdef(`$1_orbit_tmp_t_defined',`', `
+define(`$1_orbit_tmp_t_defined')
+type $1_orbit_tmp_t, file_type, sysadmfile;
+file_type_auto_trans($1_t, $2_orbit_tmp_t, $1_orbit_tmp_t, sock_file)
+
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_t self:unix_dgram_socket create_socket_perms;
+
+allow $1_t $2_orbit_tmp_t:file { getattr read write lock };
+dontaudit $1_t $2_orbit_tmp_t:dir setattr;
+')
+')
+
+define(`orbit_connect', `
+can_unix_connect($1_t, $2_t)
+can_unix_connect($2_t, $1_t)
+allow $1_t $2_orbit_tmp_t:sock_file { read write };
+allow $2_t $1_orbit_tmp_t:sock_file { read write };
+')
diff -aru policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-04-14 20:55:18.000000000 -0400
+++ policy/macros/program/x_client_macros.te	2005-04-14 20:55:51.000000000 -0400
@@ -74,7 +74,7 @@
 allow $1_t self:shm create_shm_perms;
 
 # allow X client to read all font files
-r_dir_file($1_t, fonts_t)
+read_fonts($1_t, $2)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
diff -aru policy.old/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- policy.old/macros/program/xserver_macros.te	2005-04-29 12:22:20.000000000 -0400
+++ policy/macros/program/xserver_macros.te	2005-04-30 10:11:40.000000000 -0400
@@ -79,6 +79,14 @@
 allow xdm_xserver_t init_t:fd use;
 
 dontaudit xdm_xserver_t home_dir_type:dir { read search };
+
+# Suppress fonts denials
+dontaudit_home_fonts(xdm_xserver_t, user)
+dontaudit_home_fonts(xdm_xserver_t, staff)
+dontaudit_home_fonts(xdm_xserver_t, sysadm)
+
+# Read global fonts
+read_fonts(xdm_xserver_t)
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
@@ -95,9 +103,15 @@
 # Access the home directory.
 allow $1_xserver_t home_root_t:dir search;
 allow $1_xserver_t $1_home_dir_t:dir { getattr search };
+
+# Suppress fonts denials
+dontaudit_home_fonts($1_xserver_t, $1)
+
+# Now re-enable according to boolean
 if (allow_xserver_home_fonts) {
-r_dir_file($1_xserver_t, $1_home_t)
-}
+read_fonts($1_xserver_t, $1)
+} 
+
 ifdef(`xauth.te', `
 domain_auto_trans($1_xserver_t, xauth_exec_t, $1_xauth_t)
 allow $1_xserver_t $1_xauth_home_t:file { getattr read };
@@ -263,8 +277,6 @@
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, xkb_var_lib_t)
 
-# for fonts
-r_dir_file($1_xserver_t, fonts_t)
 ')dnl end macro definition
 
 ', `
diff -aru policy.old/macros/user_macros.te policy/macros/user_macros.te
--- policy.old/macros/user_macros.te	2005-04-12 12:23:06.000000000 -0400
+++ policy/macros/user_macros.te	2005-04-29 14:51:14.000000000 -0400
@@ -21,6 +21,11 @@
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type;
 
+# Type for network content.
+type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
+create_dir_file($1_t, $1_untrusted_content_t)
+allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+
 tmp_domain($1, `, user_tmpfile, $1_file_type', `{ file lnk_file dir sock_file fifo_file }')
 
 base_user_domain($1)
diff -aru policy.old/types/device.te policy/types/device.te
--- policy.old/types/device.te	2005-04-29 19:03:41.000000000 -0400
+++ policy/types/device.te	2005-04-30 09:21:38.000000000 -0400
@@ -10,7 +10,7 @@
 #
 # device_t is the type of /dev.
 #
-type device_t, file_type, dev_fs;
+type device_t, file_type, mount_point, dev_fs;
 
 #
 # null_device_t is the type of /dev/null.
diff -aru policy.old/types/devpts.te policy/types/devpts.te
--- policy.old/types/devpts.te	2005-04-29 19:01:33.000000000 -0400
+++ policy/types/devpts.te	2005-04-30 09:19:37.000000000 -0400
@@ -16,6 +16,6 @@
 # devpts_t is the type of the devpts file system and 
 # the type of the root directory of the file system.
 #
-type devpts_t, fs_type;
+type devpts_t, mount_point, fs_type;
 
 
diff -aru policy.old/types/file.te policy/types/file.te
--- policy.old/types/file.te	2005-04-29 18:52:14.000000000 -0400
+++ policy/types/file.te	2005-04-30 09:22:36.000000000 -0400
@@ -23,37 +23,37 @@
 type eventpollfs_t, fs_type;
 type futexfs_t, fs_type;
 type bdev_t, fs_type;
-type usbfs_t, fs_type;
+type usbfs_t, mount_point, fs_type;
 type nfsd_fs_t, fs_type;
 type rpc_pipefs_t, fs_type;
-type binfmt_misc_fs_t, fs_type;
+type binfmt_misc_fs_t, mount_point, fs_type;
 
 #
 # file_t is the default type of a file that has not yet been
 # assigned an extended attribute (EA) value (when using a filesystem
 # that supports EAs).
 #
-type file_t, file_type, sysadmfile;
+type file_t, file_type, mount_point, sysadmfile;
 
 # default_t is the default type for files that do not
 # match any specification in the file_contexts configuration
 # other than the generic /.* specification.
-type default_t, file_type, sysadmfile;
+type default_t, file_type, mount_point, sysadmfile;
 
 #
 # root_t is the type for the root directory.
 #
-type root_t, file_type, sysadmfile;
+type root_t, file_type, mount_point, sysadmfile;
 
 #
 # mnt_t is the type for mount points such as /mnt/cdrom
-type mnt_t, file_type, sysadmfile;
+type mnt_t, file_type, mount_point, sysadmfile;
 
 #
 # home_root_t is the type for the directory where user home directories
 # are created
 #
-type home_root_t, file_type, sysadmfile;
+type home_root_t, file_type, mount_point, sysadmfile;
 
 #
 # lost_found_t is the type for the lost+found directories.
@@ -64,7 +64,7 @@
 # boot_t is the type for files in /boot,
 # including the kernel.
 #
-type boot_t, file_type, sysadmfile;
+type boot_t, file_type, mount_point, sysadmfile;
 # system_map_t is for the system.map files in /boot
 type system_map_t, file_type, sysadmfile;
 
@@ -77,7 +77,7 @@
 #
 # tmp_t is the type of /tmp and /var/tmp.
 #
-type tmp_t, file_type, sysadmfile, tmpfile;
+type tmp_t, file_type, mount_point, sysadmfile, tmpfile;
 
 #
 # etc_t is the type of the system etc directories.
@@ -171,17 +171,17 @@
 #
 # usr_t is the type for /usr.
 #
-type usr_t, file_type, sysadmfile;
+type usr_t, file_type, mount_point, sysadmfile;
 
 #
 # src_t is the type of files in the system src directories.
 #
-type src_t, file_type, sysadmfile;
+type src_t, file_type, mount_point, sysadmfile;
 
 #
 # var_t is the type for /var.
 #
-type var_t, file_type,  sysadmfile;
+type var_t, file_type, mount_point, sysadmfile;
 
 #
 # Types for subdirectories of /var.
@@ -190,7 +190,7 @@
 type var_log_t, file_type, sysadmfile, logfile;
 type faillog_t, file_type, sysadmfile, logfile;
 type var_lock_t, file_type, sysadmfile, lockfile;
-type var_lib_t, file_type, sysadmfile;
+type var_lib_t, mount_point, file_type, sysadmfile;
 # for /var/{spool,lib}/texmf index files
 type tetex_data_t, file_type, sysadmfile, tmpfile;
 type var_spool_t, file_type, sysadmfile, tmpfile;
@@ -203,7 +203,7 @@
 type lastlog_t, file_type, sysadmfile, logfile;
 
 # Type for /var/lib/nfs.
-type var_lib_nfs_t, file_type, sysadmfile, usercanread;
+type var_lib_nfs_t, file_type, mount_point, sysadmfile, usercanread;
 
 #
 # wtmp_t is the type of /var/log/wtmp.
@@ -275,7 +275,7 @@
 # Allow the pty to be associated with the file system.
 allow devpts_t self:filesystem associate;
 
-type tmpfs_t, file_type, sysadmfile, fs_type;
+type tmpfs_t, file_type, mount_point, sysadmfile, fs_type;
 allow { tmpfs_t tmpfile } tmpfs_t:filesystem associate;
 allow tmpfile tmp_t:filesystem associate;
 ifdef(`distro_redhat', `
@@ -285,10 +285,10 @@
 type autofs_t, fs_type, noexattrfile, sysadmfile;
 allow autofs_t self:filesystem associate;
 
-type usbdevfs_t, fs_type, noexattrfile, sysadmfile;
+type usbdevfs_t, fs_type, mount_point, noexattrfile, sysadmfile;
 allow usbdevfs_t self:filesystem associate;
 
-type sysfs_t, fs_type,  sysadmfile;
+type sysfs_t, mount_point, fs_type,  sysadmfile;
 allow sysfs_t self:filesystem associate;
 
 type iso9660_t, fs_type, noexattrfile, sysadmfile;
diff -aru policy.old/types/nfs.te policy/types/nfs.te
--- policy.old/types/nfs.te	2005-04-29 19:01:55.000000000 -0400
+++ policy/types/nfs.te	2005-04-29 19:02:02.000000000 -0400
@@ -13,7 +13,7 @@
 # The nfs_*_t types are used for specific NFS
 # servers in net_contexts or net_contexts.mls.
 #
-type nfs_t, fs_type;
+type nfs_t, mount_point, fs_type;
 
 #
 # Allow NFS files to be associated with an NFS file system.
diff -aru policy.old/types/procfs.te policy/types/procfs.te
--- policy.old/types/procfs.te	2005-04-29 19:00:33.000000000 -0400
+++ policy/types/procfs.te	2005-04-29 19:04:52.000000000 -0400
@@ -14,7 +14,7 @@
 # proc_mdstat_t is the type of /proc/mdstat.
 # proc_net_t is the type of /proc/net.
 #
-type proc_t, fs_type, proc_fs;
+type proc_t, fs_type, mount_point, proc_fs;
 type proc_kmsg_t, proc_fs;
 type proc_kcore_t, proc_fs;
 type proc_mdstat_t, proc_fs;
@@ -35,7 +35,7 @@
 # These types are applied to both the entries in
 # /proc/sys and the corresponding sysctl parameters.
 #
-type sysctl_t, sysctl_type;
+type sysctl_t, mount_point, sysctl_type;
 type sysctl_fs_t, sysctl_type;
 type sysctl_kernel_t, sysctl_type;
 type sysctl_modprobe_t, sysctl_type;
diff -aru policy.old/types/security.te policy/types/security.te
--- policy.old/types/security.te	2005-04-29 19:30:17.000000000 -0400
+++ policy/types/security.te	2005-04-29 19:30:26.000000000 -0400
@@ -12,7 +12,7 @@
 # the permissions in the security class.  It is also
 # applied to selinuxfs inodes.
 #
-type security_t, fs_type;
+type security_t, mount_point, fs_type;
 
 #
 # policy_config_t is the type of /etc/security/selinux/*

--=-NPF6RqkSNF0xLm2wZbN+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
