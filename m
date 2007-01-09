Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l090bHIR013916
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:37:17 -0500
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l090c5bm015189
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 00:38:05 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l090axKq025833
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:36:59 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l090c59l378182
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:38:05 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l090c4uX031701
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:38:05 -0700
Date: Mon, 8 Jan 2007 18:23:35 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701090023.l090NZOq017600@faith.austin.ibm.com>
To: redhat-lspp@redhat.com
Subject: [PATCH 3/3]: labeled ipsec policy
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -urpN serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.fc serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.fc
--- serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.fc	2007-01-05 10:47:48.000000000 -0600
+++ serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.fc	2007-01-08 14:48:59.000000000 -0600
@@ -7,7 +7,7 @@
 
 /etc/ipsec\.d(/.*)?			gen_context(system_u:object_r:ipsec_key_file_t,s0)
 
-/sbin/setkey			--	gen_context(system_u:object_r:ipsec_exec_t,s0)
+/sbin/setkey			--	gen_context(system_u:object_r:setkey_exec_t,s0)
 
 /usr/lib(64)?/ipsec/_plutoload	-- 	gen_context(system_u:object_r:ipsec_mgmt_exec_t,s0)
 /usr/lib(64)?/ipsec/_plutorun	--	gen_context(system_u:object_r:ipsec_mgmt_exec_t,s0)
@@ -26,8 +26,7 @@
 /usr/local/lib(64)?/ipsec/pluto --	gen_context(system_u:object_r:ipsec_exec_t,s0)
 /usr/local/lib(64)?/ipsec/spi	--	gen_context(system_u:object_r:ipsec_exec_t,s0)
 
-/usr/sbin/racoon		--	gen_context(system_u:object_r:ipsec_exec_t,s0)
-/usr/sbin/setkey		--	gen_context(system_u:object_r:ipsec_exec_t,s0)
+/usr/sbin/racoon		--	gen_context(system_u:object_r:racoon_exec_t,s0)
 
 /var/racoon(/.*)?			gen_context(system_u:object_r:ipsec_var_run_t,s0)
 
