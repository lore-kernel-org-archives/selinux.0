From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        hqjiang <hqjiang1988@gmail.com>
Subject: [PATCH] Correct the denies of android.process.media when accessing to mtp_device
Date: Wed, 11 Jul 2012 15:39:48 -0700
Message-Id: <1342046389-9271-2-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
References: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 seapp_contexts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/seapp_contexts b/seapp_contexts
index 502206a..1e98f91 100644
--- a/seapp_contexts
+++ b/seapp_contexts
@@ -38,3 +38,4 @@ user=app_* seinfo=shared domain=shared_app levelFromUid=true
 user=app_* seinfo=media domain=media_app levelFromUid=true
 user=app_* seinfo=release domain=release_app levelFromUid=true
 user=app_* seinfo=release name=com.android.browser domain=browser_app levelFromUid=true
+user=app_* name=android.process.media domain=media_app levelFromUid=true
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
