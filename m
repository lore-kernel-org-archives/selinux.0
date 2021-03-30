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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06180C433E2
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B120161953
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhC3RkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhC3Rjj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E240C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:39 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so16700760qkk.1
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rykAEjz/3D9VRJTwNHTNqNM736CbNd/UlYqHvAhkMu4=;
        b=KHL/uagxDA8Ze0WjathWuhjkpaBKrRm21gQfsaX1JSmX4diy8VAwMUc/+akKw1Ti6g
         3Qgp2cbj4m9RhpEG0VH+Cdm0UnrGAIvon726n08XS+BfZeGrfix378yOEZf6YaUsTs8O
         kffTGI7f/H7ppQV+AEyBJ1gPKjE+5AoZCP1NFUSn7wBA4PYIJ6Gj3lfp9N+5mxQbEBrE
         GF0q0k72X/72wnXu6S5lcCoHYt1HVEG9AFjT9wiBX372tbWNpTMoLM1rBmiSzSYxlOma
         mp8WH6ZbTbg0E/MZy5F7eG7yzFP82wMbYeMbF5dSrp7rW0zku6E5nAORipYclRJfC2Q+
         Cwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rykAEjz/3D9VRJTwNHTNqNM736CbNd/UlYqHvAhkMu4=;
        b=U2hSLHke+vLmAExHE9oe0RyaRynVZnsQ4EjCs+n/LjrXeLB9Oy+O0gQ+yvT6GgXYd1
         Vj4RqjZWB9SVy2IFTgMnK2f6Fy3oJZmcB4znn4e9DqR3bj7a3SNc/oi/E5PAe2Rxj/u4
         WkvxzyvoW0HLSahQMMVeV4yyQNmteaT05bjjrI93Upko8vzI8Ooq2nxpqWajDBlRel3Z
         ouPiJrKkufvjxod8WFqwZ9/n68apnLRiixZB0ThqQfBhySLJH8l7eqDS20UqRiGDBkFr
         RVhU5MOGS1g1AuEP+9iotnTpqsD2Vp3FHjms4ZfSX9CZ87PDUISON89l6Bpp6QfLFb7v
         Ffrg==
X-Gm-Message-State: AOAM531xvidD1jLwwPDF6pPybJupmbCtDKL9dZoGcUxkmxX8YHEe3nrb
        5xQKUxwXUsAT7gOicKGJKvmNSn6cg4OSUg==
X-Google-Smtp-Source: ABdhPJzw+6c05iVWEev2IDg31Hd9Lfm1o4Uc1aEPOW7MHseJgodd+OBGkWZiZ+waiVSzwE1tPhCkTQ==
X-Received: by 2002:a37:a811:: with SMTP id r17mr32326428qke.268.1617125978210;
        Tue, 30 Mar 2021 10:39:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:37 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/12] libsepol/cil: Reorder checks for invalid rules when resolving AST
Date:   Tue, 30 Mar 2021 13:39:16 -0400
Message-Id: <20210330173920.281531-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reorder checks for invalid rules in the blocks of tunableifs,
in-statements, macros, and booleanifs when resolving the AST for
consistency.

