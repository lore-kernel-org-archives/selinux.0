Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUkax001812
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:46 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUeJc002876
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:41 GMT
Message-Id: <20070423213739.966360000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:15 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 20/33] libsemanage: seuser serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/seusers_local.h  |   28 ++++
 libsemanage/include/semanage/seusers_policy.h |    7 +
 libsemanage/src/seuser_internal.h             |   40 ++++++
 libsemanage/src/seuser_record.c               |  149 +++++++++++++++++++++++++-
 libsemanage/src/seusers_local.c               |   16 ++
 libsemanage/src/seusers_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c         |    2 
 libsemanage/tests/test_seuser_record.c        |  143 ++++++++++++++++++++++++
 libsemanage/tests/test_seuser_record.h        |   32 +++++
 9 files changed, 429 insertions(+), 4 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/seusers_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/seusers_local.h
+++ selinux-pms-support/libsemanage/include/semanage/seusers_local.h
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
 
 #ifndef _SEMANAGE_SEUSERS_LOCAL_H_
 #define _SEMANAGE_SEUSERS_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/seuser_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_seuser_list_local(se
 				      semanage_seuser_t *** records,
 				      unsigned int *count);
 
+extern int semanage_seuser_serialize_local(semanage_handle_t * handle,
+					   char **data, uint64_t * data_length);
+
+extern int semanage_seuser_unserialize_local(semanage_handle_t * handle,
+					     char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/seusers_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/seusers_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/seusers_policy.h
@@ -26,4 +26,11 @@ extern int semanage_seuser_list(semanage
 				semanage_seuser_t *** records,
 				unsigned int *count);
 
+extern int semanage_seuser_serialize_policy(semanage_handle_t * handle,
+					    char **data,
+					    uint64_t * data_length);
+
+extern int semanage_seuser_unserialize_policy(semanage_handle_t * handle,
+					      char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/seuser_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/seuser_internal.h
+++ selinux-pms-support/libsemanage/src/seuser_internal.h
@@ -1,3 +1,25 @@
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
 #ifndef _SEMANAGE_SEUSER_INTERNAL_H_
 #define _SEMANAGE_SEUSER_INTERNAL_H_
 
@@ -34,8 +56,26 @@ extern int seuser_file_dbase_init(semana
 
 extern void seuser_file_dbase_release(dbase_config_t * dconfig);
 
+extern int seuser_ps_local_dbase_init(semanage_handle_t * handle,
+				uint32_t sandbox_id, dbase_config_t * dconfig);
+
+extern void seuser_ps_local_dbase_release(dbase_config_t * dconfig);
+
 extern int hidden semanage_seuser_validate_local(semanage_handle_t * handle,
 						 const sepol_policydb_t *
 						 policydb);
 
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_seuser_calculate_serialized_size(semanage_handle_t * handle,
+						     const semanage_seuser_t *
+						     seuser, uint64_t * size);
+
+hidden int semanage_seuser_serialize(semanage_handle_t * handle,
+				     const semanage_seuser_t * seuser,
+				     char **data, uint64_t * size);
+
+hidden int semanage_seuser_unserialize(semanage_handle_t * handle,
+				       char **data, uint64_t * size,
+				       semanage_seuser_t ** seuser);
+
 #endif
Index: selinux-pms-support/libsemanage/src/seuser_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/seuser_record.c
+++ selinux-pms-support/libsemanage/src/seuser_record.c
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
 
 /* Object: semanage_seuser_t (Unix User)
  * Object: semanage_seuser_key_t (Unix User Key)
@@ -12,12 +32,14 @@ typedef struct semanage_seuser record_t;
 typedef struct semanage_seuser_key record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
-#include "seuser_internal.h"
-#include "debug.h"
 #include <semanage/handle.h>
 #include "database.h"
+#include "debug.h"
+#include "serialize.h"
+#include "seuser_internal.h"
 
 struct semanage_seuser {
 	/* This user's name */
@@ -254,6 +276,125 @@ void semanage_seuser_free(semanage_seuse
 
 hidden_def(semanage_seuser_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_seuser_calculate_serialized_size(). */
+hidden int semanage_seuser_serialize(semanage_handle_t * handle,
+				     const semanage_seuser_t * seuser,
+				     char **data, uint64_t * size)
+{
+	int status = STATUS_SUCCESS;
+	const char *name = NULL;
+	const char *sename = NULL;
+	const char *mlsrange = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && seuser != NULL);
+
+	/* Seuser user name. */
+	name = semanage_seuser_get_name(seuser);
+	if ((status =
+	     semanage_serialize(handle,
+				name,
+				(name == NULL) ? 0 : strlen(name),
+				SEMANAGE_SERIAL_STRING, data, size)))
+		goto cleanup;
+
+	/* Seuser name. */
+	sename = semanage_seuser_get_sename(seuser);
+	if ((status =
+	     semanage_serialize(handle,
+				sename,
+				(sename == NULL) ? 0 : strlen(sename),
+				SEMANAGE_SERIAL_STRING, data, size)))
+		goto cleanup;
+
+	/* Seuser mls range. */
+	mlsrange = semanage_seuser_get_mlsrange(seuser);
+	if ((status =
+	     semanage_serialize(handle,
+				mlsrange,
+				(mlsrange == NULL) ? 0 : strlen(mlsrange),
+				SEMANAGE_SERIAL_STRING, data, size)))
+		goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	return status;
+}
+
+/** Destructively modifies seuser, data and size.
+ *  Allocates space for seuser.
+ *  Caller must free. */
+hidden int semanage_seuser_unserialize(semanage_handle_t * handle,
+				       char **data, uint64_t * size,
+				       semanage_seuser_t ** seuser)
+{
+	int status = STATUS_SUCCESS;
+	char *name = NULL;
+	size_t *name_size = NULL;
+	char *sename = NULL;
+	size_t *sename_size = NULL;
+	char *mlsrange = NULL;
+	size_t *mlsrange_size = NULL;
+
+	/* Sundry sanity checks. */
+	assert(handle != NULL && data != NULL && *data != NULL && size != NULL);
+
+	/* Allocate space. */
+	if ((status = semanage_seuser_create(handle, seuser)))
+		goto cleanup;
+
+	/* Seuser user name. */
+	status =
+	     semanage_unserialize(handle,
+					data, size,
+				  (void **)&name,
+				  &name_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (name != NULL)
+		if ((status = semanage_seuser_set_name(handle, *seuser, name)))
+			goto cleanup;
+
+	/* Seuser name. */
+	status =
+	     semanage_unserialize(handle,
+					data, size,
+				  (void **)&sename,
+				  &sename_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (sename != NULL)
+		if ((status =
+		     semanage_seuser_set_sename(handle, *seuser, sename)))
+			goto cleanup;
+
+	/* Seuser mls range. */
+	status =
+	     semanage_unserialize(handle,
+					data, size,
+				  (void **)&mlsrange,
+				  &mlsrange_size, SEMANAGE_SERIAL_STRING);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+	if (mlsrange != NULL)
+		if ((status =
+		     semanage_seuser_set_mlsrange(handle, *seuser, mlsrange)))
+			goto cleanup;
+
+	/* Cleanup. */
+      cleanup:
+	free(name);
+	free(name_size);
+	free(sename);
+	free(sename_size);
+	free(mlsrange);
+	free(mlsrange_size);
+	return status;
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_SEUSER_RTABLE = {
 	.create = semanage_seuser_create,
@@ -264,4 +405,6 @@ record_table_t SEMANAGE_SEUSER_RTABLE = 
 	.compare2 = semanage_seuser_compare2,
 	.compare2_qsort = semanage_seuser_compare2_qsort,
 	.free = semanage_seuser_free,
+	.serialize = semanage_seuser_serialize,
+	.unserialize = semanage_seuser_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/seusers_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/seusers_local.c
+++ selinux-pms-support/libsemanage/src/seusers_local.c
@@ -173,3 +173,19 @@ int hidden semanage_seuser_validate_loca
 	arg.policydb = policydb;
 	return semanage_seuser_iterate_local(handle, validate_handler, &arg);
 }
+
+int semanage_seuser_serialize_local(semanage_handle_t * handle,
+				    char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_seuser_unserialize_local(semanage_handle_t * handle,
+				      char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_seuser_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/seusers_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/seusers_policy.c
+++ selinux-pms-support/libsemanage/src/seusers_policy.c
@@ -56,3 +56,19 @@ int semanage_seuser_list(semanage_handle
 	dbase_config_t *dconfig = semanage_seuser_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_seuser_serialize_policy(semanage_handle_t * handle,
+				     char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_seuser_unserialize_policy(semanage_handle_t * handle,
+				       char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_seuser_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -27,6 +27,7 @@
 #include "test_iface_record.h"
 #include "test_node_record.h"
 #include "test_port_record.h"
+#include "test_seuser_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -69,6 +70,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(iface_record);
 	DECLARE_SUITE(node_record);
 	DECLARE_SUITE(port_record);
+	DECLARE_SUITE(seuser_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_seuser_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_seuser_record.c
@@ -0,0 +1,143 @@
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
+#include "seuser_internal.h"
+#include "seuser_record.h"
+#include <semanage/seuser_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_seuser_record.h"
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
+int seuser_record_test_init(void)
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
+int seuser_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int seuser_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_seuser_serialize",
+			test_semanage_seuser_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_seuser_serialize function in seuser_record.c
+ */
+void test_semanage_seuser_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_seuser_t *seuser;
+	status = semanage_seuser_create(sh, &seuser);
+
+	/* setup test fields */
+	const char *name = "testname";
+	const char *sename = "testsename";
+
+	status = semanage_seuser_set_name(sh, seuser, name);
+	status = semanage_seuser_set_sename(sh, seuser, sename);
+
+	/* set aside enough space... */
+	status = semanage_seuser_serialize(sh, seuser, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_seuser_serialize(sh, seuser, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_seuser_t *seuser2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status =
+	    semanage_seuser_unserialize(sh, &data2, &data_length2, &seuser2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	const char *name2;
+	const char *sename2;
+
+	name2 = semanage_seuser_get_name(seuser2);
+	sename2 = semanage_seuser_get_sename(seuser2);
+
+	/* compare */
+	status = strcmp(name, name2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(sename, sename2);
+	CU_ASSERT(status == 0);
+
+	/* cleanup */
+	semanage_seuser_free(seuser);
+	semanage_seuser_free(seuser2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_seuser_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_seuser_record.h
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
+#ifndef __TEST_SEUSER_RECORD_H__
+#define __TEST_SEUSER_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int seuser_record_test_init(void);
+int seuser_record_test_cleanup(void);
+int seuser_record_add_tests(CU_pSuite suite);
+
+void test_semanage_seuser_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
