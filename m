Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KiBdG026025
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:44:11 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Ki9Tm007497
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:44:09 GMT
Date: Thu, 2 Aug 2007 16:44:05 -0400
Message-Id: <200708022044.l72Ki5eY032692@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_procmail changes - Minor procmail fixes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/procmail.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/procmail.te	2007-08-02 11:02:02.000000000 -0400
@@ -30,6 +30,8 @@
 allow procmail_t procmail_tmp_t:file manage_file_perms;
 files_tmp_filetrans(procmail_t, procmail_tmp_t, file)
 
+can_exec(procmail_t,procmail_exec_t)
+
 kernel_read_system_state(procmail_t)
 kernel_read_kernel_sysctls(procmail_t)
 
@@ -108,6 +110,9 @@
 	# for a bug in the postfix local program
 	postfix_dontaudit_rw_local_tcp_sockets(procmail_t)
 	postfix_dontaudit_use_fds(procmail_t)
+	postfix_read_spool_files(procmail_t)
+	postfix_read_local_state(procmail_t)
+	postfix_read_master_state(procmail_t)
 ')
 
 optional_policy(`
@@ -129,3 +134,7 @@
 	spamassassin_exec_client(procmail_t)
 	spamassassin_read_lib_files(procmail_t)
 ')
+
+optional_policy(`
+	mailscanner_read_spool(procmail_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
