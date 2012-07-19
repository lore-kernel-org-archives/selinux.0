From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Subject: [PATCH 5/6] external/sepolicy: allow media_app read to application data files
Date: Thu, 19 Jul 2012 16:07:55 -0700
Message-Id: <1342739276-1686-6-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 app.te |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/app.te b/app.te
index a5ff295..06da29b 100644
--- a/app.te
+++ b/app.te
@@ -45,6 +45,8 @@ allow media_app sdcard:file { create_file_perms link_file_perms };
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow media_app qtaguid_proc:file rw_file_perms;
 allow media_app qtaguid_device:chr_file r_file_perms;
+# Read to app_data_file
+allow media_app app_data_file:file r_file_perms;
 # Apps signed with the shared key.
 type shared_app, domain;
 app_domain(shared_app)
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
