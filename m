Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B92CCA48D
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiGUPFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGUPFa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A713CF6
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id va17so3725395ejb.0
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yUyNwXeOZPUcZE3O3R/KJFa91mJuvG5xcxHODidsA7Y=;
        b=C94A7wOWO9b/h+gOkZ4DhltStYkgGNdfXPOHvsAPQyhwFbuQeK9J4flDcgN2ZOL7Yo
         qhqWyENsp3Ob4VSCnwtrwqSAcc9HVbZNqDCOsHFzK97oW2ok2hoYlUl7aQmCbQ6uj4zg
         OVbltil64MgPz7BYV4wHt+CcuneLlYUTHsVNbn5tD3QUlYyZfic1jni7+9zIO8Dh2dwg
         xfhi7kdzjs+7MCkUj7+OzDiZ3bw78sxNgqlA3hH3ZU2VakHtqN38dvo9XjbJD2hFW3+O
         I/97CdZJxlGwFxW1S0UfYqdpbtUJBMbv8O3+KvUQF0JHxFFRODN+lRHlHzTq3Z+NMl20
         6Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUyNwXeOZPUcZE3O3R/KJFa91mJuvG5xcxHODidsA7Y=;
        b=N1X7rWqtc3gW9wdMZVJbXK4oX7OfWuP3XY7GGlILjfbWKLmUJ15C9udmQx5lsap9R1
         Yzp7u6th3+BT63N15Ne/NivJC3c74D0zppK/vGFXXI3K6c9t9qdssMqfovNP9blvRyVt
         p9ORKV7qg1KDO6pY/YAFeVNnXDyPui0I9FVfBNaN0dLraF1b3tm7Q8OoOgmxvRYc11Vg
         fpnQ8u9d0cWQEaLRjJT49Bsv39F+9s/5xe7vZ8sLNG7+upK6y52/YOY/yEf/V/goJlnT
         vPR4zaAzSHodtLTl896i8HYtKugv7SAbqgCLUYhh1I0FEH1Gi10rNho0pIzKSTUZJYXP
         vUBQ==
X-Gm-Message-State: AJIora+Zd6t4OFhJnadXNlXIntKc1rBNDM7kuvBvdVrz9H5CCUXeXEFD
        WWQ1yH1UN/7q6yIKswj8mCezDr+Ei2pCIg==
X-Google-Smtp-Source: AGRyM1u00JzAxnbbDGLNwet/F7hr/dTXRWns+Vv3bRJQcVsYoduaA3AigUL28J6gKjjlIze+6BHe8g==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id fj4-20020a1709069c8400b006e07c756f01mr41603719ejc.103.1658415926219;
        Thu, 21 Jul 2022 08:05:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 6/8] libsepol/cil: add support for segregate attributes
Date:   Thu, 21 Jul 2022 17:05:13 +0200
Message-Id: <20220721150515.19843-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support the compile time constraint with the following syntax:

    (segregateattributes (attr1 attr2 [...]))

and reports like:

    ...
    Qualifying Names
    Compile post process
    Building policy binary
    Checking Neverallows
    Checking Segregate Attributes
    Segregate Attributes violation, type test_type associated with attributes attr1 attr2
    Checking User Bounds
    Checking Role Bounds
    Checking Type Bounds
    Failed to generate binary
    Failed to build policydb

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil.c             | 17 +++++++
 libsepol/cil/src/cil_binary.c      | 75 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c   | 58 +++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h   |  2 +
 libsepol/cil/src/cil_copy_ast.c    | 18 +++++++
 libsepol/cil/src/cil_flavor.h      |  1 +
 libsepol/cil/src/cil_internal.h    |  8 ++++
 libsepol/cil/src/cil_policy.c      | 26 +++++++++++
 libsepol/cil/src/cil_reset_ast.c   |  8 ++++
 libsepol/cil/src/cil_resolve_ast.c | 38 +++++++++++++++
 libsepol/cil/src/cil_resolve_ast.h |  1 +
 libsepol/cil/src/cil_write_ast.c   | 11 +++++
 libsepol/src/kernel_to_cil.c       | 32 +++++++++++++
 secilc/docs/README.md              |  1 +
 secilc/docs/cil_type_statements.md | 50 ++++++++++++++++++++
 15 files changed, 346 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 38edcf8e..cc6adb90 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -225,6 +225,7 @@ char *CIL_KEY_SRC_CIL;
 char *CIL_KEY_SRC_HLL_LMS;
 char *CIL_KEY_SRC_HLL_LMX;
 char *CIL_KEY_SRC_HLL_LME;
