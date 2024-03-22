Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36384D135
	for <selinux@vger.kernel.org>; Fri, 22 Mar 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119502; cv=none; b=nYWBKrdhS2X73yObCfgBDYttP6cElt4TBUQhM+ig2d1YvXblCbMC+8dKzfe/iM9dp2KH8mRxTSb1MmTslrPewTHFQPiPLVbBFdpHmi1k5om+WXBgNTqT+8Mj0cIOirIRNaAIUmG5qnbXPMkgkfSDbvj12p2yEAhBd4fhtcEUxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119502; c=relaxed/simple;
	bh=gxQcX5XS05rm/d39mf8nu23DfHDZePJzMyU7BxqIti8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PV7dXV9W68uqx+jmXpLo6siUMk+1nVv8DDKYfeWkitId7M7+HvIMSKo4ryHCG2zCy8SB/6SVOQJxUOlEOViQXnuKYPNVgShwZGGDvBLLU4F5GMIRe4Po4DY7jaUoneVzi1xnzthVdWOBxGuMXc5hKJVPPVcWZRSPQD5zXy1kLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com; spf=fail smtp.mailfrom=googlemail.com; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=googlemail.com
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: avoid logs in get_ordered_context_list() without policy
Date: Fri, 22 Mar 2024 15:50:19 +0100
Message-ID: <20240322145019.60220-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If no policy has been loaded yet and thus the current context is still
"kernel" avoid logging failures in get_ordered_context_list(), like:

    get_ordered_context_list:  error in processing configuration file /etc/selinux/debian/contexts/users/root
    get_ordered_context_list:  error in processing configuration file /etc/selinux/debian/contexts/default_contexts

Move the context parsing from get_context_user() to its caller
get_ordered_context_list(), so an invalid context is not treated as an
get_context_user() failure and not logged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - move the context parsing from get_context_user() to its caller
  - add Signed-off-by
---
 libselinux/src/get_context_list.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 7e23be05..0ad24654 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -130,7 +130,7 @@ static int is_in_reachable(char **reachable, const char *usercon_str)
 }
 
 static int get_context_user(FILE * fp,
-			     const char * fromcon,
+			     context_t fromcon,
 			     const char * user,
 			     char ***reachable,
 			     unsigned int *nreachable)
@@ -146,7 +146,6 @@ static int get_context_user(FILE * fp,
 	char **new_reachable = NULL;
 	char *usercon_str;
 	const char *usercon_str2;
-	context_t con;
 	context_t usercon;
 
 	int rc;
@@ -155,14 +154,10 @@ static int get_context_user(FILE * fp,
 
 	/* Extract the role and type of the fromcon for matching.
 	   User identity and MLS range can be variable. */
-	con = context_new(fromcon);
-	if (!con)
-		return -1;
-	fromrole = context_role_get(con);
-	fromtype = context_type_get(con);
-	fromlevel = context_range_get(con);
+	fromrole = context_role_get(fromcon);
+	fromtype = context_type_get(fromcon);
+	fromlevel = context_range_get(fromcon);
 	if (!fromrole || !fromtype) {
-		context_free(con);
 		return -1;
 	}
 
@@ -296,7 +291,6 @@ static int get_context_user(FILE * fp,
 	rc = 0;
 
       out:
-	context_free(con);
 	free(line);
 	return rc;
 }
@@ -418,6 +412,7 @@ int get_ordered_context_list(const char *user,
 	char *fname = NULL;
 	size_t fname_len;
 	const char *user_contexts_path = selinux_user_contexts_path();
+	context_t con = NULL;
 
 	if (!fromcon) {
 		/* Get the current context and use it for the starting context */
@@ -427,6 +422,10 @@ int get_ordered_context_list(const char *user,
 		fromcon = backup_fromcon;
 	}
 
+	con = context_new(fromcon);
+	if (!con)
+		goto failsafe;
+
 	/* Determine the ordering to apply from the optional per-user config
 	   and from the global config. */
 	fname_len = strlen(user_contexts_path) + strlen(user) + 2;
@@ -437,7 +436,7 @@ int get_ordered_context_list(const char *user,
 	fp = fopen(fname, "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
+		rc = get_context_user(fp, con, user, &reachable, &nreachable);
 
 		fclose(fp);
 		if (rc < 0 && errno != ENOENT) {
@@ -451,7 +450,7 @@ int get_ordered_context_list(const char *user,
 	fp = fopen(selinux_default_context_path(), "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
+		rc = get_context_user(fp, con, user, &reachable, &nreachable);
 		fclose(fp);
 		if (rc < 0 && errno != ENOENT) {
 			selinux_log(SELINUX_ERROR,
@@ -472,6 +471,7 @@ int get_ordered_context_list(const char *user,
 	else
 		freeconary(reachable);
 
+	context_free(con);
 	freecon(backup_fromcon);
 
 	return rc;
-- 
2.43.0

