Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36BwODo016619
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 07:58:24 -0400 (EDT)
Message-ID: <4253CD52.1090206@redhat.com>
Date: Wed, 06 Apr 2005 07:51:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: More patches
References: <200502032350.40924.russell@coker.com.au> <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060306050105050307090309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060306050105050307090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan has some more cleanup of x_client apps.
Also added execmod to httpd for php
Moved +r_dir_file(httpd_t, httpd_$1_content_t) outside boolean
so you should be able to serve pages with httpd with all booleans turned 
off.

You are missing NetworkManager from your latest pool, even though 
comment says it is there.

Dan

-- 



--------------060306050105050307090309
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.8/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/domains/program/unused/apache.te	2005-04-06 07:32:56.000000000 -0400
@@ -119,6 +119,12 @@
 allow httpd_t port_type:tcp_socket name_connect;
 }
 
+##########################################
+# Legacy: remove when it's fixed         #
+# Allow libphp5.so with text relocations #
+##########################################
+allow httpd_t texrel_shlib_t:file execmod;
+
 #########################################
 # Allow httpd to search users directories
 #########################################
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.8/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/domains/program/unused/hald.te	2005-04-06 07:31:54.000000000 -0400
@@ -31,7 +31,6 @@
 allow hald_t usr_t:file { getattr read };
 
 allow hald_t bin_t:file getattr;
