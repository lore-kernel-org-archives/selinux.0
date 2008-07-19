Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4cIa024506
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:38 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4aTc006798
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:37 GMT
Message-Id: <20080719210253.146694148@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:15 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 13/23] portslave policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial patch

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/portslave.te serefpolicy-3.5.0/policy/modules/services/portslave.te
--- nsaserefpolicy/policy/modules/services/portslave.te	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/portslave.te	2008-07-15 14:05:13.000000000 -0400
@@ -12,7 +12,7 @@
 init_daemon_domain(portslave_t,portslave_exec_t)
 
 type portslave_etc_t;
-files_type(portslave_etc_t)
+files_config_file(portslave_etc_t)
 
 type portslave_lock_t;
 files_lock_file(portslave_lock_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
