Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbsPV014340
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbq2p008427
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:52 GMT
Date: Wed, 30 May 2007 10:20:19 -0400
Message-Id: <200705301420.l4UEKJQC007751@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Spam can connect to smtp port and can use mysql backend
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/spamassassin.te	2007-05-30 09:08:15.000000000 -0400
@@ -101,6 +99,7 @@
 corenet_tcp_bind_all_nodes(spamd_t)
 corenet_tcp_bind_spamd_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
+corenet_tcp_connect_smtp_port(spamd_t)
 corenet_sendrecv_razor_client_packets(spamd_t)
 corenet_sendrecv_spamd_server_packets(spamd_t)
 # spamassassin 3.1 needs this for its
@@ -185,6 +184,11 @@
 ')
 
 optional_policy(`
+	mysql_search_db(spamd_t)
+	mysql_stream_connect(spamd_t)
+')
+
+optional_policy(`
 	nis_use_ypbind(spamd_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
