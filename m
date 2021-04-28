Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDCC43460
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CE9611BE
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhD1USx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbhD1USv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04856C061574
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:05 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 8so31229609qkv.8
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krBP23f1Ygb27jZ+g49fjqQ8mRwubqqTbS5KBXtWFnQ=;
        b=L/gjg4Xjy+fz0JRsC1BV93Jzgl+93ufPc4L35b4HL9of+XkB/j/rt2LTRlgHOtt2zv
         YYM59iz6gZZMMdqLCmzK7QLq51cNEGssFX88hHxyRnxAx5rGw0mzoRxT6A+C+88ai4l6
         mdGM3UvIVVu321IrUhvh0138hgX3bnrVei1cwIck6ASIyXngAbm8a3vNXsewOxID5AHa
         kbbIi8xpQHjvt20pSBwEUYMv5fp87z2FPKA7JRQDgg+Ya4ccNmHTd4RgZEzFgnMIaOfX
         UErEQLG6R2sLKU7cTiTXUZpBASb8yPKBO9XitLxNE9FG23HroAPGWHWz3OvVP+/ghFcx
         0Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krBP23f1Ygb27jZ+g49fjqQ8mRwubqqTbS5KBXtWFnQ=;
        b=dqQdN+yrp2yj6snbwlJ0bXd8naxylM/cOeLtCSZZaBAH/f+soNfsTdmkSjcOuz+y3o
         r86sKQEuafurS3EmG3nQ1X+4Zr7U4xYZco3uoW1r1nTM9OX2H/JRVygbd+8zClOMHjEv
         Xr9Eel6PrxEQ6C6bTPZMTQdcS+T2r7sAetmSQyTddWG4ZbZV5b3zyF/3UXXPzkQOpKWz
         XvOs20qwYcnKyxMnmjGbjgfnNRER3PHL01zTqU/ygT6a7OIq0lWDv4hun4mJ0lqlmLdV
         gjn2u/JQxgrhKeYTLmckavYkOhSHOIKSVDi0sFzqHfIHXTYS95FG00V5IJJBC9zX9+Zi
         DoeQ==
X-Gm-Message-State: AOAM532hQS+BwtFS4zy8Dnlhbc+6Ty3LAU5ItkdVWKN9moZOWcaEp/xI
        OV9Wna9YmSaBDMyDKhKLrfhOfS60Woofpw==
X-Google-Smtp-Source: ABdhPJz+IAP1rlz6DshvjxbBkcnBe5FHTM0Cc7ToyrYLDUwp0dmHNdJQ/ISzYzksUk+cFfx0VtHrPg==
X-Received: by 2002:a37:58c5:: with SMTP id m188mr30134098qkb.327.1619641084040;
        Wed, 28 Apr 2021 13:18:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:18:03 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5] libsepol/cil: Check for self-referential loops in sets
Date:   Wed, 28 Apr 2021 16:17:52 -0400
Message-Id: <20210428201753.282831-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
References: <20210428201753.282831-1-jwcart2@gmail.com>
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
 libsepol/cil/src/cil_resolve_ast.c | 31 +---------
 libsepol/cil/src/cil_verify.c      | 97 +++++++++++++++++++++---------
 libsepol/cil/src/cil_verify.h      |  1 -
 3 files changed, 71 insertions(+), 58 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index b081d45d..34c28fc6 100644
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
@@ -3544,11 +3520,6 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
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
index 5a37dd2f..4c860a21 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -430,28 +430,71 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
 	return SEPOL_OK;
 }
 
-int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
+int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
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
 
+int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig)
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

