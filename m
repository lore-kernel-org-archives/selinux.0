From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] installd unlink platform_app_data_file
Date: Fri, 27 Jul 2012 11:44:13 -0700
Message-Id: <1343414653-3998-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 installd.te |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/installd.te b/installd.te
index ce9122b..a2c7bb4 100644
--- a/installd.te
+++ b/installd.te
@@ -20,5 +20,6 @@ dontaudit installd self:capability sys_admin;
 selinux_check_context(installd)
 # Read /seapp_contexts, presently on the rootfs.
 allow installd rootfs:file r_file_perms;
-# Unlink app_data_file
+# Unlink app_data_file and platform_app_data_file
 allow installd app_data_file:lnk_file unlink;
+allow installd platform_app_data_file:lnk_file unlink;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
