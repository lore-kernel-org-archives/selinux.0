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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B9BC433E3
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D106961987
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhC3RkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhC3Rjh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF628C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i9so16679654qka.2
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nc/zJUbibFsdwu4XOt5o22kI3txgov9uz+pGpG2O6pw=;
        b=k0wMLIF6FZR+pykf73zz43xrZk/bKpM253l5m6r3Q6kiu2JybIvbHNJMKMg4W8Lp1N
         aYuQbzzhlE21oRyFYC6PbUilUswSGh8y3DFJnJgwZTRR9JKW36Vo4xr5kVIEWkXRujJH
         aK/JV6pcOGRHgV0T+sT8ihMLrs5avhfuIAmVqIZkEKkd4XDeBA9mC8SqOgOX8MkgOIS0
         gSUHdQ9H+YdKgA1jGbOAfARDx8kU9J6sW1j9De0E7otYjF/b2Q9V78gel/cmEijiJRa0
         zlb6rRuEM4qnI6F8i5P3qVySDnnz3nJBUw1F1gloCku5gigUSVJckK53ztb03rEpCYbW
         gQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nc/zJUbibFsdwu4XOt5o22kI3txgov9uz+pGpG2O6pw=;
        b=Ea1nfeJYp3NK8iO4M5MqzYtKGG377Myqq5Y+8UDWGDb0UzanSHYmuEJJrBQcTRWdWi
         31AY4ECCwB6CqKqKiK6TZIyWWL2QVgCCvErCRFLLXcFSzKMj8yDL22SQLo5yTZ2PeKVz
         CDr1Zwf/CIrs24cZHgpJG0CHWZt5gShvjYsDduos1Ez+5INFywyktE8F7kDabYlN/FLv
         0w2h5CnZGtjtE1i6RIhqThTcXuVVMV/E4bOnH59yqCoV/hl1WSXX2voFFEphrO1EUGbJ
         NcsdZ2sSAEENIZOTwfGpC0QSyOpjhpX25hN1KMTPReAykbepbZHMoH4xHSBzei/w+J4F
         c9Fw==
X-Gm-Message-State: AOAM533ZhLiy35Cc4a3XAJy4WpcM+MNL/8pSXCnFldUUoSDNnr8msWqu
        +v+sjUsNJwHbf1Bhfz/YFWw4k5H84wZCrA==
X-Google-Smtp-Source: ABdhPJwsAqcitskiuks/6GuH1Wt3DxhmxnfzAvxh40c7YwEW7o82+Ke0rc1yp7UaKehgcSScj6GxxA==
X-Received: by 2002:a37:7e87:: with SMTP id z129mr32802798qkc.243.1617125976763;
        Tue, 30 Mar 2021 10:39:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 04/12] libsepol/cil: Use AST to track blocks and optionals when resolving
Date:   Tue, 30 Mar 2021 13:39:15 -0400
Message-Id: <20210330173920.281531-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When resolving the AST, block and optional stacks are used to
determine if the current rule being resolved is in a block or
an optional. There is no need to do this since the parent node
pointers can be used when exiting a block or an optional to
determine if resolution is still within a block or an optional.

