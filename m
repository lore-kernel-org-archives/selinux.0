Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK2ebG029357
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:02:40 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EK2dtB027781
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:39 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614200059.405254084@hp.com>
References: <20070614195502.420663549@hp.com>
Date: Thu, 14 Jun 2007 15:55:04 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/5] Add NetLabel labeled and unlabeled support to the system domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant system domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/hotplug.te    |    4 ++++
 policy/modules/system/init.te       |    4 ++++
 policy/modules/system/ipsec.te      |    2 ++
 policy/modules/system/iscsi.te      |    2 ++
 policy/modules/system/logging.te    |    4 ++++
 policy/modules/system/lvm.te        |    4 ++++
 policy/modules/system/mount.te      |    4 ++++
 policy/modules/system/sysnetwork.if |   10 ++++++++++
 policy/modules/system/sysnetwork.te |    4 ++++
 policy/modules/system/userdomain.if |   10 ++++------
 policy/modules/system/xen.te        |    4 ++++
 11 files changed, 46 insertions(+), 6 deletions(-)

Index: refpolicy_svn_repo/policy/modules/system/hotplug.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/hotplug.te
+++ refpolicy_svn_repo/policy/modules/system/hotplug.te
@@ -51,6 +51,10 @@ kernel_read_net_sysctls(hotplug_t)
 
 files_read_kernel_modules(hotplug_t)
 
+corenet_tcp_recv_unlabeled(hotplug_t)
+corenet_udp_recv_unlabeled(hotplug_t)
+corenet_tcp_recv_netlabel(hotplug_t)
+corenet_udp_recv_netlabel(hotplug_t)
 corenet_non_ipsec_sendrecv(hotplug_t)
 corenet_tcp_sendrecv_all_if(hotplug_t)
 corenet_udp_sendrecv_all_if(hotplug_t)
