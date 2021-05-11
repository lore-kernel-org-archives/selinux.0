Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32CC43460
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EB261433
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKUEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhEKUEW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BFC061574
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dl3so10878460qvb.3
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjdqO/ymwXUGPgxx6yXUTGCdJ9WveRBNFiN5g1q5zPQ=;
        b=Dd4GXk+zjL7XbER1XcWhgJxawyjGpDWxhoDbVzKPSaTTI+d+m4j9Urz7YMKy1k0IoY
         bL4oTgsWGee2Gav4TOA3pUOOvMCOkbyUdyHI+jD52E/ft3UAxLvPGnsrH5rRGSYZ93K7
         q9VID86PztJatuLi+1WtD0SqjZkNrazw5JVSMsVwoH+mLl3cwO+k6Vd4BY2OBRHYelGf
         NB+rzp4TpTinrNiZhjsn1XYRQpXWATCzHjIYQuE21C1SuH1qSX1YFHKIZkT/jNWvjG3T
         0+yW+eyNeKiK3eaQeTOZOZ/2qM03Af+V4GlxvWZ6XaIjh6aofdWRwLW+sj9xg6WsM0wf
         rzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjdqO/ymwXUGPgxx6yXUTGCdJ9WveRBNFiN5g1q5zPQ=;
        b=KUQbbAZkh6P4gxO8HT/3Hh5PeXLhxvzkZEmwg1ovZq8s/0EEy/apQYljeK7aPUTijs
         JWNdjF0NcHczGPpqeB85TGjeyIke/DXOMhNPdHFUi36azdbAX1vTyIN4PvXmwP84Jd0d
         tpk9CnzJQ1nEit9lQCppw1TTyYOwxt7FX9vsnVTdN56C81B+BS27diB3Y3rL662Dn+v8
         blewO/BUaVXSS6mxudVgwtiezAqAJ80qS4z0bf3FDZAhIwwoRXXxEfxOf2MO+GXnDAIT
         V+9HOKfOwYiGe9VdM2MNMvLMZ+lmXzLsIRoDpr5gIYEldL3cs9ShPP4ByfO57Xl1KlJo
         tcWQ==
X-Gm-Message-State: AOAM532fVKvjXssCHwX8bGXBXfC3izQA2y6AdcXhcep+r4hkhX2gRR1s
        VADH3Bh63Z5zWfdJDVrBBDLnrB/GSAYp8g==
X-Google-Smtp-Source: ABdhPJy5BNxwzDasw48w41V0hZj52Ib0W2IUuX1QCxiu/3PwCzc+3AmJ554q0d9/9NpZm7K6lDhYMQ==
X-Received: by 2002:a0c:9c0f:: with SMTP id v15mr26362745qve.24.1620763393481;
        Tue, 11 May 2021 13:03:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:13 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5 v2] libsepo/cil: Refactor macro call resolution
Date:   Tue, 11 May 2021 16:02:59 -0400
Message-Id: <20210511200301.407855-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
References: <20210511200301.407855-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rename cil_resolve_call1() as cil resolve_call() and rename
cil_resolve_call2() as cil_resolve_call_args() to make it clearer
what is being done in each function.

Move code to build call arguments out of cil_resolve_call() and into
the new function called cil_build_call_args() so that the logic of
cil_resolve_call() can be seen.

Exit cil_resolve_call() immediately if the call has already been
copied.

In __cil_resolve_ast_node(), only resolve calls outside of macros.
This results in more calls to cil_copy_ast(), but slightly less
rules copied overall (since no rules are copied into a macro). This
also means that the CIL_PASS_MACRO pass is not needed and can be
eliminated.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_internal.h    |   1 -
 libsepol/cil/src/cil_resolve_ast.c | 599 +++++++++++++++--------------
 2 files changed, 303 insertions(+), 297 deletions(-)

diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 74e0b34d..a77c9520 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -59,7 +59,6 @@ enum cil_pass {
 	CIL_PASS_BLKIN_LINK,
 	CIL_PASS_BLKIN_COPY,
 	CIL_PASS_BLKABS,
-	CIL_PASS_MACRO,
 	CIL_PASS_CALL1,
 	CIL_PASS_CALL2,
 	CIL_PASS_ALIAS1,
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index bbe86e22..b96118ce 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2840,359 +2840,371 @@ exit:
 	return rc;
 }
 
