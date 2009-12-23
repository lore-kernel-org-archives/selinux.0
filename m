From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 08/13] libsemanage: get/set module info and enabled status
Date: Wed, 23 Dec 2009 18:25:55 -0500
Message-Id: <1261610760-4724-9-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-8-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
 <1261610760-4724-6-git-send-email-ccase@tresys.com>
 <1261610760-4724-7-git-send-email-ccase@tresys.com>
 <1261610760-4724-8-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This provides the functions for enabling/disabling modules via a
semanage_module_key_t and getting/setting module info.

Enabled/disabled status is indicated by the presence of an empty file in
the disabled directory:

/var/lib/selinux/<policy type>/disabled/<module name>

The presence of a file there indicates that the module is disabled at
all priorities. Enable/disabling of modules is done across all
priorities simultaneously to avoid confusion that would likely arise
from per priority settings.

semanage_module_get_module_info gathers up the on disk information about
a module indicated by the module key and puts the information into
module info. In order to facilitate an easy mechanism for getting the
highest priority module of a given name, the key's priority value may
be 0 and the highest priority module with the given name will be located.

semanage_direct_set_module_info is a helper function that writes module
info to disk. The unused attribute is used to suppress warnings for
compilation and is removed in the module install patch later in the
series.

semanage_module_list_all behaves similar to semanage_module_list except
it returns all modules at all priorities. semanage_module_list will only
include the highest priority, enabled, non-base modules (this is its
current behavior). See the module install patch later in the series for
the modified semanage_module_list.

Adds a helper function for creating a directory if it doesn't already
exist (used to automatically create the disabled, priority, and module
dirs).
---
 libsemanage/src/direct_api.c |  908 +++++++++++++++++++++++++++++++++++++++++-
 libsemanage/src/modules.c    |   83 ++++
 libsemanage/src/modules.h    |   44 ++
 libsemanage/src/policy.h     |   21 +
 4 files changed, 1055 insertions(+), 1 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e438b87..7964eaa 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -34,6 +34,7 @@
 #include <sys/types.h>
 #include <limits.h>
 #include <errno.h>
+#include <dirent.h>
 
 #include "user_internal.h"
 #include "seuser_internal.h"
@@ -70,6 +71,20 @@ static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
 				int *num_modules);
