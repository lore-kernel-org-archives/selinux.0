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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D469C433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C1964E4D
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhBBUzL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhBBUzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 15:55:09 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7DC06174A
        for <selinux@vger.kernel.org>; Tue,  2 Feb 2021 12:54:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id a12so21245832qkh.10
        for <selinux@vger.kernel.org>; Tue, 02 Feb 2021 12:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C42luy/5P/9CwaerTJMYQnjmp7rSr20FFpTcLEYOHI0=;
        b=L6hNe47PgBIkNjjixfD1EVb1ZxtwHjRNXhpeyXC8ds5gyjbCuHSIv48kyDUR9UqSSf
         GMxFt1CdZOyUV+4ZpCqY8OqIVQdczr4YNWeL8BMWw8iH0Guo2+qUQytMHJYJ4xfthLzn
         7CNDLq6djc3DHSmjnD8pbeT3UK+hi21Zi2R/60k1YW22dB3VKyumu0YU+ePp1BuE8+bc
         kdbYV9xzJY0FhXHuVlTdP2MzrGJ3Ez2cIX4jb9ZYeasIm5aHfEQvb8lurmpjIT5rxLRy
         9cozNV2a5cIIIl6ynXG4HnptMWgcz1VWkg3vnzi5ahhQ/CRlMNjzoIJoY6VhAYceyHT0
         TRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C42luy/5P/9CwaerTJMYQnjmp7rSr20FFpTcLEYOHI0=;
        b=jUn0i+rInveINIOB2t0d6Y0ZrlsX/IMnsuBQEHPmzKz3aF5HxuR1zGN4U+MWMVPiix
         +c9MjO+kyeursFLdRWd8qJNEL3R1T8KFxwJA5zSSJgpDT4P8kxcP4PqpXeY4JGWs1WWe
         +ZhB0BhqEUJUWLkRAgrsyTKiFQEN0S7Wxs+YNFMf1GcyMqjEgoYQCTw6k77pz9WLRq3c
         0VqgJ9H0pwb0AREfrSVjwhDZLVhuJPrZgZcfqR7Lcz98VZ+ZQBeXYishd98wMmFuBTSX
         p+c6KSEmphkymmDaFZZkSBgV+Xs690Ox6YZkwdujzcI2YZ2k/YsZ3sXDcOQX6IwbCuk0
         TxGg==
X-Gm-Message-State: AOAM530ulUjPX/9Yqe4KzI8BBkIsZqB2QyiMdughnByzhFzDMXhcUrZz
        q2K/Yinc6pwsemVO3jghqBoULgBUX+U=
X-Google-Smtp-Source: ABdhPJyWGmzqMN5b6j6phKfw+EWSpt/yiPMTd3HSW2TZOeHmO3pnuo+iRSgFTDDIaNMbxZ+TkmQ3oQ==
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr23829709qkb.201.1612299267216;
        Tue, 02 Feb 2021 12:54:27 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id b194sm28102qkc.102.2021.02.02.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 12:54:26 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH V2] libsepol/cil: Fix heap-use-after-free when using optional blockinherit
Date:   Tue,  2 Feb 2021 15:54:17 -0500
Message-Id: <20210202205417.120630-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is based on a patch by Nicolas Iooss. He writes:
    When secilc compiles the following policy:

        (block b1
            (optional o1
                (blockinherit b1)
                (blockinherit x)
            )
        )

    it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK)
    because the block "x" does not exist.
    __cil_resolve_ast_last_child_helper() calls
    cil_tree_children_destroy() on the optional block, which destroys
    the two blockinherit statements. But the (blockinherit b1) node
    was referenced inside (block b1) node, in its block->bi_nodes list.
    Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY),
    it contains a node which was freed: this triggers a use-after-free
    issue

    Fix this issue by removing blockinherit nodes from their lists of
    nodes block->bi_nodes when they are being destroyed. As
    cil_destroy_blockinherit() does not have a reference to the node
    containing the blockinherit data, implement this new logic in
    cil_tree_node_destroy().

    This issue was found while investigating a testcase from an OSS-Fuzz
    issue which seems unrelated (a Null-dereference READ in
    cil_symtab_get_datum,
    https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 02481558..ab0efd53 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -283,6 +283,19 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
 		return;
 	}
 
+	if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
+		struct cil_tree_node *node;
+		struct cil_list_item *item;
+
+		cil_list_for_each(item, inherit->block->bi_nodes) {
+			node = item->data;
+			if (node->data == inherit) {
+				cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
+				break;
+			}
+		}
+	}
+
 	free(inherit);
 }
 
-- 
2.26.2