+char *CIL_KEY_SEGREGATEATTRIBUTES;
 
 static void cil_init_keys(void)
 {
@@ -394,6 +395,7 @@ static void cil_init_keys(void)
 	CIL_KEY_SRC_HLL_LMS = cil_strpool_add("lms");
 	CIL_KEY_SRC_HLL_LMX = cil_strpool_add("lmx");
 	CIL_KEY_SRC_HLL_LME = cil_strpool_add("lme");
+	CIL_KEY_SEGREGATEATTRIBUTES = cil_strpool_add("segregateattributes");
 }
 
 void cil_db_init(struct cil_db **db)
@@ -426,6 +428,7 @@ void cil_db_init(struct cil_db **db)
 	cil_list_init(&(*db)->userprefixes, CIL_LIST_ITEM);
 	cil_list_init(&(*db)->selinuxusers, CIL_LIST_ITEM);
 	cil_list_init(&(*db)->names, CIL_LIST_ITEM);
+	cil_list_init(&(*db)->segregateattributes, CIL_LIST_ITEM);
 
 	cil_type_init(&(*db)->selftype);
 	(*db)->selftype->datum.name = CIL_KEY_SELF;
@@ -481,6 +484,7 @@ void cil_db_destroy(struct cil_db **db)
 	cil_list_destroy(&(*db)->userprefixes, CIL_FALSE);
 	cil_list_destroy(&(*db)->selinuxusers, CIL_FALSE);
 	cil_list_destroy(&(*db)->names, CIL_TRUE);
+	cil_list_destroy(&(*db)->segregateattributes, CIL_FALSE);
 
 	cil_destroy_type((*db)->selftype);
 
@@ -1005,6 +1009,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_SRC_INFO:
 		cil_destroy_src_info(*data);
 		break;
+	case CIL_SEGREGATEATTRIBUTES:
+		cil_destroy_segregateattributes(*data);
+		break;
 	case CIL_OP:
 	case CIL_CONS_OPERAND:
 		break;
@@ -1413,6 +1420,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_CONS_H1;
 	case CIL_CONS_H2:
 		return CIL_KEY_CONS_H2;
+	case CIL_SEGREGATEATTRIBUTES:
+		return CIL_KEY_SEGREGATEATTRIBUTES;
 
 	default:
 		break;
@@ -2904,3 +2913,11 @@ void cil_src_info_init(struct cil_src_info **info)
 	(*info)->hll_line = 0;
 	(*info)->path = NULL;
 }
+
+void cil_segregateattributes_init(struct cil_segregateattributes **sattrs)
+{
+	*sattrs = cil_malloc(sizeof(**sattrs));
+
+	(*sattrs)->str_expr = NULL;
+	(*sattrs)->datum_expr = NULL;
+}
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 40615db2..0301d739 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3818,6 +3818,38 @@ exit:
 	return SEPOL_ERR;
 }
 
+static int cil_segregateattributes_to_policydb(policydb_t *pdb, const struct cil_segregateattributes *sattrs)
+{
+	segregate_attributes_rule_t *sattr;
+	struct cil_list_item *curr;
+	type_datum_t *sepol_type;
+	int rc = SEPOL_ERR;
+
+	sattr = cil_malloc(sizeof(segregate_attributes_rule_t));
+	ebitmap_init(&sattr->attrs);
+
+	cil_list_for_each(curr, sattrs->datum_expr) {
+		rc = __cil_get_sepol_type_datum(pdb, DATUM(curr->data), &sepol_type);
+		if (rc != SEPOL_OK) goto exit;
+
+		if (ebitmap_set_bit(&sattr->attrs, sepol_type->s.value - 1, 1)) {
+			goto exit;
+		}
+	}
+
+	sattr->next = pdb->segregate_attributes;
+	pdb->segregate_attributes = sattr;
+
+	return SEPOL_OK;
+
+exit:
+	if (sattr) {
+		ebitmap_destroy(&sattr->attrs);
+		free(sattr);
+	}
+	return rc;
+}
+
 static int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 {
 	int rc = SEPOL_OK;
@@ -3960,6 +3992,9 @@ static int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 		case CIL_DEFAULTRANGE:
 			rc = cil_defaultrange_to_policydb(pdb, node->data);
 			break;
+		case CIL_SEGREGATEATTRIBUTES:
+			rc = cil_segregateattributes_to_policydb(pdb, node->data);
+			break;
 		default:
 			break;
 		}
