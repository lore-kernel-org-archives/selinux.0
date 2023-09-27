Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1FE82CC6
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjI0TAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjI0TAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55A1A6
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4180b417309so48956761cf.0
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841231; x=1696446031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yYMIhzuxCQIRRb0lHr3Wd4V1FPA2OYxIbUN18oCFY4=;
        b=OdLNQcU5+Pmaj9UWBCw6y+tixMXiigedvyxXC91ewNuTD3JViTDCh2TOpZ6bcuzWMt
         /7VEAC0/YQAF/qrct3IpJdX90r0SzUpw5W6kQDaKoO2jk4Fb49NxoPkz497sM7sGd6IC
         kduBuMqmYwx855MTO4uS8uMTqlk3svwi5sYg8fbNM6/yDS/0zClveUsO2Jx2i2L9MFet
         HuPB+w2kZ4BJP7vVPUejyyAxbPD6CqPlBBMyGIvWk2llQAkEr4HQSDsuV9vaIoJhxleL
         dXd/G8EFGshrC5qAvHPy8ru+9YOdruyZBElO3ZedKiVfpnX/PZzI6JMVAQx0n4d1/M/9
         SqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841231; x=1696446031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yYMIhzuxCQIRRb0lHr3Wd4V1FPA2OYxIbUN18oCFY4=;
        b=SPmIZ66EjFLB4EIPdP8oSHZiwGMp54PbE5atr0iLvHv9vMXrXu44cct2hriIk+HPue
         hyGefGGznofXKhDVJ3ewUD+zW9fhxMP39EXuNDWwCc6MVkltItbTmTYKU0vDXm4FZSz3
         IcOFKRBV5mM/I6zm2w6PsWv9EzLSIhyn2wNeZbzkz2cP9u2bQv7nYAFCxT4ULrizDKkm
         +mkQm5Ge2cLYzJy7tN1BPkyHqm1TSz/stFDVV68PcRc8hIXux156EqAEQd82CTHGPyqy
         SHwPzYwqOThArpaUY/wTAL/q3DUoJ2BV8f70yYC3k9oEMs7MrZt4zkszpPT9Tfc27T2G
         HNRA==
X-Gm-Message-State: AOJu0YyQybYHyql4kouv62KCpfniMf5wUtfBAhYLUZ+DpueWb7SDtkDo
        3tTEpzIxrztmxTVGoZ5fVsUlt+h/OpQ=
X-Google-Smtp-Source: AGHT+IF1G0PZsEzcaWWE/St0aXEYLml97UVYuwl102K/fQs73b6+Colmi267cg6fhmxjDmCOhhOQmQ==
X-Received: by 2002:a05:622a:2c1:b0:417:b7c7:5a2e with SMTP id a1-20020a05622a02c100b00417b7c75a2emr2881193qtx.61.1695841231096;
        Wed, 27 Sep 2023 12:00:31 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:30 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/9] libsepol/cil: Refactor Named Type Transition Filename Creation
Date:   Wed, 27 Sep 2023 15:00:17 -0400
Message-ID: <20230927190021.1164278-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To support passing a filename as an argument in a macro call that
is to be used in a named type transition, the filename is considered
to be declared when it is used in a named type transition or passed
as an argument with the name flavor. In the struct for a named
type transition, there are fields for a pointer to the filename
string and the filename datum pointer.

When writing out the filename after the resolve phase AST, it is not
possible to determine whether the filename in a named type transition
is an argument name or an actual filename. If it is an actual filename,
then it should be enclosed in double quotes, otherwise, it should
not. Currently, it is always double quoted.

Rework how filenames are declared and handled, so that if the datum
pointer for the name is not NULL, then that is an actual filename
that should be double quoted. Otherwise, the value pointed to by
the string pointer is used and not double quoted.

Move the declaration of the filename to the build phase. Any named
type transition that is not in a macro or is not using a macro
argument is an actual filename, so create a datum and store that in
the struct for the named type transition. Otherwise, store the
string in the named type transition. During the resolve phase,
filename strings can be looked up to find the actual filename that
is being passed into the macro call.

Since the name parameter was never used, just get rid of the
cil_name struct and use datums directly.

