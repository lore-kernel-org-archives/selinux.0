Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Koji0026974
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:50:45 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KogM1010194
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:50:43 GMT
Date: Thu, 2 Aug 2007 16:50:39 -0400
Message-Id: <200708022050.l72KodAs000456@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: mailscanner policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/mailscanner.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/services/mailscanner.fc	2007-08-02 11:02:02.000000000 -0400
@@ -0,0 +1,2 @@
+/var/spool/MailScanner(/.*)?	gen_context(system_u:object_r:mailscanner_spool_t,s0)
+
--- nsaserefpolicy/policy/modules/services/mailscanner.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/services/mailscanner.if	2007-08-02 11:02:02.000000000 -0400
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
--- nsaserefpolicy/policy/modules/services/mailscanner.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.5/policy/modules/services/mailscanner.te	2007-08-02 11:02:02.000000000 -0400
@@ -0,0 +1,5 @@
+
+policy_module(mailscanner,1.0.0)
+
+type mailscanner_spool_t;
+files_type(mailscanner_spool_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
