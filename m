Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHauFT013827
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaq2p008239
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 10:29:54 -0400
Message-Id: <200705301429.l4UETs7Q007861@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Procmail needs to use ypbind, eliminate bogus udp avc messages
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/procmail.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/procmail.te	2007-05-30 09:08:15.000000000 -0400
@@ -101,6 +102,10 @@
 ')
 
 optional_policy(`
+	nis_use_ypbind(procmail_t)
+')
+
+optional_policy(`
 	# for a bug in the postfix local program
 	postfix_dontaudit_rw_local_tcp_sockets(procmail_t)
 	postfix_dontaudit_use_fds(procmail_t)
@@ -119,8 +124,11 @@
 
 optional_policy(`
 	corenet_udp_bind_generic_port(procmail_t)
+	corenet_dontaudit_udp_bind_all_ports(procmail_t)
 
 	spamassassin_exec(procmail_t)
 	spamassassin_exec_client(procmail_t)
 	spamassassin_read_lib_files(procmail_t)
 ')
+
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
