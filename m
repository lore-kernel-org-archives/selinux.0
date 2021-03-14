Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC5C433E9
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2534A64EB7
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhCNUSX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:18:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48312 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhCNURv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 16:17:51 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C862D5646B0
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 21:17:49 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/6] libsepol/cil: replace printf with proper cil_tree_log
Date:   Sun, 14 Mar 2021 21:16:49 +0100
Message-Id: <20210314201651.474432-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314201651.474432-1-nicolas.iooss@m4x.org>
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 21:17:50 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All functions of the CIL compiler use cil_log or cil_tree_log to report
errors, but in two places which still uses printf. Replace these printf
invocation with cil_tree_log.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 47cdf0e7c0b9..2ea106d63505 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2497,7 +2497,7 @@ int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
 
 	rc = cil_copy_ast(db, current, block_node);
 	if (rc != SEPOL_OK) {
-		printf("Failed to copy in, rc: %d\n", rc);
+		cil_tree_log(current, CIL_ERR, "Failed to copy in-statement");
 		goto exit;
 	}
 
@@ -2788,7 +2788,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 	macro_node = NODE(macro_datum);
 
 	if (macro_node->flavor != CIL_MACRO) {
-		printf("Failed to resolve %s to a macro\n", new_call->macro_str);
+		cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", new_call->macro_str);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
-- 
2.30.2

