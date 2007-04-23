Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUc64001684
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:38 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUaSG027849
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:37 GMT
Message-Id: <20070423213735.837709000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:11 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 16/33] libsemanage: fcontext serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/fcontexts_local.h  |   30 ++++
 libsemanage/include/semanage/fcontexts_policy.h |    8 +
 libsemanage/src/fcontext_internal.h             |   46 ++++++
 libsemanage/src/fcontext_record.c               |  164 +++++++++++++++++++++++
 libsemanage/src/fcontexts_local.c               |   37 +++++
 libsemanage/src/fcontexts_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c           |    2 
 libsemanage/tests/test_fcontext_record.c        |  171 ++++++++++++++++++++++++
 libsemanage/tests/test_fcontext_record.h        |   32 ++++
 9 files changed, 503 insertions(+), 3 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/fcontexts_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/fcontexts_local.h
+++ selinux-pms-support/libsemanage/include/semanage/fcontexts_local.h
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
 
 #ifndef _SEMANAGE_FCONTEXTS_LOCAL_H_
 #define _SEMANAGE_FCONTEXTS_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/fcontext_record.h>
 #include <semanage/handle.h>
 
@@ -34,4 +54,12 @@ extern int semanage_fcontext_list_local(
 					semanage_fcontext_t *** records,
 					unsigned int *count);
 
