Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CoJ52015061
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:50:19 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CoDpq017353
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:50:14 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 077C541C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:50:16 +0200 (CEST)
Message-Id: <20080804123738.744174540@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:21 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 25/35] rdisc policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Minor changes to the rdisc module, the interface that is added is used
in later RH patches (not part of the current patchset)...
Index: refpolicy/policy/modules/services/rdisc.if
===================================================================
--- refpolicy.orig/policy/modules/services/rdisc.if	2008-07-19 19:15:41.000000000 +0200
+++ refpolicy/policy/modules/services/rdisc.if	2008-08-03 21:17:42.000000000 +0200
@@ -1 +1,20 @@
 ## <summary>Network router discovery daemon</summary>
+
+########################################
+## <summary>
+##	Execute rdisc server in the rdisc domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+#
+interface(`rdisc_script_domtrans',`
+	gen_require(`
+		type rdisc_script_exec_t;
+	')
+
+	init_script_domtrans_spec($1,rdisc_script_exec_t)
+')
Index: refpolicy/policy/modules/services/rdisc.te
===================================================================
--- refpolicy.orig/policy/modules/services/rdisc.te	2008-08-03 16:47:00.000000000 +0200
+++ refpolicy/policy/modules/services/rdisc.te	2008-08-03 21:17:42.000000000 +0200
@@ -45,6 +45,8 @@
 libs_use_ld_so(rdisc_t)
 libs_use_shared_libs(rdisc_t)
 
+miscfiles_read_localization(rdisc_t)
+
 logging_send_syslog_msg(rdisc_t)
 
 sysnet_read_config(rdisc_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
