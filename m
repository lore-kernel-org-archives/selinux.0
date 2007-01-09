Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l090ZX0G013830
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:35:33 -0500
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l090aKbm014930
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 00:36:21 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l090ZEVj022325
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:35:14 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l090aIFx456702
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:36:19 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l090aIcC016365
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:36:18 -0700
Date: Mon, 8 Jan 2007 18:21:48 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701090021.l090LmBZ017580@faith.austin.ibm.com>
To: redhat-lspp@redhat.com
Subject: [PATCH 1/3]: labeled ipsec policy
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/amanda.te serefpolicy-2.4.6.patch/policy/modules/admin/amanda.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/amanda.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/amanda.te	2007-01-04 15:33:13.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(amanda,1.4.1)
 type amanda_t;
 type amanda_inetd_exec_t;
 inetd_service_domain(amanda_t,amanda_inetd_exec_t)
+corenet_type(amanda_t)
 role system_r types amanda_t;
 
 type amanda_exec_t;
@@ -53,6 +54,7 @@ type amanda_recover_t;
 type amanda_recover_exec_t;
 domain_type(amanda_recover_t)
 domain_entry_file(amanda_recover_t,amanda_recover_exec_t)
+corenet_type(amanda_recover_t)
 role system_r types amanda_recover_t;
 
 # type for recover files ( restored data )
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/apt.te serefpolicy-2.4.6.patch/policy/modules/admin/apt.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/apt.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/apt.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(apt,1.1.0)
 #
 
 type apt_t;
