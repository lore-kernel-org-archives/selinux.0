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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB0C43461
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DEF21D7E
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMhYAibU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgIISYz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgIISYt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 14:24:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7474C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 11:24:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b13so2044904qvl.2
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUsLdBOoX4meTGFHAMbUEgnx4HKIeCq0mMwR44Hfm74=;
        b=JMhYAibUpWfFa4MGtM0A4xFJhuQt+fqTUPSMQMG1PRrcW7SxF8dGyEdkAOyUJCRftG
         7vJxF8tF2CUEL24pQWedB86F664vZjikjNUSKQn0IWYUo3ea+A84zRhLoCTdp3QjE4Co
         WMuCHaZhaBMA8TiufzpohIW+5xhdfFIBPGEjfvXE9uxYGbxDGSyYsbsWYVk3HXDPKaXa
         94T9Au/zoPiw8YKyv8pMQnGLsaCtnT+tZUiDzWvGrHY1Vc3z4ELRzAUYub4xeAYEvn0u
         U2ioqlqgiTwHjbyINxB5JQH/1ZT3G5GayUqq7mI58k6q1dZ2BtA55Xyh94JgryuLfbtp
         TK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUsLdBOoX4meTGFHAMbUEgnx4HKIeCq0mMwR44Hfm74=;
        b=ryzoybpjtMvb4BjneQ7DdYQ3eKliq5BwALa3GP1vXMK2qjQGOQbnEdEx/xTEvsBjAH
         OdjQkVAu5g+AmotCyxCCi/9C+wnfs+DQiKdDrKNlzmi/Eb+rOQ4i2A/LDgZFBcTMcUfW
         wyFds3RPsCwTJDkq1OhzbdbYmoYjD3nLV5XLDeVASn24j9UDrADPbZwGEFz/DbqiXLUW
         Vn8yBtH/DBHvz67ZIwO6RhsPpaC3DP9edA52gGb282zpO93j1cxSfxXSJvrqvxDeLIoO
         AZx1fJ35uwga4h+3kPiufq45B5vACwi/uM4IeEVHg7dx9J8SUq44tT9dVQXiKiBHlWlY
         85Bg==
X-Gm-Message-State: AOAM530VFmItS0U0HnORvsuD2YQb1vfZfmZ01hYAFnqGZXubnru5dIZn
        0aGliqPkuoulN8Z+g4dJfZHqAJeGYsQ=
X-Google-Smtp-Source: ABdhPJzQg0yuHDwbdz2gQFZzlQ8PV3zK23ATaXRDkdgyLcuWTw5bsmqx09S4rByfQWmmFWV12EIuTA==
X-Received: by 2002:ad4:56a6:: with SMTP id bd6mr5475002qvb.29.1599675887996;
        Wed, 09 Sep 2020 11:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e1sm3803116qtb.0.2020.09.09.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:24:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Jonathan Hettwer <j2468h@gmail.com>
Subject: [PATCH] libsepol/cil: Validate constraint expressions before adding to binary policy
Date:   Wed,  9 Sep 2020 14:24:44 -0400
Message-Id: <20200909182444.254828-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL was not correctly determining the depth of constraint expressions
which prevented it from giving an error when the max depth was exceeded.
This allowed invalid policy binaries with constraint expressions exceeding
the max depth to be created.

Validate the constraint expression using the same logic that is used
when reading the binary policy. This includes checking the depth of the
the expression.

Reported-by: Jonathan Hettwer <j2468h@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c    | 50 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 20 ++++---------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 77266858..0604db3c 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2713,6 +2713,51 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
 	return SEPOL_OK;
 }
 
+int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
+{
+	constraint_expr_t *e = sepol_expr;
+	int depth = -1;
+
+	while (e) {
+		switch (e->expr_type) {
+		case CEXPR_NOT:
+			if (depth < 0) {
+				cil_log(CIL_ERR,"Invalid constraint expression\n");
+				return SEPOL_ERR;
+			}
+			break;
+		case CEXPR_AND:
+		case CEXPR_OR:
+			if (depth < 1) {
+				cil_log(CIL_ERR,"Invalid constraint expression\n");
+				return SEPOL_ERR;
+			}
+			depth--;
+			break;
+		case CEXPR_ATTR:
+			if (depth == (CEXPR_MAXDEPTH - 1)) {
+				cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
+				return SEPOL_ERR;
+			}
+			depth++;
+			break;
+		case CEXPR_NAMES:
+			if (depth == (CEXPR_MAXDEPTH - 1)) {
+				cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
+				return SEPOL_ERR;
+			}
+			depth++;
+			break;
+		default:
+			cil_log(CIL_ERR,"Invalid constraint expression\n");
+			return SEPOL_ERR;
+		}
+		e = e->next;
+	}
+
+	return SEPOL_OK;
+}
+
 int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *class, struct cil_list *perms, struct cil_list *expr)
 {
 	int rc = SEPOL_ERR;
@@ -2736,6 +2781,11 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
 		goto exit;
 	}
 
+	rc = __cil_validate_constrain_expr(sepol_expr);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	sepol_constrain->expr = sepol_expr;
 	sepol_constrain->next = sepol_class->constraints;
 	sepol_class->constraints = sepol_constrain;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 60ecaaff..870c6923 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2738,7 +2738,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr, int *depth)
+static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
 {
 	int rc = SEPOL_ERR;
 	enum cil_flavor op;
@@ -2750,12 +2750,6 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		goto exit;
 	}
 
-	if (*depth > CEXPR_MAXDEPTH) {
-		cil_log(CIL_ERR, "Max depth of %d exceeded for constraint expression\n", CEXPR_MAXDEPTH);
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	op = __cil_get_constraint_operator_flavor(current->data);
 
 	rc = cil_verify_constraint_expr_syntax(current, op);
@@ -2769,14 +2763,13 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 	case CIL_CONS_DOM:
 	case CIL_CONS_DOMBY:
 	case CIL_CONS_INCOMP:
-		(*depth)++;
 		rc = __cil_fill_constraint_leaf_expr(current, flavor, op, expr);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
 		break;
 	case CIL_NOT:
-		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth);
+		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2785,11 +2778,11 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		cil_list_append(*expr, CIL_LIST, lexpr);
 		break;
 	default:
-		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth);
+		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-		rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr, depth);
+		rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr);
 		if (rc != SEPOL_OK) {
 			cil_list_destroy(&lexpr, CIL_TRUE);
 			goto exit;
@@ -2801,8 +2794,6 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		break;
 	}
 
-	(*depth)--;
-
 	return SEPOL_OK;
 exit:
 
@@ -2812,13 +2803,12 @@ exit:
 int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
 {
 	int rc = SEPOL_ERR;
-	int depth = 0;
 
 	if (current->cl_head == NULL) {
 		goto exit;
 	}
 
-	rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr, &depth);
+	rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-- 
2.25.4

