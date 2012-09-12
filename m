From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Allow domain access to /dev/ion
Date: Wed, 12 Sep 2012 14:43:48 -0700
Message-Id: <1347486228-12390-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change-Id: I87f81a632ed61f284f2fe09726f5c4529d36f252
---
 domain.te      |    3 +++
 mediaserver.te |    1 -
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/domain.te b/domain.te
index 6be7ddd..47ad05a 100644
--- a/domain.te
+++ b/domain.te
@@ -83,6 +83,9 @@ allow domain cache_file:lnk_file read;
 allow domain cgroup:dir { search write };
 allow domain cgroup:file w_file_perms;
 
+#Allow access to ion memory allocation device
+allow domain ion_device:chr_file rw_file_perms;
+
 # For /sys/qemu_trace files in the emulator.
 bool in_qemu false;
 if (in_qemu) {
diff --git a/mediaserver.te b/mediaserver.te
index e124db0..4b299a0 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -25,7 +25,6 @@ allow mediaserver qemu_device:chr_file rw_file_perms;
 allow mediaserver sysfs:file rw_file_perms;
 # XXX Why?
 allow mediaserver apk_data_file:file { read getattr };
-allow mediaserver ion_device:chr_file rw_file_perms;
 
 # To use remote processor
 allow mediaserver rpmsg_device:chr_file rw_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
