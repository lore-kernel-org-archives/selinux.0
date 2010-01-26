From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 08/15] [src-policy] libsemanage: remove binary interfaces
Date: Tue, 26 Jan 2010 17:08:14 -0500
Message-Id: <1264543701-20638-9-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-8-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Supporting both binary policy packages and source modules is difficult
and leads to problems that are unacceptable. For instance, the binary
modules would lack relevant information for recompilation such as the
interface definition (which would lead to unexpected behavior if a
source module interface changes, but those changes don't appear in the
binary modules).  Consequently, we completely removed support for binary
modules, leaving only support for source modules. Also, because we are
now creating the base module automatically from the source modules, the
base module interfaces are removed as well.

This patch deprecates the following:

   semanage_module_install
   semanage_module_upgrade
   semanage_module_install_base
   semanage_module_intall_base_file

and removes their direct_api implementations.

For the sake of rendering meaningful error messages, the callbacks for
these functions have been initialized to NULL. This will result in an
error message indicating that the function is not implemented for the
given connection type. At a future time these functions would be removed
entirely.

The file related functions are updated to expect source modules:

   semanage_module_install_file
   semanage_module_upgrade_file
---
 libsemanage/include/semanage/modules.h |   14 +-
 libsemanage/src/direct_api.c           |  751 +++++++++++++-------------------
 2 files changed, 302 insertions(+), 463 deletions(-)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index e169279..8a26e6c 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -1,7 +1,7 @@
 /* Authors: Joshua Brindle  <jbrindle@tresys.com>
  *	    Jason Tang	    <jtang@tresys.com>
  *
- * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005,2010 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -29,17 +29,21 @@
  */
 
 int semanage_module_install(semanage_handle_t *,
-			    char *module_data, size_t data_len);
+			    char *module_data, size_t data_len)
+			    __attribute__ ((deprecated));
 int semanage_module_install_file(semanage_handle_t *,
 				 const char *module_name);
 int semanage_module_upgrade(semanage_handle_t *,
-			    char *module_data, size_t data_len);
+			    char *module_data, size_t data_len)
+			    __attribute__ ((deprecated));
 int semanage_module_upgrade_file(semanage_handle_t *,
 				 const char *module_name);
 int semanage_module_install_base(semanage_handle_t *,
-				 char *module_data, size_t data_len);
+				 char *module_data, size_t data_len)
+				 __attribute__ ((deprecated));
 int semanage_module_install_base_file(semanage_handle_t *,
-				      const char *module_name);
+				      const char *module_name)
+				      __attribute__ ((deprecated));
 int semanage_module_remove(semanage_handle_t *, char *module_name);
 
 /* semanage_module_info is for getting information on installed
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 0623497..6f7cf63 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -58,15 +58,8 @@ static void semanage_direct_destroy(semanage_handle_t * sh);
 static int semanage_direct_disconnect(semanage_handle_t * sh);
 static int semanage_direct_begintrans(semanage_handle_t * sh);
 static int semanage_direct_commit(semanage_handle_t * sh);
-static int semanage_direct_install(semanage_handle_t * sh, char *data,
-				   size_t data_len);
 static int semanage_direct_install_file(semanage_handle_t * sh, const char *module_name);
-static int semanage_direct_upgrade(semanage_handle_t * sh, char *data,
-				   size_t data_len);
 static int semanage_direct_upgrade_file(semanage_handle_t * sh, const char *module_name);
-static int semanage_direct_install_base(semanage_handle_t * sh, char *base_data,
-					size_t data_len);
-static int semanage_direct_install_base_file(semanage_handle_t * sh, const char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -105,12 +98,12 @@ static struct semanage_policy_table direct_funcs = {
 	.disconnect = semanage_direct_disconnect,
 	.begin_trans = semanage_direct_begintrans,
 	.commit = semanage_direct_commit,
-	.install = semanage_direct_install,
 	.install_file = semanage_direct_install_file,
-	.upgrade = semanage_direct_upgrade,
 	.upgrade_file = semanage_direct_upgrade_file,
-	.install_base = semanage_direct_install_base,
-	.install_base_file = semanage_direct_install_base_file,
+	.install = NULL,
+	.upgrade = NULL,
+	.install_base = NULL,
+	.install_base_file = NULL,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list,
 	.get_enabled = semanage_direct_get_enabled,
@@ -373,87 +366,6 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
 
 /********************* utility functions *********************/
 
