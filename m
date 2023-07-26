Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE4C001B0
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjGZO0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjGZOZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:25:59 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089051B0
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:57 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so4960456d6.0
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381555; x=1690986355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imYa12CnkHZVYmYNE+jrAJtRsID9LYwGGCOrXWRV5DY=;
        b=nC1WEzW57FoUNUHpPCzpi4zAQmPQfUHrp/Rp+YtomKJSjEJ3poR7oUwmogrvevhrQ/
         MVKs7KmCCXD+hWHwC74MGb9fm8kxk3/+sGJ+tQCietMuLZNeOqXlMcKh3EsoXrnIyJnM
         Ti79+KqbM1SnmaDv/H0SV5VQV2ygD0SAEa9kAZJc84jGjgTO8HdKwtJV4ot1k6qVxMLn
         kTOlTHT5yY9sSJVoD8HSBhEJ1O9GqAbDW3nHIj4zuu2O01frrIczJmci4NWlLQRgTtO0
         2Hvo+Nfap/akiHhj+HTzLA+Y6zw1QANyEZmXFL+qrScEHn9+D57z8EvobLy7a5nhIWdf
         H4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381555; x=1690986355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imYa12CnkHZVYmYNE+jrAJtRsID9LYwGGCOrXWRV5DY=;
        b=Lhz5oymXlggx97I8KG1dMhCSG0j27wxwAWMjM55gqaD4Ob6MLmSPyRGDAMdCk8Dc+q
         kNjvdLwMFdHMit5ZUortt5XXnfAeYJivqXcotIJMsvV8QlWMdh1BuC37LQS1J84wATOy
         fwKTSLLMG8LOzM505gQVx6jcDHt5PTX9ffuSYlVfCKHjPxNN9vytV50w4dgvzc+ALJrb
         h+rJY/ART8zFpyeuz0w37gsHAgl62gKELcg6uUQ5Eat+bO6qwNWA2zwh5J06xfjbPXtq
         tD/oV6lQrb/tW0Ix2IDEPUTMwKLNphPwGfsghM/xqPbcbe1U0g2ktMd7LELNTpOhbz+0
         XCDg==
X-Gm-Message-State: ABy/qLaPtk4diVX8IOOxtznT66Nen3kjkYqNPqmSptKQEt9ldMrTFtES
        ivd7Y4NcFtqPg6X4p+zmSl6GWcUIecniug==
X-Google-Smtp-Source: APBJJlFPe3or11Kd164oZSBaeTRAOBybnc60sp91ed5rnDbU/DK96v6QrM3343C12EQ5ezlMK1Md2Q==
X-Received: by 2002:a05:6214:2262:b0:63c:7b04:6dfd with SMTP id gs2-20020a056214226200b0063c7b046dfdmr5974164qvb.30.1690381555423;
        Wed, 26 Jul 2023 07:25:55 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:54 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/8] Revert "checkpolicy,libsepol: add prefix/suffix support to module policy"
Date:   Wed, 26 Jul 2023 10:25:43 -0400
Message-ID: <20230726142549.94685-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit c39ebd07acd030a59a432797ed4da7733266a305.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c                | 13 +++----
 checkpolicy/policy_define.h                |  2 +-
 checkpolicy/policy_parse.y                 | 13 +++----
 checkpolicy/policy_scan.l                  |  4 ---
 checkpolicy/test/dismod.c                  | 14 --------
 checkpolicy/test/dispol.c                  |  2 +-
 libsepol/cil/src/cil_binary.c              |  4 +--
 libsepol/include/sepol/policydb/avtab.h    |  1 -
 libsepol/include/sepol/policydb/policydb.h | 13 +++----
 libsepol/src/avtab.c                       | 30 ++++------------
 libsepol/src/expand.c                      |  6 +---
 libsepol/src/kernel_to_common.h            |  2 +-
 libsepol/src/link.c                        |  1 -
 libsepol/src/module_to_cil.c               | 25 +++-----------
 libsepol/src/policydb.c                    | 23 +------------
 libsepol/src/write.c                       | 40 ++++++----------------
 16 files changed, 43 insertions(+), 150 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8421b253..25dbf25d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1601,8 +1601,7 @@ static int set_types(type_set_t * set, char *id, int *add, char starallowed)
 	return -1;
 }
 
