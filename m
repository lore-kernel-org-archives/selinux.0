Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2D6C433B4
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256BB61403
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 06:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhDVGqq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Apr 2021 02:46:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55899 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhDVGqq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Apr 2021 02:46:46 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 93D2B5646B4
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 08:46:10 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: use checked arithmetic builtin to perform safe addition
Date:   Thu, 22 Apr 2021 08:46:04 +0200
Message-Id: <20210422064604.270374-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Apr 22 08:46:10 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Checking whether an overflow occurred after adding two values can be
achieved using checked arithmetic builtin functions such as:

    bool __builtin_add_overflow(type1 x, type2 y, type3 *sum);

This function is available at least in clang
(at least since clang 3.8.0,
https://releases.llvm.org/3.8.0/tools/clang/docs/LanguageExtensions.html#checked-arithmetic-builtins)
and gcc
(https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html,
since gcc 5 according to https://gcc.gnu.org/gcc-5/changes.html)

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/context_record.c | 29 ++++++-----------------------
 libsepol/src/module_to_cil.c  |  6 ++----
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
index 317a42133884..435f788058c4 100644
--- a/libsepol/src/context_record.c
+++ b/libsepol/src/context_record.c
@@ -267,31 +267,13 @@ int sepol_context_from_string(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-
-static inline int safe_sum(size_t *sum, const size_t augends[], const size_t cnt) {
-
-	size_t a, i;
-
-	*sum = 0;
-	for(i=0; i < cnt; i++) {
-		/* sum should not be smaller than the addend */
-		a = augends[i];
-		*sum += a;
-		if (*sum < a) {
-			return i;
-		}
-	}
-
-	return 0;
-}
-
 int sepol_context_to_string(sepol_handle_t * handle,
 			    const sepol_context_t * con, char **str_ptr)
 {
 
 	int rc;
 	char *str = NULL;
-	size_t total_sz, err;
+	size_t total_sz = 0, i;
 	const size_t sizes[] = {
 			strlen(con->user),                 /* user length */
 			strlen(con->role),                 /* role length */
@@ -300,10 +282,11 @@ int sepol_context_to_string(sepol_handle_t * handle,
 			((con->mls) ? 3 : 2) + 1           /* mls has extra ":" also null byte */
 	};
 
-	err = safe_sum(&total_sz, sizes, ARRAY_SIZE(sizes));
-	if (err) {
-		ERR(handle, "invalid size, overflow at position: %zu", err);
-		goto err;
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		if (__builtin_add_overflow(total_sz, sizes[i], &total_sz)) {
+			ERR(handle, "invalid size, overflow at position: %zu", i);
+			goto err;
+		}
 	}
 
 	str = (char *)malloc(total_sz);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 58df0d4f6d77..496693f4616e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1134,16 +1134,14 @@ static int name_list_to_string(char **names, unsigned int num_names, char **stri
 	char *strpos;
 
 	for (i = 0; i < num_names; i++) {
-		len += strlen(names[i]);
-		if (len < strlen(names[i])) {
+		if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
 			log_err("Overflow");
 			return -1;
 		}
 	}
 
 	// add spaces + null terminator
-	len += num_names;
-	if (len < (size_t)num_names) {
+	if (__builtin_add_overflow(len, (size_t)num_names, &len)) {
 		log_err("Overflow");
 		return -1;
 	}
-- 
2.31.0

