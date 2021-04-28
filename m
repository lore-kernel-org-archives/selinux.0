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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF7C433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D38F6143F
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 20:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbhD1USu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbhD1USs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 16:18:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B3C061574
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 66so25400485qkf.2
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR9Ttq3ZYNAd96OGPM3jBsjzU0I1N1UfJBbAkjsIozM=;
        b=pXJTDrhzY4ZywKONjmRKC0OGVPsEOJPUiNbK7rOtObdb2QTEfMbu5FS6SSCcp3q/45
         +qG+dpFyBR5OhnmFD05BYfpQujeumpG95WANopkA5yxhMJHm/1CzeszqUj4XRR02JoqB
         AZcNrN+97rzWUaDy4xa+L45dpKPu2MmB9HUa63wn9/Bhr5WxrhigqZ7ta1vuLnvFmDQN
         tKHk8828h8ZYNcQBpzYLFtvP7VnEOMyfTjiHff1noklXeCAMkTSvvGW/SS9Z9dhAG8r6
         7waMXk9wscpikLAS4PCGuZW9gOnySEYlODIP9PUZbD6ZI6hEVo7g/0V2uyzho8nWaeqJ
         RAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR9Ttq3ZYNAd96OGPM3jBsjzU0I1N1UfJBbAkjsIozM=;
        b=lrSGWVNFCUahNLPQDts/Z7kN1H/ftZsmi4OY95UqRfjryTlWXfxpxGP4XD93hJ4Fiv
         5HJonl0rT7747/qQh1WttbTgaPHZI1mGBzMtxOT1AopxX2wruRufnrxUL/TWnf0pVsjI
         HqWRBPyBPjs8Q7s8WB8mjnvZgkM/QbItzwBR0QrAr4u7VyBsMfYdZRxofvp9ua26Tyf3
         HKugm13Ful3+RCjPJzxn6khb0Dlf4zYUDA8KtBLoJrTCrt6CophYfkGyzE6c6eCmENzP
         ok2iH83HGQej5Mv+SQ1FLDx4R2Q0blfvO4xNwOCIer1GzyYcyCmumM9kjc9NrNamz5MU
         lRCw==
X-Gm-Message-State: AOAM530SKYSukTk8QtojJOzfvU8+Xh+dfiME/m4fA6woeNo4ht9eOtJe
        5tpQ1YATNkBLX8mS2mv6tfYnTtc4hqdLbA==
X-Google-Smtp-Source: ABdhPJy7G/XB9yi8MwjWGiDQ7Uijpo731fv3d9gvb4Z01gvmF0XZDVgIrNzEWwq9GwWncGN8A6V5rQ==
X-Received: by 2002:a37:e412:: with SMTP id y18mr31814666qkf.40.1619641081264;
        Wed, 28 Apr 2021 13:18:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q126sm616666qkd.48.2021.04.28.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:18:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5] libsepol/cil: Detect degenerate inheritance and exit with an error
Date:   Wed, 28 Apr 2021 16:17:50 -0400
Message-Id: <20210428201753.282831-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
References: <20210428201753.282831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A CIL policy with inheritance of the form
...
(blockinherit ba)
(block ba
  (block b1
    (blockinherit bb)
  )
  (block bb
    (block b2
      (blockinherit bc)
    )
    (block bc
      (block b3
        (blockinherit bd)
      )
      (block bd
        (block b4
          (blockinherit be)
        )
        (block be
        ...
will require creating 2^depth copies of the block at the bottom of
the inheritance chain. This pattern can quickly consume all the
memory of the system compiling this policy.

The depth of the inheritance chain can be found be walking the
tree up through the parents and noting how many of the parent
blocks have been inherited. The number of times a block will be
copied is found by counting the list of nodes in the "bi_nodes"
list of the block. To minimize legitimate policies from being
falsely detected as being degenerate, both the depth and breadth
(number of copies) are checked and an error is given only if both
exceed the limits (depth >= 12 and breadth >= 4096).

This problem was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_internal.h    |  2 ++
 libsepol/cil/src/cil_resolve_ast.c | 54 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 9bdcbdd0..74e0b34d 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -48,6 +48,8 @@
 
 #define CIL_MAX_NAME_LENGTH 2048
 
+#define CIL_DEGENERATE_INHERITANCE_DEPTH 12
+#define CIL_DEGENERATE_INHERITANCE_BREADTH (0x1 << CIL_DEGENERATE_INHERITANCE_DEPTH)
 
 enum cil_pass {
 	CIL_PASS_INIT = 0,
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 5389df43..68909647 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2410,6 +2410,55 @@ exit:
 	return rc;
 }
 
+/*
+ * Detect degenerate inheritance of the form:
+ * ...
+ * (blockinherit ba)
+ * (block ba
+ *    (block b1
+ *      (blockinherit bb)
+ *    )
+ *    (block bb
+ *      (block b2
+ *        (blockinherit bc)
+ *      )
+ *      (block bc
+ *      ...
+ */
+static int cil_check_for_degenerate_inheritance(struct cil_tree_node *current)
+{
+	struct cil_block *block = current->data;
+	struct cil_tree_node *node;
+	struct cil_list_item *item;
+	unsigned depth;
+	unsigned breadth = 0;
+
+	cil_list_for_each(item, block->bi_nodes) {
+		breadth++;
+	}
+
+	if (breadth >= CIL_DEGENERATE_INHERITANCE_BREADTH) {
+		node = current->parent;
+		depth = 0;
+		while (node && node->flavor != CIL_ROOT) {
+			if (node->flavor == CIL_BLOCK) {
+				block = node->data;
+				if (block->bi_nodes != NULL) {
+					depth++;
+				}
+			}
+			node = node->parent;
+		}
+
+		if (depth >= CIL_DEGENERATE_INHERITANCE_DEPTH) {
+			cil_tree_log(current, CIL_ERR, "Degenerate inheritance detected (depth=%u, breadth=%u)", depth, breadth);
+			return SEPOL_ERR;
+		}
+	}
+
+	return SEPOL_OK;
+}
+
 int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_block *block = current->data;
@@ -2426,6 +2475,11 @@ int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_arg
 
 	db = args->db;
 
+	rc = cil_check_for_degenerate_inheritance(current);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	// Make sure this is the original block and not a merged block from a blockinherit
 	if (current != block->datum.nodes->head->data) {
 		rc = SEPOL_OK;
-- 
2.26.3

