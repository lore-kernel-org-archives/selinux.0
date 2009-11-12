Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nACGjMbB015699
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 11:45:22 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nACGiLCC002625
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 16:44:22 GMT
Message-ID: <4AFC3B9F.6070802@redhat.com>
Date: Thu, 12 Nov 2009 11:45:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add modules support to semanage
References: <C7207217.AFD8F%csellers@tresys.com>
In-Reply-To: <C7207217.AFD8F%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------040404080405040108030201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040404080405040108030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/11/2009 01:52 PM, Chad Sellers wrote:
> On 9/30/09 2:33 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> Includes enable and disable.
>>
> I presume I should hold off on this patch until you have a chance to
> resubmit the libsemanage support that it relies on. Let me know if that's
> not the case.
> 
> Thanks,
> Chad
> 

This patch is provided the old fashioned way since I am fighting with guilt right now.

Just the enable/disable changes to libsemanage.

--------------040404080405040108030201
Content-Type: text/plain;
 name="libsemanage-disable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-disable.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/modules.h libsemanage-2.0.41/include/semanage/modules.h
--- nsalibsemanage/include/semanage/modules.h	2009-01-13 08:45:35.000000000 -0500
+++ libsemanage-2.0.41/include/semanage/modules.h	2009-11-12 11:01:10.000000000 -0500
@@ -40,10 +40,12 @@
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
@@ -53,5 +55,6 @@
 						 int n);
 const char *semanage_module_get_name(semanage_module_info_t *);
 const char *semanage_module_get_version(semanage_module_info_t *);
+int semanage_module_get_enabled(semanage_module_info_t *);
 
 #endif
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.41/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2009-09-17 08:59:43.000000000 -0400
+++ libsemanage-2.0.41/src/direct_api.c	2009-11-12 11:01:10.000000000 -0500
@@ -66,6 +66,8 @@
 static int semanage_direct_install_base(semanage_handle_t * sh, char *base_data,
 					size_t data_len);
 static int semanage_direct_install_base_file(semanage_handle_t * sh, const char *module_name);
+static int semanage_direct_enable(semanage_handle_t * sh, char *module_name);
+static int semanage_direct_disable(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -83,6 +85,8 @@
 	.upgrade_file = semanage_direct_upgrade_file,
 	.install_base = semanage_direct_install_base,
 	.install_base_file = semanage_direct_install_base_file,
+	.enable = semanage_direct_enable,
+	.disable = semanage_direct_disable,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list
 };
@@ -348,10 +352,17 @@
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
 
@@ -1273,6 +1284,107 @@
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
@@ -1293,8 +1405,7 @@
 			goto cleanup;
 		}
 		base++;
-		if (memcmp(module_name, base, name_len) == 0 &&
-		    strcmp(base + name_len, ".pp") == 0) {
+		if (memcmp(module_name, base, name_len) == 0) {
 			if (unlink(module_filenames[i]) == -1) {
 				ERR(sh, "Could not remove module file %s.",
 				    module_filenames[i]);
@@ -1369,6 +1480,7 @@
 		}
 		ssize_t size;
 		char *data = NULL;
+		int enabled = semanage_module_enabled(module_filenames[i]);
 
 		if ((size = bunzip(sh, fp, &data)) > 0) {
 			fclose(fp);
@@ -1393,6 +1505,7 @@
 		if (type == SEPOL_POLICY_MOD) {
 			(*modinfo)[*num_modules].name = name;
 			(*modinfo)[*num_modules].version = version;
+			(*modinfo)[*num_modules].enabled = enabled;
 			(*num_modules)++;
 		} else {
 			/* file was not a module, so don't report it */
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/libsemanage.map libsemanage-2.0.41/src/libsemanage.map
--- nsalibsemanage/src/libsemanage.map	2009-10-29 15:21:39.000000000 -0400
+++ libsemanage-2.0.41/src/libsemanage.map	2009-11-12 11:01:10.000000000 -0500
@@ -6,10 +6,13 @@
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/module_internal.h libsemanage-2.0.41/src/module_internal.h
--- nsalibsemanage/src/module_internal.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.41/src/module_internal.h	2009-11-12 11:01:10.000000000 -0500
@@ -6,6 +6,7 @@
 
 hidden_proto(semanage_module_get_name)
     hidden_proto(semanage_module_get_version)
+    hidden_proto(semanage_module_get_enabled)
     hidden_proto(semanage_module_info_datum_destroy)
     hidden_proto(semanage_module_list_nth)
 #endif
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/modules.c libsemanage-2.0.41/src/modules.c
--- nsalibsemanage/src/modules.c	2009-09-17 08:59:43.000000000 -0400
+++ libsemanage-2.0.41/src/modules.c	2009-11-12 11:01:10.000000000 -0500
@@ -154,6 +154,40 @@
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
@@ -209,6 +243,13 @@
 
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/modules.h libsemanage-2.0.41/src/modules.h
--- nsalibsemanage/src/modules.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.41/src/modules.h	2009-11-12 11:01:10.000000000 -0500
@@ -26,6 +26,7 @@
 struct semanage_module_info {
 	char *name;		/* Key */
 	char *version;
+	int enabled;
 };
 
 #endif
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/policy.h libsemanage-2.0.41/src/policy.h
--- nsalibsemanage/src/policy.h	2009-01-13 08:45:35.000000000 -0500
+++ libsemanage-2.0.41/src/policy.h	2009-11-12 11:01:10.000000000 -0500
@@ -58,6 +58,12 @@
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
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.41/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2009-10-29 15:21:39.000000000 -0400
+++ libsemanage-2.0.41/src/semanage_store.c	2009-11-12 11:01:10.000000000 -0500
@@ -57,6 +57,8 @@
 
 #include "debug.h"
 
+const char *DISABLESTR=".disabled";
+
 #define SEMANAGE_CONF_FILE "semanage.conf"
 /* relative path names to enum semanage_paths to special files and
  * directories for the module store */
@@ -433,6 +435,21 @@
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
@@ -599,15 +616,8 @@
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
@@ -622,7 +632,7 @@
 	*filenames = NULL;
 	*len = 0;
 	if ((num_files = scandir(modules_path, &namelist,
-				 semanage_filename_select, alphasort)) == -1) {
+				 filter, alphasort)) == -1) {
 		ERR(sh, "Error while scanning directory %s.", modules_path);
 		goto cleanup;
 	}
@@ -663,6 +673,34 @@
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
@@ -1589,7 +1627,7 @@
 	}
 
 	/* get list of modules and load them */
-	if (semanage_get_modules_names(sh, &module_filenames, &num_modules) ==
+	if (semanage_get_active_modules_names(sh, &module_filenames, &num_modules) ==
 	    -1 || semanage_load_module(sh, base_filename, base) == -1) {
 		goto cleanup;
 	}
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h libsemanage-2.0.41/src/semanage_store.h
--- nsalibsemanage/src/semanage_store.h	2009-07-07 15:32:32.000000000 -0400
+++ libsemanage-2.0.41/src/semanage_store.h	2009-11-12 11:01:10.000000000 -0500
@@ -128,4 +128,6 @@
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
+extern const char *DISABLESTR;
+
 #endif

--------------040404080405040108030201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
