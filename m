Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45Co7Rf012111
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 08:50:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 331A5C04B302
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:50:05 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.40.3.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC5EA80693
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:50:04 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsemanage: replace access(,
 F_OK) checks to make setuid programs work
Date: Fri,  5 May 2017 14:49:47 +0200
Message-Id: <20170505124947.21392-4-vmojzis@redhat.com>
In-Reply-To: <20170505124947.21392-1-vmojzis@redhat.com>
References: <1488219577.19819.19.camel@tycho.nsa.gov>
 <20170505124947.21392-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

access() uses real UID instead of effective UID which causes false
negative checks in setuid programs.
Replace access(,F_OK) (i.e. tests for file existence) by stat().

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 508277d..35ca1b0 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -272,7 +272,9 @@ int semanage_direct_connect(semanage_handle_t * sh)
 
 	/* set the disable dontaudit value */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
-	if (access(path, F_OK) == 0)
+
+	struct stat sb;
+	if (stat(path, &sb) == 0)
 		sepol_set_disable_dontaudit(sh->sepolh, 1);
 	else
 		sepol_set_disable_dontaudit(sh->sepolh, 0);
@@ -1101,8 +1103,9 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
+		struct stat sb;
 		if (semanage_get_ignore_module_cache(sh) == 0 &&
-				access(cil_path, F_OK) == 0) {
+				stat(cil_path, &sb) == 0) {
 			continue;
 		}
 
@@ -1165,7 +1168,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Create or remove the disable_dontaudit flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
-	if (access(path, F_OK) == 0)
+	struct stat sb;
+	if (stat(path, &sb) == 0)
 		do_rebuild |= !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
 	else
 		do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
@@ -1190,7 +1194,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Create or remove the preserve_tunables flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
-	if (access(path, F_OK) == 0)
+	if (stat(path, &sb) == 0)
 		do_rebuild |= !(sepol_get_preserve_tunables(sh->sepolh) == 1);
 	else
 		do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
@@ -1231,37 +1235,37 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 */
 	if (!do_rebuild) {
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
-		if (access(path, F_OK) != 0) {
+		if (stat(path, &sb) != 0) {
 			do_rebuild = 1;
 			goto rebuild;
 		}
@@ -1395,7 +1399,7 @@ rebuild:
 			goto cleanup;
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
-		if (access(path, F_OK) == 0) {
+		if (stat(path, &sb) == 0) {
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_STORE_SEUSERS),
@@ -1408,7 +1412,7 @@ rebuild:
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
-		if (access(path, F_OK) == 0) {
+		if (stat(path, &sb) == 0) {
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_USERS_EXTRA),
@@ -1732,7 +1736,8 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (access(module_path, F_OK) != 0) {
+	struct stat sb;
+	if (stat(module_path, &sb) != 0) {
 		ERR(sh, "Module does not exist: %s", module_path);
 		rc = -1;
 		goto cleanup;
@@ -1762,7 +1767,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && access(input_file, F_OK) != 0) {
+	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && stat(input_file, &sb) != 0) {
 		rc = semanage_compile_module(sh, _modinfo);
 		if (rc < 0) {
 			goto cleanup;
@@ -2737,7 +2742,8 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
-		if (access(path, F_OK) == 0) {
+		struct stat sb;
+		if (stat(path, &sb) == 0) {
 			ret = unlink(path);
 			if (ret != 0) {
 				ERR(sh, "Error while removing cached CIL file %s: %s", path, strerror(errno));
-- 
2.9.3
