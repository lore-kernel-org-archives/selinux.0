Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2w3W024277
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:58 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2v5T024801
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:57 GMT
Message-Id: <20080719210252.542720877@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:11 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 09/23] apm policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

apmd knows nothing of dbus but powersaved is also in domain apmd_t and 
powersaved is HAL-aware.

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apm.te serefpolicy-3.5.0/policy/modules/services/apm.te
--- nsaserefpolicy/policy/modules/services/apm.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/apm.te	2008-07-15 14:05:12.000000000 -0400
@@ -191,6 +191,10 @@
 	dbus_stub(apmd_t)
 
 	optional_policy(`
+		consolekit_dbus_chat(apmd_t)
+	')
+
+	optional_policy(`
 		networkmanager_dbus_chat(apmd_t)
 	')
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
