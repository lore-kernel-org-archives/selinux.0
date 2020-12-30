Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB5DC433E9
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B192222A
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL3UMh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:12:37 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36617 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UMh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 15:12:37 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 74303560618
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 21:11:55 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libsepol/cil: propagate failure of cil_fill_list()
Date:   Wed, 30 Dec 2020 21:11:41 +0100
Message-Id: <20201230201141.3455302-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230201141.3455302-1-nicolas.iooss@m4x.org>
References: <20201230201141.3455302-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 21:11:55 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
to compile the following policy:

    (optional o (validatetrans x (eq t3 (a ()))))

With some logs, secilc reports:

    Invalid syntax
    Destroying Parse Tree
    Resolving AST
    Failed to resolve validatetrans statement at fuzz:1
    Disabling optional 'o' at tmp.cil:1

So there is an "Invalid syntax" error, but the compilation continues.
Fix this issue by stopping the compilation when cil_fill_list() reports
an error:

    Invalid syntax
    Bad expression tree for constraint
    Bad validatetrans declaration at tmp.cil:1

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29061
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4caff3cb3c98..0ea90cf92186 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2713,7 +2713,11 @@ static int __cil_fill_constraint_leaf_expr(struct cil_tree_node *current, enum c
 		cil_list_append(*leaf_expr, CIL_STRING, current->next->next->data);
 	} else if (r_flavor == CIL_LIST) {
 		struct cil_list *sub_list;
-		cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
+		rc = cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
+		if (rc != SEPOL_OK) {
+			cil_list_destroy(leaf_expr, CIL_TRUE);
+			goto exit;
+		}
 		cil_list_append(*leaf_expr, CIL_LIST, sub_list);
 	} else {
 		cil_list_append(*leaf_expr, CIL_CONS_OPERAND, (void *)r_flavor);
-- 
2.29.2

