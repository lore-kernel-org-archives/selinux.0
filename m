Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QJ2Cr7031912
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 14:02:12 -0500
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QJ2Cae015414
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 19:02:12 GMT
Received: from g5t0007.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 20CBF14083
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:08 +0000 (UTC)
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 0FD5E1403A
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:08 +0000 (UTC)
Message-Id: <20080226184406.780973062@hp.com>
References: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:35 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/5] REFPOL: Allow network apps domains to receive unlabeled traffic
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the corenet_recvfrom_unlabeled_peer() interface call to
all of the apps modules which need to receive data over the network.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/apps/calamaris.te   |    1 +
 policy/modules/apps/evolution.if   |    3 +++
 policy/modules/apps/games.if       |    1 +
 policy/modules/apps/gift.if        |    2 ++
 policy/modules/apps/gpg.if         |    2 ++
 policy/modules/apps/irc.if         |    1 +
 policy/modules/apps/java.if        |    1 +
 policy/modules/apps/mozilla.if     |    1 +
 policy/modules/apps/screen.if      |    1 +
 policy/modules/apps/thunderbird.if |    1 +
 policy/modules/apps/uml.if         |    1 +
 policy/modules/apps/vmware.te      |    1 +
 policy/modules/apps/webalizer.te   |    1 +
 policy/modules/apps/yam.te         |    1 +
 14 files changed, 18 insertions(+)

Index: refpolicy_svn_repo/policy/modules/apps/calamaris.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/calamaris.te
+++ refpolicy_svn_repo/policy/modules/apps/calamaris.te
@@ -41,6 +41,7 @@ kernel_read_system_state(calamaris_t)
 corecmd_exec_bin(calamaris_t)
 
 corenet_all_recvfrom_unlabeled(calamaris_t)
+corenet_recvfrom_unlabeled_peer(calamaris_t)
 corenet_all_recvfrom_netlabel(calamaris_t)
 corenet_tcp_sendrecv_generic_if(calamaris_t)
 corenet_udp_sendrecv_generic_if(calamaris_t)
