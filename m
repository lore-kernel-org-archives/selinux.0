Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Cc6CZ012069
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:38:06 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cbxpq014373
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:38:00 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id CBC9226E
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:38:02 +0200 (CEST)
Message-Id: <20080804123735.852335004@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:04 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 08/35] logging policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Most changes here seem uncontroversial. Note that the logging_admin_audit
and logging_admin_syslog interfaces are not currently used in the
refpolicy so changing their signature shouldn't be a problem.

Originally submitted Jul 19, no comments so far

Index: refpolicy/policy/modules/system/logging.fc
===================================================================
--- refpolicy.orig/policy/modules/system/logging.fc	2008-08-03 13:09:37.000000000 +0200
+++ refpolicy/policy/modules/system/logging.fc	2008-08-03 17:14:08.000000000 +0200
@@ -4,6 +4,8 @@
 /etc/syslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)
 /etc/audit(/.*)?		gen_context(system_u:object_r:auditd_etc_t,mls_systemhigh)
 
+/sbin/audispd		--	gen_context(system_u:object_r:audisp_exec_t,s0)
+/sbin/audisp-remote	--	gen_context(system_u:object_r:audisp_remote_exec_t,s0)
 /sbin/auditctl		--	gen_context(system_u:object_r:auditctl_exec_t,s0)
 /sbin/auditd		--	gen_context(system_u:object_r:auditd_exec_t,s0)
 /sbin/klogd		--	gen_context(system_u:object_r:klogd_exec_t,s0)
@@ -20,6 +22,7 @@
 /usr/sbin/syslog-ng	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 /usr/sbin/syslogd	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
 
