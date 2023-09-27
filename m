Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED0E82CC7
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjI0TAi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjI0TAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A3191
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41819a68143so43469041cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841228; x=1696446028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1a+Czivph0rG5mvi+xPzN9iLYTyubWIC/hBPiCbplQ=;
        b=Lda/7KlDOVLGd04+cTgvS+eDd+ymFpWwicCKLMXAkO7kDaJ/ACau12uQa0GNisnhmT
         uC4srAH7GABrRHEY3gBU0dgbYAaNsPcYXfISQfZblAxdQtXjvzXMcxgWpQ/+2dnIiGBZ
         RihRxahqzhkcFqOykda2DsVKHYc2oprybtVUujpbPrqhxDUxIBJYesIJCmsfhlFw4F62
         uTJfSESPCIsn6W5b852HfqtZBj+sXwmCdikuSJLHbxMzEFnUzQXf4SBHdajrjcShrvxW
         /PeZDbrktinsdDA98Vo3q60ImwCOsAcjsCQgdftlO+aB1b0ijzAJ4uWGEZFRSjRhSiBv
         3sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841228; x=1696446028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1a+Czivph0rG5mvi+xPzN9iLYTyubWIC/hBPiCbplQ=;
        b=LIeXYl0+6dUFcFGgG/Fc2xBuvhmJYl1UxS7GIXlmYTsVtdla5k8T5MWimL+XI73dFX
         A+9IkD0dy/ZWL3uBEYZhH/SkeVhLGBkk10DuFzTN3+c9sPxEiksYa8ha4m5c6eo+JT8f
         VWfnly8t5HzRQQ70czdTu0vS5mO/9c1Yybn/RGXR1fzsHPtc0WCef+MimyGvw1mZXLip
         /S0xcNuV5k2CDrYuIfmiGfhQgyBSdK7hC6C436hmDt1f2XnfFvjMkS93AECh0LhaTrKq
         3B28YB9SkF6CG+kAuICjC1lgO8VIYeoRRSN58ZbN/geSkr2GUGzc2+Vxg3NO4wBUJZSa
         3uwA==
X-Gm-Message-State: AOJu0YyfBOQ8eYVW7l52eRdaDc6VvYglsdze9sATttq7RMib94XIX/QU
        BaBnmG/hjliwu+6aGrNHVLUvMtN+DKo=
X-Google-Smtp-Source: AGHT+IG6wfyC9WqfoAOADQ+Bf1RurP677Gl1Pf68D8MV3FyPzd1/dEK6GGdnxl5vByDnzs9c6ns3ew==
X-Received: by 2002:a05:622a:355:b0:412:1ba6:32c7 with SMTP id r21-20020a05622a035500b004121ba632c7mr3251521qtw.44.1695841227880;
        Wed, 27 Sep 2023 12:00:27 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:27 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/9] libsepol/cil: Refactor and improve handling of order rules
Date:   Wed, 27 Sep 2023 15:00:14 -0400
Message-ID: <20230927190021.1164278-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the same common structure for the ordering rules (classorder,
sidorder, sensitivityorder, and categoryorder). This removes code
duplication and makes it easier to write out the CIL AST.

Simplify the merging of multiple order rules.

Add a verification that checks that the final merged ordering is
fully specified and without ambiguity.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c             |  44 ++--
 libsepol/cil/src/cil_build_ast.c   | 333 +++++++----------------------
 libsepol/cil/src/cil_build_ast.h   |  10 +-
 libsepol/cil/src/cil_copy_ast.c    |  86 ++------
 libsepol/cil/src/cil_copy_ast.h    |   5 +-
 libsepol/cil/src/cil_internal.h    |  27 +--
 libsepol/cil/src/cil_reset_ast.c   |  16 +-
 libsepol/cil/src/cil_resolve_ast.c | 315 ++++++++++-----------------
 libsepol/cil/src/cil_verify.c      |  72 +++++++
 libsepol/cil/src/cil_verify.h      |   1 +
 libsepol/cil/src/cil_write_ast.c   |  32 ++-
 11 files changed, 347 insertions(+), 594 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 2021187d..46477d0e 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -837,7 +837,7 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_destroy_class(*data);
 		break;
 	case CIL_CLASSORDER:
-		cil_destroy_classorder(*data);
+		cil_destroy_ordered(*data);
 		break;
 	case CIL_CLASSPERMISSION:
 		cil_destroy_classpermission(*data);
@@ -934,7 +934,7 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_destroy_aliasactual(*data);
 		break;
 	case CIL_SENSITIVITYORDER:
-		cil_destroy_sensitivityorder(*data);
+		cil_destroy_ordered(*data);
 		break;
 	case CIL_SENSCAT:
 		cil_destroy_senscat(*data);
@@ -952,7 +952,7 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_destroy_aliasactual(*data);
 		break;
 	case CIL_CATORDER:
-		cil_destroy_catorder(*data);
+		cil_destroy_ordered(*data);
 		break;
 	case CIL_LEVEL:
 		cil_destroy_level(*data);
@@ -964,7 +964,7 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_destroy_sid(*data);
 		break;
 	case CIL_SIDORDER:
-		cil_destroy_sidorder(*data);
+		cil_destroy_ordered(*data);
 		break;
 	case CIL_NAME:
 		cil_destroy_name(*data);
@@ -2164,6 +2164,14 @@ void cil_sort_destroy(struct cil_sort **sort)
 	*sort = NULL;
 }
 
+void cil_ordered_init(struct cil_ordered **ordered)
+{
+	*ordered = cil_malloc(sizeof(**ordered));
+	(*ordered)->merged = CIL_FALSE;
+	(*ordered)->strs = NULL;
+	(*ordered)->datums = NULL;
+}
+
 void cil_netifcon_init(struct cil_netifcon **netifcon)
 {
 	*netifcon = cil_malloc(sizeof(**netifcon));
@@ -2281,13 +2289,6 @@ void cil_class_init(struct cil_class **class)
 	(*class)->ordered = CIL_FALSE;
 }
 
-void cil_classorder_init(struct cil_classorder **classorder)
-{
-	*classorder = cil_malloc(sizeof(**classorder));
-
-	(*classorder)->class_list_str = NULL;
-}
-
 void cil_classcommon_init(struct cil_classcommon **classcommon)
 {
 	*classcommon = cil_malloc(sizeof(**classcommon));
@@ -2315,13 +2316,6 @@ void cil_sidcontext_init(struct cil_sidcontext **sidcontext)
 	(*sidcontext)->context = NULL;
 }
 
-void cil_sidorder_init(struct cil_sidorder **sidorder)
-{
-	*sidorder = cil_malloc(sizeof(**sidorder));
-
-	(*sidorder)->sid_list_str = NULL;
-}
-
 void cil_userrole_init(struct cil_userrole **userrole)
 {
 	*userrole = cil_malloc(sizeof(**userrole));
@@ -2877,20 +2871,6 @@ void cil_cat_init(struct cil_cat **cat)
 	(*cat)->value = 0;
 }
 
