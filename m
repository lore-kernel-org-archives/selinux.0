Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CkKoI014108
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:20 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CkJ7E012647
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:19 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 290E341C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:46:17 +0200 (CEST)
Message-Id: <20080804123736.576821217@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:08 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 12/35] getty policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hopefully trivial changes
Index: refpolicy/policy/modules/system/getty.fc
===================================================================
--- refpolicy.orig/policy/modules/system/getty.fc	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/getty.fc	2008-08-03 18:01:20.000000000 +0200
@@ -8,5 +8,5 @@
 
 /var/run/mgetty\.pid.*	--	gen_context(system_u:object_r:getty_var_run_t,s0)
 
-/var/spool/fax		--	gen_context(system_u:object_r:getty_var_run_t,s0)
-/var/spool/voice	--	gen_context(system_u:object_r:getty_var_run_t,s0)
+/var/spool/fax(/.*)?		gen_context(system_u:object_r:getty_var_run_t,s0)
+/var/spool/voice(/.*)?		gen_context(system_u:object_r:getty_var_run_t,s0)
Index: refpolicy/policy/modules/system/getty.te
===================================================================
--- refpolicy.orig/policy/modules/system/getty.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/getty.te	2008-08-03 18:01:20.000000000 +0200
@@ -9,6 +9,7 @@
 type getty_t;
 type getty_exec_t;
 init_domain(getty_t,getty_exec_t)
+init_system_domain(getty_t,getty_exec_t)
 domain_interactive_fd(getty_t)
 
 type getty_etc_t;

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
