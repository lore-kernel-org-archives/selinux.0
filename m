Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j365bpDo015056
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 01:37:51 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j365WoCb012715
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 05:32:50 GMT
Subject: Re: [ PATCH ] X clients cleanup Patch #3
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112761124.12597.1.camel@cobra.ivg2.net>
References: <1112308113.17917.9.camel@cobra.ivg2.net>
	 <1112416291.7982.7.camel@cobra.ivg2.net> <424E8A49.2090408@redhat.com>
	 <200504022227.40688.russell@coker.com.au>
	 <1112456589.12762.6.camel@cobra.ivg2.net>  <425154AB.8080206@redhat.com>
	 <1112741764.24363.5.camel@cobra.ivg2.net>
	 <1112761124.12597.1.camel@cobra.ivg2.net>
Content-Type: multipart/mixed; boundary="=-VI7+kVUXa6J3iKYP6+0/"
Date: Wed, 06 Apr 2005 00:41:26 -0400
Message-Id: <1112762486.13109.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VI7+kVUXa6J3iKYP6+0/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Ok, there's one problem with it - the allow_write_xshm rules should say:
> rw_shm_perms and rw_file_perms and not write... 

... and yet another typo...unbelievable. Fixed version attached - please
apply. There should be no denials w/ that, and I finally get acceptable
graphical performance out of my card with SELinux enabled.

I will write another patch for the tmpfs issue..

Also, can you please add getattr permission to proc_t to $1_giftd_t -
right next to the read rule - addresses a denial I'm seeing. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-VI7+kVUXa6J3iKYP6+0/
Content-Disposition: attachment; filename=x_client_cleanup3_v2.diff
Content-Type: text/x-patch; name=x_client_cleanup3_v2.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aru policy.old/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-04-04 11:43:36.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-04-04 15:48:40.000000000 -0400
@@ -124,8 +124,6 @@
 # Use the type when relabeling pty devices.
 type_change $1_t server_pty:chr_file $1_devpts_t;
 