@@ -4890,6 +4925,42 @@ exit:
 	return rc;
 }
 
+static int cil_check_segregateattributes(const policydb_t *pdb, int *violation)
+{
+	const segregate_attributes_rule_t *sattr;
+
+	for (sattr = pdb->segregate_attributes; sattr; sattr = sattr->next) {
+		ebitmap_node_t *first_node;
+		unsigned int first_bit;
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, first_node, first_bit) {
+			ebitmap_node_t *second_node;
+			unsigned int second_bit;
+
+			ebitmap_for_each_positive_bit_after(&sattr->attrs, second_node, second_bit, first_node, first_bit) {
+				ebitmap_t attr_union;
+				ebitmap_node_t *type_node;
+				unsigned int type_bit;
+
+				if (ebitmap_and(&attr_union, &pdb->attr_type_map[first_bit], &pdb->attr_type_map[second_bit]))
+					return SEPOL_ERR;
+
+				ebitmap_for_each_positive_bit(&attr_union, type_node, type_bit) {
+					cil_log(CIL_ERR, "Segregate Attributes violation, type %s associated with attributes %s and %s\n",
+					                 pdb->p_type_val_to_name[type_bit],
+					                 pdb->p_type_val_to_name[first_bit],
+					                 pdb->p_type_val_to_name[second_bit]);
+					*violation = CIL_TRUE;
+				}
+
+				ebitmap_destroy(&attr_union);
+			}
+		}
+	}
+
+	return SEPOL_OK;
+}
+
 static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
 {
 	struct cil_classperms *cp;
@@ -5160,6 +5231,10 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		rc = cil_check_neverallows(db, pdb, neverallows, &violation);
 		if (rc != SEPOL_OK) goto exit;
 
+		cil_log(CIL_INFO, "Checking Segregate Attributes\n");
+		rc = cil_check_segregateattributes(pdb, &violation);
+		if (rc != SEPOL_OK) goto exit;
+
 		cil_log(CIL_INFO, "Checking User Bounds\n");
 		rc = bounds_check_users(NULL, pdb);
 		if (rc) {
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4177c9f6..611aade8 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6164,6 +6164,62 @@ void cil_destroy_src_info(struct cil_src_info *info)
 	free(info);
 }
 
+int cil_gen_segregateattributes(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_segregateattributes *sattrs = NULL;
+	int rc = SEPOL_ERR;
+
+	if (db == NULL || parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_segregateattributes_init(&sattrs);
+
+	rc = cil_gen_expr(parse_current->next, CIL_TYPEATTRIBUTE, &sattrs->str_expr);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	/* require at least two attributes */
+	if (sattrs->str_expr->head == sattrs->str_expr->tail) {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	ast_node->data = sattrs;
+	ast_node->flavor = CIL_SEGREGATEATTRIBUTES;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad segregate attributes declaration");
+	cil_destroy_segregateattributes(sattrs);
+	return rc;
+}
+
+void cil_destroy_segregateattributes(struct cil_segregateattributes *sattrs)
+{
+	if (sattrs == NULL) {
+		return;
+	}
+
+	cil_list_destroy(&sattrs->str_expr, CIL_TRUE);
+	cil_list_destroy(&sattrs->datum_expr, CIL_FALSE);
+
+	free(sattrs);
+}
+
 static int check_for_illegal_statement(struct cil_tree_node *parse_current, struct cil_args_build *args)
 {
 	if (args->tunif != NULL) {
@@ -6455,6 +6511,8 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 		rc = cil_gen_mls(parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SRC_INFO) {
 		rc = cil_gen_src_info(parse_current, new_ast_node);
+	} else if (parse_current->data == CIL_KEY_SEGREGATEATTRIBUTES) {
+		rc = cil_gen_segregateattributes(db, parse_current, new_ast_node);
 	} else {
 		cil_log(CIL_ERR, "Error: Unknown keyword %s\n", (char *)parse_current->data);
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index fd9053ce..d815a22f 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -225,6 +225,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 void cil_destroy_defaultrange(struct cil_defaultrange *def);
 int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_src_info(struct cil_src_info *info);
+int cil_gen_segregateattributes(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_segregateattributes(struct cil_segregateattributes *sattrs);
 
 int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats);
 void cil_destroy_cats(struct cil_cats *cats);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 17f05021..e0f3ba4f 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1697,6 +1697,21 @@ static int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *da
 	return SEPOL_OK;
 }
 
+static int cil_copy_segregateattributes(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_segregateattributes *orig = data;
+	struct cil_segregateattributes *new = NULL;
+
+	cil_segregateattributes_init(&new);
+
+	cil_copy_expr(db, orig->str_expr, &new->str_expr);
+	cil_copy_expr(db, orig->datum_expr, &new->datum_expr);
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
@@ -1990,6 +2005,9 @@ static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished
 	case CIL_SRC_INFO:
 		copy_func = &cil_copy_src_info;
 		break;
+	case CIL_SEGREGATEATTRIBUTES:
+		copy_func = &cil_copy_segregateattributes;
+		break;
 	default:
 		goto exit;
 	}
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index c2f0cee7..ffbd5877 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -115,6 +115,7 @@ enum cil_flavor {
 	CIL_SRC_INFO,
 	CIL_IBPKEYCON,
 	CIL_IBENDPORTCON,
+	CIL_SEGREGATEATTRIBUTES,
 
 /*
  *          boolean  constraint  set  catset
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index a7604762..e22c2f87 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -242,6 +242,7 @@ extern char *CIL_KEY_SRC_CIL;
 extern char *CIL_KEY_SRC_HLL_LMS;
 extern char *CIL_KEY_SRC_HLL_LMX;
 extern char *CIL_KEY_SRC_HLL_LME;
+extern char *CIL_KEY_SEGREGATEATTRIBUTES;
 
 /*
 	Symbol Table Array Indices
@@ -309,6 +310,7 @@ struct cil_db {
 	struct cil_list *userprefixes;
 	struct cil_list *selinuxusers;
 	struct cil_list *names;
+	struct cil_list *segregateattributes;
 	int num_types_and_attrs;
 	int num_classes;
 	int num_cats;
@@ -975,6 +977,11 @@ struct cil_src_info {
 	char *path;
 };
 
+struct cil_segregateattributes {
+	struct cil_list *str_expr;
+	struct cil_list *datum_expr;
+};
+
 void cil_db_init(struct cil_db **db);
 void cil_db_destroy(struct cil_db **db);
 
@@ -1085,5 +1092,6 @@ void cil_mls_init(struct cil_mls **mls);
 void cil_src_info_init(struct cil_src_info **info);
 void cil_userattribute_init(struct cil_userattribute **attribute);
 void cil_userattributeset_init(struct cil_userattributeset **attrset);
+void cil_segregateattributes_init(struct cil_segregateattributes **sattrs);
 
 #endif
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 7c543c47..36f6780d 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -69,6 +69,7 @@ enum cil_statement_list {
 	CIL_LIST_USER,
 	CIL_LIST_CONSTRAINT,
 	CIL_LIST_VALIDATETRANS,
+	CIL_LIST_SEGREGATEATTRIBUTES,
 	CIL_LIST_NUM_LISTS
 };
 
@@ -168,6 +169,9 @@ static int __cil_gather_statements_helper(struct cil_tree_node *node, uint32_t *
 	case CIL_VALIDATETRANS:
 		kind = CIL_LIST_VALIDATETRANS;
 		break;
+	case CIL_SEGREGATEATTRIBUTES:
+		kind = CIL_LIST_SEGREGATEATTRIBUTES;
+		break;
 	default:
 		break;
 	}
@@ -1911,6 +1915,27 @@ static void cil_devicetreecons_to_policy(FILE *out, struct cil_sort *devicetreec
 	}
 }
 
+static void cil_segregateattributes_to_policy(FILE *out, struct cil_list *sattrs_list)
+{
+	struct cil_list_item *curr_sattrs, *curr_attr;
+	struct cil_segregateattributes *sattrs;
+	int first = 1;
+
+	cil_list_for_each(curr_sattrs, sattrs_list) {
+		sattrs = curr_sattrs->data;
+		fprintf(out, "segregate_attriutes ");
+		cil_list_for_each(curr_attr, sattrs->datum_expr) {
+			if (!first) {
+				first = 0;
+			} else {
+				fprintf(out, ", ");
+			}
+			fprintf(out, "%s", DATUM(curr_attr->data)->fqn);
+		}
+		fprintf(out, ";\n");
+	}
+}
+
 void cil_gen_policy(FILE *out, struct cil_db *db)
 {
 	unsigned i;
@@ -1956,6 +1981,7 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
 	cil_typebounds_to_policy(out, lists[CIL_LIST_TYPE]);
 	cil_typeattributes_to_policy(out, lists[CIL_LIST_TYPE], lists[CIL_LIST_TYPEATTRIBUTE]);
 	cil_te_rules_to_policy(out, head, db->mls);
+	cil_segregateattributes_to_policy(out, db->segregateattributes);
 
 	cil_roles_to_policy(out, lists[CIL_LIST_ROLE]);
 	cil_role_types_to_policy(out, lists[CIL_LIST_ROLE], lists[CIL_LIST_TYPE]);
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 0864d7ef..c5ac83c8 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -475,6 +475,11 @@ static void cil_reset_booleanif(struct cil_booleanif *bif)
 	cil_list_destroy(&bif->datum_expr, CIL_FALSE);
 }
 
+static void cil_reset_segregateattributes(struct cil_segregateattributes *sattrs)
+{
+	cil_list_destroy(&sattrs->datum_expr, CIL_FALSE);
+}
+
 static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
 	switch (node->flavor) {
@@ -630,6 +635,9 @@ static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused))
 	case CIL_BOOLEANIF:
 		cil_reset_booleanif(node->data);
 		break;
+	case CIL_SEGREGATEATTRIBUTES:
+		cil_reset_segregateattributes(node->data);
+		break;
 	case CIL_TUNABLEIF:
 	case CIL_CALL:
 		break; /* Not effected by optional block disabling */
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f5e22c97..36a96199 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3265,6 +3265,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 		sym_index = CIL_SYM_TUNABLES;
 		break;
 	case CIL_TYPE:
+	case CIL_TYPEATTRIBUTE:
 		sym_index = CIL_SYM_TYPES;
 		break;
 	case CIL_ROLE:
@@ -3312,6 +3313,13 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			} else {
 				if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
 					cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
+				} else if (expr_type == CIL_SEGREGATEATTRIBUTES) {
+					if (FLAVOR(res_datum) != CIL_TYPEATTRIBUTE) {
+						cil_tree_log(parent, CIL_ERR, "Type or type alias not supported in segregate attributes declaration");
+						rc = SEPOL_ERR;
+						goto exit;
+					}
+					cil_type_used(res_datum, CIL_ATTR_NEVERALLOW);
 				}
 				cil_list_append(*datum_expr, CIL_DATUM, res_datum);
 			}
@@ -3508,6 +3516,33 @@ exit:
 	return rc;
 }
 
+int cil_resolve_segregateattributes(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_segregateattributes *sattrs = current->data;
+	struct cil_list_item *first, *second;
+	int rc;
+
+	rc = cil_resolve_expr(CIL_SEGREGATEATTRIBUTES, sattrs->str_expr, &sattrs->datum_expr, current, extra_args);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_list_for_each(first, sattrs->datum_expr) {
+		for (second = first->next; second; second = second->next) {
+			if (first->data == second->data) {
+				cil_tree_log(current, CIL_ERR, "Repeated attribute in segregate attributes declaration");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 /*
  * Degenerate inheritance leads to exponential growth of the policy
  * It can take many forms, but here is one example.
@@ -3888,6 +3923,9 @@ static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_USERATTRIBUTESET:
 			rc = cil_resolve_userattributeset(node, args);
 			break;
+		case CIL_SEGREGATEATTRIBUTES:
+			rc = cil_resolve_segregateattributes(node, args);
+			break;
 		default:
 			break;
 		}
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 1d971fd6..31594954 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -96,6 +96,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 int cil_resolve_boolif(struct cil_tree_node *current, void *extra_args);
 int cil_evaluate_expr(struct cil_list *datum_expr, uint16_t *result);
 int cil_resolve_tunif(struct cil_tree_node *current, void *extra_args);
+int cil_resolve_segregateattributes(struct cil_tree_node *current, void *extra_args);
 
 int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current);
 int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum);
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index b75784ef..d0fb555b 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1474,7 +1474,18 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		fprintf(out, "(ipaddr %s %s)\n", datum_to_str(&ipaddr->datum), buf);
 		break;
 	}
+	case CIL_SEGREGATEATTRIBUTES: {
+		struct cil_segregateattributes *sattrs = node->data;
+		fprintf(out, "(segregateattributes ");
+		if (sattrs->datum_expr)
+			write_expr(out, sattrs->datum_expr);
+		else
+			write_expr(out, sattrs->str_expr);
+		fprintf(out, ")\n");
+		break;
+	}
 	default :
+		cil_log(CIL_ERR, "Unsupported flavor: %d\n", node->flavor);
 		fprintf(out, "(<?RULE:%s>)\n", cil_node_to_string(node));
 		break;
 	}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 9128ac55..4b99208d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1906,6 +1906,33 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
 	return 0;
 }
 
+static int write_segregate_attributes_to_cil(FILE *out, const struct policydb *pdb)
+{
+	const segregate_attributes_rule_t *sattr;
+
+	for (sattr = pdb->segregate_attributes; sattr; sattr = sattr->next) {
+		struct ebitmap_node *node;
+		unsigned int bit;
+		int first = 1;
+
+		sepol_printf(out, "(segregateattributes (");
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, node, bit) {
+			if (first) {
+				first = 0;
+			} else {
+				sepol_printf(out, " ");
+			}
+
+			sepol_printf(out, "%s", pdb->p_type_val_to_name[bit - 1]);
+		}
+
+		sepol_printf(out, "))\n");
+	}
+
+	return 0;
+}
+
 static int write_filename_trans_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	struct map_filename_trans_args args;
@@ -3329,6 +3356,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	rc = write_segregate_attributes_to_cil(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = write_filename_trans_rules_to_cil(out, pdb);
 	if (rc != 0) {
 		goto exit;
diff --git a/secilc/docs/README.md b/secilc/docs/README.md
index efab2a71..8f584019 100644
--- a/secilc/docs/README.md
+++ b/secilc/docs/README.md
@@ -132,6 +132,7 @@ CIL (Common Intermediate Language)
   * [typemember](cil_type_statements.md#typemember)
   * [typetransition](cil_type_statements.md#typetransition)
   * [typepermissive](cil_type_statements.md#typepermissive)
+  * [segregateattributes](cil_type_statements.md#segregateattributes)
 
 * [User Statements](cil_user_statements.md#user-statements)
   * [user](cil_user_statements.md#user)
diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
index 19438417..56533eea 100644
--- a/secilc/docs/cil_type_statements.md
+++ b/secilc/docs/cil_type_statements.md
@@ -601,3 +601,53 @@ This example will allow SELinux to run the `healthd.process` domain in permissiv
         (allow ...)
     )
 ```
+
+segregateattributes
+-------------------
+
+Libsepol and secilc version 3.5 introduced the segregateattributes statement
+to mark two or more type attributes mutual exclusive. This is a compiler
+enforced action that will stop compilation until the offending associations
+are modified.
+
+Note that these constraints can be over-ridden by the CIL compiler command
+line parameter `-N` or `--disable-neverallow` flags.
+
+**Statement definition:**
+
+```secil
+    (segregateattributes (typeattribute_id typeattribute_id...))
+```
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="27%" />
+<col width="72%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>segregateattributes</code></p></td>
+<td align="left"><p>The <code>segregateattributes</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typeattribute_id</code></p></td>
+<td align="left"><p>At least two previously declared <code>typeattribute</code> identifier.</p>
+<p>Note that the same <code>typeattribute</code> identifier must not be repeated.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will not compile as `type_1` is associated with type attributes `attr_1` and `attr_2`:
+
+```secil
+    (type type_1)
+    (typeattribute attr_1)
+    (typeattribute attr_2)
+    (typeattributeset attr_1 (type_1))
+    (typeattributeset attr_2 (type_1))
+    (segregateattributes (attr_1 attr_2))
+```
-- 
2.36.1

