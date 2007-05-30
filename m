Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHajTr013480
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:45 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHahue002768
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:26:50 -0400
Message-Id: <200705301526.l4UFQo4L010564@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_logwatch changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/logwatch.te	2007-05-30 09:25:53.000000000 -0400
@@ -63,6 +63,8 @@
 files_search_mnt(logwatch_t)
 files_dontaudit_search_home(logwatch_t)
 files_dontaudit_search_boot(logwatch_t)
+# Execs df and if file system mounted with a context avc raised
+files_dontaudit_search_all_dirs(logwatch_t)
 
 fs_getattr_all_fs(logwatch_t)
 fs_dontaudit_list_auto_mountpoints(logwatch_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
