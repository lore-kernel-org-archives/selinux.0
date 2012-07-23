From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH] external/sepolicy: mediaserver open application data files
Date: Mon, 23 Jul 2012 15:02:55 -0700
Message-Id: <1343080975-25536-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1343080975-25536-1-git-send-email-hqjiang1988@gmail.com>
References: <1343080975-25536-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 mediaserver.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mediaserver.te b/mediaserver.te
index 057e39d..39618a5 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -11,7 +11,7 @@ binder_call(mediaserver, binderservicedomain)
 binder_call(mediaserver, appdomain)
 binder_service(mediaserver)
 allow mediaserver app_data_file:dir search;
-allow mediaserver app_data_file:file { read getattr };
+allow mediaserver app_data_file:file r_file_perms;
 r_dir_file(mediaserver, sdcard)
 allow mediaserver sdcard:file write;
 allow mediaserver camera_device:chr_file rw_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
