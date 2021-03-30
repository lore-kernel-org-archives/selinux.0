Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE7C433E0
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C546619CF
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhC3RkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhC3Rjm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:42 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D335C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cx5so8542511qvb.10
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYTnDXTpvBeNq8hJ+xBU4NkkYyvt3ODJMg/G/eSCHk8=;
        b=n0jvsSXnUIxB46JEWMBSZ2pfI/uRmfaOUBJh0rt8c6bD8U8VGFDUO6REJ8K3f/Af0j
         PCh4XepyGMlubFBmJdTNv6G2hHK9rmixAEu5J7VghhT/x6wBNWH/v/YrDNrVkyHWpZY+
         Ab6F53u2A063vdmodcRIK+xKFVakT7bsb/apw/ea1tnoxySttKXS0PTpOK+X6Mt5upvc
         /XmHT/FmgqDp6Ijw2mYMYYZdSp5Ed85Zc7QEre18jKIwzaBPTjqK6f2CiZwbga2ZFoRY
         YWQpFfiwcIR+eewV7hMyH5U/6WgWs0FgCKE8yBSvlDWdJvV1f278UQyPBFaCC8QFPqTk
         BxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYTnDXTpvBeNq8hJ+xBU4NkkYyvt3ODJMg/G/eSCHk8=;
        b=PAE+2MrePwmHG1vmmo+yfmUL4NVulm5Mg1UHJkooJ1ekfTKVuz6s/5sA+aJaPZO1A5
         1NQlwx6zT2fpR2nsNK1xgqo3RL8FKVxTnleXquvpt/4V6X7ZrXnB/xgAjwib6rupuUID
         FG5l+hLuOwwUVqpcKHNMzWzRXLGQBTWHMSUDpzVzk+fvE75CXeI4gJiX44rZk4iJtxyY
         GkmSVl9gYysBQXFAZeeWunZl36LqghsSg82JFZkYUKvkc2am6yEoi/eUsEr+6096pPVl
         BabiJEUV9BgzhXwXTQV59TDYK6ZE0Xsqv8m2Ccwha84PubDqiHvr5TgypVFd2q+V6RN2
         JPeQ==
X-Gm-Message-State: AOAM532sC+r9oX5MRMQnK9uUF+LH82+9Rr9ijk2W+s4WZcqoBuP+Qg9J
        JpTALTBSAtqbihu7Rhk/SkLGNrmRuHpMDA==
X-Google-Smtp-Source: ABdhPJzLWYFO1htrBt73yF4KVVBmvWIIoDM6icqWOoidS4SFdH9XdBnS2Qx9kJ0hX4ERjqgTAM1jkA==
X-Received: by 2002:a05:6214:16c1:: with SMTP id d1mr31054532qvz.29.1617125981218;
        Tue, 30 Mar 2021 10:39:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:41 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 07/12] libsepol/cil: Check for statements not allowed in optional blocks
Date:   Tue, 30 Mar 2021 13:39:18 -0400
Message-Id: <20210330173920.281531-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While there are some checks for invalid statements in an optional
block when resolving the AST, there are no checks when building the
AST.

OSS-Fuzz found the following policy which caused a null dereference
in cil_tree_get_next_path().
  (blockinherit b3)
  (sid SID)
  (sidorder(SID))
  (optional o
    (ibpkeycon :(1 0)s)
    (block b3
      (filecon""block())
      (filecon""block())))

The problem is that the blockinherit copies block b3 before
the optional block is disabled. When the optional is disabled,
block b3 is deleted along with everything else in the optional.
Later, when filecon statements with the same path are found an
error message is produced and in trying to find out where the block
was copied from, the reference to the deleted block is used. The
error handling code assumes (rightly) that if something was copied
from a block then that block should still exist.

It is clear that in-statements, blocks, and macros cannot be in an
optional, because that allows nodes to be copied from the optional
block to somewhere outside even though the optional could be disabled
later. When optionals are disabled the AST is reset and the
resolution is restarted at the point of resolving macro calls, so
anything resolved before macro calls will never be re-resolved.
This includes tunableifs, in-statements, blockinherits,
blockabstracts, and macro definitions. Tunable declarations also
cannot be in an optional block because they are needed to resolve
tunableifs. It should be fine to allow blockinherit statements in
an optional, because that is copying nodes from outside the optional
to the optional and if the optional is later disabled, everything
will be deleted anyway.

