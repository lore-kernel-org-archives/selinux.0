Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUcP8001687
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:38 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUbSG027859
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:37 GMT
Message-Id: <20070423213736.899912000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:12 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 17/33] libsemanage: interface serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/interfaces_local.h  |   28 +++
 libsemanage/include/semanage/interfaces_policy.h |    6 
 libsemanage/src/iface_internal.h                 |   49 ++++++
 libsemanage/src/iface_record.c                   |   48 ++++++
 libsemanage/src/interfaces_local.c               |   16 ++
 libsemanage/src/interfaces_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c            |    2 
 libsemanage/tests/test_iface_record.c            |  172 +++++++++++++++++++++++
 libsemanage/tests/test_iface_record.h            |   32 ++++
 9 files changed, 367 insertions(+), 2 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/interfaces_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/interfaces_local.h
+++ selinux-pms-support/libsemanage/include/semanage/interfaces_local.h
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
 
 #ifndef _SEMANAGE_INTERFACES_LOCAL_H_
 #define _SEMANAGE_INTERFACES_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/iface_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_iface_list_local(sem
 				     semanage_iface_t *** records,
 				     unsigned int *count);
 
+extern int semanage_iface_serialize_local(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_iface_unserialize_local(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/interfaces_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/interfaces_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/interfaces_policy.h
@@ -26,4 +26,10 @@ extern int semanage_iface_list(semanage_
 			       semanage_iface_t *** records,
 			       unsigned int *count);
 
+extern int semanage_iface_serialize_policy(semanage_handle_t * handle,
+					   char **data, uint64_t * data_length);
+
+extern int semanage_iface_unserialize_policy(semanage_handle_t * handle,
+					     char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/iface_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/iface_internal.h
+++ selinux-pms-support/libsemanage/src/iface_internal.h
@@ -1,10 +1,34 @@
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
 #ifndef _SEMANAGE_IFACE_INTERNAL_H_
 #define _SEMANAGE_IFACE_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/iface_record.h>
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
 #include "database.h"
+#include "database_policydb.h"
 #include "handle.h"
 #include "dso.h"
 
@@ -24,6 +48,7 @@ hidden_proto(semanage_iface_create)
 
 /* IFACE RECORD: metod table */
 extern record_table_t SEMANAGE_IFACE_RTABLE;
+extern record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE;
 
 extern int iface_policydb_dbase_init(semanage_handle_t * handle,
 				     dbase_config_t * dconfig);
@@ -35,4 +60,28 @@ extern int iface_file_dbase_init(semanag
 
 extern void iface_file_dbase_release(dbase_config_t * dconfig);
 
+extern int iface_ps_local_dbase_init(semanage_handle_t * handle,
+			       uint32_t sandbox_id, dbase_config_t * dconfig);
+
+extern void iface_ps_local_dbase_release(dbase_config_t * dconfig);
+
+extern int iface_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+					dbase_config_t * dconfig);
+
+extern void iface_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_iface_calculate_serialized_size(semanage_handle_t * handle,
+						    const semanage_iface_t *
+						    iface, uint64_t * size);
+
+hidden int semanage_iface_serialize(semanage_handle_t * handle,
+				    const semanage_iface_t * iface,
+				    char **data, uint64_t * size);
+
+hidden int semanage_iface_unserialize(semanage_handle_t * handle,
+				      char **data, uint64_t * size,
+				      semanage_iface_t ** iface);
+
 #endif
Index: selinux-pms-support/libsemanage/src/iface_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/iface_record.c
+++ selinux-pms-support/libsemanage/src/iface_record.c
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
 
 /* Object: semanage_iface_t (Network Interface)
  * Object: semanage_iface_key_t (Network Interface Key)
@@ -19,9 +39,12 @@ typedef sepol_iface_t record_t;
 typedef sepol_iface_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <stdlib.h>
+#include <string.h>
 #include "iface_internal.h"
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 /* Key */
 int semanage_iface_compare(const semanage_iface_t * iface,
@@ -156,6 +179,27 @@ void semanage_iface_free(semanage_iface_
 
 hidden_def(semanage_iface_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_iface_calculate_serialized_size(). */
+hidden int semanage_iface_serialize(semanage_handle_t * handle,
+				    const semanage_iface_t * iface,
+				    char **data, uint64_t * size)
+{
+	return sepol_iface_serialize(handle->sepolh, iface, data, size);
+}
+
+/** Destructively modifies iface, data and size.
+ *  Allocates space for iface.
+ *  Caller must free. */
+hidden int semanage_iface_unserialize(semanage_handle_t * handle,
+				      char **data, uint64_t * size,
+				      semanage_iface_t ** iface)
+{
+	return sepol_iface_unserialize(handle->sepolh, data, size, iface);
+}
+
 /* Record base functions */
 record_table_t SEMANAGE_IFACE_RTABLE = {
 	.create = semanage_iface_create,
@@ -166,4 +210,6 @@ record_table_t SEMANAGE_IFACE_RTABLE = {
 	.compare2 = semanage_iface_compare2,
 	.compare2_qsort = semanage_iface_compare2_qsort,
 	.free = semanage_iface_free,
+	.serialize = semanage_iface_serialize,
+	.unserialize = semanage_iface_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/interfaces_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/interfaces_local.c
+++ selinux-pms-support/libsemanage/src/interfaces_local.c
@@ -69,3 +69,19 @@ int semanage_iface_list_local(semanage_h
 	dbase_config_t *dconfig = semanage_iface_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_iface_serialize_local(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_iface_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_iface_unserialize_local(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_iface_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/interfaces_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/interfaces_policy.c
+++ selinux-pms-support/libsemanage/src/interfaces_policy.c
@@ -50,3 +50,19 @@ int semanage_iface_list(semanage_handle_
 	dbase_config_t *dconfig = semanage_iface_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_iface_serialize_policy(semanage_handle_t * handle,
+				    char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_iface_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_iface_unserialize_policy(semanage_handle_t * handle,
+				      char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_iface_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -24,6 +24,7 @@
 #include "test_boolean_record.h"
 #include "test_context_record.h"
 #include "test_fcontext_record.h"
+#include "test_iface_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -63,6 +64,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(boolean_record);
 	DECLARE_SUITE(context_record);
 	DECLARE_SUITE(fcontext_record);
+	DECLARE_SUITE(iface_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_iface_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_iface_record.c
@@ -0,0 +1,172 @@
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
+#include "iface_internal.h"
+#include "iface_record.h"
+#include <sepol/context_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_iface_record.h"
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
+int iface_record_test_init(void)
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
+int iface_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int iface_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_iface_serialize",
+			test_semanage_iface_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_iface_serialize function in iface_record.c
+ */
+void test_semanage_iface_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_iface_t *iface;
+	status = semanage_iface_create(sh, &iface);
+	semanage_context_t *ifcon;
+	semanage_context_t *msgcon;
+
+	/* setup test fields */
+	const char *name = "testname";
+	const char *ifcon_str = "iftestuser:iftestrole:iftesttype";
+	const char *msgcon_str = "msgtestuser:msgtestrole:msgtesttype";
+
+	status = semanage_iface_set_name(sh, iface, name);
+	CU_ASSERT(status == 0);
+
+	status = semanage_context_from_string(sh, ifcon_str, &ifcon);
+	CU_ASSERT(status == 0);
+	status = semanage_iface_set_ifcon(sh, iface, ifcon);
+	CU_ASSERT(status == 0);
+
+	status = semanage_context_from_string(sh, msgcon_str, &msgcon);
+	CU_ASSERT(status == 0);
+	status = semanage_iface_set_msgcon(sh, iface, msgcon);
+	CU_ASSERT(status == 0);
+
+	/* set aside enough space... */
+	status = semanage_iface_serialize(sh, iface, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_iface_serialize(sh, iface, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_iface_t *iface2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status = semanage_iface_unserialize(sh, &data2, &data_length2, &iface2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	const char *name2;
+	const semanage_context_t *ifcon2;
+	const semanage_context_t *msgcon2;
+	char *ifcon_str2;
+	char *msgcon_str2;
+
+	name2 = semanage_iface_get_name(iface2);
+
+	ifcon2 = semanage_iface_get_ifcon(iface2);
+	status = semanage_context_to_string(sh, ifcon2, &ifcon_str2);
+	CU_ASSERT(status == 0);
+
+	msgcon2 = semanage_iface_get_msgcon(iface2);
+	status = semanage_context_to_string(sh, msgcon2, &msgcon_str2);
+	CU_ASSERT(status == 0);
+
+	/* compare */
+	status = strcmp(name, name2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(ifcon_str, ifcon_str2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(msgcon_str, msgcon_str2);
+	CU_ASSERT(status == 0);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	semanage_iface_free(iface2);
+	semanage_context_free(ifcon);
+	semanage_context_free(msgcon);
+	free(ifcon_str2);
+	free(msgcon_str2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_iface_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_iface_record.h
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
+#ifndef __TEST_IFACE_RECORD_H__
+#define __TEST_IFACE_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int iface_record_test_init(void);
+int iface_record_test_cleanup(void);
+int iface_record_add_tests(CU_pSuite suite);
+
+void test_semanage_iface_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