diff -urpN serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.if serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.if
--- serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.if	2007-01-05 10:47:48.000000000 -0600
+++ serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.if	2007-01-08 14:48:59.000000000 -0600
@@ -138,3 +138,83 @@ interface(`ipsec_labeled',`
 	allow $1 ipsec_spd_t:association polmatch;
 	allow $1 self:association { sendto recvfrom };
 ')
+
+########################################
+## <summary>
+##	Execute racoon in the racoon domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_racoon_domtrans',`
+	gen_require(`
+		type racoon_t, racoon_exec_t;
+	')
+
+	domain_auto_trans($1,racoon_exec_t,racoon_t)
+
+	allow $1 racoon_t:fd use;
+	allow racoon_t $1:fd use;
+	allow racoon_t $1:fifo_file rw_file_perms;
+	allow racoon_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute setkey in the setkey domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_setkey_domtrans',`
+	gen_require(`
+		type setkey_t, setkey_exec_t;
+	')
+	domain_auto_trans($1,setkey_exec_t,setkey_t)
+
+	allow $1 setkey_t:fd use;
+	allow setkey_t $1:fd use;
+	allow setkey_t $1:fifo_file rw_file_perms;
+	allow setkey_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute ipsec-tools in the setkey and racoon domains
+##	and allow the specified role the domains.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the racoon and setkey domains.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the racoon and setkey domains to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`ipsec_tools_run',`
+	gen_require(`
+		type racoon_t, setkey_t;
+	')
+	ipsec_racoon_domtrans($1)
+	role $2 types racoon_t;
+	allow racoon_t $3:chr_file rw_term_perms;
+	
+	ipsec_setkey_domtrans($1)
+	role $2 types setkey_t;
+	allow setkey_t $3:chr_file rw_term_perms;
+')
diff -urpN serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.te serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.te
--- serefpolicy-2.4.6.patch2/policy/modules/system/ipsec.te	2007-01-05 10:47:48.000000000 -0600
+++ serefpolicy-2.4.6.patch3/policy/modules/system/ipsec.te	2007-01-08 14:48:58.000000000 -0600
@@ -35,9 +35,19 @@ files_lock_file(ipsec_mgmt_lock_t)
 type ipsec_mgmt_var_run_t;
 files_pid_file(ipsec_mgmt_var_run_t)
 
+#### types for ipsec-tools utilities  #####
 # default type for ipsec-tools ipsec policy
 type ipsec_spd_t;
 
+type racoon_t;
+type racoon_exec_t;
+init_daemon_domain(racoon_t,racoon_exec_t)
+role system_r types racoon_t;
+
+type setkey_t;
+type setkey_exec_t;
+init_system_domain(setkey_t,setkey_exec_t)
+role system_r types setkey_t;
 
 ########################################
 #
@@ -276,3 +286,99 @@ file_type_auto_trans(ipsec_mgmt_t, sysad
 
 allow ipsec_mgmt_t dev_fs:file_class_set getattr;
 ') dnl end TODO
+
+
+########################################
+#
+# ipsec-tools utilities <setkey>
+#
+
+# allow setkey to set the context for ipsec SAs and policy.
+allow setkey_t ipsec_spd_t:association setcontext;
+
+allow setkey_t self:capability net_admin;
+allow setkey_t self:key_socket { create read setopt write };
+allow setkey_t self:netlink_route_socket { create_netlink_socket_perms };
+
+# need to be able to read selinux config files within setkey domain.
+allow setkey_t security_t:dir search;
+allow setkey_t security_t:file read;
+seutil_read_config(setkey_t)
+
+# allow setkey utility to set contexts on SA's and policy
+domain_setcontext(setkey_t)
+
+# allow setkey to read a config files in any directory.
+userdom_read_sysadm_home_content_files(setkey_t)
+userdom_read_all_users_home_content_files(setkey_t)
+
+# setkey will be run by sysadm, thus setkey needs access to sysadm ttys.
+userdom_use_sysadm_ttys(setkey_t)
+locallogin_use_fds(setkey_t)
+files_read_etc_files(setkey_t)
+libs_use_ld_so(setkey_t)
+libs_use_shared_libs(setkey_t)
+miscfiles_read_localization(setkey_t)
+
+########################################
+#
+# ipsec-tools utilities <racoon>
+#
+
+allow racoon_t self:udp_socket { create_socket_perms };
+allow racoon_t self:unix_dgram_socket { connect create ioctl write };
+allow racoon_t self:capability { net_admin net_bind_service };
+
+# allow racoon to use avc_has_perm to check context on proposed SA
+allow racoon_t self:netlink_selinux_socket { bind create read };
+selinux_compute_access_vector(racoon_t)
+
+allow racoon_t self:key_socket { create read setopt write };
+allow racoon_t self:netlink_route_socket { create_netlink_socket_perms };
+
+allow racoon_t node_t:udp_socket node_bind;
+
+# so racoon can listen on admin port.
+allow racoon_t inaddr_any_node_t:tcp_socket node_bind;
+
+# allow racoon to use ISAKMP port
+allow racoon_t isakmp_port_t:udp_socket name_bind;
+
+corenet_non_ipsec_sendrecv(racoon_t)
+corenet_udp_bind_link_local_node(racoon_t)
+corenet_udp_bind_compat_ipv4_node(racoon_t)
+corenet_udp_bind_lo_node(racoon_t)
+kernel_read_network_state(racoon_t)
+corenet_udp_bind_site_local_node(racoon_t)
+seutil_read_config(setkey_t)
+
+# manage pid file
+allow racoon_t ipsec_var_run_t:file manage_file_perms;
+allow racoon_t ipsec_var_run_t:dir rw_dir_perms;
+allow racoon_t ipsec_var_run_t:sock_file create_file_perms;
+files_pid_filetrans(racoon_t,ipsec_var_run_t,file)
+files_rw_generic_pids(racoon_t)
+allow racoon_t var_run_t:file setattr;
+
+allow racoon_t ipsec_conf_file_t:dir r_dir_perms;
+allow racoon_t ipsec_conf_file_t:file r_file_perms;
+allow racoon_t ipsec_conf_file_t:lnk_file r_file_perms;
+
+allow racoon_t ipsec_key_file_t:dir r_dir_perms;
+allow racoon_t ipsec_key_file_t:file r_file_perms;
+allow racoon_t ipsec_key_file_t:lnk_file r_file_perms;
+
+allow racoon_t ipsec_spd_t:association setcontext;
+
+userdom_use_sysadm_ttys(racoon_t)
+locallogin_use_fds(racoon_t)
+
+# allow racoon to set contexts on ipsec policy and SAs
+domain_setcontext(racoon_t)
+
+logging_send_syslog_msg(racoon_t)
+files_read_etc_files(racoon_t)
+libs_use_ld_so(racoon_t)
+libs_use_shared_libs(racoon_t)
+miscfiles_read_localization(racoon_t)
+dev_read_urand(racoon_t)
diff -urpN serefpolicy-2.4.6.patch2/policy/modules/system/userdomain.te serefpolicy-2.4.6.patch3/policy/modules/system/userdomain.te
--- serefpolicy-2.4.6.patch2/policy/modules/system/userdomain.te	2007-01-05 10:47:48.000000000 -0600
+++ serefpolicy-2.4.6.patch3/policy/modules/system/userdomain.te	2007-01-08 17:21:59.000000000 -0600
@@ -275,6 +275,8 @@ ifdef(`strict_policy',`
 		ipsec_stream_connect(sysadm_t)
 		# for lsof
 		ipsec_getattr_key_sockets(sysadm_t)
+		ipsec_tools_run(sysadm_t,sysadm_r,admin_terminal)
+		ipsec_labeled(sysadm_t)
 	')
 
 	optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
