From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Untrusted_app gets route information
Date: Mon, 30 Jul 2012 13:51:16 -0700
Message-Id: <1343681476-5242-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index 8b1aa53..139652f 100644
--- a/app.te
+++ b/app.te
@@ -102,6 +102,8 @@ allow untrusted_app node_type:{ tcp_socket udp_socket } node_bind;
 allow untrusted_app port_type:udp_socket name_bind;
 allow untrusted_app port_type:tcp_socket name_bind;
 unix_socket_connect(untrusted_app, dnsproxyd, netd)
+# Get route information.
+allow untrusted_app self:netlink_route_socket { create bind read nlmsg_read };
 }
 # Bluetooth access.
 bool app_bluetooth false;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
