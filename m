Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHajsw013488
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:45 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaiue002769
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:22:34 -0400
Message-Id: <200705301522.l4UFMYeG010497@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_vbetool changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/admin/vbetool.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/vbetool.te	2007-05-30 09:25:53.000000000 -0400
@@ -32,4 +32,5 @@
 
 optional_policy(`
 	hal_rw_pid_files(vbetool_t)
+	hal_write_log(vbetool_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
