Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4RJgXI4011703
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 15:42:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4RJg5uO017261
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 19:42:05 GMT
Received: from unicorn.lemuria.org (c145061.adsl.hansenet.de [213.39.145.61])
	by jazzswing.ncsc.mil  with ESMTP id h4RJg0lV017245
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2003 19:42:03 GMT
Date: Tue, 27 May 2003 21:39:51 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Subject: updated patches
Message-ID: <20030527213950.A17585@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are the updated versions of my patches, a bit later than I had
hoped, sorry for that.

xdm.diff contains the updated xdm policy. I took what Russell posted
and modified it so that it works with my patched wdm.

games.diff is the updates games policy, using userdomain now.

misc.diff contains a few minor changes I made. Lilo wants to read the
locale files, there's my apm/acpid changes in there, and a minor touch
on fcron.


These policy changes run on my notebook in enforcing mode, and
everything looks happy so far.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xdm.diff"

diff -ur default/domains/program/xdm.te current/domains/program/xdm.te
--- default/domains/program/xdm.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/xdm.te	2003-05-27 21:31:18.000000000 +0200
@@ -1,6 +1,9 @@
 #DESC XDM - X Display Manager
 #
 # Authors:  Mark Westerman mark.westerman@westcam.com
+#           Russell Coker <russell@coker.com.au>
+#
+# Some wdm-specific changes by Tom Vogt <tom@lemuria.org>
 # 
 # Some alterations and documentation by Stephen Smalley <sds@epoch.ncsc.mil>
 #
@@ -11,19 +14,24 @@
 #
 # xdm_t is the domain of a X Display Manager process 
 # spawned by getty.
