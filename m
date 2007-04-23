Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUgYu001729
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:42 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUfSG027876
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:41 GMT
Message-Id: <20070423213740.878372000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:16 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 21/33] libsemanage: user serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/users_local.h  |   28 ++++-
 libsemanage/include/semanage/users_policy.h |    6 +
 libsemanage/src/user_base_record.c          |   46 ++++++++
 libsemanage/src/user_extra_record.c         |  127 +++++++++++++++++++++++
 libsemanage/src/user_internal.h             |  105 +++++++++++++++++++
 libsemanage/src/user_record.c               |  120 +++++++++++++++++++++
 libsemanage/src/users_local.c               |   16 ++
 libsemanage/src/users_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c       |    2 
 libsemanage/tests/test_user_record.c        |  153 ++++++++++++++++++++++++++++
 libsemanage/tests/test_user_record.h        |   32 +++++
 11 files changed, 647 insertions(+), 4 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/users_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/users_local.h
+++ selinux-pms-support/libsemanage/include/semanage/users_local.h
@@ -1,8 +1,28 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
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
 
 #ifndef _SEMANAGE_USERS_LOCAL_H_
 #define _SEMANAGE_USERS_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/user_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_user_list_local(sema
 				    semanage_user_t *** records,
 				    unsigned int *count);
 
