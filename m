Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHap1O013687
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHamue002788
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:48 GMT
Date: Wed, 30 May 2007 11:00:09 -0400
Message-Id: <200705301500.l4UF09i1009188@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Cups changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Cups writes subscriptions files
Connects to smbd port
Sends mail
Uses ypbind
Needs to use generic ptys for local printers

--- nsaserefpolicy/policy/modules/services/cups.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/cups.fc	2007-05-30 09:25:53.000000000 -0400
@@ -8,6 +8,7 @@
 /etc/cups/ppd/.*	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/ppds\.dat	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/printers\.conf.* --	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
+/etc/cups/subscriptions.*  --	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/certs		-d	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /etc/cups/certs/.*	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 
--- nsaserefpolicy/policy/modules/services/cups.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/cups.te	2007-05-30 10:57:34.000000000 -0400
@@ -151,9 +149,11 @@
 corenet_tcp_bind_reserved_port(cupsd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
 corenet_tcp_connect_all_ports(cupsd_t)
+corenet_tcp_connect_smbd_port(cupsd_t)
 corenet_sendrecv_hplip_client_packets(cupsd_t)
 corenet_sendrecv_ipp_client_packets(cupsd_t)
 corenet_sendrecv_ipp_server_packets(cupsd_t)
+corenet_tcp_bind_all_rpc_ports(cupsd_t)
 
 dev_rw_printer(cupsd_t)
 dev_read_urand(cupsd_t)
@@ -223,6 +224,7 @@
 
 sysnet_read_config(cupsd_t)
 
+files_dontaudit_list_home(cupsd_t)
 userdom_dontaudit_use_unpriv_user_fds(cupsd_t)
 userdom_dontaudit_search_all_users_home_content(cupsd_t)
 
@@ -279,6 +281,10 @@
 ')
 
 optional_policy(`
+	nis_use_ypbind(cupsd_t)
+')
+
+optional_policy(`
 	nscd_socket_use(cupsd_t)
 ')
 
@@ -289,6 +295,10 @@
 ')
 
 optional_policy(`
+	mta_send_mail(cupsd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(cupsd_t)
 ')
 
@@ -391,7 +401,11 @@
 	')
 ')
 
-ifdef(`targeted_policy',`
+optional_policy(`
+	term_use_generic_ptys(cupsd_config_t)
+')
+
+optional_policy(`
 	unconfined_rw_pipes(cupsd_config_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
