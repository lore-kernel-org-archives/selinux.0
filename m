From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH] add read permission over dev_type to appdomain on android_cts enabled
Date: Fri, 27 Jul 2012 15:40:27 -0700
Message-Id: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 cts.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cts.te b/cts.te
index 489be1a..ff8a9f0 100644
--- a/cts.te
+++ b/cts.te
@@ -20,7 +20,7 @@ allow appdomain file_type:dir r_dir_perms;
 allow appdomain fs_type:dir r_dir_perms;
 allow appdomain dev_type:dir r_dir_perms;
 allow appdomain file_type:dir_file_class_set getattr;
-allow appdomain dev_type:dir_file_class_set getattr;
+allow appdomain dev_type:dir_file_class_set { getattr read };
 allow appdomain fs_type:dir_file_class_set getattr;
 
 # Execute the shell or other system executables.
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
