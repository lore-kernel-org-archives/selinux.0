Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarlG013776
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHao2p008211
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:51 GMT
Date: Wed, 30 May 2007 10:54:28 -0400
Message-Id: <200705301454.l4UEsSwQ008269@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Cyrus attempts to write snmp_var_lib
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/cyrus.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/cyrus.te	2007-05-30 09:08:15.000000000 -0400
@@ -138,6 +139,7 @@
 
 optional_policy(`
 	snmp_read_snmp_var_lib_files(cyrus_t)
+	snmp_dontaudit_write_snmp_var_lib_files(cyrus_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
