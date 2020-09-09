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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD90C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 19:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B98021D7A
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9RBVMVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIITm1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITm0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 15:42:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083EC061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 12:42:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so3653342qkf.4
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZWelYxX1fa6DiEgXKRKP3QmYmM7Pnd5Zl2JM2MkVBQ=;
        b=X9RBVMVF1jQmkA15FUlt6C97+OvmYGSaU29iPMd3kDAAzU3Umuln7VLBIoAiHbo//q
         9rvY/vOZ+o/w4Zcsty8ttc4EZZhWfuuewD1Zz235Jd69jOsw4E0ufXpyygSm9rLx6AsS
         jJkMUxhtCQLcYFGtoCa0Z5R10DXwR3nqURLZhj5G52B/oSDYm1rZjEggIzpTVWenSJdA
         k1my4zC4HS+qJXksY0vxlSG6CwXyHi71xQFSc6UP45LcV3hM3oqbQQ0l3Fi1MS93XDRr
         JrlChdDSN9H/vEB6i4SoVA+m7lJI5DZV6vJ9/mqLnvQnVWW9AJR7OtbPMOpTnb1Yr7S2
         2elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZWelYxX1fa6DiEgXKRKP3QmYmM7Pnd5Zl2JM2MkVBQ=;
        b=R3+yxLNN8KT8uQnYArGjqKc/ve15IHXDJYQNCy8+BnbY8fdJE10Zj0NXEwK/qshiMT
         az6l39mvUxQ8sCgiK0uLEY+HZj9Fe74p4f+xRgzvi13Jhls6HrEoYK0tPNELzVT8gP5O
         oxhVFc+6DurVqN2l2qCa0rgbHD0sPeV9UyVA9q3aIdlkxHbkzaRZ5MQCUMyTEc5MF5/7
         5iCnWSsxHtX2tfSOqGgYihfHHO0WuiZQwrhzygGp9A5A0RMm5IFe8ZR//E6sML1L4E+8
         YtcGAhx9Ydqg/OyXZC0FJGgyGdDe766Q10KBQwBJBJnE4NcvurA3z7oGOqi7jGhGLy6i
         2xcA==
X-Gm-Message-State: AOAM53032R6nQxYkAn8aMK14CpmS5/ONA16ikSbYPTOKID8l9gNTdJ2D
        iyhFAjXWmUnodzLjaGbdpJtDOqqd/go=
X-Google-Smtp-Source: ABdhPJxWM6J9qqu3z0/d2byMx52z161aq1xBagKQTh13dOetN3GMPKXELV5gGs2wiFm+9Efu3eKwXg==
X-Received: by 2002:a05:620a:2213:: with SMTP id m19mr4678667qkh.472.1599680545401;
        Wed, 09 Sep 2020 12:42:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u55sm4435338qtu.42.2020.09.09.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:42:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Validate conditional expressions before adding to binary policy
Date:   Wed,  9 Sep 2020 15:42:22 -0400
Message-Id: <20200909194222.263841-1-jwcart2@gmail.com>
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
 libsepol/cil/src/cil_binary.c    | 43 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 26 ++++++-------------
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 77266858..d30233c4 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2176,6 +2176,44 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t *pdb, struct cil_list *cil_e
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
+				return -1;
+			}
+			depth++;
+			break;
+		case COND_NOT:
+			if (depth < 0) {
+				cil_log(CIL_ERR,"Invalid conditional expression\n");
+				return -1;
+			}
+			break;
+		case COND_OR:
+		case COND_AND:
+		case COND_XOR:
+		case COND_EQ:
+		case COND_NEQ:
+			if (depth < 1) {
+				cil_log(CIL_ERR,"Invalid conditional expression\n");
+				return -1;
+			}
+			depth--;
+			break;
+		default:
+			cil_log(CIL_ERR,"Invalid conditional expression\n");
+			return -1;
+		}
+	}
+}
+
 int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -2204,6 +2242,11 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
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