+corenet_type(apt_t)
 type apt_exec_t;
 init_system_domain(apt_t,apt_exec_t)
 domain_system_change_exemption(apt_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/backup.te serefpolicy-2.4.6.patch/policy/modules/admin/backup.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/backup.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/backup.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(backup,1.1.0)
 #
 
 type backup_t;
+corenet_type(backup_t)
 type backup_exec_t;
 domain_type(backup_t)
 domain_entry_file(backup_t,backup_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/dpkg.te serefpolicy-2.4.6.patch/policy/modules/admin/dpkg.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/dpkg.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/dpkg.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(dpkg,1.1.0)
 #
 
 type dpkg_t;
+corenet_type(dpkg_t)
 type dpkg_exec_t;
 # dpkg can start/stop services
 init_system_domain(dpkg_t,dpkg_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/firstboot.te serefpolicy-2.4.6.patch/policy/modules/admin/firstboot.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/firstboot.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/firstboot.te	2007-01-04 15:33:13.000000000 -0600
@@ -11,6 +11,7 @@ gen_require(`
 #
 
 type firstboot_t;
+corenet_type(firstboot_t)
 type firstboot_exec_t;
 init_system_domain(firstboot_t,firstboot_exec_t)
 domain_obj_id_change_exemption(firstboot_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/mrtg.te serefpolicy-2.4.6.patch/policy/modules/admin/mrtg.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/mrtg.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/mrtg.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(mrtg,1.1.0)
 #
 
 type mrtg_t;
+corenet_type(mrtg_t)
 type mrtg_exec_t;
 init_system_domain(mrtg_t,mrtg_exec_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/netutils.te serefpolicy-2.4.6.patch/policy/modules/admin/netutils.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/netutils.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/netutils.te	2007-01-07 19:14:51.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(netutils,1.2.1)
 #
 
 type netutils_t;
+corenet_type(netutils_t)
 type netutils_exec_t;
 init_system_domain(netutils_t,netutils_exec_t)
 role system_r types netutils_t;
@@ -15,12 +16,14 @@ type netutils_tmp_t;
 files_tmp_file(netutils_tmp_t)
 
 type ping_t;
+corenet_type(ping_t)
 type ping_exec_t;
 init_system_domain(ping_t,ping_exec_t)
 role system_r types ping_t;
 userdom_executable_file(ping_exec_t)
 
 type traceroute_t;
+corenet_type(traceroute_t)
 type traceroute_exec_t;
 init_system_domain(traceroute_t,traceroute_exec_t)
 userdom_executable_file(traceroute_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/portage.te serefpolicy-2.4.6.patch/policy/modules/admin/portage.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/portage.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/portage.te	2007-01-04 15:33:13.000000000 -0600
@@ -13,6 +13,7 @@ domain_entry_file(gcc_config_t,gcc_confi
 
 # constraining type
 type portage_t;
+corenet_type(portage_t)
 type portage_exec_t;
 domain_type(portage_t)
 domain_entry_file(portage_t,portage_exec_t)
@@ -23,12 +24,14 @@ domain_entry_file(portage_t,portage_exec
 # portage domain for merging packages to the live fs
 type portage_t.merge;
 domain_type(portage_t.merge)
+corenet_type(portage_t.merge)
 domain_entry_file(portage_t.merge,portage_exec_t)
 domain_obj_id_change_exemption(portage_t.merge)
 
 # portage compile sandbox domain
 type portage_t.sandbox alias portage_sandbox_t;
 domain_type(portage_t.sandbox)
+corenet_type(portage_t.sandbox)
 # the shell is the entrypoint if regular sandbox is disabled
 # portage_exec_t is the entrypoint if regular sandbox is enabled
 corecmd_shell_entry_type(portage_t.sandbox)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/rpm.te serefpolicy-2.4.6.patch/policy/modules/admin/rpm.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/rpm.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/rpm.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(rpm,1.4.1)
 #
 
 type rpm_t;
+corenet_type(rpm_t)
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
 userdom_executable_file(rpm_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/sxid.te serefpolicy-2.4.6.patch/policy/modules/admin/sxid.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/sxid.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/sxid.te	2007-01-04 15:33:13.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(sxid,1.1.0)
 #
 
 type sxid_t;
+corenet_type(sxid_t)
 type sxid_exec_t;
 domain_type(sxid_t)
 domain_entry_file(sxid_t,sxid_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/admin/vpn.te serefpolicy-2.4.6.patch/policy/modules/admin/vpn.te
--- serefpolicy-2.4.6.orig/policy/modules/admin/vpn.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/admin/vpn.te	2007-01-04 15:33:13.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(vpn,1.3.0)
 
 type vpnc_t;
 domain_type(vpnc_t)
+corenet_type(vpnc_t)
 
 type vpnc_exec_t;
 domain_entry_file(vpnc_t,vpnc_exec_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/calamaris.te serefpolicy-2.4.6.patch/policy/modules/apps/calamaris.te
--- serefpolicy-2.4.6.orig/policy/modules/apps/calamaris.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/calamaris.te	2007-01-04 15:33:14.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(calamaris,1.1.0)
 #
 
 type calamaris_t;
+corenet_type(calamaris_t)
 type calamaris_exec_t;
 init_system_domain(calamaris_t,calamaris_exec_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/evolution.if serefpolicy-2.4.6.patch/policy/modules/apps/evolution.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/evolution.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/evolution.if	2007-01-04 15:33:14.000000000 -0600
@@ -43,6 +43,7 @@ template(`evolution_per_role_template',`
 	type $1_evolution_t;
 	domain_type($1_evolution_t)
 	domain_entry_file($1_evolution_t,evolution_exec_t)
+	corenet_type($1_evolution_t)
 	role $3 types $1_evolution_t;
 
 	type $1_evolution_tmpfs_t;
@@ -83,6 +84,7 @@ template(`evolution_per_role_template',`
 	type $1_evolution_server_t;
 	domain_type($1_evolution_server_t)
 	domain_entry_file($1_evolution_server_t,evolution_server_exec_t)
+	corenet_type($1_evolution_server_t)
 	role $3 types $1_evolution_server_t;
 
 	type $1_evolution_server_orbit_tmp_t;
@@ -91,6 +93,7 @@ template(`evolution_per_role_template',`
 	type $1_evolution_webcal_t;
 	domain_type($1_evolution_webcal_t)
 	domain_entry_file($1_evolution_webcal_t,evolution_webcal_exec_t)
+	corenet_type($1_evolution_webcal_t)
 	role $3 types $1_evolution_webcal_t;
 
 	type $1_evolution_webcal_tmpfs_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/games.if serefpolicy-2.4.6.patch/policy/modules/apps/games.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/games.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/games.if	2007-01-04 15:33:14.000000000 -0600
@@ -42,6 +42,7 @@ template(`games_per_role_template',`
 	type $1_games_t;
 	domain_type($1_games_t)
 	domain_entry_file($1_games_t,games_exec_t)
+	corenet_type($1_games_t)
 	role $3 types $1_games_t;
 
 	type $1_games_devpts_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/gift.if serefpolicy-2.4.6.patch/policy/modules/apps/gift.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/gift.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/gift.if	2007-01-04 15:33:14.000000000 -0600
@@ -42,6 +42,7 @@ template(`gift_per_role_template',`
 	type $1_gift_t;
 	domain_type($1_gift_t)
 	domain_entry_file($1_gift_t,gift_exec_t)
+	corenet_type($1_gift_t)
 	role $3 types $1_gift_t;
 
 	type $1_gift_home_t alias $1_gift_rw_t;
@@ -54,6 +55,7 @@ template(`gift_per_role_template',`
 	type $1_giftd_t;
 	domain_type($1_giftd_t)
 	domain_entry_file($1_giftd_t,giftd_exec_t)
+	corenet_type($1_giftd_t)
 	role $3 types $1_giftd_t;
 
 	##############################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/gpg.if serefpolicy-2.4.6.patch/policy/modules/apps/gpg.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/gpg.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/gpg.if	2007-01-04 15:33:14.000000000 -0600
@@ -48,6 +48,7 @@ template(`gpg_per_role_template',`
 	type $1_gpg_t;
 	domain_type($1_gpg_t)
 	domain_entry_file($1_gpg_t,gpg_exec_t)
+	corenet_type($1_gpg_t)
 	role $3 types $1_gpg_t;
 
 	type $1_gpg_agent_t;
@@ -64,6 +65,7 @@ template(`gpg_per_role_template',`
 	type $1_gpg_helper_t;
 	domain_type($1_gpg_helper_t)
 	domain_entry_file($1_gpg_helper_t,gpg_helper_exec_t)
+	corenet_type($1_gpg_helper_t)
 	role $3 types $1_gpg_helper_t;
 
 	type $1_gpg_pinentry_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/irc.if serefpolicy-2.4.6.patch/policy/modules/apps/irc.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/irc.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/irc.if	2007-01-04 15:33:14.000000000 -0600
@@ -45,6 +45,7 @@ template(`irc_per_role_template',`
 	type $1_irc_t;
 	domain_type($1_irc_t)
 	domain_entry_file($1_irc_t,irc_exec_t)
+	corenet_type($1_irc_t)
 	role $3 types $1_irc_t;
 
 	type $1_irc_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/java.if serefpolicy-2.4.6.patch/policy/modules/apps/java.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/java.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/java.if	2007-01-04 15:33:14.000000000 -0600
@@ -45,6 +45,7 @@ template(`java_per_role_template',`
 	type $1_javaplugin_t;
 	domain_type($1_javaplugin_t)
 	domain_entry_file($1_javaplugin_t,java_exec_t)
+	corenet_type($1_javaplugin_t)
 	role $3 types $1_javaplugin_t;
 	
 	type $1_javaplugin_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/mozilla.if serefpolicy-2.4.6.patch/policy/modules/apps/mozilla.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/mozilla.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/mozilla.if	2007-01-04 15:33:14.000000000 -0600
@@ -44,6 +44,7 @@ template(`mozilla_per_role_template',`
 	type $1_mozilla_t;
 	domain_type($1_mozilla_t)
 	domain_entry_file($1_mozilla_t,mozilla_exec_t)
+	corenet_type($1_mozilla_t)
 	role $3 types $1_mozilla_t;
 
 	type $1_mozilla_home_t alias $1_mozilla_rw_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/screen.if serefpolicy-2.4.6.patch/policy/modules/apps/screen.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/screen.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/screen.if	2007-01-04 15:33:14.000000000 -0600
@@ -46,6 +46,7 @@ template(`screen_per_role_template',`
 	domain_type($1_screen_t)
 	domain_entry_file($1_screen_t,screen_exec_t)
 	domain_interactive_fd($1_screen_t)
+	corenet_type($1_screen_t)
 	role $3 types $1_screen_t;
 
 	type $1_screen_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/thunderbird.if serefpolicy-2.4.6.patch/policy/modules/apps/thunderbird.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/thunderbird.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/thunderbird.if	2007-01-04 15:33:14.000000000 -0600
@@ -42,6 +42,7 @@ template(`thunderbird_per_role_template'
 	type $1_thunderbird_t;
 	domain_type($1_thunderbird_t)
 	domain_entry_file($1_thunderbird_t,thunderbird_exec_t)
+	corenet_type($1_thunderbird_t)
 	role $3 types $1_thunderbird_t;
 
 	type $1_thunderbird_home_t alias $1_thunderbird_rw_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/uml.if serefpolicy-2.4.6.patch/policy/modules/apps/uml.if
--- serefpolicy-2.4.6.orig/policy/modules/apps/uml.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/uml.if	2007-01-04 15:33:14.000000000 -0600
@@ -40,6 +40,7 @@ template(`uml_per_role_template',`
 	#
 	type $1_uml_t;
 	domain_type($1_uml_t)
+	corenet_type($1_uml_t)
 	role $3 types $1_uml_t;
 
 	type $1_uml_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/vmware.te serefpolicy-2.4.6.patch/policy/modules/apps/vmware.te
--- serefpolicy-2.4.6.orig/policy/modules/apps/vmware.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/vmware.te	2007-01-04 15:33:14.000000000 -0600
@@ -12,6 +12,7 @@ corecmd_executable_file(vmware_exec_t)
 
 # VMWare host programs
 type vmware_host_t;
+corenet_type(vmware_host_t)
 type vmware_host_exec_t;
 init_daemon_domain(vmware_host_t,vmware_host_exec_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/webalizer.te serefpolicy-2.4.6.patch/policy/modules/apps/webalizer.te
--- serefpolicy-2.4.6.orig/policy/modules/apps/webalizer.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/webalizer.te	2007-01-04 15:33:14.000000000 -0600
@@ -9,6 +9,7 @@ type webalizer_t;
 type webalizer_exec_t;
 domain_type(webalizer_t)
 domain_entry_file(webalizer_t,webalizer_exec_t)
+corenet_type(webalizer_t)
 role system_r types webalizer_t;
 
 type webalizer_etc_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/apps/yam.te serefpolicy-2.4.6.patch/policy/modules/apps/yam.te
--- serefpolicy-2.4.6.orig/policy/modules/apps/yam.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/apps/yam.te	2007-01-04 15:33:14.000000000 -0600
@@ -10,6 +10,7 @@ type yam_t alias yam_crond_t;
 type yam_exec_t;
 domain_type(yam_t)
 domain_entry_file(yam_t,yam_exec_t)
+corenet_type(yam_t)
 
 type yam_content_t;
 files_mountpoint(yam_content_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/kernel/corenetwork.if.in serefpolicy-2.4.6.patch/policy/modules/kernel/corenetwork.if.in
--- serefpolicy-2.4.6.orig/policy/modules/kernel/corenetwork.if.in	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/kernel/corenetwork.if.in	2007-01-04 15:33:11.000000000 -0600
@@ -1924,3 +1924,21 @@ interface(`corenet_dontaudit_udp_bind_al
 
 	dontaudit $1 port_type:udp_socket name_bind;
 ')
+
+########################################
+## <summary>
+##	Do not audit attepts to bind UDP sockets to any ports.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`corenet_type',`
+	gen_require(`
+		attribute netapp_type;
+	')
+
+	typeattribute $1 netapp_type;
+')
diff -urpN serefpolicy-2.4.6.orig/policy/modules/kernel/corenetwork.te.in serefpolicy-2.4.6.patch/policy/modules/kernel/corenetwork.te.in
--- serefpolicy-2.4.6.orig/policy/modules/kernel/corenetwork.te.in	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/kernel/corenetwork.te.in	2007-01-04 15:33:11.000000000 -0600
@@ -17,6 +17,8 @@ attribute server_packet_type;
 
 attribute corenet_unconfined_type;
 
+attribute netapp_type;
+
 type ppp_device_t;
 dev_node(ppp_device_t)
 
@@ -220,3 +222,10 @@ allow corenet_unconfined_type port_type:
 # Bind to any network address.
 allow corenet_unconfined_type port_type:{ tcp_socket udp_socket } name_bind;
 allow corenet_unconfined_type node_type:{ tcp_socket udp_socket rawip_socket } node_bind;
+
+#########################################
+#
+# Allow ALL domains that can talk to the network to be
+# able to use labeled-ipsec by default
+
+ipsec_labeled(netapp_type)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/kernel/domain.if serefpolicy-2.4.6.patch/policy/modules/kernel/domain.if
--- serefpolicy-2.4.6.orig/policy/modules/kernel/domain.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/kernel/domain.if	2007-01-04 15:33:11.000000000 -0600
@@ -1276,3 +1276,21 @@ template(`domain_auto_trans',`
 	domain_trans($1,$2,$3)
 	type_transition $1 $2:process $3;
 ')
+
+########################################
+## <summary>
+##	Allow specified type to set context on domain attribute.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type of subject to be allowed this.
+##	</summary>
+## </param>
+#
+interface(`domain_setcontext',`
+	gen_require(`
+		attribute domain;
+	')
+
+	allow $1 domain:association setcontext;
+')
diff -urpN serefpolicy-2.4.6.orig/policy/modules/kernel/kernel.te serefpolicy-2.4.6.patch/policy/modules/kernel/kernel.te
--- serefpolicy-2.4.6.orig/policy/modules/kernel/kernel.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/kernel/kernel.te	2007-01-08 14:42:36.000000000 -0600
@@ -139,6 +139,7 @@ type unlabeled_t;
 sid unlabeled gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
 
 corenet_non_ipsec_sendrecv(unlabeled_t)
+corenet_type(unlabeled_t)
 
 # These initial sids are no longer used, and can be removed:
 sid any_socket		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/afs.te serefpolicy-2.4.6.patch/policy/modules/services/afs.te
--- serefpolicy-2.4.6.orig/policy/modules/services/afs.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/afs.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(afs,1.1.0)
 type afs_bosserver_t;
 type afs_bosserver_exec_t;
 init_daemon_domain(afs_bosserver_t,afs_bosserver_exec_t)
+corenet_type(afs_bosserver_t)
 
 type afs_config_t;
 files_type(afs_config_t)
@@ -24,6 +25,7 @@ type afs_fsserver_t;
 type afs_fsserver_exec_t;
 domain_type(afs_fsserver_t)
 domain_entry_file(afs_fsserver_t,afs_fsserver_exec_t)
+corenet_type(afs_fsserver_t)
 role system_r types afs_fsserver_t;
 
 type afs_ka_db_t;
@@ -33,6 +35,7 @@ type afs_kaserver_t;
 type afs_kaserver_exec_t;
 domain_type(afs_kaserver_t)
 domain_entry_file(afs_kaserver_t,afs_kaserver_exec_t)
+corenet_type(afs_kaserver_t)
 role system_r types afs_kaserver_t;
 
 type afs_logfile_t;
@@ -45,6 +48,7 @@ type afs_ptserver_t;
 type afs_ptserver_exec_t;
 domain_type(afs_ptserver_t)
 domain_entry_file(afs_ptserver_t,afs_ptserver_exec_t)
+corenet_type(afs_ptserver_t)
 role system_r types afs_ptserver_t;
 
 type afs_vl_db_t;
@@ -54,6 +58,7 @@ type afs_vlserver_t;
 type afs_vlserver_exec_t;
 domain_type(afs_vlserver_t)
 domain_entry_file(afs_vlserver_t,afs_vlserver_exec_t)
+corenet_type(afs_vlserver_t)
 role system_r types afs_vlserver_t;
 
 ########################################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/amavis.te serefpolicy-2.4.6.patch/policy/modules/services/amavis.te
--- serefpolicy-2.4.6.orig/policy/modules/services/amavis.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/amavis.te	2007-01-04 15:33:07.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(amavis,1.1.0)
 type amavis_t;
 type amavis_exec_t;
 domain_type(amavis_t)
+corenet_type(amavis_t)
 init_daemon_domain(amavis_t, amavis_exec_t)
 
 # configuration files
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/apache.if serefpolicy-2.4.6.patch/policy/modules/services/apache.if
--- serefpolicy-2.4.6.orig/policy/modules/services/apache.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/apache.if	2007-01-04 15:33:07.000000000 -0600
@@ -33,6 +33,7 @@ template(`apache_content_template',`
 	# Type that CGI scripts run as
 	type httpd_$1_script_t;
 	domain_type(httpd_$1_script_t)
+	corenet_type(httpd_$1_script_t)
 	role system_r types httpd_$1_script_t;
 
 	# This type is used for executable scripts files
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/apache.te serefpolicy-2.4.6.patch/policy/modules/services/apache.te
--- serefpolicy-2.4.6.orig/policy/modules/services/apache.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/apache.te	2007-01-04 15:33:10.000000000 -0600
@@ -33,6 +33,7 @@ attribute httpd_script_domains;
 type httpd_t;
 type httpd_exec_t;
 init_daemon_domain(httpd_t,httpd_exec_t)
+corenet_type(httpd_t)
 role system_r types httpd_t;
 
 # httpd_cache_t is the type given to the /var/cache/httpd
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/arpwatch.te serefpolicy-2.4.6.patch/policy/modules/services/arpwatch.te
--- serefpolicy-2.4.6.orig/policy/modules/services/arpwatch.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/arpwatch.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(arpwatch,1.2.0)
 type arpwatch_t;
 type arpwatch_exec_t;
 init_daemon_domain(arpwatch_t,arpwatch_exec_t)
+corenet_type(arpwatch_t)
 
 type arpwatch_data_t;
 files_type(arpwatch_data_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/asterisk.te serefpolicy-2.4.6.patch/policy/modules/services/asterisk.te
--- serefpolicy-2.4.6.orig/policy/modules/services/asterisk.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/asterisk.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(asterisk,1.1.0)
 type asterisk_t;
 type asterisk_exec_t;
 init_daemon_domain(asterisk_t,asterisk_exec_t)
+corenet_type(asterisk_t)
 
 type asterisk_etc_t;
 files_config_file(asterisk_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/automount.te serefpolicy-2.4.6.patch/policy/modules/services/automount.te
--- serefpolicy-2.4.6.orig/policy/modules/services/automount.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/automount.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(automount,1.3.1)
 type automount_t;
 type automount_exec_t;
 init_daemon_domain(automount_t,automount_exec_t)
+corenet_type(automount_t)
 
 type automount_var_run_t;
 files_pid_file(automount_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/avahi.te serefpolicy-2.4.6.patch/policy/modules/services/avahi.te
--- serefpolicy-2.4.6.orig/policy/modules/services/avahi.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/avahi.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(avahi,1.3.0)
 type avahi_t;
 type avahi_exec_t;
 init_daemon_domain(avahi_t,avahi_exec_t)
+corenet_type(avahi_t)
 
 type avahi_var_run_t;
 files_pid_file(avahi_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/bind.te serefpolicy-2.4.6.patch/policy/modules/services/bind.te
--- serefpolicy-2.4.6.orig/policy/modules/services/bind.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/bind.te	2007-01-04 15:33:07.000000000 -0600
@@ -13,6 +13,7 @@ files_security_file(dnssec_t)
 type named_t;
 type named_exec_t;
 init_daemon_domain(named_t,named_exec_t)
+corenet_type(named_t)
 role system_r types named_t;
 
 type named_checkconf_exec_t;
@@ -43,6 +44,7 @@ files_type(named_zone_t)
 type ndc_t;
 type ndc_exec_t;
 init_system_domain(ndc_t,ndc_exec_t)
+corenet_type(ndc_t)
 role system_r types ndc_t;
 
 ########################################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/bluetooth.te serefpolicy-2.4.6.patch/policy/modules/services/bluetooth.te
--- serefpolicy-2.4.6.orig/policy/modules/services/bluetooth.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/bluetooth.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(bluetooth,1.3.1)
 type bluetooth_t;
 type bluetooth_exec_t;
 init_daemon_domain(bluetooth_t,bluetooth_exec_t)
+corenet_type(bluetooth_t)
 
 type bluetooth_conf_t;
 files_type(bluetooth_conf_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/canna.te serefpolicy-2.4.6.patch/policy/modules/services/canna.te
--- serefpolicy-2.4.6.orig/policy/modules/services/canna.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/canna.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(canna,1.3.0)
 type canna_t;
 type canna_exec_t;
 init_daemon_domain(canna_t,canna_exec_t)
+corenet_type(canna_t)
 
 type canna_log_t;
 logging_log_file(canna_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ccs.te serefpolicy-2.4.6.patch/policy/modules/services/ccs.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ccs.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ccs.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ccs,1.0.0)
 type ccs_t;
 type ccs_exec_t;
 init_daemon_domain(ccs_t, ccs_exec_t)
+corenet_type(ccs_t)
 
 # pid files
 type cluster_conf_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/cipe.te serefpolicy-2.4.6.patch/policy/modules/services/cipe.te
--- serefpolicy-2.4.6.orig/policy/modules/services/cipe.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/cipe.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(cipe,1.1.0)
 type ciped_t;
 type ciped_exec_t;
 init_daemon_domain(ciped_t,ciped_exec_t)
+corenet_type(ciped_t)
 
 ########################################
 #
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/clamav.te serefpolicy-2.4.6.patch/policy/modules/services/clamav.te
--- serefpolicy-2.4.6.orig/policy/modules/services/clamav.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/clamav.te	2007-01-04 15:33:07.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(clamav,1.1.0)
 # Main clamd domain
 type clamd_t;
 type clamd_exec_t;
+corenet_type(clamd_t)
 init_daemon_domain(clamd_t, clamd_exec_t)
 
 # configuration files
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/clockspeed.te serefpolicy-2.4.6.patch/policy/modules/services/clockspeed.te
--- serefpolicy-2.4.6.orig/policy/modules/services/clockspeed.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/clockspeed.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(clockspeed,1.1.0)
 
 type clockspeed_cli_t;
 type clockspeed_cli_exec_t;
+corenet_type(clockspeed_cli_t)
 domain_type(clockspeed_cli_t)
 domain_entry_file(clockspeed_cli_t,clockspeed_cli_exec_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/comsat.te serefpolicy-2.4.6.patch/policy/modules/services/comsat.te
--- serefpolicy-2.4.6.orig/policy/modules/services/comsat.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/comsat.te	2007-01-04 15:33:11.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(comsat,1.2.0)
 
 type comsat_t;
 type comsat_exec_t;
+corenet_type(comsat_t)
 inetd_udp_service_domain(comsat_t,comsat_exec_t)
 role system_r types comsat_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/courier.if serefpolicy-2.4.6.patch/policy/modules/services/courier.if
--- serefpolicy-2.4.6.orig/policy/modules/services/courier.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/courier.if	2007-01-04 15:33:09.000000000 -0600
@@ -19,6 +19,7 @@ template(`courier_domain_template',`
 
 	type courier_$1_t;
 	type courier_$1_exec_t;
+	corenet_type(courier_$1_exec_t)
 	init_daemon_domain(courier_$1_t,courier_$1_exec_t)
 
 	##############################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/cups.te serefpolicy-2.4.6.patch/policy/modules/services/cups.te
--- serefpolicy-2.4.6.orig/policy/modules/services/cups.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/cups.te	2007-01-04 15:33:07.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(cups,1.4.1)
 
 type cupsd_config_t;
 type cupsd_config_exec_t;
+corenet_type(cupsd_config_t)
 init_daemon_domain(cupsd_config_t,cupsd_config_exec_t)
 
 type cupsd_config_var_run_t;
@@ -15,6 +16,7 @@ files_pid_file(cupsd_config_var_run_t)
 
 type cupsd_t;
 type cupsd_exec_t;
+corenet_type(cupsd_t)
 init_daemon_domain(cupsd_t,cupsd_exec_t)
 
 type cupsd_etc_t;
@@ -28,6 +30,7 @@ logging_log_file(cupsd_log_t)
 
 type cupsd_lpd_t;
 type cupsd_lpd_exec_t;
+corenet_type(cupsd_lpd_t)
 domain_type(cupsd_lpd_t)
 domain_entry_file(cupsd_lpd_t,cupsd_lpd_exec_t)
 role system_r types cupsd_lpd_t;
@@ -47,6 +50,7 @@ files_pid_file(cupsd_var_run_t)
 type hplip_t;
 type hplip_exec_t;
 init_daemon_domain(hplip_t,hplip_exec_t)
+corenet_type(hplip_t)
 
 type hplip_etc_t;
 files_config_file(hplip_etc_t)
@@ -57,6 +61,7 @@ files_pid_file(hplip_var_run_t)
 type ptal_t;
 type ptal_exec_t;
 init_daemon_domain(ptal_t,ptal_exec_t)
+corenet_type(ptal_t)
 
 type ptal_etc_t;
 files_config_file(ptal_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/cvs.te serefpolicy-2.4.6.patch/policy/modules/services/cvs.te
--- serefpolicy-2.4.6.orig/policy/modules/services/cvs.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/cvs.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(cvs,1.3.0)
 
 type cvs_t;
 type cvs_exec_t;
+corenet_type(cvs_t)
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
 userdom_executable_file(cvs_exec_t)
 role system_r types cvs_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/cyrus.te serefpolicy-2.4.6.patch/policy/modules/services/cyrus.te
--- serefpolicy-2.4.6.orig/policy/modules/services/cyrus.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/cyrus.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(cyrus,1.2.0)
 type cyrus_t;
 type cyrus_exec_t;
 init_daemon_domain(cyrus_t,cyrus_exec_t)
+corenet_type(cyrus_t)
 
 type cyrus_tmp_t;
 files_tmp_file(cyrus_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dante.te serefpolicy-2.4.6.patch/policy/modules/services/dante.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dante.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dante.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(dante,1.1.0)
 type dante_t;
 type dante_exec_t;
 init_daemon_domain(dante_t,dante_exec_t)
+corenet_type(dante_t)
 
 type dante_conf_t;
 files_type(dante_conf_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dbskk.te serefpolicy-2.4.6.patch/policy/modules/services/dbskk.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dbskk.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dbskk.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(dbskk,1.2.0)
 
 type dbskkd_t;
 type dbskkd_exec_t;
+corenet_type(dbskkd_t)
 inetd_service_domain(dbskkd_t,dbskkd_exec_t)
 role system_r types dbskkd_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dbus.if serefpolicy-2.4.6.patch/policy/modules/services/dbus.if
--- serefpolicy-2.4.6.orig/policy/modules/services/dbus.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dbus.if	2007-01-04 15:33:07.000000000 -0600
@@ -57,6 +57,7 @@ template(`dbus_per_role_template',`
 	type $1_dbusd_t;
 	domain_type($1_dbusd_t)
 	domain_entry_file($1_dbusd_t,system_dbusd_exec_t)
+	corenet_type($1_dbusd_t)
 	role $3 types $1_dbusd_t;
 
 	type $1_dbusd_$1_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dcc.te serefpolicy-2.4.6.patch/policy/modules/services/dcc.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dcc.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dcc.te	2007-01-04 15:33:10.000000000 -0600
@@ -10,6 +10,7 @@ type cdcc_t;
 type cdcc_exec_t;
 domain_type(cdcc_t)
 domain_entry_file(cdcc_t,cdcc_exec_t)
+corenet_type(cdcc_t)
 role system_r types cdcc_t;
 
 type cdcc_tmp_t;
@@ -19,6 +20,7 @@ type dcc_client_t;
 type dcc_client_exec_t;
 domain_type(dcc_client_t)
 domain_entry_file(dcc_client_t,dcc_client_exec_t)
+corenet_type(dcc_client_t)
 role system_r types dcc_client_t;
 
 type dcc_client_map_t;
@@ -31,6 +33,7 @@ type dcc_dbclean_t;
 type dcc_dbclean_exec_t;
 domain_type(dcc_dbclean_t)
 domain_entry_file(dcc_dbclean_t,dcc_dbclean_exec_t)
+corenet_type(dcc_dbclean_t)
 role system_r types dcc_dbclean_t;
 
 type dcc_dbclean_tmp_t;
@@ -45,6 +48,7 @@ files_type(dcc_var_run_t)
 type dccd_t;
 type dccd_exec_t;
 init_daemon_domain(dccd_t,dccd_exec_t)
+corenet_type(dccd_t)
 
 type dccd_tmp_t;
 files_tmp_file(dccd_tmp_t)
@@ -55,6 +59,7 @@ files_pid_file(dccd_var_run_t)
 type dccifd_t;
 type dccifd_exec_t;
 init_daemon_domain(dccifd_t,dccifd_exec_t)
+corenet_type(dccifd_t)
 
 type dccifd_tmp_t;
 files_tmp_file(dccifd_tmp_t)
@@ -65,6 +70,7 @@ files_pid_file(dccifd_var_run_t)
 type dccm_t;
 type dccm_exec_t;
 init_daemon_domain(dccm_t,dccm_exec_t)
+corenet_type(dccm_t)
 
 type dccm_tmp_t;
 files_tmp_file(dccm_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ddclient.te serefpolicy-2.4.6.patch/policy/modules/services/ddclient.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ddclient.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ddclient.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ddclient,1.1.0)
 type ddclient_t;
 type ddclient_exec_t;
 init_daemon_domain(ddclient_t,ddclient_exec_t)
+corenet_type(ddclient_t)
 
 type ddclient_etc_t;
 files_type(ddclient_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dhcp.te serefpolicy-2.4.6.patch/policy/modules/services/dhcp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dhcp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dhcp.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(dhcp,1.2.0)
 type dhcpd_t;
 type dhcpd_exec_t;
 init_daemon_domain(dhcpd_t,dhcpd_exec_t)
+corenet_type(dhcpd_t)
 
 type dhcpd_state_t;
 files_type(dhcpd_state_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dictd.te serefpolicy-2.4.6.patch/policy/modules/services/dictd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dictd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dictd.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(dictd,1.2.0)
 type dictd_t;
 type dictd_exec_t;
 init_system_domain(dictd_t,dictd_exec_t)
+corenet_type(dictd_t)
 
 type dictd_etc_t;
 files_config_file(dictd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/distcc.te serefpolicy-2.4.6.patch/policy/modules/services/distcc.te
--- serefpolicy-2.4.6.orig/policy/modules/services/distcc.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/distcc.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(distcc,1.2.0)
 type distccd_t;
 type distccd_exec_t;
 init_daemon_domain(distccd_t,distccd_exec_t)
+corenet_type(distccd_t)
 
 type distccd_log_t;
 logging_log_file(distccd_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/djbdns.if serefpolicy-2.4.6.patch/policy/modules/services/djbdns.if
--- serefpolicy-2.4.6.orig/policy/modules/services/djbdns.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/djbdns.if	2007-01-04 15:33:07.000000000 -0600
@@ -18,6 +18,7 @@ template(`djbdns_daemontools_domain_temp
 	type djbdns_$1_conf_t;
 	files_config_file(djbdns_$1_conf_t)
 
+	corenet_type(djbdns_$1_t)
 	domain_type(djbdns_$1_t)
 	domain_entry_file(djbdns_$1_t,djbdns_$1_exec_t)
 	role system_r types djbdns_$1_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dnsmasq.te serefpolicy-2.4.6.patch/policy/modules/services/dnsmasq.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dnsmasq.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dnsmasq.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(dnsmasq,1.1.1)
 type dnsmasq_t;
 type dnsmasq_exec_t;
 init_daemon_domain(dnsmasq_t,dnsmasq_exec_t)
+corenet_type(dnsmasq_t)
 
 type dnsmasq_lease_t;
 files_type(dnsmasq_lease_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/dovecot.te serefpolicy-2.4.6.patch/policy/modules/services/dovecot.te
--- serefpolicy-2.4.6.orig/policy/modules/services/dovecot.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/dovecot.te	2007-01-04 15:33:09.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(dovecot,1.3.1)
 type dovecot_t;
 type dovecot_exec_t;
 init_daemon_domain(dovecot_t,dovecot_exec_t)
+corenet_type(dovecot_t)
 
 type dovecot_auth_t;
 type dovecot_auth_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/fetchmail.te serefpolicy-2.4.6.patch/policy/modules/services/fetchmail.te
--- serefpolicy-2.4.6.orig/policy/modules/services/fetchmail.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/fetchmail.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(fetchmail,1.2.0)
 type fetchmail_t;
 type fetchmail_exec_t;
 init_daemon_domain(fetchmail_t,fetchmail_exec_t)
+corenet_type(fetchmail_t)
 
 type fetchmail_var_run_t;
 files_pid_file(fetchmail_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/finger.te serefpolicy-2.4.6.patch/policy/modules/services/finger.te
--- serefpolicy-2.4.6.orig/policy/modules/services/finger.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/finger.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(finger,1.2.0)
 type fingerd_t;
 type fingerd_exec_t;
 init_daemon_domain(fingerd_t,fingerd_exec_t)
+corenet_type(fingerd_t)
 inetd_tcp_service_domain(fingerd_t,fingerd_exec_t)
 
 type fingerd_etc_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ftp.te serefpolicy-2.4.6.patch/policy/modules/services/ftp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ftp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ftp.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ftp,1.3.0)
 type ftpd_t;
 type ftpd_exec_t;
 init_daemon_domain(ftpd_t,ftpd_exec_t)
+corenet_type(ftpd_t)
 
 type ftpd_etc_t;
 files_config_file(ftpd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/gatekeeper.te serefpolicy-2.4.6.patch/policy/modules/services/gatekeeper.te
--- serefpolicy-2.4.6.orig/policy/modules/services/gatekeeper.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/gatekeeper.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(gatekeeper,1.1.0)
 type gatekeeper_t;
 type gatekeeper_exec_t;
 init_daemon_domain(gatekeeper_t,gatekeeper_exec_t)
+corenet_type(gatekeeper_t)
 
 type gatekeeper_etc_t;
 files_config_file(gatekeeper_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/hal.te serefpolicy-2.4.6.patch/policy/modules/services/hal.te
--- serefpolicy-2.4.6.orig/policy/modules/services/hal.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/hal.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(hal,1.4.1)
 type hald_t;
 type hald_exec_t;
 init_daemon_domain(hald_t,hald_exec_t)
+corenet_type(hald_t)
 
 type hald_tmp_t;
 files_tmp_file(hald_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/howl.te serefpolicy-2.4.6.patch/policy/modules/services/howl.te
--- serefpolicy-2.4.6.orig/policy/modules/services/howl.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/howl.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(howl,1.2.0)
 type howl_t;
 type howl_exec_t;
 init_daemon_domain(howl_t,howl_exec_t)
+corenet_type(howl_t)
 
 type howl_var_run_t;
 files_pid_file(howl_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/i18n_input.te serefpolicy-2.4.6.patch/policy/modules/services/i18n_input.te
--- serefpolicy-2.4.6.orig/policy/modules/services/i18n_input.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/i18n_input.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(i18n_input,1.2.0)
 type i18n_input_t;
 type i18n_input_exec_t;
 init_daemon_domain(i18n_input_t,i18n_input_exec_t)
+corenet_type(i18n_input_t)
 
 type i18n_input_var_run_t;
 files_pid_file(i18n_input_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/imaze.te serefpolicy-2.4.6.patch/policy/modules/services/imaze.te
--- serefpolicy-2.4.6.orig/policy/modules/services/imaze.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/imaze.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(imaze,1.1.0)
 type imazesrv_t;
 type imazesrv_exec_t;
 init_daemon_domain(imazesrv_t,imazesrv_exec_t)
+corenet_type(imazesrv_t)
 
 type imazesrv_data_t;
 files_type(imazesrv_data_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/inetd.te serefpolicy-2.4.6.patch/policy/modules/services/inetd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/inetd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/inetd.te	2007-01-04 15:33:07.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(inetd,1.2.0)
 type inetd_t;
 type inetd_exec_t;
 init_daemon_domain(inetd_t,inetd_exec_t)
+corenet_type(inetd_t)
 
 type inetd_log_t;
 logging_log_file(inetd_log_t)
@@ -22,6 +23,7 @@ files_pid_file(inetd_var_run_t)
 type inetd_child_t;
 type inetd_child_exec_t;
 inetd_service_domain(inetd_child_t,inetd_child_exec_t)
+corenet_type(inetd_child_t)
 role system_r types inetd_child_t;
 
 type inetd_child_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/inn.te serefpolicy-2.4.6.patch/policy/modules/services/inn.te
--- serefpolicy-2.4.6.orig/policy/modules/services/inn.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/inn.te	2007-01-04 15:33:07.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(inn,1.2.0)
 type innd_t;
 type innd_exec_t;
 init_daemon_domain(innd_t,innd_exec_t)
+corenet_type(innd_t)
 
 type innd_etc_t;
 files_config_file(innd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ircd.te serefpolicy-2.4.6.patch/policy/modules/services/ircd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ircd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ircd.te	2007-01-04 15:33:07.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ircd,1.1.0)
 type ircd_t;
 type ircd_exec_t;
 init_daemon_domain(ircd_t,ircd_exec_t)
+corenet_type(ircd_t)
 
 type ircd_etc_t;
 files_config_file(ircd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/jabber.te serefpolicy-2.4.6.patch/policy/modules/services/jabber.te
--- serefpolicy-2.4.6.orig/policy/modules/services/jabber.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/jabber.te	2007-01-04 15:33:07.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(jabber,1.1.0)
 type jabberd_t;
 type jabberd_exec_t;
 init_daemon_domain(jabberd_t,jabberd_exec_t)
+corenet_type(jabberd_t)
 
 type jabberd_log_t;
 logging_log_file(jabberd_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/kerberos.te serefpolicy-2.4.6.patch/policy/modules/services/kerberos.te
--- serefpolicy-2.4.6.orig/policy/modules/services/kerberos.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/kerberos.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(kerberos,1.2.0)
 type kadmind_t;
 type kadmind_exec_t;
 init_daemon_domain(kadmind_t,kadmind_exec_t)
+corenet_type(kadmind_t)
 
 type kadmind_log_t;
 logging_log_file(kadmind_log_t)
@@ -37,6 +38,7 @@ files_type(krb5kdc_principal_t)
 type krb5kdc_t;
 type krb5kdc_exec_t;
 init_daemon_domain(krb5kdc_t,krb5kdc_exec_t)
+corenet_type(krb5kdc_t)
 
 type krb5kdc_log_t;
 logging_log_file(krb5kdc_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ktalk.te serefpolicy-2.4.6.patch/policy/modules/services/ktalk.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ktalk.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ktalk.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(ktalk,1.3.0)
 
 type ktalkd_t;
 type ktalkd_exec_t;
+corenet_type(ktalkd_t)
 inetd_udp_service_domain(ktalkd_t,ktalkd_exec_t)
 role system_r types ktalkd_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ldap.te serefpolicy-2.4.6.patch/policy/modules/services/ldap.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ldap.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ldap.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ldap,1.3.0)
 type slapd_t;
 type slapd_exec_t;
 init_daemon_domain(slapd_t,slapd_exec_t)
+corenet_type(slapd_t)
 
 type slapd_cert_t;
 files_type(slapd_cert_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/lpd.te serefpolicy-2.4.6.patch/policy/modules/services/lpd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/lpd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/lpd.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(lpd,1.3.1)
 type checkpc_t;
 type checkpc_exec_t;
 init_system_domain(checkpc_t,checkpc_exec_t)
+corenet_type(checkpc_t)
 role system_r types checkpc_t;
 
 type checkpc_log_t;
@@ -17,6 +18,7 @@ logging_log_file(checkpc_log_t)
 type lpd_t;
 type lpd_exec_t;
 init_daemon_domain(lpd_t,lpd_exec_t)
+corenet_type(lpd_t)
 
 type lpd_tmp_t;
 files_tmp_file(lpd_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/mailman.if serefpolicy-2.4.6.patch/policy/modules/services/mailman.if
--- serefpolicy-2.4.6.orig/policy/modules/services/mailman.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/mailman.if	2007-01-04 15:33:09.000000000 -0600
@@ -19,6 +19,7 @@
 template(`mailman_domain_template', `
 	type mailman_$1_t;
 	domain_type(mailman_$1_t)
+	corenet_type(mailman_$1_t)
 	role system_r types mailman_$1_t;
 
 	type mailman_$1_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/monop.te serefpolicy-2.4.6.patch/policy/modules/services/monop.te
--- serefpolicy-2.4.6.orig/policy/modules/services/monop.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/monop.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(monop,1.1.0)
 type monopd_t;
 type monopd_exec_t;
 init_daemon_domain(monopd_t,monopd_exec_t)
+corenet_type(monopd_t)
 
 type monopd_etc_t;
 files_config_file(monopd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/mta.if serefpolicy-2.4.6.patch/policy/modules/services/mta.if
--- serefpolicy-2.4.6.orig/policy/modules/services/mta.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/mta.if	2007-01-04 15:33:09.000000000 -0600
@@ -48,6 +48,7 @@ template(`mta_base_mail_template',`
 	type $1_mail_t, user_mail_domain;
 	domain_type($1_mail_t)
 	domain_entry_file($1_mail_t,sendmail_exec_t)
+	corenet_type($1_mail_t)
 
 	type $1_mail_tmp_t;
 	files_tmp_file($1_mail_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/munin.te serefpolicy-2.4.6.patch/policy/modules/services/munin.te
--- serefpolicy-2.4.6.orig/policy/modules/services/munin.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/munin.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(munin,1.1.0)
 type munin_t alias lrrd_t;
 type munin_exec_t alias lrrd_exec_t;
 init_daemon_domain(munin_t,munin_exec_t)
+corenet_type(munin_t)
 
 type munin_etc_t alias lrrd_etc_t;
 files_config_file(munin_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/mysql.te serefpolicy-2.4.6.patch/policy/modules/services/mysql.te
--- serefpolicy-2.4.6.orig/policy/modules/services/mysql.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/mysql.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(mysql,1.3.0)
 type mysqld_t;
 type mysqld_exec_t;
 init_daemon_domain(mysqld_t,mysqld_exec_t)
+corenet_type(mysqld_t)
 
 type mysqld_var_run_t;
 files_pid_file(mysqld_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nagios.te serefpolicy-2.4.6.patch/policy/modules/services/nagios.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nagios.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nagios.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(nagios,1.1.0)
 type nagios_t;
 type nagios_exec_t;
 init_daemon_domain(nagios_t,nagios_exec_t)
+corenet_type(nagios_t)
 
 type nagios_cgi_t;
 type nagios_cgi_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nessus.te serefpolicy-2.4.6.patch/policy/modules/services/nessus.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nessus.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nessus.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(nessus,1.1.0)
 type nessusd_t;
 type nessusd_exec_t;
 init_daemon_domain(nessusd_t,nessusd_exec_t)
+corenet_type(nessusd_t)
 
 type nessusd_db_t;
 files_type(nessusd_db_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/networkmanager.te serefpolicy-2.4.6.patch/policy/modules/services/networkmanager.te
--- serefpolicy-2.4.6.orig/policy/modules/services/networkmanager.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/networkmanager.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(networkmanager,1.4.1)
 type NetworkManager_t;
 type NetworkManager_exec_t;
 init_daemon_domain(NetworkManager_t,NetworkManager_exec_t)
+corenet_type(NetworkManager_t)
 
 type NetworkManager_var_run_t;
 files_pid_file(NetworkManager_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nis.te serefpolicy-2.4.6.patch/policy/modules/services/nis.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nis.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nis.te	2007-01-04 15:33:09.000000000 -0600
@@ -12,6 +12,7 @@ files_type(var_yp_t)
 type ypbind_t;
 type ypbind_exec_t;
 init_daemon_domain(ypbind_t,ypbind_exec_t)
+corenet_type(ypbind_t)
 
 type ypbind_tmp_t;
 files_tmp_file(ypbind_tmp_t)
@@ -22,6 +23,7 @@ files_pid_file(ypbind_var_run_t)
 type yppasswdd_t;
 type yppasswdd_exec_t;
 init_daemon_domain(yppasswdd_t,yppasswdd_exec_t)
+corenet_type(yppasswdd_t)
 domain_obj_id_change_exemption(yppasswdd_t)
 
 type yppasswdd_var_run_t;
@@ -30,6 +32,7 @@ files_pid_file(yppasswdd_var_run_t)
 type ypserv_t;
 type ypserv_exec_t;
 init_daemon_domain(ypserv_t,ypserv_exec_t)
+corenet_type(ypserv_t)
 
 type ypserv_conf_t;
 files_type(ypserv_conf_t)
@@ -43,6 +46,7 @@ files_pid_file(ypserv_var_run_t)
 type ypxfr_t;
 type ypxfr_exec_t;
 init_daemon_domain(ypxfr_t,ypxfr_exec_t)
+corenet_type(ypxfr_t)
 
 ########################################
 #
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nscd.te serefpolicy-2.4.6.patch/policy/modules/services/nscd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nscd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nscd.te	2007-01-04 15:33:08.000000000 -0600
@@ -19,6 +19,7 @@ files_pid_file(nscd_var_run_t)
 type nscd_t;
 type nscd_exec_t;
 init_daemon_domain(nscd_t,nscd_exec_t)
+corenet_type(nscd_t)
 
 type nscd_log_t;
 logging_log_file(nscd_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nsd.te serefpolicy-2.4.6.patch/policy/modules/services/nsd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nsd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nsd.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(nsd,1.1.0)
 type nsd_t;
 type nsd_exec_t;
 init_daemon_domain(nsd_t,nsd_exec_t)
+corenet_type(nsd_t)
 
 # A type for configuration files of nsd
 type nsd_conf_t;
@@ -17,6 +18,7 @@ files_type(nsd_conf_t)
 type nsd_crond_t;
 domain_type(nsd_crond_t)
 domain_entry_file(nsd_crond_t,nsd_exec_t)
+corenet_type(nsd_crond_t)
 role system_r types nsd_crond_t;
 
 # a type for nsd.db
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ntop.te serefpolicy-2.4.6.patch/policy/modules/services/ntop.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ntop.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ntop.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(ntop,1.1.0)
 type ntop_t;
 type ntop_exec_t;
 init_daemon_domain(ntop_t,ntop_exec_t)
+corenet_type(ntop_t)
 
 type ntop_etc_t;
 files_config_file(ntop_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ntp.te serefpolicy-2.4.6.patch/policy/modules/services/ntp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ntp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ntp.te	2007-01-04 15:33:10.000000000 -0600
@@ -12,6 +12,7 @@ files_type(ntp_drift_t)
 type ntpd_t;
 type ntpd_exec_t;
 init_daemon_domain(ntpd_t,ntpd_exec_t)
+corenet_type(ntpd_t)
 
 type ntpd_log_t;
 logging_log_file(ntpd_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/nx.te serefpolicy-2.4.6.patch/policy/modules/services/nx.te
--- serefpolicy-2.4.6.orig/policy/modules/services/nx.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/nx.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(nx,1.1.0)
 
 type nx_server_t;
 type nx_server_exec_t;
+corenet_type(nx_server_t)
 domain_type(nx_server_t)
 domain_entry_file(nx_server_t,nx_server_exec_t)
 domain_user_exemption_target(nx_server_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/oav.te serefpolicy-2.4.6.patch/policy/modules/services/oav.te
--- serefpolicy-2.4.6.orig/policy/modules/services/oav.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/oav.te	2007-01-04 15:33:07.000000000 -0600
@@ -10,6 +10,7 @@ type oav_update_t;
 type oav_update_exec_t;
 domain_type(oav_update_t)
 domain_entry_file(oav_update_t,oav_update_exec_t)
+corenet_type(oav_update_t)
 
 # cjp: may be collapsable to etc_t
 type oav_update_etc_t;
@@ -21,6 +22,7 @@ files_type(oav_update_var_lib_t)
 type scannerdaemon_t;
 type scannerdaemon_exec_t;
 init_daemon_domain(scannerdaemon_t,scannerdaemon_exec_t)
+corenet_type(scannerdaemon_t)
 
 type scannerdaemon_etc_t;
 files_type(scannerdaemon_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/openvpn.te serefpolicy-2.4.6.patch/policy/modules/services/openvpn.te
--- serefpolicy-2.4.6.orig/policy/modules/services/openvpn.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/openvpn.te	2007-01-04 15:33:08.000000000 -0600
@@ -10,6 +10,7 @@ policy_module(openvpn,1.1.0)
 type openvpn_t;
 type openvpn_exec_t;
 init_daemon_domain(openvpn_t, openvpn_exec_t)
+corenet_type(openvpn_t)
 
 # configuration files
 type openvpn_etc_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/pegasus.te serefpolicy-2.4.6.patch/policy/modules/services/pegasus.te
--- serefpolicy-2.4.6.orig/policy/modules/services/pegasus.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/pegasus.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(pegasus,1.2.0)
 type pegasus_t;
 type pegasus_exec_t;
 init_daemon_domain(pegasus_t,pegasus_exec_t)
+corenet_type(pegasus_t)
 
 type pegasus_data_t;
 files_type(pegasus_data_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/perdition.te serefpolicy-2.4.6.patch/policy/modules/services/perdition.te
--- serefpolicy-2.4.6.orig/policy/modules/services/perdition.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/perdition.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(perdition,1.1.0)
 type perdition_t;
 type perdition_exec_t;
 init_daemon_domain(perdition_t,perdition_exec_t)
+corenet_type(perdition_t)
 
 type perdition_etc_t;
 files_config_file(perdition_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/portmap.te serefpolicy-2.4.6.patch/policy/modules/services/portmap.te
--- serefpolicy-2.4.6.orig/policy/modules/services/portmap.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/portmap.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,10 +9,12 @@ policy_module(portmap,1.3.0)
 type portmap_t;
 type portmap_exec_t;
 init_daemon_domain(portmap_t,portmap_exec_t)
+corenet_type(portmap_t)
 
 type portmap_helper_t;
 type portmap_helper_exec_t;
 init_system_domain(portmap_helper_t,portmap_helper_exec_t)
+corenet_type(portmap_helper_t)
 role system_r types portmap_helper_t;
 
 type portmap_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/portslave.te serefpolicy-2.4.6.patch/policy/modules/services/portslave.te
--- serefpolicy-2.4.6.orig/policy/modules/services/portslave.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/portslave.te	2007-01-04 15:33:10.000000000 -0600
@@ -10,6 +10,7 @@ type portslave_t;
 type portslave_exec_t;
 init_domain(portslave_t,portslave_exec_t)
 init_daemon_domain(portslave_t,portslave_exec_t)
+corenet_type(portslave_t)
 
 type portslave_etc_t;
 files_type(portslave_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/postfix.if serefpolicy-2.4.6.patch/policy/modules/services/postfix.if
--- serefpolicy-2.4.6.orig/policy/modules/services/postfix.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/postfix.if	2007-01-04 15:33:09.000000000 -0600
@@ -32,6 +32,7 @@ template(`postfix_domain_template',`
 	type postfix_$1_exec_t;
 	domain_type(postfix_$1_t)
 	domain_entry_file(postfix_$1_t,postfix_$1_exec_t)
+	corenet_type(postfix_$1_t)
 	role system_r types postfix_$1_t;
 
 	dontaudit postfix_$1_t self:capability sys_tty_config;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/postfix.te serefpolicy-2.4.6.patch/policy/modules/services/postfix.te
--- serefpolicy-2.4.6.orig/policy/modules/services/postfix.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/postfix.te	2007-01-04 15:33:07.000000000 -0600
@@ -33,6 +33,7 @@ files_tmp_file(postfix_local_tmp_t)
 # Program for creating database files
 type postfix_map_t;
 type postfix_map_exec_t;
+corenet_type(postfix_map_t)
 domain_type(postfix_map_t)
 domain_entry_file(postfix_map_t,postfix_map_exec_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/postgresql.te serefpolicy-2.4.6.patch/policy/modules/services/postgresql.te
--- serefpolicy-2.4.6.orig/policy/modules/services/postgresql.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/postgresql.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(postgresql,1.2.0)
 type postgresql_t;
 type postgresql_exec_t;
 init_daemon_domain(postgresql_t,postgresql_exec_t)
+corenet_type(postgresql_t)
 
 type postgresql_db_t;
 files_type(postgresql_db_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/postgrey.te serefpolicy-2.4.6.patch/policy/modules/services/postgrey.te
--- serefpolicy-2.4.6.orig/policy/modules/services/postgrey.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/postgrey.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(postgrey,1.1.0)
 type postgrey_t;
 type postgrey_exec_t;
 init_daemon_domain(postgrey_t,postgrey_exec_t)
+corenet_type(postgrey_t)
 
 type postgrey_etc_t;
 files_config_file(postgrey_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ppp.te serefpolicy-2.4.6.patch/policy/modules/services/ppp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ppp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ppp.te	2007-01-04 15:33:10.000000000 -0600
@@ -11,6 +11,7 @@ policy_module(ppp,1.3.0)
 type pppd_t;
 type pppd_exec_t;
 init_daemon_domain(pppd_t,pppd_exec_t)
+corenet_type(pppd_t)
 
 type pppd_devpts_t;
 term_pty(pppd_devpts_t)
@@ -45,6 +46,7 @@ files_pid_file(pppd_var_run_t)
 type pptp_t;
 type pptp_exec_t;
 init_daemon_domain(pptp_t,pptp_exec_t)
+corenet_type(pptp_t)
 
 type pptp_log_t;
 logging_log_file(pptp_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/privoxy.te serefpolicy-2.4.6.patch/policy/modules/services/privoxy.te
--- serefpolicy-2.4.6.orig/policy/modules/services/privoxy.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/privoxy.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(privoxy,1.2.0)
 type privoxy_t; # web_client_domain
 type privoxy_exec_t;
 init_daemon_domain(privoxy_t,privoxy_exec_t)
+corenet_type(privoxy_t)
 
 type privoxy_etc_rw_t;
 files_type(privoxy_etc_rw_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/procmail.te serefpolicy-2.4.6.patch/policy/modules/services/procmail.te
--- serefpolicy-2.4.6.orig/policy/modules/services/procmail.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/procmail.te	2007-01-04 15:33:08.000000000 -0600
@@ -11,6 +11,7 @@ type procmail_exec_t;
 domain_type(procmail_t)
 domain_entry_file(procmail_t,procmail_exec_t)
 userdom_executable_file(procmail_exec_t)
+corenet_type(procmail_t)
 role system_r types procmail_t;
 
 ########################################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/pyzor.te serefpolicy-2.4.6.patch/policy/modules/services/pyzor.te
--- serefpolicy-2.4.6.orig/policy/modules/services/pyzor.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/pyzor.te	2007-01-04 15:33:10.000000000 -0600
@@ -16,6 +16,7 @@ type pyzord_t;
 type pyzord_exec_t;
 domain_type(pyzord_t)
 init_daemon_domain(pyzord_t,pyzord_exec_t)
+corenet_type(pyzord_t)
 
 type pyzor_etc_t;
 files_type(pyzor_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/radius.te serefpolicy-2.4.6.patch/policy/modules/services/radius.te
--- serefpolicy-2.4.6.orig/policy/modules/services/radius.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/radius.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(radius,1.2.0)
 type radiusd_t;
 type radiusd_exec_t;
 init_daemon_domain(radiusd_t,radiusd_exec_t)
+corenet_type(radiusd_t)
 
 type radiusd_etc_t;
 files_config_file(radiusd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/radvd.te serefpolicy-2.4.6.patch/policy/modules/services/radvd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/radvd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/radvd.te	2007-01-04 15:33:07.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(radvd,1.2.0)
 type radvd_t;
 type radvd_exec_t;
 init_daemon_domain(radvd_t,radvd_exec_t)
+corenet_type(radvd_t)
 
 type radvd_var_run_t;
 files_pid_file(radvd_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/razor.te serefpolicy-2.4.6.patch/policy/modules/services/razor.te
--- serefpolicy-2.4.6.orig/policy/modules/services/razor.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/razor.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(razor,1.1.0)
 
 type razor_t;
 type razor_exec_t;
+corenet_type(razor_t)
 domain_type(razor_t)
 domain_entry_file(razor_t,razor_exec_t)
 razor_common_domain_template(razor)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rdisc.te serefpolicy-2.4.6.patch/policy/modules/services/rdisc.te
--- serefpolicy-2.4.6.orig/policy/modules/services/rdisc.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rdisc.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(rdisc,1.2.0)
 type rdisc_t;
 type rdisc_exec_t;
 init_daemon_domain(rdisc_t,rdisc_exec_t)
+corenet_type(rdisc_t)
 
 ########################################
 #
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rhgb.te serefpolicy-2.4.6.patch/policy/modules/services/rhgb.te
--- serefpolicy-2.4.6.orig/policy/modules/services/rhgb.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rhgb.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(rhgb,1.1.1)
 type rhgb_t;
 type rhgb_exec_t;
 init_daemon_domain(rhgb_t,rhgb_exec_t)
+corenet_type(rhgb_t)
 
 type rhgb_tmpfs_t;
 files_tmpfs_file(rhgb_tmpfs_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ricci.te serefpolicy-2.4.6.patch/policy/modules/services/ricci.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ricci.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ricci.te	2007-01-04 15:33:08.000000000 -0600
@@ -10,6 +10,7 @@ type ricci_t;
 type ricci_exec_t;
 domain_type(ricci_t)
 init_daemon_domain(ricci_t, ricci_exec_t)
+corenet_type(ricci_t)
 
 # tmp files
 type ricci_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rlogin.te serefpolicy-2.4.6.patch/policy/modules/services/rlogin.te
--- serefpolicy-2.4.6.orig/policy/modules/services/rlogin.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rlogin.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(rlogin,1.2.0)
 
 type rlogind_t;
 type rlogind_exec_t;
+corenet_type(rlogind_t)
 inetd_service_domain(rlogind_t,rlogind_exec_t)
 role system_r types rlogind_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/roundup.te serefpolicy-2.4.6.patch/policy/modules/services/roundup.te
--- serefpolicy-2.4.6.orig/policy/modules/services/roundup.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/roundup.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(roundup,1.1.0)
 type roundup_t;
 type roundup_exec_t;
 init_daemon_domain(roundup_t,roundup_exec_t)
+corenet_type(roundup_t)
 
 type roundup_var_run_t;
 files_pid_file(roundup_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rpc.if serefpolicy-2.4.6.patch/policy/modules/services/rpc.if
--- serefpolicy-2.4.6.orig/policy/modules/services/rpc.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rpc.if	2007-01-04 15:33:08.000000000 -0600
@@ -40,6 +40,7 @@ template(`rpc_domain_template', `
 
 	type $1_t;
 	type $1_exec_t;
+	corenet_type($1_t)
 	init_daemon_domain($1_t,$1_exec_t)
 	domain_use_interactive_fds($1_t)
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rshd.te serefpolicy-2.4.6.patch/policy/modules/services/rshd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/rshd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rshd.te	2007-01-04 15:33:09.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(rshd,1.2.0)
 #
 type rshd_t;
 type rshd_exec_t;
+corenet_type(rshd_t)
 inetd_tcp_service_domain(rshd_t,rshd_exec_t)
 domain_subj_id_change_exemption(rshd_t)
 domain_role_change_exemption(rshd_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/rsync.te serefpolicy-2.4.6.patch/policy/modules/services/rsync.te
--- serefpolicy-2.4.6.orig/policy/modules/services/rsync.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/rsync.te	2007-01-04 15:33:10.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(rsync,1.3.0)
 
 type rsync_t;
 type rsync_exec_t;
+corenet_type(rsync_t)
 init_daemon_domain(rsync_t,rsync_exec_t)
 userdom_executable_file(rsync_exec_t)
 role system_r types rsync_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/samba.te serefpolicy-2.4.6.patch/policy/modules/services/samba.te
--- serefpolicy-2.4.6.orig/policy/modules/services/samba.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/samba.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(samba,1.3.1)
 type nmbd_t;
 type nmbd_exec_t;
 init_daemon_domain(nmbd_t,nmbd_exec_t)
+corenet_type(nmbd_t)
 
 type nmbd_var_run_t;
 files_pid_file(nmbd_var_run_t)
@@ -21,6 +22,7 @@ logging_log_file(samba_log_t)
 
 type samba_net_t;
 domain_type(samba_net_t)
+corenet_type(samba_net_t)
 role system_r types samba_net_t;
 
 type samba_net_exec_t;
@@ -41,6 +43,7 @@ files_type(samba_var_t)
 type smbd_t;
 type smbd_exec_t;
 init_daemon_domain(smbd_t,smbd_exec_t)
+corenet_type(smbd_t)
 
 type smbd_tmp_t;
 files_tmp_file(smbd_tmp_t)
@@ -50,12 +53,14 @@ files_pid_file(smbd_var_run_t)
 
 type smbmount_t;
 domain_type(smbmount_t)
+corenet_type(smbmount_t)
 
 type smbmount_exec_t;
 domain_entry_file(smbmount_t,smbmount_exec_t)
 
 type swat_t;
 type swat_exec_t;
+corenet_type(swat_t)
 domain_type(swat_t)
 domain_entry_file(swat_t,swat_exec_t)
 role system_r types swat_t;
@@ -69,6 +74,7 @@ files_pid_file(swat_var_run_t)
 type winbind_t;
 type winbind_exec_t;
 init_daemon_domain(winbind_t,winbind_exec_t)
+corenet_type(winbind_t)
 
 type winbind_helper_t;
 domain_type(winbind_helper_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/sasl.te serefpolicy-2.4.6.patch/policy/modules/services/sasl.te
--- serefpolicy-2.4.6.orig/policy/modules/services/sasl.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/sasl.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(sasl,1.3.0)
 type saslauthd_t;
 type saslauthd_exec_t;
 init_daemon_domain(saslauthd_t,saslauthd_exec_t)
+corenet_type(saslauthd_t)
 
 type saslauthd_var_run_t;
 files_pid_file(saslauthd_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/sendmail.te serefpolicy-2.4.6.patch/policy/modules/services/sendmail.te
--- serefpolicy-2.4.6.orig/policy/modules/services/sendmail.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/sendmail.te	2007-01-04 15:33:07.000000000 -0600
@@ -16,6 +16,7 @@ type sendmail_var_run_t;
 files_pid_file(sendmail_var_run_t)
 
 type sendmail_t;
+corenet_type(sendmail_t)
 mta_sendmail_mailserver(sendmail_t)
 mta_mailserver_delivery(sendmail_t)
 mta_mailserver_sender(sendmail_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/smartmon.te serefpolicy-2.4.6.patch/policy/modules/services/smartmon.te
--- serefpolicy-2.4.6.orig/policy/modules/services/smartmon.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/smartmon.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(smartmon,1.1.0)
 type fsdaemon_t;
 type fsdaemon_exec_t;
 init_daemon_domain(fsdaemon_t,fsdaemon_exec_t)
+corenet_type(fsdaemon_t)
 
 type fsdaemon_var_run_t;
 files_pid_file(fsdaemon_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/snmp.te serefpolicy-2.4.6.patch/policy/modules/services/snmp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/snmp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/snmp.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(snmp,1.2.1)
 type snmpd_t;
 type snmpd_exec_t;
 init_daemon_domain(snmpd_t,snmpd_exec_t)
+corenet_type(snmpd_t)
 
 type snmpd_etc_t;
 files_config_file(snmpd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/snort.te serefpolicy-2.4.6.patch/policy/modules/services/snort.te
--- serefpolicy-2.4.6.orig/policy/modules/services/snort.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/snort.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(snort,1.1.0)
 type snort_t;
 type snort_exec_t;
 init_daemon_domain(snort_t,snort_exec_t)
+corenet_type(snort_t)
 
 type snort_etc_t;
 files_type(snort_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/soundserver.te serefpolicy-2.4.6.patch/policy/modules/services/soundserver.te
--- serefpolicy-2.4.6.orig/policy/modules/services/soundserver.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/soundserver.te	2007-01-04 15:33:11.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(soundserver,1.1.0)
 type soundd_t;
 type soundd_exec_t;
 init_daemon_domain(soundd_t,soundd_exec_t)
+corenet_type(soundd_t)
 
 type soundd_etc_t alias etc_soundd_t;
 files_type(soundd_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/spamassassin.if serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.if
--- serefpolicy-2.4.6.orig/policy/modules/services/spamassassin.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.if	2007-01-04 15:33:10.000000000 -0600
@@ -43,6 +43,7 @@ template(`spamassassin_per_role_template
 	type $1_spamc_t;
 	domain_type($1_spamc_t)
 	domain_entry_file($1_spamc_t,spamc_exec_t)
+	corenet_type($1_spamc_t)
 	role $3 types $1_spamc_t;
 
 	type $1_spamc_tmp_t;
@@ -51,6 +52,7 @@ template(`spamassassin_per_role_template
 	type $1_spamassassin_t;
 	domain_type($1_spamassassin_t)
 	domain_entry_file($1_spamassassin_t,spamassassin_exec_t)
+	corenet_type($1_spamassassin_t)
 	role $3 types $1_spamassassin_t;
 
 	type $1_spamassassin_home_t alias $1_spamassassin_rw_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/spamassassin.te serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.te
--- serefpolicy-2.4.6.orig/policy/modules/services/spamassassin.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.te	2007-01-04 15:33:07.000000000 -0600
@@ -13,6 +13,7 @@ userdom_executable_file(spamc_exec_t)
 type spamd_t;
 type spamd_exec_t;
 init_daemon_domain(spamd_t,spamd_exec_t)
+corenet_type(spamd_t)
 
 type spamd_spool_t;
 files_type(spamd_spool_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/squid.te serefpolicy-2.4.6.patch/policy/modules/services/squid.te
--- serefpolicy-2.4.6.orig/policy/modules/services/squid.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/squid.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(squid,1.2.0)
 type squid_t;
 type squid_exec_t;
 init_daemon_domain(squid_t,squid_exec_t)
+corenet_type(squid_t)
 
 # type for /var/cache/squid
 type squid_cache_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/stunnel.te serefpolicy-2.4.6.patch/policy/modules/services/stunnel.te
--- serefpolicy-2.4.6.orig/policy/modules/services/stunnel.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/stunnel.te	2007-01-04 15:33:11.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(stunnel,1.2.0)
 
 type stunnel_t;
 domain_type(stunnel_t)
+corenet_type(stunnel_t)
 role system_r types stunnel_t;
 
 type stunnel_exec_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/tcpd.te serefpolicy-2.4.6.patch/policy/modules/services/tcpd.te
--- serefpolicy-2.4.6.orig/policy/modules/services/tcpd.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/tcpd.te	2007-01-04 15:33:07.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(tcpd,1.1.0)
 #
 type tcpd_t;
 type tcpd_exec_t;
+corenet_type(tcpd_t)
 inetd_tcp_service_domain(tcpd_t,tcpd_exec_t)
 role system_r types tcpd_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/telnet.te serefpolicy-2.4.6.patch/policy/modules/services/telnet.te
--- serefpolicy-2.4.6.orig/policy/modules/services/telnet.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/telnet.te	2007-01-04 15:33:08.000000000 -0600
@@ -8,6 +8,7 @@ policy_module(telnet,1.2.0)
 
 type telnetd_t;
 type telnetd_exec_t;
+corenet_type(telnetd_t)
 inetd_service_domain(telnetd_t,telnetd_exec_t)
 role system_r types telnetd_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/tftp.te serefpolicy-2.4.6.patch/policy/modules/services/tftp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/tftp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/tftp.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(tftp,1.2.0)
 type tftpd_t;
 type tftpd_exec_t;
 init_daemon_domain(tftpd_t,tftpd_exec_t)
+corenet_type(tftpd_t)
 
 type tftpd_var_run_t;
 files_pid_file(tftpd_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/timidity.te serefpolicy-2.4.6.patch/policy/modules/services/timidity.te
--- serefpolicy-2.4.6.orig/policy/modules/services/timidity.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/timidity.te	2007-01-04 15:33:09.000000000 -0600
@@ -11,6 +11,7 @@ policy_module(timidity,1.2.0)
 type timidity_t;
 type timidity_exec_t;
 init_daemon_domain(timidity_t,timidity_exec_t)
+corenet_type(timidity_t)
 
 type timidity_tmpfs_t;
 files_tmpfs_file(timidity_tmpfs_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/tor.te serefpolicy-2.4.6.patch/policy/modules/services/tor.te
--- serefpolicy-2.4.6.orig/policy/modules/services/tor.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/tor.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(tor,1.1.0)
 type tor_t;
 type tor_exec_t;
 init_daemon_domain(tor_t, tor_exec_t)
+corenet_type(tor_t)
 
 # etc/tor
 type tor_etc_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/transproxy.te serefpolicy-2.4.6.patch/policy/modules/services/transproxy.te
--- serefpolicy-2.4.6.orig/policy/modules/services/transproxy.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/transproxy.te	2007-01-04 15:33:10.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(transproxy,1.1.0)
 type transproxy_t;
 type transproxy_exec_t;
 init_daemon_domain(transproxy_t,transproxy_exec_t)
+corenet_type(transproxy_t)
 
 type transproxy_var_run_t;
 files_pid_file(transproxy_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/ucspitcp.te serefpolicy-2.4.6.patch/policy/modules/services/ucspitcp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/ucspitcp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/ucspitcp.te	2007-01-04 15:33:09.000000000 -0600
@@ -14,6 +14,7 @@ role system_r types rblsmtpd_t;
 type ucspitcp_t;
 type ucspitcp_exec_t;
 init_system_domain(ucspitcp_t,ucspitcp_exec_t)
+corenet_type(ucspitcp_t)
 role system_r types ucspitcp_t;
 
 ########################################
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/uucp.te serefpolicy-2.4.6.patch/policy/modules/services/uucp.te
--- serefpolicy-2.4.6.orig/policy/modules/services/uucp.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/uucp.te	2007-01-04 15:33:08.000000000 -0600
@@ -7,6 +7,7 @@ policy_module(uucp,1.2.0)
 #
 type uucpd_t;
 type uucpd_exec_t;
+corenet_type(uucpd_t)
 inetd_tcp_service_domain(uucpd_t,uucpd_exec_t)
 role system_r types uucpd_t;
 
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/uwimap.te serefpolicy-2.4.6.patch/policy/modules/services/uwimap.te
--- serefpolicy-2.4.6.orig/policy/modules/services/uwimap.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/uwimap.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(uwimap,1.1.0)
 type imapd_t;
 type imapd_exec_t;
 init_daemon_domain(imapd_t,imapd_exec_t)
+corenet_type(imapd_t)
 inetd_tcp_service_domain(imapd_t,imapd_exec_t)
 
 type imapd_tmp_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/watchdog.te serefpolicy-2.4.6.patch/policy/modules/services/watchdog.te
--- serefpolicy-2.4.6.orig/policy/modules/services/watchdog.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/watchdog.te	2007-01-04 15:33:09.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(watchdog,1.1.0)
 type watchdog_t;
 type watchdog_exec_t;
 init_daemon_domain(watchdog_t,watchdog_exec_t)
+corenet_type(watchdog_t)
 
 type watchdog_log_t;
 logging_log_file(watchdog_log_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/xprint.te serefpolicy-2.4.6.patch/policy/modules/services/xprint.te
--- serefpolicy-2.4.6.orig/policy/modules/services/xprint.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/xprint.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(xprint,1.1.0)
 type xprint_t;
 type xprint_exec_t;
 init_daemon_domain(xprint_t,xprint_exec_t)
+corenet_type(xprint_t)
 
 type xprint_var_run_t;
 files_pid_file(xprint_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/xserver.if serefpolicy-2.4.6.patch/policy/modules/services/xserver.if
--- serefpolicy-2.4.6.orig/policy/modules/services/xserver.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/xserver.if	2007-01-04 15:33:09.000000000 -0600
@@ -25,6 +25,7 @@ template(`xserver_common_domain_template
 	type $1_xserver_t;
 	domain_type($1_xserver_t)
 	domain_entry_file($1_xserver_t,xserver_exec_t)
+	corenet_type($1_xserver_t)
 
 	type $1_xserver_tmp_t;
 	files_tmp_file($1_xserver_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/xserver.te serefpolicy-2.4.6.patch/policy/modules/services/xserver.te
--- serefpolicy-2.4.6.orig/policy/modules/services/xserver.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/xserver.te	2007-01-04 15:33:09.000000000 -0600
@@ -30,6 +30,7 @@ type xdm_exec_t;
 auth_login_pgm_domain(xdm_t)
 init_domain(xdm_t,xdm_exec_t)
 init_daemon_domain(xdm_t,xdm_exec_t)
+corenet_type(xdm_t)
 
 type xdm_lock_t;
 files_lock_file(xdm_lock_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/services/zebra.te serefpolicy-2.4.6.patch/policy/modules/services/zebra.te
--- serefpolicy-2.4.6.orig/policy/modules/services/zebra.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/services/zebra.te	2007-01-04 15:33:08.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(zebra,1.3.0)
 type zebra_t;
 type zebra_exec_t;
 init_daemon_domain(zebra_t,zebra_exec_t)
+corenet_type(zebra_t)
 
 type zebra_conf_t;
 files_type(zebra_conf_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/hotplug.te serefpolicy-2.4.6.patch/policy/modules/system/hotplug.te
--- serefpolicy-2.4.6.orig/policy/modules/system/hotplug.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/hotplug.te	2007-01-04 15:33:12.000000000 -0600
@@ -10,6 +10,7 @@ type hotplug_t;
 type hotplug_exec_t;
 kernel_domtrans_to(hotplug_t,hotplug_exec_t)
 init_daemon_domain(hotplug_t,hotplug_exec_t)
+corenet_type(hotplug_t)
 
 type hotplug_etc_t;
 files_config_file(hotplug_etc_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/init.te serefpolicy-2.4.6.patch/policy/modules/system/init.te
--- serefpolicy-2.4.6.orig/policy/modules/system/init.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/init.te	2007-01-04 15:33:12.000000000 -0600
@@ -48,6 +48,7 @@ type initrc_t;
 type initrc_exec_t;
 domain_type(initrc_t)
 domain_entry_file(initrc_t,initrc_exec_t)
+corenet_type(initrc_t)
 role system_r types initrc_t;
 
 type initrc_devpts_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/ipsec.if serefpolicy-2.4.6.patch/policy/modules/system/ipsec.if
--- serefpolicy-2.4.6.orig/policy/modules/system/ipsec.if	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/ipsec.if	2007-01-04 15:33:12.000000000 -0600
@@ -119,3 +119,22 @@ interface(`ipsec_manage_pid',`
 	allow $1 ipsec_var_run_t:dir rw_dir_perms;
 	allow $1 ipsec_var_run_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Allow an IPsec SA to be used by an IPsec Policy.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_labeled',`
+	gen_require(`
+		type ipsec_spd_t;
+	')
+
+	allow $1 ipsec_spd_t:association polmatch;
+	allow $1 self:association { sendto recvfrom };
+')
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te serefpolicy-2.4.6.patch/policy/modules/system/ipsec.te
--- serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/ipsec.te	2007-01-04 15:33:12.000000000 -0600
@@ -35,6 +35,10 @@ files_lock_file(ipsec_mgmt_lock_t)
 type ipsec_mgmt_var_run_t;
 files_pid_file(ipsec_mgmt_var_run_t)
 
+# default type for ipsec-tools ipsec policy
+type ipsec_spd_t;
+
+
 ########################################
 #
 # ipsec Local policy
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/iscsi.te serefpolicy-2.4.6.patch/policy/modules/system/iscsi.te
--- serefpolicy-2.4.6.orig/policy/modules/system/iscsi.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/iscsi.te	2007-01-04 15:33:12.000000000 -0600
@@ -10,6 +10,7 @@ type iscsid_t;
 type iscsid_exec_t;
 domain_type(iscsid_t)
 init_daemon_domain(iscsid_t, iscsid_exec_t)
+corenet_type(iscsid_t)
 
 type iscsi_lock_t;
 files_lock_file(iscsi_lock_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/logging.te serefpolicy-2.4.6.patch/policy/modules/system/logging.te
--- serefpolicy-2.4.6.orig/policy/modules/system/logging.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/logging.te	2007-01-04 15:33:12.000000000 -0600
@@ -44,6 +44,7 @@ files_pid_file(klogd_var_run_t)
 type syslogd_t;
 type syslogd_exec_t;
 init_daemon_domain(syslogd_t,syslogd_exec_t)
+corenet_type(syslogd_t)
 
 type syslogd_tmp_t;
 files_tmp_file(syslogd_tmp_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/lvm.te serefpolicy-2.4.6.patch/policy/modules/system/lvm.te
--- serefpolicy-2.4.6.orig/policy/modules/system/lvm.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/lvm.te	2007-01-04 15:33:12.000000000 -0600
@@ -9,6 +9,7 @@ policy_module(lvm,1.4.1)
 type clvmd_t;
 type clvmd_exec_t;
 init_daemon_domain(clvmd_t,clvmd_exec_t)
+corenet_type(clvmd_t)
 
 type clvmd_var_run_t;
 files_pid_file(clvmd_var_run_t)
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/sysnetwork.te serefpolicy-2.4.6.patch/policy/modules/system/sysnetwork.te
--- serefpolicy-2.4.6.orig/policy/modules/system/sysnetwork.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/sysnetwork.te	2007-01-04 15:33:12.000000000 -0600
@@ -18,6 +18,7 @@ files_type(dhcp_state_t)
 type dhcpc_t;
 type dhcpc_exec_t;
 init_daemon_domain(dhcpc_t,dhcpc_exec_t)
+corenet_type(dhcpc_t)
 role system_r types dhcpc_t;
 
 type dhcpc_state_t;
diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/xen.te serefpolicy-2.4.6.patch/policy/modules/system/xen.te
--- serefpolicy-2.4.6.orig/policy/modules/system/xen.te	2007-01-03 16:43:28.000000000 -0600
+++ serefpolicy-2.4.6.patch/policy/modules/system/xen.te	2007-01-04 15:33:13.000000000 -0600
@@ -25,6 +25,7 @@ type xend_t;
 type xend_exec_t;
 domain_type(xend_t)
 init_daemon_domain(xend_t, xend_exec_t)
+corenet_type(xend_t)
 
 # var/lib files
 type xend_var_lib_t;
Binary files serefpolicy-2.4.6.orig/support/pyplate.pyc and serefpolicy-2.4.6.patch/support/pyplate.pyc differ

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
