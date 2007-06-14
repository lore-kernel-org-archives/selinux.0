Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK2oZH029410
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:02:50 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EK2ms2016603
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:48 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614200102.768782258@hp.com>
References: <20070614195502.420663549@hp.com>
Date: Thu, 14 Jun 2007 15:55:06 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 4/5] Add NetLabel labeled and unlabeled support to the application domains
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds calls to the NetLabel corenet policy interfaces to grant the
relevant application domains access to NetLabel labeled and unlabeled packets.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/apps/calamaris.te   |    4 ++++
 policy/modules/apps/evolution.if   |   14 ++++++++++++++
 policy/modules/apps/games.if       |    4 ++++
 policy/modules/apps/gift.if        |    6 ++++++
 policy/modules/apps/gpg.if         |   12 +++++++++++-
 policy/modules/apps/irc.if         |    4 ++++
 policy/modules/apps/java.if        |    4 ++++
 policy/modules/apps/mozilla.if     |    4 ++++
 policy/modules/apps/screen.if      |    4 ++++
 policy/modules/apps/thunderbird.if |    2 ++
 policy/modules/apps/uml.if         |    4 ++++
 policy/modules/apps/vmware.te      |    6 ++++++
 policy/modules/apps/webalizer.te   |    2 ++
 policy/modules/apps/yam.te         |    2 ++
 14 files changed, 71 insertions(+), 1 deletion(-)

Index: refpolicy_svn_repo/policy/modules/apps/calamaris.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/calamaris.te
+++ refpolicy_svn_repo/policy/modules/apps/calamaris.te
@@ -40,6 +40,10 @@ kernel_read_system_state(calamaris_t)
 
 corecmd_exec_bin(calamaris_t)
 
+corenet_tcp_recv_unlabeled(calamaris_t)
+corenet_udp_recv_unlabeled(calamaris_t)
+corenet_tcp_recv_netlabel(calamaris_t)
+corenet_udp_recv_netlabel(calamaris_t)
 corenet_non_ipsec_sendrecv(calamaris_t)
 corenet_tcp_sendrecv_generic_if(calamaris_t)
 corenet_udp_sendrecv_generic_if(calamaris_t)
