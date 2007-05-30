Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaq7I013743
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHan2p008201
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:24:45 -0400
Message-Id: <200705301524.l4UFOjC2010528@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_readahead changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Readahead needs access to raw disk in order for it to run fast

--- nsaserefpolicy/policy/modules/admin/readahead.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/readahead.te	2007-05-30 09:25:53.000000000 -0400
@@ -18,7 +18,8 @@
 # Local policy
 #
 
-dontaudit readahead_t self:capability { dac_override dac_read_search sys_tty_config };
+allow readahead_t self:capability { dac_override dac_read_search };
+dontaudit readahead_t self:capability sys_tty_config;
 allow readahead_t self:process signal_perms;
 
 manage_files_pattern(readahead_t,readahead_var_run_t,readahead_var_run_t)
@@ -36,7 +37,7 @@
 dev_dontaudit_read_all_blk_files(readahead_t)
 dev_dontaudit_getattr_memory_dev(readahead_t)
 dev_dontaudit_getattr_nvram_dev(readahead_t)
-storage_dontaudit_getattr_fixed_disk_dev(readahead_t)
+storage_raw_read_fixed_disk(readahead_t)
 
 domain_use_interactive_fds(readahead_t)
 
@@ -76,3 +77,7 @@
 optional_policy(`
 	seutil_sigchld_newrole(readahead_t)
 ')
+
+optional_policy(`
+	logging_dontaudit_search_audit_config(readahead_t)
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
