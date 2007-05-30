Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbxTO014614
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbr2p008429
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:53 GMT
Date: Wed, 30 May 2007 10:22:54 -0400
Message-Id: <200705301422.l4UEMsoc007775@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Remove unconfined_domain from sendmail,  Allow others to read sendmail logs (snmp)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/services/sendmail.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/sendmail.if	2007-05-30 09:08:15.000000000 -0400
@@ -76,6 +76,26 @@
 
 ########################################
 ## <summary>
+##	Read sendmail logs.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`sendmail_read_log',`
+	gen_require(`
+		type sendmail_log_t;
+	')
+
+	logging_search_logs($1)
+	read_files_pattern($1, sendmail_log_t, sendmail_log_t)
+')
+
+########################################
+## <summary>
 ##	Create, read, write, and delete sendmail logs.
 ## </summary>
 ## <param name="domain">
@@ -91,7 +111,7 @@
 	')
 
 	logging_search_logs($1)
-	allow $1 sendmail_log_t:file manage_file_perms;
+	manage_files_pattern($1, sendmail_log_t, sendmail_log_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/sendmail.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/sendmail.te	2007-05-30 09:08:15.000000000 -0400
@@ -1,5 +1,5 @@
 
-policy_module(sendmail,1.4.0)
+policy_module(sendmail,1.4.1)
 
 ########################################
 #
@@ -136,10 +136,6 @@
 	udev_read_db(sendmail_t)
 ')
 
-optional_policy(`
-	unconfined_domain(sendmail_t)
-')
-
 ifdef(`TODO',`
 allow sendmail_t etc_mail_t:dir rw_dir_perms;
 allow sendmail_t etc_mail_t:file manage_file_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
