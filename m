Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4OGA8I4001392
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 12:10:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4OGA7tV018273
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 16:10:07 GMT
Received: from unicorn.lemuria.org (c145229.adsl.hansenet.de [213.39.145.229])
        by jazzband.ncsc.mil  with ESMTP id h4OGA5al018270 for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 16:10:06 GMT
Date: Sat, 24 May 2003 18:07:38 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: some policy patches
Message-ID: <20030524180730.C8251@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have attached three diff files for policy changes. These are against
Russell's default policy, though from the file comments at least one
(xdm) is unchanged from the upstream tree.

xdm.diff contains updates to the xdm, xserver and xfs domains. Together
with my patched wdm I can boot into a graphical login and work in X,
all in enforcing mode. Accomplishing this made me very happy. :)

apm.diff contains minor updates so that acpid works (they are very
similiar in requirements, and you don't usually have both running
anyway, so a shared domain for apmd and acpid should be ok).

games.diff enables what I believe to be better games support. I have a
notebook with SELinux now and during long train trips I might want to
get some entertainment. The major change is that I have added support
for the data games want to store in the user's home directory and
updated the file context definitions (I don't want Quake3, which has
known remote holes, to be able to write to the users home dir any more
than absolutely necessary).
Using this policy, I can play Majesty in enforcing mode. I've also
tried Uplink, but it's ugly, ugly (patches itself while running. No,
I'm not joking).

Anyway - here they are. Comments welcome. If you merge them, please
drop me a short note so I can update my webpage.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xdm.diff"

diff -ru default/domains/program/xdm.te current/domains/program/xdm.te
--- default/domains/program/xdm.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/xdm.te	2003-05-24 13:08:34.000000000 +0200
@@ -3,7 +3,7 @@
 # Authors:  Mark Westerman mark.westerman@westcam.com
 # 
 # Some alterations and documentation by Stephen Smalley <sds@epoch.ncsc.mil>
-#
+# Some wdm-specific changes by Tom Vogt <tom@lemuria.org>
 
 #################################
 # 
@@ -11,19 +11,29 @@
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
-allow xdm_xserver_t xdm_var_lib_t:file { getattr read };
+# NB we do NOT allow xdm_xserver_t xdm_var_lib_t:dir, only access to an open
+# handle of a file inside the dir!!!
+# Added write access, not sure if it is required (Tom)
+allow xdm_xserver_t xdm_var_lib_t:file { getattr read write };
 dontaudit xdm_xserver_t xdm_var_lib_t:dir search;
 type xsession_exec_t, file_type, sysadmfile, exec_type;
+type etc_xdm_t, file_type, sysadmfile;
+
+# xdm_xserver_t needs to inherit the init file descriptors
+allow xdm_xserver_t initrc_t:fd { use };
+allow xdm_xserver_t initrc_t:fifo_file { read write };
 
 allow xdm_t default_context_t:file { read getattr };
 
@@ -35,13 +45,23 @@
 # for reboot
 allow xdm_t initctl_t:fifo_file write;
 
+# init script wants to check if it needs to update windowmanagerlist
+allow initrc_t etc_xdm_t:file { read };
+
 #
 # Use capabilities.
-allow xdm_t self:capability { setgid setuid sys_resource kill };
+allow xdm_t self:capability { setgid setuid sys_resource kill sys_rawio };
+
+# Use shared memory (with itself)
+allow xdm_t xdm_t:shm { create destroy read unix_read unix_write write };
 
 # Use /dev/mem.
 # Commented out by default.
 #allow xdm_t memory_device_t:chr_file { execute read write };
+# wdm just asks for read access
+allow xdm_t memory_device_t:chr_file { read };
+# but xdm_xserver wants to write, too
+allow xdm_xserver_t memory_device_t:chr_file { read write };
 
 allow xdm_t random_device_t:chr_file { getattr read };
 
@@ -67,7 +87,6 @@
 
 # Access xdm log files.
 file_type_auto_trans(xdm_t, var_log_t, xserver_var_log_t)
-
 allow xdm_t xserver_var_log_t:file create_file_perms;
 
 allow userdomain xdm_xserver_t:unix_stream_socket connectto;
@@ -88,7 +107,7 @@
 allow xdm_t lastlog_t:file rw_file_perms;
 
 # Ask the security server for SIDs for user sessions.
-allow xdm_t security_t:security { get_user_sids context_to_sid };
+allow xdm_t security_t:security { get_user_sids context_to_sid sid_to_context };
 
 # Access the shared memory pseudo file system.
 # Should really define a derived type for this.
@@ -111,6 +130,11 @@
 allow xdm_t etc_t:lnk_file read;
 allow xdm_t etc_runtime_t:file { getattr read };
 
+# wdm has its own config dir /etc/X11/wdm
+file_type_auto_trans(xdm_t, etc_t, etc_xdm_t);
+allow xdm_t etc_xdm_t:file create_file_perms;
+allow xdm_t etc_xdm_t:dir rw_file_perms;
+
 # Signal any user domain.
 allow xdm_t userdomain:process signal_perms;
 
@@ -143,10 +167,23 @@
 dontaudit xdm_t sysadm_home_dir_t:dir { getattr search };
 
 # Do not audit user access to the X log files due to file handle inheritance
