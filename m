Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeVTu012633
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:31 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CePpq014783
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:25 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id A9BD81AB
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:27 +0200 (CEST)
Message-Id: <20080804123740.307036789@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:31 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 35/35] livecd policy addition
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New policy module for livecd from the RH patchset.
Index: refpolicy/policy/modules/apps/livecd.fc
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/apps/livecd.fc	2008-08-03 23:42:07.000000000 +0200
@@ -0,0 +1,2 @@
+
+/usr/bin/livecd-creator	--	gen_context(system_u:object_r:livecd_exec_t,s0)
Index: refpolicy/policy/modules/apps/livecd.if
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/apps/livecd.if	2008-08-03 23:42:52.000000000 +0200
@@ -0,0 +1,56 @@
+
+## <summary>policy for livecd</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run livecd.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`livecd_domtrans',`
+	gen_require(`
+		type livecd_t;
+                type livecd_exec_t;
+	')
+
+	domtrans_pattern($1,livecd_exec_t,livecd_t)
+')
+
+
+########################################
+## <summary>
+##	Execute livecd in the livecd domain, and
+##	allow the specified role the livecd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the livecd domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the role's terminal.
+##	</summary>
+## </param>
+#
+interface(`livecd_run',`
+	gen_require(`
+		type livecd_t;
+	')
+
+	livecd_domtrans($1)
+	role $2 types livecd_t;
+	allow livecd_t $3:chr_file rw_term_perms;
+
+	seutil_run_setfiles_mac(livecd_t, $2, $3)
+')
+
Index: refpolicy/policy/modules/apps/livecd.te
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/apps/livecd.te	2008-08-03 23:42:07.000000000 +0200
@@ -0,0 +1,26 @@
+policy_module(livecd, 1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type livecd_t;
+type livecd_exec_t;
+application_domain(livecd_t, livecd_exec_t)
+role system_r types livecd_t;
+
+########################################
+#
+# livecd local policy
+#
+dontaudit livecd_t self:capability2 mac_admin;
+
+unconfined_domain_noaudit(livecd_t)
+domain_ptrace_all_domains(livecd_t)
+
+optional_policy(`
+	hal_dbus_chat(livecd_t)
+')
+
+seutil_domtrans_setfiles_mac(livecd_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
