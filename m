Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G6LBG021119
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:24 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so9376094pac.2
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:06:22 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] genhomedircon: rename FALLBACK #defines consistent with
 struct
Date: Sat,  9 Apr 2016 00:05:31 +0800
Message-Id: <1460131535-15688-4-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/genhomedircon.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 3289954..61f503f 100644
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
 
 typedef struct user_entry {
@@ -750,14 +751,14 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
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
@@ -842,10 +843,10 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
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
@@ -1049,10 +1050,14 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 		goto done;
 	}
 
-	s.fallback->sename = strdup(FALLBACK_USER);
-	s.fallback->prefix = strdup(FALLBACK_USER_PREFIX);
-	s.fallback->level = strdup(FALLBACK_USER_LEVEL);
-	if (s.fallback->sename == NULL || s.fallback->prefix == NULL || s.fallback->level == NULL) {
+	s.fallback->name = strdup(FALLBACK_NAME);
+	s.fallback->sename = strdup(FALLBACK_SENAME);
+	s.fallback->prefix = strdup(FALLBACK_PREFIX);
+	s.fallback->level = strdup(FALLBACK_LEVEL);
+	if (s.fallback->name == NULL
+	 || s.fallback->sename == NULL
+	 || s.fallback->prefix == NULL
+	 || s.fallback->level == NULL) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-- 
2.7.3
