Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S17XDo022255
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 20:07:33 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S148Tl000876
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 01:04:08 GMT
Subject: [ PATCH ] X clients cleanup patch #2
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-a62sDpoxgbr2ZBkrNq9p"
Date: Sun, 27 Mar 2005 20:12:19 -0500
Message-Id: <1111972339.1119.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-a62sDpoxgbr2ZBkrNq9p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This continues to remove stuff out of x_client_macros.
Again, the purpose of this is to decouple functionality
that does not always go together, and to transition from
a base-domain style macro (which we already have) to the bare
minimum required to communicate with X. The changelog is
rather large, but it's mostly because I'm trying to keep 
track of what's changed very closely. I've tested the five
x clients for damage.

Adds permissions
================
- Adds read/getattr to home_dir_t:dir for games to supress denial.
They already have search permission, so it seems acceptable.

- Add back can_exec(self) for mozilla, since it seems to be needed
for the old mozilla (not firefox)

- Add access_terminal to giftd

Restricts to individual x_clients (Minimum Priviledge)
======================================================
- Restricts networking from x_client to mozilla only, can_network only
- Restricts bin_t search from x_client to gift, which needs to launch
giftd
- Restricts bin_t exec ability from x_client to mozilla (needed for
mozilla bash script)
- Restricts ability to read/write fifo file in same domain to mozilla
and games
- Restricts ability to search proc_t from x_client to games
- Restricts ability to read self:lnk_file to mozilla 
- Restricts ability to search self:dir to mozilla 
- Restricts fork rules to mozilla, mplayer, games, gift (not tvtime)
- Restricts ability to read etc_runtime_t (/etc/mtab) to mozilla, games,
gift

Moves permission to each client (Unrelated to X connection):
======================================================
- uses_shlib in gift, mozilla, tvtime, and games
- read_locale in gift, mozilla, tvtime, and games
- read_sysctl in gift, mozilla, tvtime, and games
- access_terminal in gift, mozilla, tvtime, and games
(mplayer already has all of those permissions)
- ability to read etc_t split to all x clients, and documented
(mozilla,games,gift - nsswitch.conf, mplayer -alsa.conf, tvtime
- /etc/tvtime)

Removes (Not used by current x clients, Unrelated to X connection):
===================================
- Removes fs_t getattr permission from x_client
- Removes readable_t r_dir rule from x_client
- Removes rwx /dev/zero from x_client
- Removes exec rights to shell_exec_t from x_client
- Removes gnome-pty-helper rules from x_client
- Removes ability to read proc_t:lnk_file
- Removes ability to read etc_t:lnk_file

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-a62sDpoxgbr2ZBkrNq9p
Content-Disposition: attachment; filename=x_client_cleanup2_v0.diff
Content-Type: text/x-patch; name=x_client_cleanup2_v0.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.old/macros/program/games_domain.te	2005-03-27 18:25:21.000000000 -0500
+++ policy/macros/program/games_domain.te	2005-03-27 19:35:51.000000000 -0500
@@ -19,10 +19,18 @@
 }
 role $1_r types $1_games_t;
 
-# X access, Private tmp
+# X access, /tmp files
 x_client_domain($1, games)
 tmp_domain($1_games)
 
