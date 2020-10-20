Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5947C4363A
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FEE20BED
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9uweii9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407318AbgJTN3C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407086AbgJTN3C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Oct 2020 09:29:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD25C061755
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 06:29:01 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n6so3222992ioc.12
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBOK6NeurSDc8sv2Nh8XkGMBYuZQYqgRknktNj6BpbA=;
        b=s9uweii9petRyKOqBvyCrStZwlR5xN/8SrdV7ra3ZypAzyWrFk6FBMuemHC8UDZPMA
         5khQXlbqrH6FpA1eRWtE+AIBSWjnRDkOQNNn0pyzqELKBKkwifUwXuhLyH+stFjRwEgD
         Cx+br1iI3F0sdqjGT6pgcSD2GcaMOdJtxx8fqeXqoFCf5oCJPgVvNGmYOnSzLiff3x+t
         Zae6H+Dg7lEPtMMErKodKpGWaE2OstY2/u3er9wGHtmjyDN64hj4NrJA7tWnYk0xDGfL
         /hRqoAGELp2o6RscxsePmawzas/y1n2No3QzhgwZaKhTACCYHig1Evqfiu+GwTUtjmTa
         Ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBOK6NeurSDc8sv2Nh8XkGMBYuZQYqgRknktNj6BpbA=;
        b=qAQUqu2JQbE67Eg5I63p31/W8ylCeZ1JQPCh3xK0CLkd316oRgSW3iWY2ouITXKReL
         tl7LXK28tkjswG1B+O4gaLvDQ68sr+kn+AbBHdRnP0pid42b98BxHFHla56FcK/tjjv8
         mrXr02iYn8G3aGE7QJMsn8ZnwQ2SzXCfgloBWrYZTqoJquMcGBLJGGTyLWRoCRQyVyEB
         Is2rSII1J2156bJ+RFxGSUmUKMe7eoqxgL0cuR3djofyOb6ao8pxjnutIzq+nhNYORk+
         hE89DkNMYSMluVJ9v+MzYIWlqA3lpZpoz7SNGiTY3cpWmRIuxX+aRLBPJsFl0reklmkA
         5Pxg==
X-Gm-Message-State: AOAM531jBfrG2Ry8TKwXUmFebjid+eDVHF8Vb18HmtBtu+gBUoufmTLY
        T6gIkzlDDkGLVfGUfX8FaC72XHQKVug=
X-Google-Smtp-Source: ABdhPJzIQR3x6y6qsmFRMuw8pD1Mjg0kun31/BuIVnbOUnm8lHN1RMAJC2xTN8G6phachimg+Xw5mw==
X-Received: by 2002:a6b:1546:: with SMTP id 67mr2098310iov.182.1603200540153;
        Tue, 20 Oct 2020 06:29:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id b2sm1840080ila.62.2020.10.20.06.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:28:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH V2] libsepol/cil: Give error for more than one true or false block
Date:   Tue, 20 Oct 2020 09:28:56 -0400
Message-Id: <20201020132856.689870-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Both tunableif and booleanif use conditional blocks (either true or
false). No ordering is imposed, so a false block can be first (or even
the only) block. Checks are made to ensure that the first and second
(if it exists) blocks are either true or false, but no checks are made
to ensure that there is only one true and/or one false block. If there
are more than one true or false block, only the first will be used and
the other will be ignored.

Create a function, cil_verify_conditional_blocks(), that gives an error
along with a message if more than one true or false block is specified
and call that function when building tunableif and booleanif blocks in
the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
V2: Put spaces between items in argument list

 libsepol/cil/src/cil_build_ast.c | 44 +++++---------------------------
 libsepol/cil/src/cil_verify.c    | 35 +++++++++++++++++++++++++
 libsepol/cil/src/cil_verify.h    |  1 +
 3 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 3aabb05e..a8955834 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2821,7 +2821,6 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
 	int syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_booleanif *bif = NULL;
 	struct cil_tree_node *next = NULL;
