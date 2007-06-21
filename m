Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LNL2bo002468
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:21:02 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LNL0nL019141
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 23:21:01 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070621232051.180583544@hp.com>
References: <20070621231507.402982591@hp.com>
Date: Thu, 21 Jun 2007 19:15:09 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCHv2 2/5] Add NetLabel labeled and unlabeled support to the system domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant system domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/system/hotplug.te    |    3 ++-
 policy/modules/system/init.te       |    3 ++-
 policy/modules/system/ipsec.te      |    2 +-
 policy/modules/system/iscsi.te      |    3 ++-
 policy/modules/system/logging.te    |    3 ++-
 policy/modules/system/lvm.te        |    3 ++-
 policy/modules/system/mount.te      |    3 ++-
 policy/modules/system/sysnetwork.if |    9 ++++++---
 policy/modules/system/sysnetwork.te |    3 ++-
 policy/modules/system/userdomain.if |    9 ++-------
 policy/modules/system/xen.te        |    3 ++-
 11 files changed, 25 insertions(+), 19 deletions(-)

Index: refpolicy_svn_repo/policy/modules/system/hotplug.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/hotplug.te
+++ refpolicy_svn_repo/policy/modules/system/hotplug.te
@@ -51,7 +51,8 @@ kernel_read_net_sysctls(hotplug_t)
 
 files_read_kernel_modules(hotplug_t)
 
-corenet_non_ipsec_sendrecv(hotplug_t)
+corenet_all_recvfrom_unlabeled(hotplug_t)
+corenet_all_recvfrom_netlabel(hotplug_t)
 corenet_tcp_sendrecv_all_if(hotplug_t)
 corenet_udp_sendrecv_all_if(hotplug_t)
 corenet_tcp_sendrecv_all_nodes(hotplug_t)
