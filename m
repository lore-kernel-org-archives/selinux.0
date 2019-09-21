Return-Path: <SRS0=790g=XQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F1AC4360D
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970C5208C0
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfIUVav (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Sep 2019 17:30:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47599 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIUVav (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Sep 2019 17:30:51 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6A0F7564874
        for <selinux@vger.kernel.org>; Sat, 21 Sep 2019 23:30:48 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol, libsemanage: add a macro to silence static analyzer warnings in tests
Date:   Sat, 21 Sep 2019 23:30:46 +0200
Message-Id: <20190921213046.1121337-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Sep 21 23:30:48 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Several static analyzers (clang's one, Facebook Infer, etc.) warn about
NULL pointer dereferences after a call to CU_ASSERT_PTR_NOT_NULL_FATAL()
in the test code written using CUnit framework. This is because this
CUnit macro is too complex for them to understand that the pointer
cannot be NULL: it is translated to a call to CU_assertImplementation()
with an argument as TRUE in order to mean that the call is fatal if the
asserted condition failed (cf.
http://cunit.sourceforge.net/doxdocs/group__Framework.html).

A possible solution could consist in replacing the
CU_ASSERT_..._FATAL() calls by assert() ones, as most static analyzers
know about assert(). Nevertheless this seems to go against CUnit's API.

An alternative solution consists in overriding CU_ASSERT_..._FATAL()
macros in order to expand to assert() after a call to the matching
CU_ASSERT_...() non-fatal macro. This appears to work fine and to remove
many false-positive warnings from various static analyzers.

As this substitution should only occur when using static analyzer, put
it under #ifdef __CHECKER__, which is the macro used by sparse when
analyzing the Linux kernel.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/test_utilities.c      |  2 ++
 libsemanage/tests/utilities.h           | 24 ++++++++++++++++++++++
 libsepol/tests/helpers.h                | 27 +++++++++++++++++++++++++
 libsepol/tests/test-common.c            |  2 ++
 libsepol/tests/test-deps.c              |  2 ++
 libsepol/tests/test-expander-attr-map.c |  1 +
 libsepol/tests/test-expander-roles.c    |  1 +
 libsepol/tests/test-expander-users.c    |  1 +
 scripts/run-scan-build                  |  6 +++++-
 9 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 601508c2c386..ba995b5ae094 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -34,6 +34,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "utilities.h"
+
 void test_semanage_is_prefix(void);
 void test_semanage_split_on_space(void);
 void test_semanage_split(void);
diff --git a/libsemanage/tests/utilities.h b/libsemanage/tests/utilities.h
index c9d54d1e1b76..1d15a98d9db1 100644
--- a/libsemanage/tests/utilities.h
+++ b/libsemanage/tests/utilities.h
@@ -41,6 +41,30 @@
 		CU_ASSERT_STRING_EQUAL(__str, __str2); \
 	} while (0)
 
+
+/* Override CU_*_FATAL() in order to help static analyzers by really asserting that an assertion holds */
+#ifdef __CHECKER__
+
+#undef CU_ASSERT_FATAL
+#define CU_ASSERT_FATAL(value) do { \
+		CU_ASSERT(value); \
+		assert(value); \
+	} while (0)
+
+#undef CU_FAIL_FATAL
+#define CU_FAIL_FATAL(msg) do { \
+		CU_FAIL(msg); \
+		assert(0); \
+	} while (0)
+
+#undef CU_ASSERT_PTR_NOT_NULL_FATAL
+#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) do { \
+		CU_ASSERT_PTR_NOT_NULL(value); \
+		assert((value) != NULL); \
+	} while (0)
+
+#endif /* __CHECKER__ */
+
 #define I_NULL  -1
 #define I_FIRST  0
 #define I_SECOND 1
diff --git a/libsepol/tests/helpers.h b/libsepol/tests/helpers.h
index 10d390946499..34b8f21e10e0 100644
--- a/libsepol/tests/helpers.h
+++ b/libsepol/tests/helpers.h
@@ -24,9 +24,36 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
+#include <CUnit/Basic.h>
 
 /* helper functions */
 
