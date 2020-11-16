Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB0DC388F9
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA9223C7
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opbxDfSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgKPWHX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:22 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956EAC0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:22 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so18579281qkk.10
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RusTduV3jsECSofq865SkT3RbKYUN4PskUBQ6Hzspis=;
        b=opbxDfSEV7s6mKgygUBbRjjQPTsZnGMzJGy0nhbTdc6IzZiCQIcZ/lN3Qi9xd/T6aL
         QHkyi1TAbbnvS2QgQd8VIYPYCjJXwR24HmMYWiS5Dirk2XeVYwHg4nshFNsrdaul61r3
         SfolZtcqCKDRykBIZOUbye0LqY8iCd37SU46lFHBlW6if5S2jwpSQXhWtouryiVz0KYS
         WqrT6j6r136sOzvsdn0aLzwg1bVUxUMQ7oCjlrwFfVwG7MMNgiEtZAEseU+kKYPkyzqB
         3rqw+vvLqALVB+fplLqdX2WZry8DMpBarvjCHgwDIuUEQlQWiwqR/5oXKUYpHkjmAn64
         XbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RusTduV3jsECSofq865SkT3RbKYUN4PskUBQ6Hzspis=;
        b=qNrPjfLfPhZmYHg76GZG1Cs/+dffhKUC+hzxwCxArLVMfbyfOYGwridwbvRLHUnboE
         F+vI0N3rruO6NJi39QOwK6ZLVwFW6zIhUVrzGQ2PaEbKO0owcHTVyndCdYnVMQXSL3cc
         Z4IK70zRBzEhQYY5bjF98gOo5k2McnGouxnlfae7fi86hlBcdYIisIcO0pC4BuOuGmrS
         bwWOfjt/EzkVRcyvkaLD2wv33UdBtkyg7ZOodUhPpY77AyA5yG42RA8QCNklamJtmmE4
         tp/ml5VKNDuNcVALU2kazgKzPvmZcpeX0iackWg77o2yEkEuG4qXT7q6HdqiIU9coXuG
         dVQA==
X-Gm-Message-State: AOAM532fs+GmmNfNdXLVRrIcjuZ8d4d/rwfxTTeMUnrJETPl0ae0FfW+
        Xr6/BvPR+5/d7pgtQJ1Hr9sNf3TB2GQ=
X-Google-Smtp-Source: ABdhPJy8ONvggBe+1RsLZSxDqEhKI3p9qGZ2ZECtDhrQh54q7J1hqVZ3bvoxV3z+EeAIEBJ0E4AbXQ==
X-Received: by 2002:a37:6445:: with SMTP id y66mr17977708qkb.100.1605564441581;
        Mon, 16 Nov 2020 14:07:21 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:21 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6] libsepol/cil: Use the macro NODE() whenever possible
Date:   Mon, 16 Nov 2020 17:07:01 -0500
Message-Id: <20201116220702.174765-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116220702.174765-1-jwcart2@gmail.com>
References: <20201116220702.174765-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In cil_symtab.h, the macro NODE() is defined. It refers to the first
node in the list of nodes that declare that datum. (It is rare for
a datum to have more than one node in this list.) While the macro was
used in many places, it was not used everywhere that it could be.

