Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OJokYg025580
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:50:46 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OJp3vp028756
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 19:51:03 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJoiDw007848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:50:44 -0500
Received: from localhost.localdomain (vpn-11-226.rdu.redhat.com [10.11.11.226])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJofks005593
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:50:42 -0500
Message-ID: <4B858311.1010003@redhat.com>
Date: Wed, 24 Feb 2010 14:50:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Last attempt at upstreaming semodule_disable patch.
Content-Type: multipart/mixed;
 boundary="------------030506040908070608050802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030506040908070608050802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows you to disable/Enable policy modules.

It never seems to get upstreamed.  :^(

--------------030506040908070608050802
Content-Type: text/plain;
 name="semodule_disable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="semodule_disable.patch"

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index e169279..349a50e 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -40,10 +40,12 @@ int semanage_module_install_base(semanage_handle_t *,
 				 char *module_data, size_t data_len);
 int semanage_module_install_base_file(semanage_handle_t *,
 				      const char *module_name);
+int semanage_module_enable(semanage_handle_t *, char *module_name);
+int semanage_module_disable(semanage_handle_t *, char *module_name);
 int semanage_module_remove(semanage_handle_t *, char *module_name);
 
 /* semanage_module_info is for getting information on installed
-   modules, only name and version at this time */
+   modules, only name and version, and enabled/disabled flag at this time */
 typedef struct semanage_module_info semanage_module_info_t;
 
 int semanage_module_list(semanage_handle_t *,
@@ -53,5 +55,6 @@ semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
 						 int n);
 const char *semanage_module_get_name(semanage_module_info_t *);
 const char *semanage_module_get_version(semanage_module_info_t *);
+int semanage_module_get_enabled(semanage_module_info_t *);
 
 #endif
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index fee6644..501a51e 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -66,6 +66,8 @@ static int semanage_direct_upgrade_file(semanage_handle_t * sh, const char *modu
 static int semanage_direct_install_base(semanage_handle_t * sh, char *base_data,
 					size_t data_len);
 static int semanage_direct_install_base_file(semanage_handle_t * sh, const char *module_name);
+static int semanage_direct_enable(semanage_handle_t * sh, char *module_name);
+static int semanage_direct_disable(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -83,6 +85,8 @@ static struct semanage_policy_table direct_funcs = {
 	.upgrade_file = semanage_direct_upgrade_file,
 	.install_base = semanage_direct_install_base,
 	.install_base_file = semanage_direct_install_base_file,
+	.enable = semanage_direct_enable,
+	.disable = semanage_direct_disable,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list
 };
@@ -348,10 +352,17 @@ static int parse_module_headers(semanage_handle_t * sh, char *module_data,
 	     semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES)) == NULL) {
 		return -1;
 	}
-	if (asprintf(filename, "%s/%s.pp", module_path, *module_name) == -1) {
+	if (asprintf(filename, "%s/%s.pp%s", module_path, *module_name, DISABLESTR) == -1) {
 		ERR(sh, "Out of memory!");
 		return -1;
 	}
+
+	if (access(*filename, F_OK) == -1) {
+		char *ptr = *filename;
+		int len = strlen(ptr) - strlen(DISABLESTR);
+		if (len > 0) ptr[len]='\0';
+	}
+
 	return 0;
 }
 
@@ -1273,6 +1284,107 @@ static int semanage_direct_install_base_file(semanage_handle_t * sh,
 	return retval;
 }
 
+/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
+ * of memory, -2 if module not found or could not be enabled. */
+static int semanage_direct_enable(semanage_handle_t * sh, char *module_name)
+{
+	int i, retval = -1;
+	char **module_filenames = NULL;
+	int num_mod_files;
+	size_t name_len = strlen(module_name);
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
+	    -1) {
+		return -1;
+	}
+	for (i = 0; i < num_mod_files; i++) {
+		char *base = strrchr(module_filenames[i], '/');
+		if (base == NULL) {
+			ERR(sh, "Could not read module names.");
+			retval = -2;
+			goto cleanup;
+		}
+		base++;
+		if (memcmp(module_name, base, name_len) == 0 &&
+		    strcmp(base + name_len + 3, DISABLESTR) == 0) {
+			int len = strlen(module_filenames[i]) - strlen(DISABLESTR);
+			char *enabled_name = calloc(1, len+1);
+			if (!enabled_name) {
+				ERR(sh, "Could not allocate memory");
+				retval = -1;
+				goto cleanup;
+			}
+
+			strncpy(enabled_name, module_filenames[i],len);
+
+			if (rename(module_filenames[i], enabled_name) == -1) {
+				ERR(sh, "Could not enable module file %s.",
+				    enabled_name);
+				retval = -2;
+			}
+			retval = 0;
+			free(enabled_name);
+			goto cleanup;
+		}
+	}
+	ERR(sh, "Module %s was not found.", module_name);
+	retval = -2;		/* module not found */
+      cleanup:
+	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
+		free(module_filenames[i]);
+	}
+	free(module_filenames);
+	return retval;
+}
+
+/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
+ * of memory, -2 if module not found or could not be enabled. */
+static int semanage_direct_disable(semanage_handle_t * sh, char *module_name)
+{
+	int i, retval = -1;
+	char **module_filenames = NULL;
+	int num_mod_files;
+	size_t name_len = strlen(module_name);
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
+	    -1) {
+		return -1;
+	}
+	for (i = 0; i < num_mod_files; i++) {
+		char *base = strrchr(module_filenames[i], '/');
+		if (base == NULL) {
+			ERR(sh, "Could not read module names.");
+			retval = -2;
+			goto cleanup;
+		}
+		base++;
+		if (memcmp(module_name, base, name_len) == 0 &&
+		    strcmp(base + name_len, ".pp") == 0) {
+			char disabled_name[PATH_MAX];
+			if (snprintf(disabled_name, PATH_MAX, "%s%s", 
+				     module_filenames[i], DISABLESTR) == PATH_MAX) {
+				ERR(sh, "Could not disable module file %s.",
+				    module_filenames[i]);
+				retval = -2;
+				goto cleanup;
+			}
+			if (rename(module_filenames[i], disabled_name) == -1) {
+				ERR(sh, "Could not disable module file %s.",
+				    module_filenames[i]);
+				retval = -2;
+			}
+			retval = 0;
+			goto cleanup;
+		}
+	}
+	ERR(sh, "Module %s was not found.", module_name);
+	retval = -2;		/* module not found */
+      cleanup:
+	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
+		free(module_filenames[i]);
+	}
+	free(module_filenames);
+	return retval;
+}
+
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
@@ -1293,8 +1405,7 @@ static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
 			goto cleanup;
 		}
 		base++;
