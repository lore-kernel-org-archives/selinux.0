Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w29Fdtg9027984
 for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2018 10:39:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3zyWlq6GW7z4KSG1
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 15:39:51 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3zyWlq5BYHz4KSG0
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 15:39:51 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC661D144B
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 15:39:49 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34703215CDAE
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 15:39:48 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri,  9 Mar 2018 16:39:44 +0100
Message-Id: <20180309153944.7733-1-vmojzis@redhat.com>
In-Reply-To: <3927bd04-7409-1476-ddf6-200c49abfbe2@tycho.nsa.gov>
References: <3927bd04-7409-1476-ddf6-200c49abfbe2@tycho.nsa.gov>
Subject: [PATCH] libsemanage: replace access() checks to make setuid
 programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

access() uses real UID instead of effective UID which causes false
negative checks in setuid programs.
Replace access() calls (mostly tests for file existence) by stat().

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c     | 137 +++++++++++++++++++++++++--------------
 libsemanage/src/semanage_store.c |  11 +++-
 2 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 92d7517d..439122df 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -140,6 +140,7 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
 int semanage_direct_connect(semanage_handle_t * sh)
 {
 	const char *path;
+	struct stat sb;
 
 	if (semanage_check_init(sh, sh->conf->store_root_path))
 		goto err;
@@ -302,10 +303,16 @@ int semanage_direct_connect(semanage_handle_t * sh)
 
 	/* set the disable dontaudit value */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
-	if (access(path, F_OK) == 0)
+
+	if (stat(path, &sb) == 0)
 		sepol_set_disable_dontaudit(sh->sepolh, 1);
-	else
+	else if (errno == ENOENT) {
+		/* The file does not exist */
 		sepol_set_disable_dontaudit(sh->sepolh, 0);
+	} else {
+		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		goto err;
+	}
 
 	return STATUS_SUCCESS;
 
@@ -1139,6 +1146,7 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 	int status = 0;
 	int i;
 	char cil_path[PATH_MAX];
+	struct stat sb;
 
 	assert(sh);
 	assert(modinfos);
@@ -1155,9 +1163,13 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 		}
 
 		if (semanage_get_ignore_module_cache(sh) == 0 &&
-				access(cil_path, F_OK) == 0) {
+				(status = stat(cil_path, &sb)) == 0) {
 			continue;
 		}
+		if (status != 0 && errno != ENOENT) {
+			ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
+			goto cleanup; //an error in the "stat" call
+		}
 
 		status = semanage_compile_module(sh, &modinfos[i]);
 		if (status < 0) {
@@ -1196,6 +1208,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	struct cil_db *cildb = NULL;
 	semanage_module_info_t *modinfos = NULL;
 	mode_t mask = umask(0077);
+	struct stat sb;
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
@@ -1234,10 +1247,16 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Create or remove the disable_dontaudit flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
-	if (access(path, F_OK) == 0)
+	if (stat(path, &sb) == 0)
 		do_rebuild |= !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
-	else
+	else if (errno == ENOENT) {
+		/* The file does not exist */
 		do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
+	} else {
+		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		retval = -1;
+		goto cleanup;
+	}
 	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
 		FILE *touch;
 		touch = fopen(path, "w");
@@ -1259,10 +1278,17 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Create or remove the preserve_tunables flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
-	if (access(path, F_OK) == 0)
+	if (stat(path, &sb) == 0)
 		do_rebuild |= !(sepol_get_preserve_tunables(sh->sepolh) == 1);
-	else
+	else if (errno == ENOENT) {
+		/* The file does not exist */
 		do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
+	} else {
+		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		retval = -1;
+		goto cleanup;
+	}
+
 	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
 		FILE *touch;
 		touch = fopen(path, "w");
@@ -1299,40 +1325,25 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * a rebuild.
 	 */
 	if (!do_rebuild) {
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
-		}
-
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
-		}
-
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
-		}
-
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
-		}
-
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
-		}
+		int files[] = {SEMANAGE_STORE_KERNEL,
+					   SEMANAGE_STORE_FC,
+					   SEMANAGE_STORE_SEUSERS,
+					   SEMANAGE_LINKED,
+					   SEMANAGE_SEUSERS_LINKED,
+					   SEMANAGE_USERS_EXTRA_LINKED};
+
+		for (i = 0; i < (int) sizeof(files); i++) {
+			path = semanage_path(SEMANAGE_TMP, files[i]);
+			if (stat(path, &sb) != 0) {
+				if (errno != ENOENT) {
+					ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+					retval = -1;
+					goto cleanup;
+				}
 
-		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
-		if (access(path, F_OK) != 0) {
-			do_rebuild = 1;
-			goto rebuild;
+				do_rebuild = 1;
+				goto rebuild;
+			}
 		}
 	}
 
