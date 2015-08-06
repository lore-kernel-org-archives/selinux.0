Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t76EUWJJ018630
 for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2015 10:30:33 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH v2 1/3] libsemanage: Add ability to extract modules
Date: Thu, 6 Aug 2015 10:30:12 -0400
Message-ID: <1438871414-62292-2-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add semanage_module_extract() to extract a module as CIL or HLL. The
function takes a module name and whether to extract as CIL or HLL.

If a CIL file is requested, but does not exist, semanage_module_extract()
will compile the HLL to CIL and cache the CIL in the store as well as
extract the module. A module that was installed from a CIL file will export
as CIL when the HLL version of the file is requested.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/include/semanage/modules.h |  17 ++
 libsemanage/src/direct_api.c           | 310 ++++++++++++++++++++++-----------
 libsemanage/src/libsemanage.map        |   1 +
 libsemanage/src/modules.c              |  17 ++
 libsemanage/src/policy.h               |   8 +
 libsemanage/src/semanageswig_python.i  |   5 +
 6 files changed, 256 insertions(+), 102 deletions(-)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index 4267bd2..4b93e54 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -24,6 +24,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <semanage/handle.h>
+#include <sys/types.h>
 
 typedef struct semanage_module_key semanage_module_key_t;
 
@@ -41,6 +42,22 @@ int semanage_module_remove(semanage_handle_t *, char *module_name);
    modules, only name at this time */
 typedef struct semanage_module_info semanage_module_info_t;
 
+/* Look up a module using @modkey. The module's raw data is returned as a
+ * @mapped_data blob and size of the mapped_data is returned as @data_len.
+ * @modinfo contains additional information which can be used by the caller such
+ * as the high level language extension of @mapped_data.
+ *
+ * On success, the caller is responsible for unmapping @mapped_data with munmap(),
+ * destroying @modinfo with semanage_module_info_destroy(), and freeing @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_extract(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 int extract_cil,
+				 void **mapped_data,
+				 size_t *data_len,
+				 semanage_module_info_t **modinfo);
 int semanage_module_list(semanage_handle_t *,
 			 semanage_module_info_t **, int *num_modules);
 void semanage_module_info_datum_destroy(semanage_module_info_t *);
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b11f2ba..90a7b22 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -66,6 +66,12 @@ static int semanage_direct_commit(semanage_handle_t * sh);
 static int semanage_direct_install(semanage_handle_t * sh, char *data,
 				   size_t data_len, const char *module_name, const char *lang_ext);
 static int semanage_direct_install_file(semanage_handle_t * sh, const char *module_name);
+static int semanage_direct_extract(semanage_handle_t * sh,
+					   semanage_module_key_t *modkey,
+					   int extract_cil,
+					   void **mapped_data,
+					   size_t *data_len,
+					   semanage_module_info_t **modinfo);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -100,6 +106,7 @@ static struct semanage_policy_table direct_funcs = {
 	.begin_trans = semanage_direct_begintrans,
 	.commit = semanage_direct_commit,
 	.install = semanage_direct_install,
+	.extract = semanage_direct_extract,
 	.install_file = semanage_direct_install_file,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list,
@@ -496,15 +503,32 @@ exit:
  * the file into '*data'.
  * Returns the total number of bytes in memory .
  * Returns -1 if file could not be opened or mapped. */
