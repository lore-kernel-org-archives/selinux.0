Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F802C433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05012208CA
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 18:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRp6DgZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgICSTK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICSTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 14:19:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F1C061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 11:19:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so3922415qke.13
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al56+JGbPLSBxmvgIn0mW5jXS2RHxFSNjWYNB7D434A=;
        b=HRp6DgZgev3zV46+bz9SAH/857hOpfVFRt63NIa4B+2U1e9q5UTPuaA2US7MFPu/B7
         RBWSqCCTHnlBz92Tlt4X4pf9vNQpkt84359uZHITM9i38Qa6zn+u9uIy8QjvyeweXwVf
         Rh1A8ES9ApBcHCDgMbwLI0t3G+OCYLh8wtOPSkZrVEwVMUDU4Ug0C/kc4ZNCOshugdzW
         NZAOSJEgZSXGxGaz2y9P07pagbsfZ/xyKU4rJ/6THoeKBcr7D1UfHPzGX4S58ZkxzWrv
         8pZ5KzEalwGT/J+AS767iQPIvfJGjo0DTRkOr0LRlA4w8FQz49d7dVfk6MGwfxpeXQx/
         X2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al56+JGbPLSBxmvgIn0mW5jXS2RHxFSNjWYNB7D434A=;
        b=H3mv6Ghi7lCDJeOVIkZBN3M6tbGkYiGp/1OyOh/Uc3mAu1AsQYYgkGpFJ3Msv8CtoY
         xDMmz+ds//NMLBQnRKfTxBnQh3RtmCKlT/91hlwJazrto6+zPMneTr9+7j18zCgvrFkz
         yRV+8NK92RnV381Nb3+3d+8hntN+FZ8Jb0cPpBMOPpbB7MqZLTcq/lZYhpdAXPfYZzbW
         86VpED1LlgtSLO9eJHp6fT1GPykiGL2T1ODIetUUMvfBDwtEXU6W6+uY5mWAW/Bjh5rR
         AxuDce7oHy387oZJoAeg1Ac0cMlTgU3OWz3zyc1GkGnkddPTgqB7OdeS2gbgD8WS+irA
         oRSw==
X-Gm-Message-State: AOAM532v223BPodkZeK5LTjUqW4Bpp6aF83RGHMd5J1unnZzl/qswUiQ
        wyo0i0Ta0vlHv676EHkr1CAXKTzB8nA=
X-Google-Smtp-Source: ABdhPJxkU6T3iJjYQvUiCzsFb+oS6AdOmxMDNRyZ/g96LIGYbPXK42UHsM6L20PpSWOqS8OmN3EsDQ==
X-Received: by 2002:a37:ef13:: with SMTP id j19mr4440084qkk.184.1599157147469;
        Thu, 03 Sep 2020 11:19:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id g184sm2729194qkd.51.2020.09.03.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:19:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Jonathan Hettwer <j2468h@gmail.com>
Subject: [PATCH] libsepol/cil: Give an error when constraint expressions exceed max depth
Date:   Thu,  3 Sep 2020 14:19:00 -0400
Message-Id: <20200903181900.81179-1-jwcart2@gmail.com>
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

Correctly calculate the depth of constraint expressions when building
the AST and give an error when the max depth is exceeded.

Reported-by: Jonathan Hettwer <j2468h@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 60ecaaff..29a3d060 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2738,7 +2738,7 @@ exit:
 	return SEPOL_ERR;
 }
 
-static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr, int *depth)
+static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr, int depth)
 {
 	int rc = SEPOL_ERR;
 	enum cil_flavor op;
@@ -2750,8 +2750,9 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		goto exit;
 	}
 
-	if (*depth > CEXPR_MAXDEPTH) {
-		cil_log(CIL_ERR, "Max depth of %d exceeded for constraint expression\n", CEXPR_MAXDEPTH);
+	if (depth >= CEXPR_MAXDEPTH) {
+		/* Error occurs when depth == CEXPR_MAXDEPTH */
+		cil_log(CIL_ERR, "Max depth of %d exceeded for constraint expression\n", CEXPR_MAXDEPTH-1);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
@@ -2769,14 +2770,13 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
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
+		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth+1);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2785,11 +2785,11 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		cil_list_append(*expr, CIL_LIST, lexpr);
 		break;
 	default:
-		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth);
+		rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth+1);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-		rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr, depth);
+		rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr, depth+1);
 		if (rc != SEPOL_OK) {
 			cil_list_destroy(&lexpr, CIL_TRUE);
 			goto exit;
@@ -2801,8 +2801,6 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		break;
 	}
 
-	(*depth)--;
-
 	return SEPOL_OK;
 exit:
 
@@ -2812,13 +2810,12 @@ exit:
 int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
 {
 	int rc = SEPOL_ERR;
-	int depth = 0;
 
 	if (current->cl_head == NULL) {
 		goto exit;
 	}
 
-	rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr, &depth);
+	rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr, 0);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-- 
2.25.4

