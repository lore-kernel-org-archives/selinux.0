Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B6C43381
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AD264EB7
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhCNUSX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:18:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49133 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhCNURt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 16:17:49 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BB96D5646B0
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 21:17:47 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/6] libsepol/cil: remove stray printf
Date:   Sun, 14 Mar 2021 21:16:48 +0100
Message-Id: <20210314201651.474432-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314201651.474432-1-nicolas.iooss@m4x.org>
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 21:17:48 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

printf("%i\n", node->flavor); looks very much like a statement which was
added for debugging purpose and was unintentionally left.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 0e07856133e5..47cdf0e7c0b9 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1088,7 +1088,6 @@ int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
 	node = NODE(result_datum);
 	if (node->flavor != CIL_ROLE) {
 		rc = SEPOL_ERR;
-		printf("%i\n", node->flavor);
 		cil_log(CIL_ERR, "roletransition must result in a role, but %s is a %s\n", roletrans->result_str, cil_node_to_string(node));
 		goto exit;
 	}
-- 
2.30.2

