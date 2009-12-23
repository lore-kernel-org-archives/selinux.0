From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 10/13] libsemanage: installing/upgrading/removing modules via info and key
Date: Wed, 23 Dec 2009 18:25:57 -0500
Message-Id: <1261610760-4724-11-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-10-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
 <1261610760-4724-8-git-send-email-ccase@tresys.com>
 <1261610760-4724-9-git-send-email-ccase@tresys.com>
 <1261610760-4724-10-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These functions install/upgrade/remove modules based on the module
info/key. The motivation for these interfaces is to provide the
additional information about a module (version, language, and enabled
status) at install time and also to separate the meta-data in
preparation for supporting source policies.

This patch combines the implementations of all the
install/upgrade/remove functions to use the
semanage_direct_install_info, semanage_direct_upgrade_info, and
semanage_direct_remove_key functions. The motivation here is to reduce
the amount of duplicate installation code (for example,
semanage_direct_install and semanage_direct_install_file have separate
but similar implementations).

With this patch the transition from the old store layout to the new one
is finished. This is accomplished mostly through the modification of
install functions and semanage_get_modules_names.
---
 libsemanage/src/direct_api.c     |  652 +++++++++++++++++++++++++++-----------
 libsemanage/src/modules.c        |   61 ++++
 libsemanage/src/modules.h        |   48 +++
 libsemanage/src/policy.h         |   15 +
 libsemanage/src/semanage_store.c |  177 ++++++++---
 libsemanage/src/semanage_store.h |    1 -
 6 files changed, 713 insertions(+), 241 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7964eaa..9bbe96d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -86,6 +86,19 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 				    semanage_module_info_t **modinfo,
 				    int *num_modules);
 
+static int semanage_direct_install_info(semanage_handle_t *sh,
+					const semanage_module_info_t *modinfo,
+					char *data,
+					size_t data_len);
+
+static int semanage_direct_upgrade_info(semanage_handle_t *sh,
+					const semanage_module_info_t *modinfo,
+					char *data,
+					size_t data_len);
+
+static int semanage_direct_remove_key(semanage_handle_t *sh,
+				      const semanage_module_key_t *modkey);
+
 static struct semanage_policy_table direct_funcs = {
 	.get_serial = semanage_direct_get_serial,
 	.destroy = semanage_direct_destroy,
@@ -104,6 +117,9 @@ static struct semanage_policy_table direct_funcs = {
 	.set_enabled = semanage_direct_set_enabled,
 	.get_module_info = semanage_direct_get_module_info,
 	.list_all = semanage_direct_list_all,
+	.install_info = semanage_direct_install_info,
+	.upgrade_info = semanage_direct_upgrade_info,
+	.remove_key = semanage_direct_remove_key,
 };
 
 int semanage_direct_is_managed(semanage_handle_t * sh)
@@ -358,21 +374,19 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
 /********************* utility functions *********************/
 
 /* Takes a module stored in 'module_data' and parses its headers.
- * Sets reference variables 'filename' to module's fully qualified
- * path name into the sandbox, 'module_name' to module's name, and
+ * Sets reference variables 'module_name' to module's name, and
  * 'version' to module's version.  The caller is responsible for
- * free()ing 'filename', 'module_name', and 'version'; they will be
+ * free()ing 'module_name', and 'version'; they will be
  * set to NULL upon entering this function.  Returns 0 on success, -1
  * if out of memory, or -2 if data did not represent a module.
  */
 static int parse_module_headers(semanage_handle_t * sh, char *module_data,
 				size_t data_len, char **module_name,
-				char **version, char **filename)
+				char **version)
 {
 	struct sepol_policy_file *pf;
 	int file_type;
-	const char *module_path;
-	*module_name = *version = *filename = NULL;
+	*module_name = *version = NULL;
 
 	if (sepol_policy_file_create(&pf)) {
 		ERR(sh, "Out of memory!");
@@ -397,14 +411,7 @@ static int parse_module_headers(semanage_handle_t * sh, char *module_data,
 			ERR(sh, "Data did not represent a module.");
 		return -2;
 	}
-	if ((module_path =
-	     semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES)) == NULL) {
-		return -1;
-	}
-	if (asprintf(filename, "%s/%s.pp", module_path, *module_name) == -1) {
-		ERR(sh, "Out of memory!");
-		return -1;
-	}
+
 	return 0;
 }
 
