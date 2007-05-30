Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKBJ014096
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbG2p008292
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:43:53 -0400
Message-Id: <200705301443.l4UEhr8W008091@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: nagios changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

nagios is designed to connect to all ports
needs to read random data
Uses nsswitch

--- nsaserefpolicy/policy/modules/services/nagios.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/nagios.te	2007-05-30 07:35:54.000000000 -0400
@@ -73,8 +73,10 @@
 corenet_udp_sendrecv_all_nodes(nagios_t)
 corenet_tcp_sendrecv_all_ports(nagios_t)
 corenet_udp_sendrecv_all_ports(nagios_t)
+corenet_tcp_connect_all_ports(nagios_t)
 
 dev_read_sysfs(nagios_t)
+dev_read_urand(nagios_t)
 
 domain_use_interactive_fds(nagios_t)
 # for ps
@@ -97,8 +99,6 @@
 
 miscfiles_read_localization(nagios_t)
 
-sysnet_read_config(nagios_t)
-
 userdom_dontaudit_use_unpriv_user_fds(nagios_t)
 userdom_dontaudit_search_sysadm_home_dirs(nagios_t)
 
@@ -108,14 +108,10 @@
 	netutils_domtrans_ping(nagios_t)
 	netutils_signal_ping(nagios_t)
 	netutils_kill_ping(nagios_t)
-
-	# cjp: leaked file descriptors:
-	#dontaudit ping_t nagios_etc_t:file read;
-	#dontaudit ping_t nagios_log_t:fifo_file read;
 ')
 
 optional_policy(`
-	nis_use_ypbind(nagios_t)
+	auth_use_nsswitch(nagios_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
