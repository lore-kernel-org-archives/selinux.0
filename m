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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C54C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C2F61007
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhDSPQ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbhDSPQ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048CC06138D
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id h13so17421549qka.2
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiVKg2WBPAYnYNP2ztrBu/JhVoUYWMeDmegrPETotks=;
        b=tshprCSRNs+hr88ogqFCgXY0mKV2MVlvYgymqY5+C9a6aKDAcY33DeVOImHikOxbFD
         TW6RBOpp+ePzqiUgsx98XNgTpaKXRBcbIE7A2ia4YPkeprguchefv9v0VayX1TXLdFg+
         VqiLeAyB5xWlWyWbdENT+IiHGqUNXQcwH3rYFjZ5hXKwLhvGzOTYIJMvfBmnAGcu5szL
         0e+QVN8oREa3cvYa16HnUOEmhTZPV/3twHsfGy3nvX93YDYAPG4v/qCMM7Twjrvu5LP8
         U4hPsZ/JfhfNQEt4l++/5ZONZPfraJk/tL1LziE8YmYyRC6e+vcj+P7yMGhNCoLsWJrc
         JGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiVKg2WBPAYnYNP2ztrBu/JhVoUYWMeDmegrPETotks=;
        b=OUFuI7pIhVC2uHpvXeyIZMvtUhOOeJfwyqvAcv6TsuF52B522bSsI4jF4Hapc8bkDn
         lwEpjYiMZIn+Sqx+8zsI1DswLurjY7vEtH6sKTRiaHc0oIGFGk3+mEV0+lyqQq7jzy29
         4Vmgozuo2UVo2USrYgEcQjIzbCMKB1jPeins/3zQmzqS3pNJtAV8nEqCJHzkN/eT82gn
         q6eGDk9zFTg6yNNeydOAtBzs8yajWsZS11yL9UcIsbl06VwWNfSHH0mxEBZBoZn0mMPT
         h4HnsNVSzGQuCt1V82z5BAy5ixRExy2jf9m/ElsqgL91XrnK/O7ccw0I6pHwAj+S2OHu
         B6iw==
X-Gm-Message-State: AOAM532FMkSNiIuAImtO2vzIknnl1W1G+aKE0LKBJ86276gTYeVPrtJa
        05bHYSD45SzgoNcee0acM/5/Z/5B6OFlCQ==
X-Google-Smtp-Source: ABdhPJx41+BV9eZnyVKJF1Oi/iFpsO18zsWs3o7xsNxx7XX4sR3H/G9hpr3FcNGQhtlNOlQyoe7Acw==
X-Received: by 2002:a37:b807:: with SMTP id i7mr12360093qkf.126.1618845386687;
        Mon, 19 Apr 2021 08:16:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:26 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 11/11 v2] libsepol/cil: Move check for the shadowing of macro parameters
Date:   Mon, 19 Apr 2021 11:15:57 -0400
Message-Id: <20210419151557.87561-12-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In cil_gen_node(), after the declaration is added to the symbol
table, if the parent is a macro, then a check is made to ensure
the declaration does not shadow any of the macro's parameters.
This check also needs to be done when copying the AST.

Move the check for the shadowing of macro parameters to its own
function, cil_verify_decl_does_not_shadow_macro_parameter(), and
refactor cil_gen_node() and __cil_copy_node_helper() to use the
new function.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 16 +++-------------
 libsepol/cil/src/cil_copy_ast.c  | 20 ++++----------------
 libsepol/cil/src/cil_verify.c    | 18 ++++++++++++++++++
 libsepol/cil/src/cil_verify.h    |  1 +
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index ec81db55..a4a2baa0 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -161,19 +161,9 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	}
 
 	if (ast_node->parent->flavor == CIL_MACRO) {
-		struct cil_list_item *item;
-		struct cil_list *param_list = ((struct cil_macro*)ast_node->parent->data)->params;
-		if (param_list != NULL) {
-			cil_list_for_each(item, param_list) {
-				struct cil_param *param = item->data;
-				if (param->flavor == ast_node->flavor) {
-					if (param->str == key) {
-						cil_log(CIL_ERR, "%s %s shadows a macro parameter in macro declaration\n", cil_node_to_string(ast_node), key);
-						rc = SEPOL_ERR;
-						goto exit;
-					}
-				}
-			}
+		rc = cil_verify_decl_does_not_shadow_macro_parameter(ast_node->parent->data, ast_node, key);
+		if (rc != SEPOL_OK) {
+			goto exit;
 		}
 	}
 
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 12bc553c..954eab33 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -40,6 +40,7 @@
 #include "cil_copy_ast.h"
 #include "cil_build_ast.h"
 #include "cil_strpool.h"
+#include "cil_verify.h"
 
 struct cil_args_copy {
 	struct cil_tree_node *dest;
@@ -1716,7 +1717,6 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	struct cil_db *db = NULL;
 	struct cil_args_copy *args = NULL;
 	struct cil_tree_node *namespace = NULL;
-	struct cil_param *param = NULL;
 	enum cil_sym_index sym_index = CIL_SYM_UNKNOWN;
 	symtab_t *symtab = NULL;
 	void *data = NULL;
@@ -2043,21 +2043,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 			}
 
 			if (namespace->flavor == CIL_MACRO) {
-				struct cil_macro *macro = namespace->data;
-				struct cil_list *param_list = macro->params;
-				if (param_list != NULL) {
-					struct cil_list_item *item;
-					cil_list_for_each(item, param_list) {
-						param = item->data;
-						if (param->flavor == new->flavor) {
-							if (param->str == ((struct cil_symtab_datum*)new->data)->name) {
-								cil_tree_log(orig, CIL_ERR, "%s %s shadows a macro parameter", cil_node_to_string(new), ((struct cil_symtab_datum*)orig->data)->name);
-								cil_tree_log(namespace, CIL_ERR, "Note: macro declaration");
-								rc = SEPOL_ERR;
-								goto exit;
-							}
-						}
-					}
+				rc = cil_verify_decl_does_not_shadow_macro_parameter(namespace->data, orig, DATUM(orig->data)->name);
+				if (rc != SEPOL_OK) {
+					goto exit;
 				}
 			}
 		}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 8fd54360..5a37dd2f 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -412,6 +412,24 @@ int cil_verify_conditional_blocks(struct cil_tree_node *current)
 	return SEPOL_OK;
 }
 
+int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, struct cil_tree_node *node, const char *name)
+{
+	struct cil_list_item *item;
+	struct cil_list *param_list = macro->params;
+	if (param_list != NULL) {
+		cil_list_for_each(item, param_list) {
+			struct cil_param *param = item->data;
+			if (param->flavor == node->flavor) {
+				if (param->str == name) {
+					cil_log(CIL_ERR, "%s %s shadows a macro parameter in macro declaration\n", cil_node_to_string(node), name);
+					return SEPOL_ERR;
+				}
+			}
+		}
+	}
+	return SEPOL_OK;
+}
+
 int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
 {
 	struct cil_list_item *i;
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index 1887ae3f..c497018f 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -62,6 +62,7 @@ int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, en
 int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
 int cil_verify_conditional_blocks(struct cil_tree_node *current);
+int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, struct cil_tree_node *node, const char *name);
 int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list);
 int __cil_verify_ranges(struct cil_list *list);
 int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
-- 
2.26.3