-static ssize_t map_file(semanage_handle_t *sh, int fd, char **data,
+static ssize_t map_file(semanage_handle_t *sh, const char *path, char **data,
 			int *compressed)
 {
 	ssize_t size = -1;
 	char *uncompress;
-	if ((size = bunzip(sh, fdopen(fd, "r"), &uncompress)) > 0) {
+	int fd = -1;
+	FILE *file = NULL;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		ERR(sh, "Unable to open %s\n", path);
+		return -1;
+	}
+
+	file = fdopen(fd, "r");
+	if (file == NULL) {
+		ERR(sh, "Unable to open %s\n", path);
+		close(fd);
+		return -1;
+	}
+
+	if ((size = bunzip(sh, file, &uncompress)) > 0) {
 		*data = mmap(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (*data == MAP_FAILED) {
 			free(uncompress);
+			fclose(file);
 			return -1;
 		} else {
 			memcpy(*data, uncompress, size);
@@ -523,6 +547,8 @@ static ssize_t map_file(semanage_handle_t *sh, int fd, char **data,
 		*compressed = 0;
 	} 
 
+	fclose(file);
+
 	return size;
 }
 
@@ -886,9 +912,8 @@ cleanup:
 	return ret;
 }
 
-static int semanage_compile_hll(semanage_handle_t *sh,
-				semanage_module_info_t *modinfos,
-				int num_modinfos)
+static int semanage_compile_module(semanage_handle_t *sh,
+				semanage_module_info_t *modinfo)
 {
 	char cil_path[PATH_MAX];
 	char hll_path[PATH_MAX];
@@ -901,125 +926,132 @@ static int semanage_compile_hll(semanage_handle_t *sh,
 	ssize_t hll_data_len = 0;
 	ssize_t bzip_status;
 	int status = 0;
-	int i, compressed;
-	int in_fd = -1;
+	int compressed;
 	size_t cil_data_len;
 	size_t err_data_len;
 
-	assert(sh);
-	assert(modinfos);
+	if (!strcasecmp(modinfo->lang_ext, "cil")) {
+		goto cleanup;
+	}
 
-	for (i = 0; i < num_modinfos; i++) {
-		if (!strcasecmp(modinfos[i].lang_ext, "cil")) {
-			continue;
-		}
+	status = semanage_get_hll_compiler_path(sh, modinfo->lang_ext, &compiler_path);
+	if (status != 0) {
+		goto cleanup;
+	}
 
-		status = semanage_module_get_path(
-				sh,
-				&modinfos[i],
-				SEMANAGE_MODULE_PATH_CIL,
-				cil_path,
-				sizeof(cil_path));
-		if (status != 0) {
-			goto cleanup;
+	status = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_CIL,
+			cil_path,
+			sizeof(cil_path));
+	if (status != 0) {
+		goto cleanup;
+	}
+
+	status = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_HLL,
+			hll_path,
+			sizeof(hll_path));
+	if (status != 0) {
+		goto cleanup;
+	}
+
+	if ((hll_data_len = map_file(sh, hll_path, &hll_data, &compressed)) <= 0) {
+		ERR(sh, "Unable to read file %s\n", hll_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	status = semanage_pipe_data(sh, compiler_path, hll_data, (size_t)hll_data_len, &cil_data, &cil_data_len, &err_data, &err_data_len);
+	if (err_data_len > 0) {
+		for (start = end = err_data; end < err_data + err_data_len; end++) {
+			if (*end == '\n') {
+				fprintf(stderr, "%s: ", modinfo->name);
+				fwrite(start, 1, end - start + 1, stderr);
+				start = end + 1;
+			}
 		}
 
-		if (semanage_get_ignore_module_cache(sh) == 0 &&
-			access(cil_path, F_OK) == 0) {
-			continue;
+		if (end != start) {
+			fprintf(stderr, "%s: ", modinfo->name);
+			fwrite(start, 1, end - start, stderr);
+			fprintf(stderr, "\n");
 		}
+	}
+	if (status != 0) {
+		goto cleanup;
+	}
+
+	bzip_status = bzip(sh, cil_path, cil_data, cil_data_len);
+	if (bzip_status == -1) {
+		ERR(sh, "Failed to bzip %s\n", cil_path);
+		status = -1;
+		goto cleanup;
+	}
 
-		status = semanage_get_hll_compiler_path(sh, modinfos[i].lang_ext, &compiler_path);
+	if (sh->conf->remove_hll == 1) {
+		status = unlink(hll_path);
 		if (status != 0) {
+			ERR(sh, "Error while removing HLL file %s: %s", hll_path, strerror(errno));
 			goto cleanup;
 		}
 
-		status = semanage_module_get_path(
-				sh,
-				&modinfos[i],
-				SEMANAGE_MODULE_PATH_HLL,
-				hll_path,
-				sizeof(hll_path));
+		status = semanage_direct_write_langext(sh, "cil", modinfo);
 		if (status != 0) {
 			goto cleanup;
 		}
+	}
 
-		if ((in_fd = open(hll_path, O_RDONLY)) == -1) {
-			ERR(sh, "Unable to open %s\n", hll_path);
-			status = -1;
-			goto cleanup;
-		}
+cleanup:
+	if (hll_data_len > 0) {
+		munmap(hll_data, hll_data_len);
+	}
+	free(cil_data);
+	free(err_data);
+	free(compiler_path);
 
-		if ((hll_data_len = map_file(sh, in_fd, &hll_data, &compressed)) <= 0) {
-			ERR(sh, "Unable to read file %s\n", hll_path);
-			status = -1;
-			goto cleanup;
-		}
+	return status;
+}
 
-		if (in_fd >= 0) close(in_fd);
-		in_fd = -1;
+static int semanage_compile_hll_modules(semanage_handle_t *sh,
+				semanage_module_info_t *modinfos,
+				int num_modinfos)
+{
+	int status = 0;
+	int i;
+	char cil_path[PATH_MAX];
 
-		status = semanage_pipe_data(sh, compiler_path, hll_data, (size_t)hll_data_len, &cil_data, &cil_data_len, &err_data, &err_data_len);
-		if (err_data_len > 0) {
-			for (start = end = err_data; end < err_data + err_data_len; end++) {
-				if (*end == '\n') {
-					fprintf(stderr, "%s: ", modinfos[i].name);
-					fwrite(start, 1, end - start + 1, stderr);
-					start = end + 1;
-				}
-			}
+	assert(sh);
+	assert(modinfos);
 
-			if (end != start) {
-				fprintf(stderr, "%s: ", modinfos[i].name);
-				fwrite(start, 1, end - start, stderr);
-				fprintf(stderr, "\n");
-			}
-		}
+	for (i = 0; i < num_modinfos; i++) {
+		status = semanage_module_get_path(
+				sh,
+				&modinfos[i],
+				SEMANAGE_MODULE_PATH_CIL,
+				cil_path,
+				sizeof(cil_path));
 		if (status != 0) {
 			goto cleanup;
 		}
 
-		if (sh->conf->remove_hll == 1) {
-			status = unlink(hll_path);
-			if (status != 0) {
-				ERR(sh, "Error while removing HLL file %s: %s", hll_path, strerror(errno));
-				goto cleanup;
-			}
-
-			status = semanage_direct_write_langext(sh, "cil", &modinfos[i]);
-			if (status != 0) {
-				goto cleanup;
-			}
+		if (semanage_get_ignore_module_cache(sh) == 0 &&
+				access(cil_path, F_OK) == 0) {
+			continue;
 		}
 
-		bzip_status = bzip(sh, cil_path, cil_data, cil_data_len);
-		if (bzip_status == -1) {
-			ERR(sh, "Failed to bzip %s\n", cil_path);
-			status = -1;
+		status = semanage_compile_module(sh, &modinfos[i]);
+		if (status < 0) {
 			goto cleanup;
 		}
-
-		if (hll_data_len > 0) munmap(hll_data, hll_data_len);
-		hll_data_len = 0;
-
-		free(cil_data);
-		free(err_data);
-		free(compiler_path);
-		cil_data = NULL;
-		err_data = NULL;
-		compiler_path = NULL;
-		cil_data_len = 0;
-		err_data_len = 0;
 	}
 
 	status = 0;
 
 cleanup:
-	if (hll_data_len > 0) munmap(hll_data, hll_data_len);
-	if (in_fd >= 0) close(in_fd);
-	free(cil_data);
-	free(err_data);
-	free(compiler_path);
 	return status;
 }
 
@@ -1179,7 +1211,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			goto cleanup;
 		}
 
-		retval = semanage_compile_hll(sh, modinfos, num_modinfos);
+		retval = semanage_compile_hll_modules(sh, modinfos, num_modinfos);
 		if (retval < 0) {
 			ERR(sh, "Failed to compile hll files into cil files.\n");
 			goto cleanup;
@@ -1492,19 +1524,12 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	char *data = NULL;
 	ssize_t data_len = 0;
 	int compressed = 0;
-	int in_fd = -1;
 	char *path = NULL;
 	char *filename;
 	char *lang_ext = NULL;
 	char *separator;
 
-	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
-		ERR(sh, "Unable to open %s: %s\n", install_filename, strerror(errno));
-		retval = -1;
-		goto cleanup;
-	}
-
-	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
+	if ((data_len = map_file(sh, install_filename, &data, &compressed)) <= 0) {
 		ERR(sh, "Unable to read file %s\n", install_filename);
 		retval = -1;
 		goto cleanup;
@@ -1545,15 +1570,96 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	retval = semanage_direct_install(sh, data, data_len, filename, lang_ext);
 
 cleanup:
-	if (in_fd != -1) {
-		close(in_fd);
-	}
 	if (data_len > 0) munmap(data, data_len);
 	free(path);
 
 	return retval;
 }
 
+static int semanage_direct_extract(semanage_handle_t * sh,
+				   semanage_module_key_t *modkey,
+				   int extract_cil,
+				   void **mapped_data,
+				   size_t *data_len,
+				   semanage_module_info_t **modinfo)
+{
+	char module_path[PATH_MAX];
+	char input_file[PATH_MAX];
+	enum semanage_module_path_type file_type;
+	int rc = -1;
+	semanage_module_info_t *_modinfo = NULL;
+	ssize_t _data_len;
+	char *_data;
+	int compressed;
+
+	/* get path of module */
+	rc = semanage_module_get_path(
+			sh,
+			(const semanage_module_info_t *)modkey,
+			SEMANAGE_MODULE_PATH_NAME,
+			module_path,
+			sizeof(module_path));
+	if (rc != 0) {
+		goto cleanup;
+	}
+
+	if (access(module_path, F_OK) != 0) {
+		ERR(sh, "Module does not exist: %s", module_path);
+		rc = -1;
+		goto cleanup;
+	}
+
+	rc = semanage_module_get_module_info(sh,
+			modkey,
+			&_modinfo);
+	if (rc != 0) {
+		goto cleanup;
+	}
+
+	if (extract_cil || strcmp(_modinfo->lang_ext, "cil") == 0) {
+		file_type = SEMANAGE_MODULE_PATH_CIL;
+	} else {
+		file_type = SEMANAGE_MODULE_PATH_HLL;
+	}
+
+	/* get path of what to extract */
+	rc = semanage_module_get_path(
+			sh,
+			_modinfo,
+			file_type,
+			input_file,
+			sizeof(input_file));
+	if (rc != 0) {
+		goto cleanup;
+	}
+
+	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && access(input_file, F_OK) != 0) {
+		rc = semanage_compile_module(sh, _modinfo);
+		if (rc < 0) {
+			goto cleanup;
+		}
+	}
+
+	_data_len = map_file(sh, input_file, &_data, &compressed);
+	if (_data_len <= 0) {
+		ERR(sh, "Error mapping file: %s", input_file);
+		rc = -1;
+		goto cleanup;
+	}
+
+	*modinfo = _modinfo;
+	*data_len = (size_t)_data_len;
+	*mapped_data = _data;
+
+cleanup:
+	if (rc != 0) {
+		semanage_module_info_destroy(sh, _modinfo);
+		free(_modinfo);
+	}
+
+	return rc;
+}
+
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 70f57f9..34b553d 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -30,6 +30,7 @@ LIBSEMANAGE_1.0 {
 LIBSEMANAGE_1.1 {
   global:
 	  semanage_module_install;
+	  semanage_module_extract;
 	  semanage_get_hll_compiler_path;
 	  semanage_get_ignore_module_cache;
 	  semanage_set_ignore_module_cache;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d29c346..131f502 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -142,6 +142,23 @@ int semanage_module_install_file(semanage_handle_t * sh,
 	return sh->funcs->install_file(sh, module_name);
 }
 
+int semanage_module_extract(semanage_handle_t * sh,
+				 semanage_module_key_t *modkey,
+				 int extract_cil,
+				 void **mapped_data,
+				 size_t *data_len,
+				 semanage_module_info_t **modinfo) {
+	if (sh->funcs->extract == NULL) {
+		ERR(sh,
+		    "No get function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+	return sh->funcs->extract(sh, modkey, extract_cil, mapped_data, data_len, modinfo);
+}
+
 /* Legacy function that remains to preserve ABI
  * compatibility. Please use semanage_module_install instead.
  */
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index c5aec38..f127156 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -52,6 +52,14 @@ struct semanage_policy_table {
 	/* Install a policy module */
 	int (*install_file) (struct semanage_handle *, const char *);
 
+	/* Extract a policy module */
+	int (*extract) (struct semanage_handle *,
+				 semanage_module_key_t *,
+				 int extract_cil,
+				 void **,
+				 size_t *,
+				 semanage_module_info_t **);
+
 	/* Remove a policy module */
 	int (*remove) (struct semanage_handle *, char *);
 
diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 06b9408..1346b2e 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -23,6 +23,7 @@
 %header %{
 	#include <stdlib.h>
 	#include <semanage/semanage.h>
+	#include <sys/mman.h>
 
 	#define STATUS_SUCCESS 0
 	#define STATUS_ERR -1
@@ -103,6 +104,10 @@
 %apply int *OUTPUT { unsigned int * };
 %apply int *OUTPUT { uint16_t * };
 
+%include <cstring.i>
+/* This is needed to properly mmaped binary data in SWIG */
+%cstring_output_allocate_size(void **mapped_data, size_t *data_len, munmap(*$1, *$2));
+
 %typemap(in, numinputs=0) char **(char *temp=NULL) {
 	$1 = &temp;
 }
-- 
1.9.3
