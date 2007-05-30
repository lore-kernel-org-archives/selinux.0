Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHpWeM016192
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:51:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHpSug005771
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:51:31 GMT
Date: Wed, 30 May 2007 10:50:21 -0400
Message-Id: <200705301450.l4UEoLSx008208@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: dovecot
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add domain for dovecot deliver
dovecot uses nsswitch
Many other minor rules added

--- nsaserefpolicy/policy/modules/services/dovecot.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/dovecot.fc	2007-05-30 07:35:54.000000000 -0400
@@ -17,10 +17,12 @@
 
 ifdef(`distro_debian', `
 /usr/lib/dovecot/dovecot-auth 	--	gen_context(system_u:object_r:dovecot_auth_exec_t,s0)
+/usr/lib/dovecot/deliver --	gen_context(system_u:object_r:dovecot_deliver_exec_t,s0)
 ')
 
 ifdef(`distro_redhat', `
 /usr/libexec/dovecot/dovecot-auth --	gen_context(system_u:object_r:dovecot_auth_exec_t,s0)
+/usr/libexec/dovecot/deliver --	gen_context(system_u:object_r:dovecot_deliver_exec_t,s0)
 ')
 
 #
--- nsaserefpolicy/policy/modules/services/dovecot.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/dovecot.if	2007-05-30 07:35:54.000000000 -0400
@@ -18,3 +18,43 @@
 	manage_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 	manage_lnk_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 ')
+
+########################################
+## <summary>
+##	Connect to dovecot auth unix domain stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`dovecot_auth_stream_connect',`
+	gen_require(`
+		type dovecot_auth_t, dovecot_var_run_t;
+	')
+
+	allow $1 dovecot_var_run_t:dir search;
+	allow $1 dovecot_var_run_t:sock_file write;
+	allow $1 dovecot_auth_t:unix_stream_socket connectto;
+')
+
+########################################
+## <summary>
+##	Execute dovecot_deliver in the dovecot_deliver domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dovecot_domtrans_deliver',`
+	gen_require(`
+		type dovecot_deliver_t, dovecot_deliver_exec_t;
+	')
+
+	domtrans_pattern($1,dovecot_deliver_exec_t,dovecot_deliver_t)
+')
+
--- nsaserefpolicy/policy/modules/services/dovecot.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/dovecot.te	2007-05-30 07:35:54.000000000 -0400
@@ -1,5 +1,5 @@
 
-policy_module(dovecot,1.5.0)
+policy_module(dovecot,1.5.1)
 
 ########################################
 #
@@ -15,6 +15,12 @@
 domain_entry_file(dovecot_auth_t,dovecot_auth_exec_t)
 role system_r types dovecot_auth_t;
 
+type dovecot_deliver_t;
+type dovecot_deliver_exec_t;
+domain_type(dovecot_deliver_t)
+domain_entry_file(dovecot_deliver_t,dovecot_deliver_exec_t)
+role system_r types dovecot_deliver_t;
+
 type dovecot_cert_t;
 files_type(dovecot_cert_t)
 
@@ -46,7 +52,6 @@
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
-
 domtrans_pattern(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 
 allow dovecot_t dovecot_cert_t:dir list_dir_perms;
@@ -66,6 +71,8 @@
 manage_sock_files_pattern(dovecot_t,dovecot_var_run_t,dovecot_var_run_t)
 files_pid_filetrans(dovecot_t,dovecot_var_run_t,file)
 
+auth_use_nsswitch(dovecot_t)
+
 kernel_read_kernel_sysctls(dovecot_t)
 kernel_read_system_state(dovecot_t)
 
@@ -109,9 +116,6 @@
 miscfiles_read_certs(dovecot_t)
 miscfiles_read_localization(dovecot_t)
 
-sysnet_read_config(dovecot_t)
-sysnet_use_ldap(dovecot_auth_t)
-
 userdom_dontaudit_use_unpriv_user_fds(dovecot_t)
 userdom_dontaudit_search_sysadm_home_dirs(dovecot_t)
 userdom_priveleged_home_dir_manager(dovecot_t)
@@ -123,11 +127,11 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(dovecot_t)
+	seutil_sigchld_newrole(dovecot_t)
 ')
 
 optional_policy(`
-	seutil_sigchld_newrole(dovecot_t)
+	squid_dontaudit_search_cache(dovecot_t)
 ')
 
 optional_policy(`
@@ -139,25 +143,29 @@
 # dovecot auth local policy
 #
 
-allow dovecot_auth_t self:capability { setgid setuid };
+allow dovecot_auth_t self:capability { chown dac_override setgid setuid };
 allow dovecot_auth_t self:process signal_perms;
 allow dovecot_auth_t self:fifo_file rw_fifo_file_perms;
 allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_auth_t self:unix_stream_socket create_stream_socket_perms;
 
-allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
+allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl connectto };
 
 allow dovecot_auth_t dovecot_passwd_t:file { getattr read };
 
 # Allow dovecot to create and read SSL parameters file
 manage_files_pattern(dovecot_t,dovecot_var_lib_t,dovecot_var_lib_t)
 files_search_var_lib(dovecot_t)
+files_read_var_symlinks(dovecot_t)
 
 allow dovecot_auth_t dovecot_var_run_t:dir r_dir_perms;
 
 kernel_read_all_sysctls(dovecot_auth_t)
 kernel_read_system_state(dovecot_auth_t)
 
+logging_send_syslog_msg(dovecot_auth_t)
+logging_send_audit_msg(dovecot_auth_t)
+
 dev_read_urand(dovecot_auth_t)
 
 auth_domtrans_chk_passwd(dovecot_auth_t)
@@ -166,6 +174,7 @@
 files_read_etc_files(dovecot_auth_t)
 files_read_etc_runtime_files(dovecot_auth_t)
 files_search_pids(dovecot_auth_t)
+files_read_usr_files(dovecot_auth_t)
 files_read_usr_symlinks(dovecot_auth_t)
 files_search_tmp(dovecot_auth_t)
 files_read_var_lib_files(dovecot_t)
@@ -179,12 +188,41 @@
 
 seutil_dontaudit_search_config(dovecot_auth_t)
 
-sysnet_dns_name_resolve(dovecot_auth_t)
-
 optional_policy(`
 	kerberos_use(dovecot_auth_t)
 ')
 
 optional_policy(`
-	logging_send_syslog_msg(dovecot_auth_t)
+	mysql_search_db(dovecot_auth_t)
+	mysql_stream_connect(dovecot_auth_t)
+')
+
+optional_policy(`
+	postfix_create_pivate_sockets(dovecot_auth_t)
+	postfix_search_spool(dovecot_auth_t)
+')
+
+
+########################################
+#
+# dovecot deliver local policy
+#
+allow dovecot_deliver_t dovecot_etc_t:file read_file_perms;
+allow dovecot_deliver_t dovecot_var_run_t:dir r_dir_perms;
+
+kernel_read_all_sysctls(dovecot_deliver_t)
+kernel_read_system_state(dovecot_deliver_t)
+
+dovecot_auth_stream_connect(dovecot_deliver_t)
+
+files_read_etc_files(dovecot_deliver_t)
+files_read_etc_runtime_files(dovecot_deliver_t)
+
+libs_use_ld_so(dovecot_deliver_t)
+libs_use_shared_libs(dovecot_deliver_t)
+
+miscfiles_read_localization(dovecot_deliver_t)
+
+optional_policy(`
+	mta_manage_spool(dovecot_deliver_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
