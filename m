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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10468C4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F182A60EB9
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhHQUWg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhHQUWc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 16:22:32 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B91C0612AD
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 13:20:39 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c14so379066qvs.9
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiO72huJQy7Bs+73rWGgr0uqHOoZ+eQpEEolz2qCGjI=;
        b=vWGpiIR1rQc7ITXNsoxJi6ead203Vg5Aj7Q13gUAHr9LGjql67lPVa2eSEEg2BQf45
         Orb+ou5r/G32fzAxlQMdPKM4CRKBdSCD6Aoa0G8+oobAdaJkFuqJUMdtugHGLZ4aAwua
         jvpy+lsuvQ37RztTHGnK2EyqmE1NQmOXrWETHOYWfz9hkpcwd5Xo4zRZCFbGKGflLES8
         OzyVIFmOzNbsCs26DQJZFEN292rlL+SBSR4f5thC9vujNsY89SJf7363FtORAieiOxxG
         XWg7OX/uf0xtaR5lvetQsEChXK8tNQWedlIqxDjFl4E3LMkU/ZtA6PyWDgYmpJigQPs1
         VBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiO72huJQy7Bs+73rWGgr0uqHOoZ+eQpEEolz2qCGjI=;
        b=X4WPM+pQJY43amGKqmsbvNFbUMvJRJo1KGyoDgig0xJY2ebTyK3S02Zj2JlAjm53yx
         5yCFrBc0qZDJAwG5lPyqXuRwwhWyPML/3401m923e6Tkbcz9Me1QbKTRQz8QAY1aOZe5
         eOFdgKRG6Wr4oijWRBPYgMm8iLQ8HhYgeIGK/9CYtBBAy4sxmEBmlV3AAxe/xWBkqOQK
         ktCSV4OqzOz4/9k4HiAeCjeiXUxfXUUGRZWKN1BMk/JGIBxlJUxHRhKnbEpcE0N7g0FU
         Eva6HUnJcagJqrfeEemiZprf8FW5NAW0cDBJJ2kbZibQothMlTOOBzoOWGW69czRtNGo
         Q00Q==
X-Gm-Message-State: AOAM532ImQS9hrV2RQpG9h8fxPLj2fMZSikNVmKVeIX4vPOeJFLcNwMo
        zmbBRWZR1eXtePmt9fDzFoXOqnoev+FrKQ==
X-Google-Smtp-Source: ABdhPJxPO3KX8lpCa/EDZZs1DD1/pRAKAaFad0E93wetSr9YWRxGVRb5997nhVacm5x0Jt6+xTzi5w==
X-Received: by 2002:a0c:c490:: with SMTP id u16mr5121843qvi.26.1629231638882;
        Tue, 17 Aug 2021 13:20:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm2075529qkm.56.2021.08.17.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:20:38 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/8 v2] libsepol/cil: When writing AST use line marks for src_info nodes
Date:   Tue, 17 Aug 2021 16:20:33 -0400
Message-Id: <20210817202033.964783-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In order to retain as much information as possible, when writing
out the CIL AST, use line mark notation to write out src_info
nodes. This includes using line marks to denote the original CIL
files the AST comes from.

The line numbers will not always be exactly correct because any
blank lines and comments in the original files will not be
represented in the AST.

Line marks are not written for the parse tree because the line
numbers will be widely inaccurate since each token will be on
a different line.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_write_ast.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 186070c1..d7f00bcc 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -546,6 +546,18 @@ static const char *macro_param_flavor_to_string(enum cil_flavor flavor)
 	return str;
 }
 
+void cil_write_src_info_node(FILE *out, struct cil_tree_node *node)
+{
+	struct cil_src_info *info = node->data;
+	if (info->kind == CIL_KEY_SRC_CIL || info->kind == CIL_KEY_SRC_HLL_LMS) {
+		fprintf(out, ";;* lms %u %s\n", info->hll_line, info->path);
+	} else if (info->kind == CIL_KEY_SRC_HLL_LMX) {
+		fprintf(out, ";;* lmx %u %s\n", info->hll_line, info->path);
+	} else {
+		fprintf(out, ";;* <?SRC_INFO_KIND> %u %s\n", info->hll_line, info->path);
+	}
+}
+
 void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 {
 	if (!node->data) {
@@ -1508,8 +1520,10 @@ static int __write_cil_ast_node_helper(struct cil_tree_node *node, uint32_t *fin
 {
 	struct cil_write_ast_args *args = extra_args;
 
-	if (node->flavor == CIL_SRC_INFO)
+	if (node->flavor == CIL_SRC_INFO) {
+		cil_write_src_info_node(args->out, node);
 		return SEPOL_OK;
+	}
 
 	fprintf(args->out, "%*s", args->depth*4, "");
 
@@ -1539,7 +1553,10 @@ static int __write_cil_ast_last_child_helper(struct cil_tree_node *node, void *e
 	struct cil_write_ast_args *args = extra_args;
 	struct cil_tree_node *parent = node->parent;
 
-	if (parent->flavor == CIL_SRC_INFO || parent->flavor == CIL_ROOT) {
+	if (parent->flavor == CIL_ROOT) {
+		return SEPOL_OK;
+	} else if (parent->flavor == CIL_SRC_INFO) {
+		fprintf(args->out, ";;* lme\n");
 		return SEPOL_OK;
 	}
 
-- 
2.31.1

