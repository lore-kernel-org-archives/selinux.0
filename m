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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D5C4320A
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006C360231
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhHJSWJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhHJSWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057EBC07AF5D
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:47 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id s11so11391777qvz.7
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkeGITQYfGBZQHpR8sGcb4cqda0IhnWGymJDLCWT4fg=;
        b=Mm/+I2FqA7Ouw1J+/4J8BqYvNUYRFjSORnWM/xmAwHGpFk5o6DYS0TtTYMOv/DU6OQ
         pts7NLNZVmdxzEENGnKvWIabRi/R7sfcge0vXFIIp+4bHdVI9TbO9sGTy18mCwokEGfA
         RUJsAq4PO6fHCCFlpLHfsMOAupBTM0lw5Jc+J2u6nAlo+3nDwq4BgQ+Q7XffPfnYmIU9
         Tr+Xhxoj8Nx596rfQ4QLjrRvtDNTALZIlhng1xuD5MNxdgH3DPuiFkOEq6KSO+aROL8m
         G3a3dxDEjdSG5schgll39FhDwGj5fluSPPebmZCsg/eqflg8GhLei0mGH5DMeJR67qga
         539A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkeGITQYfGBZQHpR8sGcb4cqda0IhnWGymJDLCWT4fg=;
        b=FMZ/AqYm+dzFWolewAdfl04wuOVyCXP+31SHxCSxjbGujcbloWSkHqZxvUlYAUPkcB
         sylbKQFT5ix74trlJGjaNUEB8zu0+1m2XyiH11yRRhUgt9RtwfogrLRsv5cS2SQGldEA
         6AOkXrkAhUfQYkO2DelhVyoctOLVyc1zZA9DJBhHzZTiHDHnjXU1RWFxb88ycJsxHfg6
         /sZmAF2UscV11732/VyIiyN6ubZADCpw4imVej5EsrOrw2/UTFtNLmVThde8z8WzqPwY
         62IFsYDCjp0hrh7DpaGBOiOsnADwh5F7AbmKyjIVAVV31i+HSa+v3F7tlOP4VBZ/finU
         uFjQ==
X-Gm-Message-State: AOAM530Bz5OqLAsBaGEK0xaoyQJVAGbwTy1dLJJh0kEcYU2V1GbZeN87
        guT7o36m5cGEilhz23qgqOtfIdgDjVzJrw==
X-Google-Smtp-Source: ABdhPJxbaB8Bm0zrIvUHFQ/41kjMytuSPL08Eo0nXmYeMOHTx/2Nf5ybFrq/x2kVd6fHLuAI3TN/1Q==
X-Received: by 2002:a05:6214:e4e:: with SMTP id o14mr19155441qvc.55.1628618746080;
        Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:45 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/8] libsepol/cil: Push line mark state first when processing a line mark
Date:   Tue, 10 Aug 2021 14:05:33 -0400
Message-Id: <20210810180537.669439-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
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