-int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
+static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call *call, struct cil_macro *macro, void *extra_args)
 {
-	struct cil_call *new_call = current->data;
 	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
-	struct cil_tree_node *macro_node = NULL;
-	struct cil_symtab_datum *macro_datum = NULL;
+	struct cil_list_item *item;
+	struct cil_args *arg = NULL;
+	struct cil_tree_node *arg_node = NULL;
 	int rc = SEPOL_ERR;
 
-	if (args != NULL) {
-		db = args->db;
+	if (macro->params == NULL) {
+		if (call->args_tree == NULL) {
+			return SEPOL_OK;
+		} else {
+			cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
+			return SEPOL_ERR;;
+		}
 	}
-
-	rc = cil_resolve_name(current, new_call->macro_str, CIL_SYM_BLOCKS, extra_args, &macro_datum);
-	if (rc != SEPOL_OK) {
-		goto exit;
+	if (call->args_tree == NULL) {
+		cil_tree_log(call_node, CIL_ERR, "Missing arguments");
+		return SEPOL_ERR;
 	}
 
-	macro_node = NODE(macro_datum);
+	arg_node = call->args_tree->root->cl_head;
 
-	if (macro_node->flavor != CIL_MACRO) {
-		cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", new_call->macro_str);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-	new_call->macro = (struct cil_macro*)macro_datum;
+	cil_list_init(&call->args, CIL_LIST_ITEM);
 
-	if (new_call->macro->params != NULL ) {
+	cil_list_for_each(item, macro->params) {
+		enum cil_flavor flavor = ((struct cil_param*)item->data)->flavor;
 
-		struct cil_list_item *item;
-		struct cil_args *new_arg = NULL;
-		struct cil_tree_node *pc = NULL;
-
-		if (new_call->args_tree == NULL) {
-			cil_tree_log(current, CIL_ERR, "Missing arguments");
+		if (arg_node == NULL) {
+			cil_tree_log(call_node, CIL_ERR, "Missing arguments");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+		if (item->flavor != CIL_PARAM) {
 			rc = SEPOL_ERR;
 			goto exit;
 		}
 
-		pc = new_call->args_tree->root->cl_head;
-
-		cil_list_init(&new_call->args, CIL_LIST_ITEM);
-
-		cil_list_for_each(item, new_call->macro->params) {
-			enum cil_flavor flavor = ((struct cil_param*)item->data)->flavor;
+		cil_args_init(&arg);
 
-			if (pc == NULL) {
-				cil_tree_log(current, CIL_ERR, "Missing arguments");
+		switch (flavor) {
+		case CIL_NAME: {
+			struct cil_name *name;
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-			if (item->flavor != CIL_PARAM) {
+			name = __cil_insert_name(args->db, arg_node->data, call_node);
+			if (name != NULL) {
+				arg->arg = (struct cil_symtab_datum *)name;
+			} else {
+				arg->arg_str = arg_node->data;
+			}
+		}
+			break;
+		case CIL_TYPE:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-
-			cil_args_init(&new_arg);
-
-			switch (flavor) {
-			case CIL_NAME: {
-				struct cil_name *name;
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				name = __cil_insert_name(args->db, pc->data, current);
-				if (name != NULL) {
-					new_arg->arg = (struct cil_symtab_datum *)name;
-				} else {
-					new_arg->arg_str = pc->data;
-				}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_ROLE:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
 			}
-				break;
-			case CIL_TYPE:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_ROLE:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_USER:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_SENS:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_CAT:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_BOOL:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_CATSET: {
-				if (pc->cl_head != NULL) {
-					struct cil_catset *catset = NULL;
-					struct cil_tree_node *cat_node = NULL;
-					cil_catset_init(&catset);
-					rc = cil_fill_cats(pc, &catset->cats);
-					if (rc != SEPOL_OK) {
-						cil_destroy_catset(catset);
-						cil_destroy_args(new_arg);
-						goto exit;
-					}
-					cil_tree_node_init(&cat_node);
-					cat_node->flavor = CIL_CATSET;
-					cat_node->data = catset;
-					cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
-									CIL_LIST_ITEM, cat_node);
-					new_arg->arg = (struct cil_symtab_datum*)catset;
-				} else if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_USER:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_SENS:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_CAT:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_BOOL:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_CATSET: {
+			if (arg_node->cl_head != NULL) {
+				struct cil_catset *catset = NULL;
+				struct cil_tree_node *cat_node = NULL;
+				cil_catset_init(&catset);
+				rc = cil_fill_cats(arg_node, &catset->cats);
+				if (rc != SEPOL_OK) {
+					cil_destroy_catset(catset);
+					cil_destroy_args(arg);
 					goto exit;
-				} else {
-					new_arg->arg_str = pc->data;
 				}
-
-				break;
+				cil_tree_node_init(&cat_node);
+				cat_node->flavor = CIL_CATSET;
+				cat_node->data = catset;
+				cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
+								CIL_LIST_ITEM, cat_node);
+				arg->arg = (struct cil_symtab_datum*)catset;
+			} else if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			} else {
+				arg->arg_str = arg_node->data;
 			}
-			case CIL_LEVEL: {
-				if (pc->cl_head != NULL) {
-					struct cil_level *level = NULL;
-					struct cil_tree_node *lvl_node = NULL;
-					cil_level_init(&level);
-
-					rc = cil_fill_level(pc->cl_head, level);
-					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Failed to create anonymous level, rc: %d\n", rc);
-						cil_destroy_level(level);
-						cil_destroy_args(new_arg);
-						goto exit;
-					}
-					cil_tree_node_init(&lvl_node);
-					lvl_node->flavor = CIL_LEVEL;
-					lvl_node->data = level;
-					cil_list_append(((struct cil_symtab_datum*)level)->nodes, 
-									CIL_LIST_ITEM, lvl_node);
-					new_arg->arg = (struct cil_symtab_datum*)level;
-				} else if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
+
+			break;
+		}
+		case CIL_LEVEL: {
+			if (arg_node->cl_head != NULL) {
+				struct cil_level *level = NULL;
+				struct cil_tree_node *lvl_node = NULL;
+				cil_level_init(&level);
+
+				rc = cil_fill_level(arg_node->cl_head, level);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to create anonymous level, rc: %d\n", rc);
+					cil_destroy_level(level);
+					cil_destroy_args(arg);
 					goto exit;
-				} else {
-					new_arg->arg_str = pc->data;
 				}
-
-				break;
+				cil_tree_node_init(&lvl_node);
+				lvl_node->flavor = CIL_LEVEL;
+				lvl_node->data = level;
+				cil_list_append(((struct cil_symtab_datum*)level)->nodes,
+								CIL_LIST_ITEM, lvl_node);
+				arg->arg = (struct cil_symtab_datum*)level;
+			} else if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			} else {
+				arg->arg_str = arg_node->data;
 			}
-			case CIL_LEVELRANGE: {
-				if (pc->cl_head != NULL) {
-					struct cil_levelrange *range = NULL;
-					struct cil_tree_node *range_node = NULL;
-					cil_levelrange_init(&range);
-
-					rc = cil_fill_levelrange(pc->cl_head, range);
-					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Failed to create anonymous levelrange, rc: %d\n", rc);
-						cil_destroy_levelrange(range);
-						cil_destroy_args(new_arg);
-						goto exit;
-					}
-					cil_tree_node_init(&range_node);
-					range_node->flavor = CIL_LEVELRANGE;
-					range_node->data = range;
-					cil_list_append(((struct cil_symtab_datum*)range)->nodes, 
-									CIL_LIST_ITEM, range_node);
-					new_arg->arg = (struct cil_symtab_datum*)range;
-				} else if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
+
+			break;
+		}
+		case CIL_LEVELRANGE: {
+			if (arg_node->cl_head != NULL) {
+				struct cil_levelrange *range = NULL;
+				struct cil_tree_node *range_node = NULL;
+				cil_levelrange_init(&range);
+
+				rc = cil_fill_levelrange(arg_node->cl_head, range);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to create anonymous levelrange, rc: %d\n", rc);
+					cil_destroy_levelrange(range);
+					cil_destroy_args(arg);
 					goto exit;
-				} else {
-					new_arg->arg_str = pc->data;
 				}
-
-				break;
+				cil_tree_node_init(&range_node);
+				range_node->flavor = CIL_LEVELRANGE;
+				range_node->data = range;
+				cil_list_append(((struct cil_symtab_datum*)range)->nodes,
+								CIL_LIST_ITEM, range_node);
+				arg->arg = (struct cil_symtab_datum*)range;
+			} else if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			} else {
+				arg->arg_str = arg_node->data;
 			}
-			case CIL_IPADDR: {
-				if (pc->cl_head != NULL) {
-					struct cil_ipaddr *ipaddr = NULL;
-					struct cil_tree_node *addr_node = NULL;
-					cil_ipaddr_init(&ipaddr);
-
-					rc = cil_fill_ipaddr(pc->cl_head, ipaddr);
-					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
-						cil_destroy_ipaddr(ipaddr);
-						cil_destroy_args(new_arg);
-						goto exit;
-					}
-					cil_tree_node_init(&addr_node);
-					addr_node->flavor = CIL_IPADDR;
-					addr_node->data = ipaddr;
-					cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
-									CIL_LIST_ITEM, addr_node);
-					new_arg->arg = (struct cil_symtab_datum*)ipaddr;
-				} else if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
+
+			break;
+		}
+		case CIL_IPADDR: {
+			if (arg_node->cl_head != NULL) {
+				struct cil_ipaddr *ipaddr = NULL;
+				struct cil_tree_node *addr_node = NULL;
+				cil_ipaddr_init(&ipaddr);
+
+				rc = cil_fill_ipaddr(arg_node->cl_head, ipaddr);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
+					cil_destroy_ipaddr(ipaddr);
+					cil_destroy_args(arg);
 					goto exit;
-				} else {
-					new_arg->arg_str = pc->data;
 				}
+				cil_tree_node_init(&addr_node);
+				addr_node->flavor = CIL_IPADDR;
+				addr_node->data = ipaddr;
+				cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
+								CIL_LIST_ITEM, addr_node);
+				arg->arg = (struct cil_symtab_datum*)ipaddr;
+			} else if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			} else {
+				arg->arg_str = arg_node->data;
+			}
 
-				break;
+			break;
+		}
+		case CIL_CLASS:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
 			}
-			case CIL_CLASS:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_MAP_CLASS:
-				if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
-					goto exit;
-				}
-				new_arg->arg_str = pc->data;
-				break;
-			case CIL_CLASSPERMISSION: {
-				if (pc->cl_head != NULL) {
-					struct cil_classpermission *cp = NULL;
-					struct cil_tree_node *cp_node = NULL;
-
-					cil_classpermission_init(&cp);
-					rc = cil_fill_classperms_list(pc, &cp->classperms);
-					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Failed to create anonymous classpermission\n");
-						cil_destroy_classpermission(cp);
-						cil_destroy_args(new_arg);
-						goto exit;
-					}
-					cil_tree_node_init(&cp_node);
-					cp_node->flavor = CIL_CLASSPERMISSION;
-					cp_node->data = cp;
-					cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
-					new_arg->arg = (struct cil_symtab_datum*)cp;
-				} else if (pc->data == NULL) {
-					cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
-					cil_destroy_args(new_arg);
-					rc = SEPOL_ERR;
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_MAP_CLASS:
+			if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			arg->arg_str = arg_node->data;
+			break;
+		case CIL_CLASSPERMISSION: {
+			if (arg_node->cl_head != NULL) {
+				struct cil_classpermission *cp = NULL;
+				struct cil_tree_node *cp_node = NULL;
+
+				cil_classpermission_init(&cp);
+				rc = cil_fill_classperms_list(arg_node, &cp->classperms);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to create anonymous classpermission\n");
+					cil_destroy_classpermission(cp);
+					cil_destroy_args(arg);
 					goto exit;
-				} else {
-					new_arg->arg_str = pc->data;
 				}
-				break;
-			}
-			default:
-				cil_log(CIL_ERR, "Unexpected flavor: %d\n", 
-						(((struct cil_param*)item->data)->flavor));
-				cil_destroy_args(new_arg);
+				cil_tree_node_init(&cp_node);
+				cp_node->flavor = CIL_CLASSPERMISSION;
+				cp_node->data = cp;
+				cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
+				arg->arg = (struct cil_symtab_datum*)cp;
+			} else if (arg_node->data == NULL) {
+				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
+				cil_destroy_args(arg);
 				rc = SEPOL_ERR;
 				goto exit;
+			} else {
+				arg->arg_str = arg_node->data;
 			}
-			new_arg->param_str = ((struct cil_param*)item->data)->str;
-			new_arg->flavor = flavor;
-
-			cil_list_append(new_call->args, CIL_ARGS, new_arg);
-
-			pc = pc->next;
+			break;
 		}
