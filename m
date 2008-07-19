Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL7cSF025049
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:07:38 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL7aTc007512
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:07:37 GMT
Message-Id: <20080719210254.067780906@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:21 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 19/23] netlabel policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial patch

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/netlabel.te serefpolicy-3.5.0/policy/modules/system/netlabel.te
--- nsaserefpolicy/policy/modules/system/netlabel.te	2008-06-12 23:25:07.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/system/netlabel.te	2008-07-15 14:05:13.000000000 -0400
@@ -9,6 +9,7 @@
 type netlabel_mgmt_t;
 type netlabel_mgmt_exec_t;
 application_domain(netlabel_mgmt_t,netlabel_mgmt_exec_t)
+role system_r types netlabel_mgmt_t;
 
 ########################################
 #

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
