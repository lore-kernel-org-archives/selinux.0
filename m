Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2UChxPh016683
 for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2014 08:44:04 -0400
From: Thomas Hurd <thurd@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: fix memory leak in semanage_genhomedircon
Date: Fri, 28 Mar 2014 11:29:32 -0400
Message-Id: <1396020572-29790-1-git-send-email-thurd@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/genhomedircon.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index f3b9b5c..1aea839 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1070,8 +1070,10 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.fallback_user = strdup(FALLBACK_USER);
 	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
 	s.fallback_user_level = strdup(FALLBACK_USER_LEVEL);
-	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL)
-		return STATUS_ERR;
+	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL) {
+		retval = STATUS_ERR;
+		goto done;
+	}
 
 	if (ignoredirs) ignore_setup(ignoredirs);
 
@@ -1082,15 +1084,19 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	if (!(out = fopen(s.fcfilepath, "w"))) {
 		/* couldn't open output file */
 		ERR(sh, "Could not open the file_context file for writing");
-		return STATUS_ERR;
+		retval = STATUS_ERR;
+		goto done;
 	}
 
 	retval = write_context_file(&s, out);
 
-	fclose(out);
+done:
+	if (out != NULL)
+		fclose(out);
 
 	free(s.fallback_user);
 	free(s.fallback_user_prefix);
+	free(s.fallback_user_level);
 	ignore_free();
 
 	return retval;
-- 
1.8.4.2
