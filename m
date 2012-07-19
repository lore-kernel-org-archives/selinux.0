From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 6/6] external/sepolicy: android_cts test denials
Date: Thu, 19 Jul 2012 16:07:56 -0700
Message-Id: <1342739276-1686-7-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 cts.te |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/cts.te b/cts.te
index 3600e94..08b770e 100644
--- a/cts.te
+++ b/cts.te
@@ -39,4 +39,25 @@ dontaudit appdomain self:netlink_kobject_uevent_socket create;
 
 # Tries to override DAC restrictions but expects to fail.
 dontaudit shell self:capability dac_override;
+
+# CTS test denials
+# Allow CTS test apks access to apk_tmp_file and shell_data_file
+allow appdomain apk_tmp_file:file rw_file_perms;
+allow appdomain shell_data_file:file r_file_perms;
+# Allow CTS test apks socket permissions (for testing networking functions (e.g., bluetooth))
+allow untrusted_app self:socket { bind create setopt shutdown listen };
+# Allow CTS Test apks to access to app/system_data_file
+allow appdomain app_data_file:file r_file_perms;
+allow appdomain system_data_file:file { x_file_perms open };
+# android.permission test denies
+allow appdomain block_device:lnk_file r_file_perms;
+allow appdomain cgroup:dir w_file_perms;
+allow appdomain media_app:lnk_file r_file_perms;
+allow appdomain radio_device:lnk_file r_file_perms;
+allow appdomain untrusted_app:lnk_file r_file_perms;
+allow appdomain zygote:netlink_selinux_socket getattr;
+# android.security test deny
+allow appdomain untrusted_app:netlink_route_socket { read bind create };
+# android.util test deny
+allow appdomain log_device:chr_file r_file_perms;
 }
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
