Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUqMf001890
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:52 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUoSG027937
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:50 GMT
Message-Id: <20070423213751.466784000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:26 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 31/33] libsemanage: port serialization tests
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/tests/libsemanage-tests.c |    6 
 libsemanage/tests/test_ports_file.c   |  516 ++++++++++++++++++++++++++++++++++
 libsemanage/tests/test_ports_file.h   |   32 ++
 libsemanage/tests/test_ports_policy.c |  384 +++++++++++++++++++++++++
 libsemanage/tests/test_ports_policy.h |   32 ++
 5 files changed, 970 insertions(+)

Index: selinux-pms-support/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux-pms-support.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux-pms-support/libsemanage/tests/libsemanage-tests.c
@@ -48,6 +48,9 @@
 #include "test_nodes_file.h"
 #include "test_nodes_policy.h"
 
+#include "test_ports_file.h"
+#include "test_ports_policy.h"
+
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -116,6 +119,9 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(nodes_file);
 	DECLARE_SUITE(nodes_policy);
 
+	DECLARE_SUITE(ports_file);
+	DECLARE_SUITE(ports_policy);
+
 	/* The ps_api_disconnect test 'unforks'. */
 	DECLARE_SUITE(ps_api_disconnect);
 
Index: selinux-pms-support/libsemanage/tests/test_ports_file.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ports_file.c
@@ -0,0 +1,516 @@
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
+ *  libsemanage/src/ports_file.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_ports_file.h"
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
+#include "ports_local.h"
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
+static record_table_t test_port_rtable = {
+	.create = (create_f)semanage_port_create,
+	.key_extract = (key_extract_f)semanage_port_key_extract,
+	.key_free = (key_free_f)semanage_port_key_free,
+	.clone = (clone_f)semanage_port_clone,
+	.compare = (compare_f)semanage_port_compare,
+	.compare2 = (compare2_f)semanage_port_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_port_free,
+	.serialize = (serialize_f)semanage_port_serialize,
+	.unserialize = (unserialize_f)semanage_port_unserialize,
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
+	record_t *port = NULL;
+	record_key_t *portkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &port);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_context_t *context;
+	int proto = SEMANAGE_PROTO_TCP;
+
+	semanage_port_set_range((semanage_port_t *)port, 1, 65535);
+	semanage_port_set_proto((semanage_port_t *)port, proto);
+
+	status = semanage_context_from_string(sh, "testuser:testrole:testtype", &context);
+	if (status) goto cleanup;
+	status = semanage_port_set_con(sh, (semanage_port_t *)port, context);
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, port, &portkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		portkey,
+		port);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	semanage_context_free(context);
+	context = NULL;
+	rtable->free(port);
+	port = NULL;
+	rtable->key_free(portkey);
+	portkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &port);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_port_set_range((semanage_port_t *)port, 2, 1024);
+	semanage_port_set_proto((semanage_port_t *)port, proto);
+
+	status = semanage_context_from_string(sh, "testuser2:testrole2:testtype2", &context);
+	if (status) goto cleanup;
+	status = semanage_port_set_con(sh, (semanage_port_t *)port, context);
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, port, &portkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		portkey,
+		port);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	semanage_context_free(context);
+	rtable->free(port);
+	rtable->key_free(portkey);
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
+int ports_file_test_init(void)
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
+		dbase_config_t *dconfig = semanage_port_dbase_local(sh);
+
+		if ((status =
+			dbase_file_init(
+				sh,
+				"fakesuffix",
+				&test_port_rtable,
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
+int ports_file_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int ports_file_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_port_serialize_local", test_semanage_port_serialize_local))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_port_serialize_local function in ports_file.c
+ */
+void test_semanage_port_serialize_local(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	char *ptr = NULL;
+	int timeout = 0;
+	uint32_t database_type = 0;
+
+	semanage_port_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_port_dbase_local(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	char *context_str = NULL;
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
+		if ((status = semanage_port_serialize_local(sh, &data, &data_length)))
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
+		if ((status = write_msg(sh,client_socket_fd, PS_OK, 0, NULL)))
+			goto cleanup;
+
+		/* Unserialize the database type */
+		ptr = data;
+		if(semanage_dbase_ps_database_type_unserialize(sh, &ptr, &data_length, &database_type));
+			goto cleanup;
+
+		/* Unserialize the database. and don't move the data pointer.*/
+		if ((status = semanage_port_unserialize_local(sh, ptr, data_length)))
+			goto cleanup;
+
+		/* Gather the database records. */
+		status = dconfig->dtable->list(sh, dconfig, (record_t ***)&records, &records_size);
+		CU_ASSERT( status == 0 );
+		CU_ASSERT( records != NULL );
+		CU_ASSERT( records_size == 3 );
+
+		/* Verify data. */
+		int proto = semanage_port_get_proto(records[0]);
+		int low = semanage_port_get_low(records[0]);
+		int high = semanage_port_get_high(records[0]);
+
+		semanage_context_t *context = semanage_port_get_con(records[0]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 1 );
+		CU_ASSERT( high == 65535 );
+		CU_ASSERT( strcmp(context_str, "testuser:testrole:testtype") == 0 );
+
+		/* Cleanup. */
+		free(context_str);
+
+		proto = semanage_port_get_proto(records[1]);
+		low = semanage_port_get_low(records[1]);
+		high = semanage_port_get_high(records[1]);
+
+		context = semanage_port_get_con(records[1]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 2 );
+		CU_ASSERT( high == 1024 );
+		CU_ASSERT( strcmp(context_str, "testuser2:testrole2:testtype2") == 0 );
+
+		/* Cleanup. */
+		free(context_str);
+
+		proto = semanage_port_get_proto(records[2]);
+		low = semanage_port_get_low(records[2]);
+		high = semanage_port_get_high(records[2]);
+
+		context = semanage_port_get_con(records[2]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 3 );
+		CU_ASSERT( high == 59049 );
+		CU_ASSERT( strcmp(context_str, "testuser3:testrole3:testtype3") == 0 );
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
+		int proto = semanage_port_get_proto(records[0]);
+		int low = semanage_port_get_low(records[0]);
+		int high = semanage_port_get_high(records[0]);
+
+		semanage_context_t *context = semanage_port_get_con(records[0]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 1 );
+		CU_ASSERT( high == 65535 );
+		CU_ASSERT( strcmp(context_str, "testuser:testrole:testtype") == 0 );
+
+		/* Cleanup. */
+		free(context_str);
+
+		proto = semanage_port_get_proto(records[1]);
+		low = semanage_port_get_low(records[1]);
+		high = semanage_port_get_high(records[1]);
+
+		context = semanage_port_get_con(records[1]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 2 );
+		CU_ASSERT( high == 1024 );
+		CU_ASSERT( strcmp(context_str, "testuser2:testrole2:testtype2") == 0 );
+
+		/* Change something. */
+
+		/* Add some test entries to the list. */
+		record_t *port = NULL;
+		record_key_t *portkey = NULL;
+
+		/* Create record. */
+		status = rtable->create(sh, &port);
+		if (status) goto cleanup;
+
+		/* Populate record. */
+		semanage_port_set_range((semanage_port_t *)port, 3, 59049);
+		semanage_port_set_proto((semanage_port_t *)port, proto);
+
+		status = semanage_context_from_string(sh, "testuser3:testrole3:testtype3", &context);
+		if (status) goto cleanup;
+		status = semanage_port_set_con(sh, (semanage_port_t *)port, context);
+		if (status) goto cleanup;
+
+		status = rtable->key_extract(sh, port, &portkey);
+		if (status) goto cleanup;
+
+		/* Add record. */
+		status = dconfig->dtable->add(
+				sh,
+				dconfig,
+				portkey,
+				port);
+		if (status) goto cleanup;
+
+		/* Cleanup. */
+		semanage_context_free(context);
+		rtable->free(port);
+		rtable->key_free(portkey);
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
+	free(context_str);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_ports_file.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ports_file.h
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
+#ifndef __TEST_PORTS_FILE_H__
+#define __TEST_PORTS_FILE_H__
+
+#include <CUnit/Basic.h>
+
+int ports_file_test_init(void);
+int ports_file_test_cleanup(void);
+int ports_file_add_tests(CU_pSuite suite);
+
+void test_semanage_port_serialize_local(void);
+
+#endif
Index: selinux-pms-support/libsemanage/tests/test_ports_policy.c
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ports_policy.c
@@ -0,0 +1,384 @@
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
+ *  libsemanage/src/ports_policy.c
+ *
+ */
+
+#include "globals.h"
+#include "utilities.h"
+#include "test_ports_policy.h"
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
+#include "ports_policy.h"
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
+static record_table_t test_port_rtable = {
+	.create = (create_f)semanage_port_create,
+	.key_extract = (key_extract_f)semanage_port_key_extract,
+	.key_free = (key_free_f)semanage_port_key_free,
+	.clone = (clone_f)semanage_port_clone,
+	.compare = (compare_f)semanage_port_compare,
+	.compare2 = (compare2_f)semanage_port_compare2,
+	.compare2_qsort = NULL,
+	.free = (free_f)semanage_port_free,
+	.serialize = (serialize_f)semanage_port_serialize,
+	.unserialize = (unserialize_f)semanage_port_unserialize,
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
+	record_t *port = NULL;
+	record_key_t *portkey = NULL;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Create record. */
+	status = rtable->create(sh, &port);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_context_t *context;
+	int proto = SEMANAGE_PROTO_TCP;
+
+	semanage_port_set_range((semanage_port_t *)port, 1, 65535);
+	semanage_port_set_proto((semanage_port_t *)port, proto);
+
+	status = semanage_context_from_string(sh, "testuser:testrole:testtype", &context);
+	if (status) goto cleanup;
+	status = semanage_port_set_con(sh, (semanage_port_t *)port, context);
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, port, &portkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		portkey,
+		port);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+	semanage_context_free(context);
+	context = NULL;
+	rtable->free(port);
+	port = NULL;
+	rtable->key_free(portkey);
+	portkey = NULL;
+
+	/* Create record. */
+	status = rtable->create(sh, &port);
+	if (status) goto cleanup;
+
+	/* Populate record. */
+	semanage_port_set_range((semanage_port_t *)port, 2, 1024);
+	semanage_port_set_proto((semanage_port_t *)port, proto);
+
+	status = semanage_context_from_string(sh, "testuser2:testrole2:testtype2", &context);
+	if (status) goto cleanup;
+	status = semanage_port_set_con(sh, (semanage_port_t *)port, context);
+	if (status) goto cleanup;
+
+	status = rtable->key_extract(sh, port, &portkey);
+	if (status) goto cleanup;
+
+	/* Add record. */
+	status = dconfig->dtable->add(
+		sh,
+		dconfig,
+		portkey,
+		port);
+	if (status) goto cleanup;
+
+	/* Cleanup. */
+cleanup:
+	semanage_context_free(context);
+	rtable->free(port);
+	rtable->key_free(portkey);
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
+int ports_policy_test_init(void)
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
+		dbase_config_t *dconfig = semanage_port_dbase_policy(sh);
+
+		if ((status =
+			dbase_policydb_init(
+				sh,
+				"fakesuffix",
+				&test_port_rtable,
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
+int ports_policy_test_cleanup(void)
+{
+	return 0;
+}
+
+/* Adds all the tests needed for this suite.
+*/
+int ports_policy_add_tests(CU_pSuite suite)
+{
+	CU_ErrorCode status;
+
+	if (NULL == CU_add_test(suite, "semanage_port_serialize_policy", test_semanage_port_serialize_policy))
+		goto cleanup;
+
+cleanup:
+	if (CUE_SUCCESS != (status = CU_get_error()))
+		CU_cleanup_registry();
+	return status;
+}
+
+/* Tests the semanage_port_serialize_policy function in ports_policy.c
+ */
+void test_semanage_port_serialize_policy(void) {
+	int status;
+
+	uint32_t message_type;
+	uint64_t data_length;
+	char *data = NULL;
+	int timeout = 0;
+
+	semanage_port_t **records = NULL;
+	unsigned int records_size;
+
+	dbase_config_t *dconfig = semanage_port_dbase_policy(sh);
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	char *context_str = NULL;
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
+		if ((status = semanage_port_serialize_policy(sh, &data, &data_length)))
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
+		int proto = semanage_port_get_proto(records[0]);
+		int low = semanage_port_get_low(records[0]);
+		int high = semanage_port_get_high(records[0]);
+
+		semanage_context_t *context = semanage_port_get_con(records[0]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 1 );
+		CU_ASSERT( high == 65535 );
+		CU_ASSERT( strcmp(context_str, "testuser:testrole:testtype") == 0 );
+
+		/* Cleanup. */
+		free(context_str);
+
+		proto = semanage_port_get_proto(records[1]);
+		low = semanage_port_get_low(records[1]);
+		high = semanage_port_get_high(records[1]);
+
+		context = semanage_port_get_con(records[1]);
+		status = semanage_context_to_string(sh, context, &context_str);
+
+		CU_ASSERT( proto == SEMANAGE_PROTO_TCP );
+		CU_ASSERT( low == 2 );
+		CU_ASSERT( high == 1024 );
+		CU_ASSERT( strcmp(context_str, "testuser2:testrole2:testtype2") == 0 );
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
+	free(context_str);
+
+	CU_ASSERT( status == 0 );
+	if (status != 0) {
+		printf("\n\nReceived error code in %s: %d | %s\n", (ps_pid == 0) ? "server" : "client", status, strerror(status));
+	}
+}
+
Index: selinux-pms-support/libsemanage/tests/test_ports_policy.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/test_ports_policy.h
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
+#ifndef __TEST_PORTS_POLICY_H__
+#define __TEST_PORTS_POLICY_H__
+
+#include <CUnit/Basic.h>
+
+int ports_policy_test_init(void);
+int ports_policy_test_cleanup(void);
+int ports_policy_add_tests(CU_pSuite suite);
+
+void test_semanage_port_serialize_policy(void);
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