-	struct cil_tree_node *cond = NULL;
 	int rc = SEPOL_ERR;
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
@@ -2841,27 +2840,12 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
 		goto exit;
 	}
 
-	cond = parse_current->next->next;
-
-	/* Destroying expr tree after stack is created*/
-	if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
-		cond->cl_head->data != CIL_KEY_CONDFALSE) {
-		rc = SEPOL_ERR;
-		cil_log(CIL_ERR, "Conditional neither true nor false\n");
+	rc = cil_verify_conditional_blocks(parse_current->next->next);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-	if (cond->next != NULL) {
-		cond = cond->next;
-		if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
-			cond->cl_head->data != CIL_KEY_CONDFALSE) {
-			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "Conditional neither true nor false\n");
-			goto exit;
-		}
-	}
-
-
+	/* Destroying expr tree */
 	next = parse_current->next->next;
 	cil_tree_subtree_destroy(parse_current->next);
 	parse_current->next = next;
@@ -2905,7 +2889,6 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	int syntax_len = sizeof(syntax)/sizeof(*syntax);
 	struct cil_tunableif *tif = NULL;
 	struct cil_tree_node *next = NULL;
-	struct cil_tree_node *cond = NULL;
 	int rc = SEPOL_ERR;
 
 	if (db == NULL || parse_current == NULL || ast_node == NULL) {
@@ -2924,27 +2907,12 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
 		goto exit;
 	}
 
-	cond = parse_current->next->next;
-
-	if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
-		cond->cl_head->data != CIL_KEY_CONDFALSE) {
-		rc = SEPOL_ERR;
-		cil_log(CIL_ERR, "Conditional neither true nor false\n");
+	rc = cil_verify_conditional_blocks(parse_current->next->next);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
-	if (cond->next != NULL) {
-		cond = cond->next;
-
-		if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
-			cond->cl_head->data != CIL_KEY_CONDFALSE) {
-			rc = SEPOL_ERR;
-			cil_log(CIL_ERR, "Conditional neither true nor false\n");
-			goto exit;
-		}
-	}
-
-	/* Destroying expr tree after stack is created*/
+	/* Destroying expr tree */
 	next = parse_current->next->next;
 	cil_tree_subtree_destroy(parse_current->next);
 	parse_current->next = next;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index c73bbeee..6706e219 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -324,6 +324,41 @@ exit:
 	return SEPOL_ERR;
 }
 
+int cil_verify_conditional_blocks(struct cil_tree_node *current)
+{
+	int found_true = CIL_FALSE;
+	int found_false = CIL_FALSE;
+
+	if (current->cl_head->data == CIL_KEY_CONDTRUE) {
+		found_true = CIL_TRUE;
+	} else if (current->cl_head->data == CIL_KEY_CONDFALSE) {
+		found_false = CIL_TRUE;
+	} else {
+		cil_tree_log(current, CIL_ERR, "Expected true or false block in conditional");
+		return SEPOL_ERR;
+	}
+
+	current = current->next;
+	if (current != NULL) {
+		if (current->cl_head->data == CIL_KEY_CONDTRUE) {
+			if (found_true) {
+				cil_tree_log(current, CIL_ERR, "More than one true block in conditional");
+				return SEPOL_ERR;
+			}
+		} else if (current->cl_head->data == CIL_KEY_CONDFALSE) {
+			if (found_false) {
+				cil_tree_log(current, CIL_ERR, "More than one false block in conditional");
+				return SEPOL_ERR;
+			}
+		} else {
+			cil_tree_log(current, CIL_ERR, "Expected true or false block in conditional");
+			return SEPOL_ERR;
+		}
+	}
+
+	return SEPOL_OK;
+}
+
 int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
 {
 	struct cil_list_item *i;
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index bda1565f..905761b0 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -61,6 +61,7 @@ int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[]
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
 int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
+int cil_verify_conditional_blocks(struct cil_tree_node *current);
 int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list);
 int __cil_verify_ranges(struct cil_list *list);
 int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
-- 
2.25.4

