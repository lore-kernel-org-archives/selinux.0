From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 10/15] [src-policy] libsemanage: get source module
Date: Tue, 26 Jan 2010 17:08:16 -0500
Message-Id: <1264543701-20638-11-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-10-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
 <1264543701-20638-9-git-send-email-ccase@tresys.com>
 <1264543701-20638-10-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This provides the semanage_module_get and semanage_module_get_cil
interfaces for retrieving the original source module and the
intermediate compilation result. These functions are exported in the
private API so that they can be used by semodule.
---
 libsemanage/include/semanage/private/modules.h |   28 +++++-
 libsemanage/src/direct_api.c                   |  150 ++++++++++++++++++++++++
 libsemanage/src/libsemanage.map                |    2 +
 libsemanage/src/modules.c                      |   34 ++++++
 libsemanage/src/policy.h                       |   15 +++-
 5 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/libsemanage/include/semanage/private/modules.h b/libsemanage/include/semanage/private/modules.h
index 2ffaa5b..8a2ed99 100644
--- a/libsemanage/include/semanage/private/modules.h
+++ b/libsemanage/include/semanage/private/modules.h
@@ -1,6 +1,6 @@
 /* Authors:	Caleb Case	<ccase@tresys.com>
  *
- * Copyright (C) 2009 Tresys Technology, LLC
+ * Copyright (C) 2009-2010 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -278,4 +278,30 @@ int semanage_module_upgrade_info(semanage_handle_t *sh,
 int semanage_module_remove_key(semanage_handle_t *sh,
 			       const semanage_module_key_t *modkey);
 
+/* Get the source for the module specified @modkey.
+ * @modkey must have key values filled in.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, @modkey not found
+ */
+int semanage_module_get(semanage_handle_t *sh,
+			const semanage_module_key_t *modkey,
+			char **data,
+			size_t *data_len);
+
+/* Get the cil for the module specified @modkey.
+ * @modkey must have key values filled in.
+ *
+ * Returns:
+ *	 0	success
+ *	-1	failure, out of memory
+ *	-2	failure, @modkey not found
+ */
+int semanage_module_get_cil(semanage_handle_t *sh,
+			    const semanage_module_key_t *modkey,
+			    char **data,
+			    size_t *data_len);
+
 #endif
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 6f7cf63..ee6f70f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -92,6 +92,16 @@ static int semanage_direct_upgrade_info(semanage_handle_t *sh,
 static int semanage_direct_remove_key(semanage_handle_t *sh,
 				      const semanage_module_key_t *modkey);
 
+static int semanage_direct_get(semanage_handle_t *sh,
+			       const semanage_module_key_t *modkey,
+			       char **data,
+			       size_t *data_len);
+
+static int semanage_direct_get_cil(semanage_handle_t *sh,
+				   const semanage_module_key_t *modkey,
+				   char **data,
+				   size_t *data_len);
+
 static struct semanage_policy_table direct_funcs = {
 	.get_serial = semanage_direct_get_serial,
 	.destroy = semanage_direct_destroy,
@@ -113,6 +123,8 @@ static struct semanage_policy_table direct_funcs = {
 	.install_info = semanage_direct_install_info,
 	.upgrade_info = semanage_direct_upgrade_info,
 	.remove_key = semanage_direct_remove_key,
+	.get = semanage_direct_get,
+	.get_cil = semanage_direct_get_cil,
 };
 
 int semanage_direct_is_managed(semanage_handle_t * sh)
@@ -2498,3 +2510,141 @@ cleanup:
 	return status;
 }
 
+static int semanage_direct_get(semanage_handle_t *sh,
+			       const semanage_module_key_t *modkey,
+			       char **data,
+			       size_t *data_len)
+{
+	assert(sh);
+	assert(modkey);
+	assert(data);
+	assert(data_len);
+
+	int status = 0;
+	int ret = 0;
+
+	semanage_module_info_t *modinfo = NULL;
+	char path[PATH_MAX];
+	int fd = -1;
+
+	/* Get module info. */
+	ret = semanage_module_get_module_info(
+			sh,
+			modkey,
+			&modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Get module path source path. */
+	ret = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_HLL,
+			path,
+			sizeof(path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Open file. */
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		ERR(sh, "Failed to open file %s.", path);
+		status = -2;
+		goto cleanup;
+	}
+
+	/* Read file into buffer. */
+	ret = semanage_fd_to_data(sh, fd, data, data_len);
+	if (ret != 0) {
+		status = ret;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) {
+		free(*data);
+		*data = NULL;
+		*data_len = 0;
+	}
+
+	if (fd >= 0) close(fd);
+
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	return status;
+}
+
+static int semanage_direct_get_cil(semanage_handle_t *sh,
+				   const semanage_module_key_t *modkey,
+				   char **data,
+				   size_t *data_len)
+{
+	assert(sh);
+	assert(modkey);
+	assert(data);
+	assert(data_len);
+
+	int status = 0;
+	int ret = 0;
+
+	semanage_module_info_t *modinfo = NULL;
+	char path[PATH_MAX];
+	int fd = -1;
+
+	/* Get module info. */
+	ret = semanage_module_get_module_info(
+			sh,
+			modkey,
+			&modinfo);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Get module path source path. */
+	ret = semanage_module_get_path(
+			sh,
+			modinfo,
+			SEMANAGE_MODULE_PATH_CIL,
+			path,
+			sizeof(path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Open file. */
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		ERR(sh, "Failed to open file %s.", path);
+		status = -2;
+		goto cleanup;
+	}
+
+	/* Read file into buffer. */
+	ret = semanage_fd_to_data(sh, fd, data, data_len);
+	if (ret != 0) {
+		status = ret;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) {
+		free(*data);
+		*data = NULL;
+		*data_len = 0;
+	}
+
+	if (fd >= 0) close(fd);
+
+	semanage_module_info_destroy(sh, modinfo);
+	free(modinfo);
+
+	return status;
+}
+
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 1414ce5..64577a2 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -44,5 +44,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_install_info;
 	  semanage_module_upgrade_info;
 	  semanage_module_remove_key;
+	  semanage_module_get;
+	  semanage_module_get_cil;
   local: *;
 };
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index be30517..85d4e99 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -1215,3 +1215,37 @@ int semanage_module_remove_key(semanage_handle_t *sh,
 	return sh->funcs->remove_key(sh, modkey);
 }
 
+int semanage_module_get(semanage_handle_t *sh,
+			const semanage_module_key_t *modkey,
+			char **data,
+			size_t *data_len)
+{
+	if (sh->funcs->get == NULL) {
+		ERR(sh,
+		    "No get function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+
+	return sh->funcs->get(sh, modkey, data, data_len);
+}
+
+int semanage_module_get_cil(semanage_handle_t *sh,
+			    const semanage_module_key_t *modkey,
+			    char **data,
+			    size_t *data_len)
+{
+	if (sh->funcs->get_cil == NULL) {
+		ERR(sh,
+		    "No get cil function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	}
+
+	return sh->funcs->get_cil(sh, modkey, data, data_len);
+}
+
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index 397863f..d7047a3 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -1,7 +1,7 @@
 /* Author: Joshua Brindle <jbrindle@tresys.com>
  *         Jason Tang     <jtang@tresys.com>
  *
- * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2005,2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat Inc.
  *
  *  This library is free software; you can redistribute it and/or
@@ -106,6 +106,19 @@ struct semanage_policy_table {
 	/* Remove via module key */
 	int (*remove_key) (struct semanage_handle *,
 			   const semanage_module_key_t *);
+
+	/* Get module source */
+	int (*get) (semanage_handle_t *,
+		    const semanage_module_key_t *,
+		    char **,
+		    size_t *);
+
+	/* Get module cil */
+	int (*get_cil) (semanage_handle_t *,
+			const semanage_module_key_t *,
+			char **,
+			size_t *);
+
 };
 
 /* Should be backend independent */
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
