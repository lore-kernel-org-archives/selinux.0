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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F913C4320A
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219D860FDA
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhH0OUv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhH0OUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 10:20:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C5C061757
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so7322231qkc.4
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08dmOMw+jLvaWpCnotK1VjbqmE8K6hSH8bHbH4Eq2lQ=;
        b=AviyqiIOniFzwcJ76e4GFh14/yA180uejvgYEkm5c4YY6gSXYzKThrOIcz/sGKsGn7
         ttn0QPK8xa4fcYwKV7E8k3l7uWZ2ZkSwKHdWX8m3gP/yBlfSq/v7fgj3iTtvC8IQ5whB
         aKdSBv1z/pyXbxpjv6g4MNa834MFS6OnDOYLSwDkXrOB/ig5dJZe2cTcPeFIqcU5H7Pe
         FGlRY/w17HA/DGEgoqQM/Kk1mnQ+fLcDmG3FsqqngsMwOHVasE7MnXL7NZebs5taCFut
         xJVDxoMBjgvRtzKCs+CXhIsF3AtHoafQ+msrZFNFdC0ZYLVEbTaQPCKbCiLhNBHn+hM7
         nPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08dmOMw+jLvaWpCnotK1VjbqmE8K6hSH8bHbH4Eq2lQ=;
        b=Ws5JzOZfUHhP+ZR5Ayah7Y+he58/tBNmTX8mtRfCjsCGeYMRqnQB9Hf8KUypCNzYxN
         1/SqUId/mN3uLwjzmeLPn9yp/Pdd+BDTEhJRngfknfMeGUilFH8lHRbzfD8FOcJgQYVr
         F91Q7yHuIzLdLGOGSlj7cP61kUzbUtAPklVL6Md4dfw3mdW+fEoBRC6dGvCKy72AbtTt
         Rk2nnlQV8C1LxTHqnbVy/6utpobk8YmcjKJ0D4bxWpJ8U8jc+b6gYhFqwHS8Q3XFFC/z
         xnXXG3B/dWxkCpaRfXfN4ahn4jSBFFjQDGRoMxDmuZc12Qyapbtyu5Sa+GX6tx+QyCLS
         jOIA==
X-Gm-Message-State: AOAM5337xG1GrjjztqD5gg+Pm7e9oZc9GajrD8dL9TNUclnMVN48/O5U
        c7IWsM6yAUlaLmXdAREC5Jk+srRLXuU=
X-Google-Smtp-Source: ABdhPJxOLgborGUU++yTIEwilWouKQ1Lq4ITZ5PDZvHQ5TYm35/OcG93y2a8REHcgnNZpjFKzvZP7Q==
X-Received: by 2002:a37:9085:: with SMTP id s127mr8971908qkd.215.1630074001911;
        Fri, 27 Aug 2021 07:20:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s10sm4891010qko.134.2021.08.27.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:20:01 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsepol/cil: Reset expandtypeattribute rules when resetting AST
Date:   Fri, 27 Aug 2021 10:19:54 -0400
Message-Id: <20210827141955.370777-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827141955.370777-1-jwcart2@gmail.com>
References: <20210827141955.370777-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A list is created to store type attribute datums when resolving an
expandtypeattribute rule and that list needs to be destroyed if the
AST is reset or a memory leak will occur.

Destroy the list storing type attributes datums when resetting
expandtypeattribute rules.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 6d1d2da7..0ba075c8 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -208,6 +208,11 @@ static void cil_reset_typeattributeset(struct cil_typeattributeset *tas)
 	cil_list_destroy(&tas->datum_expr, CIL_FALSE);
 }
 
+static void cil_reset_expandtypeattribute(struct cil_expandtypeattribute *expandattr)
+{
+	cil_list_destroy(&expandattr->attr_datums, CIL_FALSE);
+}
+
 static void cil_reset_avrule(struct cil_avrule *rule)
 {
 	cil_reset_classperms_list(rule->perms.classperms);
@@ -531,6 +536,9 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_TYPEATTRIBUTESET:
 		cil_reset_typeattributeset(node->data);
 		break;
+	case CIL_EXPANDTYPEATTRIBUTE:
+		cil_reset_expandtypeattribute(node->data);
+		break;
 	case CIL_RANGETRANSITION:
 		cil_reset_rangetransition(node->data);
 		break;
@@ -630,7 +638,6 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_CLASSORDER:
 	case CIL_CATORDER:
 	case CIL_SENSITIVITYORDER:
-	case CIL_EXPANDTYPEATTRIBUTE:
 		break; /* Nothing to reset */
 	default:
 		break;
-- 
2.31.1

