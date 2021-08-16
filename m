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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3DC43214
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842E860EE0
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHPT6h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPT6d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 15:58:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D05C061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t66so20474932qkb.0
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZC1tyUSk/p8+1UGVwk/XDXPP/x2DbNbs/fWgrSLz+Y=;
        b=Dz5iwmP04PXTb63vbAHojHUwNLfoUMCM3tmHfxEevOYE0uezGWz7F1RxuGk0qdeW/+
         nn7pu/J8YrN9K37ZTeC8NBpGE9zM0PHoOhDD8uxIEfHqvIHl+y5DHWm25C7e8YU70bvg
         dxoloxZw16anUYeo3mS7oRTJVUtx3Os5QIkwxuCuN6cm7ftMXDFn5I83M3ymVPpUqxvI
         cIea5qIOAHPNfjQ98XW9MdGwJgFSzjpMKzQXm19Hgp4LcW/eXsU+4NRYOAzcpz6fIAB0
         qEzT+Jr1SxzNm2y/1Pb37olYvfq4ndzvGVxIfZgDQvQ81ue944rhrc1Be1eGQXfG/dP0
         VirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZC1tyUSk/p8+1UGVwk/XDXPP/x2DbNbs/fWgrSLz+Y=;
        b=KvjmgqJMhg+oT7j458gajnKo0PI3GXN1un9svJekO8d048ADIu55vXAXU5/cnpeWc1
         7pJYjfmW7s28gT2Q6saaVJ1YEhL2iVJa5xIF6KQ99ruKU8wCNFwnGJEBTSAWeNcl9s+B
         QJ2hnaqlw+TUGkPsvVA7SZHv44nOLeeWW09QV4u5VcIF0KBzzVKvypzdwErRIQMhZmY0
         aw4jlSgALRMKKoQnHi7/1c09LULIi0BaKpfvUF6I+nQNS+82gdhyJj7JXBlq0fQZKBvK
         uZAs99zBsW8PRcUzg7Gs6hWGCNs3w9ojFCuDbLbbj5avQt9YfwFMd87VMR/Ee13giIz6
         wI3g==
X-Gm-Message-State: AOAM533y9ZZzEVI6YHkgXAooZI92NYR5Y6haVmoF593hdQR1g86BgJU5
        RNNFsUJW0Uo1qODrJmsF0M3dZO5ITucEaA==
X-Google-Smtp-Source: ABdhPJwbr7x7R1KF7h3FHPCmK6xfA3sEd/8Wqhw3Yq9l0+9K3yU7lVwPNctmIzDAOMTVI9Cb2x6iFQ==
X-Received: by 2002:a37:a80c:: with SMTP id r12mr621252qke.299.1629143880241;
        Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f11sm135147qtf.45.2021.08.16.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/7 v2] libsepol/cil: Create common string-to-unsigned-integer functions
Date:   Mon, 16 Aug 2021 15:57:50 -0400
Message-Id: <20210816195752.923028-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816195752.923028-1-jwcart2@gmail.com>
References: <20210816195752.923028-1-jwcart2@gmail.com>
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