@@ -1465,7 +1476,7 @@ rebuild:
 			goto cleanup;
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
-		if (access(path, F_OK) == 0) {
+		if (stat(path, &sb) == 0) {
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_STORE_SEUSERS),
@@ -1473,12 +1484,17 @@ rebuild:
 			if (retval < 0)
 				goto cleanup;
 			pseusers->dtable->drop_cache(pseusers->dbase);
-		} else {
+		} else if (errno == ENOENT) {
+			/* The file does not exist */
 			pseusers->dtable->clear(sh, pseusers->dbase);
+		} else {
+			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			retval = -1;
+			goto cleanup;
 		}
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
-		if (access(path, F_OK) == 0) {
+		if (stat(path, &sb) == 0) {
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_USERS_EXTRA),
@@ -1486,8 +1502,13 @@ rebuild:
 			if (retval < 0)
 				goto cleanup;
 			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
-		} else {
+		} else if (errno == ENOENT) {
+			/* The file does not exist */
 			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+		} else {
+			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			retval = -1;
+			goto cleanup;
 		}
 	}
 
@@ -1817,6 +1838,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 	ssize_t _data_len;
 	char *_data;
 	int compressed;
+	struct stat sb;
 
 	/* get path of module */
 	rc = semanage_module_get_path(
@@ -1829,8 +1851,8 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (access(module_path, F_OK) != 0) {
-		ERR(sh, "Module does not exist: %s", module_path);
+	if (stat(module_path, &sb) != 0) {
+		ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
 		rc = -1;
 		goto cleanup;
 	}
@@ -1859,7 +1881,13 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && access(input_file, F_OK) != 0) {
+	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && stat(input_file, &sb) != 0) {
+		if (errno != ENOENT) {
+			ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
+			rc = -1;
+			goto cleanup;
+		}
+
 		rc = semanage_compile_module(sh, _modinfo);
 		if (rc < 0) {
 			goto cleanup;
@@ -2004,6 +2032,12 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
 	}
 
 	if (stat(path, &sb) < 0) {
+		if (errno != ENOENT) {
+			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			status = -1;
+			goto cleanup;
+		}
+
 		*enabled = 1;
 	}
 	else {
@@ -2330,6 +2364,12 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 
 	/* set enabled/disabled status */
 	if (stat(fn, &sb) < 0) {
+		if (errno != ENOENT) {
+			ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
+			status = -1;
+			goto cleanup;
+		}
+
 		ret = semanage_module_info_set_enabled(sh, *modinfo, 1);
 		if (ret != 0) {
 			status = -1;
@@ -2738,6 +2778,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 	int type;
+	struct stat sb;
 
 	char path[PATH_MAX];
 	mode_t mask = umask(0077);
@@ -2838,7 +2879,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
-		if (access(path, F_OK) == 0) {
+		if (stat(path, &sb) == 0) {
 			ret = unlink(path);
 			if (ret != 0) {
 				ERR(sh, "Error while removing cached CIL file %s: %s", path, strerror(errno));
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 4bd1d651..14ad99c1 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -514,6 +514,7 @@ char *semanage_conf_path(void)
 {
 	char *semanage_conf = NULL;
 	int len;
+	struct stat sb;
 
 	len = strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEMANAGE_CONF_FILE);
 	semanage_conf = calloc(len + 1, sizeof(char));
@@ -522,7 +523,7 @@ char *semanage_conf_path(void)
 	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_path(),
 		 SEMANAGE_CONF_FILE);
 
-	if (access(semanage_conf, R_OK) != 0) {
+	if (stat(semanage_conf, &sb) != 0 && errno == ENOENT) {
 		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CONF_FILE);
 	}
 
@@ -1508,8 +1509,14 @@ int semanage_split_fc(semanage_handle_t * sh)
 static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
 
 	int r;
+	struct stat sb;
+
+	if (stat(path, &sb) < 0) {
+		if (errno != ENOENT) {
+			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			return -1;
+		}
 
-	if (access(path, F_OK) != 0) {
 		return 0;
 	}
 
-- 
2.14.3
