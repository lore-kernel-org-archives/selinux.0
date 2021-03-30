Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BCC433C1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F4F61987
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhC3Rkc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhC3RkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:40:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFE8C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id iu14so2977804qvb.4
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yny9H2x8eQhkR972OvTl7dzJF9oH3Jychjdp1cJ1Lek=;
        b=XvFdUk9yyQVewcI4/yu58S1RcmS14YBvLaNkUJliVMaFoqK7J5wLH/iolXDcsJifs1
         GODaJTcBV3jdd0+XxaWf7OlvygYqiHrl/c+V4uwLdVnzpEEd1pWRyYiCpcD517Vgfj4z
         aOu+NY5Tqsq0C0zDIN0cJd34/84YQLjtpAWw0fOM4sNcqJjEtl2KNjR6pusSGF85DiFU
         Zn7RZa1Wf1Fdffnmd9uEa+KfU9jZMGW6TLXy/tjtOrl3tCXS+zf1toi3APpUPUrBpV1Z
         ukAy6BMM88YLLLNhf2AliGYVYWCnvR5pOgcOfsMylmKIUwBeZJRge7YLSyCFeArKH5qO
         l3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yny9H2x8eQhkR972OvTl7dzJF9oH3Jychjdp1cJ1Lek=;
        b=YeL9OX+dt9MGlBeMAcsTEmatKlCLi9srC6quUR32IHr5yafIchaqWoXu4xv7OR60nd
         zNd6+wRtZ+RU/uhTN5HRLibBIpFsD6KUDfTJQqFYU8t20ckOYsm9Eo43/AVIgAnheaX7
         GtcGbkj8A3KCMUEgLgVhTF159teFDs3HFjeZv5GK0nb1cLIkQ+gDtdKSABCL+NgKBgej
         YMHc6NQJdp1P/AIxhj+RWsYIi2ZVejD6XffYaoZjbM/1zegkPFzc4Vy4x/yJUMhb6vh+
         hl8vSEYBHAumS2Ds3lG/3M12mjg9KDNTWu6jhapqlY9F10OqRKB/Kk4zlhVx+2Qiyeo2
         8NJw==
X-Gm-Message-State: AOAM532EJd6tqPf3sscfGOTpPiaSypvYVPXmVi5CaBzEBjaPfP91lHta
        EIf3G34184HKcyQqz2bhCJDo6v8y/Nd/nw==
X-Google-Smtp-Source: ABdhPJwI/FhD44ANLeBAO+nb2gRZBdN3V83xsyrSQ/VwBxyxNPtfJfNnoO8QxaKMdw7i0Xh3D6Em1A==
X-Received: by 2002:a0c:e2d2:: with SMTP id t18mr31466872qvl.61.1617126007844;
        Tue, 30 Mar 2021 10:40:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z11sm16295118qkg.52.2021.03.30.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:40:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/12] libsepol/cil: Make invalid statement error messages consistent
Date:   Tue, 30 Mar 2021 13:40:01 -0400
Message-Id: <20210330174003.281613-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a consistent style for the error messages when an invalid
statement is found within tunableif, in-statement, block, macro,
optional, and booleanif blocks.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c   | 17 ++++++-----------
 libsepol/cil/src/cil_resolve_ast.c | 10 +++++-----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index df7bb950..1e35b8bd 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6123,8 +6123,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	if (tunif != NULL) {
 		if (parse_current->data == CIL_KEY_TUNABLE) {
 			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "Found tunable");
-			cil_log(CIL_ERR, "Tunables cannot be defined within tunableif statement\n");
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in tunableif", (char *)parse_current->data);
 			goto exit;
 		}
 	}
@@ -6133,8 +6132,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		if (parse_current->data == CIL_KEY_TUNABLE ||
 			parse_current->data == CIL_KEY_IN) {
 			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "Found in-statement");
-			cil_log(CIL_ERR, "in-statements cannot be defined within in-statements\n");
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in in-statement", (char *)parse_current->data);
 			goto exit;
 		}
 	}
@@ -6147,7 +6145,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
 			parse_current->data == CIL_KEY_MACRO) {
 			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in macros", (char *)parse_current->data);
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in macro", (char *)parse_current->data);
 			goto exit;
 		}
 	}
@@ -6159,7 +6157,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
 			parse_current->data == CIL_KEY_MACRO) {
 			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in optionals", (char *)parse_current->data);
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in optional", (char *)parse_current->data);
 			goto exit;
 		}
 	}
@@ -6176,13 +6174,10 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data != CIL_KEY_TYPECHANGE &&
 			parse_current->data != CIL_KEY_TYPEMEMBER) {
 			rc = SEPOL_ERR;
-			cil_tree_log(parse_current, CIL_ERR, "Found %s", (char*)parse_current->data);
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
-				cil_log(CIL_ERR, "%s cannot be defined within tunableif statement (treated as a booleanif due to preserve-tunables)\n",
-						(char*)parse_current->data);
+				cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in tunableif being treated as a booleanif", (char *)parse_current->data);
 			} else {
-				cil_log(CIL_ERR, "%s cannot be defined within booleanif statement\n",
-						(char*)parse_current->data);
+				cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in booleanif", (char *)parse_current->data);
 			}
 			goto exit;
 		}
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 7229a3b4..872b6799 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3789,7 +3789,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	if (block != NULL) {
 		if (node->flavor == CIL_CAT ||
 		    node->flavor == CIL_SENS) {
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in blocks", cil_node_to_string(node));
+			cil_tree_log(node, CIL_ERR, "%s is not allowed in block", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3802,7 +3802,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		    node->flavor == CIL_BLOCKINHERIT ||
 		    node->flavor == CIL_BLOCKABSTRACT ||
 		    node->flavor == CIL_MACRO) {
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in macros", cil_node_to_string(node));
+			cil_tree_log(node, CIL_ERR, "%s is not allowed in macro", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3814,7 +3814,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 			node->flavor == CIL_BLOCK ||
 			node->flavor == CIL_BLOCKABSTRACT ||
 		    node->flavor == CIL_MACRO) {
-			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
+			cil_tree_log(node, CIL_ERR, "%s is not allowed in optional", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
 		}
@@ -3836,9 +3836,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		}
 		if (rc == SEPOL_ERR) {
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
-				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs (tunableif treated as a booleanif)", cil_node_to_string(node));
+				cil_tree_log(node, CIL_ERR, "%s is not allowed in tunableif being treated as a booleanif", cil_node_to_string(node));
 			} else {
-				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs", cil_node_to_string(node));
+				cil_tree_log(node, CIL_ERR, "%s is not allowed in booleanif", cil_node_to_string(node));
 			}
 			goto exit;
 		}
-- 
2.26.3

