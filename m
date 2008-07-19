Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL2vjN024243
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:02:57 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL2t5T024798
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:02:56 GMT
Message-Id: <20080719210251.259776187@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:03 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 01/23] slocate policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trivial change (see http://marc.info/?l=selinux&m=121623491423847&w=2)

Index: refpolicy/policy/modules/apps/slocate.te
===================================================================
--- refpolicy.orig/policy/modules/apps/slocate.te	2008-07-19 19:15:35.000000000 +0200
+++ refpolicy/policy/modules/apps/slocate.te	2008-07-19 19:19:41.000000000 +0200
@@ -47,6 +47,7 @@
 fs_getattr_all_fs(locate_t)
 fs_getattr_all_files(locate_t)
 fs_list_all(locate_t)
+fs_list_inotifyfs(locate_t)
 
 # getpwnam
 auth_use_nsswitch(locate_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
