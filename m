Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CBE82CCB
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjI0TAl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjI0TAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50D8F
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41819a68143so43470271cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841233; x=1696446033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvhMrpYFcs6eUVVbeeWjAW8AYgJp6NNAiQxn5GTSk7A=;
        b=nWV9C2fXWe12ISVRKQGwMCrgiNC+rr1R3voKs0Gck2ziTR3CVdaskTn0m83E0vYQIb
         MnekZYAGNI8LAM8/NwY7YIwYjYPJOPHeXYUW99WIV9EziyOmfR7Ze1DYGxRUx92Blz94
         HmAdlVW/U2Kbu+v0iE+Lwbv388A7AK4sFJPV5Xq8MwAnduVjtUiREgNbsJeJwaEpk1Yw
         VVHLolRu+V8FE9mpiBvMg9XfyzyY9ZX1/eXIR5L5eNISWJoAX9eX87/+Xxrl/qZa/3Ya
         fJU5BKMxgUUAivu6I+uaqrfa582pXgW4FClcbIPWi5U0P3MLdcu/ObCJ7puolKO+671e
         iWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841233; x=1696446033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvhMrpYFcs6eUVVbeeWjAW8AYgJp6NNAiQxn5GTSk7A=;
        b=O5ZaOxKNGOxHRpgV7NgLyZenocKhDnDal1JN2LjhkMuq4FcUmBCwBg/mdVqC+8/wt0
         KgOSMtFtRbrHQaVzCIn4PjhLaBJYBTzSaZPnyTEol0XsyNuu/TDFGwO3PLPWahlLEcbZ
         MP3T+FveHEVOxuH8rqVK8P6Z6n3ZEh96BJodFCS5MBFPgIiX72uZCWWg25pFagdcfY05
         xK3fhiY6rv7zD61rh24jrYkuiZjjjHKC6L5EQ+ILjeSxTUCL/eh/UvAxhEwO9lylVWAf
         Lc5sz23usQ3bvDGB5amhCoB6XQPCmS/ENPSrB/DTbDSWFnHWKmxYLjB+cCz78AloLvly
         fimQ==
X-Gm-Message-State: AOJu0Yx30Kz4NoymeJC6qcb3V6R1U9nOUm8sL+lMILv06SkuAxlWl2eb
        4DUXDbehii9jlR7GocHia8v0fA9s1XY=
X-Google-Smtp-Source: AGHT+IFZCRb4wy6Eaia8TJELHVKVCxKJbDjvYHeI9lW/Odu5d3Jn0rPHHhrtjucjGIxKop64pRooOQ==
X-Received: by 2002:ac8:5fc3:0:b0:417:fa78:58a4 with SMTP id k3-20020ac85fc3000000b00417fa7858a4mr3260322qta.42.1695841233283;
        Wed, 27 Sep 2023 12:00:33 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:32 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/9] libsepol/cil: Add pointers to datums to improve writing out AST
Date:   Wed, 27 Sep 2023 15:00:20 -0400
Message-ID: <20230927190021.1164278-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are many rules in CIL that do not declare an object but
reference a datum or relate two or more datums together. In the
struct for these rules, strings are stored so that the appropriate
datums can be looked up when the rule is resolved. One example is
classcommon, which relates a kernel class and a common class. Often
the datums referenced in these rules will not be needed again, so
there are no pointers to datums in the struct for these rules.

When these rules are in a macro and make use of one of the arguments,
then we do not know the actual value to use when writing out the
AST for the resolve phase or later. Re-resolving the strings to
find the corresponding datums would be complex. If the structs for
these rules had pointers to the datums, then we could use the datums
to write out the correct values.

