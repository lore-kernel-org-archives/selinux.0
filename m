Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4c4K024520
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:38 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4b5T025058
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:37 GMT
Message-Id: <20080719210252.998206840@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:14 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 12/23] openca policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial patch

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/openca.te serefpolicy-3.5.0/policy/modules/services/openca.te
--- nsaserefpolicy/policy/modules/services/openca.te	2008-06-12 23:25:05.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/openca.te	2008-07-15 14:05:13.000000000 -0400
@@ -18,7 +18,7 @@
 
 # /etc/openca standard files
 type openca_etc_t;
-files_type(openca_etc_t)
+files_config_file(openca_etc_t)
 
 # /etc/openca template files
 type openca_etc_in_t;

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
