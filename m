Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BDC433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 20:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC40206DC
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 20:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi7llGg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJOUn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732734AbgJOUn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 16:43:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FAEC061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 13:43:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j13so6372579ilc.4
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdTNCF12wBZZC3NS60mOokVJLbe1fbfIWp5dXsDA0Y4=;
        b=Zi7llGg/3MxHu4KOHSKIt/nTdpbpDcUUfsTGVswxUk4p8xB9s3QkMKn6WXI658fruI
         Ztq7iTMiV48Z8+gH0EkrMIBgsDr2sXiEMLaBxHf2AB5wpHAucK9djfRE7KCzpsN8GRbn
         yt72s8gukjuo+W9rrTkF1kSo1BBjd3PKVhs64jfLNO8tubs+NiltFFjBR+UX7KupXSvI
         fQOCHIdFCuXpUmXCNkH2PqnNCZ+hwi5F53cvSpGiBKSwjyE1gh5yB6MO2A1BFBS+1eOX
         GrFvgSGo6+tgrNZpNgfaQOYZ6YFmdlLRMkdU/yZWcYsrsNuw8PePh/SqkPSkkI/u9Hxy
         k/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdTNCF12wBZZC3NS60mOokVJLbe1fbfIWp5dXsDA0Y4=;
        b=HmeeoEA1iuHtOV3nGEumLlfyFXXNpAd7/m46NHLFYXlDLZrp9ClZ5TP+GoTEFoFJTB
         6fcBjcd+AigbMAg16g1DJECZJo4dDk3+i91jXyTpdoFSNAQgxzCatX3LB07LZ/p0ZFGr
         zw6jHM7so+QmHXocLW2531SJmXXdcbCK8jQF1W4rPgDtg72RjoYbHfo57gX/+UeXL6VY
         z9Jv59wqNQsWYoqAVrVv5dI2bpDhUmCZTaxDE7hbPolAcFRIrl/tiqQaTvXMnmLG4hcv
         Q+pXS+snRiINxQ2bC6OwRts2efg0Hf0sRfqjDwLcXUk1y+08deY4aFRslzLJQ7SQLDGX
         clFg==
X-Gm-Message-State: AOAM531k2iMEP5JfUut+NHPconVR1nN//OImPs4NoB0X3Y/Kp4l1kg4m
        39NCLnvdTEUJD/SNUcp7lVLtkHXnGCw=
X-Google-Smtp-Source: ABdhPJxa60QYot/IObtgLhrJlJQ8wZxb2eKWs6LiPbSytrds5w7CfJpc2fhF+WorhVSP6NcbatluAg==
X-Received: by 2002:a92:cd05:: with SMTP id z5mr288464iln.15.1602794636178;
        Thu, 15 Oct 2020 13:43:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id w22sm200789iob.32.2020.10.15.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:43:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Give error for more than one true or false block
Date:   Thu, 15 Oct 2020 16:43:52 -0400
Message-Id: <20201015204352.569018-1-jwcart2@gmail.com>
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
index c73bbeee..7b3d2a8b 100644
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
+		cil_tree_log(current,CIL_ERR,"Expected true or false block in conditional");
+		return SEPOL_ERR;
+	}
+
+	current = current->next;
+	if (current != NULL) {
+		if (current->cl_head->data == CIL_KEY_CONDTRUE) {
+			if (found_true) {
+				cil_tree_log(current,CIL_ERR,"More than one true block in conditional");
+				return SEPOL_ERR;
+			}
+		} else if (current->cl_head->data == CIL_KEY_CONDFALSE) {
+			if (found_false) {
+				cil_tree_log(current,CIL_ERR,"More than one false block in conditional");
+				return SEPOL_ERR;
+			}
+		} else {
+			cil_tree_log(current,CIL_ERR,"Expected true or false block in conditional");
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