Add pointers to the datums in the data structures for these rules
and then use the actual datum values when writing out the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             | 18 ++++++++++
 libsepol/cil/src/cil_copy_ast.c    |  8 +++++
 libsepol/cil/src/cil_internal.h    | 18 ++++++++++
 libsepol/cil/src/cil_resolve_ast.c | 16 +++++++++
 libsepol/cil/src/cil_write_ast.c   | 57 +++++++++++++++++++-----------
 5 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index ac548d15..067e28a6 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -2275,6 +2275,7 @@ void cil_blockabstract_init(struct cil_blockabstract **abstract)
 {
 	*abstract = cil_malloc(sizeof(**abstract));
 	(*abstract)->block_str = NULL;
+	(*abstract)->block = NULL;
 }
 
 void cil_in_init(struct cil_in **in)
@@ -2284,6 +2285,7 @@ void cil_in_init(struct cil_in **in)
 	cil_symtab_array_init((*in)->symtab, cil_sym_sizes[CIL_SYM_ARRAY_IN]);
 	(*in)->is_after = CIL_FALSE;
 	(*in)->block_str = NULL;
+	(*in)->block = NULL;
 }
 
 void cil_class_init(struct cil_class **class)
@@ -2304,7 +2306,9 @@ void cil_classcommon_init(struct cil_classcommon **classcommon)
 	*classcommon = cil_malloc(sizeof(**classcommon));
 
 	(*classcommon)->class_str = NULL;
+	(*classcommon)->class = NULL;
 	(*classcommon)->common_str = NULL;
+	(*classcommon)->common = NULL;
 }
 
 void cil_sid_init(struct cil_sid **sid)
@@ -2322,6 +2326,7 @@ void cil_sidcontext_init(struct cil_sidcontext **sidcontext)
 	*sidcontext = cil_malloc(sizeof(**sidcontext));
 
 	(*sidcontext)->sid_str = NULL;
+	(*sidcontext)->sid = NULL;
 	(*sidcontext)->context_str = NULL;
 	(*sidcontext)->context = NULL;
 }
@@ -2381,6 +2386,7 @@ void cil_roleattributeset_init(struct cil_roleattributeset **attrset)
 	*attrset = cil_malloc(sizeof(**attrset));
 
 	(*attrset)->attr_str = NULL;
+	(*attrset)->attr = NULL;
 	(*attrset)->str_expr = NULL;
 	(*attrset)->datum_expr = NULL;
 }
@@ -2402,6 +2408,7 @@ void cil_typeattributeset_init(struct cil_typeattributeset **attrset)
 	*attrset = cil_malloc(sizeof(**attrset));
 
 	(*attrset)->attr_str = NULL;
+	(*attrset)->attr = NULL;
 	(*attrset)->str_expr = NULL;
 	(*attrset)->datum_expr = NULL;
 }
@@ -2429,7 +2436,9 @@ void cil_aliasactual_init(struct cil_aliasactual **aliasactual)
 	*aliasactual = cil_malloc(sizeof(**aliasactual));
 
 	(*aliasactual)->alias_str = NULL;
+	(*aliasactual)->alias = NULL;
 	(*aliasactual)->actual_str = NULL;
+	(*aliasactual)->actual = NULL;
 }
 
 void cil_typepermissive_init(struct cil_typepermissive **typeperm)
@@ -2598,6 +2607,7 @@ void cil_senscat_init(struct cil_senscat **senscat)
 	*senscat = cil_malloc(sizeof(**senscat));
 
 	(*senscat)->sens_str = NULL;
+	(*senscat)->sens = NULL;
 	(*senscat)->cats = NULL;
 }
 
@@ -2768,6 +2778,7 @@ void cil_classpermissionset_init(struct cil_classpermissionset **cps)
 	*cps = cil_malloc(sizeof(**cps));
 
 	(*cps)->set_str = NULL;
+	(*cps)->set = NULL;
 	(*cps)->classperms = NULL;
 }
 
@@ -2792,7 +2803,9 @@ void cil_classmapping_init(struct cil_classmapping **mapping)
 	*mapping = cil_malloc(sizeof(**mapping));
 
 	(*mapping)->map_class_str = NULL;
+	(*mapping)->map_class = NULL;
 	(*mapping)->map_perm_str = NULL;
+	(*mapping)->map_perm = NULL;
 	(*mapping)->classperms = NULL;
 }
 
