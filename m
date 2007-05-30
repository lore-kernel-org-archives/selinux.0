Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbOlB014232
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbLue002849
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:21 GMT
Date: Wed, 30 May 2007 10:51:20 -0400
Message-Id: <200705301451.l4UEpKo6008223@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: djbdns needs optional_policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/djbdns.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/djbdns.te	2007-05-30 07:35:54.000000000 -0400
@@ -44,4 +44,7 @@
 libs_use_ld_so(djbdns_axfrdns_t)
 libs_use_shared_libs(djbdns_axfrdns_t)
 
-ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
+optional_policy(`
+	ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
