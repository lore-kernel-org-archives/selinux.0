Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHakMn013504
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHai2p008177
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:41:15 -0400
Message-Id: <200705301541.l4UFfFZq011841@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_mozilla changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mozilla wants to read /dev/rand
--- nsaserefpolicy/policy/modules/apps/mozilla.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/mozilla.if	2007-05-30 09:25:53.000000000 -0400
@@ -150,6 +150,7 @@
 	corenet_dontaudit_tcp_bind_generic_port($1_mozilla_t)
 
 	dev_read_urand($1_mozilla_t)
+	dev_read_rand($1_mozilla_t)
 	dev_write_sound($1_mozilla_t)
 	dev_read_sound($1_mozilla_t)
 	dev_dontaudit_rw_dri($1_mozilla_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
