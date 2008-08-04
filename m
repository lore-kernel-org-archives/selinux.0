Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Cjohp013985
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:45:51 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cjn7E012540
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:45:50 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id B603E41C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:45:48 +0200 (CEST)
Message-Id: <20080804123737.432616785@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:13 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 17/35] brctl policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One minor change
Index: refpolicy/policy/modules/admin/brctl.te
===================================================================
--- refpolicy.orig/policy/modules/admin/brctl.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/admin/brctl.te	2008-08-03 18:01:42.000000000 +0200
@@ -33,6 +33,8 @@
 
 files_read_etc_files(brctl_t)
 
+term_use_console(brctl_t)
+
 libs_use_ld_so(brctl_t)
 libs_use_shared_libs(brctl_t)
 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
