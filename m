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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B6C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C97060235
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhBAOZ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBAOZ0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:25:26 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0951C06174A
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 06:24:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a19so16346553qka.2
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcwratD4Re0by9gH+NerdHscYIJgY+vbr4JHZbp+4BQ=;
        b=eKih+c/JSW5zOOZbwnwWQH7XwATckFJ3lZ9w5H7i5BS1/9ViWI5D+2hGfYRgnp+Xzv
         C66s7QHdggtEGvdw8gmLSZnjmXDSJfk+rRKdazoJ3Ti93shlgFDQNlM23UsdF4IqDZ4s
         P1nf+GeRbqO60BuZIiJeWqn3WfVouG9D7X1CFyId95iQ9nqIDG0i/SHGBIvzdwS+dxOV
         sgIJesKYRgqOhFkwTkXtR873QqCYdU+QRMGUhmddiwOLA9AwDx5vJBMmYMSj1CIv5KsM
         OCQ08fx5QsgeexHgDYHLxdzWW6hll4AW2Z4kJyTU/Y93nm1J/uC0FOzOE3dQNgTq3gAN
         2vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcwratD4Re0by9gH+NerdHscYIJgY+vbr4JHZbp+4BQ=;
        b=pcCgOY/R72SoxCGvdlCHdVIdqB1od3eBo1IF+tzwPsLBSwNpcEyc3IXY3H+IbQawgw
         /XZDViwZXN4p+D3WNaZ6uaydo4ela3pUWIFyckRIYm1yFDHQdcBfX9KuP07JE35+wZSj
         rJnY8DzvoUg7MXw+8tm8Ovj/QTMWSvvGuATqZbqxfbT7F6m+njpJfxDKsL8kUDVky+Xb
         GsdU3ahBO+Rqi7j7rVpMwjB/HJk+4qBRx4CXZS76VZ9s0k0zz4kRmJgXY7JI5CIyLKsa
         FClrCZnoS+Pm9z+9qndknid3alSIIRq3BQ9xDKDqtb4b9wcARzEoYXKh5tk0NUZ34GLQ
         8BRQ==
X-Gm-Message-State: AOAM532rrYo4Bi1r0E9uvkEf5J5FCwSLkmQGdJL8O277T1/knQWZ2PNW
        fm97czB8OrZuTxBXbUyckDXir6037iY=
X-Google-Smtp-Source: ABdhPJwdetXLSK46cvDlXF9Y5wFL7ZiNKa5uDFpyXxaa4loE6UYbB0mAxuCKi6pwJeyuy24PM+vNsA==
X-Received: by 2002:a37:4ecd:: with SMTP id c196mr16000691qkb.264.1612189484750;
        Mon, 01 Feb 2021 06:24:44 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z16sm14215369qtb.73.2021.02.01.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:24:43 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix heap-use-after-free when using optional blockinherit
Date:   Mon,  1 Feb 2021 09:24:26 -0500
Message-Id: <20210201142426.134081-1-jwcart2@gmail.com>
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
 libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 02481558..3d8367fe 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -283,6 +283,23 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
 		return;
 	}
 
+	if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
+		struct cil_tree_node *node;
+		struct cil_list_item *item;
+		int found = CIL_FALSE;
+
+		cil_list_for_each(item, inherit->block->bi_nodes) {
+			node = item->data;
+			if (node->data == inherit) {
+				found = CIL_TRUE;
+				break;
+			}
+		}
+		if (found == CIL_TRUE) {
+			cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
+		}
+	}
+
 	free(inherit);
 }
 
-- 
2.26.2

