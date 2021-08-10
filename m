Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C5C4320E
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A896056C
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhHJSWL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhHJSWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:02 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91861C07AF5E
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x12so11374917qvo.12
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZC1tyUSk/p8+1UGVwk/XDXPP/x2DbNbs/fWgrSLz+Y=;
        b=riA28tzzgMBzg9xVKyprmWPXt2WDKLo5oQnv+E8pZltOGrxVy9mzruXtrQ3PN9fmBe
         mS3GzlTfWDWt81/apOmvDOpTXduCsFAbmnFlX7K5feiHzc+6+1k9R8aONh5II3a6CLmt
         GmHhbH8cGqDywjRIOOKKm7RXzuTM1xSJiwnAcJSJkIxfxg831/H1sJryTzlc4/YyaEo1
         pKFYFccRXbcyIGlAwZFUSqeN/CtrON9IG0/UUckb3iCY7R8Shi8icmvLtkYQWQ84im+b
         EY/vobetIBeCEyvxWrUxwzszuBkm0W5IE77ReGVQGR4Qzjg7Gm2k6ScpwDQH/lACwBXb
         sKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZC1tyUSk/p8+1UGVwk/XDXPP/x2DbNbs/fWgrSLz+Y=;
        b=WGuC3HEdFDS6k1bHyrap9h72a+ZSPvUmo5oZfXAUR7waBDtB/4IpZYZNtsVKcdqJIc
         iGhN7SOB2rC0VocfCN2a8zRIXSvB1Bd2ccn594A4OIGklAzD4zIgV5boIL5fYKolBjfN
         N7qB0ztBLDBN/vY623mST66o3pF3zfS9/ogF3rHi0iRMexX2mjWMCrsHLTSLINkXswUN
         xPawxUCrOyU256ZDozQwckLZuROw7BN+JW5KF1VHuuDlL/gdLrIcOflfLQR552YYHI+p
         5c/kOhtTIJzfyIJh+GCoWIzgLAUkUFDV92VCY+5IQ/msfwxLasMz/Fsuuct3bOC0x2f6
         v8wg==
X-Gm-Message-State: AOAM533d1jE3H+t0WpEAabDhXU79vVnvL+HbnjUkgioPK5JPitUqytvw
        VhLIYEu2AU5tuYaaX10/wpIHIlwuSwq1pg==
X-Google-Smtp-Source: ABdhPJzHatoHsebIknOJ8dwxNliXNOUy2Ka+64m9zWtc/9xgUMy7db1qlL+B5M6eHAGtB93U956e0g==
X-Received: by 2002:a05:6214:21a4:: with SMTP id t4mr16950755qvc.21.1628618746675;
        Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/8] libsepol/cil: Create common string-to-unsigned-integer functions
Date:   Tue, 10 Aug 2021 14:05:34 -0400
Message-Id: <20210810180537.669439-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The functions cil_fill_integer() and cil_fill_integer64() exist in
cil_build_ast.c, but these functions take a node and it would be
better to have a function that can be used in add_hll_linemark()
so that the common functinality is in one place.

Create cil_string_to_uint32() and cil_string_to_uint64() and use
these functions in cil_fill_integer(), cil_fill_integer64(), and
add_hll_linemark().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c           | 57 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 32 ++++--------------
 libsepol/cil/src/cil_internal.h  |  2 ++
 libsepol/cil/src/cil_parser.c    | 16 +++------
 4 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index d24c81c8..bdd16eb8 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1997,6 +1997,63 @@ exit:
 	return SEPOL_ERR;	
 }
 