-dontaudit unpriv_userdomain xserver_var_log_t:file append;
+dontaudit unpriv_userdomain xserver_var_log_t:file { write append };
+
 
 # Access sound device.
 allow xdm_t sound_device_t:chr_file { setattr getattr };
 
 # Run the X server in a derived domain.
 xserver_domain(xdm)
+
+
+#
+# When the user session comes up, it checks the wdm config dir
+# and the authfiles in /var/lib/wdm/authdir/authfiles/
+allow user_t etc_xdm_t:dir { search };
+allow user_t xdm_exec_t:file { entrypoint };
+allow user_t xdm_var_lib_t:file { read write };
+
+# Also, it inherits an fd
+allow xdm_xserver_t user_t:fd { use };
+
diff -ru default/domains/program/xfs.te current/domains/program/xfs.te
--- default/domains/program/xfs.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/xfs.te	2003-05-24 10:46:46.000000000 +0200
@@ -13,7 +13,15 @@
 #
 daemon_domain(xfs)
 
-tmp_domain(xfs)
+# tmp_domain(xfs)
+# for /tmp/.font-unix/fs7100
+type xfs_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans(xfs_t, initrc_tmp_t, xfs_tmp_t, sock_file)
+
+allow xfs_t { etc_t etc_runtime_t }:file { getattr read };
+allow xfs_t proc_t:file { getattr read };
+
+allow xfs_t self:process setpgid;
 
 # Use capabilities.
 allow xfs_t xfs_t:capability { setgid setuid };
@@ -21,3 +29,5 @@
 # Bind to /tmp/.font-unix/fs-1.
 allow xfs_t xfs_tmp_t:unix_stream_socket name_bind;
 
+allow xfs_t tmp_t:dir { search };
+
diff -ru default/domains/program/xserver.te current/domains/program/xserver.te
--- default/domains/program/xserver.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/xserver.te	2003-05-24 11:04:36.000000000 +0200
@@ -34,3 +34,7 @@
 # Everything else is in the xserver_domain macro in
 # macros/program/xserver_macros.te.
 
+# XFree86-4 wants to check if kernel is tainted
+allow xdm_xserver_t sysctl_kernel_t:dir { search };
+allow xdm_xserver_t sysctl_kernel_t:file { getattr read };
+allow xdm_xserver_t sysctl_t:dir { search };
diff -ru default/file_contexts/program/xdm.fc current/file_contexts/program/xdm.fc
--- default/file_contexts/program/xdm.fc	2003-05-15 05:22:15.000000000 +0200
+++ current/file_contexts/program/xdm.fc	2003-05-24 11:32:37.000000000 +0200
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
+/etc/X11/wdm/Xsetup(_0)?	system_u:object_r:xdm_exec_t
+/etc/X11/wdm/Xstartup(_0)?	system_u:object_r:xdm_exec_t
+/etc/X11/wdm/Xreset(_0)?	system_u:object_r:xdm_exec_t
+/etc/X11/wdm/Xsession		system_u:object_r:xdm_exec_t
 /var/run/xdmctl			system_u:object_r:xdm_var_run_t
 /var/lib/kdm(/.*)?		system_u:object_r:xdm_var_lib_t

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="apm.diff"

diff -ru default/domains/program/apmd.te current/domains/program/apmd.te
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
 
diff -ru default/file_contexts/program/apmd.fc current/file_contexts/program/apmd.fc
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

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="games.diff"

diff -ru default/domains/program/games.te current/domains/program/games.te
--- default/domains/program/games.te	2003-05-15 05:22:15.000000000 +0200
+++ current/domains/program/games.te	2003-05-24 13:32:04.000000000 +0200
@@ -2,6 +2,8 @@
 #
 # Author:  Russell Coker <russell@coker.com.au>
 #
+#          Changes by Tom Vogt <tom@lemuria.org>
+#
 
 # type for shared data from games
 type games_data_t, file_type, sysadmfile;
@@ -14,3 +16,28 @@
 
 # Everything else is in the x_client_domain macro in
 # macros/program/x_client_macros.te.
+
+# games_t also used for games installed on the system, run by the user,
+# so holes in them won't compromise the user session
+allow user_t games_data_t:file r_file_perms;
+allow user_t games_data_t:dir r_dir_perms;
+
+# Game data stored in user home dirs
+type games_usrdata_t, file_type, sysadmfile;
+allow user_games_t user_home_t:dir { search };
+file_type_auto_trans(user_games_t, user_home_t, games_usrdata_t);
+#
+# Allow users to read and write these files
+# If we want to prevent cheating, we could take away the write
+# permissions. :)
+allow user_t games_usrdata_t:file create_file_perms;
+allow user_t games_usrdata_t:dir create_dir_perms;
+
+# Various access attempts to devices. Many games work just fine without,
+# but if yours doesn't, try to comment these out and look for which ones
+# it needs:
+dontaudit user_games_t device_t:chr_file { getattr };
+dontaudit user_games_t fixed_disk_device_t:blk_file { getattr };
+dontaudit user_games_t removable_device_t:blk_file { getattr };
+dontaudit user_games_t removable_device_t:lnk_file { read };
+
diff -ru default/file_contexts/program/games.fc current/file_contexts/program/games.fc
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
diff -ru default/file_contexts/types.fc current/file_contexts/types.fc
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

--OXfL5xGRrasGEqWY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
