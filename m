Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUbxa001681
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:37 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUZSG027844
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:36 GMT
Message-Id: <20070423213735.016593000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:10 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 15/33] libsemanage: context serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/src/context_internal.h      |   38 +++++++
 libsemanage/src/context_record.c        |   48 +++++++++
 libsemanage/tests/libsemanage-tests.c   |    2 
 libsemanage/tests/test_context_record.c |  154 ++++++++++++++++++++++++++++++++
 libsemanage/tests/test_context_record.h |   32 ++++++
 5 files changed, 272 insertions(+), 2 deletions(-)

Index: selinux-pms-support/libsemanage/src/context_internal.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/context_internal.h
+++ selinux-pms-support/libsemanage/src/context_internal.h
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
 #ifndef _SEMANAGE_CONTEXT_INTERNAL_H_
 #define _SEMANAGE_CONTEXT_INTERNAL_H_
 
+#include <inttypes.h>
 #include <semanage/context_record.h>
 #include "dso.h"
 
@@ -8,4 +31,19 @@ hidden_proto(semanage_context_clone)
     hidden_proto(semanage_context_free)
     hidden_proto(semanage_context_from_string)
     hidden_proto(semanage_context_to_string)
+
+/*======== Internal API:  Serialize/Unserialize ========== */
+hidden int semanage_context_calculate_serialized_size(semanage_handle_t *
+						      handle,
+						      const semanage_context_t *
+						      context, uint64_t * size);
+
+hidden int semanage_context_serialize(semanage_handle_t * handle,
+				      const semanage_context_t * context,
+				      char **data, uint64_t * size);
+
+hidden int semanage_context_unserialize(semanage_handle_t * handle,
+					char **data, uint64_t * size,
+					semanage_context_t ** context);
+
 #endif
Index: selinux-pms-support/libsemanage/src/context_record.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/context_record.c
+++ selinux-pms-support/libsemanage/src/context_record.c
@@ -1,12 +1,35 @@
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
 
+#include <stdlib.h>
+#include <string.h>
 #include <sepol/context_record.h>
-#include "handle.h"
 
 typedef sepol_context_t semanage_context_t;
 
 #define _SEMANAGE_CONTEXT_DEFINED_
 #include "context_internal.h"
+#include "handle.h"
+#include "debug.h"
 
 /* User */
 const char *semanage_context_get_user(const semanage_context_t * con)
@@ -90,6 +113,27 @@ void semanage_context_free(semanage_cont
 
 hidden_def(semanage_context_free)
 
+/* Serialize/Unserialize */
+/** Destructively modifies data and size.
+ *  Caller must pre-allocate space for data.
+ *  Use semanage_context_calculate_serialized_size(). */
+hidden int semanage_context_serialize(semanage_handle_t * handle,
+				      const semanage_context_t * context,
+				      char **data, uint64_t * size)
+{
+	return sepol_context_serialize(handle->sepolh, context, data, size);
+}
+
+/** Destructively modifies context, data and size.
+ *  Allocates space for context.
+ *  Caller must free. */
+hidden int semanage_context_unserialize(semanage_handle_t * handle,
+					char **data, uint64_t * size,
+					semanage_context_t ** context)
+{
+	return sepol_context_unserialize(handle->sepolh, data, size, context);
+}
+
 /* Parse to/from string */
 int semanage_context_from_string(semanage_handle_t * handle,
 				 const char *str, semanage_context_t ** con)
Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -22,6 +22,7 @@
 #include "test_semanage_store.h"
 
 #include "test_boolean_record.h"
+#include "test_context_record.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -59,6 +60,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(semanage_store);
 
 	DECLARE_SUITE(boolean_record);
+	DECLARE_SUITE(context_record);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux-pms-support/libsemanage/tests/test_context_record.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_context_record.c
@@ -0,0 +1,154 @@
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
+#include "context_internal.h"
+#include "context_record.h"
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_context_record.h"
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
+int context_record_test_init(void)
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
+int context_record_test_cleanup(void)
+{
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+ */
+int context_record_add_tests(CU_pSuite suite)
+{
+	if (NULL ==
+	    CU_add_test(suite, "semanage_context_serialize",
+			test_semanage_context_serialize)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
+
+/* Tests the semanage_context_serialize function in context_record.c
+ */
+void test_semanage_context_serialize(void)
+{
+	int status;
+	char *data;
+	uint64_t data_length = 0;
+
+	/* serialize */
+
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
+
+	/* set aside enough space... */
+	status = semanage_context_serialize(sh, context, NULL, &data_length);
+	CU_ASSERT(status == 0);
+	data = calloc(data_length, sizeof(char));
+
+	char *data2;
+	data2 = data;
+	status = semanage_context_serialize(sh, context, &data2, NULL);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+
+	/* unserialize */
+	semanage_context_t *context2;
+	data2 = data;
+	uint64_t data_length2 = data_length;
+	status =
+	    semanage_context_unserialize(sh, &data2, &data_length2, &context2);
+	CU_ASSERT(status == 0);
+	/* iterator/destructive effect check */
+	CU_ASSERT((unsigned)(data2 - data) == data_length);
+	/* unserialize should create space */
+	CU_ASSERT(context2 != NULL);
+
+	/* get results */
+	const char *user2;
+	const char *role2;
+	const char *type2;
+
+	user2 = semanage_context_get_user(context2);
+	role2 = semanage_context_get_role(context2);
+	type2 = semanage_context_get_type(context2);
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
+	/* cleanup */
+	semanage_context_free(context);
+	semanage_context_free(context2);
+	free(data);
+
+}
Index: selinux-pms-support/libsemanage/tests/test_context_record.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_context_record.h
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
+#ifndef __TEST_CONTEXT_RECORD_H__
+#define __TEST_CONTEXT_RECORD_H__
+
+#include <CUnit/Basic.h>
+
+int context_record_test_init(void);
+int context_record_test_cleanup(void);
+int context_record_add_tests(CU_pSuite suite);
+
+void test_semanage_context_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
