Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5RFdpV3022155
	for <selinux@tycho.nsa.gov>; Wed, 27 Jun 2007 11:39:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5RFdoIC004822
	for <selinux@tycho.nsa.gov>; Wed, 27 Jun 2007 15:39:51 GMT
Subject: Re: [PATCHv2 0/5] Labeled network policy patches
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070621231507.402982591@hp.com>
References: <20070621231507.402982591@hp.com>
Content-Type: text/plain
Date: Wed, 27 Jun 2007 11:38:00 -0400
Message-Id: <1182958680.14634.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 19:15 -0400, Paul Moore wrote:
> The latest revision of the labeled policy patches which enable both labeled
> and unlabeled policy support for NetLabel.  This revision takes into account
> Chris' feedback from the first version and reduces the number of interface
> calls in each domain down to two at present: one for unlabeled access, one for
> NetLabel access.  The older, transport layer specific interfaces, are still
> present for use by third-party modules but are not used in the default policy
> modules.

Merged.

The existing corenetwork interfaces still have to remain for
compatibility, I just put them back.  There were also some places that
still were using the old interfaces, which I also fixed.  The diff on
what I fixed:

diff -urN refpolicy.old/policy/modules/kernel/corenetwork.if.in refpolicy/policy/modules/kernel/corenetwork.if.in
--- refpolicy.old/policy/modules/kernel/corenetwork.if.in	2007-06-27 11:20:04.171919834 -0400
+++ refpolicy/policy/modules/kernel/corenetwork.if.in	2007-06-27 11:23:21.881357000 -0400
@@ -1567,6 +1567,11 @@
 ## </summary>
 ## <desc>
 ##	<p>
+##	Send and receive messages on a
+##	non-encrypted (no IPSEC) network
+##	session.  (Deprecated)
+##	</p>
+##	<p>
 ##	The corenet_all_recvfrom_unlabeled() interface should be used instead
 ##	of this one.
 ##	</p>
