Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IOqtP013030
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:24:52 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IOpOD010999
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:24:51 GMT
Message-ID: <46B2216E.1040203@redhat.com>
Date: Thu, 02 Aug 2007 14:24:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Lots of fixes for postfix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Added virtual
Switch to using nsswitch
Lots of daemons want to read master_t:file
--- nsaserefpolicy/policy/modules/services/postfix.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/postfix.fc	2007-08-02 11:02:02.000000000 -0400
@@ -14,6 +14,7 @@
 /usr/libexec/postfix/smtpd --	gen_context(system_u:object_r:postfix_smtpd_exec_t,s0)
 /usr/libexec/postfix/bounce --	gen_context(system_u:object_r:postfix_bounce_exec_t,s0)
 /usr/libexec/postfix/pipe --	gen_context(system_u:object_r:postfix_pipe_exec_t,s0)
+/usr/libexec/postfix/virtual --	gen_context(system_u:object_r:postfix_virtual_exec_t,s0)
 ', `
 /usr/lib/postfix/.*	--	gen_context(system_u:object_r:postfix_exec_t,s0)
 /usr/lib/postfix/cleanup --	gen_context(system_u:object_r:postfix_cleanup_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/postfix.if	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/postfix.if	2007-08-02 11:02:02.000000000 -0400
@@ -41,6 +41,8 @@
 	allow postfix_$1_t self:unix_stream_socket connectto;
 
 	allow postfix_master_t postfix_$1_t:process signal;
+	#https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=244456
+	allow postfix_$1_t postfix_master_t:file read;
 
 	allow postfix_$1_t postfix_etc_t:dir list_dir_perms;
 	read_files_pattern(postfix_$1_t,postfix_etc_t,postfix_etc_t)
@@ -66,6 +68,7 @@
 
 	fs_search_auto_mountpoints(postfix_$1_t)
 	fs_getattr_xattr_fs(postfix_$1_t)
+	fs_rw_anon_inodefs_files(postfix_$1_t)
 
 	term_dontaudit_use_console(postfix_$1_t)
 
@@ -132,10 +135,8 @@
 	corenet_tcp_connect_all_ports(postfix_$1_t)
 	corenet_sendrecv_all_client_packets(postfix_$1_t)
 
-	sysnet_read_config(postfix_$1_t)
-
 	optional_policy(`
-		nis_use_ypbind(postfix_$1_t)
+		auth_use_nsswitch(postfix_$1_t)
 	')
 ')
 
@@ -269,6 +270,42 @@
 
 ########################################
 ## <summary>
+##	Allow domain to read postfix local process state
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`postfix_read_local_state',`
+	gen_require(`
+		type postfix_local_t;
+	')
+
+	read_files_pattern($1,postfix_local_t,postfix_local_t)
+')
+
+########################################
+## <summary>
+##	Allow domain to read postfix master process state
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`postfix_read_master_state',`
+	gen_require(`
+		type postfix_master_t;
+	')
+
+	read_files_pattern($1,postfix_master_t,postfix_master_t)
+')
+
+########################################
+## <summary>
 ##	Do not audit attempts to use
 ##	postfix master process file
 ##	file descriptors.
@@ -434,6 +471,25 @@
 
 ########################################
 ## <summary>
+##	Read postfix mail spool files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`postfix_read_spool_files',`
+	gen_require(`
+		type postfix_spool_t;
+	')
+
+	files_search_spool($1)
+	read_files_pattern($1,postfix_spool_t, postfix_spool_t)
+')
+
+########################################
+## <summary>
 ##	Execute postfix user mail programs
 ##	in their respective domains.
 ## </summary>
@@ -450,3 +506,22 @@
 
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
--- nsaserefpolicy/policy/modules/services/postfix.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/postfix.te	2007-08-02 11:02:02.000000000 -0400
@@ -83,6 +83,12 @@
 type postfix_var_run_t;
 files_pid_file(postfix_var_run_t)
 
+postfix_server_domain_template(virtual)
+mta_mailserver_delivery(postfix_virtual_t)
+
+type postfix_virtual_tmp_t;
+files_tmp_file(postfix_virtual_tmp_t)
+
 ########################################
 #
 # Postfix master process local policy
@@ -168,6 +174,11 @@
 
 mta_rw_aliases(postfix_master_t)
 mta_read_sendmail_bin(postfix_master_t)
+term_dontaudit_search_ptys(postfix_master_t)
+
+optional_policy(`
+	auth_use_nsswitch(postfix_master_t)
+')
 
 optional_policy(`
 	cyrus_stream_connect(postfix_master_t)
@@ -179,9 +190,17 @@
 ')
 
 optional_policy(`
+	mysql_stream_connect(postfix_master_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(postfix_master_t)
 ')
 
+optional_policy(`
+	sendmail_signal(postfix_master_t)
+')
+
 ###########################################################
 #
 # Partially converted rules.  THESE ARE ONLY TEMPORARY
@@ -377,7 +396,7 @@
 # Postfix pipe local policy
 #
 
-allow postfix_pipe_t self:fifo_file { read write };
+allow postfix_pipe_t self:fifo_file rw_fifo_file_perms;
 
 write_sock_files_pattern(postfix_pipe_t,postfix_private_t,postfix_private_t)
 
@@ -386,6 +405,10 @@
 rw_files_pattern(postfix_pipe_t,postfix_spool_t,postfix_spool_t)
 
 optional_policy(`
+	dovecot_domtrans_deliver(postfix_pipe_t)
+')
+
+optional_policy(`
 	procmail_domtrans(postfix_pipe_t)
 ')
 
@@ -426,6 +449,11 @@
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
@@ -505,8 +533,6 @@
 # Postfix smtp delivery local policy
 #
 
-allow postfix_smtp_t self:netlink_route_socket r_netlink_socket_perms;
-
 # connect to master process
 stream_connect_pattern(postfix_smtp_t,{ postfix_private_t postfix_public_t },{ postfix_private_t postfix_public_t },postfix_master_t)
 
@@ -514,6 +540,8 @@
 
 allow postfix_smtp_t postfix_spool_t:file rw_file_perms;
 
+files_dontaudit_getattr_home_dir(postfix_smtp_t)
+
 optional_policy(`
 	cyrus_stream_connect(postfix_smtp_t)
 ')
@@ -538,9 +566,45 @@
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
+########################################
+#
+# Postfix virtual local policy
+#
+
+allow postfix_virtual_t self:fifo_file rw_fifo_file_perms;
+allow postfix_virtual_t self:process { setsched setrlimit };
+
+manage_dirs_pattern(postfix_virtual_t,postfix_virtual_tmp_t,postfix_virtual_tmp_t)
+manage_files_pattern(postfix_virtual_t,postfix_virtual_tmp_t,postfix_virtual_tmp_t)
+files_tmp_filetrans(postfix_virtual_t, postfix_virtual_tmp_t, { file dir })
+
+# connect to master process
+stream_connect_pattern(postfix_virtual_t,postfix_public_t,postfix_public_t,postfix_master_t)
+
+allow postfix_virtual_t postfix_spool_t:file rw_file_perms;
+
+corecmd_exec_shell(postfix_virtual_t)
+corecmd_exec_bin(postfix_virtual_t)
+
+files_read_etc_files(postfix_virtual_t)
+
+mta_read_aliases(postfix_virtual_t)
+mta_delete_spool(postfix_virtual_t)
+# For reading spamassasin
+mta_read_config(postfix_virtual_t)
+mta_manage_spool(postfix_virtual_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
