Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CkdI0014205
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:39 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CkXpq016465
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:34 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id E46E441C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:46:36 +0200 (CEST)
Message-Id: <20080804123736.746197981@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:09 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 13/35] ricci policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One trivial change
Index: refpolicy/policy/modules/services/ricci.te
===================================================================
--- refpolicy.orig/policy/modules/services/ricci.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/ricci.te	2008-08-03 18:01:32.000000000 +0200
@@ -443,6 +443,7 @@
 create_files_pattern(ricci_modstorage_t, ricci_modstorage_lock_t, ricci_modstorage_lock_t)
 files_lock_filetrans(ricci_modstorage_t, ricci_modstorage_lock_t, file)
 
+corecmd_exec_shell(ricci_modstorage_t)
 corecmd_exec_bin(ricci_modstorage_t)
 
 dev_read_sysfs(ricci_modstorage_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