@@ -2823,6 +2836,7 @@ void cil_userattributeset_init(struct cil_userattributeset **attrset)
 	*attrset = cil_malloc(sizeof(**attrset));
 
 	(*attrset)->attr_str = NULL;
+	(*attrset)->attr = NULL;
 	(*attrset)->str_expr = NULL;
 	(*attrset)->datum_expr = NULL;
 }
@@ -2832,6 +2846,7 @@ void cil_userlevel_init(struct cil_userlevel **usrlvl)
 	*usrlvl = cil_malloc(sizeof(**usrlvl));
 
 	(*usrlvl)->user_str = NULL;
+	(*usrlvl)->user = NULL;
 	(*usrlvl)->level_str = NULL;
 	(*usrlvl)->level = NULL;
 }
@@ -2841,6 +2856,7 @@ void cil_userrange_init(struct cil_userrange **userrange)
 	*userrange = cil_malloc(sizeof(**userrange));
 
 	(*userrange)->user_str = NULL;
+	(*userrange)->user = NULL;
 	(*userrange)->range_str = NULL;
 	(*userrange)->range = NULL;
 }
@@ -2928,7 +2944,9 @@ void cil_bounds_init(struct cil_bounds **bounds)
 	*bounds = cil_malloc(sizeof(**bounds));
 
 	(*bounds)->parent_str = NULL;
+	(*bounds)->parent = NULL;
 	(*bounds)->child_str = NULL;
