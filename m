Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F82C07E98
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7961490
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhGCOe0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:34:26 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43726 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhGCOeV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Jul 2021 10:34:21 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E2CCB564DD4
        for <selinux@vger.kernel.org>; Sat,  3 Jul 2021 16:31:46 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/6] libsemanage: silence -Wextra-semi-stmt warning
Date:   Sat,  3 Jul 2021 16:31:19 +0200
Message-Id: <20210703143122.1441578-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
References: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  3 16:31:47 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
(which is not the default build configuration), the compiler reports:

      genhomedircon.c:742:67: error: empty expression statement has no
      effect; remove unnecessary ';' to silence this warning
      [-Werror,-Wextra-semi-stmt]
              const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;;
                                                                               ^

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/genhomedircon.c       |  2 +-
 libsemanage/tests/libsemanage-tests.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d08c88de99a7..7ca9afc3c1c7 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -740,7 +740,7 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 static int seuser_sort_func(const void *arg1, const void *arg2)
 {
 	const semanage_seuser_t **u1 = (const semanage_seuser_t **) arg1;
-	const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;;
+	const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;
 	const char *name1 = semanage_seuser_get_name(*u1);
 	const char *name2 = semanage_seuser_get_name(*u2);
 
diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index 2ae4a21be52a..ee1767034c28 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -41,13 +41,17 @@
 #include <stdlib.h>
 
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

