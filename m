Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1LXDs018339
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:21:36 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QH6EGK015077
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 17:07:29 GMT
Subject: [ PATCH ] home_domain macro / x_client cleanup patch
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-nKBxwbJMNZ60gtyaqzzt"
Date: Sat, 26 Feb 2005 12:09:04 -0500
Message-Id: <1109437744.4873.28.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-nKBxwbJMNZ60gtyaqzzt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch attempts to remove the rw_t, ro_t types from 
x_client_macro, which are the main reason why this macro's not
usable for more than the current three domains (games, mozilla,
mplayer). 

It does this by:
- erasing the rw_t, ro_t types from x_client
- adding a new macro called home_domain, that 
allows an application to have its own private domain in 
$1_home_dir_t. The domain can have both files and subdirectories
from all users. It is accessible from $1_t, which can create
files in it, relabel to/from.
- converting mplayer, mozilla, xauth, and tvtime to use
the new macro. 

Points of interest: 
- I don't think the tvtime home domain was actually used
anywhere before. The type just existed. Now it can
create home files/dirs.

- xauth can now make directories, which I thought
isn't bad enough to warrant not changing it

- All javaplugin changes are simply reorganizing the macro
to use different arguments. 

- All mozilla changes are reorganizing things. The only
significant change is that /tmp files are now created in
$1_mozilla_tmp_t, lpr can only print those, and only
those ones are executable. 

- Additional change: getattr /tmp/.X0-lock is now
allowed for all x_client domains.

Future plan:
- Change other HOME_DIR domains to use this macro
- Further change x_client_macro to the point where it's usable
by everything. For example, the javaplugin thing has about 50 lines or
so that are just duplicating stuff already in x_client_macros.

========
This applies on top of Daniel Walsh's latest policy
(which happens to include the read_sysctl patch I sent earlier - 
no sysctl denials yet that I see)


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-nKBxwbJMNZ60gtyaqzzt
Content-Disposition: attachment; filename=home_domain.diff
Content-Type: text/x-patch; name=home_domain.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/file_contexts/program/mozilla.fc policy/file_contexts/program/mozilla.fc
--- policy.old/file_contexts/program/mozilla.fc	2005-02-26 08:28:59.000000000 -0500
+++ policy/file_contexts/program/mozilla.fc	2005-02-26 08:30:23.000000000 -0500
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
+HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_home_mozilla_t
+HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_home_mozilla_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
diff -aur policy.old/file_contexts/program/mplayer.fc policy/file_contexts/program/mplayer.fc
--- policy.old/file_contexts/program/mplayer.fc	2005-02-26 08:36:20.000000000 -0500
+++ policy/file_contexts/program/mplayer.fc	2005-02-26 08:36:08.000000000 -0500
@@ -3,4 +3,4 @@
 /usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
 
 /etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
-HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
+HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_home_mplayer_t
diff -aur policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-02-26 08:47:21.000000000 -0500
+++ policy/macros/base_user_macros.te	2005-02-26 08:49:15.000000000 -0500
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
diff -aur policy.old/macros/global_macros.te policy/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-02-26 07:42:38.000000000 -0500
+++ policy/macros/global_macros.te	2005-02-26 09:17:15.000000000 -0500
@@ -474,6 +474,31 @@
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
+type $1_home_$2_t, file_type, $1_file_type, sysadmfile;
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
+file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_home_$2_t)
+create_dir_file($1_t, $1_home_$2_t)
+allow $1_t $1_home_$2_t:{ dir file lnk_file } { relabelfrom relabelto };
+')
+
 #######################
 # application_domain(domain_prefix)
 #
