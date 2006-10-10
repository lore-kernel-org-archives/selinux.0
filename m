Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AL7rDD030455
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 17:07:53 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AL6bvk004764
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 21:06:37 GMT
Message-ID: <452C0BA5.6060704@hp.com>
Date: Tue, 10 Oct 2006 17:07:49 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [RFC 1/2] Reference policy: NetLabel policy additions
References: <20061010171524.936739000@hp.com>	 <20061010172154.448485000@hp.com> <1160503804.20774.82.camel@sgc>
In-Reply-To: <1160503804.20774.82.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-10-10 at 13:15 -0400, paul.moore@hp.com wrote:
>>plain text document attachment (netlabel-refpolicy_core)
>>This patch adds basic NetLabel support to the reference policy.
> 
> The main problem is that there are references to types that are not
> owned by this module.  These have to be changed to use interfaces that
> are provided by the modules that own the types.

Okay, attempt #2 ...

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
+##     <summary>
+##     Domain allowed access.
+##     </summary>
+## </param>
+#
+interface(`corenet_tcp_recv_netlabel',`
+       kernel_tcp_recv_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain to not audit.
+##     </summary>
+## </param>
+#
+interface(`corenet_dontaudit_tcp_recv_netlabel',`
+       kernel_dontaudit_tcp_recv_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Receive UDP packets from a NetLabel connection.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain allowed access.
+##     </summary>
+## </param>
+#
+interface(`corenet_udp_recv_netlabel',`
+       kernel_udp_recv_netlabel($1)
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.
+## </summary>
+## <param name="domain">
+##     <summary>
+##     Domain to not audit.
+##     </summary>
+## </param>
+#
+interface(`corenet_dontaudit_udp_recv_netlabel',`
+       kernel_dontaudit_udp_recv_netlabel($1)
+')
+
+########################################
+## <summary>
 ##     Send generic client packets.
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
+##     <p>
+##      Receive TCP packets from a NetLabel connection, NetLabel is an
+##      explicit packet labeling framework which implements CIPSO and
+##      similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##     <summary>
+##     Domain allowed access.
+##     </summary>
+## </param>
+#
+interface(`kernel_dontaudit_tcp_recv_netlabel',`
+       gen_require(`
+               type unlabeled_t;
+       ')
+
+       allow $1 unlabeled_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.
+## </summary>
+## <desc>
+##     <p>
+##      Do not audit attempts to receive TCP packets from a NetLabel
+##      connection.  NetLabel is an explicit packet labeling framework
+##      which implements CIPSO and similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##     <summary>
+##     Domain to not audit.
+##     </summary>
+## </param>
+#
+interface(`kernel_tcp_recv_netlabel',`
+       gen_require(`
+               type unlabeled_t;
+       ')
+
+       dontaudit $1 unlabeled_t:tcp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Receive UDP packets from a NetLabel connection.
+## </summary>
+## <desc>
+##     <p>
+##      Receive UDP packets from a NetLabel connection, NetLabel is an
+##      explicit packet labeling framework which implements CIPSO and
+##      similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##     <summary>
+##     Domain allowed access.
+##     </summary>
+## </param>
+#
+interface(`kernel_udp_recv_netlabel',`
+       gen_require(`
+               type unlabeled_t;
+       ')
+
+       allow $1 unlabeled_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.
+## </summary>
+## <desc>
+##     <p>
+##      Do not audit attempts to receive UDP packets from a NetLabel
+##      connection.  NetLabel is an explicit packet labeling framework
+##      which implements CIPSO and similar protocols.
+##      </p>
+## </desc>
+## <param name="domain">
+##     <summary>
+##     Domain to not audit.
+##     </summary>
+## </param>
+#
+interface(`kernel_dontaudit_udp_recv_netlabel',`
+       gen_require(`
+               type unlabeled_t;
+       ')
+
+       dontaudit $1 unlabeled_t:udp_socket recvfrom;
+')
+
+########################################
+## <summary>
 ##     Send and receive unlabeled packets.
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
+/sbin/netlabelctl              --
gen_context(system_u:object_r:netlabelctl_exec_t,s0)
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.if
@@ -0,0 +1,24 @@
+## <summary>NetLabel packet labeling</summary>
+
+########################################
+## <summary>
+##      Execute netlabelctl in the netlabelctl domain.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process performing this action.
+##      </summary>
+## </param>
+#
+interface(`netlabelctl_domtrans',`
+        gen_require(`
+                type netlabelctl_t, netlabelctl_exec_t;
+        ')
+
+        domain_auto_trans($1,netlabelctl_exec_t,netlabelctl_t)
+
+       allow $1 netlabelctl_t:fd use;
+       allow netlabelctl_t $1:fd use;
+       allow netlabelctl_t $1:fifo_file rw_file_perms;
+       allow netlabelctl_t $1:process sigchld;
+')
Index: refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
===================================================================
--- /dev/null
+++ refpolicy.lblnet/refpolicy/policy/modules/system/netlabel.te
@@ -0,0 +1,25 @@
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
+# netlabelctl Local policy
+#
+
+# allow netlabelctl access to shared libraries
+libs_use_ld_so(netlabelctl_t)
+libs_use_shared_libs(netlabelctl_t)
+
+# allow communication with kernel subsystem
+allow netlabelctl_t self:netlink_socket { create bind write read };
Index: refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.lblnet.orig/refpolicy/policy/modules/system/userdomain.if
+++ refpolicy.lblnet/refpolicy/policy/modules/system/userdomain.if
@@ -512,6 +512,8 @@ template(`userdom_basic_networking_templ
        corenet_udp_sendrecv_all_nodes($1_t)
        corenet_tcp_sendrecv_all_ports($1_t)
        corenet_udp_sendrecv_all_ports($1_t)
+       corenet_tcp_recv_netlabel($1_t)
+       corenet_udp_recv_netlabel($1_t)
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
+               netlabelctl_domtrans(secadm_t)
        ',`
                logging_manage_audit_log(sysadm_t)
                logging_manage_audit_config(sysadm_t)
                logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
+               netlabelctl_domtrans(sysadm_t)
        ')

        tunable_policy(`allow_ptrace',`

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
