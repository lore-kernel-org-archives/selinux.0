Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LNLAZi002501
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:21:10 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LNL9bP001322
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 23:21:09 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070621232053.954015985@hp.com>
References: <20070621231507.402982591@hp.com>
Date: Thu, 21 Jun 2007 19:15:11 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCHv2 4/5] Add NetLabel labeled and unlabeled support to the application domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant application domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/apps/calamaris.te   |    3 ++-
 policy/modules/apps/evolution.if   |    9 ++++++---
 policy/modules/apps/games.if       |    3 ++-
 policy/modules/apps/gift.if        |    6 ++++--
 policy/modules/apps/gpg.if         |    6 ++++--
 policy/modules/apps/irc.if         |    3 ++-
 policy/modules/apps/java.if        |    3 ++-
 policy/modules/apps/mozilla.if     |    3 ++-
 policy/modules/apps/screen.if      |    3 ++-
 policy/modules/apps/thunderbird.if |    3 ++-
 policy/modules/apps/uml.if         |    3 ++-
 policy/modules/apps/vmware.te      |    3 ++-
 policy/modules/apps/webalizer.te   |    3 ++-
 policy/modules/apps/yam.te         |    3 ++-
 14 files changed, 36 insertions(+), 18 deletions(-)

Index: refpolicy_svn_repo/policy/modules/apps/calamaris.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/calamaris.te
+++ refpolicy_svn_repo/policy/modules/apps/calamaris.te
@@ -40,7 +40,8 @@ kernel_read_system_state(calamaris_t)
 
 corecmd_exec_bin(calamaris_t)
 
-corenet_non_ipsec_sendrecv(calamaris_t)
+corenet_all_recvfrom_unlabeled(calamaris_t)
+corenet_all_recvfrom_netlabel(calamaris_t)
 corenet_tcp_sendrecv_generic_if(calamaris_t)
 corenet_udp_sendrecv_generic_if(calamaris_t)
 corenet_tcp_sendrecv_all_nodes(calamaris_t)
