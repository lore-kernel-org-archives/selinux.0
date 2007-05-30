Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHanaD013629
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHam2p008193
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:48 GMT
Date: Wed, 30 May 2007 11:46:05 -0400
Message-Id: <200705301546.l4UFk5GH011930@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: services_mailman changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional interfaces for mailman

--- nsaserefpolicy/policy/modules/services/mailman.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/mailman.if	2007-05-30 09:25:53.000000000 -0400
@@ -275,6 +275,25 @@
 
 #######################################
 ## <summary>
+##	append
+##	mailman logs.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_append_log',`
+	gen_require(`
+		type mailman_log_t;
+	')
+
+	append_files_pattern($1,mailman_log_t,mailman_log_t)
+')
+
+#######################################
+## <summary>
 ##	Allow domain to read mailman archive files.
 ## </summary>
 ## <param name="domain">

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