-		if (memcmp(module_name, base, name_len) == 0 &&
-		    strcmp(base + name_len, ".pp") == 0) {
+		if (memcmp(module_name, base, name_len) == 0) {
 			if (unlink(module_filenames[i]) == -1) {
 				ERR(sh, "Could not remove module file %s.",
 				    module_filenames[i]);
@@ -1369,6 +1480,7 @@ static int semanage_direct_list(semanage_handle_t * sh,
 		}
 		ssize_t size;
 		char *data = NULL;
+		int enabled = semanage_module_enabled(module_filenames[i]);
 
 		if ((size = bunzip(sh, fp, &data)) > 0) {
 			sepol_policy_file_set_mem(pf, data, size);
@@ -1389,6 +1501,7 @@ static int semanage_direct_list(semanage_handle_t * sh,
 		if (type == SEPOL_POLICY_MOD) {
 			(*modinfo)[*num_modules].name = name;
 			(*modinfo)[*num_modules].version = version;
+			(*modinfo)[*num_modules].enabled = enabled;
 			(*num_modules)++;
 		} else {
 			/* file was not a module, so don't report it */
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index d15f69d..762e20e 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -6,10 +6,13 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_install; semanage_module_install_file;
 	  semanage_module_upgrade; semanage_module_upgrade_file;
 	  semanage_module_install_base; semanage_module_install_base_file;
+	  semanage_module_enable;
+	  semanage_module_disable;
 	  semanage_module_remove;
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
+	  semanage_module_get_enabled;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
diff --git a/libsemanage/src/module_internal.h b/libsemanage/src/module_internal.h
index f074a3a..04f767b 100644
--- a/libsemanage/src/module_internal.h
+++ b/libsemanage/src/module_internal.h
@@ -6,6 +6,7 @@
 
 hidden_proto(semanage_module_get_name)
     hidden_proto(semanage_module_get_version)
+    hidden_proto(semanage_module_get_enabled)
     hidden_proto(semanage_module_info_datum_destroy)
     hidden_proto(semanage_module_list_nth)
 #endif
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d99ee5b..6b2e6df 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -154,6 +154,40 @@ int semanage_module_install_base_file(semanage_handle_t * sh,
 	return sh->funcs->install_base_file(sh, module_name);
 }
 
+int semanage_module_enable(semanage_handle_t * sh, char *module_name)
+{
+	if (sh->funcs->enable == NULL) {
+		ERR(sh, "No enable function defined for this connection type.");
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
+	return sh->funcs->enable(sh, module_name);
+}
+
+int semanage_module_disable(semanage_handle_t * sh, char *module_name)
+{
+	if (sh->funcs->disable == NULL) {
+		ERR(sh, "No disable function defined for this connection type.");
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
+	return sh->funcs->disable(sh, module_name);
+}
+
 int semanage_module_remove(semanage_handle_t * sh, char *module_name)
 {
 	if (sh->funcs->remove == NULL) {
@@ -209,6 +243,13 @@ const char *semanage_module_get_name(semanage_module_info_t * modinfo)
 
 hidden_def(semanage_module_get_name)
 
+int semanage_module_get_enabled(semanage_module_info_t * modinfo)
+{
+	return modinfo->enabled;
+}
+
+hidden_def(semanage_module_get_enabled)
+
 const char *semanage_module_get_version(semanage_module_info_t * modinfo)
 {
 	return modinfo->version;
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 381b108..8d2e60c 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -26,6 +26,7 @@
 struct semanage_module_info {
 	char *name;		/* Key */
 	char *version;
+	int enabled;
 };
 
 #endif
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index ebefc02..627b526 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -58,6 +58,12 @@ struct semanage_policy_table {
 	/* Upgrade a policy module */
 	int (*upgrade_file) (struct semanage_handle *, const char *);
 
+	/* Enable a policy module */
+	int (*enable) (struct semanage_handle *, char *);
+
+	/* Disable a policy module */
+	int (*disable) (struct semanage_handle *, char *);
+
 	/* Remove a policy module */
 	int (*remove) (struct semanage_handle *, char *);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 1b831bd..339bbd0 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -57,6 +57,8 @@ typedef struct dbase_policydb dbase_t;
 
 #include "debug.h"
 
+const char *DISABLESTR=".disabled";
+
 #define SEMANAGE_CONF_FILE "semanage.conf"
 /* relative path names to enum semanage_paths to special files and
  * directories for the module store */
@@ -433,6 +435,21 @@ static int semanage_filename_select(const struct dirent *d)
 	return 1;
 }
 
+int semanage_module_enabled(const char *file) {
+	int len = strlen(file) - strlen(DISABLESTR);
+	return (len < 0 || strcmp(&file[len], DISABLESTR) != 0);
+}
+
+static int semanage_modulename_select(const struct dirent *d)
+{
+	if (d->d_name[0] == '.'
+	    && (d->d_name[1] == '\0'
+		|| (d->d_name[1] == '.' && d->d_name[2] == '\0')))
+		return 0;
+
+	return semanage_module_enabled(d->d_name);
+}
+
 /* Copies a file from src to dst.  If dst already exists then
  * overwrite it.  Returns 0 on success, -1 on error. */
 static int semanage_copy_file(const char *src, const char *dst, mode_t mode)
@@ -599,15 +616,8 @@ int semanage_make_sandbox(semanage_handle_t * sh)
 	return -1;
 }
 
-/* Scans the modules directory for the current semanage handler.  This
- * might be the active directory or sandbox, depending upon if the
- * handler has a transaction lock.  Allocates and fills in *filenames
- * with an array of module filenames; length of array is stored in
- * *len.  The caller is responsible for free()ing *filenames and its
- * individual elements.	 Upon success returns 0, -1 on error.
- */
-int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
-			       int *len)
+static int semanage_get_modules_names_filter(semanage_handle_t * sh, char ***filenames,
+				      int *len, int (*filter)(const struct dirent *))
 {
 	const char *modules_path;
 	struct dirent **namelist = NULL;
@@ -622,7 +632,7 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 	*filenames = NULL;
 	*len = 0;
 	if ((num_files = scandir(modules_path, &namelist,
-				 semanage_filename_select, alphasort)) == -1) {
+				 filter, alphasort)) == -1) {
 		ERR(sh, "Error while scanning directory %s.", modules_path);
 		goto cleanup;
 	}
@@ -663,6 +673,34 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 	return retval;
 }
 
+/* Scans the modules directory for the current semanage handler.  This
+ * might be the active directory or sandbox, depending upon if the
+ * handler has a transaction lock.  Allocates and fills in *filenames
+ * with an array of module filenames; length of array is stored in
+ * *len.  The caller is responsible for free()ing *filenames and its
+ * individual elements.	 Upon success returns 0, -1 on error.
+ */
+int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
+			       int *len)
+{
+	return semanage_get_modules_names_filter(sh, filenames,
+						 len, semanage_filename_select);
+}
+
+/* Scans the modules directory for the current semanage handler.  This
+ * might be the active directory or sandbox, depending upon if the
+ * handler has a transaction lock.  Allocates and fills in *filenames
+ * with an array of module filenames; length of array is stored in
+ * *len.  The caller is responsible for free()ing *filenames and its
+ * individual elements.	 Upon success returns 0, -1 on error.
+ */
+int semanage_get_active_modules_names(semanage_handle_t * sh, char ***filenames,
+			       int *len)
+{
+	return semanage_get_modules_names_filter(sh, filenames,
+						 len, semanage_modulename_select);
+}
+
 /******************* routines that run external programs *******************/
 
 /* Appends a single character to a string.  Returns a pointer to the
@@ -1585,7 +1623,7 @@ int semanage_link_sandbox(semanage_handle_t * sh,
 	}
 
 	/* get list of modules and load them */
-	if (semanage_get_modules_names(sh, &module_filenames, &num_modules) ==
+	if (semanage_get_active_modules_names(sh, &module_filenames, &num_modules) ==
 	    -1 || semanage_load_module(sh, base_filename, base) == -1) {
 		goto cleanup;
 	}
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 112edb6..9e8b1fd 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -128,4 +128,6 @@ int semanage_nc_sort(semanage_handle_t * sh,
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
+extern const char *DISABLESTR;
+
 #endif
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 1c1d206..12191f6 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -35,6 +35,12 @@ upgrade an existing module package, or install if the module does not exist
 .B  \-b,\-\-base=MODULE_PKG   
 install/replace base module package
 .TP
+.B  \-d,\-\-disable=MODULE_NAME
+disable existing module
+.TP
+.B  \-e,\-\-enable=MODULE_NAME
+enable existing module
+.TP
 .B  \-r,\-\-remove=MODULE_NAME
 remove existing module
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ad6adca..059f629 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -22,12 +22,12 @@
 
 #include <semanage/modules.h>
 
-enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
+enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, ENABLE_M, DISABLE_M, REMOVE_M,
 	LIST_M, RELOAD
 };
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
-	0, 1, 1, 1, 1,
+	0, 1, 1, 1, 1, 1, 1,
 	0, 0
 };
 
@@ -104,9 +104,11 @@ static void usage(char *progname)
 	printf("  -R, --reload		    reload policy\n");
 	printf("  -B, --build		    build and reload policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
-	printf("  -u,--upgrade=MODULE_PKG   upgrades or install module to a newer version\n");
+	printf("  -u,--upgrade=MODULE_PKG   upgrade existing module\n");
 	printf("  -b,--base=MODULE_PKG      install new base module\n");
-	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
+	printf("  -e,--enable=MODULE_PKG    enable existing module\n");
+	printf("  -d,--disable=MODULE_PKG   disable existing module\n");
+ 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
 	printf
 	    ("  -l,--list-modules         display list of installed modules\n");
 	printf("Other options:\n");
@@ -152,6 +154,8 @@ static void parse_command_line(int argc, char **argv)
 		{"install", required_argument, NULL, 'i'},
 		{"list-modules", 0, NULL, 'l'},
 		{"verbose", 0, NULL, 'v'},
+		{"enable", required_argument, NULL, 'e'},
+		{"disable", required_argument, NULL, 'd'},
 		{"remove", required_argument, NULL, 'r'},
 		{"upgrade", required_argument, NULL, 'u'},
 		{"reload", 0, NULL, 'R'},
@@ -166,7 +170,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	create_store = 0;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
+		getopt_long(argc, argv, "s:b:hi:lvqe:d:r:u:RnBD", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -185,6 +189,12 @@ static void parse_command_line(int argc, char **argv)
 		case 'v':
 			verbose = 1;
 			break;
+		case 'e':
+			set_mode(ENABLE_M, optarg);
+			break;
+		case 'd':
+			set_mode(DISABLE_M, optarg);
+			break;
 		case 'r':
 			set_mode(REMOVE_M, optarg);
 			break;
@@ -238,6 +248,10 @@ static void parse_command_line(int argc, char **argv)
 			mode = UPGRADE_M;
 		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
 			mode = REMOVE_M;
+		} else if (commands && commands[num_commands - 1].mode == ENABLE_M) {
+			mode = ENABLE_M;
+		} else if (commands && commands[num_commands - 1].mode == DISABLE_M) {
+			mode = DISABLE_M;
 		} else {
 			fprintf(stderr, "unknown additional arguments:\n");
 			while (optind < argc)
@@ -352,6 +366,30 @@ int main(int argc, char *argv[])
 				    semanage_module_install_base_file(sh, mode_arg);
 				break;
 			}
+		case ENABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to enable module '%s':\n",
+					     mode_arg);
+				}
+				result = semanage_module_enable(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
+				break;
+			}
+		case DISABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to disable module '%s':\n",
+					     mode_arg);
+				}
+				result = semanage_module_disable(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
+				break;
+			}
 		case REMOVE_M:{
 				if (verbose) {
 					printf
@@ -382,11 +420,12 @@ int main(int argc, char *argv[])
 						semanage_module_info_t *m =
 						    semanage_module_list_nth
 						    (modinfo, j);
-						printf("%s\t%s\n",
+						printf("%s\t%s\t%s\n",
 						       semanage_module_get_name
 						       (m),
 						       semanage_module_get_version
-						       (m));
+						       (m), 
+						       (semanage_module_get_enabled(m) ? "" : "Disabled"));
 						semanage_module_info_datum_destroy
 						    (m);
 					}

--------------030506040908070608050802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