Index: refpolicy_svn_repo/policy/modules/system/init.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/init.te
+++ refpolicy_svn_repo/policy/modules/system/init.te
@@ -247,7 +247,8 @@ kernel_dontaudit_getattr_message_if(init
 
 files_read_kernel_symbol_table(initrc_t)
 
-corenet_non_ipsec_sendrecv(initrc_t)
+corenet_all_recvfrom_unlabeled(initrc_t)
+corenet_all_recvfrom_netlabel(initrc_t)
 corenet_tcp_sendrecv_all_if(initrc_t)
 corenet_udp_sendrecv_all_if(initrc_t)
 corenet_tcp_sendrecv_all_nodes(initrc_t)
Index: refpolicy_svn_repo/policy/modules/system/ipsec.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/ipsec.te
+++ refpolicy_svn_repo/policy/modules/system/ipsec.te
@@ -95,7 +95,7 @@ kernel_getattr_core_if(ipsec_t)
 kernel_getattr_message_if(ipsec_t)
 
 # Pluto needs network access
-corenet_non_ipsec_sendrecv(ipsec_t)
+corenet_all_recvfrom_unlabeled(ipsec_t)
 corenet_tcp_sendrecv_all_if(ipsec_t)
 corenet_raw_sendrecv_all_if(ipsec_t)
 corenet_tcp_sendrecv_all_nodes(ipsec_t)
Index: refpolicy_svn_repo/policy/modules/system/iscsi.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/iscsi.te
+++ refpolicy_svn_repo/policy/modules/system/iscsi.te
@@ -54,7 +54,8 @@ files_search_var_lib(iscsid_t)
 manage_files_pattern(iscsid_t,iscsi_var_run_t,iscsi_var_run_t)
 files_pid_filetrans(iscsid_t,iscsi_var_run_t,file)
 
-corenet_non_ipsec_sendrecv(iscsid_t)
+corenet_all_recvfrom_unlabeled(iscsid_t)
+corenet_all_recvfrom_netlabel(iscsid_t)
 corenet_tcp_sendrecv_all_if(iscsid_t)
 corenet_tcp_sendrecv_all_nodes(iscsid_t)
 corenet_tcp_sendrecv_all_ports(iscsid_t)
Index: refpolicy_svn_repo/policy/modules/system/logging.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/logging.te
+++ refpolicy_svn_repo/policy/modules/system/logging.te
@@ -303,7 +303,8 @@ init_read_utmp(syslogd_t)
 init_dontaudit_write_utmp(syslogd_t)
 term_write_all_user_ttys(syslogd_t)
 
-corenet_non_ipsec_sendrecv(syslogd_t)
+corenet_all_recvfrom_unlabeled(syslogd_t)
+corenet_all_recvfrom_netlabel(syslogd_t)
 corenet_udp_sendrecv_all_if(syslogd_t)
 corenet_udp_sendrecv_all_nodes(syslogd_t)
 corenet_udp_sendrecv_all_ports(syslogd_t)
Index: refpolicy_svn_repo/policy/modules/system/lvm.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/lvm.te
+++ refpolicy_svn_repo/policy/modules/system/lvm.te
@@ -69,7 +69,8 @@ kernel_dontaudit_getattr_core_if(clvmd_t
 corecmd_exec_shell(clvmd_t)
 corecmd_getattr_bin_files(clvmd_t)
 
-corenet_non_ipsec_sendrecv(clvmd_t)
+corenet_all_recvfrom_unlabeled(clvmd_t)
+corenet_all_recvfrom_netlabel(clvmd_t)
 corenet_tcp_sendrecv_all_if(clvmd_t)
 corenet_udp_sendrecv_all_if(clvmd_t)
 corenet_raw_sendrecv_all_if(clvmd_t)
Index: refpolicy_svn_repo/policy/modules/system/mount.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/mount.te
+++ refpolicy_svn_repo/policy/modules/system/mount.te
@@ -139,7 +139,8 @@ ifdef(`targeted_policy',`
 
 optional_policy(`
 	# for nfs
-	corenet_non_ipsec_sendrecv(mount_t)
+	corenet_all_recvfrom_unlabeled(mount_t)
+	corenet_all_recvfrom_netlabel(mount_t)
 	corenet_tcp_sendrecv_all_if(mount_t)
 	corenet_raw_sendrecv_all_if(mount_t)
 	corenet_udp_sendrecv_all_if(mount_t)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.if
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.if
@@ -480,7 +480,8 @@ interface(`sysnet_dns_name_resolve',`
 	allow $1 self:tcp_socket create_socket_perms;
 	allow $1 self:udp_socket create_socket_perms;
 
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
@@ -511,7 +512,8 @@ interface(`sysnet_use_ldap',`
 
 	allow $1 self:tcp_socket create_socket_perms;
 
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
 	corenet_tcp_sendrecv_ldap_port($1)
@@ -540,7 +542,8 @@ interface(`sysnet_use_portmap',`
 	allow $1 self:tcp_socket create_socket_perms;
 	allow $1 self:udp_socket create_socket_perms;
 
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_all_if($1)
 	corenet_udp_sendrecv_all_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
Index: refpolicy_svn_repo/policy/modules/system/sysnetwork.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/sysnetwork.te
+++ refpolicy_svn_repo/policy/modules/system/sysnetwork.te
@@ -84,7 +84,8 @@ kernel_read_network_state(dhcpc_t)
 kernel_read_kernel_sysctls(dhcpc_t)
 kernel_use_fds(dhcpc_t)
 
-corenet_non_ipsec_sendrecv(dhcpc_t)
+corenet_all_recvfrom_unlabeled(dhcpc_t)
+corenet_all_recvfrom_netlabel(dhcpc_t)
 corenet_tcp_sendrecv_all_if(dhcpc_t)
 corenet_raw_sendrecv_all_if(dhcpc_t)
 corenet_udp_sendrecv_all_if(dhcpc_t)
Index: refpolicy_svn_repo/policy/modules/system/userdomain.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/system/userdomain.if
+++ refpolicy_svn_repo/policy/modules/system/userdomain.if
@@ -537,7 +537,8 @@ template(`userdom_basic_networking_templ
 	allow $1_t self:tcp_socket create_stream_socket_perms;
 	allow $1_t self:udp_socket create_socket_perms;
 
-	corenet_non_ipsec_sendrecv($1_t)
+	corenet_all_recvfrom_unlabeled($1_t)
+	corenet_all_recvfrom_netlabel($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
@@ -546,12 +547,6 @@ template(`userdom_basic_networking_templ
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
@@ -132,7 +132,8 @@ kernel_read_network_state(xend_t)
 corecmd_exec_bin(xend_t)
 corecmd_exec_shell(xend_t)
 
-corenet_non_ipsec_sendrecv(xend_t)
+corenet_all_recvfrom_unlabeled(xend_t)
+corenet_all_recvfrom_netlabel(xend_t)
 corenet_tcp_sendrecv_all_if(xend_t)
 corenet_tcp_sendrecv_all_nodes(xend_t)
 corenet_tcp_sendrecv_all_ports(xend_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
