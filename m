Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUmPW001837
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:48 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUjSG027912
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:46 GMT
Message-Id: <20070423213746.155419000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:21 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 26/33] libsemanage: module serialization tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -33,6 +33,8 @@
 #include "test_ps_api_connect.h"
 #include "test_ps_api_disconnect.h"
 
+#include "test_modules.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -82,6 +84,8 @@ static int do_tests(int interactive, int
 	 */
 	DECLARE_SUITE(ps_api_connect);
 
+	DECLARE_SUITE(modules);
+
 	/* These tests rely upon the policy server
 	 * being properly connected via the
 	 * ps_api_connect test.
Index: selinux-pms-support/libsemanage/tests/test_modules.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_modules.c
@@ -0,0 +1,235 @@
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
+ *  libsemanage/src/modules.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_modules.h"
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
+#include <modules.h>
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
+/* Module test server functions. */
+
+int module_test_install(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+int module_test_upgrade(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+int module_test_remove(
+	semanage_handle_t *sh,
+	char *data)
+{
+	return 0;
+}
+
+int module_test_list(
+	semanage_handle_t *sh,
+	semanage_module_info_t **modules,
+	int *modules_size)
+{
+	/* Fabricate a module list. */
+	*modules_size = 2;
+
+	*modules = calloc(*modules_size, sizeof(**modules));
+
+	(*modules)[0].name = "testname0";
+	(*modules)[0].version = "testversion0";
+	(*modules)[1].name = "testname1";
+	(*modules)[1].version = "testversion1";
+
+	return 0;
+}
+
+int module_test_install_base(
+	semanage_handle_t *sh,
+	char *data,
+	size_t data_size)
+{
+	return 0;
+}
+
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int modules_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reconfigure connection callbacks. */
+		sh->funcs->list = module_test_list;
+
+	}
+
+//cleanup:
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+		modules_test_cleanup();
+	}
+
+	return status;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int modules_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int modules_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_module_list_serialize", test_semanage_module_list_serialize))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_ps_connect function in modules.c
+*/
+void test_semanage_module_list_serialize(void)
+{
+	int status = 0;
+
+	uint32_t message_type;
+	uint64_t data_size;
+	char *data = NULL;
+	int timeout = 0;
+
+	semanage_module_info_t *modules = NULL;
+	int modules_size;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Wait for message. */
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_size, &data)))
+			goto cleanup;
+
+		CU_ASSERT( message_type == PS_LIST_MODULES );
+		if (message_type != PS_LIST_MODULES) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* Serialize the modules list. */
+		free(data);
+		data = NULL;
+
+		status = semanage_module_list_serialize(sh, &data, &data_size);
+
+
+		/* Send back the modules list. */
+		status = write_msg(sh, client_socket_fd, PS_OK, data_size, data);
+
+	}
+	else {
+		/* Client code. */
+
+		/* Get the list of modules. */
+		status = semanage_module_list(sh, &modules, &modules_size);
+		CU_ASSERT( status == STATUS_SUCCESS );
+
+		/* Verify data. */
+		CU_ASSERT_STRING_EQUAL( modules[0].name, "testname0" );
+		CU_ASSERT_STRING_EQUAL( modules[0].version, "testversion0" );
+		CU_ASSERT_STRING_EQUAL( modules[1].name, "testname1" );
+		CU_ASSERT_STRING_EQUAL( modules[1].version, "testversion1" );
+	}
+
+	/* cleanup */
+cleanup:
+	free(data);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+		modules_test_cleanup();
+	}
+}
Index: selinux-pms-support/libsemanage/tests/test_modules.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_modules.h
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
+#ifndef __TEST_MODULES_H__
+#define __TEST_MODULES_H__
+
+#include <CUnit/Basic.h>
+
+int modules_test_init(void);
+int modules_test_cleanup(void);
+int modules_add_tests(CU_pSuite suite);
+
+void test_semanage_module_list_serialize(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
