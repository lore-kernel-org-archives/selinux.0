Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VEsDgA005336
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 10:54:13 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VEmIC0017853
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 14:48:19 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4VEnB6W018563
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 10:49:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4VEnAms018562
	for selinux@tycho.nsa.gov; Tue, 31 May 2005 10:49:10 -0400
Subject: [ PATCH ]: evolution/thunderbird/gconf/orbit/other stuff -
	comments?
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: fedora-selinux-list@redhat.com, SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-/ZUAfpuqt9gG6mI54NwG"
Date: Sun, 29 May 2005 15:24:35 -0400
Message-Id: <1117394675.23920.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/ZUAfpuqt9gG6mI54NwG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Features:

- policy for evolution
- policy for thunderbird
- policy for generic mail client that they derive from
- policy for gconf
- common gnome macros (mozilla, evolution, thunderbird, gift, games,
gconf) use those
- macro for secure storage at .gnome(2)_private
- attempt at per role fonts
- per application labeled orbit sockets
- per application labeled ice sockets ( this is rather broken right
now )

- begin structuring things to confine bonobo in the future
- introduce untrusted type, but don't do anything with it yet

- restricted home_domain macro set to allow specifying transition class
in /home.
Default is now { dir } only, which is more restrictive than before.

- rework gift networking rules

- start writing ethereal policy ( not finished )

- bugfixes

I believe this is against selinux-policy-strict-sources-1.23.17-2

