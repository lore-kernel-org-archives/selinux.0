Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434CC433DB
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 22:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1605164EC6
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 22:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBAWSw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:18:52 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48756 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBAWSu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 17:18:50 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 037EE5646C6
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 23:18:08 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol/cil: unlink blockinherit->block link when destroying a block
Date:   Mon,  1 Feb 2021 23:17:58 +0100
Message-Id: <20210201221758.13349-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  1 23:18:09 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following CIL policy triggers a heap use-after-free in secilc
because when the blockinherit node is destroyed, the block node was
already destroyed:

    (block b2a)
    (blockinherit b2a)

Fix this by setting blockinherit->block to NULL when destroying block.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 02481558ad11..c6edcde6bc5d 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -231,13 +231,30 @@ exit:
 
 void cil_destroy_block(struct cil_block *block)
 {
+	struct cil_list_item *item;
+	struct cil_tree_node *bi_node;
+	struct cil_blockinherit *inherit;
+
 	if (block == NULL) {
 		return;
 	}
 
 	cil_symtab_datum_destroy(&block->datum);
 	cil_symtab_array_destroy(block->symtab);
-	cil_list_destroy(&block->bi_nodes, CIL_FALSE);
+	if (block->bi_nodes != NULL) {
+		/* unlink blockinherit->block */
+		cil_list_for_each(item, block->bi_nodes) {
+			bi_node = item->data;
+			/* the conditions should always be true, but better be sure */
+			if (bi_node->flavor == CIL_BLOCKINHERIT) {
+				inherit = bi_node->data;
+				if (inherit->block == block) {
+					inherit->block = NULL;
+				}
+			}
+		}
+		cil_list_destroy(&block->bi_nodes, CIL_FALSE);
+	}
 
 	free(block);
 }
-- 
2.30.0

