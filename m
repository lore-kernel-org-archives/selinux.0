From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Platform app domain sdcard accesses
Date: Fri, 27 Jul 2012 10:54:02 -0700
Message-Id: <1343411642-3444-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index df0f5df..818f5c0 100644
--- a/app.te
+++ b/app.te
@@ -86,6 +86,9 @@ net_domain(browser_app)
 # App sandbox file accesses.
 allow platformappdomain platform_app_data_file:dir create_dir_perms;
 allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_perms;
+# App sdcard file accesses
+allow platformappdomain sdcard:dir create_dir_perms;
+allow platformappdomain sdcard:file create_file_perms;
 
 #
 # Untrusted apps.
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
