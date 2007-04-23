Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUbd9001678
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:37 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUYSG027841
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:35 GMT
Message-Id: <20070423213734.021524000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:09 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 14/33] libsemanage: boolean serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/booleans_active.h |   28 ++++
 libsemanage/include/semanage/booleans_local.h  |   28 ++++
 libsemanage/include/semanage/booleans_policy.h |    6 +
 libsemanage/src/boolean_internal.h             |   53 +++++++++
 libsemanage/src/boolean_record.c               |   48 ++++++++
 libsemanage/src/booleans_active.c              |   16 ++
 libsemanage/src/booleans_local.c               |   16 ++
 libsemanage/src/booleans_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c          |    4 
 libsemanage/tests/test_boolean_record.c        |  142 +++++++++++++++++++++++++
 libsemanage/tests/test_boolean_record.h        |   32 +++++
 11 files changed, 386 insertions(+), 3 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/booleans_active.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/booleans_active.h
+++ selinux-pms-support/libsemanage/include/semanage/booleans_active.h
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
 
 #ifndef _SEMANAGE_BOOLEANS_ACTIVE_H_
 #define _SEMANAGE_BOOLEANS_ACTIVE_H_
 
+#include <inttypes.h>
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
@@ -30,4 +50,10 @@ extern int semanage_bool_list_active(sem
 				     semanage_bool_t *** records,
 				     unsigned int *count);
 
