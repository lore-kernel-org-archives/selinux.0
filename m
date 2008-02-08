Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18LSxE0010554
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:28:59 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LSw5u019354
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:28:58 GMT
Received: from g1t0028.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id D59091C4D8
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:32 +0000 (UTC)
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by g1t0028.austin.hp.com (Postfix) with ESMTP id BDFD01C1BB
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:32 +0000 (UTC)
Message-Id: <20080208212826.453851725@hp.com>
References: <20080208212534.491651808@hp.com>
Date: Fri, 08 Feb 2008 16:25:38 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] REFPOL: Add new labeled networking permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The 2.6.25 kernel will introduce a new set of labeled networking controls to
SELinux and this patch makes the necessary changes to the Reference Policy
to support unlabeled network traffic with the new controls.

A description of the new/improved labeled networking controls was posted to
the SELinux list back in early January 2008.

 * http://marc.info/?l=selinux&m=119991234501200&w=2

---
 policy/modules/kernel/corenetwork.if.in |   24 ++++++++++++------------
 policy/modules/kernel/kernel.if         |    6 ++++++
 policy/modules/kernel/kernel.te         |    3 +++
 3 files changed, 21 insertions(+), 12 deletions(-)

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
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
@@ -2314,6 +2314,7 @@ interface(`kernel_tcp_recvfrom_unlabeled
 		type unlabeled_t;
 	')
 
+	allow $1 unlabeled_t:peer recv;
 	allow $1 unlabeled_t:tcp_socket recvfrom;
 ')
 
@@ -2343,6 +2344,7 @@ interface(`kernel_dontaudit_tcp_recvfrom
 		type unlabeled_t;
 	')
 
+	dontaudit $1 unlabeled_t:peer recv;
 	dontaudit $1 unlabeled_t:tcp_socket recvfrom;
 ')
 
@@ -2370,6 +2372,7 @@ interface(`kernel_udp_recvfrom_unlabeled
 		type unlabeled_t;
 	')
 
+	allow $1 unlabeled_t:peer recv;
 	allow $1 unlabeled_t:udp_socket recvfrom;
 ')
 
@@ -2399,6 +2402,7 @@ interface(`kernel_dontaudit_udp_recvfrom
 		type unlabeled_t;
 	')
 
+	dontaudit $1 unlabeled_t:peer recv;
 	dontaudit $1 unlabeled_t:udp_socket recvfrom;
 ')
 
@@ -2426,6 +2430,7 @@ interface(`kernel_raw_recvfrom_unlabeled
 		type unlabeled_t;
 	')
 
+	allow $1 unlabeled_t:peer recv;
 	allow $1 unlabeled_t:rawip_socket recvfrom;
 ')
 
@@ -2455,6 +2460,7 @@ interface(`kernel_dontaudit_raw_recvfrom
 		type unlabeled_t;
 	')
 
+	dontaudit $1 unlabeled_t:peer recv;
 	dontaudit $1 unlabeled_t:rawip_socket recvfrom;
 ')
 
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
