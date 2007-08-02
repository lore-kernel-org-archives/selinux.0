Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KftlZ025593
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:41:55 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KfrTm007119
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:41:53 GMT
Date: Thu, 2 Aug 2007 16:41:50 -0400
Message-Id: <200708022041.l72KfokQ032620@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_rpc changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Many fixes for rpcbind

--- nsaserefpolicy/policy/modules/services/rpcbind.te	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rpcbind.te	2007-08-02 11:02:02.000000000 -0400
@@ -21,11 +21,13 @@
 # rpcbind local policy
 #
 
-allow rpcbind_t self:capability setuid;
+allow rpcbind_t self:capability { setuid sys_tty_config };
 allow rpcbind_t self:fifo_file rw_file_perms;
 allow rpcbind_t self:unix_stream_socket create_stream_socket_perms;
 allow rpcbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow rpcbind_t self:udp_socket create_socket_perms;
+# BROKEN ...
+dontaudit rpcbind_t self:udp_socket listen;
 allow rpcbind_t self:tcp_socket create_stream_socket_perms;
 
 manage_files_pattern(rpcbind_t,rpcbind_var_run_t,rpcbind_var_run_t)
--- nsaserefpolicy/policy/modules/services/rpc.if	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rpc.if	2007-08-02 11:02:02.000000000 -0400
@@ -81,6 +81,7 @@
 	corenet_tcp_bind_all_nodes($1_t)
 	corenet_udp_bind_all_nodes($1_t)
 	corenet_tcp_bind_reserved_port($1_t)
+	corenet_tcp_bind_reserved_port($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_portmap_client_packets($1_t)
 	# do not log when it tries to bind to a port belonging to another domain
@@ -89,8 +90,11 @@
 	# bind to arbitary unused ports
 	corenet_tcp_bind_generic_port($1_t)
 	corenet_udp_bind_generic_port($1_t)
-	corenet_udp_bind_reserved_port($1_t)
+	corenet_dontaudit_tcp_bind_all_ports($1_t)
+	corenet_dontaudit_udp_bind_all_ports($1_t)
 	corenet_sendrecv_generic_server_packets($1_t)
+	corenet_tcp_bind_all_rpc_ports($1_t)
+	corenet_udp_bind_all_rpc_ports($1_t)
 
 	fs_rw_rpc_named_pipes($1_t) 
 	fs_search_auto_mountpoints($1_t)
--- nsaserefpolicy/policy/modules/services/rpc.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rpc.te	2007-08-02 11:02:02.000000000 -0400
@@ -59,10 +59,14 @@
 manage_files_pattern(rpcd_t,rpcd_var_run_t,rpcd_var_run_t)
 files_pid_filetrans(rpcd_t,rpcd_var_run_t,file)
 
+corecmd_exec_bin(rpcd_t)
+
 kernel_read_system_state(rpcd_t) 
 kernel_search_network_state(rpcd_t) 
 # for rpc.rquotad
 kernel_read_sysctl(rpcd_t)  
+kernel_read_fs_sysctls(rpcd_t)  
+kernel_getattr_core_if(nfsd_t)
 
 fs_list_rpc(rpcd_t)
 fs_read_rpc_files(rpcd_t)
@@ -76,9 +80,11 @@
 miscfiles_read_certs(rpcd_t)
 
 seutil_dontaudit_search_config(rpcd_t)
+selinux_dontaudit_read_fs(rpcd_t)
 
 optional_policy(`
 	nis_read_ypserv_config(rpcd_t)
+	nis_use_ypbind(rpcd_t)
 ')
 
 ########################################
@@ -91,9 +97,13 @@
 allow nfsd_t exports_t:file { getattr read };
 allow nfsd_t { nfsd_rw_t nfsd_ro_t }:dir list_dir_perms;
 
+dev_dontaudit_getattr_all_blk_files(nfsd_t) 
+dev_dontaudit_getattr_all_chr_files(nfsd_t) 
+
 # for /proc/fs/nfs/exports - should we have a new type?
 kernel_read_system_state(nfsd_t) 
 kernel_read_network_state(nfsd_t) 
+kernel_dontaudit_getattr_core_if(nfsd_t) 
 
 corenet_tcp_bind_all_rpc_ports(nfsd_t)
 corenet_udp_bind_all_rpc_ports(nfsd_t)
@@ -123,6 +133,7 @@
 tunable_policy(`nfs_export_all_rw',`
 	fs_read_noxattr_fs_files(nfsd_t) 
 	auth_manage_all_files_except_shadow(nfsd_t)
+	userdom_generic_user_home_dir_filetrans_generic_user_home_content(nfsd_t, { file dir })
 ')
 
 tunable_policy(`nfs_export_all_ro',`
@@ -143,6 +154,8 @@
 manage_files_pattern(gssd_t,gssd_tmp_t,gssd_tmp_t)
 files_tmp_filetrans(gssd_t, gssd_tmp_t, { file dir })
 
+auth_use_nsswitch(gssd_t)
+
 kernel_read_network_state(gssd_t)
 kernel_read_network_state_symlinks(gssd_t)	
 kernel_search_network_sysctl(gssd_t)	
@@ -158,6 +171,11 @@
 
 miscfiles_read_certs(gssd_t)
 
+ifdef(`targeted_policy',`
+	# Manage the users kerberos tgt file
+	files_manage_generic_tmp_files(gssd_t) 
+')
+
 tunable_policy(`allow_gssd_read_tmp',`
 	userdom_list_unpriv_users_tmp(gssd_t) 
 	userdom_read_unpriv_users_tmp_files(gssd_t) 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