-static int define_compute_type_helper(int which, avrule_t ** rule,
-				      int has_filename, uint8_t name_match)
+static int define_compute_type_helper(int which, avrule_t ** rule, int has_filename)
 {
 	char *id;
 	type_datum_t *datum;
@@ -1677,7 +1676,6 @@ static int define_compute_type_helper(int which, avrule_t ** rule,
 			goto bad;
 		}
 	}
-	avrule->name_match = name_match;
 
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
 		perm = malloc(sizeof(class_perm_node_t));
@@ -1702,7 +1700,7 @@ static int define_compute_type_helper(int which, avrule_t ** rule,
 	return -1;
 }
 
-int define_compute_type(int which, int has_filename, uint8_t name_match)
+int define_compute_type(int which, int has_filename)
 {
 	char *id;
 	avrule_t *avrule;
@@ -1723,8 +1721,7 @@ int define_compute_type(int which, int has_filename, uint8_t name_match)
 		return 0;
 	}
 
-	if (define_compute_type_helper(which, &avrule, has_filename,
-				       name_match))
+	if (define_compute_type_helper(which, &avrule, has_filename))
 		return -1;
 
 	append_avrule(avrule);
@@ -1748,8 +1745,7 @@ avrule_t *define_cond_compute_type(int which)
 		return (avrule_t *) 1;
 	}
 
-	if (define_compute_type_helper(which, &avrule, 0,
-				       NAME_TRANS_MATCH_EXACT))
+	if (define_compute_type_helper(which, &avrule, 0))
 		return COND_ERR;
 
 	return avrule;
@@ -2398,7 +2394,6 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 			return -1;
 		}
 	}
-	dest->name_match = src->name_match;
 	dest->line = src->line;
 	dest->source_filename = strdup(source_file);
 	if (!dest->source_filename) {
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index c1314871..5d0f70e4 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -28,7 +28,7 @@ int define_default_role(int which);
 int define_default_type(int which);
 int define_default_range(int which);
 int define_common_perms(void);
-int define_compute_type(int which, int has_filename, uint8_t name_match);
+int define_compute_type(int which, int has_filename);
 int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_list );
 int define_constraint(constraint_expr_t *expr);
 int define_dominance(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 6b6890a3..2a14fc1e 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -108,7 +108,6 @@ typedef int (* require_func_t)(int pass);
 %token IF
 %token ELSE
 %token TYPE_TRANSITION
-%token PREFIX SUFFIX
 %token TYPE_MEMBER
 %token TYPE_CHANGE
 %token ROLE_TRANSITION
@@ -452,17 +451,13 @@ cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier filename ';'
-			{if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_EXACT)) return -1;}
-            | TYPE_TRANSITION names names ':' names identifier filename PREFIX ';'
-            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_PREFIX)) return -1;}
-            | TYPE_TRANSITION names names ':' names identifier filename SUFFIX ';'
-            {if (define_compute_type(AVRULE_TRANSITION, 1, NAME_TRANS_MATCH_SUFFIX)) return -1;}
+			{if (define_compute_type(AVRULE_TRANSITION, 1)) return -1; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_TRANSITION, 0, NAME_TRANS_MATCH_EXACT)) return -1;}
+                        {if (define_compute_type(AVRULE_TRANSITION, 0)) return -1;}
                         | TYPE_MEMBER names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_MEMBER, 0, NAME_TRANS_MATCH_EXACT)) return -1;}
+                        {if (define_compute_type(AVRULE_MEMBER, 0)) return -1;}
                         | TYPE_CHANGE names names ':' names identifier ';'
