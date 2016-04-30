Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7wahi016059
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:58:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so14469265pfz.1
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:58:46 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: [PATCH v4 2/7] genhomedircon: rename FALLBACK #defines consistent
 with user struct
Date: Sat, 30 Apr 2016 15:58:07 +0800
Message-Id: <1462003092-4611-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1462003092-4611-1-git-send-email-jason@perfinion.com>
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 09c2a10..ba997e1 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -78,9 +78,10 @@
 #define TEMPLATE_SEUSER "system_u"
 #define TEMPLATE_LEVEL "s0"
 
-#define FALLBACK_USER "user_u"
-#define FALLBACK_USER_PREFIX "user"
-#define FALLBACK_USER_LEVEL "s0"
+#define FALLBACK_SENAME "user_u"
+#define FALLBACK_PREFIX "user"
+#define FALLBACK_LEVEL "s0"
+#define FALLBACK_NAME ".*"
 #define DEFAULT_LOGIN "__default__"
 
 typedef struct {
@@ -753,14 +754,14 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 			if (semanage_user_query(s->h_semanage, key, &u) < 0)
 			{
 				prefix = name;
-				level = FALLBACK_USER_LEVEL;
+				level = FALLBACK_LEVEL;
 			}
 			else
 			{
 				prefix = semanage_user_get_prefix(u);
 				level = semanage_user_get_mlslevel(u);
 				if (!level)
-					level = FALLBACK_USER_LEVEL;
+					level = FALLBACK_LEVEL;
 			}
 
 			if (set_fallback_user(s, seuname, prefix, level) != 0)
@@ -845,10 +846,10 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 			prefix = semanage_user_get_prefix(*u);
 			level = semanage_user_get_mlslevel(*u);
 			if (!level)
-				level = FALLBACK_USER_LEVEL;
+				level = FALLBACK_LEVEL;
 		} else {
 			prefix = name;
-			level = FALLBACK_USER_LEVEL;
+			level = FALLBACK_LEVEL;
 		}
 
 		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
@@ -1046,9 +1047,9 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
 					   SEMANAGE_FC_HOMEDIRS);
 
-	s.fallback_user = strdup(FALLBACK_USER);
-	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
-	s.fallback_user_level = strdup(FALLBACK_USER_LEVEL);
+	s.fallback_user = strdup(FALLBACK_SENAME);
+	s.fallback_user_prefix = strdup(FALLBACK_PREFIX);
+	s.fallback_user_level = strdup(FALLBACK_LEVEL);
 	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL) {
 		retval = STATUS_ERR;
 		goto done;
-- 
2.7.3
