Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6JL7cTt025055
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 17:07:38 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6JL7bTc007516
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2008 21:07:37 GMT
Message-Id: <20080719210252.074422602@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
Date: Sat, 19 Jul 2008 22:50:08 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Subject: [refpolicy-patch 06/23] logrotate policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No controversial changes

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logrotate.te serefpolicy-3.5.0/policy/modules/admin/logrotate.te
--- nsaserefpolicy/policy/modules/admin/logrotate.te	2008-07-10 11:38:46.000000000 -0400
+++ serefpolicy-3.5.0/policy/modules/admin/logrotate.te	2008-07-15 14:05:12.000000000 -0400
@@ -71,6 +71,7 @@
 
 fs_search_auto_mountpoints(logrotate_t)
 fs_getattr_xattr_fs(logrotate_t)
+fs_list_inotifyfs(logrotate_t)
 
 mls_file_read_all_levels(logrotate_t)
 mls_file_write_all_levels(logrotate_t)
@@ -96,9 +97,11 @@
 files_read_etc_files(logrotate_t)
 files_read_etc_runtime_files(logrotate_t)
 files_read_all_pids(logrotate_t)
+files_search_all(logrotate_t)
 # Write to /var/spool/slrnpull - should be moved into its own type.
 files_manage_generic_spool(logrotate_t)
 files_manage_generic_spool_dirs(logrotate_t)
+files_getattr_generic_locks(logrotate_t)
 
 # cjp: why is this needed?
 init_domtrans_script(logrotate_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