-                        {if (define_compute_type(AVRULE_CHANGE, 0, NAME_TRANS_MATCH_EXACT)) return -1;}
+                        {if (define_compute_type(AVRULE_CHANGE, 0)) return -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
 			{ if (define_range_trans(0)) return -1; }
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 9ffac353..2c025b61 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -123,10 +123,6 @@ EXPANDATTRIBUTE |
 expandattribute                 { return(EXPANDATTRIBUTE); }
 TYPE_TRANSITION |
 type_transition			{ return(TYPE_TRANSITION); }
-PREFIX |
-prefix				{ return(PREFIX); }
-SUFFIX |
-suffix				{ return(SUFFIX); }
 TYPE_MEMBER |
 type_member			{ return(TYPE_MEMBER); }
 TYPE_CHANGE |
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 011191c3..8bab207c 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -345,20 +345,6 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
 		if (avrule->object_name)
 			fprintf(fp, " \"%s\"", avrule->object_name);
-		switch (avrule->name_match) {
-		case NAME_TRANS_MATCH_EXACT:
-			/* do nothing */
-			break;
-		case NAME_TRANS_MATCH_PREFIX:
-			fprintf(fp, " PREFIX");
-			break;
-		case NAME_TRANS_MATCH_SUFFIX:
-			fprintf(fp, " SUFFIX");
-			break;
-		default:
-			fprintf(fp, "     ERROR: no valid name match type specified\n");
-			return -1;
-		}
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		avtab_extended_perms_t xperms;
 		int i;
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index b5a41c1f..776bf54d 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -129,7 +129,7 @@ typedef struct {
 	avtab_key_t *key;
 	policydb_t *p;
 	FILE *fp;
-	uint8_t match;
+	name_trans_match_t match;
 } render_name_trans_args_t;
 
 static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ffa44be7..996bad70 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1211,8 +1211,7 @@ static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
 		avt_key.target_type = sepol_tgt->s.value;
 		avt_key.target_class = sepol_obj->s.value;
 		rc = avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
-			sepol_result->s.value, name, NAME_TRANS_MATCH_EXACT,
-			&otype);
+			sepol_result->s.value, name, &otype);
 		if (rc != SEPOL_OK) {
 			if (rc == SEPOL_EEXIST) {
 				if (sepol_result->s.value!= otype) {
@@ -4652,7 +4651,6 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
 	__cil_init_sepol_type_set(&avrule->ttypes);
 	avrule->perms = NULL;
 	avrule->object_name = NULL;
-	avrule->name_match = NAME_TRANS_MATCH_EXACT;
 	avrule->line = node->line;
 
 	avrule->source_filename = NULL;
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 7d892879..870fb08a 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -156,7 +156,6 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 
 extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 				       uint32_t otype, const char *name,
-				       uint8_t name_match,
 				       uint32_t *present_otype);
 extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a);
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 48b7b8bb..a2df4a62 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -252,6 +252,12 @@ typedef struct av_extended_perms {
 	uint32_t perms[EXTENDED_PERMS_LEN];
 } av_extended_perms_t;
 
+typedef enum name_trans_match {
+	NAME_TRANS_MATCH_EXACT,
+	NAME_TRANS_MATCH_PREFIX,
+	NAME_TRANS_MATCH_SUFFIX,
+} name_trans_match_t;
+
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they are
  * here because of the need to include neverallow and dontaudit messages */
@@ -279,10 +285,6 @@ typedef struct avrule {
 	type_set_t ttypes;
 	class_perm_node_t *perms;
 	char *object_name;	/* optional object name */
-#define NAME_TRANS_MATCH_EXACT 0
-#define NAME_TRANS_MATCH_PREFIX 1
-#define NAME_TRANS_MATCH_SUFFIX 2
-	uint8_t name_match;
 	av_extended_perms_t *xperms;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
@@ -755,10 +757,9 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
 #define MOD_POLICYDB_VERSION_AVRULE_FTRANS	22
-#define MOD_POLICYDB_VERSION_PREFIX_SUFFIX	23 /* preffix/suffix support for filename transitions */
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PREFIX_SUFFIX
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_AVRULE_FTRANS
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 99fdaa87..90cfb90b 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -771,7 +771,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 
 int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 				uint32_t otype, const char *name,
-				uint8_t name_match, uint32_t *present_otype)
+				uint32_t *present_otype)
 {
 	int rc = SEPOL_ENOMEM;
 	avtab_trans_t new_trans = {0};
@@ -780,7 +780,6 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 	avtab_ptr_t node;
 	char *name_key = NULL;
 	uint32_t *otype_datum = NULL;
-	symtab_t *target_symtab;
 
 	datum = avtab_search(a, key);
 	if (!datum) {
@@ -794,22 +793,8 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 		datum = &node->datum;
 	}
 
-	switch (name_match) {
-	case NAME_TRANS_MATCH_EXACT:
-		target_symtab = &datum->trans->name_trans;
-		break;
-	case NAME_TRANS_MATCH_PREFIX:
-		target_symtab = &datum->trans->prefix_trans;
-		break;
-	case NAME_TRANS_MATCH_SUFFIX:
-		target_symtab = &datum->trans->suffix_trans;
-		break;
-	default:
-		return SEPOL_ERR;
-	}
-
-	if (!target_symtab->table) {
-		rc = symtab_init(target_symtab, 1 << 8);
+	if (!datum->trans->name_trans.table) {
+		rc = symtab_init(&datum->trans->name_trans, 1 << 8);
 		if (rc < 0)
 			return rc;
 	}
@@ -825,7 +810,8 @@ int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 		goto bad;
 	*otype_datum = otype;
 
-	rc = hashtab_insert(target_symtab->table, name_key, otype_datum);
+	rc = hashtab_insert(datum->trans->name_trans.table, name_key,
+			    otype_datum);
 	if (rc < 0)
 		goto bad;
 
@@ -870,8 +856,7 @@ static int filename_trans_read_one(avtab_t *a, void *fp)
 	key.target_class = le32_to_cpu(buf[2]);
 	otype = le32_to_cpu(buf[3]);
 
-	rc = avtab_insert_filename_trans(a, &key, otype, name,
-					 NAME_TRANS_MATCH_EXACT, NULL);
+	rc = avtab_insert_filename_trans(a, &key, otype, name, NULL);
 	if (rc)
 		goto err;
 
@@ -924,8 +909,7 @@ static int filename_trans_comp_read_one(avtab_t *a, void *fp)
 			key.source_type = bit + 1;
 
 			rc = avtab_insert_filename_trans(a, &key, otype, name,
-							 NAME_TRANS_MATCH_EXACT,
-							 NULL);
+				NULL);
 			if (rc < 0)
 				goto err_ebitmap;
 		}
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7a011508..a4c92f4f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1620,8 +1620,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 				uint32_t specified, cond_av_list_t ** cond,
 				cond_av_list_t ** other, uint32_t stype,
 				uint32_t ttype, class_perm_node_t * perms,
