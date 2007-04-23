Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUndZ001862
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:49 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUjSG027892
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:45 GMT
Message-Id: <20070423213744.959901000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:20 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 25/33] libsemanage: policy server database hooks
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Implements all database functions for a policy server backend.

---
 libsemanage/include/semanage/database_ps.h |   37 +
 libsemanage/include/semanage/handle.h      |    7 
 libsemanage/include/semanage/semanage.h    |    4 
 libsemanage/src/booleans_ps.c              |  100 ++++
 libsemanage/src/database.h                 |    9 
 libsemanage/src/database_ps.c              |  368 +++++++++++++++
 libsemanage/src/database_ps.h              |   55 ++
 libsemanage/src/fcontexts_ps.c             |   59 ++
 libsemanage/src/handle.c                   |   41 +
 libsemanage/src/handle.h                   |    2 
 libsemanage/src/handle_internal.h          |    2 
 libsemanage/src/interfaces_ps.c            |   78 +++
 libsemanage/src/libsemanage.map            |    2 
 libsemanage/src/nodes_ps.c                 |   78 +++
 libsemanage/src/ports_ps.c                 |   78 +++
 libsemanage/src/ps_api.c                   |  690 +++++++++++++++++++++++++++++
 libsemanage/src/ps_api.h                   |   31 +
 libsemanage/src/seusers_ps.c               |   58 ++
 libsemanage/src/users_ps.c                 |   82 +++
 libsemanage/tests/globals.h                |   39 +
 libsemanage/tests/libsemanage-tests.c      |   16 
 libsemanage/tests/test_ps_api_connect.c    |  346 ++++++++++++++
 libsemanage/tests/test_ps_api_connect.h    |   33 +
 libsemanage/tests/test_ps_api_disconnect.c |  178 +++++++
 libsemanage/tests/test_ps_api_disconnect.h |   33 +
 25 files changed, 2412 insertions(+), 14 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/database_ps.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/include/semanage/database_ps.h
@@ -0,0 +1,37 @@
+/* Authors: Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_DATABASE_PS_H_
+#define _SEMANAGE_DATABASE_PS_H_
+
+#include <stdio.h>
+#include "handle.h"
+
+#ifndef DBASE_CONFIG
+#define DBASE_CONFIG
+typedef struct dbase_config dbase_config_t;
+#endif
+
+/* PS - database type handling */
+extern int semanage_dbase_ps_get_database_type(semanage_handle_t *sh, dbase_config_t *dconfig, uint32_t * database_type);
+extern int semanage_dbase_ps_set_database_type(semanage_handle_t *sh, dbase_config_t *dconfig, uint32_t database_type);
+extern int semanage_dbase_ps_database_type_serialize(semanage_handle_t *sh, uint32_t database_type, char **data, uint64_t *size);
+extern int semanage_dbase_ps_database_type_unserialize(semanage_handle_t *sh, char **data, uint64_t *size, uint32_t *database_type) ;
+
+#endif
Index: selinux-pms-support/libsemanage/include/semanage/handle.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/handle.h
+++ selinux-pms-support/libsemanage/include/semanage/handle.h
@@ -26,6 +26,8 @@
 
 #include <inttypes.h>
 
+#include <sepol/handle.h>
+
 /* All accesses with semanage are through a "semanage_handle".  The
  * handle may ultimately reference local config files,
  * the binary policy file, a module store, or a policy management server. 
@@ -66,7 +68,7 @@ enum semanage_connect_type {
  * It must be called after semanage_handle_create but before 
  * semanage_connect. The argument should be the full path to the store.
  */
