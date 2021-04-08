Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A336C433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468C061103
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhDHTQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF01C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id m16so1690324qtx.9
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUnMVq5Sg+6wkeESsHiJc01V1ExtbtG8GfueTl6aNoY=;
        b=YUguHDFnLrErc4/UGVCEupUKQCZc/DIBpMa7IyA1KwPTHKip+VW1mtndtsN0iuZ8E0
         +dbAImolZlrLlQp2w1bsO+XTY7An/Y8xTWSr0dlx5hOUpKvci0ZDAm8nBw2UIxwov1tr
         92nmwzmTTPSfK1cb4+7z3d7ZppFVlGS24yl6YtWOU668A27QTmmlE4R42OL5Z7QsRGJW
         +Ag6uFzIYO3El8AI2/4D6QkLmZ6kHpJeUHNsXUlPRbcJIKfdAMdJxnFTvlRO0fTJPdZs
         MXal79HLjifCwzgpLS7yjXPEuWzCbCESuN/l+injVWUwsyOoMaG8anj/mS8S2QsovbQN
         3xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUnMVq5Sg+6wkeESsHiJc01V1ExtbtG8GfueTl6aNoY=;
        b=l1YSCy31xsIhyCmShksMSvCgxM/U0pUT9+/zjT+Q8xdpHX+lU6Irsxs0Cp5xlYpdVJ
         xP8JqBn5XrojYwtBDm/sU7w97WR6xlc+Xnd2SAg5N/C0bLd2kIIya6KltNn77Sdkr0Lh
         U1T3c3gRNOtoAgJ7JLexsNqTbvHxYtyacTYjXWnxfoTODyp0WuFx0xy4PuNxSoFQyX6X
         iSsiKWKD9eZ/Jz0XdqpM7fjT1J+e7Jf51ung7X/YG0idrLmKQtvOpqCU641L2BfmE315
         IQ6wiZfri6WRR48YIdK/R+FEuKAVUAXeIs/h1T0FV+zzdVRdfW14+pmEA6al2QZVlIWy
         jIGQ==
X-Gm-Message-State: AOAM532iQ6K2I/FJMplE012h1NDTKr4k5xPSyKCVt1IC/8a2+xLI0fUV
        6prcW50/nuV9APJgGQ3Xb+7y5jaU86c2Iw==
X-Google-Smtp-Source: ABdhPJyXaYwsEj/vk34JNqBF+/V+PuGuCYK/gPAR4PkOgjgboCt2tJev+rUsb7REoMQ49xgjCNIndw==
X-Received: by 2002:a05:622a:2c4:: with SMTP id a4mr9047523qtx.145.1617909391891;
        Thu, 08 Apr 2021 12:16:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:31 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/11] libsepol/cil: More strict verification of constraint leaf expressions
Date:   Thu,  8 Apr 2021 15:16:09 -0400
Message-Id: <20210408191614.262173-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In constraint expressions u1, u3, r1, r3, t1, and t3 are never
allowed on the right side of an expression, but there were no checks
to verify that they were not used on the right side. The result was
that the expression "(eq t1 t1)" would be silently turned into
"(eq t1 t2)" when the binary policy was created.

Verify that u1, u3, r1, r3, t1, and t3 are not used on the right
side of a constraint expression.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 09e3daf9..2707b6c9 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -227,7 +227,13 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
 			}
 		}
 	} else {
-		if (r_flavor == CIL_CONS_U2) {
+		if (r_flavor == CIL_CONS_U1 || r_flavor == CIL_CONS_R1 || r_flavor == CIL_CONS_T1) {
+			cil_log(CIL_ERR, "u1, r1, and t1 are not allowed on the right side\n");
+			goto exit;
+		} else if (r_flavor == CIL_CONS_U3 || r_flavor == CIL_CONS_R3 || r_flavor == CIL_CONS_T3) {
+			cil_log(CIL_ERR, "u3, r3, and t3 are not allowed on the right side\n");
+			goto exit;
+		} else if (r_flavor == CIL_CONS_U2) {
 			if (op != CIL_EQ && op != CIL_NEQ) {
 				cil_log(CIL_ERR, "u2 on the right side must be used with eq or neq as the operator\n");
 				goto exit;
-- 
2.26.3