+extern int semanage_fcontext_serialize_local(semanage_handle_t * handle,
+					     char **data,
+					     uint64_t * data_length);
+
+extern int semanage_fcontext_unserialize_local(semanage_handle_t * handle,
+					       char *data,
+					       uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/fcontexts_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/fcontexts_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/fcontexts_policy.h
@@ -26,4 +26,12 @@ extern int semanage_fcontext_list(semana
 				  semanage_fcontext_t *** records,
 				  unsigned int *count);
 
+extern int semanage_fcontext_serialize_policy(semanage_handle_t * handle,
+					      char **data,
+					      uint64_t * data_length);
+
+extern int semanage_fcontext_unserialize_policy(semanage_handle_t * handle,
+						char *data,
+						uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/fcontext_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/fcontext_internal.h
+++ selinux-pms-support/libsemanage/src/fcontext_internal.h
@@ -1,6 +1,29 @@
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
 #ifndef _SEMANAGE_FCONTEXT_INTERNAL_H_
 #define _SEMANAGE_FCONTEXT_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/fcontext_record.h>
 #include <semanage/fcontexts_local.h>
 #include <semanage/fcontexts_policy.h>
@@ -26,7 +49,7 @@ hidden_proto(semanage_fcontext_key_creat
     hidden_proto(semanage_fcontext_free)
     hidden_proto(semanage_fcontext_iterate_local)
 
-/* FCONTEXT RECORD: metod table */
+/* FCONTEXT RECORD: method table */
 extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
 
 extern int fcontext_file_dbase_init(semanage_handle_t * handle,
@@ -35,8 +58,29 @@ extern int fcontext_file_dbase_init(sema
 
 extern void fcontext_file_dbase_release(dbase_config_t * dconfig);
 
+extern int fcontext_ps_local_dbase_init(semanage_handle_t * handle,
+				  uint32_t sandbox_id,
+				  dbase_config_t * dconfig);
+
+extern void fcontext_ps_local_dbase_release(dbase_config_t * dconfig);
+
 extern int hidden semanage_fcontext_validate_local(semanage_handle_t * handle,
 						   const sepol_policydb_t *
 						   policydb);
 
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_fcontext_calculate_serialized_size(semanage_handle_t *
+						       handle,
+						       const semanage_fcontext_t
+						       * fcontext,
+						       uint64_t * size);
+
+hidden int semanage_fcontext_serialize(semanage_handle_t * handle,
+				       const semanage_fcontext_t * fcontext,
+				       char **data, uint64_t * size);
+
+hidden int semanage_fcontext_unserialize(semanage_handle_t * handle,
+					 char **data, uint64_t * size,
+					 semanage_fcontext_t ** fcontext);
+
 #endif
Index: selinux-pms-support/libsemanage/src/fcontext_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/fcontext_record.c
+++ selinux-pms-support/libsemanage/src/fcontext_record.c
@@ -1,14 +1,38 @@
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
 struct semanage_fcontext;
 struct semanage_fcontext_key;
 typedef struct semanage_fcontext record_t;
 typedef struct semanage_fcontext_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 #include "fcontext_internal.h"
 #include "context_internal.h"
 #include "debug.h"
+#include "serialize.h"
 
 struct semanage_fcontext {
 
@@ -298,6 +322,144 @@ void semanage_fcontext_free(semanage_fco
 
 hidden_def(semanage_fcontext_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_fcontext_calculate_serialized_size(). */
+hidden int semanage_fcontext_serialize(semanage_handle_t * handle,
+				       const semanage_fcontext_t * fcontext,
+				       char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *expr;
+	int32_t type;
+	semanage_context_t *con;
+	int32_t flag;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && fcontext != NULL);
+
+	/* Fcontext regex. */
+	expr = semanage_fcontext_get_expr(fcontext);
+	status =
+	    semanage_serialize(handle,
+			       expr,
+			       (expr == NULL) ? 0 : strlen(expr),
+			       SEMANAGE_SERIAL_STRING, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Fcontext type. */
+	type = semanage_fcontext_get_type(fcontext);
+	status =
+	    semanage_serialize(handle, &type, 0, SEMANAGE_SERIAL_INT32_T, data, size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Fcontext context. */
+	con = semanage_fcontext_get_con(fcontext);
+	flag = (con == NULL) ? 0 : 1;
+	status = semanage_serialize(
+				handle,
+				&flag,
+				0,
+				SEMANAGE_SERIAL_INT32_T,
+				data,
+				size);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	if (flag == 1) {
+		status =
+		    semanage_context_serialize(handle,
+					       semanage_fcontext_get_con(fcontext),
+					       data, size);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+/** Destructively modifies fcontext, data and size.
+ *  Allocates space for fcontext.
+ *  Caller must free. */
+hidden int semanage_fcontext_unserialize(semanage_handle_t * handle,
+					 char **data, uint64_t * size,
+					 semanage_fcontext_t ** fcontext)
+{
+	int status = STATUS_SUCCESS;
+	char *expr = NULL;
+	size_t *expr_size = NULL;
+	int32_t *type = NULL;
+	semanage_context_t *context = NULL;
+	int32_t *flag = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && data != NULL && *data != NULL && size != NULL);
+
+	/* Allocate space. */
+	status = semanage_fcontext_create(handle, fcontext);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	/* Fcontext regex. */
+	status =
+	    semanage_unserialize(handle,
+				 data, size,
+				 (void **)&expr,
+				 &expr_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (expr != NULL) {
+		status = semanage_fcontext_set_expr(handle, *fcontext, expr);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Fcontext type. */
+	status =
+	    semanage_unserialize(handle,
+				 data, size,
+				 (void **)&type,
+				 NULL, SEMANAGE_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	semanage_fcontext_set_type(*fcontext, *type);
+
+	/* Fcontext context. */
+	status = semanage_unserialize(
+			handle,
+			data,
+			size,
+			(void **)&flag,
+			NULL,
+			SEMANAGE_SERIAL_INT32_T);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	if (*flag == 1) {
+		status = semanage_context_unserialize(handle, data, size, &context);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+		/* Note that semanage_*_set* calls typically create space. */
+		status = semanage_fcontext_set_con(handle, *fcontext, context);
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+	}
+
+	/* Cleanup. */
+      cleanup:
+	free(expr);
+	free(expr_size);
+	free(type);
+	semanage_context_free(context);
+	free(flag);
+	return status;
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_FCONTEXT_RTABLE = {
 	.create = semanage_fcontext_create,
@@ -307,5 +469,7 @@ record_table_t SEMANAGE_FCONTEXT_RTABLE 
 	.compare = semanage_fcontext_compare,
 	.compare2 = semanage_fcontext_compare2,
 	.compare2_qsort = semanage_fcontext_compare2_qsort,
+	.serialize = semanage_fcontext_serialize,
+	.unserialize = semanage_fcontext_unserialize,
 	.free = semanage_fcontext_free,
 };
Index: selinux-pms-support/libsemanage/src/fcontexts_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/fcontexts_local.c
+++ selinux-pms-support/libsemanage/src/fcontexts_local.c
@@ -1,4 +1,23 @@
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
 
 struct semanage_fcontext;
 struct semanage_fcontext_key;
@@ -79,6 +98,22 @@ int semanage_fcontext_list_local(semanag
 	return dbase_list(handle, dconfig, records, count);
 }
 
+int semanage_fcontext_serialize_local(semanage_handle_t * handle,
+				      char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_fcontext_unserialize_local(semanage_handle_t * handle,
+					char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
+
 struct validate_handler_arg {
 	semanage_handle_t *handle;
 	const sepol_policydb_t *policydb;
Index: selinux-pms-support/libsemanage/src/fcontexts_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/fcontexts_policy.c
+++ selinux-pms-support/libsemanage/src/fcontexts_policy.c
@@ -51,3 +51,19 @@ int semanage_fcontext_list(semanage_hand
 	dbase_config_t *dconfig = semanage_fcontext_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_fcontext_serialize_policy(semanage_handle_t * handle,
+				       char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_fcontext_unserialize_policy(semanage_handle_t * handle,
+					 char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -23,6 +23,7 @@
 
 #include "test_boolean_record.h"
 #include "test_context_record.h"
+#include "test_fcontext_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -61,6 +62,7 @@ static int do_tests(int interactive, int
 
 	DECLARE_SUITE(boolean_record);
 	DECLARE_SUITE(context_record);
+	DECLARE_SUITE(fcontext_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_fcontext_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontext_record.c
@@ -0,0 +1,171 @@
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
+ *  libsemanage/src/semanage_store.c
+ *
+ */
+
+#include "fcontext_internal.h"
+#include "fcontext_record.h"
+#include <sepol/context_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_fcontext_record.h"
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
+int fcontext_record_test_init(void)
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
+int fcontext_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int fcontext_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_fcontext_serialize",
+			test_semanage_fcontext_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_fcontext_serialize function in fcontext_record.c
+ */
+void test_semanage_fcontext_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_fcontext_t *fcontext;
+	status = semanage_fcontext_create(sh, &fcontext);
+	semanage_context_t *context;
+	status = semanage_context_create(sh, &context);
+
+	/* setup test fields */
+	const char *user = "testuser";
+	const char *role = "testrole";
+	const char *type = "testtype";
+
+	status = semanage_context_set_user(sh, context, user);
+	CU_ASSERT(status == 0);
+	status = semanage_context_set_role(sh, context, role);
+	CU_ASSERT(status == 0);
+	status = semanage_context_set_type(sh, context, type);
+	CU_ASSERT(status == 0);
+	status = semanage_fcontext_set_con(sh, fcontext, context);
+	CU_ASSERT(status == 0);
+
+	const char *expr = "/testlocation/*";
+	status = semanage_fcontext_set_expr(sh, fcontext, expr);
+	CU_ASSERT(status == 0);
+
+	/* set aside enough space... */
+	status = semanage_fcontext_serialize(sh, fcontext, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_fcontext_serialize(sh, fcontext, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_fcontext_t *fcontext2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status =
+	    semanage_fcontext_unserialize(sh, &data2,
+					  &data_length2, &fcontext2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	semanage_context_t *context2 = semanage_fcontext_get_con(fcontext2);
+	const char *user2;
+	const char *role2;
+	const char *type2;
+
+	user2 = semanage_context_get_user(context2);
+	role2 = semanage_context_get_role(context2);
+	type2 = semanage_context_get_type(context2);
+
+	const char *expr2;
+
+	expr2 = semanage_fcontext_get_expr(fcontext2);
+
+	/* compare */
+	status = strcmp(user, user2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(role, role2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(type, type2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(expr, expr2);
+	CU_ASSERT(status == 0);
+
+	/* cleanup */
+	semanage_fcontext_free(fcontext);
+	semanage_context_free(context);
+	semanage_fcontext_free(fcontext2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_fcontext_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontext_record.h
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
+#ifndef __TEST_FCONTEXT_RECORD_H__
+#define __TEST_FCONTEXT_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int fcontext_record_test_init(void);
+int fcontext_record_test_cleanup(void);
+int fcontext_record_add_tests(CU_pSuite suite);
+
+void test_semanage_fcontext_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
