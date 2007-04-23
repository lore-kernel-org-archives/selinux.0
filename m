Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIV0ur001964
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:31:00 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUwJc002953
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:59 GMT
Message-Id: <20070423213753.465308000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:28 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 33/33] libsemanage: user serialization tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/tests/libsemanage-tests.c |    6 
 libsemanage/tests/test_users_file.c   |  534 ++++++++++++++++++++++++++++++++++
 libsemanage/tests/test_users_file.h   |   32 ++
 libsemanage/tests/test_users_policy.c |  391 ++++++++++++++++++++++++
 libsemanage/tests/test_users_policy.h |   32 ++
 5 files changed, 995 insertions(+)

Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -54,6 +54,9 @@
 #include "test_seusers_file.h"
 #include "test_seusers_policy.h"
 
+#include "test_users_file.h"
+#include "test_users_policy.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -128,6 +131,9 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(seusers_file);
 	DECLARE_SUITE(seusers_policy);
 
+	DECLARE_SUITE(users_file);
+	DECLARE_SUITE(users_policy);
+
 	/* The ps_api_disconnect test 'unforks'. */
 	DECLARE_SUITE(ps_api_disconnect);
 
Index: selinux-pms-support/libsemanage/tests/test_users_file.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_users_file.c
@@ -0,0 +1,534 @@
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
+ *  libsemanage/src/users_file.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_users_file.h"
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
+#include "users_local.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_file.h"
+#include "user_internal.h"
+#include "port_internal.h"
+#include "seuser_internal.h"
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
+static record_table_t test_user_rtable = {
+	.create = (create_f)semanage_user_create,
+	.key_extract = (key_extract_f)semanage_user_key_extract,
+	.key_free = (key_free_f)semanage_user_key_free,
+	.clone = (clone_f)semanage_user_clone,
+	.compare = (compare_f)semanage_user_compare,
+	.compare2 = (compare2_f)semanage_user_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_user_free,
+	.serialize = (serialize_f)semanage_user_serialize,
+	.unserialize = (unserialize_f)semanage_user_unserialize,
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
+	record_t *user = NULL;
+	record_key_t *userkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &user);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	char *roles[] = { "testrole", "testrole2" };
+	int roles_size = 2;
+
+	status = semanage_user_set_name(sh, (semanage_user_t *)user, "testname");
+	if (status) goto cleanup;
+	status = semanage_user_set_roles(sh, (semanage_user_t *)user, (const char **)roles, roles_size);
+	if (status) goto cleanup;
+	status = semanage_user_set_prefix(sh, (semanage_user_t *)user, "testprefix");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, user, &userkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		userkey,
+		user);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	rtable->free(user);
+	user = NULL;
+	rtable->key_free(userkey);
+	userkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &user);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	roles[0] = "testrole3";
+	roles[1] = "testrole4";
+	roles_size = 2;
+
+	status = semanage_user_set_name(sh, (semanage_user_t *)user, "testname2");
+	if (status) goto cleanup;
+	status = semanage_user_set_roles(sh, (semanage_user_t *)user, (const char **)roles, roles_size);
+	if (status) goto cleanup;
+	status = semanage_user_set_prefix(sh, (semanage_user_t *)user, "testprefix2");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, user, &userkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		userkey,
+		user);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	rtable->free(user);
+	rtable->key_free(userkey);
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
+int users_file_test_init(void)
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
+		dbase_config_t *dconfig = semanage_user_dbase_local(sh);
+
+		if ((status =
+			dbase_file_init(
+				sh,
+				"fakesuffix",
+				&test_user_rtable,
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
+int users_file_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int users_file_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_user_serialize_local", test_semanage_user_serialize_local))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_user_serialize_local function in users_file.c
+ */
+void test_semanage_user_serialize_local(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	char *ptr = NULL;
+	int timeout = 0;
+	uint32_t database_type = 0;
+
+	semanage_user_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_user_dbase_local(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	char **roles = NULL;
+	unsigned int roles_size;
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
+		if ((status = semanage_user_serialize_local(sh, &data, &data_length)))
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
+		if ((status = semanage_user_unserialize_local(sh, ptr, data_length)))
+			goto cleanup;
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 3 );
+
+		/* Verify data. */
+		char *name = (char *)semanage_user_get_name(records[0]);
+		char *mlslevel = (char *)semanage_user_get_mlslevel(records[0]);
+		char *mlsrange = (char *)semanage_user_get_mlsrange(records[0]);
+		status = semanage_user_get_roles(sh, records[0], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		char *prefix = (char *)semanage_user_get_prefix(records[0]);
+
+		CU_ASSERT( strcmp(name, "testname") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole2") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix") == 0 );
+
+		/* Cleanup. */
+		free(roles);
+		roles = NULL;
+
+		name = (char *)semanage_user_get_name(records[1]);
+		mlslevel = (char *)semanage_user_get_mlslevel(records[1]);
+		mlsrange = (char *)semanage_user_get_mlsrange(records[1]);
+		status = semanage_user_get_roles(sh, records[1], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		prefix = (char *)semanage_user_get_prefix(records[1]);
+
+		CU_ASSERT( strcmp(name, "testname2") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole3") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole4") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix2") == 0 );
+
+		/* Cleanup. */
+		free(roles);
+		roles = NULL;
+
+		name = (char *)semanage_user_get_name(records[2]);
+		mlslevel = (char *)semanage_user_get_mlslevel(records[2]);
+		mlsrange = (char *)semanage_user_get_mlsrange(records[2]);
+		status = semanage_user_get_roles(sh, records[2], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		prefix = (char *)semanage_user_get_prefix(records[2]);
+
+		CU_ASSERT( strcmp(name, "testname3") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole5") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole6") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix3") == 0 );
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
+		char *name = (char *)semanage_user_get_name(records[0]);
+		char *mlslevel = (char *)semanage_user_get_mlslevel(records[0]);
+		char *mlsrange = (char *)semanage_user_get_mlsrange(records[0]);
+		status = semanage_user_get_roles(sh, records[0], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		char *prefix = (char *)semanage_user_get_prefix(records[0]);
+
+		CU_ASSERT( strcmp(name, "testname") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole2") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix") == 0 );
+
+		/* Cleanup. */
+		free(roles);
+		roles = NULL;
+
+		name = (char *)semanage_user_get_name(records[1]);
+		mlslevel = (char *)semanage_user_get_mlslevel(records[1]);
+		mlsrange = (char *)semanage_user_get_mlsrange(records[1]);
+		status = semanage_user_get_roles(sh, records[1], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		prefix = (char *)semanage_user_get_prefix(records[1]);
+
+		CU_ASSERT( strcmp(name, "testname2") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole3") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole4") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix2") == 0 );
+
+		/* Add some test entries to the list. */
+		record_t *user = NULL;
+		record_key_t *userkey = NULL;
+
+		/* Create record. */
+		status = rtable->create(sh, &user);
+		if (status) goto cleanup;
+
+		/* Populate record. */
+		roles[0] = "testrole5";
+		roles[1] = "testrole6";
+		roles_size = 2;
+
+		status = semanage_user_set_name(sh, (semanage_user_t *)user, "testname3");
+		if (status) goto cleanup;
+		status = semanage_user_set_roles(sh, (semanage_user_t *)user, (const char **)roles, roles_size);
+		if (status) goto cleanup;
+		status = semanage_user_set_prefix(sh, (semanage_user_t *)user, "testprefix3");
+		if (status) goto cleanup;
+
+		status = rtable->key_extract(sh, user, &userkey);
+		if (status) goto cleanup;
+
+		/* Add record. */
+		status = dconfig->dtable->add(
+				sh,
+				dconfig,
+				userkey,
+				user);
+		if (status) goto cleanup;
+
+		/* Cleanup. */
+		rtable->free(user);
+		rtable->key_free(userkey);
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
+	free(roles);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_users_file.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_users_file.h
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
+#ifndef __TEST_USERS_FILE_H__
+#define __TEST_USERS_FILE_H__
+
+#include <CUnit/Basic.h>
+
+int users_file_test_init(void);
+int users_file_test_cleanup(void);
+int users_file_add_tests(CU_pSuite suite);
+
+void test_semanage_user_serialize_local(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_users_policy.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_users_policy.c
@@ -0,0 +1,391 @@
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
+ *  libsemanage/src/users_policy.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_users_policy.h"
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
+#include "users_policy.h"
+#include "messages_internal.h"
+#include "semanage_store.h"
+#include "database_policydb.h"
+#include "user_internal.h"
+#include "port_internal.h"
+#include "seuser_internal.h"
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
+static record_table_t test_user_rtable = {
+	.create = (create_f)semanage_user_create,
+	.key_extract = (key_extract_f)semanage_user_key_extract,
+	.key_free = (key_free_f)semanage_user_key_free,
+	.clone = (clone_f)semanage_user_clone,
+	.compare = (compare_f)semanage_user_compare,
+	.compare2 = (compare2_f)semanage_user_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_user_free,
+	.serialize = (serialize_f)semanage_user_serialize,
+	.unserialize = (unserialize_f)semanage_user_unserialize,
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
+	record_t *user = NULL;
+	record_key_t *userkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &user);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	char *roles[] = { "testrole", "testrole2" };
+	int roles_size = 2;
+
+	status = semanage_user_set_name(sh, (semanage_user_t *)user, "testname");
+	if (status) goto cleanup;
+	status = semanage_user_set_roles(sh, (semanage_user_t *)user, (const char **)roles, roles_size);
+	if (status) goto cleanup;
+	status = semanage_user_set_prefix(sh, (semanage_user_t *)user, "testprefix");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, user, &userkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		userkey,
+		user);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	rtable->free(user);
+	user = NULL;
+	rtable->key_free(userkey);
+	userkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &user);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	roles[0] = "testrole3";
+	roles[1] = "testrole4";
+	roles_size = 2;
+
+	status = semanage_user_set_name(sh, (semanage_user_t *)user, "testname2");
+	if (status) goto cleanup;
+	status = semanage_user_set_roles(sh, (semanage_user_t *)user, (const char **)roles, roles_size);
+	if (status) goto cleanup;
+	status = semanage_user_set_prefix(sh, (semanage_user_t *)user, "testprefix2");
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, user, &userkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		userkey,
+		user);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	rtable->free(user);
+	rtable->key_free(userkey);
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
+int users_policy_test_init(void)
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
+		dbase_config_t *dconfig = semanage_user_dbase_policy(sh);
+
+		if ((status =
+			dbase_policydb_init(
+				sh,
+				"fakesuffix",
+				&test_user_rtable,
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
+int users_policy_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int users_policy_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_user_serialize_policy", test_semanage_user_serialize_policy))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_user_serialize_policy function in users_policy.c
+ */
+void test_semanage_user_serialize_policy(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	semanage_user_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_user_dbase_policy(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	char **roles = NULL;
+	unsigned int roles_size;
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
+		if ((status = semanage_user_serialize_policy(sh, &data, &data_length)))
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
+		char *name = (char *)semanage_user_get_name(records[0]);
+		char *mlslevel = (char *)semanage_user_get_mlslevel(records[0]);
+		char *mlsrange = (char *)semanage_user_get_mlsrange(records[0]);
+		status = semanage_user_get_roles(sh, records[0], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		char *prefix = (char *)semanage_user_get_prefix(records[0]);
+
+		CU_ASSERT( strcmp(name, "testname") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole2") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix") == 0 );
+
+		/* Cleanup. */
+		free(roles);
+		roles = NULL;
+
+		name = (char *)semanage_user_get_name(records[1]);
+		mlslevel = (char *)semanage_user_get_mlslevel(records[1]);
+		mlsrange = (char *)semanage_user_get_mlsrange(records[1]);
+		status = semanage_user_get_roles(sh, records[1], (const char ***)&roles, &roles_size);
+		CU_ASSERT( status == 0 );
+		prefix = (char *)semanage_user_get_prefix(records[1]);
+
+		CU_ASSERT( strcmp(name, "testname2") == 0 );
+		CU_ASSERT( mlslevel == NULL );
+		CU_ASSERT( mlsrange == NULL );
+		CU_ASSERT( roles_size == 2 );
+		CU_ASSERT( strcmp(roles[0], "testrole3") == 0 );
+		CU_ASSERT( strcmp(roles[1], "testrole4") == 0 );
+		CU_ASSERT( strcmp(prefix, "testprefix2") == 0 );
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
+	free(roles);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_users_policy.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_users_policy.h
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
+#ifndef __TEST_USERS_POLICY_H__
+#define __TEST_USERS_POLICY_H__
+
+#include <CUnit/Basic.h>
+
+int users_policy_test_init(void);
+int users_policy_test_cleanup(void);
+int users_policy_add_tests(CU_pSuite suite);
+
+void test_semanage_user_serialize_policy(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
