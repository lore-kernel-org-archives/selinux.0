Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUohW001873
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:50 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUlSG027916
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:47 GMT
Message-Id: <20070423213747.227256000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:22 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 27/33] libsemanage: booleans serialization tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/tests/libsemanage-tests.c    |    7 
 libsemanage/tests/test_booleans_active.c |  461 +++++++++++++++++++++++++++++++
 libsemanage/tests/test_booleans_active.h |   32 ++
 libsemanage/tests/test_booleans_file.c   |  457 ++++++++++++++++++++++++++++++
 libsemanage/tests/test_booleans_file.h   |   32 ++
 libsemanage/tests/test_booleans_policy.c |  352 +++++++++++++++++++++++
 libsemanage/tests/test_booleans_policy.h |   32 ++
 libsemanage/tests/utilities.c            |   58 +++
 libsemanage/tests/utilities.h            |    7 
 9 files changed, 1438 insertions(+)

Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -35,6 +35,10 @@
 
 #include "test_modules.h"
 
+#include "test_booleans_active.h"
+#include "test_booleans_file.h"
+#include "test_booleans_policy.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -90,6 +94,9 @@ static int do_tests(int interactive, int
 	 * being properly connected via the
 	 * ps_api_connect test.
 	 */
+	DECLARE_SUITE(booleans_active);
+	DECLARE_SUITE(booleans_file);
+	DECLARE_SUITE(booleans_policy);
 
 	/* The ps_api_disconnect test 'unforks'. */
 	DECLARE_SUITE(ps_api_disconnect);
