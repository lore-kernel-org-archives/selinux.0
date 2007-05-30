Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbtdi014370
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbr2p008428
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:53 GMT
Date: Wed, 30 May 2007 10:26:26 -0400
Message-Id: <200705301426.l4UEQQWL007814@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: rpcbind policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/rpcbind.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/rpcbind.fc	2007-05-30 09:08:15.000000000 -0400
@@ -0,0 +1,6 @@
+
+/sbin/rpcbind		--	gen_context(system_u:object_r:rpcbind_exec_t,s0)
+/var/run/rpcbind.lock		--	gen_context(system_u:object_r:rpcbind_var_run_t,s0)
+/var/run/rpc.statd.pid		--	gen_context(system_u:object_r:rpcbind_var_run_t,s0)
+/var/run/rpcbind.sock		-s	gen_context(system_u:object_r:rpcbind_var_run_t,s0)
+/var/lib/rpcbind(/.*)?			gen_context(system_u:object_r:rpcbind_var_lib_t,s0)
--- nsaserefpolicy/policy/modules/services/rpcbind.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/rpcbind.if	2007-05-30 09:08:15.000000000 -0400
@@ -0,0 +1,104 @@
+
+## <summary>policy for rpcbind</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run rpcbind.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`rpcbind_domtrans',`
+	gen_require(`
+		type rpcbind_t, rpcbind_exec_t;
+	')
+
+	domain_auto_trans($1,rpcbind_exec_t,rpcbind_t)
+
+	allow rpcbind_t $1:fd use;
+	allow rpcbind_t $1:fifo_file rw_file_perms;
+	allow rpcbind_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Read rpcbind PID files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rpcbind_read_pid_files',`
+	gen_require(`
+		type rpcbind_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 rpcbind_var_run_t:file r_file_perms;
+')
+
+
+########################################
+## <summary>
+##	Search rpcbind lib directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rpcbind_search_lib',`
+	gen_require(`
+		type rpcbind_var_lib_t;
+	')
+
+	allow $1 rpcbind_var_lib_t:dir search_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	Read rpcbind lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rpcbind_read_lib_files',`
+	gen_require(`
+		type rpcbind_var_lib_t;
+	')
+
+	allow $1 rpcbind_var_lib_t:file r_file_perms;
+	allow $1 rpcbind_var_lib_t:dir list_dir_perms;
+	files_search_var_lib($1)
+')
+
+########################################
+## <summary>
+##	Create, read, write, and delete
+##	rpcbind lib files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rpcbind_manage_lib_files',`
+	gen_require(`
+		type rpcbind_var_lib_t;
+	')
+
+	allow $1 rpcbind_var_lib_t:file manage_file_perms;
+	allow $1 rpcbind_var_lib_t:dir rw_dir_perms;
+	files_search_var_lib($1)
+')
--- nsaserefpolicy/policy/modules/services/rpcbind.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/services/rpcbind.te	2007-05-30 09:08:15.000000000 -0400
@@ -0,0 +1,79 @@
+policy_module(rpcbind,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type rpcbind_t;
+type rpcbind_exec_t;
+domain_type(rpcbind_t)
+init_daemon_domain(rpcbind_t, rpcbind_exec_t)
+
+# pid files
+type rpcbind_var_run_t;
+files_pid_file(rpcbind_var_run_t)
+
+# var/lib files
+type rpcbind_var_lib_t;
+files_type(rpcbind_var_lib_t)
+
+########################################
+#
+# rpcbind local policy
+#
+
+# Init script handling
+init_use_fds(rpcbind_t)
+init_use_script_ptys(rpcbind_t)
+domain_use_interactive_fds(rpcbind_t)
+
+allow rpcbind_t self:capability setuid;
+allow rpcbind_t self:netlink_route_socket r_netlink_socket_perms;
+allow rpcbind_t self:udp_socket listen;
+allow rpcbind_t self:tcp_socket create_stream_socket_perms;
+allow rpcbind_t self:fifo_file rw_file_perms;
+allow rpcbind_t self:unix_stream_socket create_stream_socket_perms;
+
+# pid file
+allow rpcbind_t rpcbind_var_run_t:file manage_file_perms;
+allow rpcbind_t rpcbind_var_run_t:sock_file manage_sock_file_perms;
+allow rpcbind_t rpcbind_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(rpcbind_t,rpcbind_var_run_t, { file sock_file })
+
+# var/lib files for rpcbind
+allow rpcbind_t rpcbind_var_lib_t:file manage_file_perms;
+allow rpcbind_t rpcbind_var_lib_t:sock_file manage_sock_file_perms;
+allow rpcbind_t rpcbind_var_lib_t:dir manage_dir_perms;
+files_var_lib_filetrans(rpcbind_t,rpcbind_var_lib_t, { file dir sock_file })
+
+corenet_non_ipsec_sendrecv(rpcbind_t)
+corenet_tcp_sendrecv_all_if(rpcbind_t)
+corenet_tcp_sendrecv_all_nodes(rpcbind_t)
+corenet_tcp_sendrecv_all_ports(rpcbind_t)
+corenet_tcp_bind_all_nodes(rpcbind_t)
+corenet_tcp_bind_portmap_port(rpcbind_t)
+
+allow rpcbind_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_all_if(rpcbind_t)
+corenet_udp_sendrecv_all_nodes(rpcbind_t)
+corenet_udp_sendrecv_all_ports(rpcbind_t)
+corenet_udp_bind_all_nodes(rpcbind_t)
+corenet_udp_bind_portmap_port(rpcbind_t)
+corenet_udp_bind_all_rpc_ports(rpcbind_t)
+
+files_read_etc_files(rpcbind_t)
+
+kernel_read_network_state(rpcbind_t)
+
+libs_use_ld_so(rpcbind_t)
+libs_use_shared_libs(rpcbind_t)
+
+logging_send_syslog_msg(rpcbind_t)
+
+miscfiles_read_localization(rpcbind_t)
+
+sysnet_dns_name_resolve(rpcbind_t)
+
+
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
