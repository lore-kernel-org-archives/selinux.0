Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1ng83016679
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:42 -0500
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1oF9c003285
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:50:15 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1oCfZ012534
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:50:12 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1oC3I265840
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:50:12 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1oBU4024301
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:50:11 -0500
Date: Thu, 14 Dec 2006 19:36:20 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150136.kBF1aKJq002724@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] labeled ipsec policy changes
Cc: cpebenito@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch allows networking programs to
sendto and recvfrom using ipsec associations.

Networking programs such as ping, have a socket
and SA with same type, ping_t, so only
require the sendto and recvfrom for itself.
So, I have added sendto and recvfrom for self
to the networking programs.

I have also added an interface to each networking
module such that a sysadm can specify which subjects
may recvfrom with SAs of the network module's type.

Signed-off-by; Joy Latten <latten@austin.ibm.com>

 calamaris.if   |   18 ++++++++++++++++++
 calamaris.te   |    1 +
 evolution.if   |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 games.if       |   19 +++++++++++++++++++
 gift.if        |   38 ++++++++++++++++++++++++++++++++++++++
 gpg.if         |   38 ++++++++++++++++++++++++++++++++++++++
 irc.if         |   19 +++++++++++++++++++
 java.if        |   19 +++++++++++++++++++
 mozilla.if     |   19 +++++++++++++++++++
 screen.if      |   19 +++++++++++++++++++
 thunderbird.if |   19 +++++++++++++++++++
 uml.if         |   19 +++++++++++++++++++
 vmware.if      |   18 ++++++++++++++++++
 vmware.te      |    1 +
 webalizer.if   |   18 ++++++++++++++++++
 webalizer.te   |    1 +
 yam.if         |   18 ++++++++++++++++++
 yam.te         |    1 +
 18 files changed, 342 insertions(+)
-----------------------------------------------------------------

diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/calamaris.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/calamaris.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/calamaris.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/calamaris.if	2006-12-14 11:40:21.000000000 -0600
@@ -19,3 +19,21 @@ interface(`calamaris_read_www_files',`
 	allow $1 calamaris_www_t:file r_file_perms;
 	allow $1 calamaris_www_t:lnk_file { getattr read };
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`calamaris_recv_labeledipsec',`
+	gen_require(`
+		type calamaris_t;
+	')
+	allow $1 calamaris_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/calamaris.te serefpolicy-2.4.6.patchbox2/policy/modules/apps/calamaris.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/calamaris.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/calamaris.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ allow calamaris_t self:fifo_file { getat
 allow calamaris_t self:unix_stream_socket create_stream_socket_perms;
 allow calamaris_t self:tcp_socket create_stream_socket_perms;
 allow calamaris_t self:udp_socket create_socket_perms;
+allow calamaris_t self:association { sendto recvfrom };
 
 allow calamaris_t calamaris_www_t:dir rw_dir_perms;
 allow calamaris_t calamaris_www_t:file manage_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/evolution.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/evolution.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/evolution.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/evolution.if	2006-12-14 11:40:21.000000000 -0600
@@ -109,6 +109,7 @@ template(`evolution_per_role_template',`
 	allow $1_evolution_t self:fifo_file rw_file_perms;
 	allow $1_evolution_t self:tcp_socket create_socket_perms;
 	allow $1_evolution_t self:udp_socket create_socket_perms;
+	allow $1_evolution_t self:association { sendto recvfrom };
 
 	allow $1_evolution_t $1_evolution_alarm_t:dir search_dir_perms;
 	allow $1_evolution_t $1_evolution_alarm_t:file read;
@@ -611,6 +612,7 @@ template(`evolution_per_role_template',`
 	# Talk to ldap (address book),
 	# Obtain weather data via http (read server name from xml file in /usr)
 	allow $1_evolution_server_t self:tcp_socket create_socket_perms;
+	allow $1_evolution_server_t self:association { sendto recvfrom };
 
 	allow $1_evolution_server_t $1_evolution_t:unix_stream_socket connectto;
 	allow $1_evolution_server_t $1_evolution_orbit_tmp_t:sock_file write;
@@ -696,6 +698,7 @@ template(`evolution_per_role_template',`
 	#
 
 	allow $1_evolution_webcal_t self:tcp_socket create_socket_perms;
+	allow $1_evolution_webcal_t self:association { sendto recvfrom };
 	
 	# X/evolution common stuff
 	allow $1_evolution_webcal_t $1_evolution_webcal_tmpfs_t:dir rw_dir_perms;
@@ -813,3 +816,57 @@ template(`evolution_stream_connect',`
 	allow $2 $1_evolution_t:unix_stream_socket connectto;
 	allow $2 $1_evolution_home_t:dir search;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`evolution_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_evolution_t;
+	')
+	allow $2 $1_evolution_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`evolution_recv_labeledipsec_server_role',`
+	gen_require(`
+		type $1_evolution_server_t;
+	')
+	allow $2 evolution_server_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`evolution_recv_labeledipsec_webcal_role',`
+	gen_require(`
+		type $1_evolution_webcal_t;
+	')
+	allow $2 $1_evolution_webcal_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/games.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/games.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/games.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/games.if	2006-12-14 11:40:21.000000000 -0600
@@ -61,6 +61,7 @@ template(`games_per_role_template',`
 	allow $1_games_t self:sem create_sem_perms;
 	allow $1_games_t self:tcp_socket create_stream_socket_perms;
 	allow $1_games_t self:udp_socket create_socket_perms;
+	allow $1_games_t self:association { sendto recvfrom };
 
 	allow $1_games_t $1_games_tmpfs_t:dir rw_dir_perms;
 	allow $1_games_t $1_games_tmpfs_t:file manage_file_perms;
@@ -168,3 +169,21 @@ template(`games_per_role_template',`
 		')
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`games_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_games_t;
+	')
+	allow $2 $1_games_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/gift.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/gift.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/gift.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/gift.if	2006-12-14 11:40:21.000000000 -0600
@@ -62,6 +62,7 @@ template(`gift_per_role_template',`
 	#
 
 	allow $1_gift_t self:tcp_socket create_socket_perms;
+	allow $1_gift_t self:association { sendto recvfrom };
 
 	allow $1_gift_t $1_gift_tmpfs_t:dir rw_dir_perms;
 	allow $1_gift_t $1_gift_tmpfs_t:file manage_file_perms;
@@ -149,6 +150,7 @@ template(`gift_per_role_template',`
 	allow $1_giftd_t self:unix_stream_socket create_socket_perms;
 	allow $1_giftd_t self:tcp_socket create_stream_socket_perms;
 	allow $1_giftd_t self:udp_socket create_socket_perms;
+	allow $1_giftd_t self:association { sendto recvfrom };
 
 	allow $1_giftd_t $1_gift_home_t:dir manage_dir_perms;
 	allow $1_giftd_t $1_gift_home_t:file manage_file_perms;
@@ -203,3 +205,39 @@ template(`gift_per_role_template',`
 		fs_manage_cifs_symlinks($1_giftd_t)
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gift_recv_labeledipsec_client_role',`
+	gen_require(`
+		type $1_gift_t;
+	')
+	allow $2 $1_gift_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gift_recv_labeledipsec_server_role',`
+	gen_require(`
+		type $1_giftd_t;
+	')
+	allow $2 $1_giftd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/gpg.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/gpg.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/gpg.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/gpg.if	2006-12-14 11:40:21.000000000 -0600
@@ -83,6 +83,7 @@ template(`gpg_per_role_template',`
 
 	allow $1_gpg_t self:fifo_file rw_file_perms;
 	allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
+	allow $1_gpg_t self:association { sendto recvfrom };
 
 	allow $1_gpg_t $1_gpg_secret_t:dir rw_dir_perms;
 	allow $1_gpg_t $1_gpg_secret_t:file create_file_perms;
@@ -166,6 +167,7 @@ template(`gpg_per_role_template',`
 
 	allow $1_gpg_helper_t self:tcp_socket { connect connected_socket_perms };
 	allow $1_gpg_helper_t self:udp_socket { connect connected_socket_perms };
+	allow $1_gpg_helper_t self:association { sendto recvfrom };
 
 	dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
 
@@ -402,3 +404,39 @@ template(`gpg_signal_user_gpg',`
 
 	allow $2 $1_gpg_t:process signal;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gpg_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_gpg_t;
+	')
+	allow $2 $1_gpg_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gpg_recv_labeledipsec_helper_role',`
+	gen_require(`
+		type $1_gpg_helper_t;
+	')
+	allow $2 $1_gpg_helper_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/irc.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/irc.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/irc.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/irc.if	2006-12-14 11:40:21.000000000 -0600
@@ -67,6 +67,7 @@ template(`irc_per_role_template',`
 	allow $1_irc_t self:unix_stream_socket create_stream_socket_perms;
 	allow $1_irc_t self:tcp_socket create_socket_perms;
 	allow $1_irc_t self:udp_socket create_socket_perms;
+	allow $1_irc_t self:association { sendto recvfrom };
 
 	allow $1_irc_t $1_irc_home_t:dir create_dir_perms;
 	allow $1_irc_t $1_irc_home_t:file create_file_perms;
@@ -157,3 +158,21 @@ template(`irc_per_role_template',`
 		nis_use_ypbind($1_irc_t)
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`irc_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_irc_t;
+	')
+	allow $2 $1_irc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/java.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/java.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/java.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/java.if	2006-12-14 11:40:21.000000000 -0600
@@ -62,6 +62,7 @@ template(`java_per_role_template',`
 	allow $1_javaplugin_t self:fifo_file rw_file_perms;
 	allow $1_javaplugin_t self:tcp_socket create_socket_perms;
 	allow $1_javaplugin_t self:udp_socket create_socket_perms;
+	allow $1_javaplugin_t self:association { sendto recvfrom };
 	
 	allow $1_javaplugin_t $2:unix_stream_socket connectto;
 	allow $1_javaplugin_t $2:unix_stream_socket { read write };
@@ -199,3 +200,21 @@ interface(`java_domtrans',`
 		refpolicywarn(`$0($1) has no effect in strict policy.')
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`java_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_javaplugin_t;
+	')
+	allow $2 $1_javaplugin_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/mozilla.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/mozilla.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/mozilla.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/mozilla.if	2006-12-14 11:40:21.000000000 -0600
@@ -67,6 +67,7 @@ template(`mozilla_per_role_template',`
 	# Browse the web, connect to printer
 	allow $1_mozilla_t self:tcp_socket create_socket_perms;
 	allow $1_mozilla_t self:netlink_route_socket r_netlink_socket_perms;
+	allow $1_mozilla_t self:association { sendto recvfrom };
 
 	# for bash - old mozilla binary
 	can_exec($1_mozilla_t, mozilla_exec_t)
@@ -410,3 +411,21 @@ template(`mozilla_per_role_template',`
 		')
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mozilla_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_mozilla_t;
+	')
+	allow $2 $1_mozilla_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/screen.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/screen.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/screen.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/screen.if	2006-12-14 11:40:21.000000000 -0600
@@ -70,6 +70,7 @@ template(`screen_per_role_template',`
 	allow $1_screen_t self:fd use;
 	allow $1_screen_t self:unix_stream_socket create_socket_perms;
 	allow $1_screen_t self:unix_dgram_socket create_socket_perms;
+	allow $1_screen_t self:association { sendto recvfrom };
 
 	allow $1_screen_t $1_screen_tmp_t:dir create_dir_perms;
 	allow $1_screen_t $1_screen_tmp_t:file create_file_perms;
@@ -198,3 +199,21 @@ template(`screen_per_role_template',`
 	')
 	') dnl TODO
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`screen_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_screen_t;
+	')
+	allow $2 $1_screen_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/thunderbird.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/thunderbird.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/thunderbird.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/thunderbird.if	2006-12-14 11:40:21.000000000 -0600
@@ -62,6 +62,7 @@ template(`thunderbird_per_role_template'
 	allow $1_thunderbird_t self:unix_stream_socket { create accept connect write getattr read listen bind };
 	allow $1_thunderbird_t self:tcp_socket create_socket_perms;
 	allow $1_thunderbird_t self:shm { read write create destroy unix_read unix_write };
+	allow $1_thunderbird_t self:association { sendto recvfrom };
 
 	# Access ~/.thunderbird
 	allow $1_thunderbird_t $1_thunderbird_home_t:dir manage_dir_perms;
@@ -347,3 +348,21 @@ template(`thunderbird_per_role_template'
 
 	')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`thunderbird_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_thunderbird_t;
+	')
+	allow $2 $1_thunderbird_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/uml.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/uml.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/uml.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/uml.if	2006-12-14 11:40:21.000000000 -0600
@@ -71,6 +71,7 @@ template(`uml_per_role_template',`
 	# Use the network.
 	allow $1_uml_t self:tcp_socket create_stream_socket_perms;
 	allow $1_uml_t self:udp_socket create_socket_perms;
+	allow $1_uml_t self:association { sendto recvfrom };
 
 	allow $1_uml_t $2:process sigchld;
 	allow $1_uml_t $2:fifo_file { ioctl read write getattr lock append };
@@ -249,3 +250,21 @@ interface(`uml_manage_util_files',`
 	allow $1 uml_switch_var_run_t:file create_file_perms;
 	allow $1 uml_switch_var_run_t:lnk_file create_lnk_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`uml_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_uml_t;
+	')
+	allow $2 $1_uml_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/vmware.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/vmware.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/vmware.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/vmware.if	2006-12-14 11:40:21.000000000 -0600
@@ -203,3 +203,21 @@ interface(`vmware_append_system_config',
 
 	allow $1 vmware_sys_conf_t:file append;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`vmware_recv_labeledipsec',`
+	gen_require(`
+		type vmware_host_t;
+	')
+	allow $1 vmware_host_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/vmware.te serefpolicy-2.4.6.patchbox2/policy/modules/apps/vmware.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/vmware.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/vmware.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ allow vmware_host_t self:process signal_
 allow vmware_host_t self:fifo_file rw_file_perms;
 allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
 allow vmware_host_t self:rawip_socket create_socket_perms;
+allow vmware_host_t self:association { sendto recvfrom };
 
 # cjp: the ro and rw files should be split up
 allow vmware_host_t vmware_sys_conf_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/webalizer.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/webalizer.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/webalizer.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/webalizer.if	2006-12-14 11:40:21.000000000 -0600
@@ -54,3 +54,21 @@ interface(`webalizer_run',`
 	role $2 types webalizer_t;
 	allow webalizer_t $3:chr_file rw_term_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`webalizer_recv_labeledipsec',`
+	gen_require(`
+		type webalizer_t;
+	')
+	allow $1 webalizer_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/webalizer.te serefpolicy-2.4.6.patchbox2/policy/modules/apps/webalizer.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/webalizer.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/webalizer.te	2006-12-14 11:40:21.000000000 -0600
@@ -46,6 +46,7 @@ allow webalizer_t self:unix_stream_socke
 allow webalizer_t self:tcp_socket connected_stream_socket_perms;
 allow webalizer_t self:udp_socket { connect connected_socket_perms };
 allow webalizer_t self:netlink_route_socket r_netlink_socket_perms;
+allow webalizer_t self:association { sendto recvfrom };
 
 allow webalizer_t webalizer_etc_t:file { getattr read };
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/yam.if serefpolicy-2.4.6.patchbox2/policy/modules/apps/yam.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/yam.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/yam.if	2006-12-14 11:40:21.000000000 -0600
@@ -75,3 +75,21 @@ interface(`yam_read_content',`
 	allow $1 yam_content_t:file read_file_perms;
 	allow $1 yam_content_t:lnk_file { getattr read };
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`yam_recv_labeledipsec',`
+	gen_require(`
+		type yam_t;
+	')
+	allow $1 yam_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/apps/yam.te serefpolicy-2.4.6.patchbox2/policy/modules/apps/yam.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/apps/yam.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/apps/yam.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow yam_t self:sem create_sem_perms;
 allow yam_t self:msgq create_msgq_perms;
 allow yam_t self:msg { send receive };
 allow yam_t self:tcp_socket create_socket_perms;
+allow yam_t self:association { sendto recvfrom };
 
 # Update the content being managed by yam.
 allow yam_t yam_content_t:dir create_dir_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
