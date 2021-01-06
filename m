Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A4C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A0230FB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFIOR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:14:17 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:55658 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIOR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:14:17 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 81B165611EE;
        Wed,  6 Jan 2021 09:13:34 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/cil: fix NULL pointer dereference when parsing an improper integer
Date:   Wed,  6 Jan 2021 09:13:19 +0100
Message-Id: <20210106081319.379572-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:13:34 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
compile a policy with an invalid integer:

    $ echo '(ioportcon(2())n)' > tmp.cil
    $ secilc tmp.cil
    Segmentation fault (core dumped)

This is because strtol() is called with a NULL pointer, in
cil_fill_integer().

Fix this by checking that int_node->data is not NULL. While at it, use
strtoul() instead of strtol() to parse an unsigned integer.

When using "val > UINT32_MAX" with "unsigned long val;", it is expected
that some compilers emit a warning when the size of "unsigned long" is
32 bits. In theory gcc could be such a compiler (with warning
-Wtype-limits, which is included in -Wextra). Nevertheless this is
currently broken, according to
https://gcc.gnu.org/pipermail/gcc-help/2021-January/139755.html and
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89126 (this bug was
opened in January 2019).

In order to prevent this warning from appearing, introduce some
preprocessor macros around the bound check.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index be10d61b1314..02481558ad11 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5570,19 +5570,27 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
 {
 	int rc = SEPOL_ERR;
 	char *endptr = NULL;
-	int val;
+	unsigned long val;
 
-	if (int_node == NULL || integer == NULL) {
+	if (int_node == NULL || int_node->data == NULL || integer == NULL) {
 		goto exit;
 	}
 
 	errno = 0;
-	val = strtol(int_node->data, &endptr, base);
+	val = strtoul(int_node->data, &endptr, base);
 	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
 		rc = SEPOL_ERR;
 		goto exit;
 	}
 
+	/* Ensure that the value fits a 32-bit integer without triggering -Wtype-limits */
+#if ULONG_MAX > UINT32_MAX
+	if (val > UINT32_MAX) {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+#endif
+
 	*integer = val;
 
 	return SEPOL_OK;
@@ -5598,7 +5606,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
 	char *endptr = NULL;
 	uint64_t val;
 
-	if (int_node == NULL || integer == NULL) {
+	if (int_node == NULL || int_node->data == NULL || integer == NULL) {
 		goto exit;
 	}
 
-- 
2.30.0