-tmpfs_domain($1)
-
 ifdef(`cardmgr.te', `
 # to allow monitoring of pcmcia status
 allow $1_t cardmgr_var_run_t:file { getattr read };
@@ -280,6 +278,9 @@
 #
 dontaudit $1_t usr_t:file setattr;
 
+# Use X
+x_client_domain($1, $1)
+
 ifdef(`xserver.te', `
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
@@ -289,13 +290,7 @@
 ifdef(`xdm.te', `
 # Connect to the X server run by the X Display Manager.
 can_unix_connect($1_t, xdm_t)
-allow $1_t xdm_tmp_t:sock_file rw_file_perms;
-allow $1_t xdm_tmp_t:dir r_dir_perms;
-allow $1_t xdm_tmp_t:file { getattr read };
-allow $1_t xdm_xserver_tmp_t:sock_file { read write };
-allow $1_t xdm_xserver_tmp_t:dir search;
-allow $1_t xdm_xserver_t:unix_stream_socket connectto;
-# certain apps want to read xdm.pid file
+# certain apps want to read xdm.pid file 
 r_dir_file($1_t, xdm_var_run_t)
 allow $1_t xdm_var_lib_t:file { getattr read };
 allow xdm_t $1_home_dir_t:dir getattr;
@@ -303,9 +298,6 @@
 file_type_auto_trans(xdm_t, $1_home_dir_t, $1_xauth_home_t, file)
 ')
 
-# for shared memory
-allow xdm_xserver_t $1_tmpfs_t:file { read write };
-
 ')dnl end ifdef xdm.te
 
 # Access the sound device.
diff -aru policy.old/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.old/macros/program/gift_macros.te	2005-04-01 22:55:49.000000000 -0500
+++ policy/macros/program/gift_macros.te	2005-04-01 23:09:54.000000000 -0500
@@ -18,7 +18,7 @@
 role $1_r types $1_gift_t;
 
 # X access, Home files 
-x_client_domain($1, gift)
+x_client_domain($1_gift, $1)
 home_domain($1, gift)
 
 uses_shlib($1_gift_t)
@@ -26,12 +26,15 @@
 read_sysctl($1_gift_t)
 access_terminal($1_gift_t, $1)
 
+# Allow the user domain to signal/ps.
+can_ps($1_t, $1_gift_t)
+allow $1_t $1_gift_t:process signal_perms;
+
 # Self permissions
 allow $1_gift_t self:process getsched;
 
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
-r_dir_file($1_gift_t, fonts_t)
 
 # Launch gift daemon
 allow $1_gift_t bin_t:dir search;
diff -aru policy.old/macros/program/java_macros.te policy/macros/program/java_macros.te
--- policy.old/macros/program/java_macros.te	2005-04-04 15:47:43.000000000 -0400
+++ policy/macros/program/java_macros.te	2005-04-04 15:47:19.000000000 -0400
@@ -32,7 +32,6 @@
 allow $1_javaplugin_t port_type:tcp_socket name_connect;
 can_ypbind($1_javaplugin_t)
 allow $1_javaplugin_t self:process { execmem fork signal_perms getsched setsched };
-allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow $1_javaplugin_t self:fifo_file rw_file_perms;
 allow $1_javaplugin_t etc_runtime_t:file { getattr read };
 allow $1_javaplugin_t fs_t:filesystem getattr;
@@ -56,36 +55,8 @@
 allow $1_javaplugin_t texrel_shlib_t:file execmod;
 }
 
-# Allow connections to X server.
-ifdef(`xserver.te', `
-
-ifdef(`xdm.te', `
-# for when /tmp/.X11-unix is created by the system
-allow $1_javaplugin_t xdm_xserver_tmp_t:dir search;
-allow $1_javaplugin_t xdm_t:fifo_file rw_file_perms;
-allow $1_javaplugin_t xdm_tmp_t:dir search;
-allow $1_javaplugin_t xdm_tmp_t:sock_file write;
-')
-
-ifdef(`startx.te', `
-# for when /tmp/.X11-unix is created by the X server
-allow $1_javaplugin_t $2_xserver_tmp_t:dir search;
-
-# for /tmp/.X0-lock
-allow $1_javaplugin_t $2_xserver_tmp_t:file getattr;
-
-allow $1_javaplugin_t $2_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_javaplugin_t, $2_xserver_t)
-')dnl end startx
-
-can_unix_connect($1_javaplugin_t, xdm_xserver_t)
-allow xdm_xserver_t $1_javaplugin_t:fd use;
-allow xdm_xserver_t $1_javaplugin_t:shm { associate getattr read unix_read };
-dontaudit xdm_xserver_t $1_javaplugin_t:shm { unix_write write };
-
-')dnl end xserver
-
-allow $1_javaplugin_t self:shm create_shm_perms;
+# Connect to X server
+x_client_domain($1_javaplugin, $2) 
 
 uses_shlib($1_javaplugin_t)
 read_locale($1_javaplugin_t)
@@ -119,4 +90,5 @@
 
 # Do not audit read/getattr of .fonts-cache-1
 dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
+
 ')
diff -aru policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-04-01 22:55:49.000000000 -0500
+++ policy/macros/program/mozilla_macros.te	2005-04-01 23:09:25.000000000 -0500
@@ -26,7 +26,7 @@
 
 # X access, Home files
 home_domain($1, mozilla)
-x_client_domain($1, mozilla)
+x_client_domain($1_mozilla, $1)
 
 # Browse files
 file_browse_domain($1_mozilla_t)
@@ -43,6 +43,10 @@
 allow $1_t $1_mozilla_t:process { noatsecure siginh rlimitinh };
 allow $1_mozilla_t $1_t:process signull;
 
+# Allow the user domain to signal/ps.
+can_ps($1_t, $1_mozilla_t)
+allow $1_t $1_mozilla_t:process signal_perms;
+
 # Fork, set resource limits and scheduling info.
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
diff -aru policy.old/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-03-31 17:39:39.000000000 -0500
+++ policy/macros/program/mplayer_macros.te	2005-04-01 23:09:12.000000000 -0500
@@ -15,6 +15,10 @@
 # Read global config
 r_dir_file($1_$2_t, mplayer_etc_t)
 
+# Allow the user domain to signal/ps.
+can_ps($1_t, $1_$2_t)
+allow $1_t $1_$2_t:process signal_perms;
+
 # Read data in /usr/share (fonts, icons..)
 r_dir_file($1_$2_t, usr_t)
 
@@ -72,7 +76,7 @@
 
 # Home access, X access, Browse files
 home_domain($1, mplayer)
-x_client_domain($1, mplayer)
+x_client_domain($1_mplayer, $1)
 file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
diff -aru policy.old/macros/program/ssh_macros.te policy/macros/program/ssh_macros.te
--- policy.old/macros/program/ssh_macros.te	2005-04-04 15:44:26.000000000 -0400
+++ policy/macros/program/ssh_macros.te	2005-04-04 15:44:02.000000000 -0400
@@ -129,18 +129,8 @@
 # allow ps to show ssh
 can_ps($1_t, $1_ssh_t)
 
-ifdef(`xserver.te', `
-# Communicate with the X server.
-ifdef(`startx.te', `
-can_unix_connect($1_ssh_t, $1_xserver_t)
-allow $1_ssh_t $1_xserver_tmp_t:sock_file rw_file_perms;
-allow $1_ssh_t $1_xserver_tmp_t:dir search;
-')dnl end if startx
-ifdef(`xdm.te', `
-allow $1_ssh_t { xdm_xserver_tmp_t xdm_tmp_t }:dir search;
-allow $1_ssh_t { xdm_tmp_t }:sock_file write;
-')
-')dnl end if xserver
+# Connect to X server
+x_client_domain($1_ssh, $1)
 
 ifdef(`ssh-agent.te', `
 ssh_agent_domain($1)
@@ -167,16 +157,6 @@
 allow $1_ssh_keysign_t self:file { getattr read };
 allow $1_ssh_keysign_t self:unix_stream_socket create_socket_perms;
 
-ifdef(`xdm.te', `
-# should be able to remove these two later
-allow $1_ssh_t xdm_xserver_tmp_t:sock_file { read write };
-allow $1_ssh_t xdm_xserver_tmp_t:dir search;
-allow $1_ssh_t xdm_xserver_t:unix_stream_socket connectto;
-allow $1_ssh_t xdm_xserver_t:shm r_shm_perms;
-allow $1_ssh_t xdm_xserver_t:fd use;
-allow $1_ssh_t xdm_xserver_tmpfs_t:file read;
-allow $1_ssh_t xdm_t:fd use;
-')dnl end if xdm.te
 ')dnl end macro definition
 ', `
 
diff -aru policy.old/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
--- policy.old/macros/program/tvtime_macros.te	2005-03-31 17:41:35.000000000 -0500
+++ policy/macros/program/tvtime_macros.te	2005-04-01 23:08:50.000000000 -0500
@@ -26,13 +26,17 @@
 
 # X access, Home files
 home_domain($1, tvtime)
-x_client_domain($1, tvtime)
+x_client_domain($1_tvtime, $1)
 
 uses_shlib($1_tvtime_t)
 read_locale($1_tvtime_t)
 read_sysctl($1_tvtime_t)
 access_terminal($1_tvtime_t, $1)
 
+# Allow the user domain to signal/ps.
+can_ps($1_t, $1_tvtime_t)
+allow $1_t $1_tvtime_t:process signal_perms;
+
 # Read /etc/tvtime
 allow $1_tvtime_t etc_t:file { getattr read };
 
diff -aru policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-03-31 16:30:34.000000000 -0500
+++ policy/macros/program/x_client_macros.te	2005-04-06 00:33:51.000000000 -0400
@@ -1,5 +1,5 @@
 #
-# Macros for X client programs ($2 etc)
+# Macros for X client programs 
 #
 
 #
@@ -8,6 +8,9 @@
 # and Timothy Fraser 
 #
 
+# Allows clients to write to the X server's shm 
+bool allow_write_xshm false;
+
 define(`xsession_domain', `
 
 # Connect to xserver
@@ -23,73 +26,73 @@
 # Signal Xserver
 allow $1_t $2_xserver_t:process signal;
 
-# Use file descriptors created by each other.
-allow $1_t $2_xserver_t:fd use;
+# Xserver read/write client shm
 allow $2_xserver_t $1_t:fd use;
-
-# Xserver read/write parent shm
 allow $2_xserver_t $1_t:shm rw_shm_perms;
 allow $2_xserver_t $1_tmpfs_t:file rw_file_perms;
 
-# Parent read xserver shm
+# Client read xserver shm
+allow $1_t $2_xserver_t:fd use;
 allow $1_t $2_xserver_t:shm r_shm_perms;
 allow $1_t $2_xserver_tmpfs_t:file r_file_perms;
+
+# Client write xserver shm
+if (allow_write_xshm) {
+allow $1_t $2_xserver_t:shm rw_shm_perms;
+allow $1_t $2_xserver_tmpfs_t:file rw_file_perms;
+}
+
 ')
 
 #
-# x_client_domain(user, app)
+# x_client_domain(client, role)
 #
-# Defines common X access rules for the user_app_t domain
+# Defines common X access rules for the client domain
 #
 define(`x_client_domain',`
 
-allow $1_$2_t self:unix_dgram_socket create_socket_perms;
-allow $1_$2_t self:unix_stream_socket { connectto create_stream_socket_perms };
+# Create socket to communicate with X server
+allow $1_t self:unix_dgram_socket create_socket_perms;
+allow $1_t self:unix_stream_socket { connectto create_stream_socket_perms };
 
+# Read .Xauthority file
 ifdef(`xauth.te',`
-allow $1_$2_t $1_xauth_home_t:file { getattr read };
+allow $1_t home_root_t:dir { search getattr };
+allow $1_t $2_xauth_home_t:file { getattr read };
 ')
 
-# Allow the user domain to send any signal to the $2 process.
-can_ps($1_t, $1_$2_t)
-allow $1_t $1_$2_t:process signal_perms;
-
 # for .xsession-errors
-dontaudit $1_$2_t $1_home_t:file write;
+dontaudit $1_t $2_home_t:file write;
 
 # for X over a ssh tunnel
 ifdef(`ssh.te', `
-can_tcp_connect($1_$2_t, sshd_t)
+can_tcp_connect($1_t, sshd_t)
 ')
 
-# Read the home directory, e.g. for .Xauthority and to get to config files
-allow $1_$2_t home_root_t:dir { search getattr };
-
 # Use a separate type for tmpfs/shm pseudo files.
-tmpfs_domain($1_$2)
-
-allow $1_$2_t self:shm create_shm_perms;
+tmpfs_domain($1)
+allow $1_t self:shm create_shm_perms;
 
 # allow X client to read all font files
-r_dir_file($1_$2_t, fonts_t)
+r_dir_file($1_t, fonts_t)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
-allow $1_$2_t tmp_t:dir search;
+allow $1_t tmp_t:dir search;
 
 ifdef(`xdm.te', `
-xsession_domain($1_$2, xdm)
+xsession_domain($1, xdm)
 
 # for when /tmp/.X11-unix is created by the system
-allow $1_$2_t xdm_t:fifo_file rw_file_perms;
-allow $1_$2_t xdm_tmp_t:dir search;
-allow $1_$2_t xdm_tmp_t:sock_file { read write };
-allow $1_$2_t xdm_t:fd use;
-dontaudit $1_$2_t xdm_t:tcp_socket { read write };
+allow $1_t xdm_t:fifo_file rw_file_perms;
+allow $1_t xdm_tmp_t:dir search;
+allow $1_t xdm_tmp_t:sock_file { read write };
+allow $1_t xdm_t:fd use;
+dontaudit $1_t xdm_t:tcp_socket { read write };
 ')
 
 ifdef(`startx.te', `
-xsession_domain($1_$2, $1)
+xsession_domain($1, $2)
 ')dnl end startx
 
 ')dnl end xserver

--=-VI7+kVUXa6J3iKYP6+0/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
