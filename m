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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4989DC4320A
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3065D60231
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhHJSWV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbhHJSWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:03 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8DC07AF68
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f91so11394444qva.9
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AiO72huJQy7Bs+73rWGgr0uqHOoZ+eQpEEolz2qCGjI=;
        b=J6wvwW1ZojjLe2NPrfZZRxEUcd7jwpGC5i00/Gfv5UH+LpsYpO9rHDWDvqJcJCV2WP
         marbUEtlgNUInB6R20Jmn0Lb/wA+MMtVtqP08tYEqbrwne1wHmf/G6+ojr5Vy9sQL8aE
         EjilUqI65qAFRN7/UZB+immHcA/A24754o8t8JXIKKmFHTppimmqYp3LyDIFhamdCC7K
         /mZ0hIrbmnHFIDbQT2Fxa4Mjrj/8mdEMB8W1qagNLCBcNgV4TPuOJXSVHwztayyXgTis
         MY9c4mX9/PLfRtZxrsA7qtZkFA2fFD4wMV2UzBTftOhENJ4Wz05RE/+i0jjAGCikVrgX
         ZvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiO72huJQy7Bs+73rWGgr0uqHOoZ+eQpEEolz2qCGjI=;
        b=f8TgUkCW5+6At/eUcvYMxlZmnPtfGwg82uIQZ1xy71pgwCzd82kb0LAp8tyrK/XCYI
         u3ywHA68GzmF+8N+RjFtu2US6CGODOIkpTpswqcEPEsQdfMbGItbag/HYjCNX6M8uSxy
         L2yxX0XsdHm9mhpNzJjKOfyCxYIYaWPie+7wIs8xLC9N1jwwUwH1KwkwyzDzHIamF3U5
         NhvJLP97+PMftHIIwy1Wx+RzvjitHqnLCh6V8fUyEIKbYG6cixa+vq8uykGNySTQ44/O
         4BIERbqFjhsGVlW4LEyU4R3BVoHMhIperBp8900XEH5aFknJ+65t6X9o3cWKGh9yTo4d
         o/Kw==
X-Gm-Message-State: AOAM532n86SHF8AlpZNWJ3a6yVJGvOhPD/9qe2Do0eCaHfj7GvC3lc1v
        7W9Y35bc1PsXzhX7I19ef7tcpFdF4cpfhQ==
X-Google-Smtp-Source: ABdhPJyPu4Iu4hoNfeAcWpoGosODsJ0snkJHa95/e6Gv+VA5sNSlyMj9HsL5zPRnMHw9b7AXjcKUfw==
X-Received: by 2002:a0c:b408:: with SMTP id u8mr19439972qve.33.1628618748741;
        Tue, 10 Aug 2021 11:05:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:48 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 8/8] libsepol/cil: When writing AST use line marks for src_info nodes
Date:   Tue, 10 Aug 2021 14:05:37 -0400
Message-Id: <20210810180537.669439-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
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