-				char *object_name, uint8_t name_match,
-				avtab_t * avtab, int enabled)
+				char *object_name, avtab_t * avtab, int enabled)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
@@ -1653,7 +1652,6 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			int rc = avtab_insert_filename_trans(avtab, &avkey,
 							     remapped_data,
 							     object_name,
-							     name_match,
 							     &oldtype);
 			if (rc == SEPOL_EEXIST) {
 				ERR(handle, "conflicting filename transition %s %s:%s \"%s\": %s vs %s",
@@ -1887,7 +1885,6 @@ static int expand_rule_helper(sepol_handle_t * handle,
 							      source_rule->specified, cond,
 							      other, i, i, source_rule->perms,
 							      source_rule->object_name,
-							      source_rule->name_match,
 							      dest_avtab, enabled);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
@@ -1905,7 +1902,6 @@ static int expand_rule_helper(sepol_handle_t * handle,
 							      source_rule->specified, cond,
 							      other, i, j, source_rule->perms,
 							      source_rule->object_name,
-							      source_rule->name_match,
 							      dest_avtab, enabled);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 353eb78f..07869e3d 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -90,7 +90,7 @@ typedef struct {
 	const char *src;
 	const char *tgt;
 	const char *class;
-	uint8_t match;
+	name_trans_match_t match;
 } name_trans_to_strs_args_t;
 
 void sepol_indent(FILE *out, int indent);
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 332d62b2..88b23594 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1254,7 +1254,6 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 			if (!new_rule->object_name)
 				goto cleanup;
 		}
-		new_rule->name_match = cur->name_match;
 
 		cur_perm = cur->perms;
 		tail_perm = NULL;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3fbb4af5..ca96bb67 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -547,13 +547,12 @@ static int semantic_level_to_cil(struct policydb *pdb, int sens_offset, struct m
 	return 0;
 }
 
-static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const char *object_name, uint8_t name_match, const struct class_perm_node *classperms)
+static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const char *object_name, const struct class_perm_node *classperms)
 {
 	int rc = -1;
 	const char *rule;
 	const struct class_perm_node *classperm;
 	char *perms;
-	const char *match_str = "";
 
 	switch (type) {
 	case AVRULE_ALLOWED:
@@ -599,24 +598,10 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
 		} else if (object_name) {
-			switch (name_match) {
-			case NAME_TRANS_MATCH_EXACT:
-				match_str = "";
-				break;
-			case NAME_TRANS_MATCH_PREFIX:
-				match_str = " prefix";
-				break;
-			case NAME_TRANS_MATCH_SUFFIX:
-				match_str = " suffix";
-				break;
-			default:
-				ERR(NULL, "Unknown name match type: %" PRIu8,
-						name_match);
-			}
-			cil_println(indent, "(%s %s %s %s \"%s\"%s %s)",
+			cil_println(indent, "(%s %s %s %s \"%s\" %s)",
 					rule, src, tgt,
 					pdb->p_class_val_to_name[classperm->tclass - 1],
-					object_name, match_str,
+					object_name,
 					pdb->p_type_val_to_name[classperm->data - 1]);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
@@ -1220,7 +1205,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms, avrule->xperms);
 				} else {
-					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->object_name, avrule->name_match, avrule->perms);
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->object_name, avrule->perms);
 				}
 				if (rc != 0) {
 					goto exit;
@@ -1231,7 +1216,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (avrule->specified & AVRULE_XPERMS) {
 					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms, avrule->xperms);
 				} else {
-					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->object_name, avrule->name_match, avrule->perms);
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->object_name, avrule->perms);
 				}
 				if (rc != 0) {
 					goto exit;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 552eb77a..f1f6cec6 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -355,13 +355,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBENDPORT + 1,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -495,13 +488,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = 0,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 };
 
 #if 0
