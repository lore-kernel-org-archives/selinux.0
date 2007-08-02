Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Kkeq4026415
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:46:40 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KkcTm008105
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:46:39 GMT
Date: Thu, 2 Aug 2007 16:45:36 -0400
Message-Id: <200708022045.l72Kja8D032754@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_openvpn changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add interfaces for openvpn to be run by users
Wants to read users directories

--- nsaserefpolicy/policy/modules/services/openvpn.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/openvpn.if	2007-08-02 11:02:02.000000000 -0400
@@ -22,3 +22,71 @@
 	read_files_pattern($1,openvpn_etc_t,openvpn_etc_t)
 	read_lnk_files_pattern($1,openvpn_etc_t,openvpn_etc_t)
 ')
+
+########################################
+## <summary>
+##	Execute OPENVPN clients in the openvpn domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`openvpn_domtrans',`
+	gen_require(`
+		type openvpn_t, openvpn_exec_t;
+	')
+
+	domtrans_pattern($1,openvpn_exec_t,openvpn_t)
+')
+
+########################################
+## <summary>
+##	Execute OPENVPN clients in the openvpn domain, and
+##	allow the specified role the openvpn domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the openvpn domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the openvpn domain to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`openvpn_run',`
+	gen_require(`
+		type openvpn_t;
+	')
+
+	openvpn_domtrans($1)
+	role $2 types openvpn_t;
+	allow openvpn_t $3:chr_file rw_term_perms;
+')
+
+########################################
+## <summary>
+##	Send generic signals to OPENVPN clients.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`openvpn_signal',`
+	gen_require(`
+		type openvpn_t;
+	')
+
+	allow $1 openvpn_t:process signal;
+')
--- nsaserefpolicy/policy/modules/services/openvpn.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/openvpn.te	2007-08-02 11:02:02.000000000 -0400
@@ -6,6 +6,13 @@
 # Declarations
 #
 
+## <desc>
+## <p>
+## Allow openvpn to read home directories
+## </p>
+## </desc>
+gen_tunable(openvpn_enable_homedirs,false)
+
 # main openvpn domain
 type openvpn_t;
 type openvpn_exec_t;
@@ -28,7 +35,9 @@
 # openvpn local policy
 #
 
-allow openvpn_t self:capability { net_bind_service net_admin setgid setuid sys_tty_config };
+allow openvpn_t self:capability { dac_read_search dac_override net_bind_service net_admin setgid setuid sys_tty_config };
+allow openvpn_t self:process { signal getsched };
+
 allow openvpn_t self:unix_dgram_socket { create_socket_perms sendto };
 allow openvpn_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow openvpn_t self:udp_socket create_socket_perms;
@@ -42,8 +51,8 @@
 allow openvpn_t openvpn_var_log_t:file manage_file_perms;
 logging_log_filetrans(openvpn_t,openvpn_var_log_t,file)
 
-allow openvpn_t openvpn_var_run_t:file manage_file_perms;
-files_pid_filetrans(openvpn_t, openvpn_var_run_t, file)
+manage_files_pattern(openvpn_t,openvpn_var_run_t,openvpn_var_run_t)
+files_pid_filetrans(openvpn_t, openvpn_var_run_t, { file dir })
 
 kernel_read_kernel_sysctls(openvpn_t)
 kernel_read_net_sysctls(openvpn_t)
@@ -67,6 +76,7 @@
 corenet_udp_bind_openvpn_port(openvpn_t)
 corenet_sendrecv_openvpn_server_packets(openvpn_t)
 corenet_rw_tun_tap_dev(openvpn_t)
+corenet_tcp_connect_openvpn_port(openvpn_t)
 
 dev_search_sysfs(openvpn_t)
 dev_read_rand(openvpn_t)
@@ -81,10 +91,31 @@
 logging_send_syslog_msg(openvpn_t)
 
 miscfiles_read_localization(openvpn_t)
+miscfiles_read_certs(openvpn_t)
 
 sysnet_dns_name_resolve(openvpn_t)
 sysnet_exec_ifconfig(openvpn_t)
 
+tunable_policy(`openvpn_enable_homedirs',`
+	userdom_read_unpriv_users_home_content_files(openvpn_t)
+')
+
 optional_policy(`
 	daemontools_service_domain(openvpn_t,openvpn_exec_t)
 ')
+
+optional_policy(`
+	dbus_system_bus_client_template(openvpn,openvpn_t)
+	dbus_connect_system_bus(openvpn_t)
+	dbus_send_system_bus(openvpn_t)
+	networkmanager_dbus_chat(openvpn_t)
+')
+
+
+# Need to interact with terminals if config option "auth-user-pass" is used
+userdom_use_sysadm_terms(openvpn_t)
+
+optional_policy(`
+	unconfined_use_terminals(openvpn_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
