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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF21C433ED
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099B76105A
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEDUml (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 May 2021 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEDUmk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 May 2021 16:42:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A5C061574
        for <selinux@vger.kernel.org>; Tue,  4 May 2021 13:41:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id f15so7425917qtv.5
        for <selinux@vger.kernel.org>; Tue, 04 May 2021 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+ZHGyBEP1Q4vJokl+yAnHX1o2H0Xcxrso3jcZjqpgE=;
        b=nqvaLFHOyCcllFWWmdWqLLCt4krppn4F0Oo2a1PbV4pC5VqTO3GpTc7VnnlXUM4Elp
         gsldgScmiT/y/5MxAiuJLDZXzpkQZn1GOLrog3oibW6Q+zbz7BNZjJdF/LynJVagTclE
         tXRm63Z7pbJZGHZ6y+0MKspXjCkCYnQ/kKWs0gpyiG2fL+ddSjobRyyu4qcoBzGEnyLD
         fTfnk3L9KAJozgmByVTM2ScPJjB42U870QcooCr1Z03PKN8vNcH9hsU5dN5/6FE7f8yF
         5ZvjTr9ZyZ82BmxRZJ5sPYqzSuB5QAhQSqeM3oCfd4BYHhXU81hO1pafvQtIxSk+Ge8R
         Vbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+ZHGyBEP1Q4vJokl+yAnHX1o2H0Xcxrso3jcZjqpgE=;
        b=Wb185bM91445QebaZcWKuVux/I0YkZBaUHKw5LridRJvom50sh9uisAX6+XEG4+lcx
         xiygnRpnaQtsnuNcH7sYp1Gev4P2sSKFUMPFxgz3JiLzKl0hlBgltYM/zpOKr59EFygp
         0QlPZsO6x5sD3gnfGilb/2Ly7aFrtrlK/9jpNsrpkhSJx0gSSvJaKNdoLzyC+7bL2xcW
         I67xiy7iy5rv9k5e4OlRiJwuNNNA/xRAlArjXk2hXYMuQPFZwD4/oHXo9Hm6i0u9hc4h
         ZmMbTnUvaK1x29hJ6JtD786xoyXPtmS+E3d1XzQRntz0334BmoWsjGRpCktWsto2o6GR
         mL2g==
X-Gm-Message-State: AOAM533YnX+mFZ+OZqcFoD0Bd5t9R4y1vjvgxuXAXqx7ZtfHeLxdVWRO
        ekl4979Q8ggEiac/JaO7HxGoSgPZOwMJGw==
X-Google-Smtp-Source: ABdhPJwj78xGuVFFZVicAwWCYfQnxVlJfjJq2Efi1FZwnHpwEjIzrdEUuAMqrRupw214K1XeeCYeQA==
X-Received: by 2002:ac8:7ee8:: with SMTP id r8mr12165080qtc.56.1620160904210;
        Tue, 04 May 2021 13:41:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id y26sm3598359qtf.66.2021.05.04.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:41:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/cil: Check for self-referential loops in sets
Date:   Tue,  4 May 2021 16:41:40 -0400
Message-Id: <20210504204140.100798-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secilc-fuzzer found a self-referential loop using category sets.
Any set declaration in CIL that allows sets in it is susceptible to
the creation of a self-referential loop. There is a check, but only
for the name of the set being declared being used in the set
declaration.

Check for self-refential loops in user, role, and type attributes
and in category sets. Since all of the sets need to be declared,
this check has to be done when verifying the CIL db before doing
the post phase.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Make cil_verify_no_self_reference() static

 libsepol/cil/src/cil_resolve_ast.c | 31 +---------
 libsepol/cil/src/cil_verify.c      | 97 +++++++++++++++++++++---------
 libsepol/cil/src/cil_verify.h      |  1 -
 3 files changed, 71 insertions(+), 58 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f251ed15..5368ae80 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -438,11 +438,6 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args
 		goto exit;
 	}
 
-	rc = cil_verify_no_self_reference(attr_datum, attrtypes->datum_expr);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	if (attr->expr_list == NULL) {
 		cil_list_init(&attr->expr_list, CIL_TYPEATTRIBUTE);
 	}
@@ -1151,11 +1146,6 @@ int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args
 		goto exit;
 	}
 
-	rc = cil_verify_no_self_reference(attr_datum, attrroles->datum_expr);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	if (attr->expr_list == NULL) {
 		cil_list_init(&attr->expr_list, CIL_ROLEATTRIBUTE);
 	}
@@ -1666,21 +1656,7 @@ exit:
 
 int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, void *extra_args)
 {
-	int rc = SEPOL_ERR;
-
-	rc = cil_resolve_cats(current, catset->cats, extra_args);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	rc = cil_verify_no_self_reference((struct cil_symtab_datum *)catset, catset->cats->datum_expr);
-	if (rc != SEPOL_OK) {
-		cil_list_destroy(&catset->cats->datum_expr, CIL_FALSE);
-		goto exit;
-	}
-
-exit:
-	return rc;
+	return cil_resolve_cats(current, catset->cats, extra_args);
 }
 
 int cil_resolve_senscat(struct cil_tree_node *current, void *extra_args)