-allow hald_t self:netlink_socket create_socket_perms;
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/NetworkManager.te policy-1.23.8/domains/program/unused/NetworkManager.te
--- nsapolicy/domains/program/unused/NetworkManager.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.8/domains/program/unused/NetworkManager.te	2005-04-06 07:31:54.000000000 -0400
@@ -0,0 +1,78 @@
+#DESC NetworkManager - 
+#
+# Authors: Dan Walsh <dwalsh@redhat.com>
+#
+#
+
+#################################
+#
+# Rules for the NetworkManager_t domain.
+#
+# NetworkManager_t is the domain for the NetworkManager daemon. 
+# NetworkManager_exec_t is the type of the NetworkManager executable.
+#
+daemon_domain(NetworkManager, `, nscd_client_domain' )
+
+can_network(NetworkManager_t)
+allow NetworkManager_t port_type:tcp_socket name_connect;
+allow NetworkManager_t dhcpc_port_t:udp_socket name_bind;
+allow NetworkManager_t dhcpc_t:process signal;
+
+can_ypbind(NetworkManager_t)
+uses_shlib(NetworkManager_t)
+allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service };
+
+allow NetworkManager_t { random_device_t urandom_device_t }:chr_file { getattr read };
+
+allow NetworkManager_t self:process { setcap getsched };
+allow NetworkManager_t self:fifo_file rw_file_perms;
+allow NetworkManager_t self:unix_dgram_socket create_socket_perms;
+allow NetworkManager_t self:file { getattr read };
+allow NetworkManager_t self:packet_socket create_socket_perms;
+allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;
+
+
+#
+# Communicate with Caching Name Server
+#
+allow NetworkManager_t named_zone_t:dir search;
+rw_dir_create_file(NetworkManager_t, named_cache_t)
+domain_auto_trans(NetworkManager_t, named_exec_t, named_t)
+allow named_t NetworkManager_t:udp_socket { read write };
+allow NetworkManager_t named_t:process signal;
+
+allow NetworkManager_t selinux_config_t:dir search;
+allow NetworkManager_t selinux_config_t:file { getattr read };
+
+ifdef(`dbusd.te', `
+dbusd_client(system, NetworkManager)
+allow NetworkManager_t system_dbusd_t:dbus { acquire_svc send_msg };
+allow NetworkManager_t hald_t:dbus send_msg;
+allow hald_t NetworkManager_t:dbus send_msg;
+')
+
+allow NetworkManager_t usr_t:file { getattr read };
+
+ifdef(`ifconfig.te', `
+domain_auto_trans(NetworkManager_t, ifconfig_exec_t, ifconfig_t)
+')dnl end if def ifconfig
+
+allow NetworkManager_t { sbin_t bin_t }:dir search;
+allow NetworkManager_t bin_t:lnk_file read;
+can_exec(NetworkManager_t, { ls_exec_t bin_t shell_exec_t })
+
+# in /etc created by NetworkManager will be labelled net_conf_t.
+file_type_auto_trans(NetworkManager_t, etc_t, net_conf_t, file)
+
+allow NetworkManager_t { etc_t etc_runtime_t }:file { getattr read };
+allow NetworkManager_t proc_t:file { getattr read };
+
+allow NetworkManager_t { domain -unrestricted }:dir search;
+allow NetworkManager_t { domain -unrestricted }:file { getattr read };
+dontaudit NetworkManager_t unrestricted:dir search;
+dontaudit NetworkManager_t unrestricted:file { getattr read };
+
+allow NetworkManager_t howl_t:process signal;
+allow NetworkManager_t initrc_var_run_t:file { getattr read };
+
+domain_auto_trans(NetworkManager_t, insmod_exec_t, insmod_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.8/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/file_contexts/distros.fc	2005-04-06 07:32:56.000000000 -0400
@@ -69,7 +69,7 @@
 # Some of them should be fixed and removed from this list
 
 # Fedora Core packages: gstreamer-plugins, compat-libstdc++, Glide3, libdv
-# 	HelixPlayer, SDL, xorg-x11, xorg-x11-libs, Hermes, valgrind, openoffice.org-libs
+# 	HelixPlayer, SDL, xorg-x11, xorg-x11-libs, Hermes, valgrind, openoffice.org-libs, httpd - php
 /usr/lib/gstreamer-.*/libgstffmpeg\.so.*  -- system_u:object_r:texrel_shlib_t
 /usr/lib/gstreamer-.*/libgsthermescolorspace\.so -- system_u:object_r:texrel_shlib_t
 /usr/lib/gstreamer-.*/libgstmms\.so 	 -- system_u:object_r:texrel_shlib_t
@@ -123,6 +123,8 @@
 /usr/lib/ladspa/se4_1883\.so			-- system_u:object_r:texrel_shlib_t
 /usr/lib/libImlib2\.so.* 			-- system_u:object_r:texrel_shlib_t
 /usr/lib/ocaml/stublibs/dllnums\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/httpd/modules/libphp5\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/php/modules/.*\.so			-- system_u:object_r:texrel_shlib_t
 
 # Livna.org packages: xmms-mp3, ffmpeg, xvidcore, xine-lib, gsm, lame
 /usr/lib/xmms/Input/libmpg123\.so		-- system_u:object_r:texrel_shlib_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/NetworkManager.fc policy-1.23.8/file_contexts/program/NetworkManager.fc
--- nsapolicy/file_contexts/program/NetworkManager.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.23.8/file_contexts/program/NetworkManager.fc	2005-04-06 07:31:54.000000000 -0400
@@ -0,0 +1,2 @@
+# NetworkManager 
+/usr/bin/NetworkManager	--	system_u:object_r:NetworkManager_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.23.8/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/base_user_macros.te	2005-04-06 07:32:06.000000000 -0400
@@ -282,6 +280,9 @@
 #
 dontaudit $1_t usr_t:file setattr;
 
+# Use X
+x_client_domain($1, $1)
+
 ifdef(`xserver.te', `
 # for /tmp/.ICE-unix
 file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
@@ -291,13 +292,7 @@
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
@@ -305,9 +300,6 @@
 file_type_auto_trans(xdm_t, $1_home_dir_t, $1_xauth_home_t, file)
 ')
 
-# for shared memory
-allow xdm_xserver_t $1_tmpfs_t:file { read write };
-
 ')dnl end ifdef xdm.te
 
 # Access the sound device.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.8/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/program/apache_macros.te	2005-04-06 07:31:54.000000000 -0400
@@ -136,8 +136,8 @@
 r_dir_file(httpd_t, httpd_$1_script_ro_t)
 create_dir_file(httpd_t, httpd_$1_script_rw_t)
 ra_dir_file(httpd_t, httpd_$1_script_ra_t)
-r_dir_file(httpd_t, httpd_$1_content_t)
 }
+r_dir_file(httpd_t, httpd_$1_content_t)
 
 ')
 define(`apache_user_domain', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.8/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/program/gift_macros.te	2005-04-06 07:32:06.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.23.8/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/program/java_macros.te	2005-04-06 07:37:13.000000000 -0400
@@ -32,7 +32,6 @@
 allow $1_javaplugin_t port_type:tcp_socket name_connect;
 can_ypbind($1_javaplugin_t)
 allow $1_javaplugin_t self:process { fork signal_perms getsched setsched };
-allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow $1_javaplugin_t self:fifo_file rw_file_perms;
 allow $1_javaplugin_t etc_runtime_t:file { getattr read };
 allow $1_javaplugin_t fs_t:filesystem getattr;
@@ -58,36 +57,9 @@
 if (allow_execmem) {
 allow $1_javaplugin_t self:process execmem;
 }
-# Allow connections to X server.
-ifdef(`xserver.te', `
 
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
@@ -121,4 +93,5 @@
 
 # Do not audit read/getattr of .fonts-cache-1
 dontaudit $1_javaplugin_t $1_home_t:file { read getattr };
+
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.8/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/program/mozilla_macros.te	2005-04-06 07:32:06.000000000 -0400
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.23.8/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.8/macros/program/mplayer_macros.te	2005-04-06 07:32:06.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.23.8/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2005-04-06 06:57:44.000000000 -0400
+++ policy-1.23.8/macros/program/ssh_agent_macros.te	2005-04-06 07:32:40.000000000 -0400
@@ -63,7 +63,7 @@
 allow $1_ssh_agent_t self:capability setgid;
 
 # access the random devices
-allow $1_ssh_agent_t { random_device_t urandom_device_t }:chr_file read;
+allow $1_ssh_agent_t { random_device_t urandom_device_t }:chr_file { getattr read };
 
 # for ssh-add
 can_unix_connect($1_t, $1_ssh_agent_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.23.8/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.8/macros/program/ssh_macros.te	2005-04-06 07:32:06.000000000 -0400
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.23.8/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.8/macros/program/tvtime_macros.te	2005-04-06 07:32:06.000000000 -0400
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.23.8/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-04-04 10:21:11.000000000 -0400
+++ policy-1.23.8/macros/program/x_client_macros.te	2005-04-06 07:32:06.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/httpd_selinux.8 policy-1.23.8/man/man8/httpd_selinux.8
--- nsapolicy/man/man8/httpd_selinux.8	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.8/man/man8/httpd_selinux.8	2005-04-06 07:31:54.000000000 -0400
@@ -75,6 +75,21 @@
 setsebool -P httpd_unified 0
 
 .TP
+httpd can be configured to turn off internal scripting (PHP).  PHP and other
+loadable modules run under the same context as httpd. Therefore several policy rules allow httpd greater access to the system then is needed if you only use external cgi scripts.
+.br
+
+setsebool -P httpd_builtin_scripting 0
+
+.TP
+httpd scripts by default are not allowed to connect out to the network.
+This would prevent a hacker from breaking into you httpd server and attacking 
+other machines.  If you need scripts to be able to connect you can set the httpd_can_network_connect boolean on.
+.br
+
+setsebool -P httpd_can_network_connect 1
+
+.TP
 You can disable SELinux protection for the httpd daemon by executing:
 .br
 
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/modutil.te policy-1.23.8/targeted/domains/program/modutil.te
--- nsapolicy/targeted/domains/program/modutil.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.8/targeted/domains/program/modutil.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#DESC Modutil - Dynamic module utilities
-#
-# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
-# X-Debian-Packages: modutils
-#
-
-#################################
-#
-# Rules for the module utility domains.
-#
-type modules_dep_t, file_type, sysadmfile;
-type modules_conf_t, file_type, sysadmfile;
-type modules_object_t, file_type, sysadmfile;
-type depmod_exec_t, file_type, exec_type, sysadmfile;
-type insmod_exec_t, file_type, exec_type, sysadmfile;
-type update_modules_exec_t, file_type, exec_type, sysadmfile;
-
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.8/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.8/tunables/distro.tun	2005-04-06 07:31:54.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.8/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.8/tunables/tunable.tun	2005-04-06 07:31:54.000000000 -0400
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------060306050105050307090309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
