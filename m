Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF5C31E49
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AE020684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436777AbfFLIEp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31291 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436774AbfFLIEp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DED6330C31A5
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6414F78386
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:44 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/11] libsemanage: test semanage_iface_* functions
Date:   Wed, 12 Jun 2019 10:03:58 +0200
Message-Id: <20190612080404.4529-6-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 08:04:44 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_iface_* functions. The test suite aims for line
coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_iface.c        | 666 ++++++++++++++++++++++++++
 libsemanage/tests/test_iface.cil      |  28 ++
 libsemanage/tests/test_iface.h        |  30 ++
 4 files changed, 726 insertions(+)
 create mode 100644 libsemanage/tests/test_iface.c
 create mode 100644 libsemanage/tests/test_iface.cil
 create mode 100644 libsemanage/tests/test_iface.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index c5f42b9e..e590f7bd 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -24,6 +24,7 @@
 #include "test_handle.h"
 #include "test_bool.h"
 #include "test_fcontext.h"
+#include "test_iface.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -65,6 +66,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(handle);
 	DECLARE_SUITE(bool);
 	DECLARE_SUITE(fcontext);
+	DECLARE_SUITE(iface);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_iface.c
new file mode 100644
index 00000000..d5d530a8
--- /dev/null
+++ b/libsemanage/tests/test_iface.c
@@ -0,0 +1,666 @@
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
+#include "test_iface.h"
+
+#define IFACE_COUNT 3
+
+#define IFACE1_NAME "eth0"
+#define IFACE1_IFCON "system_u:object_r:first_netif_t:s0"
+#define IFACE1_MSGCON IFACE1_IFCON
+
+#define IFACE2_NAME "eth1"
+#define IFACE2_IFCON "system_u:object_r:second_netif_t:s0"
+#define IFACE2_MSGCON IFACE2_IFCON
+
+#define IFACE3_NAME "eth2"
+#define IFACE3_IFCON "system_u:object_r:third_netif_t:s0"
+#define IFACE3_MSGCON IFACE3_IFCON
+
+
+/* iface_record.h */
+void test_iface_compare(void);
+void test_iface_compare2(void);
+void test_iface_key_create(void);
+void test_iface_key_extract(void);
+void test_iface_get_set_name(void);
+void test_iface_get_set_ifcon(void);
+void test_iface_get_set_msgcon(void);
+void test_iface_create(void);
+void test_iface_clone(void);
+
+/* iterfaces_policy.h */
+void test_iface_query(void);
+void test_iface_exists(void);
+void test_iface_count(void);
+void test_iface_iterate(void);
+void test_iface_list(void);
+
+/* interfaces_local.h */
+void test_iface_modify_del_query_local(void);
+void test_iface_exists_local(void);
+void test_iface_count_local(void);
+void test_iface_iterate_local(void);
+void test_iface_list_local(void);
+
+extern semanage_handle_t *sh;
+
+int iface_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_iface.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int iface_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could not destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int iface_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "iface_compare", test_iface_compare);
+	CU_add_test(suite, "iface_compare2", test_iface_compare2);
+	CU_add_test(suite, "iface_key_create", test_iface_key_create);
+	CU_add_test(suite, "iface_key_extract", test_iface_key_extract);
+	CU_add_test(suite, "iface_get_set_name", test_iface_get_set_name);
+	CU_add_test(suite, "iface_get_set_ifcon", test_iface_get_set_ifcon);
+	CU_add_test(suite, "iface_get_set_msgcon", test_iface_get_set_msgcon);
+	CU_add_test(suite, "iface_create)", test_iface_create);
+	CU_add_test(suite, "iface_clone);", test_iface_clone);
+
+	CU_add_test(suite, "iface_query", test_iface_query);
+	CU_add_test(suite, "iface_exists", test_iface_exists);
+	CU_add_test(suite, "iface_count", test_iface_count);
+	CU_add_test(suite, "iface_iterate", test_iface_iterate);
+	CU_add_test(suite, "iface_list", test_iface_list);
+
+	CU_add_test(suite, "iface_modify_del_query_local",
+				test_iface_modify_del_query_local);
+	CU_add_test(suite, "iface_exists_local", test_iface_exists_local);
+	CU_add_test(suite, "iface_count_local", test_iface_count_local);
+	CU_add_test(suite, "iface_iterate_local", test_iface_iterate_local);
+	CU_add_test(suite, "iface_list_local", test_iface_list_local);
+
+	return 0;
+}
+
+/* Helpers */
+
+semanage_iface_t *get_iface_nth(int idx)
+{
+	int res;
+	semanage_iface_t **records;
+	semanage_iface_t *iface;
+	unsigned int count;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	res = semanage_iface_list(sh, &records, &count);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_FATAL(count >= (unsigned int) idx + 1);
+
+	iface = records[idx];
+
+	for (unsigned int i = 0; i < count; i++)
+		if (i != (unsigned int) idx)
+			semanage_iface_free(records[i]);
+
+	return iface;
+}
+
+semanage_iface_key_t *get_iface_key_nth(int idx)
+{
+	semanage_iface_key_t *key;
+	semanage_iface_t *iface;
+	int res;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	iface = get_iface_nth(idx);
+	res = semanage_iface_key_extract(sh, iface, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+void add_local_iface(int idx)
+{
+	semanage_iface_t *iface;
+	semanage_iface_key_t *key = NULL;
+
+	iface = get_iface_nth(idx);
+
+	CU_ASSERT_FATAL(semanage_iface_key_extract(sh, iface, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_iface_modify_local(sh, key, iface) >= 0);
+}
+
+void delete_local_iface(int idx)
+{
+	semanage_iface_key_t *key = NULL;
+	key = get_iface_key_nth(idx);
+	CU_ASSERT_FATAL(semanage_iface_del_local(sh, key) >= 0);
+}
+
+/* Function semanage_iface_compare */
+void test_iface_compare(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_iface_key_t *key1 = NULL;
+	semanage_iface_key_t *key2 = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface = get_iface_nth(I_FIRST);
+	key1 = get_iface_key_nth(I_FIRST);
+	CU_ASSERT(semanage_iface_key_create(sh, "qwerty", &key2) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key2);
+
+	/* test */
+	res = semanage_iface_compare(iface, key1);
+	CU_ASSERT(res == 0);
+	res = semanage_iface_compare(iface, key2);
+	CU_ASSERT(res != 0);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	semanage_iface_key_free(key1);
+	semanage_iface_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_compare2 */
+void test_iface_compare2(void)
+{
+	semanage_iface_t *iface1 = NULL;
+	semanage_iface_t *iface2 = NULL;
+	semanage_iface_t *iface3 = NULL;
+	int res = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface1 = get_iface_nth(I_FIRST);
+	iface2 = get_iface_nth(I_FIRST);
+	iface3 = get_iface_nth(I_SECOND);
+
+	/* test */
+	res = semanage_iface_compare2(iface1, iface2);
+	CU_ASSERT(res == 0);
+	res = semanage_iface_compare2(iface1, iface3);
+	CU_ASSERT(res != 0);
+
+	/* cleanup */
+	semanage_iface_free(iface1);
+	semanage_iface_free(iface2);
+	semanage_iface_free(iface3);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_create */
+void test_iface_key_create(void)
+{
+	semanage_iface_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_iface_key_create(sh, "asdf", &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_iface_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_extract */
+void test_iface_key_extract(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_iface_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface = get_iface_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_iface_key_extract(sh, iface, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	semanage_iface_key_free(key);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_get_name, semanage_iface_set_name */
+void test_iface_get_set_name(void)
+{
+	semanage_iface_t *iface = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface = get_iface_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_iface_set_name(sh, iface, "my_asdf") == 0);
+	CU_ASSERT_STRING_EQUAL(semanage_iface_get_name(iface), "my_asdf");
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_get_ifcon, semanage_iface_set_ifcon */
+void test_iface_get_set_ifcon(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface = get_iface_nth(I_FIRST);
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "my_user_u:my_role_r:my_type_t:s0", &con1) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_iface_set_ifcon(sh, iface, con1) == 0);
+	con2 = semanage_iface_get_ifcon(iface);
+	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_get_msgcon, semanage_iface_set_msgcon */
+void test_iface_get_set_msgcon(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_context_t *con1 = NULL;
+	semanage_context_t *con2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	iface = get_iface_nth(I_FIRST);
+	CU_ASSERT(semanage_context_from_string(sh,
+			       "my_user_u:my_role_r:my_type_t:s0", &con1) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_iface_set_msgcon(sh, iface, con1) == 0);
+	con2 = semanage_iface_get_msgcon(iface);
+	CU_ASSERT_CONTEXT_EQUAL(con1, con2);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_create */
+void test_iface_create(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_context_t *ifcon = NULL;
+	semanage_context_t *msgcon = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_iface_create(sh, &iface) >= 0);
+	CU_ASSERT(semanage_iface_set_name(sh, iface, "asdf") >= 0);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:type_t:s0",
+					       &ifcon) >= 0);
+	CU_ASSERT(semanage_iface_set_ifcon(sh, iface, ifcon) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:type_t:s0",
+					       &msgcon) >= 0);
+	CU_ASSERT(semanage_iface_set_msgcon(sh, iface, msgcon) >= 0);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_clone */
+void test_iface_clone(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_iface_t *iface_clone = NULL;
+	semanage_context_t *ifcon = NULL;
+	semanage_context_t *ifcon2 = NULL;
+	semanage_context_t *msgcon = NULL;
+	semanage_context_t *msgcon2 = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_iface_create(sh, &iface) >= 0);
+	CU_ASSERT(semanage_iface_set_name(sh, iface, "asdf") >= 0);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:if_type_t:s0",
+					       &ifcon) >= 0);
+	CU_ASSERT(semanage_iface_set_ifcon(sh, iface, ifcon) >= 0);
+	CU_ASSERT(semanage_context_from_string(sh, "user_u:role_r:msg_type_t:s0",
+					       &msgcon) >= 0);
+	CU_ASSERT(semanage_iface_set_msgcon(sh, iface, msgcon) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_iface_clone(sh, iface, &iface_clone) >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_iface_get_name(iface_clone), "asdf");
+
+	ifcon2 = semanage_iface_get_ifcon(iface_clone);
+	CU_ASSERT_CONTEXT_EQUAL(ifcon, ifcon2);
+
+	msgcon2 = semanage_iface_get_msgcon(iface_clone);
+	CU_ASSERT_CONTEXT_EQUAL(msgcon, msgcon2);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	semanage_iface_free(iface_clone);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_query */
+void test_iface_query(void)
+{
+	semanage_iface_t *iface = NULL;
+	semanage_iface_t *iface_exp = NULL;
+	semanage_iface_key_t *key = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_exp = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key = get_iface_key_nth(I_FIRST);
+	iface_exp = get_iface_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_iface_query(sh, key, &iface) >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_iface_get_name(iface),
+		semanage_iface_get_name(iface_exp));
+
+	con = semanage_iface_get_ifcon(iface);
+	con_exp = semanage_iface_get_ifcon(iface_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	con = semanage_iface_get_msgcon(iface);
+	con_exp = semanage_iface_get_msgcon(iface_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	semanage_iface_free(iface_exp);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_exists */
+void test_iface_exists(void)
+{
+	semanage_iface_key_t *key1 = NULL;
+	semanage_iface_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key1 = get_iface_key_nth(I_FIRST);
+	CU_ASSERT(semanage_iface_key_create(sh, "asdf", &key2) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_iface_exists(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_iface_exists(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	semanage_iface_key_free(key1);
+	semanage_iface_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_count */
+void test_iface_count(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_iface_count(sh, &count) >= 0);
+	CU_ASSERT(count == IFACE_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_iterate */
+
+unsigned int counter_iface_iterate = 0;
+
+int handler_iface_iterate(const semanage_iface_t *record, void *varg)
+{
+	counter_iface_iterate++;
+	return 0;
+}
+
+void test_iface_iterate(void)
+{
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	semanage_iface_iterate(sh, handler_iface_iterate, NULL);
+	CU_ASSERT(counter_iface_iterate == IFACE_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_list */
+void test_iface_list(void)
+{
+	semanage_iface_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_iface_list(sh, &records, &count) >= 0);
+	CU_ASSERT(count == IFACE_COUNT);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	for (unsigned int i = 0; i < count; i++)
+		semanage_iface_free(records[i]);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_iface_modify_local, semanage_iface_del_local,
+ * semanage_iface_query_local
+ */
+void test_iface_modify_del_query_local(void)
+{
+	semanage_iface_t *iface;
+	semanage_iface_t *iface_local;
+	semanage_iface_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	iface = get_iface_nth(I_FIRST);
+	CU_ASSERT(semanage_iface_key_extract(sh, iface, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* test */
+	CU_ASSERT(semanage_iface_modify_local(sh, key, iface) >= 0);
+
+	/* write changes to file */
+	helper_commit();
+	helper_begin_transaction();
+
+	CU_ASSERT(semanage_iface_query_local(sh, key, &iface_local) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(iface_local);
+
+	CU_ASSERT(semanage_iface_del_local(sh, key) >= 0);
+	CU_ASSERT(semanage_iface_query_local(sh, key, &iface_local) < 0);
+
+	/* cleanup */
+	semanage_iface_free(iface);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_iface_exists_local */
+void test_iface_exists_local(void)
+{
+	semanage_iface_key_t *key1 = NULL;
+	semanage_iface_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_iface(I_FIRST);
+	key1 = get_iface_key_nth(I_FIRST);
+	key2 = get_iface_key_nth(I_SECOND);
+
+	/* test */
+	CU_ASSERT(semanage_iface_exists_local(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+	CU_ASSERT(semanage_iface_exists_local(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	CU_ASSERT(semanage_iface_del_local(sh, key1) >= 0);
+	semanage_iface_key_free(key1);
+	semanage_iface_key_free(key2);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_iface_count_local */
+void test_iface_count_local(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+
+	/* test */
+	CU_ASSERT(semanage_iface_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	add_local_iface(I_FIRST);
+	CU_ASSERT(semanage_iface_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	add_local_iface(I_SECOND);
+	CU_ASSERT(semanage_iface_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 2);
+
+	delete_local_iface(I_SECOND);
+	CU_ASSERT(semanage_iface_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	delete_local_iface(I_FIRST);
+	CU_ASSERT(semanage_iface_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_iface_iterate_local */
+unsigned int counter_iface_iterate_local = 0;
+
+int handler_iface_iterate_local(const semanage_iface_t *record, void *varg)
+{
+	counter_iface_iterate_local++;
+	return 0;
+}
+
+void test_iface_iterate_local(void)
+{
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_iface(I_FIRST);
+	add_local_iface(I_SECOND);
+	add_local_iface(I_THIRD);
+
+	/* test */
+	semanage_iface_iterate_local(sh, handler_iface_iterate_local, NULL);
+	CU_ASSERT(counter_iface_iterate_local == 3);
+
+	/* cleanup */
+	delete_local_iface(I_FIRST);
+	delete_local_iface(I_SECOND);
+	delete_local_iface(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_iface_list_local */
+void test_iface_list_local(void)
+{
+	semanage_iface_t **records = NULL;
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_iface(I_FIRST);
+	add_local_iface(I_SECOND);
+	add_local_iface(I_THIRD);
+
+	/* test */
+	CU_ASSERT(semanage_iface_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == 3);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_iface_free(records[i]);
+
+	delete_local_iface(I_FIRST);
+	delete_local_iface(I_SECOND);
+	delete_local_iface(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
diff --git a/libsemanage/tests/test_iface.cil b/libsemanage/tests/test_iface.cil
new file mode 100644
index 00000000..13fd8f68
--- /dev/null
+++ b/libsemanage/tests/test_iface.cil
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
+(roletype object_r first_netif_t)
+(roletype object_r second_netif_t)
+(roletype object_r third_netif_t)
+(type first_netif_t)
+(type second_netif_t)
+(type third_netif_t)
+(sidcontext security (system_u object_r first_netif_t ((s0) (s0))))
+(class netif (tcp_recv))
+(classorder (netif))
+(allow first_netif_t self (netif (tcp_recv)))
+(netifcon eth0 (system_u object_r first_netif_t ((s0) (s0))) (system_u object_r first_netif_t ((s0) (s0))))
+(netifcon eth1 (system_u object_r second_netif_t ((s0) (s0))) (system_u object_r second_netif_t ((s0) (s0))))
+(netifcon eth2 (system_u object_r third_netif_t ((s0) (s0))) (system_u object_r third_netif_t ((s0) (s0))))
diff --git a/libsemanage/tests/test_iface.h b/libsemanage/tests/test_iface.h
new file mode 100644
index 00000000..5953e9c0
--- /dev/null
+++ b/libsemanage/tests/test_iface.h
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
+#ifndef __TEST_IFACE_H__
+#define __TEST_IFACE_H__
+
+#include <CUnit/Basic.h>
+
+int iface_test_init(void);
+int iface_test_cleanup(void);
+int iface_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

