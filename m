Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0ECCA48B
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiGUPFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGUPF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E73103C
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so3657729ejc.7
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HPb0WywPmHCsodz3CE1XuwT7afX8HUvoV56PY6zvrcI=;
        b=m1Rn83iwGLHtWcGM1JAJYUHGqCcaNNvd3Q820LBSEVsZ6bCvX804p1rEwRALfW+tG7
         IJ3OH3OZn7+sqw4Rlgp1Uf9efR6DV+hcZ/OrV4/nLiueKR7b/XETbqBZqUsty0MVHpir
         Q3tCRY3NQWQiX3Y8eBhWU4Tlu0nfKpMCb3byw/9FogtdoGE1B8nmPESm2u/DWjakVizP
         hdPGSDsOR/hGI83zClFbIsLHuSAtsijw32Z3Z7siQ7hIiujgoYxR5KcgRZtAvtg2CjSQ
         duK2f7Z9H1iR1/ck3OgyG/n7NpHhM6yJ4iR6Crd5EdhkQPj8YTxL+d9WNfutMR37tF3y
         mB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPb0WywPmHCsodz3CE1XuwT7afX8HUvoV56PY6zvrcI=;
        b=TSTiyy0XfGxFP+PihGh4/t9PYvXQ8tianCy8Nu2kXoAjh9y4LIxXhb++qDAbVSvqoj
         RqUDHUMD7DKZnYi4K94g7noYi8rQ/ujoAPOYYkt21pjWR8hvFaDq3iM+Z//vNW8j3wAC
         HULumdNIwR+w20wyFSbP7Ja1xJF/aE6HcTx2HoUZy43TVn/m3/icWZcO7lvYMoTe6Y+B
         iky3jW4gvRqbF5CMX4euoTm+0WRDhKmUAQt+1HULNJPqcZ1vvCpg/bMQyJLpuOm+fC96
         IBnaUN6nUw/Fd28fipVQebVY1yRbM982hInkl8v1YxGrWHkCISoLQg6mwuauG1Cauiwl
         x+4Q==
X-Gm-Message-State: AJIora/rNF6oRjRCt6oMyL4kuSwNLpa+lMiUIiTzYj6WZX9Mg2KtqxRH
        KogXfri3ow6LjLj8ZnVvl2orlnfCELTRtg==
X-Google-Smtp-Source: AGRyM1tH7nIcO4wbTlABBwAVepw8iJg5/ziMHkF2U5xEXvg5jqebKCpI1VP2VeTnZDIPazlwt0i9bg==
X-Received: by 2002:a17:907:2d12:b0:72b:67fb:89a5 with SMTP id gs18-20020a1709072d1200b0072b67fb89a5mr39709219ejc.507.1658415925479;
        Thu, 21 Jul 2022 08:05:25 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 5/8] libsepol/tests: add test for segregate attributes
Date:   Thu, 21 Jul 2022 17:05:12 +0200
Message-Id: <20220721150515.19843-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/libsepol-tests.c               |   2 +
 .../tests/policies/test-sattrs/single.conf    |  87 ++++++++
 .../policies/test-sattrs/split_base.conf      |  53 +++++
 .../policies/test-sattrs/split_module1.conf   |   9 +
 .../policies/test-sattrs/split_module2.conf   |   9 +
 .../policies/test-sattrs/split_module3.conf   |   9 +
 libsepol/tests/test-segregateattributes.c     | 197 ++++++++++++++++++
 libsepol/tests/test-segregateattributes.h     |  10 +
 8 files changed, 376 insertions(+)
 create mode 100644 libsepol/tests/policies/test-sattrs/single.conf
 create mode 100644 libsepol/tests/policies/test-sattrs/split_base.conf
 create mode 100644 libsepol/tests/policies/test-sattrs/split_module1.conf
 create mode 100644 libsepol/tests/policies/test-sattrs/split_module2.conf
 create mode 100644 libsepol/tests/policies/test-sattrs/split_module3.conf
 create mode 100644 libsepol/tests/test-segregateattributes.c
 create mode 100644 libsepol/tests/test-segregateattributes.h

diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index dc8fd5ce..989c7cd3 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -23,6 +23,7 @@
 #include "test-expander.h"
 #include "test-deps.h"
 #include "test-downgrade.h"
