Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QJ7PhB032696
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 14:07:25 -0500
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QJ7FQG012819
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 19:07:15 GMT
Received: from g4t0017.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id B119F380B8
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:06 +0000 (UTC)
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id A484D38041
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:06 +0000 (UTC)
Message-Id: <20080226184405.866808552@hp.com>
References: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:34 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/5] REFPOL: Allow network admin domains to receive unlabeled traffic
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the corenet_recvfrom_unlabeled_peer() interface call to
all of the admin modules which need to receive data over the network.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/admin/amanda.te    |    5 ++++-
 policy/modules/admin/apt.te       |    1 +
 policy/modules/admin/backup.te    |    1 +
 policy/modules/admin/dpkg.te      |    1 +
 policy/modules/admin/firstboot.te |    1 +
 policy/modules/admin/mrtg.te      |    1 +
 policy/modules/admin/netutils.te  |    3 +++
 policy/modules/admin/portage.if   |    2 ++
 policy/modules/admin/rpm.te       |    1 +
 policy/modules/admin/sxid.te      |    1 +
 policy/modules/admin/vpn.te       |    1 +
 11 files changed, 17 insertions(+), 1 deletion(-)

Index: refpolicy_svn_repo/policy/modules/admin/amanda.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/amanda.te
+++ refpolicy_svn_repo/policy/modules/admin/amanda.te
@@ -1,4 +1,5 @@
 
+
 policy_module(amanda,1.8.0)
 
 #######################################
