From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Appdomain write to cgroup on android_cts enabled
Date: Fri, 27 Jul 2012 15:51:24 -0700
Message-Id: <1343429484-6978-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 cts.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cts.te b/cts.te
index ff8a9f0..7877b19 100644
--- a/cts.te
+++ b/cts.te
@@ -31,6 +31,9 @@ allow appdomain system_file:file rx_file_perms;
 allow appdomain apk_tmp_file:file rw_file_perms;
 allow appdomain shell_data_file:file r_file_perms;
 
+# Write to cgroup
+allow appdomain cgroup:dir write;
+
 # Read routing information.
 allow netdomain self:netlink_route_socket { create read write nlmsg_read };
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
