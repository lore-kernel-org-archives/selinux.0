Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A777C31E48
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DD620684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfFLIEr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23483 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436774AbfFLIEr (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4E230C1AE8
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C468678386
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:46 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/11] libsemanage: test semanage_port_* functions
Date:   Wed, 12 Jun 2019 10:04:01 +0200
Message-Id: <20190612080404.4529-9-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_port_* functions. The test suite aims for line
coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_port.c         | 909 ++++++++++++++++++++++++++
 libsemanage/tests/test_port.cil       |  27 +
 libsemanage/tests/test_port.h         |  30 +
 4 files changed, 968 insertions(+)
 create mode 100644 libsemanage/tests/test_port.c
 create mode 100644 libsemanage/tests/test_port.cil
 create mode 100644 libsemanage/tests/test_port.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index ba24421d..b4a8c122 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -27,6 +27,7 @@
 #include "test_iface.h"
 #include "test_ibendport.h"
 #include "test_node.h"
+#include "test_port.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -71,6 +72,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(iface);
 	DECLARE_SUITE(ibendport);
 	DECLARE_SUITE(node);
+	DECLARE_SUITE(port);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_port.c b/libsemanage/tests/test_port.c
new file mode 100644
index 00000000..0408be4d
--- /dev/null
+++ b/libsemanage/tests/test_port.c
@@ -0,0 +1,909 @@
+/*
+ * Authors: Jan Zarsky <jzarsky@redhat.com>
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "utilities.h"
+#include "test_port.h"
+
+#define PORT_COUNT 3
+
+#define PORT1_LOW 80
+#define PORT1_HIGH 80
+#define PORT1_PROTO SEPOL_PROTO_TCP
+
+#define PORT2_LOW 1
+#define PORT2_HIGH 1023
+#define PORT2_PROTO SEPOL_PROTO_UDP
+
+#define PORT3_LOW 12345
+#define PORT3_HIGH 12345
+#define PORT3_PROTO SEPOL_PROTO_TCP
+
+/* port_record.h */
+void test_port_compare(void);
+void test_port_compare2(void);
+void test_port_key_create(void);
+void test_port_key_extract(void);
+void test_port_get_set_proto(void);
+void test_port_get_proto_str(void);
+void test_port_get_set_port(void);
+void test_port_get_set_con(void);
+void test_port_create(void);
+void test_port_clone(void);
+
+/* ports_policy.h */
+void test_port_query(void);
+void test_port_exists(void);
+void test_port_count(void);
+void test_port_iterate(void);
+void test_port_list(void);
+
+/* ports_local.h */
+void test_port_modify_del_local(void);
+void test_port_query_local(void);
+void test_port_exists_local(void);
+void test_port_count_local(void);
+void test_port_iterate_local(void);
+void test_port_list_local(void);
+
+/* internal */
+void test_port_validate_local(void);
+
+extern semanage_handle_t *sh;
+
+int port_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_port.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int port_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could not destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int port_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "port_compare", test_port_compare);
+	CU_add_test(suite, "port_compare2", test_port_compare2);
+	CU_add_test(suite, "port_key_create", test_port_key_create);
+	CU_add_test(suite, "port_key_extract", test_port_key_extract);
+	CU_add_test(suite, "port_get_set_proto", test_port_get_set_proto);
+	CU_add_test(suite, "port_get_proto_str", test_port_get_proto_str);
+	CU_add_test(suite, "port_get_set_port", test_port_get_set_port);
+	CU_add_test(suite, "port_get_set_con", test_port_get_set_con);
+	CU_add_test(suite, "port_create", test_port_create);
+	CU_add_test(suite, "port_clone", test_port_clone);
+
+	CU_add_test(suite, "port_query", test_port_query);
+	CU_add_test(suite, "port_exists", test_port_exists);
+	CU_add_test(suite, "port_count", test_port_count);
+	CU_add_test(suite, "port_iterate", test_port_iterate);
+	CU_add_test(suite, "port_list", test_port_list);
+
+	CU_add_test(suite, "port_modify_del_local", test_port_modify_del_local);
+	CU_add_test(suite, "port_query_local", test_port_query_local);
+	CU_add_test(suite, "port_exists_local", test_port_exists_local);
+	CU_add_test(suite, "port_count_local", test_port_count_local);
+	CU_add_test(suite, "port_iterate_local", test_port_iterate_local);
+	CU_add_test(suite, "port_list_local", test_port_list_local);
+
+	CU_add_test(suite, "port_validate_local", test_port_validate_local);
+
+	return 0;
+}
+
+/* Helpers */
+
+semanage_port_t *get_port_nth(int idx)
+{
+	int res;
+	semanage_port_t **records;
+	semanage_port_t *port;
+	unsigned int count;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	res = semanage_port_list(sh, &records, &count);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_FATAL(count >= (unsigned int) idx + 1);
+
+	port = records[idx];
+
+	for (unsigned int i = 0; i < count; i++)
+		if (i != (unsigned int) idx)
+			semanage_port_free(records[i]);
+
+	return port;
+}
+
+semanage_port_key_t *get_port_key_nth(int idx)
+{
+	semanage_port_key_t *key;
+	semanage_port_t *port;
+	int res;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	port = get_port_nth(idx);
+
+	res = semanage_port_key_extract(sh, port, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+void add_local_port(int port_idx)
+{
+	semanage_port_t *port;
+	semanage_port_key_t *key = NULL;
+
+	CU_ASSERT_FATAL(port_idx != I_NULL);
+
+	port = get_port_nth(port_idx);
+
+	CU_ASSERT_FATAL(semanage_port_key_extract(sh, port, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_port_modify_local(sh, key, port) >= 0);
+}
+
+void delete_local_port(int port_idx)
+{
+	semanage_port_key_t *key = NULL;
+
+	CU_ASSERT_FATAL(port_idx != I_NULL);
+
+	key = get_port_key_nth(port_idx);
+
+	CU_ASSERT_FATAL(semanage_port_del_local(sh, key) >= 0);
+}
+
+/* Function semanage_port_compare */
+void helper_port_compare(int idx1, int idx2)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_key_t *key = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	port = get_port_nth(idx1);
+	key = get_port_key_nth(idx2);
+
+	/* test */
+	res = semanage_port_compare(port, key);
+
+	if (idx1 == idx2) {
+		CU_ASSERT(res == 0);
+	} else {
+		CU_ASSERT(res != 0);
+	}
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+void test_port_compare(void)
+{
+	helper_port_compare(I_FIRST,  I_FIRST);
+	helper_port_compare(I_FIRST,  I_SECOND);
+	helper_port_compare(I_SECOND, I_FIRST);
+	helper_port_compare(I_SECOND, I_SECOND);
+}
+
+/* Function semanage_port_compare2 */
+void helper_port_compare2(int idx1, int idx2)
+{
+	semanage_port_t *port1 = NULL;
+	semanage_port_t *port2 = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	port1 = get_port_nth(idx1);
+	port2 = get_port_nth(idx2);
+
+	/* test */
+	res = semanage_port_compare2(port1, port2);
+
+	if (idx1 == idx2) {
+		CU_ASSERT(res == 0);
+	} else {
+		CU_ASSERT(res != 0);
+	}
+
+	/* cleanup */
+	semanage_port_free(port1);
+	semanage_port_free(port2);
+	cleanup_handle(SH_CONNECT);
+}
+
+void test_port_compare2(void)
+{
+	helper_port_compare2(I_FIRST,  I_FIRST);
+	helper_port_compare2(I_FIRST,  I_SECOND);
+	helper_port_compare2(I_SECOND, I_FIRST);
+	helper_port_compare2(I_SECOND, I_SECOND);
+}
+
+/* Function semanage_port_create */
+void test_port_key_create(void)
+{
+	semanage_port_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_port_key_create(sh, 1000, 1200, 0, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_port_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_extract */
+void test_port_key_extract(void)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	port = get_port_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_port_key_extract(sh, port, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_get_proto, semanage_port_set_proto */
+void helper_port_get_set_proto(int idx)
+{
+	semanage_port_t *port = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	port = get_port_nth(idx);
+
+	/* test */
+	semanage_port_set_proto(port, 0);
+	CU_ASSERT(semanage_port_get_proto(port) == 0);
+	semanage_port_set_proto(port, 1);
+	CU_ASSERT(semanage_port_get_proto(port) == 1);
+
+	/* cleanup */
+	semanage_port_free(port);
+	cleanup_handle(SH_CONNECT);
+}
+
+void test_port_get_set_proto(void)
+{
+	helper_port_get_set_proto(I_FIRST);
+	helper_port_get_set_proto(I_SECOND);
+}
+
+/* Function semanage_port_get_proto_str */
+void test_port_get_proto_str(void)
+{
+	const char *str = NULL;
+
+	str = semanage_port_get_proto_str(-1);
+	CU_ASSERT_STRING_EQUAL(str, "???");
+
+	str = semanage_port_get_proto_str(0);
+	CU_ASSERT_STRING_EQUAL(str, "udp");
+
+	str = semanage_port_get_proto_str(1);
+	CU_ASSERT_STRING_EQUAL(str, "tcp");
+
+	str = semanage_port_get_proto_str(2);
+	CU_ASSERT_STRING_EQUAL(str, "dccp");
+
+	str = semanage_port_get_proto_str(3);
+	CU_ASSERT_STRING_EQUAL(str, "sctp");
+
+	str = semanage_port_get_proto_str(4);
+	CU_ASSERT_STRING_EQUAL(str, "???");
+}
+
+/* Function semanage_port_get_low, semanage_port_get_high, */
+/* semanage_port_set_port, semanage_port_set_range */
+void test_port_get_set_port(void)
+{
+	semanage_port_t *port = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	port = get_port_nth(I_FIRST);
+
+	/* test */
+	semanage_port_set_port(port, 1000);
+	CU_ASSERT(semanage_port_get_low(port) == 1000);
+	CU_ASSERT(semanage_port_get_high(port) == 1000);
+
+	semanage_port_set_range(port, 1000, 1200);
+	CU_ASSERT(semanage_port_get_low(port) == 1000);
+	CU_ASSERT(semanage_port_get_high(port) == 1200);
+
+	/* cleanup */
+	semanage_port_free(port);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_get_con, semanage_port_set_con */
+void test_port_get_set_con(void)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_t *port_tmp = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	port = get_port_nth(I_FIRST);
+	port_tmp = get_port_nth(I_SECOND);
+	con1 = semanage_port_get_con(port_tmp);
+
+	/* test */
+	CU_ASSERT(semanage_port_set_con(sh, port, con1) >= 0);
+	con2 = semanage_port_get_con(port);
+	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_free(port_tmp);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_create */
+void test_port_create(void)
+{
+	semanage_port_t *port = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_port_create(sh, &port) >= 0);
+	CU_ASSERT(semanage_port_get_low(port) == 0);
+	CU_ASSERT(semanage_port_get_high(port) == 0);
+	CU_ASSERT(semanage_port_get_con(port) == NULL);
+	CU_ASSERT(semanage_port_get_proto(port) == 0);
+
+	/* cleanup */
+	semanage_port_free(port);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_clone */
+void test_port_clone(void)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_t *port_clone = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_port_create(sh, &port) >= 0);
+	semanage_port_set_range(port, 1000, 1200);
+	semanage_port_set_proto(port, 1);
+	semanage_context_from_string(sh, "user_u:role_r:type_t:s0", &con);
+	semanage_port_set_con(sh, port, con);
+
+	/* test */
+	CU_ASSERT(semanage_port_clone(sh, port, &port_clone) >= 0);
+	CU_ASSERT(semanage_port_get_low(port_clone) == 1000);
+	CU_ASSERT(semanage_port_get_high(port_clone) == 1200);
+	CU_ASSERT(semanage_port_get_proto(port_clone) == 1);
+
+	con2 = semanage_port_get_con(port_clone);
+	CU_ASSERT_CONTEXT_EQUAL(con, con2);
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_free(port_clone);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_query */
+void test_port_query(void)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_t *port_exp = NULL;
+	semanage_port_key_t *key = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_exp = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key = get_port_key_nth(I_FIRST);
+	port_exp = get_port_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_port_query(sh, key, &port) >= 0);
+	CU_ASSERT(semanage_port_get_low(port) ==
+			  semanage_port_get_low(port_exp));
+	CU_ASSERT(semanage_port_get_high(port) ==
+			  semanage_port_get_high(port_exp));
+	CU_ASSERT(semanage_port_get_proto(port) ==
+			  semanage_port_get_proto(port_exp));
+
+	con = semanage_port_get_con(port);
+	con_exp = semanage_port_get_con(port_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	/* cleanup */
+	semanage_port_free(port);
+	semanage_port_free(port_exp);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_exists */
+void test_port_exists(void)
+{
+	semanage_port_key_t *key1 = NULL;
+	semanage_port_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key1 = get_port_key_nth(I_FIRST);
+	CU_ASSERT(semanage_port_key_create(sh, 123, 456, 0, &key2) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_port_exists(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_port_exists(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	semanage_port_key_free(key1);
+	semanage_port_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_count */
+void test_port_count(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_port_count(sh, &count) >= 0);
+	CU_ASSERT(count == PORT_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_iterate */
+unsigned int counter_port_iterate = 0;
+
+int handler_port_iterate(const semanage_port_t *record, void *varg)
+{
+	counter_port_iterate++;
+	return 0;
+}
+
+void test_port_iterate(void)
+{
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	semanage_port_iterate(sh, handler_port_iterate, NULL);
+	CU_ASSERT(counter_port_iterate == PORT_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_list */
+void test_port_list(void)
+{
+	semanage_port_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_port_list(sh, &records, &count) >= 0);
+	CU_ASSERT(count == PORT_COUNT);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_port_free(records[i]);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_port_modify_local, semanage_port_del_local */
+void test_port_modify_del_local(void)
+{
+	semanage_port_t *port;
+	semanage_port_t *port_local;
+	semanage_port_key_t *key = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_local = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	port = get_port_nth(I_FIRST);
+	semanage_context_from_string(sh, "user_u:role_r:type_t:s0", &con);
+	semanage_port_set_con(sh, port, con);
+	CU_ASSERT(semanage_port_key_extract(sh, port, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* test */
+	CU_ASSERT(semanage_port_modify_local(sh, key, port) >= 0);
+	CU_ASSERT(semanage_port_query_local(sh, key, &port_local) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(port_local);
+
+	con_local = semanage_port_get_con(port_local);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_local);
+
+	CU_ASSERT(semanage_port_del_local(sh, key) >= 0);
+	CU_ASSERT(semanage_port_query_local(sh, key, &port_local) < 0);
+
+	/* cleanup */
+	semanage_port_free(port);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_port_query_local */
+void test_port_query_local(void)
+{
+	semanage_port_t *port = NULL;
+	semanage_port_t *port_exp = NULL;
+	semanage_port_key_t *key = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_exp = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+	key = get_port_key_nth(I_FIRST);
+	port_exp = get_port_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_port_query_local(sh, key, &port) >= 0);
+	CU_ASSERT(semanage_port_get_low(port) ==
+			  semanage_port_get_low(port_exp));
+	CU_ASSERT(semanage_port_get_high(port) ==
+			  semanage_port_get_high(port_exp));
+	CU_ASSERT(semanage_port_get_proto(port) ==
+			  semanage_port_get_proto(port_exp));
+
+	con = semanage_port_get_con(port);
+	con_exp = semanage_port_get_con(port_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	/* cleanup */
+	delete_local_port(I_FIRST);
+	semanage_port_free(port);
+	semanage_port_free(port_exp);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_port_exists_local */
+void test_port_exists_local(void)
+{
+	semanage_port_key_t *key1 = NULL;
+	semanage_port_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+	key1 = get_port_key_nth(I_FIRST);
+	key2 = get_port_key_nth(I_SECOND);
+
+	/* test */
+	CU_ASSERT(semanage_port_exists_local(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_port_exists_local(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	delete_local_port(I_FIRST);
+	semanage_port_key_free(key1);
+	semanage_port_key_free(key2);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_port_count_local */
+void test_port_count_local(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+
+	/* test */
+	CU_ASSERT(semanage_port_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	add_local_port(I_FIRST);
+	CU_ASSERT(semanage_port_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	add_local_port(I_SECOND);
+	CU_ASSERT(semanage_port_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 2);
+
+	delete_local_port(I_SECOND);
+	CU_ASSERT(semanage_port_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	delete_local_port(I_FIRST);
+	CU_ASSERT(semanage_port_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_port_iterate_local */
+unsigned int counter_port_iterate_local = 0;
+
+int handler_port_iterate_local(const semanage_port_t *record, void *varg)
+{
+	counter_port_iterate_local++;
+	return 0;
+}
+
+void test_port_iterate_local(void)
+{
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+	add_local_port(I_SECOND);
+	add_local_port(I_THIRD);
+
+	/* test */
+	semanage_port_iterate_local(sh, handler_port_iterate_local, NULL);
+	CU_ASSERT(counter_port_iterate_local == 3);
+
+	/* cleanup */
+	delete_local_port(I_FIRST);
+	delete_local_port(I_SECOND);
+	delete_local_port(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_port_list_local */
+void test_port_list_local(void)
+{
+	semanage_port_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+	add_local_port(I_SECOND);
+	add_local_port(I_THIRD);
+
+	/* test */
+	CU_ASSERT(semanage_port_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == 3);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_port_free(records[i]);
+
+	delete_local_port(I_FIRST);
+	delete_local_port(I_SECOND);
+	delete_local_port(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Internal function semanage_port_validate_local */
+void helper_port_validate_local_noport(void)
+{
+	semanage_port_key_t *key = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+	helper_commit();
+	key = get_port_key_nth(I_FIRST);
+	CU_ASSERT(semanage_port_exists_local(sh, key, &resp) >= 0);
+	CU_ASSERT(resp);
+
+	/* test */
+	helper_begin_transaction();
+	delete_local_port(I_FIRST);
+	helper_commit();
+
+	/* cleanup */
+	helper_begin_transaction();
+	delete_local_port(I_FIRST);
+	cleanup_handle(SH_TRANS);
+}
+
+void helper_port_validate_local_oneport(void)
+{
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_port(I_FIRST);
+
+	/* test */
+	helper_commit();
+
+	/* cleanup */
+	helper_begin_transaction();
+	delete_local_port(I_FIRST);
+	cleanup_handle(SH_TRANS);
+}
+
+void helper_port_validate_local_twoports(void)
+{
+	semanage_port_key_t *key1 = NULL;
+	semanage_port_key_t *key2 = NULL;
+	semanage_port_t *port1 = NULL;
+	semanage_port_t *port2 = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	CU_ASSERT(semanage_port_key_create(sh, 101, 200, 0, &key1) >= 0);
+	CU_ASSERT(semanage_port_key_create(sh, 201, 300, 0, &key2) >= 0);
+	CU_ASSERT(semanage_port_create(sh, &port1) >= 0);
+	CU_ASSERT(semanage_port_create(sh, &port2) >= 0);
+
+	semanage_port_set_range(port1, 101, 200);
+	semanage_port_set_range(port2, 201, 300);
+	semanage_port_set_proto(port1, 0);
+	semanage_port_set_proto(port2, 0);
+
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "system_u:object_r:user_home_t:s0", &con1) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh,
+				"system_u:object_r:user_tmp_t:s0", &con2) >= 0);
+
+	semanage_port_set_con(sh, port1, con1);
+	semanage_port_set_con(sh, port2, con2);
+
+	CU_ASSERT(semanage_port_modify_local(sh, key1, port1) >= 0);
+	CU_ASSERT(semanage_port_modify_local(sh, key2, port2) >= 0);
+
+	/* test */
+	helper_commit();
+
+	/* cleanup */
+	helper_begin_transaction();
+	CU_ASSERT(semanage_port_del_local(sh, key1) >= 0);
+	CU_ASSERT(semanage_port_del_local(sh, key2) >= 0);
+	semanage_port_key_free(key1);
+	semanage_port_key_free(key2);
+	semanage_port_free(port1);
+	semanage_port_free(port2);
+	cleanup_handle(SH_TRANS);
+}
+
+void helper_port_validate_local_proto(void)
+{
+	semanage_port_key_t *key1 = NULL;
+	semanage_port_key_t *key2 = NULL;
+	semanage_port_key_t *key3 = NULL;
+	semanage_port_t *port1 = NULL;
+	semanage_port_t *port2 = NULL;
+	semanage_port_t *port3 = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+	semanage_context_t *con3 = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+
+	CU_ASSERT(semanage_port_key_create(sh, 101, 200, 0, &key1) >= 0);
+	CU_ASSERT(semanage_port_key_create(sh,  51, 250, 1, &key2) >= 0);
+	CU_ASSERT(semanage_port_key_create(sh, 201, 300, 0, &key3) >= 0);
+
+	CU_ASSERT(semanage_port_create(sh, &port1) >= 0);
+	CU_ASSERT(semanage_port_create(sh, &port2) >= 0);
+	CU_ASSERT(semanage_port_create(sh, &port3) >= 0);
+
+	semanage_port_set_range(port1, 101, 200);
+	semanage_port_set_range(port2,  51, 250);
+	semanage_port_set_range(port3, 201, 300);
+
+	semanage_port_set_proto(port1, 0);
+	semanage_port_set_proto(port2, 0);
+	semanage_port_set_proto(port3, 0);
+
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "system_u:object_r:user_home_t:s0", &con1) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "system_u:object_r:user_home_t:s0", &con2) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh,
+				"system_u:object_r:user_tmp_t:s0", &con3) >= 0);
+
+	semanage_port_set_con(sh, port1, con1);
+	semanage_port_set_con(sh, port2, con2);
+	semanage_port_set_con(sh, port3, con3);
+
+	CU_ASSERT(semanage_port_modify_local(sh, key1, port1) >= 0);
+	CU_ASSERT(semanage_port_modify_local(sh, key2, port2) >= 0);
+	CU_ASSERT(semanage_port_modify_local(sh, key3, port3) >= 0);
+
+	/* test */
+	helper_commit();
+
+	/* cleanup */
+	CU_ASSERT(semanage_port_del_local(sh, key1) >= 0);
+	CU_ASSERT(semanage_port_del_local(sh, key2) >= 0);
+	CU_ASSERT(semanage_port_del_local(sh, key3) >= 0);
+	semanage_port_key_free(key1);
+	semanage_port_key_free(key2);
+	semanage_port_key_free(key3);
+	semanage_port_free(port1);
+	semanage_port_free(port2);
+	semanage_port_free(port3);
+	cleanup_handle(SH_TRANS);
+}
+
+void test_port_validate_local(void)
+{
+	helper_port_validate_local_noport();
+	helper_port_validate_local_oneport();
+	helper_port_validate_local_twoports();
+}
diff --git a/libsemanage/tests/test_port.cil b/libsemanage/tests/test_port.cil
new file mode 100644
index 00000000..7e07a61c
--- /dev/null
+++ b/libsemanage/tests/test_port.cil
@@ -0,0 +1,27 @@
+(typeattribute cil_gen_require)
+(roleattribute cil_gen_require)
+(handleunknown allow)
+(mls true)
+(policycap open_perms)
+(sid security)
+(sidorder (security))
+(sensitivity s0)
+(sensitivityorder (s0))
+(user system_u)
+(userrole system_u object_r)
+(userlevel system_u (s0))
+(userrange system_u ((s0) (s0)))
+(role object_r)
+(roletype object_r first_port_t)
+(roletype object_r second_port_t)
+(roletype object_r third_port_t)
+(type first_port_t)
+(type second_port_t)
+(type third_port_t)
+(sidcontext security (system_u object_r first_port_t ((s0) (s0))))
+(class file (open))
+(classorder (file))
+(allow first_port_t self (file (open)))
+(portcon tcp 80 (system_u object_r first_port_t ((s0) (s0))))
+(portcon udp (1 1023) (system_u object_r second_port_t ((s0) (s0))))
+(portcon tcp 12345 (system_u object_r third_port_t ((s0) (s0))))
diff --git a/libsemanage/tests/test_port.h b/libsemanage/tests/test_port.h
new file mode 100644
index 00000000..ad26f90b
--- /dev/null
+++ b/libsemanage/tests/test_port.h
@@ -0,0 +1,30 @@
+/*
+ * Authors: Jan Zarsky <jzarsky@redhat.com>
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_PORT_H__
+#define __TEST_PORT_H__
+
+#include <CUnit/Basic.h>
+
+int port_test_init(void);
+int port_test_cleanup(void);
+int port_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

