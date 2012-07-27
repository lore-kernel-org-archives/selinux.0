From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] socket permissions to untrusted_app
Date: Fri, 27 Jul 2012 15:16:56 -0700
Message-Id: <1343427416-6520-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/app.te b/app.te
index be0983f..41866d9 100644
--- a/app.te
+++ b/app.te
@@ -105,7 +105,7 @@ unix_socket_connect(untrusted_app, dnsproxyd, netd)
 }
 # Bluetooth access.
 bool app_bluetooth false;
-if (app_bluetooth) {
+if (app_bluetooth or android_cts) {
 # No specific SELinux class for bluetooth sockets presently.
 allow untrusted_app self:socket *;
 }
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
