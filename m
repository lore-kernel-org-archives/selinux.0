Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUfCq001710
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:41 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUdSG027868
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:40 GMT
Message-Id: <20070423213738.884739000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:14 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 19/33] libsemanage: port serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/include/semanage/ports_local.h  |   28 ++++
 libsemanage/include/semanage/ports_policy.h |    6 +
 libsemanage/src/port_internal.h             |   49 ++++++++
 libsemanage/src/port_record.c               |   48 ++++++++
 libsemanage/src/ports_local.c               |   16 ++
 libsemanage/src/ports_policy.c              |   16 ++
 libsemanage/tests/libsemanage-tests.c       |    2 
 libsemanage/tests/test_port_record.c        |  162 ++++++++++++++++++++++++++++
 libsemanage/tests/test_port_record.h        |   32 +++++
 9 files changed, 357 insertions(+), 2 deletions(-)

Index: selinux-pms-support/libsemanage/include/semanage/ports_local.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/ports_local.h
+++ selinux-pms-support/libsemanage/include/semanage/ports_local.h
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
 
 #ifndef _SEMANAGE_PORTS_LOCAL_H_
 #define _SEMANAGE_PORTS_LOCAL_H_
 
+#include <inttypes.h>
 #include <semanage/port_record.h>
 #include <semanage/handle.h>
 
@@ -33,4 +53,10 @@ extern int semanage_port_list_local(sema
 				    semanage_port_t *** records,
 				    unsigned int *count);
 
