From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 07/13] libsemanage: augment semanage_module_info_t and provide semanage_module_key_t
Date: Wed, 23 Dec 2009 18:25:54 -0500
Message-Id: <1261610760-4724-8-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-7-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds priority, language ext, and enabled fields to
semanage_module_info_t.

Adds get/set functions for all semanage_module_info_t/key_t fields. This
is necessary so that semanage_module_info_t/key_t can be used in the
specifing meta data on source policies.

Adds create, destroy, and init functions for semanage_module_info_t and
semanage_module_key_t. Create initializes and allocates, destroy
deallocates fields (but not struct), and init initializes fields.

Provide several utility functions for converting a string priority to a
uint16_t and validating fields.

Adds semanage_module_get_path for getting module specific file paths.
---
 libsemanage/src/modules.c |  798 ++++++++++++++++++++++++++++++++++++++++++++-
 libsemanage/src/modules.h |  229 +++++++++++++-
 2 files changed, 1023 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index c7ae301..df0f15c 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -1,7 +1,8 @@
 /* Author: Joshua Brindle <jbrindle@tresys.co
  *	   Jason Tang	  <jtang@tresys.com>
+ *	   Caleb Case	  <ccase@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2005,2009 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -28,6 +29,13 @@
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <ctype.h>
 
 #include "handle.h"
 #include "modules.h"
@@ -187,8 +195,18 @@ int semanage_module_list(semanage_handle_t * sh,
 void semanage_module_info_datum_destroy(semanage_module_info_t * modinfo)
 {
 	if (modinfo != NULL) {
+		modinfo->priority = 0;
+
 		free(modinfo->name);
+		modinfo->name = NULL;
+
 		free(modinfo->version);
+		modinfo->version = NULL;
+
+		free(modinfo->lang_ext);
+		modinfo->lang_ext = NULL;
+
+		modinfo->enabled = -1;
 	}
 }
 
@@ -216,6 +234,642 @@ const char *semanage_module_get_version(semanage_module_info_t * modinfo)
 
 hidden_def(semanage_module_get_version)
 
+int semanage_module_info_create(semanage_handle_t *sh,
+				semanage_module_info_t **modinfo)
+{
+	assert(sh);
+	assert(modinfo);
+
+	*modinfo = malloc(sizeof(semanage_module_info_t));
+	if (*modinfo == NULL) return -1;
+
+	return semanage_module_info_init(sh, *modinfo);
+}
+
+int semanage_module_info_destroy(semanage_handle_t *sh,
+				 semanage_module_info_t *modinfo)
+{
+	assert(sh);
+
+	if (!modinfo) {
+		return 0;
+	}
+
+	free(modinfo->name);
+	free(modinfo->version);
+	free(modinfo->lang_ext);
+
+	return semanage_module_info_init(sh, modinfo);
+}
+
+int semanage_module_info_init(semanage_handle_t *sh,
+			      semanage_module_info_t *modinfo)
+{
+	assert(sh);
+	assert(modinfo);
+
+	modinfo->priority = 0;
+	modinfo->name = NULL;
+	modinfo->version = NULL;
+	modinfo->lang_ext = NULL;
+	modinfo->enabled = -1;
+
+	return 0;
+}
+
+int semanage_module_info_clone(semanage_handle_t *sh,
+			       const semanage_module_info_t *source,
+			       semanage_module_info_t *target)
+{
+	assert(sh);
+	assert(source);
+	assert(target);
+
+	int status = 0;
+	int ret = 0;
+
+	ret = semanage_module_info_destroy(sh, target);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_priority(sh, target, source->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_name(sh, target, source->name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_version(sh, target, source->version);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(sh, target, source->lang_ext);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_enabled(sh, target, source->enabled);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) semanage_module_info_destroy(sh, target);
+	return status;
+}
+
+int semanage_module_info_get_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t *priority)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(priority);
+
+	*priority = modinfo->priority;
+
+	return 0;
+}
+
+int semanage_module_info_get_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char **name)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(name);
+
+	*name = modinfo->name;
+
+	return 0;
+}
+
+int semanage_module_info_get_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char **version)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(version);
+
+	*version = modinfo->version;
+
+	return 0;
+}
+
+int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char **lang_ext)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(lang_ext);
+
+	*lang_ext = modinfo->lang_ext;
+
+	return 0;
+}
+
+int semanage_module_info_get_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int *enabled)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(enabled);
+
+	*enabled = modinfo->enabled;
+
+	return 0;
+}
+
+int semanage_module_info_set_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t priority)
+{
+	assert(sh);
+	assert(modinfo);
+
+	/* Verify priority */
+	if (semanage_module_validate_priority(priority) < 0) {
+		errno = 0;
+		ERR(sh, "Priority %d is invalid.", priority);
+		return -1;
+	}
+
+	modinfo->priority = priority;
+
+	return 0;
+}
+
+int semanage_module_info_set_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char *name)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(name);
+
+	char * tmp;
+
+	/* Verify name */
+	if (semanage_module_validate_name(name) < 0) {
+		errno = 0;
+		ERR(sh, "Name %s is invalid.", name);
+		return -1;
+	}
+
+	tmp = strdup(name);
+	if (!tmp) {
+		return -1;
+	}
+
+	free(modinfo->name);
+	modinfo->name = tmp;
+
+	return 0;
+}
+
+int semanage_module_info_set_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char *version)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(version);
+
+	char * tmp;
+
+	/* Verify version */
+	if (semanage_module_validate_version(version) < 0) {
+		errno = 0;
+		ERR(sh, "Version %s is invalid.", version);
+		return -1;
+	}
+
+	tmp = strdup(version);
+	if (!tmp) {
+		return -1;
+	}
+
+	free(modinfo->version);
+	modinfo->version = tmp;
+
+	return 0;
+}
+
+int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char *lang_ext)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(lang_ext);
+
+	char * tmp;
+
+	/* Verify extension */
+	if (semanage_module_validate_lang_ext(lang_ext) < 0) {
+		errno = 0;
+		ERR(sh, "Language extensions %s is invalid.", lang_ext);
+		return -1;
+	}
+
+	tmp = strdup(lang_ext);
+	if (!tmp) {
+		return -1;
+	}
+
+	free(modinfo->lang_ext);
+	modinfo->lang_ext = tmp;
+
+	return 0;
+}
+
+int semanage_module_info_set_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int enabled)
+{
+	assert(sh);
+	assert(modinfo);
+
+	/* Verify enabled */
+	if (semanage_module_validate_enabled(enabled) < 0) {
+		errno = 0;
+		ERR(sh, "Enabled status %d is invalid.", enabled);
+		return -1;
+	}
+
+	modinfo->enabled = enabled;
+
+	return 0;
+}
+
+int semanage_module_get_path(semanage_handle_t *sh,
+			     const semanage_module_info_t *modinfo,
+			     enum semanage_module_path_type type,
+			     char *path,
+			     size_t len)
+{
+	assert(sh);
+	assert(modinfo);
+	assert(path);
+
+	int status = 0;
+	int ret = 0;
+
+	const char *modules_path = NULL;
+	const char *file = NULL;
+
+	modules_path = sh->is_in_transaction ?
+		semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES):
+		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+
+	switch (type) {
+		case SEMANAGE_MODULE_PATH_PRIORITY:
+			/* verify priority */
+			ret = semanage_module_validate_priority(modinfo->priority);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh,
+				    "Priority %d is invalid.",
+				    modinfo->priority);
+				status = ret;
+				goto cleanup;
+			}
+
+			ret = snprintf(path,
+				       len,
+				       "%s/%03u",
+				       modules_path,
+				       modinfo->priority);
+			if (ret < 0 || (size_t)ret >= len) {
+				ERR(sh, "Unable to compose priority path.");
+				status = -1;
+				goto cleanup;
+			}
+			break;
+		case SEMANAGE_MODULE_PATH_NAME:
+			/* verify priority and name */
+			ret = semanage_module_validate_priority(modinfo->priority);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh,
+				    "Priority %d is invalid.",
+				    modinfo->priority);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_validate_name(modinfo->name);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh, "Name %s is invalid.", modinfo->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = snprintf(path,
+				       len,
+				       "%s/%03u/%s",
+				       modules_path,
+				       modinfo->priority,
+				       modinfo->name);
+			if (ret < 0 || (size_t)ret >= len) {
+				ERR(sh, "Unable to compose name path.");
+				status = -1;
+				goto cleanup;
+			}
+			break;
+		case SEMANAGE_MODULE_PATH_HLL:
+			/* verify priority, name, and ext */
+			ret = semanage_module_validate_lang_ext(modinfo->lang_ext);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh,
+				    "Language extensions %s is invalid.",
+				    modinfo->lang_ext);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_validate_priority(modinfo->priority);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh,
+				    "Priority %d is invalid.",
+				    modinfo->priority);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_validate_name(modinfo->name);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh, "Name %s is invalid.", modinfo->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = snprintf(path,
+				       len,
+				       "%s/%03u/%s/%s.%s",
+				       modules_path,
+				       modinfo->priority,
+				       modinfo->name,
+				       modinfo->name,
+				       modinfo->lang_ext);
+			if (ret < 0 || (size_t)ret >= len) {
+				ERR(sh, "Unable to compose hll path.");
+				status = -1;
+				goto cleanup;
+			}
+			break;
+		case SEMANAGE_MODULE_PATH_CIL:
+			if (file == NULL) file = "cil";
+		case SEMANAGE_MODULE_PATH_LANG_EXT:
+			if (file == NULL) file = "lang_ext";
+		case SEMANAGE_MODULE_PATH_VERSION:
+			if (file == NULL) file = "version";
+
+			/* verify priority and name */
+			ret = semanage_module_validate_priority(modinfo->priority);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh,
+				    "Priority %d is invalid.",
+				    modinfo->priority);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_validate_name(modinfo->name);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh, "Name %s is invalid.", modinfo->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = snprintf(path,
+				       len,
+				       "%s/%03u/%s/%s",
+				       modules_path,
+				       modinfo->priority,
+				       modinfo->name,
+				       file);
+			if (ret < 0 || (size_t)ret >= len) {
+				ERR(sh,
+				    "Unable to compose path for %s file.",
+				    file);
+				status = -1;
+				goto cleanup;
+			}
+			break;
+		case SEMANAGE_MODULE_PATH_DISABLED:
+			/* verify name */
+			ret = semanage_module_validate_name(modinfo->name);
+			if (ret < 0) {
+				errno = 0;
+				ERR(sh, "Name %s is invalid.", modinfo->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = snprintf(path,
+				       len,
+				       "%s/disabled/%s",
+				       modules_path,
+				       modinfo->name);
+			if (ret < 0 || (size_t)ret >= len) {
+				ERR(sh,
+				    "Unable to compose disabled status path.");
+				status = -1;
+				goto cleanup;
+			}
+			break;
+		default:
+			ERR(sh, "Invalid module path type %d.", type);
+			status = -1;
+			goto cleanup;
+	}
+
+cleanup:
+	return status;
+}
+
+int semanage_module_key_create(semanage_handle_t *sh,
+			       semanage_module_key_t **modkey)
+{
+	assert(sh);
+	assert(modkey);
+
+	*modkey = malloc(sizeof(semanage_module_key_t));
+	if (*modkey == NULL) return -1;
+
+	return semanage_module_key_init(sh, *modkey);
+}
+
+int semanage_module_key_destroy(semanage_handle_t *sh,
+				semanage_module_key_t *modkey)
+{
+	assert(sh);
+
+	if (modkey) {
+		free(modkey->name);
+	}
+
+	return semanage_module_key_init(sh, modkey);
+}
+
+int semanage_module_key_init(semanage_handle_t *sh,
+			     semanage_module_key_t *modkey)
+{
+	assert(sh);
+	assert(modkey);
+
+	modkey->name = NULL;
+	modkey->priority = 0;
+
+	return 0;
+}
+
+int semanage_module_key_get_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char **name)
+{
+	assert(sh);
+	assert(modkey);
+	assert(name);
+
+	*name = modkey->name;
+
+	return 0;
+}
+
+int semanage_module_key_get_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t *priority)
+{
+	assert(sh);
+	assert(modkey);
+	assert(priority);
+
+	*priority = modkey->priority;
+
+	return 0;
+}
+
+int semanage_module_key_set_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char *name)
+{
+	assert(sh);
+	assert(modkey);
+	assert(name);
+
+	int status = 0;
+	char *tmp = NULL;
+
+	if (semanage_module_validate_name(name) < 0) {
+		errno = 0;
+		ERR(sh, "Name %s is invalid.", name);
+		return -1;
+	}
+
+	tmp = strdup(name);
+	if (tmp == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	free(modkey->name);
+	modkey->name = tmp;
+
+cleanup:
+	return status;
+}
+
+int semanage_module_key_set_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t priority)
+{
+	assert(sh);
+	assert(modkey);
+
+	if (semanage_module_validate_priority(priority) < 0) {
+		errno = 0;
+		ERR(sh, "Priority %d is invalid.", priority);
+		return -1;
+	}
+
+	modkey->priority = priority;
+
+	return 0;
+}
+
+
+/* Converts a string to a priority
+ *
+ * returns -1 if str is not a valid priority.
+ * returns 0 and sets priority if str is a valid priority
+ */
+int semanage_string_to_priority(const char *str, uint16_t *priority)
+{
+	unsigned long val;
+	char *endptr = NULL;
+	int status = -1;
+
+	if (str == NULL || priority == NULL) {
+		goto exit;
+	}
+
+	errno = 0;
+
+	val = strtoul(str, &endptr, 10);
+
+	if (errno != 0 || endptr == str || *endptr != '\0' || val > UINT16_MAX) {
+		goto exit;
+	}
+
+	if (semanage_module_validate_priority((uint16_t)val) < 0) {
+		goto exit;
+	}
+
+	*priority = val;
+	status = 0;
+
+exit:
+	return status;
+}
+
+/* Validates a module info struct.
+ *
+ * Returns -1 if module is invalid, 0 otherwise.
+ */
+int semanage_module_info_validate(const semanage_module_info_t *modinfo)
+{
+	if (semanage_module_validate_priority(modinfo->priority) != 0 ||
+	    semanage_module_validate_name(modinfo->name) != 0 ||
+	    semanage_module_validate_version(modinfo->version) != 0 ||
+	    semanage_module_validate_lang_ext(modinfo->lang_ext) != 0 ||
+	    semanage_module_validate_enabled(modinfo->enabled) != 0) {
+		return -1;
+	}
+	return 0;
+}
+
 #define PRIORITY_MIN 1
 #define PRIORITY_MAX 999
 
