Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QIiheG030451
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 13:44:43 -0500
Received: from g4t0014.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QIigQG003793
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:42 GMT
Received: from g4t0014.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id CFDB52413F
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:05 +0000 (UTC)
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id CC7E224031
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:05 +0000 (UTC)
Message-Id: <20080226184404.862575664@hp.com>
References: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:33 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/5] REFPOL: Add new labeled networking permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The 2.6.25 kernel will introduce a new set of labeled networking controls to
SELinux and this patch makes the necessary changes to the Reference Policy
to support unlabeled network traffic with the new controls.

A description of the new/improved labeled networking controls was posted to
the SELinux list back in early January 2008.

 * http://marc.info/?l=selinux&m=119991234501200&w=2

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/kernel/corenetwork.if.in |   69 +++++++++++++++++++++++---------
 policy/modules/kernel/corenetwork.if.m4 |   20 ++++-----
 policy/modules/kernel/kernel.if         |   30 +++++++++++++
 policy/modules/kernel/kernel.te         |    3 +
 4 files changed, 94 insertions(+), 28 deletions(-)

Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
+++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
@@ -154,7 +154,7 @@ interface(`corenet_tcp_sendrecv_generic_
 		type netif_t;
 	')
 
-	allow $1 netif_t:netif { tcp_send tcp_recv };
+	allow $1 netif_t:netif { tcp_send tcp_recv egress ingress };
 ')
 
 ########################################
@@ -172,7 +172,7 @@ interface(`corenet_udp_send_generic_if',
 		type netif_t;
 	')
 
-	allow $1 netif_t:netif udp_send;
+	allow $1 netif_t:netif { udp_send egress };
 ')
 
 ########################################
@@ -191,7 +191,7 @@ interface(`corenet_dontaudit_udp_send_ge
 		type netif_t;
 	')
 
-	dontaudit $1 netif_t:netif udp_send;
+	dontaudit $1 netif_t:netif { udp_send egress };
 ')
 
 ########################################
@@ -209,7 +209,7 @@ interface(`corenet_udp_receive_generic_i
 		type netif_t;
 	')
 
-	allow $1 netif_t:netif udp_recv;
+	allow $1 netif_t:netif { udp_recv ingress };
 ')
 
 ########################################
@@ -228,7 +228,7 @@ interface(`corenet_dontaudit_udp_receive
 		type netif_t;
 	')
 
-	dontaudit $1 netif_t:netif udp_recv;
+	dontaudit $1 netif_t:netif { udp_recv ingress };
 ')
 
 ########################################
@@ -277,7 +277,7 @@ interface(`corenet_raw_send_generic_if',
 		type netif_t;
 	')
 
-	allow $1 netif_t:netif rawip_send;
+	allow $1 netif_t:netif { rawip_send egress };
 ')
 
 ########################################
@@ -295,7 +295,7 @@ interface(`corenet_raw_receive_generic_i
 		type netif_t;
 	')
 
-	allow $1 netif_t:netif rawip_recv;
+	allow $1 netif_t:netif { rawip_recv ingress };
 ')
 
 ########################################
@@ -448,7 +448,7 @@ interface(`corenet_tcp_sendrecv_generic_
 		type node_t;
 	')
 
-	allow $1 node_t:node { tcp_send tcp_recv };
+	allow $1 node_t:node { tcp_send tcp_recv sendto recvfrom };
 ')
 
 ########################################
@@ -466,7 +466,7 @@ interface(`corenet_udp_send_generic_node
 		type node_t;
 	')
 
-	allow $1 node_t:node udp_send;
+	allow $1 node_t:node { udp_send sendto };
 ')
 
 ########################################
@@ -484,7 +484,7 @@ interface(`corenet_udp_receive_generic_n
 		type node_t;
 	')
 
-	allow $1 node_t:node udp_recv;
+	allow $1 node_t:node { udp_recv recvfrom };
 ')
 
 ########################################
@@ -517,7 +517,7 @@ interface(`corenet_raw_send_generic_node
 		type node_t;
 	')
 
-	allow $1 node_t:node rawip_send;
+	allow $1 node_t:node { rawip_send sendto };
 ')
 
 ########################################
@@ -535,7 +535,7 @@ interface(`corenet_raw_receive_generic_n
 		type node_t;
 	')
 
-	allow $1 node_t:node rawip_recv;
+	allow $1 node_t:node { rawip_recv recvfrom };
 ')
 
 ########################################
@@ -1737,6 +1737,7 @@ interface(`corenet_tcp_recvfrom_netlabel
 		type netlabel_peer_t;
 	')
 
+	allow $1 netlabel_peer_t:peer recv;
 	allow $1 netlabel_peer_t:tcp_socket recvfrom;
 ')
 
@@ -1791,6 +1792,7 @@ interface(`corenet_dontaudit_tcp_recvfro
 		type netlabel_peer_t;
 	')
 
+	dontaudit $1 netlabel_peer_t:peer recv;
 	dontaudit $1 netlabel_peer_t:tcp_socket recvfrom;
 ')
 
@@ -1844,6 +1846,7 @@ interface(`corenet_udp_recvfrom_netlabel
 		type netlabel_peer_t;
 	')
 
+	allow $1 netlabel_peer_t:peer recv;
 	allow $1 netlabel_peer_t:udp_socket recvfrom;
 ')
 
@@ -1898,6 +1901,7 @@ interface(`corenet_dontaudit_udp_recvfro
 		type netlabel_peer_t;
 	')
 
+	dontaudit $1 netlabel_peer_t:peer recv;
 	dontaudit $1 netlabel_peer_t:udp_socket recvfrom;
 ')
 
@@ -1951,6 +1955,7 @@ interface(`corenet_raw_recvfrom_netlabel
 		type netlabel_peer_t;
 	')
 
+	allow $1 netlabel_peer_t:peer recv;
 	allow $1 netlabel_peer_t:rawip_socket recvfrom;
 ')
 
@@ -2005,6 +2010,7 @@ interface(`corenet_dontaudit_raw_recvfro
 		type netlabel_peer_t;
 	')
 
+	dontaudit $1 netlabel_peer_t:peer recv;
 	dontaudit $1 netlabel_peer_t:rawip_socket recvfrom;
 ')
 
@@ -2064,6 +2070,7 @@ interface(`corenet_all_recvfrom_netlabel
 		type netlabel_peer_t;
 	')
 
+	allow $1 netlabel_peer_t:peer recv;
 	allow $1 netlabel_peer_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
 ')
 
@@ -2104,6 +2111,7 @@ interface(`corenet_dontaudit_all_recvfro
 		type netlabel_peer_t;
 	')
 
+	dontaudit $1 netlabel_peer_t:peer recv;
 	dontaudit $1 netlabel_peer_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
 ')
 
@@ -2135,8 +2143,10 @@ interface(`corenet_tcp_recvfrom_labeled'
 	allow $1 $2:{ association tcp_socket } recvfrom;
 	allow $2 $1:{ association tcp_socket } recvfrom;
 
-	# Netlabel (CIPSO)-based labeled networking
-	# currently only supports MLS portion of label
+	allow $1 $2:peer recv;
+	allow $2 $1:peer recv;
+
+	# allow receiving packets from MLS-only peers using NetLabel
 	corenet_tcp_recvfrom_netlabel($1)
 	corenet_tcp_recvfrom_netlabel($2)
 ')
@@ -2160,8 +2170,9 @@ interface(`corenet_udp_recvfrom_labeled'
 	allow $2 self:association sendto;
 	allow $1 $2:{ association udp_socket } recvfrom;
 
-	# Netlabel (CIPSO)-based labeled networking
-	# currently only supports MLS portion of label
+	allow $1 $2:peer recv;
+
+	# allow receiving packets from MLS-only peers using NetLabel
 	corenet_udp_recvfrom_netlabel($1)
 ')
 
@@ -2184,8 +2195,9 @@ interface(`corenet_raw_recvfrom_labeled'
 	allow $2 self:association sendto;
 	allow $1 $2:{ association rawip_socket } recvfrom;
 
-	# Netlabel (CIPSO)-based labeled networking
-	# currently only supports MLS portion of label
+	allow $1 $2:peer recv;
+
+	# allow receiving packets from MLS-only peers using NetLabel
 	corenet_raw_recvfrom_netlabel($1)
 ')
 
@@ -2380,6 +2392,27 @@ interface(`corenet_sendrecv_unlabeled_pa
 
 ########################################
 ## <summary>
+##	Receive packets from an unlabeled peer.
+## </summary>
+## <desc>
+##	<p>
+##	Receive packets from an unlabeled peer,
+##      these packets do not have any peer labeling
+##      information present.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_recvfrom_unlabeled_peer',`
+	kernel_recvfrom_unlabeled_peer($1)
+')
+
+########################################
+## <summary>
 ##	Send all client packets.
 ## </summary>
 ## <param name="domain">
Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.m4
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.m4
+++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.m4
@@ -28,7 +28,7 @@ interface(`corenet_tcp_sendrecv_$1_if',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:netif { tcp_send tcp_recv };
+	allow dollarsone $1_$2:netif { tcp_send tcp_recv egress ingress };
 ')
 
 ########################################
@@ -47,7 +47,7 @@ interface(`corenet_udp_send_$1_if',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:netif udp_send;
+	allow dollarsone $1_$2:netif { udp_send egress };
 ')
 
 ########################################
@@ -66,7 +66,7 @@ interface(`corenet_udp_receive_$1_if',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:netif udp_recv;
+	allow dollarsone $1_$2:netif { udp_recv ingress };
 ')
 
 ########################################
@@ -101,7 +101,7 @@ interface(`corenet_raw_send_$1_if',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:netif rawip_send;
+	allow dollarsone $1_$2:netif { rawip_send egress };
 ')
 
 ########################################
@@ -120,7 +120,7 @@ interface(`corenet_raw_receive_$1_if',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:netif rawip_recv;
+	allow dollarsone $1_$2:netif { rawip_recv ingress };
 ')
 
 ########################################
@@ -163,7 +163,7 @@ interface(`corenet_tcp_sendrecv_$1_node'
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:node { tcp_send tcp_recv };
+	allow dollarsone $1_$2:node { tcp_send tcp_recv sendto recvfrom };
 ')
 
 ########################################
@@ -182,7 +182,7 @@ interface(`corenet_udp_send_$1_node',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:node udp_send;
+	allow dollarsone $1_$2:node { udp_send sendto };
 ')
 
 ########################################
@@ -201,7 +201,7 @@ interface(`corenet_udp_receive_$1_node',
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:node udp_recv;
+	allow dollarsone $1_$2:node { udp_recv recvfrom };
 ')
 
 ########################################
@@ -236,7 +236,7 @@ interface(`corenet_raw_send_$1_node',`
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:node rawip_send;
+	allow dollarsone $1_$2:node { rawip_send sendto };
 ')
 
 ########################################
@@ -255,7 +255,7 @@ interface(`corenet_raw_receive_$1_node',
 		$3 $1_$2;
 	')
 
-	allow dollarsone $1_$2:node rawip_recv;
+	allow dollarsone $1_$2:node { rawip_recv recvfrom };
 ')
 
 ########################################
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
@@ -2493,6 +2493,36 @@ interface(`kernel_sendrecv_unlabeled_pac
 
 ########################################
 ## <summary>
+##	Receive packets from an unlabeled peer.
+## </summary>
+## <desc>
+##	<p>
+##	Receive packets from an unlabeled peer,
+##      these packets do not have any peer labeling
+##      information present.
+##	</p>
+##	<p>
+##	The corenetwork interface
+##	corenet_recvfrom_unlabeled_peer() should
+##	be used instead of this one.
+##	</p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_recvfrom_unlabeled_peer',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:peer recv;
+')
+
+########################################
+## <summary>
 ##	Unconfined access to kernel module resources.
 ## </summary>
 ## <param name="domain">
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
@@ -212,6 +212,9 @@ allow kernel_t unlabeled_t:dir mounton;
 # connections with invalidated labels:
 allow kernel_t unlabeled_t:packet send;
 
+# Forwarded traffic
+allow unlabeled_t unlabeled_t:packet { forward_in forward_out };
+
 corenet_all_recvfrom_unlabeled(kernel_t)
 corenet_all_recvfrom_netlabel(kernel_t)
 # Kernel-generated traffic e.g., ICMP replies:

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
