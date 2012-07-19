From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] Target the denials/policies over qtaguid file and device: 1. Relabel /proc/net/xt_qtaguid/ctrl from "qtaguid" to "qtaguid_proc"; 2. Label /dev/xt_qtaguid with "qtaguid_device"; 3. Allow mediaserver read/[write] to qtaguid_proc and qtaguid_device; 4. Allow media apps read/[write] to qtaguid_proc and qtaguid_device; 5. Allow system read/[write] to qtaguid_proc and qtaguid_device.
Date: Thu, 19 Jul 2012 11:07:04 -0700
Message-Id: <1342721224-29942-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually, some of policies related to qtaguid have been there already, but
we refind existing ones and add new ones.
---
 app.te         |    6 ++++--
 device.te      |    1 +
 file.te        |    2 +-
 file_contexts  |    1 +
 genfs_contexts |    2 +-
 mediaserver.te |    4 ++++
 system.te      |    3 ++-
 7 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/app.te b/app.te
index c55f4e0..0866e95 100644
--- a/app.te
+++ b/app.te
@@ -42,7 +42,9 @@ allow media_app cache_file:file create_file_perms;
 # Access sdcard.
 allow media_app sdcard:dir create_dir_perms;
 allow media_app sdcard:file create_file_perms;
-
+# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
+allow media_app qtaguid_proc:file rw_file_perms;
+allow media_app qtaguid_device:chr_file r_file_perms;
 # Apps signed with the shared key.
 type shared_app, domain;
 app_domain(shared_app)
@@ -141,7 +143,7 @@ allow appdomain anr_data_file:dir search;
 allow appdomain anr_data_file:file { open append };
 
 # Write to /proc/net/xt_qtaguid/ctrl file.
-allow appdomain qtaguid:file write;
+allow appdomain qtaguid_proc:file write;
 
 # Use the Binder.
 binder_use(appdomain)
diff --git a/device.te b/device.te
index c9098e9..7818ce8 100644
--- a/device.te
+++ b/device.te
@@ -40,6 +40,7 @@ type zero_device, dev_type;
 type fuse_device, dev_type;
 type ion_device, dev_type;
 type gps_device, dev_type;
+type qtaguid_device, dev_type;
 
 # All devices have a uart for the hci
 # attach service. The uart dev node
diff --git a/file.te b/file.te
index e5c8502..9af8ca5 100644
--- a/file.te
+++ b/file.te
@@ -4,7 +4,7 @@ type pipefs, fs_type;
 type sockfs, fs_type;
 type rootfs, fs_type;
 type proc, fs_type;
-type qtaguid, fs_type, mlstrustedobject;
+type qtaguid_proc, fs_type, mlstrustedobject;
 type selinuxfs, fs_type;
 type cgroup, fs_type, mlstrustedobject;
 type sysfs, fs_type, mlstrustedobject;
diff --git a/file_contexts b/file_contexts
index 39c4363..f7abbb7 100644
--- a/file_contexts
+++ b/file_contexts
@@ -77,6 +77,7 @@
 /dev/urandom		u:object_r:urandom_device:s0
 /dev/vcs[0-9a-z]*	u:object_r:vcs_device:s0
 /dev/video[0-9]*	u:object_r:video_device:s0
+/dev/xt_qtaguid	u:object_r:qtaguid_device:s0
 /dev/zero		u:object_r:zero_device:s0
 #############################
 # System files
diff --git a/genfs_contexts b/genfs_contexts
index 103136c..ff633a7 100644
--- a/genfs_contexts
+++ b/genfs_contexts
@@ -2,7 +2,7 @@
 genfscon rootfs / u:object_r:rootfs:s0
 # proc labeling can be further refined (longest matching prefix).
 genfscon proc / u:object_r:proc:s0
-genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
+genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid_proc:s0
 # selinuxfs booleans can be individually labeled.
 genfscon selinuxfs / u:object_r:selinuxfs:s0
 genfscon cgroup / u:object_r:cgroup:s0
diff --git a/mediaserver.te b/mediaserver.te
index 8d37fb7..057e39d 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -35,3 +35,7 @@ allow mediaserver system:fifo_file r_file_perms;
 # Camera calibration
 allow mediaserver camera_calibration_file:dir r_dir_perms;
 allow mediaserver camera_calibration_file:file r_file_perms;
+
+# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
+allow mediaserver qtaguid_proc:file rw_file_perms;
+allow mediaserver qtaguid_device:chr_file r_file_perms;
diff --git a/system.te b/system.te
index 04ff84c..a4065cf 100644
--- a/system.te
+++ b/system.te
@@ -89,7 +89,8 @@ allow system appdomain:dir r_dir_perms;
 allow system appdomain:{ file lnk_file } rw_file_perms;
 
 # Write to /proc/net/xt_qtaguid/ctrl.
-allow system qtaguid:file rw_file_perms;
+allow system qtaguid_proc:file rw_file_perms;
+allow system qtaguid_device:chr_file rw_file_perms;
 
 # Notify init of death.
 allow system init:process sigchld;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
