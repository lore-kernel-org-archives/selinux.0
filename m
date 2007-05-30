Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHakwU013502
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHai2p008174
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:22:01 -0400
Message-Id: <200705301522.l4UFM0PG010486@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: apps_slocate changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

locates generates avc messages without these rules

--- nsaserefpolicy/policy/modules/apps/slocate.te	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/apps/slocate.te	2007-05-30 09:25:53.000000000 -0400
@@ -39,11 +39,13 @@
 
 files_list_all(locate_t)
 files_getattr_all_files(locate_t)
+files_getattr_all_sockets(locate_t)
 files_read_etc_runtime_files(locate_t)
 files_read_etc_files(locate_t)
 
 fs_getattr_all_fs(locate_t)
-fs_getattr_all_dirs(locate_t)
+fs_getattr_all_files(locate_t)
+fs_list_all(locate_t)
 
 libs_use_shared_libs(locate_t)
 libs_use_ld_so(locate_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
