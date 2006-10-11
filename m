Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BLWWp0004835
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 17:32:32 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BLVGAB004991
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 21:31:16 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel8.hp.com (Postfix) with ESMTP id 3B04038C58
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 17:32:51 -0400 (EDT)
Message-Id: <20061011213229.879958000@hp.com>
References: <20061011212958.265773000@hp.com>
Date: Wed, 11 Oct 2006 17:29:59 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] Reference policy: NetLabel policy additions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds basic NetLabel support to the reference policy.

---
 refpolicy/policy/modules/kernel/corenetwork.if.in |   58 ++++++++++++
 refpolicy/policy/modules/kernel/kernel.if         |  102 ++++++++++++++++++++++
 refpolicy/policy/modules/system/netlabel.fc       |    7 +
 refpolicy/policy/modules/system/netlabel.if       |   58 ++++++++++++
 refpolicy/policy/modules/system/netlabel.te       |   34 +++++++
 refpolicy/policy/modules/system/userdomain.if     |    2 
 refpolicy/policy/modules/system/userdomain.te     |    2 
 7 files changed, 263 insertions(+)

Index: refpolicy.lblnet/refpolicy/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/modules/kernel/corenetwork.if.in
+++ refpolicy.lblnet/refpolicy/policy/modules/kernel/corenetwork.if.in
@@ -1436,6 +1436,64 @@ interface(`corenet_dontaudit_non_ipsec_s
 
 ########################################
 ## <summary>
+##      Receive TCP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corenet_tcp_recv_netlabel',`
+	kernel_tcp_recv_netlabel($1)
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
+interface(`corenet_dontaudit_tcp_recv_netlabel',`
+	kernel_dontaudit_tcp_recv_netlabel($1)
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
+interface(`corenet_udp_recv_netlabel',`
+	kernel_udp_recv_netlabel($1)
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
+interface(`corenet_dontaudit_udp_recv_netlabel',`
+	kernel_dontaudit_udp_recv_netlabel($1)
+')
+
+########################################
+## <summary>
 ##	Send generic client packets.
 ## </summary>
 ## <param name="domain">
Index: refpolicy.lblnet/refpolicy/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/modules/kernel/kernel.if
+++ refpolicy.lblnet/refpolicy/policy/modules/kernel/kernel.if
@@ -2205,6 +2205,108 @@ interface(`kernel_dontaudit_sendrecv_unl
 
 ########################################
 ## <summary>
+##      Receive TCP packets from a NetLabel connection.
+## </summary>
+## <desc>
+##	<p>
+##      Receive TCP packets from a NetLabel connection, NetLabel is an
+##      explicit packet labeling framework which implements CIPSO and
+##      similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_tcp_recv_netlabel',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.  NetLabel is an explicit packet labeling framework
+##      which implements CIPSO and similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_tcp_recv_netlabel',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	dontaudit $1 unlabeled_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive UDP packets from a NetLabel connection.
+## </summary>
+## <desc>
+##	<p>
+##      Receive UDP packets from a NetLabel connection, NetLabel is an
+##      explicit packet labeling framework which implements CIPSO and
+##      similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_udp_recv_netlabel',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.
+## </summary>
+## <desc>
+##	<p>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.  NetLabel is an explicit packet labeling framework
+##      which implements CIPSO and similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_udp_recv_netlabel',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	dontaudit $1 unlabeled_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
 ##	Send and receive unlabeled packets.
 ## </summary>
 ## <desc>
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.fc
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.fc
@@ -0,0 +1,7 @@
+
+########################################
+#
+# netlabel file contexts
+#
+
+/sbin/netlabelctl		--	gen_context(system_u:object_r:netlabel_mgmt_exec_t,s0)
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
@@ -0,0 +1,58 @@
+## <summary>NetLabel packet labeling</summary>
+
+########################################
+## <summary>
+##      Execute netlabel_mgmt in the netlabel_mgmt domain.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process performing this action.
+##      </summary>
+## </param>
+#
+interface(`netlabel_domtrans_mgmt',`
+        gen_require(`
+                type netlabel_mgmt_t, netlabel_mgmt_exec_t;
+        ')
+
+	corecmd_search_sbin($1)
+	domain_auto_trans($1,netlabel_mgmt_exec_t,netlabel_mgmt_t)
+
+	allow $1 netlabel_mgmt_t:fd use;
+	allow netlabel_mgmt_t $1:fd use;
+	allow netlabel_mgmt_t $1:fifo_file rw_file_perms;
+	allow netlabel_mgmt_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##      Execute netlabel_mgmt in the netlabel_mgmt domain, and
+##      allow the specified role the netlabel_mgmt domain.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process performing this action.
+##      </summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the netlabel_mgmt domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the netlabel_mgmt domain to use.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`netlabel_run_mgmt',`
+	gen_require(`
+		type netlabel_mgmt_t;
+	')
+
+	corecmd_search_sbin($1)
+	netlabel_domtrans_mgmt($1)
+	role $2 types netlabel_mgmt_t;
+	allow netlabel_mgmt_t $3:chr_file rw_term_perms;
+')
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
@@ -0,0 +1,34 @@
+
+policy_module(netlabel,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type netlabel_mgmt_t;
+type netlabel_mgmt_exec_t;
+
+domain_type(netlabel_mgmt_t)
+domain_entry_file(netlabel_mgmt_t,netlabel_mgmt_exec_t)
+
+########################################
+#
+# NetLabel Management Tools Local policy
+#
+
+# allow access to newrole fds
+seutil_use_newrole_fds(netlabel_mgmt_t)
+
+# allow access to shared libraries
+libs_use_ld_so(netlabel_mgmt_t)
+libs_use_shared_libs(netlabel_mgmt_t)
+
+# allow read access to network state
+kernel_read_network_state(netlabel_mgmt_t)
+
+# allow communication with kernel subsystem
+allow netlabel_mgmt_t self:netlink_socket create_socket_perms;
+
+# allow CAP_NET_ADMIN to modify the kernel subsystem configuration
+allow netlabel_mgmt_t self:capability net_admin;
Index: refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/modules/system/userdomain.if
+++ refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.if
@@ -512,6 +512,8 @@ template(`userdom_basic_networking_templ
 	corenet_udp_sendrecv_all_nodes($1_t)
 	corenet_tcp_sendrecv_all_ports($1_t)
 	corenet_udp_sendrecv_all_ports($1_t)
+	corenet_tcp_recv_netlabel($1_t)
+	corenet_udp_recv_netlabel($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
 ')
Index: refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.te
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/modules/system/userdomain.te
+++ refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.te
@@ -155,10 +155,12 @@ ifdef(`strict_policy',`
 	        logging_read_generic_logs(secadm_t)
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
 		userdom_dontaudit_read_sysadm_home_content_files(secadm_t)
+		netlabel_run_mgmt(secadm_t,secadm_r, { secadm_tty_device_t secadm_devpts_t })
 	',`
 		logging_manage_audit_log(sysadm_t)
 		logging_manage_audit_config(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
+		netlabel_run_mgmt(sysadm_t,sysadm_r,admin_terminal)
 	')
 
 	tunable_policy(`allow_ptrace',`

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