@@ -3185,7 +3171,6 @@ common_read, class_read, role_read, type_read, user_read,
 static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
 {
 	unsigned int i;
-	uint8_t buf8;
 	uint32_t buf[2], len;
 	class_perm_node_t *cur, *tail = NULL;
 	avrule_t *avrule;
@@ -3249,15 +3234,10 @@ static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
 			if (rc < 0)
 				goto bad;
 		}
-		if (p->policyvers >= MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
-			rc = next_entry(&buf8, fp, sizeof(uint8_t));
-			if (rc < 0)
-				goto bad;
-			avrule->name_match = buf8;
-		}
 	}
 
 	if (avrule->specified & AVRULE_XPERMS) {
+		uint8_t buf8;
 		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
 
@@ -3566,7 +3546,6 @@ static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
 		rc = str_read(&cur->object_name, fp, len);
 		if (rc)
 			return -1;
-		cur->name_match = NAME_TRANS_MATCH_EXACT;
 
 		if (type_set_read(&cur->stypes, fp))
 			return -1;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f0ed9e33..df47197c 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2071,7 +2071,6 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 			struct policy_file *fp)
 {
 	size_t items, items2;
-	uint8_t buf8;
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
@@ -2079,11 +2078,6 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 	if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    avrule->specified & AVRULE_TRANSITION && avrule->object_name)
 		return POLICYDB_SUCCESS;
