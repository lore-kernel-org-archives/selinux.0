Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarkE013764
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaoue002802
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 10:34:21 -0400
Message-Id: <200705301434.l4UEYL4v007939@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: postfix changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

postfix needs to use nsswitch
postfix communicates with dovecot 
postfix_master children are reading parents process table
Communicate with mysql
Read mailman data

--- nsaserefpolicy/policy/modules/services/postfix.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/postfix.if	2007-05-30 09:08:15.000000000 -0400
@@ -131,10 +131,8 @@
 	corenet_tcp_connect_all_ports(postfix_$1_t)
 	corenet_sendrecv_all_client_packets(postfix_$1_t)
 
-	sysnet_read_config(postfix_$1_t)
-
 	optional_policy(`
-		nis_use_ypbind(postfix_$1_t)
+		auth_use_nsswitch(postfix_$1_t)
 	')
 ')
 
@@ -449,3 +447,22 @@
 
 	typeattribute $1 postfix_user_domtrans;
 ')
+
+########################################
+## <summary>
+##	Create a named socket in a postfix private directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`postfix_create_pivate_sockets',`
+	gen_require(`
+		type postfix_private_t;
+	')
+
+	allow $1 postfix_private_t:dir list_dir_perms;
+	create_sock_files_pattern($1,postfix_private_t,postfix_private_t)
+')
--- nsaserefpolicy/policy/modules/services/postfix.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/postfix.te	2007-05-30 09:08:15.000000000 -0400
@@ -169,6 +169,12 @@
 mta_rw_aliases(postfix_master_t)
 mta_read_sendmail_bin(postfix_master_t)
 
+term_dontaudit_search_ptys(postfix_master_t)
+
+optional_policy(`
+	auth_use_nsswitch(postfix_master_t)
+')
+
 optional_policy(`
 	cyrus_stream_connect(postfix_master_t)
 ')
@@ -179,6 +185,10 @@
 ')
 
 optional_policy(`
+	mysql_stream_connect(postfix_master_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(postfix_master_t)
 ')
 
@@ -205,6 +215,7 @@
 
 allow postfix_bounce_t self:capability dac_read_search;
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
+allow postfix_bounce_t postfix_master_t:file read;
 
 allow postfix_bounce_t postfix_public_t:sock_file write;
 allow postfix_bounce_t postfix_public_t:dir search;
@@ -223,6 +234,7 @@
 #
 
 allow postfix_cleanup_t self:process setrlimit;
+allow postfix_cleanup_t postfix_master_t:file read;
 
 # connect to master process
 stream_connect_pattern(postfix_cleanup_t,postfix_private_t,postfix_private_t,postfix_master_t)
@@ -245,6 +257,7 @@
 
 allow postfix_local_t self:fifo_file rw_fifo_file_perms;
 allow postfix_local_t self:process { setsched setrlimit };
+allow postfix_local_t postfix_master_t:file read;
 
 manage_dirs_pattern(postfix_local_t,postfix_local_tmp_t,postfix_local_tmp_t)
 manage_files_pattern(postfix_local_t,postfix_local_tmp_t,postfix_local_tmp_t)
@@ -359,6 +372,7 @@
 #
 
 allow postfix_pickup_t self:tcp_socket create_socket_perms;
+allow postfix_pickup_t postfix_master_t:file read;
 
 stream_connect_pattern(postfix_pickup_t,postfix_private_t,postfix_private_t,postfix_master_t)
 
@@ -376,7 +390,7 @@
 # Postfix pipe local policy
 #
 
-allow postfix_pipe_t self:fifo_file { read write };
+allow postfix_pipe_t self:fifo_file rw_fifo_file_perms;
 
 write_sock_files_pattern(postfix_pipe_t,postfix_private_t,postfix_private_t)
 
@@ -385,6 +399,10 @@
 rw_files_pattern(postfix_pipe_t,postfix_spool_t,postfix_spool_t)
 
 optional_policy(`
+	dovecot_domtrans_deliver(postfix_pipe_t)
+')
+
+optional_policy(`
 	procmail_domtrans(postfix_pipe_t)
 ')
 
@@ -425,6 +443,11 @@
 	cron_system_entry(postfix_postdrop_t, postfix_postdrop_exec_t)
 ')
 
+# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=239951
+optional_policy(`
+	fstools_read_pipes(postfix_postdrop_t)
+')
+
 optional_policy(`
 	ppp_use_fds(postfix_postqueue_t)
 	ppp_sigchld(postfix_postqueue_t)
@@ -460,6 +483,8 @@
 # Postfix qmgr local policy
 #
 
+allow postfix_qmgr_t postfix_master_t:file read;
+
 stream_connect_pattern(postfix_qmgr_t,{ postfix_private_t postfix_public_t },{ postfix_private_t postfix_public_t },postfix_master_t)
 
 rw_fifo_files_pattern(postfix_qmgr_t,postfix_public_t,postfix_public_t)
@@ -504,8 +529,6 @@
 # Postfix smtp delivery local policy
 #
 
-allow postfix_smtp_t self:netlink_route_socket r_netlink_socket_perms;
-
 # connect to master process
 stream_connect_pattern(postfix_smtp_t,{ postfix_private_t postfix_public_t },{ postfix_private_t postfix_public_t },postfix_master_t)
 
@@ -537,9 +560,18 @@
 mta_read_aliases(postfix_smtpd_t)
 
 optional_policy(`
+	mailman_read_data_files(postfix_smtpd_t)
+')
+
+optional_policy(`
 	postgrey_stream_connect(postfix_smtpd_t)
 ')
 
 optional_policy(`
 	sasl_connect(postfix_smtpd_t)
 ')
+
+optional_policy(`
+	dovecot_auth_stream_connect(postfix_smtpd_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
