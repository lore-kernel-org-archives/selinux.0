Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Ce33g012416
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:03 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Ce27E010991
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:03 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 71B371AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:01 +0200 (CEST)
Message-Id: <20080804123739.512964567@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:26 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 30/35] fetchmail policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial change to the fetchmail module...
Index: refpolicy/policy/modules/services/fetchmail.te
===================================================================
--- refpolicy.orig/policy/modules/services/fetchmail.te	2008-08-03 21:45:04.000000000 +0200
+++ refpolicy/policy/modules/services/fetchmail.te	2008-08-03 21:45:45.000000000 +0200
@@ -14,7 +14,7 @@
 files_pid_file(fetchmail_var_run_t)
 
 type fetchmail_etc_t;
-files_type(fetchmail_etc_t)
+files_config_file(fetchmail_etc_t)
 
 type fetchmail_uidl_cache_t;
 files_type(fetchmail_uidl_cache_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
