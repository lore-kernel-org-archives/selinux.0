From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Allow CTS Test apps to access to system_data_file
Date: Fri, 27 Jul 2012 15:18:59 -0700
Message-Id: <1343427539-6583-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/app.te b/app.te
index 41866d9..b9b5a17 100644
--- a/app.te
+++ b/app.te
@@ -117,7 +117,7 @@ allow untrusted_app sdcard:file create_file_perms;
 }
 # Native app support.
 bool app_ndk false;
-if (app_ndk) {
+if (app_ndk or android_cts) {
 allow untrusted_app system_data_file:file { execute open };
 }
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