-void cil_catorder_init(struct cil_catorder **catorder)
-{
-	*catorder = cil_malloc(sizeof(**catorder));
-
-	(*catorder)->cat_list_str = NULL;
-}
-
-void cil_sensorder_init(struct cil_sensorder **sensorder)
-{
-	*sensorder = cil_malloc(sizeof(**sensorder));
-
-	(*sensorder)->sens_list_str = NULL;
-}
-
 void cil_args_init(struct cil_args **args)
 {
 	*args = cil_malloc(sizeof(**args));
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 8976c254..efe1601c 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -186,6 +186,83 @@ static void cil_clear_node(struct cil_tree_node *ast_node)
 	ast_node->flavor = CIL_NONE;
 }
 
+int cil_gen_ordered(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_ordered *ordered = NULL;
+	struct cil_list_item *curr = NULL;
+
+	int rc = SEPOL_ERR;
+
+	if (db == NULL || parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc !=  SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_ordered_init(&ordered);
+
+	rc = cil_fill_list(parse_current->next->cl_head, flavor, &ordered->strs);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_list_for_each(curr, ordered->strs) {
+		if (curr->data == CIL_KEY_UNORDERED) {
+			if (flavor == CIL_CLASSORDER) {
+				if (curr == ordered->strs->head && curr->next == NULL) {
+					cil_log(CIL_ERR, "classorder 'unordered' keyword must be followed by one or more class.\n");
+					rc = SEPOL_ERR;
+					goto exit;
+				} else if (curr != ordered->strs->head) {
+					cil_log(CIL_ERR, "classorder can only use 'unordered' keyword as the first item in the list.\n");
+					rc = SEPOL_ERR;
+					goto exit;
+				}
+			} else {
+				cil_log(CIL_ERR, "The 'unordered' keyword can only be used with classorder rules.\n");
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+		}
+	}
+
+	ast_node->data = ordered;
+	ast_node->flavor = flavor;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad ordered declaration");
+	cil_destroy_ordered(ordered);
+	return rc;
+}
+
+void cil_destroy_ordered(struct cil_ordered *ordered)
+{
+	if (ordered == NULL) {
+		return;
+	}
+
+	if (ordered->strs != NULL) {
+		cil_list_destroy(&ordered->strs, CIL_FALSE);
+	}
+	if (ordered->datums != NULL) {
+		cil_list_destroy(&ordered->datums, CIL_FALSE);
+	}
+
+	free(ordered);
+}
+
+
 int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint16_t is_abstract)
 {
 	enum cil_syntax syntax[] = {
@@ -510,74 +587,6 @@ void cil_destroy_class(struct cil_class *class)
 	free(class);
 }
 
-int cil_gen_classorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
-{
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING,
-		CIL_SYN_LIST,
-		CIL_SYN_END
-	};
-	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
-	struct cil_classorder *classorder = NULL;
-	struct cil_list_item *curr = NULL;
-	struct cil_list_item *head = NULL;
-	int rc = SEPOL_ERR;
-
-	if (db == NULL || parse_current == NULL || ast_node == NULL) {
-		goto exit;
-	}
-
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc !=  SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_classorder_init(&classorder);
-
-	rc = cil_fill_list(parse_current->next->cl_head, CIL_CLASSORDER, &classorder->class_list_str);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	head = classorder->class_list_str->head;
-	cil_list_for_each(curr, classorder->class_list_str) {
-		if (curr->data == CIL_KEY_UNORDERED) {
-			if (curr == head && curr->next == NULL) {
-				cil_log(CIL_ERR, "Classorder 'unordered' keyword must be followed by one or more class.\n");
-				rc = SEPOL_ERR;
-				goto exit;
-			} else if (curr != head) {
-				cil_log(CIL_ERR, "Classorder can only use 'unordered' keyword as the first item in the list.\n");
-				rc = SEPOL_ERR;
-				goto exit;
-			}
-		}
-	}
-
-	ast_node->data = classorder;
-	ast_node->flavor = CIL_CLASSORDER;
-
-	return SEPOL_OK;
-
-exit:
-	cil_tree_log(parse_current, CIL_ERR, "Bad classorder declaration");
-	cil_destroy_classorder(classorder);
-	return rc;
-}
-
-void cil_destroy_classorder(struct cil_classorder *classorder)
-{
-	if (classorder == NULL) {
-		return;
-	}
-
-	if (classorder->class_list_str != NULL) {
-		cil_list_destroy(&classorder->class_list_str, 1);
-	}
-
-	free(classorder);
-}
-
 int cil_gen_perm(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms)
 {
 	char *key = NULL;
@@ -1220,66 +1229,6 @@ void cil_destroy_sidcontext(struct cil_sidcontext *sidcon)
 	free(sidcon);
 }
 
-int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
-{
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING,
-		CIL_SYN_LIST,
-		CIL_SYN_END
-	};
-	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
-	struct cil_sidorder *sidorder = NULL;
-	struct cil_list_item *curr = NULL;
-	int rc = SEPOL_ERR;
-
-	if (db == NULL || parse_current == NULL || ast_node == NULL) {
-		goto exit;
-	}
-
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc !=  SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_sidorder_init(&sidorder);
-
-	rc = cil_fill_list(parse_current->next->cl_head, CIL_SIDORDER, &sidorder->sid_list_str);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_list_for_each(curr, sidorder->sid_list_str) {
-		if (curr->data == CIL_KEY_UNORDERED) {
-			cil_log(CIL_ERR, "Sidorder cannot be unordered.\n");
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-	}
-
-	ast_node->data = sidorder;
-	ast_node->flavor = CIL_SIDORDER;
-
-	return SEPOL_OK;
-
-exit:
-	cil_tree_log(parse_current, CIL_ERR, "Bad sidorder declaration");
-	cil_destroy_sidorder(sidorder);
-	return rc;
-}
-
-void cil_destroy_sidorder(struct cil_sidorder *sidorder)
-{
-	if (sidorder == NULL) {
-		return;
-	}
-
-	if (sidorder->sid_list_str != NULL) {
-		cil_list_destroy(&sidorder->sid_list_str, 1);
-	}
-
-	free(sidorder);
-}
-
 int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -3699,126 +3648,6 @@ void cil_destroy_catset(struct cil_catset *catset)
 	free(catset);
 }
 
