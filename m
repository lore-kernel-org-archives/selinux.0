From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] domain writes to cgroup pseudo filesystem
Date: Mon, 30 Jul 2012 13:20:38 -0700
Message-Id: <1343679638-3266-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 domain.te |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/domain.te b/domain.te
index 2e9720e..9a59c49 100644
--- a/domain.te
+++ b/domain.te
@@ -80,7 +80,7 @@ allow domain cache_file:file { getattr read };
 allow domain cache_file:lnk_file read;
 
 # For /acct/uid/*/tasks.
-allow domain cgroup:dir search;
+allow domain cgroup:dir { search write };
 allow domain cgroup:file w_file_perms;
 
 # For /sys/qemu_trace files in the emulator.
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
