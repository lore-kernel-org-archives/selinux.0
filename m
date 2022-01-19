Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03126C43219
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356161AbiASQfe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356159AbiASQfd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:35:33 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42542C06161C
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 193so3222580qkh.13
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWD1gmrTBS5AqRAp/neCI4yH1ztJZFB/TS2HBhDZnEU=;
        b=ReWR7mUx55ZmJ7HNBkrXbcwoCpuAjXMP0VKTfkRUMkFnD1YMISRi8IaWpINBMRVgAj
         vefCLgp6etMFTuUNAVd6bWw8U3goJmINgE808ezCuUQ8mg5z7y45ELTrz2633I3cP/Rp
         DqqBuyVHigsl5zP15P1FJHKA/m7hF6hsVQS3ulT5P/w4j5VlGH1TxmSPz0FM21ErxQAx
         PzOV8xEbECe7a92qHygfwWVJr//ME6xznIjJKzUoqBhOTOzXiomR9JP7IiueyaIHr2V5
         3APBw4wU8VPoKZVgeZIYwj40vJORw6fTM6S2IUFautNa8EEuNNtVZTjecH2aWQ1JDCv+
         Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWD1gmrTBS5AqRAp/neCI4yH1ztJZFB/TS2HBhDZnEU=;
        b=KtC5kfUtCfYOikkgL3WG2OHobw8IW/aKNC5B6vPIthemt38quOoLToOIKQ7Mtyh86/
         xVg2NFWAPTnigVFCVGKdY1LQv6Q+Tig1+KPLz0cQ2+RmE/K/YcIotIbsucjSHN4dtDfm
         vvg0VXy7iIigc/w72K30c+h39UD1CZPYpgiGjInlvI5jNGjYWT0NJWwOjSar383AUbrZ
         2yfhDSEL+PGg2ZGahhh/9iU21kCZoSfOmypQAnKc1kmRe+0ZOCvrbteoLfTIMRJJZBEP
         /qIqXvwuwgYmncoBcBaw85pL9aczpMiRTgBR90/eEZL34o8PcLwpkRgsHHxlz8g4Celu
         YdMQ==
X-Gm-Message-State: AOAM533lLlFbt938R1mve2exv/HfazV24WH++uxQ8eU4Ff168mmyVAlZ
        uNbVuvM4o0tvlVKJrZlRPLJYOlRSUdM=
X-Google-Smtp-Source: ABdhPJzUF195BFW1H3mT3vgsjWup8jswig6xnj3au4d4YivpyqOUGZkiS7nZKCCy6twrf0JqEfMVsQ==
X-Received: by 2002:a37:9b8a:: with SMTP id d132mr21854161qke.672.1642610132263;
        Wed, 19 Jan 2022 08:35:32 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id b200sm127231qkc.50.2022.01.19.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:35:32 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4 v2] libsepol/cil: Limit the amount of reporting for context rule conflicts
Date:   Wed, 19 Jan 2022 11:35:18 -0500
Message-Id: <20220119163518.93780-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220119163518.93780-1-jwcart2@gmail.com>
References: <20220119163518.93780-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When there are conflicting context rules, the location of the
conflicting rules are written out. If there are many duplicates of
the same context rule, there will be many pairs of conflicts written
out. This hides the fact that all of the rules are the same and can
make it hard to see the different conflicts.

First, since these are warnings and not reported at the default log
verbosity level (which only reports errors), only search for the
locations of the conflicting rules when the verbosity level means
that the warnings will actually be reported.

Second, Report all the duplicate conflicting rules together.

Third, Report the first four conflicts of the same rule if when
the verbosity level is at CIL_WARN ("-v") and report all of them
when the verbosity level is at CIL_INFO or higher ("-v -v").

Fixes problem found by oss-fuzz (#39735)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 57 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 7e2c2b9a..09c02af9 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2280,8 +2280,10 @@ static int __cil_post_report_conflict(struct cil_tree_node *node, uint32_t *fini
 static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)(const void *, const void *), int (*concompar)(const void *, const void *), struct cil_db *db, enum cil_flavor flavor, const char *flavor_str)
 {
 	uint32_t count = sort->count;
-	uint32_t i, j = 0, removed = 0;
+	uint32_t i = 0, j, removed = 0;
+	int conflicting = 0;
 	int rc = SEPOL_OK;
+	enum cil_log_level log_level = cil_get_log_level();
 
 	if (count < 2) {
 		return SEPOL_OK;
@@ -2289,36 +2291,43 @@ static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)
 
 	qsort(sort->array, sort->count, sizeof(sort->array), compar);
 
-	for (i=1; i<count; i++) {
+	for (j=1; j<count; j++) {
 		if (compar(&sort->array[i], &sort->array[j]) != 0) {
-			j++;
+			i++;
+			if (conflicting >= 4) {
+				/* 2 rules were written when conflicting == 1 */
+				cil_log(CIL_WARN, "  Only first 4 of %d conflicting rules shown\n", conflicting);
+			}
+			conflicting = 0;
 		} else {
 			removed++;
-			if (!db->multiple_decls ||
-			   concompar(&sort->array[i], &sort->array[j]) != 0) {
-				struct cil_list_item li;
-				int rc2;
-				cil_log(CIL_WARN, "Found conflicting %s rules\n",
-					flavor_str);
-				rc = SEPOL_ERR;
-				li.flavor = flavor;
-				li.data = sort->array[i];
-				rc2 = cil_tree_walk(db->ast->root,
-						    __cil_post_report_conflict,
-						    NULL, NULL, &li);
-				if (rc2 != SEPOL_OK) goto exit;
-				li.data = sort->array[j];
-				rc2 = cil_tree_walk(db->ast->root,
-						    __cil_post_report_conflict,
-						    NULL, NULL, &li);
-				if (rc2 != SEPOL_OK) goto exit;
+			if (!db->multiple_decls || concompar(&sort->array[i], &sort->array[j]) != 0) {
+				conflicting++;
+				if (log_level >= CIL_WARN) {
+					struct cil_list_item li;
+					int rc2;
+					li.flavor = flavor;
+					if (conflicting == 1) {
+						cil_log(CIL_WARN, "Found conflicting %s rules\n", flavor_str);
+						rc = SEPOL_ERR;
+						li.data = sort->array[i];
+						rc2 = cil_tree_walk(db->ast->root, __cil_post_report_conflict,
+											NULL, NULL, &li);
+						if (rc2 != SEPOL_OK) goto exit;
+					}
+					if (conflicting < 4 || log_level > CIL_WARN) {
+						li.data = sort->array[j];
+						rc2 = cil_tree_walk(db->ast->root, __cil_post_report_conflict,
+											NULL, NULL, &li);
+						if (rc2 != SEPOL_OK) goto exit;
+					}
+				}
 			}
 		}
-		if (i != j) {
-			sort->array[j] = sort->array[i];
+		if (i != j && !conflicting) {
+			sort->array[i] = sort->array[j];
 		}
 	}
-
 	sort->count = count - removed;
 
 exit:
-- 
2.31.1

