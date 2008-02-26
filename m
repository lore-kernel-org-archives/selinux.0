Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QIiuT3030482
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 13:44:56 -0500
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QIitQG003896
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:55 GMT
Received: from g5t0008.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 2CFA924052
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:10 +0000 (UTC)
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g5t0008.atlanta.hp.com (Postfix) with ESMTP id 16BFB2401B
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:10 +0000 (UTC)
Message-Id: <20080226184409.184059190@hp.com>
References: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:37 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 5/5] REFPOL: Allow network system domains to receive unlabeled traffic
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the corenet_recvfrom_unlabeled_peer() interface call to
all of the system modules which need to receive data over the network.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/hotplug.te    |    1 +
 policy/modules/system/init.te       |    1 +
 policy/modules/system/ipsec.te      |    2 ++
 policy/modules/system/iscsi.te      |    1 +
 policy/modules/system/logging.te    |    1 +
 policy/modules/system/lvm.te        |    1 +
 policy/modules/system/mount.te      |    1 +
 policy/modules/system/sysnetwork.if |    3 +++
 policy/modules/system/sysnetwork.te |    1 +
 policy/modules/system/userdomain.if |    1 +
 policy/modules/system/xen.te        |    1 +
 11 files changed, 14 insertions(+)

Index: refpolicy_svn_repo/policy/modules/system/hotplug.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/hotplug.te
+++ refpolicy_svn_repo/policy/modules/system/hotplug.te
@@ -52,6 +52,7 @@ kernel_read_net_sysctls(hotplug_t)
 files_read_kernel_modules(hotplug_t)
 
 corenet_all_recvfrom_unlabeled(hotplug_t)
+corenet_recvfrom_unlabeled_peer(hotplug_t)
 corenet_all_recvfrom_netlabel(hotplug_t)
 corenet_tcp_sendrecv_all_if(hotplug_t)
 corenet_udp_sendrecv_all_if(hotplug_t)
