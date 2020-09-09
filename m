Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12D4C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759BE21D6C
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCxUzaxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgIIU5J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIU5I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:57:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39EC061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 13:57:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id f11so2310834qvw.3
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3L0O2L3T+zX6rOQH8AzxPQvZ8FkPH/Z9S80DDI0C+E=;
        b=MCxUzaxUzzmNgd4R/I48p5+SmqhYLciBrVIKmlKDDZnAfbvQVgPyi8FK11IIxoFTzU
         2m+dmmTcyEJITIQmK5uFLbDRfQvPZQxx+zJLVeqklufNJKA15o/n+gDEi8OMKhmnFB4G
         y4dsFcaASHmOCCyP8lzZCct4gWqxrk0Iqkep+m7AwCfyWQtUHbo+CynpstB2g3iy3VW3
         xmkfkqgtnzGjAfexg18TvnXTXpUCPy9pWfVOCPJ4MSGp377wtVlCsi0KtyBni8M+ifyG
         G+h/28SbBMAgcqfcGfCrOLc1Z3tOjDKV+UwhzBo1IcgxHFYK1tA15EmzmvuZ+0Ws+uTz
         XKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3L0O2L3T+zX6rOQH8AzxPQvZ8FkPH/Z9S80DDI0C+E=;
        b=PSO/EgbvZfLSg5kIPd6fwxXB7GIs904O8I3ost6uUZRpsmL0wlHgERUKQXyIJy4aHL
         PVZwtAzXzG+A+8tQojMiaSIJUfLgD1ESI1BmtG2cS3wb8BIk2stKamvHr8C+xC5MMNw0
         RyRTZFFNyAvTAmgwr1E7/H0TOfFv0NEJJHujfcN7PqXFiZr4yzaYeJZ643UQdDSzRk3m
         RYt/vDh8G/AaCgDte188Irgo3/ieeVZkmvdcbmzdE1UhCLgW7kmhQPEOjB2zm7CzA0Kc
         NN+o2/qi8Ig63EGUEZUoeEAxj64HJ4cuIl2nGN27CsPZl3TWv1DCdkhGER7yZ1aDY2nQ
         IrNw==
X-Gm-Message-State: AOAM5323VnOqOK1sDdG+ws7u0PiSm5+Yo2OngL8g7frTgepaUP/lbHcY
        AmgymgJ1meAUlWInnLv6zZ5X4nZEV1g=
X-Google-Smtp-Source: ABdhPJyEDR8c5e9px84v5DD70sA8B2CQfOcbywqqdJgGkL3AV1FNcJkaQmNE4AKKF/aGVvDNSd6iKQ==
X-Received: by 2002:a0c:90c1:: with SMTP id p59mr4263747qvp.7.1599685026332;
        Wed, 09 Sep 2020 13:57:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l29sm4514524qtb.77.2020.09.09.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:57:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/cil: Validate conditional expressions before adding to binary policy
Date:   Wed,  9 Sep 2020 16:57:02 -0400
Message-Id: <20200909205702.282311-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL was not correctly determining the depth of conditional expressions
which prevented it from giving an error when the max depth was exceeded.
This allowed invalid policy binaries to be created.

Validate the conditional expression using the same logic that is used
when evaluating a conditional expression. This includes checking the
depth of the expression.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2 changes:
Return SEPOL_ERR or SEPOL_OK
Return SEPOL_OK if cond expr is valid
Return SEPOL_ERR if depth != 0 at the end

 libsepol/cil/src/cil_binary.c    | 50 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 26 +++++------------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 77266858..8575c3b1 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2176,6 +2176,51 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t *pdb, struct cil_list *cil_e
 	return SEPOL_OK;
 }
 
