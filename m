From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/6] external/sepolicy: allow media_app more permissions on sdcard
Date: Thu, 19 Jul 2012 16:07:51 -0700
Message-Id: <1342739276-1686-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/app.te b/app.te
index 0866e95..a5ff295 100644
--- a/app.te
+++ b/app.te
@@ -41,7 +41,7 @@ allow media_app cache_file:dir rw_dir_perms;
 allow media_app cache_file:file create_file_perms;
 # Access sdcard.
 allow media_app sdcard:dir create_dir_perms;
-allow media_app sdcard:file create_file_perms;
+allow media_app sdcard:file { create_file_perms link_file_perms };
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow media_app qtaguid_proc:file rw_file_perms;
 allow media_app qtaguid_device:chr_file r_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
