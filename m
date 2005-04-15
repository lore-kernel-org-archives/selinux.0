Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3F1hi7C023200
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 21:43:44 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3F1duJd000989
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 01:39:56 GMT
Subject: [ PATCH ] restrict_home
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1113450153.10622.3.camel@cobra.ivg2.net>
References: <1113445869.6139.52.camel@cobra.ivg2.net>
	 <1113450153.10622.3.camel@cobra.ivg2.net>
Content-Type: multipart/mixed; boundary="=-G4oJFBwol8JVudTJHvB9"
Date: Thu, 14 Apr 2005 21:46:00 -0400
Message-Id: <1113529561.22664.15.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-G4oJFBwol8JVudTJHvB9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-04-13 at 23:42 -0400, Ivan Gyurdiev wrote:
> Ok I see the first thing that's wrong with this patch...

Attached is a new version - resynced against latest policy, and removed
miscellaneous patches. 

- Allowed ROLE_t full access to ROLE_untrusted_content_t (should this be
only relabelfrom instead? how do we want to protect the default user
context from untrusted content? )

- Added types: mime_types_t, ROLE_mime_types_t, and read_mime_types()
macro - it's used in mozilla

- Added type ROLE_fonts_t. It should be used for per/user (home) fonts,
but I'm not sure where those are stored - for now I just marked
$HOME/.fonts. Added read_fonts() macro to read those, and read
the .font.cache-1 file, and changed a bunch of programs to use that.
Removed X's privilege to read ROLE_home_t, and replaced with this macro.
Moved fonts contexts into fontconfig.fc

- Gave giFT name_connect permission

=====================

Any comments?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-G4oJFBwol8JVudTJHvB9
Content-Disposition: attachment; filename=restrict_home.diff
Content-Type: text/x-patch; name=restrict_home.diff; charset=UTF-8
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
diff -aur policy.old/domains/program/mailcap.te policy/domains/program/mailcap.te
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
diff -aur policy.old/file_contexts/program/gnome.fc policy/file_contexts/program/gnome.fc
--- policy.old/file_contexts/program/gnome.fc	2005-04-13 21:52:10.000000000 -0400
+++ policy/file_contexts/program/gnome.fc	2005-04-14 20:32:29.000000000 -0400
@@ -0,0 +1,7 @@
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?(/.*)?		system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?_private?(/.*)?		system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.local(/.*)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.themes(/.*)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.icons(/.*)?		system_u:object_r:ROLE_gnome_data_t
+HOME_DIR/\.thumbnails(/.*)?	system_u:object_r:ROLE_gnome_data_t
diff -aur policy.old/file_contexts/program/mailcap.fc policy/file_contexts/program/mailcap.fc
--- policy.old/file_contexts/program/mailcap.fc	2005-04-14 20:17:39.000000000 -0400
+++ policy/file_contexts/program/mailcap.fc	2005-04-14 20:35:07.000000000 -0400
@@ -0,0 +1,8 @@
+#
+# Mime types
+#
+
+/etc/mailcap	--	system_u:object_r:mime_types_t
+/etc/mime.types	--	system_u:object_r:mime_types_t
+HOME_DIR/\.mailcap	--	system_u:object_r:ROLE_mime_types_t
+HOME_DOR/\.mime_types	--	system_u:object_r:ROLE_mime_types_t
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
diff -aur policy.old/file_contexts/types.fc policy/file_contexts/types.fc
--- policy.old/file_contexts/types.fc	2005-04-14 20:24:48.000000000 -0400
+++ policy/file_contexts/types.fc	2005-04-14 20:39:37.000000000 -0400
@@ -387,17 +387,6 @@
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
diff -aur policy.old/macros/admin_macros.te policy/macros/admin_macros.te
--- policy.old/macros/admin_macros.te	2005-04-12 12:23:17.000000000 -0400
+++ policy/macros/admin_macros.te	2005-04-14 21:10:11.000000000 -0400
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
 
diff -aur policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-04-12 12:20:28.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-04-14 20:15:40.000000000 -0400
@@ -69,7 +69,7 @@
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
 can_setfscreate($1_t)
 
 allow $1_t autofs_t:dir { search getattr };
