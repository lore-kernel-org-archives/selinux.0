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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E772C432BE
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4349B60231
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbhHJSWV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhHJSWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C23C07AF64
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 3so11384468qvd.2
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zguFDXV+WK4mQGxz7VuN/jiCM5azEzkdnGTb2ASezTQ=;
        b=GuNsqxhH4uC4cLVuQckv1+eHZhnR4RIYs0kkV317Ldc6oOE4SNMzbUgl7Zyk+fczPg
         210qjju6T4pmayirWrCoC433cLk7h8OIwxz8kPsRJw5vCj4faDANbWt6b1sFQe8wwUhU
         3IKabApJIKo6ofexJtypbdTYuO1Yny0rtwf0HJ9QHdN5jVoy94IR7eQh4h0tOW0E0par
         uJtK6/R7ATPSxI+WpPr7Zg+dXiAgt4FiiKX1w2YoyXo+QktHtlqvfAYVlNaIxvBO+IMI
         I5+GqU8l1/pDq/MT5U6gyLk93wGSz7WbO+LIrIigKLopWcJXJjx/3GNhsjyxLVfifke/
         RVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zguFDXV+WK4mQGxz7VuN/jiCM5azEzkdnGTb2ASezTQ=;
        b=aCsPK/JHbLTsEKaNLrXbADkvNtBiXro8hUAdn8WNO6CSbggI5RJ3NzYmO26vn18SEg
         5I/dDI+bnZYcIa8OOq2JUuuO5RvPhM+odc6ESKUTOP3XsKjU+1HEP/BMU/3mkVxneEO2
         ONDuO3Wd+pN/c896nyegZ9JIes510UKEWZtbQuj026ODhPVMRpdnmVK7oFP2jzFdxJOI
         eWpFMXqZlEj6KOeRmRNsBIUjYnuuJg5i04eQBQyFz3TkuV4BXJR7/yj3j66gu0P4UIa/
         y69dRFRAB9zzpeTO3sprXaIhHtLpn2UiLHl9oJ0W/FJRwrlJjYWooBX7o0K9+zFSZcq6
         +dQg==
X-Gm-Message-State: AOAM5316L4p+Wa5H0jLwKu2j9GNgShqb98XlgpQOMKaN47P9EdghlDjX
        H7N0sb8WNJjvWueuAimZkAakg1ksN+R/dg==
X-Google-Smtp-Source: ABdhPJz23XsE+vcpKWKUCcq0Iu4ralunRW51V+rLJj05J5zPqQOvEh9VTRPcoObIHfgKd17Grax01Q==
X-Received: by 2002:a05:6214:528a:: with SMTP id kj10mr30339442qvb.38.1628618747451;
        Tue, 10 Aug 2021 11:05:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/8] libsepol/cil: Add line mark kind and line number to src info
Date:   Tue, 10 Aug 2021 14:05:35 -0400
Message-Id: <20210810180537.669439-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To be able to write line mark information when writing the AST,
the line mark kind and line number is needed in the src info.

Instead of indicating whether the src info is for CIL or a hll,
differentiate between CIL, a normal hll line mark, and an expanded
hll line mark. Also include the line mark line number in the src
info nodes.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c           | 13 +++++++++----
 libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++--
 libsepol/cil/src/cil_copy_ast.c  |  3 ++-
 libsepol/cil/src/cil_internal.h  |  7 +++++--
 libsepol/cil/src/cil_parser.c    | 27 +++++++++++----------------
 libsepol/cil/src/cil_tree.c      |  2 +-
 6 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index bdd16eb8..caec5dad 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -220,7 +220,9 @@ char *CIL_KEY_IOCTL;
 char *CIL_KEY_UNORDERED;
 char *CIL_KEY_SRC_INFO;
 char *CIL_KEY_SRC_CIL;