-
-		if (pc != NULL) {
-			cil_tree_log(current, CIL_ERR, "Unexpected arguments");
+		default:
+			cil_log(CIL_ERR, "Unexpected flavor: %d\n",
+					(((struct cil_param*)item->data)->flavor));
+			cil_destroy_args(arg);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-	} else if (new_call->args_tree != NULL) {
-		cil_tree_log(current, CIL_ERR, "Unexpected arguments");
+		arg->param_str = ((struct cil_param*)item->data)->str;
+		arg->flavor = flavor;
+
+		cil_list_append(call->args, CIL_ARGS, arg);
+
+		arg_node = arg_node->next;
+	}
+
+	if (arg_node != NULL) {
+		cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
 		rc = SEPOL_ERR;
 		goto exit;
 	}
 
-	if (new_call->copied == 0) {
-		new_call->copied = 1;
+	return SEPOL_OK;
 
-		rc = cil_check_recursive_call(current, macro_node);
-		if (rc != SEPOL_OK) {
-			goto exit;
-		}
+exit:
+	return rc;
+}
 
-		rc = cil_copy_ast(db, macro_node, current);
-		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to copy macro, rc: %d\n", rc);
-			goto exit;
-		}
+int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_call *call = current->data;
+	struct cil_args_resolve *args = extra_args;
+	struct cil_tree_node *macro_node = NULL;
+	struct cil_symtab_datum *macro_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	if (call->copied) {
+		return SEPOL_OK;
+	}
+
+	rc = cil_resolve_name(current, call->macro_str, CIL_SYM_BLOCKS, extra_args, &macro_datum);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	macro_node = NODE(macro_datum);
+
+	if (macro_node->flavor != CIL_MACRO) {
+		cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", call->macro_str);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+	call->macro = (struct cil_macro*)macro_datum;
+
+	rc = cil_build_call_args(current, call, call->macro, extra_args);
+	if (rc != SEPOL_OK) {
+		goto exit;
 	}
 
+	rc = cil_check_recursive_call(current, macro_node);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	rc = cil_copy_ast(args->db, macro_node, current);
+	if (rc != SEPOL_OK) {
+		cil_tree_log(current, CIL_ERR, "Failed to copy macro %s to call", macro_datum->name);
+		goto exit;
+	}
+
+	call->copied = 1;
+
 	return SEPOL_OK;
 
 exit:
 	return rc;
 }
 