Index: refpolicy_svn_repo/policy/modules/apps/evolution.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/evolution.if
+++ refpolicy_svn_repo/policy/modules/apps/evolution.if
@@ -188,6 +188,12 @@ template(`evolution_per_role_template',`
 	# Run various programs
 	corecmd_exec_bin($1_evolution_t)
 
+	corenet_tcp_recv_unlabeled($1_evolution_t)
+	corenet_udp_recv_unlabeled($1_evolution_t)
+	corenet_raw_recv_unlabeled($1_evolution_t)
+	corenet_tcp_recv_netlabel($1_evolution_t)
+	corenet_udp_recv_netlabel($1_evolution_t)
+	corenet_raw_recv_netlabel($1_evolution_t)
 	corenet_non_ipsec_sendrecv($1_evolution_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_t)
 	corenet_udp_sendrecv_generic_if($1_evolution_t)
@@ -681,6 +687,8 @@ template(`evolution_per_role_template',`
 	corecmd_exec_shell($1_evolution_server_t)
 
 	# Obtain weather data via http (read server name from xml file in /usr)
+	corenet_tcp_recv_unlabeled($1_evolution_server_t)
+	corenet_tcp_recv_netlabel($1_evolution_server_t)
 	corenet_non_ipsec_sendrecv($1_evolution_server_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_server_t)
 	corenet_tcp_sendrecv_all_nodes($1_evolution_server_t)
@@ -758,6 +766,12 @@ template(`evolution_per_role_template',`
 	# Transition from user type
 	domain_auto_trans($2, evolution_webcal_exec_t, $1_evolution_webcal_t)
 
+	corenet_tcp_recv_unlabeled($1_evolution_webcal_t)
+	corenet_udp_recv_unlabeled($1_evolution_webcal_t)
+	corenet_raw_recv_unlabeled($1_evolution_webcal_t)
+	corenet_tcp_recv_netlabel($1_evolution_webcal_t)
+	corenet_udp_recv_netlabel($1_evolution_webcal_t)
+	corenet_raw_recv_netlabel($1_evolution_webcal_t)
 	corenet_non_ipsec_sendrecv($1_evolution_webcal_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_webcal_t)
 	corenet_raw_sendrecv_generic_if($1_evolution_webcal_t)
Index: refpolicy_svn_repo/policy/modules/apps/games.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/games.if
+++ refpolicy_svn_repo/policy/modules/apps/games.if
@@ -92,6 +92,10 @@ template(`games_per_role_template',`
 
 	corecmd_exec_bin($1_games_t)
 
+	corenet_tcp_recv_unlabeled($1_games_t)
+	corenet_udp_recv_unlabeled($1_games_t)
+	corenet_tcp_recv_netlabel($1_games_t)
+	corenet_udp_recv_netlabel($1_games_t)
 	corenet_non_ipsec_sendrecv($1_games_t)
 	corenet_tcp_sendrecv_generic_if($1_games_t)
 	corenet_udp_sendrecv_generic_if($1_games_t)
Index: refpolicy_svn_repo/policy/modules/apps/gift.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gift.if
+++ refpolicy_svn_repo/policy/modules/apps/gift.if
@@ -96,6 +96,8 @@ template(`gift_per_role_template',`
 	kernel_read_system_state($1_giftd_t)
 
 	# Connect to gift daemon
+	corenet_tcp_recv_unlabeled($1_gift_t)
+	corenet_tcp_recv_netlabel($1_gift_t)
 	corenet_non_ipsec_sendrecv($1_gift_t)
 	corenet_tcp_sendrecv_generic_if($1_gift_t)
 	corenet_tcp_sendrecv_all_nodes($1_gift_t)
@@ -155,6 +157,10 @@ template(`gift_per_role_template',`
 	kernel_read_kernel_sysctls($1_giftd_t)
 
 	# Serve content on various p2p networks. Ports can be random.
+	corenet_tcp_recv_unlabeled($1_giftd_t)
+	corenet_udp_recv_unlabeled($1_giftd_t)
+	corenet_tcp_recv_netlabel($1_giftd_t)
+	corenet_udp_recv_netlabel($1_giftd_t)
 	corenet_non_ipsec_sendrecv($1_giftd_t)
 	corenet_tcp_sendrecv_generic_if($1_giftd_t)
 	corenet_udp_sendrecv_generic_if($1_giftd_t)
Index: refpolicy_svn_repo/policy/modules/apps/gpg.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gpg.if
+++ refpolicy_svn_repo/policy/modules/apps/gpg.if
@@ -98,6 +98,10 @@ template(`gpg_per_role_template',`
 	# allow ps to show gpg
 	ps_process_pattern($2,$1_gpg_t)
 
+	corenet_tcp_recv_unlabeled($1_gpg_t)
+	corenet_udp_recv_unlabeled($1_gpg_t)
+	corenet_tcp_recv_netlabel($1_gpg_t)
+	corenet_udp_recv_netlabel($1_gpg_t)
 	corenet_non_ipsec_sendrecv($1_gpg_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_t)
 	corenet_udp_sendrecv_all_if($1_gpg_t)
@@ -161,6 +165,13 @@ template(`gpg_per_role_template',`
 
 	dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
 
+	corenet_tcp_recv_unlabeled($1_gpg_helper_t)
+	corenet_udp_recv_unlabeled($1_gpg_helper_t)
+	corenet_raw_recv_unlabeled($1_gpg_helper_t)
+	corenet_tcp_recv_netlabel($1_gpg_helper_t)
+	corenet_udp_recv_netlabel($1_gpg_helper_t)
+	corenet_raw_recv_netlabel($1_gpg_helper_t)
+	corenet_non_ipsec_sendrecv($1_gpg_helper_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_helper_t)
 	corenet_raw_sendrecv_all_if($1_gpg_helper_t)
 	corenet_udp_sendrecv_all_if($1_gpg_helper_t)
@@ -169,7 +180,6 @@ template(`gpg_per_role_template',`
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
@@ -90,6 +90,10 @@ template(`irc_per_role_template',`
 	
 	kernel_read_proc_symlinks($1_irc_t)
 
+	corenet_tcp_recv_unlabeled($1_irc_t)
+	corenet_udp_recv_unlabeled($1_irc_t)
+	corenet_tcp_recv_netlabel($1_irc_t)
+	corenet_udp_recv_netlabel($1_irc_t)
 	corenet_non_ipsec_sendrecv($1_irc_t)
 	corenet_tcp_sendrecv_generic_if($1_irc_t)
 	corenet_udp_sendrecv_generic_if($1_irc_t)
Index: refpolicy_svn_repo/policy/modules/apps/java.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/java.if
+++ refpolicy_svn_repo/policy/modules/apps/java.if
@@ -97,6 +97,10 @@ template(`java_per_role_template',`
 	# Search bin directory under javaplugin for javaplugin executable
 	corecmd_search_bin($1_javaplugin_t)
 
+	corenet_tcp_recv_unlabeled($1_javaplugin_t)
+	corenet_udp_recv_unlabeled($1_javaplugin_t)
+	corenet_tcp_recv_netlabel($1_javaplugin_t)
+	corenet_udp_recv_netlabel($1_javaplugin_t)
 	corenet_non_ipsec_sendrecv($1_javaplugin_t)
 	corenet_tcp_sendrecv_generic_if($1_javaplugin_t)
 	corenet_udp_sendrecv_generic_if($1_javaplugin_t)
Index: refpolicy_svn_repo/policy/modules/apps/mozilla.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/mozilla.if
+++ refpolicy_svn_repo/policy/modules/apps/mozilla.if
@@ -126,6 +126,10 @@ template(`mozilla_per_role_template',`
 	corecmd_exec_bin($1_mozilla_t)
 
 	# Browse the web, connect to printer
+	corenet_tcp_recv_unlabeled($1_mozilla_t)
+	corenet_raw_recv_unlabeled($1_mozilla_t)
+	corenet_tcp_recv_netlabel($1_mozilla_t)
+	corenet_raw_recv_netlabel($1_mozilla_t)
 	corenet_non_ipsec_sendrecv($1_mozilla_t)
 	corenet_tcp_sendrecv_generic_if($1_mozilla_t)
 	corenet_raw_sendrecv_generic_if($1_mozilla_t)
Index: refpolicy_svn_repo/policy/modules/apps/screen.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/screen.if
+++ refpolicy_svn_repo/policy/modules/apps/screen.if
@@ -111,6 +111,10 @@ template(`screen_per_role_template',`
 	corecmd_shell_domtrans($1_screen_t,$2)
 	corecmd_bin_domtrans($1_screen_t,$2)
 
+	corenet_tcp_recv_unlabeled($1_screen_t)
+	corenet_udp_recv_unlabeled($1_screen_t)
+	corenet_tcp_recv_netlabel($1_screen_t)
+	corenet_udp_recv_netlabel($1_screen_t)
 	corenet_non_ipsec_sendrecv($1_screen_t)
 	corenet_tcp_sendrecv_generic_if($1_screen_t)
 	corenet_udp_sendrecv_generic_if($1_screen_t)
Index: refpolicy_svn_repo/policy/modules/apps/thunderbird.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/thunderbird.if
+++ refpolicy_svn_repo/policy/modules/apps/thunderbird.if
@@ -105,6 +105,8 @@ template(`thunderbird_per_role_template'
 	# Startup shellscript
 	corecmd_exec_shell($1_thunderbird_t)
 
+	corenet_tcp_recv_unlabeled($1_thunderbird_t)
+	corenet_tcp_recv_netlabel($1_thunderbird_t)
 	corenet_non_ipsec_sendrecv($1_thunderbird_t)
 	corenet_tcp_sendrecv_generic_if($1_thunderbird_t)
 	corenet_tcp_sendrecv_all_nodes($1_thunderbird_t)
Index: refpolicy_svn_repo/policy/modules/apps/uml.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/uml.if
+++ refpolicy_svn_repo/policy/modules/apps/uml.if
@@ -152,6 +152,10 @@ template(`uml_per_role_template',`
 	# for xterm
 	corecmd_exec_bin($1_uml_t)
 
+	corenet_tcp_recv_unlabeled($1_uml_t)
+	corenet_udp_recv_unlabeled($1_uml_t)
+	corenet_tcp_recv_netlabel($1_uml_t)
+	corenet_udp_recv_netlabel($1_uml_t)
 	corenet_non_ipsec_sendrecv($1_uml_t)
 	corenet_tcp_sendrecv_generic_if($1_uml_t)
 	corenet_udp_sendrecv_generic_if($1_uml_t)
Index: refpolicy_svn_repo/policy/modules/apps/vmware.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/vmware.te
+++ refpolicy_svn_repo/policy/modules/apps/vmware.te
@@ -45,6 +45,12 @@ kernel_read_kernel_sysctls(vmware_host_t
 kernel_list_proc(vmware_host_t)
 kernel_read_proc_symlinks(vmware_host_t)
 
+corenet_tcp_recv_unlabeled(vmware_host_t)
+corenet_udp_recv_unlabeled(vmware_host_t)
+corenet_raw_recv_unlabeled(vmware_host_t)
+corenet_tcp_recv_netlabel(vmware_host_t)
+corenet_udp_recv_netlabel(vmware_host_t)
+corenet_raw_recv_netlabel(vmware_host_t)
 corenet_non_ipsec_sendrecv(vmware_host_t)
 corenet_tcp_sendrecv_generic_if(vmware_host_t)
 corenet_udp_sendrecv_generic_if(vmware_host_t)
Index: refpolicy_svn_repo/policy/modules/apps/webalizer.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/webalizer.te
+++ refpolicy_svn_repo/policy/modules/apps/webalizer.te
@@ -61,6 +61,8 @@ files_var_lib_filetrans(webalizer_t,weba
 kernel_read_kernel_sysctls(webalizer_t)
 kernel_read_system_state(webalizer_t)
 
+corenet_tcp_recv_unlabeled(webalizer_t)
+corenet_tcp_recv_netlabel(webalizer_t)
 corenet_non_ipsec_sendrecv(webalizer_t)
 corenet_tcp_sendrecv_all_if(webalizer_t)
 corenet_tcp_sendrecv_all_nodes(webalizer_t)
Index: refpolicy_svn_repo/policy/modules/apps/yam.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/yam.te
+++ refpolicy_svn_repo/policy/modules/apps/yam.te
@@ -60,6 +60,8 @@ corecmd_exec_bin(yam_t)
 
 # Rsync and lftp need to network.  They also set files attributes to
 # match whats on the remote server.
+corenet_tcp_recv_unlabeled(yam_t)
+corenet_tcp_recv_netlabel(yam_t)
 corenet_non_ipsec_sendrecv(yam_t)
 corenet_tcp_sendrecv_generic_if(yam_t)
 corenet_tcp_sendrecv_all_nodes(yam_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
