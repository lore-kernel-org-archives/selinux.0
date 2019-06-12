Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BBC31E47
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A7520684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfFLIEm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbfFLIEm (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34A5EC79CE
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB3CF78405
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:41 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/11] libsemanage: test semanage_handle_* functions
Date:   Wed, 12 Jun 2019 10:03:55 +0200
Message-Id: <20190612080404.4529-3-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 12 Jun 2019 08:04:42 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for semanage_handle_* functions. The test suite aims for line
coverage and covers expected usage of functions. The test suite uses custom
semanage store and policy written in CIL, it does not require running on SELinux
enabled system.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_handle.c       | 329 ++++++++++++++++++++++++++
 libsemanage/tests/test_handle.cil     |  21 ++
 libsemanage/tests/test_handle.h       |  30 +++
 4 files changed, 382 insertions(+)
 create mode 100644 libsemanage/tests/test_handle.c
 create mode 100644 libsemanage/tests/test_handle.cil
 create mode 100644 libsemanage/tests/test_handle.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index 048751b8..0fb3991b 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -21,6 +21,7 @@
 
 #include "test_semanage_store.h"
 #include "test_utilities.h"
+#include "test_handle.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -59,6 +60,7 @@ static bool do_tests(int interactive, int verbose)
 
 	DECLARE_SUITE(semanage_store);
 	DECLARE_SUITE(semanage_utilities);