-int cil_resolve_call2(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args)
 {
-	struct cil_call *new_call = current->data;
+	struct cil_call *call = current->data;
 	int rc = SEPOL_ERR;
 	enum cil_sym_index sym_index = CIL_SYM_UNKNOWN;
 	struct cil_list_item *item;
 
-	if (new_call->args == NULL) {
+	if (call->args == NULL) {
 		rc = SEPOL_OK;
 		goto exit;
 	}
 
-	cil_list_for_each(item, new_call->args) {
+	cil_list_for_each(item, call->args) {
 		struct cil_args *arg = item->data;
 		if (arg->arg == NULL && arg->arg_str == NULL) {
 			cil_log(CIL_ERR, "Arguments not created correctly\n");
@@ -3603,19 +3615,14 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 			rc = cil_resolve_blockabstract(node, args);
 		}
 		break;
-	case CIL_PASS_MACRO:
-		if (node->flavor == CIL_CALL && args->macro != NULL) {
-			rc = cil_resolve_call1(node, args);
-		}
-		break;
 	case CIL_PASS_CALL1:
-		if (node->flavor == CIL_CALL) {
-			rc = cil_resolve_call1(node, args);
+		if (node->flavor == CIL_CALL && args->macro == NULL) {
+			rc = cil_resolve_call(node, args);
 		}
 		break;
 	case CIL_PASS_CALL2:
-		if (node->flavor == CIL_CALL) {
-			rc = cil_resolve_call2(node, args);
+		if (node->flavor == CIL_CALL && args->macro == NULL) {
+			rc = cil_resolve_call_args(node, args);
 		}
 		break;
 	case CIL_PASS_ALIAS1:
@@ -3919,7 +3926,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	}
 
 	if (node->flavor == CIL_MACRO) {
-		if (pass != CIL_PASS_TIF && pass != CIL_PASS_MACRO) {
+		if (pass != CIL_PASS_TIF) {
 			*finished = CIL_TREE_SKIP_HEAD;
 			rc = SEPOL_OK;
 			goto exit;
-- 
2.26.3

