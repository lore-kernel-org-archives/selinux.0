Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j21BVeDo000597
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 06:31:40 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j21BSC6U009977
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 11:28:12 GMT
Subject: Re: [ PATCH ] home_domain macro / x_client cleanup patch
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109613763.10399.23.camel@cobra.ivg2.net>
References: <1109437744.4873.28.camel@cobra.ivg2.net>
	 <1109531369.21556.28.camel@cobra.ivg2.net>
	 <1109613763.10399.23.camel@cobra.ivg2.net>
Content-Type: multipart/mixed; boundary="=-W/aMiCXIeNFA1Pz6zDFr"
Date: Tue, 01 Mar 2005 06:31:58 -0500
Message-Id: <1109676719.28919.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-W/aMiCXIeNFA1Pz6zDFr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Home_domain_v5 attached.
- corrects bug in home_domain_ro typealias
- adds $1_home_$2_t typealias for home_domain_ro
- adds screen and irc to the list of domains using this.
screen uses the ro domain only. 
- adds fixes for games_domain denials that I caused 

Ok, at this point the only controversial thing that I see left 
is that home_domain macros allow both directories and files
to operated on, and rw macro allows creation of directories.
Previously some domains were only given permission to 
work with files, and some were given permissions to directories,
but not to create them. I'm not sure if this is a huge problem.

If there are no objections, please apply.

(other pending patch is security.diff that marks policy_src_t 
 and policy_config_t as sysadmfile)

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-W/aMiCXIeNFA1Pz6zDFr
Content-Disposition: attachment; filename=home_domain_v5.diff
Content-Type: text/x-patch; name=home_domain_v5.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aru policy.old/file_contexts/program/mozilla.fc policy/file_contexts/program/mozilla.fc
--- policy.old/file_contexts/program/mozilla.fc	2005-02-26 08:28:59.000000000 -0500
+++ policy/file_contexts/program/mozilla.fc	2005-02-28 11:45:21.000000000 -0500
@@ -1,13 +1,13 @@
 #  netscape/mozilla
-HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
-HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_home_t
+HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_home_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
diff -aru policy.old/file_contexts/program/mplayer.fc policy/file_contexts/program/mplayer.fc
--- policy.old/file_contexts/program/mplayer.fc	2005-02-26 08:36:20.000000000 -0500
+++ policy/file_contexts/program/mplayer.fc	2005-02-28 11:45:30.000000000 -0500
@@ -3,4 +3,4 @@
 /usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
 
 /etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
-HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
+HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_home_t
diff -aru policy.old/file_contexts/program/screen.fc policy/file_contexts/program/screen.fc
--- policy.old/file_contexts/program/screen.fc	2005-03-01 05:56:51.000000000 -0500
+++ policy/file_contexts/program/screen.fc	2005-03-01 06:15:35.000000000 -0500
@@ -1,5 +1,5 @@
 # screen
 /usr/bin/screen		--	system_u:object_r:screen_exec_t
-HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_home_screen_t
+HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_screen_ro_home_t
 /var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
 /var/run/screen/S-[^/]+/.*	<<none>>
diff -aru policy.old/file_contexts/program/spamassassin.fc policy/file_contexts/program/spamassassin.fc
--- policy.old/file_contexts/program/spamassassin.fc	2005-02-28 11:55:19.000000000 -0500
+++ policy/file_contexts/program/spamassassin.fc	2005-02-28 11:55:30.000000000 -0500
@@ -1,3 +1,3 @@
 # spamassasin
 /usr/bin/spamassassin	--	system_u:object_r:spamassassin_exec_t
-HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:ROLE_home_spamassassin_t
+HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:ROLE_spamassassin_home_t
diff -aru policy.old/file_contexts/program/xauth.fc policy/file_contexts/program/xauth.fc
--- policy.old/file_contexts/program/xauth.fc	2005-02-26 08:36:25.000000000 -0500
+++ policy/file_contexts/program/xauth.fc	2005-02-28 11:45:39.000000000 -0500
@@ -1,3 +1,3 @@
 # xauth
 /usr/X11R6/bin/xauth	--	system_u:object_r:xauth_exec_t
-HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_home_xauth_t
+HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_xauth_home_t
diff -aru policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-02-26 08:47:21.000000000 -0500
+++ policy/macros/base_user_macros.te	2005-02-28 11:44:17.000000000 -0500
@@ -187,10 +187,7 @@
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
-ifdef(`mplayer.te', `
-mplayer_domain($1)
-mencoder_domain($1)
-')
+ifdef(`mplayer.te', `mplayer_domains($1)')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
@@ -301,7 +298,7 @@
 allow $1_t xdm_var_lib_t:file { getattr read };
 allow xdm_t $1_home_dir_t:dir getattr;
 ifdef(`xauth.te', `
-file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_xauth_t, file)
+file_type_auto_trans(xdm_t, $1_home_dir_t, $1_xauth_home_t, file)
 ')
 
 # for shared memory
diff -aru policy.old/macros/global_macros.te policy/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-02-26 07:42:38.000000000 -0500
+++ policy/macros/global_macros.te	2005-03-01 06:10:32.000000000 -0500
@@ -474,6 +474,63 @@
 file_type_auto_trans($1_t, var_lock_t, $1_lock_t, file)
 ')
 
+####################################################################
+# home_domain (prefix, app)
+#
+# Creates a domain in the prefix home where an application can
+# store its settings. It's accessible by the prefix domain.
+#
+
+define(`home_domain', `
+type $1_$2_home_t, file_type, $1_file_type, sysadmfile;
+
+allow $1_$2_t home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+create_dir_file($1_$2_t, nfs_t)
+}
+if (use_samba_home_dirs) {
+create_dir_file($1_$2_t, cifs_t)
+}
+allow $1_$2_t autofs_t:dir { search getattr };
+
+file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_home_t)
+create_dir_file($1_t, $1_$2_home_t)
+allow $1_t $1_$2_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+typealias $1_$2_home_t alias $1_$2_rw_t;
+typealias $1_$2_home_t alias $1_home_$2_t;
+')
+
+####################################################################
+# home_domain_ro (prefix, app)
+#
+# Creates a read-only domain in the prefix home where an application can
+# store its settings. It's fully accessible by the prefix domain, but
+# it's read-only for the application.
+#
+
+define(`home_domain_ro', `
+type $1_$2_ro_home_t, file_type, $1_file_type, sysadmfile;
+
+allow $1_$2_t home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+r_dir_file($1_$2_t, nfs_t)
+}
+if (use_samba_home_dirs) {
+r_dir_file($1_$2_t, cifs_t)
+}
+allow $1_$2_t autofs_t:dir { search getattr };
+
+r_dir_file($1_$2_t, $1_$2_ro_home_t)
+create_dir_file($1_t, $1_$2_ro_home_t)
+allow $1_t $1_$2_ro_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+typealias $1_$2_ro_home_t alias $1_$2_ro_t;
+typealias $1_$2_ro_home_t alias $1_home_$2_t;
+')
+
 #######################
 # application_domain(domain_prefix)
 #
diff -aru policy.old/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.old/macros/program/games_domain.te	2005-02-26 06:35:24.000000000 -0500
+++ policy/macros/program/games_domain.te	2005-03-01 05:48:13.000000000 -0500
@@ -11,13 +11,18 @@
 #
 define(`games_domain', `
 x_client_domain($1, `games', `, transitionbool')
+
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
 r_dir_file($1_games_t, usr_t)
 can_udp_send($1_games_t, $1_games_t)
 can_tcp_connect($1_games_t, $1_games_t)
+
+# Access /home/user/.gnome2
 create_dir_file($1_games_t, $1_home_t)
+allow $1_games_t $1_home_dir_t:dir search;
+allow $1_games_t $1_home_t:dir { read getattr };
 
 create_dir_file($1_games_t, $1_tmp_t)
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
@@ -48,9 +53,6 @@
 # kpat spews errors
 dontaudit $1_games_t bin_t:dir getattr;
 dontaudit $1_games_t var_run_t:dir search;
-ifdef(`xdm.te', `
-dontaudit $1_games_t xdm_xserver_tmp_t:dir getattr;
-')
 
 ')dnl end macro definition
 
diff -aru policy.old/macros/program/irc_macros.te policy/macros/program/irc_macros.te
--- policy.old/macros/program/irc_macros.te	2005-03-01 05:58:54.000000000 -0500
+++ policy/macros/program/irc_macros.te	2005-03-01 06:00:01.000000000 -0500
@@ -18,12 +18,15 @@
 undefine(`irc_domain')
 ifdef(`irc.te', `
 define(`irc_domain',`
+
+# Home domain
+home_domain($1, irc)
+
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
-type $1_home_irc_t, file_type, $1_file_type, sysadmfile;
 type $1_irc_exec_t, file_type, sysadmfile, $1_file_type;
 
-allow $1_t { $1_home_irc_t $1_irc_exec_t }:file { relabelfrom relabelto create_file_perms };
+allow $1_t $1_irc_exec_t:file { relabelfrom relabelto create_file_perms };
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, { irc_exec_t $1_irc_exec_t }, $1_irc_t)
@@ -65,10 +68,6 @@
 allow $1_irc_t initrc_var_run_t:file read;
 dontaudit $1_irc_t initrc_var_run_t:file lock;
 
-# access config files
-allow $1_irc_t home_root_t:dir search;
-file_type_auto_trans($1_irc_t, $1_home_dir_t, $1_home_irc_t, file)
-
 # access files under /tmp
 file_type_auto_trans($1_irc_t, tmp_t, $1_tmp_t)
 
diff -aru policy.old/macros/program/java_macros.te policy/macros/program/java_macros.te
--- policy.old/macros/program/java_macros.te	2005-02-25 15:36:28.000000000 -0500
+++ policy/macros/program/java_macros.te	2005-02-28 11:41:24.000000000 -0500
@@ -105,7 +105,7 @@
 
 uses_shlib($1_javaplugin_t)
 read_locale($1_javaplugin_t)
-rw_dir_file($1_javaplugin_t, $1_rw_t)
+rw_dir_file($1_javaplugin_t, $1_home_t)
 
 if (allow_java_execstack) {
 legacy_domain($1_javaplugin)
@@ -119,8 +119,8 @@
 allow $1_javaplugin_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
 
 allow $1_javaplugin_t home_root_t:dir { getattr search };
-file_type_auto_trans($1_javaplugin_t, $2_home_dir_t, $1_rw_t)
-allow $1_javaplugin_t $2_home_xauth_t:file { getattr read };
+file_type_auto_trans($1_javaplugin_t, $2_home_dir_t, $1_home_t)
+allow $1_javaplugin_t $2_xauth_home_t:file { getattr read };
 allow $1_javaplugin_t $2_tmp_t:sock_file write;
 allow $1_javaplugin_t $2_t:fd use;
 
@@ -131,6 +131,6 @@
 dontaudit $1_javaplugin_t sysadm_devpts_t:chr_file { read write };
 dontaudit $1_javaplugin_t devtty_t:chr_file { read write };
 dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
-dontaudit $1_javaplugin_t $1_rw_t:file { execute setattr };
+dontaudit $1_javaplugin_t $1_home_t:file { execute setattr };
 
 ')
diff -aru policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-02-26 07:50:08.000000000 -0500
+++ policy/macros/program/mozilla_macros.te	2005-02-28 11:59:28.000000000 -0500
@@ -18,6 +18,9 @@
 define(`mozilla_domain',`
 x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
 
+# Configuration
+home_domain($1, mozilla)
+
 # Allow mozilla to browse files
 file_browse_domain($1_mozilla_t)
 
@@ -36,18 +39,6 @@
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
 
-# for the orbit files of mozilla
-allow $1_t $1_mozilla_rw_t:sock_file create_file_perms;
-can_unix_connect($1_t, $1_mozilla_t)
-
-if (use_nfs_home_dirs) {
-create_dir_file($1_mozilla_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1_mozilla_t, cifs_t)
-}
-allow $1_mozilla_t autofs_t:dir { search getattr };
-
 # for bash
 allow $1_mozilla_t device_t:dir r_dir_perms;
 allow $1_mozilla_t devpts_t:dir r_dir_perms;
@@ -59,37 +50,44 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Execute downloaded programs.
-can_exec($1_mozilla_t, $1_mozilla_rw_t)
+# Write files to tmp
+tmp_domain($1_mozilla)
 
-dontaudit $1_mozilla_t tmpfile:dir setattr;
+# Execute downloaded programs.
+can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
 # Use printer
 ifdef(`lpr.te', `
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-# $1_lpr_t should only need read access to the tmp files
-allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
+
+# Print document
+allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
+
+# Suppress history.fop denial
+dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+
 dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
 dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
 ')
 
-#
-# This is another place where I sould like to allow system customization.
-# We need to allow the admin to select whether then want to allow mozilla
-# access to the users home directories.
-#
+# ORBit sockets
+file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
+can_unix_connect($1_t, $1_mozilla_t)
+allow $1_t $1_mozilla_tmp_t:sock_file write;
+allow $1_mozilla_t $1_tmp_t:file { read write lock };
+allow $1_mozilla_t $1_tmp_t:sock_file { read write };
+dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
+
+# Allow mozilla to read user home content
 if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, { $1_home_t $1_tmp_t })
+r_dir_file($1_mozilla_t, $1_home_t)
 } else {
 dontaudit $1_mozilla_t $1_home_t:dir setattr;
 dontaudit $1_mozilla_t $1_home_t:file setattr;
 }
-allow $1_mozilla_t $1_tmp_t:sock_file rw_file_perms;
-file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
-file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_rw_t)
 
 if (mozilla_writehome) {
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
+file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t)
 allow $1_mozilla_t $1_home_t:dir setattr;
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
 } dnl end if writehome
@@ -110,8 +108,7 @@
 dontaudit $1_mozilla_t $1_home_t:file unlink;
 allow $1_mozilla_t self:sem create_sem_perms;
 
-#
-# Rules needed to run java apps
+# Java plugin
 ifdef(`java.te', `
 javaplugin_domain($1_mozilla, $1)
 ')
@@ -119,9 +116,12 @@
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
-# Read temporary content - mozilla saves stuff there
-r_dir_file($1_mplayer_t, $1_mozilla_rw_t);
-dontaudit $1_mplayer_t $1_mozilla_rw_t:file write;
+
+# Read mozilla content in /tmp
+r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
+
+# FIXME: why does it need this?
+dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
 allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
diff -aru policy.old/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-02-26 07:45:30.000000000 -0500
+++ policy/macros/program/mplayer_macros.te	2005-02-28 11:40:06.000000000 -0500
@@ -6,6 +6,9 @@
 #
 # mplayer_domain(domain_prefix)
 # mencoder_domain(domain_prefix)
+#
+# mplayer_domains(domain_prefix)
+# declares both of them 
 
 ################################################
 #    mplayer_common(prefix, mplayer domain)    #
@@ -13,18 +16,6 @@
 
 define(`mplayer_common',`
 
-# Home directory stuff
-if (use_nfs_home_dirs) {
-create_dir_file($1_$2_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1_$2_t, cifs_t)
-}
-allow $1_$2_t autofs_t:dir { search getattr };
-
-# Read local config
-r_dir_file($1_$2_t, $1_mplayer_rw_t)
-
 # Read global config
 r_dir_file($1_$2_t, mplayer_etc_t)
 
@@ -62,7 +53,6 @@
 allow $1_$2_t removable_device_t:blk_file { getattr read };
 allow $1_$2_t v4l_device_t:chr_file { getattr read };
 
-
 # Legacy domain issues
 if (allow_mplayer_execstack) {
 legacy_domain($1_$2)
@@ -116,3 +106,17 @@
 mplayer_common($1, mencoder)
 
 ') dnl end mencoder_domain
+
+###############################
+#  mplayer_domains(prefix)    #
+###############################
+define(`mplayer_domains', `
+
+# Mplayer common configuration here
+home_domain($1, mplayer)
+
+# Invoke both domains
+mplayer_domain($1)
+mencoder_domain($1)
+') dnl end mplayer_domains
+
diff -aru policy.old/macros/program/screen_macros.te policy/macros/program/screen_macros.te
--- policy.old/macros/program/screen_macros.te	2005-03-01 05:50:43.000000000 -0500
+++ policy/macros/program/screen_macros.te	2005-03-01 06:13:37.000000000 -0500
@@ -22,7 +22,6 @@
 define(`screen_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, $1_file_type, sysadmfile;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
@@ -50,15 +49,7 @@
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
 
-allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
-allow $1_t $1_home_screen_t:file { create_file_perms relabelfrom relabelto };
-allow $1_t $1_home_screen_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-if (use_nfs_home_dirs) {
-r_dir_file($1_screen_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-r_dir_file($1_screen_t, cifs_t)
-}
+home_domain_ro($1, screen)
 
 allow $1_screen_t privfd:fd use;
 
diff -aru policy.old/macros/program/spamassassin_macros.te policy/macros/program/spamassassin_macros.te
--- policy.old/macros/program/spamassassin_macros.te	2005-02-28 11:56:46.000000000 -0500
+++ policy/macros/program/spamassassin_macros.te	2005-02-28 11:53:01.000000000 -0500
@@ -58,8 +58,8 @@
 #
 define(`spamassassin_agent_privs',`
 allow $1 home_root_t:dir r_dir_perms;
-file_type_auto_trans($1, $2_home_dir_t, $2_home_spamassassin_t)
-create_dir_file($1, $2_home_spamassassin_t)
+file_type_auto_trans($1, $2_home_dir_t, $2_spamassassin_home_t)
+create_dir_file($1, $2_spamassassin_home_t)
 
 allow $1 urandom_device_t:chr_file r_file_perms;
 ')
@@ -78,11 +78,8 @@
 dontaudit $1_spamassassin_t proc_t:dir search;
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
-# The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, $1_file_type, sysadmfile;
-create_dir_file($1_t, $1_home_spamassassin_t)
-allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
-allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
+# For ~/.spamassassin
+home_domain($1, spamassassin)
 
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
diff -aru policy.old/macros/program/su_macros.te policy/macros/program/su_macros.te
--- policy.old/macros/program/su_macros.te	2005-02-28 11:57:41.000000000 -0500
+++ policy/macros/program/su_macros.te	2005-02-28 11:43:21.000000000 -0500
@@ -141,9 +141,9 @@
 
 # Modify .Xauthority file (via xauth program).
 ifdef(`xauth.te', `
-file_type_auto_trans($1_su_t, staff_home_dir_t, staff_home_xauth_t, file)
-file_type_auto_trans($1_su_t, user_home_dir_t, user_home_xauth_t, file)
-file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_home_xauth_t, file)
+file_type_auto_trans($1_su_t, staff_home_dir_t, staff_xauth_home_t, file)
+file_type_auto_trans($1_su_t, user_home_dir_t, user_xauth_home_t, file)
+file_type_auto_trans($1_su_t, sysadm_home_dir_t, sysadm_xauth_home_t, file)
 domain_auto_trans($1_su_t, xauth_exec_t, $1_xauth_t)
 ')
 
diff -aru policy.old/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
--- policy.old/macros/program/tvtime_macros.te	2005-02-25 15:36:28.000000000 -0500
+++ policy/macros/program/tvtime_macros.te	2005-02-26 08:41:06.000000000 -0500
@@ -18,9 +18,8 @@
 undefine(`tvtime_domain')
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
-# Derived domain based on the calling user domain and the program.
-type $1_home_tvtime_t, file_type, $1_file_type, sysadmfile;
 
+home_domain($1, tvtime)
 x_client_domain($1, tvtime)
 
 allow $1_tvtime_t urandom_device_t:chr_file read;
diff -aru policy.old/macros/program/uml_macros.te policy/macros/program/uml_macros.te
--- policy.old/macros/program/uml_macros.te	2005-02-28 11:56:58.000000000 -0500
+++ policy/macros/program/uml_macros.te	2005-02-28 11:42:39.000000000 -0500
@@ -103,7 +103,7 @@
 dontaudit $1_uml_t etc_runtime_t:file read;
 can_tcp_connect($1_uml_t, sshd_t)
 ifdef(`xauth.te', `
-allow $1_uml_t $1_home_xauth_t:file { getattr read };
+allow $1_uml_t $1_xauth_home_t:file { getattr read };
 ')
 allow $1_uml_t var_run_t:dir search;
 allow $1_uml_t initrc_var_run_t:file { getattr read };
diff -aru policy.old/macros/program/userhelper_macros.te policy/macros/program/userhelper_macros.te
--- policy.old/macros/program/userhelper_macros.te	2005-02-28 11:57:07.000000000 -0500
+++ policy/macros/program/userhelper_macros.te	2005-02-28 11:43:48.000000000 -0500
@@ -130,7 +130,7 @@
 
 ifdef(`xauth.te', `
 domain_auto_trans($1_userhelper_t, xauth_exec_t, $1_xauth_t)
-allow $1_userhelper_t $1_home_xauth_t:file { getattr read };
+allow $1_userhelper_t $1_xauth_home_t:file { getattr read };
 ')
 
 ifdef(`pamconsole.te', `
diff -aru policy.old/macros/program/xauth_macros.te policy/macros/program/xauth_macros.te
--- policy.old/macros/program/xauth_macros.te	2005-02-26 08:28:08.000000000 -0500
+++ policy/macros/program/xauth_macros.te	2005-02-28 11:40:29.000000000 -0500
@@ -20,11 +20,10 @@
 define(`xauth_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_xauth_t, domain;
-type $1_home_xauth_t, file_type, $1_file_type, sysadmfile;
 
 allow $1_xauth_t self:process signal;
 
-allow $1_t $1_home_xauth_t:file { relabelfrom relabelto create_file_perms };
+home_domain($1, xauth)
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, xauth_exec_t, $1_xauth_t)
@@ -72,23 +71,9 @@
 allow $1_xauth_t var_t:dir search;
 allow $1_xauth_t var_run_t:dir search; 
 
-# this is what we are here for
-allow $1_xauth_t home_root_t:dir search;
-file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_home_xauth_t, file)
-
 tmp_domain($1_xauth)
 allow $1_xauth_t $1_tmp_t:file { getattr ioctl read };
 
-if (use_nfs_home_dirs) {
-allow $1_xauth_t autofs_t:dir { search getattr };
-rw_dir_create_file($1_xauth_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-rw_dir_create_file($1_xauth_t, cifs_t)
-}
-if (use_samba_home_dirs) {
-rw_dir_create_file($1_xauth_t, cifs_t)
-}
 ')dnl end xauth_domain macro
 
 ', `
diff -aru policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-02-26 06:27:46.000000000 -0500
+++ policy/macros/program/x_client_macros.te	2005-02-28 11:42:18.000000000 -0500
@@ -9,15 +9,29 @@
 #
 
 define(`xsession_domain', `
+
+# Connect to xserver
 can_unix_connect($1_t, $2_xserver_t)
+
+# /tmp/.ICE_unix
 allow $1_t $2_xserver_tmp_t:dir search;
 allow $1_t $2_xserver_tmp_t:sock_file rw_file_perms;
+
+# Stat /tmp/.X0-lock
+allow $1_t $2_xserver_tmp_t:file getattr;
+
+# Signal Xserver
 allow $1_t $2_xserver_t:process signal;
-# Use descriptors created by each other.
+
+# Use file descriptors created by each other.
 allow $1_t $2_xserver_t:fd use;
 allow $2_xserver_t $1_t:fd use;
+
+# Xserver read/write parent shm
 allow $2_xserver_t $1_t:shm rw_shm_perms;
 allow $2_xserver_t $1_tmpfs_t:file rw_file_perms;
+
+# Parent read xserver shm
 allow $1_t $2_xserver_t:shm r_shm_perms;
 allow $1_t $2_xserver_tmpfs_t:file r_file_perms;
 ')
@@ -38,10 +52,6 @@
 define(`x_client_domain',`
 # Derived domain based on the calling user domain and the program.
 type $1_$2_t, domain, nscd_client_domain $3;
-# Type for files that are writeable by this domain.
-type $1_$2_rw_t, file_type, $1_file_type, sysadmfile, tmpfile;
-# Type for files that are read-only for this domain
-type $1_$2_ro_t, file_type, $1_file_type, sysadmfile;
 
 ifelse(index(`$3', `transitionbool'), -1, `
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
@@ -81,24 +91,9 @@
 read_sysctl($1_$2_t)
 
 ifdef(`xauth.te',`
-allow $1_$2_t $1_home_xauth_t:file { getattr read };
+allow $1_$2_t $1_xauth_home_t:file { getattr read };
 ')
 
-# Allow the user domain to relabel to or create files with this type
-# to provide the domain with write access to particular files.
-allow $1_t $1_$2_rw_t:{ dir file lnk_file } { relabelfrom relabelto };
-# allow $1_t to create dirs and files in the rw type (the auto_trans rule above
-# does it for $1_$2_t)
-allow $1_t $1_$2_rw_t:dir create_dir_perms;
-allow $1_t $1_$2_rw_t:file create_file_perms;
-allow $1_t $1_$2_rw_t:lnk_file create_lnk_perms;
-
-r_dir_file($1_$2_t, $1_$2_ro_t)
-allow $1_$2_t $1_$2_ro_t:fifo_file { read write };
-create_dir_file($1_t, $1_$2_ro_t)
-allow $1_t $1_$2_ro_t:fifo_file create_file_perms;
-allow $1_t $1_$2_ro_t:{ dir file lnk_file } { relabelto relabelfrom };
-
 # Allow the user domain to send any signal to the $2 process.
 allow $1_t $1_$2_t:process signal_perms;
 
@@ -133,7 +128,6 @@
 
 # Read the home directory, e.g. for .Xauthority and to get to config files
 allow $1_$2_t home_root_t:dir { search getattr };
-file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_rw_t)
 
 # Use a separate type for tmpfs/shm pseudo files.
 tmpfs_domain($1_$2)
@@ -159,12 +153,9 @@
 ')
 
 ifdef(`startx.te', `
-# for /tmp/.X0-lock
-allow $1_$2_t $1_xserver_tmp_t:file getattr;
-
 xsession_domain($1_$2, $1)
-
 ')dnl end startx
+
 ')dnl end xserver
 
 ')dnl end x_client macro
diff -aru policy.old/macros/program/xserver_macros.te policy/macros/program/xserver_macros.te
--- policy.old/macros/program/xserver_macros.te	2005-02-28 11:57:31.000000000 -0500
+++ policy/macros/program/xserver_macros.te	2005-02-28 11:42:00.000000000 -0500
@@ -97,7 +97,7 @@
 }
 ifdef(`xauth.te', `
 domain_auto_trans($1_xserver_t, xauth_exec_t, $1_xauth_t)
-allow $1_xserver_t $1_home_xauth_t:file { getattr read };
+allow $1_xserver_t $1_xauth_home_t:file { getattr read };
 ', `
 allow $1_xserver_t $1_home_t:file { getattr read };
 ')dnl end ifdef xauth

--=-W/aMiCXIeNFA1Pz6zDFr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
