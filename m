Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CpNDb015397
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:23 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CpM7E014017
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:23 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id C7F4B5E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:21 +0200 (CEST)
Message-Id: <20080804123738.204515169@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:18 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 22/35] oav policy updates
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial changes...

Index: refpolicy/policy/modules/services/oav.te
===================================================================
--- refpolicy.orig/policy/modules/services/oav.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/oav.te	2008-08-03 20:34:32.000000000 +0200
@@ -12,7 +12,7 @@
 
 # cjp: may be collapsable to etc_t
 type oav_update_etc_t;
-files_type(oav_update_etc_t)
+files_config_file(oav_update_etc_t)
 
 type oav_update_var_lib_t;
 files_type(oav_update_var_lib_t)
@@ -22,7 +22,7 @@
 init_daemon_domain(scannerdaemon_t, scannerdaemon_exec_t)
 
 type scannerdaemon_etc_t;
-files_type(scannerdaemon_etc_t)
+files_config_file(scannerdaemon_etc_t)
 
 type scannerdaemon_log_t;
 logging_log_file(scannerdaemon_log_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