@@ -232,3 +886,145 @@ int semanage_module_validate_priority(uint16_t priority)
 	return -1;
 }
 
+/* Validates module name.
+ *
+ * A module name must match one of the following regular expressions
+ * to be considered valid:
+ *
+ * ^[a-zA-Z](\.?[a-zA-Z0-9_-])*$
+ * ^_base$
+ *
+ * returns -1 if name is not valid, returns 0 otherwise
+ */
+int semanage_module_validate_name(const char * name)
+{
+	int status = 0;
+
+	if (name == NULL) {
+		status = -1;
+		goto exit;
+	}
+
+	if (strcmp(name, "_base") == 0) {
+		goto exit;
+	}
+
+	if (!isalpha(*name)) {
+		status = -1;
+		goto exit;
+	}
+
+#define ISVALIDCHAR(c) (isalnum(c) || c == '_' || c == '-')
+
+	for (name++; *name; name++) {
+		if (ISVALIDCHAR(*name)) {
+			continue;
+		}
+		if (*name == '.' && name++ && ISVALIDCHAR(*name)) {
+			continue;
+		}
+		status = -1;
+		goto exit;
+	}
+
+#undef ISVALIDCHAR
+
+exit:
+	return status;
+}
+
+/* Validates module enabled status.
+ *
+ * Valid enabled values are 1, 0, and -1.
+ *
+ * returns 0 if enabled is a valid value, returns -1 otherwise.
+ */
+int semanage_module_validate_enabled(int enabled)
+{
+	if (enabled == 1 || enabled == 0 || enabled == -1) {
+		return 0;
+	}
+
+	return -1;
+}
+
+/* Validate extension.
+ *
+ * An extension must match the following regular expression to be
+ * considered valid:
+ *
+ * ^[a-zA-Z0-9][a-zA-Z0-9_-]*$
+ *
+ * returns 0 if ext is a valid value, returns -1 otherwise.
+ */
+int semanage_module_validate_lang_ext(const char *ext)
+{
+	int status = 0;
+
+	if (ext == NULL) {
+		status = -1;
+		goto exit;
+	}
+
+	if (!isalnum(*ext)) {
+		status = -1;
+		goto exit;
+	}
+
+#define ISVALIDCHAR(c) (isalnum(c) || c == '_' || c == '-')
+
+	for (ext++; *ext; ext++) {
+		if (ISVALIDCHAR(*ext)) {
+			continue;
+		}
+		status = -1;
+		goto exit;
+	}
+
+#undef ISVALIDCHAR
+
+exit:
+	return status;
+}
+
+/* Validate version.
+ *
+ * A version must match the following regular expression to be
+ * considered valid:
+ *
+ * ^[:print:]+$
+ *
+ * returns 0 if version is valid, returns -1 otherwise.
+ */
+int semanage_module_validate_version(const char *version)
+{
+	int status = 0;
+
+	if (version == NULL) {
+		status = -1;
+		goto exit;
+	}
+
+	/* must start with a printable char */
+	if (!isprint(*version)) {
+		status = -1;
+		goto exit;
+	}
+
+	/* everything else must be printable */
+#define ISVALIDCHAR(c) (isprint(c))
+
+	for (version++; *version; version++) {
+		if (ISVALIDCHAR(*version)) {
+			continue;
+		}
+		status = -1;
+		goto exit;
+	}
+
+#undef ISVALIDCHAR
+
+exit:
+	return status;
+}
+
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index cac567b..7bed3ef 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -1,7 +1,8 @@
 /* Author: Joshua Brindle <jbrindle@tresys.com>
  *         Jason Tang     <jtang@tresys.com>
+ *         Caleb Case     <ccase@tresys.com>
  *
- * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005,2009 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -25,11 +26,233 @@
 
 #include "module_internal.h"
 
+/* Module Info */
 struct semanage_module_info {
-	char *name;		/* Key */
-	char *version;
+	uint16_t priority;	/* key, module priority */
+	char *name;		/* key, module name */
+	char *version;		/* module version */
+	char *lang_ext;		/* module source language extension */
+	int enabled;		/* module enabled/disabled status */
 };
 