-/* Takes a module stored in 'module_data' and parses its headers.
- * Sets reference variables 'module_name' to module's name, and
- * 'version' to module's version.  The caller is responsible for
- * free()ing 'module_name', and 'version'; they will be
- * set to NULL upon entering this function.  Returns 0 on success, -1
- * if out of memory, or -2 if data did not represent a module.
- */
-static int parse_module_headers(semanage_handle_t * sh, char *module_data,
-				size_t data_len, char **module_name,
-				char **version)
-{
-	struct sepol_policy_file *pf;
-	int file_type;
-	*module_name = *version = NULL;
-
-	if (sepol_policy_file_create(&pf)) {
-		ERR(sh, "Out of memory!");
-		return -1;
-	}
-	sepol_policy_file_set_mem(pf, module_data, data_len);
-	sepol_policy_file_set_handle(pf, sh->sepolh);
-	if (module_data == NULL ||
-	    data_len == 0 ||
-	    sepol_module_package_info(pf, &file_type, module_name,
-				      version) == -1) {
-		sepol_policy_file_free(pf);
-		ERR(sh, "Could not parse module data.");
-		return -2;
-	}
-	sepol_policy_file_free(pf);
-	if (file_type != SEPOL_POLICY_MOD) {
-		if (file_type == SEPOL_POLICY_BASE)
-			ERR(sh,
-			    "Received a base module, expected a non-base module.");
-		else
-			ERR(sh, "Data did not represent a module.");
-		return -2;
-	}
-
-	return 0;
-}
-
-/* Takes a base module stored in 'module_data' and parse its headers.
- * Returns 0 on success, -1 if out of memory, or -2 if data did not
- * represent a module.
- */
-static int parse_base_headers(semanage_handle_t * sh,
-			      char *module_data, size_t data_len)
-{
-	struct sepol_policy_file *pf;
-	char *module_name = NULL, *version = NULL;
-	int file_type;
-
-	if (sepol_policy_file_create(&pf)) {
-		ERR(sh, "Out of memory!");
-		return -1;
-	}
-	sepol_policy_file_set_mem(pf, module_data, data_len);
-	sepol_policy_file_set_handle(pf, sh->sepolh);
-	if (module_data == NULL ||
-	    data_len == 0 ||
-	    sepol_module_package_info(pf, &file_type,
-				      &module_name, &version) == -1) {
-		sepol_policy_file_free(pf);
-		ERR(sh, "Could not parse base module data.");
-		return -2;
-	}
-	sepol_policy_file_free(pf);
-	free(module_name);
-	free(version);
-	if (file_type != SEPOL_POLICY_BASE) {
-		if (file_type == SEPOL_POLICY_MOD)
-			ERR(sh,
-			    "Received a non-base module, expected a base module.");
-		else
-			ERR(sh, "Data did not represent a module.");
-		return -2;
-	}
-	return 0;
-}
-
 #include <stdlib.h>
 #include <bzlib.h>
 #include <string.h>
@@ -564,41 +476,6 @@ ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
 	return  total;
 }
 