Change all the remaining places to use NODE().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             |  2 +-
 libsepol/cil/src/cil_binary.c      | 12 ++++-----
 libsepol/cil/src/cil_find.c        |  2 +-
 libsepol/cil/src/cil_resolve_ast.c | 40 +++++++++++++++---------------
 libsepol/cil/src/cil_tree.c        |  2 +-
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 95bdb5e5..bb7f06d5 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1380,7 +1380,7 @@ static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitm
 	}
 
 	cil_list_for_each(i, cats->datum_expr) {
-		node = DATUM(i->data)->nodes->head->data;
+		node = NODE(i->data);
 		if (node->flavor == CIL_CATSET) {
 			cs = (struct cil_catset*)i->data;
 			cil_list_for_each(j, cs->cats->datum_expr) {
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e417c5c2..3b01ade1 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -147,7 +147,7 @@ static int __cil_get_sepol_level_datum(policydb_t *pdb, struct cil_symtab_datum
 
 static int __cil_expand_user(struct cil_symtab_datum *datum, ebitmap_t *new)
 {
-	struct cil_tree_node *node = datum->nodes->head->data;
+	struct cil_tree_node *node = NODE(datum);
 	struct cil_user *user = NULL;
 	struct cil_userattribute *attr = NULL;
 
@@ -175,7 +175,7 @@ exit:
 
 static int __cil_expand_role(struct cil_symtab_datum *datum, ebitmap_t *new)
 {
-	struct cil_tree_node *node = datum->nodes->head->data;
+	struct cil_tree_node *node = NODE(datum);
 
 	if (node->flavor == CIL_ROLEATTRIBUTE) {
 		struct cil_roleattribute *attr = (struct cil_roleattribute *)datum;
@@ -201,7 +201,7 @@ exit:
 
 static int __cil_expand_type(struct cil_symtab_datum *datum, ebitmap_t *new)
 {
-	struct cil_tree_node *node = datum->nodes->head->data;
+	struct cil_tree_node *node = NODE(datum);
 
 	if (node->flavor == CIL_TYPEATTRIBUTE) {
 		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
@@ -2943,7 +2943,7 @@ int __cil_cats_to_mls_level(policydb_t *pdb, struct cil_cats *cats, mls_level_t
 	cat_datum_t *sepol_cat = NULL;
 
 	cil_list_for_each(i, cats->datum_expr) {
-		struct cil_tree_node *node = DATUM(i->data)->nodes->head->data;
+		struct cil_tree_node *node = NODE(i->data);
 		if (node->flavor == CIL_CATSET) {
 			struct cil_list_item *j;
 			struct cil_catset *cs = i->data;
@@ -3701,7 +3701,7 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 	type_value_to_cil = args->type_value_to_cil;
 
 	if (node->flavor >= CIL_MIN_DECLARATIVE) {
-		if (node != DATUM(node->data)->nodes->head->data) {
+		if (node != NODE(node->data)) {
 			goto exit;
 		}
 	}
@@ -4450,7 +4450,7 @@ static void __cil_init_sepol_type_set(type_set_t *t)
 static int __cil_add_sepol_type(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *datum, ebitmap_t *map)
 {
 	int rc = SEPOL_ERR;
-	struct cil_tree_node *n = datum->nodes->head->data;
+	struct cil_tree_node *n = NODE(datum);
 	type_datum_t *sepol_datum = NULL;
 
 	if (n->flavor == CIL_TYPEATTRIBUTE) {
diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 41342424..c182406e 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -118,7 +118,7 @@ static int cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, str
 static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
 {
 	int rc;
-	struct cil_tree_node *n1 = s1->nodes->head->data;
+	struct cil_tree_node *n1 = NODE(s1);
 	if (n1->flavor != CIL_TYPEATTRIBUTE) {
 		rc = cil_type_match_any(s1, t2);
 	} else {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 9e6afca9..060bc0d0 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -393,7 +393,7 @@ int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	result_node = result_datum->nodes->head->data;
+	result_node = NODE(result_datum);
 
 	if (result_node->flavor != CIL_TYPE) {
 		cil_log(CIL_ERR, "Type rule result must be a type [%d]\n",result_node->flavor);
@@ -421,7 +421,7 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args
 		goto exit;
 	}
 
-	attr_node = attr_datum->nodes->head->data;
+	attr_node = NODE(attr_datum);
 
 	if (attr_node->flavor != CIL_TYPEATTRIBUTE) {
 		rc = SEPOL_ERR;
@@ -470,7 +470,7 @@ int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_a
 			goto exit;
 		}
 
-		attr_node = attr_datum->nodes->head->data;
+		attr_node = NODE(attr_datum);
 
 		if (attr_node->flavor != CIL_TYPEATTRIBUTE) {
 			rc = SEPOL_ERR;
@@ -594,7 +594,7 @@ int cil_resolve_typepermissive(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	type_node = type_datum->nodes->head->data;
+	type_node = NODE(type_datum);
 
 	if (type_node->flavor != CIL_TYPE && type_node->flavor != CIL_TYPEALIAS) {
 		cil_log(CIL_ERR, "Typepermissive must be a type or type alias\n");
@@ -654,7 +654,7 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_ar
 		goto exit;
 	}
 
-	result_node = result_datum->nodes->head->data;
+	result_node = NODE(result_datum);
 
 	if (result_node->flavor != CIL_TYPE && result_node->flavor != CIL_TYPEALIAS) {
 		cil_log(CIL_ERR, "typetransition result is not a type or type alias\n");
@@ -855,7 +855,7 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	user_node = user_datum->nodes->head->data;
+	user_node = NODE(user_datum);
 
 	if (user_node->flavor != CIL_USER) {
 		cil_log(CIL_ERR, "Userlevel must be a user\n");
@@ -908,7 +908,7 @@ int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	user_node = user_datum->nodes->head->data;
+	user_node = NODE(user_datum);
 
 	if (user_node->flavor != CIL_USER) {
 		cil_log(CIL_ERR, "Userrange must be a user: %s\n", user_datum->fqn);
@@ -959,7 +959,7 @@ int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	user_node = user_datum->nodes->head->data;
+	user_node = NODE(user_datum);
 
 	if (user_node->flavor != CIL_USER) {
 		cil_log(CIL_ERR, "Userprefix must be a user: %s\n", user_datum->fqn);
@@ -986,7 +986,7 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	user_node = user_datum->nodes->head->data;
+	user_node = NODE(user_datum);
 
 	if (user_node->flavor != CIL_USER) {
 		cil_log(CIL_ERR, "Selinuxuser must be a user: %s\n", user_datum->fqn);
@@ -1079,7 +1079,7 @@ int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	node = result_datum->nodes->head->data;
+	node = NODE(result_datum);
 	if (node->flavor != CIL_ROLE) {
 		rc = SEPOL_ERR;
 		printf("%i\n", node->flavor);
@@ -1131,7 +1131,7 @@ int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	attr_node = attr_datum->nodes->head->data;
+	attr_node = NODE(attr_datum);
 
 	if (attr_node->flavor != CIL_ROLEATTRIBUTE) {
 		rc = SEPOL_ERR;
@@ -1569,7 +1569,7 @@ int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
 			cil_log(CIL_ERR, "Failed to resolve category %s in categoryorder\n", (char *)curr->data);
 			goto exit;
 		}
-		node = cat_datum->nodes->head->data;
+		node = NODE(cat_datum);
 		if (node->flavor != CIL_CAT) {
 			cil_log(CIL_ERR, "%s is not a category. Only categories are allowed in categoryorder statements\n", cat_datum->name);
 			rc = SEPOL_ERR;
@@ -1832,7 +1832,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 		goto exit;
 	}
 
-	node = user_datum->nodes->head->data;
+	node = NODE(user_datum);
 
 	if (node->flavor != CIL_USER) {
 		cil_log(CIL_ERR, "Context user must be a user: %s\n", user_datum->fqn);
@@ -1847,7 +1847,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 		goto exit;
 	}
 
-	node = role_datum->nodes->head->data;
+	node = NODE(role_datum);
 	if (node->flavor != CIL_ROLE) {
 		rc = SEPOL_ERR;
 		cil_log(CIL_ERR, "Context role not a role: %s\n", role_datum->fqn);
@@ -1861,7 +1861,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
 		goto exit;
 	}
 
-	node = type_datum->nodes->head->data;
+	node = NODE(type_datum);
 
 	if (node->flavor != CIL_TYPE && node->flavor != CIL_TYPEALIAS) {
 		rc = SEPOL_ERR;
@@ -2311,7 +2311,7 @@ int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_arg
 		goto exit;
 	}
 
-	node = block_datum->nodes->head->data;
+	node = NODE(block_datum);
 
 	if (node->flavor != CIL_BLOCK) {
 		cil_log(CIL_ERR, "%s is not a block\n", cil_node_to_string(node));
@@ -2450,7 +2450,7 @@ int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	block_node = block_datum->nodes->head->data;
+	block_node = NODE(block_datum);
 	if (block_node->flavor != CIL_BLOCK) {
 		cil_log(CIL_ERR, "Failed to resolve blockabstract to a block, rc: %d\n", rc);
 		goto exit;
@@ -2482,7 +2482,7 @@ int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	block_node = block_datum->nodes->head->data;
+	block_node = NODE(block_datum);
 
 	rc = cil_copy_ast(db, current, block_node);
 	if (rc != SEPOL_OK) {
@@ -2774,7 +2774,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	macro_node = macro_datum->nodes->head->data;
+	macro_node = NODE(macro_datum);
 
 	if (macro_node->flavor != CIL_MACRO) {
 		printf("Failed to resolve %s to a macro\n", new_call->macro_str);
@@ -3367,7 +3367,7 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	attr_node = attr_datum->nodes->head->data;
+	attr_node = NODE(attr_datum);
 
 	if (attr_node->flavor != CIL_USERATTRIBUTE) {
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index b1cbda91..3ab5e868 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1688,7 +1688,7 @@ void cil_tree_print_node(struct cil_tree_node *node)
 					struct cil_symtab_datum *datum = ((struct cil_args*)item->data)->arg;
 					if (datum != NULL) {
 						if (datum->nodes != NULL && datum->nodes->head != NULL) {
-							cil_tree_print_node((struct cil_tree_node*)datum->nodes->head->data);
+							cil_tree_print_node(NODE(datum));
 						}
 					} else if (((struct cil_args*)item->data)->arg_str != NULL) {
 						switch (item->flavor) {
-- 
2.25.4