Allow either "name" or "string" to be used as the parameter flavor.
Internally, it will be a CIL_DECLARED_STRING and "string" will be
used to write out the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             | 38 ++++++++-------
 libsepol/cil/src/cil_build_ast.c   | 78 +++++++++++++++++++++---------
 libsepol/cil/src/cil_build_ast.h   |  3 +-
 libsepol/cil/src/cil_copy_ast.c    |  1 +
 libsepol/cil/src/cil_flavor.h      |  2 +-
 libsepol/cil/src/cil_fqn.c         |  2 +-
 libsepol/cil/src/cil_internal.h    | 12 ++---
 libsepol/cil/src/cil_policy.c      |  5 +-
 libsepol/cil/src/cil_resolve_ast.c | 64 ++++--------------------
 libsepol/cil/src/cil_write_ast.c   | 30 +++++++-----
 10 files changed, 115 insertions(+), 120 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 46477d0e..d2219f77 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -431,7 +431,7 @@ void cil_db_init(struct cil_db **db)
 	cil_sort_init(&(*db)->fsuse);
 	cil_list_init(&(*db)->userprefixes, CIL_LIST_ITEM);
 	cil_list_init(&(*db)->selinuxusers, CIL_LIST_ITEM);
-	cil_list_init(&(*db)->names, CIL_LIST_ITEM);
+	cil_list_init(&(*db)->declared_strings, CIL_LIST_ITEM);
 
 	cil_type_init(&(*db)->selftype);
 	(*db)->selftype->datum.name = CIL_KEY_SELF;
@@ -465,6 +465,18 @@ void cil_db_init(struct cil_db **db)
 	(*db)->policy_version = POLICYDB_VERSION_MAX;
 }
 
