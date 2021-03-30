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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F4C433E6
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2504961864
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhC3RkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhC3Rjl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC799C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y5so16662038qkl.9
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdhepQu/VI4XTPfQ68flEPHwC1x02TMrebAN5BlNslo=;
        b=nbA2FgRC7BsArtj/6W8v01XTG1FbR4YWx1rDAPW/Q1yGOp3fyVPVVToUQqz85V9gbF
         4mMtzValXfDvMSm3tNvD2QucXdpS1ssknmOwSkeMnnh2GWtoTBrvxRkuDPDniCSc3d+1
         ilEiTdW2dfUd/alm5rpMpe/Ccyg6ovILI5TDm167hkvOYMSykZj0U8HTmnI2u15Y6Hny
         w7sQdZJlkF533crIC9gCN008Fei+G9+Pk6W/P3TmTVpYOEIwHTcFgVcxASQXYeRV6+cX
         sTkEXg5DZNjAwP3gE63X4eu/GnAP8MyqsAU3GYMyymfbLp9LhTMRgoLbuJv1wjqz3amG
         9MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdhepQu/VI4XTPfQ68flEPHwC1x02TMrebAN5BlNslo=;
        b=TxaNvecE8xTdEu9Aten2Xp3aoG3VgksS8kH/QuPv70ZqX7CuoZtOSLj09CHHJUH4tP
         Y5IHdMe/lzmoFSl0oObon/8/VIWBYyUg802q7tYGeDfogYKyDJY+UHaRO9/nIe2UsLQI
         71UYHQiQUq/RLtdpVKT8A1Sd5KIbHiPJhY+CMazNtpT42LVFXilIP+zUfTxu7nSUkqTP
         iOQq6c3AdM9PGrRhgIfGm/YvXi7ynEHrK1aARcQcnuCnqfNlv4q2imNeLCYucCLYcWpI
         rkWOt67ZuKVyQ4j5agEm9/+CquvCVSc27+x+QthbOgTz5nIl1JLhnqcGqBzKvOFIumQb
         IbTg==
X-Gm-Message-State: AOAM533pvFHWgrbf1PcAaFwrc6T5xVPbMnBcvrHMS1qTKW1bhBqNhAxH
        6GChFzK+WtX0IUe8TNZt6W5pv2axSniZhQ==
X-Google-Smtp-Source: ABdhPJwLughT8Bp0VM0SYvt+RgphStHzZNWWEbGmrkxrrSXU8LHJs2iFhMeGZMOAFk2lz6W0Us/cRQ==
X-Received: by 2002:a05:620a:801:: with SMTP id s1mr30822191qks.152.1617125979834;
        Tue, 30 Mar 2021 10:39:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:39 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/12] libsepol/cil: Sync checks for invalid rules in booleanifs
Date:   Tue, 30 Mar 2021 13:39:17 -0400
Message-Id: <20210330173920.281531-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When building the AST, typemember rules in a booleanif block will
be incorrectly called invalid. They are allowed in the kernel
policy and should be allowed in CIL.

When resolving the AST, if a neverallow rule is copied into a
booleanif block, it will not be considered an invalid rule, even
though this is not allowed in the kernel policy.

Update the booleanif checks to allow typemember rules and to not
allow neverallow rules in booleanifs. Also use the same form of
conditional for the checks when building and resolving the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c   |  3 ++-
 libsepol/cil/src/cil_resolve_ast.c | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index c0783ba6..457d3ee7 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6158,7 +6158,8 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 			parse_current->data != CIL_KEY_DONTAUDIT &&
 			parse_current->data != CIL_KEY_AUDITALLOW &&
 			parse_current->data != CIL_KEY_TYPETRANSITION &&
-			parse_current->data != CIL_KEY_TYPECHANGE) {
+			parse_current->data != CIL_KEY_TYPECHANGE &&
+			parse_current->data != CIL_KEY_TYPEMEMBER) {
 			rc = SEPOL_ERR;
 			cil_tree_log(parse_current, CIL_ERR, "Found %s", (char*)parse_current->data);
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 93fc0d63..56295a04 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3774,7 +3774,7 @@ exit:
 
 int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
-	int rc = SEPOL_ERR;
+	int rc = SEPOL_OK;
 	struct cil_args_resolve *args = extra_args;
 	enum cil_pass pass = args->pass;
 	struct cil_tree_node *block = args->block;
@@ -3817,18 +3817,25 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	}
 
 	if (boolif != NULL) {
-		if (!(node->flavor == CIL_TUNABLEIF ||
-		      node->flavor == CIL_CALL ||
-		      node->flavor == CIL_CONDBLOCK ||
-		      node->flavor == CIL_AVRULE ||
-		      node->flavor == CIL_TYPE_RULE ||
-		      node->flavor == CIL_NAMETYPETRANSITION)) {
+		if (node->flavor != CIL_TUNABLEIF &&
+			node->flavor != CIL_CALL &&
+			node->flavor != CIL_CONDBLOCK &&
+			node->flavor != CIL_AVRULE &&
+			node->flavor != CIL_TYPE_RULE &&
+			node->flavor != CIL_NAMETYPETRANSITION) {
+			rc = SEPOL_ERR;
+		} else if (node->flavor == CIL_AVRULE) {
+			struct cil_avrule *rule = node->data;
+			if (rule->rule_kind == CIL_AVRULE_NEVERALLOW) {
+				rc = SEPOL_ERR;
+			}
+		}
+		if (rc == SEPOL_ERR) {
 			if (((struct cil_booleanif*)boolif->data)->preserved_tunable) {
 				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs (tunableif treated as a booleanif)", cil_node_to_string(node));
 			} else {
 				cil_tree_log(node, CIL_ERR, "%s statement is not allowed in booleanifs", cil_node_to_string(node));
 			}
-			rc = SEPOL_ERR;
 			goto exit;
 		}
 	}
-- 
2.26.3

