Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbeB7014306
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:40 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbd2p008398
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:39 GMT
Date: Wed, 30 May 2007 10:42:57 -0400
Message-Id: <200705301442.l4UEgvZP008075@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Cron needs many changes to run on MLS
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

proper path on 64 bit ypxfr
nis domains should use rpc_ports not reserved ports
ypbind is now a dbus client

--- nsaserefpolicy/policy/modules/services/nis.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/nis.fc	2007-05-30 09:08:15.000000000 -0400
@@ -4,6 +4,7 @@
 /sbin/ypbind		--	gen_context(system_u:object_r:ypbind_exec_t,s0)
 
 /usr/lib/yp/ypxfr	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
+/usr/lib64/yp/ypxfr	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
 
 /usr/sbin/rpc\.yppasswdd --	gen_context(system_u:object_r:yppasswdd_exec_t,s0)
 /usr/sbin/rpc\.ypxfrd	--	gen_context(system_u:object_r:ypxfr_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/nis.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/nis.if	2007-05-30 09:08:15.000000000 -0400
@@ -48,8 +48,8 @@
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
--- nsaserefpolicy/policy/modules/services/nis.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/nis.te	2007-05-30 09:08:15.000000000 -0400
@@ -112,6 +112,14 @@
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
@@ -244,6 +253,8 @@
 corenet_udp_bind_all_nodes(ypserv_t)
 corenet_tcp_bind_reserved_port(ypserv_t)
 corenet_udp_bind_reserved_port(ypserv_t)
+corenet_tcp_bind_all_rpc_ports(ypserv_t)
+corenet_udp_bind_all_rpc_ports(ypserv_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(ypserv_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(ypserv_t)
 corenet_sendrecv_generic_server_packets(ypserv_t)
@@ -311,6 +323,8 @@
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
