From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/2] GPS chip accesses to uart driver when locationmanager launched.
Date: Thu, 12 Jul 2012 15:37:50 -0700
Message-Id: <1342132671-17376-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
References: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 sepolicy.fc |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sepolicy.fc b/sepolicy.fc
index 599ff92..066f4fb 100644
--- a/sepolicy.fc
+++ b/sepolicy.fc
@@ -9,7 +9,6 @@
 /dev/tiler	u:object_r:video_device:s0
 /dev/ttyGS0	u:object_r:radio_device:s0
 /dev/ttyGS1	u:object_r:radio_device:s0
-/dev/ttyO0	u:object_r:radio_device:s0
 /dev/umts_boot0 u:object_r:radio_device:s0
 /dev/umts_boot1 u:object_r:radio_device:s0
 /dev/umts_ipc0	u:object_r:radio_device:s0
@@ -25,3 +24,6 @@
 #The devices and files used by the hciattach service are device specific
 /system/bin/brcm_patchram_plus     u:object_r:hci_attach_exec:s0
 /dev/ttyO1     u:object_r:hci_attach_dev:s0
+
+# In Samsung Tuna Board, ttyO0 is for uart driver. gps_device is device specific
+/dev/ttyO0	u:object_r:gps_device:s0
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