+static void cil_declared_strings_list_destroy(struct cil_list **strings)
+{
+	struct cil_list_item *i;
+
+	cil_list_for_each(i, *strings) {
+		struct cil_symtab_datum *d = i->data;
+		cil_symtab_datum_destroy(d);
+		free(d);
+	}
+	cil_list_destroy(strings, CIL_FALSE);
+}
+
 void cil_db_destroy(struct cil_db **db)
 {
 	if (db == NULL || *db == NULL) {
@@ -492,7 +504,8 @@ void cil_db_destroy(struct cil_db **db)
 	cil_sort_destroy(&(*db)->fsuse);
 	cil_list_destroy(&(*db)->userprefixes, CIL_FALSE);
 	cil_list_destroy(&(*db)->selinuxusers, CIL_FALSE);
-	cil_list_destroy(&(*db)->names, CIL_TRUE);
+
+	cil_declared_strings_list_destroy(&(*db)->declared_strings);
 
 	cil_destroy_type((*db)->selftype);
 	cil_destroy_type((*db)->notselftype);
@@ -966,9 +979,6 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_SIDORDER:
 		cil_destroy_ordered(*data);
 		break;
-	case CIL_NAME:
-		cil_destroy_name(*data);
-		break;
 	case CIL_ROLEALLOW:
 		cil_destroy_roleallow(*data);
 		break;
@@ -1010,6 +1020,8 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_IPADDR:
 		cil_destroy_ipaddr(*data);
 		break;
+	case CIL_DECLARED_STRING:
+		break;
 	case CIL_SIDCONTEXT:
 		cil_destroy_sidcontext(*data);
 		break;
@@ -1151,8 +1163,8 @@ int cil_flavor_to_symtab_index(enum cil_flavor flavor, enum cil_sym_index *sym_i
 	case CIL_SID:
 		*sym_index = CIL_SYM_SIDS;
 		break;
-	case CIL_NAME:
-		*sym_index = CIL_SYM_NAMES;
+	case CIL_DECLARED_STRING:
+		*sym_index = CIL_SYM_STRINGS;
 		break;
 	case CIL_CONTEXT:
 		*sym_index = CIL_SYM_CONTEXTS;
@@ -1185,7 +1197,7 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 	case CIL_NODE:
 		return CIL_KEY_NODE;
 	case CIL_STRING:
-		return "string";
+		return CIL_KEY_STRING;
 	case CIL_DATUM:
 		return "<datum>";
 	case CIL_LIST:
@@ -1324,8 +1336,6 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_SID;
 	case CIL_SIDORDER:
 		return CIL_KEY_SIDORDER;
-	case CIL_NAME:
-		return CIL_KEY_NAME;
 	case CIL_ROLEALLOW:
 		return CIL_KEY_ROLEALLOW;
 	case CIL_AVRULE:
@@ -2430,14 +2440,6 @@ void cil_typepermissive_init(struct cil_typepermissive **typeperm)
 	(*typeperm)->type = NULL;
 }
 
-void cil_name_init(struct cil_name **name)
-{
-	*name = cil_malloc(sizeof(**name));
-
-	cil_symtab_datum_init(&(*name)->datum);
-	(*name)->name_str = NULL;
-}
-
 void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans)
 {
 	*nametypetrans = cil_malloc(sizeof(**nametypetrans));
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index fa7148b0..ec430743 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -83,6 +83,51 @@ exit:
 	return rc;
 }
 
+struct cil_symtab_datum *cil_gen_declared_string(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
+{
+	struct cil_tree_node *parent = ast_node->parent;
+	struct cil_macro *macro = NULL;
+	symtab_t *symtab;
+	struct cil_symtab_datum *datum;
+
+	while (parent) {
+		if (parent->flavor == CIL_MACRO) {
+			/* This condition is only reached in the build phase */
+			macro = parent->data;
+			break;
+		} else if (parent->flavor == CIL_CALL) {
+			/* This condition is only reached in the resolve phase */
+			struct cil_call *call = parent->data;
+			macro = call->macro;
+			break;
+		}
+		parent = parent->parent;
+	}
+
+	if (macro && macro->params) {
+		struct cil_list_item *item;
+		cil_list_for_each(item, macro->params) {
+			struct cil_param *param = item->data;
+			if (param->flavor == CIL_DECLARED_STRING && param->str == key) {
+				return NULL;
+			}
+		}
+	}
+
+	symtab = &((struct cil_root *)db->ast->root->data)->symtab[CIL_SYM_STRINGS];
+	cil_symtab_get_datum(symtab, key, &datum);
+	if (datum != NULL) {
+		return datum;
+	}
+
+	datum = cil_malloc(sizeof(*datum));
+	cil_symtab_datum_init(datum);
+	cil_symtab_insert(symtab, key, datum, ast_node);
+	cil_list_append(db->declared_strings, CIL_DATUM, datum);
+	return datum;
+}
+
+
 static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, enum cil_flavor f_old)
 {
 	if (f_new != f_old) {
@@ -3371,30 +3416,29 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 
 	if (s5) {
 		struct cil_nametypetransition *nametypetrans = NULL;
-
 		cil_nametypetransition_init(&nametypetrans);
 
+		ast_node->data = nametypetrans;
+		ast_node->flavor = CIL_NAMETYPETRANSITION;
+
 		nametypetrans->src_str = s1;
 		nametypetrans->tgt_str = s2;
 		nametypetrans->obj_str = s3;
-		nametypetrans->result_str = s5;
 		nametypetrans->name_str = s4;
-
-		ast_node->data = nametypetrans;
-		ast_node->flavor = CIL_NAMETYPETRANSITION;
+		nametypetrans->name = cil_gen_declared_string(db, s4, ast_node);
+		nametypetrans->result_str = s5;
 	} else {
 		struct cil_type_rule *rule = NULL;
-
 		cil_type_rule_init(&rule);
 
+		ast_node->data = rule;
+		ast_node->flavor = CIL_TYPE_RULE;
+
 		rule->rule_kind = CIL_TYPE_TRANSITION;
 		rule->src_str = s1;
 		rule->tgt_str = s2;
 		rule->obj_str = s3;
 		rule->result_str = s4;
-
-		ast_node->data = rule;
-		ast_node->flavor = CIL_TYPE_RULE;
 	}
 
 	return SEPOL_OK;
@@ -3404,16 +3448,6 @@ exit:
 	return rc;
 }
 
-void cil_destroy_name(struct cil_name *name)
-{
-	if (name == NULL) {
-		return;
-	}
-
-	cil_symtab_datum_destroy(&name->datum);
-	free(name);
-}
-
 void cil_destroy_typetransition(struct cil_nametypetransition *nametypetrans)
 {
 	if (nametypetrans == NULL) {
@@ -5223,9 +5257,9 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		} else if (kind == CIL_KEY_BOOL) {
 			param->flavor = CIL_BOOL;
 		} else if (kind == CIL_KEY_STRING) {
-			param->flavor = CIL_NAME;
+			param->flavor = CIL_DECLARED_STRING;
 		} else if (kind == CIL_KEY_NAME) {
-			param->flavor = CIL_NAME;
+			param->flavor = CIL_DECLARED_STRING;
 		} else {
 			cil_log(CIL_ERR, "The kind %s is not allowed as a parameter\n",kind);
 			cil_destroy_param(param);
@@ -5365,7 +5399,7 @@ void cil_destroy_args(struct cil_args *args)
 	} else if (args->arg != NULL) {
 		struct cil_tree_node *node = args->arg->nodes->head->data;
 		switch (args->flavor) {
-		case CIL_NAME:
+		case CIL_DECLARED_STRING:
 			break;
 		case CIL_CATSET:
 			cil_destroy_catset((struct cil_catset *)args->arg);
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 96af3c91..7fa4299c 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -34,11 +34,13 @@
 
 #include "cil_internal.h"
 #include "cil_flavor.h"
+#include "cil_symtab.h"
 #include "cil_tree.h"
 #include "cil_list.h"
 
 int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t key, struct cil_symtab_datum *datum, struct cil_tree_node *node);
 
+struct cil_symtab_datum *cil_gen_declared_string(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node);
 int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor);
 int cil_parse_to_list(struct cil_tree_node *parse_cl_head, struct cil_list *ast_cl, enum cil_flavor flavor);
 
@@ -146,7 +148,6 @@ int cil_gen_typebounds(struct cil_db *db, struct cil_tree_node *parse_current, s
 int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typepermissive(struct cil_typepermissive *typeperm);
 int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
-void cil_destroy_name(struct cil_name *name);
 void cil_destroy_typetransition(struct cil_nametypetransition *nametypetrans);
 int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_rangetransition(struct cil_rangetransition *rangetrans);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 735628df..b6e13f3c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -714,6 +714,7 @@ int cil_copy_nametypetransition(__attribute__((unused)) struct cil_db *db, void
 	new->tgt_str = orig->tgt_str;
 	new->obj_str = orig->obj_str;
 	new->name_str = orig->name_str;
+	new->name = orig->name;
 	new->result_str = orig->result_str;
 
 
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 89ab7875..155d7c80 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -184,7 +184,7 @@ enum cil_flavor {
 	CIL_LEVEL,
 	CIL_LEVELRANGE,
 	CIL_SID,
-	CIL_NAME,
+	CIL_DECLARED_STRING,
 	CIL_CONTEXT,
 	CIL_IPADDR,
 	CIL_POLICYCAP,
diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
index 46db069b..20e062e5 100644
--- a/libsepol/cil/src/cil_fqn.c
+++ b/libsepol/cil/src/cil_fqn.c
@@ -103,7 +103,7 @@ static int __cil_fqn_qualify_blocks(__attribute__((unused)) hashtab_key_t k, has
 		case CIL_SYM_CONTEXTS:
 		case CIL_SYM_LEVELRANGES:
 		case CIL_SYM_IPADDRS:
-		case CIL_SYM_NAMES:
+		case CIL_SYM_STRINGS:
 		case CIL_SYM_PERMX:
 			/* These do not show up in the kernel policy */
 			break;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 013483c9..6d578cea 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -267,7 +267,7 @@ enum cil_sym_index {
 	CIL_SYM_LEVELRANGES,
 	CIL_SYM_POLICYCAPS,
 	CIL_SYM_IPADDRS,
-	CIL_SYM_NAMES,
+	CIL_SYM_STRINGS,
 	CIL_SYM_PERMX,
 	CIL_SYM_NUM,
 	CIL_SYM_UNKNOWN,
@@ -313,7 +313,7 @@ struct cil_db {
 	struct cil_sort *fsuse;
 	struct cil_list *userprefixes;
 	struct cil_list *selinuxusers;
-	struct cil_list *names;
+	struct cil_list *declared_strings;
 	int num_types_and_attrs;
 	int num_classes;
 	int num_cats;
@@ -564,11 +564,6 @@ struct cil_typepermissive {
 	void *type; /* type or alias */
 };
 
-struct cil_name {
-	struct cil_symtab_datum datum;
-	char *name_str;
-};
-
 struct cil_nametypetransition {
 	char *src_str;
 	void *src; /* type, alias, or attribute */
@@ -577,7 +572,7 @@ struct cil_nametypetransition {
 	char *obj_str;
 	struct cil_class *obj;
 	char *name_str;
-	struct cil_name *name;
+	struct cil_symtab_datum *name;
 	char *result_str;
 	void *result; /* type or alias */
 
@@ -1029,7 +1024,6 @@ void cil_expandtypeattribute_init(struct cil_expandtypeattribute **expandattr);
 void cil_alias_init(struct cil_alias **alias);
 void cil_aliasactual_init(struct cil_aliasactual **aliasactual);
 void cil_typepermissive_init(struct cil_typepermissive **typeperm);
-void cil_name_init(struct cil_name **name);
 void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans);
 void cil_rangetransition_init(struct cil_rangetransition **rangetrans);
 void cil_bool_init(struct cil_bool **cilbool);
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index feb97868..e9a8f75d 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1256,8 +1256,7 @@ static void cil_type_rule_to_policy(FILE *out, struct cil_type_rule *rule)
 
 static void cil_nametypetransition_to_policy(FILE *out, struct cil_nametypetransition *trans)
 {
-	struct cil_symtab_datum *src, *tgt, *res;
-	struct cil_name *name;
+	struct cil_symtab_datum *src, *tgt, *name, *res;
 	struct cil_list *class_list;
 	struct cil_list_item *i1;
 
@@ -1268,7 +1267,7 @@ static void cil_nametypetransition_to_policy(FILE *out, struct cil_nametypetrans
 
 	class_list = cil_expand_class(trans->obj);
 	cil_list_for_each(i1, class_list) {
-		fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn);
+		fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->fqn);
 	}
 	cil_list_destroy(&class_list, CIL_FALSE);
 }
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 0172bbdd..bdff044a 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -68,49 +68,6 @@ struct cil_args_resolve {
 	struct cil_list *abstract_blocks;
 };
 
-static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
-{
-	/* Currently only used for typetransition file names.
-	   But could be used for any string that is passed as a parameter.
-	*/
-	struct cil_tree_node *parent = ast_node->parent;
-	struct cil_macro *macro = NULL;
-	struct cil_name *name;
-	symtab_t *symtab;
-	enum cil_sym_index sym_index;
-	struct cil_symtab_datum *datum = NULL;
-
-	if (parent->flavor == CIL_CALL) {
-		struct cil_call *call = parent->data;
-		macro = call->macro;	
-	} else if (parent->flavor == CIL_MACRO) {
-		macro = parent->data;
-	}
-	if (macro != NULL && macro->params != NULL) {
-		struct cil_list_item *item;
-		cil_list_for_each(item, macro->params) {
-			struct cil_param *param = item->data;
-			if (param->flavor == CIL_NAME && param->str == key) {
-				return NULL;
-			}
-		}
-	}
-
-	cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
-	symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		return (struct cil_name *)datum;
-	}
-
-	cil_name_init(&name);
-	cil_symtab_insert(symtab, key, (struct cil_symtab_datum *)name, ast_node);
-	cil_list_append(db->names, CIL_NAME, name);
-
-	return name;
-}
-
 static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab, struct cil_list *perm_strs, struct cil_list **perm_datums, enum cil_flavor class_flavor)
 {
 	int rc = SEPOL_ERR;
@@ -691,13 +648,12 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, struct cil_db
 	}
 	nametypetrans->obj = (struct cil_class*)obj_datum;
 
-	nametypetrans->name = __cil_insert_name(db, nametypetrans->name_str, current);
-	if (nametypetrans->name == NULL) {
-		rc = cil_resolve_name(current, nametypetrans->name_str, CIL_SYM_NAMES, db, &name_datum);
+	if (!nametypetrans->name) {
+		rc = cil_resolve_name(current, nametypetrans->name_str, CIL_SYM_STRINGS, db, &name_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-		nametypetrans->name = (struct cil_name *)name_datum;
+		nametypetrans->name = name_datum;
 	}
 
 	rc = cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYPES, db, &result_datum);
@@ -2689,17 +2645,17 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
 		cil_args_init(&arg);
 
 		switch (flavor) {
-		case CIL_NAME: {
-			struct cil_name *name;
+		case CIL_DECLARED_STRING: {
+			struct cil_symtab_datum *string;
 			if (arg_node->data == NULL) {
 				cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
 				cil_destroy_args(arg);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-			name = __cil_insert_name(db, arg_node->data, call_node);
-			if (name != NULL) {
-				arg->arg = (struct cil_symtab_datum *)name;
+			string = cil_gen_declared_string(db, arg_node->data, call_node);
+			if (string) {
+				arg->arg = string;
 			} else {
 				arg->arg_str = arg_node->data;
 			}
@@ -3017,11 +2973,11 @@ static int cil_resolve_call_args(struct cil_tree_node *current, struct cil_db *d
 		}
 
 		switch (arg->flavor) {
-		case CIL_NAME:
+		case CIL_DECLARED_STRING:
 			if (arg->arg != NULL) {
 				continue; /* No need to resolve */
 			} else {
-				sym_index = CIL_SYM_NAMES;
+				sym_index = CIL_SYM_STRINGS;
 			}
 			break;
 		case CIL_LEVEL:
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 59122a17..d867fa8b 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -43,7 +43,7 @@
 
 static inline const char *datum_or_str(struct cil_symtab_datum *datum, const char *str)
 {
-	return datum ? datum->fqn : str;
+	return datum && datum->fqn ? datum->fqn : str;
 }
 
 static inline const char *datum_to_str(struct cil_symtab_datum *datum)
@@ -78,7 +78,7 @@ static void write_expr(FILE *out, struct cil_list *expr)
 		case CIL_BOOL:
 		case CIL_CLASS:
 		case CIL_MAP_CLASS:
-		case CIL_NAME:
+		case CIL_DECLARED_STRING:
 			fprintf(out, "%s", datum_to_str(curr->data));
 			break;
 		case CIL_OP: {
@@ -413,9 +413,16 @@ static void write_call_args(FILE *out, struct cil_list *args)
 		case CIL_CAT:
 		case CIL_BOOL:
 		case CIL_CLASS:
-		case CIL_MAP_CLASS:
-		case CIL_NAME: {
-			fprintf(out, "%s", datum_or_str(arg->arg, arg->arg_str));
+		case CIL_MAP_CLASS: {
+			fprintf(out, "%s", datum_or_str(DATUM(arg->arg), arg->arg_str));
+			break;
+		}
+		case CIL_DECLARED_STRING: {
+			if (arg->arg) {
+				fprintf(out, "\"%s\" ", DATUM(arg->arg)->fqn);
+			} else {
+				fprintf(out, "%s ", arg->arg_str);
+			}
 			break;
 		}
 		case CIL_CATSET: {
@@ -467,7 +474,7 @@ static void write_call_args(FILE *out, struct cil_list *args)
 			break;
 		}
 		default:
-			fprintf(out, "<?ARG:%s>", datum_or_str(arg->arg, arg->arg_str));
+			fprintf(out, "<?ARG:%s>", datum_or_str(DATUM(arg->arg), arg->arg_str));
 			break;
 		}
 	}
@@ -533,12 +540,9 @@ static const char *macro_param_flavor_to_string(enum cil_flavor flavor)
 	case CIL_BOOL:
 		str = CIL_KEY_BOOL;
 		break;
-	case CIL_STRING:
+	case CIL_DECLARED_STRING:
 		str = CIL_KEY_STRING;
 		break;
-	case CIL_NAME:
-		str = CIL_KEY_NAME;
-		break;
 	default:
 		str = "<?FLAVOR>";
 		break;
@@ -1193,7 +1197,11 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->src), rule->src_str));
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
-		fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), rule->name_str));
+		if (rule->name) {
+			fprintf(out, "\"%s\" ", DATUM(rule->name)->fqn);
+		} else {
+			fprintf(out, "%s ", rule->name_str);
+		}
 		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str));
 		fprintf(out, ")\n");
 		break;
-- 
2.41.0

