Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q271Q3P4026009
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 20:26:03 -0500
Received: by ghbz13 with SMTP id z13so2788452ghb.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2012 17:26:01 -0800 (PST)
From: Bryan Hinton <bryan@bryanhinton.com>
To: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Cc: Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH] (SCH-i515 US LTE) Added device specific policy and file context files.[PUBLIC DOMAIN]
Date: Tue,  6 Mar 2012 19:28:42 -0600
Message-Id: <1331083722-5732-1-git-send-email-bryan@bryanhinton.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change-Id: Iaf0aa012e48dd3084aae6f57c25a022b210308ff
---
 sepolicy.fc |   13 +++++++++++++
 sepolicy.te |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 sepolicy.fc
 create mode 100644 sepolicy.te

diff --git a/sepolicy.fc b/sepolicy.fc
new file mode 100644
index 0000000..b2f612b
--- /dev/null
+++ b/sepolicy.fc
@@ -0,0 +1,13 @@
+/dev/cdma_.*   u:object_r:radio_device:s0
+/dev/lte_.*    u:object_r:radio_device:s0
+
+/dev/ttyO3     u:object_r:nfc_device:s0
+
+/data/data/com.android.providers.telephony/databases(/.*)? u:object_r:radio_data_file:s0
+/data/data/com.android.providers.telephony/optable.db    u:object_r:radio_data_file:s0
+
+/data/radio/nv_data.bin.*  u:object_r:radio_data_file:s0
+/factory(/.*)?             u:object_r:efs_file:s0
+/factory/nv_data.bin.*     u:object_r:radio_data_file:s0
+
+/sys/devices/platform/nfc-power/nfc_power -- u:object_r:sysfs_nfc_power_writable:s0
diff --git a/sepolicy.te b/sepolicy.te
new file mode 100644
index 0000000..2964ae1
--- /dev/null
+++ b/sepolicy.te
@@ -0,0 +1,4 @@
+type sysfs_nfc_power_writable, fs_type, sysfs_type, mlstrustedobject;
+
+allow domain sysfs_nfc_power_writable:file rw_file_perms;
+allow rild self:netlink_route_socket { setopt };
-- 
1.7.5.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
