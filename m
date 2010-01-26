From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 07/15] [src-policy] libsemanage: compile common intermediary language
Date: Tue, 26 Jan 2010 17:08:13 -0500
Message-Id: <1264543701-20638-8-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-7-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

During the commit process semanage_compile_cil is called to create the
binary base module from the installed active refpol modules. The
intermediate language compiler is called with each refpol module as an
argument. The compiler is expected to output the binary base module on
stdout and compilation messages to stderr. The compilation messages are
stored in /var/lib/selinux/.../modules/log.
---
 libsemanage/src/direct_api.c     |   15 +-
 libsemanage/src/semanage_store.c |  520 ++++++++++++++++----------------------
 libsemanage/src/semanage_store.h |   28 +--
 3 files changed, 241 insertions(+), 322 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 61e5b92..0623497 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -800,9 +800,11 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		retval = semanage_verify_modules(sh, mod_filenames, num_modfiles);
 		if (retval < 0)
 			goto cleanup;
-		retval = semanage_link_sandbox(sh, &base);
-		if (retval < 0)
+		retval = semanage_compile_cil(sh, &base);
+		if (retval != 0) {
+			retval = -1;
 			goto cleanup;
+		}
 
 		/* write the linked base if we want to save or we have a
 		 * verification program that wants it. */
@@ -938,9 +940,11 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			goto cleanup;
 		
 		if (seusers_modified || users_extra_modified) {
-			retval = semanage_link_base(sh, &base);
-			if (retval < 0)
+			retval = semanage_compile_cil(sh, &base);
+			if (retval != 0) {
+				retval = -1;
 				goto cleanup;
+			}
 
 			if (seusers_modified) {
 				retval = semanage_direct_update_seuser(sh, base );
@@ -2166,7 +2170,8 @@ cleanup:
 static int semanage_priorities_filename_select(const struct dirent *d)
 {
 	if (d->d_name[0] == '.' ||
-	    strcmp(d->d_name, "disabled") == 0)
+	    strcmp(d->d_name, "disabled") == 0 ||
+	    strcmp(d->d_name, "log") == 0)
 		return 0;
 	return 1;
 }
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index dd96a75..a714d1e 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -110,6 +110,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/users_extra",
 	"/disable_dontaudit",
 	"/modules/disabled",
+	"/modules/log",
 };
 
 static char const * const semanage_final_prefix[SEMANAGE_FINAL_NUM] = {
@@ -501,65 +502,13 @@ const char *semanage_lang_conf_path(void)
 	return "/etc/selinux/language.d";
 }
 
-/* Locates the highest priority enabled base module
- * and fills @path in with that value. @path must be
- * pre-allocated with size @len.
- *
- * Returns 0 on success and -1 on error.
+/* Return a fully-qualified path + filename to the cil compiler. The
+ * caller must not alter the string returned (and hence why this
+ * function return type is const).
  */
-int semanage_base_path(semanage_handle_t *sh,
-		       char *path,
-		       size_t len)
+static const char *semanage_cil_path(void)
 {
-	assert(sh);
-	assert(path);
-
-	int status = 0;
-	int ret = 0;
-
-	semanage_module_info_t *base = NULL;
-
-	/* set key for getting base module */
-	semanage_module_key_t modkey;
-	ret = semanage_module_key_init(sh, &modkey);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_key_set_name(sh, &modkey, "_base");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	/* get highest priority base module */
-	ret = semanage_module_get_module_info(sh, &modkey, &base);
-	if (ret != 0) {
-		/* no base module found */
-		status = -1;
-		goto cleanup;
-	}
-
-	/* get the highest priority base module path */
-	ret = semanage_module_get_path(
-			sh,
-			base,
-			SEMANAGE_MODULE_PATH_HLL,
-			path,
-			len);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-cleanup:
-	semanage_module_key_destroy(sh, &modkey);
-
-	semanage_module_info_destroy(sh, base);
-	free(base);
-
-	return status;
+	return "/usr/bin/refpol_ilc";
 }
 
 /**************** functions that create module store ***************/
@@ -998,29 +947,6 @@ cleanup:
 	return status;
 }
 
