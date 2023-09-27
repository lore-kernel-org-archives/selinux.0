Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970BE82CBB
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjI0TAg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0TAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6A12A
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41819a68143so43468981cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841228; x=1696446028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OJIp/8NJu/8VDiYFJTRNupdCF9e7x0HRhtElUJzaAU=;
        b=XGfbKXCXVhe/xhxMLlwSUnbeaqk81i4/UkLWTelFOsPb8USbrMPyZ7b7dVqfHFwJ0O
         sWgmz/pZR4seh1s3+BC1MLnIwuIoocwYeyLnFsTkXbCbLQ3uv5dQ5sgU/BYYewplB8mj
         eSfktaHGcIjRr4/YL3zchEza5DuF2Kd1EIx9L1U6DGDqgQQ0oKLVan0VCZprl3G072+X
         y8iurn/uyHSWa2fg7iZpXhFp+/wqej5B2cCTdGkeubnB6o95cBQkRmtkJFxQaou7082g
         RlwqD8E8c81KXghPCZpW1GLfrNep9E7RWf4alTWJPXEft6K6fUdYxVTu6pG2SNH2+L/7
         8jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841228; x=1696446028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OJIp/8NJu/8VDiYFJTRNupdCF9e7x0HRhtElUJzaAU=;
        b=VAzp0SAN2ZvFxvV6QLw/1V6YcOdKMOJj6zELc6HKlNInXTZn72oTfRmIYi9laN8G5R
         /C7k1eqpWu7p72SwQl1bOje0IhDunDnpLzbtIv7FemmrKmdloE85qFLFE7ZK7WV2iM9n
         IUQ8PDkS+BFLrBAa1xwTc1/aybj8F6Z69LtcTaCVzFLJW5DzB9M08YW+FTwiVZFGsd7x
         k1z6lu9tlzZY9drPPk0rmzD985oaTxD/xh6xIv/up4NdgHtimX2LIxKKcufqz691PA2g
         cnvXefUy997pWrI/iu4aEVeDdYHuxrf992oGyf6p3I2ApMFTGWRbdk1mszbDMnwBKndG
         fjlg==
X-Gm-Message-State: AOJu0Yw58ppQIhtxWVJVkgVR47OSpfKN0MqfuViOjAcPABQ+1YgAmelQ
        Kct5bCfe6Spro9Z+xJ6l1t2+wX3F4sk=
X-Google-Smtp-Source: AGHT+IHLLn2NSTS2sCa7P0kNN73th7ebyOHW7ytQlVUcPutYBWaZPbGaG1n4bekQxb/iLg4pUkC34w==
X-Received: by 2002:a05:622a:1a1d:b0:419:5775:7d6a with SMTP id f29-20020a05622a1a1d00b0041957757d6amr2656447qtb.16.1695841227107;
        Wed, 27 Sep 2023 12:00:27 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:26 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
Date:   Wed, 27 Sep 2023 15:00:13 -0400
Message-ID: <20230927190021.1164278-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the CIL AST resolve phase, the functions all take a void *
and struct cil_args_resolve * is passed in to them. But in almost
all cases, only the cil_db is needed.

Modify the functions to take struct cil_db * and pass in extra
arguments in the few cases where something more is needed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 631 +++++++++++++----------------
 libsepol/cil/src/cil_resolve_ast.h | 124 +++---
 2 files changed, 350 insertions(+), 405 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 33b9d321..595bd2b9 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -156,7 +156,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms *cp, void *extra_args)
+int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms *cp, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_symtab_datum *datum = NULL;
@@ -167,7 +167,7 @@ int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms
 		return SEPOL_OK;
 	}
 
-	rc = cil_resolve_name(current, cp->class_str, CIL_SYM_CLASSES, extra_args, &datum);
+	rc = cil_resolve_name(current, cp->class_str, CIL_SYM_CLASSES, db, &datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -191,12 +191,12 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil_classperms_set *cp_set, void *extra_args)
+static int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil_classperms_set *cp_set, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_symtab_datum *datum = NULL;
 
