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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C509CC2D0A8
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898812087C
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llZ/d89D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgIIQdL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbgIIQdB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 12:33:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D0C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 09:32:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so2385604qtv.12
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9wmniWjHMtvpK7p8gjkmOWDZzc/AFCAObFnKUl1grc=;
        b=llZ/d89DnScQJjJUTbrF9gOAVGMfCXmrg2bdqM1jMKO/CGf5QqmrBBXu4Z7ERD1wBD
         EfnGg5luhfinTqS6DrhvybUtiEXe9BxYrjUQ0W1lWc1GW5JY0bKR4niU+mpHzLbAR11k
         cKai4hnLgaf4p2EqQXBeIJlsZOwB7Fk5bLDVLfgFTwGS/zpB8tc9UGDrqGAJwATRPofv
         QejExP90tHU5IGk/u69X8MBZCeloIyeMJGDgPu3zFiTNXz0hQnsAjrmSFaUn44jJfFjC
         KxsU+1spU9e31kJgc5N+iJR2WIFwI6VCWgs5KY+TpWTta2AAzkz+qqZfZ+sjtrPtnvO3
         AXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9wmniWjHMtvpK7p8gjkmOWDZzc/AFCAObFnKUl1grc=;
        b=euUb8k5AQKIQ0nxo+yok8j+iBHzmdMKLWJvZRQ913IDRvMSZqbeuNDNG1IsxkhV6sf
         a7MlYt+Wnp6LhlBmslmpn/8y8Drf261tJn4lWfOArvKZMxQXPnflCUet0bGck/bt9Mwx
         DAvaKUZnlaBORZ2R4eRHWqGcenagzaf9fOiaVYGVShA6IoCS6hqdbJvBwRJn6FyIMEKt
         q6c3urxsX7GX4JAs6RR+s5e2rJxCtZ+sApNvCw87WNIfE2ffnuymos9Id2aA9Sfi8Y7d
         bL65JIUyT2m65EwlW0dFCA/rcaAp7VrWmVYGOHQtwDKOCOQRqRV3j7mLP+O4qsLASMDs
         fXrQ==
X-Gm-Message-State: AOAM532DQiWBMcorOQ5erAlUQmV4kkpXIygx5qZ4udfdJNQhH2PLpcFG
        i5bayaxlZSgSj/6PnDm1DTBjOHjZP84=
X-Google-Smtp-Source: ABdhPJxsmcdVu9ZrM7MzvAsQJ59IF9PX0JDb45gqVQw9rQolaJq+0eLjkOXFAG2t7NyktfGvdCILbQ==
X-Received: by 2002:ac8:310c:: with SMTP id g12mr4023386qtb.281.1599669177355;
        Wed, 09 Sep 2020 09:32:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s30sm3611904qth.65.2020.09.09.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:32:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Jonathan Hettwer <j2468h@gmail.com>
Subject: [PATCH v2] libsepol/cil: Give an error when constraint expressions exceed max depth
Date:   Wed,  9 Sep 2020 12:32:45 -0400
Message-Id: <20200909163245.249011-1-jwcart2@gmail.com>
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

Check the depth of a constraint expression after converting it to the
postfix form used in the binary policy and give an error when the max
depth is exceeded.

Reported-by: Jonathan Hettwer <j2468h@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c    | 42 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.c | 20 ++++-----------
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 77266858..3131a63e 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2713,6 +2713,42 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
 	return SEPOL_OK;
 }
 
+int __cil_constrain_expr_check_depth(constraint_expr_t *sepol_expr)
+{
+	constraint_expr_t *e = sepol_expr;
+	int depth = -1;
+
+	while (e) {
+		switch (e->expr_type) {
+		case CEXPR_NOT:
+			if (depth < 0)
+				return SEPOL_ERR;
+			break;
+		case CEXPR_AND:
+		case CEXPR_OR:
+			if (depth < 1)
+				return SEPOL_ERR;
+			depth--;
+			break;
+		case CEXPR_ATTR:
+			if (depth == (CEXPR_MAXDEPTH - 1))
+				return SEPOL_ERR;
+			depth++;
+			break;
+		case CEXPR_NAMES:
+			if (depth == (CEXPR_MAXDEPTH - 1))
+				return SEPOL_ERR;
+			depth++;
+			break;
+		default:
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
@@ -2736,6 +2772,12 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
 		goto exit;
 	}
 
+	rc = __cil_constrain_expr_check_depth(sepol_expr);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
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

