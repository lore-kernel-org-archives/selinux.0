Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91966C001DC
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjGZOZ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGZOZ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:25:57 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF04188
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63ce8bea776so26374526d6.0
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381554; x=1690986354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEURyXjei7Di8hCp5M5j2fKeQCacdFeOAtWC8quZg2E=;
        b=aFYU6A2wwHNTfv89DauZsoApHp8g3P7cDZi6yji81kSmW3j0R69TRc7KdXktGCyjT8
         64XCQ0YNZyI+RfpBYJN6GvAjLnsXnjcWDtxPD76mj1HpxKlQyi2mcbUlXJhr8PvUYnW8
         yQnnZSfNmkPK3FLGc6dWU1NXx7Y2CJRtjxNx42NFwDWOhXbjYO+m0U8xaBIRGikQLhZo
         C5OmDwOWIG2JhUp2Hqj04P0EXeZ0W/CRMg7B0RgT/Rz+igiKnTkQHgGCXkqPx1tcsqAo
         doW7P9Fve3oZq6aoqfpogUnXaFz+fl+W4fMrNt2YHXd9g2/o+atp6vgw/D9obkkxX43h
         znCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381554; x=1690986354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEURyXjei7Di8hCp5M5j2fKeQCacdFeOAtWC8quZg2E=;
        b=ZDNmNntR2W27fBA4AkhQtuVcpJTCRjVZt6+Reg5VHLpfko9zwdgZeoYSkEgu1cAhAi
         cwPeRhy9+Dmgjdx1IVsIgjAR4rbOFnD9PwYIHMpDlooxZfASoXiJVFLxQwNLj/4eYE99
         kkb4WZNVkLhsFrIJyU5bYmnPpCcdwpEeZj1m5O/YSSs2t9zvU6Pyf5TVEmKGCQVBMrGw
         zigsIrVmIAPUab2bA6psEEo9bYjs3duvUjuUpc2VIkUXGwucQ8xMLStv3Iw0SXtPvDw5
         mAtdaELDCaJGtHxViE3RzmjWvH2V+IBUfKd1Ucq+dyet8hM5vAFFrXjE+amGHIuzeinJ
         7SdQ==
X-Gm-Message-State: ABy/qLYAMjsyRk6wFTjqMwGuH7NsQqYzjf67Bdy2heYm6KtjspZCJqAW
        aPVpeZ8vqQEzBtcGitu6TGsB60YhHOeJ8A==
X-Google-Smtp-Source: APBJJlE4GQkvsUWMmVz1h+QJxNeQ6PI0DbXUbzXJYrPWrEC1G5OUAkkmb+1BdFVqVPo+/kvLKp5wkw==
X-Received: by 2002:a05:6214:2b52:b0:63c:b107:e8a0 with SMTP id jy18-20020a0562142b5200b0063cb107e8a0mr2075914qvb.56.1690381554439;
        Wed, 26 Jul 2023 07:25:54 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/8] Revert "libsepol/cil: add support for prefix/suffix filename transtions to CIL"
Date:   Wed, 26 Jul 2023 10:25:42 -0400
Message-ID: <20230726142549.94685-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 0c50de03cd38ef80dc6c5df9acef027f4b5c9526.
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             |  6 ------
 libsepol/cil/src/cil_binary.c      |  8 ++++----
 libsepol/cil/src/cil_build_ast.c   | 26 +++++---------------------
 libsepol/cil/src/cil_copy_ast.c    |  1 -
 libsepol/cil/src/cil_internal.h    |  4 ----
 libsepol/cil/src/cil_policy.c      | 17 +----------------
 libsepol/cil/src/cil_resolve_ast.c | 10 ----------
 libsepol/cil/src/cil_write_ast.c   |  2 --
 8 files changed, 10 insertions(+), 64 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index fa693020..38edcf8e 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -95,8 +95,6 @@ char *CIL_KEY_TUNABLEIF;
 char *CIL_KEY_ALLOW;
 char *CIL_KEY_DONTAUDIT;
 char *CIL_KEY_TYPETRANSITION;
-char *CIL_KEY_PREFIX;
-char *CIL_KEY_SUFFIX;
 char *CIL_KEY_TYPECHANGE;
 char *CIL_KEY_CALL;
 char *CIL_KEY_TUNABLE;