Order the checks in the same order the blocks will be resolved in,
so tuanbleif, in-statement, macro, booleanif, and then non-block
rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 76 +++++++++++++++---------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a61462d0..93fc0d63 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -52,10 +52,10 @@ struct cil_args_resolve {
 	enum cil_pass pass;
 	uint32_t *changed;
 	struct cil_list *disabled_optionals;
+	struct cil_tree_node *block;
+	struct cil_tree_node *macro;
 	struct cil_tree_node *optional;
 	struct cil_tree_node *boolif;
-	struct cil_tree_node *macro;
-	struct cil_tree_node *block;
 	struct cil_list *sidorder_lists;
 	struct cil_list *classorder_lists;
 	struct cil_list *unordered_classorder_lists;
@@ -3777,50 +3777,52 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
 	enum cil_pass pass = args->pass;
-	struct cil_tree_node *optional = args->optional;
-	struct cil_tree_node *boolif = args->boolif;
 	struct cil_tree_node *block = args->block;
 	struct cil_tree_node *macro = args->macro;
+	struct cil_tree_node *optional = args->optional;
+	struct cil_tree_node *boolif = args->boolif;
 
 	if (node == NULL) {
 		goto exit;
 	}
 
-	if (optional != NULL) {
-		if (node->flavor == CIL_TUNABLE || node->flavor == CIL_MACRO) {
-			/* tuanbles and macros are not allowed in optionals*/
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
+	if (block != NULL) {
+		if (node->flavor == CIL_CAT ||
+		    node->flavor == CIL_SENS) {
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in blocks", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 	}
 
-	if (block != NULL) {
-		if (node->flavor == CIL_CAT || node->flavor == CIL_SENS) {
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in blocks", cil_node_to_string(node));
+	if (macro != NULL) {
+		if (node->flavor == CIL_BLOCK ||
+		    node->flavor == CIL_BLOCKINHERIT ||
+		    node->flavor == CIL_BLOCKABSTRACT ||
+		    node->flavor == CIL_MACRO) {
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in macros", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 	}
 
-	if (macro != NULL) {
-		if (node->flavor == CIL_BLOCKINHERIT ||
-			node->flavor == CIL_BLOCK ||
-			node->flavor == CIL_BLOCKABSTRACT ||
-			node->flavor == CIL_MACRO) {
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in macros", cil_node_to_string(node));
+	if (optional != NULL) {
+		if (node->flavor == CIL_TUNABLE ||
+		    node->flavor == CIL_MACRO) {
+			/* tuanbles and macros are not allowed in optionals*/
+			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 	}
 
 	if (boolif != NULL) {
-		if (!(node->flavor == CIL_CONDBLOCK ||
-			node->flavor == CIL_AVRULE ||
-			node->flavor == CIL_TYPE_RULE ||
-			node->flavor == CIL_CALL ||
-			node->flavor == CIL_TUNABLEIF ||
-			node->flavor == CIL_NAMETYPETRANSITION)) {
+		if (!(node->flavor == CIL_TUNABLEIF ||
+		      node->flavor == CIL_CALL ||
+		      node->flavor == CIL_CONDBLOCK ||
+		      node->flavor == CIL_AVRULE ||
+		      node->flavor == CIL_TYPE_RULE ||
+		      node->flavor == CIL_NAMETYPETRANSITION)) {
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
 				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs (tunableif treated as a booleanif)", cil_node_to_string(node));
 			} else {
@@ -3886,12 +3888,12 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
 
 	if (parent->flavor == CIL_BLOCK) {
 		args->block = parent;
+	} else if (parent->flavor == CIL_MACRO) {
+		args->macro = parent;
 	} else if (parent->flavor == CIL_OPTIONAL) {
 		args->optional = parent;
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = parent;
-	} else if (parent->flavor == CIL_MACRO) {
-		args->macro = parent;
 	}
 
 	return SEPOL_OK;
@@ -3913,7 +3915,17 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 
 	parent = current->parent;
 
-	if (parent->flavor == CIL_MACRO) {
+	if (parent->flavor == CIL_BLOCK) {
+		struct cil_tree_node *n = parent->parent;
+		args->block = NULL;
+		while (n && n->flavor != CIL_ROOT) {
+			if (n->flavor == CIL_BLOCK) {
+				args->block = n;
+				break;
+			}
+			n = n->parent;
+		}
+	} else if (parent->flavor == CIL_MACRO) {
 		args->macro = NULL;
 	} else if (parent->flavor == CIL_OPTIONAL) {
 		struct cil_tree_node *n = parent->parent;
@@ -3931,16 +3943,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 		}
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = NULL;
-	} else if (parent->flavor == CIL_BLOCK) {
-		struct cil_tree_node *n = parent->parent;
-		args->block = NULL;
-		while (n && n->flavor != CIL_ROOT) {
-			if (n->flavor == CIL_BLOCK) {
-				args->block = n;
-				break;
-			}
-			n = n->parent;
-		}
 	}
 
 	return SEPOL_OK;
@@ -3964,9 +3966,9 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.pass = pass;
 	extra_args.changed = &changed;
 	extra_args.block = NULL;
+	extra_args.macro = NULL;
 	extra_args.optional = NULL;
 	extra_args.boolif= NULL;
-	extra_args.macro = NULL;
 	extra_args.sidorder_lists = NULL;
 	extra_args.classorder_lists = NULL;
 	extra_args.unordered_classorder_lists = NULL;
-- 
2.26.3

