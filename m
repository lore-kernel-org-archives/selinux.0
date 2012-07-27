From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] allocate perms to platformappdomain over system_data_file
Date: Fri, 27 Jul 2012 11:34:15 -0700
Message-Id: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index 85de816..dca2e0c 100644
--- a/app.te
+++ b/app.te
@@ -83,6 +83,8 @@ allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_
 # App sdcard file accesses
 allow platformappdomain sdcard:dir create_dir_perms;
 allow platformappdomain sdcard:file create_file_perms;
+# System data file accesses XXX????
+allow platformappdomain system_data_file:file open;
 
 #
 # Untrusted apps.
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
