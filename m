Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL4ek5024589
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:04:40 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL4c5T025071
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:04:39 GMT
Message-Id: <20080719210253.302868396@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:16 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 14/23] rhgb policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rhgb (RedHat Graphical Boot) is RH specific so this should be uncontroversial...

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.if serefpolicy-3.5.0/policy/modules/services/rhgb.if
--- nsaserefpolicy/policy/modules/services/rhgb.if	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/rhgb.if	2008-07-15 14:05:13.000000000 -0400
@@ -4,7 +4,7 @@
 ## <summary>
 ##	RHGB stub interface.  No access allowed.
 ## </summary>
-## <param name="domain" unused="true">
+## <param name="domain">
 ##	<summary>
 ##	N/A
 ##	</summary>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.te serefpolicy-3.5.0/policy/modules/services/rhgb.te
--- nsaserefpolicy/policy/modules/services/rhgb.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/services/rhgb.te	2008-07-15 14:05:13.000000000 -0400
@@ -92,6 +92,7 @@
 term_getattr_pty_fs(rhgb_t)
 
 init_write_initctl(rhgb_t)
+init_chat(rhgb_t)
 
 libs_use_ld_so(rhgb_t)
 libs_use_shared_libs(rhgb_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