-# xdm_exec_t is the type of the [xgk]dm program
+# xdm_exec_t is the type of the [xgkw]dm program
 #
 daemon_domain(xdm, `, privuser, privrole, auth, privowner, privmem')
 
 # for running xdm from init
 domain_auto_trans(init_t, xdm_exec_t, xdm_t)
 
+# for xdmctl
+allow xdm_t xdm_var_run_t:fifo_file create_file_perms;
+
 tmp_domain(xdm)
 var_lib_domain(xdm)
-# NB we do NOT allow xdm_xserver_t xdm_var_lib_t:dir!!!
+# NB we do NOT allow xdm_xserver_t xdm_var_lib_t:dir, only access to an open
+# handle of a file inside the dir!!!
 allow xdm_xserver_t xdm_var_lib_t:file { getattr read };
 dontaudit xdm_xserver_t xdm_var_lib_t:dir search;
 type xsession_exec_t, file_type, sysadmfile, exec_type;
+type etc_xdm_t, file_type, sysadmfile;
 
 allow xdm_t default_context_t:file { read getattr };
 
@@ -35,13 +43,17 @@
 # for reboot
 allow xdm_t initctl_t:fifo_file write;
 
+# init script wants to check if it needs to update windowmanagerlist
+allow initrc_t etc_xdm_t:file { getattr read };
+
 #
 # Use capabilities.
 allow xdm_t self:capability { setgid setuid sys_resource kill };
 
 # Use /dev/mem.
-# Commented out by default.
+# Commented out by default. Needed if you can not use the framebuffer
 #allow xdm_t memory_device_t:chr_file { execute read write };
+allow xdm_xserver_t memory_device_t:chr_file { read write };
 
 allow xdm_t random_device_t:chr_file { getattr read };
 
@@ -70,8 +82,9 @@
 
 allow xdm_t xserver_var_log_t:file create_file_perms;
 
+allow xdm_t self:shm create_shm_perms;
 allow userdomain xdm_xserver_t:unix_stream_socket connectto;
-allow userdomain xdm_xserver_t:shm { read unix_read getattr associate };
+allow userdomain xdm_xserver_t:shm r_shm_perms;
 allow userdomain xdm_xserver_t:fd use;
 allow userdomain xdm_xserver_tmpfs_t:file read;
 allow xdm_xserver_t userdomain:shm { unix_read unix_write read write };
@@ -88,7 +101,7 @@
 allow xdm_t lastlog_t:file rw_file_perms;
 
 # Ask the security server for SIDs for user sessions.
-allow xdm_t security_t:security { get_user_sids context_to_sid };
+allow xdm_t security_t:security { get_user_sids context_to_sid sid_to_context };
 
 # Access the shared memory pseudo file system.
 # Should really define a derived type for this.
@@ -102,8 +115,8 @@
 allow xdm_t var_lock_t:file { create write unlink };
 
 # Connect to xfs.
-ifdef(`xfs.te',
-`allow xdm_t xfs_tmp_t:dir { search };
+ifdef(`xfs.te', `
+allow xdm_t xfs_tmp_t:dir { search };
 allow xdm_t xfs_tmp_t:sock_file { write };
 can_unix_connect(xdm_t, xfs_t)')
 
@@ -111,6 +124,11 @@
 allow xdm_t etc_t:lnk_file read;
 allow xdm_t etc_runtime_t:file { getattr read };
 
+# wdm has its own config dir /etc/X11/wdm
+file_type_auto_trans(xdm_t, etc_t, etc_xdm_t, file);
+allow xdm_t etc_xdm_t:dir r_dir_perms;
+allow xdm_t etc_xdm_t:file r_file_perms;
+
 # Signal any user domain.
 allow xdm_t userdomain:process signal_perms;
 
@@ -143,10 +161,16 @@
 dontaudit xdm_t sysadm_home_dir_t:dir { getattr search };
 
 # Do not audit user access to the X log files due to file handle inheritance
-dontaudit unpriv_userdomain xserver_var_log_t:file append;
+dontaudit unpriv_userdomain xserver_var_log_t:file { write append };
 
 # Access sound device.
 allow xdm_t sound_device_t:chr_file { setattr getattr };
 
+# Login necessities and dontaudits
+allow userdomain etc_xdm_t:dir { search };
+dontaudit userdomain initrc_t:fd { use };
+dontaudit userdomain xdm_var_lib_t:file { read write };
+
 # Run the X server in a derived domain.
 xserver_domain(xdm)
+
diff -ur default/domains/program/xserver.te current/domains/program/xserver.te
--- default/domains/program/xserver.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/xserver.te	2003-05-27 21:16:51.000000000 +0200
@@ -34,3 +34,9 @@
 # Everything else is in the xserver_domain macro in
 # macros/program/xserver_macros.te.
 
+ifdef(`xdm.te',`
+# XFree86-4 wants to check if kernel is tainted
+allow xdm_xserver_t sysctl_kernel_t:dir { search };
+allow xdm_xserver_t sysctl_kernel_t:file { getattr read };
+allow xdm_xserver_t sysctl_t:dir { search };
+')
diff -ur default/file_contexts/program/xdm.fc current/file_contexts/program/xdm.fc
--- default/file_contexts/program/xdm.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/program/xdm.fc	2003-05-27 21:14:02.000000000 +0200
@@ -1,11 +1,19 @@
 # X Display Manager
-/usr/bin/[xgk]dm                system_u:object_r:xdm_exec_t
+/usr/bin/[xgkw]dm               system_u:object_r:xdm_exec_t
+/usr/X11R6/bin/[xgkw]dm         system_u:object_r:xdm_exec_t
+/usr/X11R6/bin/wdmLogin         system_u:object_r:xdm_exec_t
 /usr/bin/gpe-dm                 system_u:object_r:xdm_exec_t
-/var/[xgk]dm(/.*)?              system_u:object_r:xserver_var_log_t
-/usr/var/[xgk]dm(/.*)?          system_u:object_r:xserver_var_log_t
-/var/log/kdm\.log		system_u:object_r:xserver_var_log_t
+/usr/sbin/update_wdm_wmlist     system_u:object_r:xdm_exec_t
+/var/[xgkw]dm(/.*)?             system_u:object_r:xserver_var_log_t
+/usr/var/[xgkw]dm(/.*)?         system_u:object_r:xserver_var_log_t
+/var/log/[xgkw]dm\.log		system_u:object_r:xserver_var_log_t
 /tmp/\.X11-unix(/.*)?		system_u:object_r:initrc_xserver_tmp_t
 /tmp/\.X0-lock			system_u:object_r:xdm_tmp_t
 /etc/X11/Xsession[^/]*	--	system_u:object_r:xsession_exec_t
+/etc/X11/wdm(/.*)?		system_u:object_r:etc_xdm_t
+/etc/X11/wdm/Xsetup(_0)?	system_u:object_r:xsession_exec_t
+/etc/X11/wdm/Xstartup(_0)?	system_u:object_r:xsession_exec_t
+/etc/X11/wdm/Xreset(_0)?	system_u:object_r:xsession_exec_t
+/etc/X11/wdm/Xsession		system_u:object_r:xsession_exec_t
 /var/run/xdmctl			system_u:object_r:xdm_var_run_t
 /var/lib/kdm(/.*)?		system_u:object_r:xdm_var_lib_t
diff -ur default/file_contexts/types.fc current/file_contexts/types.fc
--- default/file_contexts/types.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/types.fc	2003-05-24 12:46:13.000000000 +0200
@@ -229,7 +229,7 @@
 /usr/lib/gconv/.*\.so		system_u:object_r:shlib_t
 /usr/share/guile/g-wrapped/.*\.so system_u:object_r:shlib_t
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
-/usr/games(/.*)?		system_u:object_r:bin_t
+#/usr/games(/.*)?		system_u:object_r:bin_t
 
 #
 # /usr/.*glibc.*-linux/lib

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="games.diff"

diff -ur default/domains/program/games.te current/domains/program/games.te
--- default/domains/program/games.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/games.te	2003-05-27 21:07:18.000000000 +0200
@@ -2,6 +2,8 @@
 #
 # Author:  Russell Coker <russell@coker.com.au>
 #
+#	   Changes by Tom Vogt <tom@lemuria.org>
+#
 
 # type for shared data from games
 type games_data_t, file_type, sysadmfile;
@@ -14,3 +16,28 @@
 
 # Everything else is in the x_client_domain macro in
 # macros/program/x_client_macros.te.
+
+# games_t also used for games installed on the system, run by the user,
+# so holes in them won't compromise the user session
+allow userdomain games_data_t:file r_file_perms;
+allow userdomain games_data_t:dir r_dir_perms;
+
+# Game data stored in user home dirs
+type games_usrdata_t, file_type, sysadmfile;
+allow user_games_t user_home_t:dir { search };
+file_type_auto_trans(user_games_t, user_home_t, games_usrdata_t);
+#
+# Allow users to read and write these files
+# If we want to prevent cheating, we could take away the write
+# permissions. :)
+allow userdomain games_usrdata_t:file create_file_perms;
+allow userdomain games_usrdata_t:dir create_dir_perms;
+
+# Various access attempts to devices. Many games work just fine without,
+# but if yours does not, try to comment these out and look for which ones
+# it needs:
+dontaudit user_games_t device_t:chr_file { getattr };
+dontaudit user_games_t fixed_disk_device_t:blk_file { getattr };
+dontaudit user_games_t removable_device_t:blk_file { getattr };
+dontaudit user_games_t removable_device_t:lnk_file { read };
+
diff -ur default/file_contexts/program/games.fc current/file_contexts/program/games.fc
--- default/file_contexts/program/games.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/program/games.fc	2003-05-24 13:32:12.000000000 +0200
@@ -1,5 +1,15 @@
-#  netscape/mozilla
-/usr/games/.*		system_u:object_r:games_exec_t
+#  games installed on the system
+# Most games installed in /usr/local/games don't follow FHS conventions and
+# drop the binaries in with the data - therefore, you must relabel the
+# binaries to system_u:object_r:games_exec_t manually!
+/usr/games(/.*)?	system_u:object_r:games_data_t
+/usr/local/games(/.*)?	system_u:object_r:games_data_t
 /usr/lib/games/.* --	system_u:object_r:games_exec_t
 /var/games(/.*)?	system_u:object_r:games_data_t
 /usr/bin/micq		system_u:object_r:games_exec_t
+#
+# Some examples
+# Majesty (Fantasy RTS)
+/usr/local/games/majesty/majesty		system_u:object_r:games_exec_t
+/usr/local/games/majesty/majx			system_u:object_r:games_exec_t
+/usr/local/games/majesty/netmodules/libtcp_ip.so	system_u:object_r:games_exec_t
diff -ur default/file_contexts/types.fc current/file_contexts/types.fc
--- default/file_contexts/types.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/types.fc	2003-05-24 12:46:13.000000000 +0200
@@ -229,7 +229,7 @@
 /usr/lib/gconv/.*\.so		system_u:object_r:shlib_t
 /usr/share/guile/g-wrapped/.*\.so system_u:object_r:shlib_t
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
-/usr/games(/.*)?		system_u:object_r:bin_t
+#/usr/games(/.*)?		system_u:object_r:bin_t
 
 #
 # /usr/.*glibc.*-linux/lib

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc.diff"

diff -ur default/domains/program/apmd.te current/domains/program/apmd.te
--- default/domains/program/apmd.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/apmd.te	2003-05-24 11:44:40.000000000 +0200
@@ -34,6 +34,12 @@
 allow apmd_t { etc_runtime_t modules_conf_t }:file { getattr read };
 allow apmd_t etc_t:lnk_file read;
 
+# acpid wants a socket
+allow apmd_t var_run_t:sock_file create_file_perms;
+
+# acpid also has a logfile
+log_domain(apmd)
+
 # for id
 allow apmd_t security_t:security sid_to_context;
 
diff -ur default/domains/program/bootloader.te current/domains/program/bootloader.te
--- default/domains/program/bootloader.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/bootloader.te	2003-05-24 12:09:52.000000000 +0200
@@ -107,3 +107,9 @@
 
 allow bootloader_t policy_config_t:dir { search read };
 allow bootloader_t policy_config_t:file read;
+
+# Locals
+allow bootloader_t locale_t:dir { search };
+allow bootloader_t locale_t:file { read };
+allow bootloader_t locale_t:lnk_file { read };
+
diff -ur default/file_contexts/program/apmd.fc current/file_contexts/program/apmd.fc
--- default/file_contexts/program/apmd.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/program/apmd.fc	2003-05-24 11:38:46.000000000 +0200
@@ -1,4 +1,7 @@
 # apmd
 /usr/sbin/apmd			system_u:object_r:apmd_exec_t
+/usr/sbin/acpid			system_u:object_r:apmd_exec_t
 /usr/bin/apm			system_u:object_r:apm_exec_t
 /var/run/apmd\.pid		system_u:object_r:apmd_var_run_t
+/var/run/.acpid.socket		system_u:object_r:apmd_var_run_t
+
diff -ur default/file_contexts/program/crond.fc current/file_contexts/program/crond.fc
--- default/file_contexts/program/crond.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/program/crond.fc	2003-05-21 20:03:39.000000000 +0200
@@ -17,5 +17,6 @@
 /var/spool/fcron/.*		<<none>>
 /var/spool/fcron/systab.orig	system_u:object_r:sysadm_cron_spool_t
 /var/spool/fcron/systab		system_u:object_r:sysadm_cron_spool_t
+/var/spool/fcron/new.systab	system_u:object_r:sysadm_cron_spool_t
 /var/run/fcron\.fifo		system_u:object_r:crond_var_run_t
 /var/run/fcron\.pid		system_u:object_r:crond_var_run_t

--SUOF0GtieIMvvwua--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