@@ -266,8 +264,6 @@ static void cil_init_keys(void)
 	CIL_KEY_ALLOW = cil_strpool_add("allow");
 	CIL_KEY_DONTAUDIT = cil_strpool_add("dontaudit");
 	CIL_KEY_TYPETRANSITION = cil_strpool_add("typetransition");
-	CIL_KEY_PREFIX = cil_strpool_add("prefix");
-	CIL_KEY_SUFFIX = cil_strpool_add("suffix");
 	CIL_KEY_TYPECHANGE = cil_strpool_add("typechange");
 	CIL_KEY_CALL = cil_strpool_add("call");
 	CIL_KEY_TUNABLE = cil_strpool_add("tunable");
@@ -2391,8 +2387,6 @@ void cil_nametypetransition_init(struct cil_nametypetransition **nametypetrans)
 	(*nametypetrans)->obj = NULL;
 	(*nametypetrans)->name_str = NULL;
 	(*nametypetrans)->name = NULL;
-	(*nametypetrans)->name_match_str = NULL;
-	(*nametypetrans)->name_match = NAME_TRANS_MATCH_EXACT;
 	(*nametypetrans)->result_str = NULL;
 	(*nametypetrans)->result = NULL;
 }
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ea0cef32..ffa44be7 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1193,7 +1193,7 @@ static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
 						type_datum_t *sepol_src,
 						type_datum_t *sepol_tgt,
 						struct cil_list *class_list,