@@ -3545,11 +3521,6 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
 		goto exit;
 	}
 
-	rc = cil_verify_no_self_reference(attr_datum, attrusers->datum_expr);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	if (attr->expr_list == NULL) {
 		cil_list_init(&attr->expr_list, CIL_USERATTRIBUTE);
 	}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 5a37dd2f..8e15a0e6 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -430,28 +430,71 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
 	return SEPOL_OK;
 }
 
-int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
+static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
+
+static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_symtab_datum *orig)
 {
-	struct cil_list_item *i;
+	struct cil_list_item *item;
+	int rc = SEPOL_OK;
 
-	cil_list_for_each(i, datum_list) {
-		if (i->flavor == CIL_DATUM) {
-			struct cil_symtab_datum *d = i->data;
-			if (d == datum) {
-				cil_log(CIL_ERR,"Self-reference found for %s\n",datum->name);
-				return SEPOL_ERR;
-			}
-		} else if (i->flavor == CIL_LIST) {
-			int rc = cil_verify_no_self_reference(datum, i->data);
-			if (rc != SEPOL_OK) {
-				return SEPOL_ERR;
-			}
+	if (!expr) {
+		return SEPOL_OK;
+	}
+
+	cil_list_for_each(item, expr) {
+		if (item->flavor == CIL_DATUM) {
+			struct cil_symtab_datum* datum = item->data;
+			rc = cil_verify_no_self_reference(FLAVOR(datum), datum, orig);
+		} else if (item->flavor == CIL_LIST) {
+			rc = __verify_no_self_reference_in_expr(item->data, orig);
+		}
+		if (rc != SEPOL_OK) {
+			return SEPOL_ERR;
 		}
 	}
 
 	return SEPOL_OK;
 }
 
+static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig)
+{
+	int rc = SEPOL_OK;
+
+	if (datum == orig) {
+		cil_tree_log(NODE(orig), CIL_ERR, "Self-reference found for %s", orig->name);
+		return SEPOL_ERR;
+	} else if (orig == NULL) {
+		orig = datum;
+	}
+
+	switch (flavor) {
+	case CIL_USERATTRIBUTE: {
+		struct cil_userattribute *attr = (struct cil_userattribute *)datum;
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		break;
+	}
+	case CIL_ROLEATTRIBUTE: {
+		struct cil_roleattribute *attr = (struct cil_roleattribute *)datum;
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		break;
+	}
+	case CIL_TYPEATTRIBUTE: {
+		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
+		rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
+		break;
+	}
+	case CIL_CATSET: {
+		struct cil_catset *set = (struct cil_catset *)datum;
+		rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, orig);
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 int __cil_verify_ranges(struct cil_list *list)
 {
 	int rc = SEPOL_ERR;
@@ -1757,27 +1800,22 @@ static int __cil_verify_map_class(struct cil_tree_node *node)
 
 int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
-	int rc = SEPOL_ERR;
+	int rc = SEPOL_OK;
 
-	if (node->flavor == CIL_MACRO) {
+	switch (node->flavor) {
+	case CIL_MACRO: {
 		*finished = CIL_TREE_SKIP_HEAD;
-		rc = SEPOL_OK;
-		goto exit;
-	} else if (node->flavor == CIL_BLOCK) {
+		break;
+	}
+	case CIL_BLOCK: {
 		struct cil_block *blk = node->data;
 		if (blk->is_abstract == CIL_TRUE) {
 			*finished = CIL_TREE_SKIP_HEAD;
 		}
-		rc = SEPOL_OK;
-		goto exit;
+		break;
 	}
-
-	switch (node->flavor) {
 	case CIL_USER:
 		rc = __cil_verify_user_pre_eval(node);
-		if (rc != SEPOL_OK) {
-			goto exit;
-		}
 		break;
 	case CIL_MAP_CLASS:
 		rc = __cil_verify_map_class(node);
@@ -1785,11 +1823,16 @@ int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __at
 	case CIL_CLASSPERMISSION:
 		rc = __cil_verify_classpermission(node);
 		break;
+	case CIL_USERATTRIBUTE:
+	case CIL_ROLEATTRIBUTE:
+	case CIL_TYPEATTRIBUTE:
+	case CIL_CATSET:
+		rc = cil_verify_no_self_reference(node->flavor, node->data, NULL);
+		break;
 	default:
 		rc = SEPOL_OK;
 		break;
 	}
 
-exit:
 	return rc;
 }
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index c497018f..4ea14f5b 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -63,7 +63,6 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
 int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
 int cil_verify_conditional_blocks(struct cil_tree_node *current);
 int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, struct cil_tree_node *node, const char *name);
-int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list);
 int __cil_verify_ranges(struct cil_list *list);
 int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
 int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor);
-- 
2.26.3