+int cil_string_to_uint32(const char *string, uint32_t *value, int base)
+{
+	unsigned long val;
+	char *end = NULL;
+	int rc = SEPOL_ERR;
+
+	if (string == NULL || value  == NULL) {
+		goto exit;
+	}
+
+	errno = 0;
+	val = strtoul(string, &end, base);
+	if (errno != 0 || end == string || *end != '\0') {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	/* Ensure that the value fits a 32-bit integer without triggering -Wtype-limits */
+#if ULONG_MAX > UINT32_MAX
+	if (val > UINT32_MAX) {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+#endif
+
+	*value = val;
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Failed to create uint32_t from string\n");
+	return rc;
+}
+
+int cil_string_to_uint64(const char *string, uint64_t *value, int base)
+{
+	char *end = NULL;
+	int rc = SEPOL_ERR;
+
+	if (string == NULL || value  == NULL) {
+		goto exit;
+	}
+
+	errno = 0;
+	*value = strtoull(string, &end, base);
+	if (errno != 0 || end == string || *end != '\0') {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Failed to create uint64_t from string\n");
+	return rc;
+}
+
 void cil_sort_init(struct cil_sort **sort)
 {
 	*sort = cil_malloc(sizeof(**sort));
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 5e65a266..ffbd3082 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5601,60 +5601,40 @@ void cil_destroy_ipaddr(struct cil_ipaddr *ipaddr)
 int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base)
 {
 	int rc = SEPOL_ERR;
-	char *endptr = NULL;
-	unsigned long val;
 
 	if (int_node == NULL || int_node->data == NULL || integer == NULL) {
 		goto exit;
 	}
 
-	errno = 0;
-	val = strtoul(int_node->data, &endptr, base);
-	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
-	/* Ensure that the value fits a 32-bit integer without triggering -Wtype-limits */
-#if ULONG_MAX > UINT32_MAX
-	if (val > UINT32_MAX) {
-		rc = SEPOL_ERR;
+	rc = cil_string_to_uint32(int_node->data, integer, base);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-#endif
-
-	*integer = val;
 
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Failed to create integer from string\n");
+	cil_log(CIL_ERR, "Failed to fill 32-bit integer\n");
 	return rc;
 }
 
 int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int base)
 {
 	int rc = SEPOL_ERR;
-	char *endptr = NULL;
-	uint64_t val;
 
 	if (int_node == NULL || int_node->data == NULL || integer == NULL) {
 		goto exit;
 	}
 
-	errno = 0;
-	val = strtoull(int_node->data, &endptr, base);
-	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
-		rc = SEPOL_ERR;
+	rc = cil_string_to_uint64(int_node->data, integer, base);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-	*integer = val;
-
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Failed to create integer from string\n");
+	cil_log(CIL_ERR, "Failed to fill 64-bit integer\n");
 	return rc;
 }
 
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 98e303d1..b9a03a37 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -986,6 +986,8 @@ void cil_symtab_array_init(symtab_t symtab[], const int symtab_sizes[CIL_SYM_NUM
 void cil_symtab_array_destroy(symtab_t symtab[]);
 void cil_destroy_ast_symtabs(struct cil_tree_node *root);
 int cil_get_symtab(struct cil_tree_node *ast_node, symtab_t **symtab, enum cil_sym_index sym_index);
+int cil_string_to_uint32(const char *string, uint32_t *value, int base);
+int cil_string_to_uint64(const char *string, uint64_t *value, int base);
 
 void cil_sort_init(struct cil_sort **sort);
 void cil_sort_destroy(struct cil_sort **sort);
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index d36ffc49..9ca1432e 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -103,8 +103,7 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 	struct cil_tree_node *node;
 	struct token tok;
 	char *hll_file;
-	char *end = NULL;
-	unsigned long val;
+	int rc;
 
 	cil_lexer_next(&tok);
 	if (tok.type != SYMBOL) {
@@ -142,18 +141,11 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 			goto exit;
 		}
 
-		val = strtoul(tok.value, &end, 10);
-		if (errno == ERANGE || *end != '\0') {
-			cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
+		rc = cil_string_to_uint32(tok.value, hll_lineno, 10);
+		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-#if ULONG_MAX > UINT32_MAX
-		if (val > UINT32_MAX) {
-			cil_log(CIL_ERR, "Line mark line number > UINT32_MAX\n");
-			goto exit;
-		}
-#endif
-		*hll_lineno = val;
+
 		*hll_expand = (hll_type == CIL_KEY_HLL_LMX) ? 1 : 0;
 
 		cil_lexer_next(&tok);
-- 
2.31.1

