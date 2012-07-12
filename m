From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 2/2] label gps proc entry as device-specific (instead of in ocontexts)
Date: Thu, 12 Jul 2012 15:37:51 -0700
Message-Id: <1342132671-17376-3-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
References: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 sepolicy.fc |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sepolicy.fc b/sepolicy.fc
index 066f4fb..759ef03 100644
--- a/sepolicy.fc
+++ b/sepolicy.fc
@@ -27,3 +27,6 @@
 
 # In Samsung Tuna Board, ttyO0 is for uart driver. gps_device is device specific
 /dev/ttyO0	u:object_r:gps_device:s0
+
+# These proc entries are for the CSR GPS chip
+genfscon proc /mcspi1_cs3_ctrl u:object_r:gps_control:s0
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
