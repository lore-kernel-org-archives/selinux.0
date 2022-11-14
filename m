Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E9C433FE
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKNTkl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNTkj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 14:40:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B61A235
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:40:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m22so30825277eji.10
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWxyOqo1fpHKqM1GvKu8sQbSBYBSBX/tkUMHB6hnKqY=;
        b=hFHYFM6ifSfE7X9pgqV3PRkV6AzQFHcsCHldk8lj+KBQvnlXXCqf0f7/5KiPsMB+X1
         Q/CEF1QhA4BsN7D9vsjlL2tHVpH0Hg/jUY34Ln8n30iElNeEplhmMZM8VBsG+Y7k2PpT
         EjDRM6qZZm3EWA+eXjguPiElrmE3af0MuaKsHUvH0QYwTlvSQOE4dSweCYxfJYtJIxz8
         DH8+dK8Te94bRd/jXzYMAu+LTxrJZ6Xoe8vZgJD40WeHda2LtTvG4SqPAbmbcGl+WUwZ
         pq/bVYrV8XmccL/ROZePPuNcZxZT2FsBqwRabDr0bPBLQ8HvRfWsSrRc0fz4G1ggqBYY
         ROyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWxyOqo1fpHKqM1GvKu8sQbSBYBSBX/tkUMHB6hnKqY=;
        b=ZM0MlroARSNJICn6MiHk8NNItlLGHgAParxF6YZbIeQI0B97YR7GFOjzcbdAFi0cgC
         7Hv+HguXDXIKCwwJDKvkKd79JBYk7Z1P1KIabsNpT/4Kd08v2Z/EEQterOJpY8x9xEwa
         vDL5bbo0t/Q8tjan9ZpNwWu/uvqYseczheumkBcoMdNoRJI/D8b8Y0xULWOjeLY5l8pv
         83lRQ2rGAHzvFTgahKMucVLuo4lXYx8h2G4O8w3Rse66scvMq41fmoDmGLZh58fVaamu
         1g5wr8J8EM7TsaUEb0T6MEXt/FHquNaWs1SxCJiv/k7zdNlQdgwm2WArD6hOvyma7RUy
         LKnQ==
X-Gm-Message-State: ANoB5plytwztq+CXE7wpe1CZpGbEi+HlwWdTAKIyqZ+eZV1k6kvoX3Bg
        xesPC7gJAR84jXyg4BonwkU1IOdu90o=
X-Google-Smtp-Source: AA0mqf7tY1CXQQVqzHmXv7rM6m3ZZ2L+1LBBvO4bZdVanxkspbKX1JzqLFBmT1/XRed5PwRXGxYmqg==
X-Received: by 2002:a17:907:1b89:b0:7ad:b51d:39d0 with SMTP id mz9-20020a1709071b8900b007adb51d39d0mr11055325ejc.571.1668454836394;
        Mon, 14 Nov 2022 11:40:36 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id kz7-20020a17090777c700b00772061034dbsm4500016ejc.182.2022.11.14.11.40.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:40:36 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol/tests: add tests for neverallow assertions
Date:   Mon, 14 Nov 2022 20:40:31 +0100
Message-Id: <20221114194031.12245-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114194031.12245-1-cgzones@googlemail.com>
References: <20221114194031.12245-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add tests for neverallow assertion checks.
This creates a foundation for the status quo, and enables to spot
regressions in future changes to the - quite complex - assertion logic.
One example is the support for not-self rules.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/libsepol-tests.c               |   2 +
 .../policies/test-neverallow/policy.conf      | 298 ++++++++++++++++++
 libsepol/tests/test-neverallow.c              | 172 ++++++++++
 libsepol/tests/test-neverallow.h              |  10 +
 4 files changed, 482 insertions(+)
 create mode 100644 libsepol/tests/policies/test-neverallow/policy.conf
 create mode 100644 libsepol/tests/test-neverallow.c
 create mode 100644 libsepol/tests/test-neverallow.h

diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 5ae6bedc..968e3cc2 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -24,6 +24,7 @@
 #include "test-expander.h"
 #include "test-deps.h"
 #include "test-downgrade.h"
+#include "test-neverallow.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -71,6 +72,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(expander);
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(downgrade);
+	DECLARE_SUITE(neverallow);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-neverallow/policy.conf b/libsepol/tests/policies/test-neverallow/policy.conf
new file mode 100644
index 00000000..67a16372
--- /dev/null
+++ b/libsepol/tests/policies/test-neverallow/policy.conf
@@ -0,0 +1,298 @@
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
+class file { getattr ioctl open read write }
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
+
+########################################
+#
+# Test start
+#
+########################################
+
+
+## Test 1 (basic)
+
+type test1_t;
+allow      test1_t test1_t : file { read write };
+neverallow test1_t test1_t : file read;
+
+
+## Test 2 (wildcard permission)
+
+type test2_t;
+allow      test2_t test2_t : file { read write };
+neverallow test2_t test2_t : file *;
+
+
+## Test 3 (complement permission)
+
+type test3_t;
+allow      test3_t test3_t : file { read write };
+neverallow test3_t test3_t : file ~{ write };
+
+
+## Test 4 (wildcard source)
+
+type test4_t;
+allow      test4_t test4_t : file { read write };
+neverallow *       test4_t : file read;
+
+
+## Test 5 (wildcard target)
+
+type test5_t;
+allow      test5_t test5_t : file { read write };
+neverallow test5_t *       : file read;
+
+
+## Test 6 (complement source)
+
+type test6_1_t;
+type test6_2_t;
+allow      { test6_1_t test6_2_t } { test6_1_t test6_2_t } : file { read write };
+neverallow ~{ test6_2_t }          test6_1_t               : file read;
+
+
+## Test 7 (complement target)
+
+type test7_1_t;
+type test7_2_t;
+allow      { test7_1_t test7_2_t } { test7_1_t test7_2_t } : file { read write };
+neverallow test7_1_t               ~{ test7_2_t }          : file read;
+
+
+## Test 8 (source attribute)
+
+attribute test8_a;
+type test8_t, test8_a;
+allow      test8_a test8_a : file read;
+allow      test8_t test8_t : file write;
+neverallow test8_a test8_t : file { read write };
+
+
+## Test 9 (target attribute)
+
+attribute test9_a;
+type test9_t, test9_a;
+allow      test9_a test9_a : file read;
+allow      test9_t test9_t : file write;
+neverallow test9_t test9_a : file { read write };
+
+
+## Test 10 (self)
+
+attribute test10_a;
+type test10_1_t, test10_a;
+type test10_2_t;
+allow      { test10_1_t test10_2_t } { test10_1_t test10_2_t } : file read;
+neverallow test10_a                  self                      : file *;
+
+
+## Test 11 (wildcard)
+
+type test11_t;
+allow      test11_t self : process *;
+neverallow *        *    : process *;
+
+
+## Test 12 (complement attributes)
+
+attribute test12_1_a;
+attribute test12_2_a;
+attribute test12_3_a;
+type test12_1_t, test12_1_a;
+type test12_2_t, test12_2_a;
+type test12_3_t, test12_3_a;
+allow     { test12_1_a test12_2_a test12_3_a } { test12_1_a test12_2_a test12_3_a } : file *;
+neverallow ~{ test12_1_a test12_2_t }          ~{ test12_3_a }                      : file getattr;
+neverallow ~{ test12_1_a }                     ~{ test12_2_a test12_3_t }           : file open;
+
+
+## Test 13 (excludes)
+
+attribute test13_1_a;
+attribute test13_2_a;
+attribute test13_3_a;
+type test13_1_t, test13_1_a;
+type test13_2_t, test13_2_a;
+type test13_3_t, test13_3_a;
+allow      { test13_1_a test13_2_a test13_3_a }                         { test13_1_a test13_2_a test13_3_a }                         : file { read write };
+neverallow { test13_1_a test13_2_a test13_3_a -test13_2_a -test13_3_t } { test13_1_a test13_2_a test13_3_a -test13_2_t -test13_3_a } : file read;
+
+
+## Test 14 (misc avrules)
+
+type test14_t;
+auditallow      test14_t test14_t : file read;
+dontaudit       test14_t test14_t : file write;
+neverallow      test14_t test14_t : file { read write };
+type_transition test14_t test14_t : file test14_t;
+type_transition test14_t test14_t : file test14_t "objname";
+neverallow      test14_t test14_t : file *;  # nofail
+
+
+## Test 15 (extended permissions - standard allow)
+
+type test15_t;
+allow           test15_t self : file ioctl;
+neverallowxperm test15_t self : file ioctl 0x1111;
+
+
+## Test 16 (extended permissions - allowxperm)
+
+type test16_t;
+allow           test16_t self : file ioctl;
+allowxperm      test16_t self : file ioctl 0x1111;
+neverallowxperm test16_t self : file ioctl 0x1111;
+
+
+## Test 17 (extended permissions - allowxperm mismatch)
+
+type test17_t;
+allow           test17_t self : file ioctl;
+allowxperm      test17_t self : file ioctl 0x1111;
+neverallowxperm test17_t self : file ioctl 0x2222;  # nofail
+
+
+## Test 18 (extended permissions - allowxperm range I)
+
+type test18_t;
+allow           test18_t self : file ioctl;
+allowxperm      test18_t self : file ioctl { 0x1100-0x1300 };
+neverallowxperm test18_t self : file ioctl 0x1111;
+
+
+## Test 19 (extended permissions - allowxperm range II)
+
+type test19_t;
+allow           test19_t self : file ioctl;
+allowxperm      test19_t self : file ioctl 0x1111;
+neverallowxperm test19_t self : file ioctl { 0x1100-0x1300 };
+
+
+## Test 20 (extended permissions - misc targets I)
+
+attribute test20_a;
+type test20_t, test20_a;
+
+allow           test20_a test20_a : file ioctl;
+allowxperm      test20_a test20_a : file ioctl 0x1111;
+neverallowxperm test20_a self     : file ioctl 0x1111;
+
+
+## Test 21 (extended permissions - misc targets II)
+
+attribute test21_1_a;
+attribute test21_2_a;
+type test21_t, test21_1_a, test21_2_a;
+
+allow           test21_1_a test21_1_a : file ioctl;
+allowxperm      test21_1_a test21_2_a : file ioctl 0x1111;
+neverallowxperm test21_1_a self       : file ioctl 0x1111;
+
+
+## Test 22 (extended permissions - misc targets III)
+
+attribute test22_a;
+type test22_t, test22_a;
+
+allow           test22_a test22_a : file ioctl;
+allowxperm      test22_t self     : file ioctl 0x1111;
+neverallowxperm test22_a self     : file ioctl 0x1111;
+
+
+## Test 23 (extended permissions - misc targets IV)
+
+attribute test23_a;
+type test23_t, test23_a;
+
+allow           test23_a test23_a : file ioctl;
+allowxperm      test23_t test23_t : file ioctl 0x1111;
+neverallowxperm test23_a self     : file ioctl 0x1111;
+
+
+## Test 24 (extended permissions - misc targets V)
+
+attribute test24_a;
+type test24_t, test24_a;
+
+allow           test24_a test24_a : file ioctl;
+allowxperm      test24_t test24_a : file ioctl 0x1111;
+neverallowxperm test24_a self     : file ioctl 0x1111;
+
+
+## Test 25 (extended permissions - misc targets VI)
+
+attribute test25_a;
+type test25_t, test25_a;
+
+allow           test25_a test25_a : file ioctl;
+allowxperm      test25_a self     : file ioctl 0x1111;
+neverallowxperm test25_a self     : file ioctl 0x1111;
+
+
+## Test 26 (extended permissions - assert twice)
+
+attribute test26_a;
+type test26_1_t, test26_a;
+type test26_2_t, test26_a;
+allow           test26_a   test26_a : file ioctl;
+allowxperm      test26_a   test26_a : file ioctl 0x1111;
+neverallowxperm test26_1_t test26_a : file ioctl 0x1111;
+
+
+########################################
+#
+# Test End
+#
+########################################
+
+
+type sys_isid;
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
diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-neverallow.c
new file mode 100644
index 00000000..d973a0e3
--- /dev/null
+++ b/libsepol/tests/test-neverallow.c
@@ -0,0 +1,172 @@
+#define _GNU_SOURCE  /* vasprintf(3) */
+
+#include "test-neverallow.h"
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
+int neverallow_test_init(void)
+{
+	return 0;
+}
+
+int neverallow_test_cleanup(void)
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
+			fprintf(stderr, "\n<expected %u, got %u>\n", count, i);
+			return;
+		}
+
+		if (strcmp(expected[i], m->msg) != 0) {
+			CU_FAIL("messages differ from expected");
+			fprintf(stderr, "\n<expected: '''%s''', got: '''%s'''>\n", expected[i], m->msg);
+		}
+	}
+
+	if (m) {
+		CU_FAIL("more messages than expected");
+		fprintf(stderr, "\n<expected %u; next message: '''%s'''>\n", count, m->msg);
+	}
+}
+
+__attribute__ ((format(printf, 3, 4)))
+static void msg_handler(void *varg __attribute__ ((unused)),
+			sepol_handle_t * handle __attribute__ ((unused)),
+			const char *fmt, ...)
+{
+	char *msg;
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = vasprintf(&msg, fmt, ap);
+	if (r < 0)
+		CU_FAIL_FATAL("oom");
+	va_end(ap);
+
+	struct msg_list *new = malloc(sizeof(*new));
+	if (!new)
+		CU_FAIL_FATAL("oom");
+	new->msg = msg;
+	new->next = messages;
+	messages = new;
+}
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*a))
+
+static void test_neverallow_basic(void)
+{
+	policydb_t basemod, base_expanded;
+	sepol_handle_t *handle;
+	static const char *const expected_messages[] = {
+		"30 neverallow failures occurred",
+		"neverallow on line 53 of policies/test-neverallow/policy.conf.std (or line 53 of policies/test-neverallow/policy.conf.std) violated by allow test1_t test1_t:file { read };",
+		"neverallow on line 60 of policies/test-neverallow/policy.conf.std (or line 60 of policies/test-neverallow/policy.conf.std) violated by allow test2_t test2_t:file { read write };",
+		"neverallow on line 67 of policies/test-neverallow/policy.conf.std (or line 67 of policies/test-neverallow/policy.conf.std) violated by allow test3_t test3_t:file { read };",
+		"neverallow on line 74 of policies/test-neverallow/policy.conf.std (or line 74 of policies/test-neverallow/policy.conf.std) violated by allow test4_t test4_t:file { read };",
+		"neverallow on line 81 of policies/test-neverallow/policy.conf.std (or line 81 of policies/test-neverallow/policy.conf.std) violated by allow test5_t test5_t:file { read };",
+		"neverallow on line 89 of policies/test-neverallow/policy.conf.std (or line 89 of policies/test-neverallow/policy.conf.std) violated by allow test6_1_t test6_1_t:file { read };",
+		"neverallow on line 97 of policies/test-neverallow/policy.conf.std (or line 97 of policies/test-neverallow/policy.conf.std) violated by allow test7_1_t test7_1_t:file { read };",
+		"neverallow on line 106 of policies/test-neverallow/policy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violated by allow test8_t test8_t:file { write };",
+		"neverallow on line 106 of policies/test-neverallow/policy.conf.std (or line 106 of policies/test-neverallow/policy.conf.std) violated by allow test8_t test8_t:file { read };",
+		"neverallow on line 115 of policies/test-neverallow/policy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violated by allow test9_t test9_t:file { read };",
+		"neverallow on line 115 of policies/test-neverallow/policy.conf.std (or line 115 of policies/test-neverallow/policy.conf.std) violated by allow test9_t test9_t:file { write };",
+		"neverallow on line 124 of policies/test-neverallow/policy.conf.std (or line 124 of policies/test-neverallow/policy.conf.std) violated by allow test10_1_t test10_1_t:file { read };",
+		"neverallow on line 131 of policies/test-neverallow/policy.conf.std (or line 131 of policies/test-neverallow/policy.conf.std) violated by allow test11_t test11_t:process { dyntransition transition };",
+		"neverallow on line 143 of policies/test-neverallow/policy.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violated by allow test12_3_t test12_1_t:file { getattr };",
+		"neverallow on line 143 of policies/test-neverallow/policy.conf.std (or line 143 of policies/test-neverallow/policy.conf.std) violated by allow test12_3_t test12_2_t:file { getattr };",
+		"neverallow on line 144 of policies/test-neverallow/policy.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violated by allow test12_3_t test12_1_t:file { open };",
+		"neverallow on line 144 of policies/test-neverallow/policy.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violated by allow test12_2_t test12_1_t:file { open };",
+		"neverallow on line 156 of policies/test-neverallow/policy.conf.std (or line 156 of policies/test-neverallow/policy.conf.std) violated by allow test13_1_t test13_1_t:file { read };",
+		"neverallowxperm on line 174 of policies/test-neverallow/policy.conf.std (or line 174 of policies/test-neverallow/policy.conf.std) violated by\nallow test15_t test15_t:file { ioctl };",
+		"neverallowxperm on line 182 of policies/test-neverallow/policy.conf.std (or line 182 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test16_t test16_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 198 of policies/test-neverallow/policy.conf.std (or line 198 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test18_t test18_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 206 of policies/test-neverallow/policy.conf.std (or line 206 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test19_t test19_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 216 of policies/test-neverallow/policy.conf.std (or line 216 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test20_a test20_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 227 of policies/test-neverallow/policy.conf.std (or line 227 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test21_1_a test21_2_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 237 of policies/test-neverallow/policy.conf.std (or line 237 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test22_t test22_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 247 of policies/test-neverallow/policy.conf.std (or line 247 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test23_t test23_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 257 of policies/test-neverallow/policy.conf.std (or line 257 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test24_t test24_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 267 of policies/test-neverallow/policy.conf.std (or line 267 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test25_t test25_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
+	};
+
+	if (policydb_init(&base_expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (test_load_policy(&basemod, POLICY_BASE, mls, "test-neverallow", "policy.conf"))
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
+	if (check_assertions(handle, &base_expanded, base_expanded.global->branch_list->avrules) != -1)
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
+int neverallow_add_tests(CU_pSuite suite)
+{
+	/*
+	 * neverallow rules operate only on types and are unaffected by MLS
+	 * (avoid adjusting the messages for std and mls)
+	 */
+	if (mls)
+		return 0;
+
+	if (NULL == CU_add_test(suite, "neverallow_basic", test_neverallow_basic)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
+	return 0;
+}
diff --git a/libsepol/tests/test-neverallow.h b/libsepol/tests/test-neverallow.h
new file mode 100644
index 00000000..d3c2a74e
--- /dev/null
+++ b/libsepol/tests/test-neverallow.h
@@ -0,0 +1,10 @@
+#ifndef TEST_NEVERALLOW_H__
+#define TEST_NEVERALLOW_H__
+
+#include <CUnit/Basic.h>
+
+int neverallow_test_init(void);
+int neverallow_test_cleanup(void);
+int neverallow_add_tests(CU_pSuite suite);
+
+#endif  /* TEST_NEVERALLOW_H__ */
-- 
2.38.1

