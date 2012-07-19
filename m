From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 2/6] external/sepolicy: mediaserver open application data files
Date: Thu, 19 Jul 2012 16:07:52 -0700
Message-Id: <1342739276-1686-3-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 mediaserver.te |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mediaserver.te b/mediaserver.te
index 057e39d..d3f0334 100644
--- a/mediaserver.te
+++ b/mediaserver.te
@@ -25,6 +25,7 @@ allow mediaserver sysfs:file rw_file_perms;
 # XXX Why?
 allow mediaserver apk_data_file:file { read getattr };
 allow mediaserver ion_device:chr_file rw_file_perms;
+allow mediaserver app_data_file:file open;
 
 # To use remote processor
 allow mediaserver rpmsg_device:chr_file rw_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
