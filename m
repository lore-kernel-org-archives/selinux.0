Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KnSO8026797
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:49:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KnOTm008875
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:49:24 GMT
Date: Thu, 2 Aug 2007 16:48:53 -0400
Message-Id: <200708022048.l72Kmr7I000377@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_nis changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix paths
yp daemons need to bind to any port between 600-1024
ypbind talks dbus

--- nsaserefpolicy/policy/modules/services/nis.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/nis.fc	2007-08-02 11:02:02.000000000 -0400
@@ -4,6 +4,7 @@
 /sbin/ypbind		--	gen_context(system_u:object_r:ypbind_exec_t,s0)
 
 /usr/lib/yp/ypxfr	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
+/usr/lib64/yp/ypxfr	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
 
 /usr/sbin/rpc\.yppasswdd --	gen_context(system_u:object_r:yppasswdd_exec_t,s0)
 /usr/sbin/rpc\.ypxfrd	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/nis.if	2007-07-03 07:06:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/nis.if	2007-08-02 11:02:02.000000000 -0400
@@ -49,8 +49,8 @@
 	corenet_udp_bind_all_nodes($1)
 	corenet_tcp_bind_generic_port($1)
 	corenet_udp_bind_generic_port($1)
-	corenet_tcp_bind_reserved_port($1)
-	corenet_udp_bind_reserved_port($1)
+	corenet_dontaudit_tcp_bind_all_reserved_ports($1)
+	corenet_dontaudit_udp_bind_all_reserved_ports($1)
 	corenet_dontaudit_tcp_bind_all_ports($1)
 	corenet_dontaudit_udp_bind_all_ports($1)
 	corenet_tcp_connect_portmap_port($1)
--- nsaserefpolicy/policy/modules/services/nis.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/nis.te	2007-08-02 11:02:02.000000000 -0400
@@ -113,6 +113,14 @@
 userdom_dontaudit_use_unpriv_user_fds(ypbind_t)
 userdom_dontaudit_search_sysadm_home_dirs(ypbind_t)
 
+
+optional_policy(`
+	dbus_system_bus_client_template(ypbind,ypbind_t)
+	dbus_connect_system_bus(ypbind_t)
+	dbus_send_system_bus(ypbind_t)
+	init_dbus_chat_script(ypbind_t)
+')
+
 optional_policy(`
 	seutil_sigchld_newrole(ypbind_t)
 ')
@@ -126,6 +134,7 @@
 # yppasswdd local policy
 #
 
+allow yppasswdd_t self:capability dac_override;
 dontaudit yppasswdd_t self:capability sys_tty_config;
 allow yppasswdd_t self:fifo_file rw_fifo_file_perms;
 allow yppasswdd_t self:process { setfscreate signal_perms };
@@ -156,8 +165,8 @@
 corenet_udp_sendrecv_all_ports(yppasswdd_t)
 corenet_tcp_bind_all_nodes(yppasswdd_t)
 corenet_udp_bind_all_nodes(yppasswdd_t)
-corenet_tcp_bind_reserved_port(yppasswdd_t)
-corenet_udp_bind_reserved_port(yppasswdd_t)
+corenet_tcp_bind_all_rpc_ports(yppasswdd_t)
+corenet_udp_bind_all_rpc_ports(yppasswdd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(yppasswdd_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(yppasswdd_t)
 corenet_sendrecv_generic_server_packets(yppasswdd_t)
@@ -247,6 +256,8 @@
 corenet_udp_bind_all_nodes(ypserv_t)
 corenet_tcp_bind_reserved_port(ypserv_t)
 corenet_udp_bind_reserved_port(ypserv_t)
+corenet_tcp_bind_all_rpc_ports(ypserv_t)
+corenet_udp_bind_all_rpc_ports(ypserv_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(ypserv_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(ypserv_t)
 corenet_sendrecv_generic_server_packets(ypserv_t)
@@ -315,6 +326,8 @@
 corenet_udp_bind_all_nodes(ypxfr_t)
 corenet_tcp_bind_reserved_port(ypxfr_t)
 corenet_udp_bind_reserved_port(ypxfr_t)
+corenet_tcp_bind_all_rpc_ports(ypxfr_t)
+corenet_udp_bind_all_rpc_ports(ypxfr_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(ypxfr_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(ypxfr_t)
 corenet_tcp_connect_all_ports(ypxfr_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
