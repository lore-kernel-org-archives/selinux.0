Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Confi015191
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:50:49 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74Com7E013786
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:50:48 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 35BCA41C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:50:38 +0200 (CEST)
Message-Id: <20080804123739.984442576@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:29 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 33/35] mailscanner policy addition
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds a new mailscanner module from the RH patchset
Index: refpolicy/policy/modules/services/mailscanner.fc
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/mailscanner.fc	2008-08-03 22:09:51.000000000 +0200
@@ -0,0 +1,2 @@
+/var/spool/MailScanner(/.*)?	gen_context(system_u:object_r:mailscanner_spool_t,s0)
+
Index: refpolicy/policy/modules/services/mailscanner.if
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/mailscanner.if	2008-08-03 22:09:51.000000000 +0200
@@ -0,0 +1,59 @@
+## <summary>Anti-Virus and Anti-Spam Filter</summary>
+
+########################################
+## <summary>
+##	Search mailscanner spool directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailscanner_search_spool',`
+	gen_require(`
+		type mailscanner_spool_t;
+	')
+
+	files_search_spool($1)
+	allow $1 mailscanner_spool_t:dir search_dir_perms;
+')
+
+########################################
+## <summary>
+##	read mailscanner spool files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailscanner_read_spool',`
+	gen_require(`
+		type mailscanner_spool_t;
+	')
+
+	files_search_spool($1)
+	read_files_pattern($1,mailscanner_spool_t,mailscanner_spool_t)
+')
+
+########################################
+## <summary>
+##	Create, read, write, and delete
+##	mailscanner spool files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailscanner_manage_spool',`
+	gen_require(`
+		type mailscanner_spool_t;
+	')
+
+	files_search_spool($1)
+	manage_files_pattern($1,mailscanner_spool_t,mailscanner_spool_t)
+')
Index: refpolicy/policy/modules/services/mailscanner.te
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ refpolicy/policy/modules/services/mailscanner.te	2008-08-03 22:09:51.000000000 +0200
@@ -0,0 +1,5 @@
+
+policy_module(mailscanner,1.0.0)
+
+type mailscanner_spool_t;
+files_type(mailscanner_spool_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
