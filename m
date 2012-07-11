From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] Correct denies of rpmsg device when accessing to remote processors.
Date: Wed, 11 Jul 2012 11:21:05 -0700
Message-Id: <1342030865-5825-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342030865-5825-1-git-send-email-hqjiang1988@gmail.com>
References: <1342030865-5825-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 device.te      |    4 ++++
 file_contexts  |    2 ++
 mediaserver.te |    3 +++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/device.te b/device.te
index 9fc4d18..c9098e9 100644
--- a/device.te
+++ b/device.te
@@ -46,3 +46,7 @@ type gps_device, dev_type;
 # varies per device. This type
 # is used in per device policy
 type hci_attach_dev, dev_type;
+
+# All devices have a rpmsg device for 
+# achieving remoteproc and rpmsg modules
+type rpmsg_device, dev_type;
diff --git a/file_contexts b/file_contexts
index 72c95a5..f88865d 100644
--- a/file_contexts
+++ b/file_contexts
@@ -47,6 +47,8 @@
 /dev/nvmap		u:object_r:nv_device:s0
 /dev/nvhost-.*		u:object_r:nv_device:s0
 /dev/random		u:object_r:random_device:s0
+/dev/rpmsg-omx[0-9]	u:object_r:rpmsg_device:s0
+/dev/rproc_user	u:object_r:rpmsg_device:s0
 /dev/s3c-jpg		u:object_r:camera_device:s0
 /dev/s3c-mem		u:object_r:camera_device:s0
 /dev/s3c-mfc		u:object_r:graphics_device:s0
diff --git a/mediaserver.te b/mediaserver.te
index 8236c79..97f8e5d 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -25,3 +25,6 @@ allow mediaserver sysfs:file rw_file_perms;
 # XXX Why?
 allow mediaserver apk_data_file:file { read getattr };
 allow mediaserver ion_device:chr_file rw_file_perms;
+
+# To use remote processor
+allow mediaserver rpmsg_device:chr_file rw_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
