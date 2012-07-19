From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via socket
Date: Thu, 19 Jul 2012 16:07:53 -0700
Message-Id: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 mediaserver.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/mediaserver.te b/mediaserver.te
index d3f0334..6dd4d4a 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -40,3 +40,6 @@ allow mediaserver camera_calibration_file:file r_file_perms;
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow mediaserver qtaguid_proc:file rw_file_perms;
 allow mediaserver qtaguid_device:chr_file r_file_perms;
+
+# Talk to rild via socket
+unix_socket_connect(mediaserver, rild, rild)
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