diff -aur policy.old/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.old/macros/program/games_domain.te	2005-02-26 06:35:24.000000000 -0500
+++ policy/macros/program/games_domain.te	2005-02-26 11:13:08.000000000 -0500
@@ -11,6 +11,9 @@
 #
 define(`games_domain', `
 x_client_domain($1, `games', `, transitionbool')
+
+allow $1_games_t $1_home_dir_t:dir search;
+
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
@@ -48,9 +51,6 @@
 # kpat spews errors
 dontaudit $1_games_t bin_t:dir getattr;
 dontaudit $1_games_t var_run_t:dir search;
-ifdef(`xdm.te', `
-dontaudit $1_games_t xdm_xserver_tmp_t:dir getattr;
-')
 
 ')dnl end macro definition
 
diff -aur policy.old/macros/program/java_macros.te policy/macros/program/java_macros.te
--- policy.old/macros/program/java_macros.te	2005-02-25 15:36:28.000000000 -0500
+++ policy/macros/program/java_macros.te	2005-02-26 09:14:31.000000000 -0500
@@ -1,4 +1,3 @@
-#
 # Authors:  Dan Walsh <dwalsh@redhat.com> 
 #
 #
@@ -27,7 +26,7 @@
 # Macros for javaplugin (java plugin) domains.
 #
 #
-# javaplugin_domain(domain_prefix, user)
+# javaplugin_domain(user_prefix, browser_prefix)
 #
 # Define a derived domain for the javaplugin program when executed by
 # a web browser.  
@@ -36,101 +35,101 @@
 # provided separately in domains/program/java.te. 
 #
 define(`javaplugin_domain',`
-type $1_javaplugin_t, domain, privlog , nscd_client_domain, transitionbool;
+type $1_$2_javaplugin_t, domain, privlog , nscd_client_domain, transitionbool;
 
 # The user role is authorized for this domain.
-role $2_r types $1_javaplugin_t;
-domain_auto_trans($1_t, java_exec_t, $1_javaplugin_t)
+role $1_r types $1_$2_javaplugin_t;
+domain_auto_trans($1_$2_t, java_exec_t, $1_$2_javaplugin_t)
 
-allow $1_javaplugin_t sound_device_t:chr_file rw_file_perms;
+allow $1_$2_javaplugin_t sound_device_t:chr_file rw_file_perms;
 # Unrestricted inheritance from the caller.
-allow $1_t $1_javaplugin_t:process { noatsecure siginh rlimitinh };
-allow $1_javaplugin_t $1_t:process signull;
+allow $1_$2_t $1_$2_javaplugin_t:process { noatsecure siginh rlimitinh };
+allow $1_$2_javaplugin_t $1_$2_t:process signull;
 
-can_unix_connect($1_javaplugin_t, $1_t)
-allow $1_javaplugin_t $1_t:unix_stream_socket { read write };
+can_unix_connect($1_$2_javaplugin_t, $1_$2_t)
+allow $1_$2_javaplugin_t $1_t:unix_stream_socket { read write };
 
 # This domain is granted permissions common to most domains (including can_net)
-can_network_client($1_javaplugin_t)
-can_ypbind($1_javaplugin_t)
-allow $1_javaplugin_t self:process { fork signal_perms getsched setsched };
-allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow $1_javaplugin_t self:fifo_file rw_file_perms;
-allow $1_javaplugin_t etc_runtime_t:file { getattr read };
-allow $1_javaplugin_t fs_t:filesystem getattr;
-r_dir_file($1_javaplugin_t, { proc_t proc_net_t })
-allow $1_javaplugin_t self:dir search;
-allow $1_javaplugin_t self:lnk_file read;
-allow $1_javaplugin_t self:file { getattr read };
+can_network_client($1_$2_javaplugin_t)
+can_ypbind($1_$2_javaplugin_t)
+allow $1_$2_javaplugin_t self:process { fork signal_perms getsched setsched };
+allow $1_$2_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow $1_$2_javaplugin_t self:fifo_file rw_file_perms;
+allow $1_$2_javaplugin_t etc_runtime_t:file { getattr read };
+allow $1_$2_javaplugin_t fs_t:filesystem getattr;
+r_dir_file($1_$2_javaplugin_t, { proc_t proc_net_t })
+allow $1_$2_javaplugin_t self:dir search;
+allow $1_$2_javaplugin_t self:lnk_file read;
+allow $1_$2_javaplugin_t self:file { getattr read };
 
-read_sysctl($1_javaplugin_t)
+read_sysctl($1_$2_javaplugin_t)
 
-tmp_domain($1_javaplugin)
-r_dir_file($1_javaplugin_t,{ fonts_t usr_t etc_t })
+tmp_domain($1_$2_javaplugin)
+r_dir_file($1_$2_javaplugin_t,{ fonts_t usr_t etc_t })
 
 # Search bin directory under javaplugin for javaplugin executable
-allow $1_javaplugin_t bin_t:dir search;
-can_exec($1_javaplugin_t, java_exec_t)
+allow $1_$2_javaplugin_t bin_t:dir search;
+can_exec($1_$2_javaplugin_t, java_exec_t)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
 
 ifdef(`xdm.te', `
 # for when /tmp/.X11-unix is created by the system
-allow $1_javaplugin_t xdm_xserver_tmp_t:dir search;
-allow $1_javaplugin_t xdm_t:fifo_file rw_file_perms;
-allow $1_javaplugin_t xdm_tmp_t:dir search;
-allow $1_javaplugin_t xdm_tmp_t:sock_file write;
+allow $1_$2_javaplugin_t xdm_xserver_tmp_t:dir search;
+allow $1_$2_javaplugin_t xdm_t:fifo_file rw_file_perms;
+allow $1_$2_javaplugin_t xdm_tmp_t:dir search;
+allow $1_$2_javaplugin_t xdm_tmp_t:sock_file write;
 ')
 
 ifdef(`startx.te', `
 # for when /tmp/.X11-unix is created by the X server
-allow $1_javaplugin_t $2_xserver_tmp_t:dir search;
+allow $1_$2_javaplugin_t $1_xserver_tmp_t:dir search;
 
 # for /tmp/.X0-lock
-allow $1_javaplugin_t $2_xserver_tmp_t:file getattr;
+allow $1_$2_javaplugin_t $1_xserver_tmp_t:file getattr;
 
-allow $1_javaplugin_t $2_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_javaplugin_t, $2_xserver_t)
+allow $1_$2_javaplugin_t $1_xserver_tmp_t:sock_file rw_file_perms;
+can_unix_connect($1_$2_javaplugin_t, $1_xserver_t)
 ')dnl end startx
 
-can_unix_connect($1_javaplugin_t, xdm_xserver_t)
-allow xdm_xserver_t $1_javaplugin_t:fd use;
-allow xdm_xserver_t $1_javaplugin_t:shm { associate getattr read unix_read };
-dontaudit xdm_xserver_t $1_javaplugin_t:shm { unix_write write };
+can_unix_connect($1_$2_javaplugin_t, xdm_xserver_t)
+allow xdm_xserver_t $1_$2_javaplugin_t:fd use;
+allow xdm_xserver_t $1_$2_javaplugin_t:shm { associate getattr read unix_read };
+dontaudit xdm_xserver_t $1_$2_javaplugin_t:shm { unix_write write };
 
 ')dnl end xserver
 
-allow $1_javaplugin_t self:shm create_shm_perms;
+allow $1_$2_javaplugin_t self:shm create_shm_perms;
 
-uses_shlib($1_javaplugin_t)
-read_locale($1_javaplugin_t)
-rw_dir_file($1_javaplugin_t, $1_rw_t)
+uses_shlib($1_$2_javaplugin_t)
+read_locale($1_$2_javaplugin_t)
+rw_dir_file($1_$2_javaplugin_t, $1_home_$2_t)
 
 if (allow_java_execstack) {
-legacy_domain($1_javaplugin)
-allow $1_javaplugin_t lib_t:file execute;
-allow $1_javaplugin_t locale_t:file execute;
-allow $1_javaplugin_t $1_javaplugin_tmp_t:file execute;
-allow $1_javaplugin_t fonts_t:file execute;
-allow $1_javaplugin_t sound_device_t:chr_file execute;
+legacy_domain($1_$2_javaplugin)
+allow $1_$2_javaplugin_t lib_t:file execute;
+allow $1_$2_javaplugin_t locale_t:file execute;
+allow $1_$2_javaplugin_t $1_$2_javaplugin_tmp_t:file execute;
+allow $1_$2_javaplugin_t fonts_t:file execute;
+allow $1_$2_javaplugin_t sound_device_t:chr_file execute;
 }
 
-allow $1_javaplugin_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
+allow $1_$2_javaplugin_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
 
-allow $1_javaplugin_t home_root_t:dir { getattr search };
-file_type_auto_trans($1_javaplugin_t, $2_home_dir_t, $1_rw_t)
-allow $1_javaplugin_t $2_home_xauth_t:file { getattr read };
-allow $1_javaplugin_t $2_tmp_t:sock_file write;
-allow $1_javaplugin_t $2_t:fd use;
-
-allow $1_javaplugin_t var_t:dir getattr;
-allow $1_javaplugin_t var_lib_t:dir { getattr search };
-
-dontaudit $1_javaplugin_t $2_devpts_t:chr_file { read write };
-dontaudit $1_javaplugin_t sysadm_devpts_t:chr_file { read write };
-dontaudit $1_javaplugin_t devtty_t:chr_file { read write };
-dontaudit $1_javaplugin_t tmpfs_t:file { execute read write };
-dontaudit $1_javaplugin_t $1_rw_t:file { execute setattr };
+allow $1_$2_javaplugin_t home_root_t:dir { getattr search };
+file_type_auto_trans($1_$2_javaplugin_t, $1_home_dir_t, $1_home_$2_t)
+allow $1_$2_javaplugin_t $1_home_xauth_t:file { getattr read };
+allow $1_$2_javaplugin_t $1_tmp_t:sock_file write;
+allow $1_$2_javaplugin_t $1_t:fd use;
+
+allow $1_$2_javaplugin_t var_t:dir getattr;
+allow $1_$2_javaplugin_t var_lib_t:dir { getattr search };
+
+dontaudit $1_$2_javaplugin_t $1_devpts_t:chr_file { read write };
+dontaudit $1_$2_javaplugin_t sysadm_devpts_t:chr_file { read write };
+dontaudit $1_$2_javaplugin_t devtty_t:chr_file { read write };
+dontaudit $1_$2_javaplugin_t tmpfs_t:file { execute read write };
+dontaudit $1_$2_javaplugin_t $1_home_$2_t:file { execute setattr };
 
 ')
diff -aur policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-02-26 07:50:08.000000000 -0500
+++ policy/macros/program/mozilla_macros.te	2005-02-26 11:56:28.000000000 -0500
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
+dontaudit $1_lpr_t $1_home_mozilla_t:file { read write };
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
+allow $1_mozilla_t $1_tmp_t:file { read write };
+allow $1_mozilla_t $1_tmp_t:sock_file write;
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
+file_type_auto_trans($1_mozilla_t, $1_home_t, $1_home_mozilla_t)
 allow $1_mozilla_t $1_home_t:dir setattr;
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
 } dnl end if writehome
@@ -110,18 +108,20 @@
 dontaudit $1_mozilla_t $1_home_t:file unlink;
 allow $1_mozilla_t self:sem create_sem_perms;
 
-#
-# Rules needed to run java apps
+# Java plugin
 ifdef(`java.te', `
-javaplugin_domain($1_mozilla, $1)
+javaplugin_domain($1, mozilla)
 ')
 
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
+dontaudit $1_mplayer_t $1_home_mozilla_t:file write;
 allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
diff -aur policy.old/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-02-26 07:45:30.000000000 -0500
+++ policy/macros/program/mplayer_macros.te	2005-02-26 08:49:57.000000000 -0500
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
diff -aur policy.old/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
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
diff -aur policy.old/macros/program/xauth_macros.te policy/macros/program/xauth_macros.te
--- policy.old/macros/program/xauth_macros.te	2005-02-26 08:28:08.000000000 -0500
+++ policy/macros/program/xauth_macros.te	2005-02-26 08:14:21.000000000 -0500
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
diff -aur policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-02-26 06:27:46.000000000 -0500
+++ policy/macros/program/x_client_macros.te	2005-02-26 07:45:05.000000000 -0500
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
@@ -84,21 +94,6 @@
 allow $1_$2_t $1_home_xauth_t:file { getattr read };
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

--=-nKBxwbJMNZ60gtyaqzzt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
