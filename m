Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUtDl001925
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:55 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUrJc002922
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:53 GMT
Message-Id: <20070423213748.175168000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:23 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 28/33] libsemanage: fcontexts serialization tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/tests/libsemanage-tests.c     |    6 
 libsemanage/tests/test_fcontexts_file.c   |  531 ++++++++++++++++++++++++++++++
 libsemanage/tests/test_fcontexts_file.h   |   32 +
 libsemanage/tests/test_fcontexts_policy.c |  394 ++++++++++++++++++++++
 libsemanage/tests/test_fcontexts_policy.h |   32 +
 5 files changed, 995 insertions(+)

Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -39,6 +39,9 @@
 #include "test_booleans_file.h"
 #include "test_booleans_policy.h"
 
+#include "test_fcontexts_file.h"
+#include "test_fcontexts_policy.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -98,6 +101,9 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(booleans_file);
 	DECLARE_SUITE(booleans_policy);
 
+	DECLARE_SUITE(fcontexts_file);
+	DECLARE_SUITE(fcontexts_policy);
+
 	/* The ps_api_disconnect test 'unforks'. */
 	DECLARE_SUITE(ps_api_disconnect);
 
Index: selinux-pms-support/libsemanage/tests/test_fcontexts_file.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontexts_file.c
@@ -0,0 +1,531 @@
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
+ *  libsemanage/src/fcontexts_file.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_fcontexts_file.h"
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
+#include "fcontexts_local.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_file.h"
+#include "user_internal.h"
+#include "seuser_internal.h"
+#include "port_internal.h"
+#include "iface_internal.h"
+#include "boolean_internal.h"
+#include "fcontext_internal.h"
+#include "node_internal.h"
+
+#include "database_llist.h"
+
+/* Server table setup. */
+
+/* Record functions. */
+
+static record_table_t test_fcontext_rtable = {
+	.create = (create_f)semanage_fcontext_create,
+	.key_extract = (key_extract_f)semanage_fcontext_key_extract,
+	.key_free = (key_free_f)semanage_fcontext_key_free,
+	.clone = (clone_f)semanage_fcontext_clone,
+	.compare = (compare_f)semanage_fcontext_compare,
+	.compare2 = (compare2_f)semanage_fcontext_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_fcontext_free,
+	.serialize = (serialize_f)semanage_fcontext_serialize,
+	.unserialize = (unserialize_f)semanage_fcontext_unserialize,
+};
+
+/* Table functions. */
+
+/* Test cache function. */
+static int test_dbase_file_cache(
+	semanage_handle_t *handle,
+	dbase_config_t *dconfig)
+{
+	int status = 0;
+
+	/* Add some test entries to the list. */
+	record_t *fcontext = NULL;
+	record_key_t *fcontextkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &fcontext);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_context_t *context;
+	status = semanage_context_create(sh, &context);
+	if (status) goto cleanup;
+
+	status = semanage_context_set_user(sh, context, "testuser");
+	if (status) goto cleanup;
+	status = semanage_context_set_role(sh, context, "testrole");
+	if (status) goto cleanup;
+	status = semanage_context_set_type(sh, context, "testtype");
+	if (status) goto cleanup;
+	status = semanage_fcontext_set_con(sh, (semanage_fcontext_t *)fcontext, context);
+	if (status) goto cleanup;
+
+	semanage_fcontext_set_type((semanage_fcontext_t *)fcontext, 1);
+	status = semanage_fcontext_set_expr(sh, (semanage_fcontext_t *)fcontext, "/testlocation/*");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, fcontext, &fcontextkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		fcontextkey,
+		fcontext);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	semanage_context_free(context);
+	context = NULL;
+	rtable->free(fcontext);
+	fcontext = NULL;
+	rtable->key_free(fcontextkey);
+	fcontextkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &fcontext);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_context_create(sh, &context);
+	if (status) goto cleanup;
+
+	status = semanage_context_set_user(sh, context, "testuser2");
+	if (status) goto cleanup;
+	status = semanage_context_set_role(sh, context, "testrole2");
+	if (status) goto cleanup;
+	status = semanage_context_set_type(sh, context, "testtype2");
+	if (status) goto cleanup;
+	status = semanage_fcontext_set_con(sh, (semanage_fcontext_t *)fcontext, context);
+	if (status) goto cleanup;
+
+	semanage_fcontext_set_type((semanage_fcontext_t *)fcontext, 2);
+	status = semanage_fcontext_set_expr(sh, (semanage_fcontext_t *)fcontext, "/testlocation2/*");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, fcontext, &fcontextkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		fcontextkey,
+		fcontext);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	semanage_context_free(context);
+	rtable->free(fcontext);
+	rtable->key_free(fcontextkey);
+
+	CU_ASSERT( status == 0 );
+	return status;
+}
+
+/* Database callback table. */
+static dbase_table_t test_file_dtable = {
+
+	/* Cache/Transactions */
+	.cache = test_dbase_file_cache,
+	.drop_cache = (void *)dbase_llist_drop_cache,
+	.flush = NULL,
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
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int fcontexts_file_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reset locks status. */
+		sh->u.ps_handle.socket_fd = 0;
+
+		/* Store setup. */
+		dbase_config_t *dconfig = semanage_fcontext_dbase_local(sh);
+
+		if ((status =
+			dbase_file_init(
+				sh,
+				"fakesuffix",
+				&test_fcontext_rtable,
+				NULL,
+				(dbase_file_t **)&dconfig->dbase)))
+			goto cleanup;
+
+		dconfig->dtable = &test_file_dtable;
+
+	}
+
+	/* Cleanup. */
+cleanup:
+	return status;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int fcontexts_file_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int fcontexts_file_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_fcontext_serialize_local", test_semanage_fcontext_serialize_local))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_fcontext_serialize_local function in fcontexts_file.c
+ */
+void test_semanage_fcontext_serialize_local(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	char *ptr = NULL;
+	int timeout = 0;
+	uint32_t database_type = 0;
+
+	semanage_fcontext_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_local(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	int commit_number = 7;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* On caching the client will ask for the commit number. */
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Wait for message. */
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		CU_ASSERT( message_type == PS_GET_DATABASE );
+		if (message_type != PS_GET_DATABASE) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* Get and serialize the database. */
+		free(data);
+		data = NULL;
+
+		if ((status = semanage_fcontext_serialize_local(sh, &data, &data_length)))
+			goto cleanup;
+
+		/* Send back the database. */
+		if ((status = write_msg(sh, client_socket_fd, PS_OK, data_length, data)))
+			goto cleanup;
+
+		/* On caching the client will ask for the commit number. */
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* On flushing the client will ask for the commit number. */
+		//FIXME: Why does the client ask for the commit number so many times here?
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Receive changed database. */
+		free(data);
+		data = NULL;
+
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		CU_ASSERT( message_type == PS_PUT_DATABASE );
+		if (message_type != PS_PUT_DATABASE) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* Say we got it ok. */
+		if ((status = write_msg(sh, client_socket_fd, PS_OK, 0, NULL)))
+			goto cleanup;
+
+		/* Unserialize the database type */
+		ptr = data;
+		if(semanage_dbase_ps_database_type_unserialize(sh, &ptr, &data_length, &database_type));
+			goto cleanup;
+
+		/* Unserialize the database. and don't move the data pointer.*/
+		if ((status = semanage_fcontext_unserialize_local(sh, ptr, data_length)))
+			goto cleanup;
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 3 );
+
+		/* Verify data. */
+		semanage_context_t *context = semanage_fcontext_get_con(records[0]);
+		char *user = (char *)semanage_context_get_user(context);
+		char *role = (char *)semanage_context_get_role(context);
+		char *type = (char *)semanage_context_get_type(context);
+		int ftype = semanage_fcontext_get_type(records[0]);
+		char *expr = (char *)semanage_fcontext_get_expr(records[0]);
+
+		CU_ASSERT( strcmp(user, "testuser") == 0 );
+		CU_ASSERT( strcmp(role, "testrole") == 0 );
+		CU_ASSERT( strcmp(type, "testtype") == 0 );
+		CU_ASSERT( ftype == 1 );
+		CU_ASSERT( strcmp(expr, "/testlocation/*") == 0 );
+
+		context = semanage_fcontext_get_con(records[1]);
+		user = (char *)semanage_context_get_user(context);
+		role = (char *)semanage_context_get_role(context);
+		type = (char *)semanage_context_get_type(context);
+		ftype = semanage_fcontext_get_type(records[1]);
+		expr = (char *)semanage_fcontext_get_expr(records[1]);
+
+		CU_ASSERT( strcmp(user, "testuser2") == 0 );
+		CU_ASSERT( strcmp(role, "testrole2") == 0 );
+		CU_ASSERT( strcmp(type, "testtype2") == 0 );
+		CU_ASSERT( ftype == 2 );
+		CU_ASSERT( strcmp(expr, "/testlocation2/*") == 0 );
+
+		context = semanage_fcontext_get_con(records[2]);
+		user = (char *)semanage_context_get_user(context);
+		role = (char *)semanage_context_get_role(context);
+		type = (char *)semanage_context_get_type(context);
+		ftype = semanage_fcontext_get_type(records[2]);
+		expr = (char *)semanage_fcontext_get_expr(records[2]);
+
+		CU_ASSERT( strcmp(user, "testuser3") == 0 );
+		CU_ASSERT( strcmp(role, "testrole3") == 0 );
+		CU_ASSERT( strcmp(type, "testtype3") == 0 );
+		CU_ASSERT( ftype == 3 );
+		CU_ASSERT( strcmp(expr, "/testlocation3/*") == 0 );
+	}
+
+	if (ps_pid > 0) {
+		/* Client code. */
+
+		/* Cache database.
+		 * This sends a message to the server requesting the database.
+		 * The server serializes the database and sends it to us (the client).
+		 * Internally the database is unserialized and loaded.
+		 */
+		status = dconfig->dtable->cache(sh, dconfig);
+		CU_ASSERT( status == 0 );
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 2 );
+
+		/* Verify data was sent correctly. */
+		semanage_context_t *context = semanage_fcontext_get_con(records[0]);
+		char *user = (char *)semanage_context_get_user(context);
+		char *role = (char *)semanage_context_get_role(context);
+		char *type = (char *)semanage_context_get_type(context);
+		int ftype = semanage_fcontext_get_type(records[0]);
+		char *expr = (char *)semanage_fcontext_get_expr(records[0]);
+
+		CU_ASSERT( strcmp(user, "testuser") == 0 );
+		CU_ASSERT( strcmp(role, "testrole") == 0 );
+		CU_ASSERT( strcmp(type, "testtype") == 0 );
+		CU_ASSERT( ftype == 1 );
+		CU_ASSERT( strcmp(expr, "/testlocation/*") == 0 );
+
+		context = semanage_fcontext_get_con(records[1]);
+		user = (char *)semanage_context_get_user(context);
+		role = (char *)semanage_context_get_role(context);
+		type = (char *)semanage_context_get_type(context);
+		ftype = semanage_fcontext_get_type(records[1]);
+		expr = (char *)semanage_fcontext_get_expr(records[1]);
+
+		CU_ASSERT( strcmp(user, "testuser2") == 0 );
+		CU_ASSERT( strcmp(role, "testrole2") == 0 );
+		CU_ASSERT( strcmp(type, "testtype2") == 0 );
+		CU_ASSERT( ftype == 2 );
+		CU_ASSERT( strcmp(expr, "/testlocation2/*") == 0 );
+
+		/* Change something. */
+
+		/* Add some test entries to the list. */
+		record_t *fcontext = NULL;
+		record_key_t *fcontextkey = NULL;
+
+		/* Create record. */
+		status = rtable->create(sh, &fcontext);
+		if (status) goto cleanup;
+
+		/* Populate record. */
+		status = semanage_context_create(sh, &context);
+		if (status) goto cleanup;
+
+		status = semanage_context_set_user(sh, context, "testuser3");
+		if (status) goto cleanup;
+		status = semanage_context_set_role(sh, context, "testrole3");
+		if (status) goto cleanup;
+		status = semanage_context_set_type(sh, context, "testtype3");
+		if (status) goto cleanup;
+		status = semanage_fcontext_set_con(sh, (semanage_fcontext_t *)fcontext, context);
+		if (status) goto cleanup;
+
+		semanage_fcontext_set_type((semanage_fcontext_t *)fcontext, 3);
+		status = semanage_fcontext_set_expr(sh, (semanage_fcontext_t *)fcontext, "/testlocation3/*");
+		if (status) goto cleanup;
+
+		status = rtable->key_extract(sh, fcontext, &fcontextkey);
+		if (status) goto cleanup;
+
+		/* Add record. */
+		status = dconfig->dtable->add(
+				sh,
+				dconfig,
+				fcontextkey,
+				fcontext);
+		if (status) goto cleanup;
+
+		/* Cleanup. */
+		semanage_context_free(context);
+		rtable->free(fcontext);
+		rtable->key_free(fcontextkey);
+
+		/* Flush database.
+		 * This sends a message to the server to replace its database
+		 * with the one we are sending.  Internally the flush serializes
+		 * the database and sends it.  The server then unserializes it,
+		 * clears its old copy, and replaces it with the new one.
+		 */
+		status = dconfig->dtable->flush(sh, dconfig);
+		CU_ASSERT( status == 0 );
+	}
+
+	/* Cleanup. */
+cleanup:
+	if (records != NULL) {
+		unsigned int i;
+		for (i = 0; i < records_size; i++) {
+			if (!records[i])
+				break;
+			rtable->free((record_t *)records[i]);
+		}
+	}
+
+	free(records);
+	free(data);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_fcontexts_file.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontexts_file.h
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
+#ifndef __TEST_FCONTEXTS_FILE_H__
+#define __TEST_FCONTEXTS_FILE_H__
+
+#include <CUnit/Basic.h>
+
+int fcontexts_file_test_init(void);
+int fcontexts_file_test_cleanup(void);
+int fcontexts_file_add_tests(CU_pSuite suite);
+
+void test_semanage_fcontext_serialize_local(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_fcontexts_policy.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontexts_policy.c
@@ -0,0 +1,394 @@
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
+ *  libsemanage/src/fcontexts_policy.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_fcontexts_policy.h"
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
+#include "fcontexts_policy.h"
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
+#include "database_llist.h"
+
+/* Server table setup. */
+
+/* Record functions. */
+
+static record_table_t test_fcontext_rtable = {
+	.create = (create_f)semanage_fcontext_create,
+	.key_extract = (key_extract_f)semanage_fcontext_key_extract,
+	.key_free = (key_free_f)semanage_fcontext_key_free,
+	.clone = (clone_f)semanage_fcontext_clone,
+	.compare = (compare_f)semanage_fcontext_compare,
+	.compare2 = (compare2_f)semanage_fcontext_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_fcontext_free,
+	.serialize = (serialize_f)semanage_fcontext_serialize,
+	.unserialize = (unserialize_f)semanage_fcontext_unserialize,
+};
+
+/* Table functions. */
+
+/* Test cache function. */
+static int test_dbase_policydb_cache(
+	semanage_handle_t *handle,
+	dbase_config_t *dconfig)
+{
+	int status = 0;
+
+	/* Add some test entries to the list. */
+	record_t *fcontext = NULL;
+	record_key_t *fcontextkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &fcontext);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_context_t *context;
+	status = semanage_context_create(sh, &context);
+	if (status) goto cleanup;
+
+	status = semanage_context_set_user(sh, context, "testuser");
+	if (status) goto cleanup;
+	status = semanage_context_set_role(sh, context, "testrole");
+	if (status) goto cleanup;
+	status = semanage_context_set_type(sh, context, "testtype");
+	if (status) goto cleanup;
+	status = semanage_fcontext_set_con(sh, (semanage_fcontext_t *)fcontext, context);
+	if (status) goto cleanup;
+
+	semanage_fcontext_set_type((semanage_fcontext_t *)fcontext, 1);
+	status = semanage_fcontext_set_expr(sh, (semanage_fcontext_t *)fcontext, "/testlocation/*");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, fcontext, &fcontextkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		fcontextkey,
+		fcontext);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	semanage_context_free(context);
+	context = NULL;
+	rtable->free(fcontext);
+	fcontext = NULL;
+	rtable->key_free(fcontextkey);
+	fcontextkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &fcontext);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_context_create(sh, &context);
+	if (status) goto cleanup;
+
+	status = semanage_context_set_user(sh, context, "testuser2");
+	if (status) goto cleanup;
+	status = semanage_context_set_role(sh, context, "testrole2");
+	if (status) goto cleanup;
+	status = semanage_context_set_type(sh, context, "testtype2");
+	if (status) goto cleanup;
+	status = semanage_fcontext_set_con(sh, (semanage_fcontext_t *)fcontext, context);
+	if (status) goto cleanup;
+
+	semanage_fcontext_set_type((semanage_fcontext_t *)fcontext, 2);
+	status = semanage_fcontext_set_expr(sh, (semanage_fcontext_t *)fcontext, "/testlocation2/*");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, fcontext, &fcontextkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		fcontextkey,
+		fcontext);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	semanage_context_free(context);
+	rtable->free(fcontext);
+	rtable->key_free(fcontextkey);
+
+	CU_ASSERT( status == 0 );
+	return status;
+}
+
+/* Database callback table. */
+static dbase_table_t test_policydb_dtable = {
+
+	/* Cache/Transactions */
+	.cache = test_dbase_policydb_cache,
+	.drop_cache = (void *)dbase_llist_drop_cache,
+	.flush = NULL,
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
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int fcontexts_policy_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reset locks status. */
+		sh->u.ps_handle.socket_fd = 0;
+
+		/* Store setup. */
+		dbase_config_t *dconfig = semanage_fcontext_dbase_policy(sh);
+
+		if ((status =
+			dbase_policydb_init(
+				sh,
+				"fakesuffix",
+				&test_fcontext_rtable,
+				NULL,
+				(dbase_policydb_t **)&dconfig->dbase)))
+			goto cleanup;
+
+		dconfig->dtable = &test_policydb_dtable;
+
+	}
+
+	/* Cleanup. */
+cleanup:
+	return status;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int fcontexts_policy_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int fcontexts_policy_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_fcontext_serialize_policy", test_semanage_fcontext_serialize_policy))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_fcontext_serialize_policy function in fcontexts_policy.c
+ */
+void test_semanage_fcontext_serialize_policy(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	semanage_fcontext_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_fcontext_dbase_policy(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	int commit_number = 7;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* On caching the client will ask for the commit number. */
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+		/* Wait for message. */
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		CU_ASSERT( message_type == PS_GET_DATABASE );
+		if (message_type != PS_GET_DATABASE) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* Get and serialize the database. */
+		free(data);
+		data = NULL;
+
+		if ((status = semanage_fcontext_serialize_policy(sh, &data, &data_length)))
+			goto cleanup;
+
+		/* Send back the database. */
+		if ((status = write_msg(sh, client_socket_fd, PS_OK, data_length, data)))
+			goto cleanup;
+
+		/* On caching the client will ask for the commit number. */
+		status = test_semanage_ps_handle_get_commit_number(sh, commit_number);
+		CU_ASSERT( status == STATUS_SUCCESS );
+		if (status != STATUS_SUCCESS)
+			goto cleanup;
+
+	}
+
+	if (ps_pid > 0) {
+		/* Client code. */
+
+		/* Cache database.
+		 * This sends a message to the server requesting the database.
+		 * The server serializes the database and sends it to us (the client).
+		 * Internally the database is unserialized and loaded.
+		 */
+		status = dconfig->dtable->cache(sh, dconfig);
+		CU_ASSERT( status == 0 );
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 2 );
+
+		/* Verify data was sent correctly. */
+		semanage_context_t *context = semanage_fcontext_get_con(records[0]);
+		char *user = (char *)semanage_context_get_user(context);
+		char *role = (char *)semanage_context_get_role(context);
+		char *type = (char *)semanage_context_get_type(context);
+		int ftype = semanage_fcontext_get_type(records[0]);
+		char *expr = (char *)semanage_fcontext_get_expr(records[0]);
+
+		CU_ASSERT( strcmp(user, "testuser") == 0 );
+		CU_ASSERT( strcmp(role, "testrole") == 0 );
+		CU_ASSERT( strcmp(type, "testtype") == 0 );
+		CU_ASSERT( ftype == 1 );
+		CU_ASSERT( strcmp(expr, "/testlocation/*") == 0 );
+
+		context = semanage_fcontext_get_con(records[1]);
+		user = (char *)semanage_context_get_user(context);
+		role = (char *)semanage_context_get_role(context);
+		type = (char *)semanage_context_get_type(context);
+		ftype = semanage_fcontext_get_type(records[1]);
+		expr = (char *)semanage_fcontext_get_expr(records[1]);
+
+		CU_ASSERT( strcmp(user, "testuser2") == 0 );
+		CU_ASSERT( strcmp(role, "testrole2") == 0 );
+		CU_ASSERT( strcmp(type, "testtype2") == 0 );
+		CU_ASSERT( ftype == 2 );
+		CU_ASSERT( strcmp(expr, "/testlocation2/*") == 0 );
+	}
+
+	/* Cleanup. */
+cleanup:
+	if (records != NULL) {
+		unsigned int i;
+		for (i = 0; i < records_size; i++) {
+			if (!records[i])
+				break;
+			rtable->free((record_t *)records[i]);
+		}
+	}
+
+	free(records);
+	free(data);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_fcontexts_policy.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_fcontexts_policy.h
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
+#ifndef __TEST_FCONTEXTS_POLICY_H__
+#define __TEST_FCONTEXTS_POLICY_H__
+
+#include <CUnit/Basic.h>
+
+int fcontexts_policy_test_init(void);
+int fcontexts_policy_test_cleanup(void);
+int fcontexts_policy_add_tests(CU_pSuite suite);
+
+void test_semanage_fcontext_serialize_policy(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
