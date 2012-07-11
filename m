From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] correct denies of inter system processes communication over named pipe
Date: Wed, 11 Jul 2012 11:21:04 -0700
Message-Id: <1342030865-5825-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 mediaserver.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/mediaserver.te b/mediaserver.te
index 97f8e5d..c6af603 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -28,3 +28,6 @@ allow mediaserver ion_device:chr_file rw_file_perms;
 
 # To use remote processor
 allow mediaserver rpmsg_device:chr_file rw_file_perms;
+
+# Inter System processes communicate over named pipe (FIFO)
+allow mediaserver system:fifo_file r_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
