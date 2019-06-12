Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133FC31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C716020684
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436774AbfFLIEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436780AbfFLIEt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC7D230BDE49
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62FA378386
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:04:48 +0000 (UTC)
From:   Jan Zarsky <jzarsky@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/11] libsemanage: test semanage_context_* functions
Date:   Wed, 12 Jun 2019 10:04:03 +0200
Message-Id: <20190612080404.4529-11-jzarsky@redhat.com>
In-Reply-To: <20190612080404.4529-1-jzarsky@redhat.com>
References: <20190612080404.4529-1-jzarsky@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 08:04:48 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add new test suite for other libsemanage functions. Add tests for
semanage_context_* functions.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/tests/libsemanage-tests.c |  2 +
 libsemanage/tests/test_other.c        | 97 +++++++++++++++++++++++++++
 libsemanage/tests/test_other.h        | 30 +++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 libsemanage/tests/test_other.c
 create mode 100644 libsemanage/tests/test_other.h

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index 64039b5d..2ae4a21b 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -29,6 +29,7 @@
 #include "test_node.h"
 #include "test_port.h"
 #include "test_user.h"
+#include "test_other.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -75,6 +76,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(node);
 	DECLARE_SUITE(port);
 	DECLARE_SUITE(user);
+	DECLARE_SUITE(other);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_other.c b/libsemanage/tests/test_other.c
new file mode 100644
index 00000000..437064d2
--- /dev/null
+++ b/libsemanage/tests/test_other.c
@@ -0,0 +1,97 @@
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
+#include "test_other.h"
+
+/* context_record.h */
+void test_semanage_context(void);
+
+extern semanage_handle_t *sh;
+
+int other_test_init(void)
+{
+	return 0;
+}
+
+int other_test_cleanup(void)
+{
+	return 0;
+}
+
+int other_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "semanage_context", test_semanage_context);
+
+	return 0;
+}
+
+/* Function semanage_context_get_user, semanage_context_set_user,
+ * semanage_context_get_role, semanage_context_set_role,
+ * semanage_context_get_type, semanage_context_set_type,
+ * semanage_context_get_mls, semanage_context_set_mls,
+ * semanage_context_create, semanage_context_clone,
+ * semanage_context_free, semanage_context_from_string
+ * semanage_context_to_string
+ */
+void test_semanage_context(void)
+{
+	semanage_context_t *con = NULL;
+	semanage_context_t *con_clone = NULL;
+	char *str = NULL;
+
+	/* setup */
+	setup_handle(SH_CONNECT);
+
+	/* test */
+	CU_ASSERT(semanage_context_create(sh, &con) >= 0);
+
+	CU_ASSERT(semanage_context_set_user(sh, con, "user_u") >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_user(con), "user_u");
+	CU_ASSERT(semanage_context_set_role(sh, con, "role_r") >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_role(con), "role_r");
+	CU_ASSERT(semanage_context_set_type(sh, con, "type_t") >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_type(con), "type_t");
+	CU_ASSERT(semanage_context_set_mls(sh, con, "s0") >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_mls(con), "s0");
+
+	CU_ASSERT(semanage_context_to_string(sh, con, &str) >= 0);
+	CU_ASSERT_PTR_NOT_NULL(str);
+	assert(str);
+	CU_ASSERT_STRING_EQUAL(str, "user_u:role_r:type_t:s0");
+
+	CU_ASSERT(semanage_context_from_string(sh, "my_u:my_r:my_t:s0",
+					       &con) >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_user(con), "my_u");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_role(con), "my_r");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_type(con), "my_t");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_mls(con), "s0");
+
+	CU_ASSERT(semanage_context_clone(sh, con, &con_clone) >= 0);
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_user(con_clone), "my_u");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_role(con_clone), "my_r");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_type(con_clone), "my_t");
+	CU_ASSERT_STRING_EQUAL(semanage_context_get_mls(con_clone), "s0");
+
+	/* cleanup */
+	semanage_context_free(con);
+	semanage_context_free(con_clone);
+	cleanup_handle(SH_CONNECT);
+}
diff --git a/libsemanage/tests/test_other.h b/libsemanage/tests/test_other.h
new file mode 100644
index 00000000..40d2dcf8
--- /dev/null
+++ b/libsemanage/tests/test_other.h
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
+#ifndef __TEST_OTHER_H__
+#define __TEST_OTHER_H__
+
+#include <CUnit/Basic.h>
+
+int other_test_init(void);
+int other_test_cleanup(void);
+int other_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.20.1

