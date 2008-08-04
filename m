Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeLkB012549
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:21 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CeFpq014753
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:15 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id D8ECE1AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:17 +0200 (CEST)
Message-Id: <20080804123739.041708374@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:23 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 27/35] inetd policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RH changes to the inetd module, most of these are related to the MLS/MCS
override which is already present in the module...
Index: refpolicy/policy/modules/services/inetd.if
===================================================================
--- refpolicy.orig/policy/modules/services/inetd.if	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/inetd.if	2008-08-03 21:25:12.000000000 +0200
@@ -115,6 +115,10 @@
 
 	allow $1 inetd_t:tcp_socket rw_stream_socket_perms;
 	allow $1 inetd_t:udp_socket rw_socket_perms;
+
+	optional_policy(`
+		stunnel_service_domain($1,$2)
+	')
 ')
 
 ########################################
Index: refpolicy/policy/modules/services/inetd.te
===================================================================
--- refpolicy.orig/policy/modules/services/inetd.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/inetd.te	2008-08-03 21:25:12.000000000 +0200
@@ -30,6 +30,10 @@
 type inetd_child_var_run_t;
 files_pid_file(inetd_child_var_run_t)
 
+ifdef(`enable_mcs',`
+	init_ranged_daemon_domain(inetd_t,inetd_exec_t,s0 - mcs_systemhigh)
+')
+
 ########################################
 #
 # Local policy
@@ -84,6 +88,7 @@
 corenet_udp_bind_ftp_port(inetd_t)
 corenet_tcp_bind_inetd_child_port(inetd_t)
 corenet_udp_bind_inetd_child_port(inetd_t)
+corenet_tcp_bind_ircd_port(inetd_t)
 corenet_udp_bind_ktalkd_port(inetd_t)
 corenet_tcp_bind_printer_port(inetd_t)
 corenet_udp_bind_rlogind_port(inetd_t)
@@ -137,6 +142,7 @@
 miscfiles_read_localization(inetd_t)
 
 # xinetd needs MLS override privileges to work
+mls_fd_use_all_levels(inetd_t)
 mls_fd_share_all_levels(inetd_t)
 mls_socket_read_to_clearance(inetd_t)
 mls_socket_write_to_clearance(inetd_t)
@@ -165,6 +171,7 @@
 ')
 
 optional_policy(`
+	unconfined_domain(inetd_t)
 	unconfined_domtrans(inetd_t)
 ')
 
@@ -181,6 +188,9 @@
 # for identd
 allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow inetd_child_t self:capability { setuid setgid };
+allow inetd_child_t self:dir search;
+allow inetd_child_t self:{ lnk_file file } { getattr read };
+
 files_search_home(inetd_child_t)
 
 manage_dirs_pattern(inetd_child_t, inetd_child_tmp_t, inetd_child_tmp_t)
@@ -227,3 +237,7 @@
 optional_policy(`
 	unconfined_domain(inetd_child_t)
 ')
+
+optional_policy(`
+	inetd_service_domain(inetd_child_t,bin_t)
+')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