+	(*bounds)->child = NULL;
 }
 
 void cil_default_init(struct cil_default **def)
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index f025de2f..1507edb4 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -148,6 +148,7 @@ int cil_copy_blockabstract(__attribute__((unused)) struct cil_db *db, void *data
 	cil_blockabstract_init(&new);
 
 	new->block_str = orig->block_str;
+	new->block = orig->block;
 
 	*copy = new;
 
@@ -248,7 +249,9 @@ int cil_copy_classmapping(__attribute__((unused)) struct cil_db *db, void *data,
 	cil_classmapping_init(&new);
 
 	new->map_class_str = orig->map_class_str;
+	new->map_class = orig->map_class;
 	new->map_perm_str = orig->map_perm_str;
+	new->map_perm = orig->map_perm;
 
 	cil_copy_classperms_list(orig->classperms, &new->classperms);
 
@@ -311,6 +314,7 @@ int cil_copy_classpermissionset(__attribute__((unused)) struct cil_db *db, void
 	cil_classpermissionset_init(&new);
 
 	new->set_str = orig->set_str;
+	new->set = orig->set;
 
 	cil_copy_classperms_list(orig->classperms, &new->classperms);
 
@@ -327,7 +331,9 @@ int cil_copy_classcommon(__attribute__((unused)) struct cil_db *db, void *data,
 	cil_classcommon_init(&new);
 
 	new->class_str = orig->class_str;
+	new->class = orig->class;
 	new->common_str = orig->common_str;
+	new->common = orig->common;
 
 	*copy = new;
 
@@ -679,7 +685,9 @@ static int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *db, void
 	cil_aliasactual_init(&new);
 
 	new->alias_str = orig->alias_str;
+	new->alias = orig->alias;
 	new->actual_str = orig->actual_str;
+	new->actual = orig->actual;
 
 	*copy = new;
 
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 4193ee99..47b67c89 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -367,12 +367,14 @@ struct cil_blockinherit {
 
 struct cil_blockabstract {
 	char *block_str;
+	struct cil_block *block;
 };
 
 struct cil_in {
 	symtab_t symtab[CIL_SYM_NUM];
 	int is_after;
 	char *block_str;
+	struct cil_block *block;
 };
 
 struct cil_optional {
@@ -412,18 +414,23 @@ struct cil_classpermission {
 
 struct cil_classpermissionset {
 	char *set_str;
+	struct cil_classpermission *set;
 	struct cil_list *classperms;
 };
 
 struct cil_classmapping {
 	char *map_class_str;
+	struct cil_class *map_class;
 	char *map_perm_str;
+	struct cil_perm *map_perm;
 	struct cil_list *classperms;
 };
 
 struct cil_classcommon {
 	char *class_str;
+	struct cil_class *class;
 	char *common_str;
+	struct cil_class *common;
 };
 
 struct cil_alias {
@@ -433,7 +440,9 @@ struct cil_alias {
 
 struct cil_aliasactual {
 	char *alias_str;
+	void *alias;
 	char *actual_str;
+	void *actual;
 };
 
 struct cil_sid {
@@ -444,6 +453,7 @@ struct cil_sid {
 
 struct cil_sidcontext {
 	char *sid_str;
+	struct cil_sid *sid;
 	char *context_str;
 	struct cil_context *context;
 };
@@ -465,6 +475,7 @@ struct cil_userattribute {
 
 struct cil_userattributeset {
 	char *attr_str;
+	struct cil_userattribute *attr;
 	struct cil_list *str_expr;
 	struct cil_list *datum_expr;
 };
@@ -478,12 +489,14 @@ struct cil_userrole {
 
 struct cil_userlevel {
 	char *user_str;
+	void *user;
 	char *level_str;
 	struct cil_level *level;
 };
 
 struct cil_userrange {
 	char *user_str;
+	void *user;
 	char *range_str;
 	struct cil_levelrange *range;
 };
@@ -517,6 +530,7 @@ struct cil_roleattribute {
 
 struct cil_roleattributeset {
 	char *attr_str;
+	struct cil_roleattribute *attr;
 	struct cil_list *str_expr;
 	struct cil_list *datum_expr;
 };
@@ -549,6 +563,7 @@ struct cil_typeattribute {
 
 struct cil_typeattributeset {
 	char *attr_str;
+	struct cil_typeattribute *attr;
 	struct cil_list *str_expr;
 	struct cil_list *datum_expr;
 };
@@ -697,6 +712,7 @@ struct cil_catset {
 
 struct cil_senscat {
 	char *sens_str;
+	struct cil_sens *sens;
 	struct cil_cats *cats;
 };
 
@@ -925,7 +941,9 @@ struct cil_policycap {
 
 struct cil_bounds {
 	char *parent_str;
+	void *parent;
 	char *child_str;
+	void *child;
 };
 
 /* Ensure that CIL uses the same values as sepol policydb.h */
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index d52c106a..4e8a375d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -216,6 +216,7 @@ int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_cla
 	}
 
 	cp = (struct cil_classpermission *)datum;
+	cps->set = cp;
 
 	if (cp->classperms == NULL) {
 		cil_list_init(&cp->classperms, CIL_CLASSPERMS);
@@ -524,6 +525,7 @@ static int cil_resolve_aliasactual(struct cil_tree_node *current, struct cil_db
 	}
 
 	alias = (struct cil_alias *)alias_datum;
+	aliasactual->alias = alias_datum;
 
 	if (alias->actual != NULL) {
 		cil_log(CIL_ERR, "%s %s cannot bind more than one value\n", cil_node_to_string(NODE(alias_datum)), alias_datum->name);
@@ -532,6 +534,7 @@ static int cil_resolve_aliasactual(struct cil_tree_node *current, struct cil_db
 	}
 
 	alias->actual = actual_datum;
+	aliasactual->actual = actual_datum;
 
 	return SEPOL_OK;
 
@@ -773,6 +776,9 @@ int cil_resolve_classcommon(struct cil_tree_node *current, struct cil_db *db)
 
 	class->common = common;
 
+	clscom->class = class;
+	clscom->common = common;
+
 	cil_symtab_map(&class->perms, __class_update_perm_values, &common->num_perms);
 
 	class->num_perms += common->num_perms;
@@ -802,6 +808,7 @@ int cil_resolve_classmapping(struct cil_tree_node *current, struct cil_db *db)
 		goto exit;
 	}
 	map = (struct cil_class*)datum;
+	mapping->map_class = map;
 
 	rc = cil_symtab_get_datum(&map->perms, mapping->map_perm_str, &datum);
 	if (rc != SEPOL_OK) {
@@ -809,6 +816,7 @@ int cil_resolve_classmapping(struct cil_tree_node *current, struct cil_db *db)
 	}
 
 	mp = (struct cil_perm*)datum;
+	mapping->map_perm = mp;
 
 	rc = cil_resolve_classperms_list(current, mapping->classperms, db);
 	if (rc != SEPOL_OK) {
@@ -877,6 +885,7 @@ int cil_resolve_userlevel(struct cil_tree_node *current, struct cil_db *db)
 	}
 
 	user = (struct cil_user*)user_datum;
+	usrlvl->user = user;
 
 	if (usrlvl->level_str != NULL) {
 		rc = cil_resolve_name(current, usrlvl->level_str, CIL_SYM_LEVELS, db, &lvl_datum);
@@ -930,6 +939,7 @@ int cil_resolve_userrange(struct cil_tree_node *current, struct cil_db *db)
 	}
 
 	user = (struct cil_user*)user_datum;
+	userrange->user = user;
 
 	if (userrange->range_str != NULL) {
 		rc = cil_resolve_name(current, userrange->range_str, CIL_SYM_LEVELRANGES, db, &range_datum);
@@ -2190,6 +2200,7 @@ int cil_resolve_sidcontext(struct cil_tree_node *current, struct cil_db *db)
 		goto exit;
 	}
 	sid = (struct cil_sid*)sid_datum;
+	sidcon->sid = sid;
 
 	if (sidcon->context_str != NULL) {
 		rc = cil_resolve_name(current, sidcon->context_str, CIL_SYM_CONTEXTS, db, &context_datum);
@@ -2315,6 +2326,8 @@ static int cil_resolve_blockabstract(struct cil_tree_node *current, struct cil_d
 		goto exit;
 	}
 
+	abstract->block = (struct cil_block *)block_datum;
+
 	cil_list_append(abstract_blocks, CIL_NODE, block_node);
 
 	return SEPOL_OK;
@@ -2335,6 +2348,8 @@ int cil_resolve_in(struct cil_tree_node *current, struct cil_db *db)
 		goto exit;
 	}
 
+	in->block = (struct cil_block *)block_datum;
+
 	block_node = NODE(block_datum);
 
 	if (block_node->flavor == CIL_OPTIONAL) {
@@ -3364,6 +3379,7 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, struct cil_db *d
 		goto exit;
 	}
 	attr = (struct cil_userattribute*)attr_datum;
+	attrusers->attr = attr;
 
 	rc = cil_resolve_expr(CIL_USERATTRIBUTESET, attrusers->str_expr, &attrusers->datum_expr, current, db);
 	if (rc != SEPOL_OK) {
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 161c53e9..f4f9f167 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -588,7 +588,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_IN: {
 		struct cil_in *in = node->data;
-		fprintf(out, "(in %s", in->block_str);
+		fprintf(out, "(in %s", datum_or_str(DATUM(in->block), in->block_str));
 		if (!node->cl_head)
 			fprintf(out, ")");
 		fprintf(out, "\n");
@@ -667,7 +667,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_BLOCKABSTRACT: {
 		struct cil_blockabstract *abstract = node->data;
-		fprintf(out, "(blockabstract %s)\n", abstract->block_str);
+		fprintf(out, "(blockabstract %s)\n", datum_or_str(DATUM(abstract->block), abstract->block_str));
 		break;
 	}
 	case CIL_MLS: {
@@ -788,7 +788,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_CLASSCOMMON: {
 		struct cil_classcommon *cc = node->data;
-		fprintf(out, "(classcommon %s %s)\n", cc->class_str, cc->common_str);
+		fprintf(out, "(classcommon %s ", datum_or_str(DATUM(cc->class), cc->class_str));
+		fprintf(out, "%s", datum_or_str(DATUM(cc->common), cc->common_str));
+		fprintf(out, ")\n");
 		break;
 	}
 	case CIL_CLASSPERMISSION: {
@@ -798,7 +800,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_CLASSPERMISSIONSET: {
 		struct cil_classpermissionset *cps = node->data;
-		fprintf(out, "(classpermissionset %s ", cps->set_str);
+		fprintf(out, "(classpermissionset %s ", datum_or_str(DATUM(cps->set), cps->set_str));
 		write_classperms_list(out, cps->classperms);
 		fprintf(out, ")\n");
 		break;
@@ -812,7 +814,8 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_CLASSMAPPING: {
 		struct cil_classmapping *mapping = node->data;
-		fprintf(out, "(classmapping %s %s ", mapping->map_class_str, mapping->map_perm_str);
+		fprintf(out, "(classmapping %s ", datum_or_str(DATUM(mapping->map_class), mapping->map_class_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(mapping->map_perm), mapping->map_perm_str));
 		write_classperms_list(out, mapping->classperms);
 		fprintf(out, ")\n");
 		break;
@@ -833,7 +836,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_SIDCONTEXT: {
 		struct cil_sidcontext *sidcon = node->data;
-		fprintf(out, "(sidcontext %s ", sidcon->sid_str);
+		fprintf(out, "(sidcontext %s ", datum_or_str(DATUM(sidcon->sid), sidcon->sid_str));
 		if (sidcon->context)
 			write_context(out, sidcon->context, CIL_TRUE);
 		else
@@ -874,7 +877,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_SENSALIASACTUAL: {
 		struct cil_aliasactual *aliasactual = node->data;
-		fprintf(out, "(sensitivityaliasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		fprintf(out, "(sensitivityaliasactual %s ", datum_or_str(DATUM(aliasactual->alias), aliasactual->alias_str));
+		fprintf(out, "%s", datum_or_str(DATUM(aliasactual->actual), aliasactual->actual_str));
+		fprintf(out, ")\n");
 		break;
 	}
 	case CIL_CAT: {
@@ -889,7 +894,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_CATALIASACTUAL: {
 		struct cil_aliasactual *aliasactual = node->data;
-		fprintf(out, "(categoryaliasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		fprintf(out, "(categoryaliasactual %s ", datum_or_str(DATUM(aliasactual->alias), aliasactual->alias_str));
+		fprintf(out, "%s", datum_or_str(DATUM(aliasactual->actual), aliasactual->actual_str));
+		fprintf(out, ")\n");
 		break;
 	}
 	case CIL_CATSET: {
@@ -913,7 +920,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	case CIL_SENSCAT: {
 		struct cil_senscat *senscat = node->data;
 		fprintf(out, "(sensitivitycategory ");
-		fprintf(out, "%s ", senscat->sens_str);
+		fprintf(out, "%s ", datum_or_str(DATUM(senscat->sens), senscat->sens_str));
 		write_cats(out, senscat->cats);
 		fprintf(out, ")\n");
 		break;
@@ -955,7 +962,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_USERATTRIBUTESET: {
 		struct cil_userattributeset *attr = node->data;
-		fprintf(out, "(userattributeset %s ", attr->attr_str);
+		fprintf(out, "(userattributeset %s ", datum_or_str(DATUM(attr->attr), attr->attr_str));
 		if (attr->datum_expr)
 			write_expr(out, attr->datum_expr);
 		else
@@ -966,14 +973,14 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	case CIL_USERROLE: {
 		struct cil_userrole *userrole = node->data;
 		fprintf(out, "(userrole ");
-		fprintf(out, "%s ", datum_or_str(userrole->user, userrole->user_str));
-		fprintf(out, "%s", datum_or_str(userrole->role, userrole->role_str));
+		fprintf(out, "%s ", datum_or_str(DATUM(userrole->user), userrole->user_str));
+		fprintf(out, "%s", datum_or_str(DATUM(userrole->role), userrole->role_str));
 		fprintf(out, ")\n");
 		break;
 	}
 	case CIL_USERLEVEL: {
 		struct cil_userlevel *userlevel = node->data;
-		fprintf(out, "(userlevel %s ", userlevel->user_str);
+		fprintf(out, "(userlevel %s ", datum_or_str(DATUM(userlevel->user), userlevel->user_str));
 		if (userlevel->level)
 			write_level(out, userlevel->level, CIL_TRUE);
 		else
@@ -983,7 +990,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_USERRANGE: {
 		struct cil_userrange *userrange = node->data;
-		fprintf(out, "(userrange %s ", userrange->user_str);
+		fprintf(out, "(userrange %s ", datum_or_str(DATUM(userrange->user), userrange->user_str));
 		if (userrange->range)
 			write_range(out, userrange->range, CIL_TRUE);
 		else
@@ -993,7 +1000,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_USERBOUNDS: {
 		struct cil_bounds *bounds = node->data;
-		fprintf(out, "(userbounds %s %s)\n", bounds->parent_str, bounds->child_str);
+		fprintf(out, "(userbounds ");
+		fprintf(out, "%s ", datum_or_str(DATUM(bounds->parent), bounds->parent_str));
+		fprintf(out, "%s)\n", datum_or_str(DATUM(bounds->child), bounds->child_str));
 		break;
 	}
 	case CIL_USERPREFIX: {
@@ -1035,7 +1044,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_ROLEATTRIBUTESET: {
 		struct cil_roleattributeset *attr = node->data;
-		fprintf(out, "(roleattributeset %s ", attr->attr_str);
+		fprintf(out, "(roleattributeset %s ", datum_or_str(DATUM(attr->attr), attr->attr_str));
 		if (attr->datum_expr)
 			write_expr(out, attr->datum_expr);
 		else
@@ -1052,8 +1061,10 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		break;
 	}
 	case CIL_ROLEBOUNDS: {
-		struct cil_bounds *bnds = node->data;
-		fprintf(out, "(rolebounds %s %s)\n", bnds->parent_str, bnds->child_str);
+		struct cil_bounds *bounds = node->data;
+		fprintf(out, "(rolebounds ");
+		fprintf(out, "%s ", datum_or_str(DATUM(bounds->parent), bounds->parent_str));
+		fprintf(out, "%s)\n", datum_or_str(DATUM(bounds->child), bounds->child_str));
 		break;
 	}
 	case CIL_TYPE: {
@@ -1066,7 +1077,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_TYPEALIASACTUAL: {
 		struct cil_aliasactual *aliasactual = node->data;
-		fprintf(out, "(typealiasactual %s %s)\n", aliasactual->alias_str, aliasactual->actual_str);
+		fprintf(out, "(typealiasactual %s ", datum_or_str(DATUM(aliasactual->alias), aliasactual->alias_str));
+		fprintf(out, "%s", datum_or_str(DATUM(aliasactual->actual), aliasactual->actual_str));
+		fprintf(out, ")\n");
 		break;
 	}
 	case CIL_TYPEATTRIBUTE: {
@@ -1075,7 +1088,7 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_TYPEATTRIBUTESET: {
 		struct cil_typeattributeset *attr = node->data;
-		fprintf(out, "(typeattributeset %s ", attr->attr_str);
+		fprintf(out, "(typeattributeset %s ", datum_or_str(DATUM(attr->attr), attr->attr_str));
 		if (attr->datum_expr)
 			write_expr(out, attr->datum_expr);
 		else
@@ -1102,7 +1115,9 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	}
 	case CIL_TYPEBOUNDS: {
 		struct cil_bounds *bounds = node->data;
-		fprintf(out, "(typebounds %s %s)\n", bounds->parent_str, bounds->child_str);
+		fprintf(out, "(typebounds ");
+		fprintf(out, "%s ", datum_or_str(DATUM(bounds->parent), bounds->parent_str));
+		fprintf(out, "%s)\n", datum_or_str(DATUM(bounds->child), bounds->child_str));
 		break;
 	}
 	case CIL_ROLEALLOW: {
-- 
2.41.0