Index: refpolicy_svn_repo/policy/modules/system/init.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/init.te
+++ refpolicy_svn_repo/policy/modules/system/init.te
@@ -236,6 +236,7 @@ kernel_dontaudit_getattr_message_if(init
 files_read_kernel_symbol_table(initrc_t)
 
 corenet_all_recvfrom_unlabeled(initrc_t)
+corenet_recvfrom_unlabeled_peer(initrc_t)
 corenet_all_recvfrom_netlabel(initrc_t)
 corenet_tcp_sendrecv_all_if(initrc_t)
 corenet_udp_sendrecv_all_if(initrc_t)
Index: refpolicy_svn_repo/policy/modules/system/ipsec.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/ipsec.te
+++ refpolicy_svn_repo/policy/modules/system/ipsec.te
@@ -96,6 +96,7 @@ kernel_getattr_message_if(ipsec_t)
 
 # Pluto needs network access
 corenet_all_recvfrom_unlabeled(ipsec_t)
+corenet_recvfrom_unlabeled_peer(ipsec_t)
 corenet_tcp_sendrecv_all_if(ipsec_t)
 corenet_raw_sendrecv_all_if(ipsec_t)
 corenet_tcp_sendrecv_all_nodes(ipsec_t)
@@ -301,6 +302,7 @@ kernel_read_system_state(racoon_t)
 kernel_read_network_state(racoon_t)
 
 corenet_all_recvfrom_unlabeled(racoon_t)
+corenet_recvfrom_unlabeled_peer(racoon_t)
 corenet_tcp_bind_all_nodes(racoon_t)
 corenet_udp_bind_all_nodes(racoon_t)
 corenet_udp_bind_isakmp_port(racoon_t)
Index: refpolicy_svn_repo/policy/modules/system/iscsi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/iscsi.te
+++ refpolicy_svn_repo/policy/modules/system/iscsi.te
@@ -57,6 +57,7 @@ files_pid_filetrans(iscsid_t,iscsi_var_r
 kernel_read_system_state(iscsid_t)
 
 corenet_all_recvfrom_unlabeled(iscsid_t)
+corenet_recvfrom_unlabeled_peer(iscsid_t)
 corenet_all_recvfrom_netlabel(iscsid_t)
 corenet_tcp_sendrecv_all_if(iscsid_t)
 corenet_tcp_sendrecv_all_nodes(iscsid_t)
Index: refpolicy_svn_repo/policy/modules/system/logging.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/logging.te
+++ refpolicy_svn_repo/policy/modules/system/logging.te
@@ -311,6 +311,7 @@ init_dontaudit_write_utmp(syslogd_t)
 term_write_all_user_ttys(syslogd_t)
 
 corenet_all_recvfrom_unlabeled(syslogd_t)
+corenet_recvfrom_unlabeled_peer(syslogd_t)
 corenet_all_recvfrom_netlabel(syslogd_t)
 corenet_udp_sendrecv_all_if(syslogd_t)
 corenet_udp_sendrecv_all_nodes(syslogd_t)
Index: refpolicy_svn_repo/policy/modules/system/lvm.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/lvm.te
+++ refpolicy_svn_repo/policy/modules/system/lvm.te
@@ -70,6 +70,7 @@ corecmd_exec_shell(clvmd_t)
 corecmd_getattr_bin_files(clvmd_t)
 
 corenet_all_recvfrom_unlabeled(clvmd_t)
+corenet_recvfrom_unlabeled_peer(clvmd_t)
 corenet_all_recvfrom_netlabel(clvmd_t)
 corenet_tcp_sendrecv_all_if(clvmd_t)
 corenet_udp_sendrecv_all_if(clvmd_t)
Index: refpolicy_svn_repo/policy/modules/system/mount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/mount.te
+++ refpolicy_svn_repo/policy/modules/system/mount.te
@@ -143,6 +143,7 @@ tunable_policy(`allow_mount_anyfile',`
 optional_policy(`
 	# for nfs
 	corenet_all_recvfrom_unlabeled(mount_t)
+	corenet_recvfrom_unlabeled_peer(mount_t)
 	corenet_all_recvfrom_netlabel(mount_t)
 	corenet_tcp_sendrecv_all_if(mount_t)
 	corenet_raw_sendrecv_all_if(mount_t)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.if
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.if
@@ -481,6 +481,7 @@ interface(`sysnet_dns_name_resolve',`
 	allow $1 self:udp_socket create_socket_perms;
 
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
@@ -513,6 +514,7 @@ interface(`sysnet_use_ldap',`
 	allow $1 self:tcp_socket create_socket_perms;
 
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
@@ -543,6 +545,7 @@ interface(`sysnet_use_portmap',`
 	allow $1 self:udp_socket create_socket_perms;
 
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.te
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.te
@@ -85,6 +85,7 @@ kernel_read_kernel_sysctls(dhcpc_t)
 kernel_use_fds(dhcpc_t)
 
 corenet_all_recvfrom_unlabeled(dhcpc_t)
+corenet_recvfrom_unlabeled_peer(dhcpc_t)
 corenet_all_recvfrom_netlabel(dhcpc_t)
 corenet_tcp_sendrecv_all_if(dhcpc_t)
 corenet_raw_sendrecv_all_if(dhcpc_t)
Index: refpolicy_svn_repo/policy/modules/system/userdomain.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/userdomain.if
+++ refpolicy_svn_repo/policy/modules/system/userdomain.if
@@ -539,6 +539,7 @@ template(`userdom_basic_networking_templ
 	allow $1_t self:udp_socket create_socket_perms;
 
 	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_recvfrom_unlabeled_peer($1_t)
 	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
Index: refpolicy_svn_repo/policy/modules/system/xen.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/xen.te
+++ refpolicy_svn_repo/policy/modules/system/xen.te
@@ -143,6 +143,7 @@ corecmd_exec_bin(xend_t)
 corecmd_exec_shell(xend_t)
 
 corenet_all_recvfrom_unlabeled(xend_t)
+corenet_recvfrom_unlabeled_peer(xend_t)
 corenet_all_recvfrom_netlabel(xend_t)
 corenet_tcp_sendrecv_all_if(xend_t)
 corenet_tcp_sendrecv_all_nodes(xend_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
