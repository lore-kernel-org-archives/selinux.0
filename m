Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32AC49EAB
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9A36124C
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 19:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFXUAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhFXUAj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 16:00:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7084C061756
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:58:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x6so3975794qvx.4
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IuotmkYntAR38acSz+qxrUNl7CU1zig0cw2lYzRypZY=;
        b=qxND/cdDPkZs6n4M+FplHi+YQ6ZxfbuUgMFKHefojxbA7rpaUlSrSqBpLFOHW4FjPm
         LdaWebgTu4JXw1PQVDH6HXfI3Aps8Pz76uU4o8K+K+DiW3VCARISXlNkmhMi33Kj/ViK
         btBwTms10kxMHCaOpoZhb7P5vYFkbFTOlAcwODHsmjkfK8RvOPIG74ccPTGLe+UleTG2
         Kh76Gqf4GSS3BIrdDt2KAvSfL9T79woHBZREK2lmvZ5ItFER3lfntiwpPir+sr1kBNp2
         ne6CA6DBjqgJsVI/8TiAIftRqAnGVilDvC3k1e59s/102cP664r6Up7Pz3iqZcvqYvqC
         9h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IuotmkYntAR38acSz+qxrUNl7CU1zig0cw2lYzRypZY=;
        b=DVu/8Davl0myI+jfPiCVnE46lrvBIDDt4/EReS5DPIAs2Qe9+2zYQx0chkwLSmlxrT
         CcmZCLldSyTAnFwtiAEMExjwJ2b7RQtVCo0r99SRKEib3Y9XkgdKXz+8/DEFZ9wlkufP
         KrUXlnnWRQWlpv/NsWEF+edAcHXbpP3GLTZS2aRdrv77Dm5f3FUvBo6CV2CkSIXoZV72
         TE91Sjj7K2qPkGZ8yGMJ3tLILbOPt+EDZIg46uCvzQBxqtW7Zx0u9HzY8Y+vOeHR3Bnr
         o1SQN6q13Mm8MslpdC7nW6SrloxgfxtT3akSuZNFhXD4bYSkqjC8mw6EM0rCWDrIo2O2
         2EmA==
X-Gm-Message-State: AOAM531xOhQlVMdgTvdJpdxuZdtnJtpSRTdom9oJq9Lg18HGRRb7vMVn
        IQCl3PSyYBVGUZ4sXlREkfRtvFxIEMiyrw==
X-Google-Smtp-Source: ABdhPJzFX6JFmPggBQ4y5ywsIfbbAx/UBoGI5kFhZT5tufc++MOTJo7zdnNvw9Ou96UV1eKEqwCG8w==
X-Received: by 2002:a0c:a362:: with SMTP id u89mr7010181qvu.50.1624564698764;
        Thu, 24 Jun 2021 12:58:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m19sm3257531qka.22.2021.06.24.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:58:18 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol/cil: Only reset AST if optional has a declaration
Date:   Thu, 24 Jun 2021 15:58:15 -0400
Message-Id: <20210624195815.148698-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624195815.148698-1-jwcart2@gmail.com>
References: <20210624195815.148698-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When disabling optionals, the AST needs to be reset only if one
of the optional blocks being disabled contains a declaration.

Call the function cil_tree_subtree_has_decl() for each optional
block being disabled and only reset the AST if one of them has
a declaration in it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 58 +++++++++++++++++-------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 5245cc15..0ea5b169 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4230,33 +4230,43 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 		if (changed) {
 			struct cil_list_item *item;
 			if (pass > CIL_PASS_CALL1) {
-				/* Need to re-resolve because an optional was disabled that contained
-				 * one or more declarations. We only need to reset to the call1 pass
-				 * because things done in the preceding passes aren't allowed in
-				 * optionals, and thus can't be disabled.
-				 * Note: set pass to CIL_PASS_CALL1 because the pass++ will increment
-				 * it to CIL_PASS_CALL2
-				 */
-				cil_log(CIL_INFO, "Resetting declarations\n");
-
-				if (pass >= CIL_PASS_MISC1) {
-					__cil_ordered_lists_reset(&extra_args.sidorder_lists);
-					__cil_ordered_lists_reset(&extra_args.classorder_lists);
-					__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
-					__cil_ordered_lists_reset(&extra_args.catorder_lists);
-					__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
-					cil_list_destroy(&db->sidorder, CIL_FALSE);
-					cil_list_destroy(&db->classorder, CIL_FALSE);
-					cil_list_destroy(&db->catorder, CIL_FALSE);
-					cil_list_destroy(&db->sensitivityorder, CIL_FALSE);
+				int has_decls = CIL_FALSE;
+
+				cil_list_for_each(item, extra_args.to_destroy) {
+					has_decls = cil_tree_subtree_has_decl(item->data);
+					if (has_decls) {
+						break;
+					}
 				}
 
-				pass = CIL_PASS_CALL1;
+				if (has_decls) {
+					/* Need to re-resolve because an optional was disabled that
+					 * contained one or more declarations.
+					 * Everything that needs to be reset comes after the
+					 * CIL_PASS_CALL2 pass. We set pass to CIL_PASS_CALL1 because
+					 * the pass++ will increment it to CIL_PASS_CALL2
+					 */
+					cil_log(CIL_INFO, "Resetting declarations\n");
+
+					if (pass >= CIL_PASS_MISC1) {
+						__cil_ordered_lists_reset(&extra_args.sidorder_lists);
+						__cil_ordered_lists_reset(&extra_args.classorder_lists);
+						__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
+						__cil_ordered_lists_reset(&extra_args.catorder_lists);
+						__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
+						cil_list_destroy(&db->sidorder, CIL_FALSE);
+						cil_list_destroy(&db->classorder, CIL_FALSE);
+						cil_list_destroy(&db->catorder, CIL_FALSE);
+						cil_list_destroy(&db->sensitivityorder, CIL_FALSE);
+					}
 
-				rc = cil_reset_ast(current);
-				if (rc != SEPOL_OK) {
-					cil_log(CIL_ERR, "Failed to reset declarations\n");
-					goto exit;
+					pass = CIL_PASS_CALL1;
+
+					rc = cil_reset_ast(current);
+					if (rc != SEPOL_OK) {
+						cil_log(CIL_ERR, "Failed to reset declarations\n");
+						goto exit;
+					}
 				}
 			}
 			cil_list_for_each(item, extra_args.to_destroy) {
-- 
2.26.3

