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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF1EC432BE
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534A66056C
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhHJSWK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbhHJSWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:22:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B34C07AF5C
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s132so2546238qke.9
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4umRkcaGpCtbzgqA5jpMX6247ba4PQmUVExObBh0Pr8=;
        b=S1V4sc/YaRtFYH6NaGoHYbYPhnVv4L0Dyyaz0diYTjoIXG8DUeaEiFfIt9o2nB+tGE
         3s4fTrP8pe40mDMCx+nEH/NKRe8a7PdiDX39oBuUeTzkWlRRsHeOvkHGl62NT+XGbdfb
         ec5ft927npiNexXKepeuYh9fNJ75lqy0oXiyjFdE+NrdkprQeP6TqtoIwqEAy/suz2ZB
         wai6yNE/RKe13Ndam6WW9oX1nQc+5PhyS68G7xVHM25dCv0Ri2tpsJRZY+MFl2irhS/p
         BKUM8BEVSMbGEktJCvXwbJHZh0Mpdz84N9FjTg2u+YwuFVvZTEfSS695lk8YJBytoFNg
         ejyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4umRkcaGpCtbzgqA5jpMX6247ba4PQmUVExObBh0Pr8=;
        b=d65YXkYYh2etjcNney8OMXYKPy7EH6H4KFvOmTHDgiTMvy6E6Ip0pT1b//BW335o1a
         xlEJ0fWEvqoFrrOc9Lhms9yP/Tti+UBUHHn39vr75i5JqzuZZYIMk2U61GHw8wyBCr0w
         D20aBcN4uEpFU+dVYghm0Opt1DSXqs+oUiIB8T0SMzCCm6QQNOIq2WmPrkBKjxGtJN2r
         55QzXbojk9zhEuMTdo31DyLR6LmI7ojAURZKbxXz099feFLSBIoKA1n7O+/v1UCgArf4
         x5acoAYhrAvtGM9W0+usEYClYUR7+igTp7ygV+W9NIXqk38ZCaa4CDeu4PJ2mdhTo+hp
         gNvw==
X-Gm-Message-State: AOAM531I0kTgKvSrk7iNKnHGaoHdnFNGS4Zcd0Ei55oQ7zCGCu/a7BDt
        TQlviVmfXjsCtTbTzOWO4akNP9DJO1+U8Q==
X-Google-Smtp-Source: ABdhPJy43Qn+EKoBcUN9MyFL/rD+jdUCH9WWGxpv/0NP5Sp/1t1PoyVd2RshBRbVipCXKibW9qZl3g==
X-Received: by 2002:a37:9643:: with SMTP id y64mr28556423qkd.213.1628618745409;
        Tue, 10 Aug 2021 11:05:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m16sm3057415qki.19.2021.08.10.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/8] libsepol/cil: Check for valid line mark type immediately
Date:   Tue, 10 Aug 2021 14:05:32 -0400
Message-Id: <20210810180537.669439-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810180537.669439-1-jwcart2@gmail.com>
References: <20210810180537.669439-1-jwcart2@gmail.com>
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

