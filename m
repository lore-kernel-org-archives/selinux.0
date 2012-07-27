From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] mediaserver and system require abstract socket connnection
Date: Fri, 27 Jul 2012 13:20:20 -0700
Message-Id: <1343420420-4920-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 mediaserver.te |    2 ++
 system.te      |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/mediaserver.te b/mediaserver.te
index 39618a5..1b97eed 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -39,3 +39,5 @@ allow mediaserver camera_calibration_file:file r_file_perms;
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow mediaserver qtaguid_proc:file rw_file_perms;
 allow mediaserver qtaguid_device:chr_file r_file_perms;
+# Allow abstract socket connection
+allow mediaserver rild:unix_stream_socket connectto;
diff --git a/system.te b/system.te
index bfbc35a..0b16246 100644
--- a/system.te
+++ b/system.te
@@ -199,3 +199,5 @@ allow system gps_control:file rw_file_perms;
 
 # system Read/Write udp_socket of untrusted_app
 allow system appdomain:udp_socket { read write };
+# Allow abstract socket connection
+allow system rild:unix_stream_socket connectto;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
