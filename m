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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F6C433E5
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE95619B1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhC3RkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhC3Rjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D738C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 30so8541063qva.9
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+IaRNib8GD1HsVBTVVqgpzCvjDurnSpzLgNlA4TgSpI=;
        b=hdhrkPz/7+dMC5D9XYDqpCoPU3qUEhimH8Az2bvhdqvGhnxYFQnzcDofeQczSDc/1Y
         wGiratDRaXijhonvZmNQ0X4ZmaoX+2ItdBFQ3GkE3h/QyzU3bpQoVBZg7OqdcyKJBMak
         wLBmrxna0oV7/0+3ZatOcaAn7SlhRvUH8+4c6TBYk/7eNPm8OwC9hhHGbmxgClJskltJ
         s7iL9BVbR11iY7mTuvXKz+yh0AVTrLDWPOstYy4QMhsFaWYbO9/4m9U+xKGlg9nlhA2+
         We1GFx/4XNRhZojUpQ1E214TAeAfqWrpJemwlTxzuknpLALZTme4Pnu86mMHS8y04ZBD
         FmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+IaRNib8GD1HsVBTVVqgpzCvjDurnSpzLgNlA4TgSpI=;
        b=ugrWZes/AtqqdiT3BefocxlzdTuC2VlHznCiogDyMKNlhEHZicBk3bwpxWYoVS0iuv
         UehwPh3GhBcsctZFZ+H9FDU+8hsosGrotQaJErA7snZeejDnrs4W9OJ31D35A53Qrsmn
         QiyvjuJSfiQjiGMWqTCUdmXRWsDI7ZcTsKJltONrl77mxLh8VBvCUqeyCuNh2N3YMQDg
         1aZJ+xZ7XSGqoVp36Df3NBrZg3EQftkRc5hggFVMqEgAlRf6U1E9GZdFkcKTOV5Ntm26
         v26CYDBq9RX0D+B47bqdMvOjE9t/yK4sBPv67SlerAoTJQQrNJJI+Qk4fHE9Q8h8jGyf
         fm6w==
X-Gm-Message-State: AOAM531ErQZnRG7fVo9D2yKg2Xvt/9OSOrvEg6iu0lvp3RkxwDPln0tc
        GEJ5Nb6wjyGNG4kv3pk2/jaSmRUnjN91/Q==
X-Google-Smtp-Source: ABdhPJxAxP4AVtPE5npaLi8jVxl5gyzAvzGmkVBaH0gwp1BgFXN0lQfwIJNKbWWdWByTaGX7x5ArmA==
X-Received: by 2002:a0c:f890:: with SMTP id u16mr31617152qvn.21.1617125972690;
        Tue, 30 Mar 2021 10:39:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:32 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/12] libsepol/cil: Cleanup build AST helper functions
Date:   Tue, 30 Mar 2021 13:39:13 -0400
Message-Id: <20210330173920.281531-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since parse_current, finished, and extra_args can never be NULL,
remove the useless check and directly assign local variables from
extra_args.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 44 ++++++++------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 1c530bbc..dd57ad82 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6093,28 +6093,16 @@ void cil_destroy_src_info(struct cil_src_info *info)
 
 int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *finished, void *extra_args)
 {
-	struct cil_args_build *args = NULL;
-	struct cil_tree_node *ast_current = NULL;
-	struct cil_db *db = NULL;
+	struct cil_args_build *args = extra_args;
+	struct cil_db *db = args->db;
+	struct cil_tree_node *ast_current = args->ast;
+	struct cil_tree_node *tunif = args->tunif;
+	struct cil_tree_node *in = args->in;
+	struct cil_tree_node *macro = args->macro;
+	struct cil_tree_node *boolif = args->boolif;
 	struct cil_tree_node *ast_node = NULL;
-	struct cil_tree_node *tunif = NULL;
-	struct cil_tree_node *in = NULL;
-	struct cil_tree_node *macro = NULL;
-	struct cil_tree_node *boolif = NULL;
 	int rc = SEPOL_ERR;
 
-	if (parse_current == NULL || finished == NULL || extra_args == NULL) {
-		goto exit;
-	}
-
-	args = extra_args;
-	ast_current = args->ast;
-	db = args->db;
-	tunif = args->tunif;
-	in = args->in;
-	macro = args->macro;
-	boolif = args->boolif;
-
 	if (parse_current->parent->cl_head != parse_current) {
 		/* ignore anything that isn't following a parenthesis */
 		rc = SEPOL_OK;
@@ -6502,20 +6490,11 @@ exit:
 
 int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void *extra_args)
 {
-	int rc = SEPOL_ERR;
-	struct cil_tree_node *ast = NULL;
-	struct cil_args_build *args = NULL;
-
-	if (extra_args == NULL) {
-		goto exit;
-	}
-
-	args = extra_args;
-	ast = args->ast;
+	struct cil_args_build *args = extra_args;
+	struct cil_tree_node *ast = args->ast;
 
 	if (ast->flavor == CIL_ROOT) {
-		rc = SEPOL_OK;
-		goto exit;
+		return SEPOL_OK;
 	}
 
 	args->ast = ast->parent;
@@ -6544,9 +6523,6 @@ int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void
 	cil_tree_children_destroy(parse_current->parent);
 
 	return SEPOL_OK;
-
-exit:
-	return rc;
 }
 
 int cil_build_ast(struct cil_db *db, struct cil_tree_node *parse_tree, struct cil_tree_node *ast)
-- 
2.26.3