-/* qsort comparison function for semanage_get_modules_names. */
-static int semanage_get_modules_names_cmp(const void *a, const void *b)
-{
-	const char *aa = *(const char **)a;
-	const char *bb = *(const char **)b;
-
-	/* copy into a buffer since basename/dirname can modify */
-	char ap[PATH_MAX];
-	char bp[PATH_MAX];
-
-	strncpy(ap, aa, sizeof(ap));
-	ap[PATH_MAX - 1] = '\0';
-
-	strncpy(bp, bb, sizeof(bp));
-	bp[PATH_MAX - 1] = '\0';
-
-	/* compare the module dir names */
-	const char *an = basename(dirname((char *)ap));
-	const char *bn = basename(dirname((char *)bp));
-
-	return strverscmp(an, bn);
-}
-
 /* Scans the modules directory for the current semanage handler.  This
  * might be the active directory or sandbox, depending upon if the
  * handler has a transaction lock.  Allocates and fills in *filenames
@@ -1038,27 +964,20 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 	int status = 0;
 	int ret = 0;
 
-	int i = 0;
-	int j = 0;
-
-	semanage_list_t *list = NULL;
-	semanage_list_t *found = NULL;
-
 	semanage_module_info_t *modinfos = NULL;
 	int modinfos_len = 0;
 
+	int i;
 	char path[PATH_MAX];
 
-	void *tmp = NULL;
-
 	/* get all modules */
-	ret = semanage_module_list_all(sh, &modinfos, &modinfos_len);
+	ret = semanage_module_list(sh, &modinfos, &modinfos_len);
 	if (ret != 0) {
 		status = -1;
 		goto cleanup;
 	}
 
