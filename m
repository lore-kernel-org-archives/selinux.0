From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 2/2] untrusted_app reads logs when android_cts enabled
Date: Mon, 30 Jul 2012 11:24:06 -0700
Message-Id: <1343672646-2490-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1343672646-2490-1-git-send-email-hqjiang1988@gmail.com>
References: <1343672646-2490-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index b9b5a17..8b1aa53 100644
--- a/app.te
+++ b/app.te
@@ -120,6 +120,10 @@ bool app_ndk false;
 if (app_ndk or android_cts) {
 allow untrusted_app system_data_file:file { execute open };
 }
+# Read Logs
+if (android_cts) {
+allow untrusted_app log_device:chr_file read;
+}
 
 #
 # Rules for all app domains.
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
