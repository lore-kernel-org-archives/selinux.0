Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LNLrJO002548
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:21:53 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LNLqnL019243
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 23:21:52 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070621232055.362259099@hp.com>
References: <20070621231507.402982591@hp.com>
Date: Thu, 21 Jun 2007 19:15:12 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCHv2 5/5] Add NetLabel labeled and unlabeled support to the administrative domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant administrative domains access to NetLabel labeled and unlabeled
packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/admin/amanda.te    |    6 ++++--
 policy/modules/admin/apt.te       |    3 ++-
 policy/modules/admin/backup.te    |    3 ++-
 policy/modules/admin/dpkg.te      |    3 ++-
 policy/modules/admin/firstboot.te |    3 ++-
 policy/modules/admin/mrtg.te      |    3 ++-
 policy/modules/admin/netutils.te  |    9 ++++++---
 policy/modules/admin/portage.if   |    6 ++++--
 policy/modules/admin/rpm.te       |    3 ++-
 policy/modules/admin/sxid.te      |    3 ++-
 policy/modules/admin/vpn.te       |    3 ++-
 11 files changed, 30 insertions(+), 15 deletions(-)

Index: refpolicy_svn_repo/policy/modules/admin/amanda.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/amanda.te
+++ refpolicy_svn_repo/policy/modules/admin/amanda.te
@@ -113,7 +113,8 @@ kernel_dontaudit_read_proc_symlinks(aman
 # Added for targeted policy
 term_use_unallocated_ttys(amanda_t)
 
-corenet_non_ipsec_sendrecv(amanda_t)
+corenet_all_recvfrom_unlabeled(amanda_t)
+corenet_all_recvfrom_netlabel(amanda_t)
 corenet_tcp_sendrecv_all_if(amanda_t)
 corenet_udp_sendrecv_all_if(amanda_t)
 corenet_raw_sendrecv_all_if(amanda_t)
@@ -200,7 +201,8 @@ files_tmp_filetrans(amanda_recover_t,ama
 kernel_read_system_state(amanda_recover_t)
 kernel_read_kernel_sysctls(amanda_recover_t)
 
-corenet_non_ipsec_sendrecv(amanda_recover_t)
+corenet_all_recvfrom_unlabeled(amanda_recover_t)
+corenet_all_recvfrom_netlabel(amanda_recover_t)
 corenet_tcp_sendrecv_all_if(amanda_recover_t)
 corenet_udp_sendrecv_all_if(amanda_recover_t)
 corenet_tcp_sendrecv_all_nodes(amanda_recover_t)
Index: refpolicy_svn_repo/policy/modules/admin/apt.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/apt.te
+++ refpolicy_svn_repo/policy/modules/admin/apt.te
@@ -72,7 +72,8 @@ kernel_read_kernel_sysctls(apt_t)
 corecmd_exec_bin(apt_t)
 corecmd_exec_shell(apt_t)
 
-corenet_non_ipsec_sendrecv(apt_t)
+corenet_all_recvfrom_unlabeled(apt_t)
+corenet_all_recvfrom_netlabel(apt_t)
 corenet_tcp_sendrecv_all_if(apt_t)
 corenet_udp_sendrecv_all_if(apt_t)
 corenet_tcp_sendrecv_all_nodes(apt_t)
Index: refpolicy_svn_repo/policy/modules/admin/backup.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/backup.te
+++ refpolicy_svn_repo/policy/modules/admin/backup.te
@@ -36,7 +36,8 @@ kernel_read_kernel_sysctls(backup_t)
 
 corecmd_exec_bin(backup_t)
 
-corenet_non_ipsec_sendrecv(backup_t)
+corenet_all_recvfrom_unlabeled(backup_t)
+corenet_all_recvfrom_netlabel(backup_t)
 corenet_tcp_sendrecv_generic_if(backup_t)
 corenet_udp_sendrecv_generic_if(backup_t)
 corenet_raw_sendrecv_generic_if(backup_t)
Index: refpolicy_svn_repo/policy/modules/admin/dpkg.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/dpkg.te
+++ refpolicy_svn_repo/policy/modules/admin/dpkg.te
@@ -90,7 +90,8 @@ kernel_read_kernel_sysctls(dpkg_t)
 corecmd_exec_all_executables(dpkg_t)
 
 # TODO: do we really need all networking?
-corenet_non_ipsec_sendrecv(dpkg_t)
+corenet_all_recvfrom_unlabeled(dpkg_t)
+corenet_all_recvfrom_netlabel(dpkg_t)
 corenet_tcp_sendrecv_all_if(dpkg_t)
 corenet_raw_sendrecv_all_if(dpkg_t)
 corenet_udp_sendrecv_all_if(dpkg_t)
Index: refpolicy_svn_repo/policy/modules/admin/firstboot.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/firstboot.te
+++ refpolicy_svn_repo/policy/modules/admin/firstboot.te
@@ -41,7 +41,8 @@ unconfined_domain(firstboot_t) 
 kernel_read_system_state(firstboot_t)
 kernel_read_kernel_sysctls(firstboot_t)
 
-corenet_non_ipsec_sendrecv(firstboot_t)
+corenet_all_recvfrom_unlabeled(firstboot_t)
+corenet_all_recvfrom_netlabel(firstboot_t)
 corenet_tcp_sendrecv_all_if(firstboot_t)
 corenet_tcp_sendrecv_all_nodes(firstboot_t)
 corenet_tcp_sendrecv_all_ports(firstboot_t)
Index: refpolicy_svn_repo/policy/modules/admin/mrtg.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/mrtg.te
+++ refpolicy_svn_repo/policy/modules/admin/mrtg.te
@@ -63,7 +63,8 @@ kernel_read_kernel_sysctls(mrtg_t)
 corecmd_exec_bin(mrtg_t)
 corecmd_exec_shell(mrtg_t)
 
-corenet_non_ipsec_sendrecv(mrtg_t)
+corenet_all_recvfrom_unlabeled(mrtg_t)
+corenet_all_recvfrom_netlabel(mrtg_t)
 corenet_tcp_sendrecv_generic_if(mrtg_t)
 corenet_udp_sendrecv_generic_if(mrtg_t)
 corenet_tcp_sendrecv_all_nodes(mrtg_t)
Index: refpolicy_svn_repo/policy/modules/admin/netutils.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/netutils.te
+++ refpolicy_svn_repo/policy/modules/admin/netutils.te
@@ -53,7 +53,8 @@ files_tmp_filetrans(netutils_t, netutils
 
 kernel_search_proc(netutils_t)
 
-corenet_non_ipsec_sendrecv(netutils_t)
+corenet_all_recvfrom_unlabeled(netutils_t)
+corenet_all_recvfrom_netlabel(netutils_t)
 corenet_tcp_sendrecv_all_if(netutils_t)
 corenet_raw_sendrecv_all_if(netutils_t)
 corenet_udp_sendrecv_all_if(netutils_t)
@@ -114,7 +115,8 @@ allow ping_t self:tcp_socket create_sock
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
 allow ping_t self:packet_socket { create ioctl read write bind getopt setopt };
 
-corenet_non_ipsec_sendrecv(ping_t)
+corenet_all_recvfrom_unlabeled(ping_t)
+corenet_all_recvfrom_netlabel(ping_t)
 corenet_tcp_sendrecv_all_if(ping_t)
 corenet_raw_sendrecv_all_if(ping_t)
 corenet_raw_sendrecv_all_nodes(ping_t)
@@ -184,7 +186,8 @@ allow traceroute_t self:udp_socket creat
 kernel_read_system_state(traceroute_t)
 kernel_read_network_state(traceroute_t)
 
-corenet_non_ipsec_sendrecv(traceroute_t)
+corenet_all_recvfrom_unlabeled(traceroute_t)
+corenet_all_recvfrom_netlabel(traceroute_t)
 corenet_tcp_sendrecv_all_if(traceroute_t)
 corenet_udp_sendrecv_all_if(traceroute_t)
 corenet_raw_sendrecv_all_if(traceroute_t)
Index: refpolicy_svn_repo/policy/modules/admin/portage.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/portage.if
+++ refpolicy_svn_repo/policy/modules/admin/portage.if
@@ -152,7 +152,8 @@ interface(`portage_compile_domain',`
 	# really shouldnt need this but some packages test
 	# network access, such as during configure
 	# also distcc--need to reinvestigate confining distcc client
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_generic_if($1)
 	corenet_udp_sendrecv_generic_if($1)
 	corenet_raw_sendrecv_generic_if($1)
@@ -242,7 +243,8 @@ interface(`portage_fetch_domain',`
 
 	corecmd_exec_bin($1)
 
-	corenet_non_ipsec_sendrecv($1)
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
 	corenet_tcp_sendrecv_generic_if($1)
 	corenet_tcp_sendrecv_all_nodes($1)
 	corenet_tcp_sendrecv_all_ports($1)
Index: refpolicy_svn_repo/policy/modules/admin/rpm.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/rpm.te
+++ refpolicy_svn_repo/policy/modules/admin/rpm.te
@@ -91,7 +91,8 @@ kernel_read_kernel_sysctls(rpm_t)
 
 corecmd_exec_all_executables(rpm_t)
 
-corenet_non_ipsec_sendrecv(rpm_t)
+corenet_all_recvfrom_unlabeled(rpm_t)
+corenet_all_recvfrom_netlabel(rpm_t)
 corenet_tcp_sendrecv_all_if(rpm_t)
 corenet_raw_sendrecv_all_if(rpm_t)
 corenet_udp_sendrecv_all_if(rpm_t)
Index: refpolicy_svn_repo/policy/modules/admin/sxid.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/sxid.te
+++ refpolicy_svn_repo/policy/modules/admin/sxid.te
@@ -42,7 +42,8 @@ kernel_read_kernel_sysctls(sxid_t)
 corecmd_exec_bin(sxid_t)
 corecmd_exec_shell(sxid_t)
 
-corenet_non_ipsec_sendrecv(sxid_t)
+corenet_all_recvfrom_unlabeled(sxid_t)
+corenet_all_recvfrom_netlabel(sxid_t)
 corenet_tcp_sendrecv_generic_if(sxid_t)
 corenet_udp_sendrecv_generic_if(sxid_t)
 corenet_tcp_sendrecv_all_nodes(sxid_t)
Index: refpolicy_svn_repo/policy/modules/admin/vpn.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/admin/vpn.te
+++ refpolicy_svn_repo/policy/modules/admin/vpn.te
@@ -48,7 +48,8 @@ kernel_read_network_state(vpnc_t)
 kernel_read_kernel_sysctls(vpnc_t)
 kernel_rw_net_sysctls(vpnc_t)
 
-corenet_non_ipsec_sendrecv(vpnc_t)
+corenet_all_recvfrom_unlabeled(vpnc_t)
+corenet_all_recvfrom_netlabel(vpnc_t)
 corenet_tcp_sendrecv_all_if(vpnc_t)
 corenet_udp_sendrecv_all_if(vpnc_t)
 corenet_raw_sendrecv_all_if(vpnc_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
