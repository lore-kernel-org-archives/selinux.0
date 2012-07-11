From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] GPSLocation Provider needs socket connection
Date: Wed, 11 Jul 2012 15:39:49 -0700
Message-Id: <1342046389-9271-3-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
References: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 system.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/system.te b/system.te
index 1a94c75..f35e9a2 100644
--- a/system.te
+++ b/system.te
@@ -192,3 +192,6 @@ allow system domain:file r_file_perms;
 # to uart driver and ctrl proc entry
 allow system gps_device:chr_file rw_file_perms;
 allow system gps_control:file rw_file_perms;
+
+# GpsLocationProvider Connection
+allow system rild:unix_stream_socket connectto;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