Index: selinux-pms-support/libsemanage/tests/test_booleans_active.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_active.c
@@ -0,0 +1,461 @@
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
+ *  libsemanage/src/booleans_active.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_booleans_active.h"
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
+#include "booleans_active.h"
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
+#include "database_llist.h"
+#include "serialize.h"
+
+/* Server table setup. */
+
+/* Record functions. */
+
+static record_table_t test_bool_rtable = {
+	.create = (create_f)semanage_bool_create,
+	.key_extract = (key_extract_f)semanage_bool_key_extract,
+	.key_free = (key_free_f)semanage_bool_key_free,
+	.clone = (clone_f)semanage_bool_clone,
+	.compare = (compare_f)semanage_bool_compare,
+	.compare2 = (compare2_f)semanage_bool_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_bool_free,
+	.serialize = (serialize_f)semanage_bool_serialize,
+	.unserialize = (unserialize_f)semanage_bool_unserialize,
+};
+
+/* Table functions. */
+
+/* Test cache function. */
+static int test_dbase_activedb_cache(
+	semanage_handle_t *handle,
+	dbase_config_t *dconfig)
+{
+	int status = 0;
+
+	/* Add some test entries to the list. */
+	record_t *aboolean = NULL;
+	record_key_t *abooleankey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool");
+	if (status) goto cleanup;
+
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 0);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	rtable->free(aboolean);
+	aboolean = NULL;
+	rtable->key_free(abooleankey);
+	abooleankey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool2");
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 1);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+
+	/* Cleanup. */
+cleanup:
+	rtable->free(aboolean);
+	rtable->key_free(abooleankey);
+
+	return status;
+}
+
+/* Database callback table. */
+static dbase_table_t test_activedb_dtable = {
+
+	/* Cache/Transactions */
+	.cache = test_dbase_activedb_cache,
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
+int booleans_active_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reset locks status. */
+		sh->u.direct.activelock_file_fd = 0;
+		sh->u.ps_handle.socket_fd = 0;
+
+		/* Store setup. */
+		dbase_config_t *dconfig = semanage_bool_dbase_active(sh);
+
+		if ((status =
+			dbase_activedb_init(
+				sh,
+				&test_bool_rtable,
+				NULL,
+				(dbase_activedb_t **)&dconfig->dbase)))
+			goto cleanup;
+
+		dconfig->dtable = &test_activedb_dtable;
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
+int booleans_active_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int booleans_active_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_bool_serialize_active", test_semanage_bool_serialize_active))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_bool_serialize_active function in booleans_active.c
+ */
+void test_semanage_bool_serialize_active(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	char *ptr = NULL;
+	int timeout = 0;
+	uint32_t database_type = 0;
+
+	semanage_bool_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_bool_dbase_active(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	const char *name;
+	int value;
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
+		free(data);
+		data = NULL;
+
+		if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+			goto cleanup;
+
+		CU_ASSERT( message_type == PS_GET_DATABASE );
+		if (message_type != PS_GET_DATABASE) {
+			status = -1;
+			goto cleanup;
+		}
+
+		/* Serialize the database. */
+		free(data);
+		data = NULL;
+
+		if ((status = semanage_bool_serialize_active(sh, &data, &data_length)))
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
+		/* dont move data pointer so we can free it later */
+		ptr = data;
+		/* Unserialize the database type */
+		 if(semanage_dbase_ps_database_type_unserialize(sh, &ptr, &data_length, &database_type))
+			goto cleanup;
+
+		/* Unserialize the database. */
+		if ((status = semanage_bool_unserialize_active(sh, ptr, data_length)))
+			goto cleanup;
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 3 );
+
+		/* Verify data. */
+		name = semanage_bool_get_name(records[0]);
+		value = semanage_bool_get_value(records[0]);
+
+		CU_ASSERT( strcmp(name, "testbool") == 0 );
+		CU_ASSERT( value == 0 );
+
+		name = semanage_bool_get_name(records[1]);
+		value = semanage_bool_get_value(records[1]);
+
+		CU_ASSERT( strcmp(name, "testbool2") == 0 );
+		CU_ASSERT( value == 1 );
+
+		name = semanage_bool_get_name(records[2]);
+		value = semanage_bool_get_value(records[2]);
+
+		CU_ASSERT( strcmp(name, "testbool3") == 0 );
+		CU_ASSERT( value == 0 );
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
+		name = semanage_bool_get_name(records[0]);
+		value = semanage_bool_get_value(records[0]);
+
+		CU_ASSERT( strcmp(name, "testbool") == 0 );
+		CU_ASSERT( value == 0 );
+
+		name = semanage_bool_get_name(records[1]);
+		value = semanage_bool_get_value(records[1]);
+
+		CU_ASSERT( strcmp(name, "testbool2") == 0 );
+		CU_ASSERT( value == 1 );
+
+		/* Change something. */
+
+		/* Add some test entries to the list. */
+		record_t *aboolean = NULL;
+		record_key_t *abooleankey = NULL;
+
+		/* Create record. */
+		status = rtable->create(sh, &aboolean);
+		if (status) goto cleanup;
+
+		/* Populate record. */
+		status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool3");
+		if (status) goto cleanup;
+
+		semanage_bool_set_value((semanage_bool_t *)aboolean, 0);
+
+		status = rtable->key_extract(sh, aboolean, &abooleankey);
+		if (status) goto cleanup;
+
+		/* Add record. */
+		status = dconfig->dtable->add(
+				sh,
+				dconfig,
+				abooleankey,
+				aboolean);
+		if (status) goto cleanup;
+
+		/* Cleanup. */
+		rtable->free(aboolean);
+		rtable->key_free(abooleankey);
+
+		/* Flush database.
+		 * This sends a message to the server to replace its database
+		 * with the one we are sending.  Internally the flush serializes
+		 * the database and sends it.  The server then unserializes it,
+		 * clears its old copy, and replaces it with the new one.
+		 */
+		status = dconfig->dtable->flush(sh, dconfig);
+		CU_ASSERT( status == 0 );
+
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
Index: selinux-pms-support/libsemanage/tests/test_booleans_active.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_active.h
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
+#ifndef __TEST_BOOLEANS_ACTIVE_H__
+#define __TEST_BOOLEANS_ACTIVE_H__
+
+#include <CUnit/Basic.h>
+
+int booleans_active_test_init(void);
+int booleans_active_test_cleanup(void);
+int booleans_active_add_tests(CU_pSuite suite);
+
+void test_semanage_bool_serialize_active(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_booleans_file.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_file.c
@@ -0,0 +1,457 @@
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
+ *  libsemanage/src/booleans_file.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_booleans_file.h"
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
+#include "booleans_local.h"
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
+static record_table_t test_bool_rtable = {
+	.create = (create_f)semanage_bool_create,
+	.key_extract = (key_extract_f)semanage_bool_key_extract,
+	.key_free = (key_free_f)semanage_bool_key_free,
+	.clone = (clone_f)semanage_bool_clone,
+	.compare = (compare_f)semanage_bool_compare,
+	.compare2 = (compare2_f)semanage_bool_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_bool_free,
+	.serialize = (serialize_f)semanage_bool_serialize,
+	.unserialize = (unserialize_f)semanage_bool_unserialize,
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
+	record_t *aboolean = NULL;
+	record_key_t *abooleankey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool");
+	if (status) goto cleanup;
+
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 0);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	rtable->free(aboolean);
+	aboolean = NULL;
+	rtable->key_free(abooleankey);
+	abooleankey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool2");
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 1);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+
+	/* Cleanup. */
+cleanup:
+	rtable->free(aboolean);
+	rtable->key_free(abooleankey);
+
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
+int booleans_file_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reset locks status. */
+		sh->u.direct.activelock_file_fd = 0;
+		sh->u.ps_handle.socket_fd = 0;
+
+		/* Store setup. */
+		dbase_config_t *dconfig = semanage_bool_dbase_local(sh);
+
+		if ((status =
+			dbase_file_init(
+				sh,
+				"/tmp/test-fake-filedb",
+				&test_bool_rtable,
+				NULL,
+				(dbase_file_t **)&dconfig->dbase)))
+			goto cleanup;
+
+		dconfig->dtable = &test_file_dtable;
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
+int booleans_file_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int booleans_file_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_bool_serialize_local", test_semanage_bool_serialize_local))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_bool_serialize_local function in booleans_file.c
+ */
+void test_semanage_bool_serialize_local(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	char *ptr = NULL;
+	int timeout = 0;
+	uint32_t database_type = 0;
+
+	semanage_bool_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_bool_dbase_local(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	const char *name;
+	int value;
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
+		if ((status = semanage_bool_serialize_local(sh, &data, &data_length)))
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
+		/* dont move data pointer so we can free it later */
+		ptr = data;
+		/* Unserialize the database type */
+		if(semanage_dbase_ps_database_type_unserialize(sh, &ptr, &data_length, &database_type))
+			goto cleanup;
+
+		/* Unserialize the database. and don't move the data pointer*/
+		if ((status = semanage_bool_unserialize_local(sh, ptr, data_length)))
+			goto cleanup;
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 3 );
+
+		/* Verify data. */
+		name = semanage_bool_get_name(records[0]);
+		value = semanage_bool_get_value(records[0]);
+
+		CU_ASSERT( strcmp(name, "testbool") == 0 );
+		CU_ASSERT( value == 0 );
+
+		name = semanage_bool_get_name(records[1]);
+		value = semanage_bool_get_value(records[1]);
+
+		CU_ASSERT( strcmp(name, "testbool2") == 0 );
+		CU_ASSERT( value == 1 );
+
+		name = semanage_bool_get_name(records[2]);
+		value = semanage_bool_get_value(records[2]);
+
+		CU_ASSERT( strcmp(name, "testbool3") == 0 );
+		CU_ASSERT( value == 0 );
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
+		name = semanage_bool_get_name(records[0]);
+		value = semanage_bool_get_value(records[0]);
+
+		CU_ASSERT( strcmp(name, "testbool") == 0 );
+		CU_ASSERT( value == 0 );
+
+		name = semanage_bool_get_name(records[1]);
+		value = semanage_bool_get_value(records[1]);
+
+		CU_ASSERT( strcmp(name, "testbool2") == 0 );
+		CU_ASSERT( value == 1 );
+
+		/* Change something. */
+
+		/* Add some test entries to the list. */
+		record_t *aboolean = NULL;
+		record_key_t *abooleankey = NULL;
+
+		/* Create record. */
+		status = rtable->create(sh, &aboolean);
+		if (status) goto cleanup;
+
+		/* Populate record. */
+		status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool3");
+		if (status) goto cleanup;
+
+		semanage_bool_set_value((semanage_bool_t *)aboolean, 0);
+
+		status = rtable->key_extract(sh, aboolean, &abooleankey);
+		if (status) goto cleanup;
+
+		/* Add record. */
+		status = dconfig->dtable->add(
+			sh,
+			dconfig,
+			abooleankey,
+			aboolean);
+		if (status) goto cleanup;
+
+		/* Cleanup. */
+		rtable->free(aboolean);
+		rtable->key_free(abooleankey);
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
Index: selinux-pms-support/libsemanage/tests/test_booleans_file.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_file.h
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
+#ifndef __TEST_BOOLEANS_FILE_H__
+#define __TEST_BOOLEANS_FILE_H__
+
+#include <CUnit/Basic.h>
+
+int booleans_file_test_init(void);
+int booleans_file_test_cleanup(void);
+int booleans_file_add_tests(CU_pSuite suite);
+
+void test_semanage_bool_serialize_local(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_booleans_policy.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_policy.c
@@ -0,0 +1,352 @@
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
+ *  libsemanage/src/booleans_policy.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_booleans_policy.h"
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
+#include "booleans_policy.h"
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
+static record_table_t test_bool_rtable = {
+	.create = (create_f)semanage_bool_create,
+	.key_extract = (key_extract_f)semanage_bool_key_extract,
+	.key_free = (key_free_f)semanage_bool_key_free,
+	.clone = (clone_f)semanage_bool_clone,
+	.compare = (compare_f)semanage_bool_compare,
+	.compare2 = (compare2_f)semanage_bool_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_bool_free,
+	.serialize = (serialize_f)semanage_bool_serialize,
+	.unserialize = (unserialize_f)semanage_bool_unserialize,
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
+	record_t *aboolean = NULL;
+	record_key_t *abooleankey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool");
+	if (status) goto cleanup;
+
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 0);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	rtable->free(aboolean);
+	aboolean = NULL;
+	rtable->key_free(abooleankey);
+	abooleankey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &aboolean);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	status = semanage_bool_set_name(sh, (semanage_bool_t *)aboolean, "testbool2");
+	semanage_bool_set_value((semanage_bool_t *)aboolean, 1);
+
+	status = rtable->key_extract(sh, aboolean, &abooleankey);
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		abooleankey,
+		aboolean);
+
+	/* Cleanup. */
+cleanup:
+	rtable->free(aboolean);
+	rtable->key_free(abooleankey);
+
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
+int booleans_policy_test_init(void)
+{
+	int status = 0;
+
+	if (ps_pid == 0) {
+		/* Server code. */
+
+		/* Reset locks status. */
+		sh->u.direct.activelock_file_fd = 0;
+		sh->u.ps_handle.socket_fd = 0;
+
+		/* Store setup. */
+		dbase_config_t *dconfig = semanage_bool_dbase_policy(sh);
+
+		if ((status =
+			dbase_policydb_init(
+				sh,
+				"policy.kern",
+				&test_bool_rtable,
+				NULL,
+				(dbase_policydb_t **)&dconfig->dbase)))
+			goto cleanup;
+
+		dconfig->dtable = &test_policydb_dtable;
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
+int booleans_policy_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int booleans_policy_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_bool_serialize_policy", test_semanage_bool_serialize_policy))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_bool_serialize_policy function in booleans_policy.c
+ */
+void test_semanage_bool_serialize_policy(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	semanage_bool_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_bool_dbase_policy(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	const char *name;
+	int value;
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
+		if ((status = semanage_bool_serialize_policy(sh, &data, &data_length)))
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
+		name = semanage_bool_get_name(records[0]);
+		value = semanage_bool_get_value(records[0]);
+
+		CU_ASSERT( strcmp(name, "testbool") == 0 );
+		CU_ASSERT( value == 0 );
+
+		name = semanage_bool_get_name(records[1]);
+		value = semanage_bool_get_value(records[1]);
+
+		CU_ASSERT( strcmp(name, "testbool2") == 0 );
+		CU_ASSERT( value == 1 );
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
Index: selinux-pms-support/libsemanage/tests/test_booleans_policy.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_booleans_policy.h
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
+#ifndef __TEST_BOOLEANS_POLICY_H__
+#define __TEST_BOOLEANS_POLICY_H__
+
+#include <CUnit/Basic.h>
+
+int booleans_policy_test_init(void);
+int booleans_policy_test_cleanup(void);
+int booleans_policy_add_tests(CU_pSuite suite);
+
+void test_semanage_bool_serialize_policy(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/utilities.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/utilities.c
+++ selinux-pms-support/libsemanage/tests/utilities.c
@@ -21,6 +21,15 @@
  *  by our unit tests.
  */
 
+#include <inttypes.h>
+#include <stdlib.h>
+#include <CUnit/Basic.h>
+
+#include "debug.h"
+#include "globals.h"
+#include "handle.h"
+#include "messages_internal.h"
+#include "policy.h"
 #include "utilities.h"
 
 /* Silence any error output caused by our tests
@@ -30,3 +39,52 @@ void test_msg_handler(void *varg,
 		      semanage_handle_t * handle, const char *fmt, ...)
 {
 }
+
+int test_semanage_serialize_serial(semanage_handle_t *sh, int commit_number, char **data, uint64_t *data_length)
+{
+	int status = STATUS_SUCCESS;
+
+	status = semanage_policy_table_serialize_serial(sh, data, data_length);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+cleanup:
+	return status;
+}
+
+int test_semanage_ps_handle_get_commit_number(semanage_handle_t *sh, int commit_number) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	/* Wait for message. */
+	if ((status = read_msg(sh, client_socket_fd, timeout, &message_type, &data_length, &data)))
+		goto cleanup;
+
+	CU_ASSERT( message_type == PS_GET_COMMIT_NUMBER );
+	if (message_type != PS_GET_COMMIT_NUMBER) {
+		status = STATUS_ERR;
+		goto cleanup;
+	}
+
+	/* Serialize the commit number. */
+	free(data);
+	data = NULL;
+
+	status = test_semanage_serialize_serial(sh, commit_number, &data, &data_length);
+	CU_ASSERT( status == STATUS_SUCCESS);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+	status = write_msg(sh, client_socket_fd, PS_OK, data_length, data);
+	CU_ASSERT( status == STATUS_SUCCESS);
+	if (status != STATUS_SUCCESS)
+		goto cleanup;
+
+cleanup:
+	free(data);
+	return status;
+}
Index: selinux-pms-support/libsemanage/tests/utilities.h
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/utilities.h
+++ selinux-pms-support/libsemanage/tests/utilities.h
@@ -17,7 +17,14 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <inttypes.h>
+
 #include "handle.h"
 
 void test_msg_handler(void *varg, semanage_handle_t * handle, const char *fmt,
 		      ...);
+
+int test_semanage_serialize_serial(semanage_handle_t *sh, int commit_number, char **data, uint64_t *data_length);
+
+int test_semanage_ps_handle_get_commit_number(semanage_handle_t *sh, int commit_number);
+

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
