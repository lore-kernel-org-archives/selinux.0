Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D85C433ED
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33416109E
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhEFRGn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 May 2021 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhEFRGn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 May 2021 13:06:43 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A8C061574
        for <selinux@vger.kernel.org>; Thu,  6 May 2021 10:05:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t7so4577244qtn.3
        for <selinux@vger.kernel.org>; Thu, 06 May 2021 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA3wFs+jVT7fh71nib7pBZnhAm8IrLPndVpiTPRMzKM=;
        b=judJYd5LFHoB322enfB96HzrKh80EbFMHhddqds4wUxtd/Odbp01/DEhKqla+zAO0M
         mFB182aN1e1MJXqM8uEOEH/Rmnpx1j2GRMS0SMAZPdKbwEPV85ixzdduqYddZtHGIIyA
         GsYheb6SHPWvQaGt8PLX85nIyecW2WKkXcE9LC0A17Ql0U6b/++rGM1r6/F9cfUTSB37
         fJBPTG6rr1XHR9Fz5P0Rkm57wUMyulOPzWYxjnyXGZUBa78zBytdk4VYwMCnrQQuQFMC
         70upThNeznMc/AA7L7cf5ODthKNenuNt8sIMo05NOAQc0oRguN5VXc5anlObwgGyudHC
         9meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA3wFs+jVT7fh71nib7pBZnhAm8IrLPndVpiTPRMzKM=;
        b=YQJq64cT4KtA/9UjKgR/wJzsvfCbudMG9+2hjszw2J9PY1/qYyweMnc9P5axFLlbIi
         W9v18882gRbdy+8zqtfeNCH6OK9+yDVUoJUsPaWVVQPFNcoMqEPTvda2k2uuD9Vg9Vcz
         Z8k3RlwvO/dWogxlUiC3rncVgtqnMc5WsPMzk6kqlB1nWOrKd3th2e6ZfEaWJQqqJTL7
         UpzxZU2vcwY/FnF0Tp8m/zQFfGySpjpZoAJZWC2BpNHrxtasqLhVk9Lh67H74CWQeuHd
         ZtGYZslMAjorCuq6KsIWQJ63YtvVNMKMCmjkH1BNbPBAFdoqPAldbIEpG6x+foRDlAf8
         QEkQ==
X-Gm-Message-State: AOAM531InOhfnl2s4tuazXTTF4XtJNPdZRtopMsESBsqg1rZz0rLVQ1D
        97S7Xf8TzMUtFaaMvw4Br72sLOdyd+ekgg==
X-Google-Smtp-Source: ABdhPJyhbwhlAY6VIGhQKqep31mVpOF7T5RFNEDkNzhyiwEuXdf0ogtmRpTROkfKH/4VQCdP0+HtFQ==
X-Received: by 2002:ac8:a02:: with SMTP id b2mr5320176qti.310.1620320743728;
        Thu, 06 May 2021 10:05:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f132sm2455965qke.104.2021.05.06.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 10:05:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Fix name resolution involving inherited blocks
Date:   Thu,  6 May 2021 13:05:36 -0400
Message-Id: <20210506170537.146337-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When resolving a name in a block that has been inherited. First,
a search is done in the parent namespaces (if any) of the
blockinherit rule with the exception of the global namespace. If
the name is not found, then a search is done in the namespaces of
the original block (starting with that block's namespace)  with
the exception of the global namespace. Finally, if it still has
not been found, the global namespace is searched.

This does not work if a declaration is in the block being
inherited.

For example:
  (block b
    (typeattribute a)
    (allow a self (CLASS (PERM)))
  )
  (blockinherit b)

This will result in a policy with the following identical allow
rules:
  (allow b.a self (CLASS (PERM)))
  (allow b.a self (CLASS (PERM)))
rather than the expected:
  (allow b.a self (CLASS (PERM)))
  (allow a self (CLASS (PERM)))
This is because when the typeattribute is copied while resolving
the inheritance, the new datum is added to the global namespace
and, since that is searched last, the typeattribute in block b is
found first.

This behavior means that no declaration that is inherited into the
global namespace will actually be used.

Instead, if the name is not found in the parent namespaces (if any)
where the blockinherit is located with the exception of the global
namespace, start the next search in the namespace of the parent of
the original block (instead of the original block itself). Now if
a declaration is inherited from the original block, the new
declaration will be used. This behavior seems to be the originally
intended behavior because there is a comment in the code that says,
"Continue search in original block's parent".

This issue was found by secilc-fuzzer. If the original block
is made to be abstract, then the type attribute declaration
in the original block is not in the policy and a segfault
occurs when creating the binary because the copied allow rule
refers to a non-existent type attribute.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f251ed15..55080396 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4211,7 +4211,7 @@ static int __cil_resolve_name_with_parents(struct cil_tree_node *node, char *nam
 			rc = __cil_resolve_name_with_parents(node->parent, name, sym_index, datum);
 			if (rc != SEPOL_OK) {
 				/* Continue search in original block's parent */
-				rc = __cil_resolve_name_with_parents(NODE(inherit->block), name, sym_index, datum);
+				rc = __cil_resolve_name_with_parents(NODE(inherit->block)->parent, name, sym_index, datum);
 				goto exit;
 			}
 		}
-- 
2.26.3

