Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHauGr013836
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHar2p008242
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 10:28:43 -0400
Message-Id: <200705301428.l4UEShUe007842@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: pyzor needs to communicate with http to get updates, signal spam
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/pyzor.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/pyzor.te	2007-05-30 09:08:15.000000000 -0400
@@ -54,6 +54,11 @@
 corenet_udp_sendrecv_all_nodes(pyzor_t)
 corenet_udp_sendrecv_all_ports(pyzor_t)
 
+corenet_tcp_sendrecv_all_if(pyzor_t)
+corenet_tcp_sendrecv_all_nodes(pyzor_t)
+corenet_tcp_sendrecv_all_ports(pyzor_t)
+corenet_tcp_connect_http_port(pyzor_t)
+
 dev_read_urand(pyzor_t)
 
 files_read_etc_files(pyzor_t)
@@ -68,6 +73,7 @@
 userdom_dontaudit_search_sysadm_home_dirs(pyzor_t)
 
 ifdef(`targeted_policy',`
+	userdom_dontaudit_write_sysadm_home_dirs(pyzor_t)
 	userdom_read_generic_user_home_content_files(pyzor_t)
 ')
 
@@ -77,6 +83,7 @@
 ')
 
 optional_policy(`
+	spamassassin_signal_spamd(pyzor_t)
 	spamassassin_read_spamd_tmp_files(pyzor_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