+extern int semanage_bool_serialize_active(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_bool_unserialize_active(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/booleans_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/booleans_local.h
+++ selinux-pms-support/libsemanage/include/semanage/booleans_local.h
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
 
 #ifndef _SEMANAGE_BOOLEANS_LOCAL_H_
 #define _SEMANAGE_BOOLEANS_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/boolean_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_bool_list_local(sema
 				    semanage_bool_t *** records,
 				    unsigned int *count);
 
+extern int semanage_bool_serialize_local(semanage_handle_t * handle,
+					 char **data, uint64_t * data_length);
+
+extern int semanage_bool_unserialize_local(semanage_handle_t * handle,
+					   char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/booleans_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/booleans_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/booleans_policy.h
@@ -24,4 +24,10 @@ extern int semanage_bool_iterate(semanag
 extern int semanage_bool_list(semanage_handle_t * handle,
 			      semanage_bool_t *** records, unsigned int *count);
 
+extern int semanage_bool_serialize_policy(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_bool_unserialize_policy(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/boolean_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/boolean_internal.h
+++ selinux-pms-support/libsemanage/src/boolean_internal.h
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
 #ifndef _SEMANAGE_BOOLEAN_INTERNAL_H_
 #define _SEMANAGE_BOOLEAN_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/boolean_record.h>
 #include <semanage/booleans_local.h>
 #include <semanage/booleans_policy.h>
 #include <semanage/booleans_active.h>
 #include "database.h"
+#include "database_policydb.h"
+#include "database_activedb.h"
 #include "handle.h"
 #include "dso.h"
 
@@ -23,6 +48,8 @@ hidden_proto(semanage_bool_clone)
 
 /* BOOL RECORD: metod table */
 extern record_table_t SEMANAGE_BOOL_RTABLE;
+extern record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE;
+extern record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE;
 
 extern int bool_file_dbase_init(semanage_handle_t * handle,
 				const char *fname, dbase_config_t * dconfig);
@@ -39,4 +66,30 @@ extern int bool_activedb_dbase_init(sema
 
 extern void bool_activedb_dbase_release(dbase_config_t * dconfig);
 
+extern int bool_ps_local_dbase_init(semanage_handle_t * handle,
+			      uint32_t sandbox_id, dbase_config_t * dconfig);
+
+extern void bool_ps_local_dbase_release(dbase_config_t * dconfig);
+
+extern int bool_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				       dbase_config_t * dconfig);
+
+extern void bool_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
+extern int bool_ps_activedb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				       dbase_config_t * dconfig);
+
+extern void bool_ps_activedb_dbase_release(dbase_config_t * dconfig);
+
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_bool_serialize(semanage_handle_t * handle,
+				   const semanage_bool_t * boolean,
+				   char **data, uint64_t * size);
+
+hidden int semanage_bool_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_bool_t ** boolean);
+
 #endif
Index: selinux-pms-support/libsemanage/src/boolean_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/boolean_record.c
+++ selinux-pms-support/libsemanage/src/boolean_record.c
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
 
 /* Object: semanage_bool_t (Policy Boolean)
  * Object: semanage_bool_key_t (Policy Boolean Key)
@@ -6,6 +26,8 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <stdlib.h>
+#include <string.h>
 #include <sepol/boolean_record.h>
 
 typedef sepol_bool_t semanage_bool_t;
@@ -19,6 +41,7 @@ typedef semanage_bool_key_t record_key_t
 #include "boolean_internal.h"
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 /* Key */
 int semanage_bool_key_create(semanage_handle_t * handle,
@@ -133,6 +156,27 @@ void semanage_bool_free(semanage_bool_t 
 
 hidden_def(semanage_bool_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_bool_calculate_serialized_size(). */
+hidden int semanage_bool_serialize(semanage_handle_t * handle,
+				   const semanage_bool_t * boolean,
+				   char **data, uint64_t * size)
+{
+	return sepol_bool_serialize(handle->sepolh, boolean, data, size);
+}
+
+/** Destructively modifies boolean, data and size.
+ *  Allocates space for boolean.
+ *  Caller must free. */
+hidden int semanage_bool_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_bool_t ** boolean)
+{
+	return sepol_bool_unserialize(handle->sepolh, data, size, boolean);
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_BOOL_RTABLE = {
 	.create = semanage_bool_create,
@@ -143,4 +187,6 @@ record_table_t SEMANAGE_BOOL_RTABLE = {
 	.compare2 = semanage_bool_compare2,
 	.compare2_qsort = semanage_bool_compare2_qsort,
 	.free = semanage_bool_free,
+	.serialize = semanage_bool_serialize,
+	.unserialize = semanage_bool_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/booleans_active.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/booleans_active.c
+++ selinux-pms-support/libsemanage/src/booleans_active.c
@@ -60,3 +60,19 @@ int semanage_bool_list_active(semanage_h
 	dbase_config_t *dconfig = semanage_bool_dbase_active(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_bool_serialize_active(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_active(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_bool_unserialize_active(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_active(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/booleans_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/booleans_local.c
+++ selinux-pms-support/libsemanage/src/booleans_local.c
@@ -68,3 +68,19 @@ int semanage_bool_list_local(semanage_ha
 	dbase_config_t *dconfig = semanage_bool_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_bool_serialize_local(semanage_handle_t * handle,
+				  char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_bool_unserialize_local(semanage_handle_t * handle,
+				    char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/booleans_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/booleans_policy.c
+++ selinux-pms-support/libsemanage/src/booleans_policy.c
@@ -50,3 +50,19 @@ int semanage_bool_list(semanage_handle_t
 	dbase_config_t *dconfig = semanage_bool_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_bool_serialize_policy(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_bool_unserialize_policy(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_bool_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -21,6 +21,8 @@
 
 #include "test_semanage_store.h"
 
+#include "test_boolean_record.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -56,6 +58,8 @@ static int do_tests(int interactive, int
 
 	DECLARE_SUITE(semanage_store);
 
+	DECLARE_SUITE(boolean_record);
+
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
 	else
Index: selinux-pms-support/libsemanage/tests/test_boolean_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_boolean_record.c
@@ -0,0 +1,142 @@
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
+ *  libsemanage/src/boolean_record.c
+ *
+ */
+
+#include "boolean_internal.h"
+#include "boolean_record.h"
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_boolean_record.h"
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
+int boolean_record_test_init(void)
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
+int boolean_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int boolean_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_bool_serialize",
+			test_semanage_bool_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_boolean_serialize function in boolean_record.c
+ */
+void test_semanage_bool_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_bool_t *boolean;
+	status = semanage_bool_create(sh, &boolean);
+
+	/* setup test fields */
+	const char *name = "testbool";
+	int value = 1;
+
+	status = semanage_bool_set_name(sh, boolean, name);
+	CU_ASSERT(status == 0);
+	semanage_bool_set_value(boolean, value);
+
+	/* set aside enough space... */
+	status = semanage_bool_serialize(sh, boolean, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_bool_serialize(sh, boolean, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_bool_t *boolean2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status =
+	    semanage_bool_unserialize(sh, &data2, &data_length2, &boolean2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	const char *name2;
+	int value2;
+
+	name2 = semanage_bool_get_name(boolean2);
+	value2 = semanage_bool_get_value(boolean2);
+
+	/* compare */
+	status = strcmp(name, name2);
+	CU_ASSERT(status == 0);
+
+	CU_ASSERT(value == value2);
+
+	/* cleanup */
+	semanage_bool_free(boolean);
+	semanage_bool_free(boolean2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_boolean_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_boolean_record.h
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
+#ifndef __TEST_BOOLEAN_RECORD_H__
+#define __TEST_BOOLEAN_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int boolean_record_test_init(void);
+int boolean_record_test_cleanup(void);
+int boolean_record_add_tests(CU_pSuite suite);
+
+void test_semanage_bool_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
