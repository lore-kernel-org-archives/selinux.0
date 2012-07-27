Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RL0dxj020163
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 17:00:39 -0400
Received: by ggnv5 with SMTP id v5so3793327ggn.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 14:00:32 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] You can now specify a sebool= flag in seapp_contexts
Date: Fri, 27 Jul 2012 13:59:50 -0700
Message-Id: <1343422790-11155-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The seapp rule will containing an sebool clause will
ONLY be applied on a match to that boolean,
and only if the boolean is set to true.

Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
---
 src/android.c |   48 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/src/android.c b/src/android.c
index 83ba7b7..7974391 100644
--- a/src/android.c
+++ b/src/android.c
@@ -45,6 +45,7 @@ struct seapp_context {
 	char *domain;
 	char *type;
 	char *level;
+	char *sebool;
 	char levelFromUid;
 };
 
@@ -85,6 +86,12 @@ static int seapp_context_cmp(const void *A, const void *B)
 	if (!s1->name && s2->name)
 		return 1;
 
+        /* Give precedence to a specified sebool= over an unspecified sebool=. */
+        if (s1->sebool && !s2->sebool)
+                return -1;
+        if (!s1->sebool && s2->sebool)
+                return 1;
+
 	/* Anything else has equal precedence. */
 	return 0;
 }
@@ -196,6 +203,10 @@ int selinux_android_seapp_context_reload(void)
 				cur->level = strdup(value);
 				if (!cur->level)
 					goto oom;
+			} else if (!strcasecmp(name, "sebool")) {
+				cur->sebool = strdup(value);
+				if (!cur->sebool)
+					goto oom;
 			} else
 				goto err;
 
@@ -217,12 +228,12 @@ int selinux_android_seapp_context_reload(void)
 		int i;
 		for (i = 0; i < nspec; i++) {
 			cur = seapp_contexts[i];
-			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s",
-				    __FUNCTION__,
-				    cur->isSystemServer ? "true" : "false",
-				    cur->user, cur->seinfo, cur->name,
-				    cur->domain, cur->type, cur->level,
-				    cur->levelFromUid ? "true" : "false");
+			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s sebool=%s -> domain=%s type=%s level=%s levelFromUid=%s",
+			__FUNCTION__,
+			cur->isSystemServer ? "true" : "false", cur->user,
+			cur->seinfo, cur->name, cur->sebool, cur->domain,
+			cur->type, cur->level,
+			cur->levelFromUid ? "true" : "false");
 		}
 	}
 #endif
@@ -335,6 +346,17 @@ int selinux_android_setfilecon2(const char *pkgdir,
 		if (!cur->type)
 			continue;
 
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if (value == 0)
+				continue;
+			else if (value == -1) {
+				selinux_log(SELINUX_ERROR,
+				"Could not find boolean: %s ", cur->sebool);
+				goto err;
+			}
+		}
+
 		if (context_type_set(ctx, cur->type))
 			goto oom;
 
@@ -348,7 +370,7 @@ int selinux_android_setfilecon2(const char *pkgdir,
 			if (context_range_set(ctx, cur->level))
 				goto oom;
 		}
-		
+
 		break;
 	}
 
@@ -443,6 +465,7 @@ int selinux_android_setcontext(uid_t uid,
 
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
+
 		if (cur->isSystemServer != isSystemServer)
 			continue;
 		if (cur->user) {
@@ -466,6 +489,17 @@ int selinux_android_setcontext(uid_t uid,
 		if (!cur->domain)
 			continue;
 
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if (value == 0)
+				continue;
+			else if (value == -1) {
+				selinux_log(SELINUX_ERROR,
+				"Could not find boolean: %s ", cur->sebool);
+                                goto err;
+                        }
+                }
+
 		if (context_type_set(ctx, cur->domain))
 			goto oom;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
