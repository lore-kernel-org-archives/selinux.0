Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CbwDF011974
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:37:58 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Cbv7E010535
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:37:57 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 5C1501AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:37:56 +0200 (CEST)
Message-Id: <20080804123734.999572013@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:34:59 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 03/35] logrotate policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Perhaps controversial changes

First sent on Jul 19, dwalsh described the need for the patch here:
http://marc.info/?l=selinux&m=121726318902852&w=2

Refreshed to apply cleanly to SVN repo

Index: refpolicy/policy/modules/admin/logrotate.te
===================================================================
--- refpolicy.orig/policy/modules/admin/logrotate.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/admin/logrotate.te	2008-08-03 16:59:10.000000000 +0200
@@ -97,6 +97,7 @@
 files_read_etc_files(logrotate_t)
 files_read_etc_runtime_files(logrotate_t)
 files_read_all_pids(logrotate_t)
+files_search_all(logrotate_t)
 # Write to /var/spool/slrnpull - should be moved into its own type.
 files_manage_generic_spool(logrotate_t)
 files_manage_generic_spool_dirs(logrotate_t)
@@ -142,9 +143,8 @@
 ')
 
 optional_policy(`
-	apache_read_config(logrotate_t)
-	apache_domtrans(logrotate_t)
 	apache_signull(logrotate_t)
+	apache_manage_all_content(logrotate_t)
 ')
 
 optional_policy(`
@@ -186,6 +186,5 @@
 ')
 
 optional_policy(`
-	# cjp: why?
-	squid_domtrans(logrotate_t)
+	squid_signal(logrotate_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
