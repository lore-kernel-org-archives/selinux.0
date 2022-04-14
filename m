Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC5C43219
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiDNOnR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347704AbiDNN7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511E7BBE20
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o18so3540909qtk.7
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXVecjHHthg2gOVFiNcdfcarsEfa6CXU2XGClV9sI9g=;
        b=m0uaFN/O0KjEpM7uJH2d20tq4aPQLE3+MuOH0fbCD4J5zwmf+MZJUYmNQZl4YC1rNi
         qmWkBBQvBHyQXjmuW6LMw8UdK+c4Xj+vHAepZdMEux1TIRJnb8NXd0jkfpvsDTUrptWE
         hjyKzsV3fVIFqjINAjRdpKfEOx92ki3JMLswkgWjo0lQFa/AM3mKAnwOLqGmHqdSAZn+
         5ys4CjkDKRD2a2oiDQ8njz3shCyYr84IuRl9x648hoRMeAE5RLSUAd5ZMQ7LMF4WfmQO
         +WHyUgu5HFTO/CNKljCs6vYzEM/P2pEh16xIVbElJpVTNORMPR7SseM6uqo16kRlP9ZK
         AEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXVecjHHthg2gOVFiNcdfcarsEfa6CXU2XGClV9sI9g=;
        b=iPA55k1oOWYZUXScGc+wJHccx+I0+92gcT3/X+8dvVox6+6RGBm0Sl72oTbKDxEuh+
         uGL+1ixTH/S3LS9Hgm80a/uRZbnkBXd0QWd86pNsrZbhIX4hKjKJOmuFa7Gw+mR6wJbP
         8qVTBqCQKL/Usk0L/+CSNRE8dscFxGdFPWNJsSrnuyaPkRaBOEz/hy0t80fJbhSUBNOV
         gOq79g4u0wf76WYK57IXzDP/ROeuwsvcSCHik11Wtrhk6lseSvovuaRE50RsmC8jX70T
         /bQwH98x/O/hNdfzAnG7QFEIAD17OKzt/wsw20Vq4UHpeliDmNmT1+EN73CpuRilMru+
         rmhA==
X-Gm-Message-State: AOAM530VatN8W8kji5XxlS5JiVy4n0YHstc7BdRFGgzWESUApSDqdAiW
        iUi6TD8A9sWeHOceykZ6CpwtRVnhGJM=
X-Google-Smtp-Source: ABdhPJxrOTnacuUe2wcayDJAikDV+kaV+X15tiYDQU2oQMUCDxdvPTJHQC04Jh2Eg87r61ouhl9bNA==
X-Received: by 2002:ac8:70da:0:b0:2f1:d195:cfaf with SMTP id g26-20020ac870da000000b002f1d195cfafmr1806017qtp.247.1649944321298;
        Thu, 14 Apr 2022 06:52:01 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm999748qkj.17.2022.04.14.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:52:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5] libsepol/test: Declare file local functions as static
Date:   Thu, 14 Apr 2022 09:51:39 -0400
Message-Id: <20220414135141.1723610-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414135141.1723610-1-jwcart2@gmail.com>
References: <20220414135141.1723610-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is needed to use "-Wmissing-prototypes".

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/tests/test-expander.c        | 2 +-
 libsepol/tests/test-linker-cond-map.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index ee70e220..a9e66ed8 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -67,7 +67,7 @@ extern int mls;
 /* Takes base, some number of modules, links them, and expands them
    reads source from myfiles array, which has the base string followed by
    each module string */
-int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mymodules, policydb_t * myexpanded, const char *const *myfiles)
+static int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mymodules, policydb_t * myexpanded, const char *const *myfiles)
 {
 	char *filename[num_modules + 1];
 	int i;
diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 5400c46b..694a7346 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -55,7 +55,7 @@ typedef struct test_cond_expr {
 	uint32_t expr_type;
 } test_cond_expr_t;
 
-void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_expr_t * bools, int len)
+static void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_expr_t * bools, int len)
 {
 	int i;
 	cond_expr_t *expr;
@@ -76,7 +76,7 @@ void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_expr_t
 	}
 }
 
-void test_bool_state(policydb_t * p, const char *bool, int state)
+static void test_bool_state(policydb_t * p, const char *bool, int state)
 {
 	cond_bool_datum_t *b;
 
-- 
2.34.1

