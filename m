Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeHss012511
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:17 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CeF7E011024
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:16 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 0C1871AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:15 +0200 (CEST)
Message-Id: <20080804123737.235985370@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:12 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 16/35] usernet policy updates
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Only minor changes
Index: refpolicy/policy/modules/apps/usernetctl.if
===================================================================
--- refpolicy.orig/policy/modules/apps/usernetctl.if	2008-08-03 16:46:56.000000000 +0200
+++ refpolicy/policy/modules/apps/usernetctl.if	2008-08-03 18:01:40.000000000 +0200
@@ -63,4 +63,9 @@
 	optional_policy(`
 		modutils_run_insmod(usernetctl_t, $2, $3)
 	')
+
+
+	optional_policy(`
+		ppp_run(usernetctl_t,$2,$3)
+	')
 ')
Index: refpolicy/policy/modules/apps/usernetctl.te
===================================================================
--- refpolicy.orig/policy/modules/apps/usernetctl.te	2008-08-03 16:46:56.000000000 +0200
+++ refpolicy/policy/modules/apps/usernetctl.te	2008-08-03 18:01:40.000000000 +0200
@@ -49,15 +49,21 @@
 
 fs_search_auto_mountpoints(usernetctl_t)
 
+auth_use_nsswitch(usernetctl_t)
+
 libs_use_ld_so(usernetctl_t)
 libs_use_shared_libs(usernetctl_t)
 
+logging_send_syslog_msg(usernetctl_t)
+
 miscfiles_read_localization(usernetctl_t)
 
 seutil_read_config(usernetctl_t)
 
 sysnet_read_config(usernetctl_t)
 
+term_search_ptys(usernetctl_t)
+
 optional_policy(`
 	hostname_exec(usernetctl_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
