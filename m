Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUhJi001740
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:43 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUgJc002879
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:42 GMT
Message-Id: <20070423213741.907065000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:17 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 22/33] libsemanage: module serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/modules.h |   11 ++
 libsemanage/src/libsemanage.map        |    1 
 libsemanage/src/module_internal.h      |    3 
 libsemanage/src/modules.c              |  148 +++++++++++++++++++++++++++++++--
 4 files changed, 155 insertions(+), 8 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/modules.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/modules.h
+++ selinux-pms-support/libsemanage/include/semanage/modules.h
@@ -21,6 +21,7 @@
 #ifndef _SEMANAGE_MODULES_H_
 #define _SEMANAGE_MODULES_H_
 
+#include <inttypes.h>
 #include <stddef.h>
 #include <semanage/handle.h>
 
@@ -48,4 +49,14 @@ semanage_module_info_t *semanage_module_
 const char *semanage_module_get_name(semanage_module_info_t *);
 const char *semanage_module_get_version(semanage_module_info_t *);
 
+int semanage_module_list_serialize(semanage_handle_t * handle,
+				   char **data,
+				   uint64_t * size);
+
+int semanage_module_list_unserialize(semanage_handle_t * handle,
+	char **data,
+	uint64_t *size,
+	semanage_module_info_t ** modules,
+	int *num_modules);
+
 #endif
Index: selinux-pms-support/libsemanage/src/libsemanage.map
===================================================================
--- selinux-pms-support.orig/libsemanage/src/libsemanage.map
+++ selinux-pms-support/libsemanage/src/libsemanage.map
@@ -7,6 +7,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_install_base; semanage_module_remove;
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
+	  semanage_module_list_serialize; semanage_module_list_unserialize;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
Index: selinux-pms-support/libsemanage/src/module_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/module_internal.h
+++ selinux-pms-support/libsemanage/src/module_internal.h
@@ -8,4 +8,7 @@ hidden_proto(semanage_module_get_name)
     hidden_proto(semanage_module_get_version)
     hidden_proto(semanage_module_info_datum_destroy)
     hidden_proto(semanage_module_list_nth)
+    hidden_proto(semanage_module_list_serialize)
+    hidden_proto(semanage_module_list_unserialize)
+
 #endif
Index: selinux-pms-support/libsemanage/src/modules.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/modules.c
+++ selinux-pms-support/libsemanage/src/modules.c
@@ -1,7 +1,8 @@
-/* Author: Joshua Brindle <jbrindle@tresys.co
- *	   Jason Tang	  <jtang@tresys.com>
+/* Author: Joshua Brindle       <jbrindle@tresys.com>
+ *         Jason Tang           <jtang@tresys.com>
+ *         Christopher Ashworth <cashworth@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -20,18 +21,24 @@
 
 /* This file implements only the publicly-visible module functions to libsemanage. */
 
-#include "direct_api.h"
-#include "semanage_conf.h"
-#include "semanage_store.h"
-
 #include <stdarg.h>
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <limits.h>
 
+#include "direct_api.h"
+#include "semanage_conf.h"
+#include "semanage_store.h"
+#include "handle_internal.h"
 #include "handle.h"
 #include "modules.h"
 #include "debug.h"
+#include "byteswap.h"
+#include "serialize.h"
 
 int semanage_module_install(semanage_handle_t * sh,
 			    char *module_data, size_t data_len)
@@ -120,6 +127,131 @@ int semanage_module_list(semanage_handle
 	return sh->funcs->list(sh, modinfo, num_modules);
 }
 
+/* serialize a list of modules into a string, for sending over the wire.
+ * this function (and the corresponding unserialize function) will have to be
+ * able to handle changes to semanage_module_info_t since it is opaque.
+ * caller is responsible for freeing results
+ */
+int semanage_module_list_serialize(semanage_handle_t * handle,
+				   char **data,
+				   uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+	const char *version = NULL;
+	int i;
+	semanage_module_info_t * modules = NULL;
+	semanage_module_info_t * module = NULL;
+	int modules_size;
+	char *ptr = NULL;
+
+	/* Get the modules. */
+	status = semanage_module_list(handle, &modules, &modules_size);
+	if (status < 0)
+		goto cleanup;
+
+	/* Number of modules. */
+	status = semanage_serialize(handle, &modules_size, 0, SEMANAGE_SERIAL_UINT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	for (i = 0; i < modules_size; i++) {
+		module = semanage_module_list_nth(modules, i);
+
+		/* Module name. */
+		name = semanage_module_get_name(module);
+		status = semanage_serialize(handle, name, (name == NULL) ? 0 : strlen(name), SEMANAGE_SERIAL_STRING, NULL, size);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Module version. */
+		version = semanage_module_get_version(module);
+		status = semanage_serialize(handle, version, (version == NULL) ? 0 : strlen(version), SEMANAGE_SERIAL_STRING, NULL, size);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	*data = calloc(*size, sizeof(char));
+	if (*data == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	ptr = *data;
+
+	/* Number of modules. */
+	status = semanage_serialize(handle, &modules_size, 0, SEMANAGE_SERIAL_UINT32_T, &ptr, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	for (i = 0; i < modules_size; i++) {
+		module = semanage_module_list_nth(modules, i);
+
+		/* Module name. */
+		name = semanage_module_get_name(module);
+		status = semanage_serialize(handle, name, (name == NULL) ? 0 : strlen(name), SEMANAGE_SERIAL_STRING, &ptr, NULL);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Module version. */
+		version = semanage_module_get_version(module);
+		status = semanage_serialize(handle, version, (version == NULL) ? 0 : strlen(version), SEMANAGE_SERIAL_STRING, &ptr, NULL);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+cleanup:
+	free(modules);
+	return status;
+}
+
+hidden_def(semanage_module_list_serialize)
+
+	/* unserialize a list of modules from a string that has been received over the wire.
+	 * caller is responsible for freeing modules.
+	 * NOTE: *data is modified by this function.
+	 */
+int semanage_module_list_unserialize(semanage_handle_t * handle,
+		char **data,
+		uint64_t *size,
+		semanage_module_info_t ** modules,
+		int *modules_size)
+{
+	int status = STATUS_SUCCESS;
+	int i;
+	size_t *temp_size = NULL;
+
+	/* Number of modules. */
+	status = semanage_unserialize(handle, data, size, (void **)&temp_size, NULL, SEMANAGE_SERIAL_UINT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	*modules_size = *temp_size;
+
+	*modules = calloc(*modules_size, sizeof(**modules));
+	if (*modules == NULL)
+		goto cleanup;
+
+	for (i = 0; i < *modules_size; i++) {
+		/* Module name. */
+		status = semanage_unserialize(handle, data, size, (void **)&(*modules)[i].name, &temp_size, SEMANAGE_SERIAL_STRING);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Module version. */
+		status = semanage_unserialize(handle, data, size, (void **)&(*modules)[i].version, &temp_size, SEMANAGE_SERIAL_STRING);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+cleanup:
+	free(temp_size);
+	return status;
+}
+
+hidden_def(semanage_module_list_unserialize)
+
 void semanage_module_info_datum_destroy(semanage_module_info_t * modinfo)
 {
 	if (modinfo != NULL) {
@@ -131,7 +263,7 @@ void semanage_module_info_datum_destroy(
 hidden_def(semanage_module_info_datum_destroy)
 
 semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
-						 int n)
+		int n)
 {
 	return list + n;
 }

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
