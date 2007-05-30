Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbPgO014261
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbLue002850
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:21 GMT
Date: Wed, 30 May 2007 11:03:01 -0400
Message-Id: <200705301503.l4UF31BJ009240@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Clamd creates files in amavis_var_run_t
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/clamav.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/clamav.te	2007-05-30 07:35:54.000000000 -0400
@@ -121,6 +121,7 @@
 	amavis_read_lib_files(clamd_t)
 	amavis_read_spool_files(clamd_t)
 	amavis_spool_filetrans(clamd_t,clamd_var_run_t,sock_file)
+	amavis_create_pid_files(clamd_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/amavis.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/amavis.if	2007-05-30 09:25:53.000000000 -0400
@@ -167,3 +167,22 @@
 	allow $1 amavis_var_run_t:file setattr;
 	files_search_pids($1)
 ')
+
+########################################
+## <summary>
+##	Set the create of amavis var run files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_create_pid_files',`
+	gen_require(`
+		type amavis_var_run_t;
+	')
+
+	allow $1 amavis_var_run_t:file create_file_perms;
+	files_search_pids($1)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