@@ -1578,7 +1583,8 @@
 ## </param>
 #
 interface(`corenet_non_ipsec_sendrecv',`
-	kernel_sendrecv_unlabeled_association($1)
+	refpolicywarn(`$0($*) has been deprecated, use corenet_all_recvfrom_unlabeled() instead.')
+	corenet_all_recvfrom_unlabeled($1)
 ')
 
 ########################################
@@ -1589,6 +1595,11 @@
 ## </summary>
 ## <desc>
 ##	<p>
+##	Do not audit attempts to send and receive
+##	messages on a non-encrypted (no IPSEC) network
+##	session.
+##	</p>
+##	<p>
 ##	The corenet_dontaudit_all_recvfrom_unlabeled() interface should be
 ##	used instead of this one.
 ##	</p>
@@ -1600,7 +1611,23 @@
 ## </param>
 #
 interface(`corenet_dontaudit_non_ipsec_sendrecv',`
-	kernel_dontaudit_sendrecv_unlabeled_association($1)
+	refpolicywarn(`$0($*) has been deprecated, use corenet_dontaudit_all_recvfrom_unlabeled() instead.')
+	corenet_dontaudit_all_recvfrom_unlabeled($1)
+')
+
+########################################
+## <summary>
+##      Receive TCP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_tcp_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_tcp_recvfrom_netlabel() instead.')
+	corenet_tcp_recvfrom_netlabel($1)
 ')
 
 ########################################
@@ -1651,6 +1678,22 @@
 ##	</summary>
 ## </param>
 #
+interface(`corenet_dontaudit_tcp_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_dontaudit_tcp_recvfrom_netlabel() instead.')
+	corenet_dontaudit_tcp_recvfrom_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
 interface(`corenet_dontaudit_tcp_recvfrom_netlabel',`
 	gen_require(`
 		type netlabel_peer_t;
@@ -1689,6 +1732,21 @@
 ##	</summary>
 ## </param>
 #
+interface(`corenet_udp_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_udp_recvfrom_netlabel() instead.')
+	corenet_udp_recvfrom_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Receive UDP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
 interface(`corenet_udp_recvfrom_netlabel',`
 	gen_require(`
 		type netlabel_peer_t;
@@ -1727,6 +1785,22 @@
 ##	</summary>
 ## </param>
 #
+interface(`corenet_dontaudit_udp_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_dontaudit_udp_recvfrom_netlabel($1) instead.')
+	corenet_dontaudit_udp_recvfrom_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
 interface(`corenet_dontaudit_udp_recvfrom_netlabel',`
 	gen_require(`
 		type netlabel_peer_t;
@@ -1765,6 +1839,21 @@
 ##	</summary>
 ## </param>
 #
+interface(`corenet_raw_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_raw_recvfrom_netlabel() instead.')
+	corenet_raw_recvfrom_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Receive Raw IP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
 interface(`corenet_raw_recvfrom_netlabel',`
 	gen_require(`
 		type netlabel_peer_t;
@@ -1803,6 +1892,22 @@
 ##	</summary>
 ## </param>
 #
+interface(`corenet_dontaudit_raw_recv_netlabel',`
+	refpolicywarn(`$0($*) has been deprecated, use corenet_dontaudit_raw_recvfrom_netlabel() instead.')
+	corenet_dontaudit_raw_recvfrom_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive Raw IP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
 interface(`corenet_dontaudit_raw_recvfrom_netlabel',`
 	gen_require(`
 		type netlabel_peer_t;
diff -urN refpolicy.old/policy/modules/kernel/corenetwork.te.in refpolicy/policy/modules/kernel/corenetwork.te.in
--- refpolicy.old/policy/modules/kernel/corenetwork.te.in	2007-06-27 11:25:14.077580351 -0400
+++ refpolicy/policy/modules/kernel/corenetwork.te.in	2007-06-27 11:23:21.881357000 -0400
@@ -41,7 +41,7 @@
 # connections using NetLabel which do not carry full SELinux contexts.
 #
 type netlabel_peer_t;
-sid netmsg		gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
+sid netmsg gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
 
 #
 # port_t is the default type of INET port numbers.
diff -urN refpolicy.old/policy/modules/kernel/kernel.te refpolicy/policy/modules/kernel/kernel.te
--- refpolicy.old/policy/modules/kernel/kernel.te	2007-06-27 11:25:22.206043566 -0400
+++ refpolicy/policy/modules/kernel/kernel.te	2007-06-27 11:23:21.881357000 -0400
@@ -205,7 +205,8 @@
 # connections with invalidated labels:
 allow kernel_t unlabeled_t:packet send;
 
-corenet_non_ipsec_sendrecv(kernel_t)
+corenet_all_recvfrom_unlabeled(kernel_t)
+corenet_all_recvfrom_netlabel(kernel_t)
 # Kernel-generated traffic e.g., ICMP replies:
 corenet_raw_sendrecv_all_if(kernel_t)
 corenet_raw_sendrecv_all_nodes(kernel_t)

diff -urN refpolicy.old/policy/modules/services/bind.te refpolicy/policy/modules/services/bind.te
--- refpolicy.old/policy/modules/services/bind.te	2007-06-27 11:20:28.805323612 -0400
+++ refpolicy/policy/modules/services/bind.te	2007-06-27 11:23:21.881357000 -0400
@@ -232,6 +232,8 @@
 
 kernel_read_kernel_sysctls(ndc_t)
 
+corenet_all_recvfrom_unlabeled(ndc_t)
+corenet_all_recvfrom_netlabel(ndc_t)
 corenet_tcp_sendrecv_all_if(ndc_t)
 corenet_tcp_sendrecv_all_nodes(ndc_t)
 corenet_tcp_sendrecv_all_ports(ndc_t)
diff -urN refpolicy.old/policy/modules/services/cups.te refpolicy/policy/modules/services/cups.te
--- refpolicy.old/policy/modules/services/cups.te	2007-06-27 11:20:28.813324068 -0400
+++ refpolicy/policy/modules/services/cups.te	2007-06-27 11:23:21.881357000 -0400
@@ -135,7 +135,6 @@
 
 corenet_all_recvfrom_unlabeled(cupsd_t)
 corenet_all_recvfrom_netlabel(cupsd_t)
-corenet_all_recvfrom_unlabeled(cupsd_t)
 corenet_tcp_sendrecv_all_if(cupsd_t)
 corenet_udp_sendrecv_all_if(cupsd_t)
 corenet_raw_sendrecv_all_if(cupsd_t)

diff -urN refpolicy.old/policy/modules/services/ntp.te refpolicy/policy/modules/services/ntp.te
--- refpolicy.old/policy/modules/services/ntp.te	2007-04-17 09:28:09.865803000 -0400
+++ refpolicy/policy/modules/services/ntp.te	2007-06-27 11:23:21.881357000 -0400
@@ -61,7 +61,8 @@
 kernel_read_system_state(ntpd_t)
 kernel_read_network_state(ntpd_t)
 
-corenet_non_ipsec_sendrecv(ntpd_t)
+corenet_all_recvfrom_unlabeled(ntpd_t)
+corenet_all_recvfrom_netlabel(ntpd_t)
 corenet_tcp_sendrecv_all_if(ntpd_t)
 corenet_udp_sendrecv_all_if(ntpd_t)
 corenet_tcp_sendrecv_all_nodes(ntpd_t)

diff -urN refpolicy.old/policy/modules/system/ipsec.te refpolicy/policy/modules/system/ipsec.te
--- refpolicy.old/policy/modules/system/ipsec.te	2007-06-27 11:22:37.444654350 -0400
+++ refpolicy/policy/modules/system/ipsec.te	2007-06-27 11:23:21.881357000 -0400
@@ -307,7 +307,7 @@
 
 kernel_read_network_state(racoon_t)
 
-corenet_non_ipsec_sendrecv(racoon_t)
+corenet_all_recvfrom_unlabeled(racoon_t)
 corenet_tcp_bind_all_nodes(racoon_t)
 corenet_udp_bind_isakmp_port(racoon_t)
 


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
