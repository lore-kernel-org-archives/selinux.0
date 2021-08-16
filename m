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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0EC4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A1860F38
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhHPT6e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhHPT6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 15:58:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16181C061796
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v1so9943519qva.7
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4umRkcaGpCtbzgqA5jpMX6247ba4PQmUVExObBh0Pr8=;
        b=tG6ftrXW1TCOMIEavf4w9uemXGdpsKLdquvoq4YwaWWsEWWrr9i5nJ26tbL3j0Eznk
         VrYf1Ai09bbBup2nAqO7ZJDc5nRQw3PXMb4BfovsHSi3HmLqdC3saNJ6Fz44H1T2zC9y
         cC+du10XB8Jh8yP/nDOCC6EazrfUNrK+oQWCX+Q2qLMORJYnvrYqFH7WxWAs4pVh8XsU
         x2WpYTDmTBkePx+I/pOraRHb23t1/2kqWWL7YpP0aSmnYgNWTS1oIpB8/Vbqbz+Zai4r
         FTx4IePZADtSQsACO6CFXgti5Rc8ONsu5i1AE8pdFuGTLoaleMV7Kb7m5ao2R15PTz4j
         hl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4umRkcaGpCtbzgqA5jpMX6247ba4PQmUVExObBh0Pr8=;
        b=oXE74f5uOpqTaBomhDRsnwpP5QNtBHFy06k2R9pctpWGYIoyuQ3Vc27uedBxfIlgQP
         FJXq/yA9MLfXKoY9IL0W24sIz2oR87lJVFhHU876eILUQXAKzp8Qlg6eiU0IqX5wTwvx
         ZQr8PJYeK/+K3IV/IeVs+V6EgApx3b3WFYhvlh8ZbTLYYyZcaIUGEJhQIPqMFm7H396E
         uq1AvS0ir1yvahY4M00E8X/jfFzqAVjBAmYE7DcLy1x1Nl4ERO5K9nTfq8Mrpgx7UBDx
         wbxZLFoyRN8pisRSrs/g/2DPmcvu1Zu/K2swJU56GW56gy/NH4UFSsGLjHHkXJLTNJ9F
         EcnQ==
X-Gm-Message-State: AOAM533QUB0DfPZSwwucCdDj8wixgOqjkjgBpk+hmglTlUjfZvx0akWc
        7jb6opoVxXxKvRnF3QX5FV8Wy1ZQkmmI1A==
X-Google-Smtp-Source: ABdhPJy8z0lHMT51anwy95Nv8Dqu/mQNGGMUhDpMET0s9+EMsyKsCjoNhA0RuHQ/tJX9ZMo4f5Ekqg==
X-Received: by 2002:a05:6214:508:: with SMTP id v8mr375667qvw.33.1629143879164;
        Mon, 16 Aug 2021 12:57:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f11sm135147qtf.45.2021.08.16.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:57:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/7 v2] libsepol/cil: Check for valid line mark type immediately
Date:   Mon, 16 Aug 2021 15:57:48 -0400
Message-Id: <20210816195752.923028-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816195752.923028-1-jwcart2@gmail.com>
References: <20210816195752.923028-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It clearer to check that the line mark type is a valid option right
after getting the token.

Check that the line mark type is one of the expected values right
awasy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index fc90caec..24386f60 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -116,6 +116,10 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		goto exit;
 	}
 	hll_type = cil_strpool_add(tok.value);
+	if (hll_type != CIL_KEY_HLL_LME && hll_type != CIL_KEY_HLL_LMS && hll_type != CIL_KEY_HLL_LMX) {
+		cil_log(CIL_ERR, "Invalid line mark syntax\n");
+		goto exit;
+	}
 	if (hll_type == CIL_KEY_HLL_LME) {
 		if (cil_stack_is_empty(stack)) {
 			cil_log(CIL_ERR, "Line mark end without start\n");
@@ -134,15 +138,6 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_HLL);
 		insert_node(node, *current);
 
-		if (hll_type == CIL_KEY_HLL_LMS) {
-			*hll_expand = 0;
-		} else if (hll_type == CIL_KEY_HLL_LMX) {
-			*hll_expand = 1;
-		} else {
-			cil_log(CIL_ERR, "Invalid line mark syntax\n");
-			goto exit;
-		}
-
 		cil_lexer_next(&tok);
 		if (tok.type != SYMBOL) {
 			cil_log(CIL_ERR, "Invalid line mark syntax\n");
@@ -161,6 +156,7 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
 		}
 #endif
 		*hll_lineno = val;
+		*hll_expand = (hll_type == CIL_KEY_HLL_LMX) ? 1 : 0;
 
 		push_hll_info(stack, *hll_lineno, *hll_expand);
 
-- 
2.31.1