+#include "test-segregateattributes.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -69,6 +70,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(expander);
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(downgrade);
+	DECLARE_SUITE(sattrs);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-sattrs/single.conf b/libsepol/tests/policies/test-sattrs/single.conf
new file mode 100644
index 00000000..1666f842
--- /dev/null
+++ b/libsepol/tests/policies/test-sattrs/single.conf
@@ -0,0 +1,87 @@
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+
+sid kernel
+sid security
+sid unlabeled
+sid file
+sid port
+sid netif
+sid netmsg
+sid node
+sid devnull
+
+class process { dyntransition transition }
+class file { write }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0; category c1; category c2; category c3;
+category c4; category c5; category c6; category c7;
+category c8; category c9; category c10; category c11;
+category c12; category c13; category c14; category c15;
+category c16; category c17; category c18; category c19;
+category c20; category c21; category c22; category c23;
+
+level s0:c0.c23;
+
+mlsconstrain file { write } ( h1 dom h2 );
+')
+
+#
+# Test start
+#
+
+attribute test1_attr1;
+attribute test1_attr2;
+type test1_type;
+typeattribute test1_type test1_attr1;
+typeattribute test1_type test1_attr2;
+segregate_attributes test1_attr1, test1_attr2;
+
+
+attribute test2_attr1;
+attribute test2_attr2;
+attribute test2_attr3;
+type test2_type1;
+type test2_type2;
+type test2_type3;
+type test2_type4;
+typeattribute test2_type1 test2_attr1;
+typeattribute test2_type1 test2_attr2;
+typeattribute test2_type2 test2_attr1;
+typeattribute test2_type2 test2_attr3;
+typeattribute test2_type3 test2_attr2;
+typeattribute test2_type3 test2_attr3;
+typeattribute test2_type4 test2_attr1;
+typeattribute test2_type4 test2_attr2;
+typeattribute test2_type4 test2_attr3;
+segregate_attributes test2_attr1, test2_attr2, test2_attr3;
+
+#
+# Test End
+#
+
+type sys_isid;
+allow sys_isid self : process { dyntransition transition };
+role sys_role;
+role sys_role types sys_isid;
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0.c23)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
+sid security gen_context(sys_user:sys_role:sys_isid, s0)
+sid unlabeled gen_context(sys_user:sys_role:sys_isid, s0)
+sid file gen_context(sys_user:sys_role:sys_isid, s0)
+sid port gen_context(sys_user:sys_role:sys_isid, s0)
+sid netif gen_context(sys_user:sys_role:sys_isid, s0)
+sid netmsg gen_context(sys_user:sys_role:sys_isid, s0)
+sid node gen_context(sys_user:sys_role:sys_isid, s0)
+sid devnull gen_context(sys_user:sys_role:sys_isid, s0)
+fs_use_trans devpts gen_context(sys_user:sys_role:sys_isid, s0);
+fs_use_trans devtmpfs gen_context(sys_user:sys_role:sys_isid, s0);
diff --git a/libsepol/tests/policies/test-sattrs/split_base.conf b/libsepol/tests/policies/test-sattrs/split_base.conf
new file mode 100644
index 00000000..6fba8cdd
--- /dev/null
+++ b/libsepol/tests/policies/test-sattrs/split_base.conf
@@ -0,0 +1,53 @@
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+
+sid kernel
+sid security
+sid unlabeled
+sid file
+sid port
+sid netif
+sid netmsg
+sid node
+sid devnull
+
+class process { dyntransition transition }
+class file { write }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0; category c1; category c2; category c3;
+category c4; category c5; category c6; category c7;
+category c8; category c9; category c10; category c11;
+category c12; category c13; category c14; category c15;
+category c16; category c17; category c18; category c19;
+category c20; category c21; category c22; category c23;
+
+level s0:c0.c23;
+
+mlsconstrain file { write } ( h1 dom h2 );
+')
+
+type sys_isid;
+allow sys_isid self : process { dyntransition transition };
+role sys_role;
+role sys_role types sys_isid;
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0.c23)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
+sid security gen_context(sys_user:sys_role:sys_isid, s0)
+sid unlabeled gen_context(sys_user:sys_role:sys_isid, s0)
+sid file gen_context(sys_user:sys_role:sys_isid, s0)
+sid port gen_context(sys_user:sys_role:sys_isid, s0)
+sid netif gen_context(sys_user:sys_role:sys_isid, s0)
+sid netmsg gen_context(sys_user:sys_role:sys_isid, s0)
+sid node gen_context(sys_user:sys_role:sys_isid, s0)
+sid devnull gen_context(sys_user:sys_role:sys_isid, s0)
+fs_use_trans devpts gen_context(sys_user:sys_role:sys_isid, s0);
+fs_use_trans devtmpfs gen_context(sys_user:sys_role:sys_isid, s0);
diff --git a/libsepol/tests/policies/test-sattrs/split_module1.conf b/libsepol/tests/policies/test-sattrs/split_module1.conf
new file mode 100644
index 00000000..52b5f248
--- /dev/null
+++ b/libsepol/tests/policies/test-sattrs/split_module1.conf
@@ -0,0 +1,9 @@
+module sattrs_test_1 1.0;
+
+require {
+	type test_type_t;
+}
+
+attribute attr1;
+
+typeattribute test_type_t attr1;
diff --git a/libsepol/tests/policies/test-sattrs/split_module2.conf b/libsepol/tests/policies/test-sattrs/split_module2.conf
new file mode 100644
index 00000000..6b6128f7
--- /dev/null
+++ b/libsepol/tests/policies/test-sattrs/split_module2.conf
@@ -0,0 +1,9 @@
+module sattrs_test_2 1.0;
+
+require {
+	type test_type_t;
+}
+
+attribute attr2;
+
+typeattribute test_type_t attr2;
diff --git a/libsepol/tests/policies/test-sattrs/split_module3.conf b/libsepol/tests/policies/test-sattrs/split_module3.conf
new file mode 100644
index 00000000..050b9228
--- /dev/null
+++ b/libsepol/tests/policies/test-sattrs/split_module3.conf
@@ -0,0 +1,9 @@
+module sattrs_test_3 1.0;
+
+require {
+	attribute attr1, attr2;
+}
+
+type test_type_t;
+
+segregate_attributes attr1, attr2;
diff --git a/libsepol/tests/test-segregateattributes.c b/libsepol/tests/test-segregateattributes.c
new file mode 100644
index 00000000..4a21fb06
--- /dev/null
+++ b/libsepol/tests/test-segregateattributes.c
@@ -0,0 +1,197 @@
+#define _GNU_SOURCE
+
+#include "test-segregateattributes.h"
+
+#include "helpers.h"
+#include "test-common.h"
+
+#include <sepol/debug.h>
+#include <sepol/policydb/link.h>
+#include <sepol/policydb/expand.h>
+
+#include <stdio.h>
+#include <stdarg.h>
+
+extern int mls;
+
+int sattrs_test_init(void)
+{
+	return 0;
+}
+
+int sattrs_test_cleanup(void)
+{
+	return 0;
+}
+
+static struct msg_list {
+	char *msg;
+	struct msg_list *next;
+} *messages;
+
+static void messages_clean(void)
+{
+	while (messages) {
+		struct msg_list *n = messages->next;
+		free(messages->msg);
+		free(messages);
+		messages = n;
+	}
+}
+
+static void messages_check(unsigned count, const char *const expected[count])
+{
+	unsigned i;
+	const struct msg_list *m = messages;
+
+	for (i = 0; i < count; i++, m = m->next) {
+		if (!m) {
+			CU_FAIL("less messages than expected");
+			return;
+		}
+
+		if (strcmp(expected[i], m->msg) != 0) {
+			CU_FAIL("messages differs from expected");
+			fprintf(stderr, "\n<expected: '%s', got: '%s'>\n", expected[i], m->msg);
+		}
+	}
+
+	if (m) {
+		CU_FAIL("more messages than expected");
+		fprintf(stderr, "\n<next message: '%s'>\n", m->msg);
+	}
+}
+
+#ifdef __GNUC__
+__attribute__ ((format(printf, 3, 4)))
+#endif
+static void msg_handler(void *varg __attribute__ ((unused)),
+			sepol_handle_t * handle,
+			const char *fmt, ...)
+{
+	char *msg;
+	va_list ap;
+
+	va_start(ap, fmt);
+	vasprintf(&msg, fmt, ap);
+	va_end(ap);
+
+	struct msg_list *new = malloc(sizeof(struct msg_list));
+	new->msg = msg;
+	new->next = messages;
+	messages = new;
+}
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*a))
+
+static void test_sattrs_single(void)
+{
+	policydb_t basemod, base_expanded;
+	sepol_handle_t *handle;
+	const char *const expected_messages[] = {
+		"7 Segregate Attributes failures occurred",
+		"Segregate Attributes violation, type test1_type associated with attributes test1_attr1 and test1_attr2",
+		"Segregate Attributes violation, type test2_type3 associated with attributes test2_attr2 and test2_attr3",
+		"Segregate Attributes violation, type test2_type4 associated with attributes test2_attr2 and test2_attr3",
+		"Segregate Attributes violation, type test2_type2 associated with attributes test2_attr1 and test2_attr3",
+		"Segregate Attributes violation, type test2_type4 associated with attributes test2_attr1 and test2_attr3",
+		"Segregate Attributes violation, type test2_type1 associated with attributes test2_attr1 and test2_attr2",
+		"Segregate Attributes violation, type test2_type4 associated with attributes test2_attr1 and test2_attr2",
+	};
+
+	if (policydb_init(&base_expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (test_load_policy(&basemod, POLICY_BASE, mls, "test-sattrs", "single.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (expand_module(NULL, &basemod, &base_expanded, 0, 0))
+		CU_FAIL_FATAL("Failed to expand policy");
+
+	if ((handle = sepol_handle_create()) == NULL)
+		CU_FAIL_FATAL("Failed to initialize handle");
+
+	sepol_msg_set_callback(handle, msg_handler, NULL);
+
+	if (check_assertions(handle, &base_expanded, NULL) != -1)
+		CU_FAIL("Assertions did not trigger");
+
+	messages_check(ARRAY_SIZE(expected_messages), expected_messages);
+
+	sepol_handle_destroy(handle);
+	messages_clean();
+	policydb_destroy(&basemod);
+	policydb_destroy(&base_expanded);
+}
+
+#define NUM_MODS 3
+
+static void test_sattrs_split(void)
+{
+	policydb_t basemod, base_expanded;
+	policydb_t *modules[NUM_MODS];
+	const char *policies[NUM_MODS] = { "split_module1.conf", "split_module2.conf", "split_module3.conf" };
+	sepol_handle_t *handle;
+	const char *const expected_messages[] = {
+		"1 Segregate Attributes failures occurred",
+		"Segregate Attributes violation, type test_type_t associated with attributes attr1 and attr2",
+	};
+	unsigned i;
+
+	if (policydb_init(&base_expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (test_load_policy(&basemod, POLICY_BASE, mls, "test-sattrs", "split_base.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	for (i = 0; i < NUM_MODS; i++) {
+		modules[i] = calloc(1, sizeof(*modules[i]));
+		if (!modules[i])
+			CU_FAIL_FATAL("Failed to allocate module");
+
+		if (test_load_policy(modules[i], POLICY_MOD, mls, "test-sattrs", policies[i]))
+			CU_FAIL_FATAL("Failed to load module");
+	}
+
+	if (link_modules(NULL, &basemod, modules, 3, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (expand_module(NULL, &basemod, &base_expanded, 0, 0))
+		CU_FAIL_FATAL("Failed to expand policy");
+
+	if ((handle = sepol_handle_create()) == NULL)
+		CU_FAIL_FATAL("Failed to initialize handle");
+
+	sepol_msg_set_callback(handle, msg_handler, NULL);
+
+	if (check_assertions(handle, &base_expanded, NULL) != -1)
+		CU_FAIL("Assertions did not trigger");
+
+	messages_check(ARRAY_SIZE(expected_messages), expected_messages);
+
+	sepol_handle_destroy(handle);
+	messages_clean();
+	for (i = 0; i < NUM_MODS; i++) {
+		policydb_destroy(modules[i]);
+		free(modules[i]);
+	}
+	policydb_destroy(&basemod);
+	policydb_destroy(&base_expanded);
+}
+
+int sattrs_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "sattrs_single", test_sattrs_single)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "sattrs_split", test_sattrs_split)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
diff --git a/libsepol/tests/test-segregateattributes.h b/libsepol/tests/test-segregateattributes.h
new file mode 100644
index 00000000..a63c59f4
--- /dev/null
+++ b/libsepol/tests/test-segregateattributes.h
@@ -0,0 +1,10 @@
+#ifndef TEST_SEGREGATEATTRIBUTES_H__
+#define TEST_SEGREGATEATTRIBUTES_H__
+
+#include <CUnit/Basic.h>
+
+int sattrs_test_init(void);
+int sattrs_test_cleanup(void);
+int sattrs_add_tests(CU_pSuite suite);
+
+#endif  /* TEST_SEGREGATEATTRIBUTES_H__ */
-- 
2.36.1