+	DECLARE_SUITE(handle);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_handle.c b/libsemanage/tests/test_handle.c
new file mode 100644
index 00000000..2fab29be
--- /dev/null
+++ b/libsemanage/tests/test_handle.c
@@ -0,0 +1,329 @@
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
+#include "test_handle.h"
+
+void test_handle_create(void);
+void test_connect(void);
+void test_disconnect(void);
+void test_transaction(void);
+void test_commit(void);
+void test_is_connected(void);
+void test_access_check(void);
+void test_is_managed(void);
+void test_mls_enabled(void);
+void test_msg_set_callback(void);
+void test_root(void);
+void test_select_store(void);
+
+extern semanage_handle_t *sh;
+
+int handle_test_init(void)
+{
+	if (create_test_store() < 0) {
+		fprintf(stderr, "Could not create test store\n");
+		return 1;
+	}
+
+	if (write_test_policy_from_file("test_handle.policy") < 0) {
+		fprintf(stderr, "Could not write test policy\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int handle_test_cleanup(void)
+{
+	if (destroy_test_store() < 0) {
+		fprintf(stderr, "Could not destroy test store\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int handle_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "test_handle_create", test_handle_create);
+	CU_add_test(suite, "test_connect", test_connect);
+	CU_add_test(suite, "test_disconnect", test_disconnect);
+	CU_add_test(suite, "test_transaction", test_transaction);
+	CU_add_test(suite, "test_commit", test_commit);
+	CU_add_test(suite, "test_is_connected", test_is_connected);
+	CU_add_test(suite, "test_access_check", test_access_check);
+	CU_add_test(suite, "test_is_managed", test_is_managed);
+	CU_add_test(suite, "test_mls_enabled", test_mls_enabled);
+	CU_add_test(suite, "msg_set_callback", test_msg_set_callback);
+	CU_add_test(suite, "test_root", test_root);
+	CU_add_test(suite, "test_select_store", test_select_store);
+
+	return 0;
+}
+
+/* Function semanage_handle_create */
+void test_handle_create(void)
+{
+	sh = semanage_handle_create();
+	CU_ASSERT_PTR_NOT_NULL(sh);
+	semanage_handle_destroy(sh);
+}
+
+/* Function semanage_connect */
+void test_connect(void)
+{
+	/* test handle created */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_connect(sh) >= 0);
+	CU_ASSERT(semanage_disconnect(sh) >= 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* test invalid store */
+	setup_handle_invalid_store(SH_HANDLE);
+	CU_ASSERT(semanage_connect(sh) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* test normal use */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_connect(sh) >= 0);
+	CU_ASSERT(semanage_disconnect(sh) >= 0);
+	cleanup_handle(SH_HANDLE);
+}
+
+/* Function semanage_disconnect */
+void test_disconnect(void)
+{
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_disconnect(sh) >= 0);
+	cleanup_handle(SH_HANDLE);
+}
+
+/* Function semanage_begin_transaction */
+void test_transaction(void)
+{
+	/* test disconnected */
+	setup_handle(SH_CONNECT);
+	helper_disconnect();
+	CU_ASSERT(semanage_begin_transaction(sh) < 0);
+
+	cleanup_handle(SH_HANDLE);
+
+	/* test normal use */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_begin_transaction(sh) >= 0);
+	CU_ASSERT(semanage_commit(sh) >= 0);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_commit */
+void test_commit(void)
+{
+	/* test without transaction */
+	setup_handle(SH_CONNECT);
+	CU_ASSERT(semanage_commit(sh) < 0);
+
+	/* test with transaction */
+	helper_begin_transaction();
+	CU_ASSERT(semanage_commit(sh) >= 0);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_is_connected */
+void test_is_connected(void)
+{
+	/* test disconnected */
+	setup_handle(SH_HANDLE);
+	CU_ASSERT(semanage_is_connected(sh) == 0);
+
+	/* test connected */
+	helper_connect();
+	CU_ASSERT(semanage_is_connected(sh) == 1);
+
+	/* test in transaction */
+	helper_begin_transaction();
+	CU_ASSERT(semanage_is_connected(sh) == 1);
+
+	cleanup_handle(SH_TRANS);
+}
+
+/* Function semanage_access_check */
+void test_access_check(void)
+{
+	int res = 0;
+
+	/* test with handle */
+	setup_handle(SH_HANDLE);
+	res = semanage_access_check(sh);
+	CU_ASSERT(res == 0 || res == SEMANAGE_CAN_READ
+		  || res == SEMANAGE_CAN_WRITE);
+	cleanup_handle(SH_HANDLE);
+
+	/* test with invalid store */
+	setup_handle_invalid_store(SH_HANDLE);
+	CU_ASSERT(semanage_access_check(sh) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* test connected */
+	setup_handle(SH_CONNECT);
+	res = semanage_access_check(sh);
+	CU_ASSERT(res == 0 || res == SEMANAGE_CAN_READ
+		  || res == SEMANAGE_CAN_WRITE);
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_is_managed */
+void test_is_managed(void)
+{
+	int res = 0;
+
+	/* test with handle */
+	setup_handle(SH_HANDLE);
+	res = semanage_is_managed(sh);
+	CU_ASSERT(res == 0 || res == 1);
+
+	/* test connected */
+	helper_connect();
+	res = semanage_is_managed(sh);
+	CU_ASSERT(res < 0);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_mls_enabled */
+void test_mls_enabled(void)
+{
+	int res = 0;
+
+	/* test with handle */
+	setup_handle(SH_HANDLE);
+	res = semanage_mls_enabled(sh);
+	CU_ASSERT(res == 0 || res == 1);
+	cleanup_handle(SH_HANDLE);
+
+	/* test with invalid store */
+	setup_handle_invalid_store(SH_HANDLE);
+	CU_ASSERT(semanage_mls_enabled(sh) < 0);
+	cleanup_handle(SH_HANDLE);
+
+	/* test connected */
+	setup_handle(SH_CONNECT);
+	res = semanage_mls_enabled(sh);
+	CU_ASSERT(res == 0 || res == 1);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_set_callback */
+int msg_set_callback_count = 0;
+
+void helper_msg_set_callback(void *varg, semanage_handle_t *handle,
+			     const char *fmt, ...)
+{
+	msg_set_callback_count++;
+}
+
+void test_msg_set_callback(void)
+{
+	setup_handle(SH_CONNECT);
+
+	semanage_msg_set_callback(sh, helper_msg_set_callback, NULL);
+
+	/* produce error message */
+	semanage_commit(sh);
+	CU_ASSERT(msg_set_callback_count == 1);
+	semanage_msg_set_callback(sh, NULL, NULL);
+
+	/* produce error message */
+	semanage_commit(sh);
+	CU_ASSERT(msg_set_callback_count == 1);
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_root, semanage_set_root */
+void helper_root(void)
+{
+	const char *root = NULL;
+
+	CU_ASSERT(semanage_set_root("asdf") >= 0);
+	root = semanage_root();
+	CU_ASSERT_STRING_EQUAL(root, "asdf");
+
+	CU_ASSERT(semanage_set_root("") >= 0);
+	root = semanage_root();
+	CU_ASSERT_STRING_EQUAL(root, "");
+}
+
+void test_root(void)
+{
+	/* test without handle */
+	setup_handle(SH_NULL);
+	helper_root();
+
+	/* test with handle */
+	helper_handle_create();
+	helper_root();
+
+	/* test connected */
+	helper_connect();
+	helper_root();
+
+	cleanup_handle(SH_CONNECT);
+}
+
+/* Function semanage_select_store */
+void helper_select_store(const char *name, enum semanage_connect_type type,
+			 int exp_res)
+{
+	setup_handle(SH_HANDLE);
+
+	/* FIXME: the storename parameter of semanage_select_store should be
+	 * 'const char *'
+	 */
+	semanage_select_store(sh, (char *) name, type);
+
+	int res = semanage_connect(sh);
+
+	if (exp_res < 0) {
+		CU_ASSERT(res < 0);
+	} else {
+		CU_ASSERT(res >= 0);
+	}
+
+	if (res >= 0)
+		cleanup_handle(SH_CONNECT);
+	else
+		cleanup_handle(SH_HANDLE);
+}
+
+void test_select_store(void)
+{
+	helper_select_store("asdf", SEMANAGE_CON_INVALID - 1, -1);
+	helper_select_store("asdf", SEMANAGE_CON_POLSERV_REMOTE + 1, -1);
+	helper_select_store("", SEMANAGE_CON_DIRECT, 0);
+
+	helper_select_store("asdf", SEMANAGE_CON_INVALID, -1);
+	helper_select_store("asdf", SEMANAGE_CON_DIRECT, 0);
+	helper_select_store("asdf", SEMANAGE_CON_POLSERV_LOCAL, -1);
+	helper_select_store("asdf", SEMANAGE_CON_POLSERV_REMOTE, -1);
+}
diff --git a/libsemanage/tests/test_handle.cil b/libsemanage/tests/test_handle.cil
new file mode 100644
index 00000000..81690b88
--- /dev/null
+++ b/libsemanage/tests/test_handle.cil
@@ -0,0 +1,21 @@
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
diff --git a/libsemanage/tests/test_handle.h b/libsemanage/tests/test_handle.h
new file mode 100644
index 00000000..f927bd6a
--- /dev/null
+++ b/libsemanage/tests/test_handle.h
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
+#ifndef __TEST_HANDLE_H__
+#define __TEST_HANDLE_H__
+
+#include <CUnit/Basic.h>
+
+int handle_test_init(void);
+int handle_test_cleanup(void);
+int handle_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