-	rc = cil_resolve_name(current, cp_set->set_str, CIL_SYM_CLASSPERMSETS, extra_args, &datum);
+	rc = cil_resolve_name(current, cp_set->set_str, CIL_SYM_CLASSPERMSETS, db, &datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -204,7 +204,7 @@ static int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil_
 
 	/* This could be an anonymous classpermission */
 	if (datum->name == NULL) {
-		rc = cil_resolve_classperms_list(current, cp_set->set->classperms, extra_args);
+		rc = cil_resolve_classperms_list(current, cp_set->set->classperms, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -216,19 +216,19 @@ exit:
 	return rc;
 }
 
-int cil_resolve_classperms_list(struct cil_tree_node *current, struct cil_list *cp_list, void *extra_args)
+int cil_resolve_classperms_list(struct cil_tree_node *current, struct cil_list *cp_list, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 
 	cil_list_for_each(curr, cp_list) {
 		if (curr->flavor == CIL_CLASSPERMS) {
-			rc = cil_resolve_classperms(current, curr->data, extra_args);
+			rc = cil_resolve_classperms(current, curr->data, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		} else {
-			rc = cil_resolve_classperms_set(current, curr->data, extra_args);
+			rc = cil_resolve_classperms_set(current, curr->data, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -241,20 +241,19 @@ exit:
 	return rc;
 }
 
-int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_classpermissionset *cps, void *extra_args)
+int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_classpermissionset *cps, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
-	struct cil_args_resolve *args = extra_args;
 	struct cil_list_item *curr;
 	struct cil_symtab_datum *datum;
 	struct cil_classpermission *cp;
 
-	rc = cil_resolve_name(current, cps->set_str, CIL_SYM_CLASSPERMSETS, args, &datum);
+	rc = cil_resolve_name(current, cps->set_str, CIL_SYM_CLASSPERMSETS, db, &datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-	rc = cil_resolve_classperms_list(current, cps->classperms, extra_args);
+	rc = cil_resolve_classperms_list(current, cps->classperms, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -292,12 +291,12 @@ static void cil_type_used(struct cil_symtab_datum *datum, int used)
 	}
 }
 
-static int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
+static int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, struct cil_db *db)
 {
 	struct cil_symtab_datum *obj_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, db, &obj_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -309,11 +308,8 @@ exit:
 	return rc;
 }
 
-int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_avrule(struct cil_tree_node *current, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
-
 	struct cil_avrule *rule = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
@@ -321,11 +317,7 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 	int used;
 	int rc = SEPOL_ERR;
 
-	if (args != NULL) {
-		db = args->db;
-	}
-
-	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, args, &src_datum);
+	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -338,7 +330,7 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 	} else if (rule->tgt_str == CIL_KEY_OTHER) {
 		rule->tgt = db->othertype;
 	} else {
-		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
+		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, db, &tgt_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -350,19 +342,19 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 	}
 
 	if (!rule->is_extended) {
-		rc = cil_resolve_classperms_list(current, rule->perms.classperms, extra_args);
+		rc = cil_resolve_classperms_list(current, rule->perms.classperms, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	} else {
 		if (rule->perms.x.permx_str != NULL) {
-			rc = cil_resolve_name(current, rule->perms.x.permx_str, CIL_SYM_PERMX, args, &permx_datum);
+			rc = cil_resolve_name(current, rule->perms.x.permx_str, CIL_SYM_PERMX, db, &permx_datum);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 			rule->perms.x.permx = (struct cil_permissionx*)permx_datum;
 		} else {
-			rc = cil_resolve_permissionx(current, rule->perms.x.permx, extra_args);
+			rc = cil_resolve_permissionx(current, rule->perms.x.permx, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -375,21 +367,14 @@ exit:
 	return rc;
 }
 
-int cil_resolve_deny_rule(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_deny_rule(struct cil_tree_node *current, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
-
 	struct cil_deny_rule *rule = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	if (args != NULL) {
-		db = args->db;
-	}
-
-	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, args, &src_datum);
+	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -402,14 +387,14 @@ int cil_resolve_deny_rule(struct cil_tree_node *current, void *extra_args)
 	} else if (rule->tgt_str == CIL_KEY_OTHER) {
 		rule->tgt = db->othertype;
 	} else {
-		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
+		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, db, &tgt_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		rule->tgt = tgt_datum;
 	}
 
-	rc = cil_resolve_classperms_list(current, rule->classperms, extra_args);
+	rc = cil_resolve_classperms_list(current, rule->classperms, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -420,9 +405,8 @@ exit:
 	return rc;
 }
 
-int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_type_rule(struct cil_tree_node *current, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
 	struct cil_type_rule *rule = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
@@ -431,29 +415,29 @@ int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *result_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, extra_args, &src_datum);
+	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rule->src = src_datum;
 
 	if (rule->tgt_str == CIL_KEY_SELF) {
-		rule->tgt = args->db->selftype;
+		rule->tgt = db->selftype;
 	} else {
-		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
+		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, db, &tgt_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		rule->tgt = tgt_datum;
 	}
 
-	rc = cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	rc = cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES, db, &obj_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rule->obj = (struct cil_class*)obj_datum;
 
-	rc = cil_resolve_name(current, rule->result_str, CIL_SYM_TYPES, extra_args, &result_datum);
+	rc = cil_resolve_name(current, rule->result_str, CIL_SYM_TYPES, db, &result_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -473,7 +457,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_typeattributeset(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_typeattributeset *attrtypes = current->data;
 	struct cil_symtab_datum *attr_datum = NULL;
@@ -481,7 +465,7 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args
 	struct cil_typeattribute *attr = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, attrtypes->attr_str, CIL_SYM_TYPES, extra_args, &attr_datum);
+	rc = cil_resolve_name(current, attrtypes->attr_str, CIL_SYM_TYPES, db, &attr_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -496,7 +480,7 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args
 
 	attr = (struct cil_typeattribute*)attr_datum;
 
-	rc = cil_resolve_expr(CIL_TYPEATTRIBUTESET, attrtypes->str_expr, &attrtypes->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_TYPEATTRIBUTESET, attrtypes->str_expr, &attrtypes->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -513,7 +497,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_expandtypeattribute(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_expandtypeattribute *expandattr = current->data;
 	struct cil_symtab_datum *attr_datum = NULL;
@@ -525,7 +509,7 @@ static int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *
 	cil_list_init(&expandattr->attr_datums, CIL_TYPE);
 
 	cil_list_for_each(curr, expandattr->attr_strs) {
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_TYPES, extra_args, &attr_datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_TYPES, db, &attr_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -547,7 +531,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
+static int cil_resolve_aliasactual(struct cil_tree_node *current, struct cil_db *db, enum cil_flavor flavor, enum cil_flavor alias_flavor)
 {
 	int rc = SEPOL_ERR;
 	enum cil_sym_index sym_index;
@@ -561,7 +545,7 @@ static int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_ar
 		goto exit;
 	}
 
-	rc = cil_resolve_name_keep_aliases(current, aliasactual->alias_str, sym_index, extra_args, &alias_datum);
+	rc = cil_resolve_name_keep_aliases(current, aliasactual->alias_str, sym_index, db, &alias_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -571,7 +555,7 @@ static int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_ar
 		goto exit;
 	}
 
-	rc = cil_resolve_name(current, aliasactual->actual_str, sym_index, extra_args, &actual_datum);
+	rc = cil_resolve_name(current, aliasactual->actual_str, sym_index, db, &actual_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -646,14 +630,14 @@ static int cil_resolve_alias_to_actual(struct cil_tree_node *current, enum cil_f
 	return SEPOL_OK;
 }
 
-int cil_resolve_typepermissive(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_typepermissive(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_typepermissive *typeperm = current->data;
 	struct cil_symtab_datum *type_datum = NULL;
 	struct cil_tree_node *type_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, typeperm->type_str, CIL_SYM_TYPES, extra_args, &type_datum);
+	rc = cil_resolve_name(current, typeperm->type_str, CIL_SYM_TYPES, db, &type_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -674,9 +658,8 @@ exit:
 	return rc;
 }
 
-int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
 	struct cil_nametypetransition *nametypetrans = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
@@ -686,38 +669,38 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_ar
 	struct cil_tree_node *result_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, nametypetrans->src_str, CIL_SYM_TYPES, extra_args, &src_datum);
+	rc = cil_resolve_name(current, nametypetrans->src_str, CIL_SYM_TYPES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	nametypetrans->src = src_datum;
 
 	if (nametypetrans->tgt_str == CIL_KEY_SELF) {
-		nametypetrans->tgt = args->db->selftype;
+		nametypetrans->tgt = db->selftype;
 	} else {
-		rc = cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
+		rc = cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_TYPES, db, &tgt_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		nametypetrans->tgt = tgt_datum;
 	}
 
-	rc = cil_resolve_name(current, nametypetrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	rc = cil_resolve_name(current, nametypetrans->obj_str, CIL_SYM_CLASSES, db, &obj_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	nametypetrans->obj = (struct cil_class*)obj_datum;
 
-	nametypetrans->name = __cil_insert_name(args->db, nametypetrans->name_str, current);
+	nametypetrans->name = __cil_insert_name(db, nametypetrans->name_str, current);
 	if (nametypetrans->name == NULL) {
-		rc = cil_resolve_name(current, nametypetrans->name_str, CIL_SYM_NAMES, extra_args, &name_datum);
+		rc = cil_resolve_name(current, nametypetrans->name_str, CIL_SYM_NAMES, db, &name_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		nametypetrans->name = (struct cil_name *)name_datum;
 	}
 
-	rc = cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYPES, extra_args, &result_datum);
+	rc = cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYPES, db, &result_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -737,7 +720,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_rangetransition(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_rangetransition(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_rangetransition *rangetrans = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
@@ -746,26 +729,26 @@ int cil_resolve_rangetransition(struct cil_tree_node *current, void *extra_args)
 	struct cil_symtab_datum *range_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, rangetrans->src_str, CIL_SYM_TYPES, extra_args, &src_datum);
+	rc = cil_resolve_name(current, rangetrans->src_str, CIL_SYM_TYPES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rangetrans->src = src_datum;
 
-	rc = cil_resolve_name(current, rangetrans->exec_str, CIL_SYM_TYPES, extra_args, &exec_datum);
+	rc = cil_resolve_name(current, rangetrans->exec_str, CIL_SYM_TYPES, db, &exec_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rangetrans->exec = exec_datum;
 
-	rc = cil_resolve_name(current, rangetrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	rc = cil_resolve_name(current, rangetrans->obj_str, CIL_SYM_CLASSES, db, &obj_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	rangetrans->obj = (struct cil_class*)obj_datum;
 
 	if (rangetrans->range_str != NULL) {
-		rc = cil_resolve_name(current, rangetrans->range_str, CIL_SYM_LEVELRANGES, extra_args, &range_datum);
+		rc = cil_resolve_name(current, rangetrans->range_str, CIL_SYM_LEVELRANGES, db, &range_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -773,13 +756,13 @@ int cil_resolve_rangetransition(struct cil_tree_node *current, void *extra_args)
 
 		/* This could still be an anonymous levelrange even if range_str is set, if range_str is a param_str*/
 		if (rangetrans->range->datum.name == NULL) {
-			rc = cil_resolve_levelrange(current, rangetrans->range, extra_args);
+			rc = cil_resolve_levelrange(current, rangetrans->range, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else {
-		rc = cil_resolve_levelrange(current, rangetrans->range, extra_args);
+		rc = cil_resolve_levelrange(current, rangetrans->range, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -800,7 +783,7 @@ static int __class_update_perm_values(__attribute__((unused)) hashtab_key_t k, h
 	return SEPOL_OK;
 }
 
-int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_classcommon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_class *class = NULL;
 	struct cil_class *common = NULL;
@@ -809,7 +792,7 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
 	struct cil_symtab_datum *common_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, clscom->class_str, CIL_SYM_CLASSES, extra_args, &class_datum);
+	rc = cil_resolve_name(current, clscom->class_str, CIL_SYM_CLASSES, db, &class_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -819,7 +802,7 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	rc = cil_resolve_name(current, clscom->common_str, CIL_SYM_COMMONS, extra_args, &common_datum);
+	rc = cil_resolve_name(current, clscom->common_str, CIL_SYM_COMMONS, db, &common_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -849,7 +832,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_classmapping(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_classmapping(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_classmapping *mapping = current->data;
@@ -858,7 +841,7 @@ int cil_resolve_classmapping(struct cil_tree_node *current, void *extra_args)
 	struct cil_symtab_datum *datum = NULL;
 	struct cil_list_item *curr;
 
-	rc = cil_resolve_name(current, mapping->map_class_str, CIL_SYM_CLASSES, extra_args, &datum);
+	rc = cil_resolve_name(current, mapping->map_class_str, CIL_SYM_CLASSES, db, &datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -871,7 +854,7 @@ int cil_resolve_classmapping(struct cil_tree_node *current, void *extra_args)
 
 	mp = (struct cil_perm*)datum;
 
-	rc = cil_resolve_classperms_list(current, mapping->classperms, extra_args);
+	rc = cil_resolve_classperms_list(current, mapping->classperms, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -890,20 +873,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_userrole(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_userrole(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_userrole *userrole = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
 	struct cil_symtab_datum *role_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, userrole->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, userrole->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	userrole->user = (struct cil_user*)user_datum;
 
-	rc = cil_resolve_name(current, userrole->role_str, CIL_SYM_ROLES, extra_args, &role_datum);
+	rc = cil_resolve_name(current, userrole->role_str, CIL_SYM_ROLES, db, &role_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -915,7 +898,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_userlevel(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_userlevel *usrlvl = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
@@ -924,7 +907,7 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *user_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, usrlvl->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, usrlvl->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -940,7 +923,7 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
 	user = (struct cil_user*)user_datum;
 
 	if (usrlvl->level_str != NULL) {
-		rc = cil_resolve_name(current, usrlvl->level_str, CIL_SYM_LEVELS, extra_args, &lvl_datum);
+		rc = cil_resolve_name(current, usrlvl->level_str, CIL_SYM_LEVELS, db, &lvl_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -949,13 +932,13 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
 
 		/* This could still be an anonymous level even if level_str is set, if level_str is a param_str*/
 		if (user->dftlevel->datum.name == NULL) {
-			rc = cil_resolve_level(current, user->dftlevel, extra_args);
+			rc = cil_resolve_level(current, user->dftlevel, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (usrlvl->level != NULL) {
-		rc = cil_resolve_level(current, usrlvl->level, extra_args);
+		rc = cil_resolve_level(current, usrlvl->level, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -968,7 +951,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_userrange(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_userrange *userrange = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
@@ -977,7 +960,7 @@ int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *user_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, userrange->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, userrange->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -993,7 +976,7 @@ int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
 	user = (struct cil_user*)user_datum;
 
 	if (userrange->range_str != NULL) {
-		rc = cil_resolve_name(current, userrange->range_str, CIL_SYM_LEVELRANGES, extra_args, &range_datum);
+		rc = cil_resolve_name(current, userrange->range_str, CIL_SYM_LEVELRANGES, db, &range_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1002,13 +985,13 @@ int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
 
 		/* This could still be an anonymous levelrange even if levelrange_str is set, if levelrange_str is a param_str*/
 		if (user->range->datum.name == NULL) {
-			rc = cil_resolve_levelrange(current, user->range, extra_args);
+			rc = cil_resolve_levelrange(current, user->range, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (userrange->range != NULL) {
-		rc = cil_resolve_levelrange(current, userrange->range, extra_args);
+		rc = cil_resolve_levelrange(current, userrange->range, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1021,14 +1004,14 @@ exit:
 	return rc;
 }
 
-int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_userprefix(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_userprefix *userprefix = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
 	struct cil_tree_node *user_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, userprefix->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, userprefix->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1047,7 +1030,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_selinuxuser(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_selinuxuser *selinuxuser = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
@@ -1055,7 +1038,7 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *user_node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, selinuxuser->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, selinuxuser->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1071,7 +1054,7 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
 	selinuxuser->user = (struct cil_user*)user_datum;
 
 	if (selinuxuser->range_str != NULL) {
-		rc = cil_resolve_name(current, selinuxuser->range_str, CIL_SYM_LEVELRANGES, extra_args, &lvlrange_datum);
+		rc = cil_resolve_name(current, selinuxuser->range_str, CIL_SYM_LEVELRANGES, db, &lvlrange_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1079,13 +1062,13 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
 
 		/* This could still be an anonymous levelrange even if range_str is set, if range_str is a param_str*/
 		if (selinuxuser->range->datum.name == NULL) {
-			rc = cil_resolve_levelrange(current, selinuxuser->range, extra_args);
+			rc = cil_resolve_levelrange(current, selinuxuser->range, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (selinuxuser->range != NULL) {
-		rc = cil_resolve_levelrange(current, selinuxuser->range, extra_args);
+		rc = cil_resolve_levelrange(current, selinuxuser->range, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1096,20 +1079,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_roletype(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_roletype(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_roletype *roletype = current->data;
 	struct cil_symtab_datum *role_datum = NULL;
 	struct cil_symtab_datum *type_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, roletype->role_str, CIL_SYM_ROLES, extra_args, &role_datum);
+	rc = cil_resolve_name(current, roletype->role_str, CIL_SYM_ROLES, db, &role_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	roletype->role = (struct cil_role*)role_datum;
 
-	rc = cil_resolve_name(current, roletype->type_str, CIL_SYM_TYPES, extra_args, &type_datum);
+	rc = cil_resolve_name(current, roletype->type_str, CIL_SYM_TYPES, db, &type_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1121,7 +1104,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_roletransition(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_roletransition *roletrans = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
@@ -1131,25 +1114,25 @@ int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, roletrans->src_str, CIL_SYM_ROLES, extra_args, &src_datum);
+	rc = cil_resolve_name(current, roletrans->src_str, CIL_SYM_ROLES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	roletrans->src = (struct cil_role*)src_datum;
 
-	rc = cil_resolve_name(current, roletrans->tgt_str, CIL_SYM_TYPES, extra_args, &tgt_datum);
+	rc = cil_resolve_name(current, roletrans->tgt_str, CIL_SYM_TYPES, db, &tgt_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	roletrans->tgt = tgt_datum;
 
-	rc = cil_resolve_name(current, roletrans->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	rc = cil_resolve_name(current, roletrans->obj_str, CIL_SYM_CLASSES, db, &obj_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	roletrans->obj = (struct cil_class*)obj_datum;
 
-	rc = cil_resolve_name(current, roletrans->result_str, CIL_SYM_ROLES, extra_args, &result_datum);
+	rc = cil_resolve_name(current, roletrans->result_str, CIL_SYM_ROLES, db, &result_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1167,20 +1150,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_roleallow(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_roleallow(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_roleallow *roleallow = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, roleallow->src_str, CIL_SYM_ROLES, extra_args, &src_datum);
+	rc = cil_resolve_name(current, roleallow->src_str, CIL_SYM_ROLES, db, &src_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	roleallow->src = (struct cil_role*)src_datum;
 
-	rc = cil_resolve_name(current, roleallow->tgt_str, CIL_SYM_ROLES, extra_args, &tgt_datum);
+	rc = cil_resolve_name(current, roleallow->tgt_str, CIL_SYM_ROLES, db, &tgt_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1192,7 +1175,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_roleattributeset(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_roleattributeset *attrroles = current->data;
@@ -1200,7 +1183,7 @@ int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args
 	struct cil_tree_node *attr_node = NULL;
 	struct cil_roleattribute *attr = NULL;
 
-	rc = cil_resolve_name(current, attrroles->attr_str, CIL_SYM_ROLES, extra_args, &attr_datum);
+	rc = cil_resolve_name(current, attrroles->attr_str, CIL_SYM_ROLES, db, &attr_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1213,7 +1196,7 @@ int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args
 	}
 	attr = (struct cil_roleattribute*)attr_datum;
 
-	rc = cil_resolve_expr(CIL_ROLEATTRIBUTESET, attrroles->str_expr, &attrroles->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_ROLEATTRIBUTESET, attrroles->str_expr, &attrroles->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1523,11 +1506,8 @@ exit:
 	return NULL;
 }
 
-int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_classorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *classorder_list, struct cil_list *unordered_classorder_list)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_list *classorder_list = args->classorder_lists;
-	struct cil_list *unordered_classorder_list = args->unordered_classorder_lists;
 	struct cil_classorder *classorder = current->data;
 	struct cil_list *new = NULL;
 	struct cil_list_item *curr = NULL;
@@ -1544,7 +1524,7 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
 			continue;
 		}
 
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve class %s in classorder\n", (char *)curr->data);
 			rc = SEPOL_ERR;
@@ -1574,10 +1554,8 @@ exit:
 	return rc;
 }
 
-int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_sidorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sidorder_list)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_list *sidorder_list = args->sidorder_lists;
 	struct cil_sidorder *sidorder = current->data;
 	struct cil_list *new = NULL;
 	struct cil_list_item *curr = NULL;
@@ -1588,7 +1566,7 @@ int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
 	cil_list_init(&new, CIL_SIDORDER);
 
 	cil_list_for_each(curr, sidorder->sid_list_str) {
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SIDS, extra_args, &datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SIDS, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve sid %s in sidorder\n", (char *)curr->data);
 			goto exit;
@@ -1628,10 +1606,8 @@ static void cil_set_cat_values(struct cil_list *ordered_cats, struct cil_db *db)
 	db->num_cats = v;
 }
 
-int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_catorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *catorder_list)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_list *catorder_list = args->catorder_lists;
 	struct cil_catorder *catorder = current->data;
 	struct cil_list *new = NULL;
 	struct cil_list_item *curr = NULL;
@@ -1644,7 +1620,7 @@ int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
 
 	cil_list_for_each(curr, catorder->cat_list_str) {
 		struct cil_tree_node *node = NULL;
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CATS, extra_args, &cat_datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CATS, db, &cat_datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve category %s in categoryorder\n", (char *)curr->data);
 			goto exit;
@@ -1671,10 +1647,8 @@ exit:
 	return rc;
 }
 
-int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_sensitivityorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sensitivityorder_list)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_list *sensitivityorder_list = args->sensitivityorder_lists;
 	struct cil_sensorder *sensorder = current->data;
 	struct cil_list *new = NULL;
 	struct cil_list_item *curr = NULL;
@@ -1685,7 +1659,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
 	cil_list_init(&new, CIL_LIST_ITEM);
 
 	cil_list_for_each(curr, sensorder->sens_list_str) {
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SENS, extra_args, &datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SENS, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve sensitivity %s in sensitivityorder\n", (char *)curr->data);
 			goto exit;
@@ -1710,11 +1684,11 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cats, void *extra_args)
+static int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cats, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_expr(CIL_CATSET, cats->str_expr, &cats->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_CATSET, cats->str_expr, &cats->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1726,25 +1700,25 @@ exit:
 }
 
 
-int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, void *extra_args)
+int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, struct cil_db *db)
 {
-	return cil_resolve_cats(current, catset->cats, extra_args);
+	return cil_resolve_cats(current, catset->cats, db);
 }
 
-int cil_resolve_senscat(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_senscat(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_senscat *senscat = current->data;
 	struct cil_symtab_datum *sens_datum;
 	struct cil_sens *sens = NULL;
 
-	rc = cil_resolve_name(current, (char*)senscat->sens_str, CIL_SYM_SENS, extra_args, &sens_datum);
+	rc = cil_resolve_name(current, (char*)senscat->sens_str, CIL_SYM_SENS, db, &sens_datum);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to find sensitivity\n");
 		goto exit;
 	}
 
-	rc = cil_resolve_cats(current, senscat->cats, extra_args);
+	rc = cil_resolve_cats(current, senscat->cats, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1763,7 +1737,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, void *extra_args)
+int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, struct cil_db *db)
 {
 	struct cil_symtab_datum *sens_datum = NULL;
 	int rc = SEPOL_ERR;
@@ -1772,7 +1746,7 @@ int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, vo
 		return SEPOL_OK;
 	}
 
-	rc = cil_resolve_name(current, (char*)level->sens_str, CIL_SYM_SENS, extra_args, &sens_datum);
+	rc = cil_resolve_name(current, (char*)level->sens_str, CIL_SYM_SENS, db, &sens_datum);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Failed to find sensitivity\n");
 		goto exit;
@@ -1781,7 +1755,7 @@ int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, vo
 	level->sens = (struct cil_sens *)sens_datum;
 
 	if (level->cats != NULL) {
-		rc = cil_resolve_cats(current, level->cats, extra_args);
+		rc = cil_resolve_cats(current, level->cats, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1793,14 +1767,14 @@ exit:
 	return rc;
 }
 
-int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange *lvlrange, void *extra_args)
+int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange *lvlrange, struct cil_db *db)
 {
 	struct cil_symtab_datum *low_datum = NULL;
 	struct cil_symtab_datum *high_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (lvlrange->low_str != NULL) {
-		rc = cil_resolve_name(current, lvlrange->low_str, CIL_SYM_LEVELS, extra_args, &low_datum);
+		rc = cil_resolve_name(current, lvlrange->low_str, CIL_SYM_LEVELS, db, &low_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1808,20 +1782,20 @@ int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange
 
 		/* This could still be an anonymous level even if low_str is set, if low_str is a param_str */
 		if (lvlrange->low->datum.name == NULL) {
-			rc = cil_resolve_level(current, lvlrange->low, extra_args);
+			rc = cil_resolve_level(current, lvlrange->low, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (lvlrange->low != NULL) {
-		rc = cil_resolve_level(current, lvlrange->low, extra_args);
+		rc = cil_resolve_level(current, lvlrange->low, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	}
 
 	if (lvlrange->high_str != NULL) {
-		rc = cil_resolve_name(current, lvlrange->high_str, CIL_SYM_LEVELS, extra_args, &high_datum);
+		rc = cil_resolve_name(current, lvlrange->high_str, CIL_SYM_LEVELS, db, &high_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1829,13 +1803,13 @@ int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange
 
 		/* This could still be an anonymous level even if high_str is set, if high_str is a param_str */
 		if (lvlrange->high->datum.name == NULL) {
-			rc = cil_resolve_level(current, lvlrange->high, extra_args);
+			rc = cil_resolve_level(current, lvlrange->high, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (lvlrange->high != NULL) {
-		rc = cil_resolve_level(current, lvlrange->high, extra_args);
+		rc = cil_resolve_level(current, lvlrange->high, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1847,17 +1821,17 @@ exit:
 	return rc;
 }
 
-int cil_resolve_constrain(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_constrain(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_constrain *cons = current->data;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_classperms_list(current, cons->classperms, extra_args);
+	rc = cil_resolve_classperms_list(current, cons->classperms, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-	rc = cil_resolve_expr(CIL_CONSTRAIN, cons->str_expr, &cons->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_CONSTRAIN, cons->str_expr, &cons->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1868,20 +1842,19 @@ exit:
 	return rc;
 }
 
-int cil_resolve_validatetrans(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_validatetrans(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_validatetrans *validtrans = current->data;
-	struct cil_args_resolve *args = extra_args;
 	struct cil_symtab_datum *class_datum = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, validtrans->class_str, CIL_SYM_CLASSES, args, &class_datum);
+	rc = cil_resolve_name(current, validtrans->class_str, CIL_SYM_CLASSES, db, &class_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	validtrans->class = (struct cil_class*)class_datum;
 
-	rc = cil_resolve_expr(CIL_VALIDATETRANS, validtrans->str_expr, &validtrans->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_VALIDATETRANS, validtrans->str_expr, &validtrans->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1892,7 +1865,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, void *extra_args)
+int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, struct cil_db *db)
 {
 	struct cil_symtab_datum *user_datum = NULL;
 	struct cil_symtab_datum *role_datum = NULL;
@@ -1902,7 +1875,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, context->user_str, CIL_SYM_USERS, extra_args, &user_datum);
+	rc = cil_resolve_name(current, context->user_str, CIL_SYM_USERS, db, &user_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1917,7 +1890,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 
 	context->user = (struct cil_user*)user_datum;
 
-	rc = cil_resolve_name(current, context->role_str, CIL_SYM_ROLES, extra_args, &role_datum);
+	rc = cil_resolve_name(current, context->role_str, CIL_SYM_ROLES, db, &role_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1931,7 +1904,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 
 	context->role = (struct cil_role*)role_datum;
 
-	rc = cil_resolve_name(current, context->type_str, CIL_SYM_TYPES, extra_args, &type_datum);
+	rc = cil_resolve_name(current, context->type_str, CIL_SYM_TYPES, db, &type_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -1946,7 +1919,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 	context->type = type_datum;
 
 	if (context->range_str != NULL) {
-		rc = cil_resolve_name(current, context->range_str, CIL_SYM_LEVELRANGES, extra_args, &lvlrange_datum);
+		rc = cil_resolve_name(current, context->range_str, CIL_SYM_LEVELRANGES, db, &lvlrange_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1954,13 +1927,13 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 
 		/* This could still be an anonymous levelrange even if levelrange_str is set, if levelrange_str is a param_str*/
 		if (context->range->datum.name == NULL) {
-			rc = cil_resolve_levelrange(current, context->range, extra_args);
+			rc = cil_resolve_levelrange(current, context->range, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else if (context->range != NULL) {
-		rc = cil_resolve_levelrange(current, context->range, extra_args);
+		rc = cil_resolve_levelrange(current, context->range, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -1972,20 +1945,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_filecon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_filecon *filecon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (filecon->context_str != NULL) {
-		rc = cil_resolve_name(current, filecon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, filecon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			return rc;
 		}
 		filecon->context = (struct cil_context*)context_datum;
 	} else if (filecon->context != NULL) {
-		rc = cil_resolve_context(current, filecon->context, extra_args);
+		rc = cil_resolve_context(current, filecon->context, db);
 		if (rc != SEPOL_OK) {
 			return rc;
 		}
@@ -1994,20 +1967,20 @@ int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args)
 	return SEPOL_OK;
 }
 
-int cil_resolve_ibpkeycon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_ibpkeycon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_ibpkeycon *ibpkeycon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (ibpkeycon->context_str) {
-		rc = cil_resolve_name(current, ibpkeycon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, ibpkeycon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK)
 			goto exit;
 
 		ibpkeycon->context = (struct cil_context *)context_datum;
 	} else {
-		rc = cil_resolve_context(current, ibpkeycon->context, extra_args);
+		rc = cil_resolve_context(current, ibpkeycon->context, db);
 		if (rc != SEPOL_OK)
 			goto exit;
 	}
@@ -2018,20 +1991,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_portcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_portcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_portcon *portcon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (portcon->context_str != NULL) {
-		rc = cil_resolve_name(current, portcon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, portcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		portcon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, portcon->context, extra_args);
+		rc = cil_resolve_context(current, portcon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2043,20 +2016,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_genfscon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_genfscon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_genfscon *genfscon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (genfscon->context_str != NULL) {
-		rc = cil_resolve_name(current, genfscon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, genfscon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		genfscon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, genfscon->context, extra_args);
+		rc = cil_resolve_context(current, genfscon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2068,7 +2041,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_nodecon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_nodecon *nodecon = current->data;
 	struct cil_symtab_datum *addr_datum = NULL;
@@ -2077,7 +2050,7 @@ int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args)
 	int rc = SEPOL_ERR;
 
 	if (nodecon->addr_str != NULL) {
-		rc = cil_resolve_name(current, nodecon->addr_str, CIL_SYM_IPADDRS, extra_args, &addr_datum);
+		rc = cil_resolve_name(current, nodecon->addr_str, CIL_SYM_IPADDRS, db, &addr_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2085,7 +2058,7 @@ int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args)
 	}
 
 	if (nodecon->mask_str != NULL) {
-		rc = cil_resolve_name(current, nodecon->mask_str, CIL_SYM_IPADDRS, extra_args, &mask_datum);
+		rc = cil_resolve_name(current, nodecon->mask_str, CIL_SYM_IPADDRS, db, &mask_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2093,13 +2066,13 @@ int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args)
 	}
 
 	if (nodecon->context_str != NULL) {
-		rc = cil_resolve_name(current, nodecon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, nodecon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		nodecon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, nodecon->context, extra_args);
+		rc = cil_resolve_context(current, nodecon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2118,7 +2091,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_netifcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_netifcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_netifcon *netifcon = current->data;
 	struct cil_symtab_datum *ifcon_datum = NULL;
@@ -2127,26 +2100,26 @@ int cil_resolve_netifcon(struct cil_tree_node *current, void *extra_args)
 	int rc = SEPOL_ERR;
 
 	if (netifcon->if_context_str != NULL) {
-		rc = cil_resolve_name(current, netifcon->if_context_str, CIL_SYM_CONTEXTS, extra_args, &ifcon_datum);
+		rc = cil_resolve_name(current, netifcon->if_context_str, CIL_SYM_CONTEXTS, db, &ifcon_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		netifcon->if_context = (struct cil_context*)ifcon_datum;
 	} else {
-		rc = cil_resolve_context(current, netifcon->if_context, extra_args);
+		rc = cil_resolve_context(current, netifcon->if_context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	}
 
 	if (netifcon->packet_context_str != NULL) {
-		rc = cil_resolve_name(current, netifcon->packet_context_str, CIL_SYM_CONTEXTS, extra_args, &packcon_datum);
+		rc = cil_resolve_name(current, netifcon->packet_context_str, CIL_SYM_CONTEXTS, db, &packcon_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		netifcon->packet_context = (struct cil_context*)packcon_datum;
 	} else {
-		rc = cil_resolve_context(current, netifcon->packet_context, extra_args);
+		rc = cil_resolve_context(current, netifcon->packet_context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2157,7 +2130,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_ibendportcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_ibendportcon *ibendportcon = current->data;
 	struct cil_symtab_datum *con_datum = NULL;
@@ -2165,13 +2138,13 @@ int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args)
 	int rc = SEPOL_ERR;
 
 	if (ibendportcon->context_str) {
-		rc = cil_resolve_name(current, ibendportcon->context_str, CIL_SYM_CONTEXTS, extra_args, &con_datum);
+		rc = cil_resolve_name(current, ibendportcon->context_str, CIL_SYM_CONTEXTS, db, &con_datum);
 		if (rc != SEPOL_OK)
 			goto exit;
 
 		ibendportcon->context = (struct cil_context *)con_datum;
 	} else {
-		rc = cil_resolve_context(current, ibendportcon->context, extra_args);
+		rc = cil_resolve_context(current, ibendportcon->context, db);
 		if (rc != SEPOL_OK)
 			goto exit;
 	}
@@ -2182,20 +2155,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_pirqcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_pirqcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_pirqcon *pirqcon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (pirqcon->context_str != NULL) {
-		rc = cil_resolve_name(current, pirqcon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, pirqcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		pirqcon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, pirqcon->context, extra_args);
+		rc = cil_resolve_context(current, pirqcon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2207,20 +2180,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_iomemcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_iomemcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_iomemcon *iomemcon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (iomemcon->context_str != NULL) {
-		rc = cil_resolve_name(current, iomemcon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, iomemcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		iomemcon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, iomemcon->context, extra_args);
+		rc = cil_resolve_context(current, iomemcon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2232,20 +2205,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_ioportcon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_ioportcon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_ioportcon *ioportcon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (ioportcon->context_str != NULL) {
-		rc = cil_resolve_name(current, ioportcon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, ioportcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		ioportcon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, ioportcon->context, extra_args);
+		rc = cil_resolve_context(current, ioportcon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2257,20 +2230,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_pcidevicecon(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_pcidevicecon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_pcidevicecon *pcidevicecon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (pcidevicecon->context_str != NULL) {
-		rc = cil_resolve_name(current, pcidevicecon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, pcidevicecon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		pcidevicecon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, pcidevicecon->context, extra_args);
+		rc = cil_resolve_context(current, pcidevicecon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2282,20 +2255,20 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_devicetreecon(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_devicetreecon(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_devicetreecon *devicetreecon = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (devicetreecon->context_str != NULL) {
-		rc = cil_resolve_name(current, devicetreecon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, devicetreecon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		devicetreecon->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, devicetreecon->context, extra_args);
+		rc = cil_resolve_context(current, devicetreecon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2307,20 +2280,20 @@ exit:
 	return rc;
 }
 
-int cil_resolve_fsuse(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_fsuse(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_fsuse *fsuse = current->data;
 	struct cil_symtab_datum *context_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (fsuse->context_str != NULL) {
-		rc = cil_resolve_name(current, fsuse->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, fsuse->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		fsuse->context = (struct cil_context*)context_datum;
 	} else {
-		rc = cil_resolve_context(current, fsuse->context, extra_args);
+		rc = cil_resolve_context(current, fsuse->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2332,7 +2305,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_sidcontext(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_sidcontext(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_sidcontext *sidcon = current->data;
 	struct cil_symtab_datum *sid_datum = NULL;
@@ -2341,20 +2314,20 @@ int cil_resolve_sidcontext(struct cil_tree_node *current, void *extra_args)
 
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, sidcon->sid_str, CIL_SYM_SIDS, extra_args, &sid_datum);
+	rc = cil_resolve_name(current, sidcon->sid_str, CIL_SYM_SIDS, db, &sid_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	sid = (struct cil_sid*)sid_datum;
 
 	if (sidcon->context_str != NULL) {
-		rc = cil_resolve_name(current, sidcon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		rc = cil_resolve_name(current, sidcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		sidcon->context = (struct cil_context*)context_datum;
 	} else if (sidcon->context != NULL) {
-		rc = cil_resolve_context(current, sidcon->context, extra_args);
+		rc = cil_resolve_context(current, sidcon->context, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2374,14 +2347,14 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockinherit_link(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_blockinherit *inherit = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
 	struct cil_tree_node *node = NULL;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, inherit->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
+	rc = cil_resolve_name(current, inherit->block_str, CIL_SYM_BLOCKS, db, &block_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2407,11 +2380,9 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockinherit_copy(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_block *block = current->data;
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
 	struct cil_list_item *item = NULL;
 	int rc = SEPOL_ERR;
 
@@ -2421,8 +2392,6 @@ static int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *ex
 		goto exit;
 	}
 
-	db = args->db;
-
 	// Make sure this is the original block and not a merged block from a blockinherit
 	if (current != block->datum.nodes->head->data) {
 		rc = SEPOL_OK;
@@ -2456,15 +2425,14 @@ static void cil_mark_subtree_abstract(struct cil_tree_node *node)
 	}
 }
 
-static int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_blockabstract(struct cil_tree_node *current, struct cil_db *db, struct cil_list *abstract_blocks)
 {
 	struct cil_blockabstract *abstract = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
 	struct cil_tree_node *block_node = NULL;
-	struct cil_args_resolve *args = extra_args;
 	int rc = SEPOL_ERR;
 
-	rc = cil_resolve_name(current, abstract->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
+	rc = cil_resolve_name(current, abstract->block_str, CIL_SYM_BLOCKS, db, &block_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2476,7 +2444,7 @@ static int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_
 		goto exit;
 	}
 
-	cil_list_append(args->abstract_blocks, CIL_NODE, block_node);
+	cil_list_append(abstract_blocks, CIL_NODE, block_node);
 
 	return SEPOL_OK;
 
@@ -2484,20 +2452,14 @@ exit:
 	return rc;
 }
 
-int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_in(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_in *in = current->data;
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
 	struct cil_symtab_datum *block_datum = NULL;
 	struct cil_tree_node *block_node = NULL;
 	int rc = SEPOL_ERR;
 
-	if (args != NULL) {
-		db = args->db;
-	}
-
-	rc = cil_resolve_name(current, in->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
+	rc = cil_resolve_name(current, in->block_str, CIL_SYM_BLOCKS, db, &block_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2527,7 +2489,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
+static int cil_resolve_in_list(struct cil_list *in_list, struct cil_db *db)
 {
 	struct cil_list_item *curr = NULL;
 	struct cil_tree_node *node = NULL;
@@ -2550,12 +2512,12 @@ static int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
 			node = curr->data;
 			in = node->data;
 
-			rc = cil_resolve_name(node, in->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
+			rc = cil_resolve_name(node, in->block_str, CIL_SYM_BLOCKS, db, &block_datum);
 			if (rc != SEPOL_OK) {
 				unresolved++;
 				last_failed_node = node;
 			} else {
-				rc = cil_resolve_in(node, extra_args);
+				rc = cil_resolve_in(node, db);
 				if (rc != SEPOL_OK) {
 					goto exit;
 				}
@@ -2581,7 +2543,7 @@ exit:
 }
 
 
-static int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor attr_flavor)
+static int cil_resolve_bounds(struct cil_tree_node *current, struct cil_db *db, enum cil_flavor flavor, enum cil_flavor attr_flavor)
 {
 	int rc = SEPOL_ERR;
 	struct cil_bounds *bounds = current->data;
@@ -2594,7 +2556,7 @@ static int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, e
 		goto exit;
 	}
 
-	rc = cil_resolve_name(current, bounds->parent_str, index, extra_args, &parent_datum);
+	rc = cil_resolve_name(current, bounds->parent_str, index, db, &parent_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2605,7 +2567,7 @@ static int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, e
 	}
 
 
-	rc = cil_resolve_name(current, bounds->child_str, index, extra_args, &child_datum);
+	rc = cil_resolve_name(current, bounds->child_str, index, db, &child_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2663,7 +2625,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_default(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_default *def = current->data;
@@ -2673,7 +2635,7 @@ static int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
 	cil_list_init(&def->class_datums, def->flavor);
 
 	cil_list_for_each(curr, def->class_strs) {
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, db, &datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2686,7 +2648,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_defaultrange(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_defaultrange *def = current->data;
@@ -2696,7 +2658,7 @@ static int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_a
 	cil_list_init(&def->class_datums, CIL_DEFAULTRANGE);
 
 	cil_list_for_each(curr, def->class_strs) {
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, db, &datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2781,9 +2743,8 @@ exit:
 	return rc;
 }
 
-static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call *call, struct cil_macro *macro, void *extra_args)
+static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call *call, struct cil_macro *macro, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
 	struct cil_list_item *item;
 	struct cil_args *arg = NULL;
 	struct cil_tree_node *arg_node = NULL;
@@ -2830,7 +2791,7 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-			name = __cil_insert_name(args->db, arg_node->data, call_node);
+			name = __cil_insert_name(db, arg_node->data, call_node);
 			if (name != NULL) {
 				arg->arg = (struct cil_symtab_datum *)name;
 			} else {
@@ -3080,10 +3041,9 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_call(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_call *call = current->data;
-	struct cil_args_resolve *args = extra_args;
 	struct cil_tree_node *macro_node = NULL;
 	struct cil_symtab_datum *macro_datum = NULL;
 	int rc = SEPOL_ERR;
@@ -3092,7 +3052,7 @@ static int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
 		return SEPOL_OK;
 	}
 
-	rc = cil_resolve_name(current, call->macro_str, CIL_SYM_BLOCKS, extra_args, &macro_datum);
+	rc = cil_resolve_name(current, call->macro_str, CIL_SYM_BLOCKS, db, &macro_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3106,7 +3066,7 @@ static int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
 	}
 	call->macro = (struct cil_macro*)macro_datum;
 
-	rc = cil_build_call_args(current, call, call->macro, extra_args);
+	rc = cil_build_call_args(current, call, call->macro, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3116,7 +3076,7 @@ static int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	rc = cil_copy_ast(args->db, macro_node, current);
+	rc = cil_copy_ast(db, macro_node, current);
 	if (rc != SEPOL_OK) {
 		cil_tree_log(current, CIL_ERR, "Failed to copy macro %s to call", macro_datum->name);
 		goto exit;
@@ -3130,7 +3090,7 @@ exit:
 	return rc;
 }
 
-static int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args)
+static int cil_resolve_call_args(struct cil_tree_node *current, struct cil_db *db)
 {
 	struct cil_call *call = current->data;
 	int rc = SEPOL_ERR;
@@ -3227,7 +3187,7 @@ static int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args
 		if (sym_index != CIL_SYM_UNKNOWN) {
 			struct cil_symtab_datum *datum;
 			struct cil_tree_node *n;
-			rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &datum);
+			rc = cil_resolve_name(current, arg->arg_str, sym_index, db, &datum);
 			if (rc != SEPOL_OK) {
 				cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
 				goto exit;
@@ -3242,7 +3202,7 @@ static int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args
 					 * the call.
 					 */
 					cil_symtab_remove_datum(datum);
-					rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &(arg->arg));
+					rc = cil_resolve_name(current, arg->arg_str, sym_index, db, &(arg->arg));
 					if (rc != SEPOL_OK) {
 						cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
 						goto exit;
@@ -3297,7 +3257,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struct cil_list **datum_expr, struct cil_tree_node *parent, void *extra_args)
+int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struct cil_list **datum_expr, struct cil_tree_node *parent, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
@@ -3334,7 +3294,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 	cil_list_for_each(curr, str_expr) {
 		switch (curr->flavor) {
 		case CIL_STRING:
-			rc = cil_resolve_name(parent, curr->data, sym_index, extra_args, &res_datum);
+			rc = cil_resolve_name(parent, curr->data, sym_index, db, &res_datum);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -3348,7 +3308,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 				if (!res_datum->name) {
 					/* Anonymous category sets need to be resolved when encountered */
 					if (!catset->cats->datum_expr) {
-						rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
+						rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, db);
 						if (rc != SEPOL_OK) {
 							goto exit;
 						}
@@ -3366,7 +3326,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			}
 			break;
 		case CIL_LIST: {
-			rc = cil_resolve_expr(expr_type, curr->data, &datum_sub_expr, parent, extra_args);
+			rc = cil_resolve_expr(expr_type, curr->data, &datum_sub_expr, parent, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -3388,12 +3348,12 @@ exit:
 	return rc;
 }
 
-int cil_resolve_boolif(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_boolif(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_booleanif *bif = (struct cil_booleanif*)current->data;
 
-	rc = cil_resolve_expr(CIL_BOOLEANIF, bif->str_expr, &bif->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_BOOLEANIF, bif->str_expr, &bif->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3453,10 +3413,8 @@ static int __cil_evaluate_tunable_expr(struct cil_list_item *curr)
 	}
 }
 
-int cil_resolve_tunif(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_tunif(struct cil_tree_node *current, struct cil_db *db)
 {
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
 	int rc = SEPOL_ERR;
 	struct cil_tunableif *tif = (struct cil_tunableif*)current->data;
 	uint16_t result = CIL_FALSE;
@@ -3464,11 +3422,7 @@ int cil_resolve_tunif(struct cil_tree_node *current, void *extra_args)
 	struct cil_tree_node *false_node = NULL;
 	struct cil_condblock *cb = NULL;
 
-	if (args != NULL) {
-		db = args->db;
-	}
-
-	rc = cil_resolve_expr(CIL_TUNABLEIF, tif->str_expr, &tif->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_TUNABLEIF, tif->str_expr, &tif->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3519,7 +3473,7 @@ exit:
 	return rc;
 }
 
-int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args)
+int cil_resolve_userattributeset(struct cil_tree_node *current, struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
 	struct cil_userattributeset *attrusers = current->data;
@@ -3527,7 +3481,7 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
 	struct cil_tree_node *attr_node = NULL;
 	struct cil_userattribute *attr = NULL;
 
-	rc = cil_resolve_name(current, attrusers->attr_str, CIL_SYM_USERS, extra_args, &attr_datum);
+	rc = cil_resolve_name(current, attrusers->attr_str, CIL_SYM_USERS, db, &attr_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3540,7 +3494,7 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
 	}
 	attr = (struct cil_userattribute*)attr_datum;
 
-	rc = cil_resolve_expr(CIL_USERATTRIBUTESET, attrusers->str_expr, &attrusers->datum_expr, current, extra_args);
+	rc = cil_resolve_expr(CIL_USERATTRIBUTESET, attrusers->str_expr, &attrusers->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(struct cil_tree_node *node)
 	return rc;
 }
 
-static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
+static int __cil_resolve_ast_node(struct cil_tree_node *node, struct cil_args_resolve *args)
 {
 	int rc = SEPOL_OK;
-	struct cil_args_resolve *args = extra_args;
+	struct cil_db *db = args->db;
 	enum cil_pass pass = 0;
 
-	if (node == NULL || args == NULL) {
-		goto exit;
-	}
-
 	pass = args->pass;
 	switch (pass) {
 	case CIL_PASS_TIF:
 		if (node->flavor == CIL_TUNABLEIF) {
-			rc = cil_resolve_tunif(node, args);
+			rc = cil_resolve_tunif(node, db);
 		}
 		break;
 	case CIL_PASS_IN_BEFORE:
@@ -3690,17 +3640,17 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		break;
 	case CIL_PASS_BLKIN_LINK:
 		if (node->flavor == CIL_BLOCKINHERIT) {
-			rc = cil_resolve_blockinherit_link(node, args);
+			rc = cil_resolve_blockinherit_link(node, db);
 		}
 		break;
 	case CIL_PASS_BLKIN_COPY:
 		if (node->flavor == CIL_BLOCK) {
-			rc = cil_resolve_blockinherit_copy(node, args);
+			rc = cil_resolve_blockinherit_copy(node, db);
 		}
 		break;
 	case CIL_PASS_BLKABS:
 		if (node->flavor == CIL_BLOCKABSTRACT) {
-			rc = cil_resolve_blockabstract(node, args);
+			rc = cil_resolve_blockabstract(node, db, args->abstract_blocks);
 		}
 		break;
 	case CIL_PASS_IN_AFTER:
@@ -3715,24 +3665,24 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		break;
 	case CIL_PASS_CALL1:
 		if (node->flavor == CIL_CALL && args->macro == NULL) {
-			rc = cil_resolve_call(node, args);
+			rc = cil_resolve_call(node, db);
 		}
 		break;
 	case CIL_PASS_CALL2:
 		if (node->flavor == CIL_CALL && args->macro == NULL) {
-			rc = cil_resolve_call_args(node, args);
+			rc = cil_resolve_call_args(node, db);
 		}
 		break;
 	case CIL_PASS_ALIAS1:
 		switch (node->flavor) {
 		case CIL_TYPEALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_TYPE, CIL_TYPEALIAS);
+			rc = cil_resolve_aliasactual(node, db, CIL_TYPE, CIL_TYPEALIAS);
 			break;
 		case CIL_SENSALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_SENS, CIL_SENSALIAS);
+			rc = cil_resolve_aliasactual(node, db, CIL_SENS, CIL_SENSALIAS);
 			break;
 		case CIL_CATALIASACTUAL:
-			rc = cil_resolve_aliasactual(node, args, CIL_CAT, CIL_CATALIAS);
+			rc = cil_resolve_aliasactual(node, db, CIL_CAT, CIL_CATALIAS);
 			break;
 		default: 
 			break;
@@ -3756,19 +3706,19 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	case CIL_PASS_MISC1:
 		switch (node->flavor) {
 		case CIL_SIDORDER:
-			rc = cil_resolve_sidorder(node, args);
+			rc = cil_resolve_sidorder(node, db, args->sidorder_lists);
 			break;
 		case CIL_CLASSORDER:
-			rc = cil_resolve_classorder(node, args);
+			rc = cil_resolve_classorder(node, db, args->classorder_lists, args->unordered_classorder_lists);
 			break;
 		case CIL_CATORDER:
-			rc = cil_resolve_catorder(node, args);
+			rc = cil_resolve_catorder(node, db, args->catorder_lists);
 			break;
 		case CIL_SENSITIVITYORDER:
-			rc = cil_resolve_sensitivityorder(node, args);
+			rc = cil_resolve_sensitivityorder(node, db, args->sensitivityorder_lists);
 			break;
 		case CIL_BOOLEANIF:
-			rc = cil_resolve_boolif(node, args);
+			rc = cil_resolve_boolif(node, db);
 			break;
 		default:
 			break;
@@ -3777,7 +3727,7 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	case CIL_PASS_MLS:
 		switch (node->flavor) {
 		case CIL_CATSET:
-			rc = cil_resolve_catset(node, (struct cil_catset*)node->data, args);
+			rc = cil_resolve_catset(node, (struct cil_catset*)node->data, db);
 			break;
 		default:
 			break;
@@ -3786,10 +3736,10 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	case CIL_PASS_MISC2:
 		switch (node->flavor) {
 		case CIL_SENSCAT:
-			rc = cil_resolve_senscat(node, args);
+			rc = cil_resolve_senscat(node, db);
 			break;
 		case CIL_CLASSCOMMON:
-			rc = cil_resolve_classcommon(node, args);
+			rc = cil_resolve_classcommon(node, db);
 			break;
 		default:
 			break;
@@ -3798,147 +3748,147 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	case CIL_PASS_MISC3:
 		switch (node->flavor) {
 		case CIL_TYPEATTRIBUTESET:
-			rc = cil_resolve_typeattributeset(node, args);
+			rc = cil_resolve_typeattributeset(node, db);
 			break;
 		case CIL_EXPANDTYPEATTRIBUTE:
-			rc = cil_resolve_expandtypeattribute(node, args);
+			rc = cil_resolve_expandtypeattribute(node, db);
 			break;
 		case CIL_TYPEBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_TYPE, CIL_TYPEATTRIBUTE);
+			rc = cil_resolve_bounds(node, db, CIL_TYPE, CIL_TYPEATTRIBUTE);
 			break;
 		case CIL_TYPEPERMISSIVE:
-			rc = cil_resolve_typepermissive(node, args);
+			rc = cil_resolve_typepermissive(node, db);
 			break;
 		case CIL_NAMETYPETRANSITION:
-			rc = cil_resolve_nametypetransition(node, args);
+			rc = cil_resolve_nametypetransition(node, db);
 			break;
 		case CIL_RANGETRANSITION:
-			rc = cil_resolve_rangetransition(node, args);
+			rc = cil_resolve_rangetransition(node, db);
 			break;
 		case CIL_CLASSPERMISSIONSET:
-			rc = cil_resolve_classpermissionset(node, (struct cil_classpermissionset*)node->data, args);
+			rc = cil_resolve_classpermissionset(node, (struct cil_classpermissionset*)node->data, db);
 			break;
 		case CIL_CLASSMAPPING:
-			rc = cil_resolve_classmapping(node, args);
+			rc = cil_resolve_classmapping(node, db);
 			break;
 		case CIL_AVRULE:
 		case CIL_AVRULEX:
-			rc = cil_resolve_avrule(node, args);
+			rc = cil_resolve_avrule(node, db);
 			break;
 		case CIL_PERMISSIONX:
-			rc = cil_resolve_permissionx(node, (struct cil_permissionx*)node->data, args);
+			rc = cil_resolve_permissionx(node, (struct cil_permissionx*)node->data, db);
 			break;
 		case CIL_DENY_RULE:
-			rc = cil_resolve_deny_rule(node, args);
+			rc = cil_resolve_deny_rule(node, db);
 			break;
 		case CIL_TYPE_RULE:
-			rc = cil_resolve_type_rule(node, args);
+			rc = cil_resolve_type_rule(node, db);
 			break;
 		case CIL_USERROLE:
-			rc = cil_resolve_userrole(node, args);
+			rc = cil_resolve_userrole(node, db);
 			break;
 		case CIL_USERLEVEL:
-			rc = cil_resolve_userlevel(node, args);
+			rc = cil_resolve_userlevel(node, db);
 			break;
 		case CIL_USERRANGE:
-			rc = cil_resolve_userrange(node, args);
+			rc = cil_resolve_userrange(node, db);
 			break;
 		case CIL_USERBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_USER, CIL_USERATTRIBUTE);
+			rc = cil_resolve_bounds(node, db, CIL_USER, CIL_USERATTRIBUTE);
 			break;
 		case CIL_USERPREFIX:
-			rc = cil_resolve_userprefix(node, args);
+			rc = cil_resolve_userprefix(node, db);
 			break;
 		case CIL_SELINUXUSER:
 		case CIL_SELINUXUSERDEFAULT:
-			rc = cil_resolve_selinuxuser(node, args);
+			rc = cil_resolve_selinuxuser(node, db);
 			break;
 		case CIL_ROLEATTRIBUTESET:
-			rc = cil_resolve_roleattributeset(node, args);
+			rc = cil_resolve_roleattributeset(node, db);
 			break;
 		case CIL_ROLETYPE:
-			rc = cil_resolve_roletype(node, args);
+			rc = cil_resolve_roletype(node, db);
 			break;
 		case CIL_ROLETRANSITION:
-			rc = cil_resolve_roletransition(node, args);
+			rc = cil_resolve_roletransition(node, db);
 			break;
 		case CIL_ROLEALLOW:
-			rc = cil_resolve_roleallow(node, args);
+			rc = cil_resolve_roleallow(node, db);
 			break;
 		case CIL_ROLEBOUNDS:
-			rc = cil_resolve_bounds(node, args, CIL_ROLE, CIL_ROLEATTRIBUTE);
+			rc = cil_resolve_bounds(node, db, CIL_ROLE, CIL_ROLEATTRIBUTE);
 			break;
 		case CIL_LEVEL:
-			rc = cil_resolve_level(node, (struct cil_level*)node->data, args);
+			rc = cil_resolve_level(node, (struct cil_level*)node->data, db);
 			break;
 		case CIL_LEVELRANGE:
-			rc = cil_resolve_levelrange(node, (struct cil_levelrange*)node->data, args);
+			rc = cil_resolve_levelrange(node, (struct cil_levelrange*)node->data, db);
 			break;
 		case CIL_CONSTRAIN:
-			rc = cil_resolve_constrain(node, args);
+			rc = cil_resolve_constrain(node, db);
 			break;
 		case CIL_MLSCONSTRAIN:
-			rc = cil_resolve_constrain(node, args);
+			rc = cil_resolve_constrain(node, db);
 			break;
 		case CIL_VALIDATETRANS:
 		case CIL_MLSVALIDATETRANS:
-			rc = cil_resolve_validatetrans(node, args);
+			rc = cil_resolve_validatetrans(node, db);
 			break;
 		case CIL_CONTEXT:
-			rc = cil_resolve_context(node, (struct cil_context*)node->data, args);
+			rc = cil_resolve_context(node, (struct cil_context*)node->data, db);
 			break;
 		case CIL_FILECON:
-			rc = cil_resolve_filecon(node, args);
+			rc = cil_resolve_filecon(node, db);
 			break;
 		case CIL_IBPKEYCON:
-			rc = cil_resolve_ibpkeycon(node, args);
+			rc = cil_resolve_ibpkeycon(node, db);
 			break;
 		case CIL_PORTCON:
-			rc = cil_resolve_portcon(node, args);
+			rc = cil_resolve_portcon(node, db);
 			break;
 		case CIL_NODECON:
-			rc = cil_resolve_nodecon(node, args);
+			rc = cil_resolve_nodecon(node, db);
 			break;
 		case CIL_GENFSCON:
-			rc = cil_resolve_genfscon(node, args);
+			rc = cil_resolve_genfscon(node, db);
 			break;
 		case CIL_NETIFCON:
-			rc = cil_resolve_netifcon(node, args);
+			rc = cil_resolve_netifcon(node, db);
 			break;
 		case CIL_IBENDPORTCON:
-			rc = cil_resolve_ibendportcon(node, args);
+			rc = cil_resolve_ibendportcon(node, db);
 			break;
 		case CIL_PIRQCON:
-			rc = cil_resolve_pirqcon(node, args);
+			rc = cil_resolve_pirqcon(node, db);
 			break;
 		case CIL_IOMEMCON:
-			rc = cil_resolve_iomemcon(node, args);
+			rc = cil_resolve_iomemcon(node, db);
 			break;
 		case CIL_IOPORTCON:
-			rc = cil_resolve_ioportcon(node, args);
+			rc = cil_resolve_ioportcon(node, db);
 			break;
 		case CIL_PCIDEVICECON:
-			rc = cil_resolve_pcidevicecon(node, args);
+			rc = cil_resolve_pcidevicecon(node, db);
 			break;
 		case CIL_DEVICETREECON:
-			rc = cil_resolve_devicetreecon(node, args);
+			rc = cil_resolve_devicetreecon(node, db);
 			break;
 		case CIL_FSUSE:
-			rc = cil_resolve_fsuse(node, args);
+			rc = cil_resolve_fsuse(node, db);
 			break;
 		case CIL_SIDCONTEXT:
-			rc = cil_resolve_sidcontext(node, args);
+			rc = cil_resolve_sidcontext(node, db);
 			break;
 		case CIL_DEFAULTUSER:
 		case CIL_DEFAULTROLE:
 		case CIL_DEFAULTTYPE:
-			rc = cil_resolve_default(node, args);
+			rc = cil_resolve_default(node, db);
 			break;
 		case CIL_DEFAULTRANGE:
-			rc = cil_resolve_defaultrange(node, args);
+			rc = cil_resolve_defaultrange(node, db);
 			break;
 		case CIL_USERATTRIBUTESET:
-			rc = cil_resolve_userattributeset(node, args);
+			rc = cil_resolve_userattributeset(node, db);
 			break;
 		default:
 			break;
@@ -3949,9 +3899,6 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	}
 
 	return rc;
-
-exit:
-	return rc;
 }
 
 static int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
@@ -4040,7 +3987,7 @@ static int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *f
 		goto exit;
 	}
 
-	rc = __cil_resolve_ast_node(node, extra_args);
+	rc = __cil_resolve_ast_node(node, args);
 	if (rc == SEPOL_ENOENT) {
 		if (optional == NULL) {
 			cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
@@ -4186,13 +4133,13 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 		}
 
 		if (pass == CIL_PASS_IN_BEFORE) {
-			rc = cil_resolve_in_list(extra_args.in_list_before, &extra_args);
+			rc = cil_resolve_in_list(extra_args.in_list_before, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 			cil_list_destroy(&extra_args.in_list_before, CIL_FALSE);
 		} else if (pass == CIL_PASS_IN_AFTER) {
-			rc = cil_resolve_in_list(extra_args.in_list_after, &extra_args);
+			rc = cil_resolve_in_list(extra_args.in_list_after, db);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -4413,12 +4360,12 @@ static int __cil_resolve_name_helper(struct cil_db *db, struct cil_tree_node *no
 	return rc;
 }
 
-int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum)
+int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, struct cil_db *db, struct cil_symtab_datum **datum)
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *node = NULL;
 
-	rc = cil_resolve_name_keep_aliases(ast_node, name, sym_index, extra_args, datum);
+	rc = cil_resolve_name_keep_aliases(ast_node, name, sym_index, db, datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -4441,11 +4388,9 @@ exit:
 	return rc;
 }
 
-int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum)
+int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, struct cil_db *db, struct cil_symtab_datum **datum)
 {
 	int rc = SEPOL_ERR;
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = args->db;
 	struct cil_tree_node *node = NULL;
 
 	if (name == NULL) {
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 78357993..2f6b7e86 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -35,71 +35,71 @@
 #include "cil_internal.h"
 #include "cil_tree.h"
 
-int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms *cp, void *extra_args);
-int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_classpermissionset *cps, void *extra_args);
-int cil_resolve_classperms_list(struct cil_tree_node *current, struct cil_list *cp_list, void *extra_args);
-int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_deny_rule(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_typealias(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_typebounds(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_typepermissive(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_rangetransition(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_classmapping(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userrole(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userbounds(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_roletype(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_roleallow(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_rolebounds(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_sensalias(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_catalias(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_cat_list(struct cil_tree_node *current, struct cil_list *cat_list, struct cil_list *res_cat_list, void *extra_args);
-int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, void *extra_args);
-int cil_resolve_senscat(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, void *extra_args); 
-int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange *levelrange, void *extra_args); 
-int cil_resolve_constrain(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_validatetrans(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, void *extra_args);
-int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_ibpkeycon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_portcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_genfscon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_netifcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_pirqcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_iomemcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_ioportcon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_pcidevicecon(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_fsuse(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_sidcontext(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_blockinherit(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_in(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_call1(struct cil_tree_node *current, void *extra_args);
-int cil_resolve_call2(struct cil_tree_node *, void *extra_args);
+int cil_resolve_classorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *classorder_list, struct cil_list *unordered_classorder_list);
+int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms *cp, struct cil_db *db);
+int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_classpermissionset *cps, struct cil_db *db);
+int cil_resolve_classperms_list(struct cil_tree_node *current, struct cil_list *cp_list, struct cil_db *db);
+int cil_resolve_avrule(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_deny_rule(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_type_rule(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typeattributeset(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typealias(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typebounds(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_typepermissive(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_rangetransition(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_classcommon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_classmapping(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userrole(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userlevel(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userrange(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userbounds(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userprefix(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_userattributeset(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_selinuxuser(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_roletype(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_roletransition(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_roleallow(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_roleattributeset(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_rolebounds(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_sensalias(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_catalias(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_catorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *catorder_list);
+int cil_resolve_sensitivityorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sensitivityorder_list);
+int cil_resolve_cat_list(struct cil_tree_node *current, struct cil_list *cat_list, struct cil_list *res_cat_list, struct cil_db *db);
+int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, struct cil_db *db);
+int cil_resolve_senscat(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_level(struct cil_tree_node *current, struct cil_level *level, struct cil_db *db);
+int cil_resolve_levelrange(struct cil_tree_node *current, struct cil_levelrange *levelrange, struct cil_db *db);
+int cil_resolve_constrain(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_validatetrans(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, struct cil_db *db);
+int cil_resolve_filecon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_ibpkeycon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_ibendportcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_portcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_genfscon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_nodecon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_netifcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_pirqcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_iomemcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_ioportcon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_pcidevicecon(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_fsuse(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_sidcontext(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_sidorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sidorder_list);
+int cil_resolve_blockinherit(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_in(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_call1(struct cil_tree_node *current, struct cil_db *db);
+int cil_resolve_call2(struct cil_tree_node *, struct cil_db *db);
 int cil_resolve_name_call_args(struct cil_call *call, char *name, enum cil_sym_index sym_index, struct cil_symtab_datum **datum);
-int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struct cil_list **datum_expr, struct cil_tree_node *parent, void *extra_args);
-int cil_resolve_boolif(struct cil_tree_node *current, void *extra_args);
+int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struct cil_list **datum_expr, struct cil_tree_node *parent, struct cil_db *db);
+int cil_resolve_boolif(struct cil_tree_node *current, struct cil_db *db);
 int cil_evaluate_expr(struct cil_list *datum_expr, uint16_t *result);
-int cil_resolve_tunif(struct cil_tree_node *current, void *extra_args);
+int cil_resolve_tunif(struct cil_tree_node *current, struct cil_db *db);
 
 int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current);
-int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum);
-int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum);
+int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, struct cil_db *db, struct cil_symtab_datum **datum);
+int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, struct cil_db *db, struct cil_symtab_datum **datum);
 
 #endif /* CIL_RESOLVE_AST_H_ */
-- 
2.41.0

