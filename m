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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5080DC433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF8F61264
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEMS4A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhEMS4A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:56:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3158C061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 197so26496043qkl.12
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AtZBLYQtLpPGpWQH3Z8AgEUKpRBgf0BUcASH6jRzKw=;
        b=dZfnHXsWwDQ/0ffAO551KIh82xPZ5A0hqMb6ciE2eThcO548Xi2VytWOZG2FQujoYD
         /UusHIHX3GdOP79wv0WPPRHL2hQgU+7LZOIm098/dByqnr8vcjwKCCr/SO5vwRd5dLb2
         STdbHKTg3TNaq4KLuz7KHDitbwOnExemIBcTM4fyHiTaSKGtAEFamVoeQuVLEP+K2O0d
         rL1lJSlghrCcG8GRO3JHsz6ORjWUZmwPt5iAHFRRfV8sm1/+AApUYQhTcYtH79MTvF3Q
         ChTEvZy2cxK79xz7NuEQQmfx2wcWuTi/aCbsju8EmTsbqqrWXSDv3/avowJsWuojTimk
         mb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AtZBLYQtLpPGpWQH3Z8AgEUKpRBgf0BUcASH6jRzKw=;
        b=mu6VL1SxdrNAyirLXfh7yV+PeT5f72mSt0p3UcruRFS1Qk+Jp+REtuiZh4WZVPbnPS
         90pRlejZFkXqpa2aSlB8JB6phkSYFZHCm+5nrgZ8bQNSptHte9cFzMMzYz8O3+KCKT83
         GBS3GV7fnBuo05K1kaggIc0xnWkTGaXD9iJK808W2+dhMWClgIFxYu0tdxyp8n+l9OBy
         +Y4aZd1+P4eIIU/UHisYiUuf7iusZim6N/7aMavX2ohJfttpluuymBSXuRdkBaMhZkAc
         EOX+sBEe4xg9RGM3737aAijNKQ53cs+F3uDx5RKlgEyKRSwSXkaeDQ03vPgTv9ECkSIm
         4k9Q==
X-Gm-Message-State: AOAM5306jnb1yw837rQgEZa7PoFs0TqJqoI0haQrWpBLL0luDNNJda6W
        hpucYqa3gksEkGfMQGTGj1PSWrbs4YoTNw==
X-Google-Smtp-Source: ABdhPJw1aa+gIeYDASlND9c2rtOtrAvGGR3xKwQs/FuFSiX0ysowJ5HooluwOasOlUVBHeOq/coqVQ==
X-Received: by 2002:a37:658a:: with SMTP id z132mr28928031qkb.86.1620932087836;
        Thu, 13 May 2021 11:54:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:54:38 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6] libsepol/cil: Limit the number of open parenthesis allowed
Date:   Thu, 13 May 2021 14:52:51 -0400
Message-Id: <20210513185254.559588-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When parsing a CIL policy, the number of open parenthesis is tracked
to verify that each has a matching close parenthesis. If there are
too many open parenthesis, a stack overflow could occur during later
processing.

Exit with an error if the number of open parenthesis exceeds 4096
(which should be enough for any policy.)

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index a9306218..fb95f401 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -42,6 +42,8 @@
 #include "cil_strpool.h"
 #include "cil_stack.h"
 
+#define CIL_PARSER_MAX_EXPR_DEPTH (0x1 << 12)
+
 char *CIL_KEY_HLL_LMS;
 char *CIL_KEY_HLL_LMX;
 char *CIL_KEY_HLL_LME;
@@ -245,7 +247,10 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
 			break;
 		case OPAREN:
 			paren_count++;
-
+			if (paren_count > CIL_PARSER_MAX_EXPR_DEPTH) {
+				cil_log(CIL_ERR, "Number of open parenthesis exceeds limit of %d at line %d of %s\n", CIL_PARSER_MAX_EXPR_DEPTH, tok.line, path);
+				goto exit;
+			}
 			create_node(&node, current, tok.line, hll_lineno, NULL);
 			insert_node(node, current);
 			current = node;
-- 
2.26.3