-/* mmap() a file to '*data',
- *  If the file is bzip compressed map_file will uncompress 
- * the file into '*data'.
- * Returns the total number of bytes in memory .
- * Returns -1 if file could not be opened or mapped. */
-static ssize_t map_file(semanage_handle_t *sh, int fd, char **data,
-			int *compressed)
-{
-	ssize_t size = -1;
-	char *uncompress;
-	if ((size = bunzip(sh, fdopen(fd, "r"), &uncompress)) > 0) {
-		*data = mmap(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
-		if (*data == MAP_FAILED) {
-			free(uncompress);
-			return -1;
-		} else {
-			memcpy(*data, uncompress, size);
-		}
-		free(uncompress);
-		*compressed = 1;
-	} else {
-		struct stat sb;
-		if (fstat(fd, &sb) == -1 ||
-		    (*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
-		    MAP_FAILED) {
-			size = -1;
-		} else {
-			size = sb.st_size;
-		}
-		*compressed = 0;
-	} 
-
-	return size;
-}
-
 /* Writes a block of data to a file.  Returns 0 on success, -1 on
  * error. */
 static int write_file(semanage_handle_t * sh,
@@ -706,6 +583,169 @@ static int semanage_direct_update_seuser(semanage_handle_t * sh, sepol_module_pa
 	return retval;
 }
 
+/* Reads the source module pointed to by @path into a memory buffer
+ * @data of length @data_len. @modinfo is constructed with gleaned from
+ * the module path and defaults as follows:
+ *
+ * priority	default from handle
+ * name		basename(path) sans extension
+ * version	empty string (gets overridden by hll compiler)
+ * lang_ext	basename(path) sans name and '.'
+ * enabled	default of -1 (don't change status)
+ * 
+ * On call @modinfo and @data will be set to NULL. @data_len will be set
+ * to 0.
+ *
+ * Caller should destroy and free @modinfo and free @data.
+ *
+ * Returns:
+ *
+ * 	 0	success
+ * 	-1	failure, out of memory
+ * 	-2	failure, invalid @path
+ */
+static int semanage_path_to_info(semanage_handle_t *sh,
+				 const char *path,
+				 semanage_module_info_t **modinfo,
+				 char **data,
+				 size_t *data_len)
+{
+	assert(sh);
+	assert(path);
+	assert(modinfo);
+	assert(data);
+	assert(data_len);
+
+	int status = 0;
+	int ret = 0;
+
+	int fd = -1;
+	char *path_tmp = NULL;
+	char *name = NULL;
+	int i;
+	char *ext = NULL;
+
+	*modinfo = NULL;
+
+	/* Open the module. */
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		ERR(sh, "Failed to open file %s.", path);
+		status = -2;
+		goto cleanup;
+	}
+
+	/* Convert to buffer. */
+	ret = semanage_fd_to_data(sh, fd, data, data_len);
+	if (ret != 0) {
+		status = ret;
+		goto cleanup;
+	}
+
+	/* Get the name and ext from the path.
+	 * name will be the first part of the string.
+	 * ext will be the last part.
+	 * Note that neither should be free'd.
+	 * strduping here since basename can modify.
+	 */
+	path_tmp = strdup(path);
+	if (path_tmp == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	name = basename(path_tmp);
+	for (i = strlen(name) - 1; i >= 1; i--) {
+		if (name[i] == '.') {
+			name[i] = '\0';
+			ext = &name[i] + 1;
+			break;
+		}
+	}
+
+	/* Failed to find an ext or name begins with '.'. */
+	if (i == 0) {
+		status = -2;
+		goto cleanup;
+	}
+
+	/* Create and initialize a modinfo. */
+	ret = semanage_module_info_create(sh, modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_priority(
+			sh,
+			*modinfo,
+			sh->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_name(
+			sh,
+			*modinfo,
+			name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Initialize version to 0.
+	 * The module version will changed later by the hll compiler.
+	 */
+	ret = semanage_module_info_set_version(
+			sh,
+			*modinfo,
+			"0");
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(
+			sh,
+			*modinfo,
+			ext);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Set enabled to the default -1 value. This means that
+	 * installing the module will not modify the enabled/disabled
+	 * status.
+	 */
+	ret = semanage_module_info_set_enabled(
+			sh,
+			*modinfo,
+			-1);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) {
+		semanage_module_info_destroy(sh, *modinfo);
+		free(*modinfo);
+		*modinfo = NULL;
+
+		free(*data);
+		*data = NULL;
+		*data_len = 0;
+	}
+
+	free(path_tmp);
+
+	close(fd);
+
+	return status;
+}
+
 /********************* direct API functions ********************/
 
 /* Commits all changes in sandbox to the actual kernel policy.
@@ -1055,72 +1095,6 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	return retval;
 }
 
-/* Writes a module to the sandbox's module directory, overwriting any
- * previous module stored within.  Note that module data are not
- * free()d by this function; caller is responsible for deallocating it
- * if necessary.  Returns 0 on success, -1 if out of memory, -2 if the
- * data does not represent a valid module file, -3 if error while
- * writing file. */
-static int semanage_direct_install(semanage_handle_t * sh,
-				   char *data, size_t data_len)
-{
-	int status = 0;
-	int ret = 0;
-
-	char *module_name = NULL, *version = NULL;
-	if ((status = parse_module_headers(sh, data, data_len,
-					   &module_name, &version)) != 0) {
-		goto cleanup;
-	}
-
-	semanage_module_info_t modinfo;
-	ret = semanage_module_info_init(sh, &modinfo);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_name(sh, &modinfo, module_name);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_version(sh, &modinfo, version);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_enabled(sh, &modinfo, -1);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	status = semanage_direct_install_info(sh, &modinfo, data, data_len);
-
-cleanup:
-	free(version);
-	free(module_name);
-
-	semanage_module_info_destroy(sh, &modinfo);
-
-	return status;
-}
-
 /* Attempts to link a module to the sandbox's module directory, unlinking any
  * previous module stored within.  Returns 0 on success, -1 if out of memory, -2 if the
  * data does not represent a valid module file, -3 if error while
@@ -1129,97 +1103,31 @@ cleanup:
 static int semanage_direct_install_file(semanage_handle_t * sh,
 					const char *install_filename)
 {
+	int status = 0;
 
-	int retval = -1;
+	semanage_module_info_t *modinfo = NULL;
 	char *data = NULL;
-	ssize_t data_len = 0;
-	int compressed = 0;
-	int in_fd = -1;
-
-	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
-		return -1;
-	}
-
-	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
-		goto cleanup;
-	}
-		
-	retval = semanage_direct_install(sh, data, data_len);
-
-      cleanup:
-	close(in_fd);
-	if (data_len > 0) munmap(data, data_len);
-
-	return retval;
-}
+	size_t data_len = 0;
 
-/* Similar to semanage_direct_install(), except that it checks that
- * there already exists a module with the same name and that the
- * module is an older version then the one in 'data'.  Returns 0 on
- * success, -1 if out of memory, -2 if the data does not represent a
- * valid module file, -3 if error while writing file or reading
- * modules directory, -4 if the previous module is same or newer than 'data', 
- * -5 if there does not exist an older module.
- */
-static int semanage_direct_upgrade(semanage_handle_t * sh,
-				   char *data, size_t data_len)
-{
-	int status = 0;
-	int ret = 0;
+	status = semanage_path_to_info(
+			sh,
+			install_filename,
+			&modinfo,
+			&data,
+			&data_len);
+	if (status != 0) goto cleanup;
 
-	char *module_name = NULL, *version = NULL;
-	status = parse_module_headers(
+	status = semanage_module_install_info(
 			sh,
+			modinfo,
 			data,
-			data_len,
-			&module_name,
-			&version);
-	if (status != 0) {
-		goto cleanup;
-	}
-
-	semanage_module_info_t modinfo;
-	ret = semanage_module_info_init(sh, &modinfo);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_name(sh, &modinfo, module_name);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_version(sh, &modinfo, version);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_enabled(sh, &modinfo, -1);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	status = semanage_direct_upgrade_info(sh, &modinfo, data, data_len);
+			data_len);
 
 cleanup:
-	free(module_name);
-	free(version);
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	free(data);
 
 	return status;
 }
@@ -1233,125 +1141,33 @@ cleanup:
 static int semanage_direct_upgrade_file(semanage_handle_t * sh,
 					const char *module_filename)
 {
-	int retval = -1;
-	char *data = NULL;
-	ssize_t data_len = 0;
-	int compressed = 0;
-	int in_fd = -1;
-
-	if ((in_fd = open(module_filename, O_RDONLY)) == -1) {
-		return -1;
-	}
-
-	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
-		goto cleanup;
-	}
-
-	retval = semanage_direct_upgrade(sh, data, data_len);
-
-      cleanup:
-	close(in_fd);
-	if (data_len > 0) munmap(data, data_len);
-
-	return retval;
-}
-
-/* Writes a base module into a sandbox, overwriting any previous base
- * module.  Note that 'module_data' is not free()d by this function;
- * caller is responsible for deallocating it if necessary.  Returns 0
- * on success, -1 if out of memory, -2 if the data does not represent
- * a valid base module file, -3 if error while writing file.
- */
-static int semanage_direct_install_base(semanage_handle_t * sh,
-					char *base_data, size_t data_len)
-{
 	int status = 0;
-	int ret = 0;
-
-	ret = parse_base_headers(sh, base_data, data_len);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	semanage_module_info_t modinfo;
-	ret = semanage_module_info_init(sh, &modinfo);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_priority(sh, &modinfo, sh->priority);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_name(sh, &modinfo, "_base");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_version(sh, &modinfo, "1.0.0");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
-
-	ret = semanage_module_info_set_lang_ext(sh, &modinfo, "pp");
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
 
-	ret = semanage_module_info_set_enabled(sh, &modinfo, 1);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
+	semanage_module_info_t *modinfo = NULL;
+	char *data = NULL;
+	size_t data_len = 0;
 
-	status = semanage_direct_install_info(
+	status = semanage_path_to_info(
 			sh,
+			module_filename,
 			&modinfo,
-			base_data,
+			&data,
+			&data_len);
+	if (status != 0) goto cleanup;
+
+	status = semanage_module_upgrade_info(
+			sh,
+			modinfo,
+			data,
 			data_len);
 
 cleanup:
-	semanage_module_info_destroy(sh, &modinfo);
-
-	return status;
-}
-
-/* Writes a base module into a sandbox, overwriting any previous base
- * module.  
- * Returns 0 on success, -1 if out of memory, -2 if the data does not represent
- * a valid base module file, -3 if error while writing file.
- */
-static int semanage_direct_install_base_file(semanage_handle_t * sh,
-					     const char *install_filename)
-{
-	int retval = -1;
-	char *data = NULL;
-	ssize_t data_len = 0;
-	int compressed = 0;
-	int in_fd;
-
-	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
-		return -1;
-	}
-
-	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
-		goto cleanup;
-	}
-		
-	retval = semanage_direct_install_base(sh, data, data_len);
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
 
-      cleanup:
-	close(in_fd);
-	if (data_len > 0) munmap(data, data_len);
+	free(data);
 
-	return retval;
+	return status;
 }
 
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
@@ -1386,6 +1202,14 @@ cleanup:
 	return status;
 }
 
+/* qsort comparison function for semanage_direct_list. */
+static int semanage_direct_list_cmp(const void *a, const void *b)
+{
+	semanage_module_info_t *ma = (semanage_module_info_t *)a;
+	semanage_module_info_t *mb = (semanage_module_info_t *)b;
+	return strverscmp(ma->name, mb->name);
+}
+
 /* Allocate an array of module_info structures for each readable
  * module within the store.  Note that if the calling program has
  * already begun a transaction then this function will get a list of
@@ -1393,97 +1217,108 @@ cleanup:
  * semanage_module_info_datum_destroy() on each element of the array
  * as well as free()ing the entire list.
  */
-static int semanage_direct_list(semanage_handle_t * sh,
-				semanage_module_info_t ** modinfo,
-				int *num_modules)
+static int semanage_direct_list(semanage_handle_t *sh,
+				semanage_module_info_t **modinfos,
+				int *modinfos_len)
 {
-	struct sepol_policy_file *pf = NULL;
-	int i, retval = -1;
-	char **module_filenames = NULL;
-	int num_mod_files;
-	*modinfo = NULL;
-	*num_modules = 0;
+	assert(sh);
+	assert(modinfos);
+	assert(modinfos_len);
 
-	/* get the read lock when reading from the active
-	   (non-transaction) directory */
-	if (!sh->is_in_transaction)
-		if (semanage_get_active_lock(sh) < 0)
-			return -1;
+	int status = 0;
+	int ret = 0;
 
-	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
-	    -1) {
-		goto cleanup;
-	}
-	if (num_mod_files == 0) {
-		retval = semanage_direct_get_serial(sh);
-		goto cleanup;
-	}
+	int i = 0;
+	int j = 0;
 
-	if (sepol_policy_file_create(&pf)) {
-		ERR(sh, "Out of memory!");
+	semanage_list_t *list = NULL;
+	semanage_list_t *found = NULL;
+
+	semanage_module_info_t *all_modinfos = NULL;
+	int all_modinfos_len = 0;
+
+	void *tmp = NULL;
+
+	/* get all modules */
+	ret = semanage_module_list_all(sh, &all_modinfos, &all_modinfos_len);
+	if (ret != 0) {
+		status = -1;
 		goto cleanup;
 	}
-	sepol_policy_file_set_handle(pf, sh->sepolh);
 
-	if ((*modinfo = calloc(num_mod_files, sizeof(**modinfo))) == NULL) {
-		ERR(sh, "Out of memory!");
+	/* allocate enough for worst case */
+	(*modinfos) = calloc(all_modinfos_len, sizeof(semanage_module_info_t));
+	if ((*modinfos) == NULL) {
+		ERR(sh, "Error allocating space for module info array.");
+		status = -1;
 		goto cleanup;
 	}
 
-	for (i = 0; i < num_mod_files; i++) {
-		FILE *fp;
-		char *name = NULL, *version = NULL;
-		int type;
-		if ((fp = fopen(module_filenames[i], "rb")) == NULL) {
-			/* could not open this module file, so don't
-			 * report it */
-			continue;
-		}
-		ssize_t size;
-		char *data = NULL;
-
-		if ((size = bunzip(sh, fp, &data)) > 0) {
-			fclose(fp);
-			fp = fmemopen(data, size, "rb");
-			if (!fp) {
-				ERR(sh, "Out of memory!");
+	*modinfos_len = all_modinfos_len;
+
+	/* for each highest priority, enabled module clone */
+	semanage_list_destroy(&list);
+	for (i = 0, j = 0; i < all_modinfos_len; i++) {
+		/* check if enabled */
+		if (all_modinfos[i].enabled != 1) continue;
+
+		/* check if we've seen this before (i.e. highest priority) */
+		found = semanage_list_find(list, all_modinfos[i].name);
+		if (found == NULL) {
+			ret = semanage_list_push(&list, all_modinfos[i].name);
+			if (ret != 0) {
+				ERR(sh, "Failed to add module name to list of known names.");
+				status = -1;
 				goto cleanup;
 			}
 		}
-		rewind(fp);
-		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		sepol_policy_file_set_fp(pf, fp);
-		if (sepol_module_package_info(pf, &type, &name, &version)) {
-			fclose(fp);
-			free(data);
-			free(name);
-			free(version);
-			continue;
-		}
-		fclose(fp);
-		free(data);
-		if (type == SEPOL_POLICY_MOD) {
-			(*modinfo)[*num_modules].name = name;
-			(*modinfo)[*num_modules].version = version;
-			(*num_modules)++;
-		} else {
-			/* file was not a module, so don't report it */
-			free(name);
-			free(version);
+		else continue;
+
+		ret = semanage_module_info_clone(
+				sh,
+				&all_modinfos[i],
+				&(*modinfos)[j]);
+		if (ret != 0) {
+			ERR(sh, "Failed to clone module into array.");
+			status = -1;
+			goto cleanup;
 		}
+
+		j += 1;
 	}
-	retval = semanage_direct_get_serial(sh);
 
-      cleanup:
-	sepol_policy_file_free(pf);
-	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
-		free(module_filenames[i]);
+	/* realloc the array to its min size */
+	tmp = realloc(*modinfos, j * sizeof(semanage_module_info_t));
+	if (tmp == NULL) {
+		ERR(sh, "Error allocating space for module info array.");
+		status = -1;
+		goto cleanup;
 	}
-	free(module_filenames);
-	if (!sh->is_in_transaction) {
-		semanage_release_active_lock(sh);
+	*modinfos = tmp;
+	*modinfos_len = j;
+
+	/* sort array on module name */
+	qsort(*modinfos,
+	      *modinfos_len,
+	      sizeof(semanage_module_info_t),
+	      semanage_direct_list_cmp);
+
+cleanup:
+	semanage_list_destroy(&list);
+
+	for (i = 0; i < all_modinfos_len; i++) {
+		semanage_module_info_destroy(sh, &all_modinfos[i]);
 	}
-	return retval;
+	free(all_modinfos);
+
+	if (status != 0) {
+		for (i = 0; i < *modinfos_len; i++) {
+			semanage_module_info_destroy(sh, &(*modinfos)[i]);
+		}
+		free(*modinfos);
+	}
+
+	return status;
 }
 
 static int semanage_direct_get_enabled(semanage_handle_t *sh,
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
