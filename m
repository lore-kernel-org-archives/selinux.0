Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QJG3YT024943
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 14:16:03 -0500
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libsemanage: Add option to remove HLL files after
 compilation
Date: Thu, 26 Feb 2015 14:15:59 -0500
Message-ID: <1424978160-4652-2-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This adds a 'remove-hll' option to semanage.conf. If set to 'true', all
HLL files will be removed from the SELinux store after successfully
buildling the SELinux modules. The default for this option is 'false'.

In order to delete already compiled HLL files, the modules need to be
recompiled with the ignore-module-cache option.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/man/man5/semanage.conf.5 | 13 ++++++
 libsemanage/src/conf-parse.y         | 15 +++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         | 91 ++++++++++++++++++++++++------------
 libsemanage/src/semanage_conf.h      |  1 +
 5 files changed, 89 insertions(+), 32 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index c76c89f..8f8de55 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -108,6 +108,19 @@ size value is obtained after multiplication by 100000).
 When set to "true", the bzip algorithm shall try to reduce its system memory usage. It can be set to either "true" or "false" and
 by default it is set to "false".
 
+.TP
+.B remove-hll
+When set to "true", HLL files will be removed after compilation into CIL. In order to delete HLL files already compiled into CIL,
+modules will need to be recompiled with the
+.BR ignore-module-cache
+option set to 'true' or using the
+.BR ignore-module-cache
+option with semodule. The remove-hll option can be set to either "true" or "false"
+and by default it is set to "false".
+
+Please note that since this option deletes all HLL files, an updated HLL compiler will not be able to recompile the original HLL file into CIL.
+In order to compile the original HLL file into CIL, the same HLL file will need to be reinstalled.
+
 .SH "SEE ALSO"
 .TP
 semanage(8)
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index df12530..a22f08d 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -60,7 +60,7 @@ static int parse_errors;
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
-%token BZIP_BLOCKSIZE BZIP_SMALL
+%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -93,6 +93,7 @@ single_opt:     module_store
         |       handle_unknown
 	|	bzip_blocksize
 	|	bzip_small
+	|	remove_hll
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -247,6 +248,17 @@ bzip_small:  BZIP_SMALL '=' ARG {
 	free($3);
 }
 
+remove_hll:  REMOVE_HLL'=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->remove_hll = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->remove_hll = 1;
+	} else {
+		yyerror("remove-hll can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -330,6 +342,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_blocksize = 9;
 	conf->bzip_small = 0;
 	conf->ignore_module_cache = 0;
+	conf->remove_hll = 0;
 
 	conf->save_previous = 0;
 	conf->save_linked = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 9b91d94..5414582 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -55,6 +55,7 @@ ignoredirs        return IGNOREDIRS;
 handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
+remove-hll	return REMOVE_HLL;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index be6bd3c..e631d7d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -849,6 +849,52 @@ cleanup:
 	return retval;
 }
 
+static int semanage_direct_write_langext(semanage_handle_t *sh,
+				char *lang_ext,
+				const semanage_module_info_t *modinfo)
+{
+	int ret = -1;
+	char fn[PATH_MAX];
+	FILE *fp = NULL;
+
+	ret = semanage_module_get_path(sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_LANG_EXT,
+			fn,
+			sizeof(fn));
+	if (ret != 0) {
+		goto cleanup;
+	}
+
+	fp = fopen(fn, "w");
+	if (fp == NULL) {
+		ERR(sh, "Unable to open %s module ext file.", modinfo->name);
+		ret = -1;
+		goto cleanup;
+	}
+
+	if (fputs(lang_ext, fp) < 0) {
+		ERR(sh, "Unable to write %s module ext file.", modinfo->name);
+		ret = -1;
+		goto cleanup;
+	}
+
+	if (fclose(fp) != 0) {
+		ERR(sh, "Unable to close %s module ext file.", modinfo->name);
+		ret = -1;
+		goto cleanup;
+	}
+
+	fp = NULL;
+
+	ret = 0;
+
+cleanup:
+	if (fp != NULL) fclose(fp);
+
+	return ret;
+}
+
 static int semanage_compile_hll(semanage_handle_t *sh,
 				semanage_module_info_t *modinfos,
 				int num_modinfos)
@@ -942,6 +988,19 @@ static int semanage_compile_hll(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
+		if (sh->conf->remove_hll == 1) {
+			status = unlink(hll_path);
+			if (status != 0) {
+				ERR(sh, "Error while removing HLL file %s: %s", hll_path, strerror(errno));
+				goto cleanup;
+			}
+
+			status = semanage_direct_write_langext(sh, "cil", &modinfos[i]);
+			if (status != 0) {
+				goto cleanup;
+			}
+		}
+
 		bzip_status = bzip(sh, cil_path, cil_data, cil_data_len);
 		if (bzip_status == -1) {
 			ERR(sh, "Failed to bzip %s\n", cil_path);
@@ -973,7 +1032,6 @@ cleanup:
 	return status;
 }
 
-
 /********************* direct API functions ********************/
 
 /* Commits all changes in sandbox to the actual kernel policy.
@@ -1915,7 +1973,6 @@ static int semanage_direct_set_module_info(semanage_handle_t *sh,
 
 	char fn[PATH_MAX];
 	const char *path = NULL;
-	FILE *fp = NULL;
 	int enabled = 0;
 
 	semanage_module_key_t modkey;
@@ -1988,38 +2045,12 @@ static int semanage_direct_set_module_info(semanage_handle_t *sh,
 	}
 
 	/* write ext */
-	ret = semanage_module_get_path(sh,
-				       modinfo,
-				       SEMANAGE_MODULE_PATH_LANG_EXT,
-				       fn,
-				       sizeof(fn));
+	ret = semanage_direct_write_langext(sh, modinfo->lang_ext, modinfo);
 	if (ret != 0) {
 		status = -1;
 		goto cleanup;
 	}
 
-	fp = fopen(fn, "w");
-
-	if (fp == NULL) {
-		ERR(sh, "Unable to open %s module ext file.", modinfo->name);
-		status = -1;
-		goto cleanup;
-	}
-
-	if (fputs(modinfo->lang_ext, fp) < 0) {
-		ERR(sh, "Unable to write %s module ext file.", modinfo->name);
-		status = -1;
-		goto cleanup;
-	}
-
-	if (fclose(fp) != 0) {
-		ERR(sh, "Unable to close %s module ext file.", modinfo->name);
-		status = -1;
-		goto cleanup;
-	}
-
-	fp = NULL;
-
 	/* write enabled/disabled status */
 
 	/* check for disabled path, create if missing */
@@ -2071,8 +2102,6 @@ static int semanage_direct_set_module_info(semanage_handle_t *sh,
 	}
 
 cleanup:
-	if (fp != NULL) fclose(fp);
-
 	semanage_module_key_destroy(sh, &modkey);
 
 	semanage_module_info_destroy(sh, modinfo_tmp);
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 0963cc8..c99ac8c 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -45,6 +45,7 @@ typedef struct semanage_conf {
 	mode_t file_mode;
 	int bzip_blocksize;
 	int bzip_small;
+	int remove_hll;
 	int ignore_module_cache;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
-- 
1.9.3
