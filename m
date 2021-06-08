Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D88C4743F
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44E060FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFHQBU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhFHQBT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFDCC06178B
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g18so23108992edq.8
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f8Skzmh2yOOR2rqJQHZGom4biqoFz9njBKN2ekELaQU=;
        b=r309N2V7/sARVTjc26o2IbuaTlM4x1UjKTSBKLNo9W+DPO7xiP38lKBRrSpL+teD86
         Te3aOGfql/WsXRMZ92x40nkZvx5xCM1c161fpQrYWTdadP/09H/dHMqXmk8c8kOQ6XJH
         jLXchMRg/IwQgWnI9h5s2KGPS7GqsovsN1/zcZ3DvJ6dAjgzVLGF1xKQ/qExFTgFStMu
         gJvu1RQdiXxD50mOXCFrZHNWTRBVVw48vYn36IS9ZyX7GEQDwuFXGHwDDrDBnZ7i8jZZ
         an6GPE9eozos2lMThrL4YqtiS++nLSg9sRs5LxpJJ88ek3AL32wquFc2LAQ4uPOzKxQb
         Te2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8Skzmh2yOOR2rqJQHZGom4biqoFz9njBKN2ekELaQU=;
        b=TVAT2w51Mk/lz9bSdx3j3JIVdTb0bTVnOJ+COQu9sCuf2tK9xSYE/5dXB3nl0SIal/
         s44P7FQk1BDkbNIF8Fbp/hFvRFvC7fokABbfMGNtUfLaLVgCBZbvksmQXbIVl6xLaREc
         uOXb2bwwj6kQSzNbemjGtodWf16tLjSgqC+SR5Sb6TLMLpHfPqb6IMAwuzWq5A84x3z3
         6GsgDY00OxYzPxmr1JiTRkUoeNBYtkBJp5xoOUe4T/lYUYi/KUoVpgUMhkkvXQEgCUY5
         Ce9b48eXrrH4v9s9kWp5s5J7JZZ6+Ilivwqhiy+0MhIOiPj3jM8XxgwSgNT5YhYOvF5F
         e1Hw==
X-Gm-Message-State: AOAM530ieLXCLho+lsQ30033cqdwQk1+5xx1RJtt12F+zQmXkAaxtR0N
        VD+gF9ysDF5DySLWX8kMhALbNJ/8DCQ=
X-Google-Smtp-Source: ABdhPJxmz+S6xuWjTrPfZ/nfRvOZPfV7cz8T5EWDLbxkdxqdu9Xrz//yghMj6gHAwlfIGIh/MNdxNw==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr26447383edt.152.1623167964956;
        Tue, 08 Jun 2021 08:59:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/23] libsepol: mark read-only parameters of ebitmap interfaces const
Date:   Tue,  8 Jun 2021 17:58:59 +0200
Message-Id: <20210608155912.32047-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h | 16 ++++++++--------
 libsepol/src/ebitmap.c                    | 18 +++++++++---------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 634436f6..81d0c7a6 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -67,7 +67,7 @@ static inline unsigned int ebitmap_next(ebitmap_node_t ** n, unsigned int bit)
 	return (bit + 1);
 }
 
-static inline int ebitmap_node_get_bit(ebitmap_node_t * n, unsigned int bit)
+static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigned int bit)
 {
 	if (n->map & (MAPBIT << (bit - n->startbit)))
 		return 1;
@@ -83,18 +83,18 @@ static inline int ebitmap_node_get_bit(ebitmap_node_t * n, unsigned int bit)
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
-extern int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2);
-extern int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2);
-extern int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbit);
-extern int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int maxbit);
-extern unsigned int ebitmap_cardinality(ebitmap_t *e1);
-extern int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2);
+extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
+extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
+extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit);
+extern int ebitmap_andnot(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2, unsigned int maxbit);
+extern unsigned int ebitmap_cardinality(const ebitmap_t *e1);
+extern int ebitmap_hamming_distance(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src);
 extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
 extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
-extern unsigned int ebitmap_highest_set_bit(ebitmap_t * e);
+extern unsigned int ebitmap_highest_set_bit(const ebitmap_t * e);
 extern void ebitmap_destroy(ebitmap_t * e);
 extern int ebitmap_read(ebitmap_t * e, void *fp);
 
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 522e14a6..4e9acdf8 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -71,7 +71,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	return 0;
 }
 
-int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
+int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
 	unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));
 	ebitmap_init(dst);
@@ -85,7 +85,7 @@ int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
 	return 0;
 }
 
-int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
+int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
 	unsigned int i, length = max(ebitmap_length(e1), ebitmap_length(e2));
 	ebitmap_init(dst);
@@ -98,7 +98,7 @@ int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
 	return 0;
 }
 
-int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbit)
+int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit)
 {
 	unsigned int i;
 	ebitmap_init(dst);
@@ -111,7 +111,7 @@ int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbit)
 	return 0;
 }
 
-int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int maxbit)
+int ebitmap_andnot(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2, unsigned int maxbit)
 {
 	int rc;
 	ebitmap_t e3;
@@ -126,10 +126,10 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
 	return 0;
 }
 
-unsigned int ebitmap_cardinality(ebitmap_t *e1)
+unsigned int ebitmap_cardinality(const ebitmap_t *e1)
 {
 	unsigned int count = 0;
-	ebitmap_node_t *n;
+	const ebitmap_node_t *n;
 
 	for (n = e1->node; n; n = n->next) {
 		count += __builtin_popcountll(n->map);
@@ -137,7 +137,7 @@ unsigned int ebitmap_cardinality(ebitmap_t *e1)
 	return count;
 }
 
-int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2)
+int ebitmap_hamming_distance(const ebitmap_t * e1, const ebitmap_t * e2)
 {
 	int rc;
 	ebitmap_t tmp;
@@ -347,9 +347,9 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 	return 0;
 }
 
-unsigned int ebitmap_highest_set_bit(ebitmap_t * e)
+unsigned int ebitmap_highest_set_bit(const ebitmap_t * e)
 {
-	ebitmap_node_t *n;
+	const ebitmap_node_t *n;
 	MAPTYPE map;
 	unsigned int pos = 0;
 
-- 
2.32.0

