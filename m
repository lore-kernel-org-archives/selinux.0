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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF137C433DB
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DFC61987
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhC3RkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhC3Rjg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:36 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D8C061762
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:36 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q12so8550738qvc.8
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Ag07xrx/t83l3rxsOY16qxRYFZUr4mjPQY6Mk8SZkU=;
        b=H3hXAXvaOV9JOKMYO8rAQsGRlYSfhZWtbrS50g0eLL46oYxR11xsmJ5ZiQswa+a1Om
         qWn8WBOWjBjP8tVfq30ZNd7RLxCHNv3M9gA6Quiig5u5wgzMN7milQ0zoOKX3syyFdww
         0i7xCKm4NeDCyD88n+Z4DIEyYQZIhh+wI+HgyKE3pDoque5ICoQZrfa3Dp8BVBY0Wkj5
         92bgBCCT9vTwS0afRNhE1kaiQJxcOv5Aiogm1v3ayZkfh3xau+HNq6KLKVc5c2owR9tp
         JmK2FR8MpSmVNbn6rD2zXR+qNXESUV1+M4/R01l4l/zbV8OGjqpLdxUDSw/AiX9l9d67
         GBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ag07xrx/t83l3rxsOY16qxRYFZUr4mjPQY6Mk8SZkU=;
        b=myWku2qpnp36TbhFYmlHOE0iS+gDdaiXpLLjl8hIUK5gzFYz9WclmHuoYPe2ur5LoD
         uP5UDR2U9VrKqs2ackrtQcuxi9ikko0JZHnmvU978X5XTb9j6zd2aynBmSnBS/uv4xO2
         hB6Vl7nynVR16pxrW8vmZmkEBykjKZWwuZqfbBK3GC7GgqPlm7jvlUiNzibX0+csb+IS
         BCsGR607va99bYt5avmtLQSWmG6zsFVHr0C/se41dj3EqtOLFL++zzOikkKJ24Dz5fZq
         9Npg/lgeRrqyd7tGM4j9k4lLKbXmz7urUw0ZpWaygmcsY9OYFCRf8xzOGitmFeUsMaND
         zxCQ==
X-Gm-Message-State: AOAM532uo6WgsygjSld0d4qGd2SfFC+qMR3J3koxKOvv6buiubID/6V+
        J4TmWUDGCFvdhGJWMkgR4sKiRLoiBdHJkA==
X-Google-Smtp-Source: ABdhPJyyYePeZM7QxYqNQVfNYZ/ZIpCGHYKiNsI1WJNqR8p82dUClnilVtXmyDmcXQb4ubFiI+GprA==
X-Received: by 2002:ad4:5887:: with SMTP id dz7mr31968545qvb.12.1617125975314;
        Tue, 30 Mar 2021 10:39:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:35 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/12] libsepol/cil: Create new first child helper function for building AST
Date:   Tue, 30 Mar 2021 13:39:14 -0400
Message-Id: <20210330173920.281531-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In order to find statements not allowed in tunableifs, in-statements,
macros, and booleanifs, there are tree node pointers that point to
each of these kinds of statements when its block is being parsed.
If the pointer is non-NULL, then the rule being parsed is in the block
of that kind of statement.

The tree node pointers were being updated at the wrong point which
prevented an invalid statement from being found if it was the first
statement in the block of a tunableif, in-statement, macro, or
booleanif.

Create a first child helper function for walking the parse tree and
in that function set the appropriate tree node pointer if the
current AST node is a tunableif, in-statement, macro, or booleanif.
This also makes the code symmetrical with the last child helper
where the tree node pointers are set to NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index dd57ad82..c0783ba6 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6457,22 +6457,6 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 
 	if (rc == SEPOL_OK) {
 		if (ast_current->cl_head == NULL) {
-			if (ast_current->flavor == CIL_TUNABLEIF) {
-				args->tunif = ast_current;
-			}
-
-			if (ast_current->flavor == CIL_IN) {
-				args->in = ast_current;
-			}
-
-			if (ast_current->flavor == CIL_MACRO) {
-				args->macro = ast_current;
-			}
-
-			if (ast_current->flavor == CIL_BOOLEANIF) {
-				args->boolif = ast_current;
-			}
-
 			ast_current->cl_head = ast_node;
 		} else {
 			ast_current->cl_tail->next = ast_node;
@@ -6488,6 +6472,30 @@ exit:
 	return rc;
 }
 
+int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_node *parse_current, void *extra_args)
+{
+	struct cil_args_build *args = extra_args;
+	struct cil_tree_node *ast = args->ast;
+
+	if (ast->flavor == CIL_TUNABLEIF) {
+		args->tunif = ast;
+	}
+
+	if (ast->flavor == CIL_IN) {
+		args->in = ast;
+	}
+
+	if (ast->flavor == CIL_MACRO) {
+		args->macro = ast;
+	}
+
+	if (ast->flavor == CIL_BOOLEANIF) {
+		args->boolif = ast;
+	}
+
+	return SEPOL_OK;
+}
+
 int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void *extra_args)
 {
 	struct cil_args_build *args = extra_args;
@@ -6541,7 +6549,7 @@ int cil_build_ast(struct cil_db *db, struct cil_tree_node *parse_tree, struct ci
 	extra_args.macro = NULL;
 	extra_args.boolif = NULL;
 
-	rc = cil_tree_walk(parse_tree, __cil_build_ast_node_helper, NULL, __cil_build_ast_last_child_helper, &extra_args);
+	rc = cil_tree_walk(parse_tree, __cil_build_ast_node_helper, __cil_build_ast_first_child_helper, __cil_build_ast_last_child_helper, &extra_args);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-- 
2.26.3