-char *CIL_KEY_SRC_HLL;
+char *CIL_KEY_SRC_HLL_LMS;
+char *CIL_KEY_SRC_HLL_LMX;
+char *CIL_KEY_SRC_HLL_LME;
 
 static void cil_init_keys(void)
 {
@@ -384,8 +386,10 @@ static void cil_init_keys(void)
 	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
 	CIL_KEY_UNORDERED = cil_strpool_add("unordered");
 	CIL_KEY_SRC_INFO = cil_strpool_add("<src_info>");
-	CIL_KEY_SRC_CIL = cil_strpool_add("<src_cil>");
-	CIL_KEY_SRC_HLL = cil_strpool_add("<src_hll>");
+	CIL_KEY_SRC_CIL = cil_strpool_add("cil");
+	CIL_KEY_SRC_HLL_LMS = cil_strpool_add("lms");
+	CIL_KEY_SRC_HLL_LMX = cil_strpool_add("lmx");
+	CIL_KEY_SRC_HLL_LME = cil_strpool_add("lme");
 }
 
 void cil_db_init(struct cil_db **db)
@@ -2881,6 +2885,7 @@ void cil_mls_init(struct cil_mls **mls)
 void cil_src_info_init(struct cil_src_info **info)
 {
 	*info = cil_malloc(sizeof(**info));
-	(*info)->is_cil = 0;
+	(*info)->kind = NULL;
+	(*info)->hll_line = 0;
 	(*info)->path = NULL;
 }
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index ffbd3082..a0f58b1e 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6060,6 +6060,7 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
+		CIL_SYN_STRING,
 		CIL_SYN_N_LISTS | CIL_SYN_END,
 		CIL_SYN_END
 	};
@@ -6077,8 +6078,19 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
 
 	cil_src_info_init(&info);
 