+/* Creates a module info struct.
+ *
+ * Returns 0 on success and -1 on failure.
+ *
+ * The @modinfo should be destroyed with semanage_module_info_destroy.
+ * The caller should call free() on the struct.
+ */
+int semanage_module_info_create(semanage_handle_t *sh,
+				semanage_module_info_t **modinfo);
+
+/* Frees the members of the module info struct.
+ *
+ * Returns 0 on success and -1 on failure.
+ *
+ * The caller should call free() on the struct.
+ */
+int semanage_module_info_destroy(semanage_handle_t *handle,
+				 semanage_module_info_t *modinfo);
+
+/* Initializes a pre-allocated module info struct.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_init(semanage_handle_t *sh,
+			      semanage_module_info_t *modinfo);
+
+/* Clones module info @source's members into module info @target.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_clone(semanage_handle_t *sh,
+			       const semanage_module_info_t *source,
+			       semanage_module_info_t *target);
+
+/* Module Info Getters */
+
+/* Get @priority from @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t *priority);
+
+/* Get @name from @modinfo. Caller should not free @name.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char **name);
+
+/* Get @version from @modinfo. Caller should not free @version.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char **version);
+
+/* Get @lang_ext from @modinfo. Caller should not free @lang_ext.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char **lang_ext);
+
+/* Get @enabled from @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_get_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int *enabled);
+
+/* Module Info Setters */
+
+/* Set @priority in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_priority(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      uint16_t priority);
+
+/* Set @name in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_name(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo,
+				  const char *name);
+
+/* Set @version in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_version(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     const char *version);
+
+/* Set @lang_ext in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
+				      semanage_module_info_t *modinfo,
+				      const char *lang_ext);
+
+/* Set @enabled in @modinfo.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_info_set_enabled(semanage_handle_t *sh,
+				     semanage_module_info_t *modinfo,
+				     int enabled);
+
+/* Convert a cstring to a priority.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_string_to_priority(const char *str, uint16_t *priority);
+
+int semanage_module_info_validate(const semanage_module_info_t *modinfo);
 int semanage_module_validate_priority(uint16_t priority);
+int semanage_module_validate_name(const char *name);
+int semanage_module_validate_enabled(int enabled);
+int semanage_module_validate_lang_ext(const char *ext);
+int semanage_module_validate_version(const char *version);
+
+/* Module Key */
+typedef struct semanage_module_key {
+	uint16_t priority;	/* module priority */
+	char *name;		/* module name */
+} semanage_module_key_t;
+
+/* Creates a module key struct.
+ *
+ * Return 0 on success, and -1 on error.
+ *
+ * The @modkey should be destroyed with semanage_module_key_destroy.
+ * The caller should call free() on the struct.
+ */
+int semanage_module_key_create(semanage_handle_t *sh,
+			       semanage_module_key_t **modkey);
+
+/* Frees members of the @modkey, but not the struct. The caller should
+ * call free() on struct.
+ *
+ * Returns 0 on success, and -1 on error.
+ */
+int semanage_module_key_destroy(semanage_handle_t *sh,
+				semanage_module_key_t *modkey);
+
+/* Initializes a pre-allocated module key struct.
+ *
+ * Returns 0 on success, and -1 on error.
+ */
+int semanage_module_key_init(semanage_handle_t *sh,
+			     semanage_module_key_t *modkey);
+
+/* Module Key Getters */
+
+/* Get @name from @modkey. Caller should not free @name.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_get_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char **name);
+
+/* Get @name from @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_get_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t *priority);
+
+/* Module Key Setters */
+
+/* Set @name in @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_set_name(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey,
+				 const char *name);
+
+/* Set @priority in @modkey.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_key_set_priority(semanage_handle_t *sh,
+				     semanage_module_key_t *modkey,
+				     uint16_t priority);
+
+/* Module Paths */
+
+enum semanage_module_path_type {
+	SEMANAGE_MODULE_PATH_PRIORITY,
+	SEMANAGE_MODULE_PATH_NAME,
+	SEMANAGE_MODULE_PATH_HLL,
+	SEMANAGE_MODULE_PATH_CIL,
+	SEMANAGE_MODULE_PATH_LANG_EXT,
+	SEMANAGE_MODULE_PATH_VERSION,
+	SEMANAGE_MODULE_PATH_DISABLED,
+};
+
+/* Get the module path for the given path @type.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_get_path(semanage_handle_t *sh,
+			     const semanage_module_info_t *module,
+			     enum semanage_module_path_type type,
+			     char *path,
+			     size_t len);
 
 #endif
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
