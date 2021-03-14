Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046FC4332D
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8F64E6B
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhCNUSY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:18:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56810 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhCNURt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 16:17:49 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 96F9C5646B0
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 21:17:46 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/6] libsepol/cil: make cil_post_fc_fill_data static
Date:   Sun, 14 Mar 2021 21:16:47 +0100
Message-Id: <20210314201651.474432-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314201651.474432-1-nicolas.iooss@m4x.org>
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 21:17:46 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

cil_post_fc_fill_data() is not used outside of cil_post.c, and is not
exported in libsepol.so. Make it static, in order to ease the analysis
of static analyzers.

While at it, make its path argument "const char*" and the fields of
"struct fc_data" "unsigned int" or "size_t", in order to make the types
better match the values.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_post.c | 11 +++++++++--
 libsepol/cil/src/cil_post.h |  7 -------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 5f9cf4efd242..783929e50df8 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -27,6 +27,7 @@
  * either expressed or implied, of Tresys Technology, LLC.
  */
 
+#include <stddef.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -50,6 +51,12 @@
 #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
 #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
 
+struct fc_data {
+	unsigned int meta;
+	size_t stem_len;
+	size_t str_len;
+};
+
 static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
 static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
 
@@ -156,9 +163,9 @@ static int cil_verify_is_list(struct cil_list *list, enum cil_flavor flavor)
 	return CIL_TRUE;
 }
 
-void cil_post_fc_fill_data(struct fc_data *fc, char *path)
+static void cil_post_fc_fill_data(struct fc_data *fc, const char *path)
 {
-	int c = 0;
+	size_t c = 0;
 	fc->meta = 0;
 	fc->stem_len = 0;
 	fc->str_len = 0;
diff --git a/libsepol/cil/src/cil_post.h b/libsepol/cil/src/cil_post.h
index 3d5415486b77..b1d2206f9ef6 100644
--- a/libsepol/cil/src/cil_post.h
+++ b/libsepol/cil/src/cil_post.h
@@ -30,13 +30,6 @@
 #ifndef CIL_POST_H_
 #define CIL_POST_H_
 
-struct fc_data {
-	int meta;
-	int stem_len;
-	int str_len;
-};
-
-void cil_post_fc_fill_data(struct fc_data *fc, char *path);
 int cil_post_filecon_compare(const void *a, const void *b);
 int cil_post_ibpkeycon_compare(const void *a, const void *b);
 int cil_post_portcon_compare(const void *a, const void *b);
-- 
2.30.2

