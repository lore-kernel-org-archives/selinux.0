From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/2] read permission over lnk_file to devices when android_cts enabled
Date: Mon, 30 Jul 2012 11:24:05 -0700
Message-Id: <1343672646-2490-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 cts.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cts.te b/cts.te
index 489be1a..3371410 100644
--- a/cts.te
+++ b/cts.te
@@ -31,6 +31,9 @@ allow appdomain system_file:file rx_file_perms;
 allow appdomain apk_tmp_file:file rw_file_perms;
 allow appdomain shell_data_file:file r_file_perms;
 
+# Read permission over link file to devices.
+allow appdomain dev_type:lnk_file read;
+
 # Read routing information.
 allow netdomain self:netlink_route_socket { create read write nlmsg_read };
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