Index: refpolicy_svn_repo/policy/modules/apps/evolution.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/evolution.if
+++ refpolicy_svn_repo/policy/modules/apps/evolution.if
@@ -188,7 +188,8 @@ template(`evolution_per_role_template',`
 	# Run various programs
 	corecmd_exec_bin($1_evolution_t)
 
-	corenet_non_ipsec_sendrecv($1_evolution_t)
+	corenet_all_recvfrom_unlabeled($1_evolution_t)
+	corenet_all_recvfrom_netlabel($1_evolution_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_t)
 	corenet_udp_sendrecv_generic_if($1_evolution_t)
 	corenet_raw_sendrecv_generic_if($1_evolution_t)
@@ -681,7 +682,8 @@ template(`evolution_per_role_template',`
 	corecmd_exec_shell($1_evolution_server_t)
 
 	# Obtain weather data via http (read server name from xml file in /usr)
-	corenet_non_ipsec_sendrecv($1_evolution_server_t)
+	corenet_all_recvfrom_unlabeled($1_evolution_server_t)
+	corenet_all_recvfrom_netlabel($1_evolution_server_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_server_t)
 	corenet_tcp_sendrecv_all_nodes($1_evolution_server_t)
 	corenet_tcp_sendrecv_http_port($1_evolution_server_t)
@@ -758,7 +760,8 @@ template(`evolution_per_role_template',`
 	# Transition from user type
 	domain_auto_trans($2, evolution_webcal_exec_t, $1_evolution_webcal_t)
 
-	corenet_non_ipsec_sendrecv($1_evolution_webcal_t)
+	corenet_all_recvfrom_unlabeled($1_evolution_webcal_t)
+	corenet_all_recvfrom_netlabel($1_evolution_webcal_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_webcal_t)
 	corenet_raw_sendrecv_generic_if($1_evolution_webcal_t)
 	corenet_tcp_sendrecv_all_nodes($1_evolution_webcal_t)
Index: refpolicy_svn_repo/policy/modules/apps/games.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/games.if
+++ refpolicy_svn_repo/policy/modules/apps/games.if
@@ -92,7 +92,8 @@ template(`games_per_role_template',`
 
 	corecmd_exec_bin($1_games_t)
 
-	corenet_non_ipsec_sendrecv($1_games_t)
+	corenet_all_recvfrom_unlabeled($1_games_t)
+	corenet_all_recvfrom_netlabel($1_games_t)
 	corenet_tcp_sendrecv_generic_if($1_games_t)
 	corenet_udp_sendrecv_generic_if($1_games_t)
 	corenet_tcp_sendrecv_all_nodes($1_games_t)
Index: refpolicy_svn_repo/policy/modules/apps/gift.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gift.if
+++ refpolicy_svn_repo/policy/modules/apps/gift.if
@@ -96,7 +96,8 @@ template(`gift_per_role_template',`
 	kernel_read_system_state($1_giftd_t)
 
 	# Connect to gift daemon
-	corenet_non_ipsec_sendrecv($1_gift_t)
+	corenet_all_recvfrom_unlabeled($1_gift_t)
+	corenet_all_recvfrom_netlabel($1_gift_t)
 	corenet_tcp_sendrecv_generic_if($1_gift_t)
 	corenet_tcp_sendrecv_all_nodes($1_gift_t)
 	corenet_tcp_sendrecv_giftd_port($1_gift_t)
@@ -155,7 +156,8 @@ template(`gift_per_role_template',`
 	kernel_read_kernel_sysctls($1_giftd_t)
 
 	# Serve content on various p2p networks. Ports can be random.
-	corenet_non_ipsec_sendrecv($1_giftd_t)
+	corenet_all_recvfrom_unlabeled($1_giftd_t)
+	corenet_all_recvfrom_netlabel($1_giftd_t)
 	corenet_tcp_sendrecv_generic_if($1_giftd_t)
 	corenet_udp_sendrecv_generic_if($1_giftd_t)
 	corenet_tcp_sendrecv_all_nodes($1_giftd_t)
Index: refpolicy_svn_repo/policy/modules/apps/gpg.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gpg.if
+++ refpolicy_svn_repo/policy/modules/apps/gpg.if
@@ -98,7 +98,8 @@ template(`gpg_per_role_template',`
 	# allow ps to show gpg
 	ps_process_pattern($2,$1_gpg_t)
 
-	corenet_non_ipsec_sendrecv($1_gpg_t)
+	corenet_all_recvfrom_unlabeled($1_gpg_t)
+	corenet_all_recvfrom_netlabel($1_gpg_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_t)
 	corenet_udp_sendrecv_all_if($1_gpg_t)
 	corenet_tcp_sendrecv_all_nodes($1_gpg_t)
@@ -161,6 +162,8 @@ template(`gpg_per_role_template',`
 
 	dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
 
+	corenet_all_recvfrom_unlabeled($1_gpg_helper_t)
+	corenet_all_recvfrom_netlabel($1_gpg_helper_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_helper_t)
 	corenet_raw_sendrecv_all_if($1_gpg_helper_t)
 	corenet_udp_sendrecv_all_if($1_gpg_helper_t)
@@ -169,7 +172,6 @@ template(`gpg_per_role_template',`
 	corenet_raw_sendrecv_all_nodes($1_gpg_helper_t)
 	corenet_tcp_sendrecv_all_ports($1_gpg_helper_t)
 	corenet_udp_sendrecv_all_ports($1_gpg_helper_t)
-	corenet_non_ipsec_sendrecv($1_gpg_helper_t)
 	corenet_tcp_bind_all_nodes($1_gpg_helper_t)
 	corenet_udp_bind_all_nodes($1_gpg_helper_t)
 	corenet_tcp_connect_all_ports($1_gpg_helper_t)
Index: refpolicy_svn_repo/policy/modules/apps/irc.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/irc.if
+++ refpolicy_svn_repo/policy/modules/apps/irc.if
@@ -90,7 +90,8 @@ template(`irc_per_role_template',`
 	
 	kernel_read_proc_symlinks($1_irc_t)
 
-	corenet_non_ipsec_sendrecv($1_irc_t)
+	corenet_all_recvfrom_unlabeled($1_irc_t)
+	corenet_all_recvfrom_netlabel($1_irc_t)
 	corenet_tcp_sendrecv_generic_if($1_irc_t)
 	corenet_udp_sendrecv_generic_if($1_irc_t)
 	corenet_tcp_sendrecv_all_nodes($1_irc_t)
Index: refpolicy_svn_repo/policy/modules/apps/java.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/java.if
+++ refpolicy_svn_repo/policy/modules/apps/java.if
@@ -97,7 +97,8 @@ template(`java_per_role_template',`
 	# Search bin directory under javaplugin for javaplugin executable
 	corecmd_search_bin($1_javaplugin_t)
 
-	corenet_non_ipsec_sendrecv($1_javaplugin_t)
+	corenet_all_recvfrom_unlabeled($1_javaplugin_t)
+	corenet_all_recvfrom_netlabel($1_javaplugin_t)
 	corenet_tcp_sendrecv_generic_if($1_javaplugin_t)
 	corenet_udp_sendrecv_generic_if($1_javaplugin_t)
 	corenet_tcp_sendrecv_all_nodes($1_javaplugin_t)
Index: refpolicy_svn_repo/policy/modules/apps/mozilla.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/mozilla.if
+++ refpolicy_svn_repo/policy/modules/apps/mozilla.if
@@ -126,7 +126,8 @@ template(`mozilla_per_role_template',`
 	corecmd_exec_bin($1_mozilla_t)
 
 	# Browse the web, connect to printer
-	corenet_non_ipsec_sendrecv($1_mozilla_t)
+	corenet_all_recvfrom_unlabeled($1_mozilla_t)
+	corenet_all_recvfrom_netlabel($1_mozilla_t)
 	corenet_tcp_sendrecv_generic_if($1_mozilla_t)
 	corenet_raw_sendrecv_generic_if($1_mozilla_t)
 	corenet_tcp_sendrecv_all_nodes($1_mozilla_t)
Index: refpolicy_svn_repo/policy/modules/apps/screen.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/screen.if
+++ refpolicy_svn_repo/policy/modules/apps/screen.if
@@ -111,7 +111,8 @@ template(`screen_per_role_template',`
 	corecmd_shell_domtrans($1_screen_t,$2)
 	corecmd_bin_domtrans($1_screen_t,$2)
 
-	corenet_non_ipsec_sendrecv($1_screen_t)
+	corenet_all_recvfrom_unlabeled($1_screen_t)
+	corenet_all_recvfrom_netlabel($1_screen_t)
 	corenet_tcp_sendrecv_generic_if($1_screen_t)
 	corenet_udp_sendrecv_generic_if($1_screen_t)
 	corenet_tcp_sendrecv_all_nodes($1_screen_t)
Index: refpolicy_svn_repo/policy/modules/apps/thunderbird.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/thunderbird.if
+++ refpolicy_svn_repo/policy/modules/apps/thunderbird.if
@@ -105,7 +105,8 @@ template(`thunderbird_per_role_template'
 	# Startup shellscript
 	corecmd_exec_shell($1_thunderbird_t)
 
-	corenet_non_ipsec_sendrecv($1_thunderbird_t)
+	corenet_all_recvfrom_unlabeled($1_thunderbird_t)
+	corenet_all_recvfrom_netlabel($1_thunderbird_t)
 	corenet_tcp_sendrecv_generic_if($1_thunderbird_t)
 	corenet_tcp_sendrecv_all_nodes($1_thunderbird_t)
 	corenet_tcp_sendrecv_ipp_port($1_thunderbird_t)
Index: refpolicy_svn_repo/policy/modules/apps/uml.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/uml.if
+++ refpolicy_svn_repo/policy/modules/apps/uml.if
@@ -152,7 +152,8 @@ template(`uml_per_role_template',`
 	# for xterm
 	corecmd_exec_bin($1_uml_t)
 
-	corenet_non_ipsec_sendrecv($1_uml_t)
+	corenet_all_recvfrom_unlabeled($1_uml_t)
+	corenet_all_recvfrom_netlabel($1_uml_t)
 	corenet_tcp_sendrecv_generic_if($1_uml_t)
 	corenet_udp_sendrecv_generic_if($1_uml_t)
 	corenet_tcp_sendrecv_all_nodes($1_uml_t)
Index: refpolicy_svn_repo/policy/modules/apps/vmware.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/vmware.te
+++ refpolicy_svn_repo/policy/modules/apps/vmware.te
@@ -45,7 +45,8 @@ kernel_read_kernel_sysctls(vmware_host_t
 kernel_list_proc(vmware_host_t)
 kernel_read_proc_symlinks(vmware_host_t)
 
-corenet_non_ipsec_sendrecv(vmware_host_t)
+corenet_all_recvfrom_unlabeled(vmware_host_t)
+corenet_all_recvfrom_netlabel(vmware_host_t)
 corenet_tcp_sendrecv_generic_if(vmware_host_t)
 corenet_udp_sendrecv_generic_if(vmware_host_t)
 corenet_raw_sendrecv_generic_if(vmware_host_t)
Index: refpolicy_svn_repo/policy/modules/apps/webalizer.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/webalizer.te
+++ refpolicy_svn_repo/policy/modules/apps/webalizer.te
@@ -61,7 +61,8 @@ files_var_lib_filetrans(webalizer_t,weba
 kernel_read_kernel_sysctls(webalizer_t)
 kernel_read_system_state(webalizer_t)
 
-corenet_non_ipsec_sendrecv(webalizer_t)
+corenet_all_recvfrom_unlabeled(webalizer_t)
+corenet_all_recvfrom_netlabel(webalizer_t)
 corenet_tcp_sendrecv_all_if(webalizer_t)
 corenet_tcp_sendrecv_all_nodes(webalizer_t)
 corenet_tcp_sendrecv_all_ports(webalizer_t)
Index: refpolicy_svn_repo/policy/modules/apps/yam.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/yam.te
+++ refpolicy_svn_repo/policy/modules/apps/yam.te
@@ -60,7 +60,8 @@ corecmd_exec_bin(yam_t)
 
 # Rsync and lftp need to network.  They also set files attributes to
 # match whats on the remote server.
-corenet_non_ipsec_sendrecv(yam_t)
+corenet_all_recvfrom_unlabeled(yam_t)
+corenet_all_recvfrom_netlabel(yam_t)
 corenet_tcp_sendrecv_generic_if(yam_t)
 corenet_tcp_sendrecv_all_nodes(yam_t)
 corenet_tcp_sendrecv_all_ports(yam_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
