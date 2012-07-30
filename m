From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Allow release_app getattr of netlink_selinux sockets
Date: Mon, 30 Jul 2012 14:18:14 -0700
Message-Id: <1343683094-5461-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index 139652f..4e002bf 100644
--- a/app.te
+++ b/app.te
@@ -63,6 +63,8 @@ net_domain(release_app)
 bluetooth_domain(release_app)
 # Read logs.
 allow release_app log_device:chr_file read;
+# Use netlink_selinux socket
+allow release_app zygote:netlink_selinux_socket getattr;
 
 #
 # An example of a specific domain for a specific app
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
