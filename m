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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E16C432BE
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EBA60F38
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhHPT6h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHPT6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 15:58:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C357C06179A
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n11so15585552qkk.1
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkeGITQYfGBZQHpR8sGcb4cqda0IhnWGymJDLCWT4fg=;
        b=cPdOx1kLKus0ldyf9OB24G2mQeQA59ViSTVxVFE6QH5ENKP+qadyRJ8ZogqR7aBc11
         9svcA3cqnmy3LBXCmW5N9CyWecDEtwlc+rIh/Vna1TIUxmm5XL9/DA2Gacw/Lia1Pq2g
         SCwqOm8D4AJkpwlXS2TZHOMRIIoNUskX+tDeNhPPPXMolzMTUVb9X79WLqLbXtX/tSg8
         kJf8CtDAcwYno2T2gNmMa33wjX9ZzXCMqMrElH6slzWy7dSeZcVKz7civxcnyRp9cSt4
         w6f9zAZYo4Tuv0IygqB7DF/1QJ1lEkNkCt0f3K+SKjmw/f64iKBgrIVAlKncYj011L/K
         76dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkeGITQYfGBZQHpR8sGcb4cqda0IhnWGymJDLCWT4fg=;
        b=nQwYvzcN9oRDgoiSu6pm2iL5U5dil78kjYBpd0yxVkmZEL0aVlfA6Xwht4Uf4zvZn+
         uI6PY1ZGC1HDXCtEMpnHkDmtd8fyIjHBQflt7ZehLOGxPqxd5olnqjOdpHRnIyYrz9/H
         JJQOu0YbvEqS3U1z5OHbnS7mv1Rp8wa9t6SYs9TYpc84y+cPHxJIvvEnQy6b7iVBq9u8
         iJy1zGqgE3bePkXqx46RDmffGPQIk+31muzKeAM8+ehhqKpPY/txgAKPU/zWBqwtur4l
         O0z+v2ClQBEXp7tJugE9x96e4xVNPx4qlVPPURKcaKfGGsMfCJFfZ+cJ+QV7xn8CK0Go
         AH4w==
X-Gm-Message-State: AOAM532WDiX4zRorpIIPXo6HK7Hj3Gu3iff0CIuUhSPDI0EvrIknGMVy
        ezgKYkRGaX46QOSJWDycb2GzBgQh1ixEJg==
X-Google-Smtp-Source: ABdhPJw2jy4cbZQPbX+eCA1Ntcr6qNSjKNdAt/SjMSsaA/I3dxbHIT8KBjvmc1zkViGku6m4HuiMCg==
X-Received: by 2002:a37:5dc2:: with SMTP id r185mr38373qkb.186.1629143879706;
        Mon, 16 Aug 2021 12:57:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f11sm135147qtf.45.2021.08.16.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:57:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/7 v4] libsepol/cil: Push line mark state first when processing a line mark
Date:   Mon, 16 Aug 2021 15:57:49 -0400
Message-Id: <20210816195752.923028-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816195752.923028-1-jwcart2@gmail.com>
References: <20210816195752.923028-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL line mark rules are used to annotate the original line and file
of a rule. It is mostly used for neverallow rules that have been
converted to CIL.

Pushing the current line mark state after processing a line mark
section does not make sense since that information is never used.
When the line mark section ends the information is just popped and
discarded. It also makes pop_hll_info() more complicated than it
needs to be.

Push the line mark state first and simplfy pop_hll_info().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index 24386f60..d36ffc49 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -66,19 +66,15 @@ static void push_hll_info(struct cil_stack *stack, uint32_t hll_lineno, uint32_t
 static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t *hll_expand)
 {
 	struct cil_stack_item *curr = cil_stack_pop(stack);
-	struct cil_stack_item *prev = cil_stack_peek(stack);
-	struct hll_info *old;
+	struct hll_info *info;
 
-	free(curr->data);
-
-	if (!prev) {
-		*hll_lineno = 0;
-		*hll_expand = 0;
-	} else {
-		old = prev->data;
-		*hll_lineno = old->hll_lineno;
-		*hll_expand = old->hll_expand;
+	if (!curr) {
+		return;
 	}
+	info = curr->data;
+	*hll_expand = info->hll_expand;
+	*hll_lineno = info->hll_lineno;
+	free(curr->data);
 }
 
 static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_line, void *value)
@@ -128,6 +124,8 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		pop_hll_info(stack, hll_lineno, hll_expand);
 		*current = (*current)->parent;
 	} else {
+		push_hll_info(stack, *hll_lineno, *hll_expand);
+
 		create_node(&node, *current, tok.line, *hll_lineno, NULL);
 		insert_node(node, *current);
 		*current = node;
@@ -158,8 +156,6 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		*hll_lineno = val;
 		*hll_expand = (hll_type == CIL_KEY_HLL_LMX) ? 1 : 0;
 
-		push_hll_info(stack, *hll_lineno, *hll_expand);
-
 		cil_lexer_next(&tok);
 		if (tok.type != SYMBOL && tok.type != QSTRING) {
 			cil_log(CIL_ERR, "Invalid line mark syntax\n");
-- 
2.31.1

