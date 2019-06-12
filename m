Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F73CC31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015B920684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436779AbfFLIEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436771AbfFLIEq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB3DC23CD6E
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 314F2783B4
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:45 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/11] libsemanage: test semanage_ibendport_* functions
Date:   Wed, 12 Jun 2019 10:03:59 +0200
Message-Id: <20190612080404.4529-7-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 08:04:45 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_ibendport_* functions. The test suite aims for
line coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_ibendport.c    | 525 ++++++++++++++++++++++++++
 libsemanage/tests/test_ibendport.cil  |  28 ++
 libsemanage/tests/test_ibendport.h    |  30 ++
 4 files changed, 585 insertions(+)
 create mode 100644 libsemanage/tests/test_ibendport.c
 create mode 100644 libsemanage/tests/test_ibendport.cil
 create mode 100644 libsemanage/tests/test_ibendport.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index e590f7bd..d395a9fd 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -25,6 +25,7 @@
 #include "test_bool.h"
 #include "test_fcontext.h"
 #include "test_iface.h"
+#include "test_ibendport.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -67,6 +68,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(bool);
 	DECLARE_SUITE(fcontext);
 	DECLARE_SUITE(iface);
+	DECLARE_SUITE(ibendport);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_ibendport.c b/libsemanage/tests/test_ibendport.c
new file mode 100644
index 00000000..79a8e2c8
--- /dev/null
+++ b/libsemanage/tests/test_ibendport.c
@@ -0,0 +1,525 @@
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
+#include "test_ibendport.h"
+
+#define IBENDPORT_COUNT 3
+#define IBENDPORT_1_NAME "mlx4_0"
+#define IBENDPORT_1_PORT 1
+#define IBENDPORT_1_CON "system_u:object_r:first_ibendport_t:s0"
+#define IBENDPORT_2_NAME "mlx4_1"
+#define IBENDPORT_2_PORT 2
+#define IBENDPORT_2_CON "system_u:object_r:second_ibendport_second_t:s0"
+#define IBENDPORT_3_NAME "mlx4_1"
+#define IBENDPORT_3_PORT 3
+#define IBENDPORT_3_CON "system_u:object_r:third_ibendport_second_t:s0"
+
+/* ibendports_policy.h */
+void test_ibendport_query(void);
+void test_ibendport_exists(void);
+void test_ibendport_count(void);
+void test_ibendport_iterate(void);
+void test_ibendport_list(void);
+
+/* ibendports_local.h */
+void test_ibendport_modify_del_query_local(void);
+void test_ibendport_exists_local(void);
+void test_ibendport_count_local(void);
+void test_ibendport_iterate_local(void);
+void test_ibendport_list_local(void);
+
+extern semanage_handle_t *sh;
+
+int ibendport_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_ibendport.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int ibendport_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could not destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int ibendport_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "ibendport_query", test_ibendport_query);
+	CU_add_test(suite, "ibendport_exists", test_ibendport_exists);
+	CU_add_test(suite, "ibendport_count", test_ibendport_count);
+	CU_add_test(suite, "ibendport_iterate", test_ibendport_iterate);
+	CU_add_test(suite, "ibendport_list", test_ibendport_list);
+
+	CU_add_test(suite, "ibendport_modify_del_query_local",
+		    test_ibendport_modify_del_query_local);
+	CU_add_test(suite, "ibendport_exists_local",
+		    test_ibendport_exists_local);
+	CU_add_test(suite, "ibendport_count_local", test_ibendport_count_local);
+	CU_add_test(suite, "ibendport_iterate_local",
+		    test_ibendport_iterate_local);
+	CU_add_test(suite, "ibendport_list_local", test_ibendport_list_local);
+
+	return 0;
+}
+
+/* Helpers */
+
+semanage_ibendport_t *get_ibendport_nth(int idx)
+{
+	semanage_ibendport_t **records;
+	semanage_ibendport_t *ibendport;
+	unsigned int count;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	CU_ASSERT_FATAL(semanage_ibendport_list(sh, &records, &count) >= 0);
+	CU_ASSERT_FATAL(count >= (unsigned int) idx + 1);
+
+	ibendport = records[idx];
+
+	for (unsigned int i = 0; i < count; i++)
+		if (i != (unsigned int) idx)
+			semanage_ibendport_free(records[i]);
+
+	return ibendport;
+}
+
+semanage_ibendport_key_t *get_ibendport_key_nth(int idx)
+{
+	semanage_ibendport_key_t *key;
+	semanage_ibendport_t *ibendport;
+	int res;
+
+	if (idx == I_NULL)
+		return NULL;
+
+	ibendport = get_ibendport_nth(idx);
+
+	res = semanage_ibendport_key_extract(sh, ibendport, &key);
+
+	CU_ASSERT_FATAL(res >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	return key;
+}
+
+void add_local_ibendport(int idx)
+{
+	semanage_ibendport_t *ibendport;
+	semanage_ibendport_key_t *key = NULL;
+
+	ibendport = get_ibendport_nth(idx);
+
+	CU_ASSERT_FATAL(semanage_ibendport_key_extract(sh, ibendport,
+						       &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(key);
+
+	CU_ASSERT_FATAL(semanage_ibendport_modify_local(sh, key,
+							ibendport) >= 0);
+}
+
+void delete_local_ibendport(int idx)
+{
+	semanage_ibendport_key_t *key = NULL;
+	key = get_ibendport_key_nth(idx);
+	CU_ASSERT_FATAL(semanage_ibendport_del_local(sh, key) >= 0);
+}
+
+/* Function semanage_ibendport_query */
+void test_ibendport_query(void)
+{
+	semanage_ibendport_t *ibendport = NULL;
+	semanage_ibendport_t *ibendport_exp = NULL;
+	semanage_ibendport_key_t *key = NULL;
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_exp = NULL;
+	char *name;
+	char *name_exp;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key = get_ibendport_key_nth(I_FIRST);
+	ibendport_exp = get_ibendport_nth(I_FIRST);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_query(sh, key, &ibendport) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(ibendport);
+
+	CU_ASSERT(semanage_ibendport_get_ibdev_name(sh, ibendport, &name) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(name);
+	CU_ASSERT(semanage_ibendport_get_ibdev_name(sh, ibendport_exp,
+						    &name_exp) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(name_exp);
+	assert(name);
+	CU_ASSERT_STRING_EQUAL(name, name_exp);
+
+	CU_ASSERT(semanage_ibendport_get_port(ibendport) ==
+		  semanage_ibendport_get_port(ibendport_exp));
+
+	con = semanage_ibendport_get_con(ibendport);
+	con_exp = semanage_ibendport_get_con(ibendport_exp);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(con);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(con_exp);
+	CU_ASSERT_CONTEXT_EQUAL(con, con_exp);
+
+	/* cleanup */
+	free(name);
+	semanage_ibendport_free(ibendport);
+	semanage_ibendport_free(ibendport_exp);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_ibendport_exists */
+void test_ibendport_exists(void)
+{
+	semanage_ibendport_key_t *key1 = NULL;
+	semanage_ibendport_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+	key1 = get_ibendport_key_nth(I_FIRST);
+	CU_ASSERT(semanage_ibendport_key_create(sh, "asdf", 1, &key2) >= 0);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_exists(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+
+	CU_ASSERT(semanage_ibendport_exists(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	semanage_ibendport_key_free(key1);
+	semanage_ibendport_key_free(key2);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_ibendport_count */
+void test_ibendport_count(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_count(sh, &count) >= 0);
+	CU_ASSERT(count == IBENDPORT_COUNT);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_ibendport_iterate */
+unsigned int helper_ibendport_iterate_counter = 0;
+
+int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
+			     void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_counter++;
+	return 0;
+}
+
+int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
+				   void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_counter++;
+	return -1;
+}
+
+int helper_ibendport_iterate_break(const semanage_ibendport_t *ibendport,
+				   void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_counter++;
+	return 1;
+}
+
+void test_ibendport_iterate(void)
+{
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	helper_ibendport_iterate_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate(sh, helper_ibendport_iterate,
+					     (void *) 42) >= 0);
+	CU_ASSERT(helper_ibendport_iterate_counter == IBENDPORT_COUNT);
+
+	/* test function which returns error */
+	helper_ibendport_iterate_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate(sh, helper_ibendport_iterate_error,
+					     (void *) 42) < 0);
+	CU_ASSERT(helper_ibendport_iterate_counter == 1);
+
+	/* test function which requests break */
+	helper_ibendport_iterate_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate(sh, helper_ibendport_iterate_break,
+					     (void *) 42) >= 0);
+	CU_ASSERT(helper_ibendport_iterate_counter == 1);
+
+	/* cleanup */
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_ibendport_list */
+void test_ibendport_list(void)
+{
+	semanage_ibendport_t **records = NULL;
+	unsigned int count = 42;
+	char *name = NULL;
+	semanage_context_t *con = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_list(sh, &records, &count) >= 0);
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(records);
+	assert(records);
+	CU_ASSERT(count == IBENDPORT_COUNT);
+
+	for (unsigned int i = 0; i < count; i++) {
+		CU_ASSERT_PTR_NOT_NULL_FATAL(records[i]);
+		CU_ASSERT(semanage_ibendport_get_ibdev_name(sh, records[i],
+							    &name) >= 0);
+		con = semanage_ibendport_get_con(records[i]);
+		CU_ASSERT_PTR_NOT_NULL_FATAL(con);
+		free(name);
+	}
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_ibendport_free(records[i]);
+
+	free(records);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_ibendport_modify_local, semanage_ibendport_del_local,
+ * semanage_ibendport_query_local
+ */
+void test_ibendport_modify_del_query_local(void)
+{
+	semanage_ibendport_t *ibendport;
+	semanage_ibendport_t *ibendport_local;
+	semanage_ibendport_key_t *key = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	ibendport = get_ibendport_nth(I_FIRST);
+	CU_ASSERT(semanage_ibendport_key_extract(sh, ibendport, &key) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(key);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_modify_local(sh, key, ibendport) >= 0);
+
+	/* write changes to file */
+	helper_commit();
+	helper_begin_transaction();
+
+	CU_ASSERT(semanage_ibendport_query_local(sh, key,
+						 &ibendport_local) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(ibendport_local);
+
+	CU_ASSERT(semanage_ibendport_del_local(sh, key) >= 0);
+	CU_ASSERT(semanage_ibendport_query_local(sh, key,
+						 &ibendport_local) < 0);
+
+	/* cleanup */
+	semanage_ibendport_free(ibendport);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_ibendport_exists_local */
+void test_ibendport_exists_local(void)
+{
+	semanage_ibendport_key_t *key1 = NULL;
+	semanage_ibendport_key_t *key2 = NULL;
+	int resp = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_ibendport(I_FIRST);
+	key1 = get_ibendport_key_nth(I_FIRST);
+	key2 = get_ibendport_key_nth(I_SECOND);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_exists_local(sh, key1, &resp) >= 0);
+	CU_ASSERT(resp);
+
+	CU_ASSERT(semanage_ibendport_exists_local(sh, key2, &resp) >= 0);
+	CU_ASSERT(!resp);
+
+	/* cleanup */
+	CU_ASSERT(semanage_ibendport_del_local(sh, key1) >= 0);
+	semanage_ibendport_key_free(key1);
+	semanage_ibendport_key_free(key2);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_ibendport_count_local */
+void test_ibendport_count_local(void)
+{
+	unsigned int count = 42;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	add_local_ibendport(I_FIRST);
+	CU_ASSERT(semanage_ibendport_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	add_local_ibendport(I_SECOND);
+	CU_ASSERT(semanage_ibendport_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 2);
+
+	delete_local_ibendport(I_SECOND);
+	CU_ASSERT(semanage_ibendport_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 1);
+
+	delete_local_ibendport(I_FIRST);
+	CU_ASSERT(semanage_ibendport_count_local(sh, &count) >= 0);
+	CU_ASSERT(count == 0);
+
+	/* cleanup */
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_ibendport_iterate_local */
+unsigned int helper_ibendport_iterate_local_counter = 0;
+
+int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
+				   void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_local_counter++;
+	return 0;
+}
+
+int helper_ibendport_iterate_local_error(const semanage_ibendport_t *ibendport,
+					 void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_local_counter++;
+	return -1;
+}
+
+int helper_ibendport_iterate_local_break(const semanage_ibendport_t *ibendport,
+					 void *fn_arg)
+{
+	CU_ASSERT(fn_arg == (void *) 42);
+	helper_ibendport_iterate_local_counter++;
+	return 1;
+}
+
+void test_ibendport_iterate_local(void)
+{
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_ibendport(I_FIRST);
+	add_local_ibendport(I_SECOND);
+	add_local_ibendport(I_THIRD);
+
+	/* test */
+	helper_ibendport_iterate_local_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate_local(sh,
+			     helper_ibendport_iterate_local, (void *) 42) >= 0);
+	CU_ASSERT(helper_ibendport_iterate_local_counter == 3);
+
+	/* test function which returns error */
+	helper_ibendport_iterate_local_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate_local(sh,
+			helper_ibendport_iterate_local_error, (void *) 42) < 0);
+	CU_ASSERT(helper_ibendport_iterate_local_counter == 1);
+
+	/* test function which requests break */
+	helper_ibendport_iterate_local_counter = 0;
+	CU_ASSERT(semanage_ibendport_iterate_local(sh,
+		       helper_ibendport_iterate_local_break, (void *) 42) >= 0);
+
+	/* cleanup */
+	delete_local_ibendport(I_FIRST);
+	delete_local_ibendport(I_SECOND);
+	delete_local_ibendport(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_ibendport_list_local */
+void test_ibendport_list_local(void)
+{
+	semanage_ibendport_t **records = NULL;
+	unsigned int count = 42;
+	char *name = NULL;
+	semanage_context_t *con = NULL;
+
+	/* setup */
+	setup_handle(SH_TRANS);
+	add_local_ibendport(I_FIRST);
+	add_local_ibendport(I_SECOND);
+	add_local_ibendport(I_THIRD);
+
+	/* test */
+	CU_ASSERT(semanage_ibendport_list_local(sh, &records, &count) >= 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(records);
+	assert(records);
+	CU_ASSERT(count == 3);
+
+	for (unsigned int i = 0; i < count; i++) {
+		CU_ASSERT_PTR_NOT_NULL_FATAL(records[i]);
+		CU_ASSERT(semanage_ibendport_get_ibdev_name(sh, records[i],
+								   &name) >= 0);
+		con = semanage_ibendport_get_con(records[i]);
+		CU_ASSERT_PTR_NOT_NULL_FATAL(con);
+		free(name);
+	}
+
+	/* cleanup */
+	for (unsigned int i = 0; i < count; i++)
+		semanage_ibendport_free(records[i]);
+
+	free(records);
+	delete_local_ibendport(I_FIRST);
+	delete_local_ibendport(I_SECOND);
+	delete_local_ibendport(I_THIRD);
+	cleanup_handle(SH_TRANS);
+}
diff --git a/libsemanage/tests/test_ibendport.cil b/libsemanage/tests/test_ibendport.cil
new file mode 100644
index 00000000..b786b913
--- /dev/null
+++ b/libsemanage/tests/test_ibendport.cil
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
+(roletype object_r first_ibendport_t)
+(roletype object_r second_ibendport_t)
+(roletype object_r third_ibendport_t)
+(type first_ibendport_t)
+(type second_ibendport_t)
+(type third_ibendport_t)
+(sidcontext security (system_u object_r first_ibendport_t ((s0) (s0))))
+(class test_class (test_perm))
+(classorder (test_class))
+(allow first_ibendport_t self (test_class (test_perm)))
+(ibendportcon mlx4_0 1 (system_u object_r first_ibendport_t ((s0) (s0))))
+(ibendportcon mlx4_1 2 (system_u object_r second_ibendport_t ((s0) (s0))))
+(ibendportcon mlx4_1 3 (system_u object_r third_ibendport_t ((s0) (s0))))
diff --git a/libsemanage/tests/test_ibendport.h b/libsemanage/tests/test_ibendport.h
new file mode 100644
index 00000000..33d7fbd0
--- /dev/null
+++ b/libsemanage/tests/test_ibendport.h
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
+#ifndef __TEST_IBENDPORT_H__
+#define __TEST_IBENDPORT_H__
+
+#include <CUnit/Basic.h>
+
+int ibendport_test_init(void);
+int ibendport_test_cleanup(void);
+int ibendport_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