Issues:
(see my other message (nsa-list) - file_type_auto_trans 
is not sufficient)
- need to patch libfontconfig to create font cache with proper type
- need to patch libgnome to create .gnome2 .gnome2_private,
and .gnome2/share/*fonts*
with correct type
- need to patch ORBit to create /tmp/orbit-* with correct type
- need to patch libICE to create /tmp/.ICE_unix with correct type
- need to give getfscreate/setfscreate privileges to all of those
(just like it's done for orbit_domain)
- need to patch evolution to create autosave composer files in
~~/.evolution, not in $HOME
- need to fix everything relating to $HOME/.ICEauthority
- need to finish evolution exchange policy
- need to finish ethereal policy
- need to update boolean file

Status:
- can log in with almost no denials. There are the usual
strict policy bugs, there's some iceauth related denials,
but nothing too bad. Evolution works, but it
keeps popping up warning boxes every 15 seconds saying
it can't write its autosave files to $HOME - that needs
to be patched.


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-/ZUAfpuqt9gG6mI54NwG
Content-Disposition: attachment; filename=patch.diff
Content-Type: text/x-patch; name=patch.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur --exclude-from=excludes policy.orig/domains/program/ethereal.te policy/domains/program/ethereal.te
--- policy.orig/domains/program/ethereal.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/ethereal.te	2005-05-28 15:37:11.000000000 -0400
@@ -0,0 +1,73 @@
+# DESC - Ethereal  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executables
+type tethereal_exec_t, file_type, exec_type, sysadmfile;
+type ethereal_exec_t, file_type, exec_type, sysadmfile;
+
+########################################################
+# ethereal_common(app_prefix) - common ethereal rules
+#
+define(`ethereal_common', `
+
+uses_shlib($1_t)
+read_locale($1_t)
+
+# Terminal output
+access_terminal($1_t, sysadm)
+
+# /proc
+read_sysctl($1_t)
+allow $1_t { self proc_t }:dir { read search getattr };
+allow $1_t { self proc_t }:{ file lnk_file } { read getattr };
+
+# Access root
+allow $1_t root_t:dir search;
+
+# Read ethereal files in /usr
+allow $1_t usr_t:file { read getattr };
+
+# /etc/nsswitch.conf
+allow $1_t etc_t:file { read getattr };
+
+# Networking privileges
+allow $1_t self:netlink_route_socket create_netlink_socket_perms;
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_t self:udp_socket create_socket_perms;
+allow $1_t self:packet_socket create_socket_perms; 
+
+') dnl ethereal_common
+
+########################################################
+# Tethereal 
+#
+
+# Type for program
+type tethereal_t, domain, nscd_client_domain;
+
+# Transition from sysadm type
+domain_auto_trans(sysadm_t, tethereal_exec_t, tethereal_t)
+role sysadm_r types tethereal_t;
+
+# Ethereal common
+ethereal_common(tethereal)
+
+########################################################
+# Ethereal (GNOME) 
+#
+
+ifdef(`gnome.te', `
+
+# Type for program
+type ethereal_t, domain, nscd_client_domain;
+
+# Transition from sysadm type
+domain_auto_trans(sysadm_t, ethereal_exec_t, ethereal_t)
+role sysadm_r types ethereal_t;
+
+# Ethereal common
+ethereal_common(ethereal)
+
+') dnl gnome.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/evolution.te policy/domains/program/evolution.te
--- policy.orig/domains/program/evolution.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/evolution.te	2005-05-27 13:15:38.000000000 -0400
@@ -0,0 +1,13 @@
+# DESC - Evolution  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executables
+type evolution_exec_t, file_type, exec_type, sysadmfile;
+type evolution_server_exec_t, file_type, exec_type, sysadmfile;
+type evolution_webcal_exec_t, file_type, exec_type, sysadmfile;
+type evolution_alarm_exec_t, file_type, exec_type, sysadmfile;
+type evolution_exchange_exec_t, file_type, exec_type, sysadmfile;
+
+# Everything else is in macros/evolution_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/gconf.te policy/domains/program/gconf.te
--- policy.orig/domains/program/gconf.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/gconf.te	2005-05-24 10:31:09.000000000 -0400
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
diff -Naur --exclude-from=excludes policy.orig/domains/program/gift.te policy/domains/program/gift.te
--- policy.orig/domains/program/gift.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/gift.te	2005-05-29 14:58:59.000000000 -0400
@@ -0,0 +1,13 @@
+# DESC - giFT file sharing tool
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+type gift_exec_t, file_type, exec_type, sysadmfile;
+type giftd_exec_t, file_type, exec_type, sysadmfile;
+type giftd_port_t, port_type;
+type giftd_openft_port_t, port_type;
+type giftd_fasttrack_port_t, port_type;
+type giftd_gnutella_port_t, port_type;
+
+# Everything else is in macros/gift_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/gnome.te policy/domains/program/gnome.te
--- policy.orig/domains/program/gnome.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/gnome.te	2005-05-27 14:16:57.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in gnome_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/iceauth.te policy/domains/program/iceauth.te
--- policy.orig/domains/program/iceauth.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/iceauth.te	2005-05-27 10:29:09.000000000 -0400
@@ -0,0 +1,12 @@
+#DESC ICEauth - ICE authority file utility
+#
+# Domains for the iceauth program.
+#
+# Author: Ivan Gyurdiev <gyurdiev@redhat.com>
+#
+# iceauth_exec_t is the type of the xauth executable.
+#
+type iceauth_exec_t, file_type, sysadmfile;
+
+# Everything else is in the iceauth_domain macro in
+# macros/program/iceauth_macros.te.
diff -Naur --exclude-from=excludes policy.orig/domains/program/orbit.te policy/domains/program/orbit.te
--- policy.orig/domains/program/orbit.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/orbit.te	2005-05-24 10:31:04.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in orbit_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/thunderbird.te policy/domains/program/thunderbird.te
--- policy.orig/domains/program/thunderbird.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/program/thunderbird.te	2005-05-26 10:42:40.000000000 -0400
@@ -0,0 +1,9 @@
+# DESC - Thunderbird  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executables
+type thunderbird_exec_t, file_type, exec_type, sysadmfile;
+
+# Everything else is in macros/thunderbird_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/unused/gift.te policy/domains/program/unused/gift.te
--- policy.orig/domains/program/unused/gift.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/domains/program/unused/gift.te	2005-05-29 14:58:59.000000000 -0400
@@ -5,5 +5,9 @@
 
 type gift_exec_t, file_type, exec_type, sysadmfile;
 type giftd_exec_t, file_type, exec_type, sysadmfile;
+type giftd_port_t, port_type;
+type giftd_openft_port_t, port_type;
+type giftd_fasttrack_port_t, port_type;
+type giftd_gnutella_port_t, port_type;
 
 # Everything else is in macros/gift_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/xdm.te policy/domains/program/xdm.te
--- policy.orig/domains/program/xdm.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/domains/program/xdm.te	2005-05-28 12:26:36.000000000 -0400
@@ -279,6 +279,11 @@
 # Search /var/run.
 allow xdm_xserver_t var_run_t:dir search;
 
+# FIXME: After per user fonts are properly working
+# xdm_xserver_t may no longer have any reason
+# to read ROLE_home_t - examine this in more detail
+# (xauth?)
+
 # Search home directories.
 allow xdm_xserver_t user_home_type:dir search;
 allow xdm_xserver_t user_home_type:file { getattr read };
diff -Naur --exclude-from=excludes policy.orig/domains/program/xserver.te policy/domains/program/xserver.te
--- policy.orig/domains/program/xserver.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/domains/program/xserver.te	2005-05-28 12:15:10.000000000 -0400
@@ -14,8 +14,8 @@
 type xkb_var_lib_t, file_type, sysadmfile, usercanread;
 typealias xkb_var_lib_t alias var_lib_xkb_t;
 
-# Allow the xserver to check for fonts in ~/.gnome or ~/.kde
-bool allow_xserver_home_fonts false;
+# type for /tmp/.ICE-unix
+type ice_tmp_t, file_type, sysadmfile, tmpfile;
 
 # Everything else is in the xserver_domain macro in
 # macros/program/xserver_macros.te.
diff -Naur --exclude-from=excludes policy.orig/file_contexts/distros.fc policy/file_contexts/distros.fc
--- policy.orig/file_contexts/distros.fc	2005-05-26 12:06:31.000000000 -0400
+++ policy/file_contexts/distros.fc	2005-05-25 09:38:58.000000000 -0400
@@ -31,6 +31,7 @@
 /usr/share/system-config-network/neat-control\.py	--	system_u:object_r:bin_t
 /usr/share/system-config-nfs/nfs-export\.py	--	system_u:object_r:bin_t
 /usr/share/pydict/pydict\.py	--	system_u:object_r:bin_t
+/opt/rhqa/inventory/client/inventory\.py --	system_u:object_r:bin_t
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
 /usr/share/pwlib/make/ptlib-config --	system_u:object_r:bin_t
 /usr/share/texmf/web2c/mktexdir	--	system_u:object_r:bin_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/ethereal.fc policy/file_contexts/program/ethereal.fc
--- policy.orig/file_contexts/program/ethereal.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/ethereal.fc	2005-05-28 14:44:36.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/sbin/tethereal.*		--	system_u:object_r:tethereal_exec_t
+/usr/bin/ethereal.*		--	system_u:object_r:ethereal_exec_t				
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/evolution.fc policy/file_contexts/program/evolution.fc
--- policy.orig/file_contexts/program/evolution.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/evolution.fc	2005-05-27 21:33:44.000000000 -0400
@@ -0,0 +1,7 @@
+/usr/bin/evolution.*					--	system_u:object_r:evolution_exec_t
+/usr/libexec/evolution/.*evolution-alarm-notify.*	--	system_u:object_r:evolution_alarm_exec_t
+/usr/libexec/evolution/.*evolution-exchange-storage.*	--	system_u:object_r:evolution_exchange_exec_t
+/usr/libexec/evolution-data-server.*			--	system_u:object_r:evolution_server_exec_t
+/usr/libexec/evolution-webcal.*				--	system_u:object_r:evolution_webcal_exec_t
+HOME_DIR/\.evolution(/.*)?					system_u:object_r:ROLE_evolution_home_t
+HOME_DIR/\.camel_certs(/.*)?					system_u:object_r:ROLE_evolution_home_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/fontconfig.fc policy/file_contexts/program/fontconfig.fc
--- policy.orig/file_contexts/program/fontconfig.fc	2005-05-26 12:06:31.000000000 -0400
+++ policy/file_contexts/program/fontconfig.fc	2005-05-27 13:57:49.000000000 -0400
@@ -1,2 +1,4 @@
-HOME_DIR/\.fonts(/.*)?				system_u:object_r:ROLE_fonts_t	
-HOME_DIR/\.fonts.cache-1		--	system_u:object_r:ROLE_fonts_cache_t
+# FIXME: Those will be created with the wrong type
+HOME_DIR/\.fonts.conf		--	system_u:object_r:ROLE_fonts_config_t
+HOME_DIR/\.fonts(/.*)?			system_u:object_r:ROLE_fonts_t
+HOME_DIR/\.fonts.cache-.*	--	system_u:object_r:ROLE_fonts_cache_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/gconf.fc policy/file_contexts/program/gconf.fc
--- policy.orig/file_contexts/program/gconf.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/gconf.fc	2005-05-24 10:31:09.000000000 -0400
@@ -0,0 +1,5 @@
+/usr/libexec/gconfd-2	--	system_u:object_r:gconfd_exec_t
+/etc/gconf(/.*)?		system_u:object_r:gconf_etc_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_gconfd_home_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_gconfd_home_t
+/tmp/gconfd-USER(/.*)?		system_u:object_r:ROLE_gconfd_tmp_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/gnome.fc policy/file_contexts/program/gnome.fc
--- policy.orig/file_contexts/program/gnome.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/gnome.fc	2005-05-27 21:33:54.000000000 -0400
@@ -0,0 +1,9 @@
+# FIXME: add a lot more GNOME folders
+# FIXME: Those folders will be created with the wrong type 
+HOME_DIR/\.gnome(2)?(/.*)?			system_u:object_r:ROLE_gnome_settings_t
+HOME_DIR/\.gnome(2)?_private(/.*)?              system_u:object_r:ROLE_gnome_secret_t
+ifdef(`evolution.te', `
+HOME_DIR/\.gnome(2)?_private/Evolution	--	system_u:object_r:ROLE_evolution_secret_t
+')
+HOME_DIR/\.gnome(2)?/share/fonts(/.*)?          system_u:object_r:ROLE_fonts_t
+HOME_DIR/\.gnome(2)?/share/cursor-fonts(/.*)?   system_u:object_r:ROLE_fonts_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/iceauth.fc policy/file_contexts/program/iceauth.fc
--- policy.orig/file_contexts/program/iceauth.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/iceauth.fc	2005-05-27 10:10:45.000000000 -0400
@@ -0,0 +1,3 @@
+# iceauth
+/usr/X11R6/bin/iceauth	--      system_u:object_r:iceauth_exec_t
+HOME_DIR/\.ICEauthority.* --      system_u:object_r:ROLE_iceauth_home_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/mozilla.fc policy/file_contexts/program/mozilla.fc
--- policy.orig/file_contexts/program/mozilla.fc	2005-05-26 12:06:31.000000000 -0400
+++ policy/file_contexts/program/mozilla.fc	2005-05-27 14:25:02.000000000 -0400
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
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/orbit.fc policy/file_contexts/program/orbit.fc
--- policy.orig/file_contexts/program/orbit.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/orbit.fc	2005-05-27 14:49:05.000000000 -0400
@@ -0,0 +1,3 @@
+/tmp/orbit-USER(-.*)?		-d      system_u:object_r:ROLE_orbit_tmp_t
+/tmp/orbit-USER(-.*)?/linc.*	-s	<<none>>
+/tmp/orbit-USER(-.*)?/bonobo.*		system_u:object_r:ROLE_orbit_tmp_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/thunderbird.fc policy/file_contexts/program/thunderbird.fc
--- policy.orig/file_contexts/program/thunderbird.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy/file_contexts/program/thunderbird.fc	2005-05-26 10:44:11.000000000 -0400
@@ -0,0 +1,2 @@
+/usr/bin/thunderbird.*			--	system_u:object_r:thunderbird_exec_t
+HOME_DIR/\.thunderbird(/.*)?			system_u:object_r:ROLE_thunderbird_home_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/xserver.fc policy/file_contexts/program/xserver.fc
--- policy.orig/file_contexts/program/xserver.fc	2005-05-26 12:06:31.000000000 -0400
+++ policy/file_contexts/program/xserver.fc	2005-05-27 10:19:18.000000000 -0400
@@ -13,5 +13,5 @@
 /etc/init\.d/xfree86-common --	system_u:object_r:xserver_exec_t
 /tmp/\.X11-unix		-d	system_u:object_r:xdm_tmp_t
 /tmp/\.X11-unix/.*	-s	<<none>>
-/tmp/\.ICE-unix		-d	system_u:object_r:xdm_xserver_tmp_t
+/tmp/\.ICE-unix		-d	system_u:object_r:ice_tmp_t
 /tmp/\.ICE-unix/.*	-s	<<none>>
diff -Naur --exclude-from=excludes policy.orig/file_contexts/types.fc policy/file_contexts/types.fc
--- policy.orig/file_contexts/types.fc	2005-05-26 12:06:31.000000000 -0400
+++ policy/file_contexts/types.fc	2005-05-26 22:33:08.000000000 -0400
@@ -499,6 +499,7 @@
 #
 /usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird --      system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird-bin -- system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*thunderbird[^/]*/open-browser\.sh -- system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/run-mozilla\.sh -- system_u:object_r:bin_t
 /usr/lib(64)?/[^/]*thunderbird[^/]*/mozilla-xremote-client -- system_u:object_r:bin_t
 