+uses_shlib($1_games_t)
+read_locale($1_games_t)
+read_sysctl($1_games_t)
+access_terminal($1_games_t, $1)
+
+# Fork
+allow $1_games_t self:process { fork signal_perms getsched };
+
 # Games seem to need this
 if (allow_execmem) {
 allow $1_games_t self:process execmem;
@@ -37,7 +45,7 @@
 
 # Access /home/user/.gnome2
 create_dir_file($1_games_t, $1_home_t)
-allow $1_games_t $1_home_dir_t:dir search;
+allow $1_games_t $1_home_dir_t:dir { read getattr search };
 allow $1_games_t $1_home_t:dir { read getattr };
 
 create_dir_file($1_games_t, $1_tmp_t)
@@ -57,6 +65,7 @@
 
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
+allow $1_games_t proc_t:dir search;
 allow $1_games_t proc_t:file { read getattr };
 ifdef(`mozilla.te', ` 
 dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
@@ -64,10 +73,17 @@
 allow $1_games_t event_device_t:chr_file getattr;
 allow $1_games_t mouse_device_t:chr_file getattr;
 allow $1_games_t self:file { getattr read };
+allow $1_games_t self:fifo_file rw_file_perms;
 
 # kpat spews errors
 dontaudit $1_games_t bin_t:dir getattr;
 dontaudit $1_games_t var_run_t:dir search;
 
+# Allow games to read /etc/mtab and /etc/nsswitch.conf
+allow $1_games_t etc_t:file { getattr read };
+allow $1_games_t etc_runtime_t:file { getattr read };
+
+# 
+
 ')dnl end macro definition
 
diff -aur policy.old/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.old/macros/program/gift_macros.te	2005-03-27 18:07:34.000000000 -0500
+++ policy/macros/program/gift_macros.te	2005-03-27 20:00:35.000000000 -0500
@@ -17,10 +17,15 @@
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
 role $1_r types $1_gift_t;
 
-# X access, Home access
+# X access, Home files 
 x_client_domain($1, gift)
 home_domain($1, gift)
 
+uses_shlib($1_gift_t)
+read_locale($1_gift_t)
+read_sysctl($1_gift_t)
+access_terminal($1_gift_t, $1)
+
 # Self permissions
 allow $1_gift_t self:process getsched;
 
@@ -29,7 +34,8 @@
 r_dir_file($1_gift_t, fonts_t)
 
 # Launch gift daemon
-allow $1_gift_t self:process fork;
+allow $1_gift_t bin_t:dir search;
+allow $1_gift_t self:process { fork signal_perms getsched };
 domain_auto_trans($1_gift_t, giftd_exec_t, $1_giftd_t)
 
 # Connect to gift daemon
@@ -40,6 +46,10 @@
 allow $1_gift_t proc_t:dir search;
 allow $1_gift_t proc_t:file { getattr read };
 
+# Read /etc/mtab, /etc/nsswitch.conf
+allow $1_gift_t etc_t:file { getattr read };
+allow $1_gift_t etc_runtime_t:file { getattr read };
+
 # Tmp/ORBit
 tmp_domain($1_gift)
 file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
@@ -78,6 +88,7 @@
 read_sysctl($1_giftd_t)
 read_locale($1_giftd_t)
 uses_shlib($1_giftd_t)
+access_terminal($1_giftd_t, $1)
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
diff -aur policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-03-27 17:37:58.000000000 -0500
+++ policy/macros/program/mozilla_macros.te	2005-03-27 19:35:44.000000000 -0500
@@ -24,33 +24,52 @@
 }
 role $1_r types $1_mozilla_t;
 
+# X access, Home files
 home_domain($1, mozilla)
 x_client_domain($1, mozilla)
+
+# Browse files
 file_browse_domain($1_mozilla_t)
 
+can_network($1_mozilla_t)
+uses_shlib($1_mozilla_t)
+read_locale($1_mozilla_t)
+read_sysctl($1_mozilla_t)
+access_terminal($1_mozilla_t, $1)
+
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
 # Unrestricted inheritance from the caller.
 allow $1_t $1_mozilla_t:process { noatsecure siginh rlimitinh };
 allow $1_mozilla_t $1_t:process signull;
 
-# Set resource limits and scheduling info.
-allow $1_mozilla_t self:process { setrlimit setsched };
+# Fork, set resource limits and scheduling info.
+allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
+allow $1_mozilla_t self:fifo_file rw_file_perms;
 
-# for bash
+# for bash - old mozilla binary
+can_exec($1_mozilla_t, mozilla_exec_t)
+can_exec($1_mozilla_t, bin_t)
+allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t devpts_t:dir r_dir_perms;
 allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+allow $1_mozilla_t self:dir search;
+allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
 
 allow $1_mozilla_t { var_t var_lib_t }:dir search;
 
+# Allow mozilla to read /etc/mtab, /etc/nsswitch.conf
+allow $1_mozilla_t etc_t:file { getattr read };
+allow $1_mozilla_t etc_runtime_t:file { getattr read };
+
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
diff -aur policy.old/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
--- policy.old/macros/program/tvtime_macros.te	2005-03-27 18:24:11.000000000 -0500
+++ policy/macros/program/tvtime_macros.te	2005-03-27 19:42:09.000000000 -0500
@@ -24,11 +24,21 @@
 domain_auto_trans($1_t, tvtime_exec_t, $1_tvtime_t)
 role $1_r types $1_tvtime_t;
 
-# Home access, X access
+# X access, Home files
 home_domain($1, tvtime)
-tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
 x_client_domain($1, tvtime)
 
+uses_shlib($1_tvtime_t)
+read_locale($1_tvtime_t)
+read_sysctl($1_tvtime_t)
+access_terminal($1_tvtime_t, $1)
+
+# Read /etc/tvtime
+allow $1_tvtime_t etc_t:file { getattr read };
+
+# Tmp files
+tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
+
 allow $1_tvtime_t urandom_device_t:chr_file read;
 allow $1_tvtime_t clock_device_t:chr_file { ioctl read };
 allow $1_tvtime_t kernel_t:system ipc_info;
diff -aur policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-03-27 17:35:18.000000000 -0500
+++ policy/macros/program/x_client_macros.te	2005-03-27 19:56:01.000000000 -0500
@@ -43,54 +43,17 @@
 #
 define(`x_client_domain',`
 
-# This domain is granted permissions common to most domains (including can_net)
-can_network($1_$2_t)
-allow $1_$2_t port_type:tcp_socket name_connect;
-can_ypbind($1_$2_t)
-allow $1_$2_t self:process { fork signal_perms getsched };
 allow $1_$2_t self:unix_dgram_socket create_socket_perms;
 allow $1_$2_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow $1_$2_t self:fifo_file rw_file_perms;
-allow $1_$2_t etc_runtime_t:file { getattr read };
-allow $1_$2_t etc_t:lnk_file read;
-allow $1_$2_t fs_t:filesystem getattr;
-access_terminal($1_$2_t, $1)
-read_locale($1_$2_t)
-r_dir_file($1_$2_t, readable_t)
-allow $1_$2_t proc_t:dir search;
-allow $1_$2_t proc_t:lnk_file read;
-allow $1_$2_t self:dir search;
-allow $1_$2_t self:lnk_file read;
-read_sysctl($1_$2_t)
 
 ifdef(`xauth.te',`
 allow $1_$2_t $1_xauth_home_t:file { getattr read };
 ')
 
 # Allow the user domain to send any signal to the $2 process.
+can_ps($1_t, $1_$2_t)
 allow $1_t $1_$2_t:process signal_perms;
 
-# Allow the user domain to read the /proc/PID directory for 
-# the $2 process.
-allow $1_t $1_$2_t:dir r_dir_perms;
-allow $1_t $1_$2_t:notdevfile_class_set r_file_perms;
-
-# Allow use of /dev/zero by ld.so.
-allow $1_$2_t device_t:dir search;
-allow $1_$2_t zero_device_t:chr_file rw_file_perms;
-allow $1_$2_t zero_device_t:chr_file x_file_perms;
-
-# allow using shared libraries and running programs
-uses_shlib($1_$2_t)
-allow $1_$2_t { bin_t sbin_t }:dir search;
-allow $1_$2_t bin_t:lnk_file read;
-can_exec($1_$2_t, { shell_exec_t bin_t })
-allow $1_$2_t etc_t:file { getattr read };
-
-# Inherit and use descriptors from gnome-pty-helper.
-ifdef(`gnome-pty-helper.te', `allow $1_$2_t $1_gph_t:fd use;')
-allow $1_$2_t privfd:fd use;
-
 # for .xsession-errors
 dontaudit $1_$2_t $1_home_t:file write;
 

--=-a62sDpoxgbr2ZBkrNq9p--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
