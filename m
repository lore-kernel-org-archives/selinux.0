From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] installd unlink platform_app_data_file
Date: Fri, 27 Jul 2012 13:13:19 -0700
Message-Id: <1343419999-4789-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 installd.te |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/installd.te b/installd.te
index ce9122b..2a87eb7 100644
--- a/installd.te
+++ b/installd.te
@@ -10,7 +10,7 @@ allow installd system_data_file:lnk_file create;
 allow installd dalvikcache_data_file:file create_file_perms;
 allow installd data_file_type:dir create_dir_perms;
 allow installd data_file_type:dir { relabelfrom relabelto };
-allow installd data_file_type:file { getattr unlink };
+allow installd data_file_type:{ file lnk_file } { getattr unlink };
 allow installd apk_data_file:file r_file_perms;
 allow installd apk_tmp_file:file r_file_perms;
 allow installd system_file:file x_file_perms;
@@ -20,5 +20,3 @@ dontaudit installd self:capability sys_admin;
 selinux_check_context(installd)
 # Read /seapp_contexts, presently on the rootfs.
 allow installd rootfs:file r_file_perms;
-# Unlink app_data_file
-allow installd app_data_file:lnk_file unlink;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
