Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3N65XAI007368
 for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2016 02:05:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so11959288pfr.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 23:05:37 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 5/8] genhomedircon: Add uid and gid to struct user_entry
Date: Sat, 23 Apr 2016 14:04:56 +0800
Message-Id: <1461391499-20593-6-git-send-email-jason@perfinion.com>
In-Reply-To: <1461391499-20593-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 1a7882c..56c58e0 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -82,10 +82,13 @@
 #define FALLBACK_PREFIX "user"
 #define FALLBACK_LEVEL "s0"
 #define FALLBACK_NAME ".*"
+#define FALLBACK_UIDGID "[0-9]+"
 #define DEFAULT_LOGIN "__default__"
 
 typedef struct user_entry {
 	char *name;
+	char *uid;
+	char *gid;
 	char *sename;
 	char *prefix;
 	char *home;
@@ -628,11 +631,13 @@ static int name_user_cmp(char *key, semanage_user_t ** val)
 }
 
 static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
-			   const char *sen, const char *pre, const char *h,
-			   const char *l)
+			   const char *u, const char *g, const char *sen,
+			   const char *pre, const char *h, const char *l)
 {
 	genhomedircon_user_entry_t *temp = NULL;
 	char *name = NULL;
+	char *uid = NULL;
+	char *gid = NULL;
 	char *sename = NULL;
 	char *prefix = NULL;
 	char *home = NULL;
@@ -644,6 +649,12 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	name = strdup(n);
 	if (!name)
 		goto cleanup;
+	uid = strdup(u);
+	if (!uid)
+		goto cleanup;
+	gid = strdup(g);
+	if (!gid)
+		goto cleanup;
 	sename = strdup(sen);
 	if (!sename)
 		goto cleanup;
@@ -658,6 +669,8 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 		goto cleanup;
 
 	temp->name = name;
+	temp->uid = uid;
+	temp->gid = gid;
 	temp->sename = sename;
 	temp->prefix = prefix;
 	temp->home = home;
@@ -669,6 +682,8 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 
       cleanup:
 	free(name);
+	free(uid);
+	free(gid);
 	free(sename);
 	free(prefix);
 	free(home);
@@ -687,6 +702,8 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
 	temp = *list;
 	*list = temp->next;
 	free(temp->name);
+	free(temp->uid);
+	free(temp->gid);
 	free(temp->sename);
 	free(temp->prefix);
 	free(temp->home);
@@ -738,7 +755,8 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 					level = FALLBACK_LEVEL;
 			}
 
-			if (push_user_entry(&(s->fallback), FALLBACK_NAME, 0, 0,
+			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
+					    FALLBACK_UIDGID, FALLBACK_UIDGID,
 					    seuname, prefix, "", level) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
@@ -768,6 +786,8 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 	const char *seuname = NULL;
 	const char *prefix = NULL;
 	const char *level = NULL;
+	char uid[10];
+	char gid[10];
 	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
 	long rbuflen;
@@ -852,7 +872,13 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		}
 		if (ignore(pwent->pw_dir))
 			continue;
-		if (push_user_entry(&head, name, seuname,
+
+		if (snprintf(uid, sizeof(uid), "%d", pwent->pw_uid) < 0
+		 || snprintf(gid, sizeof(gid), "%d", pwent->pw_gid) < 0) {
+			*errors = STATUS_ERR;
+			goto cleanup;
+		}
+		if (push_user_entry(&head, name, uid, gid, seuname,
 				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
 			*errors = STATUS_ERR;
 			break;
-- 
2.7.3
