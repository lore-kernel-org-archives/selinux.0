From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 2/3] external/sepolicy: install daemon link/unlink application data files
Date: Thu, 19 Jul 2012 14:49:22 -0700
Message-Id: <1342734563-32644-3-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: hqjiang <hqjiang1988@gmail.com>

---
 installd.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/installd.te b/installd.te
index 466125e..5211f0a 100644
--- a/installd.te
+++ b/installd.te
@@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;
 selinux_check_context(installd)
 # Read /seapp_contexts, presently on the rootfs.
 allow installd rootfs:file r_file_perms;
+# Link/Unlink app_data_file
+allow installd app_data_file:lnk_file link_file_perms;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