+extern int semanage_user_serialize_local(semanage_handle_t * handle,
+					 char **data, uint64_t * data_length);
+
+extern int semanage_user_unserialize_local(semanage_handle_t * handle,
+					   char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/users_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/users_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/users_policy.h
@@ -24,4 +24,10 @@ extern int semanage_user_iterate(semanag
 extern int semanage_user_list(semanage_handle_t * handle,
 			      semanage_user_t *** records, unsigned int *count);
 
+extern int semanage_user_serialize_policy(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_user_unserialize_policy(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/user_base_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/user_base_record.c
+++ selinux-pms-support/libsemanage/src/user_base_record.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
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
 
 /* Object: semanage_user_base_t (SELinux User/Class Policy Object)
  * Object: semanage_user_key_t (SELinux User/Class Key)
@@ -171,6 +191,28 @@ hidden void semanage_user_base_free(sema
 	sepol_user_free(user);
 }
 
+/* Serialize/Unserialize */
+
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_user_base_calculate_serialized_size(). */
+hidden int semanage_user_base_serialize(semanage_handle_t * handle,
+					const semanage_user_base_t * user_base,
+					char **data, uint64_t * size)
+{
+	return sepol_user_serialize(handle->sepolh, user_base, data, size);
+}
+
+/** Destructively modifies user_base, data and size.
+ *  Allocates space for user_base.
+ *  Caller must free. */
+hidden int semanage_user_base_unserialize(semanage_handle_t * handle,
+					  char **data, uint64_t * size,
+					  semanage_user_base_t ** user_base)
+{
+	return sepol_user_unserialize(handle->sepolh, data, size, user_base);
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_USER_BASE_RTABLE = {
 	.create = semanage_user_base_create,
@@ -181,4 +223,6 @@ record_table_t SEMANAGE_USER_BASE_RTABLE
 	.compare2 = semanage_user_base_compare2,
 	.compare2_qsort = semanage_user_base_compare2_qsort,
 	.free = semanage_user_base_free,
+	.serialize = semanage_user_base_serialize,
+	.unserialize = semanage_user_base_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/user_extra_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/user_extra_record.c
+++ selinux-pms-support/libsemanage/src/user_extra_record.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
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
 
 /* Object: semanage_user_extra_t (SELinux User/Class Extra Data)
  * Object: semanage_user_extra_key_t (SELinux User/Class Key)
@@ -16,12 +36,14 @@ typedef struct semanage_user_extra recor
 typedef semanage_user_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <assert.h>
 #include <semanage/handle.h>
 #include <stdlib.h>
 #include <string.h>
 #include "user_internal.h"
 #include "debug.h"
 #include "database.h"
+#include "serialize.h"
 
 struct semanage_user_extra {
 	/* This user's name */
@@ -184,6 +206,107 @@ hidden int semanage_user_extra_clone(sem
 	return STATUS_ERR;
 }
 
+/* Serialize/Unserialize */
+
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_user_extra_calculate_serialized_size(). */
+hidden int semanage_user_extra_serialize(semanage_handle_t * handle,
+					 const semanage_user_extra_t *
+					 user_extra, char **data,
+					 uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+	const char *prefix = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && user_extra != NULL);
+
+	/* User extra name. */
+	name = semanage_user_extra_get_name(user_extra);
+	status =
+	    semanage_serialize(handle,
+			       name,
+			       (name == NULL) ? 0 : strlen(name),
+			       SEMANAGE_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User extra prefix. */
+	prefix = semanage_user_extra_get_prefix(user_extra);
+	status =
+	    semanage_serialize(handle,
+			       prefix,
+			       (prefix == NULL) ? 0 : strlen(prefix),
+			       SEMANAGE_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+/** Destructively modifies user_extra, data and size.
+ *  Allocates space for user_extra.
+ *  Caller must free. */
+hidden int semanage_user_extra_unserialize(semanage_handle_t * handle,
+					   char **data, uint64_t * size,
+					   semanage_user_extra_t ** user_extra)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+	char *prefix = NULL;
+	size_t *prefix_size = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && data != NULL && *data != NULL && size != NULL);
+
+	/* Allocate space. */
+	if ((status = semanage_user_extra_create(handle, user_extra)))
+		goto cleanup;
+
+	/* User extra name. */
+	status =
+	    semanage_unserialize(handle,
+				 data, size,
+				 (void **)&name,
+				 &name_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL) {
+		status =
+		    semanage_user_extra_set_name(handle, *user_extra, name);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* User extra name. */
+	status =
+	    semanage_unserialize(handle,
+				 data, size,
+				 (void **)&prefix,
+				 &prefix_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (prefix != NULL) {
+		status =
+		    semanage_user_extra_set_prefix(handle, *user_extra, prefix);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+      cleanup:
+	free(name);
+	free(name_size);
+	free(prefix);
+	free(prefix_size);
+	return status;
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_USER_EXTRA_RTABLE = {
 	.create = semanage_user_extra_create,
@@ -194,4 +317,6 @@ record_table_t SEMANAGE_USER_EXTRA_RTABL
 	.compare2 = semanage_user_extra_compare2,
 	.compare2_qsort = semanage_user_extra_compare2_qsort,
 	.free = semanage_user_extra_free,
+	.serialize = semanage_user_extra_serialize,
+	.unserialize = semanage_user_extra_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/user_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/user_internal.h
+++ selinux-pms-support/libsemanage/src/user_internal.h
@@ -1,11 +1,36 @@
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
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
 #ifndef _SEMANAGE_USER_INTERNAL_H_
 #define _SEMANAGE_USER_INTERNAL_H_
 
+#include <inttypes.h>
 #include <sepol/user_record.h>
 #include <semanage/user_record.h>
 #include <semanage/users_local.h>
 #include <semanage/users_policy.h>
 #include "database.h"
+#include "database_policydb.h"
+#include "database_join.h"
 #include "handle.h"
 #include "dso.h"
 
@@ -30,9 +55,11 @@ hidden_proto(semanage_user_add_role)
 
 /* USER record: metod table */
 extern record_table_t SEMANAGE_USER_RTABLE;
+extern record_join_table_t SEMANAGE_USER_JOIN_RTABLE;
 
 /* USER BASE record: method table */
 extern record_table_t SEMANAGE_USER_BASE_RTABLE;
+extern record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE;
 
 /* USER EXTRA record: method table */
 extern record_table_t SEMANAGE_USER_EXTRA_RTABLE;
@@ -46,6 +73,13 @@ extern int user_base_file_dbase_init(sem
 
 extern void user_base_file_dbase_release(dbase_config_t * dconfig);
 
+/* USER BASE record, PS backend */
+extern int user_base_ps_local_dbase_init(semanage_handle_t * handle,
+				   uint32_t sandbox_id,
+				   dbase_config_t * dconfig);
+
+extern void user_base_ps_local_dbase_release(dbase_config_t * dconfig);
+
 /* USER EXTRA record, FILE backend */
 extern int user_extra_file_dbase_init(semanage_handle_t * handle,
 				      const char *fname,
@@ -53,12 +87,26 @@ extern int user_extra_file_dbase_init(se
 
 extern void user_extra_file_dbase_release(dbase_config_t * dconfig);
 
+/* USER EXTRA record, PS backend */
+extern int user_extra_ps_local_dbase_init(semanage_handle_t * handle,
+				    uint32_t sandbox_id,
+				    dbase_config_t * dconfig);
+
+extern void user_extra_ps_local_dbase_release(dbase_config_t * dconfig);
+
 /* USER BASE record, POLICYDB backend */
 extern int user_base_policydb_dbase_init(semanage_handle_t * handle,
 					 dbase_config_t * dconfig);
 
 extern void user_base_policydb_dbase_release(dbase_config_t * dconfig);
 
+/* USER BASE record, PS POLICYDB backend */
+extern int user_base_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+					    dbase_config_t * dconfig);
+
+extern void user_base_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
 /* USER record, JOIN backend */
 extern int user_join_dbase_init(semanage_handle_t * handle,
 				dbase_config_t * join1,
@@ -67,6 +115,19 @@ extern int user_join_dbase_init(semanage
 
 extern void user_join_dbase_release(dbase_config_t * dconfig);
 
+extern int user_ps_local_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				   dbase_config_t * dconfig);
+
+extern void user_ps_local_dbase_release(dbase_config_t * dconfig);
+
+extern int user_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				   dbase_config_t * dconfig);
+
+extern void user_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
+
 /*======= Internal API: Base (Policy) User record ====== */
 
 #ifndef _SEMANAGE_USER_BASE_DEFINED_
@@ -131,6 +192,21 @@ hidden int semanage_user_base_set_roles(
 
 hidden void semanage_user_base_free(semanage_user_base_t * user);
 
+hidden int semanage_user_base_calculate_serialized_size(semanage_handle_t *
+							handle,
+							const
+							semanage_user_base_t *
+							user_base,
+							uint64_t * size);
+
+hidden int semanage_user_base_serialize(semanage_handle_t * handle,
+					const semanage_user_base_t * user_base,
+					char **data, uint64_t * size);
+
+hidden int semanage_user_base_unserialize(semanage_handle_t * handle,
+					  char **data, uint64_t * size,
+					  semanage_user_base_t ** user_base);
+
 /*=========== Internal API: Extra User record ==========*/
 struct semanage_user_extra;
 typedef struct semanage_user_extra semanage_user_extra_t;
@@ -158,6 +234,22 @@ hidden int semanage_user_extra_set_prefi
 
 hidden void semanage_user_extra_free(semanage_user_extra_t * user_extra);
 
+hidden int semanage_user_extra_calculate_serialized_size(semanage_handle_t *
+							 handle,
+							 const
+							 semanage_user_extra_t *
+							 user_extra,
+							 uint64_t * size);
+
+hidden int semanage_user_extra_serialize(semanage_handle_t * handle,
+					 const semanage_user_extra_t *
+					 user_extra, char **data,
+					 uint64_t * size);
+
+hidden int semanage_user_extra_unserialize(semanage_handle_t * handle,
+					   char **data, uint64_t * size,
+					   semanage_user_extra_t ** user_extra);
+
 /*======== Internal API: Join record ========== */
 hidden void semanage_user_key_unpack(const semanage_user_key_t * key,
 				     const char **name);
@@ -172,4 +264,17 @@ hidden int semanage_user_split(semanage_
 			       semanage_user_base_t ** split1,
 			       semanage_user_extra_t ** split2);
 
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_user_calculate_serialized_size(semanage_handle_t * handle,
+						   const semanage_user_t * user,
+						   uint64_t * size);
+
+hidden int semanage_user_serialize(semanage_handle_t * handle,
+				   const semanage_user_t * user,
+				   char **data, uint64_t * size);
+
+hidden int semanage_user_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_user_t ** user);
+
 #endif
Index: selinux-pms-support/libsemanage/src/user_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/user_record.c
+++ selinux-pms-support/libsemanage/src/user_record.c
@@ -1,4 +1,24 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
+/* Authors: Ivan Gyurdiev        <ivg2@cornell.edu>
+ *          Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case           <ccase@tresys.com>
+ *
+ * Copyright (C) 2005 Red Hat, Inc.
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
 
 /* Object: semanage_user_t (SELinux User/Class)
  * Object: semanage_user_key_t (SELinux User/Class Key)
@@ -16,12 +36,14 @@ typedef struct semanage_user record_t;
 typedef semanage_user_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 #include "user_internal.h"
 #include "handle.h"
 #include "database.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct semanage_user {
 	char *name;
@@ -305,6 +327,100 @@ void semanage_user_free(semanage_user_t 
 
 hidden_def(semanage_user_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_user_calculate_serialized_size(). */
+hidden int semanage_user_serialize(semanage_handle_t * handle,
+				   const semanage_user_t * user,
+				   char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && user != NULL);
+
+	/* User name. */
+	name = semanage_user_get_name(user);
+	status =
+	    semanage_serialize(handle,
+			       name,
+			       (name == NULL) ? 0 : strlen(name),
+			       SEMANAGE_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User base. */
+	status = semanage_user_base_serialize(handle, user->base, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User extra. */
+	status = semanage_user_extra_serialize(handle, user->extra, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+/** Destructively modifies user, data and size.
+ *  Allocates space for user.
+ *  Caller must free. */
+hidden int semanage_user_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_user_t ** user)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && data != NULL && *data != NULL && size != NULL);
+
+	/* Allocate space. */
+	if ((status = semanage_user_create(handle, user)))
+		goto cleanup;
+
+	/* User name. */
+	status =
+	    semanage_unserialize(handle,
+				 data, size,
+				 (void **)&name,
+				 &name_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL) {
+		status = semanage_user_set_name(handle, *user, name);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* User base. */
+	semanage_user_base_free((*user)->base);
+	status =
+	    semanage_user_base_unserialize(handle,
+					   data, size, &((*user)->base));
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* User extra. */
+	semanage_user_extra_free((*user)->extra);
+	status =
+	    semanage_user_extra_unserialize(handle,
+					    data, size, &((*user)->extra));
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(name);
+	free(name_size);
+	return status;
+}
+
 /* Join properties */
 hidden int semanage_user_join(semanage_handle_t * handle,
 			      const semanage_user_base_t * record1,
@@ -407,4 +523,6 @@ record_table_t SEMANAGE_USER_RTABLE = {
 	.compare2 = semanage_user_compare2,
 	.compare2_qsort = semanage_user_compare2_qsort,
 	.free = semanage_user_free,
+	.serialize = semanage_user_serialize,
+	.unserialize = semanage_user_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/users_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/users_local.c
+++ selinux-pms-support/libsemanage/src/users_local.c
@@ -68,3 +68,19 @@ int semanage_user_list_local(semanage_ha
 	dbase_config_t *dconfig = semanage_user_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_user_serialize_local(semanage_handle_t * handle,
+				  char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_user_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_user_unserialize_local(semanage_handle_t * handle,
+				    char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_user_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/users_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/users_policy.c
+++ selinux-pms-support/libsemanage/src/users_policy.c
@@ -54,3 +54,19 @@ int semanage_user_list(semanage_handle_t
 	dbase_config_t *dconfig = semanage_user_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_user_serialize_policy(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_user_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_user_unserialize_policy(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_user_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -28,6 +28,7 @@
 #include "test_node_record.h"
 #include "test_port_record.h"
 #include "test_seuser_record.h"
+#include "test_user_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -71,6 +72,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(node_record);
 	DECLARE_SUITE(port_record);
 	DECLARE_SUITE(seuser_record);
+	DECLARE_SUITE(user_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_user_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_user_record.c
@@ -0,0 +1,153 @@
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
+#include "user_internal.h"
+#include "user_record.h"
+#include <semanage/user_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_user_record.h"
+
+#include <libgen.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <CUnit/Basic.h>
+
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int user_record_test_init(void)
+{
+	/* initialize the handle */
+	sh = semanage_handle_create();
+	if (sh == NULL)
+		return -1;
+
+	/* hide error messages */
+	sh->msg_callback = test_msg_handler;
+
+	return 0;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int user_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int user_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_user_serialize",
+			test_semanage_user_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_user_serialize function in user_record.c
+ */
+void test_semanage_user_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_user_t *user;
+	status = semanage_user_create(sh, &user);
+
+	/* setup test fields */
+	const char *name = "testname";
+	/* const char *mlslevel = NULL; */
+	/* const char *mlsrange = NULL; */
+	const char *roles[] = { "testrole1", "testrole2" };
+	unsigned int roles_size = 2;
+	const char *prefix = "testprefix";
+
+	status = semanage_user_set_name(sh, user, name);
+	/* status = semanage_user_set_mlslevel(sh, user, mlslevel); */
+	/* status = semanage_user_set_mlsrange(sh, user, mlsrange); */
+	status = semanage_user_set_roles(sh, user, roles, roles_size);
+	status = semanage_user_set_prefix(sh, user, prefix);
+
+	/* set aside enough space... */
+	status = semanage_user_serialize(sh, user, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_user_serialize(sh, user, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_user_t *user2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status = semanage_user_unserialize(sh, &data2, &data_length2, &user2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	const char *name2;
+	const char *mlslevel2;
+	const char *mlsrange2;
+	const char **roles2;
+	unsigned int roles_size2;
+	const char *prefix2;
+
+	name2 = semanage_user_get_name(user2);
+	mlslevel2 = semanage_user_get_mlslevel(user2);
+	mlsrange2 = semanage_user_get_mlsrange(user2);
+	status = semanage_user_get_roles(sh, user2, &roles2, &roles_size2);
+	CU_ASSERT(status == 0);
+	prefix2 = semanage_user_get_prefix(user2);
+
+	/* compare */
+	CU_ASSERT(strcmp(name, name2) == 0);
+	CU_ASSERT(mlslevel2 == NULL);
+	CU_ASSERT(mlsrange2 == NULL);
+	CU_ASSERT(roles_size == roles_size2);
+	CU_ASSERT(strcmp(roles[0], roles2[0]) == 0);
+	CU_ASSERT(strcmp(roles[1], roles2[1]) == 0);
+
+	/* cleanup */
+	semanage_user_free(user);
+	semanage_user_free(user2);
+	free(roles2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_user_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_user_record.h
@@ -0,0 +1,32 @@
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
+#ifndef __TEST_USER_RECORD_H__
+#define __TEST_USER_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int user_record_test_init(void);
+int user_record_test_cleanup(void);
+int user_record_add_tests(CU_pSuite suite);
+
+void test_semanage_user_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
