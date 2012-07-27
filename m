From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] appdomain r/w apk_tmp_file and shell_data_file on android_cts enabled
Date: Fri, 27 Jul 2012 15:13:05 -0700
Message-Id: <1343427185-6377-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 cts.te |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/cts.te b/cts.te
index 3600e94..489be1a 100644
--- a/cts.te
+++ b/cts.te
@@ -27,6 +27,10 @@ allow appdomain fs_type:dir_file_class_set getattr;
 allow appdomain shell_exec:file rx_file_perms;
 allow appdomain system_file:file rx_file_perms;
 
+# Accesses to apk_tmp_file and shell_data_file
+allow appdomain apk_tmp_file:file rw_file_perms;
+allow appdomain shell_data_file:file r_file_perms;
+
 # Read routing information.
 allow netdomain self:netlink_route_socket { create read write nlmsg_read };
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
