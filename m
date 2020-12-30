Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4CC433DB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314822222A
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3UMg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:12:36 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45584 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3UMg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 15:12:36 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AF7E0560618
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 21:11:54 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] libsepol/cil: do not add a stack variable to a list
Date:   Wed, 30 Dec 2020 21:11:40 +0100
Message-Id: <20201230201141.3455302-3-nicolas.iooss@m4x.org>
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

OSS-Fuzz found a heap use-after-free when the CIL compiler destroys its
database after failing to compile the following policy:

    (validatetrans x (eq t3 (a)))

This is caused by the fact that the validatetrans AST object references
a stack variable local to __cil_fill_constraint_leaf_expr, when parsing
the list "(a)":

    struct cil_list *sub_list;
    cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
    cil_list_append(*leaf_expr, CIL_LIST, &sub_list);

Drop the & sign to really add the list like it is supposed to be.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28507
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 0c9015cef578..4caff3cb3c98 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2714,7 +2714,7 @@ static int __cil_fill_constraint_leaf_expr(struct cil_tree_node *current, enum c
 	} else if (r_flavor == CIL_LIST) {
 		struct cil_list *sub_list;
 		cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
-		cil_list_append(*leaf_expr, CIL_LIST, &sub_list);
+		cil_list_append(*leaf_expr, CIL_LIST, sub_list);
 	} else {
 		cil_list_append(*leaf_expr, CIL_CONS_OPERAND, (void *)r_flavor);
 	}
-- 
2.29.2