+/* Override CU_*_FATAL() in order to help static analyzers by really asserting that an assertion holds */
+#ifdef __CHECKER__
+
+#include <assert.h>
+
+#undef CU_ASSERT_FATAL
+#define CU_ASSERT_FATAL(value) do { \
+		CU_ASSERT(value); \
+		assert(value); \
+	} while (0)
+
+#undef CU_FAIL_FATAL
+#define CU_FAIL_FATAL(msg) do { \
+		CU_FAIL(msg); \
+		assert(0); \
+	} while (0)
+
+#undef CU_ASSERT_PTR_NOT_NULL_FATAL
+#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) do { \
+		CU_ASSERT_PTR_NOT_NULL(value); \
+		assert((value) != NULL); \
+	} while (0)
+
+#endif /* __CHECKER__ */
+
+
 /* Load a source policy into p. policydb_init will called within this function.
  * 
  * Example: test_load_policy(p, POLICY_BASE, 1, "foo", "base.conf") will load the
diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index 1d902880fe2e..f690635eee27 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -26,6 +26,8 @@
 
 #include <CUnit/Basic.h>
 
+#include "helpers.h"
+
 void test_sym_presence(policydb_t * p, const char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
 {
 	scope_datum_t *scope;
diff --git a/libsepol/tests/test-deps.c b/libsepol/tests/test-deps.c
index 6bbba810564a..f4ab09ba0dbf 100644
--- a/libsepol/tests/test-deps.c
+++ b/libsepol/tests/test-deps.c
@@ -66,6 +66,8 @@
 #include <sepol/debug.h>
 #include <sepol/handle.h>
 
+#include "helpers.h"
+
 #define BASE_MODREQ_TYPE_GLOBAL    0
 #define BASE_MODREQ_ATTR_GLOBAL    1
 #define BASE_MODREQ_OBJ_GLOBAL     2
diff --git a/libsepol/tests/test-expander-attr-map.c b/libsepol/tests/test-expander-attr-map.c
index d10636ca09a8..a9744541fe00 100644
--- a/libsepol/tests/test-expander-attr-map.c
+++ b/libsepol/tests/test-expander-attr-map.c
@@ -21,6 +21,7 @@
 
 #include "test-expander-attr-map.h"
 #include "test-common.h"
+#include "helpers.h"
 
 #include <sepol/policydb/policydb.h>
 #include <CUnit/Basic.h>
diff --git a/libsepol/tests/test-expander-roles.c b/libsepol/tests/test-expander-roles.c
index aba3c9bd19c4..74c781b85e68 100644
--- a/libsepol/tests/test-expander-roles.c
+++ b/libsepol/tests/test-expander-roles.c
@@ -22,6 +22,7 @@
 
 #include "test-expander-roles.h"
 #include "test-common.h"
+#include "helpers.h"
 
 #include <sepol/policydb/policydb.h>
 #include <CUnit/Basic.h>
diff --git a/libsepol/tests/test-expander-users.c b/libsepol/tests/test-expander-users.c
index 9d9c7a62f215..ab2265c110d5 100644
--- a/libsepol/tests/test-expander-users.c
+++ b/libsepol/tests/test-expander-users.c
@@ -21,6 +21,7 @@
  */
 
 #include "test-expander-users.h"
+#include "helpers.h"
 
 #include <sepol/policydb/policydb.h>
 #include <CUnit/Basic.h>
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 88fe551ce698..ae5aa48b4a05 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -22,7 +22,11 @@ export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir
 
 # Build and analyze
 make -C .. CC=clang clean distclean -j"$(nproc)"
-scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. CC=clang DESTDIR="$DESTDIR" install install-pywrap install-rubywrap all test
+scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. \
+    CC=clang \
+    DESTDIR="$DESTDIR" \
+    CFLAGS="-O2 -Wall -D__CHECKER__ -I$DESTDIR/usr/include" \
+    install install-pywrap install-rubywrap all test
 
 # Reduce the verbosity in order to keep the message from scan-build saying
 # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examine bug reports.
-- 
2.22.0

