Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHarua013771
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHaoue002808
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:51 GMT
Date: Wed, 30 May 2007 10:27:43 -0400
Message-Id: <200705301427.l4UERhvI007829@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: radius wants to be able to read samba files
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/radius.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/radius.te	2007-05-30 09:08:15.000000000 -0400
@@ -124,3 +124,7 @@
 optional_policy(`
 	udev_read_db(radiusd_t)
 ')
+
+optional_policy(`
+	samba_read_var_files(radiusd_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
