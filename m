From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: bill.c.roberts@gmail.com, sds@tycho.nsa.gov,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] Corrected denials for LocationManager when accessing gps over uart.
Date: Tue, 10 Jul 2012 14:36:22 -0700
Message-Id: <1341956182-1071-3-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
References: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 device.te |    1 +
 file.te   |    3 +++
 ocontexts |    3 +++
 rild.te   |    3 +++
 system.te |    5 +++++
 5 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/device.te b/device.te
index cb15eeb..9fc4d18 100644
--- a/device.te
+++ b/device.te
@@ -39,6 +39,7 @@ type vcs_device, dev_type;
 type zero_device, dev_type;
 type fuse_device, dev_type;
 type ion_device, dev_type;
+type gps_device, dev_type;
 
 # All devices have a uart for the hci
 # attach service. The uart dev node
diff --git a/file.te b/file.te
index f18eb23..ba85ca5 100644
--- a/file.te
+++ b/file.te
@@ -79,6 +79,9 @@ type vold_socket, file_type;
 type wpa_socket, file_type;
 type zygote_socket, file_type;
 
+# UART (for GPS) control proc file
+type gps_control, file_type;
+
 # Allow files to be created in their appropriate filesystems.
 allow fs_type self:filesystem associate;
 allow sysfs_type sysfs:filesystem associate;
diff --git a/ocontexts b/ocontexts
index 7cbb989..a3e7d91 100644
--- a/ocontexts
+++ b/ocontexts
@@ -52,6 +52,9 @@ genfscon rootfs / u:object_r:rootfs:s0
 # proc labeling can be further refined (longest matching prefix).
 genfscon proc / u:object_r:proc:s0
 genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
+# These proc entries are for the CSR GPS chip
+# XXX Can we label these as device specific?
+genfscon proc /mcspi1_cs3_ctrl u:object_r:gps_control:s0
 # selinuxfs booleans can be individually labeled.
 genfscon selinuxfs / u:object_r:selinuxfs:s0
 genfscon cgroup / u:object_r:cgroup:s0
diff --git a/rild.te b/rild.te
index 033fc84..9176348 100644
--- a/rild.te
+++ b/rild.te
@@ -34,3 +34,6 @@ allow rild sysfs:file rw_file_perms;
 # property service
 allow rild rild_prop:property_service set;
 allow rild radio_prop:property_service set;
+
+# Read/Write to uart driver (for GPS)
+allow rild gps_device:chr_file rw_file_perms;
diff --git a/system.te b/system.te
index 2030af4..1a94c75 100644
--- a/system.te
+++ b/system.te
@@ -187,3 +187,8 @@ allow system system_file:file x_file_perms;
 # XXX dontaudit candidate
 allow system domain:dir r_dir_perms;
 allow system domain:file r_file_perms;
+
+# LocationManager(e.g, GPS) needs to read and write
+# to uart driver and ctrl proc entry
+allow system gps_device:chr_file rw_file_perms;
+allow system gps_control:file rw_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
