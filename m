Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CbqnU011941
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:37:52 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cbo7E010511
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:37:51 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 4129F1AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:37:50 +0200 (CEST)
Message-Id: <20080804123734.692354545@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:34:57 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 01/35] anaconda policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Anaconda is a RH installation program, RH should know their own program and
the changes are quite trivial

Previously submitted Jul 19, refreshed to apply to current SVN

Index: refpolicy/policy/modules/admin/anaconda.te
===================================================================
--- refpolicy.orig/policy/modules/admin/anaconda.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/admin/anaconda.te	2008-08-03 16:52:56.000000000 +0200
@@ -31,14 +31,9 @@
 modutils_domtrans_insmod(anaconda_t)
 
 seutil_domtrans_semanage(anaconda_t)
+seutil_domtrans_setsebool(anaconda_t)
 
-unconfined_domain(anaconda_t)
-
-unprivuser_home_dir_filetrans_home_content(anaconda_t, { dir file lnk_file fifo_file sock_file })
-
-optional_policy(`
-	dmesg_domtrans(anaconda_t)
-')
+unprivuser_home_dir_filetrans_home_content(anaconda_t,{ dir file lnk_file fifo_file sock_file })
 
 optional_policy(`
 	kudzu_domtrans(anaconda_t)
@@ -58,5 +53,9 @@
 ')
 
 optional_policy(`
+	unconfined_domain(anaconda_t)
+')
+
+optional_policy(`
 	usermanage_domtrans_admin_passwd(anaconda_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
