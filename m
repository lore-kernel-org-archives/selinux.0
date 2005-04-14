Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3E2Sj7C014308
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 22:28:45 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3E2MG1i029876
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 02:22:16 GMT
Subject: [ PATCH ] Cumulative patch - various fixes, untrusted_content_t,
	mozilla, gnome types
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-di3qLYJFinh3CcFhce9G"
Date: Wed, 13 Apr 2005 22:31:09 -0400
Message-Id: <1113445869.6139.52.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-di3qLYJFinh3CcFhce9G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Parts of this patch are rather controversial and might break things.
Please comment if anything needs to be changed.

Changelog:
==========

1) Introduces new type - ROLE_untrusted_content_t.
This will be the "downloads" folder type that I proposed earlier.
I started a discussion on the Gnome Usability list about further
separation, but so far it doesn't seem to be making progress.

Mozilla and gift gain the ability to create files of this type.
The parent folder must be manually created for mozilla (for now)
and already exists for giFT.

Mozilla has been changed to create files of this type under /tmp,
but under /tmp/orbit-* it still uses the old ROLE_mozilla_tmp_t type.

Mplayer and lpr are granted rights to read this "untrusted" type as
part of the mozilla policy. This may not be what we want, but 
that's what used to be the case before the patch - they could read
ROLE_mozilla_tmp_t.

2) Introduce new types for gnome - ROLE_gnome_settings_t, and
ROLE_gnome_data_t. This looks to me like too low level of granularity
for labeling, but I didn't know what would be appropriate - at
least it seems better than the existing types (ROLE_home_t, and
ROLE_mozilla_home_t (why mozilla for .gconf?))

Those types are used
for .gnome, .gnome2, .gnome_private, .gnome2_private, .gconf, 
.local, .thumbnails, .themes, .icons,

and are fully accessible from ROLE_t. However, now applications
can be granted access to this particular type, rather than
ROLE_home_t, or ROLE_mozilla_home_t.

3) Introduce new type for .fonts.cache-1 - ROLE_font_cache_t.
Change dontaudit for gift and mozilla to allow reading this file.

4) Miscellaneous fix: Allow load_policy to read /proc/filesystems,
or else it just refuses to load in enforcing mode.

5) Miscellaneous fix: Remove duplicate file label from inetd.fc 
that's causing trouble (uuico)

6) Grant the user the ability to relabel to/from directories of type
ROLE_home_t. Why not?

7) Add nscd_client_domain to mozilla, as it seems to be needed after all

8) Allow mozilla to search bin_t for plugins, and other minor stuff...

9) Is this going to be a problem?

-HOME_DIR/\.gconf(/.*)?         system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t

Mozilla refused to even start until
allowed to { search getattr } ROLE_gnome_settings_t, which is the
new type for those folders...


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-di3qLYJFinh3CcFhce9G
Content-Disposition: attachment; filename=cumulative.diff
Content-Type: text/x-patch; name=cumulative.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/domains/program/fontconfig.te policy/domains/program/fontconfig.te
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
diff -aur policy.old/domains/program/gnome.te policy/domains/program/gnome.te
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
diff -aur policy.old/domains/program/load_policy.te policy/domains/program/load_policy.te
--- policy.old/domains/program/load_policy.te	2005-04-13 20:49:03.000000000 -0400
+++ policy/domains/program/load_policy.te	2005-04-13 20:50:05.000000000 -0400
@@ -58,3 +58,6 @@
 
 read_locale(load_policy_t)
 r_dir_file(load_policy_t, selinux_config_t)