Index: refpolicy_svn_repo/policy/modules/system/init.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/init.te
+++ refpolicy_svn_repo/policy/modules/system/init.te
@@ -247,6 +247,10 @@ kernel_dontaudit_getattr_message_if(init
 
 files_read_kernel_symbol_table(initrc_t)
 
+corenet_tcp_recv_unlabeled(initrc_t)
+corenet_udp_recv_unlabeled(initrc_t)
+corenet_tcp_recv_netlabel(initrc_t)
+corenet_udp_recv_netlabel(initrc_t)
 corenet_non_ipsec_sendrecv(initrc_t)
 corenet_tcp_sendrecv_all_if(initrc_t)
 corenet_udp_sendrecv_all_if(initrc_t)
Index: refpolicy_svn_repo/policy/modules/system/ipsec.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/ipsec.te
+++ refpolicy_svn_repo/policy/modules/system/ipsec.te
@@ -95,6 +95,8 @@ kernel_getattr_core_if(ipsec_t)
 kernel_getattr_message_if(ipsec_t)
 
 # Pluto needs network access
+corenet_tcp_recv_unlabeled(ipsec_t)
+corenet_udp_recv_unlabeled(ipsec_t)
 corenet_non_ipsec_sendrecv(ipsec_t)
 corenet_tcp_sendrecv_all_if(ipsec_t)
 corenet_raw_sendrecv_all_if(ipsec_t)
Index: refpolicy_svn_repo/policy/modules/system/iscsi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/iscsi.te
+++ refpolicy_svn_repo/policy/modules/system/iscsi.te
@@ -54,6 +54,8 @@ files_search_var_lib(iscsid_t)
 manage_files_pattern(iscsid_t,iscsi_var_run_t,iscsi_var_run_t)
 files_pid_filetrans(iscsid_t,iscsi_var_run_t,file)
 
+corenet_tcp_recv_unlabeled(iscsid_t)
+corenet_tcp_recv_netlabel(iscsid_t)
 corenet_non_ipsec_sendrecv(iscsid_t)
 corenet_tcp_sendrecv_all_if(iscsid_t)
 corenet_tcp_sendrecv_all_nodes(iscsid_t)
Index: refpolicy_svn_repo/policy/modules/system/logging.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/logging.te
+++ refpolicy_svn_repo/policy/modules/system/logging.te
@@ -303,6 +303,8 @@ init_read_utmp(syslogd_t)
 init_dontaudit_write_utmp(syslogd_t)
 term_write_all_user_ttys(syslogd_t)
 
+corenet_udp_recv_unlabeled(syslogd_t)
+corenet_udp_recv_netlabel(syslogd_t)
 corenet_non_ipsec_sendrecv(syslogd_t)
 corenet_udp_sendrecv_all_if(syslogd_t)
 corenet_udp_sendrecv_all_nodes(syslogd_t)
@@ -310,6 +312,8 @@ corenet_udp_sendrecv_all_ports(syslogd_t
 corenet_udp_bind_all_nodes(syslogd_t)
 corenet_udp_bind_syslogd_port(syslogd_t)
 # syslog-ng can listen and connect on tcp port 514 (rsh)
+corenet_tcp_recv_unlabeled(syslogd_t)
+corenet_tcp_recv_netlabel(syslogd_t)
 corenet_tcp_sendrecv_all_if(syslogd_t)
 corenet_tcp_sendrecv_all_nodes(syslogd_t)
 corenet_tcp_sendrecv_all_ports(syslogd_t)
Index: refpolicy_svn_repo/policy/modules/system/lvm.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/lvm.te
+++ refpolicy_svn_repo/policy/modules/system/lvm.te
@@ -69,6 +69,10 @@ kernel_dontaudit_getattr_core_if(clvmd_t
 corecmd_exec_shell(clvmd_t)
 corecmd_getattr_bin_files(clvmd_t)
 
+corenet_tcp_recv_unlabeled(clvmd_t)
+corenet_udp_recv_unlabeled(clvmd_t)
+corenet_tcp_recv_netlabel(clvmd_t)
+corenet_udp_recv_netlabel(clvmd_t)
 corenet_non_ipsec_sendrecv(clvmd_t)
 corenet_tcp_sendrecv_all_if(clvmd_t)
 corenet_udp_sendrecv_all_if(clvmd_t)
Index: refpolicy_svn_repo/policy/modules/system/mount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/mount.te
+++ refpolicy_svn_repo/policy/modules/system/mount.te
@@ -139,6 +139,10 @@ ifdef(`targeted_policy',`
 
 optional_policy(`
 	# for nfs
+	corenet_tcp_recv_unlabeled(mount_t)
+	corenet_udp_recv_unlabeled(mount_t)
+	corenet_tcp_recv_netlabel(mount_t)
+	corenet_udp_recv_netlabel(mount_t)
 	corenet_non_ipsec_sendrecv(mount_t)
 	corenet_tcp_sendrecv_all_if(mount_t)
 	corenet_raw_sendrecv_all_if(mount_t)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.if
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.if
@@ -480,6 +480,10 @@ interface(`sysnet_dns_name_resolve',`
 	allow $1 self:tcp_socket create_socket_perms;
 	allow $1 self:udp_socket create_socket_perms;
 
+	corenet_tcp_recv_unlabeled($1)
+	corenet_udp_recv_unlabeled($1)
+	corenet_tcp_recv_netlabel($1)
+	corenet_udp_recv_netlabel($1)
 	corenet_non_ipsec_sendrecv($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
@@ -511,6 +515,8 @@ interface(`sysnet_use_ldap',`
 
 	allow $1 self:tcp_socket create_socket_perms;
 
+	corenet_tcp_recv_unlabeled($1)
+	corenet_tcp_recv_netlabel($1)
 	corenet_non_ipsec_sendrecv($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
@@ -540,6 +546,10 @@ interface(`sysnet_use_portmap',`
 	allow $1 self:tcp_socket create_socket_perms;
 	allow $1 self:udp_socket create_socket_perms;
 
+	corenet_tcp_recv_unlabeled($1)
+	corenet_udp_recv_unlabeled($1)
+	corenet_tcp_recv_netlabel($1)
+	corenet_udp_recv_netlabel($1)
 	corenet_non_ipsec_sendrecv($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.te
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.te
@@ -84,6 +84,10 @@ kernel_read_network_state(dhcpc_t)
 kernel_read_kernel_sysctls(dhcpc_t)
 kernel_use_fds(dhcpc_t)
 
+corenet_tcp_recv_unlabeled(dhcpc_t)
+corenet_udp_recv_unlabeled(dhcpc_t)
+corenet_tcp_recv_netlabel(dhcpc_t)
+corenet_udp_recv_netlabel(dhcpc_t)
 corenet_non_ipsec_sendrecv(dhcpc_t)
 corenet_tcp_sendrecv_all_if(dhcpc_t)
 corenet_raw_sendrecv_all_if(dhcpc_t)
Index: refpolicy_svn_repo/policy/modules/system/userdomain.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/userdomain.if
+++ refpolicy_svn_repo/policy/modules/system/userdomain.if
@@ -537,6 +537,10 @@ template(`userdom_basic_networking_templ
 	allow $1_t self:tcp_socket create_stream_socket_perms;
 	allow $1_t self:udp_socket create_socket_perms;
 
+	corenet_tcp_recv_unlabeled($1_t)
+	corenet_udp_recv_unlabeled($1_t)
+	corenet_tcp_recv_netlabel($1_t)
+	corenet_udp_recv_netlabel($1_t)
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
@@ -546,12 +550,6 @@ template(`userdom_basic_networking_templ
 	corenet_udp_sendrecv_all_ports($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
-
-	ifdef(`enable_mls',`
-		# netlabel/CIPSO labeled networking 
-		corenet_tcp_recv_netlabel($1_t)
-		corenet_udp_recv_netlabel($1_t)
-	')
 ')
 
 #######################################
Index: refpolicy_svn_repo/policy/modules/system/xen.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/xen.te
+++ refpolicy_svn_repo/policy/modules/system/xen.te
@@ -132,6 +132,10 @@ kernel_read_network_state(xend_t)
 corecmd_exec_bin(xend_t)
 corecmd_exec_shell(xend_t)
 
+corenet_tcp_recv_unlabeled(xend_t)
+corenet_udp_recv_unlabeled(xend_t)
+corenet_tcp_recv_netlabel(xend_t)
+corenet_udp_recv_netlabel(xend_t)
 corenet_non_ipsec_sendrecv(xend_t)
 corenet_tcp_sendrecv_all_if(xend_t)
 corenet_tcp_sendrecv_all_nodes(xend_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