-	info->is_cil = (parse_current->next->data == CIL_KEY_SRC_CIL) ? CIL_TRUE : CIL_FALSE;
-	info->path = parse_current->next->next->data;
+	info->kind = parse_current->next->data;
+	if (info->kind != CIL_KEY_SRC_CIL && info->kind != CIL_KEY_SRC_HLL_LMS && info->kind != CIL_KEY_SRC_HLL_LMX) {
+		cil_log(CIL_ERR, "Invalid src info kind\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	rc = cil_string_to_uint32(parse_current->next->next->data, &info->hll_line, 10);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	info->path = parse_current->next->next->next->data;
 
 	ast_node->data = info;
 	ast_node->flavor = CIL_SRC_INFO;
@@ -6087,6 +6099,7 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
 
 exit:
 	cil_tree_log(parse_current, CIL_ERR, "Bad src info");
+	cil_destroy_src_info(info);
 	return rc;
 }
 
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 9c0231f2..02b9828f 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1692,7 +1692,8 @@ int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *data, voi
 
 	cil_src_info_init(&new);
 
-	new->is_cil = orig->is_cil;
+	new->kind = orig->kind;
+	new->hll_line = orig->hll_line;
 	new->path = orig->path;
 
 	*copy = new;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index b9a03a37..385677d4 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -236,7 +236,9 @@ extern char *CIL_KEY_IOCTL;
 extern char *CIL_KEY_UNORDERED;
 extern char *CIL_KEY_SRC_INFO;
 extern char *CIL_KEY_SRC_CIL;
-extern char *CIL_KEY_SRC_HLL;
+extern char *CIL_KEY_SRC_HLL_LMS;
+extern char *CIL_KEY_SRC_HLL_LMX;
+extern char *CIL_KEY_SRC_HLL_LME;
 
 /*
 	Symbol Table Array Indices
@@ -963,7 +965,8 @@ struct cil_mls {
 };
 
 struct cil_src_info {
-	int is_cil;
+	char *kind;
+	uint32_t hll_line;
 	char *path;
 };
 
diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index 9ca1432e..842c327c 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -44,10 +44,6 @@
 
 #define CIL_PARSER_MAX_EXPR_DEPTH (0x1 << 12)
 
-char *CIL_KEY_HLL_LMS;
-char *CIL_KEY_HLL_LMX;
-char *CIL_KEY_HLL_LME;
-
 struct hll_info {
 	uint32_t hll_lineno;
 	uint32_t hll_expand;
@@ -102,7 +98,6 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 	char *hll_type;
 	struct cil_tree_node *node;
 	struct token tok;
-	char *hll_file;
 	int rc;
 
 	cil_lexer_next(&tok);
@@ -111,11 +106,11 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		goto exit;
 	}
 	hll_type = cil_strpool_add(tok.value);
-	if (hll_type != CIL_KEY_HLL_LME && hll_type != CIL_KEY_HLL_LMS && hll_type != CIL_KEY_HLL_LMX) {
+	if (hll_type != CIL_KEY_SRC_HLL_LME && hll_type != CIL_KEY_SRC_HLL_LMS && hll_type != CIL_KEY_SRC_HLL_LMX) {
 		cil_log(CIL_ERR, "Invalid line mark syntax\n");
 		goto exit;
 	}
-	if (hll_type == CIL_KEY_HLL_LME) {
+	if (hll_type == CIL_KEY_SRC_HLL_LME) {
 		if (cil_stack_is_empty(stack)) {
 			cil_log(CIL_ERR, "Line mark end without start\n");
 			goto exit;
@@ -132,7 +127,7 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_INFO);
 		insert_node(node, *current);
 
-		create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_HLL);
+		create_node(&node, *current, tok.line, *hll_lineno, hll_type);
 		insert_node(node, *current);
 
 		cil_lexer_next(&tok);
@@ -141,12 +136,15 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 			goto exit;
 		}
 
+		create_node(&node, *current, tok.line, *hll_lineno, cil_strpool_add(tok.value));
+		insert_node(node, *current);
+
 		rc = cil_string_to_uint32(tok.value, hll_lineno, 10);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 
-		*hll_expand = (hll_type == CIL_KEY_HLL_LMX) ? 1 : 0;
+		*hll_expand = (hll_type == CIL_KEY_SRC_HLL_LMX) ? 1 : 0;
 
 		cil_lexer_next(&tok);
 		if (tok.type != SYMBOL && tok.type != QSTRING) {
@@ -159,9 +157,7 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 			tok.value = tok.value+1;
 		}
 
-		hll_file = cil_strpool_add(tok.value);
-
-		create_node(&node, *current, tok.line, *hll_lineno, hll_file);
+		create_node(&node, *current, tok.line, *hll_lineno, cil_strpool_add(tok.value));
 		insert_node(node, *current);
 	}
 
@@ -192,6 +188,9 @@ static void add_cil_path(struct cil_tree_node **current, char *path)
 	create_node(&node, *current, 0, 0, CIL_KEY_SRC_CIL);
 	insert_node(node, *current);
 
+	create_node(&node, *current, 0, 0, "1");
+	insert_node(node, *current);
+
 	create_node(&node, *current, 0, 0, path);
 	insert_node(node, *current);
 }
@@ -211,10 +210,6 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
 	struct token tok;
 	int rc = SEPOL_OK;
 
-	CIL_KEY_HLL_LMS = cil_strpool_add("lms");
-	CIL_KEY_HLL_LMX = cil_strpool_add("lmx");
-	CIL_KEY_HLL_LME = cil_strpool_add("lme");
-
 	cil_stack_init(&stack);
 
 	cil_lexer_setup(buffer, size);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 4cf8dcc8..52b28999 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -71,7 +71,7 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
 				/* AST */
 				struct cil_src_info *info = node->data;
 				*path = info->path;
-				*is_cil = info->is_cil;
+				*is_cil = (info->kind == CIL_KEY_SRC_CIL);
 				return node;
 		} else {
 			if (node->flavor == CIL_CALL) {
-- 
2.31.1