@@ -184,6 +184,9 @@
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
 ifdef(`gift.te', `gift_domains($1)')
+ifdef(`gnome.te', `gnome_domain($1)')
+ifdef(`fontconfig.te', `fontconfig_domain($1)')
+ifdef(`mailcap.te', `mailcap_domain($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -aur policy.old/macros/global_macros.te policy/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-04-14 20:41:59.000000000 -0400
+++ policy/macros/global_macros.te	2005-04-14 20:49:02.000000000 -0400
@@ -156,6 +156,28 @@
 r_dir_file($1, locale_t)
 ')
 
+##################################
+#
+# read_mime_types(domain, role)
+#
+# Permission for reading mime types
+#
+define(`read_mime_types', `
+allow $1 mime_types_t:file r_file_perms;
+allow $1 $2_mime_types_t:file r_file_perms;
+')
+
+###################################
+#
+# read_fonts(domain, role)
+# 
+# Permission for reading fonts
+#
+define(`read_fonts', `
+r_dir_file($1, fonts_t)
+r_dir_file($1, $2_fonts_t)
+allow $1 $2_fonts_cache_t:file r_file_perms;
+')
 
 ###################################
 #
diff -aur policy.old/macros/program/fontconfig_macros.te policy/macros/program/fontconfig_macros.te
--- policy.old/macros/program/fontconfig_macros.te	2005-04-13 21:51:58.000000000 -0400
+++ policy/macros/program/fontconfig_macros.te	2005-04-14 20:51:12.000000000 -0400
@@ -0,0 +1,15 @@
+#
+# Fontconfig related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# fontconfig_domain(role_prefix)
+
+define(`fontconfig_domain', `
+
+type $1_fonts_t, file_type, $1_file_type, sysadmfile, customizable;
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
diff -aur policy.old/macros/program/gpg_agent_macros.te policy/macros/program/gpg_agent_macros.te
--- policy.old/macros/program/gpg_agent_macros.te	2005-04-14 20:57:52.000000000 -0400
+++ policy/macros/program/gpg_agent_macros.te	2005-04-14 20:58:18.000000000 -0400
@@ -89,7 +89,7 @@
 allow $1_gpg_pinentry_t xdm_t:fd use;
 ')dnl end ig xdm.te
 
-r_dir_file($1_gpg_pinentry_t, fonts_t)
+read_fonts($1_gpg_pinentry_t, $1)
 # read kde font cache
 allow $1_gpg_pinentry_t usr_t:file { getattr read };
 
diff -aur policy.old/macros/program/java_macros.te policy/macros/program/java_macros.te
--- policy.old/macros/program/java_macros.te	2005-04-14 20:56:47.000000000 -0400
+++ policy/macros/program/java_macros.te	2005-04-14 21:11:05.000000000 -0400
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
diff -aur policy.old/macros/program/mailcap_macros.te policy/macros/program/mailcap_macros.te
--- policy.old/macros/program/mailcap_macros.te	2005-04-14 20:17:26.000000000 -0400
+++ policy/macros/program/mailcap_macros.te	2005-04-14 20:17:06.000000000 -0400
@@ -0,0 +1,14 @@
+#
+# Mailcap related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# mailcap_domain(role_prefix)
+
+define(`mailcap_domain', `
+
+type $1_mime_types_t, file_type, $1_file_type, sysadmfile;
+
+create_dir_file($1_t, $1_mime_types_t)
+
+') dnl gnome_domain
diff -aur policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-04-12 12:26:11.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-04-14 20:56:11.000000000 -0400
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
+allow $1_mozilla_t $1_gnome_settings_t:dir { search getattr };
+r_dir_file($1_mozilla_t, $1_gnome_data_t)
+read_mime_types($1_mozilla_t, $1)
+dontaudit $1_mozilla_t $1_fonts_cache_t:file unlink;
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
diff -aur policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-04-14 20:55:18.000000000 -0400
+++ policy/macros/program/x_client_macros.te	2005-04-14 20:55:51.000000000 -0400
@@ -74,7 +74,7 @@
 allow $1_t self:shm create_shm_perms;
 
 # allow X client to read all font files
-r_dir_file($1_t, fonts_t)
+read_fonts($1_t, $2)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
diff -aur policy.old/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- policy.old/macros/program/xserver_macros.te	2005-04-14 21:15:36.000000000 -0400
+++ policy/macros/program/xserver_macros.te	2005-04-14 21:18:01.000000000 -0400
@@ -77,6 +77,9 @@
 allow xdm_xserver_t init_t:fd use;
 
 dontaudit xdm_xserver_t home_dir_type:dir { read search };
+
+# for fonts
+r_dir_file($1_xserver_t, fonts_t)
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
@@ -93,9 +96,7 @@
 # Access the home directory.
 allow $1_xserver_t home_root_t:dir search;
 allow $1_xserver_t $1_home_dir_t:dir { getattr search };
-if (allow_xserver_home_fonts) {
-r_dir_file($1_xserver_t, $1_home_t)
-}
+read_fonts($1_xserver_t, $1)
 ifdef(`xauth.te', `
 domain_auto_trans($1_xserver_t, xauth_exec_t, $1_xauth_t)
 allow $1_xserver_t $1_xauth_home_t:file { getattr read };
@@ -261,8 +262,6 @@
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, xkb_var_lib_t)
 
-# for fonts
-r_dir_file($1_xserver_t, fonts_t)
 ')dnl end macro definition
 
 ', `
diff -aur policy.old/macros/user_macros.te policy/macros/user_macros.te
--- policy.old/macros/user_macros.te	2005-04-12 12:23:06.000000000 -0400
+++ policy/macros/user_macros.te	2005-04-14 21:10:04.000000000 -0400
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

--=-G4oJFBwol8JVudTJHvB9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