-	/* allocate enough for worst case */
+	/* allocate space */
 	(*filenames) = calloc(modinfos_len, sizeof(char *));
 	if ((*filenames) == NULL) {
 		ERR(sh, "Error allocating space for filenames.");
@@ -1068,29 +987,7 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 
 	*len = modinfos_len;
 
-	/* for each highest priority, non-base, enabled module get its path */
-	semanage_list_destroy(&list);
-	j = 0;
 	for (i = 0; i < modinfos_len; i++) {
-		/* check if base */
-		ret = strcmp(modinfos[i].name, "_base");
-		if (ret == 0) continue;
-
-		/* check if enabled */
-		if (modinfos[i].enabled != 1) continue;
-
-		/* check if we've seen this before (i.e. highest priority) */
-		found = semanage_list_find(list, modinfos[i].name);
-		if (found == NULL) {
-			ret = semanage_list_push(&list, modinfos[i].name);
-			if (ret != 0) {
-				ERR(sh, "Failed to add module name to list of known names.");
-				status = -1;
-				goto cleanup;
-			}
-		}
-		else continue;
-
 		ret = semanage_module_get_path(
 				sh,
 				&modinfos[i],
@@ -1102,47 +999,26 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 			goto cleanup;
 		}
 
-		(*filenames)[j] = strdup(path);
-		if ((*filenames)[j] == NULL) {
+		(*filenames)[i] = strdup(path);
+		if ((*filenames)[i] == NULL) {
 			status = -1;
 			goto cleanup;
 		}
-
-		j += 1;
 	}
 
-	/* realloc the array to its min size */
-	tmp = realloc(*filenames, j * sizeof(char *));
-	if (tmp == NULL) {
-		ERR(sh, "Error allocating space for filenames.");
-		status = -1;
-		goto cleanup;
-	}
-	*filenames = tmp;
-	*len = j;
-
-	/* sort array on module name */
-	qsort(*filenames,
-	      *len,
-	      sizeof(char *),
-	      semanage_get_modules_names_cmp);
-
 cleanup:
-	semanage_list_destroy(&list);
-
-	for (i = 0; i < modinfos_len; i++) {
-		semanage_module_info_destroy(sh, &modinfos[i]);
-	}
-	free(modinfos);
-
 	if (status != 0) {
-		for (i = 0; i < j; j++) {
+		for (i = 0; i < *len; i++) {
 			free((*filenames)[i]);
 		}
-
 		free(*filenames);
 	}
 
+	for (i = 0; i < modinfos_len; i++) {
+		semanage_module_info_destroy(sh, &modinfos[i]);
+	}
+	free(modinfos);
+
 	return status;
 }
 
@@ -1921,166 +1797,6 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 
 /* HIGHER LEVEL COMMIT FUNCTIONS */
 
-/* Loads a module (or a base) from a fully-qualified 'filename' into a
- * newly allocated sepol_module_package_t structure and returns it in
- * '*package'.	Caller is responsible for destroying it afterwards via
- * sepol_module_package_destroy().  Returns 0 on success, -1 on error.
- */
-static int semanage_load_module(semanage_handle_t * sh, const char *filename,
-				sepol_module_package_t ** package)
-{
-	int retval = 0;
-	FILE *fp;
-	struct sepol_policy_file *pf = NULL;
-
-	*package = NULL;
-	if (sepol_module_package_create(package) == -1) {
-		ERR(sh, "Out of memory!");
-		return -1;
-	}
-
-	if (sepol_policy_file_create(&pf)) {
-		ERR(sh, "Out of memory!");
-		goto cleanup;
-	}
-
-	if ((fp = fopen(filename, "rb")) == NULL) {
-		ERR(sh, "Could not open module file %s for reading.", filename);
-		goto cleanup;
-	}
-	ssize_t size;
-	char *data = NULL;
-
-	if ((size = bunzip(sh, fp, &data)) > 0) {
-		fclose(fp);
-		fp = fmemopen(data, size, "rb");
-		if (!fp) {
-			ERR(sh, "Out of memory!");
-			goto cleanup;
-		}
-	}
-	rewind(fp);
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	sepol_policy_file_set_fp(pf, fp);
-	sepol_policy_file_set_handle(pf, sh->sepolh);
-	if (sepol_module_package_read(*package, pf, 0) == -1) {
-		ERR(sh, "Error while reading from module file %s.", filename);
-		fclose(fp);
-		free(data);
-		goto cleanup;
-	}
-	sepol_policy_file_free(pf);
-	fclose(fp);
-	free(data);
-	return retval;
-
-      cleanup:
-	sepol_module_package_free(*package);
-	*package = NULL;
-	sepol_policy_file_free(pf);
-	return -1;
-}
-
-/* Links all of the modules within the sandbox into the base module.
- * '*base' will point to the module package that contains everything
- * linked together (caller must call sepol_module_package_destroy() on
- * it afterwards).  '*mods' will be a list of module packages and
- * '*num_modules' will be the number of elements within '*mods'
- * (caller must destroy each element as well as the pointer itself.)
- * Both '*base' and '*mods' will be set to NULL upon entering this
- * function.  Returns 0 on success, -1 on error.
- */
-int semanage_link_sandbox(semanage_handle_t * sh,
-			  sepol_module_package_t ** base)
-{
-	char base_filename[PATH_MAX];
-	char **module_filenames = NULL;
-	int retval = -1, i;
-	int num_modules = 0;
-	sepol_module_package_t **mods = NULL;
-
-	*base = NULL;
-
-	/* first make sure that base module is readable */
-	if (semanage_base_path(sh, base_filename, sizeof(base_filename)) != 0) {
-		goto cleanup;
-	}
-	if (access(base_filename, R_OK) == -1) {
-		ERR(sh, "Could not access sandbox base file %s.",
-		    base_filename);
-		goto cleanup;
-	}
-
-	/* get list of modules and load them */
-	if (semanage_get_modules_names(sh, &module_filenames, &num_modules) ==
-	    -1 || semanage_load_module(sh, base_filename, base) == -1) {
-		goto cleanup;
-	}
-	if ((mods = calloc(num_modules, sizeof(*mods))) == NULL) {
-		ERR(sh, "Out of memory!");
-		num_modules = 0;
-		goto cleanup;
-	}
-	for (i = 0; i < num_modules; i++) {
-		if (semanage_load_module(sh, module_filenames[i], mods + i) ==
-		    -1) {
-			goto cleanup;
-		}
-	}
-
-	if (sepol_link_packages(sh->sepolh, *base, mods, num_modules, 0) != 0) {
-		ERR(sh, "Link packages failed");
-		goto cleanup;
-	}
-
-	retval = 0;
-
-      cleanup:
-	for (i = 0; module_filenames != NULL && i < num_modules; i++) {
-		free(module_filenames[i]);
-	}
-	free(module_filenames);
-	for (i = 0; mods != NULL && i < num_modules; i++) {
-		sepol_module_package_free(mods[i]);
-	}
-	free(mods);
-	return retval;
-}
-
-/* Links only the base module within the sandbox into the base module.
- * '*base' will point to the module package that contains everything
- * linked together (caller must call sepol_module_package_destroy() on
- * it afterwards).  '*base' will be set to NULL upon entering this
- * function.  Returns 0 on success, -1 on error.
- */
-int semanage_link_base(semanage_handle_t * sh,
-			  sepol_module_package_t ** base)
-{
-	char base_filename[PATH_MAX];
-	int retval = -1;
-
-	*base = NULL;
-
-	/* first make sure that base module is readable */
-	if (semanage_base_path(sh, base_filename, sizeof(base_filename)) != 0) {
-		goto cleanup;
-	}
-	if (access(base_filename, R_OK) == -1) {
-		ERR(sh, "Could not access sandbox base file %s.",
-		    base_filename);
-		goto cleanup;
-	}
-
-	if (semanage_load_module(sh, base_filename, base) == -1) {
-		goto cleanup;
-	}
-
-	retval = 0;
-
-      cleanup:
-	return retval;
-}
-
 /* 
  * Expands the policy contained within *base 
  */
@@ -3388,3 +3104,205 @@ cleanup:
 	return status;
 }
 
+/* Compiles all active modules into a base module.  This function
+ * assumes that the HLL has been compiled to the CIL during module
+ * install/upgrade. *base must be NULL.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, error outside CIL compiler
+ *	+N	failure, CIL compiler exit status
+ */
+int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
+{
+	assert(sh != NULL);
+	assert(base != NULL);
+	assert(*base == NULL);
+
+	int status = 0;
+	int ret = 0;
+
+	int io[3];
+	int io_len = 3;
+
+	int i = 0;
+	char path[PATH_MAX];
+	semanage_module_info_t *modinfos = NULL;
+	int modinfos_len = 0;
+
+	char **argv = NULL;
+
+	char tmp[] = "/tmp/libsemanage-XXXXXX";
+	FILE *fp = NULL;
+	struct sepol_policy_file *pf = NULL;
+
+	const char *cilc = semanage_cil_path();
+	const char *log = semanage_path(SEMANAGE_TMP, SEMANAGE_CIL_LOG);
+
+	char *data = NULL;
+	size_t data_len = 0;
+
+	/* setup io */
+
+	/* no stdin */
+	io[0] = -1;
+
+	/* stdout to temp (base module) */
+	io[1] = mkstemp(tmp);
+	if (io[1] < 0) {
+		ERR(sh, "Failed to create tmp file for base module %s.", tmp);
+		unlink(tmp);
+		status = -1;
+		goto cleanup;
+	}
+	unlink(tmp);
+
+	/* stderr to cil log */
+	io[2] = creat(log, S_IRUSR | S_IWUSR);
+	if (io[2] < 0) {
+		ERR(sh, "Failed to create log file %s", log);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get modinfos */
+	ret = semanage_module_list_all(sh, &modinfos, &modinfos_len);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* argv for module paths */
+	argv = calloc(modinfos_len + 2, sizeof(char *));
+	if (argv == NULL) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+
+	/* for each module */
+	for (i = 0; i < modinfos_len; i++) {
+		/* add module cil path to argv */
+		ret = semanage_module_get_path(sh,
+					       &modinfos[i],
+					       SEMANAGE_MODULE_PATH_CIL,
+					       path,
+					       sizeof(path));
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* if the module is disabled pass with -d */
+		if (modinfos[i].enabled == 1) {
+			argv[i + 1] = strdup(path);
+		}
+		else {
+			ret = asprintf(&argv[i + 1], "-d%s", path);
+			if (ret < 0) argv[i + 1] = NULL;
+		}
+
+		if (argv[i + 1] == NULL) {
+			ERR(sh, "Out of memory!");
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	argv[0] = strdup(cilc);
+	if (argv[0] == NULL) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+
+	/* exec cil compiler */
+	ret = semanage_exec(sh, cilc, argv, io, io_len);
+	if (ret != 0) {
+		status = ret;
+		if (status > 0) {
+			ret = fsync(io[2]);
+			if (ret != 0) {
+				WARN(sh, "Failed to sync log to disk!");
+			}
+			close(io[2]);
+
+			io[2] = open(log, O_RDONLY);
+			if (io[2] < 0) {
+				ERR(sh, "Failed to open log file.");
+				goto cleanup;
+			}
+
+			ret = semanage_fd_to_data(sh, io[2], &data, &data_len);
+			if (ret != 0) {
+				ERR(sh, "Failed to read log.");
+				goto cleanup;
+			}
+
+			ERR(sh, "%s\n", data);
+		}
+
+		goto cleanup;
+	}
+
+	/* load base module */
+	ret = sepol_module_package_create(base);
+	if (ret != 0) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = sepol_policy_file_create(&pf);
+	if (ret != 0) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = fdopen(io[1], "r");
+	if (fp == NULL) {
+		ERR(sh, "Failed to open tmp file for base module %s.", tmp);
+		status = -1;
+		goto cleanup;
+	}
+
+	rewind(fp);
+
+	sepol_policy_file_set_fp(pf, fp);
+	sepol_policy_file_set_handle(pf, sh->sepolh);
+
+	ret = sepol_module_package_read(*base, pf, 0);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) {
+		sepol_module_package_free(*base);
+		*base = NULL;
+	}
+
+	sepol_policy_file_free(pf);
+	if (fp != NULL) {
+		fclose(fp);
+		io[1] = -1;
+	}
+
+	free_argv(argv);
+
+	for (i = 0; i < modinfos_len; i++) {
+		semanage_module_info_destroy(sh, &modinfos[i]);
+	}
+	free(modinfos);
+
+	free(data);
+
+	for (i = 0; i < io_len; i++) {
+		if (io[i] >= 0) close(io[i]);
+	}
+
+	return status;
+}
+
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index f1b9675..c59bc69 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -53,6 +53,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_MODULES_DISABLED,
+	SEMANAGE_CIL_LOG,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
@@ -113,12 +114,6 @@ void semanage_release_trans_lock(semanage_handle_t * sh);
 void semanage_release_active_lock(semanage_handle_t * sh);
 int semanage_direct_get_serial(semanage_handle_t * sh);
 
-int semanage_link_sandbox(semanage_handle_t * sh,
-			  sepol_module_package_t ** base);
-
-int semanage_link_base(semanage_handle_t * sh,
-		       sepol_module_package_t ** base);
-
 int semanage_expand_sandbox(semanage_handle_t * sh,
 			    sepol_module_package_t * base,
 			    sepol_policydb_t ** policydb);
@@ -150,16 +145,6 @@ int semanage_nc_sort(semanage_handle_t * sh,
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
-/* Locates the highest priority enabled base module
- * and fills @path in with that value. @path must be
- * pre-allocated with size @len.
- *
- * Returns 0 on success and -1 on error.
- */
-int semanage_base_path(semanage_handle_t *sh,
-		       char *path,
-		       size_t len);
-
 /* Copy @fd into a the buffer @data with size @data_len.
  * On call @data will be set to NULL and @data_len to 0.
  * If @fd is bzip compressed, it will be uncompressed.
@@ -189,4 +174,15 @@ int semanage_fd_to_data(semanage_handle_t *sh,
 int semanage_compile_hll(semanage_handle_t *sh,
 			 const semanage_module_info_t *modinfo);
 
+/* Compiles all active modules into a base module.  This function
+ * assumes that the HLL has been compiled to the CIL during module
+ * install/upgrade. *base must be NULL.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, error outside CIL compiler
+ *	+N	failure, CIL compiler exit status
+ */
+int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base);
+
 #endif
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
