Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57LBhEP009926
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 17:11:43 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l57LBgIa015368
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 21:11:42 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070607205808.935275285@hp.com>
Date: Thu, 07 Jun 2007 16:58:02 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, dwalsh@redhat.com
Subject: [RFC] use the netmsg initial SID for NetLabel connections
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a simple RFC patch for the Reference Policy to go along with the
proposed NetLabel kernel changes to use the netmsg initial SID, the kernel
change thread can be found here:

 * http://marc.info/?t=117394234100037&r=1&w=2

The basic idea is that NetLabel would use the netmsg initial SID as the
base/TE context for MLS-only connections and the unlabeled SID for
connections that did not have have security attributes at all, true
unlabeled connections.  The reason for doing this would be to enable us
to allow/disallow unlabeled NetLabel traffic on a per-domain basis;
something that is not easily possible with the current approach of using
the unlabeled SID as the base/TE context for MLS-only connections.

I don't consider the changes below to be complete, there would still need
to be changes to all of the user and application domains, but I want to
start a conversation on the "right" way to do this.  Chris, Dan, I'm
especially interested in what the two of you have to say.

FYI: This _really_ is a RFC patch, I haven't even compile tested it, I'm
just using it as a starting point for the conversation.

---
 policy/mls                              |    5 
 policy/modules/kernel/corenetwork.if.in |   88 ++++++++++++++
 policy/modules/kernel/kernel.if         |  194 +++++++++++++++++++++++++++++---
 policy/modules/kernel/kernel.te         |    8 +
 4 files changed, 276 insertions(+), 19 deletions(-)

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
@@ -1602,6 +1602,20 @@ interface(`corenet_dontaudit_non_ipsec_s
 ## </param>
 #
 interface(`corenet_tcp_recv_netlabel',`
+	kernel_tcp_recvfrom_netlabel($1)
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
 
@@ -1617,6 +1631,21 @@ interface(`corenet_tcp_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_tcp_recv_netlabel',`
+	kernel_dontaudit_tcp_recvfrom_netlabel($1)
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
 
@@ -1631,6 +1660,20 @@ interface(`corenet_dontaudit_tcp_recv_ne
 ## </param>
 #
 interface(`corenet_udp_recv_netlabel',`
+	kernel_udp_recvfrom_netlabel($1)
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
 
@@ -1646,6 +1689,21 @@ interface(`corenet_udp_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_udp_recv_netlabel',`
+	kernel_dontaudit_udp_recvfrom_netlabel($1)
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
 
@@ -1660,6 +1718,20 @@ interface(`corenet_dontaudit_udp_recv_ne
 ## </param>
 #
 interface(`corenet_raw_recv_netlabel',`
+	kernel_raw_recvfrom_netlabel($1)
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
 
@@ -1675,9 +1747,25 @@ interface(`corenet_raw_recv_netlabel',`
 ## </param>
 #
 interface(`corenet_dontaudit_raw_recv_netlabel',`
+	kernel_dontaudit_raw_recvfrom_netlabel($1)
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
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
@@ -2207,8 +2207,34 @@ interface(`kernel_dontaudit_sendrecv_unl
 ##      similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_tcp_recv_netlabel() should
+##	The corenetwork interface corenet_tcp_recv_netlabel() should
+##	be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_tcp_recvfrom_netlabel',`
+	gen_require(`
+		type netlabel_peer_t;
+	')
+
+	allow $1 netlabel_peer_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive TCP packets from an unlabeled connection.
+## </summary>
+## <desc>
+##	<p>
+##      Receive TCP packets from an unlabeled connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_tcp_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2238,9 +2264,37 @@ interface(`kernel_tcp_recvfrom_unlabeled
 ##      which implements CIPSO and similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_tcp_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_tcp_recv_netlabel()
+##      should be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_tcp_recvfrom_netlabel',`
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
+##	connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive TCP packets from an unlabeled
+##	connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_dontaudit_tcp_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
@@ -2268,8 +2322,34 @@ interface(`kernel_dontaudit_tcp_recvfrom
 ##      similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_udp_recv_netlabel() should
+##	The corenetwork interface corenet_udp_recv_netlabel() should
+##	be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_udp_recvfrom_netlabel',`
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
+## <desc>
+##	<p>
+##      Receive UDP packets from an unlabeled connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_udp_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2299,9 +2379,37 @@ interface(`kernel_udp_recvfrom_unlabeled
 ##      which implements CIPSO and similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_udp_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_udp_recv_netlabel()
+##	should be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_udp_recvfrom_netlabel',`
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
+##	connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive UDP packets from an unlabeled
+##	connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_dontaudit_udp_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
@@ -2329,8 +2437,34 @@ interface(`kernel_dontaudit_udp_recvfrom
 ##      similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_raw_recv_netlabel() should
+##	The corenetwork interface corenet_raw_recv_netlabel() should be
+##	used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_raw_recvfrom_netlabel',`
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
+## <desc>
+##	<p>
+##      Receive Raw IP packets from an unlabeled connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_raw_recv_unlabeled() should
 ##	be used instead of this one.
 ##	</p>
 ## </desc>
@@ -2345,7 +2479,7 @@ interface(`kernel_raw_recvfrom_unlabeled
 		type unlabeled_t;
 	')
 
-	allow $1 unlabeled_t:rawip_socket recvfrom;
+	allow $1 unlabeled_t:raw_socket recvfrom;
 ')
 
 ########################################
@@ -2360,9 +2494,37 @@ interface(`kernel_raw_recvfrom_unlabeled
 ##      which implements CIPSO and similar protocols.
 ##      </p>
 ##	<p>
-##	The corenetwork interface
-##	corenet_dontaudit_raw_recv_netlabel() should
-##	be used instead of this one.
+##	The corenetwork interface corenet_dontaudit_raw_recv_netlabel()
+##	should be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_raw_recvfrom_netlabel',`
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
+##	connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive Raw IP packets from an unlabeled
+##	connection.
+##      </p>
+##	<p>
+##	The corenetwork interface corenet_dontaudit_raw_recv_unlabeled()
+##	should be used instead of this one.
 ##	</p>
 ## </desc>
 ## <param name="domain">
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
@@ -139,6 +139,13 @@ type sysctl_dev_t, sysctl_type;
 genfscon proc /sys/dev gen_context(system_u:object_r:sysctl_dev_t,s0)
 
 #
+# The netmsg inital SID is used by the kernel's NetLabel subsystem for network
+# connections which do not carry full SELinux contexts.
+#
+type netlabel_peer_t;
+sid netmsg		gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
+
+#
 # unlabeled_t is the type of unlabeled objects.
 # Objects that have no known labeling information or that
 # have labels that are no longer valid are treated as having this type.
@@ -153,7 +160,6 @@ sid icmp_socket		gen_context(system_u:ob
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