+
+# Read /proc/filesystems
+allow load_policy_t proc_t:file { read getattr };
diff -aur policy.old/file_contexts/program/fontconfig.fc policy/file_contexts/program/fontconfig.fc
--- policy.old/file_contexts/program/fontconfig.fc	2005-04-13 21:52:08.000000000 -0400
+++ policy/file_contexts/program/fontconfig.fc	2005-04-13 20:22:03.000000000 -0400
@@ -0,0 +1 @@
+HOME_DIR/\.fonts.cache-1            --       system_u:object_r:ROLE_fonts_cache_t
diff -aur policy.old/file_contexts/program/gnome.fc policy/file_contexts/program/gnome.fc
--- policy.old/file_contexts/program/gnome.fc	2005-04-13 21:52:10.000000000 -0400
+++ policy/file_contexts/program/gnome.fc	2005-04-13 21:27:04.000000000 -0400
@@ -0,0 +1,7 @@
+HOME_DIR/\.gconf(/.*)?                  system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?(/.*)?              system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?_private?(/.*)?     system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.local(/.*)?                  system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.themes(/.*)?                 system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.icons(/.*)?                  system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.thumbnails(/.*)?             system_u:object_r:ROLE_gnome_data_t
diff -aur policy.old/file_contexts/program/inetd.fc policy/file_contexts/program/inetd.fc
--- policy.old/file_contexts/program/inetd.fc	2005-04-13 21:09:16.000000000 -0400
+++ policy/file_contexts/program/inetd.fc	2005-04-13 21:09:29.000000000 -0400
@@ -3,7 +3,6 @@
 /usr/sbin/xinetd	--	system_u:object_r:inetd_exec_t
 /usr/sbin/rlinetd	--	system_u:object_r:inetd_exec_t
 /usr/sbin/identd	--	system_u:object_r:inetd_child_exec_t
-/usr/sbin/uucico	--	system_u:object_r:inetd_child_exec_t
 /usr/sbin/in\..*d	--	system_u:object_r:inetd_child_exec_t
 /var/log/(x)?inetd\.log	--	system_u:object_r:inetd_log_t
 /var/run/inetd\.pid	--	system_u:object_r:inetd_var_run_t
diff -aur policy.old/file_contexts/program/mozilla.fc policy/file_contexts/program/mozilla.fc
--- policy.old/file_contexts/program/mozilla.fc	2005-04-13 21:02:52.000000000 -0400
+++ policy/file_contexts/program/mozilla.fc	2005-04-13 21:03:26.000000000 -0400
@@ -4,8 +4,6 @@
 HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_home_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
diff -aur policy.old/macros/admin_macros.te policy/macros/admin_macros.te
--- policy.old/macros/admin_macros.te	2005-04-12 12:23:17.000000000 -0400
+++ policy/macros/admin_macros.te	2005-04-12 12:23:44.000000000 -0400
@@ -14,11 +14,16 @@
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
+
+
 # Type and access for pty devices.
 can_create_pty($1, `, admin_tty_type')
 
diff -aur policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-04-12 12:20:28.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-04-13 20:02:45.000000000 -0400
@@ -69,7 +69,7 @@
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
 can_setfscreate($1_t)
 
 allow $1_t autofs_t:dir { search getattr };
@@ -184,6 +184,8 @@
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
 ifdef(`gift.te', `gift_domains($1)')
