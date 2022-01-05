Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE085C433EF
	for <selinux@archiver.kernel.org>; Wed,  5 Jan 2022 21:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiAEVQQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbiAEVQP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jan 2022 16:16:15 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F32C061212
        for <selinux@vger.kernel.org>; Wed,  5 Jan 2022 13:16:15 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w27so716311qkj.7
        for <selinux@vger.kernel.org>; Wed, 05 Jan 2022 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hnaVrkmlYse3rWDrMGsc1OvrBAsnnFBvXQxoQ0lC+fw=;
        b=ltHJIKPGN7fKSnDyCpJ15WmpOcy+B0XWBVAwwzDIA9REkbA1+TAUBu4SGWbDNX0ssb
         yXXuGdPkLoPJi2bCYsOOoEDpPcMS6ffxcRrpWIu+AenswyJYE+xdmBzwVWM59CCVFV9a
         L9O1n6bI2jnHn4dZSP+f6ZPFNexfBbGIpMmWzhm8qNY1RIYqDYMh+eCFCPyrPaugJRbM
         S4VoAKew7GW40bwr8hnmu6gJcwkJ/KYZ7Xm+eaR3Tw8510SmIbVUC9tpLo9Ow7eFUzSt
         dOCo8R28LnrfilIn0nJmQl57JEbO8+1fHxzgtsEneDdpHDqNTqmVSJALTsD/7McvvoOg
         zizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hnaVrkmlYse3rWDrMGsc1OvrBAsnnFBvXQxoQ0lC+fw=;
        b=A3q01URwJTe+shlybr6BBbamOCG8JaALSJu0LS4VcomxukCRhBjFv+czw0qT+3Cyzt
         JGeOiAD4khouNXfFRlcNwj7MGQ4xpnhxkNX0SdU8wmNLrvCc9dnY3j4dvcMcaJi24/YD
         +NodoCo7wXXyBy1BKOk12XfvxN8JSOqm2XeNgtmTPxLHllqg/dK2UFkOzQZTjLwtGLDT
         gUV0rsdQ2+Ixc6QLz797ros111xW3IINiVqUALOorVK5mwvE9HJF786/NSdauyD2V2iG
         Z9NWiC3SlUK6LH6lxxv7xzaR2P1tBJzxKC9rMWdV1XdUEDm1X2qRZxyCcXNyI5R0nuQz
         YUpw==
X-Gm-Message-State: AOAM5307KAOiAyY3FvHm6OcM3sxRD/3/NAHBrlwbSnbK5mSvNCQxIdWq
        za6uzdyYNc8I4KJRYcWhkkhccX/xD58=
X-Google-Smtp-Source: ABdhPJxG7v6fLL/uPYbW8gj3+dM8sysmqClYD4d4uCIDg2lpvS2kXBWN/GMX+Sg5Oi+2ZODIIUFBcg==
X-Received: by 2002:a05:620a:4107:: with SMTP id j7mr40117042qko.645.1641417373725;
        Wed, 05 Jan 2022 13:16:13 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id m1sm36148502qkn.115.2022.01.05.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:16:13 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Mark as abstract all sub-blocks of an abstract block
Date:   Wed,  5 Jan 2022 16:16:01 -0500
Message-Id: <20220105211602.359300-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105211602.359300-1-jwcart2@gmail.com>
References: <20220105211602.359300-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If a block is marked as abstract, then it will be skipped during
every pass after blockabstracts are resolved (only tunables,
in-befores, and blockinherits are before blockabstracts), so mark
all of its sub-blocks as abstract to reflect their actual status.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index e97a9f46..0288b7dc 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2379,6 +2379,19 @@ exit:
 	return rc;
 }
 
+static void cil_mark_subtree_abstract(struct cil_tree_node *node)
+{
+	struct cil_block *block = node->data;
+
+	block->is_abstract = CIL_TRUE;
+
+	for (node = node->cl_head; node; node = node->next) {
+		if (node->flavor == CIL_BLOCK) {
+			cil_mark_subtree_abstract(node);
+		}
+	}
+}
+
 int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_blockabstract *abstract = current->data;
@@ -2398,7 +2411,7 @@ int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	((struct cil_block*)block_datum)->is_abstract = CIL_TRUE;
+	cil_mark_subtree_abstract(block_node);
 
 	return SEPOL_OK;
 
-- 
2.31.1

