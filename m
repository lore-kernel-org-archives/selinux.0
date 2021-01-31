Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4403C433DB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A0464DDB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhAaXNe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 18:13:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45898 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhAaXNb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 18:13:31 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DF3E85605EA
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 00:12:48 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: fix heap-use-after-free when using optional blockinherit
Date:   Mon,  1 Feb 2021 00:12:40 +0100
Message-Id: <20210131231240.58838-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  1 00:12:49 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When secilc compiles the following policy:

    (block b1
        (optional o1
            (blockinherit b1)
            (blockinherit x)
        )
    )

it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK) because
the block "x" does not exist. __cil_resolve_ast_last_child_helper()
calls cil_tree_children_destroy() on the optional block, which destroys
the two blockinherit statements. But the (blockinherit b1) node was
referenced inside (block b1) node, in its block->bi_nodes list.
Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY), it
contains a node which was freed: this triggers a use-after-free issue

Fix this issue by removing blockinherit nodes from their lists of nodes
block->bi_nodes when they are being destroyed. As
cil_destroy_blockinherit() does not have a reference to the node
containing the blockinherit data, implement this new logic in
cil_tree_node_destroy().

This issue was found while investigating a testcase from an OSS-Fuzz
issue which seems unrelated (a Null-dereference READ in
cil_symtab_get_datum, https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 886412d1b974..72c4892de707 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -223,11 +223,20 @@ void cil_tree_node_init(struct cil_tree_node **node)
 void cil_tree_node_destroy(struct cil_tree_node **node)
 {
 	struct cil_symtab_datum *datum;
+	struct cil_blockinherit *inherit;
 
 	if (node == NULL || *node == NULL) {
 		return;
 	}
 
+	if ((*node)->flavor == CIL_BLOCKINHERIT) {
+		inherit = (*node)->data;
+		if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
+			// Unlink the blockinherit from the block
+			cil_list_remove(inherit->block->bi_nodes, CIL_NODE, *node, CIL_FALSE);
+		}
+	}
+
 	if ((*node)->flavor >= CIL_MIN_DECLARATIVE) {
 		datum = (*node)->data;
 		cil_symtab_datum_remove_node(datum, *node);
-- 
2.30.0

