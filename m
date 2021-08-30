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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB5C432BE
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DD60FD9
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhH3SZm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhH3SZm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Aug 2021 14:25:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF6C061575
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b64so16856610qkg.0
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJSxzqV/JNhIgGpJRvbRPT4gzCE6dgjbtTAZDlehGK4=;
        b=o8aJlQ1sV2rBsUGfUjnNOY/j/tRdThu4wAJxcZIoDoX3f0hAbO6gGrZai4dsNgbmlv
         fClmb/KKw/6ov4pYF2PXEZaUKnaz84/c74gv8xV9uhIdAdC4QpXcvlV1lFc0LLBgdmNW
         7/zvHTLsm+xiXdFw7DrTZN24igDp5kJlEbvTvqjP0/x1ofan1zi5eyG8XYfj623kH2VE
         QHo7V7CULqhfpvo5IhiN+bJZEkPwmI0ywbpHcJUUM6v91CBr4qOrVkDJ/qqbS0UqibKx
         IA/P3bhw9bfNYMX9BgLSLhcrkxzYgGbVkbSoM7WBMRX/D8kHxPCLiK6jyl1j7thbOIke
         CghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJSxzqV/JNhIgGpJRvbRPT4gzCE6dgjbtTAZDlehGK4=;
        b=sW8t8HrYcJcxh8f7GCJmpqAJbERsmMd1vdo9rM6ubF1L4L2tECGASf58wzsr1oTt6j
         66yUGjwCbKLd7HQ4fRXTd6QcxPEKKU0p6cIdgWBuQsaUm/6zhhMkSbSOgJshj8onNpVK
         UjyOuqYwuL/klOjdgm5dE0EgwcoRFQrm53YIhTb0i33W62g2DJmZTaDDs21BKTbKdqbB
         0IWL74Tn9bQd+pYIPoDBbBGzneI5pbZ82dUQE0WVcMIra/pWYfoUo3D+HRTknKKDYy/v
         8IiHBFImII2BNYXY4foSKWmxU7pVAOawi0KH+QuRH9WmUlEzvCrijR9buS0F4+H2pXq6
         tyHQ==
X-Gm-Message-State: AOAM533PwqCY9l8KYyRrrLiQfJMXytqThQASuADhB99pr4DILDZRHsC2
        gVQ/bzDbM2EmDktD/6nIlUYUoGS9vlA=
X-Google-Smtp-Source: ABdhPJzpvTf4cYux6x3q2uU8Hmg6SMTrQHZ+aFWzLPGupLiMePXf1Ly9xSmbte0zmVbd8NpIZRfw+A==
X-Received: by 2002:a05:620a:2988:: with SMTP id r8mr24482458qkp.445.1630347887084;
        Mon, 30 Aug 2021 11:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm11581572qkm.56.2021.08.30.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:24:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Don't destroy optionals whose parent will be destroyed
Date:   Mon, 30 Aug 2021 14:24:40 -0400
Message-Id: <20210830182442.491886-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If an optional that is to be disabled is the child of an optional that
is going to be disabled, then there is no reason to add that optional
to the stack of disabled optionals, because it is going to be destroyed
anyways. This means that there is no reason to maintain a stack of
disabled optionals at all.

Instead of using a stack to track disabled optionals, use a pointer
that points to the top-most optional that is to be disabled. When a
rule fails to resolve in an optional, if the disabled optional pointer
has not been set, then set it to that optional. If the pointer has
been set already, then the optional is already going to be destroyed,
so nothing else needs to be done. The resolution failure and the fact
that the optional is being disabled is reported in either case.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 18007324..aeedc7dd 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -56,6 +56,7 @@ struct cil_args_resolve {
 	struct cil_tree_node *block;
 	struct cil_tree_node *macro;
 	struct cil_tree_node *optional;
+	struct cil_tree_node *disabled_optional;
 	struct cil_tree_node *boolif;
 	struct cil_list *sidorder_lists;
 	struct cil_list *classorder_lists;
@@ -63,7 +64,6 @@ struct cil_args_resolve {
 	struct cil_list *catorder_lists;
 	struct cil_list *sensitivityorder_lists;
 	struct cil_list *in_list;
-	struct cil_stack *disabled_optionals;
 };
 
 static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
@@ -3873,7 +3873,6 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	struct cil_tree_node *macro = args->macro;
 	struct cil_tree_node *optional = args->optional;
 	struct cil_tree_node *boolif = args->boolif;
-	struct cil_stack *disabled_optionals = args->disabled_optionals;
 
 	if (node == NULL) {
 		goto exit;
@@ -3956,7 +3955,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		if (optional == NULL) {
 			cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
 		} else {
-			cil_stack_push(disabled_optionals, CIL_NODE, optional);
+			if (!args->disabled_optional) {
+				args->disabled_optional = optional;
+			}
 			cil_tree_log(node, CIL_INFO, "Failed to resolve %s statement", cil_node_to_string(node));
 			cil_tree_log(optional, CIL_INFO, "Disabling optional '%s'", DATUM(optional->data)->name);
 			rc = SEPOL_OK;
@@ -4003,7 +4004,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 {
 	int rc = SEPOL_ERR;
 	struct cil_args_resolve *args = extra_args;
-	struct cil_stack *disabled_optionals = args->disabled_optionals;
 	struct cil_tree_node *parent = NULL;
 
 	if (current == NULL ||  extra_args == NULL) {
@@ -4026,11 +4026,10 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 		args->macro = NULL;
 	} else if (parent->flavor == CIL_OPTIONAL) {
 		struct cil_tree_node *n = parent->parent;
-		struct cil_stack_item *item = cil_stack_peek(disabled_optionals);
-		if (item && item->data == parent) {
-			cil_stack_pop(disabled_optionals);
+		if (args->disabled_optional == parent) {
 			*(args->changed) = CIL_TRUE;
 			cil_list_append(args->to_destroy, CIL_NODE, parent);
+			args->disabled_optional = NULL;
 		}
 		args->optional = NULL;
 		while (n && n->flavor != CIL_ROOT) {
@@ -4067,6 +4066,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.block = NULL;
 	extra_args.macro = NULL;
 	extra_args.optional = NULL;
+	extra_args.disabled_optional = NULL;
 	extra_args.boolif= NULL;
 	extra_args.sidorder_lists = NULL;
 	extra_args.classorder_lists = NULL;
@@ -4074,7 +4074,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.catorder_lists = NULL;
 	extra_args.sensitivityorder_lists = NULL;
 	extra_args.in_list = NULL;
-	extra_args.disabled_optionals = NULL;
 
 	cil_list_init(&extra_args.to_destroy, CIL_NODE);
 	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
@@ -4083,7 +4082,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.in_list, CIL_IN);
-	cil_stack_init(&extra_args.disabled_optionals);
 
 	for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
 		extra_args.pass = pass;
@@ -4218,7 +4216,6 @@ exit:
 	__cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
 	cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list, CIL_FALSE);
-	cil_stack_destroy(&extra_args.disabled_optionals);
 
 	return rc;
 }
-- 
2.31.1