+/var/lib/syslog-ng(/.*)? 	gen_context(system_u:object_r:syslogd_var_lib_t,s0)
 /var/lib/syslog-ng.persist --	gen_context(system_u:object_r:syslogd_var_lib_t,s0)
 
 ifdef(`distro_suse', `
@@ -37,7 +40,7 @@
 /var/log/maillog[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
 /var/log/spooler[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
 /var/log/audit(/.*)?		gen_context(system_u:object_r:auditd_log_t,mls_systemhigh)
-/var/log/syslog-ng(/.*)? --	gen_context(system_u:object_r:syslogd_var_run_t,s0)
+/var/log/syslog-ng(/.*)? 	gen_context(system_u:object_r:syslogd_var_run_t,s0)
 
 ifndef(`distro_gentoo',`
 /var/log/audit\.log	--	gen_context(system_u:object_r:auditd_log_t,mls_systemhigh)
@@ -48,7 +51,7 @@
 ')
 
 /var/run/audit_events	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
-/var/run/audispd_events	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
+/var/run/audispd_events	-s	gen_context(system_u:object_r:audisp_var_run_t,s0)
 /var/run/auditd\.pid	--	gen_context(system_u:object_r:auditd_var_run_t,s0)
 /var/run/auditd_sock	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
 /var/run/klogd\.pid	--	gen_context(system_u:object_r:klogd_var_run_t,s0)
@@ -59,3 +62,8 @@
 /var/spool/postfix/pid	-d	gen_context(system_u:object_r:var_run_t,s0)
 
 /var/tinydns/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
+
+/etc/rc\.d/init\.d/rsyslog	--	gen_context(system_u:object_r:syslogd_script_exec_t,s0)
+/etc/rc\.d/init\.d/auditd	--	gen_context(system_u:object_r:auditd_script_exec_t,s0)
+
+/var/cfengine/outputs(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
Index: refpolicy/policy/modules/system/logging.if
===================================================================
--- refpolicy.orig/policy/modules/system/logging.if	2008-08-03 13:09:37.000000000 +0200
+++ refpolicy/policy/modules/system/logging.if	2008-08-03 17:14:08.000000000 +0200
@@ -213,12 +213,7 @@
 ## </param>
 #
 interface(`logging_stream_connect_auditd',`
-	gen_require(`
-		type auditd_t, auditd_var_run_t;
-	')
-
-	files_search_pids($1)
-	stream_connect_pattern($1,auditd_var_run_t,auditd_var_run_t,auditd_t)
+	logging_stream_connect_audisp($1)
 ')
 
 ########################################
@@ -530,8 +525,27 @@
 	')
 
 	files_search_var($1)
-	allow $1 var_log_t:dir list_dir_perms;
-	allow $1 logfile:file { getattr append };
+	append_files_pattern($1, var_log_t, logfile)
+')
+
+########################################
+## <summary>
+##	read/write to all log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_rw_all_logs',`
+	gen_require(`
+		attribute logfile;
+		type var_log_t;
+	')
+
+	files_search_var($1)
+	rw_files_pattern($1, var_log_t, logfile)
 ')
 
 ########################################
@@ -596,6 +610,8 @@
 	files_search_var($1)
 	manage_files_pattern($1,logfile,logfile)
 	read_lnk_files_pattern($1,logfile,logfile)
+	allow $1 logfile:dir  { relabelfrom relabelto };
+	allow $1 logfile:file  { relabelfrom relabelto };
 ')
 
 ########################################
@@ -641,6 +657,25 @@
 
 ########################################
 ## <summary>
+##	Dontaudit Write generic log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_dontaudit_write_generic_logs',`
+	gen_require(`
+		type var_log_t;
+	')
+
+	files_search_var($1)
+	dontaudit $1 var_log_t:file write;
+')
+
+########################################
+## <summary>
 ##	Read and write generic log files.
 ## </summary>
 ## <param name="domain">
@@ -695,6 +730,7 @@
 interface(`logging_admin_audit',`
 	gen_require(`
 		type auditd_t, auditd_etc_t, auditd_log_t;
+		type auditd_script_exec_t;
 		type auditd_var_run_t;
 	')
 
@@ -709,6 +745,15 @@
 
 	manage_dirs_pattern($1, auditd_var_run_t, auditd_var_run_t)
 	manage_files_pattern($1, auditd_var_run_t, auditd_var_run_t)
+
+	logging_run_auditctl($1, $2, $3)
+
+	# Allow $1 to restart the audit service
+	logging_audit_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 auditd_script_exec_t system_r;
+	allow $2 system_r;
+
 ')
 
 ########################################
@@ -729,6 +774,7 @@
 		type syslogd_tmp_t, syslogd_var_lib_t;
 		type syslogd_var_run_t, klogd_var_run_t;
 		type klogd_tmp_t, var_log_t;
+		type syslogd_script_exec_t;
 	')
 
 	allow $1 syslogd_t:process { ptrace signal_perms };
@@ -756,6 +802,12 @@
 	manage_files_pattern($1, syslogd_var_run_t, syslogd_var_run_t)
 
 	logging_manage_all_logs($1)
+
+	# Allow $1 to restart the syslog service
+	logging_syslog_script_domtrans($1)
+	domain_system_change_exemption($1)
+	role_transition $2 syslogd_script_exec_t system_r;
+	allow $2 system_r;
 ')
 
 ########################################
@@ -771,6 +823,132 @@
 ## <rolecap/>
 #
 interface(`logging_admin',`
-	logging_admin_audit($1)
-	logging_admin_syslog($1)
+	logging_admin_audit($1, $2, $3)
+	logging_admin_syslog($1, $2, $3)
+')
+
+########################################
+## <summary>
+##	Execute syslog server in the syslogd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`logging_syslog_script_domtrans',`
+	gen_require(`
+		type syslogd_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,syslogd_script_exec_t)
+')
+
+########################################
+## <summary>
+##	Execute audit server in the auditd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`logging_audit_script_domtrans',`
+	gen_require(`
+		type auditd_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,auditd_script_exec_t)
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run audisp.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`logging_domtrans_audisp',`
+	gen_require(`
+		type audisp_t;
+                type audisp_exec_t;
+	')
+
+	domtrans_pattern($1,audisp_exec_t,audisp_t)
+')
+
+########################################
+## <summary>
+##	Signal the audisp domain.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`logging_audisp_signal',`
+	gen_require(`
+		type audisp_t;
+	')
+
+	allow $1 audisp_t:process signal;
+')
+
+########################################
+## <summary>
+##	Create a domain for processes
+##	which can be started by the system audisp
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used as a domain.
+##	</summary>
+## </param>
+## <param name="entry_point">
+##	<summary>
+##	Type of the program to be used as an entry point to this domain.
+##	</summary>
+## </param>
+#
+interface(`logging_audisp_system_domain',`
+	gen_require(`
+		type audisp_t;
+		role system_r;
+	')
+
+	domain_type($1)
+	domain_entry_file($1,$2)
+
+	role system_r types $1;
+
+	domtrans_pattern(audisp_t,$2,$1)
+	allow $1 audisp_t:process signal;
+
+	allow audisp_t $2:file getattr;
+	allow $1 audisp_t:unix_stream_socket rw_socket_perms;
+')
+
+########################################
+## <summary>
+##	Connect to auditdstored over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_stream_connect_audisp',`
+	gen_require(`
+		type audisp_t, audisp_var_run_t;
+	')
+
+	files_search_pids($1)
+	stream_connect_pattern($1,audisp_var_run_t,audisp_var_run_t,audisp_t)
 ')
Index: refpolicy/policy/modules/system/logging.te
===================================================================
--- refpolicy.orig/policy/modules/system/logging.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/system/logging.te	2008-08-03 17:14:41.000000000 +0200
@@ -61,10 +61,29 @@
 logging_log_file(var_log_t)
 files_mountpoint(var_log_t)
 
+type auditd_script_exec_t;
+init_script_type(auditd_script_exec_t)
+
+type syslogd_script_exec_t;
+init_script_type(syslogd_script_exec_t)
+
 ifdef(`enable_mls',`
 	init_ranged_daemon_domain(auditd_t,auditd_exec_t,mls_systemhigh)
+	init_ranged_daemon_domain(syslogd_t,syslogd_exec_t,mls_systemhigh)
 ')
 
+type audisp_t;
+type audisp_exec_t;
+init_system_domain(audisp_t, audisp_exec_t)
+
+type audisp_var_run_t;
+files_pid_file(audisp_var_run_t)
+
+type audisp_remote_t;
+type audisp_remote_exec_t;
+domain_type(audisp_remote_t)
+domain_entry_file(audisp_remote_t, audisp_remote_exec_t)
+
 ########################################
 #
 # Auditctl local policy
@@ -84,6 +103,7 @@
 kernel_read_kernel_sysctls(auditctl_t)
 kernel_read_proc_symlinks(auditctl_t)
 
+
 domain_read_all_domains_state(auditctl_t)
 domain_use_interactive_fds(auditctl_t)
 
@@ -158,11 +178,13 @@
 
 mls_file_read_all_levels(auditd_t)
 mls_file_write_all_levels(auditd_t) # Need to be able to write to /var/run/ directory
+mls_fd_use_all_levels(auditd_t)
 
 seutil_dontaudit_read_config(auditd_t)
 
-userdom_dontaudit_use_unpriv_user_fds(auditd_t)
+sysnet_dns_name_resolve(auditd_t)
 
+userdom_dontaudit_use_unpriv_user_fds(auditd_t)
 sysadm_dontaudit_search_home_dirs(auditd_t)
 
 ifdef(`distro_ubuntu',`
@@ -172,6 +194,10 @@
 ')
 
 optional_policy(`
+	mta_send_mail(auditd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(auditd_t)
 ')
 
@@ -209,6 +235,7 @@
 
 fs_getattr_all_fs(klogd_t)
 fs_search_auto_mountpoints(klogd_t)
+fs_search_tmpfs(klogd_t)
 
 domain_use_interactive_fds(klogd_t)
 
@@ -253,7 +280,6 @@
 dontaudit syslogd_t self:capability sys_tty_config;
 # setpgid for metalog
 allow syslogd_t self:process { signal_perms setpgid };
-allow syslogd_t self:netlink_route_socket r_netlink_socket_perms;
 # receive messages to be logged
 allow syslogd_t self:unix_dgram_socket create_socket_perms;
 allow syslogd_t self:unix_stream_socket create_stream_socket_perms;
@@ -275,6 +301,9 @@
 # Allow access for syslog-ng
 allow syslogd_t var_log_t:dir { create setattr };
 
+mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
+mls_fd_use_all_levels(syslogd_t)
+
 # manage temporary files
 manage_dirs_pattern(syslogd_t,syslogd_tmp_t,syslogd_tmp_t)
 manage_files_pattern(syslogd_t,syslogd_tmp_t,syslogd_tmp_t)
@@ -290,12 +319,14 @@
 manage_files_pattern(syslogd_t,syslogd_var_run_t,syslogd_var_run_t)
 files_pid_filetrans(syslogd_t,syslogd_var_run_t,file)
 
+kernel_read_system_state(syslogd_t)
 kernel_read_kernel_sysctls(syslogd_t)
 kernel_read_proc_symlinks(syslogd_t)
 # Allow access to /proc/kmsg for syslog-ng
 kernel_read_messages(syslogd_t)
 kernel_clear_ring_buffer(syslogd_t)
 kernel_change_ring_buffer_level(syslogd_t)
+files_read_kernel_symbol_table(syslogd_t)
 
 dev_filetrans(syslogd_t,devlog_t,sock_file)
 dev_read_sysfs(syslogd_t)
@@ -328,6 +359,8 @@
 # Allow users to define additional syslog ports to connect to
 corenet_tcp_bind_syslogd_port(syslogd_t)
 corenet_tcp_connect_syslogd_port(syslogd_t)
+corenet_tcp_connect_postgresql_port(syslogd_t)
+corenet_tcp_connect_mysqld_port(syslogd_t)
 
 # syslog-ng can send or receive logs
 corenet_sendrecv_syslogd_client_packets(syslogd_t)
@@ -340,23 +373,23 @@
 domain_use_interactive_fds(syslogd_t)
 
 files_read_etc_files(syslogd_t)
+files_read_usr_files(syslogd_t)
 files_read_var_files(syslogd_t)
 files_read_etc_runtime_files(syslogd_t)
 # /initrd is not umounted before minilog starts
 files_dontaudit_search_isid_type_dirs(syslogd_t)
 
+auth_use_nsswitch(syslogd_t)
+
 libs_use_ld_so(syslogd_t)
 libs_use_shared_libs(syslogd_t)
 
 # cjp: this doesnt make sense
 logging_send_syslog_msg(syslogd_t)
 
-sysnet_read_config(syslogd_t)
-
 miscfiles_read_localization(syslogd_t)
 
 userdom_dontaudit_use_unpriv_user_fds(syslogd_t)
-
 sysadm_dontaudit_search_home_dirs(syslogd_t)
 
 ifdef(`distro_gentoo',`
@@ -382,15 +415,11 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(syslogd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(syslogd_t)
+	seutil_sigchld_newrole(syslogd_t)
 ')
 
 optional_policy(`
-	seutil_sigchld_newrole(syslogd_t)
+	postgresql_stream_connect(syslogd_t)
 ')
 
 optional_policy(`
@@ -401,3 +430,67 @@
 	# log to the xconsole
 	xserver_rw_console(syslogd_t)
 ')
+
+########################################
+#
+# audisp local policy
+#
+
+# Init script handling
+domain_use_interactive_fds(audisp_t)
+
+allow audisp_t self:capability sys_nice;
+allow audisp_t self:process setsched;
+
+## internal communication is often done using fifo and unix sockets.
+allow audisp_t self:fifo_file rw_file_perms;
+allow audisp_t self:unix_stream_socket create_stream_socket_perms;
+allow audisp_t auditd_t:unix_stream_socket rw_file_perms;
+
+manage_sock_files_pattern(audisp_t, audisp_var_run_t, audisp_var_run_t)
+files_pid_filetrans(audisp_t, audisp_var_run_t, sock_file)
+
+files_read_etc_files(audisp_t)
+
+libs_use_ld_so(audisp_t)
+libs_use_shared_libs(audisp_t)
+
+logging_send_syslog_msg(audisp_t)
+
+miscfiles_read_localization(audisp_t)
+
+mls_file_write_all_levels(audisp_t)
+
+corecmd_search_bin(audisp_t)
+allow audisp_t self:unix_dgram_socket create_socket_perms;
+
+logging_domtrans_audisp(auditd_t)
+logging_audisp_signal(auditd_t)
+
+########################################
+#
+# audisp_remote local policy
+#
+
+logging_audisp_system_domain(audisp_remote_t, audisp_remote_exec_t)
+
+allow audisp_remote_t self:tcp_socket create_socket_perms;
+
+corenet_all_recvfrom_unlabeled(audisp_remote_t)
+corenet_all_recvfrom_netlabel(audisp_remote_t)
+corenet_tcp_sendrecv_all_if(audisp_remote_t)
+corenet_tcp_sendrecv_all_nodes(audisp_remote_t)
+corenet_tcp_connect_audit_port(audisp_remote_t)
+
+files_read_etc_files(audisp_remote_t)
+
+libs_use_ld_so(audisp_remote_t)
+libs_use_shared_libs(audisp_remote_t)
+
+logging_send_syslog_msg(audisp_remote_t)
+logging_audisp_system_domain(audisp_remote_t, audisp_remote_exec_t)
+
+miscfiles_read_localization(audisp_remote_t)
+
+sysnet_dns_name_resolve(audisp_remote_t)
+

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
