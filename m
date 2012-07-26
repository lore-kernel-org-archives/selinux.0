Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QJGAUr008822
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 15:16:10 -0400
Received: by ghbz13 with SMTP id z13so2475711ghb.12
        for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 12:16:09 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Support for sebool in seapp_contexts
Date: Thu, 26 Jul 2012 12:15:31 -0700
Message-Id: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can now specify a sebool= flag in seapp_contexts
and that rule will ONLY be applied on a match to that
boolean, and only if the boolean is set to true.

Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
---
 src/android.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/src/android.c b/src/android.c
index 83ba7b7..ef27991 100644
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
 
@@ -217,12 +228,13 @@ int selinux_android_seapp_context_reload(void)
 		int i;
 		for (i = 0; i < nspec; i++) {
 			cur = seapp_contexts[i];
-			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s",
+			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s sebool=%s",
 				    __FUNCTION__,
 				    cur->isSystemServer ? "true" : "false",
 				    cur->user, cur->seinfo, cur->name,
 				    cur->domain, cur->type, cur->level,
-				    cur->levelFromUid ? "true" : "false");
+				    cur->levelFromUid ? "true" : "false",
+				    cur->sebool);
 		}
 	}
 #endif
@@ -308,6 +320,17 @@ int selinux_android_setfilecon2(const char *pkgdir,
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
 
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if (value == 0)
+				continue;
+			else if (value == -1) {
+				selinux_log(SELINUX_ERROR, \
+				"Could not find boolean: %s ", cur->sebool);
+				goto err;
+			}
+		}
+
 		/* isSystemServer=true is only for app process labeling. */
 		if (cur->isSystemServer)
 			continue;
@@ -443,6 +466,18 @@ int selinux_android_setcontext(uid_t uid,
 
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
+
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if (value == 0)
+				continue;
+			else if (value == -1) {
+                                selinux_log(SELINUX_ERROR, \
+                                        "Could not find boolean: %s ", cur->sebool);
+				goto err;
+			}
+		}
+
 		if (cur->isSystemServer != isSystemServer)
 			continue;
 		if (cur->user) {
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