@@ -592,27 +599,6 @@ static ssize_t map_file(semanage_handle_t *sh, int fd, char **data,
 	return size;
 }
 
-static int dupfile( const char *dest, int src_fd) {
-	int dest_fd = -1;
-	int retval = 0;
-	int cnt;
-	char    buf[1<<18];
-
-	if (lseek(src_fd, 0, SEEK_SET)  == -1 ) return -1;
-
-	if ((dest_fd = open(dest, O_WRONLY | O_CREAT | O_TRUNC,
-			   S_IRUSR | S_IWUSR)) == -1) {
-		return -1;
-	}
-
-	while (( retval == 0 ) && 
-	       ( cnt = read(src_fd, buf, sizeof(buf)))> 0 ) {
-		if (write(dest_fd, buf, cnt) < cnt) retval = -1;
-	}
-	close(dest_fd);
-	return retval;
-}
-
 /* Writes a block of data to a file.  Returns 0 on success, -1 on
  * error. */
 static int write_file(semanage_handle_t * sh,
@@ -1074,25 +1060,61 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 static int semanage_direct_install(semanage_handle_t * sh,
 				   char *data, size_t data_len)
 {
+	int status = 0;
+	int ret = 0;
 
-	int retval;
-	char *module_name = NULL, *version = NULL, *filename = NULL;
-	if ((retval = parse_module_headers(sh, data, data_len,
-					   &module_name, &version,
-					   &filename)) != 0) {
+	char *module_name = NULL, *version = NULL;
+	if ((status = parse_module_headers(sh, data, data_len,
+					   &module_name, &version)) != 0) {
 		goto cleanup;
 	}
-	if (bzip(sh, filename, data, data_len) <= 0) {
-		ERR(sh, "Error while writing to %s.", filename);
-		retval = -3;
+
+	semanage_module_info_t modinfo;
+	ret = semanage_module_info_init(sh, &modinfo);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	retval = 0;
-      cleanup:
+
+	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_name(sh, &modinfo, module_name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_version(sh, &modinfo, version);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_enabled(sh, &modinfo, -1);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	status = semanage_direct_install_info(sh, &modinfo, data, data_len);
+
+cleanup:
 	free(version);
-	free(filename);
 	free(module_name);
-	return retval;
+
+	semanage_module_info_destroy(sh, &modinfo);
+
+	return status;
 }
 
 /* Attempts to link a module to the sandbox's module directory, unlinking any
@@ -1118,24 +1140,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		goto cleanup;
 	}
 		
-	if (compressed) {
-		char *module_name = NULL, *version = NULL, *filename = NULL;
-		if ((retval = parse_module_headers(sh, data, data_len,
-						   &module_name, &version,
-						   &filename)) != 0) {
-			goto cleanup;
-		}
-
-		if (data_len > 0) munmap(data, data_len);
-		data_len = 0;
-		retval = dupfile(filename, in_fd);
-		free(version);
-		free(filename);
-		free(module_name);
-
-	} else {
-		retval = semanage_direct_install(sh, data, data_len);
-	}
+	retval = semanage_direct_install(sh, data, data_len);
 
       cleanup:
 	close(in_fd);
@@ -1144,54 +1149,6 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	return retval;
 }
 
-
-static int get_direct_upgrade_filename(semanage_handle_t * sh,
-				       char *data, size_t data_len, char **outfilename) {
-	int i, retval, num_modules = 0;
-	char *module_name = NULL, *version = NULL, *filename = NULL;
-	semanage_module_info_t *modinfo = NULL;
-	if ((retval = parse_module_headers(sh, data, data_len,
-					   &module_name, &version,
-					   &filename)) != 0) {
-		goto cleanup;
-	}
-	if (semanage_direct_list(sh, &modinfo, &num_modules) < 0) {
-		goto cleanup;
-	}
-	retval = -5;
-	for (i = 0; i < num_modules; i++) {
-		semanage_module_info_t *m =
-		    semanage_module_list_nth(modinfo, i);
-		if (strcmp(semanage_module_get_name(m), module_name) == 0) {
-			if (strverscmp(version, semanage_module_get_version(m))
-			    > 0) {
-				retval = 0;
-				break;
-			} else {
-				ERR(sh, "Previous module %s is same or newer.",
-				    module_name);
-				retval = -4;
-				goto cleanup;
-			}
-		}
-	}
-      cleanup:
-	free(version);
-	free(module_name);
-	for (i = 0; modinfo != NULL && i < num_modules; i++) {
-		semanage_module_info_t *m =
-		    semanage_module_list_nth(modinfo, i);
-		semanage_module_info_datum_destroy(m);
-	}
-	free(modinfo);
-	if (retval == 0) {
-		*outfilename = filename;
-	} else {
-		free(filename);
-	}
-	return retval;
-}
-
 /* Similar to semanage_direct_install(), except that it checks that
  * there already exists a module with the same name and that the
  * module is an older version then the one in 'data'.  Returns 0 on
@@ -1203,18 +1160,64 @@ static int get_direct_upgrade_filename(semanage_handle_t * sh,
 static int semanage_direct_upgrade(semanage_handle_t * sh,
 				   char *data, size_t data_len)
 {
-	char *filename = NULL;
-	int retval = get_direct_upgrade_filename(sh,
-						 data, data_len, 
-						 &filename);
-	if (retval == 0) {
-		if (bzip(sh, filename, data, data_len) <= 0) {
-			ERR(sh, "Error while writing to %s.", filename);
-			retval = -3;
-		}
-		free(filename);
+	int status = 0;
+	int ret = 0;
+
+	char *module_name = NULL, *version = NULL;
+	status = parse_module_headers(
+			sh,
+			data,
+			data_len,
+			&module_name,
+			&version);
+	if (status != 0) {
+		goto cleanup;
 	}
-	return retval;
+
+	semanage_module_info_t modinfo;
+	ret = semanage_module_info_init(sh, &modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_name(sh, &modinfo, module_name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_version(sh, &modinfo, version);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_enabled(sh, &modinfo, -1);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	status = semanage_direct_upgrade_info(sh, &modinfo, data, data_len);
+
+cleanup:
+	free(module_name);
+	free(version);
+
+	return status;
 }
 
 /* Attempts to link a module to the sandbox's module directory, unlinking any
@@ -1240,19 +1243,7 @@ static int semanage_direct_upgrade_file(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (compressed) {
-		char *filename = NULL;
-		retval = get_direct_upgrade_filename(sh,
-					 	     data, data_len, 
-						     &filename);
-		
-		if (retval != 0)  goto cleanup;
-
-		retval = dupfile(filename, in_fd);
-		free(filename);
-	} else {
-		retval = semanage_direct_upgrade(sh, data, data_len);
-	}
+	retval = semanage_direct_upgrade(sh, data, data_len);
 
       cleanup:
 	close(in_fd);
@@ -1270,22 +1261,62 @@ static int semanage_direct_upgrade_file(semanage_handle_t * sh,
 static int semanage_direct_install_base(semanage_handle_t * sh,
 					char *base_data, size_t data_len)
 {
-	int retval = -1;
-	const char *filename = NULL;
-	if ((retval = parse_base_headers(sh, base_data, data_len)) != 0) {
+	int status = 0;
+	int ret = 0;
+
+	ret = parse_base_headers(sh, base_data, data_len);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+
+	semanage_module_info_t modinfo;
+	ret = semanage_module_info_init(sh, &modinfo);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	if (bzip(sh, filename, base_data, data_len) <= 0) {
-		ERR(sh, "Error while writing to %s.", filename);
-		retval = -3;
+
+	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	retval = 0;
-      cleanup:
-	return retval;
+
+	ret = semanage_module_info_set_name(sh, &modinfo, "_base");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_version(sh, &modinfo, "1.0.0");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_enabled(sh, &modinfo, 1);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	status = semanage_direct_install_info(
+			sh,
+			&modinfo,
+			base_data,
+			data_len);
+
+cleanup:
+	semanage_module_info_destroy(sh, &modinfo);
+
+	return status;
 }
 
 /* Writes a base module into a sandbox, overwriting any previous base
@@ -1310,19 +1341,7 @@ static int semanage_direct_install_base_file(semanage_handle_t * sh,
 		goto cleanup;
 	}
 		
-	if (compressed) {
-		const char *filename = NULL;
-		if ((retval = parse_base_headers(sh, data, data_len)) != 0) {
-			goto cleanup;
-		}
-		if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
-			goto cleanup;
-		}
-
-		retval = dupfile(filename, in_fd);
-	} else {
-		retval = semanage_direct_install_base(sh, data, data_len);
-	}
+	retval = semanage_direct_install_base(sh, data, data_len);
 
       cleanup:
 	close(in_fd);
@@ -1335,41 +1354,32 @@ static int semanage_direct_install_base_file(semanage_handle_t * sh,
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
 {
-	int i, retval = -1;
-	char **module_filenames = NULL;
-	int num_mod_files;
-	size_t name_len = strlen(module_name);
-	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
-	    -1) {
-		return -1;
+	int status = 0;
+	int ret = 0;
+
+	semanage_module_key_t modkey;
+	ret = semanage_module_key_init(sh, &modkey);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
 	}
-	for (i = 0; i < num_mod_files; i++) {
-		char *base = strrchr(module_filenames[i], '/');
-		if (base == NULL) {
-			ERR(sh, "Could not read module names.");
-			retval = -2;
-			goto cleanup;
-		}
-		base++;
-		if (memcmp(module_name, base, name_len) == 0 &&
-		    strcmp(base + name_len, ".pp") == 0) {
-			if (unlink(module_filenames[i]) == -1) {
-				ERR(sh, "Could not remove module file %s.",
-				    module_filenames[i]);
-				retval = -2;
-			}
-			retval = 0;
-			goto cleanup;
-		}
+
+	ret = semanage_module_key_set_priority(sh, &modkey, sh->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
 	}
-	ERR(sh, "Module %s was not found.", module_name);
-	retval = -2;		/* module not found */
-      cleanup:
-	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
-		free(module_filenames[i]);
+
+	ret = semanage_module_key_set_name(sh, &modkey, module_name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
 	}
-	free(module_filenames);
-	return retval;
+
+	status = semanage_direct_remove_key(sh, &modkey);
+
+cleanup:
+	return status;
 }
 
 /* Allocate an array of module_info structures for each readable
@@ -1930,7 +1940,6 @@ cleanup:
 	return status;
 }
 
-__attribute__ ((unused))
 static int semanage_direct_set_module_info(semanage_handle_t *sh,
 					   const semanage_module_info_t *modinfo)
 {
@@ -2385,3 +2394,260 @@ cleanup:
 
 	return status;
 }
+
+static int semanage_direct_install_info(semanage_handle_t *sh,
+					const semanage_module_info_t *modinfo,
+					char *data,
+					size_t data_len)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(data);
+
+	int status = 0;
+	int ret = 0;
+
+	char path[PATH_MAX];
+
+	semanage_module_info_t *higher_info = NULL;
+	semanage_module_key_t higher_key;
+	ret = semanage_module_key_init(sh, &higher_key);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* validate module info */
+	ret = semanage_module_info_validate(modinfo);
+	if (ret != 0) {
+		status = -2;
+		goto cleanup;
+	}
+
+	/* Check for higher priority module and warn if there is one as
+	 * it will override the module currently being installed.
+	 */
+	ret = semanage_module_key_set_name(sh, &higher_key, modinfo->name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_direct_get_module_info(sh, &higher_key, &higher_info);
+	if (ret == 0) {
+		if (higher_info->priority > modinfo->priority) {
+			errno = 0;
+			WARN(sh,
+			     "A higher priority %s module exists at priority %d and will override the module currently being installed at priority %d.",
+			     modinfo->name,
+			     higher_info->priority,
+			     modinfo->priority);
+		}
+		else if (higher_info->priority < modinfo->priority) {
+			errno = 0;
+			INFO(sh,
+			     "Overriding %s module at lower priority %d with module at priority %d.",
+			     modinfo->name,
+			     higher_info->priority,
+			     modinfo->priority);
+		}
+
+		if (higher_info->enabled == 0 && modinfo->enabled == -1) {
+			errno = 0;
+			WARN(sh,
+			     "%s module will be disabled after install due to default enabled status.",
+			     modinfo->name);
+		}
+	}
+
+	/* set module meta data */
+	ret = semanage_direct_set_module_info(sh, modinfo);
+	if (ret != 0) {
+		status = -2;
+		goto cleanup;
+	}
+
+	/* install module source file */
+	ret = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_HLL,
+			path,
+			sizeof(path));
+	if (ret != 0) {
+		status = -3;
+		goto cleanup;
+	}
+	
+	ret = bzip(sh, path, data, data_len);
+	if (ret <= 0) {
+		ERR(sh, "Error while writing to %s.", path);
+		status = -3;
+		goto cleanup;
+	}
+
+cleanup:
+	semanage_module_key_destroy(sh, &higher_key);
+	semanage_module_info_destroy(sh, higher_info);
+	free(higher_info);
+
+	return status;
+}
+
+static int semanage_direct_upgrade_info(semanage_handle_t *sh,
+					const semanage_module_info_t *modinfo,
+					char *data,
+					size_t data_len)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(data);
+
+	int status = 0;
+	int ret = 0;
+
+	semanage_module_info_t *existing = NULL;
+
+	/* get existing module data */
+	ret = semanage_direct_get_module_info(
+			sh,
+			(const semanage_module_key_t *)modinfo,
+			&existing);
+	if (ret == 0) {
+		/* verify this is an upgrade */
+		ret = strverscmp(existing->version, modinfo->version);
+		if (ret >= 0) {
+			ERR(sh,
+			    "Existing module %s version %s >= %s.",
+			    existing->name,
+			    existing->version,
+			    modinfo->version);
+			status = -4;
+			goto cleanup;
+		}
+	}
+
+	/* install the module */
+	status = semanage_direct_install_info(sh, modinfo, data, data_len);
+
+cleanup:
+	semanage_module_info_destroy(sh, existing);
+	free(existing);
+
+	return status;
+}
+
+static int semanage_direct_remove_key(semanage_handle_t *sh,
+				      const semanage_module_key_t *modkey)
+{
+	assert(sh);
+	assert(modkey);
+
+	int status = 0;
+	int ret = 0;
+
+	char path[PATH_MAX];
+	semanage_module_info_t *modinfo = NULL;
+
+	semanage_module_key_t modkey_tmp;
+	ret = semanage_module_key_init(sh, &modkey_tmp);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* validate module key */
+	ret = semanage_module_validate_priority(modkey->priority);
+	if (ret != 0) {
+		errno = 0;
+		ERR(sh, "Priority %d is invalid.", modkey->priority);
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_validate_name(modkey->name);
+	if (ret != 0) {
+		errno = 0;
+		ERR(sh, "Name %s is invalid.", modkey->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_key_set_name(sh, &modkey_tmp, modkey->name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get module path */
+	ret = semanage_module_get_path(
+			sh,
+			(const semanage_module_info_t *)modkey,
+			SEMANAGE_MODULE_PATH_NAME,
+			path,
+			sizeof(path));
+	if (ret != 0) {
+		status = -2;
+		goto cleanup;
+	}
+
+	/* remove directory */
+	ret = semanage_remove_directory(path);
+	if (ret != 0) {
+		ERR(sh, "Unable to remove module directory %s.", path);
+		status = -2;
+		goto cleanup;
+	}
+
+	/* check if its the last module at any priority */
+	ret = semanage_module_get_module_info(sh, &modkey_tmp, &modinfo);
+	if (ret != 0) {
+		/* info that no other module will override */
+		errno = 0;
+		INFO(sh,
+		     "Removing last %s module (no other %s module exists at another priority).",
+		     modkey->name,
+		     modkey->name);
+
+		/* remove disabled status file */
+		ret = semanage_module_get_path(
+				sh,
+				(const semanage_module_info_t *)modkey,
+				SEMANAGE_MODULE_PATH_DISABLED,
+				path,
+				sizeof(path));
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		struct stat sb;
+		if (stat(path, &sb) == 0) {
+			ret = unlink(path);
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+		}
+	}
+	else {
+		/* if a lower priority module is going to become active */
+		if (modkey->priority > modinfo->priority) {
+			/* inform what the new active module will be */
+			errno = 0;
+			INFO(sh,
+			     "%s module at priority %d is now active.",
+			     modinfo->name,
+			     modinfo->priority);
+		}
+	}
+
+cleanup:
+	semanage_module_key_destroy(sh, &modkey_tmp);
+
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	return status;
+}
+
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 3f7b652..817da80 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -1111,3 +1111,64 @@ int semanage_module_list_all(semanage_handle_t *sh,
 	return sh->funcs->list_all(sh, modinfos, modinfos_len);
 }
 
+int semanage_module_install_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len)
+{
+	if (sh->funcs->install_info == NULL) {
+		ERR(sh,
+		    "No install info function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+	sh->modules_modified = 1;
+	return sh->funcs->install_info(sh, modinfo, data, data_len);
+}
+
+int semanage_module_upgrade_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len)
+{
+	if (sh->funcs->upgrade_info == NULL) {
+		ERR(sh,
+		    "No upgrade info function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+	sh->modules_modified = 1;
+	return sh->funcs->upgrade_info(sh, modinfo, data, data_len);
+}
+
+int semanage_module_remove_key(semanage_handle_t *sh,
+			       const semanage_module_key_t *modkey)
+{
+	if (sh->funcs->remove_key== NULL) {
+		ERR(sh,
+		    "No remove key function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+	sh->modules_modified = 1;
+	return sh->funcs->remove_key(sh, modkey);
+}
+
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 8b5b9b8..7faead4 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -299,4 +299,52 @@ int semanage_module_list_all(semanage_handle_t *sh,
 			     semanage_module_info_t **modinfos,
 			     int *modinfos_len);
 
+/* Install the module indicated by @modinfo with input data from 
+ * @module_data with length @data_len.
+ *
+ * @modinfo must have all values filled in.
+ * @module_data may be bzip compressed.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, invalid @modinfo
+ *	-3	failure, error writing file
+ */
+int semanage_module_install_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len);
+
+/* Upgrade the module indicated by @modinfo with input data from
+ * @module_data with length @data_len.
+ *
+ * If the module is not already installed, then this will install it.
+ *
+ * @modinfo must have all values filled in.
+ * @module_data may be bzip compressed.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, invalid @modinfo
+ *	-3	failure, error writing file
+ *	-4	failure, same or newer version module exists
+ */
+int semanage_module_upgrade_info(semanage_handle_t *sh,
+				 const semanage_module_info_t *modinfo,
+				 char *data,
+				 size_t data_len);
+
+/* Remove the module indicated by @modkey.
+ * @modkey must have key values filled in.
+ *
+ * Returns:
+ * 	 0	success
+ *	-1	failure, out of memeory
+ *	-2	failure, @module not found or couldn't be removed
+ */
+int semanage_module_remove_key(semanage_handle_t *sh,
+			       const semanage_module_key_t *modkey);
+
 #endif
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index d232ba8..397863f 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -91,6 +91,21 @@ struct semanage_policy_table {
 			 semanage_module_info_t **,
 			 int *);
 
+	/* Install via module info */
+	int (*install_info) (struct semanage_handle *,
+			     const semanage_module_info_t *,
+			     char *,
+			     size_t);
+
+	/* Upgrade via module info */
+	int (*upgrade_info) (struct semanage_handle *,
+			     const semanage_module_info_t *,
+			     char *,
+			     size_t);
+
+	/* Remove via module key */
+	int (*remove_key) (struct semanage_handle *,
+			   const semanage_module_key_t *);
 };
 
 /* Should be backend independent */
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 6b4c2e0..4ac5b5b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -55,8 +55,10 @@ typedef struct dbase_policydb dbase_t;
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
+#include <libgen.h>
 
 #include "debug.h"
+#include "utilities.h"
 
 #define SEMANAGE_CONF_FILE "semanage.conf"
 /* relative path names to enum semanage_paths to special files and
@@ -94,7 +96,6 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
 static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"",
 	"/modules",
-	"/base.pp",
 	"/base.linked",
 	"/homedir_template",
 	"/file_contexts.template",
@@ -988,6 +989,29 @@ cleanup:
 	return status;
 }
 
+/* qsort comparison function for semanage_get_modules_names. */
+static int semanage_get_modules_names_cmp(const void *a, const void *b)
+{
+	const char *aa = *(const char **)a;
+	const char *bb = *(const char **)b;
+
+	/* copy into a buffer since basename/dirname can modify */
+	char ap[PATH_MAX];
+	char bp[PATH_MAX];
+
+	strncpy(ap, aa, sizeof(ap));
+	ap[PATH_MAX - 1] = '\0';
+
+	strncpy(bp, bb, sizeof(bp));
+	bp[PATH_MAX - 1] = '\0';
+
+	/* compare the module dir names */
+	const char *an = basename(dirname((char *)ap));
+	const char *bn = basename(dirname((char *)bp));
+
+	return strverscmp(an, bn);
+}
+
 /* Scans the modules directory for the current semanage handler.  This
  * might be the active directory or sandbox, depending upon if the
  * handler has a transaction lock.  Allocates and fills in *filenames
@@ -998,58 +1022,119 @@ cleanup:
 int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 			       int *len)
 {
-	const char *modules_path;
-	struct dirent **namelist = NULL;
-	int num_files, i, retval = -1;
+	assert(sh);
+	assert(filenames);
+	assert(len);
 
-	if (sh->is_in_transaction) {
-		modules_path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
-	} else {
-		modules_path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
-	}
+	int status = 0;
+	int ret = 0;
 
-	*filenames = NULL;
-	*len = 0;
-	if ((num_files = scandir(modules_path, &namelist,
-				 semanage_filename_select, alphasort)) == -1) {
-		ERR(sh, "Error while scanning directory %s.", modules_path);
-		goto cleanup;
-	}
-	if (num_files == 0) {
-		retval = 0;
+	int i = 0;
+	int j = 0;
+
+	semanage_list_t *list = NULL;
+	semanage_list_t *found = NULL;
+
+	semanage_module_info_t *modinfos = NULL;
+	int modinfos_len = 0;
+
+	char path[PATH_MAX];
+
+	void *tmp = NULL;
+
+	/* get all modules */
+	ret = semanage_module_list_all(sh, &modinfos, &modinfos_len);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	if ((*filenames =
-	     (char **)calloc(num_files, sizeof(**filenames))) == NULL) {
-		ERR(sh, "Out of memory!");
+
+	/* allocate enough for worst case */
+	(*filenames) = calloc(modinfos_len, sizeof(char *));
+	if ((*filenames) == NULL) {
+		ERR(sh, "Error allocating space for filenames.");
+		status = -1;
 		goto cleanup;
 	}
-	for (i = 0; i < num_files; i++) {
-		char *filename;
-		char path[PATH_MAX];
 
-		snprintf(path, PATH_MAX, "%s/%s", modules_path,
-			 namelist[i]->d_name);
-		if ((filename = strdup(path)) == NULL) {
-			int j;
-			ERR(sh, "Out of memory!");
-			for (j = 0; j < i; j++) {
-				free((*filenames)[j]);
+	*len = modinfos_len;
+
+	/* for each highest priority, non-base, enabled module get its path */
+	semanage_list_destroy(&list);
+	j = 0;
+	for (i = 0; i < modinfos_len; i++) {
+		/* check if base */
+		ret = strcmp(modinfos[i].name, "_base");
+		if (ret == 0) continue;
+
+		/* check if enabled */
+		if (modinfos[i].enabled != 1) continue;
+
+		/* check if we've seen this before (i.e. highest priority) */
+		found = semanage_list_find(list, modinfos[i].name);
+		if (found == NULL) {
+			ret = semanage_list_push(&list, modinfos[i].name);
+			if (ret != 0) {
+				ERR(sh, "Failed to add module name to list of known names.");
+				status = -1;
+				goto cleanup;
 			}
-			free(*filenames);
-			*filenames = NULL;
+		}
+		else continue;
+
+		ret = semanage_module_get_path(
+				sh,
+				&modinfos[i],
+				SEMANAGE_MODULE_PATH_HLL,
+				path,
+				sizeof(path));
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		(*filenames)[j] = strdup(path);
+		if ((*filenames)[j] == NULL) {
+			status = -1;
 			goto cleanup;
 		}
-		(*filenames)[i] = filename;
+
+		j += 1;
 	}
-	*len = num_files;
-	retval = 0;
-      cleanup:
-	for (i = 0; i < num_files; i++) {
-		free(namelist[i]);
+
+	/* realloc the array to its min size */
+	tmp = realloc(*filenames, j * sizeof(char *));
+	if (tmp == NULL) {
+		ERR(sh, "Error allocating space for filenames.");
+		status = -1;
+		goto cleanup;
 	}
-	free(namelist);
-	return retval;
+	*filenames = tmp;
+	*len = j;
+
+	/* sort array on module name */
+	qsort(*filenames,
+	      *len,
+	      sizeof(char *),
+	      semanage_get_modules_names_cmp);
+
+cleanup:
+	semanage_list_destroy(&list);
+
+	for (i = 0; i < modinfos_len; i++) {
+		semanage_module_info_destroy(sh, &modinfos[i]);
+	}
+	free(modinfos);
+
+	if (status != 0) {
+		for (i = 0; i < j; j++) {
+			free((*filenames)[i]);
+		}
+
+		free(*filenames);
+	}
+
+	return status;
 }
 
 /******************* routines that run external programs *******************/
@@ -1899,7 +1984,7 @@ static int semanage_load_module(semanage_handle_t * sh, const char *filename,
 int semanage_link_sandbox(semanage_handle_t * sh,
 			  sepol_module_package_t ** base)
 {
-	const char *base_filename = NULL;
+	char base_filename[PATH_MAX];
 	char **module_filenames = NULL;
 	int retval = -1, i;
 	int num_modules = 0;
@@ -1908,8 +1993,7 @@ int semanage_link_sandbox(semanage_handle_t * sh,
 	*base = NULL;
 
 	/* first make sure that base module is readable */
-	if ((base_filename =
-	     semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+	if (semanage_base_path(sh, base_filename, sizeof(base_filename)) != 0) {
 		goto cleanup;
 	}
 	if (access(base_filename, R_OK) == -1) {
@@ -1963,14 +2047,13 @@ int semanage_link_sandbox(semanage_handle_t * sh,
 int semanage_link_base(semanage_handle_t * sh,
 			  sepol_module_package_t ** base)
 {
-	const char *base_filename = NULL;
+	char base_filename[PATH_MAX];
 	int retval = -1;
 
 	*base = NULL;
 
 	/* first make sure that base module is readable */
-	if ((base_filename =
-	     semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+	if (semanage_base_path(sh, base_filename, sizeof(base_filename)) != 0) {
 		goto cleanup;
 	}
 	if (access(base_filename, R_OK) == -1) {
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index c6711ce..16148ef 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -39,7 +39,6 @@ enum semanage_store_defs {
 enum semanage_sandbox_defs {
 	SEMANAGE_TOPLEVEL,
 	SEMANAGE_MODULES,
-	SEMANAGE_BASE,
 	SEMANAGE_LINKED,
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
