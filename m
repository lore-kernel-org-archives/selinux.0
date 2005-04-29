Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3TKRcgA007030
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 16:27:38 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3TKR2U2026099
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 20:27:02 GMT
Subject: Restrict Home v. 2
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, russell@coker.com.au
Content-Type: multipart/mixed; boundary="=-BAQzhdUTfl1jlBzI/2MK"
Date: Fri, 29 Apr 2005 16:26:51 -0400
Message-Id: <1114806411.15876.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BAQzhdUTfl1jlBzI/2MK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's version 2 of this patch, still not in
merge-able state, but getting closer.

Changelog:
==========

- GConf runs in its own domain. Things that want to make use of gconf
call gconf_client(). This allows them to connect to gconfd via ORBit.
Each client can launch the daemon if necessary.

- Lots of gnome-specific folders in /home are labeled differently to
differentiate from ROLE_home_t.

- Gift, games, Xserver, and mozilla are denied access to ROLE_home_t.
Mozilla's readhome and writehome booleans are dropped, and it needs to
write ROLE_untrusted_content_t. Gift writes the same thing. X uses a
macro to access per/user fonts, which now have their own type.

- Gift, mozilla are denied access to ROLE_tmp_t, previously needed
because of ORBit connection to gconf.

- Mailcap/mime types stuff labeled differently too

- Probably other stuff I forgot.

TODO:
=====

- Startup script for creation and persistent labeling of
of /tmp/gconfd-$USER, /tmp/orbit-$USER, $HOME/downloads.

- worry about how to label .ICE-unix/.ICE-authority.

- worry about policy for fc-cache that properly labels the
font cache file.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-BAQzhdUTfl1jlBzI/2MK
Content-Disposition: attachment; filename=genhomedircon.diff
Content-Type: text/x-patch; name=genhomedircon.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- genhomedircon	2005-04-27 15:26:47.000000000 -0400
+++ genhomedircon.new	2005-04-27 16:01:36.000000000 -0400
@@ -357,16 +357,22 @@
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
-		ret="\n\n#\n# Context for user %s\n#\n\n" % user
+		ret="\n\n#\n# Home Context for user %s\n#\n\n" % user
 		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
 		return ret + rc[1] + "\n"
 
+	def getUserContext(self, user, role):
+		ret="\n\n#\n# Other Context for user %s\n#\n\n" % user
+		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, user))
+		return ret + rc[1] + "\n"
+
 	def genHomeDirContext(self):
 		users = self.getUsers()
 		ret=""
 		# Fill in HOME and ROLE for users that are defined
 		for u in users.keys():
 			ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
+			ret += self.getUserContext (u, users[u]["role"])
 		return ret+"\n"
 
 	def checkExists(self, home):

--=-BAQzhdUTfl1jlBzI/2MK
Content-Disposition: attachment; filename=Makefile.diff
Content-Type: text/x-patch; name=Makefile.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- Makefile	2005-04-27 16:02:07.000000000 -0400
+++ Makefile.new	2005-04-27 16:02:50.000000000 -0400
@@ -221,7 +221,7 @@
 	@echo "Building file contexts files..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
 	@grep -v -e HOME -e ROLE $@.tmp > $@
-	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@grep -e HOME -e ROLE -e USER $@.tmp  > $(HOMEDIR_TEMPLATE)
 	@-rm $@.tmp
 
 # Create a tags-file for the policy:

--=-BAQzhdUTfl1jlBzI/2MK
Content-Disposition: attachment; filename=restrict_home2.diff
Content-Type: text/x-patch; name=restrict_home2.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
+++ policy/domains/program/xdm.te	2005-04-29 13:43:32.000000000 -0400
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
+++ policy/file_contexts/types.fc	2005-04-29 15:02:40.000000000 -0400
@@ -58,7 +58,7 @@
 
 #
 # Mount points; do not relabel subdirectories, since
