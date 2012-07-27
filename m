Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RIxmDE013318
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 14:59:48 -0400
Received: by mail-yw0-f53.google.com with SMTP id 26so3693368yhp.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 11:59:47 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Allow zygote to spawn non matched apps in permissive mode
Date: Fri, 27 Jul 2012 11:58:42 -0700
Message-Id: <1343415522-31745-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1343415522-31745-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343415522-31745-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch will allow non-matched apps in seapp_contexts to
still be spawned via the zygote. An error message will be sent
to logcat.

Change-Id: I9fb5dcfeb384a26e6a01d69bffd2ef14af74c51c
Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
---
 src/android.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/android.c b/src/android.c
index ef27991..50666a0 100644
--- a/src/android.c
+++ b/src/android.c
@@ -526,8 +526,7 @@ int selinux_android_setcontext(uid_t uid,
 		selinux_log(SELINUX_ERROR,
 			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
 			    __FUNCTION__, uid, seinfo, pkgname);
-		rc = -1;
-		goto out;
+		goto err;
 	}
 
 	ctx_str = context_str(ctx);
@@ -559,7 +558,7 @@ err:
 			    "%s:  Error setting context for app with uid %d, seinfo %s: %s\n",
 			    __FUNCTION__, uid, seinfo, strerror(errno));
 
-	rc = -1;
+	rc = (security_getenforce() == 0) ? 0 : -1;
 	goto out;
 oom:
 	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __FUNCTION__);
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
