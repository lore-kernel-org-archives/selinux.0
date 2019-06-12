Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894ADC31E4A
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6537920684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436771AbfFLIEr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436774AbfFLIEq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B9EDC04B2F6
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0021578386
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:45 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/11] libsemanage: test semanage_node_* functions
Date:   Wed, 12 Jun 2019 10:04:00 +0200
Message-Id: <20190612080404.4529-8-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Jun 2019 08:04:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_node_* functions. The test suite aims for line
coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_node.c         | 807 ++++++++++++++++++++++++++
 libsemanage/tests/test_node.cil       |  28 +
 libsemanage/tests/test_node.h         |  30 +
 4 files changed, 867 insertions(+)
 create mode 100644 libsemanage/tests/test_node.c
 create mode 100644 libsemanage/tests/test_node.cil
 create mode 100644 libsemanage/tests/test_node.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index d395a9fd..ba24421d 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -26,6 +26,7 @@
 #include "test_fcontext.h"
 #include "test_iface.h"
 #include "test_ibendport.h"
+#include "test_node.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -69,6 +70,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(fcontext);
 	DECLARE_SUITE(iface);
 	DECLARE_SUITE(ibendport);
+	DECLARE_SUITE(node);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_node.c b/libsemanage/tests/test_node.c
new file mode 100644
index 00000000..53c2eb69
--- /dev/null
+++ b/libsemanage/tests/test_node.c
@@ -0,0 +1,807 @@
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
+#include "test_node.h"
+
+#define NODE_COUNT 3
+
+#define NODE1_ADDR "192.168.0.0"
+#define NODE1_MASK "255.255.255.0"
+#define NODE1_PROTO SEPOL_PROTO_IP4
+#define NODE1_CONTEXT "system_u:object_r:first_node_t:s0"
+
+#define NODE2_ADDR "2001:db8:85a3::8a2e:370:7334"
+#define NODE2_MASK "2001:db8:85a3::8a2e:370:7334"
+#define NODE2_PROTO SEPOL_PROTO_IP6
+#define NODE2_CONTEXT "system_u:object_r:second_node_t:s0"
+
+#define NODE3_ADDR "127.0.0.1"
+#define NODE3_MASK "255.255.0.0"
+#define NODE3_PROTO SEPOL_PROTO_IP4
+#define NODE3_CONTEXT "system_u:object_r:third_node_t:s0"
+
+/* node_record.h */
+void test_node_compare(void);
+void test_node_compare2(void);
+void test_node_key_create(void);
+void test_node_key_extract(void);
+void test_node_get_set_addr(void);
+void test_node_get_set_addr_bytes(void);
+void test_node_get_set_mask(void);
+void test_node_get_set_mask_bytes(void);
+void test_node_get_set_proto(void);
+void test_node_get_proto_str(void);
+void test_node_get_set_con(void);
+void test_node_create(void);
+void test_node_clone(void);
+
+/* nodes_policy.h */
+void test_node_query(void);
+void test_node_exists(void);
+void test_node_count(void);
+void test_node_iterate(void);
+void test_node_list(void);
+
+/* nodes_local.h */
+void test_node_modify_del_query_local(void);
+void test_node_exists_local(void);
+void test_node_count_local(void);
+void test_node_iterate_local(void);
+void test_node_list_local(void);
+
+extern semanage_handle_t *sh;
+
+int node_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_node.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int node_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int node_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "node_compare", test_node_compare);
+	CU_add_test(suite, "node_compare2", test_node_compare2);
+	CU_add_test(suite, "node_key_create", test_node_key_create);
+	CU_add_test(suite, "node_key_extract", test_node_key_extract);
+	CU_add_test(suite, "node_get_set_addr", test_node_get_set_addr);
+	CU_add_test(suite, "node_get_set_addr_bytes",
+		    test_node_get_set_addr_bytes);
+	CU_add_test(suite, "node_get_set_mask", test_node_get_set_mask);
+	CU_add_test(suite, "node_get_set_mask_bytes",
+		    test_node_get_set_mask_bytes);
+	CU_add_test(suite, "node_get_set_proto", test_node_get_set_proto);
+	CU_add_test(suite, "node_get_proto_str", test_node_get_proto_str);
+	CU_add_test(suite, "node_get_set_con", test_node_get_set_con);
+	CU_add_test(suite, "node_create", test_node_create);
+	CU_add_test(suite, "node_clone", test_node_clone);
+
+	CU_add_test(suite, "node_query", test_node_query);
+	CU_add_test(suite, "node_exists", test_node_exists);
+	CU_add_test(suite, "node_count", test_node_count);
+	CU_add_test(suite, "node_iterate", test_node_iterate);
+	CU_add_test(suite, "node_list", test_node_list);
+
+	CU_add_test(suite, "node_modify_del_query_local",
+		    test_node_modify_del_query_local);
+	CU_add_test(suite, "node_exists_local", test_node_exists_local);
+	CU_add_test(suite, "node_count_local", test_node_count_local);
+	CU_add_test(suite, "node_iterate_local", test_node_iterate_local);
+	CU_add_test(suite, "node_list_local", test_node_list_local);
+
+	return 0;
+}
+
+/* Helpers */
+
+semanage_node_t *get_node_nth(int idx)
+{
+	semanage_node_t **records;
+	semanage_node_t *node;
+	unsigned int count;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	CU_ASSERT_FATAL(semanage_node_list(sh, &records, &count) >= 0);
+	CU_ASSERT_FATAL(count >= (unsigned int) idx + 1);
+
+	node = records[idx];
+
+	for (unsigned int i = 0; i < count; i++)
+		if (i != (unsigned int) idx)
+			semanage_node_free(records[i]);
+
+	return node;
+}
+
+semanage_node_key_t *get_node_key_nth(int idx)
+{
+	semanage_node_key_t *key;
+	semanage_node_t *node;
+	int res;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	node = get_node_nth(idx);
+
+	res = semanage_node_key_extract(sh, node, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+void add_local_node(int idx)
+{
+	semanage_node_t *node;
+	semanage_node_key_t *key = NULL;
+
+	node = get_node_nth(idx);
+
+	CU_ASSERT_FATAL(semanage_node_key_extract(sh, node, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_node_modify_local(sh, key, node) >= 0);
+}
+
+void delete_local_node(int idx)
+{
+	semanage_node_key_t *key = NULL;
+
+	key = get_node_key_nth(idx);
+
+	CU_ASSERT_FATAL(semanage_node_del_local(sh, key) >= 0);
+}
+
+/* Function semanage_node_compare */
+void test_node_compare(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_node_key_t *key1 = NULL;
+	semanage_node_key_t *key2 = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	node = get_node_nth(I_FIRST);
+	key1 = get_node_key_nth(I_FIRST);
+	CU_ASSERT(semanage_node_key_create(sh, "192.168.0.1", "255.255.0.0",
+					   SEMANAGE_PROTO_IP4, &key2) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key2);
+
+	/* test */
+	res = semanage_node_compare(node, key1);
+	CU_ASSERT(res == 0);
+	res = semanage_node_compare(node, key2);
+	CU_ASSERT(res != 0);
+
+	/* cleanup */
+	semanage_node_free(node);
+	semanage_node_key_free(key1);
+	semanage_node_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_compare2 */
+void test_node_compare2(void)
+{
+	semanage_node_t *node1 = NULL;
+	semanage_node_t *node2 = NULL;
+	semanage_node_t *node3 = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	node1 = get_node_nth(I_FIRST);
+	node2 = get_node_nth(I_FIRST);
+	node3 = get_node_nth(I_SECOND);
+
+	/* test */
+	res = semanage_node_compare2(node1, node2);
+	CU_ASSERT(res == 0);
+	res = semanage_node_compare2(node1, node3);
+	CU_ASSERT(res != 0);
+
+	/* cleanup */
+	semanage_node_free(node1);
+	semanage_node_free(node2);
+	semanage_node_free(node3);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_key_create */
+void test_node_key_create(void)
+{
+	semanage_node_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_node_key_create(sh, "127.0.0.1", "255.255.255.255",
+					   SEMANAGE_PROTO_IP4, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_node_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_key_extract */
+void test_node_key_extract(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_node_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	node = get_node_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_node_key_extract(sh, node, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_node_free(node);
+	semanage_node_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_addr, semanage_node_set_addr */
+void test_node_get_set_addr(void)
+{
+	semanage_node_t *node = NULL;
+	char *addr = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_set_addr(sh, node, SEMANAGE_PROTO_IP4,
+					 "192.168.0.1") == 0);
+	CU_ASSERT(semanage_node_get_addr(sh, node, &addr) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(addr);
+	assert(addr);
+	CU_ASSERT_STRING_EQUAL(addr, "192.168.0.1");
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_addr_bytes, semanage_node_set_addr_bytes */
+void test_node_get_set_addr_bytes(void)
+{
+	semanage_node_t *node = NULL;
+	char addr1[] = { 192, 168, 0, 1 };
+	size_t addr1_size = sizeof(addr1);
+	char *addr2 = NULL;
+	size_t addr2_size = 0;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_set_addr_bytes(sh, node, addr1,
+					       addr1_size) == 0);
+	CU_ASSERT(semanage_node_get_addr_bytes(sh, node, &addr2,
+					       &addr2_size) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(addr2);
+	assert(addr2);
+
+	for (size_t i = 0; i < addr2_size; i++)
+		CU_ASSERT(addr1[i] == addr2[i]);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_mask, semanage_node_set_mask */
+void test_node_get_set_mask(void)
+{
+	semanage_node_t *node = NULL;
+	char *mask = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_set_mask(sh, node, SEMANAGE_PROTO_IP4,
+					 "255.255.255.0") == 0);
+	CU_ASSERT(semanage_node_get_mask(sh, node, &mask) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(mask);
+	assert(mask);
+	CU_ASSERT_STRING_EQUAL(mask, "255.255.255.0");
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_mask_bytes, semanage_node_set_mask_bytes */
+void test_node_get_set_mask_bytes(void)
+{
+	semanage_node_t *node = NULL;
+	char mask1[] = { 255, 255, 255, 0 };
+	size_t mask1_size = sizeof(mask1);
+	char *mask2 = NULL;
+	size_t mask2_size = 0;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_set_mask_bytes(sh, node, mask1,
+					       mask1_size) == 0);
+	CU_ASSERT(semanage_node_get_mask_bytes(sh, node, &mask2,
+					       &mask2_size) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(mask2);
+	assert(mask2);
+
+	for (size_t i = 0; i < mask2_size; i++)
+		CU_ASSERT(mask1[i] == mask2[i]);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_proto, semanage_node_set_proto */
+void test_node_get_set_proto(void)
+{
+	semanage_node_t *node = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+
+	/* test */
+	semanage_node_set_proto(node, SEMANAGE_PROTO_IP4);
+	CU_ASSERT(semanage_node_get_proto(node) == SEMANAGE_PROTO_IP4);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_get_proto_str */
+void test_node_get_proto_str(void)
+{
+	CU_ASSERT_STRING_EQUAL(semanage_node_get_proto_str(SEMANAGE_PROTO_IP4),
+							   "ipv4");
+	CU_ASSERT_STRING_EQUAL(semanage_node_get_proto_str(SEMANAGE_PROTO_IP6),
+							   "ipv6");
+}
+
+/* Function semanage_node_get_con, semanage_node_set_con */
+void test_node_get_set_con(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "my_user_u:my_role_r:my_type_t:s0", &con1) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_set_con(sh, node, con1) == 0);
+	con2 = semanage_node_get_con(node);
+	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_create */
+void test_node_create(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_context_t *con = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+	CU_ASSERT(semanage_node_set_addr(sh, node, SEMANAGE_PROTO_IP4,
+					 "127.0.0.1") >= 0);
+	CU_ASSERT(semanage_node_set_mask(sh, node, SEMANAGE_PROTO_IP4,
+					 "255.255.255.0") >= 0);
+	semanage_node_set_proto(node, SEMANAGE_PROTO_IP4);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:type_t:s0",
+					       &con) >= 0);
+	CU_ASSERT(semanage_node_set_con(sh, node, con) >= 0);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_clone */
+void test_node_clone(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_node_t *node_clone = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con2 = NULL;
+	const char *addr1 = "127.0.0.1";
+	char *addr2 = NULL;
+	const char *mask1 = "255.255.255.0";
+	char *mask2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_node_create(sh, &node) >= 0);
+	CU_ASSERT(semanage_node_set_addr(sh, node, SEMANAGE_PROTO_IP4,
+					 addr1) >= 0);
+	CU_ASSERT(semanage_node_set_mask(sh, node, SEMANAGE_PROTO_IP4,
+					 mask1) >= 0);
+	semanage_node_set_proto(node, SEMANAGE_PROTO_IP4);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:type_t:s0",
+					       &con) >= 0);
+	CU_ASSERT(semanage_node_set_con(sh, node, con) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_clone(sh, node, &node_clone) >= 0);
+
+	CU_ASSERT(semanage_node_get_addr(sh, node_clone, &addr2) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(addr2);
+	assert(addr2);
+	CU_ASSERT_STRING_EQUAL(addr1, addr2);
+
+	CU_ASSERT(semanage_node_get_mask(sh, node_clone, &mask2) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(mask2);
+	assert(mask2);
+	CU_ASSERT_STRING_EQUAL(mask1, mask2);
+
+	CU_ASSERT(semanage_node_get_proto(node_clone) == SEMANAGE_PROTO_IP4);
+
+	con2 = semanage_node_get_con(node_clone);
+	CU_ASSERT_CONTEXT_EQUAL(con, con2);
+
+	/* cleanup */
+	semanage_node_free(node);
+	semanage_node_free(node_clone);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_query */
+void test_node_query(void)
+{
+	semanage_node_t *node = NULL;
+	semanage_node_t *node_exp = NULL;
+	semanage_node_key_t *key = NULL;
+	char *str = NULL;
+	char *str_exp = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_exp = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key = get_node_key_nth(I_FIRST);
+	node_exp = get_node_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_node_query(sh, key, &node) >= 0);
+
+	CU_ASSERT(semanage_node_get_addr(sh, node, &str) >= 0);
+	CU_ASSERT(semanage_node_get_addr(sh, node_exp, &str_exp) >= 0);
+	CU_ASSERT_STRING_EQUAL(str, str_exp);
+	free(str);
+	free(str_exp);
+
+	CU_ASSERT(semanage_node_get_mask(sh, node, &str) >= 0);
+	CU_ASSERT(semanage_node_get_mask(sh, node_exp, &str_exp) >= 0);
+	CU_ASSERT_STRING_EQUAL(str, str_exp);
+	free(str);
+	free(str_exp);
+
+	CU_ASSERT(semanage_node_get_proto(node) ==
+			  semanage_node_get_proto(node_exp));
+
+	con = semanage_node_get_con(node);
+	con_exp = semanage_node_get_con(node_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	/* cleanup */
+	semanage_node_free(node);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_exists */
+void test_node_exists(void)
+{
+	semanage_node_key_t *key1 = NULL;
+	semanage_node_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key1 = get_node_key_nth(I_FIRST);
+	CU_ASSERT(semanage_node_key_create(sh, "1.2.3.4", "255.255.0.0",
+					   SEMANAGE_PROTO_IP4, &key2) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_node_exists(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_node_exists(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	semanage_node_key_free(key1);
+	semanage_node_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_count */
+void test_node_count(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_node_count(sh, &count) >= 0);
+	CU_ASSERT(count == NODE_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_iterate */
+unsigned int counter_node_iterate = 0;
+
+int handler_node_iterate(const semanage_node_t *record, void *varg)
+{
+	counter_node_iterate++;
+	return 0;
+}
+
+void test_node_iterate(void)
+{
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	semanage_node_iterate(sh, handler_node_iterate, NULL);
+	CU_ASSERT(counter_node_iterate == NODE_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_list */
+void test_node_list(void)
+{
+	semanage_node_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_node_list(sh, &records, &count) >= 0);
+	CU_ASSERT(count == NODE_COUNT);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	for (unsigned int i = 0; i < count; i++)
+		semanage_node_free(records[i]);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_node_modify_local, semanage_node_del_local,
+ * semanage_node_query_local
+ */
+void test_node_modify_del_query_local(void)
+{
+	semanage_node_t *node;
+	semanage_node_t *node_local;
+	semanage_node_t *node_tmp;
+	semanage_node_key_t *key = NULL;
+	semanage_node_key_t *key_tmp = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	node = get_node_nth(I_FIRST);
+	CU_ASSERT(semanage_node_key_extract(sh, node, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* add second record, so that semanage_node_compare2_qsort
+	 * will be called
+	 */
+	node_tmp = get_node_nth(I_FIRST);
+
+	CU_ASSERT(semanage_node_set_addr(sh, node_tmp, SEMANAGE_PROTO_IP4,
+					 "10.0.0.1") >= 0);
+	CU_ASSERT(semanage_node_key_extract(sh, node_tmp, &key_tmp) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key_tmp);
+
+	/* test */
+	CU_ASSERT(semanage_node_modify_local(sh, key, node) >= 0);
+	CU_ASSERT(semanage_node_modify_local(sh, key_tmp, node_tmp) >= 0);
+
+	/* write changes to file */
+	helper_commit();
+	helper_begin_transaction();
+
+	CU_ASSERT(semanage_node_query_local(sh, key, &node_local) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(node_local);
+
+	CU_ASSERT(semanage_node_del_local(sh, key) >= 0);
+	CU_ASSERT(semanage_node_del_local(sh, key_tmp) >= 0);
+
+	CU_ASSERT(semanage_node_query_local(sh, key, &node_local) < 0);
+
+	/* cleanup */
+	semanage_node_free(node);
+	semanage_node_free(node_tmp);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_node_exists_local */
+void test_node_exists_local(void)
+{
+	semanage_node_key_t *key1 = NULL;
+	semanage_node_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_node(I_FIRST);
+	key1 = get_node_key_nth(I_FIRST);
+	key2 = get_node_key_nth(I_SECOND);
+
+	/* test */
+	CU_ASSERT(semanage_node_exists_local(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_node_exists_local(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	CU_ASSERT(semanage_node_del_local(sh, key1) >= 0);
+	semanage_node_key_free(key1);
+	semanage_node_key_free(key2);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_node_count_local */
+void test_node_count_local(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+
+	/* test */
+	CU_ASSERT(semanage_node_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	add_local_node(I_FIRST);
+	CU_ASSERT(semanage_node_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	add_local_node(I_SECOND);
+	CU_ASSERT(semanage_node_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 2);
+
+	delete_local_node(I_SECOND);
+	CU_ASSERT(semanage_node_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	delete_local_node(I_FIRST);
+	CU_ASSERT(semanage_node_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_node_iterate_local */
+unsigned int counter_node_iterate_local = 0;
+
+int handler_node_iterate_local(const semanage_node_t *record, void *varg)
+{
+	counter_node_iterate_local++;
+	return 0;
+}
+
+void test_node_iterate_local(void)
+{
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_node(I_FIRST);
+	add_local_node(I_SECOND);
+	add_local_node(I_THIRD);
+
+	/* test */
+	semanage_node_iterate_local(sh, handler_node_iterate_local, NULL);
+	CU_ASSERT(counter_node_iterate_local == 3);
+
+	/* cleanup */
+	delete_local_node(I_FIRST);
+	delete_local_node(I_SECOND);
+	delete_local_node(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_node_list_local */
+void test_node_list_local(void)
+{
+	semanage_node_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_node(I_FIRST);
+	add_local_node(I_SECOND);
+	add_local_node(I_THIRD);
+
+	/* test */
+	CU_ASSERT(semanage_node_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == 3);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_node_free(records[i]);
+
+	delete_local_node(I_FIRST);
+	delete_local_node(I_SECOND);
+	delete_local_node(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
diff --git a/libsemanage/tests/test_node.cil b/libsemanage/tests/test_node.cil
new file mode 100644
index 00000000..1638cd1e
--- /dev/null
+++ b/libsemanage/tests/test_node.cil
@@ -0,0 +1,28 @@
+(typeattribute cil_gen_require)
+(roleattribute cil_gen_require)
+(handleunknown allow)
+(mls true)
+(policycap network_peer_controls)
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
+(roletype object_r first_node_t)
+(roletype object_r second_node_t)
+(roletype object_r third_node_t)
+(type first_node_t)
+(type second_node_t)
+(type third_node_t)
+(sidcontext security (system_u object_r first_node_t ((s0) (s0))))
+(class node (tcp_recv))
+(classorder (node))
+(allow first_node_t self (node (tcp_recv)))
+(nodecon (192.168.0.0) (255.255.255.0) (system_u object_r first_node_t ((s0) (s0))))
+(nodecon (2001:db8:85a3::8a2e:370:7334) (2001:db8:85a3::8a2e:370:7334) (system_u object_r second_node_t ((s0) (s0))))
+(nodecon (127.0.0.1) (255.255.0.0) (system_u object_r third_node_t ((s0) (s0))))
diff --git a/libsemanage/tests/test_node.h b/libsemanage/tests/test_node.h
new file mode 100644
index 00000000..5b329406
--- /dev/null
+++ b/libsemanage/tests/test_node.h
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
+#ifndef __TEST_NODE_H__
+#define __TEST_NODE_H__
+
+#include <CUnit/Basic.h>
+
+int node_test_init(void);
+int node_test_cleanup(void);
+int node_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