+int __cil_validate_cond_expr(cond_expr_t *cond_expr)
+{
+	cond_expr_t *e;
+	int depth = -1;
+
+	for (e = cond_expr; e != NULL; e = e->next) {
+		switch (e->expr_type) {
+		case COND_BOOL:
+			if (depth == (COND_EXPR_MAXDEPTH - 1)) {
+				cil_log(CIL_ERR,"Conditional expression exceeded max allowable depth\n");
+				return SEPOL_ERR;
+			}
+			depth++;
+			break;
+		case COND_NOT:
+			if (depth < 0) {
+				cil_log(CIL_ERR,"Invalid conditional expression\n");
+				return SEPOL_ERR;
+			}
+			break;
+		case COND_OR:
+		case COND_AND:
+		case COND_XOR:
+		case COND_EQ:
+		case COND_NEQ:
+			if (depth < 1) {
+				cil_log(CIL_ERR,"Invalid conditional expression\n");
+				return SEPOL_ERR;
+			}
+			depth--;
+			break;
+		default:
+			cil_log(CIL_ERR,"Invalid conditional expression\n");
+			return SEPOL_ERR;
+		}
+	}
+
+	if (depth != 0) {
+		cil_log(CIL_ERR,"Invalid conditional expression\n");
+		return SEPOL_ERR;
+	}
+
+	return SEPOL_OK;
+}
+
 int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -2204,6 +2249,11 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 		goto exit;
 	}
 
+	rc = __cil_validate_cond_expr(tmp_cond->expr);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	tmp_cond->true_list = &tmp_cl;
 
 	rc = cond_normalize_expr(pdb, tmp_cond);
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 60ecaaff..f1d5dcca 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2548,18 +2548,13 @@ static enum cil_flavor __cil_get_expr_operator_flavor(const char *op)
 	else return CIL_NONE;
 }
 
-static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr, int *depth);
+static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr);
 
-static int __cil_fill_expr_helper(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr, int *depth)
+static int __cil_fill_expr_helper(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
 	enum cil_flavor op;
 
-	if (flavor == CIL_BOOL && *depth > COND_EXPR_MAXDEPTH) {
-		cil_log(CIL_ERR, "Max depth of %d exceeded for boolean expression\n", COND_EXPR_MAXDEPTH);
-		goto exit;
-	}
-
 	op = __cil_get_expr_operator_flavor(current->data);
 
 	rc = cil_verify_expr_syntax(current, op, flavor);
@@ -2572,26 +2567,20 @@ static int __cil_fill_expr_helper(struct cil_tree_node *current, enum cil_flavor
 		current = current->next;
 	}
 
-	if (op == CIL_NONE || op == CIL_ALL) {
-		(*depth)++;
-	}
-
 	for (;current != NULL; current = current->next) {
-		rc = __cil_fill_expr(current, flavor, expr, depth);
+		rc = __cil_fill_expr(current, flavor, expr);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 	}
 
-	(*depth)--;
-
 	return SEPOL_OK;
 
 exit:
 	return rc;
 }
 
-static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr, int *depth)
+static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
 
@@ -2605,7 +2594,7 @@ static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor
 	} else {
 		struct cil_list *sub_expr;
 		cil_list_init(&sub_expr, flavor);
-		rc = __cil_fill_expr_helper(current->cl_head, flavor, sub_expr, depth);
+		rc = __cil_fill_expr_helper(current->cl_head, flavor, sub_expr);
 		if (rc != SEPOL_OK) {
 			cil_list_destroy(&sub_expr, CIL_TRUE);
 			goto exit;
@@ -2623,14 +2612,13 @@ exit:
 int cil_gen_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
 {
 	int rc = SEPOL_ERR;
-	int depth = 0;
 
 	cil_list_init(expr, flavor);
 
 	if (current->cl_head == NULL) {
-		rc = __cil_fill_expr(current, flavor, *expr, &depth);
+		rc = __cil_fill_expr(current, flavor, *expr);
 	} else {
-		rc = __cil_fill_expr_helper(current->cl_head, flavor, *expr, &depth);
+		rc = __cil_fill_expr_helper(current->cl_head, flavor, *expr);
 	}
 
 	if (rc != SEPOL_OK) {
-- 
2.25.4