-# we don not want to change any removable media by default.
+# we don't want to change any removable media by default.
 /mnt(/[^/]*)?		-d	system_u:object_r:mnt_t
 /mnt/[^/]*/.*			<<none>>
 /media(/[^/]*)?		-d	system_u:object_r:mnt_t
@@ -388,17 +388,6 @@
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
+++ policy/macros/base_user_macros.te	2005-04-29 14:58:27.000000000 -0400
@@ -75,7 +75,7 @@
 
 # Create, access, and remove files in home directory.
 file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:notdevfile_class_set { relabelfrom relabelto };
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
 can_setfscreate($1_t)
 
 allow $1_t autofs_t:dir { search getattr };
@@ -176,7 +176,6 @@
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`samba.te', `samba_domain($1)')
-ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`startx.te', `xserver_domain($1)')
@@ -189,7 +188,28 @@
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
+
+# GNOME
+ifdef(`gnome.te', `
+
+# Base 
+gnome_domain($1)
+gconfd_domain($1)
+gconf_client($1, $1)
+
+# Applications
+ifdef(`games.te', `games_domain($1)')
 ifdef(`gift.te', `gift_domains($1)')
+')
+
+# Fonts, mailcap - required stuff
+mailcap_domain($1)
+fontconfig_domain($1)
+
+# ORBit sockets
+# Serves double purpose of defining the per/user folder type,
+# and letting us create sockets in it
+orbit_domain($1, $1)
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
@@ -350,6 +370,10 @@
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
+++ policy/macros/global_macros.te	2005-04-29 15:17:11.000000000 -0400
@@ -156,7 +156,6 @@
 r_dir_file($1, locale_t)
 ')
 
-
 ###################################
 #
 # access_terminal(domain, typeprefix)
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
+++ policy/macros/program/fontconfig_macros.te	2005-04-29 15:52:08.000000000 -0400
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
+# disallow_home_fonts(domain, role_prefix) - 
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
+define(`disallow_home_fonts', `
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
+++ policy/macros/program/gconf_macros.te	2005-04-29 16:16:24.000000000 -0400
@@ -0,0 +1,65 @@
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
+++ policy/macros/program/gnome_macros.te	2005-04-29 15:33:17.000000000 -0400
@@ -0,0 +1,16 @@
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
+') dnl gnome_domain
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
+++ policy/macros/program/mozilla_macros.te	2005-04-29 15:00:27.000000000 -0400
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
 allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
@@ -53,7 +56,23 @@
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
@@ -66,8 +85,6 @@
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t proc_t:file { getattr read };
-allow $1_mozilla_t proc_t:lnk_file read;
 allow $1_mozilla_t self:dir search;
 allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
@@ -81,47 +98,12 @@
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
@@ -135,8 +117,7 @@
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
-# Mozilla tries to delete .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file unlink;
+
 allow $1_mozilla_t self:sem create_sem_perms;
 
 # Java plugin
@@ -144,16 +125,32 @@
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
@@ -162,6 +159,7 @@
 if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
+
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `
diff -aru policy.old/macros/program/orbit_macros.te policy/macros/program/orbit_macros.te
--- policy.old/macros/program/orbit_macros.te	2005-04-29 15:01:27.000000000 -0400
+++ policy/macros/program/orbit_macros.te	2005-04-29 14:49:38.000000000 -0400
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
+++ policy/macros/program/xserver_macros.te	2005-04-29 15:50:39.000000000 -0400
@@ -79,6 +79,14 @@
 allow xdm_xserver_t init_t:fd use;
 
 dontaudit xdm_xserver_t home_dir_type:dir { read search };
+
+# Suppress fonts denials
+disallow_home_fonts(xdm_xserver_t, user)
+disallow_home_fonts(xdm_xserver_t, staff)
+disallow_home_fonts(xdm_xserver_t, sysadm)
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
+disallow_home_fonts($1_xserver_t, $1)
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

--=-BAQzhdUTfl1jlBzI/2MK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
