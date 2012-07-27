Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RMHZkC023750
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 18:17:35 -0400
Received: by ggnv5 with SMTP id v5so3847915ggn.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 15:17:24 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Allow non-matched apps to launch when no match found
Date: Fri, 27 Jul 2012 15:16:43 -0700
Message-Id: <1343427403-22826-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allows the zygote to still spawn apps in the zygote's
context when no match is found in seapp_contexts. In
enforcing mode, apps that are not matched will not be
spawned. A "No match" message will (still) be printed
to logcat.

Change-Id: Ibe362cc8e168be7acae5162c9ff6a310233fcbe6
---
 src/android.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/android.c b/src/android.c
index 7974391..b013110 100644
--- a/src/android.c
+++ b/src/android.c
@@ -525,7 +525,8 @@ int selinux_android_setcontext(uid_t uid,
 		selinux_log(SELINUX_ERROR,
 			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
 			    __FUNCTION__, uid, seinfo, pkgname);
-		rc = -1;
+
+		rc = (security_getenforce() == 0) ? 0 : -1;
 		goto out;
 	}
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
