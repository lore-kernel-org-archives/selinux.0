Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJTT9u027355
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:29:29 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KJTSP1004017
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 19:29:28 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 15:29:25 -0400
Message-Id: <200704201929.l3KJTPT6027296@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Fixes for locate tool
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/apps/slocate.te	2007-02-19 11:32:52.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/apps/slocate.te	2007-04-16 12:08:09.000000000 -0400
@@ -42,9 +42,8 @@
 files_read_etc_runtime_files(locate_t)
 files_read_etc_files(locate_t)
 
-fs_getattr_xattr_fs(locate_t)
-fs_getattr_rpc_pipefs(locate_t)
-fs_getattr_rpc_dirs(locate_t)
+fs_getattr_all_fs(locate_t)
+fs_getattr_all_dirs(locate_t)
 
 libs_use_shared_libs(locate_t)
 libs_use_ld_so(locate_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
