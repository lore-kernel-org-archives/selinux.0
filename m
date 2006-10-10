Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AHLuHX022672
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:57 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AHKevk021090
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 17:20:41 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id BDB823576E
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 13:21:55 -0400 (EDT)
Message-Id: <20061010172154.448485000@hp.com>
References: <20061010171524.936739000@hp.com>
Date: Tue, 10 Oct 2006 13:15:26 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [RFC 1/2] Reference policy: NetLabel policy additions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds basic NetLabel support to the reference policy.

---
 refpolicy/policy/modules/system/netlabel.fc |    7 ++++
 refpolicy/policy/modules/system/netlabel.if |   37 +++++++++++++++++++++++++
 refpolicy/policy/modules/system/netlabel.te |   41 ++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

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
+/sbin/netlabelctl		--	gen_context(system_u:object_r:netlabelctl_exec_t,s0)
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
@@ -0,0 +1,37 @@
+## <summary>NetLabel packet labeling</summary>
+
+########################################
+## <summary>
+##      Allow the domain to receive UDP packets via NetLabel connections.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process requesting this access.
+##      </summary>
+## </param>
+#
+interface(`netlabel_udp_recvfrom',`
+        gen_require(`
+                type unlabeled_t;
+        ')
+
+	allow $1 unlabeled_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Allow the domain to receive TCP packets via NetLabel connections.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process requesting this access.
+##      </summary>
+## </param>
+#
+interface(`netlabel_tcp_recvfrom',`
+        gen_require(`
+                type unlabeled_t;
+        ')
+
+	allow $1 unlabeled_t:tcp_socket recvfrom;
+')
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
@@ -0,0 +1,41 @@
+
+policy_module(netlabel,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type netlabelctl_t;
+type netlabelctl_exec_t;
+
+domain_type(netlabelctl_t)
+domain_entry_file(netlabelctl_t,netlabelctl_exec_t)
+
+########################################
+#
+# NetLabel Local policy
+#
+
+# sending netlabel'd packets does not require a selinux privilege, however
+# receiving netlabel's packets does
+allow staff_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;
+allow user_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;
+
+########################################
+#
+# netlabelctl Local policy
+#
+
+# allow sysadm_t to run netlabelctl
+domain_auto_trans(sysadm_t,netlabelctl_exec_t,netlabelctl_t)
+
+# allow netlabelctl access to shared libraries
+libs_use_ld_so(netlabelctl_t)
+libs_use_shared_libs(netlabelctl_t)
+
+# allow netlabelctl fd access
+domain_use_interactive_fds(netlabelctl_t)
+
+# allow communication with kernel subsystem
+allow netlabelctl_t self:netlink_socket { create bind write read };

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
