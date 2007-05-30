Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHawx6013852
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHar2p008244
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 10:45:44 -0400
Message-Id: <200705301445.l4UEjic1008135@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: mta changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

snmp wants to search mail queue
remove commented out lines
sysadm_mail_t is now created in all policies
Read bugzilla files

--- nsaserefpolicy/policy/modules/services/mta.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/mta.if	2007-05-30 07:35:54.000000000 -0400
@@ -805,6 +805,25 @@
 	manage_lnk_files_pattern($1,mail_spool_t,mail_spool_t)
 ')
 
+########################################
+## <summary>
+##	Search mail queue dirs.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mta_search_queue',`
+	gen_require(`
+		type mqueue_spool_t;
+	')
+
+	files_search_spool($1)
+	allow $1 mqueue_spool_t:dir search_dir_perms;
+')
+
 #######################################
 ## <summary>
 ##	Do not audit attempts to read and
--- nsaserefpolicy/policy/modules/services/mta.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/mta.te	2007-05-30 07:35:54.000000000 -0400
@@ -27,18 +27,11 @@
 
 type sendmail_exec_t;
 files_type(sendmail_exec_t)
+application_executable_file(sendmail_exec_t)
 
 mta_base_mail_template(system)
 role system_r types system_mail_t;
 
-# cjp: need to resolve this, but require{}
-# does not work in the else part of the optional
-#ifdef(`strict_policy',`
-#	optional_policy(`',`
-#		init_system_domain(system_mail_t,sendmail_exec_t)
-#	')
-#')
-
 ########################################
 #
 # System mail local policy
@@ -61,7 +54,6 @@
 userdom_dontaudit_search_sysadm_home_dirs(system_mail_t)
 
 ifdef(`targeted_policy',`
-	typealias system_mail_t alias sysadm_mail_t;
 
 	manage_dirs_pattern(system_mail_t,mail_spool_t,mail_spool_t)
 	manage_files_pattern(system_mail_t,mail_spool_t,mail_spool_t)
@@ -91,6 +83,7 @@
 optional_policy(`
 	apache_read_squirrelmail_data(system_mail_t)
 	apache_append_squirrelmail_data(system_mail_t)
+	apache_search_bugzilla_dirs(system_mail_t)
 
 	# apache should set close-on-exec
 	apache_dontaudit_append_log(system_mail_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
