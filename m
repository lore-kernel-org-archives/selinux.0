From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 4/6] external/sepolicy: system talk to rild via socket
Date: Thu, 19 Jul 2012 16:07:54 -0700
Message-Id: <1342739276-1686-5-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 system.te |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/system.te b/system.te
index 5c34f81..1a25fd3 100644
--- a/system.te
+++ b/system.te
@@ -107,6 +107,7 @@ unix_socket_connect(system, dbus, dbusd)
 unix_socket_connect(system, gps, gpsd)
 unix_socket_connect(system, bluetooth, bluetoothd)
 unix_socket_send(system, wpa, wpa)
+unix_socket_connect(system, rild, rild)
 
 # Communicate over a socket created by surfaceflinger.
 allow system surfaceflinger:unix_stream_socket { read write setopt };
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