Index: refpolicy_svn_repo/policy/modules/apps/evolution.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/evolution.if
+++ refpolicy_svn_repo/policy/modules/apps/evolution.if
@@ -184,6 +184,7 @@ template(`evolution_per_role_template',`
 	corecmd_exec_bin($1_evolution_t)
 
 	corenet_all_recvfrom_unlabeled($1_evolution_t)
+	corenet_recvfrom_unlabeled_peer($1_evolution_t)
 	corenet_all_recvfrom_netlabel($1_evolution_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_t)
 	corenet_udp_sendrecv_generic_if($1_evolution_t)
@@ -675,6 +676,7 @@ template(`evolution_per_role_template',`
 
 	# Obtain weather data via http (read server name from xml file in /usr)
 	corenet_all_recvfrom_unlabeled($1_evolution_server_t)
+	corenet_recvfrom_unlabeled_peer($1_evolution_server_t)
 	corenet_all_recvfrom_netlabel($1_evolution_server_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_server_t)
 	corenet_tcp_sendrecv_all_nodes($1_evolution_server_t)
@@ -753,6 +755,7 @@ template(`evolution_per_role_template',`
 	domain_auto_trans($2, evolution_webcal_exec_t, $1_evolution_webcal_t)
 
 	corenet_all_recvfrom_unlabeled($1_evolution_webcal_t)
+	corenet_recvfrom_unlabeled_peer($1_evolution_webcal_t)
 	corenet_all_recvfrom_netlabel($1_evolution_webcal_t)
 	corenet_tcp_sendrecv_generic_if($1_evolution_webcal_t)
 	corenet_raw_sendrecv_generic_if($1_evolution_webcal_t)
Index: refpolicy_svn_repo/policy/modules/apps/games.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/games.if
+++ refpolicy_svn_repo/policy/modules/apps/games.if
@@ -92,6 +92,7 @@ template(`games_per_role_template',`
 	corecmd_exec_bin($1_games_t)
 
 	corenet_all_recvfrom_unlabeled($1_games_t)
+	corenet_recvfrom_unlabeled_peer($1_games_t)
 	corenet_all_recvfrom_netlabel($1_games_t)
 	corenet_tcp_sendrecv_generic_if($1_games_t)
 	corenet_udp_sendrecv_generic_if($1_games_t)
Index: refpolicy_svn_repo/policy/modules/apps/gift.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gift.if
+++ refpolicy_svn_repo/policy/modules/apps/gift.if
@@ -95,6 +95,7 @@ template(`gift_per_role_template',`
 
 	# Connect to gift daemon
 	corenet_all_recvfrom_unlabeled($1_gift_t)
+	corenet_recvfrom_unlabeled_peer($1_gift_t)
 	corenet_all_recvfrom_netlabel($1_gift_t)
 	corenet_tcp_sendrecv_generic_if($1_gift_t)
 	corenet_tcp_sendrecv_all_nodes($1_gift_t)
@@ -155,6 +156,7 @@ template(`gift_per_role_template',`
 
 	# Serve content on various p2p networks. Ports can be random.
 	corenet_all_recvfrom_unlabeled($1_giftd_t)
+	corenet_recvfrom_unlabeled_peer($1_giftd_t)
 	corenet_all_recvfrom_netlabel($1_giftd_t)
 	corenet_tcp_sendrecv_generic_if($1_giftd_t)
 	corenet_udp_sendrecv_generic_if($1_giftd_t)
Index: refpolicy_svn_repo/policy/modules/apps/gpg.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/gpg.if
+++ refpolicy_svn_repo/policy/modules/apps/gpg.if
@@ -95,6 +95,7 @@ template(`gpg_per_role_template',`
 	ps_process_pattern($2,$1_gpg_t)
 
 	corenet_all_recvfrom_unlabeled($1_gpg_t)
+	corenet_recvfrom_unlabeled_peer($1_gpg_t)
 	corenet_all_recvfrom_netlabel($1_gpg_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_t)
 	corenet_udp_sendrecv_all_if($1_gpg_t)
@@ -159,6 +160,7 @@ template(`gpg_per_role_template',`
 	dontaudit $1_gpg_helper_t $1_gpg_secret_t:file read;
 
 	corenet_all_recvfrom_unlabeled($1_gpg_helper_t)
+	corenet_recvfrom_unlabeled_peer($1_gpg_helper_t)
 	corenet_all_recvfrom_netlabel($1_gpg_helper_t)
 	corenet_tcp_sendrecv_all_if($1_gpg_helper_t)
 	corenet_raw_sendrecv_all_if($1_gpg_helper_t)
Index: refpolicy_svn_repo/policy/modules/apps/irc.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/irc.if
+++ refpolicy_svn_repo/policy/modules/apps/irc.if
@@ -90,6 +90,7 @@ template(`irc_per_role_template',`
 	kernel_read_proc_symlinks($1_irc_t)
 
 	corenet_all_recvfrom_unlabeled($1_irc_t)
+	corenet_recvfrom_unlabeled_peer($1_irc_t)
 	corenet_all_recvfrom_netlabel($1_irc_t)
 	corenet_tcp_sendrecv_generic_if($1_irc_t)
 	corenet_udp_sendrecv_generic_if($1_irc_t)
Index: refpolicy_svn_repo/policy/modules/apps/java.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/java.if
+++ refpolicy_svn_repo/policy/modules/apps/java.if
@@ -97,6 +97,7 @@ template(`java_per_role_template',`
 	corecmd_search_bin($1_javaplugin_t)
 
 	corenet_all_recvfrom_unlabeled($1_javaplugin_t)
+	corenet_recvfrom_unlabeled_peer($1_javaplugin_t)
 	corenet_all_recvfrom_netlabel($1_javaplugin_t)
 	corenet_tcp_sendrecv_generic_if($1_javaplugin_t)
 	corenet_udp_sendrecv_generic_if($1_javaplugin_t)
Index: refpolicy_svn_repo/policy/modules/apps/mozilla.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/mozilla.if
+++ refpolicy_svn_repo/policy/modules/apps/mozilla.if
@@ -126,6 +126,7 @@ template(`mozilla_per_role_template',`
 
 	# Browse the web, connect to printer
 	corenet_all_recvfrom_unlabeled($1_mozilla_t)
+	corenet_recvfrom_unlabeled_peer($1_mozilla_t)
 	corenet_all_recvfrom_netlabel($1_mozilla_t)
 	corenet_tcp_sendrecv_generic_if($1_mozilla_t)
 	corenet_raw_sendrecv_generic_if($1_mozilla_t)
Index: refpolicy_svn_repo/policy/modules/apps/screen.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/screen.if
+++ refpolicy_svn_repo/policy/modules/apps/screen.if
@@ -111,6 +111,7 @@ template(`screen_per_role_template',`
 	corecmd_bin_domtrans($1_screen_t,$2)
 
 	corenet_all_recvfrom_unlabeled($1_screen_t)
+	corenet_recvfrom_unlabeled_peer($1_screen_t)
 	corenet_all_recvfrom_netlabel($1_screen_t)
 	corenet_tcp_sendrecv_generic_if($1_screen_t)
 	corenet_udp_sendrecv_generic_if($1_screen_t)
Index: refpolicy_svn_repo/policy/modules/apps/thunderbird.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/thunderbird.if
+++ refpolicy_svn_repo/policy/modules/apps/thunderbird.if
@@ -104,6 +104,7 @@ template(`thunderbird_per_role_template'
 	corecmd_exec_shell($1_thunderbird_t)
 
 	corenet_all_recvfrom_unlabeled($1_thunderbird_t)
+	corenet_recvfrom_unlabeled_peer($1_thunderbird_t)
 	corenet_all_recvfrom_netlabel($1_thunderbird_t)
 	corenet_tcp_sendrecv_generic_if($1_thunderbird_t)
 	corenet_tcp_sendrecv_all_nodes($1_thunderbird_t)
Index: refpolicy_svn_repo/policy/modules/apps/uml.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/uml.if
+++ refpolicy_svn_repo/policy/modules/apps/uml.if
@@ -151,6 +151,7 @@ template(`uml_per_role_template',`
 	corecmd_exec_bin($1_uml_t)
 
 	corenet_all_recvfrom_unlabeled($1_uml_t)
+	corenet_recvfrom_unlabeled_peer($1_uml_t)
 	corenet_all_recvfrom_netlabel($1_uml_t)
 	corenet_tcp_sendrecv_generic_if($1_uml_t)
 	corenet_udp_sendrecv_generic_if($1_uml_t)
Index: refpolicy_svn_repo/policy/modules/apps/vmware.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/vmware.te
+++ refpolicy_svn_repo/policy/modules/apps/vmware.te
@@ -46,6 +46,7 @@ kernel_list_proc(vmware_host_t)
 kernel_read_proc_symlinks(vmware_host_t)
 
 corenet_all_recvfrom_unlabeled(vmware_host_t)
+corenet_recvfrom_unlabeled_peer(vmware_host_t)
 corenet_all_recvfrom_netlabel(vmware_host_t)
 corenet_tcp_sendrecv_generic_if(vmware_host_t)
 corenet_udp_sendrecv_generic_if(vmware_host_t)
Index: refpolicy_svn_repo/policy/modules/apps/webalizer.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/webalizer.te
+++ refpolicy_svn_repo/policy/modules/apps/webalizer.te
@@ -61,6 +61,7 @@ kernel_read_kernel_sysctls(webalizer_t)
 kernel_read_system_state(webalizer_t)
 
 corenet_all_recvfrom_unlabeled(webalizer_t)
+corenet_recvfrom_unlabeled_peer(webalizer_t)
 corenet_all_recvfrom_netlabel(webalizer_t)
 corenet_tcp_sendrecv_all_if(webalizer_t)
 corenet_tcp_sendrecv_all_nodes(webalizer_t)
Index: refpolicy_svn_repo/policy/modules/apps/yam.te
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/apps/yam.te
+++ refpolicy_svn_repo/policy/modules/apps/yam.te
@@ -60,6 +60,7 @@ corecmd_exec_bin(yam_t)
 # Rsync and lftp need to network.  They also set files attributes to
 # match whats on the remote server.
 corenet_all_recvfrom_unlabeled(yam_t)
+corenet_recvfrom_unlabeled_peer(yam_t)
 corenet_all_recvfrom_netlabel(yam_t)
 corenet_tcp_sendrecv_generic_if(yam_t)
 corenet_tcp_sendrecv_all_nodes(yam_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
