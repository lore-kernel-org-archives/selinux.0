Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JWU4J019278
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:32:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JWTOD024070
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:32:29 GMT
Date: Thu, 2 Aug 2007 15:32:26 -0400
Message-Id: <200708021932.l72JWQ6L028688@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_apcupsd changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Lots of fixes to get apcupd working
Has a cgi interface

--- nsaserefpolicy/policy/modules/services/apcupsd.fc	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apcupsd.fc	2007-08-02 15:30:16.000000000 -0400
@@ -5,5 +5,11 @@
 /usr/sbin/apcupsd		--	gen_context(system_u:object_r:apcupsd_exec_t,s0)
 
 /var/log/apcupsd\.events.*	--	gen_context(system_u:object_r:apcupsd_log_t,s0)
+/var/log/apcupsd\.status.*	--	gen_context(system_u:object_r:apcupsd_log_t,s0)
 
 /var/run/apcupsd\.pid		--	gen_context(system_u:object_r:apcupsd_var_run_t,s0)
+
+/var/www/apcupsd/multimon.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsfstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsimage.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/apcupsd.if	2007-05-30 11:47:29.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apcupsd.if	2007-08-02 11:02:02.000000000 -0400
@@ -79,3 +79,25 @@
 	allow $1 apcupsd_log_t:dir list_dir_perms;
 	allow $1 apcupsd_log_t:file { getattr append };
 ')
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
--- nsaserefpolicy/policy/modules/services/apcupsd.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/apcupsd.te	2007-08-02 11:02:02.000000000 -0400
@@ -16,6 +16,9 @@
 type apcupsd_log_t;
 logging_log_file(apcupsd_log_t)
 
+type apcupsd_tmp_t;
+files_tmp_file(apcupsd_tmp_t)
+
 type apcupsd_var_run_t;
 files_pid_file(apcupsd_var_run_t)
 
@@ -24,6 +27,7 @@
 # apcupsd local policy
 #
 
+allow apcupsd_t self:capability { dac_override setgid sys_tty_config };
 allow apcupsd_t self:process signal;
 allow apcupsd_t self:fifo_file rw_file_perms;
 allow apcupsd_t self:unix_stream_socket create_stream_socket_perms;
@@ -36,9 +40,15 @@
 manage_files_pattern(apcupsd_t,apcupsd_log_t,apcupsd_log_t)
 logging_log_filetrans(apcupsd_t,apcupsd_log_t,{ file dir })
 
+manage_files_pattern(apcupsd_t,apcupsd_tmp_t,apcupsd_tmp_t)
+files_tmp_filetrans(apcupsd_t,apcupsd_tmp_t,file)
+
 manage_files_pattern(apcupsd_t,apcupsd_var_run_t,apcupsd_var_run_t)
 files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)
 
+corecmd_exec_bin(apcupsd_t)
+corecmd_exec_shell(apcupsd_t)
+
 corenet_all_recvfrom_unlabeled(apcupsd_t)
 corenet_all_recvfrom_netlabel(apcupsd_t)
 corenet_tcp_sendrecv_generic_if(apcupsd_t)
@@ -47,6 +57,7 @@
 corenet_tcp_bind_all_nodes(apcupsd_t)
 corenet_tcp_bind_apcupsd_port(apcupsd_t)
 corenet_sendrecv_apcupsd_server_packets(apcupsd_t)
+corenet_tcp_connect_apcupsd_port(apcupsd_t)
 
 dev_rw_generic_usb_dev(apcupsd_t)
 
@@ -55,6 +66,15 @@
 
 files_read_etc_files(apcupsd_t)
 files_search_locks(apcupsd_t)
+# Creates /etc/nologin
+files_manage_etc_runtime_files(apcupsd_t)
+files_etc_filetrans_etc_runtime(apcupsd_t,file)
+
+#apcupsd runs shutdown, probably need a shutdown domain
+init_rw_utmp(apcupsd_t)
+init_telinit(apcupsd_t)
+
+kernel_read_system_state(apcupsd_t)
 
 libs_use_ld_so(apcupsd_t)
 libs_use_shared_libs(apcupsd_t)
@@ -62,3 +82,41 @@
 logging_send_syslog_msg(apcupsd_t)
 
 miscfiles_read_localization(apcupsd_t)
+
+# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=240805
+term_use_unallocated_ttys(apcupsd_t)
+
+userdom_use_unpriv_users_ttys(apcupsd_t)
+userdom_use_unpriv_users_ptys(apcupsd_t)
+
+optional_policy(`
+	hostname_exec(apcupsd_t)
+')
+
+optional_policy(`
+	mta_send_mail(apcupsd_t)
+')
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
+corenet_all_recvfrom_unlabeled(httpd_apcupsd_cgi_script_t)
+corenet_all_recvfrom_netlabel(httpd_apcupsd_cgi_script_t)
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
