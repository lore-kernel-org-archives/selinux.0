Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC65AC433E1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AAD61864
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhC3RkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3Rja (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981FDC061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y18so16631017qky.11
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+6TjWfzdMru7Jb6qMivLGdR+Dq1tZsUpNnFX8G7o2c=;
        b=UN/BDg46sy3Q2I/UduA1mB4eTHCBikj9vk8jEQ/oiAQlADyILoR78EYNP34D09VE0O
         9HaIDcZlZrQigzUCWp6RRLpW9MWFcUuXr7xHYqr4PSKAGmYM0UlpXaqJEDoMUvwKOR+d
         oc9uW0tGiVJ+9OZjjonCxg+4IeLSFY2d+ufLvoVjFVoqYoOaplZW9UV8FoXQLJgOFTOO
         ljn/vIfg2kdxJOKrqAErtGE6Xm565JAa2qtcojt5DECBjvRqPU+ENqWu9zmqp+yj7cR0
         itRpyJf71I4tZHxEcygp5OXtCYrjK/N72KFiWSInzrWghfdv7s/XY0df86k91dQeuHHo
         wNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+6TjWfzdMru7Jb6qMivLGdR+Dq1tZsUpNnFX8G7o2c=;
        b=rCvDlq2W5x8KcZM1e30nJgpr+nSkbTHPkksHGVNDJRveTwF7DxA36Aqc1WxgRcWA/p
         DDwmgMKD5NMRAg09cUgPTJN3vkwcPgrGjpRicUo5gOSPKwzxettuXQSZ0l2mHK1WqsXt
         ZjK17D0EcAuJQJ7bYDvmkLbmOaG5tcsSkFt3GdeLGDNEOwSsHyje04kJi+7G15+j8Vh9
         v4TWPhm42KrnhS8sMr/ViXWCEFq1SSZTDXTWyx3hBKnWT3oLcYJ68UFQOKURtCm7rsKa
         eeFlcHx+d/wJP5GwQga1ZESqXTlB7qgmYHoX1bziyMUh4SuBTqa0zFZVuKgpCLnvZx5R
         pKkQ==
X-Gm-Message-State: AOAM531WHm5kJREBvkz4RirO+z0QpBE33wMqYWNsAziG+IBg8PyVIofb
        UEdaT9DNUxVlOZXkg+ga+jXW3/jooM/OlQ==
X-Google-Smtp-Source: ABdhPJzzMk80/c51MAky2k81dMjdB+VsEoHfIXkz5pB5ukDO1DEAxcISpJ5yZvtBfCR1tKAPMfRIjw==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr31765715qkm.355.1617125969630;
        Tue, 30 Mar 2021 10:39:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:29 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 01/12] libsepol/cil: Reorder checks for invalid rules when building AST
Date:   Tue, 30 Mar 2021 13:39:12 -0400
Message-Id: <20210330173920.281531-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reorder checks for invalid rules in the blocks of tunableifs,
in-statements, macros, and booleanifs when building the AST for
consistency.

Order the checks in the same order the blocks will be resolved in,
so tuanbleif, in-statement, macro, booleanif, and then non-block
rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 100 +++++++++++++++----------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4e53f06a..1c530bbc 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -49,10 +49,10 @@
 struct cil_args_build {
 	struct cil_tree_node *ast;
 	struct cil_db *db;
-	struct cil_tree_node *macro;
-	struct cil_tree_node *boolif;
 	struct cil_tree_node *tunif;
 	struct cil_tree_node *in;
+	struct cil_tree_node *macro;
+	struct cil_tree_node *boolif;
 };
 
 int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **list)
@@ -6097,10 +6097,10 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	struct cil_tree_node *ast_current = NULL;
 	struct cil_db *db = NULL;
 	struct cil_tree_node *ast_node = NULL;
-	struct cil_tree_node *macro = NULL;
-	struct cil_tree_node *boolif = NULL;
 	struct cil_tree_node *tunif = NULL;
 	struct cil_tree_node *in = NULL;
