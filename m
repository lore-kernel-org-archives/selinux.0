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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51BC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB4561007
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhDSPQu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbhDSPQt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6DCC061761
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t17so7634773qkg.4
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUnMVq5Sg+6wkeESsHiJc01V1ExtbtG8GfueTl6aNoY=;
        b=sVcY1zGVXZ/nJgxjvEbzhbU+BhbpPsOW8XHi2Gg6ZKlAqvaJbErBnuZzD/XWgarzYh
         Ls3Hb24GmyLwOvI2Qla7IPzk/magEFphsqcR6DSGntHNuuANZcSrPaGyl5uRJRsiPcEF
         0yz/NUIVvIZiGawW2+SbzAI9MVJTqcNHzZASJQsdnXU26kwzWQlbLRB+EKNdtKCthiTw
         XYo+SmZCHSS6PtK1JWmHHJEyfsFLd8eVkweW862Ri9gqaLCIRz37I8GlQUuHvSQiU4h8
         AIP+10rqH8k/ahU3NBnVEyymTT7I4vJG7iCYvDZKfjVisQD80KK/i9dTKM8KYb6H0Z0j
         fx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUnMVq5Sg+6wkeESsHiJc01V1ExtbtG8GfueTl6aNoY=;
        b=RdPozpWd2OZ7J3L2uZ5eKmkjX3ZhElTWtIL9GxNp9Id56G3zTpJmCdUhkffE3o/Vw7
         2OVXZQPxgiXARnnF5GjBj2QsPpsNdtHHM/jRYxQEdNi1oF1DYu239Ynhkg6UriiGD029
         mbKhpvZj+nA5myoS98zg6U3O5qidrCcVUqI6HIXoH4N28YW4aUKOB+DUi9yoGExFfjOJ
         lj/ft6bmIuNRrDBBOP8cvUBUO8FKCYU3fvKIpdHhXTt7LetlToOt9MGXOTxrDG63fju+
         +Y7kIw8TILHpVCUQ6HL3wocz5CxhAdy+YjVJhRKJH29qsz06Hrul2IjxyLyX8fh4FJai
         eSAQ==
X-Gm-Message-State: AOAM530qnHdV7KXhelN9xVPqmBSNVnpkhfSE4oQDX1AGlFau6gusAeey
        8N+svSN5m3ZQzKSOKiWKvkfpg0mCWB94ZQ==
X-Google-Smtp-Source: ABdhPJwUmpeEzFZaYkXiwBlqapJk/ALEoHvZrEkaq3hH8Y0A/X4+utBDm466jDLfvr8FqBkxL19tgw==
X-Received: by 2002:a37:6705:: with SMTP id b5mr898587qkc.378.1618845378873;
        Mon, 19 Apr 2021 08:16:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:18 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/11 v2] libsepol/cil: More strict verification of constraint leaf expressions
Date:   Mon, 19 Apr 2021 11:15:52 -0400
Message-Id: <20210419151557.87561-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
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

