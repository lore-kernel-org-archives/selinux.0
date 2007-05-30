Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbKfi014115
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbH2p008305
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:17 GMT
Date: Wed, 30 May 2007 10:22:36 -0400
Message-Id: <200705301422.l4UEMaFZ007770@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: snmp changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

remove snmp_etc_t, no value
snmp requests sys_module (denied)
snmp uses nsswitch
snmp wants to read mail log and look at squid config

--- nsaserefpolicy/policy/modules/services/snmp.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/snmp.te	2007-05-30 07:35:54.000000000 -0400
@@ -1,5 +1,5 @@
 
-policy_module(snmp,1.4.0)
+policy_module(snmp,1.4.2)
 
 ########################################
 #
@@ -9,9 +9,6 @@
 type snmpd_exec_t;
 init_daemon_domain(snmpd_t,snmpd_exec_t)
 
-type snmpd_etc_t;
-files_config_file(snmpd_etc_t)
-
 type snmpd_log_t;
 logging_log_file(snmpd_log_t)
 
@@ -26,15 +23,13 @@
 # Local policy
 #
 allow snmpd_t self:capability { dac_override kill net_admin sys_nice sys_tty_config };
-dontaudit snmpd_t self:capability sys_tty_config;
+dontaudit snmpd_t self:capability { sys_module sys_tty_config };
 allow snmpd_t self:fifo_file rw_fifo_file_perms;
 allow snmpd_t self:unix_dgram_socket create_socket_perms;
 allow snmpd_t self:unix_stream_socket create_stream_socket_perms;
 allow snmpd_t self:tcp_socket create_stream_socket_perms;
 allow snmpd_t self:udp_socket connected_stream_socket_perms;
 
-allow snmpd_t snmpd_etc_t:file { getattr read };
-
 allow snmpd_t snmpd_log_t:file manage_file_perms;
 logging_log_filetrans(snmpd_t,snmpd_log_t,file)
 
@@ -124,15 +119,16 @@
 ')
 
 optional_policy(`
-	cups_read_rw_config(snmpd_t)
+	auth_use_nsswitch(snmpd_t)
 ')
 
 optional_policy(`
-	nis_use_ypbind(snmpd_t)
+	cups_read_rw_config(snmpd_t)
 ')
 
 optional_policy(`
-	nscd_socket_use(snmpd_t)
+	mta_read_config(snmpd_t)
+	mta_search_queue(snmpd_t)
 ')
 
 optional_policy(`
@@ -140,9 +136,17 @@
 ')
 
 optional_policy(`
+	sendmail_read_log(snmpd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(snmpd_t)
 ')
 
 optional_policy(`
+	squid_read_config(snmpd_t)
+')
+
+optional_policy(`
 	udev_read_db(snmpd_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
