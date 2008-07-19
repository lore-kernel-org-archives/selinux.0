Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2wZp024272
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:58 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2t5T024796
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:56 GMT
Message-Id: <20080719210251.622231332@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:05 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 03/23] unconfined_u policy updates
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These seem uncontroversial (and match the default contexts for staff_u
pretty well).

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-mcs/unconfined_u_default_contexts serefpolicy-3.5.0/config/appconfig-mcs/unconfined_u_default_contexts
--- nsaserefpolicy/config/appconfig-mcs/unconfined_u_default_contexts	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.5.0/config/appconfig-mcs/unconfined_u_default_contexts	2008-07-15 14:05:12.000000000 -0400
@@ -0,0 +1,9 @@
+system_r:crond_t:s0		unconfined_r:unconfined_t:s0
+system_r:initrc_t:s0		unconfined_r:unconfined_t:s0
+system_r:local_login_t:s0	unconfined_r:unconfined_t:s0
+system_r:remote_login_t:s0	unconfined_r:unconfined_t:s0
+system_r:rshd_t:s0		unconfined_r:unconfined_t:s0
+system_r:sshd_t:s0		unconfined_r:unconfined_t:s0
+system_r:sysadm_su_t:s0		unconfined_r:unconfined_t:s0
+system_r:unconfined_t:s0	unconfined_r:unconfined_t:s0
+system_r:xdm_t:s0		unconfined_r:unconfined_t:s0

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