-void semanage_select_store(semanage_handle_t * handle, char *path,
+void semanage_select_store(semanage_handle_t * handle, const char *path,
 			   enum semanage_connect_type storetype);
 
 /* Just reload the policy */
@@ -81,6 +83,9 @@ void semanage_set_reload(semanage_handle
  * 1 for yes, 0 for no (default) */
 void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
 
+/* returns the sepol handle associated with this handle */
+sepol_handle_t *semanage_get_sepol_handle(semanage_handle_t * sh);
+
 /* create the store if it does not exist, this only has an effect on 
  * direct connections and must be called before semanage_connect 
  * 1 for yes, 0 for no (default) */
Index: selinux-pms-support/libsemanage/include/semanage/semanage.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/semanage.h
+++ selinux-pms-support/libsemanage/include/semanage/semanage.h
@@ -24,6 +24,7 @@
 
 #include <semanage/handle.h>
 #include <semanage/modules.h>
+#include <semanage/policy.h>
 #include <semanage/debug.h>
 
 /* Records */
@@ -55,4 +56,7 @@
 /* Messaging */
 #include <semanage/messages.h>
 
+/* Database types */
+#include <semanage/database_ps.h>
+
 #endif
Index: selinux-pms-support/libsemanage/src/booleans_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/booleans_ps.c
@@ -0,0 +1,100 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_boolean;
+struct semanage_boolean_key;
+typedef struct semanage_boolean record_t;
+typedef struct semanage_boolean_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "boolean_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int bool_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_BOOL_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
+int bool_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+			     dbase_config_t * dconfig)
+{
+
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_BOOL_RTABLE,
+		(dbase_ps_t **)&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_ps_policydb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
+int bool_ps_activedb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+			     dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_BOOL_RTABLE,
+		(dbase_ps_t **)&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_ACTIVEDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void bool_ps_activedb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
Index: selinux-pms-support/libsemanage/src/database.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database.h
+++ selinux-pms-support/libsemanage/src/database.h
@@ -209,7 +209,7 @@ typedef struct dbase_table {
 
 } dbase_table_t;
 
-typedef struct dbase_config {
+struct dbase_config {
 
 	/* Database state */
 	dbase_t *dbase;
@@ -217,7 +217,12 @@ typedef struct dbase_config {
 	/* Database methods */
 	dbase_table_t *dtable;
 
-} dbase_config_t;
+};
+
+#ifndef DBASE_CONFIG
+#define DBASE_CONFIG
+typedef struct dbase_config dbase_config_t;
+#endif
 
 extern int dbase_add(struct semanage_handle *handle,
 		     dbase_config_t * dconfig,
Index: selinux-pms-support/libsemanage/src/database_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/database_ps.c
@@ -0,0 +1,368 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* Object: dbase_ps_t (Policy Server)
+ * Extends: dbase_llist_t (Linked List)
+ * Implements: dbase_t (Database)
+ */
+
+struct dbase_ps;
+typedef struct dbase_ps dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include "debug.h"
+#include "handle.h"
+#include "database_ps.h"
+#include "database_llist.h"
+#include "database_policydb.h"
+#include "byteswap.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "serialize.h"
+
+/* PS dbase */
+struct dbase_ps {
+
+	/* Parent object - must always be
+	 * the first field. For example,
+	 * the generic database "add" function
+	 * passes the dbase_ps as a dbase_t,
+	 * but the internal dbase_llist_add
+	 * function treats it as a dbase_llist_t
+	 * without dereferencing the llist field. */
+	dbase_llist_t llist;
+
+	/* Enumerated database type.
+	 * (i.e. Which database is this?) */
+	uint32_t database_type;
+
+};
+
+/* Get database type. */
+int semanage_dbase_ps_get_database_type(semanage_handle_t *sh, dbase_config_t *dconfig, uint32_t * database_type)
+{
+	*database_type = dconfig->dbase->database_type;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(semanage_dbase_ps_get_database_type)
+
+/* Set database type. */
+int semanage_dbase_ps_set_database_type(semanage_handle_t *sh, dbase_config_t *dconfig, uint32_t database_type)
+{
+	dconfig->dbase->database_type = database_type;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(semanage_dbase_ps_set_database_type)
+
+/* Serialize database type. */
+int semanage_dbase_ps_database_type_serialize(semanage_handle_t *sh, uint32_t database_type, char **data, uint64_t *size)
+{
+	int status = STATUS_SUCCESS;
+	char *ptr = NULL;
+
+	/* Sundry sanity checks. */
+	if (data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Calculate size. */
+	status = semanage_serialize(sh, &database_type, 0, SEMANAGE_SERIAL_UINT32_T, NULL, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Allocate memory. */
+	ptr = *data = calloc(*size, sizeof(char));
+	if (*data == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Serialize. */
+	status = semanage_serialize(sh, &database_type, 0, SEMANAGE_SERIAL_UINT32_T, &ptr, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+cleanup:
+	return status;
+
+}
+
+hidden_def(semanage_dbase_ps_database_type_serialize)
+
+/* Unserialize database type. */
+int semanage_dbase_ps_database_type_unserialize(semanage_handle_t *sh, char **data, uint64_t *size, uint32_t *database_type)
+{
+	int status = STATUS_SUCCESS;
+	uint32_t *datum = NULL;
+	size_t *datum_length = NULL;
+
+	/* Sundry sanity checks. */
+	if (data == NULL || *data == NULL || size == NULL) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	status = semanage_unserialize(sh, data, size, (void **)&datum, &datum_length, SEMANAGE_SERIAL_UINT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	*database_type = *datum;
+
+cleanup:
+	free(datum);
+	free(datum_length);
+	return status;
+}
+
+hidden_def(semanage_dbase_ps_database_type_unserialize)
+
+/* Load database from server. */
+static int dbase_ps_cache(semanage_handle_t * handle, dbase_config_t * dconfig)
+{
+	dbase_ps_t *dbase = dconfig->dbase;
+
+	int fd = handle->u.ps_handle.socket_fd;
+	uint32_t message_type = 0;
+	uint64_t data_length = 0;
+	char *data = NULL;
+
+	/* Already cached? */
+	if (!dbase_llist_needs_resync(handle, &dbase->llist))
+		return STATUS_SUCCESS;
+
+	/* Check that we're connected. */
+	if (fd < 0)
+		goto err;
+
+	/* Update cache serial. */
+	dbase_llist_cache_init(&dbase->llist);
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
+
+	/* Retrieve serialized records from the server. */
+	/* The data sent with a GET_DATABASE message is
+         * the database_type of this database, so the server
+         * knows which one to send back. */
+	if (semanage_dbase_ps_database_type_serialize(handle, dbase->database_type, &data, &data_length) != STATUS_SUCCESS)
+		goto err;
+
+	if (write_msg(handle, fd, PS_GET_DATABASE, data_length, data))
+		goto err;
+
+	data = NULL;
+	data_length = 0;
+	if (read_server(handle, fd, &message_type, &data_length, &data))
+		goto err;
+
+	if (message_type != PS_OK)
+		goto err;
+
+	/* Unserialize the records into our database. */
+	if (dbase_unserialize(handle, dconfig, data, data_length))
+		goto err;
+
+	/* Clean up. */
+	free(data);
+	return STATUS_SUCCESS;
+
+      err:
+	ERR(handle, "could not cache file database");
+	free(data);
+	dbase_llist_drop_cache(&dbase->llist);
+	return STATUS_ERR;
+}
+
+/* Flush database to server */
+static int dbase_ps_flush(semanage_handle_t * handle, dbase_config_t * dconfig)
+{
+	int fd = handle->u.ps_handle.socket_fd;
+	uint32_t message_type = 0;
+	uint64_t data_length = 0;
+	char *data = NULL;
+	uint64_t records_length = 0;
+	char *records = NULL;
+	uint64_t type_length = 0;
+	char *type = NULL;
+	dbase_ps_t *dbase = dconfig->dbase;
+
+	/* Any changes to flush? */
+	if (!dbase_llist_is_modified(&dbase->llist))
+		return STATUS_SUCCESS;
+
+	/* Check that we're connected. */
+	if (fd < 0)
+		goto err;
+
+	/* Serialize the database type. */
+	if (semanage_dbase_ps_database_type_serialize(handle, dbase->database_type, &type, &type_length) != STATUS_SUCCESS)
+		goto err;
+
+	/* Serialize the database records. */
+	if (dbase_serialize(handle, dconfig, &records, &records_length))
+		goto err;
+
+	/* Combine the buffers. */
+	data_length = type_length + records_length;
+	data = calloc(data_length, sizeof(char));
+	if (data == NULL)
+		goto err;
+	memcpy(data, type, type_length);
+	memcpy(data + type_length, records, records_length);
+
+	/* Send serialized records to the server. */
+	if (write_msg(handle, fd, PS_PUT_DATABASE, data_length, data))
+		goto err;
+
+	/* Check response. */
+	if (read_server(handle, fd, &message_type, &data_length, &data))
+		goto err;
+
+	if (message_type != PS_OK)
+		goto err;
+
+	dbase_llist_set_modified(&dbase->llist, 0);
+
+	/* Clean up. */
+	free(data);
+
+	return STATUS_SUCCESS;
+
+      err:
+	ERR(handle, "could not flush database to policy server");
+	free(data);
+	free(type);
+	free(records);
+	return STATUS_ERR;
+}
+
+int dbase_ps_init(semanage_handle_t * handle,
+		  uint32_t sandbox_id,
+		  record_table_t * rtable, dbase_ps_t ** dbase)
+{
+	dbase_ps_t *tmp_dbase = (dbase_ps_t *) malloc(sizeof(dbase_ps_t));
+
+	if (!tmp_dbase)
+		goto omem;
+
+	tmp_dbase->database_type = sandbox_id;
+	dbase_llist_init(&tmp_dbase->llist, rtable);
+
+	*dbase = tmp_dbase;
+
+	return STATUS_SUCCESS;
+
+      omem:
+	ERR(handle,
+	    "out of memory, could not initialize policy server database");
+	free(tmp_dbase);
+	return STATUS_ERR;
+}
+
+/* Release dbase resources */
+void dbase_ps_release(dbase_ps_t * dbase)
+{
+	dbase_llist_drop_cache(&dbase->llist);
+	free(dbase);
+}
+
+/* PS dbase - method table implementation */
+dbase_table_t SEMANAGE_PS_DTABLE = {
+
+	/* Cache/Transactions */
+	.cache = dbase_ps_cache,
+	.drop_cache = (void *)dbase_llist_drop_cache,
+	.flush = dbase_ps_flush,
+	.is_modified = (void *)dbase_llist_is_modified,
+
+	/* Database API */
+	.iterate = (void *)dbase_llist_iterate,
+	.exists = (void *)dbase_llist_exists,
+	.list = (void *)dbase_llist_list,
+	.add = (void *)dbase_llist_add,
+	.set = (void *)dbase_llist_set,
+	.del = (void *)dbase_llist_del,
+	.clear = (void *)dbase_llist_clear,
+	.modify = (void *)dbase_llist_modify,
+	.query = (void *)dbase_llist_query,
+	.count = (void *)dbase_llist_count,
+
+	/* Polymorphism */
+	.get_rtable = (void *)dbase_llist_get_rtable
+};
+
+/* PS POLICYDB dbase - method table implementation */
+dbase_table_t SEMANAGE_PS_POLICYDB_DTABLE = {
+	/* Cache/Transactions */
+	.cache = dbase_ps_cache,
+	.drop_cache = (void *)dbase_llist_drop_cache,
+	.flush = dbase_policydb_flush,
+	.is_modified = (void *)dbase_llist_is_modified,
+
+	/* Database API */
+	.iterate = (void *)dbase_llist_iterate,
+	.exists = (void *)dbase_llist_exists,
+	.list = (void *)dbase_llist_list,
+	.add = (void *)dbase_llist_add,
+	.set = (void *)dbase_llist_set,
+	.del = (void *)dbase_llist_del,
+	.clear = (void *)dbase_llist_clear,
+	.modify = (void *)dbase_llist_modify,
+	.query = (void *)dbase_llist_query,
+	.count = (void *)dbase_llist_count,
+
+	/* Polymorphism */
+	.get_rtable = (void *)dbase_llist_get_rtable
+};
+
+/* PS ACTIVEDB dbase - method table implementation */
+dbase_table_t SEMANAGE_PS_ACTIVEDB_DTABLE = {
+
+	/* Cache/Transactions */
+	.cache = dbase_ps_cache,
+	.drop_cache = (void *)dbase_llist_drop_cache,
+	.flush = dbase_ps_flush,
+	.is_modified = (void *)dbase_llist_is_modified,
+
+	/* Database API */
+	.iterate = (void *)dbase_llist_iterate,
+	.exists = (void *)dbase_llist_exists,
+	.list = (void *)dbase_llist_list,
+	.add = (void *)dbase_llist_add,
+	.set = (void *)dbase_llist_set,
+	.del = (void *)dbase_llist_del,
+	.clear = (void *)dbase_llist_clear,
+	.modify = (void *)dbase_llist_modify,
+	.query = (void *)dbase_llist_query,
+	.count = (void *)dbase_llist_count,
+
+	/* Polymorphism */
+	.get_rtable = (void *)dbase_llist_get_rtable
+};
Index: selinux-pms-support/libsemanage/src/database_ps.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/database_ps.h
@@ -0,0 +1,55 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _SEMANAGE_DATABASE_PS_INTERNAL_H_
+#define _SEMANAGE_DATABASE_PS_INTERNAL_H_
+
+#include <stdio.h>
+
+#include <semanage/database_ps.h>
+
+#include "database.h"
+#include "handle.h"
+
+struct dbase_ps;
+typedef struct dbase_ps dbase_ps_t;
+
+/* PS - initialization */
+extern int dbase_ps_init(semanage_handle_t * handle,
+			 uint32_t sandbox_id,
+			 record_table_t * rtable, dbase_ps_t ** dbase);
+
+/* PS - release */
+extern void dbase_ps_release(dbase_ps_t * dbase);
+
+/* PS - method table implementation */
+extern dbase_table_t SEMANAGE_PS_DTABLE;
+extern dbase_table_t SEMANAGE_PS_POLICYDB_DTABLE;
+extern dbase_table_t SEMANAGE_PS_ACTIVEDB_DTABLE;
+
+/* PS - database type handling */
+hidden_proto(semanage_dbase_ps_get_database_type)
+hidden_proto(semanage_dbase_ps_set_database_type)
+hidden_proto(semanage_dbase_ps_database_type_serialize)
+hidden_proto(semanage_dbase_ps_database_type_unserialize)
+
+#endif
Index: selinux-pms-support/libsemanage/src/fcontexts_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/fcontexts_ps.c
@@ -0,0 +1,59 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_fcontext;
+struct semanage_fcontext_key;
+typedef struct semanage_fcontext record_t;
+typedef struct semanage_fcontext_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "fcontext_internal.h"
+#include "context_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int fcontext_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_FCONTEXT_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void fcontext_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/src/handle.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/handle.c
+++ selinux-pms-support/libsemanage/src/handle.c
@@ -26,11 +26,13 @@
 #include <stdarg.h>
 #include <assert.h>
 #include <stdlib.h>
+#include <string.h>
 #include <stdio.h>
 #include <sys/time.h>
 
 #include "direct_api.h"
 #include "handle.h"
+#include "handle_internal.h"
 #include "debug.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
@@ -143,7 +145,7 @@ int semanage_is_connected(semanage_handl
 	return sh->is_connected;
 }
 
-void semanage_select_store(semanage_handle_t * sh, char *storename,
+void semanage_select_store(semanage_handle_t * sh, const char *storename,
 			   enum semanage_connect_type storetype)
 {
 
@@ -151,12 +153,20 @@ void semanage_select_store(semanage_hand
 
 	/* This just sets the storename to what the user requests, no 
 	   verification of existance will be done until connect */
-	sh->conf->store_path = storename;
+	sh->conf->store_path = strdup(storename);
 	sh->conf->store_type = storetype;
 
 	return;
 }
 
+sepol_handle_t *semanage_get_sepol_handle(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+	return sh->sepolh;
+}
+
+hidden_def(semanage_get_sepol_handle)
+
 int semanage_is_managed(semanage_handle_t * sh)
 {
 	assert(sh != NULL);
@@ -167,6 +177,9 @@ int semanage_is_managed(semanage_handle_
 	switch (sh->conf->store_type) {
 	case SEMANAGE_CON_DIRECT:
 		return semanage_direct_is_managed(sh);
+	case SEMANAGE_CON_POLSERV_REMOTE:
+	case SEMANAGE_CON_POLSERV_LOCAL:
+		return semanage_ps_is_managed(sh);
 	default:
 		ERR(sh,
 		    "The connection type specified within your semanage.conf file has not been implemented yet.");
@@ -179,17 +192,21 @@ int semanage_connect(semanage_handle_t *
 {
 	assert(sh != NULL);
 	switch (sh->conf->store_type) {
-	case SEMANAGE_CON_DIRECT:{
-			if (semanage_direct_connect(sh) < 0) {
-				return -1;
-			}
-			break;
+	case SEMANAGE_CON_DIRECT:
+		if (semanage_direct_connect(sh) < 0) {
+			return -1;
 		}
-	default:{
-			ERR(sh,
-			    "The connection type specified within your semanage.conf file has not been implemented yet.");
+		break;
+	case SEMANAGE_CON_POLSERV_REMOTE:
+	case SEMANAGE_CON_POLSERV_LOCAL:
+		if (semanage_ps_connect(sh) < 0) {
 			return -1;
 		}
+		break;
+	default:
+		ERR(sh,
+		    "The connection type specified within your semanage.conf file has not been implemented yet.");
+		return -1;
 	}
 	sh->is_connected = 1;
 	return 0;
@@ -201,6 +218,10 @@ int semanage_access_check(semanage_handl
 	switch (sh->conf->store_type) {
 	case SEMANAGE_CON_DIRECT:
 		return semanage_direct_access_check(sh);
+	case SEMANAGE_CON_POLSERV_REMOTE:
+	case SEMANAGE_CON_POLSERV_LOCAL:
+		/* FIXME: for now just say we have access */
+		return SEMANAGE_CAN_WRITE;
 	default:
 		return -1;
 	}
Index: selinux-pms-support/libsemanage/src/handle.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/handle.h
+++ selinux-pms-support/libsemanage/src/handle.h
@@ -30,6 +30,7 @@
 #include "semanage_conf.h"
 #include "database.h"
 #include "direct_api.h"
+#include "ps_api.h"
 #include "policy.h"
 
 struct semanage_handle {
@@ -49,6 +50,7 @@ struct semanage_handle {
 	/* Direct vs Server specific handle */
 	union {
 		struct semanage_direct_handle direct;
+		struct semanage_ps_handle ps_handle;
 	} u;
 
 	/* Libsepol handle */
Index: selinux-pms-support/libsemanage/src/handle_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/handle_internal.h
+++ selinux-pms-support/libsemanage/src/handle_internal.h
@@ -12,5 +12,5 @@ hidden_proto(semanage_handle_get_version
 hidden_proto(semanage_handle_set_version)
 hidden_proto(semanage_handle_version_serialize)
 hidden_proto(semanage_handle_version_unserialize)
-
+hidden_proto(semanage_get_sepol_handle)
 #endif
Index: selinux-pms-support/libsemanage/src/interfaces_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/interfaces_ps.c
@@ -0,0 +1,78 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface record_t;
+typedef struct semanage_iface_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "iface_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int iface_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_IFACE_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void iface_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
+int iface_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+			      dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_IFACE_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void iface_ps_policydb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/src/libsemanage.map
===================================================================
--- selinux-pms-support.orig/libsemanage/src/libsemanage.map
+++ selinux-pms-support/libsemanage/src/libsemanage.map
@@ -1,5 +1,6 @@
 LIBSEMANAGE_1.0 {
   global: semanage_handle_create; semanage_handle_destroy; 
+          semanage_get_sepol_handle;
           semanage_is_managed; semanage_connect; semanage_disconnect; 
 	  semanage_msg_*;
           semanage_begin_transaction; semanage_commit;
@@ -16,6 +17,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_*_serialize; semanage_*_unserialize;
 	  semanage_is_connected;
+	  semanage_handle_get_version; semanage_handle_set_version;
 	  semanage_policy_table_serialize_serial;
   local: *;
 };
Index: selinux-pms-support/libsemanage/src/nodes_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/nodes_ps.c
@@ -0,0 +1,78 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_node;
+struct semanage_node_key;
+typedef struct semanage_node record_t;
+typedef struct semanage_node_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "node_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int node_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_NODE_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void node_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
+int node_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+			     dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_NODE_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void node_ps_policydb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/src/ports_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/ports_ps.c
@@ -0,0 +1,78 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port record_t;
+typedef struct semanage_port_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "port_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int port_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_PORT_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void port_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
+
+int port_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+			     dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_PORT_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void port_ps_policydb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/src/ps_api.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/ps_api.c
@@ -0,0 +1,690 @@
+/* Author:  Jason Tang                  <jtang@tresys.com>
+ *          Christopher Ashworth        <cashworth@tresys.com>
+ *          Caleb Case                  <ccase@tresys.com>
+ *
+ * Copyright (C) 2004-2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+/*
+ *  ps_api.c
+ *
+ *  Implements the module management functions that communicate
+ *  with a remote policy server.
+ *
+ */
+
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <netdb.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <selinux/selinux.h>
+
+#include "debug.h"
+#include "byteswap.h"
+#include "handle.h"
+#include "modules.h"
+#include "policy.h"
+#include "ps_api.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_policydb.h"
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "port_internal.h"
+#include "iface_internal.h"
+#include "boolean_internal.h"
+#include "fcontext_internal.h"
+#include "node_internal.h"
+#include "serialize.h"
+
+/*  Policy server variants of the semanage functions.
+ */
+struct semanage_policy_table ps_funcs = {
+	.get_serial = semanage_ps_get_commit_number,
+	.destroy = semanage_ps_destroy,
+	.disconnect = semanage_ps_disconnect,
+	.begin_trans = semanage_ps_begintrans,
+	.commit = semanage_ps_commit,
+	.install = semanage_ps_install_module,
+	.upgrade = semanage_ps_upgrade_module,
+	.remove = semanage_ps_remove_module,
+	.list = semanage_ps_list_modules,
+	.install_base = semanage_ps_install_base_module
+};
+
+static int connect_local(semanage_handle_t * sh);
+static int connect_remote(semanage_handle_t * sh);
+static int set_file_control(semanage_handle_t * sh);
+
+/* Begin a transaction with the policy server.
+ * Returns 0 on success, negative value on error, or the
+ * positive error code received from the server.
+ */
+int semanage_ps_begintrans(semanage_handle_t * sh)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint32_t response_type = 0;
+	uint64_t response_length = 0;
+	char *response = NULL;
+	int err = 0;
+
+	err = write_msg(sh, fd, PS_BEGIN_TRANSACTION, 0, NULL);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &response_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error beginning transaction.");
+	}
+
+	free(response);
+	return err;
+}
+
+/* Interacting with your policy via the policy server
+ * means that your policy is managed (by definition).
+ */
+int semanage_ps_is_managed(semanage_handle_t * sh)
+{
+	return 1;
+}
+
+/* Command the policy server to commit all changes.
+ * Returns 0 on success, negative value on error, or the
+ * positive error code received from the server.
+ */
+int semanage_ps_commit(semanage_handle_t * sh)
+{
+	int i = 0;
+	int fd = sh->u.ps_handle.socket_fd;
+	uint32_t response_type = 0;
+	uint64_t response_length = 0;
+	char *response = NULL;
+	int err = 0;
+	dbase_config_t *components[] = {
+		semanage_iface_dbase_local(sh),
+		semanage_bool_dbase_local(sh),
+		semanage_user_dbase_local(sh),
+		semanage_port_dbase_local(sh),
+		semanage_fcontext_dbase_local(sh),
+		semanage_fcontext_dbase_policy(sh),
+		semanage_seuser_dbase_local(sh),
+		semanage_seuser_dbase_policy(sh),
+		semanage_bool_dbase_active(sh),
+		semanage_node_dbase_local(sh),
+	};
+	const int CCOUNT = sizeof(components) / sizeof(components[0]);
+
+	for (i = 0; i < CCOUNT; i++) {
+		/* Flush to disk */
+		if(components[i]->dtable == NULL || components[i]->dtable->flush == NULL) {
+			printf("Flush method not implemented");
+			return err;
+		}
+		if (components[i]->dtable->flush(sh, components[i]) == STATUS_ERR){
+			ERR(sh, "Error flushing database");
+			return err;
+		}
+	}
+
+	err = write_msg(sh, fd, PS_COMMIT, 0, NULL);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &response_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error committing.");
+	}
+
+	free(response);
+	return err;
+}
+
+/* Attempt to make a connection to the policy server specified within
+ * the given semod_module_store struct.  If handshake_response is not
+ * NULL then write the message received from the server to the
+ * semanage handle.
+ * The file descriptor will be set to non-blocking mode.
+ * Return the file descriptor used, -1 if the server could not be
+ * found, -2 if the server rejected this connection, or -3 for all
+ * other errors.
+ */
+int semanage_ps_connect(semanage_handle_t * sh)
+{
+	char *handshake = NULL;
+	char *handshake_response = NULL;
+	uint32_t response_type = 0;
+	uint64_t data_length = 0;
+	int err = 0;
+
+	/* attempt to open connection */
+	if (sh->conf->store_type == SEMANAGE_CON_POLSERV_REMOTE) {
+		if (connect_remote(sh) == EXIT_FAILURE) {
+			return sh->u.ps_handle.socket_fd;
+		}
+	} else if (sh->conf->store_type == SEMANAGE_CON_POLSERV_LOCAL) {
+		if (connect_local(sh) == EXIT_FAILURE) {
+			return sh->u.ps_handle.socket_fd;
+		}
+	} else {
+		sh->u.ps_handle.socket_fd = -2;
+		return sh->u.ps_handle.socket_fd;
+	}
+
+	/* set up function table */
+	sh->funcs = &ps_funcs;
+
+	/* set file descriptor to non-blocking mode */
+	sh->is_connected = 1;
+	if (set_file_control(sh) == EXIT_FAILURE) {
+		return sh->u.ps_handle.socket_fd;
+	}
+
+	/* perform handshake with server. */
+	err = semanage_handle_set_version(sh, SEMANAGE_SERIAL_VERSION_MAJOR, SEMANAGE_SERIAL_VERSION_MINOR);
+
+	if (err != STATUS_SUCCESS) {
+		close(sh->u.ps_handle.socket_fd);
+		ERR(sh, "Error setting version during handshake with server.");
+		sh->u.ps_handle.socket_fd = -1;
+		return sh->u.ps_handle.socket_fd;
+	}
+
+	err = semanage_handle_version_serialize(sh, &handshake, &data_length);
+	if (err != STATUS_SUCCESS) {
+		close(sh->u.ps_handle.socket_fd);
+		ERR(sh, "Error serializing version during handshake with server.");
+		sh->u.ps_handle.socket_fd = -1;
+		return sh->u.ps_handle.socket_fd;
+	}
+
+	err = write_msg(sh, sh->u.ps_handle.socket_fd, PS_CONNECT,
+			data_length, handshake);
+	if (err) {
+		close(sh->u.ps_handle.socket_fd);
+		ERR(sh, "Error writing handshake to server.");
+		sh->u.ps_handle.socket_fd = -1;
+		return sh->u.ps_handle.socket_fd;
+	}
+	err = read_server(sh, sh->u.ps_handle.socket_fd, &response_type,
+			  &data_length, &handshake_response);
+	if (err) {
+		// TODO: TESTME
+		close(sh->u.ps_handle.socket_fd);
+		if (handshake_response)
+			ERR(sh, handshake_response);
+		else
+			ERR(sh, "Error reading handshake from server.");
+		free(handshake_response);
+		sh->u.ps_handle.socket_fd = -2;
+		return sh->u.ps_handle.socket_fd;
+	}
+	free(handshake_response);
+
+	/* Object databases: local modifications */
+	if (user_ps_local_dbase_init(sh,
+				DB_USER_LOCAL,
+				semanage_user_dbase_local(sh)) < 0)
+		goto err;
+
+	if (port_ps_local_dbase_init(sh,
+				 DB_PORT_LOCAL,
+				 semanage_port_dbase_local(sh)) < 0)
+		goto err;
+
+	if (iface_ps_local_dbase_init(sh,
+				  DB_INTERFACE_LOCAL,
+				  semanage_iface_dbase_local(sh)) < 0)
+		goto err;
+
+	if (bool_ps_local_dbase_init(sh,
+				 DB_BOOLEAN_LOCAL,
+				 semanage_bool_dbase_local(sh)) < 0)
+		goto err;
+
+	if (fcontext_ps_local_dbase_init(sh,
+				     DB_FCONTEXT_LOCAL,
+				     semanage_fcontext_dbase_local(sh)) < 0)
+		goto err;
+
+	if (seuser_ps_local_dbase_init(sh,
+				   DB_SEUSER_LOCAL,
+				   semanage_seuser_dbase_local(sh)) < 0)
+		goto err;
+
+	if (node_ps_local_dbase_init(sh,
+				 DB_NODE_LOCAL,
+				 semanage_node_dbase_local(sh)) < 0)
+		goto err;
+
+	/* Object databases: local modifications + policy */
+	if (user_ps_policydb_dbase_init(sh, DB_USER_POLICY, semanage_user_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (port_ps_policydb_dbase_init(sh, DB_PORT_POLICY, semanage_port_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (iface_ps_policydb_dbase_init(sh, DB_INTERFACE_POLICY, semanage_iface_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (bool_ps_policydb_dbase_init(sh, DB_BOOLEAN_POLICY, semanage_bool_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (fcontext_ps_local_dbase_init(sh,
+				     DB_FCONTEXT_POLICY,
+				     semanage_fcontext_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (seuser_ps_local_dbase_init(sh,
+				   DB_SEUSER_POLICY,
+				   semanage_seuser_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (node_ps_policydb_dbase_init(sh, DB_NODE_POLICY, semanage_node_dbase_policy(sh)) < 0)
+		goto err;
+
+	/* Active kernel policy */
+	if (bool_ps_activedb_dbase_init(sh, DB_BOOLEAN_ACTIVE, semanage_bool_dbase_active(sh)) < 0)
+		goto err;
+
+	return sh->u.ps_handle.socket_fd;
+
+      err:
+	close(sh->u.ps_handle.socket_fd);
+	sh->u.ps_handle.socket_fd = -3;
+	return sh->u.ps_handle.socket_fd;
+}
+
+int semanage_ps_get_commit_number(semanage_handle_t * sh)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint32_t response_type = 0;
+	uint64_t response_length = 0;
+	char *response = NULL;
+	char *ptr = NULL;
+	int status = STATUS_SUCCESS;
+
+	/* Retrieve commit number. */
+	status = write_msg(sh, fd, PS_GET_COMMIT_NUMBER, 0, NULL);
+	if (status != 0) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	status = read_server(sh, fd, &response_type, &response_length, &response);
+	if (status != 0 || response_type != PS_OK) {
+		if (response != NULL)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error getting commit number.");
+
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	ptr = response;
+	status = semanage_policy_table_unserialize_serial(sh, &ptr, &response_length);
+	if (status < 0)
+		goto cleanup;
+
+cleanup:
+	free(response);
+	return status;
+}
+
+/* Callback that allows us to do cleanup on destroy.
+ * Currently does nothing.
+ * NOTE: The destroy callback is explicitly not supposed
+ *       to disconnect.  The client MUST call disconnect
+ *       before calling destroy, for example when handling
+ *       errors during other parts of the transaction.
+ */
+void semanage_ps_destroy(semanage_handle_t * sh)
+{
+	sh = NULL;
+}
+
+/* Disconnect from the server.
+ * Returns 0 on success, -1 on error.
+ */
+int semanage_ps_disconnect(semanage_handle_t * sh)
+{
+	int err = 0;
+
+	write_msg(sh, sh->u.ps_handle.socket_fd, PS_DISCONNECT, 0, NULL);
+
+	/* Release object databases: local modifications */
+	user_ps_local_dbase_release(semanage_user_dbase_local(sh));
+	port_ps_local_dbase_release(semanage_port_dbase_local(sh));
+	iface_ps_local_dbase_release(semanage_iface_dbase_local(sh));
+	bool_ps_local_dbase_release(semanage_bool_dbase_local(sh));
+	fcontext_ps_local_dbase_release(semanage_fcontext_dbase_local(sh));
+	seuser_ps_local_dbase_release(semanage_seuser_dbase_local(sh));
+	node_ps_local_dbase_release(semanage_node_dbase_local(sh));
+
+	/* Release object databases: local modifications + policy */
+	user_ps_policydb_dbase_release(semanage_user_dbase_policy(sh));
+	port_ps_policydb_dbase_release(semanage_port_dbase_policy(sh));
+	iface_ps_policydb_dbase_release(semanage_iface_dbase_policy(sh));
+	bool_ps_policydb_dbase_release(semanage_bool_dbase_policy(sh));
+	fcontext_ps_local_dbase_release(semanage_fcontext_dbase_policy(sh));
+	seuser_ps_local_dbase_release(semanage_seuser_dbase_policy(sh));
+	node_ps_policydb_dbase_release(semanage_node_dbase_policy(sh));
+
+	/* Release object databases: active kernel policy */
+	bool_ps_activedb_dbase_release(semanage_bool_dbase_active(sh));
+
+	err = close(sh->u.ps_handle.socket_fd);
+	sh->u.ps_handle.socket_fd = err;
+	return err;
+}
+
+/* Command the policy server to install a new base module.
+ * Returns 0 on success, -1 if it could not send the command,
+ * or the positive error code received from the server.
+ */
+int semanage_ps_install_base_module(semanage_handle_t * sh,
+				    char *base_data, size_t data_len)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint64_t data_length = data_len;
+	uint32_t response_type = 0;
+	char *response = NULL;
+	int err = 0;
+
+	err = write_msg(sh, fd, PS_BASE_MODULE, data_length, base_data);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &data_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error installing base module.");
+	}
+
+	free(response);
+	return err;
+}
+
+/* Command the policy server to install a module.
+ * Returns 0 on success, -1 if it could not send the command,
+ * or the positive error code received from the server.
+ */
+int semanage_ps_install_module(semanage_handle_t * sh,
+			       char *module_data, size_t data_len)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint64_t data_length = data_len;
+	uint32_t response_type = 0;
+	char *response = NULL;
+	int err = 0;
+
+	err = write_msg(sh, fd, PS_INSTALL_MODULE, data_length, module_data);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &data_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error installing module.");
+	}
+
+	free(response);
+	return err;
+}
+
+/* Obtain from the policy server a list of active modules.
+ * Returns 0 on success, -1 if it could not send the command,
+ * or the positive error code received from the server.
+ * Caller is responsible for freeing modules.
+ */
+int semanage_ps_list_modules(semanage_handle_t * sh,
+			     semanage_module_info_t ** modules, int *num_mods)
+{
+	int status = STATUS_SUCCESS;
+	int fd = sh->u.ps_handle.socket_fd;
+	uint32_t response_type = 0;
+	uint64_t response_length = 0;
+	char *response = NULL;
+
+	status = write_msg(sh, fd, PS_LIST_MODULES, 0, NULL);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	status = read_server(sh, fd, &response_type, &response_length, &response);
+	if (status != STATUS_SUCCESS) {
+		if (response != NULL)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error listing modules.");
+		goto cleanup;
+	}
+
+	char *ptr = response;
+	uint64_t size = response_length;
+	status = semanage_module_list_unserialize(sh, &ptr, &size, modules, num_mods);
+	if (status != STATUS_SUCCESS) {
+		ERR(sh, "Error unserializing modules.");
+		goto cleanup;
+	}
+
+cleanup:
+	free(response);
+	return status;
+}
+
+/* Command the policy server to remove a module.
+ * Returns 0 on success, -1 if it could not send the command,
+ * or the positive error code received from the server.
+ */
+int semanage_ps_remove_module(semanage_handle_t * sh, char *module_name)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint64_t data_length = 0;
+	uint32_t response_type = 0;
+	char *response = NULL;
+	int err = 0;
+
+	data_length = strlen(module_name) + 1;
+	err = write_msg(sh, fd, PS_REMOVE_MODULE, data_length, module_name);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &data_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error removing module.");
+	}
+
+	free(response);
+	return err;
+}
+
+/* Command the policy server to upgrade a module.
+ * Returns 0 on success, -1 if it could not send the command,
+ * or the positive error code received from the server.
+ */
+int semanage_ps_upgrade_module(semanage_handle_t * sh,
+			       char *module_data, size_t data_len)
+{
+	int fd = sh->u.ps_handle.socket_fd;
+	uint64_t data_length = data_len;
+	uint32_t response_type = 0;
+	char *response = NULL;
+	int err = 0;
+
+	err = write_msg(sh, fd, PS_UPGRADE_MODULE, data_length, module_data);
+	if (err)
+		return err;
+
+	err = read_server(sh, fd, &response_type, &data_length, &response);
+	if (err) {
+		if (response)
+			ERR(sh, response);
+		else
+			ERR(sh, "Error upgrading module.");
+	}
+
+	free(response);
+	return err;
+}
+
+/********************* utility functions *********************/
+
+/* This function connects the policy management server to
+ * a local host. The information needed to connect to the
+ * host, and the information returned from this function,
+ * appear in the semange_handle pointed to by sh.
+ *
+ * If the function is successful, the socket descriptor is
+ * put in the semanage_handle structure, and EXIT_SUCCESS is returned.
+ *
+ * If the function fails, an error indicator (a negative number)
+ * is put in the socket descriptor field of the semanage_handle
+ * structure, and EXIT_FAILURE is returned.
+ */
+static int connect_local(semanage_handle_t * sh)
+{
+	char *server_path = sh->conf->store_path;
+	struct sockaddr_un sock;
+
+	sh->u.ps_handle.socket_fd = socket(PF_LOCAL, SOCK_STREAM, 0);
+	if (sh->u.ps_handle.socket_fd < 0) {
+		sh->u.ps_handle.socket_fd = -3;
+		return EXIT_FAILURE;
+	}
+	memset(&sock, 0, sizeof(sock));
+	sock.sun_family = AF_LOCAL;
+	strncpy(sock.sun_path, server_path, sizeof(sock.sun_path) - 1);
+	sock.sun_path[sizeof(sock.sun_path) - 1] = '\0';
+	if (connect(sh->u.ps_handle.socket_fd, (struct sockaddr *)&sock,
+		    sizeof(sock)) < 0) {
+		close(sh->u.ps_handle.socket_fd);
+		sh->u.ps_handle.socket_fd = -1;
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
+
+/* This function connects the policy management server to
+ * a remote host. The information needed to connect to the
+ * host, and the information returned from this function,
+ * appear in the semange_handle pointed to by sh.
+ *
+ * If the function is successful, the socket descriptor is
+ * put in the semanage_handle structure, and EXIT_SUCCESS is returned.
+ *
+ * If the function fails, an error indicator (a negative number)
+ * is put in the socket descriptor field of the semanage_handle
+ * structure, the file descriptor is closed, and EXIT_FAILURE is returned.
+ */
+static int connect_remote(semanage_handle_t * sh)
+{
+	char *server_addr = sh->conf->store_path;
+	int server_port = sh->conf->server_port;
+	struct sockaddr_in sock;
+	struct hostent *host;
+	char address[INET_ADDRSTRLEN];
+	int status;
+
+	sh->u.ps_handle.socket_fd = socket(PF_INET, SOCK_STREAM, 0);
+	if (sh->u.ps_handle.socket_fd < 0) {
+		sh->u.ps_handle.socket_fd = -3;
+		return EXIT_FAILURE;
+	}
+	memset(&sock, 0, sizeof(sock));
+	sock.sin_family = AF_INET;
+	sock.sin_port = htons(server_port);
+
+	host = gethostbyname(server_addr);
+	if (host == NULL) {
+		close(sh->u.ps_handle.socket_fd);
+		sh->u.ps_handle.socket_fd = -2;
+		return EXIT_FAILURE;
+	}
+
+	inet_ntop(AF_INET, host->h_addr, address, INET_ADDRSTRLEN);
+	status = inet_pton(AF_INET, address, &sock.sin_addr);
+	if (status != 1) {
+		close(sh->u.ps_handle.socket_fd);
+		sh->u.ps_handle.socket_fd = -1;
+		return EXIT_FAILURE;
+	}
+
+	status = connect(sh->u.ps_handle.socket_fd, (struct sockaddr *)&sock, sizeof(sock));
+	if (status < 0) {
+		close(sh->u.ps_handle.socket_fd);
+		sh->u.ps_handle.socket_fd = -1;
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
+
+/* This function gets the current status flags from the socket
+ * file descriptor, sets file I/O to non-blocking, and rewrites
+ * the file status flag.
+ *
+ * The value EXIT_SUCCESS is returned if the operation is
+ * successful, otherwise the value EXIT_FAILURE is returned and
+ * the socket file descriptor is closed and set to -3.
+ */
+static int set_file_control(semanage_handle_t * sh)
+{
+	int flags;
+
+	flags = fcntl(sh->u.ps_handle.socket_fd, F_GETFL, 0);
+	if (flags < 0) {
+		close(sh->u.ps_handle.socket_fd);
+		ERR(sh, "F_GETFL error!");
+		sh->u.ps_handle.socket_fd = -3;
+		return EXIT_FAILURE;
+	}
+	flags |= O_NONBLOCK;
+	if (fcntl(sh->u.ps_handle.socket_fd, F_SETFL, flags) < 0) {
+		close(sh->u.ps_handle.socket_fd);
+		ERR(sh, "F_SETFL error!");
+		sh->u.ps_handle.socket_fd = -3;
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
Index: selinux-pms-support/libsemanage/src/ps_api.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/ps_api.h
@@ -0,0 +1,31 @@
+#ifndef _SEMANAGE_PS_API_H_
+#define _SEMANAGE_PS_API_H_
+
+#include <sys/types.h>
+
+struct semanage_handle;
+
+struct semanage_ps_handle {
+	int socket_fd;
+};
+
+int semanage_ps_begintrans(semanage_handle_t * sh);
+int semanage_ps_commit(semanage_handle_t * sh);
+int semanage_ps_connect(semanage_handle_t * sh);
+int semanage_ps_is_managed(semanage_handle_t * sh);
+int semanage_ps_disconnect(semanage_handle_t * sh);
+int semanage_ps_install_base_module(semanage_handle_t * sh, char *base_data,
+				    size_t data_len);
+int semanage_ps_install_module(semanage_handle_t * sh, char *module_data,
+			       size_t data_len);
+int semanage_ps_list_modules(semanage_handle_t * sh,
+			     semanage_module_info_t ** mod_names,
+			     int *num_mods);
+int semanage_ps_list_sandbox(semanage_handle_t * sh);
+int semanage_ps_remove_module(semanage_handle_t * sh, char *module_name);
+int semanage_ps_upgrade_module(semanage_handle_t * sh, char *module_data,
+			       size_t data_len);
+int semanage_ps_get_commit_number(semanage_handle_t * sh);
+void semanage_ps_destroy(semanage_handle_t * sh);
+
+#endif
Index: selinux-pms-support/libsemanage/src/seusers_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/seusers_ps.c
@@ -0,0 +1,58 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser record_t;
+typedef struct semanage_seuser_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "seuser_internal.h"
+#include "database_ps.h"
+#include "debug.h"
+
+int seuser_ps_local_dbase_init(semanage_handle_t * handle,
+			   uint32_t sandbox_id, dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_SEUSER_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void seuser_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *) dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/src/users_ps.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/users_ps.c
@@ -0,0 +1,82 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ * Copyright (C) 2005 Red Hat, Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user record_t;
+typedef struct semanage_user_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "user_internal.h"
+#include "database_ps.h"
+#include "database_join.h"
+#include "debug.h"
+
+int user_ps_local_dbase_init(
+		semanage_handle_t * handle,
+		uint32_t sandbox_id,
+		dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_USER_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_ps_local_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *)dconfig->dbase);
+}
+
+int user_ps_policydb_dbase_init(
+		semanage_handle_t * handle,
+		uint32_t sandbox_id,
+		dbase_config_t * dconfig)
+{
+	if (dbase_ps_init(
+		handle,
+		sandbox_id,
+		&SEMANAGE_USER_RTABLE,
+		(dbase_ps_t **)(&dconfig->dbase)) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_PS_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_ps_policydb_dbase_release(dbase_config_t * dconfig)
+{
+	dbase_ps_release((dbase_ps_t *)dconfig->dbase);
+}
Index: selinux-pms-support/libsemanage/tests/globals.h
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/globals.h
+++ selinux-pms-support/libsemanage/tests/globals.h
@@ -24,4 +24,43 @@
 
 semanage_handle_t *sh;
 
+/* ps_api */
+pid_t ps_pid;
+char *socket_path;
+int server_socket_fd;
+int client_socket_fd;
+
+typedef int (*create_f) (
+			struct semanage_handle * handle,
+			record_t ** rec);
+typedef int (*key_extract_f) (
+			struct semanage_handle * handle,
+			const record_t * rec,
+			record_key_t ** key);
+typedef void (*key_free_f) (record_key_t * key);
+typedef int (*compare_f) (
+			const record_t * rec,
+			const record_key_t * key);
+typedef int (*compare2_f) (
+			const record_t * rec,
+			const record_t * rec2);
+typedef int (*compare2_qsort_f) (
+			const record_t ** rec,
+			const record_t ** rec2);
+typedef int (*clone_f) (
+			struct semanage_handle * handle,
+			const record_t * rec,
+			record_t ** new_rec);
+typedef int (*serialize_f) (
+			struct semanage_handle* handle,
+			const record_t* rec,
+			char** rec_data,
+			uint64_t* size);
+typedef int (*unserialize_f) (
+			struct semanage_handle* handle,
+			char** rec_data,
+			uint64_t* size,
+			record_t** rec);
+typedef void (*free_f) (record_t * rec);
+
 #endif
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -30,6 +30,9 @@
 #include "test_seuser_record.h"
 #include "test_user_record.h"
 
+#include "test_ps_api_connect.h"
+#include "test_ps_api_disconnect.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -74,6 +77,19 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(seuser_record);
 	DECLARE_SUITE(user_record);
 
+	/* The ps_api_connect test forks the
+	 * tests into client and server variants.
+	 */
+	DECLARE_SUITE(ps_api_connect);
+
+	/* These tests rely upon the policy server
+	 * being properly connected via the
+	 * ps_api_connect test.
+	 */
+
+	/* The ps_api_disconnect test 'unforks'. */
+	DECLARE_SUITE(ps_api_disconnect);
+
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
 	else
Index: selinux-pms-support/libsemanage/tests/test_ps_api_connect.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ps_api_connect.c
@@ -0,0 +1,346 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*  The purpose of this file is to provide unit tests of the functions in:
+ *
+ *  libsemanage/src/ps_api.c
+ *
+ *  test_ps_api_connect.c and test_ps_api_disconnect.c should be used
+ *  together.  The logic behind a seperate test file for connection
+ *  and disconnection is that their seperation allows other tests which
+ *  also rely on the policy server being connected to run in between
+ *  the connect and disconnect tests.
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_ps_api_connect.h"
+
+#include <libgen.h>
+#include <limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <CUnit/Basic.h>
+
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <selinux/selinux.h>
+
+#include "debug.h"
+#include "byteswap.h"
+#include "handle.h"
+#include "modules.h"
+#include "policy.h"
+#include "ps_api.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_policydb.h"
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "port_internal.h"
+#include "iface_internal.h"
+#include "boolean_internal.h"
+#include "fcontext_internal.h"
+#include "node_internal.h"
+
+/* PS API stub functions. */
+
+int ps_api_test_get_serial(semanage_handle_t *sh)
+{
+	return 0;
+}
+
+void ps_api_test_destroy(semanage_handle_t *sh)
+{
+}
+
+int ps_api_test_disconnect(semanage_handle_t *sh)
+{
+	return 0;
+}
+
+int ps_api_test_begin_trans(semanage_handle_t *sh)
+{
+	return 0;
+}
+
+int ps_api_test_commit(semanage_handle_t *sh)
+{
+	return 0;
+}
+
+int ps_api_test_install(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+int ps_api_test_upgrade(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+int ps_api_test_remove(
+	semanage_handle_t *sh,
+	char *data)
+{
+	return 0;
+}
+
+int ps_api_test_list(
+	semanage_handle_t *sh,
+	semanage_module_info_t **modules,
+	int *modules_size)
+{
+	return 0;
+}
+
+int ps_api_test_install_base(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+struct semanage_policy_table server_funcs = {
+	.get_serial = ps_api_test_get_serial,
+	.destroy = ps_api_test_destroy,
+	.disconnect = ps_api_test_disconnect,
+	.begin_trans = ps_api_test_begin_trans,
+	.commit = ps_api_test_commit,
+	.install = ps_api_test_install,
+	.upgrade = ps_api_test_upgrade,
+	.install_base = ps_api_test_install_base,
+	.remove = ps_api_test_remove,
+	.list = ps_api_test_list
+};
+
+struct semanage_policy_table client_funcs = {
+	.get_serial = semanage_ps_get_commit_number,
+	.destroy = semanage_ps_destroy,
+	.disconnect = semanage_ps_disconnect,
+	.begin_trans = semanage_ps_begintrans,
+	.commit = semanage_ps_commit,
+	.install = semanage_ps_install_module,
+	.upgrade = semanage_ps_upgrade_module,
+	.remove = semanage_ps_remove_module,
+	.list = semanage_ps_list_modules,
+	.install_base = semanage_ps_install_base_module
+};
+
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int ps_api_connect_test_init(void)
+{
+	int status = 0;
+
+	/* initialize the handle */
+	sh = semanage_handle_create();
+	if (sh == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* hide error messages */
+	sh->msg_callback = test_msg_handler;
+
+	/* Decide where our socket path will be. */
+	socket_path = "/tmp/test-policy-server";
+	remove(socket_path);
+
+	/* Fork. */
+	if ((ps_pid = fork()) < 0) {
+		status = errno;
+		goto cleanup;
+	}
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Store setup. */
+		sh->funcs = &server_funcs;
+
+		/* Networking. */
+		struct sockaddr_un serv_addr;
+		int flags;
+
+		if ((server_socket_fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
+			status = errno;
+			goto cleanup;
+		}
+
+		serv_addr.sun_family = AF_UNIX;
+		strncpy(serv_addr.sun_path, socket_path, sizeof(serv_addr.sun_path));
+		serv_addr.sun_path[sizeof(serv_addr.sun_path) - 1] = '\0';
+
+		if (bind(server_socket_fd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) == -1) {
+			status = errno;
+			goto cleanup;
+		}
+
+		if (listen(server_socket_fd, 1) == -1) {
+			status = errno;
+			goto cleanup;
+		}
+
+		if ((flags = fcntl(server_socket_fd, F_GETFD)) == -1) {
+			status = errno;
+			goto cleanup;
+		}
+		flags |= FD_CLOEXEC;
+		if (fcntl(server_socket_fd, F_SETFD, flags) == -1) {
+			status = errno;
+			goto cleanup;
+		}
+
+		sh->is_connected = 1;
+	}
+	else {
+		/* Client code. */
+
+		sh->funcs = &client_funcs;
+	}
+
+cleanup:
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+		ps_api_connect_test_cleanup();
+	}
+
+	return status;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int ps_api_connect_test_cleanup(void)
+{
+	/* Do nothing.  Cleanup will be done by ps_api_disconnect_test_cleanup() */
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int ps_api_connect_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_ps_connect", test_semanage_ps_connect))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_ps_connect function in ps_api.c
+*/
+void test_semanage_ps_connect(void)
+{
+	int status = 0;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Wait for client to connect. */
+		struct sockaddr client_addr;
+		socklen_t client_len = sizeof(struct sockaddr);
+		client_socket_fd = accept(server_socket_fd, &client_addr, &client_len);
+
+		CU_ASSERT( client_socket_fd >= 0 );
+		if (client_socket_fd < 0) {
+			status = errno;
+			goto cleanup;
+		}
+
+		/* Block waiting for a message. */
+
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		/* Perform handshake. */
+		CU_ASSERT( message_type == PS_CONNECT );
+		if (message_type != PS_CONNECT) {
+			status = -1;
+			goto cleanup;
+		}
+
+		char *motd = "MOTD: Hello.\0";
+		if ((status = write_msg(sh, client_socket_fd, PS_OK, strlen(motd) + 1, motd)))
+			goto cleanup;
+
+	}
+	else {
+		/* Client code. */
+
+		/* Fake store. */
+		sh->conf->store_type = SEMANAGE_CON_POLSERV_LOCAL;
+		sh->conf->store_path = strdup(socket_path);
+
+		/* FIXME: Waiting for server to finish setting up. */
+		sleep(1);
+
+		/* Connect to server. */
+		status = semanage_connect(sh);
+		CU_ASSERT( status == 0 );
+	}
+
+	/* cleanup */
+cleanup:
+	free(data);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+		ps_api_connect_test_cleanup();
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_ps_api_connect.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ps_api_connect.h
@@ -0,0 +1,33 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_PS_API_CONNECT_H__
+#define __TEST_PS_API_CONNECT_H__
+
+#include "handle.h"
+#include <CUnit/Basic.h>
+
+int ps_api_connect_test_init(void);
+int ps_api_connect_test_cleanup(void);
+int ps_api_connect_add_tests(CU_pSuite suite);
+
+void test_semanage_ps_connect(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_ps_api_disconnect.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ps_api_disconnect.c
@@ -0,0 +1,178 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*  The purpose of this file is to provide unit tests of the functions in:
+ *
+ *  libsemanage/src/ps_api.c
+ *
+ *  test_ps_api_connect.c and test_ps_api_disconnect.c should be used
+ *  together.  The logic behind a seperate test file for connection
+ *  and disconnection is that their seperation allows other tests which
+ *  also rely on the policy server being connected to run in between
+ *  the connect and disconnect tests.
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_ps_api_disconnect.h"
+
+#include <libgen.h>
+#include <limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <CUnit/Basic.h>
+
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <selinux/selinux.h>
+
+#include "debug.h"
+#include "byteswap.h"
+#include "handle.h"
+#include "modules.h"
+#include "policy.h"
+#include "ps_api.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_policydb.h"
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "port_internal.h"
+#include "iface_internal.h"
+#include "boolean_internal.h"
+#include "fcontext_internal.h"
+#include "node_internal.h"
+
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int ps_api_disconnect_test_init(void)
+{
+	/* Do nothing.  ps_api_connect_test_init should have set everything up. */
+	return 0;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int ps_api_disconnect_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+
+	if (ps_pid > 0) {
+		/* Client code. */
+	}
+
+	if (ps_pid == 0) {
+		/* Policy server code. */
+
+		/* Close sockets. */
+		close(client_socket_fd);
+		close(server_socket_fd);
+		remove(socket_path);
+
+		exit(0);
+	}
+
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int ps_api_disconnect_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_ps_disconnect", test_semanage_ps_disconnect))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_ps_disconnect function in ps_api.c
+*/
+void test_semanage_ps_disconnect(void)
+{
+	int status = 0;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	if (ps_pid == 0) {
+		/* Policy server code. */
+
+		/* Block waiting for a message. */
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		/* Perform disconnect. */
+		CU_ASSERT( message_type == PS_DISCONNECT );
+		if (message_type != PS_DISCONNECT) {
+			status = -1;
+			goto cleanup;
+		}
+
+		if (sh->funcs != NULL) {
+			status = semanage_disconnect(sh);
+			CU_ASSERT( status == 0 );
+		}
+	}
+	else {
+		/* Client code. */
+
+		/* Disconnect from ps. */
+		if (sh->funcs != NULL) {
+			status = semanage_disconnect(sh);
+			CU_ASSERT( status == 0 );
+		}
+	}
+
+cleanup:
+	free(data);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+		ps_api_disconnect_test_cleanup();
+	}
+}
Index: selinux-pms-support/libsemanage/tests/test_ps_api_disconnect.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ps_api_disconnect.h
@@ -0,0 +1,33 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_PS_API_DISCONNECT_H__
+#define __TEST_PS_API_DISCONNECT_H__
+
+#include <CUnit/Basic.h>
+
+int ps_api_disconnect_test_init(void);
+int ps_api_disconnect_test_cleanup(void);
+int ps_api_disconnect_add_tests(CU_pSuite suite);
+
+void test_semanage_ps_connect(void);
+void test_semanage_ps_disconnect(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
