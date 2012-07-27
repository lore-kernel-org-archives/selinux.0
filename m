From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Platform app domain sdcard accesses
Date: Fri, 27 Jul 2012 11:23:10 -0700
Message-Id: <1343413390-3603-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/app.te b/app.te
index df0f5df..85de816 100644
--- a/app.te
+++ b/app.te
@@ -22,9 +22,6 @@ allow platform_app cache_file:file create_file_perms;
 allow platform_app shell_data_file:dir search;
 allow platform_app shell_data_file:file { open getattr read };
 allow platform_app shell_data_file:lnk_file read;
-# Access the sdcard.
-allow platform_app sdcard:dir create_dir_perms;
-allow platform_app sdcard:file create_file_perms;
 # Populate /data/app/vmdl*.tmp file created by system server.
 allow platform_app apk_tmp_file:file rw_file_perms;
 
@@ -41,9 +38,6 @@ allow media_app mtp_device:chr_file rw_file_perms;
 # Write to /cache.
 allow media_app cache_file:dir rw_dir_perms;
 allow media_app cache_file:file create_file_perms;
-# Access sdcard.
-allow media_app sdcard:dir create_dir_perms;
-allow media_app sdcard:file create_file_perms;
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow media_app qtaguid_proc:file rw_file_perms;
 allow media_app qtaguid_device:chr_file r_file_perms;
@@ -86,6 +80,9 @@ net_domain(browser_app)
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
