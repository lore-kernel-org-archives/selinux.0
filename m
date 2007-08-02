Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72K5Tck022098
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:05:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72K5SM1000653
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:05:28 GMT
Date: Thu, 2 Aug 2007 16:04:24 -0400
Message-Id: <200708022004.l72K4Ome029700@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_kernel changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional interfaces for kernel access

--- nsaserefpolicy/policy/modules/kernel/kernel.if	2007-07-03 07:05:38.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/kernel.if	2007-08-02 11:02:02.000000000 -0400
@@ -108,6 +108,24 @@
 
 ########################################
 ## <summary>
+##	Set the process scheduler of kernel threads.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_setsched',`
+	gen_require(`
+		type kernel_t;
+	')
+
+	allow $1 kernel_t:process setsched;
+')
+
+########################################
+## <summary>
 ##	Send a SIGCHLD signal to kernel threads.
 ## </summary>
 ## <param name="domain">
@@ -1848,6 +1866,27 @@
 
 ########################################
 ## <summary>
+##	Read the process state (/proc/pid) of all unlabeled_t.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_read_unlabeled_state',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:dir list_dir_perms;
+	read_files_pattern($1,unlabeled_t,unlabeled_t)
+	read_lnk_files_pattern($1,unlabeled_t,unlabeled_t)
+')
+
+
+########################################
+## <summary>
 ##	Do not audit attempts to list unlabeled directories.
 ## </summary>
 ## <param name="domain">
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2007-07-25 10:37:36.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/kernel.te	2007-08-02 11:02:02.000000000 -0400
@@ -26,9 +26,6 @@
 role staff_r;
 role user_r;
 
-# here until order dependence is fixed:
-role unconfined_r;
-
 ifdef(`enable_mls',`
 	role secadm_r;
 	role auditadm_r;
@@ -278,6 +275,7 @@
 
 optional_policy(`
 	logging_send_syslog_msg(kernel_t)
+	logging_unconfined(kernel_t)
 ')
 
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