Check and quit with an error if a tunable declaration, in-statement,
block, blockabstract, or macro definition is found within an
optional when either building or resolving the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c   | 32 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_resolve_ast.c |  4 +++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 457d3ee7..1fef25d4 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -52,6 +52,7 @@ struct cil_args_build {
 	struct cil_tree_node *tunif;
 	struct cil_tree_node *in;
 	struct cil_tree_node *macro;
+	struct cil_tree_node *optional;
 	struct cil_tree_node *boolif;
 };
 
@@ -6099,6 +6100,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	struct cil_tree_node *tunif = args->tunif;
 	struct cil_tree_node *in = args->in;
 	struct cil_tree_node *macro = args->macro;
+	struct cil_tree_node *optional = args->optional;
 	struct cil_tree_node *boolif = args->boolif;
 	struct cil_tree_node *ast_node = NULL;
 	int rc = SEPOL_ERR;
@@ -6149,6 +6151,18 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		}
 	}
 
+	if (optional != NULL) {
+		if (parse_current->data == CIL_KEY_TUNABLE ||
+			parse_current->data == CIL_KEY_IN ||
+			parse_current->data == CIL_KEY_BLOCK ||
+			parse_current->data == CIL_KEY_BLOCKABSTRACT ||
+			parse_current->data == CIL_KEY_MACRO) {
+			rc = SEPOL_ERR;
+			cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in optionals", (char *)parse_current->data);
+			goto exit;
+		}
+	}
+
 	if (boolif != NULL) {
 		if (parse_current->data != CIL_KEY_TUNABLEIF &&
 			parse_current->data != CIL_KEY_CALL &&
@@ -6490,6 +6504,10 @@ int __cil_build_ast_first_child_helper(__attribute__((unused)) struct cil_tree_n
 		args->macro = ast;
 	}
 
+	if (ast->flavor == CIL_OPTIONAL) {
+		args->optional = ast;
+	}
+
 	if (ast->flavor == CIL_BOOLEANIF) {
 		args->boolif = ast;
 	}
@@ -6520,6 +6538,19 @@ int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_current, void
 		args->macro = NULL;
 	}
 
+	if (ast->flavor == CIL_OPTIONAL) {
+		struct cil_tree_node *n = ast->parent;
+		args->optional = NULL;
+		/* Optionals can be nested */
+		while (n && n->flavor != CIL_ROOT) {
+			if (n->flavor == CIL_OPTIONAL) {
+				args->optional = n;
+				break;
+			}
+			n = n->parent;
+		}
+	}
+
 	if (ast->flavor == CIL_BOOLEANIF) {
 		args->boolif = NULL;
 	}
@@ -6548,6 +6579,7 @@ int cil_build_ast(struct cil_db *db, struct cil_tree_node *parse_tree, struct ci
 	extra_args.tunif = NULL;
 	extra_args.in = NULL;
 	extra_args.macro = NULL;
+	extra_args.optional = NULL;
 	extra_args.boolif = NULL;
 
 	rc = cil_tree_walk(parse_tree, __cil_build_ast_node_helper, __cil_build_ast_first_child_helper, __cil_build_ast_last_child_helper, &extra_args);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 56295a04..efff0f2e 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3808,8 +3808,10 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 
 	if (optional != NULL) {
 		if (node->flavor == CIL_TUNABLE ||
+			node->flavor == CIL_IN ||
+			node->flavor == CIL_BLOCK ||
+			node->flavor == CIL_BLOCKABSTRACT ||
 		    node->flavor == CIL_MACRO) {
-			/* tuanbles and macros are not allowed in optionals*/
 			cil_tree_log(node, CIL_ERR, "%s statement is not allowed in optionals", cil_node_to_string(node));
 			rc = SEPOL_ERR;
 			goto exit;
-- 
2.26.3

