Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09Nj8Oh028303
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:45:08 -0500
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09NjuUL008696
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 23:45:57 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l09NjuB1017300
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:45:56 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l09NjuY1538110
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:45:56 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l09NjuGw017042
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:45:56 -0700
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l09NjuQ9017015
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:45:56 -0700
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.53.40.35])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id l09NjtnP033910
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 17:45:55 -0600
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.4/8.12.8) with ESMTP id l09NVPSJ027176
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 17:31:25 -0600
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.4/8.13.4/Submit) id l09NVPr8027175
	for selinux@tycho.nsa.gov; Tue, 9 Jan 2007 17:31:25 -0600
Date: Tue, 9 Jan 2007 17:31:25 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701092331.l09NVPr8027175@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: PATCH[2.1/3]: labeled ipsec policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The 2nd patch of three, was too big to be received on this mailing list,
so I split it into two, 2.1 and 2.2. 
My apologies for not readily realizing the patch had not
been received. 

Regards,
Joy
------------------------------------------------------------------------------
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/evolution.if serefpolicy-2.4.6.patch2/policy/modules/apps/evolution.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/evolution.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/evolution.if	2007-01-08 17:59:29.000000000 -0600
@@ -816,3 +816,57 @@ template(`evolution_stream_connect',`
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
+	allow $2 $1_evolution_server_t:association recvfrom;
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/games.if serefpolicy-2.4.6.patch2/policy/modules/apps/games.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/games.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/games.if	2007-01-05 10:47:48.000000000 -0600
@@ -169,3 +169,21 @@ template(`games_per_role_template',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/gift.if serefpolicy-2.4.6.patch2/policy/modules/apps/gift.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/gift.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/gift.if	2007-01-05 10:47:48.000000000 -0600
@@ -205,3 +205,39 @@ template(`gift_per_role_template',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/gpg.if serefpolicy-2.4.6.patch2/policy/modules/apps/gpg.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/gpg.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/gpg.if	2007-01-05 10:47:48.000000000 -0600
@@ -405,3 +405,39 @@ template(`gpg_signal_user_gpg',`
 
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/irc.if serefpolicy-2.4.6.patch2/policy/modules/apps/irc.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/irc.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/irc.if	2007-01-05 10:47:48.000000000 -0600
@@ -158,3 +158,21 @@ template(`irc_per_role_template',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/java.if serefpolicy-2.4.6.patch2/policy/modules/apps/java.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/java.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/java.if	2007-01-05 10:47:48.000000000 -0600
@@ -200,3 +200,21 @@ interface(`java_domtrans',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/mozilla.if serefpolicy-2.4.6.patch2/policy/modules/apps/mozilla.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/mozilla.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/mozilla.if	2007-01-05 10:47:48.000000000 -0600
@@ -411,3 +411,21 @@ template(`mozilla_per_role_template',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/screen.if serefpolicy-2.4.6.patch2/policy/modules/apps/screen.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/screen.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/screen.if	2007-01-05 10:47:48.000000000 -0600
@@ -199,3 +199,21 @@ template(`screen_per_role_template',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/thunderbird.if serefpolicy-2.4.6.patch2/policy/modules/apps/thunderbird.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/thunderbird.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/thunderbird.if	2007-01-05 10:47:48.000000000 -0600
@@ -348,3 +348,21 @@ template(`thunderbird_per_role_template'
 
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/uml.if serefpolicy-2.4.6.patch2/policy/modules/apps/uml.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/uml.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/uml.if	2007-01-05 10:47:48.000000000 -0600
@@ -250,3 +250,21 @@ interface(`uml_manage_util_files',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/apps/vmware.if serefpolicy-2.4.6.patch2/policy/modules/apps/vmware.if
--- serefpolicy-2.4.6.patch/policy/modules/apps/vmware.if	2007-01-04 15:33:14.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/apps/vmware.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/afs.if serefpolicy-2.4.6.patch2/policy/modules/services/afs.if
--- serefpolicy-2.4.6.patch/policy/modules/services/afs.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/afs.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,91 @@
 ## <summary>Andrew Filesystem server</summary>
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
+interface(`afs_recv_labeledipsec_bosserver',`
+	gen_require(`
+		type afs_bosserver_t;
+	')
+	allow $1 afs_bosserver_t:association recvfrom;
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
+interface(`afs_recv_labeledipsec_fsserver',`
+	gen_require(`
+		type afs_fsserver_t;
+	')
+	allow $1 afs_fsserver_t:association recvfrom;
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
+interface(`afs_recv_labeledipsec_kaserver',`
+	gen_require(`
+		type afs_kaserver_t;
+	')
+	allow $1 afs_kaserver_t:association recvfrom;
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
+interface(`afs_recv_labeledipsec_ptserver',`
+	gen_require(`
+		type afs_ptserver_t;
+	')
+	allow $1 afs_ptserver_t:association recvfrom;
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
+interface(`afs_recv_labeledipsec_vlserver',`
+	gen_require(`
+		type afs_vlserver_t;
+	')
+	allow $1 afs_vlserver_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/amavis.if serefpolicy-2.4.6.patch2/policy/modules/services/amavis.if
--- serefpolicy-2.4.6.patch/policy/modules/services/amavis.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/amavis.if	2007-01-05 10:47:48.000000000 -0600
@@ -174,3 +174,21 @@ interface(`amavis_setattr_pid_files',`
 	allow $1 amavis_var_run_t:file setattr;
 	files_search_pids($1)
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
+interface(`amavis_recv_labeledipsec',`
+	gen_require(`
+		type amavis_t;
+	')
+	allow $1 amavis_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/apache.if serefpolicy-2.4.6.patch2/policy/modules/services/apache.if
--- serefpolicy-2.4.6.patch/policy/modules/services/apache.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/apache.if	2007-01-05 10:47:48.000000000 -0600
@@ -1032,3 +1032,57 @@ interface(`apache_search_sys_script_stat
 
 	allow $1 httpd_sys_script_t:dir search;
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
+interface(`apache_recv_labeledipsec',`
+	gen_require(`
+		type httpd_t;
+	')
+	allow $1 httpd_t:association recvfrom;
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
+interface(`apache_recv_labeledipsec_script_sys',`
+	gen_require(`
+		type httpd_sys_script_t;
+	')
+	allow $1 httpd_sys_script_t:association recvfrom;
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
+interface(`apache_recv_labeledipsec_script_role',`
+	gen_require(`
+		type httpd_$1_script_t;
+	')
+	allow $2 httpd_$1_script_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/asterisk.if serefpolicy-2.4.6.patch2/policy/modules/services/asterisk.if
--- serefpolicy-2.4.6.patch/policy/modules/services/asterisk.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/asterisk.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Asterisk IP telephony server</summary>
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
+interface(`asterisk_recv_labeledipsec',`
+	gen_require(`
+		type asterisk_t;
+	')
+	allow $1 asterisk_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/automount.if serefpolicy-2.4.6.patch2/policy/modules/services/automount.if
--- serefpolicy-2.4.6.patch/policy/modules/services/automount.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/automount.if	2007-01-05 10:47:48.000000000 -0600
@@ -81,3 +81,21 @@ interface(`automount_dontaudit_getattr_t
 
 	dontaudit $1 automount_tmp_t:dir getattr;
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
+interface(`autotmount_recv_labeledipsec',`
+	gen_require(`
+		type automount_t;
+	')
+	allow $1 automoun_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/avahi.if serefpolicy-2.4.6.patch2/policy/modules/services/avahi.if
--- serefpolicy-2.4.6.patch/policy/modules/services/avahi.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/avahi.if	2007-01-05 10:47:48.000000000 -0600
@@ -41,3 +41,21 @@ interface(`avahi_stream_connect',`
 	allow $1 avahi_var_run_t:sock_file rw_file_perms;
 	allow $1 avahi_t:unix_stream_socket connectto;
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
+interface(`avahi_recv_labeledipsec',`
+	gen_require(`
+		type avahi_t;
+	')
+	allow $1 avahi_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/bind.if serefpolicy-2.4.6.patch2/policy/modules/services/bind.if
--- serefpolicy-2.4.6.patch/policy/modules/services/bind.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/bind.if	2007-01-05 10:47:48.000000000 -0600
@@ -268,3 +268,39 @@ interface(`bind_read_zone',`
 interface(`bind_udp_chat_named',`
 	refpolicywarn(`$0($*) has been deprecated.')
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
+interface(`bind_recv_labeledipsec_named',`
+	gen_require(`
+		type named_t;
+	')
+	allow $1 named_t:association recvfrom;
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
+interface(`bind_recv_labeledipsec_ndc',`
+	gen_require(`
+		type ndc_t;
+	')
+	allow $1 ndc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/bluetooth.if serefpolicy-2.4.6.patch2/policy/modules/services/bluetooth.if
--- serefpolicy-2.4.6.patch/policy/modules/services/bluetooth.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/bluetooth.if	2007-01-05 10:47:48.000000000 -0600
@@ -133,3 +133,21 @@ interface(`bluetooth_dontaudit_read_help
 	dontaudit $1 bluetooth_helper_t:dir search;
 	dontaudit $1 bluetooth_helper_t:file { read getattr };
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
+interface(`bluetooth_recv_labeledipsec',`
+	gen_require(`
+		type bluetooth_t;
+	')
+	allow $1 bluetooth_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/canna.if serefpolicy-2.4.6.patch2/policy/modules/services/canna.if
--- serefpolicy-2.4.6.patch/policy/modules/services/canna.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/canna.if	2007-01-05 10:47:48.000000000 -0600
@@ -20,3 +20,21 @@ interface(`canna_stream_connect',`
 	allow $1 canna_var_run_t:sock_file write;
 	allow $1 canna_t:unix_stream_socket connectto;
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
+interface(`canna_recv_labeledipsec',`
+	gen_require(`
+		type canna_t;
+	')
+	allow $1 canna_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ccs.if serefpolicy-2.4.6.patch2/policy/modules/services/ccs.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ccs.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ccs.if	2007-01-05 10:47:48.000000000 -0600
@@ -79,3 +79,21 @@ interface(`ccs_manage_config',`
 	allow $1 cluster_conf_t:dir manage_dir_perms;
 	allow $1 cluster_conf_t:file manage_file_perms;
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
+interface(`ccs_recv_labeledipsec',`
+	gen_require(`
+		type ccs_t;
+	')
+	allow $1 ccs_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/cipe.if serefpolicy-2.4.6.patch2/policy/modules/services/cipe.if
--- serefpolicy-2.4.6.patch/policy/modules/services/cipe.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/cipe.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Encrypted tunnel daemon</summary>
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
+interface(`cipe_recv_labeledipsec',`
+	gen_require(`
+		type ciped_t;
+	')
+	allow $1 ciped_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/clamav.if serefpolicy-2.4.6.patch2/policy/modules/services/clamav.if
--- serefpolicy-2.4.6.patch/policy/modules/services/clamav.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/clamav.if	2007-01-05 10:47:48.000000000 -0600
@@ -102,3 +102,39 @@ interface(`clamav_domtrans_clamscan',`
 	allow clamscan_t $1:fifo_file rw_file_perms;
 	allow clamscan_t $1:process sigchld;
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
+interface(`clamav_recv_labeledipsec',`
+	gen_require(`
+		type clamd_t;
+	')
+	allow $1 clamd_t:association recvfrom;
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
+interface(`clamav_recv_labeledipsec_freshclam',`
+	gen_require(`
+		type freshclam_t;
+	')
+	allow $1 freshclam_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/clockspeed.if serefpolicy-2.4.6.patch2/policy/modules/services/clockspeed.if
--- serefpolicy-2.4.6.patch/policy/modules/services/clockspeed.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/clockspeed.if	2007-01-05 10:47:48.000000000 -0600
@@ -52,3 +52,39 @@ template(`clockspeed_run_cli',`
 	allow clockspeed_cli_t $3:chr_file { getattr read write ioctl };
 
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
+interface(`clockspeed_recv_labeledipsec_cli',`
+	gen_require(`
+		type clockpeed_cli_t;
+	')
+	allow $1 clockspeed_cli_t:association recvfrom;
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
+interface(`clockspeed_recv_labeledipsec_srv',`
+	gen_require(`
+		type clockspeed_srv_t;
+	')
+	allow $1 clockspeed_srv_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/comsat.if serefpolicy-2.4.6.patch2/policy/modules/services/comsat.if
--- serefpolicy-2.4.6.patch/policy/modules/services/comsat.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/comsat.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Comsat, a biff server.</summary>
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
+interface(`comsat_recv_labeledipsec',`
+	gen_require(`
+		type comsat_t;
+	')
+	allow $1 comsat_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/courier.if serefpolicy-2.4.6.patch2/policy/modules/services/courier.if
--- serefpolicy-2.4.6.patch/policy/modules/services/courier.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/courier.if	2007-01-05 10:47:48.000000000 -0600
@@ -141,3 +141,112 @@ interface(`courier_domtrans_pop',`
 	allow courier_pop_t $1:fifo_file rw_file_perms;
 	allow courier_pop_t $1:process sigchld;
 ')
+
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
+interface(`courier_recv_labeledipsec_auth',`
+	gen_require(`
+		type courier_authdaemon_t;
+	')
+	allow $1 courier_authdaemon_t:association recvfrom;
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
+interface(`courier_recv_labeledipsec_pcp',`
+	gen_require(`
+		type courier_pcp_t;
+	')
+	allow $1 courier_pcp_t:association recvfrom;
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
+interface(`courier_recv_labeledipsec_pop',`
+	gen_require(`
+		type courier_pop_t;
+	')
+	allow $1 courier_pop_t:association recvfrom;
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
+interface(`courier_recv_labeledipsec_tcpd',`
+	gen_require(`
+		type courier_tcpd_t;
+	')
+	allow $1 courier_tcpd_t:association recvfrom;
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
+interface(`courier_recv_labeledipsec_sqwebmail',`
+	gen_require(`
+		type courier_sqwebmail_t;
+	')
+	allow $1 courier_sqwebmail_t:association recvfrom;
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
+interface(`courier_recv_labeledipsec_tmpl',`
+	gen_require(`
+		type courier_$1_t;
+	')
+	allow $2 courier_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/cups.if serefpolicy-2.4.6.patch2/policy/modules/services/cups.if
--- serefpolicy-2.4.6.patch/policy/modules/services/cups.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/cups.if	2007-01-05 10:47:48.000000000 -0600
@@ -263,3 +263,59 @@ interface(`cups_stream_connect_ptal',`
 	allow $1 ptal_var_run_t:sock_file write;
 	allow $1 ptal_t:unix_stream_socket connectto;
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
+interface(`cups_recv_labeledipsec',`
+	gen_require(`
+		type cupsd_t;
+	')
+	allow $1 cupsd_t:association recvfrom;
+	allow $1 cupsd_config_t:association recvfrom;
+	allow $1 cupsd_lpd_t:association recvfrom;
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
+interface(`cups_recv_labeledipsec_ptal',`
+	gen_require(`
+		type ptal_t;
+	')
+	allow $1 ptal_t:association recvfrom;
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
+interface(`cups_recv_labeledipsec_hplip',`
+	gen_require(`
+		type hplip_t;
+	')
+	allow $1 hplip_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/cvs.if serefpolicy-2.4.6.patch2/policy/modules/services/cvs.if
--- serefpolicy-2.4.6.patch/policy/modules/services/cvs.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/cvs.if	2007-01-05 10:47:48.000000000 -0600
@@ -37,3 +37,20 @@ interface(`cvs_exec',`
 	can_exec($1,cvs_exec_t)
 ')
 
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
+interface(`cvs_recv_labeledipsec',`
+	gen_require(`
+		type cvs_t;
+	')
+	allow $1 cvs_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/cyrus.if serefpolicy-2.4.6.patch2/policy/modules/services/cyrus.if
--- serefpolicy-2.4.6.patch/policy/modules/services/cyrus.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/cyrus.if	2007-01-05 10:47:48.000000000 -0600
@@ -42,3 +42,21 @@ interface(`cyrus_stream_connect',`
 	allow $1 cyrus_var_lib_t:sock_file write;
 	allow $1 cyrus_t:unix_stream_socket connectto;
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
+interface(`cyrus_recv_labeledipsec',`
+	gen_require(`
+		type cyrus_t;
+	')
+	allow $1 cyrus_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dante.if serefpolicy-2.4.6.patch2/policy/modules/services/dante.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dante.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dante.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Dante msproxy and socks4/5 proxy server</summary>
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
+interface(`dante_recv_labeledipsec',`
+	gen_require(`
+		type dante_t;
+	')
+	allow $1 dante_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dbskk.if serefpolicy-2.4.6.patch2/policy/modules/services/dbskk.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dbskk.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dbskk.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Dictionary server for the SKK Japanese input method system.</summary>
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
+interface(`dbskk_recv_labeledipsec',`
+	gen_require(`
+		type dbskkd_t;
+	')
+	allow $1 dbskkd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dbus.if serefpolicy-2.4.6.patch2/policy/modules/services/dbus.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dbus.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dbus.if	2007-01-05 10:47:48.000000000 -0600
@@ -354,3 +354,21 @@ interface(`dbus_system_bus_unconfined',`
 
 	allow $1 system_dbusd_t:dbus *;
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
+interface(`dbus_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_dbusd_t;
+	')
+	allow $2 $1_dbusd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dcc.if serefpolicy-2.4.6.patch2/policy/modules/services/dcc.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dcc.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dcc.if	2007-01-05 10:47:48.000000000 -0600
@@ -182,3 +182,111 @@ interface(`dcc_stream_connect_dccifd',`
 	allow $1 dccifd_var_run_t:sock_file { getattr write };
 	allow $1 dccifd_t:unix_stream_socket connectto;
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
+interface(`dcc_recv_labeledipsec_cdcc',`
+	gen_require(`
+		type cdcc_t;
+	')
+	allow $1 cdcc_t:association recvfrom;
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
+interface(`dcc_recv_labeledipsec_client',`
+	gen_require(`
+		type dcc_client_t;
+	')
+	allow $1 dcc_client_t:association recvfrom;
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
+interface(`dcc_recv_labeledipsec_dbclean',`
+	gen_require(`
+		type dcc_dbclean_t;
+	')
+	allow $1 dcc_dbclean_t:association recvfrom;
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
+interface(`dcc_recv_labeledipsec_dccd',`
+	gen_require(`
+		type dccd_t;
+	')
+	allow $1 dccd_t:association recvfrom;
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
+interface(`dcc_recv_labeledipsec_dccifd',`
+	gen_require(`
+		type dccifd_t;
+	')
+	allow $1 dccifd_t:association recvfrom;
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
+interface(`dcc_recv_labeledipsec_dccm',`
+	gen_require(`
+		type dccm_t;
+	')
+	allow $1 dccm_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ddclient.if serefpolicy-2.4.6.patch2/policy/modules/services/ddclient.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ddclient.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ddclient.if	2007-01-05 10:47:48.000000000 -0600
@@ -23,3 +23,21 @@ interface(`ddclient_domtrans',`
 	allow ddclient_t $1:fifo_file rw_file_perms;
 	allow ddclient_t $1:process sigchld;
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
+interface(`ddclient_recv_labeledipsec',`
+	gen_require(`
+		type ddclient_t;
+	')
+	allow $1 ddclient_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dhcp.if serefpolicy-2.4.6.patch2/policy/modules/services/dhcp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dhcp.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dhcp.if	2007-01-05 10:47:48.000000000 -0600
@@ -19,3 +19,21 @@ interface(`dhcpd_setattr_state_files',`
 	sysnet_search_dhcp_state($1)
 	allow $1 dhcpd_state_t:file setattr;
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
+interface(`dhcpd_recv_labeledipsec',`
+	gen_require(`
+		type dhcpd_t;
+	')
+	allow $1 dhcpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dictd.if serefpolicy-2.4.6.patch2/policy/modules/services/dictd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dictd.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dictd.if	2007-01-05 10:47:48.000000000 -0600
@@ -14,3 +14,21 @@
 interface(`dictd_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
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
+interface(`dictd_recv_labeledipsec',`
+	gen_require(`
+		type dictd_t;
+	')
+	allow $1 dictd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/distcc.if serefpolicy-2.4.6.patch2/policy/modules/services/distcc.if
--- serefpolicy-2.4.6.patch/policy/modules/services/distcc.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/distcc.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Distributed compiler daemon</summary>
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
+interface(`distcc_recv_labeledipsec',`
+	gen_require(`
+		type distccd_t;
+	')
+	allow $1 distccd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/djbdns.if serefpolicy-2.4.6.patch2/policy/modules/services/djbdns.if
--- serefpolicy-2.4.6.patch/policy/modules/services/djbdns.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/djbdns.if	2007-01-05 10:47:48.000000000 -0600
@@ -53,3 +53,57 @@ template(`djbdns_daemontools_domain_temp
 	libs_use_ld_so(djbdns_$1_t)
 	libs_use_shared_libs(djbdns_$1_t)
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
+interface(`djbdns_recv_labeledipsec_dnscache',`
+	gen_require(`
+		type djbdns_dnscache_t;
+	')
+	allow $1 djbdns_dnscache_t:association recvfrom;
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
+interface(`djbdns_recv_labeledipsec_tinydns',`
+	gen_require(`
+		type djbdns_tinydns_t;
+	')
+	allow $1 djbdns_tinydns_t:association recvfrom;
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
+interface(`djbdns_recv_labeledipsec_domain',`
+	gen_require(`
+		type djbdns_$1_t;
+	')
+	allow $2 djbdns_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dnsmasq.if serefpolicy-2.4.6.patch2/policy/modules/services/dnsmasq.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dnsmasq.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dnsmasq.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>dnsmasq DNS forwarder and DHCP server</summary>
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
+interface(`dnsmasq_recv_labeledipsec',`
+	gen_require(`
+		type dnsmasq_t;
+	')
+	allow $1 dnsmasq_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/dovecot.if serefpolicy-2.4.6.patch2/policy/modules/services/dovecot.if
--- serefpolicy-2.4.6.patch/policy/modules/services/dovecot.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/dovecot.if	2007-01-05 10:47:48.000000000 -0600
@@ -19,3 +19,21 @@ interface(`dovecot_manage_spool',`
 	allow $1 dovecot_spool_t:file create_file_perms;
 	allow $1 dovecot_spool_t:lnk_file create_lnk_perms;
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
+interface(`dovecot_recv_labeledipsec',`
+	gen_require(`
+		type dovecot_t;
+	')
+	allow $1 dovecot_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/fetchmail.if serefpolicy-2.4.6.patch2/policy/modules/services/fetchmail.if
--- serefpolicy-2.4.6.patch/policy/modules/services/fetchmail.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/fetchmail.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Remote-mail retrieval and forwarding utility</summary>
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
+interface(`fetchmail_recv_labeledipsec',`
+	gen_require(`
+		type mrtg_t;
+	')
+	allow $1 fetchmail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/finger.if serefpolicy-2.4.6.patch2/policy/modules/services/finger.if
--- serefpolicy-2.4.6.patch/policy/modules/services/finger.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/finger.if	2007-01-05 10:47:48.000000000 -0600
@@ -36,3 +36,21 @@ interface(`finger_domtrans',`
 interface(`finger_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
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
+interface(`finger_recv_labeledipsec',`
+	gen_require(`
+		type fingerd_t;
+	')
+	allow $1 fingerd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ftp.if serefpolicy-2.4.6.patch2/policy/modules/services/ftp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ftp.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ftp.if	2007-01-05 10:47:48.000000000 -0600
@@ -126,3 +126,21 @@ interface(`ftp_domtrans_ftpdctl',`
 	allow ftpdctl_t $1:fifo_file rw_file_perms;
 	allow ftpdctl_t $1:process sigchld;
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
+interface(`ftp_recv_labeledipsec',`
+	gen_require(`
+		type ftpd_t;
+	')
+	allow $1 ftpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/gatekeeper.if serefpolicy-2.4.6.patch2/policy/modules/services/gatekeeper.if
--- serefpolicy-2.4.6.patch/policy/modules/services/gatekeeper.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/gatekeeper.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>OpenH.323 Voice-Over-IP Gatekeeper</summary>
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
+interface(`gatekeeper_recv_labeledipsec',`
+	gen_require(`
+		type gatekeeper_t;
+	')
+	allow $1 gatekeeper_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/hal.if serefpolicy-2.4.6.patch2/policy/modules/services/hal.if
--- serefpolicy-2.4.6.patch/policy/modules/services/hal.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/hal.if	2007-01-05 10:47:48.000000000 -0600
@@ -177,3 +177,21 @@ interface(`hal_dontaudit_append_var_lib_
 	files_search_pids($1)
 	dontaudit $1 hald_var_lib_t:file ra_file_perms;
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
+interface(`hal_recv_labeledipsec',`
+	gen_require(`
+		type hald_t;
+	')
+	allow $1 hald_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/howl.if serefpolicy-2.4.6.patch2/policy/modules/services/howl.if
--- serefpolicy-2.4.6.patch/policy/modules/services/howl.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/howl.if	2007-01-05 10:47:48.000000000 -0600
@@ -17,3 +17,21 @@ interface(`howl_signal',`
 
 	allow $1 howl_t:process signal;
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
+interface(`howl_recv_labeledipsec',`
+	gen_require(`
+		type howl_t;
+	')
+	allow $1 howl_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/i18n_input.if serefpolicy-2.4.6.patch2/policy/modules/services/i18n_input.if
--- serefpolicy-2.4.6.patch/policy/modules/services/i18n_input.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/i18n_input.if	2007-01-05 10:47:48.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`i18n_use',`
 	refpolicywarn(`$0($*) has been deprecated.')
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
+interface(`i18n_recv_labeledipsec',`
+	gen_require(`
+		type i18n_input_t;
+	')
+	allow $1 i18n_input_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/imaze.if serefpolicy-2.4.6.patch2/policy/modules/services/imaze.if
--- serefpolicy-2.4.6.patch/policy/modules/services/imaze.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/imaze.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>iMaze game server</summary>
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
+interface(`imaze_recv_labeledipsec',`
+	gen_require(`
+		type imazesrv_t;
+	')
+	allow $1 imazesrv_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/inetd.if serefpolicy-2.4.6.patch2/policy/modules/services/inetd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/inetd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/inetd.if	2007-01-05 10:47:48.000000000 -0600
@@ -236,3 +236,39 @@ interface(`inetd_rw_tcp_sockets',`
 
 	allow $1 inetd_t:tcp_socket rw_stream_socket_perms;
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
+interface(`inetd_recv_labeledipsec',`
+	gen_require(`
+		type inetd_t;
+	')
+	allow $1 inetd_t:association recvfrom;
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
+interface(`inetd_recv_labeledipsec_child',`
+	gen_require(`
+		type inetd_child_t;
+	')
+	allow $1 inetd_child_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/inn.if serefpolicy-2.4.6.patch2/policy/modules/services/inn.if
--- serefpolicy-2.4.6.patch/policy/modules/services/inn.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/inn.if	2007-01-05 10:47:48.000000000 -0600
@@ -182,3 +182,20 @@ interface(`inn_domtrans',`
 	allow innd_t $1:process sigchld;
 ')
 
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
+interface(`inn_recv_labeledipsec',`
+	gen_require(`
+		type innd_t;
+	')
+	allow $1 innd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ircd.if serefpolicy-2.4.6.patch2/policy/modules/services/ircd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ircd.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ircd.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>IRC server</summary>
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
+interface(`ircd_recv_labeledipsec',`
+	gen_require(`
+		type ircd_t;
+	')
+	allow $1 ircd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/jabber.if serefpolicy-2.4.6.patch2/policy/modules/services/jabber.if
--- serefpolicy-2.4.6.patch/policy/modules/services/jabber.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/jabber.if	2007-01-05 10:47:48.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`jabber_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
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
+interface(`jabber_recv_labeledipsec',`
+	gen_require(`
+		type jabberd_t;
+	')
+	allow $1 jabberd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/kerberos.if serefpolicy-2.4.6.patch2/policy/modules/services/kerberos.if
--- serefpolicy-2.4.6.patch/policy/modules/services/kerberos.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/kerberos.if	2007-01-05 10:47:48.000000000 -0600
@@ -142,3 +142,39 @@ interface(`kerberos_read_keytab',`
 	files_search_etc($1)
 	allow $1 krb5_keytab_t:file r_file_perms;
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
+interface(`kerberos_recv_labeledipsec_kadmind',`
+	gen_require(`
+		type kadmind_t;
+	')
+	allow $1 kadmind_t:association recvfrom;
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
+interface(`kerberos_recv_labeledipsec_krb5kdc',`
+	gen_require(`
+		type krb5kdc_t;
+	')
+	allow $1 krb5kdc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ktalk.if serefpolicy-2.4.6.patch2/policy/modules/services/ktalk.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ktalk.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ktalk.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>KDE Talk daemon</summary>
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
+interface(`ktalk_recv_labeledipsec',`
+	gen_require(`
+		type ktalkd_t;
+	')
+	allow $1 ktalkd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ldap.if serefpolicy-2.4.6.patch2/policy/modules/services/ldap.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ldap.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ldap.if	2007-01-05 10:47:48.000000000 -0600
@@ -73,3 +73,21 @@ interface(`ldap_stream_connect',`
 	allow $1 slapd_var_run_t:sock_file write;
 	allow $1 slapd_t:unix_stream_socket connectto;
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
+interface(`ldap_recv_labeledipsec',`
+	gen_require(`
+		type slapd_t;
+	')
+	allow $1 slapd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/lpd.if serefpolicy-2.4.6.patch2/policy/modules/services/lpd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/lpd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/lpd.if	2007-01-05 10:47:48.000000000 -0600
@@ -406,3 +406,56 @@ template(`lpd_domtrans_user_lpr',`
 	allow $1_lpr_t $2:process sigchld;
 ')
 
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
+interface(`lpd_recv_labeledipsec',`
+	gen_require(`
+		type lpd_t;
+	')
+	allow $1 lpd_t:association recvfrom;
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
+interface(`lpd_recv_labeledipsec_checkpc',`
+	gen_require(`
+		type checkpc_t;
+	')
+	allow $1 checkpc_t:association recvfrom;
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
+interface(`lpd_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_lpr_t;
+	')
+	allow $2 $1_lpr_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/mailman.if serefpolicy-2.4.6.patch2/policy/modules/services/mailman.if
--- serefpolicy-2.4.6.patch/policy/modules/services/mailman.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/mailman.if	2007-01-05 10:47:48.000000000 -0600
@@ -334,3 +334,74 @@ interface(`mailman_domtrans_queue',`
 	allow mailman_queue_t $1:process sigchld;
 ')
 
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
+interface(`mailman_recv_labeledipsec_cgi',`
+	gen_require(`
+		type mailman_cgi_t;
+	')
+	allow $1 mailman_cgi_t:association recvfrom;
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
+interface(`mailman_recv_labeledipsec_mail',`
+	gen_require(`
+		type mailman_mail_t;
+	')
+	allow $1 mailman_mail_t:association recvfrom;
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
+interface(`mailman_recv_labeledipsec_queue',`
+	gen_require(`
+		type mailman_queue_t;
+	')
+	allow $1 mailman_queue_t:association recvfrom;
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
+interface(`mailman_recv_labeledipsec_tmpl',`
+	gen_require(`
+		type mailman_$1_t;
+	')
+	allow $2 mailman_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/monop.if serefpolicy-2.4.6.patch2/policy/modules/services/monop.if
--- serefpolicy-2.4.6.patch/policy/modules/services/monop.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/monop.if	2007-01-05 10:47:48.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Monopoly daemon</summary>
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
+interface(`monop_recv_labeledipsec',`
+	gen_require(`
+		type monopd_t;
+	')
+	allow $1 monopd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/mta.if serefpolicy-2.4.6.patch2/policy/modules/services/mta.if
--- serefpolicy-2.4.6.patch/policy/modules/services/mta.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/mta.if	2007-01-05 10:47:48.000000000 -0600
@@ -883,3 +883,21 @@ interface(`mta_rw_user_mail_stream_socke
 
 	allow $1 user_mail_domain:unix_stream_socket rw_socket_perms;
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
+interface(`mta_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_mail_t;
+	')
+	allow $2 $_mail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/munin.if serefpolicy-2.4.6.patch2/policy/modules/services/munin.if
--- serefpolicy-2.4.6.patch/policy/modules/services/munin.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/munin.if	2007-01-05 10:47:48.000000000 -0600
@@ -61,3 +61,21 @@ interface(`munin_search_lib',`
 	allow $1 munin_var_lib_t:dir search_dir_perms;
 	files_search_var_lib($1)
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
+interface(`munin_recv_labeledipsec',`
+	gen_require(`
+		type munin_t;
+	')
+	allow $1 munin_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/mysql.if serefpolicy-2.4.6.patch2/policy/modules/services/mysql.if
--- serefpolicy-2.4.6.patch/policy/modules/services/mysql.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/mysql.if	2007-01-05 10:47:48.000000000 -0600
@@ -159,3 +159,21 @@ interface(`mysql_write_log',`
 	logging_search_logs($1)
 	allow $1 mysqld_log_t:file { write append setattr ioctl };
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
+interface(`mysql_recv_labeledipsec',`
+	gen_require(`
+		type mysqld_t;
+	')
+	allow $1 mysqld_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nagios.if serefpolicy-2.4.6.patch2/policy/modules/services/nagios.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nagios.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nagios.if	2007-01-05 10:47:48.000000000 -0600
@@ -85,3 +85,21 @@ interface(`nagios_domtrans_nrpe',`
 	allow nrpe_t $1:fifo_file rw_file_perms;
 	allow nrpe_t $1:process sigchld;
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
+interface(`nagios_recv_labeledipsec',`
+	gen_require(`
+		type nagios_t;
+	')
+	allow $1 nagios_t:association recvfrom;
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