+extern int semanage_port_serialize_local(semanage_handle_t * handle,
+					 char **data, uint64_t * data_length);
+
+extern int semanage_port_unserialize_local(semanage_handle_t * handle,
+					   char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/include/semanage/ports_policy.h
===================================================================
--- selinux-pms-support.orig/libsemanage/include/semanage/ports_policy.h
+++ selinux-pms-support/libsemanage/include/semanage/ports_policy.h
@@ -24,4 +24,10 @@ extern int semanage_port_iterate(semanag
 extern int semanage_port_list(semanage_handle_t * handle,
 			      semanage_port_t *** records, unsigned int *count);
 
+extern int semanage_port_serialize_policy(semanage_handle_t * handle,
+					  char **data, uint64_t * data_length);
+
+extern int semanage_port_unserialize_policy(semanage_handle_t * handle,
+					    char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/port_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/port_internal.h
+++ selinux-pms-support/libsemanage/src/port_internal.h
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
 #ifndef _SEMANAGE_PORT_INTERNAL_H_
 #define _SEMANAGE_PORT_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/port_record.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
 #include "database.h"
+#include "database_policydb.h"
 #include "handle.h"
 #include "dso.h"
 
@@ -28,6 +52,7 @@ hidden_proto(semanage_port_create)
 
 /* PORT RECORD: method table */
 extern record_table_t SEMANAGE_PORT_RTABLE;
+extern record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE;
 
 extern int port_file_dbase_init(semanage_handle_t * handle,
 				const char *fname, dbase_config_t * dconfig);
@@ -41,9 +66,33 @@ extern void port_policydb_dbase_release(
 
 extern int hidden semanage_port_validate_local(semanage_handle_t * handle);
 
+extern int port_ps_local_dbase_init(semanage_handle_t * handle,
+			      uint32_t sandbox_id, dbase_config_t * dconfig);
+
+extern void port_ps_local_dbase_release(dbase_config_t * dconfig);
+
+extern int port_ps_policydb_dbase_init(semanage_handle_t * handle,
+		uint32_t sandbox_id,
+				       dbase_config_t * dconfig);
+
+extern void port_ps_policydb_dbase_release(dbase_config_t * dconfig);
+
 /* ==== Internal (to ports) API === */
 
 hidden int semanage_port_compare2_qsort(const semanage_port_t ** port,
 					const semanage_port_t ** port2);
 
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_port_calculate_serialized_size(semanage_handle_t * handle,
+						   const semanage_port_t * port,
+						   uint64_t * size);
+
+hidden int semanage_port_serialize(semanage_handle_t * handle,
+				   const semanage_port_t * port,
+				   char **data, uint64_t * size);
+
+hidden int semanage_port_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_port_t ** port);
+
 #endif
Index: selinux-pms-support/libsemanage/src/port_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/port_record.c
+++ selinux-pms-support/libsemanage/src/port_record.c
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
 
 /* Object: semanage_port_t (Network Port)
  * Object: semanage_port_key_t (Network Port Key)
@@ -6,6 +26,8 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <stdlib.h>
+#include <string.h>
 #include <sepol/context_record.h>
 #include <sepol/port_record.h>
 
@@ -22,6 +44,7 @@ typedef semanage_port_key_t record_key_t
 #include "port_internal.h"
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 /* Key */
 int semanage_port_compare(const semanage_port_t * port,
@@ -179,6 +202,27 @@ void semanage_port_free(semanage_port_t 
 
 hidden_def(semanage_port_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_port_calculate_serialized_size(). */
+hidden int semanage_port_serialize(semanage_handle_t * handle,
+				   const semanage_port_t * port,
+				   char **data, uint64_t * size)
+{
+	return sepol_port_serialize(handle->sepolh, port, data, size);
+}
+
+/** Destructively modifies port, data and size.
+ *  Allocates space for port.
+ *  Caller must free. */
+hidden int semanage_port_unserialize(semanage_handle_t * handle,
+				     char **data, uint64_t * size,
+				     semanage_port_t ** port)
+{
+	return sepol_port_unserialize(handle->sepolh, data, size, port);
+}
+
 /* Port base functions */
 record_table_t SEMANAGE_PORT_RTABLE = {
 	.create = semanage_port_create,
@@ -189,4 +233,6 @@ record_table_t SEMANAGE_PORT_RTABLE = {
 	.compare2 = semanage_port_compare2,
 	.compare2_qsort = semanage_port_compare2_qsort,
 	.free = semanage_port_free,
+	.serialize = semanage_port_serialize,
+	.unserialize = semanage_port_unserialize,
 };
Index: selinux-pms-support/libsemanage/src/ports_local.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/ports_local.c
+++ selinux-pms-support/libsemanage/src/ports_local.c
@@ -142,3 +142,19 @@ int hidden semanage_port_validate_local(
 	free(ports);
 	return STATUS_ERR;
 }
+
+int semanage_port_serialize_local(semanage_handle_t * handle,
+				  char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_port_dbase_local(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_port_unserialize_local(semanage_handle_t * handle,
+				    char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_port_dbase_local(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/src/ports_policy.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/ports_policy.c
+++ selinux-pms-support/libsemanage/src/ports_policy.c
@@ -50,3 +50,19 @@ int semanage_port_list(semanage_handle_t
 	dbase_config_t *dconfig = semanage_port_dbase_policy(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int semanage_port_serialize_policy(semanage_handle_t * handle,
+				   char **data, uint64_t * data_length)
+{
+
+	dbase_config_t *dconfig = semanage_port_dbase_policy(handle);
+	return dbase_serialize(handle, dconfig, data, data_length);
+}
+
+int semanage_port_unserialize_policy(semanage_handle_t * handle,
+				     char *data, uint64_t data_length)
+{
+
+	dbase_config_t *dconfig = semanage_port_dbase_policy(handle);
+	return dbase_unserialize(handle, dconfig, data, data_length);
+}
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -26,6 +26,7 @@
 #include "test_fcontext_record.h"
 #include "test_iface_record.h"
 #include "test_node_record.h"
+#include "test_port_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -67,6 +68,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(fcontext_record);
 	DECLARE_SUITE(iface_record);
 	DECLARE_SUITE(node_record);
+	DECLARE_SUITE(port_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_port_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_port_record.c
@@ -0,0 +1,162 @@
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
+#include "port_internal.h"
+#include "port_record.h"
+#include <sepol/context_record.h>
+#include <sepol/port_record.h>
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_port_record.h"
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
+int port_record_test_init(void)
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
+int port_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int port_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_port_serialize",
+			test_semanage_port_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_port_serialize function in port_record.c
+ */
+void test_semanage_port_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
+	semanage_port_t *port;
+	status = semanage_port_create(sh, &port);
+	semanage_context_t *con;
+
+	/* setup test fields */
+	int low = 1;
+	int high = 65535;
+	int proto = SEMANAGE_PROTO_TCP;
+	const char *con_str = "testuser:testrole:testtype";
+
+	semanage_port_set_range(port, low, high);
+	semanage_port_set_proto(port, proto);
+
+	status = semanage_context_from_string(sh, con_str, &con);
+	CU_ASSERT(status == 0);
+	status = semanage_port_set_con(sh, port, con);
+	CU_ASSERT(status == 0);
+
+	/* set aside enough space... */
+	status = semanage_port_serialize(sh, port, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_port_serialize(sh, port, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_port_t *port2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status = semanage_port_unserialize(sh, &data2, &data_length2, &port2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* get results */
+	int low2;
+	int high2;
+	int proto2;
+	semanage_context_t *con2;
+	char *con_str2;
+
+	low2 = semanage_port_get_low(port2);
+	high2 = semanage_port_get_high(port2);
+	proto2 = semanage_port_get_proto(port2);
+
+	con2 = semanage_port_get_con(port2);
+	status = semanage_context_to_string(sh, con2, &con_str2);
+	CU_ASSERT(status == 0);
+
+	/* compare */
+	CU_ASSERT(low == low2);
+	CU_ASSERT(high == high2);
+	CU_ASSERT(proto == proto2);
+
+	status = strcmp(con_str, con_str2);
+	CU_ASSERT(status == 0);
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_free(port2);
+	semanage_context_free(con);
+	free(con_str2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_port_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_port_record.h
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
+#ifndef __TEST_PORT_RECORD_H__
+#define __TEST_PORT_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int port_record_test_init(void);
+int port_record_test_cleanup(void);
+int port_record_add_tests(CU_pSuite suite);
+
+void test_semanage_port_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
