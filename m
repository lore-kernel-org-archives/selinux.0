Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DFC07E9B
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188306193A
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhGCOeW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:34:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48830 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhGCOeS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Jul 2021 10:34:18 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2B2DD564DD4
        for <selinux@vger.kernel.org>; Sat,  3 Jul 2021 16:31:43 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/6] libsepol: silence -Wextra-semi-stmt warning
Date:   Sat,  3 Jul 2021 16:31:17 +0200
Message-Id: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  3 16:31:43 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
(which is not the default build configuration), the compiler reports:

  ../cil/src/cil_binary.c:4293:22: error: empty expression statement
  has no effect; remove unnecessary ';' to silence this warning
  [-Werror,-Wextra-semi-stmt]
          mix(k->target_class);
                              ^
  ../cil/src/cil_binary.c:4294:21: error: empty expression statement
  has no effect; remove unnecessary ';' to silence this warning
  [-Werror,-Wextra-semi-stmt]
          mix(k->target_type);
                             ^
  ../cil/src/cil_binary.c:4295:21: error: empty expression statement
  has no effect; remove unnecessary ';' to silence this warning
  [-Werror,-Wextra-semi-stmt]
          mix(k->source_type);
                             ^
  ../cil/src/cil_binary.c:4296:19: error: empty expression statement
  has no effect; remove unnecessary ';' to silence this warning
  [-Werror,-Wextra-semi-stmt]
          mix(k->specified);
                           ^

Use a do { ... } while (0) construction to silence this warning.

Moreover the same warning appears when using two semicolons to end a
statement. Remove such occurrences, like what was already done in commit
811185648af2 ("libsepol: drop repeated semicolons").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c      |  4 ++--
 libsepol/cil/src/cil_resolve_ast.c |  2 +-
 libsepol/src/avtab.c               |  4 ++--
 libsepol/tests/libsepol-tests.c    | 18 +++++++++++-------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 54d13f2f3945..41105c122bc3 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4277,7 +4277,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
 
 	uint32_t hash = 0;
 
-#define mix(input) { \
+#define mix(input) do { \
 	uint32_t v = input; \
 	v *= c1; \
 	v = (v << r1) | (v >> (32 - r1)); \
@@ -4285,7 +4285,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
 	hash ^= v; \
 	hash = (hash << r2) | (hash >> (32 - r2)); \
 	hash = hash * m + n; \
-}
+} while (0)
 
 	mix(k->target_class);
 	mix(k->target_type);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 32ea64e39b21..9a02e3867659 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2825,7 +2825,7 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
 			return SEPOL_OK;
 		} else {
 			cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
-			return SEPOL_ERR;;
+			return SEPOL_ERR;
 		}
 	}
 	if (call->args_tree == NULL) {
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 88e9d510f981..5e16a0e9899e 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -63,7 +63,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
 
 	uint32_t hash = 0;
 
-#define mix(input) { \
+#define mix(input) do { \
 	uint32_t v = input; \
 	v *= c1; \
 	v = (v << r1) | (v >> (32 - r1)); \
@@ -71,7 +71,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
 	hash ^= v; \
 	hash = (hash << r2) | (hash >> (32 - r2)); \
 	hash = hash * m + n; \
-}
+} while (0)
 
 	mix(keyp->target_class);
 	mix(keyp->target_type);
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 544c792d2ab5..dc8fd5ce5f6c 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -36,13 +36,17 @@
 int mls;
 
 #define DECLARE_SUITE(name) \
-	suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
-	if (NULL == suite) { \
-		CU_cleanup_registry(); \
-		return CU_get_error(); } \
-	if (name##_add_tests(suite)) { \
-		CU_cleanup_registry(); \
-		return CU_get_error(); }
+	do { \
+		suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
+		if (NULL == suite) { \
+			CU_cleanup_registry(); \
+			return CU_get_error(); \
+		} \
+		if (name##_add_tests(suite)) { \
+			CU_cleanup_registry(); \
+			return CU_get_error(); \
+		} \
+	} while (0)
 
 static void usage(char *progname)
 {
-- 
2.32.0

