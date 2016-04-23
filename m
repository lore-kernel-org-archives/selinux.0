Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3N65Sgg007355
 for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2016 02:05:28 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so12078432pac.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 23:05:24 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 2/8] genhomedircon: move fallback user to
 genhomedircon_user_entry_t
Date: Sat, 23 Apr 2016 14:04:53 +0800
Message-Id: <1461391499-20593-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1461391499-20593-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The fallback user is used in all the write functions, making it use a
struct allows us to have everything consistent between normal and
fallback users.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 09c2a10..1e35b7e 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -83,17 +83,6 @@
 #define FALLBACK_USER_LEVEL "s0"
 #define DEFAULT_LOGIN "__default__"
 
-typedef struct {
-	const char *fcfilepath;
-	int usepasswd;
-	const char *homedir_template_path;
-	char *fallback_user;
-	char *fallback_user_prefix;
-	char *fallback_user_level;
-	semanage_handle_t *h_semanage;
-	sepol_policydb_t *policydb;
-} genhomedircon_settings_t;
-
 typedef struct user_entry {
 	char *name;
 	char *sename;
@@ -104,6 +93,15 @@ typedef struct user_entry {
 } genhomedircon_user_entry_t;
 
 typedef struct {
+	const char *fcfilepath;
+	int usepasswd;
+	const char *homedir_template_path;
+	genhomedircon_user_entry_t *fallback;
+	semanage_handle_t *h_semanage;
+	sepol_policydb_t *policydb;
+} genhomedircon_settings_t;
+
+typedef struct {
 	const char *search_for;
 	const char *replace_with;
 } replacement_pair_t;
@@ -1046,10 +1044,16 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
 					   SEMANAGE_FC_HOMEDIRS);
 
-	s.fallback_user = strdup(FALLBACK_USER);
-	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
-	s.fallback_user_level = strdup(FALLBACK_USER_LEVEL);
-	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL) {
+	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
+	if (s.fallback == NULL) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
+	s.fallback->sename = strdup(FALLBACK_USER);
+	s.fallback->prefix = strdup(FALLBACK_USER_PREFIX);
+	s.fallback->level = strdup(FALLBACK_USER_LEVEL);
+	if (s.fallback->sename == NULL || s.fallback->prefix == NULL || s.fallback->level == NULL) {
 		retval = STATUS_ERR;
 		goto done;
 	}
@@ -1073,9 +1077,7 @@ done:
 	if (out != NULL)
 		fclose(out);
 
-	free(s.fallback_user);
-	free(s.fallback_user_prefix);
-	free(s.fallback_user_level);
+	pop_user_entry(&(s.fallback));
 	ignore_free();
 
 	return retval;
-- 
2.7.3
