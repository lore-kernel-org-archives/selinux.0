Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q271TU1v026103
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 20:29:30 -0500
Received: by ggni4 with SMTP id i4so2788749ggn.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2012 17:29:29 -0800 (PST)
From: Bryan Hinton <bryan@bryanhinton.com>
To: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Cc: Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH] (SCH-i515 US LTE) Modified init.tuna.rc for proper labeling of /factory/* files.[PUBLIC DOMAIN]
Date: Tue,  6 Mar 2012 19:31:58 -0600
Message-Id: <1331083918-5820-1-git-send-email-bryan@bryanhinton.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change-Id: I48f8623ec24728517597fcd77c9c7f3fab5db9be
---
 init.tuna.rc |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/init.tuna.rc b/init.tuna.rc
index 70f1cbe..354c292 100755
--- a/init.tuna.rc
+++ b/init.tuna.rc
@@ -23,6 +23,9 @@ on post-fs-data
 	mkdir /data/misc/camera 0770 media media
 	mkdir /data/misc/camera/R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044 0770 media media
 
+   # remount factory as read-only
+   mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory ro remount
+
 	setprop vold.post_fs_data_done 1
 
 # LTE
@@ -56,7 +59,11 @@ on fs
 	setprop ro.crypto.tmpfs_options size=128m,mode=0771,uid=1000,gid=1000
 	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data wait noatime nosuid nodev nomblk_io_submit,errors=panic
 	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/cache /cache wait noatime nosuid nodev nomblk_io_submit,errors=panic
-	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait ro
+	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait
+   chown radio radio /factory
+   restorecon /factory
+   restorecon /factory/nv_data.bin
+   restorecon /factory/nv_data.bin.md5
 	setprop ro.crypto.fuse_sdcard true
 
 # change permissions for mtd device
@@ -82,6 +89,14 @@ on fs
 
 # add symlink for HDCP key
         symlink /factory/hdcp.keys /system/vendor/firmware/hdcp.keys
+        restorecon /factory/hdcp.keys
+        restorecon /factory/imei
+
+# wifi
+   restorecon /factory/wifi
+
+# wv
+   restorecon /factory/wv.keys
 
 # nfc
     setprop ro.nfc.port "COM4"
@@ -98,6 +113,7 @@ on fs
 	chmod 0660 /sys/class/rfkill/rfkill0/state
 	chown bluetooth bluetooth /sys/class/rfkill/rfkill0/state
 	chown bluetooth bluetooth /sys/class/rfkill/rfkill0/type
+   restorecon /factory/bluetooth
 
 # backlight
 	chown system system /sys/class/backlight/s6e8aa0/brightness
-- 
1.7.5.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