@@ -115,8 +116,9 @@ kernel_dontaudit_read_proc_symlinks(aman
 corecmd_exec_shell(amanda_t)
 corecmd_exec_bin(amanda_t)
 
-corenet_all_recvfrom_unlabeled(amanda_t)
+corenet_recvfrom_unlabeled_peer(amanda_t)
 corenet_all_recvfrom_netlabel(amanda_t)
+corenet_recvfrom_unlabeled_peer(amanda_t)
 corenet_tcp_sendrecv_all_if(amanda_t)
 corenet_udp_sendrecv_all_if(amanda_t)
 corenet_raw_sendrecv_all_if(amanda_t)
@@ -197,6 +199,7 @@ corecmd_exec_shell(amanda_recover_t)
 corecmd_exec_bin(amanda_recover_t)
 
 corenet_all_recvfrom_unlabeled(amanda_recover_t)
+corenet_recvfrom_unlabeled_peer(amanda_recover_t)
 corenet_all_recvfrom_netlabel(amanda_recover_t)
 corenet_tcp_sendrecv_all_if(amanda_recover_t)
 corenet_udp_sendrecv_all_if(amanda_recover_t)
Index: refpolicy_svn_repo/policy/modules/admin/apt.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/apt.te
+++ refpolicy_svn_repo/policy/modules/admin/apt.te
@@ -73,6 +73,7 @@ corecmd_exec_bin(apt_t)
 corecmd_exec_shell(apt_t)
 
 corenet_all_recvfrom_unlabeled(apt_t)
+corenet_recvfrom_unlabeled_peer(apt_t)
 corenet_all_recvfrom_netlabel(apt_t)
 corenet_tcp_sendrecv_all_if(apt_t)
 corenet_udp_sendrecv_all_if(apt_t)
Index: refpolicy_svn_repo/policy/modules/admin/backup.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/backup.te
+++ refpolicy_svn_repo/policy/modules/admin/backup.te
@@ -38,6 +38,7 @@ corecmd_exec_bin(backup_t)
 corecmd_exec_shell(backup_t)
 
 corenet_all_recvfrom_unlabeled(backup_t)
+corenet_recvfrom_unlabeled_peer(backup_t)
 corenet_all_recvfrom_netlabel(backup_t)
 corenet_tcp_sendrecv_generic_if(backup_t)
 corenet_udp_sendrecv_generic_if(backup_t)
Index: refpolicy_svn_repo/policy/modules/admin/dpkg.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/dpkg.te
+++ refpolicy_svn_repo/policy/modules/admin/dpkg.te
@@ -91,6 +91,7 @@ corecmd_exec_all_executables(dpkg_t)
 
 # TODO: do we really need all networking?
 corenet_all_recvfrom_unlabeled(dpkg_t)
+corenet_recvfrom_unlabeled_peer(dpkg_t)
 corenet_all_recvfrom_netlabel(dpkg_t)
 corenet_tcp_sendrecv_all_if(dpkg_t)
 corenet_raw_sendrecv_all_if(dpkg_t)
Index: refpolicy_svn_repo/policy/modules/admin/firstboot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/firstboot.te
+++ refpolicy_svn_repo/policy/modules/admin/firstboot.te
@@ -42,6 +42,7 @@ kernel_read_system_state(firstboot_t)
 kernel_read_kernel_sysctls(firstboot_t)
 
 corenet_all_recvfrom_unlabeled(firstboot_t)
+corenet_recvfrom_unlabeled_peer(firstboot_t)
 corenet_all_recvfrom_netlabel(firstboot_t)
 corenet_tcp_sendrecv_all_if(firstboot_t)
 corenet_tcp_sendrecv_all_nodes(firstboot_t)
Index: refpolicy_svn_repo/policy/modules/admin/mrtg.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/mrtg.te
+++ refpolicy_svn_repo/policy/modules/admin/mrtg.te
@@ -64,6 +64,7 @@ corecmd_exec_bin(mrtg_t)
 corecmd_exec_shell(mrtg_t)
 
 corenet_all_recvfrom_unlabeled(mrtg_t)
+corenet_recvfrom_unlabeled_peer(mrtg_t)
 corenet_all_recvfrom_netlabel(mrtg_t)
 corenet_tcp_sendrecv_generic_if(mrtg_t)
 corenet_udp_sendrecv_generic_if(mrtg_t)
Index: refpolicy_svn_repo/policy/modules/admin/netutils.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/netutils.te
+++ refpolicy_svn_repo/policy/modules/admin/netutils.te
@@ -52,6 +52,7 @@ files_tmp_filetrans(netutils_t, netutils
 kernel_search_proc(netutils_t)
 
 corenet_all_recvfrom_unlabeled(netutils_t)
+corenet_recvfrom_unlabeled_peer(netutils_t)
 corenet_all_recvfrom_netlabel(netutils_t)
 corenet_tcp_sendrecv_all_if(netutils_t)
 corenet_raw_sendrecv_all_if(netutils_t)
@@ -109,6 +110,7 @@ allow ping_t self:rawip_socket { create 
 allow ping_t self:packet_socket { create ioctl read write bind getopt setopt };
 
 corenet_all_recvfrom_unlabeled(ping_t)
+corenet_recvfrom_unlabeled_peer(ping_t)
 corenet_all_recvfrom_netlabel(ping_t)
 corenet_tcp_sendrecv_all_if(ping_t)
 corenet_raw_sendrecv_all_if(ping_t)
@@ -173,6 +175,7 @@ kernel_read_system_state(traceroute_t)
 kernel_read_network_state(traceroute_t)
 
 corenet_all_recvfrom_unlabeled(traceroute_t)
+corenet_recvfrom_unlabeled_peer(traceroute_t)
 corenet_all_recvfrom_netlabel(traceroute_t)
 corenet_tcp_sendrecv_all_if(traceroute_t)
 corenet_udp_sendrecv_all_if(traceroute_t)
Index: refpolicy_svn_repo/policy/modules/admin/portage.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/portage.if
+++ refpolicy_svn_repo/policy/modules/admin/portage.if
@@ -153,6 +153,7 @@ interface(`portage_compile_domain',`
 	# network access, such as during configure
 	# also distcc--need to reinvestigate confining distcc client
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_generic_if($1)
 	corenet_udp_sendrecv_generic_if($1)
@@ -244,6 +245,7 @@ interface(`portage_fetch_domain',`
 	corecmd_exec_bin($1)
 
 	corenet_all_recvfrom_unlabeled($1)
+	corenet_recvfrom_unlabeled_peer($1)
 	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_generic_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
Index: refpolicy_svn_repo/policy/modules/admin/rpm.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/rpm.te
+++ refpolicy_svn_repo/policy/modules/admin/rpm.te
@@ -95,6 +95,7 @@ kernel_read_kernel_sysctls(rpm_t)
 corecmd_exec_all_executables(rpm_t)
 
 corenet_all_recvfrom_unlabeled(rpm_t)
+corenet_recvfrom_unlabeled_peer(rpm_t)
 corenet_all_recvfrom_netlabel(rpm_t)
 corenet_tcp_sendrecv_all_if(rpm_t)
 corenet_raw_sendrecv_all_if(rpm_t)
Index: refpolicy_svn_repo/policy/modules/admin/sxid.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/sxid.te
+++ refpolicy_svn_repo/policy/modules/admin/sxid.te
@@ -42,6 +42,7 @@ corecmd_exec_bin(sxid_t)
 corecmd_exec_shell(sxid_t)
 
 corenet_all_recvfrom_unlabeled(sxid_t)
+corenet_recvfrom_unlabeled_peer(sxid_t)
 corenet_all_recvfrom_netlabel(sxid_t)
 corenet_tcp_sendrecv_generic_if(sxid_t)
 corenet_udp_sendrecv_generic_if(sxid_t)
Index: refpolicy_svn_repo/policy/modules/admin/vpn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/vpn.te
+++ refpolicy_svn_repo/policy/modules/admin/vpn.te
@@ -47,6 +47,7 @@ kernel_read_kernel_sysctls(vpnc_t)
 kernel_rw_net_sysctls(vpnc_t)
 
 corenet_all_recvfrom_unlabeled(vpnc_t)
+corenet_recvfrom_unlabeled_peer(vpnc_t)
 corenet_all_recvfrom_netlabel(vpnc_t)
 corenet_tcp_sendrecv_all_if(vpnc_t)
 corenet_udp_sendrecv_all_if(vpnc_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
