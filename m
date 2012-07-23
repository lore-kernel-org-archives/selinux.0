From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] external/sepolicy: system r/w udp_socket of appdomain
Date: Mon, 23 Jul 2012 14:20:59 -0700
Message-Id: <1343078459-25342-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1343078459-25342-1-git-send-email-hqjiang1988@gmail.com>
References: <1343078459-25342-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: hqjiang <hqjiang1988@gmail.com>

external/sepolicy: allow media_app more permissions on sdcard

external/sepolicy: allow media_app more permissions on sdcard
---
 system.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/system.te b/system.te
index a4065cf..bfbc35a 100644
--- a/system.te
+++ b/system.te
@@ -196,3 +196,6 @@ allow system domain:file r_file_perms;
 # to uart driver and ctrl proc entry
 allow system gps_device:chr_file rw_file_perms;
 allow system gps_control:file rw_file_perms;
+
+# system Read/Write udp_socket of untrusted_app
+allow system appdomain:udp_socket { read write };
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