+ifdef(`gnome.te', `gnome_domain($1)')
+ifdef(`fontconfig.te', `fontconfig_domain($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -aur policy.old/macros/program/fontconfig_macros.te policy/macros/program/fontconfig_macros.te
--- policy.old/macros/program/fontconfig_macros.te	2005-04-13 21:51:58.000000000 -0400
+++ policy/macros/program/fontconfig_macros.te	2005-04-13 20:47:58.000000000 -0400
@@ -0,0 +1,14 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# fontconfig_domain(role_prefix)
+
+define(`fontconfig_domain', `
+
+type $1_fonts_cache_t, file_type, $1_file_type, sysadmfile;
+
+create_dir_file($1_t, $1_fonts_cache_t)
+
+') dnl gnome_domain
diff -aur policy.old/macros/program/gnome_macros.te policy/macros/program/gnome_macros.te
--- policy.old/macros/program/gnome_macros.te	2005-04-13 21:51:55.000000000 -0400
+++ policy/macros/program/gnome_macros.te	2005-04-13 20:47:47.000000000 -0400
@@ -0,0 +1,16 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# gnome_domain(role_prefix)
+
+define(`gnome_domain', `
+
+type $1_gnome_settings_t, file_type, $1_file_type, sysadmfile;
+type $1_gnome_data_t, file_type, $1_file_type, sysadmfile;
+
+create_dir_file($1_t, $1_gnome_settings_t)
+create_dir_file($1_t, $1_gnome_data_t)
+
+') dnl gnome_domain
diff -aur policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-04-12 12:26:11.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-04-13 21:51:36.000000000 -0400
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
@@ -28,8 +30,9 @@
 home_domain($1, mozilla)
 x_client_domain($1_mozilla, $1)
 
-# Browse files 
+# Look for plugins 
 file_browse_domain($1_mozilla_t)
+allow $1_mozilla_t bin_t:dir { getattr read search };
 
 can_network_client($1_mozilla_t)
 allow $1_mozilla_t { ftp_port_t http_port_t }:tcp_socket name_connect;
@@ -53,7 +56,18 @@
 # Fork, set resource limits and scheduling info.
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
+# Fonts, icons
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
+r_dir_file($1_mozilla_t, $1_gnome_data_t)
+allow $1_mozilla_t $1_fonts_cache_t:file r_file_perms;
+dontaudit $1_mozilla_t $1_fonts_cache_t:file unlink;
+allow $1_mozilla_t $1_gnome_settings_t:dir { search getattr };
+
+# Access /proc
+allow $1_mozilla_t proc_t:dir search;
+allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
@@ -66,8 +80,6 @@
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t proc_t:file { getattr read };
-allow $1_mozilla_t proc_t:lnk_file read;
 allow $1_mozilla_t self:dir search;
 allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
@@ -81,47 +93,20 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Write files to tmp
-tmp_domain($1_mozilla)
-
-# Execute downloaded programs.
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
 # ORBit sockets
 file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
 can_unix_connect($1_t, $1_mozilla_t)
 allow $1_t $1_mozilla_tmp_t:sock_file write;
-allow $1_mozilla_t $1_tmp_t:file { read write lock };
+allow $1_mozilla_t $1_tmp_t:file { getattr read write lock };
 allow $1_mozilla_t $1_tmp_t:sock_file { read write };
 dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
 
-# Allow mozilla to read user home content
-if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, $1_home_t)
-} else {
-dontaudit $1_mozilla_t $1_home_t:dir setattr;
-dontaudit $1_mozilla_t $1_home_t:file setattr;
-}
+# Allow mozilla to create untrusted content
+create_dir_file($1_mozilla_t, $1_untrusted_content_t)
+file_type_auto_trans($1_mozilla_t, tmp_t, $1_untrusted_content_t)
 
-if (mozilla_writehome) {
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t)
-allow $1_mozilla_t $1_home_t:dir setattr;
-allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
-} dnl end if writehome
+# Execute downloaded programs.
+can_exec($1_mozilla_t, $1_untrusted_content_t)
 
 allow $1_mozilla_t $1_t:unix_stream_socket connectto;
 allow $1_mozilla_t sysctl_net_t:dir search;
@@ -135,8 +120,7 @@
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
-# Mozilla tries to delete .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file unlink;
+
 allow $1_mozilla_t self:sem create_sem_perms;
 
 # Java plugin
@@ -144,16 +128,32 @@
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
@@ -162,6 +162,7 @@
 if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
+
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `
diff -aur policy.old/macros/user_macros.te policy/macros/user_macros.te
--- policy.old/macros/user_macros.te	2005-04-12 12:23:06.000000000 -0400
+++ policy/macros/user_macros.te	2005-04-12 12:23:30.000000000 -0400
@@ -21,6 +21,9 @@
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type;
 
+# Type for network content.
+type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
+
 tmp_domain($1, `, user_tmpfile, $1_file_type', `{ file lnk_file dir sock_file fifo_file }')
 
 base_user_domain($1)

--=-di3qLYJFinh3CcFhce9G--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