-	/* skip prefix/suffix name transition if writing older version */
-	if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
-	    avrule->specified & AVRULE_TRANSITION &&
-	    avrule->object_name && avrule->name_match != NAME_TRANS_MATCH_EXACT)
-		return POLICYDB_SUCCESS;
 
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
 	    (avrule->specified & AVRULE_TYPE) &&
@@ -2142,17 +2136,12 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 			if (items != len)
 				return POLICYDB_ERROR;
 		}
-		if (p->policyvers >= MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
-			buf8 = avrule->name_match;
-			items = put_entry(&buf8, sizeof(uint8_t), 1, fp);
-			if (items != 1)
-				return POLICYDB_ERROR;
-		}
 	}
 
 	if (avrule->specified & AVRULE_XPERMS) {
 		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
+		uint8_t buf8;
 		unsigned int i;
 
 		if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
@@ -2197,17 +2186,12 @@ static int avrule_write_list(policydb_t *p, avrule_t * avrules,
 
 	avrule = avrules;
 	len = 0;
-	for (avrule = avrules; avrule; avrule = avrule->next) {
-		if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
-		    (avrule->specified & AVTAB_TRANSITION) &&
-		    avrule->object_name)
-			continue;
-		if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
-		    (avrule->specified & AVTAB_TRANSITION) &&
-		    avrule->object_name &&
-		    avrule->name_match != NAME_TRANS_MATCH_EXACT)
-			continue;
-		len++;
+	while (avrule) {
+		if (p->policyvers >= MOD_POLICYDB_VERSION_AVRULE_FTRANS ||
+		    !(avrule->specified & AVRULE_TRANSITION &&
+		      avrule->object_name))
+			len++;
+		avrule = avrule->next;
 	}
 
 	buf[0] = cpu_to_le32(len);
@@ -2315,8 +2299,7 @@ static int filename_trans_rule_write(policydb_t *p, avrule_t *rules,
 	class_perm_node_t *perm;
 
 	for (rule = rules; rule; rule = rule->next) {
-		if (rule->specified & AVRULE_TRANSITION && rule->object_name &&
-		    rule->name_match == NAME_TRANS_MATCH_EXACT) {
+		if (rule->specified & AVRULE_TRANSITION && rule->object_name) {
 			for (perm = rule->perms; perm; perm = perm->next) {
 				nel++;
 			}
@@ -2329,9 +2312,7 @@ static int filename_trans_rule_write(policydb_t *p, avrule_t *rules,
 		return POLICYDB_ERROR;
 
 	for (rule = rules; rule; rule = rule->next) {
-		if (!(rule->specified & AVRULE_TRANSITION &&
-		      rule->object_name &&
-		      rule->name_match == NAME_TRANS_MATCH_EXACT))
+		if (!(rule->specified & AVRULE_TRANSITION && rule->object_name))
 			continue;
 		len = strlen(rule->object_name);
 		for (perm = rule->perms; perm; perm = perm->next) {
@@ -2770,8 +2751,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	if (p->policy_type == POLICY_KERN) {
 		if (avtab_write(p, &p->te_avtab, fp))
 			return POLICYDB_ERROR;
-		if (p->policyvers < POLICYDB_VERSION_PREFIX_SUFFIX &&
-		    avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
+		if (avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
 			WARN(fp->handle,
 			     "Discarding filename prefix/suffix type transition rules");
 		}
-- 
2.41.0