-						char *name, uint8_t name_match,
+						char *name,
 						type_datum_t *sepol_result)
 {
 	int rc;
@@ -1211,7 +1211,7 @@ static int __cil_typetransition_to_avtab_helper(policydb_t *pdb,
 		avt_key.target_type = sepol_tgt->s.value;
 		avt_key.target_class = sepol_obj->s.value;
 		rc = avtab_insert_filename_trans(&pdb->te_avtab, &avt_key,
-			sepol_result->s.value, name, name_match,
+			sepol_result->s.value, name, NAME_TRANS_MATCH_EXACT,
 			&otype);
 		if (rc != SEPOL_OK) {
 			if (rc == SEPOL_EEXIST) {
@@ -1280,7 +1280,7 @@ static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *d
 
 			rc = __cil_typetransition_to_avtab_helper(
 				pdb, sepol_src, sepol_src, class_list,
-				name, typetrans->name_match, sepol_result
+				name, sepol_result
 			);
 			if (rc != SEPOL_OK) goto exit;
 		}
@@ -1298,7 +1298,7 @@ static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *d
 
 				rc = __cil_typetransition_to_avtab_helper(
 					pdb, sepol_src, sepol_tgt, class_list,
-					name, typetrans->name_match, sepol_result
+					name, sepol_result
 				);
 				if (rc != SEPOL_OK) goto exit;
 			}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 67bbdcab..4177c9f6 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3334,11 +3334,10 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_END,
-		CIL_SYN_STRING | CIL_SYN_END,
-		CIL_SYN_END,
+		CIL_SYN_END
 	};
 	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
-	char *s1, *s2, *s3, *s4, *s5, *s6;
+	char *s1, *s2, *s3, *s4, *s5;
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL ) {
 		goto exit;
@@ -3354,22 +3353,12 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 	s3 = parse_current->next->next->next->data;
 	s4 = parse_current->next->next->next->next->data;
 	s5 = NULL;
-	s6 = NULL;
 
 	if (parse_current->next->next->next->next->next) {
 		if (s4 == CIL_KEY_STAR) {
-			if (parse_current->next->next->next->next->next->next) {
-				s4 = parse_current->next->next->next->next->next->next->data;
-			} else {
-				s4 = parse_current->next->next->next->next->next->data;
-			}
+			s4 = parse_current->next->next->next->next->next->data;
 		} else {
-			if (parse_current->next->next->next->next->next->next) {
-				s5 = parse_current->next->next->next->next->next->data;
-				s6 = parse_current->next->next->next->next->next->next->data;
-			} else {
-				s5 = parse_current->next->next->next->next->next->data;
-			}
+			s5 = parse_current->next->next->next->next->next->data;
 		}
 	}
 
@@ -3381,13 +3370,8 @@ int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_curren
 		nametypetrans->src_str = s1;
 		nametypetrans->tgt_str = s2;
 		nametypetrans->obj_str = s3;
+		nametypetrans->result_str = s5;
 		nametypetrans->name_str = s4;
-		if (s6) {
-			nametypetrans->name_match_str = s5;
-			nametypetrans->result_str = s6;
-		} else {
-			nametypetrans->result_str = s5;
-		}
 
 		ast_node->data = nametypetrans;
 		ast_node->flavor = CIL_NAMETYPETRANSITION;
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index a2d2fe40..17f05021 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -726,7 +726,6 @@ int cil_copy_nametypetransition(__attribute__((unused)) struct cil_db *db, void
 	new->tgt_str = orig->tgt_str;
 	new->obj_str = orig->obj_str;
 	new->name_str = orig->name_str;
-	new->name_match_str = orig->name_match_str;
 	new->result_str = orig->result_str;
 
 
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index a5ff808b..a7604762 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -112,8 +112,6 @@ extern char *CIL_KEY_TUNABLEIF;
 extern char *CIL_KEY_ALLOW;
 extern char *CIL_KEY_DONTAUDIT;
 extern char *CIL_KEY_TYPETRANSITION;
-extern char *CIL_KEY_PREFIX;
-extern char *CIL_KEY_SUFFIX;
 extern char *CIL_KEY_TYPECHANGE;
 extern char *CIL_KEY_CALL;
 extern char *CIL_KEY_TUNABLE;
@@ -577,8 +575,6 @@ struct cil_nametypetransition {
 	struct cil_class *obj;
 	char *name_str;
 	struct cil_name *name;
-	char *name_match_str;
-	uint8_t name_match;
 	char *result_str;
 	void *result; /* type or alias */
 
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 9ee40ba7..feb97868 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1260,7 +1260,6 @@ static void cil_nametypetransition_to_policy(FILE *out, struct cil_nametypetrans
 	struct cil_name *name;
 	struct cil_list *class_list;
 	struct cil_list_item *i1;
-	const char *name_match_str = "";
 
 	src = trans->src;
 	tgt = trans->tgt;
@@ -1269,21 +1268,7 @@ static void cil_nametypetransition_to_policy(FILE *out, struct cil_nametypetrans
 
 	class_list = cil_expand_class(trans->obj);
 	cil_list_for_each(i1, class_list) {
-		switch (trans->name_match) {
-		case NAME_TRANS_MATCH_EXACT:
-			name_match_str = "";
-			break;
-		case NAME_TRANS_MATCH_PREFIX:
-			name_match_str = " PREFIX";
-			break;
-		case NAME_TRANS_MATCH_SUFFIX:
-			name_match_str = " SUFFIX";
-			break;
-		default:
-			name_match_str = "???";
-			break;
-		}
-		fprintf(out, "type_transition %s %s : %s %s \"%s\"%s;\n", src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn, name_match_str);
+		fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn);
 	}
 	cil_list_destroy(&class_list, CIL_FALSE);
 }
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 1ef0986c..d2bfdc81 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -668,16 +668,6 @@ int cil_resolve_nametypetransition(struct cil_tree_node *current, void *extra_ar
 		nametypetrans->name = (struct cil_name *)name_datum;
 	}
 
-	if (nametypetrans->name_match_str == NULL) {
-		nametypetrans->name_match = NAME_TRANS_MATCH_EXACT;
-	} else if (nametypetrans->name_match_str == CIL_KEY_PREFIX) {
-		nametypetrans->name_match = NAME_TRANS_MATCH_PREFIX;
-	} else if (nametypetrans->name_match_str == CIL_KEY_SUFFIX) {
-		nametypetrans->name_match = NAME_TRANS_MATCH_SUFFIX;
-	} else {
-		cil_tree_log(current, CIL_ERR, "Invalid name match type \"%s\"", nametypetrans->name_match_str);
-	}
-
 	rc = cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYPES, extra_args, &result_datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index d96f6c39..b75784ef 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1168,8 +1168,6 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->tgt_str));
 		fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->obj_str));
 		fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), rule->name_str));
-		if (rule->name_match != NAME_TRANS_MATCH_EXACT)
-			fprintf(out, "%s ", rule->name_match_str);
 		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str));
 		fprintf(out, ")\n");
 		break;
-- 
2.41.0

