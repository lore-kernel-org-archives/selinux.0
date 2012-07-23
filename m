From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH 1/1] external/sepolicy: install daemon unlink application data files
Date: Mon, 23 Jul 2012 10:22:17 -0700
Message-Id: <1343064137-17849-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1343064137-17849-1-git-send-email-hqjiang1988@gmail.com>
References: <1343064137-17849-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: hqjiang <hqjiang1988@gmail.com>

---
 installd.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/installd.te b/installd.te
index 466125e..ce9122b 100644
--- a/installd.te
+++ b/installd.te
@@ -20,3 +20,5 @@ dontaudit installd self:capability sys_admin;
 selinux_check_context(installd)
 # Read /seapp_contexts, presently on the rootfs.
 allow installd rootfs:file r_file_perms;
+# Unlink app_data_file
+allow installd app_data_file:lnk_file unlink;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