diff -Naur --exclude-from=excludes policy.orig/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.orig/macros/base_user_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-05-29 15:16:58.000000000 -0400
@@ -22,6 +22,14 @@
 undefine(`base_user_domain')
 define(`base_user_domain', `
 
+# Type for network-obtained content
+type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
+bool $1_access_untrusted_content false;
+if ($1_access_untrusted_content) {
+rw_dir_file($1_t, $1_untrusted_content_t) 
+}
+#allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+
 allow $1_t self:capability { setgid chown fowner };
 dontaudit $1_t self:capability { sys_nice fsetid };
 
@@ -182,10 +190,11 @@
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
+ifdef(`thunderbird.te', `thunderbird_domain($1)')
 ifdef(`samba.te', `samba_domain($1)')
-ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
+ifdef(`iceauth.te', `iceauth_domain($1)')
 ifdef(`startx.te', `xserver_domain($1)')
 ifdef(`lpr.te', `lpr_domain($1)')
 ifdef(`ssh.te', `ssh_domain($1)')
@@ -196,10 +205,23 @@
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
-ifdef(`gift.te', `gift_domains($1)')
 
 fontconfig_domain($1)
 
+# GNOME
+ifdef(`gnome.te', `
+gnome_domain($1)
+ifdef(`games.te', `games_domain($1)')
+ifdef(`gift.te', `gift_domains($1)')
+ifdef(`evolution.te', `evolution_domains($1)')
+')
+
+# ICE communication channel
+ice_domain($1, $1)
+
+# ORBit communication channel (independent of GNOME)
+orbit_domain($1, $1)
+
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
 
@@ -294,8 +316,6 @@
 x_client_domain($1, $1)
 
 ifdef(`xserver.te', `
-# for /tmp/.ICE-unix
-file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
 allow $1_t xserver_misc_device_t:{ chr_file blk_file } rw_file_perms;
 ')
 
diff -Naur --exclude-from=excludes policy.orig/macros/global_macros.te policy/macros/global_macros.te
--- policy.orig/macros/global_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/global_macros.te	2005-05-26 22:27:50.000000000 -0400
@@ -60,7 +60,7 @@
 # read_sysctl(domain)
 #
 # Permissions for reading sysctl variables.
-# If the second parameter is 'full', allow
+# If the second parameter is full, allow
 # reading of any sysctl variables, else only
 # sysctl_kernel_t.
 #
@@ -292,7 +292,7 @@
 # Define a daemon domain with a base set of type declarations
 # and permissions that are common to most daemons.
 # attribs is the list of attributes which must start with "," if it is not empty
-# `nosysadm' may be given as an optional third parameter, to specify that the
+# nosysadm may be given as an optional third parameter, to specify that the
 # sysadmin should not transition to the domain when directly calling the executable
 #
 # Author:  Russell Coker <russell@coker.com.au>
@@ -520,11 +520,13 @@
 ') dnl home_domain_ro_access
 
 ####################################################################
-# home_domain_access(source, user, app)
+# home_domain_access(source, user, app, trans_classes)
 #
 # Gives source full access to the home
 # domain of app for the given user type
 #
+# You can also specify the transition classes
+# By default the only trans. class in /home is dir
 
 define(`home_domain_access', `
 
@@ -538,16 +540,24 @@
 }
 allow $1 autofs_t:dir { search getattr };
 
-file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t)
+create_dir_file($1, $2_$3_home_t)
+
+ifelse($4, `', `
+file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t, dir)
+', `
+file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t, $4)
+')
 
 ') dnl home_domain_access
 
 ####################################################################
-# home_domain (prefix, app)
+# home_domain (prefix, app, trans_classes)
 #
 # Creates a domain in the prefix home where an application can
-# store its settings. It's accessible by the prefix domain.
+# store its settings. It is accessible by the prefix domain.
 #
+# You can also specify the transition classes
+# By default the only trans. class in /home is dir
 
 define(`home_domain', `
 
@@ -565,15 +575,15 @@
 allow $1_t $1_$2_home_t:{ dir file lnk_file } { relabelfrom relabelto };
 
 # App side access
-home_domain_access($1_$2_t, $1, $2)
+home_domain_access($1_$2_t, $1, $2, $3)
 ')
 
 ####################################################################
 # home_domain_ro (user, app)
 #
 # Creates a read-only domain in the user home where an application can
-# store its settings. It's fully accessible by the user, but
-# it's read-only for the application.
+# store its settings. It is fully accessible by the user, but
+# it is read-only for the application.
 #
 
 define(`home_domain_ro', `
@@ -797,12 +807,3 @@
 ')
 
 ')dnl end unconfined_domain
-# Author: Ivan Gyurdiev <ivg2@cornell.edu>
-#
-# read_fonts(domain, role_prefix) - 
-#         allow domain to read fonts, optionally per/user
-#  
-define(`read_fonts', `
-r_dir_file($1, fonts_t)
-')
-
diff -Naur --exclude-from=excludes policy.orig/macros/program/bonobo_macros.te policy/macros/program/bonobo_macros.te
--- policy.orig/macros/program/bonobo_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/bonobo_macros.te	2005-05-28 13:42:55.000000000 -0400
@@ -0,0 +1,60 @@
+#
+# Bonobo
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# bonobo_domain(role_prefix) - invoke per role
+# bonobo_client(app_prefix, role_prefix) - invoke per client app
+# bonobo_connect(type1_prefix, type2_prefix) - 
+# 	connect two bonobo clients, the channel is bidirectional
+
+######################
+
+define(`bonobo_domain', `
+
+# Protect against double inclusion for faster compile
+ifdef(`bonobo_domain_$1', `', `
+define(`bonobo_domain_$1')
+
+# FIXME: The current implementation of bonobo
+# must be as user_t. Bonobo is difficult to confine,
+# because it launches numerous applications, which
+# inherit its type. When bonobo is confined,
+# add the implementation here. Until then,
+# simply route over ORBit sockets
+
+orbit_domain($1, $1)
+
+') dnl ifdef bonobo_domain_args
+') dnl bonobo_domain
+
+#####################
+
+define(`bonobo_client', `
+
+# Protect against double inclusion for faster compile
+ifdef(`bonobo_client_$1_$2', `', `
+define(`bonobo_client_$1_$2')
+
+# FIXME: Implemented as user_t currently
+
+# Create ORBit sockets
+orbit_domain($1, $2)
+
+# Connect to bonobo
+orbit_connect($1, $2)
+orbit_connect($2, $1)
+
+') dnl ifdef bonobo_client_args
+') dnl bonobo_client
+
+#####################
+
+define(`bonobo_connect', `
+
+# FIXME: Should there be a macro for unidirectional conn. ?
+
+orbit_connect($1, $2)
+orbit_connect($2, $1)
+
+') dnl bonobo_connect
diff -Naur --exclude-from=excludes policy.orig/macros/program/evolution_macros.te policy/macros/program/evolution_macros.te
--- policy.orig/macros/program/evolution_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/evolution_macros.te	2005-05-28 19:36:55.000000000 -0400
@@ -0,0 +1,247 @@
+#
+# Evolution   
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+################################################
+# evolution_common(app_prefix,role_prefix)
+# 
+define(`evolution_common', `
+
+# Gnome common stuff
+gnome_application($1, $2)
+
+# Fork
+allow $1_t self:process { sigchld sigkill signal getsched setsched fork };
+allow $1_t self:fifo_file rw_file_perms;
+allow $1_t self:socket create;
+
+# Stat path
+allow $1_t root_t:dir search;
+
+# Connect to gnome-session
+# FIXME: more specific context for gnome-session
+ice_connect($1, $2)
+
+# Access null device 
+allow $1_t null_device_t:chr_file rw_file_perms;
+
+# Sysctl
+read_sysctl($1_t)
+
+# FIXME: why is this necessary?
+allow $1_t tmp_t:dir r_dir_perms;
+
+# FIXME: suppress access to .local/.icons/.themes until properly implemented
+dontaudit $1_t $2_home_t:dir r_dir_perms;
+
+# FIXME: suppress access to .gaim/blist.xml (buddy list synchronization)
+# until properly implemented
+dontaudit $1_t $2_home_t:file r_file_perms;
+
+') dnl evolution_common
+
+#######################################
+# evolution_data_server(role_prefix) 
+#
+
+define(`evolution_data_server', `
+
+# Type for daemon
+type $1_evolution_server_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, evolution_server_exec_t, $1_evolution_server_t)
+role $1_r types $1_evolution_server_t;
+
+# Evolution common stuff
+evolution_common($1_evolution_server, $1)
+
+# Access evolution home
+home_domain_access($1_evolution_server_t, $1, evolution)
+
+# Talks to exchange
+bonobo_connect($1_evolution_server, $1_evolution_exchange)
+
+can_exec($1_evolution_server_t, shell_exec_t)
+
+# Obtain weather data via http (read server name from xml file in /usr)
+allow $1_evolution_server_t usr_t:file r_file_perms;
+can_resolve($1_evolution_server_t)
+can_network_client($1_evolution_server_t)
+allow $1_evolution_server_t http_port_t:tcp_socket name_connect;
+
+# Talk to ldap (address book)
+allow $1_evolution_server_t ldap_port_t:tcp_socket name_connect;
+
+') dnl evolution_data_server
+
+#######################################
+# evolution_webcal(role_prefix)
+#
+
+define(`evolution_webcal', `
+
+# Type for program
+type $1_evolution_webcal_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, evolution_webcal_exec_t, $1_evolution_webcal_t)
+role $1_r types $1_evolution_webcal_t;
+
+# X/evolution common stuff
+x_client_domain($1_evolution_webcal, $1)
+evolution_common($1_evolution_webcal, $1)
+
+# Search home directory (?)
+allow $1_evolution_webcal_t $1_home_dir_t:dir search;
+
+# Networking capability - connect to website and handle ics link
+# FIXME: is this necessary ?
+can_network_client($1_evolution_webcal_t)
+allow $1_evolution_webcal_t http_port_t:tcp_socket name_connect;
+
+') dnl evolution_webcal
+
+#######################################
+# evolution_alarm(role_prefix)
+#
+define(`evolution_alarm', `
+
+# Type for program
+type $1_evolution_alarm_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, evolution_alarm_exec_t, $1_evolution_alarm_t)
+role $1_r types $1_evolution_alarm_t;
+
+# Common evolution stuff, X
+evolution_common($1_evolution_alarm, $1)
+x_client_domain($1_evolution_alarm, $1)
+
+# Connect to exchange, e-d-s
+bonobo_connect($1_evolution_alarm, $1_evolution_server) 
+bonobo_connect($1_evolution_alarm, $1_evolution_exchange)
+
+# Access evolution home
+home_domain_access($1_evolution_alarm_t, $1, evolution)
+
+') dnl evolution_alarm
+
+########################################
+# evolution_exchange(role_prefix)
+#
+define(`evolution_exchange', `
+
+# Type for program
+type $1_evolution_exchange_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, evolution_exchange_exec_t, $1_evolution_exchange_t)
+role $1_r types $1_evolution_exchange_t;
+
+# Common evolution stuff, X
+evolution_common($1_evolution_exchange, $1)
+x_client_domain($1_evolution_exchange, $1)
+
+# Access evolution home
+home_domain_access($1_evolution_exchange_t, $1, evolution)
+
+# Stat /tmp/.exchange-$USER, which is created by evolution
+allow $1_evolution_exchange_t $1_evolution_tmp_t:dir getattr;
+
+# Allow netstat
+allow $1_evolution_exchange_t bin_t:dir search; 
+can_exec($1_evolution_exchange_t, bin_t)
+r_dir_file($1_evolution_exchange_t, proc_net_t)
+allow $1_evolution_exchange_t sysctl_net_t:dir search;
+allow $1_evolution_exchange_t self:{ udp_socket tcp_socket } create_socket_perms;
+
+# FIXME: policy incomplete
+
+') dnl evolution_exchange
+
+#######################################
+# evolution_domain(role_prefix)
+#
+
+define(`evolution_domain', `
+
+# Type for program
+type $1_evolution_t, domain, nscd_client_domain, privlog; 
+
+# Transition from user type
+domain_auto_trans($1_t, evolution_exec_t, $1_evolution_t)
+role $1_r types $1_evolution_t;
+
+# X, mail, evolution, Dbus common stuff 
+x_client_domain($1_evolution, $1)
+mail_client_domain($1_evolution, $1)
+dbusd_client(system, $1_evolution)
+dbusd_client($1, $1_evolution)
+allow $1_evolution_t $1_dbusd_t:dbus send_msg;
+gnome_file_dialog($1_evolution_t)
+evolution_common($1_evolution, $1)
+
+# Connect to e-d-s, exchange, alarm
+bonobo_connect($1_evolution, $1_evolution_server)
+bonobo_connect($1_evolution, $1_evolution_exchange)
+bonobo_connect($1_evolution, $1_evolution_alarm)
+
+# Access .evolution
+# FIXME: Autosaves composer files in /home, but
+# that subverts the mail_save boolean in mail_domain
+home_domain($1, evolution)
+
+# Store documents in /tmp (to print, etc..)
+tmp_domain($1_evolution)
+
+# Store passwords in .gnome2_private
+gnome_private_store($1_evolution, $1) 
+
+# Run various programs
+allow $1_evolution_t { bin_t sbin_t }:dir r_dir_perms;
+allow $1_evolution_t { self bin_t }:lnk_file r_file_perms;
+
+### Junk mail filtering (start spamd)
+ifdef(`spamd.te', `
+# Start the spam daemon
+domain_auto_trans($1_evolution_t, spamd_exec_t, spamd_t)
+role $1_r types spamd_t;
+
+# Write pid file and socket in ~/.evolution/cache/tmp
+file_type_auto_trans(spamd_t, $1_evolution_home_t, spamd_tmp_t, { file sock_file })
+
+# Allow evolution to signal the daemon
+# FIXME: Now evolution can read spamd temp files
+allow $1_evolution_t spamd_tmp_t:file r_file_perms;
+allow $1_evolution_t spamd_t:process signal;
+dontaudit $1_evolution_t spamd_tmp_t:sock_file getattr;
+') dnl spamd.te
+
+### Junk mail filtering (start spamc)
+ifdef(`spamc.te', `
+domain_auto_trans($1_evolution_t, spamc_exec_t, $1_spamc_t)
+
+# Allow connection to spamd socket above
+allow $1_spamc_t $1_evolution_home_t:dir search;
+') dnl spamc.te
+
+### Junk mail filtering (start spamassassin) 
+ifdef(`spamassassin.te', `
+domain_auto_trans($1_evolution_t, spamassassin_exec_t, $1_spamassassin_t)
+') dnl spamassasin.te
+
+') dnl evolution_domain
+
+#################################
+#  evolution_domains(role_prefix) 
+
+define(`evolution_domains', `
+evolution_domain($1)
+evolution_data_server($1)
+evolution_webcal($1)
+evolution_alarm($1)
+evolution_exchange($1)
+') dnl end evolution_domains
diff -Naur --exclude-from=excludes policy.orig/macros/program/fontconfig_macros.te policy/macros/program/fontconfig_macros.te
--- policy.orig/macros/program/fontconfig_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/fontconfig_macros.te	2005-05-28 13:55:11.000000000 -0400
@@ -8,17 +8,39 @@
 # read_fonts(domain, role_prefix) - 
 #         allow domain to read fonts, optionally per/user
 #  
-# dontaudit_home_fonts(domain, role_prefix) - 
-#	block the denials of home fonts - hack for X
 
 define(`fontconfig_domain', `
 
-type $1_fonts_t, file_type, $1_file_type, sysadmfile, customizable;
+type $1_fonts_t, file_type, $1_file_type, sysadmfile;
+type $1_fonts_config_t, file_type, $1_file_type, sysadmfile;
 type $1_fonts_cache_t, file_type, $1_file_type, sysadmfile;
 
-allow $1_t $1_fonts_cache_t:file create_file_perms;
 create_dir_file($1_t, $1_fonts_t)
+allow $1_t $1_fonts_t:{ dir file } { relabelto relabelfrom };
 
-') dnl gnome_domain
+create_dir_file($1_t, $1_fonts_config_t)
+allow $1_t $1_fonts_config_t:file { relabelto relabelfrom };
 
+') dnl fontconfig_domain
 
+####################
+
+define(`read_fonts', `
+
+# Read global fonts and font config
+r_dir_file($1, fonts_t)
+r_dir_file($1, etc_t)
+
+ifelse(`$2', `', `', `
+
+# Automatically manipulated by libfontconfig
+allow $1 $2_fonts_cache_t:file create_file_perms;
+
+# Read per user fonts and font config
+r_dir_file($1, $2_fonts_t)
+r_dir_file($1, $2_fonts_config_t)
+
+# There are some fonts in .gnome2
+allow $1 $2_gnome_settings_t:dir { getattr search };
+')
+') dnl read_fonts
diff -Naur --exclude-from=excludes policy.orig/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.orig/macros/program/games_domain.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/games_domain.te	2005-05-28 19:35:35.000000000 -0400
@@ -22,17 +22,21 @@
 
 can_create_pty($1_games)
 
-# X access, /tmp files
+# X access, GNOME, /tmp files
 x_client_domain($1_games, $1)
 tmp_domain($1_games, `', { dir notdevfile_class_set })
+gnome_application($1_games, $1)
+gnome_file_dialog($1_games_t)
+
+# Ice connection to gnome-session
+ice_connect($1_games, $1)
 
-uses_shlib($1_games_t)
-read_locale($1_games_t)
 read_sysctl($1_games_t)
-access_terminal($1_games_t, $1)
+dontaudit $1_games_t sysctl_t:dir search;
 
 # Fork
 allow $1_games_t self:process { fork signal_perms getsched };
+allow $1_games_t self:fifo_file rw_file_perms;
 
 # Games seem to need this
 if (allow_execmem) {
@@ -46,30 +50,26 @@
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
-r_dir_file($1_games_t, usr_t)
 can_udp_send($1_games_t, $1_games_t)
 can_tcp_connect($1_games_t, $1_games_t)
 
 # Access /home/user/.gnome2
-create_dir_file($1_games_t, $1_home_t)
-allow $1_games_t $1_home_dir_t:dir { read getattr search };
-allow $1_games_t $1_home_t:dir { read getattr };
+# FIXME: Change to use per app types
+create_dir_file($1_games_t, $1_gnome_settings_t)
 
+# FIXME: why is this necessary - ORBit?
+# ORBit works differently now
 create_dir_file($1_games_t, $1_tmp_t)
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
+can_unix_connect($1_t, $1_games_t)
+can_unix_connect($1_games_t, $1_t)
 
-dontaudit $1_games_t sysctl_t:dir search;
-
-allow $1_games_t urandom_device_t:chr_file { getattr ioctl read };
 ifdef(`xdm.te', `
 allow $1_games_t xdm_tmp_t:dir rw_dir_perms;
 allow $1_games_t xdm_tmp_t:sock_file create_file_perms;
 allow $1_games_t xdm_var_lib_t:file { getattr read };
 ')dnl end if xdm.te
 
-can_unix_connect($1_t, $1_games_t)
-can_unix_connect($1_games_t, $1_t)
-
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
 allow $1_games_t { proc_t self }:dir search;
@@ -79,9 +79,8 @@
 ')
 allow $1_games_t event_device_t:chr_file getattr;
 allow $1_games_t mouse_device_t:chr_file getattr;
-allow $1_games_t self:file { getattr read };
-allow $1_games_t self:fifo_file rw_file_perms;
 
+allow $1_games_t self:file { getattr read };
 allow $1_games_t self:sem create_sem_perms;
 
 allow $1_games_t { bin_t sbin_t }:dir { getattr search };
@@ -92,13 +91,12 @@
 dontaudit $1_games_t initrc_var_run_t:file { read write };
 dontaudit $1_games_t var_log_t:dir search;
 
-# Allow games to read /etc/mtab and /etc/nsswitch.conf
-allow $1_games_t etc_t:file { getattr read };
-allow $1_games_t etc_runtime_t:file { getattr read };
-
 can_network($1_games_t)
 allow $1_games_t port_t:tcp_socket name_bind;
 allow $1_games_t port_t:tcp_socket name_connect;
 
+# Suppress .icons denial until properly implemented
+dontaudit $1_games_t $1_home_t:dir read;
+
 ')dnl end macro definition
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/gconf_macros.te policy/macros/program/gconf_macros.te
--- policy.orig/macros/program/gconf_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/gconf_macros.te	2005-05-27 16:25:17.000000000 -0400
@@ -0,0 +1,58 @@
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
+gnome_application($1_gconfd, $1)
+
+# Transition from user type
+domain_auto_trans($1_t, gconfd_exec_t, $1_gconfd_t)
+role $1_r types $1_gconfd_t;
+
+allow $1_gconfd_t self:process { signal getsched };
+
+read_sysctl($1_gconfd_t)
+
+# Access .gconfd and .gconf
+home_domain($1, gconfd)
+
+# Access /etc/gconf
+r_dir_file($1_gconfd_t, gconf_etc_t)
+
+# /tmp/gconfd-USER
+tmp_domain($1_gconfd)
+
+ifdef(`xdm.te', `
+allow $1_gconfd_t xdm_t:fd use;
+allow $1_gconfd_t xdm_t:fifo_file write;
+')
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
+# Connect over bonobo
+bonobo_connect($1, $2_gconfd, $1)
+
+# Read lock/ior
+allow $1_t $2_gconfd_tmp_t:dir { getattr search };
+allow $1_t $2_gconfd_tmp_t:file { getattr read }; 
+
+') dnl gconf_client 
diff -Naur --exclude-from=excludes policy.orig/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.orig/macros/program/gift_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/gift_macros.te	2005-05-29 14:43:32.000000000 -0400
@@ -17,60 +17,34 @@
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
 role $1_r types $1_gift_t;
 
-# X access, Home files, /tmp
+# X access, Home files, GNOME, /tmp
 x_client_domain($1_gift, $1)
+gnome_application($1_gift, $1)
 home_domain($1, gift)
 tmp_domain($1_gift)
 
-uses_shlib($1_gift_t)
-read_locale($1_gift_t)
-read_sysctl($1_gift_t)
-access_terminal($1_gift_t, $1)
-
 # Allow the user domain to signal/ps.
 can_ps($1_t, $1_gift_t)
 allow $1_t $1_gift_t:process signal_perms;
 
-# Self permissions
-allow $1_gift_t self:process getsched;
-allow $1_gift_t self:fifo_file { read write };
-
-# Fonts, icons
-r_dir_file($1_gift_t, usr_t)
-
 # Launch gift daemon
 allow $1_gift_t bin_t:dir search;
 allow $1_gift_t self:process { fork signal_perms getsched };
+allow $1_gift_t self:fifo_file { read write };
 domain_auto_trans($1_gift_t, giftd_exec_t, $1_giftd_t)
 
 # Connect to gift daemon
-can_network($1_gift_t)
-allow $1_gift_t port_type:tcp_socket name_connect;
+can_network_client($1_gift_t)
+allow $1_gift_t giftd_port_t:tcp_socket name_connect;
 
-# Read /proc/meminfo
+# Read /proc/meminfo, sysctl
+read_sysctl($1_gift_t)
 allow $1_gift_t proc_t:dir search;
 allow $1_gift_t proc_t:file { getattr read };
 
-# Read /etc/mtab, /etc/nsswitch.conf
-allow $1_gift_t etc_t:file { getattr read };
-allow $1_gift_t etc_runtime_t:file { getattr read };
-
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
-# Access random device
-allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
-
-# giftui looks in .icons, .themes, .fonts-cache.
+# giftui looks in .icons, .themes.
 dontaudit $1_gift_t $1_home_t:dir { getattr read search };
-dontaudit $1_gift_t $1_home_t:file { getattr read unlink };
+dontaudit $1_gift_t $1_home_t:file { getattr read };
 
 ') dnl gift_domain
 
@@ -104,15 +78,18 @@
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
-	
-# Allow networking
-allow $1_giftd_t port_t:tcp_socket { name_bind name_connect };
-allow $1_giftd_t port_t:udp_socket name_bind;
+
+# Serve content on various p2p networks 
 can_network_server($1_giftd_t)
-can_network_client($1_giftd_t)
+allow $1_giftd_t self:udp_socket listen;
+allow $1_giftd_t giftd_port_t:tcp_socket name_bind;
+allow $1_giftd_t giftd_openft_port_t:tcp_socket name_bind;
+allow $1_giftd_t giftd_fasttrack_port_t:{ tcp_socket udp_socket } name_bind;
+allow $1_giftd_t giftd_gnutella_port_t:tcp_socket name_bind;
 
-# FIXME: ???
-dontaudit $1_giftd_t self:udp_socket listen;
+# Connect to various p2p networks
+can_network_client($1_giftd_t)
+allow $1_giftd_t port_t:tcp_socket name_connect;
 
 # Plugins
 r_dir_file($1_giftd_t, usr_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/gnome_macros.te policy/macros/program/gnome_macros.te
--- policy.orig/macros/program/gnome_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/gnome_macros.te	2005-05-27 16:32:36.000000000 -0400
@@ -0,0 +1,90 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# gnome_domain(role_prefix) - create GNOME domain (run for each role)
+# gnome_application(app_prefix, role_prefix) - common stuff for gnome apps
+# gnome_file_dialog(role_prefix) - gnome file dialog rules
+# gnome_private_store(app_prefix, role_prefix) - store private files in .gnome2_private
+
+define(`gnome_domain', `
+
+# Types for .gnome2 and .gnome2_private.
+# For backwards compatibility, allow unrestricted
+# access from ROLE_t. However, content inside
+# *should* be labeled per application eventually.
+# For .gnome2_private, use the private_store macro below. 
+
+type $1_gnome_settings_t, file_type, $1_file_type, sysadmfile;
+create_dir_file($1_t, $1_gnome_settings_t)
+
+type $1_gnome_secret_t, file_type, $1_file_type, sysadmfile;
+create_dir_file($1_t, $1_gnome_secret_t)
+
+# GConf domain
+gconfd_domain($1)
+gconf_client($1, $1)
+
+# Bonobo-activation-server
+bonobo_domain($1)
+bonobo_client($1, $1)
+')
+
+#################################
+
+define(`gnome_application', `
+
+# If launched from a terminal
+access_terminal($1_t, $2)
+
+# Shlib, locale 
+uses_shlib($1_t)
+read_locale($1_t)
+
+# Most gnome apps use bonobo
+bonobo_client($1, $2)
+
+# Some talk to themselves over bonobo (?)
+bonobo_connect($1, $1)
+
+# Most talk to GConf
+gconf_client($1, $2)
+
+# Allow getattr/read/search of .gnome2 and .gnome2_private
+# Reading files should *not* be allowed - instead, more specific
+# types should be created to handle such requests
+allow $1_t { $2_gnome_settings_t $2_gnome_secret_t }:dir r_dir_perms;
+
+# Access /etc/mtab, /etc/nsswitch.conf
+allow $1_t etc_t:file { read getattr };
+allow $1_t etc_runtime_t:file { read getattr };
+
+# Themes, gtkrc
+allow $1_t usr_t:{ file lnk_file } r_file_perms;
+
+') dnl gnome_application
+
+################################
+
+define(`gnome_file_dialog', `
+
+# GNOME Open/Save As dialogs 
+dontaudit_getattr($1)
+dontaudit_search_dir($1)
+ 
+') dnl gnome_file_dialog
+
+################################
+
+define(`gnome_private_store', `
+
+# Type for storing secret data
+# (different from home, not directly accessible from ROLE_t)
+type $1_secret_t, file_type, sysadmfile;
+
+# Put secret files in .gnome2_private
+file_type_auto_trans($1_t, $2_gnome_secret_t, $1_secret_t, file);
+allow $2_t $1_secret_t:file unlink;
+
+') dnl gnome_private_store
diff -Naur --exclude-from=excludes policy.orig/macros/program/iceauth_macros.te policy/macros/program/iceauth_macros.te
--- policy.orig/macros/program/iceauth_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/iceauth_macros.te	2005-05-27 12:45:07.000000000 -0400
@@ -0,0 +1,22 @@
+#
+# Macros for iceauth domains.
+#
+# Author:  Ivan Gyurdiev <gyurdiev@redhat.com>
+#
+# iceauth_domain(domain_prefix)
+
+define(`iceauth_domain',`
+
+# Program type
+type $1_iceauth_t, domain;
+
+# Transition from the user domain to this domain.
+domain_auto_trans($1_t, iceauth_exec_t, $1_iceauth_t)
+role $1_r types $1_iceauth_t;
+
+# Store .ICEauthority files
+home_domain($1, iceauth, file)
+
+# FIXME: policy is incomplete
+
+')dnl end xauth_domain macro
diff -Naur --exclude-from=excludes policy.orig/macros/program/ice_macros.te policy/macros/program/ice_macros.te
--- policy.orig/macros/program/ice_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/ice_macros.te	2005-05-28 12:14:44.000000000 -0400
@@ -0,0 +1,52 @@
+#
+# ICE related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# ice_domain(prefix, role) - create ICE sockets
+# ice_connect(type1_prefix, type2_prefix) - allow communication through ICE sockets 
+
+define(`ice_domain', `
+ifdef(`$1_ice_tmp_t_defined',`', `
+define(`$1_ice_tmp_t_defined')
+
+# FIXME: Must have the ability to create the .ICE-unix folder
+# FIXME: The .ICE-unix folder must be properly labeled on startup,
+# (probably requires similar integration as ORBit):
+
+	# Create the ICE-unix directory if necessary
+	#allow $1_t ice_tmp_t:dir create_dir_perms;
+
+	# Set its type - libselinux integration
+	#can_setfscreate($1_t)
+	#can_getsecurity($1_t)
+	#r_dir_file($1_t, selinux_config_t)
+	#r_dir_file($1_t, file_context_t)
+	#allow $1_t default_context_t:dir search;
+
+# Type for ICE sockets
+type $1_ice_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans($1_t, ice_tmp_t, $1_ice_tmp_t)
+
+# Create the sockets
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_t self:unix_dgram_socket create_socket_perms;
+
+# FIXME: How does iceauth tie in?
+
+')
+')
+
+# FIXME: Should this be bidirectional?
+# Adding only unidirectional for now.
+
+define(`ice_connect', `
+
+# Read .ICEauthority file
+allow $1_t $2_iceauth_home_t:file { read getattr };
+
+can_unix_connect($1_t, $2_t)
+allow $1_t ice_tmp_t:dir r_dir_perms;
+allow $1_t $2_ice_tmp_t:sock_file { read write };
+allow $1_t $2_t:unix_stream_socket { read write };
+')
diff -Naur --exclude-from=excludes policy.orig/macros/program/mail_client_macros.te policy/macros/program/mail_client_macros.te
--- policy.orig/macros/program/mail_client_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/mail_client_macros.te	2005-05-27 17:35:20.000000000 -0400
@@ -0,0 +1,60 @@
+#
+# Shared macro for mail clients
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Home access
+bool mail_writehome false;
+bool mail_readhome false;
+
+########################################
+# mail_client_domain(client, role_prefix)
+#
+
+define(`mail_client_domain', `
+
+# Allow networking
+can_network_client($1_t)
+can_ypbind($1_t)
+
+# Allow netstat
+allow $1_t bin_t:dir search;
+can_exec($1_t, bin_t)
+r_dir_file($1_t, proc_net_t)
+allow $1_t sysctl_net_t:dir search;
+
+# Allow POP/IMAP/SMTP/NNTP/LDAP
+allow $1_t { pop_port_t smtp_port_t innd_port_t ldap_port_t }:tcp_socket name_connect;
+
+# Allow printing the mail
+allow $1_t ipp_port_t:tcp_socket name_connect;
+ifdef(`cups.te',`
+allow $1_t cupsd_etc_t:dir r_dir_perms;
+allow $1_t cupsd_rw_etc_t:file r_file_perms;
+')
+ifdef(`lpr.te', `
+domain_auto_trans($1_t, lpr_exec_t, $2_lpr_t)
+')
+# FIXME - common type needed for internet content
+allow $2_lpr_t $1_tmp_t:file r_file_perms;
+
+# Save mail in the home directory
+# FIXME - common type needed for internet content
+if (mail_writehome) {
+file_type_auto_trans($1_t, { $2_home_t $2_home_dir_t }, $1_home_t, file)
+}
+
+# Read home (for attachments) 
+if (mail_readhome || mail_writehome) {
+r_dir_file($1_t, $2_home_t)
+}
+
+# Encrypt mail
+ifdef(`gpg.te', `
+domain_auto_trans($1_t, gpg_exec_t, $2_gpg_t)
+# FIXME - common type needed for internet content
+allow $2_gpg_t $1_tmp_t:file r_file_perms;
+')
+
+')
diff -Naur --exclude-from=excludes policy.orig/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.orig/macros/program/mozilla_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-05-27 20:18:28.000000000 -0400
@@ -15,6 +15,11 @@
 # The type declaration for the executable type for this program is
 # provided separately in domains/program/mozilla.te. 
 #
+
+# FIXME: Rules were removed to centralize policy in a gnome_app macro
+# A similar thing might be necessary for mozilla compiled without GNOME
+# support (is this possible?). 
+
 define(`mozilla_domain',`
 
 type $1_mozilla_t, domain, web_client_domain, nscd_client_domain, privlog;
@@ -29,21 +34,19 @@
 home_domain($1, mozilla)
 x_client_domain($1_mozilla, $1)
 
-# GNOME Open/Save As dialogs
-dontaudit_getattr($1_mozilla_t)
-dontaudit_search_dir($1_mozilla_t)
+# GNOME integration
+ifdef(`gnome.te', `
+gnome_application($1_mozilla, $1)
+gnome_file_dialog($1_mozilla_t)
+')
 
 # Look for plugins 
 allow $1_mozilla_t bin_t:dir { getattr read search };
 
 can_network_client($1_mozilla_t)
 allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
-#allow $1_mozilla_t port_type:tcp_socket name_connect;
 
-uses_shlib($1_mozilla_t)
-read_locale($1_mozilla_t)
 read_sysctl($1_mozilla_t)
-access_terminal($1_mozilla_t, $1)
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
@@ -58,15 +61,12 @@
 # Fork, set resource limits and scheduling info.
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
-allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
-
 # Access /proc
 allow $1_mozilla_t proc_t:dir search;
 allow $1_mozilla_t proc_t:file { getattr read };
 allow $1_mozilla_t proc_t:lnk_file read;
 
 allow $1_mozilla_t var_lib_t:file { getattr read };
-allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
 allow $1_mozilla_t self:fifo_file rw_file_perms;
@@ -83,10 +83,6 @@
 
 allow $1_mozilla_t { var_t var_lib_t }:dir search;
 
-# Allow mozilla to read /etc/mtab, /etc/nsswitch.conf
-allow $1_mozilla_t etc_t:file { getattr read };
-allow $1_mozilla_t etc_runtime_t:file { getattr read };
-
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
@@ -96,14 +92,6 @@
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
-# ORBit sockets
-file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
-can_unix_connect($1_t, $1_mozilla_t)
-allow $1_t $1_mozilla_tmp_t:sock_file write;
-allow $1_mozilla_t $1_tmp_t:file { read write lock };
-allow $1_mozilla_t $1_tmp_t:sock_file { read write };
-dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
-
 # Allow mozilla to read user home content
 if (mozilla_readhome || mozilla_writehome) {
 r_dir_file($1_mozilla_t, $1_home_t)
@@ -113,10 +101,11 @@
 }
 
 if (mozilla_writehome) {
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t)
-allow $1_mozilla_t $1_home_t:dir setattr;
-allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
-} dnl end if writehome
+# FIXME: Common internet downloads type is needed here.
+# FIXME: additionally, dir transition to such a type conflicts with ~/.mozilla
+file_type_auto_trans($1_mozilla_t, $1_home_dir_t, $1_mozilla_home_t, file )
+file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t, { dir file } )
+}
 
 allow $1_mozilla_t $1_t:unix_stream_socket connectto;
 allow $1_mozilla_t sysctl_net_t:dir search;
@@ -130,8 +119,6 @@
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
-# Mozilla tries to delete .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file unlink;
 allow $1_mozilla_t self:sem create_sem_perms;
 
 # Java plugin
@@ -139,7 +126,6 @@
 javaplugin_domain($1_mozilla, $1)
 ')
 
-
 # Use printer
 ifdef(`lpr.te', `
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
@@ -148,6 +134,7 @@
 allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
 
 # Suppress history.fop denial
+# FIXME: common type is needed for internet content
 dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
 
 dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
@@ -159,6 +146,7 @@
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
 
 # Read mozilla content in /tmp
+# FIXME: common type is needed for internet content
 r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
 
 # Suppress history.fop denial
@@ -167,6 +155,12 @@
 dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
+# Launch email client, and make webcal links work
+ifdef(`evolution.te', `
+domain_auto_trans($1_mozilla_t, evolution_exec_t, $1_evolution_t)
+domain_auto_trans($1_mozilla_t, evolution_webcal_exec_t, $1_evolution_webcal_t)
+')
+
 if (allow_execmem) {
 allow $1_mozilla_t self:process execmem;
 }
diff -Naur --exclude-from=excludes policy.orig/macros/program/orbit_macros.te policy/macros/program/orbit_macros.te
--- policy.orig/macros/program/orbit_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/orbit_macros.te	2005-05-28 13:35:19.000000000 -0400
@@ -0,0 +1,51 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# orbit_domain(prefix, role_prefix) - create ORBit sockets
+# orbit_connect(type1_prefix, type2_prefix) 
+#	- allow communication through ORBit sockets from type1 to type2 
+
+define(`orbit_domain', `
+
+# Protect against double inclusion for speed and correctness
+ifdef(`orbit_domain_$1_$2', `', `
+define(`orbit_domain_$1_$2')
+
+# Create the user orbit directory if necessary
+allow $1_t $2_orbit_tmp_t:dir create_dir_perms;
+
+# Set its type - libselinux integration
+can_setfscreate($1_t)
+can_getsecurity($1_t)
+r_dir_file($1_t, selinux_config_t)
+r_dir_file($1_t, file_context_t)
+allow $1_t default_context_t:dir search;
+
+# Type for ORBit sockets
+type $1_orbit_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans($1_t, $2_orbit_tmp_t, $1_orbit_tmp_t)
+
+# Create the sockets
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_t self:unix_dgram_socket create_socket_perms;
+
+# Write to bonobo files
+allow $1_t $2_orbit_tmp_t:file { getattr read write lock };
+dontaudit $1_t $2_orbit_tmp_t:dir setattr;
+
+# Use random device(s)
+allow $1_t { random_device_t urandom_device_t }:chr_file { read getattr ioctl };
+
+') dnl ifdef orbit_domain_args
+') dnl orbit_domain
+
+##########################
+
+define(`orbit_connect', `
+
+can_unix_connect($1_t, $2_t)
+allow $1_t $2_orbit_tmp_t:sock_file write;
+
+') dnl orbit_connect
diff -Naur --exclude-from=excludes policy.orig/macros/program/spamassassin_macros.te policy/macros/program/spamassassin_macros.te
--- policy.orig/macros/program/spamassassin_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/spamassassin_macros.te	2005-05-26 11:21:37.000000000 -0400
@@ -29,7 +29,7 @@
 # Note: most of this should really be in a generic macro like
 # base_user_program($1, foo)
 define(`spamassassin_program_domain',`
-type $1_$2_t, domain, privlog;
+type $1_$2_t, domain, privlog $3;
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
 
 role $1_r types $1_$2_t;
@@ -76,6 +76,7 @@
 allow $1_spamassassin_t lib_t:file rx_file_perms;
 # Ignore perl digging in /proc and /var.
 dontaudit $1_spamassassin_t proc_t:dir search;
+dontaudit $1_spamassassin_t proc_t:lnk_file read;
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
 # For ~/.spamassassin
@@ -95,7 +96,7 @@
 # Define the domain for /usr/bin/spamc
 #
 ifdef(`spamc.te',`
-spamassassin_program_domain($1, spamc)
+spamassassin_program_domain($1, spamc, `, nscd_client_domain')
 can_network($1_spamc_t)
 allow $1_spamc_t port_type:tcp_socket name_connect;
 can_ypbind($1_spamc_t)
@@ -103,6 +104,8 @@
 # Allow connecting to a local spamd
 ifdef(`spamd.te',`
 can_tcp_connect($1_spamc_t, spamd_t)
+can_unix_connect($1_spamc_t, spamd_t)
+allow $1_spamc_t spamd_tmp_t:sock_file rw_file_perms;
 ') dnl endif spamd.te
 ') dnl endif spamc.te
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/thunderbird_macros.te policy/macros/program/thunderbird_macros.te
--- policy.orig/macros/program/thunderbird_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/program/thunderbird_macros.te	2005-05-27 16:26:44.000000000 -0400
@@ -0,0 +1,63 @@
+#
+# Thunderbird
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+#######################################
+# thunderbird_domain(role_prefix)
+#
+
+# FIXME: Rules were removed to centralize policy in a gnome_app macro
+# A similar thing might be necessary for mozilla compiled without GNOME
+# support (is this possible?).
+
+define(`thunderbird_domain', `
+
+# Type for program
+type $1_thunderbird_t, domain, nscd_client_domain;
+
+# Transition from user type
+domain_auto_trans($1_t, thunderbird_exec_t, $1_thunderbird_t)
+role $1_r types $1_thunderbird_t;
+
+# Startup shellscripts
+allow $1_thunderbird_t bin_t:dir r_dir_perms;
+allow $1_thunderbird_t bin_t:lnk_file r_file_perms;
+can_exec($1_thunderbird_t, bin_t)
+can_exec($1_thunderbird_t, shell_exec_t)
+
+# FIXME: Why does it try to do that?
+dontaudit $1_thunderbird_t evolution_exec_t:file { getattr execute };
+
+# Why is thunderbird looking in .mozilla ?
+# FIXME: there are legitimate uses of invoking the browser - about -> release notes
+dontaudit $1_thunderbird_t $1_mozilla_home_t:dir search;
+
+# .kde/....gtkrc
+# FIXME: support properly 
+dontaudit $1_thunderbird_t $1_home_t:file { getattr read };
+
+# Fork
+allow $1_thunderbird_t self:process { fork getsched setsched sigchld signal };
+allow $1_thunderbird_t self:fifo_file rw_file_perms;
+
+# X, mail common stuff
+x_client_domain($1_thunderbird, $1)
+mail_client_domain($1_thunderbird, $1)
+
+# GNOME support
+ifdef(`gnome.te', `
+gnome_application($1_thunderbird, $1)
+gnome_file_dialog($1_thunderbird_t)
+')
+
+# Access ~/.thunderbird
+home_domain($1, thunderbird)
+
+read_sysctl($1_thunderbird_t)
+tmp_domain($1_thunderbird)
+
+# RSS feeds
+allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
+')
diff -Naur --exclude-from=excludes policy.orig/macros/program/xauth_macros.te policy/macros/program/xauth_macros.te
--- policy.orig/macros/program/xauth_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/xauth_macros.te	2005-05-27 17:00:09.000000000 -0400
@@ -23,7 +23,7 @@
 
 allow $1_xauth_t self:process signal;
 
-home_domain($1, xauth)
+home_domain($1, xauth, file)
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, xauth_exec_t, $1_xauth_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.orig/macros/program/x_client_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/x_client_macros.te	2005-05-28 12:22:36.000000000 -0400
@@ -16,10 +16,6 @@
 # Connect to xserver
 can_unix_connect($1_t, $2_xserver_t)
 
-# /tmp/.ICE_unix
-allow $1_t $2_xserver_tmp_t:dir search;
-allow $1_t $2_xserver_tmp_t:sock_file rw_file_perms;
-
 # Stat /tmp/.X0-lock
 allow $1_t $2_xserver_tmp_t:file getattr;
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- policy.orig/macros/program/xserver_macros.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/macros/program/xserver_macros.te	2005-05-28 12:39:12.000000000 -0400
@@ -79,6 +79,12 @@
 allow xdm_xserver_t init_t:fd use;
 
 dontaudit xdm_xserver_t home_dir_type:dir { read search };
+
+# Read all global and per user fonts
+read_fonts($1_xserver_t, sysadm)
+read_fonts($1_xserver_t, staff)
+read_fonts($1_xserver_t, user)
+
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
@@ -92,12 +98,13 @@
 
 can_unix_connect($1_t, $1_xserver_t)
 
+# Read fonts
+read_fonts($1_xserver_t, $1)
+
 # Access the home directory.
 allow $1_xserver_t home_root_t:dir search;
 allow $1_xserver_t $1_home_dir_t:dir { getattr search };
-if (allow_xserver_home_fonts) {
-r_dir_file($1_xserver_t, $1_home_t)
-}
+
 ifdef(`xauth.te', `
 domain_auto_trans($1_xserver_t, xauth_exec_t, $1_xauth_t)
 allow $1_xserver_t $1_xauth_home_t:file { getattr read };
@@ -174,8 +181,6 @@
 ifdef(`xdm.te', `
 allow $1_t xdm_tmp_t:sock_file unlink;
 allow $1_xserver_t xdm_var_run_t:dir search;
-# for /tmp/.ICE-unix
-file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
 ')
 
 # Signal the user domain.
@@ -263,8 +268,6 @@
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, xkb_var_lib_t)
 
-# for fonts
-r_dir_file($1_xserver_t, fonts_t)
 ')dnl end macro definition
 
 ', `
diff -Naur --exclude-from=excludes policy.orig/net_contexts policy/net_contexts
--- policy.orig/net_contexts	2005-05-26 12:06:31.000000000 -0400
+++ policy/net_contexts	2005-05-29 14:37:25.000000000 -0400
@@ -136,6 +136,14 @@
 portcon tcp 995 system_u:object_r:pop_port_t
 portcon tcp 1109 system_u:object_r:pop_port_t
 ')
+ifdef(`gift.te', `
+portcon tcp 1213 system_u:object_r:giftd_port_t
+portcon tcp 1214 system_u:object_r:giftd_fasttrack_port_t
+portcon udp 1214 system_u:object_r:giftd_fasttrack_port_t
+portcon tcp 2141 system_u:object_r:giftd_openft_port_t
+portcon tcp 2513 system_u:object_r:giftd_openft_port_t
+portcon tcp 3606 system_u:object_r:giftd_gnutella_port_t
+')
 ifdef(`nessusd.te', `portcon tcp 1241 system_u:object_r:nessus_port_t')
 ifdef(`monopd.te', `portcon tcp 1234 system_u:object_r:monopd_port_t')
 ifdef(`radius.te', `
diff -Naur --exclude-from=excludes policy.orig/types/network.te policy/types/network.te
--- policy.orig/types/network.te	2005-05-26 12:06:31.000000000 -0400
+++ policy/types/network.te	2005-05-28 12:35:17.000000000 -0400
@@ -39,6 +39,8 @@
 ifdef(`dovecot.te', `define(`use_pop')')
 ifdef(`uwimapd.te', `define(`use_pop')')
 ifdef(`fetchmail.te', `define(`use_pop')')
+ifdef(`thunderbird.te', `define(`use_pop')')
+ifdef(`evolution.te', `define(`use_pop')')
 ifdef(`use_pop', `
 type pop_port_t, port_type, reserved_port_type;
 ')

--=-/ZUAfpuqt9gG6mI54NwG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
