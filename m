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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E5C433C1
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CBC6199E
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCVQt2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhCVQtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 12:49:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB33BC061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:49:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i9so11230336qka.2
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gq+YzaO1oo55cHYpYkNnNsbkYrRE5djJ9a4fHzymQcA=;
        b=XlNB8Sj8qml6O7HzRdJ1VraH5fWE4F6m/7+a0v1YVBQGgW5pUJnfVYexc8b2WwY3id
         F60wRAl07UG0MYHMhHWxXEQoXpBFQ9rUsa0BlWlDIIkm0XSd3HX+Q2bRCZjKi9nfAWR9
         A2kxXVA49wK6Ki91SWouPG3nkJbbKSzWfFQS7PCs3nLO2qXyXfwjfzb+LTnEDhxPWBRq
         7eumPobjtxXiZwvMBGZF0Krnc5z6P6HzoyhXP+HI6iTtwU6yf1lRCI7LrKzgbS6r/odw
         Z3mpVs75Wi+fvYiySQOXeXE6WPJcmYtW/dLH6Pam4D3JfqAUm2+jhzXsVrcn89as707J
         mbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gq+YzaO1oo55cHYpYkNnNsbkYrRE5djJ9a4fHzymQcA=;
        b=ar3QAOaOCBcVCgmeiJTc8WrpLqm2bSmlcZTqP0j0CG8blRvmvTsP8s9aNLLbKGSlM6
         uGa5hKY9oJJsau9kvqk++C2IT6fHw8YdnUsrBa6wIzCvBaiwbpO155DtFuJ8ki5ATJTt
         cDSrfC6EywHAllA+tAtcUbP84Eh9sn0XQ9oXzSP24Lds5msUIAmfdwNs1takWV7Lftbl
         ZiCSjEOBZ8QlvEdAKTmQhPAI4hLLMxI26hRvIdy3IrFDGAvoFbB4vd7FLFG+QIhBJGXE
         F9QCliNVXQV3FouMeYaSjJ3Ny0w2Q3N8uPOS0Ly8d0UxkPNqS1SNdwzN8u7x4BsEE1za
         QMbQ==
X-Gm-Message-State: AOAM530cca8TY6f4QWYSzdv/vjUYr36NbSOCMOQ9o8BA70/Te64PVoqy
        CzwI8xAsIhqn3XLxQbu0HZKUjCRHYYWU3A==
X-Google-Smtp-Source: ABdhPJwkpfqhDl1O3MoebD1QMyMCgggHTXQOtqKmgW7TygW9EXpc8FeP9lbbsW0qVQ81aXIE5pIsoQ==
X-Received: by 2002:a05:620a:15b7:: with SMTP id f23mr972867qkk.58.1616431749698;
        Mon, 22 Mar 2021 09:49:09 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f9sm10964106qkk.115.2021.03.22.09.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:49:08 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol/cil: Move check for the shadowing of macro parameters
Date:   Mon, 22 Mar 2021 12:47:03 -0400
Message-Id: <20210322164703.29564-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322164703.29564-1-jwcart2@gmail.com>
References: <20210322164703.29564-1-jwcart2@gmail.com>
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
index a18e072b..5bb396ad 100644
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
index 09e3daf9..d7102612 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -356,6 +356,24 @@ int cil_verify_conditional_blocks(struct cil_tree_node *current)
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
index 905761b0..134deac9 100644
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
2.26.2

