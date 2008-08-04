Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CkZu8014179
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:35 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CkY7E012687
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:34 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 785F741C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:46:33 +0200 (CEST)
Message-Id: <20080804123738.570715413@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:20 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 24/35] bootloader policy updates
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Most of the changes here are in a distro_redhat block and shouldn't be
controversial...

Index: refpolicy/policy/modules/admin/bootloader.if
===================================================================
--- refpolicy.orig/policy/modules/admin/bootloader.if	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/admin/bootloader.if	2008-08-03 21:09:17.000000000 +0200
@@ -49,6 +49,11 @@
 
 	role $2 types bootloader_t;
 	allow bootloader_t $3:chr_file rw_term_perms;
+
+	ifdef(`distro_redhat',`
+		# for mke2fs
+		mount_run(bootloader_t, $2, $3)
+	')
 ')
 
 ########################################
Index: refpolicy/policy/modules/admin/bootloader.te
===================================================================
--- refpolicy.orig/policy/modules/admin/bootloader.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/admin/bootloader.te	2008-08-03 21:09:17.000000000 +0200
@@ -218,3 +218,7 @@
 optional_policy(`
 	sysadm_dontaudit_search_home_dirs(bootloader_t)
 ')
+
+optional_policy(`
+	unconfined_domain(bootloader_t)
+')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
