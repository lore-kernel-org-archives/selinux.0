From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] We make two changes: 1. GPS-chip-requires-uart-rts-level-control; 2. We label our specific context to misc/camera(./*) in order to allow camera calibration.
Date: Thu, 19 Jul 2012 10:21:42 -0700
Message-Id: <1342718502-29105-1-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <We make two changes:>
References: <We make two changes:>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 init.tuna.rc            |    1 +
 sepolicy.genfs_contexts |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 sepolicy.genfs_contexts

diff --git a/init.tuna.rc b/init.tuna.rc
index 7745161..aa57120 100755
--- a/init.tuna.rc
+++ b/init.tuna.rc
@@ -22,6 +22,7 @@ on post-fs-data
 	# camera calibration
 	mkdir /data/misc/camera 0770 media media
 	mkdir /data/misc/camera/R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044 0770 media media
+	restorecon /data/misc/camera
 
 	# remount factory as read-only
 	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory ro remount
diff --git a/sepolicy.genfs_contexts b/sepolicy.genfs_contexts
new file mode 100644
index 0000000..56ef603
--- /dev/null
+++ b/sepolicy.genfs_contexts
@@ -0,0 +1,2 @@
+# This proc entry is for CSR GPS chip on Samsung Tuna Board.
+genfscon proc /mcspi1_cs3_ctrl u:object_r:gps_control:s0
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
