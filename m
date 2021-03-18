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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C49C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AE364EF9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCRUU4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUU3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 16:20:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0AC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:20:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y18so592511qky.11
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwDKL0zt+Figi5Eo5+7rHuFRMYpcDr7oGv3t4Bvyv/4=;
        b=WJVaamgqOv1QGjqZRJZ9Z0czK6mbLqzOs6wRrrrCEvtIe7B7lDVuCX3bBWjWK4sEI5
         FMdaHuIYVyQU5kb6EnaEfXvxXBW7A8E2U2Mq6dCCAiFVbrYWNRMa8y3u67We3SA+Tx5P
         Zh33b7yfnxAz4QQ/G/K82qlbsVblZsin7CUWnSh6IWaL5d81ZUoiZnLiO+rSY981YqJ2
         kAqg0zzWTovrJRrthEphmzXfNeTBifNSQn2zCCWsKTT8ag31NiC1ZHdBzXavi064+eD6
         xdDLBF9jjx6WGm2WhFajX5YcvPaUw/WteqGiAXUnN964tZTdG4ieVU5VpCt8Cu9GIQqI
         T1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwDKL0zt+Figi5Eo5+7rHuFRMYpcDr7oGv3t4Bvyv/4=;
        b=IXtak06Qu1mRqfueOp2BRLmUW5JBDqgnhTkVDNL3vLZ9sN6MJFvIH/HCG9cc9DZoit
         hWA1LrSYr3z+vVESnGdc7xgUBOtU1ZscscYkum14bnUQrP8oE2VvCmu0HPzCUvW7fsxb
         viUznm/jhdlid6w98h5/oHuIgQjn33PUnlNPg5UMqO85UFMwCLd42EsmuwZOaRFnHu5e
         zot+xgRVL9XQ7wZzRqA/PB1LusGDwlaiZMvxgiyhm6gsxWslw3YnOHDNx5hnVsyyfw5e
         vAi02vhmzWUmrUY3xtCsOTU/ZCa1bnLrmtWaoYfckc870wJ4PqVB0AiTGIYcqOg2xjId
         8vnQ==
X-Gm-Message-State: AOAM533zohIs1pMMKsCPH2Z1XOkWfyiNZ/JHp/jucNjY5NxfDlooGDxe
        Ws4PeqK1pfEdQWg3IAkqw/vKrRvApSmsdw==
X-Google-Smtp-Source: ABdhPJzOxEeTCaTQmqrJH6cVznWX68RLtJCTwS8RRb8RuJRrHNb8ZDIqLnT4V4qtl/G4eF5DKa84NQ==
X-Received: by 2002:a37:a81:: with SMTP id 123mr6095969qkk.144.1616098828187;
        Thu, 18 Mar 2021 13:20:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 66sm2696354qkk.18.2021.03.18.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:20:27 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: More strict verification of constraint leaf expressions
Date:   Thu, 18 Mar 2021 16:20:25 -0400
Message-Id: <20210318202025.154590-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
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
2.26.2

