Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK2OI4029337
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:02:24 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EK2Ns2016547
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:23 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614200057.176682747@hp.com>
References: <20070614195502.420663549@hp.com>
Date: Thu, 14 Jun 2007 15:55:03 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/5] Use the netmsg initial SID for NetLabel connections
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch changes the policy to use the netmsg initial SID as the "base"
SID/context for NetLabel packets which only have MLS security attributes.
Currently we use the unlabeled initial SID which makes it very difficult to
distinquish between actual unlabeled packets and those packets which have MLS
security attributes.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/mls                              |    5 -
 policy/modules/kernel/corenetwork.if.in |  112 ++++++++++++++++++++++++++++++++
 policy/modules/kernel/corenetwork.te.in |    7 ++
 policy/modules/kernel/kernel.if         |   69 +++++++------------
 policy/modules/kernel/kernel.te         |    1 
 5 files changed, 149 insertions(+), 45 deletions(-)

Index: refpolicy_svn_repo/policy/mls
===================================================================
--- refpolicy_svn_repo.orig/policy/mls
+++ refpolicy_svn_repo/policy/mls
@@ -182,11 +182,12 @@ mlsconstrain { socket tcp_socket udp_soc
 	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsnetwrite ));
 
-# used by netlabel to restrict normal domains to same level connections
+# used by netlabel to restrict normal domains to same level connections unless the connection is unlabeled
 mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
 	(( l1 eq l2 ) or
 	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
-	 ( t1 == mlsnetread ));
+	 ( t1 == mlsnetread ) or
+	 ( t2 == unlabeled_t ));
 
 # these access vectors have no MLS restrictions
 # { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { ioctl create lock append bind sendto send_msg name_bind }
Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
+++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
@@ -1602,6 +1602,24 @@ interface(`corenet_dontaudit_non_ipsec_s
 ## </param>
 #
 interface(`corenet_tcp_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	allow $1 netlabel_peer_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive TCP packets from an unlabled connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_tcp_recv_unlabeled',`
 	kernel_tcp_recvfrom_unlabeled($1)
 ')
 
@@ -1617,6 +1635,25 @@ interface(`corenet_tcp_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_tcp_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	dontaudit $1 netlabel_peer_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive TCP packets from an unlabeled
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`corenet_dontaudit_tcp_recv_unlabeled',`
 	kernel_dontaudit_tcp_recvfrom_unlabeled($1)
 ')
 
@@ -1631,6 +1668,24 @@ interface(`corenet_dontaudit_tcp_recv_ne
 ## </param>
 #
 interface(`corenet_udp_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	allow $1 netlabel_peer_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive UDP packets from an unlabeled connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_udp_recv_unlabeled',`
 	kernel_udp_recvfrom_unlabeled($1)
 ')
 
@@ -1646,6 +1701,25 @@ interface(`corenet_udp_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_udp_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	dontaudit $1 netlabel_peer_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive UDP packets from an unlabeled
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`corenet_dontaudit_udp_recv_unlabeled',`
 	kernel_dontaudit_udp_recvfrom_unlabeled($1)
 ')
 
@@ -1660,6 +1734,24 @@ interface(`corenet_dontaudit_udp_recv_ne
 ## </param>
 #
 interface(`corenet_raw_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	allow $1 netlabel_peer_t:rawip_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive Raw IP packets from an unlabeled connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_raw_recv_unlabeled',`
 	kernel_raw_recvfrom_unlabeled($1)
 ')
 
@@ -1675,9 +1767,29 @@ interface(`corenet_raw_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_raw_recv_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	dontaudit $1 netlabel_peer_t:rawip_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive Raw IP packets from an unlabeled
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`corenet_dontaudit_raw_recv_unlabeled',`
 	kernel_dontaudit_raw_recvfrom_unlabeled($1)
 ')
 
+
 ########################################
 ## <summary>
 ##	Send generic client packets.
Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.te.in
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.te.in
+++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.te.in
@@ -37,6 +37,13 @@ dev_node(tun_tap_device_t)
 type client_packet_t, packet_type, client_packet_type;
 
 #
+# The netlabel_peer_t is used by the kernel's NetLabel subsystem for network
+# connections using NetLabel which do not carry full SELinux contexts.
+#
+type netlabel_peer_t;
+sid netmsg		gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
+
+#
 # port_t is the default type of INET port numbers.
 #
 type port_t, port_type;
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
@@ -2198,17 +2198,14 @@ interface(`kernel_dontaudit_sendrecv_unl
 
 ########################################
 ## <summary>
-##      Receive TCP packets from a NetLabel connection.
+##      Receive TCP packets from an unlabeled connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Receive TCP packets from a NetLabel connection, NetLabel is an
-##      explicit packet labeling framework which implements CIPSO and
-##      similar protocols.
+##      Receive TCP packets from an unlabeled connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_tcp_recv_netlabel() should
+##	The corenetwork interface corenet_tcp_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2228,19 +2225,17 @@ interface(`kernel_tcp_recvfrom_unlabeled
 
 ########################################
 ## <summary>
-##      Do not audit attempts to receive TCP packets from a NetLabel
-##      connection.
+##      Do not audit attempts to receive TCP packets from an unlabeled
+##	connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Do not audit attempts to receive TCP packets from a NetLabel
-##      connection.  NetLabel is an explicit packet labeling framework
-##      which implements CIPSO and similar protocols.
+##      Do not audit attempts to receive TCP packets from an unlabeled
+##	connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_tcp_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_tcp_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
@@ -2259,17 +2254,14 @@ interface(`kernel_dontaudit_tcp_recvfrom
 
 ########################################
 ## <summary>
-##      Receive UDP packets from a NetLabel connection.
+##      Receive UDP packets from an unlabeled connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Receive UDP packets from a NetLabel connection, NetLabel is an
-##      explicit packet labeling framework which implements CIPSO and
-##      similar protocols.
+##      Receive UDP packets from an unlabeled connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_udp_recv_netlabel() should
+##	The corenetwork interface corenet_udp_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2289,19 +2281,17 @@ interface(`kernel_udp_recvfrom_unlabeled
 
 ########################################
 ## <summary>
-##      Do not audit attempts to receive UDP packets from a NetLabel
-##      connection.
+##      Do not audit attempts to receive UDP packets from an unlabeled
+##	connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Do not audit attempts to receive UDP packets from a NetLabel
-##      connection.  NetLabel is an explicit packet labeling framework
-##      which implements CIPSO and similar protocols.
+##      Do not audit attempts to receive UDP packets from an unlabeled
+##	connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_udp_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_udp_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
@@ -2320,17 +2310,14 @@ interface(`kernel_dontaudit_udp_recvfrom
 
 ########################################
 ## <summary>
-##      Receive Raw IP packets from a NetLabel connection.
+##      Receive Raw IP packets from an unlabeled connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Receive Raw IP packets from a NetLabel connection, NetLabel is an
-##      explicit packet labeling framework which implements CIPSO and
-##      similar protocols.
+##      Receive Raw IP packets from an unlabeled connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_raw_recv_netlabel() should
+##	The corenetwork interface corenet_raw_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2350,19 +2337,17 @@ interface(`kernel_raw_recvfrom_unlabeled
 
 ########################################
 ## <summary>
-##      Do not audit attempts to receive Raw IP packets from a NetLabel
-##      connection.
+##      Do not audit attempts to receive Raw IP packets from an unlabeled
+##	connection.
 ## </summary>
 ## <desc>
 ##	<p>
-##      Do not audit attempts to receive Raw IP packets from a NetLabel
-##      connection.  NetLabel is an explicit packet labeling framework
-##      which implements CIPSO and similar protocols.
+##      Do not audit attempts to receive Raw IP packets from an unlabeled
+##	connection.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_raw_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_raw_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
@@ -153,7 +153,6 @@ sid icmp_socket		gen_context(system_u:ob
 sid igmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
 sid init		gen_context(system_u:object_r:unlabeled_t,s0)
 sid kmod		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
-sid netmsg		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
 sid policy		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
 sid scmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
 sid sysctl_modprobe 	gen_context(system_u:object_r:unlabeled_t,s0)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
