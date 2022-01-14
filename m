Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43CC433EF
	for <selinux@archiver.kernel.org>; Fri, 14 Jan 2022 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiANTUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiANTUO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jan 2022 14:20:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7AC061574
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:20:14 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b127so11932379qkd.0
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWoF51O+dvgc/bZ2kdkF80dG6btf7djMvFSi0ffdaAk=;
        b=je1d7rT4N/9cD2Rzt9O2HLwjBTBnGfimo1xHpVp3IphyGNtl8B7TtQamnUS6wD1KM3
         IRoWrT6PuSG1468ByE+MsfxVmBih2zDtjzJVZntdiT6KGt+fF7FVJvheSlWeV1fr75So
         n3E2jTlszInlxK9h9rP3qWThPBO63eGZaeSBYxRuIxtxE+4VMGsz7gf6V/G9qJLE/q+U
         IPlyy2eDiVEkfrWdk9c6iWgz9PZhrSY8fAWVm19U/9Cf8HmqhnhpbkRJOrfIE62/CBgb
         qRiKJwngaq4IGhN2aEdYodYlBQEfTEWyzxXeKo73NyuKJ4XaGj31RpkAVkD2ZVWcygKE
         a7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWoF51O+dvgc/bZ2kdkF80dG6btf7djMvFSi0ffdaAk=;
        b=DDY+M9kaW5ZMS30U1bmaNYzVmA4sgp8WT5+MfxCpAhwOkcAEJ17VIrcqF+E10CJnBQ
         P/021AfY/duXN8HixK0D6Kv3sjWomfRxqhdne2fwa2+iHu9WMpjkmOTo/daEtsTenm/G
         VvMY4YwmdUn8bqxGHz3F8w6t+PZVCUjGcHtDHjOLffuImCruiMAH5ppaPbUUvrsmG1G3
         oXySjZA8JswwATIDKFT7PysAVslX0+AIYVajoH+F8j5fcGOQHR6jIwT4632StATn3Feu
         KSVdXgd47pTfGjRIbbtUgsQ9ZXA38F4gr9QI/LT/QMfkJhwQaAiQ2dP3sxYkyA4bkhQK
         4fHw==
X-Gm-Message-State: AOAM531zX91hxEr5haT3CBOTJzmfiYswOknu2HVN7NPCCUrMRt85clsB
        5X9Brbm1mnzFywawnDdQusKfdy/UEng=
X-Google-Smtp-Source: ABdhPJxXz4NCqZvf8YZGsBwDF8uacCgMyEmBn9xbX38tDpJciW7U7Pr740TW+zGhHnqbjK/vBuudWw==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr7579892qkl.665.1642188013227;
        Fri, 14 Jan 2022 11:20:13 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t21sm3447676qtc.46.2022.01.14.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:20:12 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol/cil: Limit the amount of reporting for context rule conflicts
Date:   Fri, 14 Jan 2022 14:20:02 -0500
Message-Id: <20220114192002.730773-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114192002.730773-1-jwcart2@gmail.com>
References: <20220114192002.730773-1-jwcart2@gmail.com>
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

Report all the duplicate conflicting rules together and only report
the first 10 conflicts of the same rule.

Fixes problem found by oss-fuzz (#39735)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 46 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 7e2c2b9a..f0520abe 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2280,7 +2280,8 @@ static int __cil_post_report_conflict(struct cil_tree_node *node, uint32_t *fini
 static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)(const void *, const void *), int (*concompar)(const void *, const void *), struct cil_db *db, enum cil_flavor flavor, const char *flavor_str)
 {
 	uint32_t count = sort->count;
-	uint32_t i, j = 0, removed = 0;
+	uint32_t i = 0, j, removed = 0;
+	int conflicting = 0;
 	int rc = SEPOL_OK;
 
 	if (count < 2) {
@@ -2289,36 +2290,41 @@ static int __cil_post_process_context_rules(struct cil_sort *sort, int (*compar)
 
 	qsort(sort->array, sort->count, sizeof(sort->array), compar);
 
-	for (i=1; i<count; i++) {
+	for (j=1; j<count; j++) {
 		if (compar(&sort->array[i], &sort->array[j]) != 0) {
-			j++;
+			i++;
+			if (conflicting >= 10) {
+				cil_log(CIL_WARN, "  Only first 10 of %d conflicting rules shown\n", conflicting);
+			}
+			conflicting = 0;
 		} else {
 			removed++;
 			if (!db->multiple_decls ||
 			   concompar(&sort->array[i], &sort->array[j]) != 0) {
 				struct cil_list_item li;
 				int rc2;
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
+				conflicting++;
+				if (conflicting == 1) {
+					cil_log(CIL_WARN, "Found conflicting %s rules\n", flavor_str);
+					rc = SEPOL_ERR;
+					li.flavor = flavor;
+					li.data = sort->array[i];
+					rc2 = cil_tree_walk(db->ast->root, __cil_post_report_conflict,
+										NULL, NULL, &li);
+					if (rc2 != SEPOL_OK) goto exit;
+				}
+				if (conflicting < 10) {
+					li.data = sort->array[j];
+					rc2 = cil_tree_walk(db->ast->root, __cil_post_report_conflict,
+										NULL, NULL, &li);
+					if (rc2 != SEPOL_OK) goto exit;
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

