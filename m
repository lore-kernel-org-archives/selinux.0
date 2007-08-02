Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JvopN021256
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:57:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JvmOD028549
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:57:49 GMT
Date: Thu, 2 Aug 2007 15:57:44 -0400
Message-Id: <200708021957.l72JviPf029474@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_loadkeys changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

loadkeys uses unallocated tty during bootup

--- nsaserefpolicy/policy/modules/apps/loadkeys.te	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/loadkeys.te	2007-08-02 11:02:02.000000000 -0400
@@ -30,7 +30,7 @@
 files_read_etc_runtime_files(loadkeys_t)
 
 term_dontaudit_use_console(loadkeys_t)
-term_dontaudit_use_unallocated_ttys(loadkeys_t)
+term_use_unallocated_ttys(loadkeys_t)
 
 init_dontaudit_use_script_ptys(loadkeys_t)
 
@@ -40,3 +40,8 @@
 locallogin_use_fds(loadkeys_t)
 
 miscfiles_read_localization(loadkeys_t)
+
+optional_policy(`
+	nscd_dontaudit_search_pid(loadkeys_t)
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