When entering either a block or an optional, update the appropriate
tree node pointer. When finished with the last child of a block or
optional, set the appropriate pointer to NULL. If a parent of the
same kind is found when the parent node pointers are followed back
to the root node, then set the pointer to that tree node.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 107 +++++++++--------------------
 1 file changed, 32 insertions(+), 75 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 63beed92..a61462d0 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -52,10 +52,10 @@ struct cil_args_resolve {
 	enum cil_pass pass;
 	uint32_t *changed;
 	struct cil_list *disabled_optionals;
-	struct cil_tree_node *optstack;
+	struct cil_tree_node *optional;
 	struct cil_tree_node *boolif;
 	struct cil_tree_node *macro;
-	struct cil_tree_node *blockstack;
+	struct cil_tree_node *block;
 	struct cil_list *sidorder_lists;
 	struct cil_list *classorder_lists;
 	struct cil_list *unordered_classorder_lists;
@@ -3777,16 +3777,16 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
 	enum cil_pass pass = args->pass;
-	struct cil_tree_node *optstack = args->optstack;
+	struct cil_tree_node *optional = args->optional;
 	struct cil_tree_node *boolif = args->boolif;
-	struct cil_tree_node *blockstack = args->blockstack;
+	struct cil_tree_node *block = args->block;
 	struct cil_tree_node *macro = args->macro;
 
 	if (node == NULL) {
 		goto exit;
 	}
 
-	if (optstack != NULL) {
+	if (optional != NULL) {
 		if (node->flavor == CIL_TUNABLE || node->flavor == CIL_MACRO) {
 			/* tuanbles and macros are not allowed in optionals*/
 			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
@@ -3795,7 +3795,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		}
 	}
 
-	if (blockstack != NULL) {
+	if (block != NULL) {
 		if (node->flavor == CIL_CAT || node->flavor == CIL_SENS) {
 			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in blocks", cil_node_to_string(node));
 			rc = SEPOL_ERR;
@@ -3849,11 +3849,11 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	if (rc == SEPOL_ENOENT) {
 		enum cil_log_level lvl = CIL_ERR;
 
-		if (optstack != NULL) {
+		if (optional != NULL) {
 			lvl = CIL_INFO;
 
-			struct cil_optional *opt = (struct cil_optional *)optstack->data;
-			struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
+			struct cil_optional *opt = (struct cil_optional *)optional->data;
+			struct cil_tree_node *opt_node = NODE(opt);;
 			/* disable an optional if something failed to resolve */
 			opt->enabled = CIL_FALSE;
 			cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
@@ -3876,39 +3876,18 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
 {
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
-	struct cil_tree_node *optstack = NULL;
 	struct cil_tree_node *parent = NULL;
-	struct cil_tree_node *blockstack = NULL;
-	struct cil_tree_node *new = NULL;
 
 	if (current == NULL || extra_args == NULL) {
 		goto exit;
 	}
 
-	optstack = args->optstack;
 	parent = current->parent;
-	blockstack = args->blockstack;
 
-	if (parent->flavor == CIL_OPTIONAL || parent->flavor == CIL_BLOCK) {
-		/* push this node onto a stack */
-		cil_tree_node_init(&new);
-
-		new->data = parent->data;
-		new->flavor = parent->flavor;
-
-		if (parent->flavor == CIL_OPTIONAL) {
-			if (optstack != NULL) {
-				optstack->parent = new;
-				new->cl_head = optstack;
-			}
-			args->optstack = new;
-		} else if (parent->flavor == CIL_BLOCK) {
-			if (blockstack != NULL) {
-				blockstack->parent = new;
-				new->cl_head = blockstack;
-			}
-			args->blockstack = new;
-		}
+	if (parent->flavor == CIL_BLOCK) {
+		args->block = parent;
+	} else if (parent->flavor == CIL_OPTIONAL) {
+		args->optional = parent;
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = parent;
 	} else if (parent->flavor == CIL_MACRO) {
@@ -3927,7 +3906,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
 	struct cil_tree_node *parent = NULL;
-	struct cil_tree_node *blockstack = NULL;
 
 	if (current == NULL ||  extra_args == NULL) {
 		goto exit;
@@ -3938,30 +3916,31 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 	if (parent->flavor == CIL_MACRO) {
 		args->macro = NULL;
 	} else if (parent->flavor == CIL_OPTIONAL) {
-		struct cil_tree_node *optstack;
-
+		struct cil_tree_node *n = parent->parent;
 		if (((struct cil_optional *)parent->data)->enabled == CIL_FALSE) {
 			*(args->changed) = CIL_TRUE;
 			cil_list_append(args->disabled_optionals, CIL_NODE, parent);
 		}
-
-		/* pop off the stack */
-		optstack = args->optstack;
-		args->optstack = optstack->cl_head;
-		if (optstack->cl_head) {
-			optstack->cl_head->parent = NULL;
+		args->optional = NULL;
+		while (n && n->flavor != CIL_ROOT) {
+			if (n->flavor == CIL_OPTIONAL) {
+				args->optional = n;
+				break;
+			}
+			n = n->parent;
 		}
-		free(optstack);
 	} else if (parent->flavor == CIL_BOOLEANIF) {
 		args->boolif = NULL;
 	} else if (parent->flavor == CIL_BLOCK) {
-		/* pop off the stack */
-		blockstack = args->blockstack;
-		args->blockstack = blockstack->cl_head;
-		if (blockstack->cl_head) {
-			blockstack->cl_head->parent = NULL;
+		struct cil_tree_node *n = parent->parent;
+		args->block = NULL;
+		while (n && n->flavor != CIL_ROOT) {
+			if (n->flavor == CIL_BLOCK) {
+				args->block = n;
+				break;
+			}
+			n = n->parent;
 		}
-		free(blockstack);
 	}
 
 	return SEPOL_OK;
@@ -3970,16 +3949,6 @@ exit:
 	return rc;
 }
 
-static void cil_destroy_tree_node_stack(struct cil_tree_node *curr)
-{
-	struct cil_tree_node *next;
-	while (curr != NULL) {
-		next = curr->cl_head;
-		free(curr);
-		curr = next;
-	}
-}
-
 int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 {
 	int rc = SEPOL_ERR;
@@ -3994,7 +3963,8 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.db = db;
 	extra_args.pass = pass;
 	extra_args.changed = &changed;
-	extra_args.optstack = NULL;
+	extra_args.block = NULL;
+	extra_args.optional = NULL;
 	extra_args.boolif= NULL;
 	extra_args.macro = NULL;
 	extra_args.sidorder_lists = NULL;
@@ -4003,7 +3973,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.catorder_lists = NULL;
 	extra_args.sensitivityorder_lists = NULL;
 	extra_args.in_list = NULL;
-	extra_args.blockstack = NULL;
 
 	cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
 	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
@@ -4107,17 +4076,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 			}
 			cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
 			cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
-		}
-
-		/* reset the arguments */
-		changed = 0;
-		while (extra_args.optstack != NULL) {
-			cil_destroy_tree_node_stack(extra_args.optstack);
-			extra_args.optstack = NULL;
-		}
-		while (extra_args.blockstack!= NULL) {
-			cil_destroy_tree_node_stack(extra_args.blockstack);
-			extra_args.blockstack = NULL;
+			changed = 0;
 		}
 	}
 
@@ -4128,8 +4087,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 
 	rc = SEPOL_OK;
 exit:
-	cil_destroy_tree_node_stack(extra_args.optstack);
-	cil_destroy_tree_node_stack(extra_args.blockstack);
 	__cil_ordered_lists_destroy(&extra_args.sidorder_lists);
 	__cil_ordered_lists_destroy(&extra_args.classorder_lists);
 	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
-- 
2.26.3