+static int semanage_direct_get_enabled(semanage_handle_t *sh,
+				       const semanage_module_key_t *modkey,
+				       int *enabled);
+static int semanage_direct_set_enabled(semanage_handle_t *sh,
+				       const semanage_module_key_t *modkey,
+				       int enabled);
+
+static int semanage_direct_get_module_info(semanage_handle_t *sh,
+					   const semanage_module_key_t *modkey,
+					   semanage_module_info_t **modinfo);
+
+static int semanage_direct_list_all(semanage_handle_t *sh,
+				    semanage_module_info_t **modinfo,
+				    int *num_modules);
 
 static struct semanage_policy_table direct_funcs = {
 	.get_serial = semanage_direct_get_serial,
@@ -84,7 +99,11 @@ static struct semanage_policy_table direct_funcs = {
 	.install_base = semanage_direct_install_base,
 	.install_base_file = semanage_direct_install_base_file,
 	.remove = semanage_direct_remove,
-	.list = semanage_direct_list
+	.list = semanage_direct_list,
+	.get_enabled = semanage_direct_get_enabled,
+	.set_enabled = semanage_direct_set_enabled,
+	.get_module_info = semanage_direct_get_module_info,
+	.list_all = semanage_direct_list_all,
 };
 
 int semanage_direct_is_managed(semanage_handle_t * sh)
@@ -1453,6 +1472,197 @@ static int semanage_direct_list(semanage_handle_t * sh,
 	return retval;
 }
 
+static int semanage_direct_get_enabled(semanage_handle_t *sh,
+				       const semanage_module_key_t *modkey,
+				       int *enabled)
+{
+	assert(sh);
+	assert(modkey);
+	assert(enabled);
+
+	int status = 0;
+	int ret = 0;
+
+	char path[PATH_MAX];
+	struct stat sb;
+	semanage_module_info_t *modinfo = NULL;
+
+	/* get module info */
+	ret = semanage_module_get_module_info(
+			sh,
+			modkey,
+			&modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get disabled file path */
+	ret = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_DISABLED,
+			path,
+			sizeof(path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	if (stat(path, &sb) < 0) {
+		*enabled = 1;
+	}
+	else {
+		*enabled = 0;
+	}
+
+cleanup:
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	return status;
+}
+
+static int semanage_direct_set_enabled(semanage_handle_t *sh,
+				       const semanage_module_key_t *modkey,
+				       int enabled)
+{
+	assert(sh);
+	assert(modkey);
+
+	int status = 0;
+	int ret = 0;
+
+	char fn[PATH_MAX];
+	const char *path = NULL;
+	FILE *fp = NULL;
+	semanage_module_info_t *modinfo = NULL;
+
+	/* check transaction */
+	if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	/* validate name */
+	ret = semanage_module_validate_name(modkey->name);
+	if (ret != 0) {
+		errno = 0;
+		ERR(sh, "Name %s is invalid.", modkey->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* validate enabled */
+	ret = semanage_module_validate_enabled(enabled);
+	if (ret != 0) {
+		errno = 0;
+		ERR(sh, "Enabled status %d is invalid.", enabled);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* check for base module */
+	if (strcmp(modkey->name, "_base") == 0) {
+		if (enabled == 0) {
+			errno = 0;
+			ERR(sh, "Base module cannot be disabled.");
+			status = -1;
+			goto cleanup;
+		}
+		else {
+			errno = 0;
+			WARN(sh, "Base module is always enabled, redundant enabling of base module requested.");
+		}
+	}
+
+	/* check for disabled path, create if missing */
+	path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES_DISABLED);
+
+	ret = semanage_mkdir(sh, path);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get module info */
+	ret = semanage_module_get_module_info(
+			sh,
+			modkey,
+			&modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get module disabled file */
+	ret = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_DISABLED,
+			fn,
+			sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	switch (enabled) {
+		case 0: /* disable the module */
+			fp = fopen(fn, "w");
+
+			if (fp == NULL) {
+				ERR(sh,
+				    "Unable to disable module %s",
+				    modkey->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			if (fclose(fp) != 0) {
+				ERR(sh,
+				    "Unable to close disabled file for module %s",
+				    modkey->name);
+				status = -1;
+				goto cleanup;
+			}
+
+			fp = NULL;
+
+			break;
+		case 1: /* enable the module */
+			if (unlink(fn) < 0) {
+				if (errno != ENOENT) {
+					ERR(sh,
+					    "Unable to enable module %s",
+					    modkey->name);
+					status = -1;
+					goto cleanup;
+				}
+				else {
+					/* module already enabled */
+					errno = 0;
+				}
+			}
+
+			break;
+		case -1: /* warn about ignored setting to default */
+			WARN(sh,
+			     "Setting module %s to 'default' state has no effect",
+			     modkey->name);
+			break;
+	}
+
+cleanup:
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	if (fp != NULL) fclose(fp);
+	return status;
+}
+
 int semanage_direct_access_check(semanage_handle_t * sh)
 {
 	if (semanage_check_init(sh, semanage_root_path()))
@@ -1479,3 +1689,699 @@ cleanup:
 	sepol_policydb_free(p);
 	return retval;
 }
+
+static int semanage_direct_get_module_info(semanage_handle_t *sh,
+					   const semanage_module_key_t *modkey,
+					   semanage_module_info_t **modinfo)
+{
+	assert(sh);
+	assert(modkey);
+	assert(modinfo);
+
+	int status = 0;
+	int ret = 0;
+
+	char fn[PATH_MAX];
+	FILE *fp = NULL;
+	const char *modules_path = NULL;
+	size_t size = 0;
+	struct stat sb;
+	char *tmp = NULL;
+
+	int i = 0;
+
+	semanage_module_info_t *modinfos = NULL;
+	int modinfos_len = 0;
+	semanage_module_info_t *highest = NULL;
+
+	if (sh->is_in_transaction) {
+		modules_path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
+	} else {
+		modules_path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	}
+
+	/* check module name */
+	ret = semanage_module_validate_name(modkey->name);
+	if (ret < 0) {
+		errno = 0;
+		ERR(sh, "Name %s is invalid.", modkey->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* if priority == 0, then find the highest priority available */
+	if (modkey->priority == 0) {
+		ret = semanage_direct_list_all(sh, &modinfos, &modinfos_len);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		for (i = 0; i < modinfos_len; i++) {
+			ret = strcmp(modinfos[i].name, modkey->name);
+			if (ret == 0) {
+				highest = &modinfos[i];
+				break;
+			}
+		}
+
+		if (highest == NULL) {
+			status = -1;
+			goto cleanup;
+		}
+
+		ret = semanage_module_info_create(sh, modinfo);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		ret = semanage_module_info_clone(sh, highest, *modinfo);
+		if (ret != 0) {
+			status = -1;
+		}
+
+		/* skip to cleanup, module was found */
+		goto cleanup;
+	}
+
+	/* check module priority */
+	ret = semanage_module_validate_priority(modkey->priority);
+	if (ret != 0) {
+		errno = 0;
+		ERR(sh, "Priority %d is invalid.", modkey->priority);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* copy in key values */
+	ret = semanage_module_info_create(sh, modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_priority(sh, *modinfo, modkey->priority);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_name(sh, *modinfo, modkey->name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* lookup module ext */
+	ret = semanage_module_get_path(sh,
+				       *modinfo,
+				       SEMANAGE_MODULE_PATH_LANG_EXT,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = fopen(fn, "r");
+
+	if (fp == NULL) {
+		ERR(sh,
+		    "Unable to open %s module lang ext file at %s.",
+		    (*modinfo)->name, fn);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* set module ext */
+	if (getline(&tmp, &size, fp) < 0) {
+		ERR(sh,
+		    "Unable to read %s module lang ext file.",
+		    (*modinfo)->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_lang_ext(sh, *modinfo, tmp);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+	free(tmp);
+	tmp = NULL;
+
+	if (fclose(fp) != 0) {
+		ERR(sh,
+		    "Unable to close %s module lang ext file.",
+		    (*modinfo)->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = NULL;
+
+	/* lookup module version */
+	ret = semanage_module_get_path(sh,
+				       *modinfo,
+				       SEMANAGE_MODULE_PATH_VERSION,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = fopen(fn, "r");
+
+	if (fp == NULL) {
+		ERR(sh,
+		    "Unable to open %s module version file.",
+		    (*modinfo)->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* set module version */
+	if (getline(&tmp, &size, fp) < 0) {
+		ERR(sh,
+		    "Unable to read %s module version file.",
+		    (*modinfo)->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_info_set_version(sh, (*modinfo), tmp);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+	free(tmp);
+	tmp = NULL;
+
+	if (fclose(fp) != 0) {
+		ERR(sh,
+		    "Unable to close %s module version file.",
+		    (*modinfo)->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = NULL;
+
+	/* lookup enabled/disabled status */
+	ret = semanage_module_get_path(sh,
+				       *modinfo,
+				       SEMANAGE_MODULE_PATH_DISABLED,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* set enabled/disabled status */
+	if (stat(fn, &sb) < 0) {
+		ret = semanage_module_info_set_enabled(sh, *modinfo, 1);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+	}
+	else {
+		ret = semanage_module_info_set_enabled(sh, *modinfo, 0);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	free(tmp);
+
+	if (modinfos != NULL) {
+		for (i = 0; i < modinfos_len; i++) {
+			semanage_module_info_destroy(sh, &modinfos[i]);
+		}
+		free(modinfos);
+	}
+
+	if (fp != NULL) fclose(fp);
+	return status;
+}
+
+__attribute__ ((unused))
+static int semanage_direct_set_module_info(semanage_handle_t *sh,
+					   const semanage_module_info_t *modinfo)
+{
+	int status = 0;
+	int ret = 0;
+
+	char fn[PATH_MAX];
+	const char *path = NULL;
+	FILE *fp = NULL;
+	int enabled = 0;
+
+	semanage_module_key_t modkey;
+	ret = semanage_module_key_init(sh, &modkey);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_module_info_t *modinfo_tmp = NULL;
+
+	/* check transaction */
+	if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	/* validate module */
+	ret = semanage_module_info_validate(modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* check for base module */
+	if (strcmp(modinfo->name, "_base") == 0) {
+		if (modinfo->enabled == 0) {
+			errno = 0;
+			ERR(sh, "Base module cannot be disabled.");
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	sh->modules_modified = 1;
+
+	/* check for modules path, create if missing */
+	path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
+
+	ret = semanage_mkdir(sh, path);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* write priority */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_PRIORITY,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_mkdir(sh, fn);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* write name */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_NAME,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_mkdir(sh, fn);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* write ext */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_LANG_EXT,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = fopen(fn, "w");
+
+	if (fp == NULL) {
+		ERR(sh, "Unable to open %s module ext file.", modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	if (fputs(modinfo->lang_ext, fp) < 0) {
+		ERR(sh, "Unable to write %s module ext file.", modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	if (fclose(fp) != 0) {
+		ERR(sh, "Unable to close %s module ext file.", modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = NULL;
+
+	/* write version */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_VERSION,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = fopen(fn, "w");
+
+	if (fp == NULL) {
+		ERR(sh,
+		    "Unable to open %s module version file.",
+		    modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	if (fputs(modinfo->version, fp) < 0) {
+		ERR(sh,
+		    "Unable to write %s module version file.",
+		    modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	if (fclose(fp) != 0) {
+		ERR(sh,
+		    "Unable to close %s module version file.",
+		    modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	fp = NULL;
+
+	/* write enabled/disabled status */
+
+	/* check for disabled path, create if missing */
+	path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES_DISABLED);
+
+	ret = semanage_mkdir(sh, path);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_DISABLED,
+				       fn,
+				       sizeof(fn));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_module_key_set_name(sh, &modkey, modinfo->name);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	if (modinfo->enabled == -1) {
+		/* default to enabled */
+		enabled = 1;
+
+		/* check if a module is already installed */
+		ret = semanage_module_get_module_info(sh,
+						      &modkey,
+						      &modinfo_tmp);
+		if (ret == 0) {
+			/* set enabled status to current one */
+			enabled = modinfo_tmp->enabled;
+		}
+	}
+	else {
+		enabled = modinfo->enabled;
+	}
+
+	ret = semanage_module_set_enabled(sh, &modkey, enabled);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	if (fp != NULL) fclose(fp);
+
+	semanage_module_key_destroy(sh, &modkey);
+
+	semanage_module_info_destroy(sh, modinfo_tmp);
+	free(modinfo_tmp);
+
+	return status;
+}
+
+static int semanage_priorities_filename_select(const struct dirent *d)
+{
+	if (d->d_name[0] == '.' ||
+	    strcmp(d->d_name, "disabled") == 0)
+		return 0;
+	return 1;
+}
+
+static int semanage_modules_filename_select(const struct dirent *d)
+{
+	if (d->d_name[0] == '.')
+		return 0;
+	return 1;
+}
+
+static int semanage_direct_list_all(semanage_handle_t *sh,
+				    semanage_module_info_t **modinfos,
+				    int *modinfos_len)
+{
+	assert(sh);
+	assert(modinfos);
+	assert(modinfos_len);
+
+	int status = 0;
+	int ret = 0;
+
+	int i = 0;
+	int j = 0;
+
+	*modinfos = NULL;
+	*modinfos_len = 0;
+	void *tmp = NULL;
+
+	const char *toplevel = NULL;
+
+	struct dirent **priorities = NULL;
+	int priorities_len = 0;
+	char priority_path[PATH_MAX];
+
+	struct dirent **modules = NULL;
+	int modules_len = 0;
+
+	uint16_t priority = 0;
+
+	semanage_module_info_t modinfo;
+	ret = semanage_module_info_init(sh, &modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_module_info_t *modinfo_tmp = NULL;
+
+	if (sh->is_in_transaction) {
+		toplevel = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
+	} else {
+		toplevel = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	}
+
+	/* find priorities */
+	priorities_len = scandir(toplevel,
+				 &priorities,
+				 semanage_priorities_filename_select,
+				 versionsort);
+	if (priorities_len == -1) {
+		ERR(sh, "Error while scanning directory %s.", toplevel);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* for each priority directory */
+	/* loop through in reverse so that highest priority is first */
+	for (i = priorities_len - 1; i >= 0; i--) {
+		/* convert priority string to uint16_t */
+		ret = semanage_string_to_priority(priorities[i]->d_name,
+						  &priority);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* set our priority */
+		ret = semanage_module_info_set_priority(sh,
+							&modinfo,
+							priority);
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* get the priority path */
+		ret = semanage_module_get_path(sh,
+					       &modinfo,
+					       SEMANAGE_MODULE_PATH_PRIORITY,
+					       priority_path,
+					       sizeof(priority_path));
+		if (ret != 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* cleanup old modules */
+		if (modules != NULL) {
+			for (j = 0; j < modules_len; j++) {
+				free(modules[j]);
+				modules[j] = NULL;
+			}
+			free(modules);
+			modules = NULL;
+			modules_len = 0;
+		}
+
+		/* find modules at this priority */
+		modules_len = scandir(priority_path,
+				      &modules,
+				      semanage_modules_filename_select,
+				      versionsort);
+		if (modules_len == -1) {
+			ERR(sh,
+			    "Error while scanning directory %s.",
+			    priority_path);
+			status = -1;
+			goto cleanup;
+		}
+
+		if (modules_len == 0) continue;
+
+		/* add space for modules */
+		tmp = realloc(*modinfos,
+			      sizeof(semanage_module_info_t) *
+				(*modinfos_len + modules_len));
+		if (tmp == NULL) {
+			ERR(sh, "Error allocating memory for module array.");
+			status = -1;
+			goto cleanup;
+		}
+		*modinfos = tmp;
+
+		/* for each module directory */
+		for(j = 0; j < modules_len; j++) {
+			/* set module name */
+			ret = semanage_module_info_set_name(
+					sh,
+					&modinfo,
+					modules[j]->d_name);
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+
+			/* get module values */
+			ret = semanage_direct_get_module_info(
+					sh,
+					(const semanage_module_key_t *)
+						(&modinfo),
+					&modinfo_tmp);
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+
+			/* copy into array */
+			ret = semanage_module_info_init(
+					sh,
+					&((*modinfos)[*modinfos_len]));
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_info_clone(
+					sh,
+					modinfo_tmp,
+					&((*modinfos)[*modinfos_len]));
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+
+			ret = semanage_module_info_destroy(sh, modinfo_tmp);
+			if (ret != 0) {
+				status = -1;
+				goto cleanup;
+			}
+			free(modinfo_tmp);
+			modinfo_tmp = NULL;
+
+			*modinfos_len += 1;
+		}
+	}
+
+cleanup:
+	semanage_module_info_destroy(sh, &modinfo);
+
+	if (priorities != NULL) {
+		for (i = 0; i < priorities_len; i++) {
+			free(priorities[i]);
+		}
+		free(priorities);
+	}
+
+	if (modules != NULL) {
+		for (i = 0; i < modules_len; i++) {
+			free(modules[i]);
+		}
+		free(modules);
+	}
+
+	ret = semanage_module_info_destroy(sh, modinfo_tmp);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+	free(modinfo_tmp);
+	modinfo_tmp = NULL;
+
+	if (status != 0) {
+		if (modinfos != NULL) {
+			for (i = 0; i < *modinfos_len; i++) {
+				semanage_module_info_destroy(
+						sh, 
+						&(*modinfos)[i]);
+			}
+			free(*modinfos);
+			*modinfos = NULL;
+			*modinfos_len = 0;
+		}
+	}
+
+	return status;
+}
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index df0f15c..3f7b652 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -819,6 +819,49 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
 	return 0;
 }
 
+int semanage_module_get_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int *enabled)
+{
+	assert(sh);
+	assert(modkey);
+	assert(enabled);
+
+	if (sh->funcs->get_enabled == NULL) {
+		ERR(sh,
+		    "No get_enabled function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+
+	return sh->funcs->get_enabled(sh, modkey, enabled);
+}
+
+int semanage_module_set_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int enabled)
+{
+	assert(sh);
+	assert(modkey);
+
+	if (sh->funcs->set_enabled == NULL) {
+		ERR(sh,
+		    "No set_enabled function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+
+	sh->modules_modified = 1;
+	return sh->funcs->set_enabled(sh, modkey, enabled);
+}
 
 /* Converts a string to a priority
  *
@@ -1028,3 +1071,43 @@ exit:
 	return status;
 }
 
+int semanage_module_get_module_info(semanage_handle_t *sh,
+				    const semanage_module_key_t *modkey,
+				    semanage_module_info_t **modinfo)
+{
+	assert(sh);
+	assert(modkey);
+	assert(modinfo);
+
+	if (sh->funcs->get_module_info == NULL) {
+		ERR(sh,
+		    "No get module info function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+
+	return sh->funcs->get_module_info(sh, modkey, modinfo);
+}
+
+int semanage_module_list_all(semanage_handle_t *sh,
+			     semanage_module_info_t **modinfos,
+			     int *modinfos_len)
+{
+	assert(sh);
+	assert(modinfos);
+	assert(modinfos_len);
+
+	if (sh->funcs->list_all == NULL) {
+		ERR(sh,
+		    "No list all function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+
+	return sh->funcs->list_all(sh, modinfos, modinfos_len);
+}
+
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 7bed3ef..8b5b9b8 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -255,4 +255,48 @@ int semanage_module_get_path(semanage_handle_t *sh,
 			     char *path,
 			     size_t len);
 
+/* Module Enabled */
+
+/* Get module @enabled status from @modkey. Modules are enabled on a per
+ * module name basis (across all priorities). @modkey only needs to have
+ * name set (priority is ignored).
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_get_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int *enabled);
+
+/* Set module @enabled status from @modkey. Modules are enabled on a per
+ * module name basis (across all priorities). @modkey only needs to have
+ * name set (priority is ignored).
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_set_enabled(semanage_handle_t *sh,
+				const semanage_module_key_t *modkey,
+				int enabled);
+
+/* Lookup @modinfo by @modkey. Caller should use
+ * semanage_module_info_destroy and free on @modinfo.
+ * 
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_get_module_info(semanage_handle_t *sh,
+				    const semanage_module_key_t *modkey,
+				    semanage_module_info_t **modinfo);
+
+/* Create a list of all modules in @modinfos of length @modinfos_len.
+ * The list will be sorted from high priority to low and alphabetically
+ * by module name within a priority.
+ *
+ * Caller should use semanage_module_info_destroy on each modinfo in
+ * @modinfos and free on @modinfos.
+ *
+ * Returns 0 on success and -1 on error.
+ */
+int semanage_module_list_all(semanage_handle_t *sh,
+			     semanage_module_info_t **modinfos,
+			     int *modinfos_len);
+
 #endif
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index ebefc02..d232ba8 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -70,6 +70,27 @@ struct semanage_policy_table {
 
 	/* Install a base module */
 	int (*install_base_file) (struct semanage_handle *, const char *);
+
+	/* Get module enabled status */
+	int (*get_enabled) (struct semanage_handle *sh,
+			    const semanage_module_key_t *key,
+			    int *enabled);
+
+	/* Set module enabled status */
+	int (*set_enabled) (struct semanage_handle *sh,
+			    const semanage_module_key_t *key,
+			    int enabled);
+
+	/* Get a module info */
+	int (*get_module_info) (struct semanage_handle *,
+				const semanage_module_key_t *,
+				semanage_module_info_t **);
+
+	/* List all policy modules */
+	int (*list_all) (struct semanage_handle *,
+			 semanage_module_info_t **,
+			 int *);
+
 };
 
 /* Should be backend independent */
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
