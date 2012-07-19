From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 3/3] external/sepolicy: system r/w udp_socket of untrusted apps
Date: Thu, 19 Jul 2012 14:49:23 -0700
Message-Id: <1342734563-32644-4-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: hqjiang <hqjiang1988@gmail.com>

---
 system.te |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/system.te b/system.te
index a4065cf..5c34f81 100644
--- a/system.te
+++ b/system.te
@@ -196,3 +196,6 @@ allow system domain:file r_file_perms;
 # to uart driver and ctrl proc entry
 allow system gps_device:chr_file rw_file_perms;
 allow system gps_control:file rw_file_perms;
+
+# system Read/Write udp_socket of untrusted_app
+allow system untrusted_app:udp_socket { read write };
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