+	struct cil_tree_node *macro = NULL;
+	struct cil_tree_node *boolif = NULL;
 	int rc = SEPOL_ERR;
 
 	if (parse_current == NULL || finished == NULL || extra_args == NULL) {
@@ -6110,10 +6110,10 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	args = extra_args;
 	ast_current = args->ast;
 	db = args->db;
-	macro = args->macro;
-	boolif = args->boolif;
 	tunif = args->tunif;
 	in = args->in;
+	macro = args->macro;
+	boolif = args->boolif;
 
 	if (parse_current->parent->cl_head != parse_current) {
 		/* ignore anything that isn't following a parenthesis */
@@ -6130,13 +6130,31 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		goto exit;
 	}
 
+	if (tunif != NULL) {
+		if (parse_current->data == CIL_KEY_TUNABLE) {
+			rc = SEPOL_ERR;
+			cil_tree_log(parse_current, CIL_ERR, "Found tunable");
+			cil_log(CIL_ERR, "Tunables cannot be defined within tunableif statement\n");
+			goto exit;
+		}
+	}
+
+	if (in != NULL) {
+		if (parse_current->data == CIL_KEY_IN) {
+			rc = SEPOL_ERR;
+			cil_tree_log(parse_current, CIL_ERR, "Found in-statement");
+			cil_log(CIL_ERR, "in-statements cannot be defined within in-statements\n");
+			goto exit;
+		}
+	}
+
 	if (macro != NULL) {
-		if (parse_current->data == CIL_KEY_MACRO ||
-			parse_current->data == CIL_KEY_TUNABLE ||
+		if (parse_current->data == CIL_KEY_TUNABLE ||
 			parse_current->data == CIL_KEY_IN ||
 			parse_current->data == CIL_KEY_BLOCK ||
 			parse_current->data == CIL_KEY_BLOCKINHERIT ||
-			parse_current->data == CIL_KEY_BLOCKABSTRACT) {
+			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
+			parse_current->data == CIL_KEY_MACRO) {
 			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in macros", (char *)parse_current->data);
 			goto exit;
@@ -6144,15 +6162,15 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	}
 
 	if (boolif != NULL) {
-		if (parse_current->data != CIL_KEY_CONDTRUE &&
+		if (parse_current->data != CIL_KEY_TUNABLEIF &&
+			parse_current->data != CIL_KEY_CALL &&
+			parse_current->data != CIL_KEY_CONDTRUE &&
 			parse_current->data != CIL_KEY_CONDFALSE &&
-			parse_current->data != CIL_KEY_AUDITALLOW &&
-			parse_current->data != CIL_KEY_TUNABLEIF &&
 			parse_current->data != CIL_KEY_ALLOW &&
 			parse_current->data != CIL_KEY_DONTAUDIT &&
+			parse_current->data != CIL_KEY_AUDITALLOW &&
 			parse_current->data != CIL_KEY_TYPETRANSITION &&
-			parse_current->data != CIL_KEY_TYPECHANGE &&
-			parse_current->data != CIL_KEY_CALL) {
+			parse_current->data != CIL_KEY_TYPECHANGE) {
 			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "Found %s", (char*)parse_current->data);
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
@@ -6166,24 +6184,6 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		}
 	}
 
-	if (tunif != NULL) {
-		if (parse_current->data == CIL_KEY_TUNABLE) {
-			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "Found tunable");
-			cil_log(CIL_ERR, "Tunables cannot be defined within tunableif statement\n");
-			goto exit;
-		}
-	}
-
-	if (in != NULL) {
-		if (parse_current->data == CIL_KEY_IN) {
-			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "Found in-statement");
-			cil_log(CIL_ERR, "in-statements cannot be defined within in-statements\n");
-			goto exit;
-		}
-	}
-
 	cil_tree_node_init(&ast_node);
 
 	ast_node->parent = ast_current;
@@ -6469,14 +6469,6 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 
 	if (rc == SEPOL_OK) {
 		if (ast_current->cl_head == NULL) {
-			if (ast_current->flavor == CIL_MACRO) {
-				args->macro = ast_current;
-			}
-
-			if (ast_current->flavor == CIL_BOOLEANIF) {
-				args->boolif = ast_current;
-			}
-
 			if (ast_current->flavor == CIL_TUNABLEIF) {
 				args->tunif = ast_current;
 			}
@@ -6485,6 +6477,14 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 				args->in = ast_current;
 			}
 
+			if (ast_current->flavor == CIL_MACRO) {
+				args->macro = ast_current;
+			}
+
+			if (ast_current->flavor == CIL_BOOLEANIF) {
+				args->boolif = ast_current;
+			}
+
 			ast_current->cl_head = ast_node;
 		} else {
 			ast_current->cl_tail->next = ast_node;
@@ -6520,14 +6520,6 @@ int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void
 
 	args->ast = ast->parent;
 
-	if (ast->flavor == CIL_MACRO) {
-		args->macro = NULL;
-	}
-
-	if (ast->flavor == CIL_BOOLEANIF) {
-		args->boolif = NULL;
-	}
-
 	if (ast->flavor == CIL_TUNABLEIF) {
 		args->tunif = NULL;
 	}
@@ -6536,6 +6528,14 @@ int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void
 		args->in = NULL;
 	}
 
+	if (ast->flavor == CIL_MACRO) {
+		args->macro = NULL;
+	}
+
+	if (ast->flavor == CIL_BOOLEANIF) {
+		args->boolif = NULL;
+	}
+
 	// At this point we no longer have any need for parse_current or any of its
 	// siblings; they have all been converted to the appropriate AST node. The
 	// full parse tree will get deleted elsewhere, but in an attempt to
@@ -6560,10 +6560,10 @@ int cil_build_ast(struct cil_db *db, struct cil_tree_node *parse_tree, struct ci
 
 	extra_args.ast = ast;
 	extra_args.db = db;
-	extra_args.macro = NULL;
-	extra_args.boolif = NULL;
 	extra_args.tunif = NULL;
 	extra_args.in = NULL;
+	extra_args.macro = NULL;
+	extra_args.boolif = NULL;
 
 	rc = cil_tree_walk(parse_tree, __cil_build_ast_node_helper, NULL, __cil_build_ast_last_child_helper, &extra_args);
 	if (rc != SEPOL_OK) {
-- 
2.26.3

