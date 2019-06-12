Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30366C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0211020684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436773AbfFLIEn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436771AbfFLIEn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2649C3097052
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9F07C801
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/11] libsemanage: test semanage_bool_* functions
Date:   Wed, 12 Jun 2019 10:03:56 +0200
Message-Id: <20190612080404.4529-4-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 08:04:43 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_bool_* functions. The test suite aims for line
coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_bool.c         | 932 ++++++++++++++++++++++++++
 libsemanage/tests/test_bool.cil       |  24 +
 libsemanage/tests/test_bool.h         |  31 +
 4 files changed, 989 insertions(+)
 create mode 100644 libsemanage/tests/test_bool.c
 create mode 100644 libsemanage/tests/test_bool.cil
 create mode 100644 libsemanage/tests/test_bool.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index 0fb3991b..83754fe4 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -22,6 +22,7 @@
 #include "test_semanage_store.h"
 #include "test_utilities.h"
 #include "test_handle.h"
+#include "test_bool.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -61,6 +62,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(semanage_store);
 	DECLARE_SUITE(semanage_utilities);
 	DECLARE_SUITE(handle);
+	DECLARE_SUITE(bool);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_bool.c b/libsemanage/tests/test_bool.c
new file mode 100644
index 00000000..dbcdeddb
--- /dev/null
+++ b/libsemanage/tests/test_bool.c
@@ -0,0 +1,932 @@
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
+#include "test_bool.h"
+
+#define BOOL_COUNT 3
+#define BOOL1_NAME "first_bool"
+#define BOOL1_VALUE 1
+#define BOOL2_NAME "second_bool"
+#define BOOL2_VALUE 0
+#define BOOL3_NAME "third_bool"
+#define BOOL3_VALUE 0
+#define BOOL_NONEXISTENT "asdf"
+
+/* boolean_record.h */
+void test_bool_key_create(void);
+void test_bool_key_extract(void);
+void test_bool_compare(void);
+void test_bool_compare2(void);
+void test_bool_get_set_name(void);
+void test_bool_get_set_value(void);
+void test_bool_create(void);
+void test_bool_clone(void);
+
+/* booleans_policy.h */
+void test_bool_query(void);
+void test_bool_exists(void);
+void test_bool_count(void);
+void test_bool_iterate(void);
+void test_bool_list(void);
+
+/* booleans_local.h */
+void test_bool_modify_del_local(void);
+void test_bool_query_local(void);
+void test_bool_exists_local(void);
+void test_bool_count_local(void);
+void test_bool_iterate_local(void);
+void test_bool_list_local(void);
+
+extern semanage_handle_t *sh;
+
+int bool_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_bool.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int bool_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could not destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int bool_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "bool_key_create", test_bool_key_create);
+	CU_add_test(suite, "bool_key_extract", test_bool_key_extract);
+	CU_add_test(suite, "bool_compare", test_bool_compare);
+	CU_add_test(suite, "bool_compare2", test_bool_compare2);
+	CU_add_test(suite, "bool_get_set_name", test_bool_get_set_name);
+	CU_add_test(suite, "bool_get_set_value", test_bool_get_set_value);
+	CU_add_test(suite, "bool_create", test_bool_create);
+	CU_add_test(suite, "bool_clone", test_bool_clone);
+
+	CU_add_test(suite, "bool_query", test_bool_query);
+	CU_add_test(suite, "bool_exists", test_bool_exists);
+	CU_add_test(suite, "bool_count", test_bool_count);
+	CU_add_test(suite, "bool_iterate", test_bool_iterate);
+	CU_add_test(suite, "bool_list", test_bool_list);
+
+	CU_add_test(suite, "bool_modify_del_local", test_bool_modify_del_local);
+	CU_add_test(suite, "bool_query_local", test_bool_query_local);
+	CU_add_test(suite, "bool_exists_local", test_bool_exists_local);
+	CU_add_test(suite, "bool_count_local", test_bool_count_local);
+	CU_add_test(suite, "bool_iterate_local", test_bool_iterate_local);
+	CU_add_test(suite, "bool_list_local", test_bool_list_local);
+
+	return 0;
+}
+
+/* Helpers */
+
+semanage_bool_t *get_bool_nth(int idx)
+{
+	int res;
+	semanage_bool_t **records;
+	semanage_bool_t *boolean;
+	unsigned int count;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	res = semanage_bool_list(sh, &records, &count);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_FATAL(count >= (unsigned int) idx + 1);
+
+	boolean = records[idx];
+
+	for (unsigned int i = 0; i < count; i++)
+		if (i != (unsigned int) idx)
+			semanage_bool_free(records[i]);
+
+	return boolean;
+}
+
+semanage_bool_t *get_bool_new(void)
+{
+	int res;
+	semanage_bool_t *boolean;
+
+	res = semanage_bool_create(sh, &boolean);
+
+	CU_ASSERT_FATAL(res >= 0);
+
+	return boolean;
+}
+
+semanage_bool_key_t *get_bool_key_nth(int idx)
+{
+	semanage_bool_key_t *key;
+	semanage_bool_t *boolean;
+	int res;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	boolean = get_bool_nth(idx);
+
+	res = semanage_bool_key_extract(sh, boolean, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+semanage_bool_key_t *get_bool_key_from_str(const char *str)
+{
+	semanage_bool_key_t *key;
+	int res;
+
+	if (str == NULL)
+		return NULL;
+
+	res = semanage_bool_key_create(sh, str, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+void add_local_bool(const char *name)
+{
+	semanage_bool_t *boolean;
+	semanage_bool_key_t *key = NULL;
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(name);
+
+	CU_ASSERT_FATAL(semanage_bool_key_create(sh, name, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_bool_query(sh, key, &boolean) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(boolean);
+
+	CU_ASSERT_FATAL(semanage_bool_modify_local(sh, key, boolean) >= 0);
+}
+
+void delete_local_bool(const char *name)
+{
+	semanage_bool_key_t *key = NULL;
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(name);
+
+	CU_ASSERT_FATAL(semanage_bool_key_create(sh, name, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_bool_del_local(sh, key) >= 0);
+}
+
+/* Function bool_key_create */
+
+void helper_bool_key_create(level_t level)
+{
+	semanage_bool_key_t *key = NULL;
+
+	setup_handle(level);
+
+	CU_ASSERT(semanage_bool_key_create(sh, "", &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	semanage_bool_key_free(key);
+
+	key = NULL;
+
+	CU_ASSERT(semanage_bool_key_create(sh, "testbool", &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	semanage_bool_key_free(key);
+
+	cleanup_handle(level);
+}
+
+void test_bool_key_create(void)
+{
+	helper_bool_key_create(SH_CONNECT);
+	helper_bool_key_create(SH_TRANS);
+}
+
+/* Function bool_key_extract */
+#define SK_NULL 1
+#define SK_NEW 2
+#define SK_INDEX 3
+#define SK_KEY_NULL 4
+void helper_bool_key_extract(level_t level, int mode)
+{
+	semanage_bool_t *boolean = NULL;
+	semanage_bool_key_t *key = NULL;
+	int res;
+
+	setup_handle(level);
+
+	switch (mode) {
+	case SK_NULL:
+		boolean = NULL;
+		break;
+	case SK_NEW:
+		boolean = get_bool_new();
+		break;
+	case SK_INDEX:
+		boolean = get_bool_nth(0);
+		break;
+	case SK_KEY_NULL:
+		boolean = get_bool_nth(0);
+		break;
+	default:
+		CU_FAIL_FATAL("Invalid mode\n");
+	}
+
+	if (mode == SK_KEY_NULL)
+		res = semanage_bool_key_extract(sh, boolean, NULL);
+	else
+		res = semanage_bool_key_extract(sh, boolean, &key);
+
+	CU_ASSERT(res >= 0);
+
+	res = semanage_bool_compare(boolean, key);
+
+	CU_ASSERT(res == 0);
+
+	semanage_bool_key_free(key);
+	semanage_bool_free(boolean);
+
+	cleanup_handle(level);
+}
+
+void test_bool_key_extract(void)
+{
+	helper_bool_key_extract(SH_CONNECT, SK_INDEX);
+	helper_bool_key_extract(SH_TRANS, SK_INDEX);
+}
+#undef SK_NULL
+#undef SK_NEW
+#undef SK_INDEX
+#undef SK_KEY_NULL
+
+/* Function bool_compare */
+void helper_bool_compare(level_t level, int bool_idx1, int bool_idx2)
+{
+	semanage_bool_t *boolean;
+	semanage_bool_key_t *key;
+	int res;
+
+	setup_handle(level);
+
+	boolean = get_bool_nth(bool_idx1);
+	key = get_bool_key_nth(bool_idx2);
+
+	res = semanage_bool_compare(boolean, key);
+
+	if (bool_idx1 == bool_idx2) {
+		CU_ASSERT(res == 0);
+	} else {
+		CU_ASSERT(res != 0);
+	}
+
+	semanage_bool_free(boolean);
+	semanage_bool_key_free(key);
+	cleanup_handle(level);
+}
+
+void test_bool_compare(void)
+{
+	helper_bool_compare(SH_CONNECT, I_FIRST,  I_FIRST);
+	helper_bool_compare(SH_CONNECT, I_FIRST,  I_SECOND);
+	helper_bool_compare(SH_CONNECT, I_SECOND, I_FIRST);
+	helper_bool_compare(SH_CONNECT, I_SECOND, I_SECOND);
+
+	helper_bool_compare(SH_TRANS, I_FIRST,  I_FIRST);
+	helper_bool_compare(SH_TRANS, I_FIRST,  I_SECOND);
+	helper_bool_compare(SH_TRANS, I_SECOND, I_FIRST);
+	helper_bool_compare(SH_TRANS, I_SECOND, I_SECOND);
+}
+
+/* Function bool_compare2 */
+void helper_bool_compare2(level_t level, int bool_idx1, int bool_idx2)
+{
+	semanage_bool_t *bool1;
+	semanage_bool_t *bool2;
+	int res;
+
+	setup_handle(level);
+
+	bool1 = get_bool_nth(bool_idx1);
+	bool2 = get_bool_nth(bool_idx2);
+
+	res = semanage_bool_compare2(bool1, bool2);
+
+	if (bool_idx1 == bool_idx2) {
+		CU_ASSERT(res == 0);
+	} else {
+		CU_ASSERT(res != 0);
+	}
+
+	semanage_bool_free(bool1);
+	semanage_bool_free(bool2);
+	cleanup_handle(level);
+}
+
+void test_bool_compare2(void)
+{
+	helper_bool_compare2(SH_CONNECT, I_FIRST,  I_FIRST);
+	helper_bool_compare2(SH_CONNECT, I_FIRST,  I_SECOND);
+	helper_bool_compare2(SH_CONNECT, I_SECOND, I_FIRST);
+	helper_bool_compare2(SH_CONNECT, I_SECOND, I_SECOND);
+
+	helper_bool_compare2(SH_TRANS, I_FIRST,  I_FIRST);
+	helper_bool_compare2(SH_TRANS, I_FIRST,  I_SECOND);
+	helper_bool_compare2(SH_TRANS, I_SECOND, I_FIRST);
+	helper_bool_compare2(SH_TRANS, I_SECOND, I_SECOND);
+}
+
+/* Function bool_get_name, bool_set_name */
+void helper_bool_get_set_name(level_t level, int bool_idx, const char *name)
+{
+	semanage_bool_t *boolean;
+	const char *new_name = NULL;
+
+	setup_handle(level);
+
+	boolean = get_bool_nth(bool_idx);
+
+	CU_ASSERT(semanage_bool_set_name(sh, boolean, name) >= 0);
+
+	new_name = semanage_bool_get_name(boolean);
+
+	CU_ASSERT_PTR_NOT_NULL(new_name);
+	/* Use assert to silence the clang analyzer */
+	assert(new_name);
+	CU_ASSERT_STRING_EQUAL(new_name, name);
+
+	semanage_bool_free(boolean);
+	cleanup_handle(level);
+}
+
+void test_bool_get_set_name(void)
+{
+	helper_bool_get_set_name(SH_CONNECT, I_FIRST, "testbool");
+	helper_bool_get_set_name(SH_CONNECT, I_FIRST, "");
+	helper_bool_get_set_name(SH_CONNECT, I_SECOND, "testbool");
+	helper_bool_get_set_name(SH_CONNECT, I_SECOND, "");
+
+	helper_bool_get_set_name(SH_TRANS, I_FIRST, "testbool");
+	helper_bool_get_set_name(SH_TRANS, I_FIRST, "");
+	helper_bool_get_set_name(SH_TRANS, I_SECOND, "testbool");
+	helper_bool_get_set_name(SH_TRANS, I_SECOND, "");
+}
+
+/* Function bool_get_value, bool_set_value */
+void helper_bool_get_set_value(int bool_idx, int val)
+{
+	semanage_bool_t *boolean;
+	int new_val = 0;
+
+	setup_handle(SH_CONNECT);
+	boolean = get_bool_nth(bool_idx);
+	cleanup_handle(SH_CONNECT);
+
+	semanage_bool_set_value(boolean, val);
+
+	new_val = semanage_bool_get_value(boolean);
+
+	CU_ASSERT(new_val == val);
+
+	semanage_bool_free(boolean);
+}
+
+void test_bool_get_set_value(void)
+{
+	helper_bool_get_set_value(I_FIRST, 1);
+	helper_bool_get_set_value(I_FIRST, 0);
+	helper_bool_get_set_value(I_SECOND, 1);
+	helper_bool_get_set_value(I_SECOND, 0);
+}
+
+/* Function bool_create */
+void helper_bool_create(level_t level)
+{
+	semanage_bool_t *boolean;
+
+	setup_handle(level);
+
+	CU_ASSERT(semanage_bool_create(sh, &boolean) >= 0);
+
+	CU_ASSERT_PTR_NULL(semanage_bool_get_name(boolean));
+	CU_ASSERT(semanage_bool_get_value(boolean) == 0);
+
+	cleanup_handle(level);
+}
+
+void test_bool_create(void)
+{
+	helper_bool_create(SH_HANDLE);
+	helper_bool_create(SH_CONNECT);
+	helper_bool_create(SH_TRANS);
+}
+
+/* Function bool_clone */
+void helper_bool_clone(level_t level, int bool_idx)
+{
+	semanage_bool_t *boolean;
+	semanage_bool_t *boolean_clone;
+	const char *str;
+	const char *str_clone;
+	int val;
+	int val_clone;
+
+	setup_handle(level);
+
+	boolean = get_bool_nth(bool_idx);
+
+	CU_ASSERT(semanage_bool_clone(sh, boolean, &boolean_clone) >= 0);
+
+	str = semanage_bool_get_name(boolean);
+	str_clone = semanage_bool_get_name(boolean_clone);
+
+	CU_ASSERT_STRING_EQUAL(str, str_clone);
+
+	val = semanage_bool_get_value(boolean);
+	val_clone = semanage_bool_get_value(boolean_clone);
+
+	CU_ASSERT_EQUAL(val, val_clone);
+
+	cleanup_handle(level);
+}
+
+void test_bool_clone(void)
+{
+	helper_bool_clone(SH_CONNECT, I_FIRST);
+	helper_bool_clone(SH_CONNECT, I_SECOND);
+
+	helper_bool_clone(SH_TRANS, I_FIRST);
+	helper_bool_clone(SH_TRANS, I_SECOND);
+}
+
+/* Function bool_query */
+void helper_bool_query(level_t level, const char *bool_str, int exp_res)
+{
+	semanage_bool_key_t *key;
+	semanage_bool_t *resp = (void *) 42;
+
+	setup_handle(level);
+
+	key = get_bool_key_from_str(bool_str);
+
+	CU_ASSERT(semanage_bool_query(sh, key, &resp) >= 0);
+
+	if (exp_res >= 0) {
+		const char *name = semanage_bool_get_name(resp);
+		CU_ASSERT_STRING_EQUAL(name, bool_str);
+	} else {
+		CU_ASSERT_PTR_NULL(resp);
+	}
+
+	cleanup_handle(level);
+}
+
+void test_bool_query(void)
+{
+	helper_bool_query(SH_CONNECT, BOOL1_NAME,  1);
+	helper_bool_query(SH_CONNECT, BOOL2_NAME, 1);
+	helper_bool_query(SH_CONNECT, BOOL_NONEXISTENT, -1);
+
+	helper_bool_query(SH_TRANS, BOOL1_NAME,  1);
+	helper_bool_query(SH_TRANS, BOOL2_NAME, 1);
+	helper_bool_query(SH_TRANS, BOOL_NONEXISTENT, -1);
+}
+
+/* Functon bool_exists */
+void helper_bool_exists(level_t level, const char *bool_str, int exp_resp)
+{
+	semanage_bool_key_t *key;
+	int resp;
+
+	setup_handle(level);
+
+	key = get_bool_key_from_str(bool_str);
+
+	CU_ASSERT(semanage_bool_exists(sh, key, &resp) >= 0);
+	CU_ASSERT(resp == exp_resp);
+
+	semanage_bool_key_free(key);
+
+	cleanup_handle(level);
+}
+
+void test_bool_exists(void)
+{
+	helper_bool_exists(SH_CONNECT, BOOL1_NAME,  1);
+	helper_bool_exists(SH_CONNECT, BOOL2_NAME, 1);
+	helper_bool_exists(SH_CONNECT, BOOL_NONEXISTENT, 0);
+
+	helper_bool_exists(SH_TRANS, BOOL1_NAME,  1);
+	helper_bool_exists(SH_TRANS, BOOL2_NAME, 1);
+	helper_bool_exists(SH_TRANS, BOOL_NONEXISTENT, 0);
+}
+
+/* Function bool_count */
+void test_bool_count(void)
+{
+	unsigned int resp;
+
+	/* handle */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_bool_count(sh, &resp) < 0);
+	CU_ASSERT(semanage_bool_count(sh, NULL) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* connect */
+	resp = 0;
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_bool_count(sh, &resp) >= 0);
+	CU_ASSERT(resp == BOOL_COUNT);
+	cleanup_handle(SH_CONNECT);
+
+	/* trans */
+	resp = 0;
+	setup_handle(SH_TRANS);
+	CU_ASSERT(semanage_bool_count(sh, &resp) >= 0);
+	CU_ASSERT(resp == BOOL_COUNT);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function bool_iterate */
+unsigned int counter_bool_iterate = 0;
+
+int handler_bool_iterate(const semanage_bool_t *record, void *varg)
+{
+	counter_bool_iterate++;
+	return 0;
+}
+
+void helper_bool_iterate_invalid(void)
+{
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_bool_iterate(sh, &handler_bool_iterate, NULL) < 0);
+	CU_ASSERT(semanage_bool_iterate(sh, NULL, NULL) < 0);
+	cleanup_handle(SH_HANDLE);
+}
+
+void helper_bool_iterate(level_t level)
+{
+	setup_handle(level);
+	counter_bool_iterate = 0;
+	CU_ASSERT(semanage_bool_iterate(sh, &handler_bool_iterate, NULL) >= 0);
+	CU_ASSERT(counter_bool_iterate == BOOL_COUNT);
+	cleanup_handle(level);
+}
+
+void test_bool_iterate(void)
+{
+	helper_bool_iterate_invalid();
+	helper_bool_iterate(SH_CONNECT);
+	helper_bool_iterate(SH_TRANS);
+}
+
+/* Function bool_list */
+void helper_bool_list_invalid(void)
+{
+	semanage_bool_t **records;
+	unsigned int count;
+
+	setup_handle(SH_HANDLE);
+
+	CU_ASSERT(semanage_bool_list(sh, &records, &count) < 0);
+	CU_ASSERT(semanage_bool_list(sh, NULL, &count) < 0);
+	CU_ASSERT(semanage_bool_list(sh, &records, NULL) < 0);
+
+	cleanup_handle(SH_HANDLE);
+}
+
+void helper_bool_list(level_t level)
+{
+	semanage_bool_t **records;
+	unsigned int count;
+
+	setup_handle(level);
+
+	CU_ASSERT(semanage_bool_list(sh, &records, &count) >= 0);
+	CU_ASSERT(count == BOOL_COUNT);
+
+	for (unsigned int i = 0; i < count; i++)
+		CU_ASSERT_PTR_NOT_NULL(records[i]);
+
+	for (unsigned int i = 0; i < count; i++)
+		semanage_bool_free(records[i]);
+
+	cleanup_handle(level);
+}
+
+void test_bool_list(void)
+{
+	helper_bool_list_invalid();
+	helper_bool_list(SH_CONNECT);
+	helper_bool_list(SH_TRANS);
+}
+
+/* Function bool_modify_local, bool_del_local */
+void helper_bool_modify_del_local(level_t level, const char *name,
+				  int old_val, int exp_res)
+{
+	semanage_bool_t *boolean;
+	semanage_bool_t *boolean_local;
+	semanage_bool_key_t *key = NULL;
+	int res;
+	int new_val;
+
+	/* setup */
+	setup_handle(level);
+
+	CU_ASSERT(semanage_bool_key_create(sh, name, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	CU_ASSERT(semanage_bool_query(sh, key, &boolean) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(boolean);
+
+	new_val = !old_val;
+	semanage_bool_set_value(boolean, new_val);
+
+	/* test */
+	res = semanage_bool_modify_local(sh, key, boolean);
+
+	if (exp_res < 0) {
+		CU_ASSERT(res < 0);
+	} else {
+		CU_ASSERT(res >= 0);
+
+		/* write changes to file */
+		if (level == SH_TRANS) {
+			helper_commit();
+			helper_begin_transaction();
+		}
+
+		CU_ASSERT(semanage_bool_query_local(sh, key,
+					            &boolean_local) >= 0);
+		CU_ASSERT(semanage_bool_compare2(boolean_local, boolean) == 0);
+		CU_ASSERT(semanage_bool_del_local(sh, key) >= 0);
+		CU_ASSERT(semanage_bool_query_local(sh, key,
+						    &boolean_local) < 0);
+	}
+
+	/* cleanup */
+	semanage_bool_key_free(key);
+	semanage_bool_free(boolean);
+
+	cleanup_handle(level);
+}
+
+void test_bool_modify_del_local(void)
+{
+	helper_bool_modify_del_local(SH_CONNECT, BOOL1_NAME, BOOL1_VALUE, -1);
+	helper_bool_modify_del_local(SH_CONNECT, BOOL2_NAME, BOOL2_VALUE, -1);
+	helper_bool_modify_del_local(SH_TRANS, BOOL1_NAME, BOOL1_VALUE, 1);
+	helper_bool_modify_del_local(SH_TRANS, BOOL2_NAME, BOOL2_VALUE, 1);
+}
+
+/* Function bool_query_local */
+void test_bool_query_local(void)
+{
+	semanage_bool_key_t *key = NULL;
+	semanage_bool_t *resp = NULL;
+
+	/* connect */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_bool_key_create(sh, BOOL1_NAME, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) < 0);
+	CU_ASSERT_PTR_NULL(resp);
+
+	cleanup_handle(SH_CONNECT);
+
+	/* transaction */
+	setup_handle(SH_TRANS);
+	CU_ASSERT(semanage_bool_key_create(sh, BOOL1_NAME, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) < 0);
+	CU_ASSERT_PTR_NULL(resp);
+
+	add_local_bool(BOOL1_NAME);
+	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(resp);
+
+	semanage_bool_key_free(key);
+	CU_ASSERT(semanage_bool_key_create(sh, BOOL2_NAME, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	add_local_bool(BOOL2_NAME);
+	CU_ASSERT(semanage_bool_query_local(sh, key, &resp) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(resp);
+
+	/* cleanup */
+	delete_local_bool(BOOL1_NAME);
+	delete_local_bool(BOOL2_NAME);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function bool_exists_local */
+void test_bool_exists_local(void)
+{
+	int resp = -1;
+	semanage_bool_key_t *key;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	CU_ASSERT(semanage_bool_key_create(sh, BOOL1_NAME, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* test */
+	CU_ASSERT(semanage_bool_exists_local(sh, key, &resp) >= 0);
+	CU_ASSERT(resp == 0);
+
+	add_local_bool(BOOL1_NAME);
+	resp = -1;
+	CU_ASSERT(semanage_bool_exists_local(sh, key, &resp) >= 0);
+	CU_ASSERT(resp == 1);
+
+	delete_local_bool(BOOL1_NAME);
+	resp = -1;
+	CU_ASSERT(semanage_bool_exists_local(sh, key, &resp) >= 0);
+	CU_ASSERT(resp == 0);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function bool_count_local */
+void test_bool_count_local(void)
+{
+	unsigned int resp;
+	unsigned int init_count;
+
+	/* handle */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* connect */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	cleanup_handle(SH_CONNECT);
+
+	/* transaction */
+	setup_handle(SH_TRANS);
+
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	init_count = resp;
+
+	add_local_bool(BOOL1_NAME);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	CU_ASSERT(resp == init_count + 1);
+
+	add_local_bool(BOOL2_NAME);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	CU_ASSERT(resp == init_count + 2);
+
+	delete_local_bool(BOOL2_NAME);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	CU_ASSERT(resp == init_count + 1);
+
+	delete_local_bool(BOOL1_NAME);
+	CU_ASSERT(semanage_bool_count_local(sh, &resp) >= 0);
+	CU_ASSERT(resp == init_count);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function bool_iterate_local */
+unsigned int counter_bool_iterate_local = 0;
+
+int handler_bool_iterate_local(const semanage_bool_t *record, void *varg)
+{
+	counter_bool_iterate_local++;
+	return 0;
+}
+
+void test_bool_iterate_local(void)
+{
+	unsigned int init_count;
+
+	/* handle */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_bool_iterate_local(sh, &handler_bool_iterate_local,
+					      NULL) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* connect */
+	setup_handle(SH_CONNECT);
+
+	counter_bool_iterate_local = 0;
+	CU_ASSERT(semanage_bool_iterate_local(sh, &handler_bool_iterate_local,
+					      NULL) >= 0);
+	init_count = counter_bool_iterate_local;
+
+	cleanup_handle(SH_CONNECT);
+
+	/* transaction */
+	setup_handle(SH_TRANS);
+
+	counter_bool_iterate_local = 0;
+	CU_ASSERT(semanage_bool_iterate_local(sh, &handler_bool_iterate_local,
+					      NULL) >= 0);
+	CU_ASSERT(counter_bool_iterate_local == init_count);
+
+	add_local_bool(BOOL1_NAME);
+	counter_bool_iterate_local = 0;
+	CU_ASSERT(semanage_bool_iterate_local(sh, &handler_bool_iterate_local,
+					      NULL) >= 0);
+	CU_ASSERT(counter_bool_iterate_local == init_count + 1);
+
+	add_local_bool(BOOL2_NAME);
+	counter_bool_iterate_local = 0;
+	CU_ASSERT(semanage_bool_iterate_local(sh, &handler_bool_iterate_local,
+					      NULL) >= 0);
+	CU_ASSERT(counter_bool_iterate_local == init_count + 2);
+
+	/* cleanup */
+	delete_local_bool(BOOL1_NAME);
+	delete_local_bool(BOOL2_NAME);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Functtion bool_list_local */
+void test_bool_list_local(void)
+{
+	semanage_bool_t **records;
+	unsigned int count;
+	unsigned int init_count;
+
+	/* handle */
+	setup_handle(SH_HANDLE);
+
+	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) < 0);
+	CU_ASSERT(semanage_bool_list_local(sh, NULL, &count) < 0);
+	CU_ASSERT(semanage_bool_list_local(sh, &records, NULL) < 0);
+
+	cleanup_handle(SH_HANDLE);
+
+	/* connect */
+	setup_handle(SH_CONNECT);
+
+	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
+	init_count = count;
+
+	cleanup_handle(SH_CONNECT);
+
+	/* transaction */
+	setup_handle(SH_TRANS);
+
+	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == init_count);
+
+	add_local_bool(BOOL1_NAME);
+	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == init_count + 1);
+	CU_ASSERT_PTR_NOT_NULL(records[0]);
+
+	add_local_bool(BOOL2_NAME);
+	CU_ASSERT(semanage_bool_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT(count == init_count + 2);
+	CU_ASSERT_PTR_NOT_NULL(records[0]);
+	CU_ASSERT_PTR_NOT_NULL(records[1]);
+
+	/* cleanup */
+	delete_local_bool(BOOL1_NAME);
+	delete_local_bool(BOOL2_NAME);
+	cleanup_handle(SH_TRANS);
+}
diff --git a/libsemanage/tests/test_bool.cil b/libsemanage/tests/test_bool.cil
new file mode 100644
index 00000000..4174751c
--- /dev/null
+++ b/libsemanage/tests/test_bool.cil
@@ -0,0 +1,24 @@
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
+(roletype object_r test_t)
+(type test_t)
+(sidcontext security (system_u object_r test_t ((s0) (s0))))
+(class test_class (test_perm))
+(classorder (test_class))
+(allow test_t self (test_class (test_perm)))
+(boolean first_bool true)
+(boolean second_bool false)
+(boolean third_bool false)
diff --git a/libsemanage/tests/test_bool.h b/libsemanage/tests/test_bool.h
new file mode 100644
index 00000000..b5b5a603
--- /dev/null
+++ b/libsemanage/tests/test_bool.h
@@ -0,0 +1,31 @@
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
+#ifndef __TEST_BOOL_H__
+#define __TEST_BOOL_H__
+
+#include <CUnit/Basic.h>
+#include "semanage/semanage.h"
+
+int bool_test_init(void);
+int bool_test_cleanup(void);
+int bool_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

