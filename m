Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC4C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGLQJO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiGLQJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E012625
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l23so15162692ejr.5
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zWHpdd1Gp2i82c79opTYMnv9mwhyMyNRPmGXCJAnIZ0=;
        b=E962jEg21N5C9b499FqfGZTds7yFj45Whqk/O0RePud1iOoCE0MJdlYI27/bAYASb/
         VJ30DO+CghJDhnxtGxtUY5uLK1FESfTfqojJf0Ijf6GFhlfcnTbSDnIq6xTPG1TLKHjv
         s3/Oq18BQwU2rX4jkvKYEQSMl8eHIoWTxcHN8o/LoyLgzX5SJc2e3dFLLPRwGZJkon65
         Lmyu6GRu2guNlL/wRL4RxTzFxLLnh+16RVPg13epsSO2QqaNHQhHU9zfe+8Cau85MxWB
         h4xQ30AKoloT9uvHOzi5lenvgsTXBzhOIEPtHxWD4gmwGUXq9UV3D6CIkGEgagBb3/aP
         23/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWHpdd1Gp2i82c79opTYMnv9mwhyMyNRPmGXCJAnIZ0=;
        b=KDR/0MGr6psDszGKwgGJh5JfByH1l0BKlqICWqOsp39fpJn7U9aTUuyOPRN2ZEmvAr
         C0rSdSMtB13370xNv0+nVPTiJ/DrmNeGo9YeY3HUAKrdAKCrVERCkDQRvfz03HVknGpS
         9zPvViLdQOgEJEd1zMSFoa+Et2lt9ufh8MDpyihMkhS4rjL+TiAJQcQ7tZ6Toq/GM+ce
         jZ8bGoxYYknUY90On6m8cFAq+O/CPBaRT4dq+vyq8pWrBCHHUMKCF2NF3D6RrwC8GYVZ
         wFKYsbFhMXluSAtRB/W2vQyykzki1FUc5ACfF/iuDeDVIsoTmnf50OSR+VtcS1CFj5U7
         KFpQ==
X-Gm-Message-State: AJIora9yrJ3xh5we87tLLAhr1T6pBdJMc9hhtsxnXgUJC+fTHwkKJJP3
        MrCV8jc8AQVGPNljLKKUAz5c3WmuDQrABQ==
X-Google-Smtp-Source: AGRyM1sv404SnU6RHdiGbtvpQsXe3iQmr7GXT9cyZgKFi825UMuu9uxwKlQI7dKaYIalCPwYd46e9w==
X-Received: by 2002:a17:907:2d8a:b0:722:e35b:695 with SMTP id gt10-20020a1709072d8a00b00722e35b0695mr25438635ejc.470.1657642145502;
        Tue, 12 Jul 2022 09:09:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/7] libsepol/cil: use ebitmap_init_range
Date:   Tue, 12 Jul 2022 18:08:54 +0200
Message-Id: <20220712160858.22677-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
References: <20220712160858.22677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Especially in the case of __cil_permissionx_expr_range_to_bitmap_helper()
it substitutes hundreds of thousand of calls to ebitmap_set_bit() during
semodule(8) on a policy widely using extended permissions.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 714ce227..6e95225f 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1191,7 +1191,6 @@ static int __cil_cat_expr_range_to_bitmap_helper(struct cil_list_item *i1, struc
 	struct cil_tree_node *n2 = d2->nodes->head->data;
 	struct cil_cat *c1 = (struct cil_cat *)d1;
 	struct cil_cat *c2 = (struct cil_cat *)d2;
-	int i;
 
 	if (n1->flavor == CIL_CATSET || n2->flavor == CIL_CATSET) {
 		cil_log(CIL_ERR, "Category sets cannont be used in a category range\n");
@@ -1213,12 +1212,10 @@ static int __cil_cat_expr_range_to_bitmap_helper(struct cil_list_item *i1, struc
 		goto exit;
 	}
 
-	for (i = c1->value; i <= c2->value; i++) {
-		if (ebitmap_set_bit(bitmap, i, 1)) {
-			cil_log(CIL_ERR, "Failed to set cat bit\n");
-			ebitmap_destroy(bitmap);
-			goto exit;
-		}
+	if (ebitmap_init_range(bitmap, c1->value, c2->value)) {
+		cil_log(CIL_ERR, "Failed to set cat bit\n");
+		ebitmap_destroy(bitmap);
+		goto exit;
 	}
 
 	return SEPOL_OK;
@@ -1234,7 +1231,6 @@ static int __cil_permissionx_expr_range_to_bitmap_helper(struct cil_list_item *i
 	char *p2 = i2->data;
 	uint16_t v1;
 	uint16_t v2;
-	uint32_t i;
 
 	rc = __cil_permx_str_to_int(p1, &v1);
 	if (rc != SEPOL_OK) {
@@ -1246,12 +1242,10 @@ static int __cil_permissionx_expr_range_to_bitmap_helper(struct cil_list_item *i
 		goto exit;
 	}
 
-	for (i = v1; i <= v2; i++) {
-		if (ebitmap_set_bit(bitmap, i, 1)) {
-			cil_log(CIL_ERR, "Failed to set permissionx bit\n");
-			ebitmap_destroy(bitmap);
-			goto exit;
-		}
+	if (ebitmap_init_range(bitmap, v1, v2)) {
+		cil_log(CIL_ERR, "Failed to set permissionx bits\n");
+		ebitmap_destroy(bitmap);
+		goto exit;
 	}
 
 	return SEPOL_OK;
@@ -1318,9 +1312,7 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 		enum cil_flavor op = (enum cil_flavor)(uintptr_t)curr->data;
 
 		if (op == CIL_ALL) {
-			ebitmap_init(&b1); /* all zeros */
-			rc = ebitmap_not(&tmp, &b1, max);
-			ebitmap_destroy(&b1);
+			rc = ebitmap_init_range(&tmp, 0, max - 1);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_INFO, "Failed to expand 'all' operator\n");
 				ebitmap_destroy(&tmp);
@@ -1328,19 +1320,15 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 			}
 		} else if (op == CIL_RANGE) {
 			if (flavor == CIL_CAT) {
-				ebitmap_init(&tmp);
 				rc = __cil_cat_expr_range_to_bitmap_helper(curr->next, curr->next->next, &tmp);
 				if (rc != SEPOL_OK) {
 					cil_log(CIL_INFO, "Failed to expand category range\n");
-					ebitmap_destroy(&tmp);
 					goto exit;
 				}
 			} else if (flavor == CIL_PERMISSIONX) {
-				ebitmap_init(&tmp);
 				rc = __cil_permissionx_expr_range_to_bitmap_helper(curr->next, curr->next->next, &tmp);
 				if (rc != SEPOL_OK) {
 					cil_log(CIL_INFO, "Failed to expand category range\n");
-					ebitmap_destroy(&tmp);
 					goto exit;
 				}
 			} else {
-- 
2.36.1

