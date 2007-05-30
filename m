Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaq5u013754
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHao2p008206
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:11:17 -0400
Message-Id: <200705301511.l4UFBHQ3010316@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apcupsd policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/apcupsd.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/apcupsd.fc	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,10 @@
+/usr/sbin/apcupsd		--	gen_context(system_u:object_r:apcupsd_exec_t,s0)
+
+/var/log/apcupsd\.events.*	--	gen_context(system_u:object_r:apcupsd_log_t,s0)
+
+/var/run/apcupsd\.pid		--	gen_context(system_u:object_r:apcupsd_var_run_t,s0)
+
+/var/www/apcupsd/multimon.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsfstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsimage.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/apcupsd.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/apcupsd.if	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,103 @@
+## <summary>APC UPS monitoring daemon</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run apcupsd.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`apcupsd_domtrans',`
+	gen_require(`
+		type apcupsd_t, apcupsd_exec_t;
+	')
+
+	domtrans_pattern($1,apcupsd_exec_t,apcupsd_t)
+')
+
+########################################
+## <summary>
+##	Read apcupsd PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apcupsd_read_pid_files',`
+	gen_require(`
+		type apcupsd_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 apcupsd_var_run_t:file read_file_perms;
+')
+
+
+########################################
+## <summary>
+##	Allow the specified domain to read apcupsd's log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`apcupsd_read_log',`
+	gen_require(`
+		type apcupsd_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 apcupsd_log_t:dir list_dir_perms;
+	allow $1 apcupsd_log_t:file { read getattr lock };
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to append
+##	apcupsd log files.
+## </summary>
+## <param name="domain">
+## 	<summary>
+##	Domain allowed to transition.
+## 	</summary>
+## </param>
+#
+interface(`apcupsd_append_log',`
+	gen_require(`
+		type var_log_t, apcupsd_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 apcupsd_log_t:dir list_dir_perms;
+	allow $1 apcupsd_log_t:file { getattr append };
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run httpd_apcupsd_cgi_script.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`httpd_apcupsd_cgi_script_domtrans',`
+	gen_require(`
+		type httpd_apcupsd_cgi_script_t, httpd_apcupsd_cgi_script_exec_t;
+	')
+
+	domain_auto_trans($1,httpd_apcupsd_cgi_script_exec_t,httpd_apcupsd_cgi_script_t)
+
+	allow httpd_apcupsd_cgi_script_t $1:fd use;
+	allow httpd_apcupsd_cgi_script_t $1:fifo_file rw_file_perms;
+	allow httpd_apcupsd_cgi_script_t $1:process sigchld;
+')
--- nsaserefpolicy/policy/modules/services/apcupsd.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/apcupsd.te	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,89 @@
+
+policy_module(apcupsd,1.0.1)
+
+########################################
+#
+# Declarations
+#
+
+type apcupsd_t;
+type apcupsd_exec_t;
+init_daemon_domain(apcupsd_t, apcupsd_exec_t)
+
+type apcupsd_lock_t;
+files_lock_file(apcupsd_lock_t)
+
+type apcupsd_log_t;
+logging_log_file(apcupsd_log_t)
+
+type apcupsd_var_run_t;
+files_pid_file(apcupsd_var_run_t)
+
+########################################
+#
+# apcupsd local policy
+#
+
+allow apcupsd_t self:process signal;
+allow apcupsd_t self:fifo_file rw_file_perms;
+allow apcupsd_t self:unix_stream_socket create_stream_socket_perms;
+allow apcupsd_t self:tcp_socket create_stream_socket_perms;
+
+allow apcupsd_t apcupsd_lock_t:file manage_file_perms;
+files_lock_filetrans(apcupsd_t,apcupsd_lock_t,file)
+
+allow apcupsd_t apcupsd_log_t:dir setattr;
+manage_files_pattern(apcupsd_t,apcupsd_log_t,apcupsd_log_t)
+logging_log_filetrans(apcupsd_t,apcupsd_log_t,{ file dir })
+
+manage_files_pattern(apcupsd_t,apcupsd_var_run_t,apcupsd_var_run_t)
+files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)
+
+corenet_non_ipsec_sendrecv(apcupsd_t)
+corenet_tcp_sendrecv_generic_if(apcupsd_t)
+corenet_tcp_sendrecv_all_nodes(apcupsd_t)
+corenet_tcp_sendrecv_all_ports(apcupsd_t)
+corenet_tcp_bind_all_nodes(apcupsd_t)
+corenet_tcp_bind_apcupsd_port(apcupsd_t)
+corenet_sendrecv_apcupsd_server_packets(apcupsd_t)
+
+dev_rw_generic_usb_dev(apcupsd_t)
+
+# Init script handling
+domain_use_interactive_fds(apcupsd_t)
+
+files_read_etc_files(apcupsd_t)
+files_search_locks(apcupsd_t)
+
+libs_use_ld_so(apcupsd_t)
+libs_use_shared_libs(apcupsd_t)
+
+logging_send_syslog_msg(apcupsd_t)
+
+miscfiles_read_localization(apcupsd_t)
+
+# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=240805
+term_use_unallocated_ttys(apcupsd_t)
+
+########################################
+#
+# apcupsd_cgi Declarations
+#
+
+apache_content_template(apcupsd_cgi)
+
+# Default Networking
+sysnet_dns_name_resolve(httpd_apcupsd_cgi_script_t)
+corenet_non_ipsec_sendrecv(httpd_apcupsd_cgi_script_t)
+
+allow httpd_apcupsd_cgi_script_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
+corenet_tcp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
+corenet_tcp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
+corenet_tcp_connect_apcupsd_port(httpd_apcupsd_cgi_script_t)
+
+allow httpd_apcupsd_cgi_script_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
+corenet_udp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
+corenet_udp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
