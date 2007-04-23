Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUeoT001700
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:40 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUcJc002869
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:39 GMT
Message-Id: <20070423213737.903674000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:13 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 18/33] libsemanage: node serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/nodes_local.h  |   28 ++++
 libsemanage/include/semanage/nodes_policy.h |    6 
 libsemanage/src/node_internal.h             |   49 +++++++
 libsemanage/src/node_record.c               |   48 +++++++
 libsemanage/src/nodes_local.c               |   16 ++
 libsemanage/src/nodes_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c       |    2 
 libsemanage/tests/test_node_record.c        |  173 ++++++++++++++++++++++++++++
 libsemanage/tests/test_node_record.h        |   32 +++++
 9 files changed, 368 insertions(+), 2 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/nodes_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/nodes_local.h
+++ selinux-pms-support/libsemanage/include/semanage/nodes_local.h
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
 
 #ifndef _SEMANAGE_NODES_LOCAL_H_
 #define _SEMANAGE_NODES_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/node_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_node_list_local(sema
 				    semanage_node_t *** records,
 				    unsigned int *count);
 
+extern int semanage_node_serialize_local(semanage_handle_t * handle,
+					 char **data, uint64_t * data_length);
+
+extern int semanage_node_unserialize_local(semanage_handle_t * handle,
+					   char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/nodes_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/nodes_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/nodes_policy.h
@@ -24,4 +24,10 @@ extern int semanage_node_iterate(semanag
 extern int semanage_node_list(semanage_handle_t * handle,
 			      semanage_node_t *** records, unsigned int *count);
 
+extern int semanage_node_serialize_policy(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_node_unserialize_policy(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/node_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/node_internal.h
+++ selinux-pms-support/libsemanage/src/node_internal.h
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
 #ifndef _SEMANAGE_NODE_INTERNAL_H_
 #define _SEMANAGE_NODE_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/node_record.h>
 #include <semanage/nodes_local.h>
 #include <semanage/nodes_policy.h>
 #include "database.h"
+#include "database_policydb.h"
 #include "handle.h"
 #include "dso.h"
 
@@ -32,6 +56,7 @@ hidden_proto(semanage_node_create)
 
 /* NODE RECORD: method table */
 extern record_table_t SEMANAGE_NODE_RTABLE;
+extern record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE;
 
 extern int node_file_dbase_init(semanage_handle_t * handle,
 				const char *fname, dbase_config_t * dconfig);
@@ -43,6 +68,17 @@ extern int node_policydb_dbase_init(sema
 
 extern void node_policydb_dbase_release(dbase_config_t * dconfig);
 
+extern int node_ps_local_dbase_init(semanage_handle_t * handle,
+			      uint32_t sandbox_id, dbase_config_t * dconfig);
+
+extern void node_ps_local_dbase_release(dbase_config_t * dconfig);
+
+extern int node_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				       dbase_config_t * dconfig);
+
+extern void node_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
 extern int hidden semanage_node_validate_local(semanage_handle_t * handle);
 
 /* ==== Internal (to nodes) API === */
@@ -50,4 +86,17 @@ extern int hidden semanage_node_validate
 hidden int semanage_node_compare2_qsort(const semanage_node_t ** node,
 					const semanage_node_t ** node2);
 
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_node_calculate_serialized_size(semanage_handle_t * handle,
+						   const semanage_node_t * node,
+						   uint64_t * size);
+
+hidden int semanage_node_serialize(semanage_handle_t * handle,
+				   const semanage_node_t * node,
+				   char **data, uint64_t * size);
+
+hidden int semanage_node_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_node_t ** node);
+
 #endif
Index: selinux-pms-support/libsemanage/src/node_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/node_record.c
+++ selinux-pms-support/libsemanage/src/node_record.c
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
 
 /* Object: semanage_node_t (Network Port)
  * Object: semanage_node_key_t (Network Port Key)
@@ -6,6 +26,8 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <stdlib.h>
+#include <string.h>
 #include <sepol/context_record.h>
 #include <sepol/node_record.h>
 #include <stddef.h>
@@ -23,6 +45,7 @@ typedef semanage_node_key_t record_key_t
 #include "node_internal.h"
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 /* Key */
 int semanage_node_compare(const semanage_node_t * node,
@@ -227,6 +250,27 @@ void semanage_node_free(semanage_node_t 
 
 hidden_def(semanage_node_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_node_calculate_serialized_size(). */
+hidden int semanage_node_serialize(semanage_handle_t * handle,
+				   const semanage_node_t * node,
+				   char **data, uint64_t * size)
+{
+	return sepol_node_serialize(handle->sepolh, node, data, size);
+}
+
+/** Destructively modifies node, data and size.
+ *  Allocates space for node.
+ *  Caller must free. */
+hidden int semanage_node_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_node_t ** node)
+{
+	return sepol_node_unserialize(handle->sepolh, data, size, node);
+}
+
 /* Port base functions */
 record_table_t SEMANAGE_NODE_RTABLE = {
 	.create = semanage_node_create,
@@ -237,4 +281,6 @@ record_table_t SEMANAGE_NODE_RTABLE = {
 	.compare2 = semanage_node_compare2,
 	.compare2_qsort = semanage_node_compare2_qsort,
 	.free = semanage_node_free,
+	.serialize = semanage_node_serialize,
+	.unserialize = semanage_node_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/nodes_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/nodes_local.c
+++ selinux-pms-support/libsemanage/src/nodes_local.c
@@ -70,3 +70,19 @@ int semanage_node_list_local(semanage_ha
 }
 
 hidden_def(semanage_node_list_local)
+
+int semanage_node_serialize_local(semanage_handle_t * handle,
+				  char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_node_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_node_unserialize_local(semanage_handle_t * handle,
+				    char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_node_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/nodes_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/nodes_policy.c
+++ selinux-pms-support/libsemanage/src/nodes_policy.c
@@ -50,3 +50,19 @@ int semanage_node_list(semanage_handle_t
 	dbase_config_t *dconfig = semanage_node_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_node_serialize_policy(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_node_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_node_unserialize_policy(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_node_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -25,6 +25,7 @@
 #include "test_context_record.h"
 #include "test_fcontext_record.h"
 #include "test_iface_record.h"
+#include "test_node_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -65,6 +66,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(context_record);
 	DECLARE_SUITE(fcontext_record);
 	DECLARE_SUITE(iface_record);
+	DECLARE_SUITE(node_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_node_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_node_record.c
@@ -0,0 +1,173 @@
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
+#include "node_internal.h"
+#include "node_record.h"
+#include <sepol/context_record.h>
+#include <sepol/node_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_node_record.h"
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
+int node_record_test_init(void)
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
+int node_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int node_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_node_serialize",
+			test_semanage_node_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_node_serialize function in node_record.c
+ */
+void test_semanage_node_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_node_t *node;
+	status = semanage_node_create(sh, &node);
+	semanage_context_t *con;
+
+	/* setup test fields */
+	int proto = SEMANAGE_PROTO_IP4;
+	const char *addr = "10.10.10.10";
+	const char *mask = "255.255.255.255";
+	const char *con_str = "testuser:testrole:testtype";
+
+	status = semanage_node_set_addr(sh, node, proto, addr);
+	CU_ASSERT(status == 0);
+
+	status = semanage_node_set_mask(sh, node, proto, mask);
+	CU_ASSERT(status == 0);
+
+	status = semanage_context_from_string(sh, con_str, &con);
+	CU_ASSERT(status == 0);
+	status = semanage_node_set_con(sh, node, con);
+	CU_ASSERT(status == 0);
+
+	/* set aside enough space... */
+	status = semanage_node_serialize(sh, node, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_node_serialize(sh, node, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_node_t *node2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status = semanage_node_unserialize(sh, &data2, &data_length2, &node2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	int proto2;
+	char *addr2;
+	char *mask2;
+	semanage_context_t *con2;
+	char *con_str2;
+
+	proto2 = semanage_node_get_proto(node2);
+	status = semanage_node_get_addr(sh, node2, &addr2);
+	CU_ASSERT(status == 0);
+	status = semanage_node_get_mask(sh, node2, &mask2);
+	CU_ASSERT(status == 0);
+
+	con2 = semanage_node_get_con(node2);
+	status = semanage_context_to_string(sh, con2, &con_str2);
+	CU_ASSERT(status == 0);
+
+	/* compare */
+	CU_ASSERT(proto == proto2);
+
+	status = strcmp(addr, addr2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(mask, mask2);
+	CU_ASSERT(status == 0);
+
+	status = strcmp(con_str, con_str2);
+	CU_ASSERT(status == 0);
+
+	/* cleanup */
+	semanage_node_free(node);
+	semanage_node_free(node2);
+	semanage_context_free(con);
+	free(addr2);
+	free(mask2);
+	free(con_str2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_node_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_node_record.h
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
+#ifndef __TEST_NODE_RECORD_H__
+#define __TEST_NODE_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int node_record_test_init(void);
+int node_record_test_cleanup(void);
+int node_record_add_tests(CU_pSuite suite);
+
+void test_semanage_node_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
