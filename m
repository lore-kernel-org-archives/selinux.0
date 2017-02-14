Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1EDEw80007171
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 08:14:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7033804EB
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 13:14:56 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com ([10.40.3.114])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 v1EDEtSi008452
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 08:14:56 -0500
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Perform access check using euid instead of uid
Date: Tue, 14 Feb 2017 14:14:48 +0100
Message-Id: <20170214131448.22837-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use faccessat() with AT_EACCESS instead of accesss() in order to check
permissions of effective user. access() calls checking existence of
a file (F_OK) were left untouched since they work correctly.

This enables setuid programs to use libsemanage.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/conf-parse.y     |  7 ++++---
 libsemanage/src/semanage_store.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e89..d72a0c2 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -30,6 +30,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 
 extern int semanage_lex(void);                /* defined in conf-scan.c */
 extern int semanage_lex_destroy(void);        /* defined in conf-scan.c */
@@ -361,7 +362,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 		return -1;
 	}
 
-	if (access("/sbin/load_policy", X_OK) == 0) {
+	if (faccessat(AT_FDCWD, "/sbin/load_policy", X_OK, AT_EACCESS) == 0) {
 		conf->load_policy->path = strdup("/sbin/load_policy");
 	} else {
 		conf->load_policy->path = strdup("/usr/sbin/load_policy");
@@ -375,7 +376,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	     calloc(1, sizeof(*(current_conf->setfiles)))) == NULL) {
 		return -1;
 	}
-	if (access("/sbin/setfiles", X_OK) == 0) {
+	if (faccessat(AT_FDCWD, "/sbin/setfiles", X_OK, AT_EACCESS) == 0) {
 		conf->setfiles->path = strdup("/sbin/setfiles");
 	} else {
 		conf->setfiles->path = strdup("/usr/sbin/setfiles");
@@ -389,7 +390,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	     calloc(1, sizeof(*(current_conf->sefcontext_compile)))) == NULL) {
 		return -1;
 	}
-	if (access("/sbin/sefcontext_compile", X_OK) == 0) {
+	if (faccessat(AT_FDCWD, "/sbin/sefcontext_compile", X_OK, AT_EACCESS) == 0) {
 		conf->sefcontext_compile->path = strdup("/sbin/sefcontext_compile");
 	} else {
 		conf->sefcontext_compile->path = strdup("/usr/sbin/sefcontext_compile");
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f468fab..805bd60 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -517,7 +517,7 @@ char *semanage_conf_path(void)
 	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_path(),
 		 SEMANAGE_CONF_FILE);
 
-	if (access(semanage_conf, R_OK) != 0) {
+	if (faccessat(AT_FDCWD, semanage_conf, R_OK, AT_EACCESS) != 0) {
 		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CONF_FILE);
 	}
 
@@ -552,7 +552,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD, path, mode_mask, AT_EACCESS) == -1) {
 			ERR(sh,
 			    "Could not access module store at %s, or it is not a directory.",
 			    path);
@@ -575,7 +575,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD, path, mode_mask, AT_EACCESS) == -1) {
 			ERR(sh,
 			    "Could not access module store active subdirectory at %s, or it is not a directory.",
 			    path);
@@ -598,7 +598,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD, path, mode_mask, AT_EACCESS) == -1) {
 			ERR(sh,
 			    "Could not access module store active modules subdirectory at %s, or it is not a directory.",
 			    path);
@@ -619,7 +619,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISREG(sb.st_mode) || access(path, R_OK | W_OK) == -1) {
+		if (!S_ISREG(sb.st_mode) || faccessat(AT_FDCWD, path, R_OK | W_OK, AT_EACCESS) == -1) {
 			ERR(sh, "Could not access lock file at %s.", path);
 			return -1;
 		}
@@ -639,7 +639,7 @@ int semanage_store_access_check(void)
 
 	/* read access on active store */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-	if (access(path, R_OK | X_OK) != 0)
+	if (faccessat(AT_FDCWD, path, R_OK | X_OK, AT_EACCESS) != 0)
 		goto out;
 
 	/* we can read the active store meaning it is managed
@@ -650,13 +650,13 @@ int semanage_store_access_check(void)
 	 * write access necessary if the lock file does not exist
 	 */
 	path = semanage_files[SEMANAGE_READ_LOCK];
-	if (access(path, R_OK) != 0) {
+	if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS) != 0) {
 		if (access(path, F_OK) == 0) {
 			goto out;
 		}
 
 		path = semanage_files[SEMANAGE_ROOT];
-		if (access(path, R_OK | W_OK | X_OK) != 0) {
+		if (faccessat(AT_FDCWD, path, R_OK | W_OK | X_OK, AT_EACCESS) != 0) {
 			goto out;
 		}
 	}
@@ -666,7 +666,7 @@ int semanage_store_access_check(void)
 
 	/* check the modules directory */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
-	if (access(path, R_OK | W_OK | X_OK) != 0)
+	if (faccessat(AT_FDCWD, path, R_OK | W_OK | X_OK, AT_EACCESS) != 0)
 		goto out;
 
 	rc = SEMANAGE_CAN_WRITE;
-- 
2.9.3