-int cil_gen_catorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
-{
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING,
-		CIL_SYN_LIST,
-		CIL_SYN_END
-	};
-	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
-	struct cil_catorder *catorder = NULL;
-	struct cil_list_item *curr = NULL;
-	int rc = SEPOL_ERR;
-
-	if (db == NULL || parse_current == NULL || ast_node == NULL) {
-		goto exit;
-	}
-
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc !=  SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_catorder_init(&catorder);
-
-	rc = cil_fill_list(parse_current->next->cl_head, CIL_CATORDER, &catorder->cat_list_str);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_list_for_each(curr, catorder->cat_list_str) {
-		if (curr->data == CIL_KEY_UNORDERED) {
-			cil_log(CIL_ERR, "Category order cannot be unordered.\n");
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-	}
-
-	ast_node->data = catorder;
-	ast_node->flavor = CIL_CATORDER;
-
-	return SEPOL_OK;
-
-exit:
-	cil_tree_log(parse_current, CIL_ERR, "Bad categoryorder declaration");
-	cil_destroy_catorder(catorder);
-	return rc;
-}
-
-void cil_destroy_catorder(struct cil_catorder *catorder)
-{
-	if (catorder == NULL) {
-		return;
-	}
-
-	if (catorder->cat_list_str != NULL) {
-		cil_list_destroy(&catorder->cat_list_str, 1);
-	}
-
-	free(catorder);
-}
-
-int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
-{
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING,
-		CIL_SYN_LIST,
-		CIL_SYN_END
-	};
-	size_t syntax_len = sizeof(syntax)/sizeof(*syntax);
-	struct cil_sensorder *sensorder = NULL;
-	struct cil_list_item *curr = NULL;
-	int rc = SEPOL_ERR;
-
-	if (db == NULL || parse_current == NULL || ast_node == NULL) {
-		goto exit;
-	}
-
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_sensorder_init(&sensorder);
-
-	rc = cil_fill_list(parse_current->next->cl_head, CIL_SENSITIVITYORDER, &sensorder->sens_list_str);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	cil_list_for_each(curr, sensorder->sens_list_str) {
-		if (curr->data == CIL_KEY_UNORDERED) {
-			cil_log(CIL_ERR, "Sensitivity order cannot be unordered.\n");
-			rc = SEPOL_ERR;
-			goto exit;
-		}
-	}
-
-	ast_node->data = sensorder;
-	ast_node->flavor = CIL_SENSITIVITYORDER;
-
-	return SEPOL_OK;
-
-exit:
-	cil_tree_log(parse_current, CIL_ERR, "Bad sensitivityorder declaration");
-	cil_destroy_sensitivityorder(sensorder);
-	return rc;
-}
-
-void cil_destroy_sensitivityorder(struct cil_sensorder *sensorder)
-{
-	if (sensorder == NULL) {
-		return;
-	}
-
-	if (sensorder->sens_list_str != NULL) {
-		cil_list_destroy(&sensorder->sens_list_str, CIL_TRUE);
-	}
-
-	free(sensorder);
-}
-
 int cil_gen_senscat(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -6314,7 +6143,7 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 	} else if (parse_current->data == CIL_KEY_CLASS) {
 		rc = cil_gen_class(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSORDER) {
-		rc = cil_gen_classorder(db, parse_current, new_ast_node);
+		rc = cil_gen_ordered(db, parse_current, new_ast_node, CIL_CLASSORDER);
 	} else if (parse_current->data == CIL_KEY_MAP_CLASS) {
 		rc = cil_gen_map_class(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CLASSMAPPING) {
@@ -6332,7 +6161,7 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 	} else if (parse_current->data == CIL_KEY_SIDCONTEXT) {
 		rc = cil_gen_sidcontext(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_SIDORDER) {
-		rc = cil_gen_sidorder(db, parse_current, new_ast_node);
+		rc = cil_gen_ordered(db, parse_current, new_ast_node, CIL_SIDORDER);
 	} else if (parse_current->data == CIL_KEY_USER) {
 		rc = cil_gen_user(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_USERATTRIBUTE) {
@@ -6446,9 +6275,9 @@ static struct cil_tree_node * parse_statement(struct cil_db *db, struct cil_tree
 	} else if (parse_current->data == CIL_KEY_CATSET) {
 		rc = cil_gen_catset(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_CATORDER) {
-		rc = cil_gen_catorder(db, parse_current, new_ast_node);
+		rc = cil_gen_ordered(db, parse_current, new_ast_node, CIL_CATORDER);
 	} else if (parse_current->data == CIL_KEY_SENSITIVITYORDER) {
-		rc = cil_gen_sensitivityorder(db, parse_current, new_ast_node);
+		rc = cil_gen_ordered(db, parse_current, new_ast_node, CIL_SENSITIVITYORDER);
 	} else if (parse_current->data == CIL_KEY_SENSCAT) {
 		rc = cil_gen_senscat(db, parse_current, new_ast_node);
 	} else if (parse_current->data == CIL_KEY_LEVEL) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index aca84b24..96af3c91 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -42,6 +42,8 @@ int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t ke
 int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor);
 int cil_parse_to_list(struct cil_tree_node *parse_cl_head, struct cil_list *ast_cl, enum cil_flavor flavor);
 
+int cil_gen_ordered(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor);
+void cil_destroy_ordered(struct cil_ordered *ordered);
 int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint16_t is_abstract);
 void cil_destroy_block(struct cil_block *block);
 int cil_gen_blockinherit(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
@@ -52,8 +54,6 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
 void cil_destroy_in(struct cil_in *in);
 int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_class(struct cil_class *class);
-int cil_gen_classorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
-void cil_destroy_classorder(struct cil_classorder *classorder);
 int cil_gen_perm(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms);
 void cil_destroy_perm(struct cil_perm *perm);
 int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms);
@@ -78,8 +78,6 @@ int cil_gen_sid(struct cil_db *db, struct cil_tree_node *parse_current, struct c
 void cil_destroy_sid(struct cil_sid *sid);
 int cil_gen_sidcontext(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_sidcontext(struct cil_sidcontext *sidcon);
-int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
-void cil_destroy_sidorder(struct cil_sidorder *sidorder);
 int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_user(struct cil_user *user);
 int cil_gen_userattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
@@ -158,10 +156,6 @@ int cil_gen_category(struct cil_db *db, struct cil_tree_node *parse_current, str
 void cil_destroy_category(struct cil_cat *cat);
 int cil_set_to_list(struct cil_tree_node *parse_current, struct cil_list *ast_cl);
 void cil_destroy_catset(struct cil_catset *catset);
-int cil_gen_catorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
-void cil_destroy_catorder(struct cil_catorder *catorder);
-int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
-void cil_destroy_sensitivityorder(struct cil_sensorder *sensorder);
 int cil_gen_senscat(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_senscat(struct cil_senscat *senscat);
 int cil_gen_level(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index bc972f03..735628df 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -97,6 +97,24 @@ static int cil_copy_node(__attribute__((unused)) struct cil_db *db, void *data,
 	return SEPOL_OK;
 }
 
+int cil_copy_ordered(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_ordered *orig = data;
+	struct cil_ordered *new = NULL;
+
+	cil_ordered_init(&new);
+	if (orig->strs != NULL) {
+		cil_copy_list(orig->strs, &new->strs);
+	}
+	if (orig->datums != NULL) {
+		cil_copy_list(orig->datums, &new->datums);
+	}
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int cil_copy_block(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_block *orig = data;
@@ -261,21 +279,6 @@ int cil_copy_class(__attribute__((unused)) struct cil_db *db, void *data, void *
 	return SEPOL_OK;
 }
 
-int cil_copy_classorder(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
-{
-	struct cil_classorder *orig = data;
-	struct cil_classorder *new = NULL;
-
-	cil_classorder_init(&new);
-	if (orig->class_list_str != NULL) {
-		cil_copy_list(orig->class_list_str, &new->class_list_str);
-	}
-
-	*copy = new;
-
-	return SEPOL_OK;
-}
-
 int cil_copy_classpermission(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_classpermission *orig = data;
@@ -368,21 +371,6 @@ int cil_copy_sidcontext(struct cil_db *db, void *data, void **copy, __attribute_
 	return SEPOL_OK;
 }
 
-int cil_copy_sidorder(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
-{
-	struct cil_sidorder *orig = data;
-	struct cil_sidorder *new = NULL;
-
-	cil_sidorder_init(&new);
-	if (orig->sid_list_str != NULL) {
-		cil_copy_list(orig->sid_list_str, &new->sid_list_str);
-	}
-
-	*copy = new;
-
-	return SEPOL_OK;
-}
-
 int cil_copy_user(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_user *orig = data;
@@ -969,36 +957,6 @@ int cil_copy_senscat(struct cil_db *db, void *data, void **copy, __attribute__((
 	return SEPOL_OK;
 }
 
-int cil_copy_catorder(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
-{
-	struct cil_catorder *orig = data;
-	struct cil_catorder *new = NULL;
-
-	cil_catorder_init(&new);
-	if (orig->cat_list_str != NULL) {
-		cil_copy_list(orig->cat_list_str, &new->cat_list_str);
-	}
-
-	*copy = new;
-
-	return SEPOL_OK;
-}
-
-int cil_copy_sensitivityorder(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
-{
-	struct cil_sensorder *orig = data;
-	struct cil_sensorder *new = NULL;
-
-	cil_sensorder_init(&new);
-	if (orig->sens_list_str != NULL) {
-		cil_copy_list(orig->sens_list_str, &new->sens_list_str);
-	}
-
-	*copy = new;
-
-	return SEPOL_OK;
-}
-
 void cil_copy_fill_level(struct cil_db *db, struct cil_level *orig, struct cil_level **new)
 {
 	cil_level_init(new);
@@ -1768,7 +1726,7 @@ static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished
 		copy_func = &cil_copy_class;
 		break;
 	case CIL_CLASSORDER:
-		copy_func = &cil_copy_classorder;
+		copy_func = &cil_copy_ordered;
 		break;
 	case CIL_CLASSPERMISSION:
 		copy_func = &cil_copy_classpermission;
@@ -1786,7 +1744,7 @@ static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished
 		copy_func = &cil_copy_sidcontext;
 		break;
 	case CIL_SIDORDER:
-		copy_func = &cil_copy_sidorder;
+		copy_func = &cil_copy_ordered;
 		break;
 	case CIL_USER:
 		copy_func = &cil_copy_user;
@@ -1907,10 +1865,10 @@ static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished
 		copy_func = &cil_copy_senscat;
 		break;
 	case CIL_CATORDER:
-		copy_func = &cil_copy_catorder;
+		copy_func = &cil_copy_ordered;
 		break;
 	case CIL_SENSITIVITYORDER:
-		copy_func = &cil_copy_sensitivityorder;
+		copy_func = &cil_copy_ordered;
 		break;
 	case CIL_LEVEL:
 		copy_func = &cil_copy_level;
diff --git a/libsepol/cil/src/cil_copy_ast.h b/libsepol/cil/src/cil_copy_ast.h
index 9f695ec5..9e6be5ac 100644
--- a/libsepol/cil/src/cil_copy_ast.h
+++ b/libsepol/cil/src/cil_copy_ast.h
@@ -37,12 +37,12 @@
 void cil_copy_list(struct cil_list *orig, struct cil_list **copy);
 int cil_copy_expr(struct cil_db *db, struct cil_list *orig, struct cil_list **new);
 
+int cil_copy_ordered(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab);
 int cil_copy_block(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_blockabstract(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_blockinherit(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_perm(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_class(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
-int cil_copy_classorder(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_classmapping(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_permset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 
@@ -55,7 +55,6 @@ int cil_copy_common(struct cil_db *db, void *data, void **copy, symtab_t *symtab
 int cil_copy_classcommon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_sid(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_sidcontext(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
-int cil_copy_sidorder(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_user(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_userattribute(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_userattributeset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
@@ -88,8 +87,6 @@ int cil_copy_cat(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_catalias(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_catset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_senscat(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
-int cil_copy_catorder(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
-int cil_copy_sensitivityorder(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 void cil_copy_fill_level(struct cil_db *db, struct cil_level *orig, struct cil_level **new);
 int cil_copy_level(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 void cil_copy_fill_levelrange(struct cil_db *db, struct cil_levelrange *orig, struct cil_levelrange *new);
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 9e492cb9..013483c9 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -347,6 +347,12 @@ struct cil_sort {
 	void **array;
 };
 
+struct cil_ordered {
+	int merged;
+	struct cil_list *strs;
+	struct cil_list *datums;
+};
+
 struct cil_block {
 	struct cil_symtab_datum datum;
 	symtab_t symtab[CIL_SYM_NUM];
@@ -387,10 +393,6 @@ struct cil_class {
 	uint32_t ordered; /* Only used for kernel class */
 };
 
-struct cil_classorder {
-	struct cil_list *class_list_str;
-};
-
 struct cil_classperms_set {
 	char *set_str;
 	struct cil_classpermission *set;
@@ -446,10 +448,6 @@ struct cil_sidcontext {
 	struct cil_context *context;
 };
 
-struct cil_sidorder {
-	struct cil_list *sid_list_str;
-};
-
 struct cil_user {
 	struct cil_symtab_datum datum;
 	struct cil_user *bounds;
@@ -685,10 +683,6 @@ struct cil_sens {
 	uint32_t ordered;
 };
 
-struct cil_sensorder {
-	struct cil_list *sens_list_str;
-};
-
 struct cil_cat {
 	struct cil_symtab_datum datum;
 	uint32_t ordered;
@@ -706,10 +700,6 @@ struct cil_catset {
 	struct cil_cats *cats;
 };
 
-struct cil_catorder {
-	struct cil_list *cat_list_str;
-};
-
 struct cil_senscat {
 	char *sens_str;
 	struct cil_cats *cats;
@@ -1012,6 +1002,7 @@ int cil_string_to_uint64(const char *string, uint64_t *value, int base);
 
 void cil_sort_init(struct cil_sort **sort);
 void cil_sort_destroy(struct cil_sort **sort);
+void cil_ordered_init(struct cil_ordered **ordered);
 void cil_netifcon_init(struct cil_netifcon **netifcon);
 void cil_ibendportcon_init(struct cil_ibendportcon **ibendportcon);
 void cil_context_init(struct cil_context **context);
@@ -1023,11 +1014,9 @@ void cil_blockinherit_init(struct cil_blockinherit **inherit);
 void cil_blockabstract_init(struct cil_blockabstract **abstract);
 void cil_in_init(struct cil_in **in);
 void cil_class_init(struct cil_class **class);
-void cil_classorder_init(struct cil_classorder **classorder);
 void cil_classcommon_init(struct cil_classcommon **classcommon);
 void cil_sid_init(struct cil_sid **sid);
 void cil_sidcontext_init(struct cil_sidcontext **sidcontext);
-void cil_sidorder_init(struct cil_sidorder **sidorder);
 void cil_userrole_init(struct cil_userrole **userrole);
 void cil_userprefix_init(struct cil_userprefix **userprefix);
 void cil_selinuxuser_init(struct cil_selinuxuser **selinuxuser);
@@ -1083,8 +1072,6 @@ void cil_userrange_init(struct cil_userrange **userrange);
 void cil_role_init(struct cil_role **role);
 void cil_type_init(struct cil_type **type);
 void cil_cat_init(struct cil_cat **cat);
-void cil_catorder_init(struct cil_catorder **catorder);
-void cil_sensorder_init(struct cil_sensorder **sensorder);
 void cil_args_init(struct cil_args **args);
 void cil_call_init(struct cil_call **call);
 void cil_optional_init(struct cil_optional **optional);
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 9069317e..fa312c6f 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -11,6 +11,12 @@ static inline void cil_reset_levelrange(struct cil_levelrange *levelrange);
 static inline void cil_reset_context(struct cil_context *context);
 
 
+static void cil_reset_ordered(struct cil_ordered *ordered)
+{
+	ordered->merged = CIL_FALSE;
+	cil_list_destroy(&ordered->datums, CIL_FALSE);
+}
+
 static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
 {
 	struct cil_perm *perm = (struct cil_perm *)d;
@@ -638,14 +644,16 @@ static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused))
 	case CIL_BOOLEANIF:
 		cil_reset_booleanif(node->data);
 		break;
-	case CIL_TUNABLEIF:
-	case CIL_CALL:
-		break; /* Not effected by optional block disabling */
-	case CIL_MACRO:
 	case CIL_SIDORDER:
 	case CIL_CLASSORDER:
 	case CIL_CATORDER:
 	case CIL_SENSITIVITYORDER:
+		cil_reset_ordered(node->data);
+		break;
+	case CIL_TUNABLEIF:
+	case CIL_CALL:
+		break; /* Not effected by optional block disabling */
+	case CIL_MACRO:
 		break; /* Nothing to reset */
 	default:
 		break;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 595bd2b9..0172bbdd 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1213,55 +1213,6 @@ exit:
 	return rc;
 }
 
-struct cil_ordered_list {
-	int merged;
-	struct cil_list *list;
-	struct cil_tree_node *node;
-};
-
-static void __cil_ordered_list_init(struct cil_ordered_list **ordered)
-{
-	*ordered = cil_malloc(sizeof(**ordered));
-
-	(*ordered)->merged = CIL_FALSE;
-	(*ordered)->list = NULL;
-	(*ordered)->node = NULL;
-}
-
-static void __cil_ordered_list_destroy(struct cil_ordered_list **ordered)
-{
-	cil_list_destroy(&(*ordered)->list, CIL_FALSE);
-	(*ordered)->node = NULL;
-	free(*ordered);
-	*ordered = NULL;
-}
-
-static void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
-{
-	struct cil_list_item *item = NULL;
-
-	if (ordered_lists == NULL || *ordered_lists == NULL) {
-		return;
-	}
-
-	item = (*ordered_lists)->head;
-	while (item != NULL) {
-		struct cil_list_item *next = item->next;
-		struct cil_ordered_list *ordered = item->data;
-		__cil_ordered_list_destroy(&ordered);
-		free(item);
-		item = next;
-	}
-	free(*ordered_lists);
-	*ordered_lists = NULL;
-}
-
-static void __cil_ordered_lists_reset(struct cil_list **ordered_lists)
-{
-	__cil_ordered_lists_destroy(ordered_lists);
-	cil_list_init(ordered_lists, CIL_LIST_ITEM);
-}
-
 static struct cil_list_item *__cil_ordered_item_insert(struct cil_list *old, struct cil_list_item *curr, struct cil_list_item *item)
 {
 	if (item->flavor == CIL_SID) {
@@ -1310,24 +1261,30 @@ static int __cil_ordered_list_insert(struct cil_list *old, struct cil_list_item
 	return SEPOL_OK;
 }
 
-static struct cil_list_item *__cil_ordered_find_match(struct cil_list_item *t, struct cil_list_item *i)
+static void __cil_ordered_find_next_match(struct cil_list_item **i, struct cil_list_item **j, struct cil_list_item **p)
 {
-	while (i) {
-		if (i->data == t->data) {
-			return i;
+	struct cil_list_item *pstart = *p;
+	struct cil_list_item *jstart = *j;
+
+	while (*i) {
+		*p = pstart;
+		*j = jstart;
+		while (*j) {
+			if ((*i)->data == (*j)->data) {
+				return;
+			}
+			*p = *j;
+			*j = (*j)->next;
 		}
-		i = i->next;
+		*i = (*i)->next;
 	}
-	return NULL;
 }
 
 static int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
 {
-	struct cil_list_item *omatch = NULL;
 	struct cil_list_item *ofirst = old->head;
 	struct cil_list_item *ocurr = NULL;
 	struct cil_list_item *oprev = NULL;
-	struct cil_list_item *nmatch = NULL;
 	struct cil_list_item *nfirst = new->head;
 	struct cil_list_item *ncurr = NULL;
 	int rc = SEPOL_ERR;
@@ -1338,75 +1295,41 @@ static int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
 
 	if (ofirst == NULL) {
 		/* First list added */
-		rc = __cil_ordered_list_insert(old, NULL, nfirst, NULL);
-		return rc;
+		return __cil_ordered_list_insert(old, NULL, nfirst, NULL);
 	}
 
-	/* Find a match between the new list and the old one */
-	for (nmatch = nfirst; nmatch; nmatch = nmatch->next) {
-		omatch = __cil_ordered_find_match(nmatch, ofirst);
-		if (omatch) {
+	ncurr = nfirst;
+	ocurr = ofirst;
+	oprev = NULL;
+	while (ncurr && ocurr) {
+		__cil_ordered_find_next_match(&ncurr, &ocurr, &oprev);
+		if (!ncurr || !ocurr) {
 			break;
 		}
-	}
-
-	if (!nmatch) {
-		/* List cannot be merged yet */
-		return SEPOL_ERR;
-	}
-
-	if (nmatch != nfirst && omatch != ofirst) {
-		/* Potential ordering conflict--try again later */
-		return SEPOL_ERR;
-	}
-
-	if (nmatch != nfirst) {
-		/* Prepend the beginning of the new list up to the first match to the old list */
-		rc = __cil_ordered_list_insert(old, NULL, nfirst, nmatch);
-		if (rc != SEPOL_OK) {
-			return rc;
+		if (ncurr != nfirst) {
+			rc = __cil_ordered_list_insert(old, oprev, nfirst, ncurr);
+			if (rc != SEPOL_OK) {
+				return rc;
+			}
 		}
+		ncurr = ncurr->next;
+		nfirst = ncurr;
+		oprev = ocurr;
+		ocurr = ocurr->next;
 	}
 
-	/* In the overlapping protion, add items from the new list not in the old list */
-	ncurr = nmatch->next;
-	ocurr = omatch->next;
-	oprev = omatch;
-	while (ncurr && ocurr) {
-		if (ncurr->data == ocurr->data) {
-			oprev = ocurr;
-			ocurr = ocurr->next;
-			ncurr = ncurr->next;
+	if (!ncurr) {
+		if (!nfirst) {
+			/* Done */
+			return SEPOL_OK;
 		} else {
-			/* Handle gap in old: old = (A C)  new = (A B C) */
-			nmatch = __cil_ordered_find_match(ocurr, ncurr->next);
-			if (nmatch) {
-				rc = __cil_ordered_list_insert(old, oprev, ncurr, nmatch);
-				if (rc != SEPOL_OK) {
-					return rc;
-				}
-				oprev = ocurr;
-				ocurr = ocurr->next;
-				ncurr = nmatch->next;
-				continue;
-			}
-			/* Handle gap in new: old = (A B C)  new = (A C) */
-			omatch = __cil_ordered_find_match(ncurr, ocurr->next);
-			if (omatch) {
-				/* Nothing to insert, just skip */
-				oprev = omatch;
-				ocurr = omatch->next;
-				ncurr = ncurr->next;
-				continue;
-			} else {
-				return SEPOL_ERR;
-			}
+			/* Can't merge yet */
+			return SEPOL_ERR;
 		}
 	}
 
-	if (ncurr) {
-		/* Add the rest of the items from the new list */
-		rc = __cil_ordered_list_insert(old, old->tail, ncurr, NULL);
+	if (ncurr && !ocurr) { /* some remaining */
+		rc = __cil_ordered_list_insert(old, oprev, ncurr, NULL);
 		if (rc != SEPOL_OK) {
 			return rc;
 		}
@@ -1415,18 +1338,19 @@ static int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
 	return SEPOL_OK;
 }
 
-static int insert_unordered(struct cil_list *merged, struct cil_list *unordered)
+static int insert_unordered(struct cil_list *merged, struct cil_list *unordered_list)
 {
+	struct cil_tree_node *node;
+	struct cil_ordered *unordered;
 	struct cil_list_item *curr = NULL;
-	struct cil_ordered_list *unordered_list = NULL;
 	struct cil_list_item *item = NULL;
 	struct cil_list_item *ret = NULL;
 	int rc = SEPOL_ERR;
 
-	cil_list_for_each(curr, unordered) {
-		unordered_list = curr->data;
-
-		cil_list_for_each(item, unordered_list->list) {
+	cil_list_for_each(curr, unordered_list) {
+		node = curr->data;
+		unordered = node->data;
+		cil_list_for_each(item, unordered->datums) {
 			if (cil_list_contains(merged, item->data)) {
 				/* item was declared in an ordered statement, which supersedes
 				 * all unordered statements */
@@ -1453,40 +1377,50 @@ exit:
 static struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists, struct cil_list **unordered_lists)
 {
 	struct cil_list *composite = NULL;
+	struct cil_tree_node *node;
+	struct cil_ordered *ordered;
 	struct cil_list_item *curr = NULL;
 	int changed = CIL_TRUE;
 	int waiting = 1;
 	int rc = SEPOL_ERR;
 
-	cil_list_init(&composite, CIL_LIST_ITEM);
+	cil_list_init(&composite, (*ordered_lists)->flavor);
 
 	while (waiting && changed == CIL_TRUE) {
 		changed = CIL_FALSE;
 		waiting = 0;
 		cil_list_for_each(curr, *ordered_lists) {
-			struct cil_ordered_list *ordered_list = curr->data;
-			if (ordered_list->merged == CIL_FALSE) {
-				rc = __cil_ordered_lists_merge(composite, ordered_list->list);
+			node = curr->data;
+			ordered = node->data;
+			if (ordered->merged == CIL_FALSE) {
+				rc = __cil_ordered_lists_merge(composite, ordered->datums);
 				if (rc != SEPOL_OK) {
 					/* Can't merge yet */
 					waiting++;
 				} else {
-					ordered_list->merged = CIL_TRUE;
+					ordered->merged = CIL_TRUE;
 					changed = CIL_TRUE;
 				}
 			}
 		}
 		if (waiting > 0 && changed == CIL_FALSE) {
 			cil_list_for_each(curr, *ordered_lists) {
-				struct cil_ordered_list *ordered_list = curr->data;
-				if (ordered_list->merged == CIL_FALSE) {
-					cil_tree_log(ordered_list->node, CIL_ERR, "Unable to merge ordered list");
+				node = curr->data;
+				ordered = node->data;
+				if (ordered->merged == CIL_FALSE) {
+					cil_tree_log(node, CIL_ERR, "Unable to merge ordered list");
 				}
 			}
 			goto exit;
 		}
 	}
 
+	rc = cil_verify_completed_ordered_list(composite, *ordered_lists);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Unable to validate ordering\n");
+		goto exit;
+	}
+
 	if (unordered_lists != NULL) {
 		rc = insert_unordered(composite, *unordered_lists);
 		if (rc != SEPOL_OK) {
@@ -1494,31 +1428,24 @@ static struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_
 		}
 	}
 
-	__cil_ordered_lists_destroy(ordered_lists);
-	__cil_ordered_lists_destroy(unordered_lists);
-
 	return composite;
 
 exit:
-	__cil_ordered_lists_destroy(ordered_lists);
-	__cil_ordered_lists_destroy(unordered_lists);
 	cil_list_destroy(&composite, CIL_FALSE);
 	return NULL;
 }
 
 int cil_resolve_classorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *classorder_list, struct cil_list *unordered_classorder_list)
 {
-	struct cil_classorder *classorder = current->data;
-	struct cil_list *new = NULL;
+	struct cil_ordered *ordered = current->data;
 	struct cil_list_item *curr = NULL;
 	struct cil_symtab_datum *datum = NULL;
-	struct cil_ordered_list *class_list = NULL;
 	int rc = SEPOL_ERR;
 	int unordered = CIL_FALSE;
 
-	cil_list_init(&new, CIL_CLASSORDER);
+	cil_list_init(&ordered->datums, CIL_DATUM);
 
-	cil_list_for_each(curr, classorder->class_list_str) {
+	cil_list_for_each(curr, ordered->strs) {
 		if (curr->data == CIL_KEY_UNORDERED) {
 			unordered = CIL_TRUE;
 			continue;
@@ -1535,37 +1462,32 @@ int cil_resolve_classorder(struct cil_tree_node *current, struct cil_db *db, str
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		cil_list_append(new, CIL_CLASS, datum);
+		cil_list_append(ordered->datums, CIL_CLASS, datum);
 	}
 
-	__cil_ordered_list_init(&class_list);
-	class_list->list = new;
-	class_list->node = current;
 	if (unordered) {
-		cil_list_append(unordered_classorder_list, CIL_CLASSORDER, class_list);
+		cil_list_append(unordered_classorder_list, CIL_CLASSORDER, current);
 	} else {
-		cil_list_append(classorder_list, CIL_CLASSORDER, class_list);
+		cil_list_append(classorder_list, CIL_CLASSORDER, current);
 	}
 
 	return SEPOL_OK;
 
 exit:
-	cil_list_destroy(&new, CIL_FALSE);
+	cil_list_destroy(&ordered->datums, CIL_FALSE);
 	return rc;
 }
 
 int cil_resolve_sidorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sidorder_list)
 {
-	struct cil_sidorder *sidorder = current->data;
-	struct cil_list *new = NULL;
+	struct cil_ordered *ordered = current->data;
 	struct cil_list_item *curr = NULL;
 	struct cil_symtab_datum *datum = NULL;
-	struct cil_ordered_list *ordered = NULL;
 	int rc = SEPOL_ERR;
 
-	cil_list_init(&new, CIL_SIDORDER);
+	cil_list_init(&ordered->datums, CIL_DATUM);
 
-	cil_list_for_each(curr, sidorder->sid_list_str) {
+	cil_list_for_each(curr, ordered->strs) {
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SIDS, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve sid %s in sidorder\n", (char *)curr->data);
@@ -1577,18 +1499,15 @@ int cil_resolve_sidorder(struct cil_tree_node *current, struct cil_db *db, struc
 			goto exit;
 		}
 
-		cil_list_append(new, CIL_SID, datum);
+		cil_list_append(ordered->datums, CIL_SID, datum);
 	}
 
-	__cil_ordered_list_init(&ordered);
-	ordered->list = new;
-	ordered->node = current;
-	cil_list_append(sidorder_list, CIL_SIDORDER, ordered);
+	cil_list_append(sidorder_list, CIL_SIDORDER, current);
 
 	return SEPOL_OK;
 
 exit:
-	cil_list_destroy(&new, CIL_FALSE);
+	cil_list_destroy(&ordered->datums, CIL_FALSE);
 	return rc;
 }
 
@@ -1608,57 +1527,47 @@ static void cil_set_cat_values(struct cil_list *ordered_cats, struct cil_db *db)
 
 int cil_resolve_catorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *catorder_list)
 {
-	struct cil_catorder *catorder = current->data;
-	struct cil_list *new = NULL;
+	struct cil_ordered *ordered = current->data;
 	struct cil_list_item *curr = NULL;
-	struct cil_symtab_datum *cat_datum;
-	struct cil_cat *cat = NULL;
-	struct cil_ordered_list *ordered = NULL;
+	struct cil_symtab_datum *datum;
 	int rc = SEPOL_ERR;
 
-	cil_list_init(&new, CIL_CATORDER);
+	cil_list_init(&ordered->datums, CIL_DATUM);
 
-	cil_list_for_each(curr, catorder->cat_list_str) {
-		struct cil_tree_node *node = NULL;
-		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CATS, db, &cat_datum);
+	cil_list_for_each(curr, ordered->strs) {
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CATS, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve category %s in categoryorder\n", (char *)curr->data);
 			goto exit;
 		}
-		node = NODE(cat_datum);
-		if (node->flavor != CIL_CAT) {
-			cil_log(CIL_ERR, "%s is not a category. Only categories are allowed in categoryorder statements\n", cat_datum->name);
+		if (FLAVOR(datum) != CIL_CAT) {
+			cil_log(CIL_ERR, "%s is not a category. Only categories are allowed in categoryorder statements\n", datum->name);
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		cat = (struct cil_cat *)cat_datum;
-		cil_list_append(new, CIL_CAT, cat);
+
+		cil_list_append(ordered->datums, CIL_CAT, datum);
 	}
 
-	__cil_ordered_list_init(&ordered);
-	ordered->list = new;
-	ordered->node = current;
-	cil_list_append(catorder_list, CIL_CATORDER, ordered);
+	cil_list_append(catorder_list, CIL_CATORDER, current);
 
 	return SEPOL_OK;
 
 exit:
-	cil_list_destroy(&new, CIL_FALSE);
+	cil_list_destroy(&ordered->datums, CIL_FALSE);
 	return rc;
 }
 
 int cil_resolve_sensitivityorder(struct cil_tree_node *current, struct cil_db *db, struct cil_list *sensitivityorder_list)
 {
-	struct cil_sensorder *sensorder = current->data;
-	struct cil_list *new = NULL;
+	struct cil_ordered *ordered = current->data;
 	struct cil_list_item *curr = NULL;
 	struct cil_symtab_datum *datum = NULL;
-	struct cil_ordered_list *ordered = NULL;
 	int rc = SEPOL_ERR;
 
-	cil_list_init(&new, CIL_LIST_ITEM);
+	cil_list_init(&ordered->datums, CIL_DATUM);
 
-	cil_list_for_each(curr, sensorder->sens_list_str) {
+	cil_list_for_each(curr, ordered->strs) {
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SENS, db, &datum);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Failed to resolve sensitivity %s in sensitivityorder\n", (char *)curr->data);
@@ -1669,18 +1578,15 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, struct cil_db *d
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-		cil_list_append(new, CIL_SENS, datum);
+		cil_list_append(ordered->datums, CIL_SENS, datum);
 	}
 
-	__cil_ordered_list_init(&ordered);
-	ordered->list = new;
-	ordered->node = current;
-	cil_list_append(sensitivityorder_list, CIL_SENSITIVITYORDER, ordered);
+	cil_list_append(sensitivityorder_list, CIL_SENSITIVITYORDER, current);
 
 	return SEPOL_OK;
 
 exit:
-	cil_list_destroy(&new, CIL_FALSE);
+	cil_list_destroy(&ordered->datums, CIL_FALSE);
 	return rc;
 }
 
@@ -4115,11 +4021,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.abstract_blocks = NULL;
 
 	cil_list_init(&extra_args.to_destroy, CIL_NODE);
-	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
-	cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
-	cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
-	cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
-	cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
+	cil_list_init(&extra_args.sidorder_lists, CIL_SIDORDER);
+	cil_list_init(&extra_args.classorder_lists, CIL_CLASSORDER);
+	cil_list_init(&extra_args.unordered_classorder_lists, CIL_CLASSORDER);
+	cil_list_init(&extra_args.catorder_lists, CIL_CATORDER);
+	cil_list_init(&extra_args.sensitivityorder_lists, CIL_SENSITIVITYORDER);
 	cil_list_init(&extra_args.in_list_before, CIL_IN);
 	cil_list_init(&extra_args.in_list_after, CIL_IN);
 	cil_list_init(&extra_args.abstract_blocks, CIL_NODE);
@@ -4227,11 +4133,16 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 					cil_log(CIL_INFO, "Resetting declarations\n");
 
 					if (pass >= CIL_PASS_MISC1) {
-						__cil_ordered_lists_reset(&extra_args.sidorder_lists);
-						__cil_ordered_lists_reset(&extra_args.classorder_lists);
-						__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
-						__cil_ordered_lists_reset(&extra_args.catorder_lists);
-						__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
+						cil_list_destroy(&extra_args.sidorder_lists, CIL_FALSE);
+						cil_list_destroy(&extra_args.classorder_lists, CIL_FALSE);
+						cil_list_destroy(&extra_args.catorder_lists, CIL_FALSE);
+						cil_list_destroy(&extra_args.sensitivityorder_lists, CIL_FALSE);
+						cil_list_destroy(&extra_args.unordered_classorder_lists, CIL_FALSE);
+						cil_list_init(&extra_args.sidorder_lists, CIL_SIDORDER);
+						cil_list_init(&extra_args.classorder_lists, CIL_CLASSORDER);
+						cil_list_init(&extra_args.unordered_classorder_lists, CIL_CLASSORDER);
+						cil_list_init(&extra_args.catorder_lists, CIL_CATORDER);
+						cil_list_init(&extra_args.sensitivityorder_lists, CIL_SENSITIVITYORDER);
 						cil_list_destroy(&db->sidorder, CIL_FALSE);
 						cil_list_destroy(&db->classorder, CIL_FALSE);
 						cil_list_destroy(&db->catorder, CIL_FALSE);
@@ -4263,11 +4174,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 
 	rc = SEPOL_OK;
 exit:
-	__cil_ordered_lists_destroy(&extra_args.sidorder_lists);
-	__cil_ordered_lists_destroy(&extra_args.classorder_lists);
-	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
-	__cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
-	__cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
+	cil_list_destroy(&extra_args.sidorder_lists, CIL_FALSE);
+	cil_list_destroy(&extra_args.classorder_lists, CIL_FALSE);
+	cil_list_destroy(&extra_args.catorder_lists, CIL_FALSE);
+	cil_list_destroy(&extra_args.sensitivityorder_lists, CIL_FALSE);
+	cil_list_destroy(&extra_args.unordered_classorder_lists, CIL_FALSE);
 	cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list_before, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list_after, CIL_FALSE);
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 579e7962..45bf4689 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -519,6 +519,78 @@ exit:
 	return rc;
 }
 
+int cil_verify_completed_ordered_list(struct cil_list *complete, struct cil_list *ordered_lists)
+{
+	struct cil_list_item *cprev, *ccurr, *cnext;
+	int found_prev, found_next;
+	int rc = SEPOL_OK;
+
+	found_prev = CIL_FALSE;
+	found_next = CIL_FALSE;
+	cprev = NULL;
+	ccurr = complete->head;
+	cnext = ccurr ? ccurr->next : NULL;
+	while (ccurr) {
+		struct cil_tree_node *node;
+		struct cil_ordered *ordered;
+		struct cil_list_item *curr_list, *oprev, *ocurr, *onext;
+		int change = CIL_FALSE;
+		cil_list_for_each(curr_list, ordered_lists) {
+			node = curr_list->data;
+			ordered = node->data;
+			oprev = NULL;
+			cil_list_for_each(ocurr, ordered->datums) {
+				onext = ocurr ? ocurr->next : NULL;
+				if (ccurr->data == ocurr->data) {
+					if (found_prev == CIL_FALSE && ((!cprev && !oprev) ||
+						(cprev && oprev && cprev->data == oprev->data))) {
+						found_prev = CIL_TRUE;
+						change = CIL_TRUE;
+					}
+					if (found_next == CIL_FALSE && ((!cnext && !onext) ||
+						(cnext && onext && cnext->data == onext->data))) {
+						found_next = CIL_TRUE;
+						change = CIL_TRUE;
+					}
+					if (found_prev && found_next) {
+						cprev = ccurr;
+						ccurr = cnext;
+						cnext = ccurr ? ccurr->next : NULL;
+						found_prev = CIL_FALSE;
+						found_next = CIL_FALSE;
+						if (!ccurr) {
+							/* Went through the whole list */
+							return rc;
+						}
+					}
+				}
+				oprev = ocurr;
+			}
+		}
+		if (!change) {
+			rc = SEPOL_ERR;
+			cil_log(CIL_ERR, "Unable to verify the order of %s\n", DATUM(ccurr->data)->fqn);
+			cil_log(CIL_ERR, "Found in the following ordering rules:\n");
+			cil_list_for_each(curr_list, ordered_lists) {
+				node = curr_list->data;
+				ordered = node->data;
+				cil_list_for_each(ocurr, ordered->datums) {
+					if (ccurr->data == ocurr->data) {
+						cil_tree_log(node, CIL_ERR, "    ");
+					}
+				}
+			}
+			cprev = ccurr;
+			ccurr = cnext;
+			cnext = ccurr ? ccurr->next : NULL;
+			found_prev = CIL_FALSE;
+			found_next = CIL_FALSE;
+		}
+	}
+
+	return rc;
+}
+
 struct cil_args_verify_order {
 	uint32_t *flavor;
 };
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index bb1a072c..daa2f80a 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -64,6 +64,7 @@ int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_fl
 int cil_verify_conditional_blocks(struct cil_tree_node *current);
 int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, struct cil_tree_node *node, const char *name);
 int __cil_verify_ranges(struct cil_list *list);
+int cil_verify_completed_ordered_list(struct cil_list *complete, struct cil_list *ordered_lists);
 int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
 int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor);
 int __cil_verify_initsids(struct cil_list *sids);
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 4da7a77c..59122a17 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -765,9 +765,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		break;
 	}
 	case CIL_CLASSORDER: {
-		struct cil_classorder *classorder = node->data;
+		struct cil_ordered *ordered = node->data;
 		fprintf(out, "(classorder ");
-		write_string_list(out, classorder->class_list_str);
+		if (ordered->datums) {
+			write_datum_list(out, ordered->datums);
+		} else {
+			write_string_list(out, ordered->strs);
+		}
 		fprintf(out, ")\n");
 		break;
 	}
@@ -834,9 +838,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		break;
 	}
 	case CIL_SIDORDER: {
-		struct cil_sidorder *sidorder = node->data;
+		struct cil_ordered *ordered = node->data;
 		fprintf(out, "(sidorder ");
-		write_string_list(out, sidorder->sid_list_str);
+		if (ordered->datums) {
+			write_datum_list(out, ordered->datums);
+		} else {
+			write_string_list(out, ordered->strs);
+		}
 		fprintf(out, ")\n");
 		break;
 	}
@@ -888,9 +896,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		break;
 	}
 	case CIL_CATORDER: {
-		struct cil_catorder *catorder = node->data;
+		struct cil_ordered *ordered = node->data;
 		fprintf(out, "(categoryorder ");
-		write_string_list(out, catorder->cat_list_str);
+		if (ordered->datums) {
+			write_datum_list(out, ordered->datums);
+		} else {
+			write_string_list(out, ordered->strs);
+		}
 		fprintf(out, ")\n");
 		break;
 	}
@@ -903,9 +915,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 		break;
 	}
 	case CIL_SENSITIVITYORDER: {
-		struct cil_sensorder *sensorder = node->data;
+		struct cil_ordered *ordered = node->data;
 		fprintf(out, "(sensitivityorder ");
-		write_string_list(out, sensorder->sens_list_str);
+		if (ordered->datums) {
+			write_datum_list(out, ordered->datums);
+		} else {
+			write_string_list(out, ordered->strs);
+		}
 		fprintf(out, ")\n");
 		break;
 	}
-- 
2.41.0

