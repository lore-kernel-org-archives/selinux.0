Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6Q1UpZM019367
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 21:30:56 -0400
Received: by ggnv5 with SMTP id v5so1492139ggn.12
        for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 18:30:54 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Support for sebool in seapp_contexts
Date: Wed, 25 Jul 2012 18:30:08 -0700
Message-Id: <1343266208-4869-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1343266208-4869-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343266208-4869-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change-Id: Ib2f95d526ef20179f113254d4683836bdabdfbea
---
 src/android.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/src/android.c b/src/android.c
index 83ba7b7..921e8dc 100644
--- a/src/android.c
+++ b/src/android.c
@@ -45,6 +45,7 @@ struct seapp_context {
 	char *domain;
 	char *type;
 	char *level;
+	char *sebool;
 	char levelFromUid;
 };
 
@@ -53,6 +54,12 @@ static int seapp_context_cmp(const void *A, const void *B)
 	const struct seapp_context **sp1 = A, **sp2 = B;
 	const struct seapp_context *s1 = *sp1, *s2 = *sp2;
 
+	/* Give precedence to a specified sebool= over an unspecified sebool=. */
+	if (s1->sebool && !s2->sebool)
+		return -1;
+	if (!s1->sebool && s2->sebool)
+		return 1;
+
 	/* Give precedence to isSystemServer=true. */
 	if (s1->isSystemServer != s2->isSystemServer)
 		return (s1->isSystemServer ? -1 : 1);
@@ -196,6 +203,14 @@ int selinux_android_seapp_context_reload(void)
 				cur->level = strdup(value);
 				if (!cur->level)
 					goto oom;
+			} else if (!strcasecmp(name, "sebool")) {
+				cur->sebool = strdup(value);
+				if (!cur->sebool)
+					goto oom;
+			} else if (!strcasecmp(name, "sebool")) {
+				cur->sebool = strdup(value);
+				if (!cur->sebool)
+					goto oom;
 			} else
 				goto err;
 
@@ -217,12 +232,13 @@ int selinux_android_seapp_context_reload(void)
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
@@ -308,6 +324,18 @@ int selinux_android_setfilecon2(const char *pkgdir,
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
 
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if(value == 0) {
+				continue;
+			}
+			else if(value == -1) {
+				selinux_log(SELINUX_ERROR, \
+				"Could not find boolean: %s ", cur->sebool);
+				goto err;
+			}
+		}
+
 		/* isSystemServer=true is only for app process labeling. */
 		if (cur->isSystemServer)
 			continue;
@@ -443,6 +471,19 @@ int selinux_android_setcontext(uid_t uid,
 
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
+
+		if (cur->sebool) {
+			int value = security_get_boolean_active(cur->sebool);
+			if(value == 0) {
+				continue;
+			}
+			else if(value == -1) {
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
