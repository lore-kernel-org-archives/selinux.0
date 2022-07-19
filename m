Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DECCCA483
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiGSPbJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiGSPbH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 11:31:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F558870
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so27907796ejb.4
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWHpdd1Gp2i82c79opTYMnv9mwhyMyNRPmGXCJAnIZ0=;
        b=KanbOXVuJ6HVRNl0V0lNuxLyzhVlWIAFHaZOr1oCWnHea7xdRPaJiSGlANTGAFmeQs
         1MIcLdXINl7sVsmBtiymquVvhuwfs5o2mZYYUZUO17wi96w9VnKJ4kANNhdY/jvZ3Tpr
         brjBiCSIS5vfvSMf9JED6Ha5gg80HqWDuF/GhTQSAYvFoP5iQmocQM/oHYhvxCGuUBhk
         6nEuec2xRRdE8CkgtiwhoyAaibiAE5dw7yJyoK2SG/5fpwM/RD8iUQJ1gdDgywHk0bSf
         9LBjDrAOqxT5k/mwlUpzMFoVXkBSiEygRnJu+IuMxbkAqJ7NeMUV/FaRC8oxVSyCyqZ8
         RNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWHpdd1Gp2i82c79opTYMnv9mwhyMyNRPmGXCJAnIZ0=;
        b=1RHOuiheSOuHBPHo67QeiRK+vAUTwT7QULHR25nnmnzHEnCaTgB0pLR/gnEUan6Wct
         gz9pA4SFvYqxE20WBKlFnlW3HxTbBonQ/zxCqdD1d515k0pTC6o7fv6EaiEiVdzUsqns
         twxtwef4L75JGFUUnbgth1Cbqu6pWQECyBMq3dad1+lSUsIqxGqMibdQH2S3vn25lguo
         htQW0020wzkrjncv7G8my9P4QYUaBkqpHyS6QSOqpGeFPcUjm6+LB5imNUwGURQAIT8n
         qzqwGmdFLJnITwSq7MHOB4KECK0clDrCDyPOQyTCYUbpOLTDlPv9ugh/pMwXe2H1attd
         /Qyg==
X-Gm-Message-State: AJIora/hHkhC2XmSuFnLh1vnsGJtV+KohcP2DbofUa/YwzCtw/xj4F05
        B6pL9Up4JPSRNk1c3kXz4PzNarnaWsWBsA==
X-Google-Smtp-Source: AGRyM1sc8htJnjrttKZuDPGFgAPL1AE51LrqNwzKuUnBs8JW7+XBft8lsPJFQwgKPt/MaVi/GaFqig==
X-Received: by 2002:a17:907:2cc8:b0:72b:52b3:68e with SMTP id hg8-20020a1709072cc800b0072b52b3068emr31782333ejc.298.1658244663990;
        Tue, 19 Jul 2022 08:31:03 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-001-147-221.77.1.pool.telefonica.de. [77.1.147.221])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906311b00b0072b7b317aadsm6809621ejx.150.2022.07.19.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:31:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/7] libsepol/cil: use ebitmap_init_range
Date:   Tue, 19 Jul 2022 17:30:40 +0200
Message-Id: <20220719153045.70041-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719153045.70041-1-cgzones@googlemail.com>
References: <20220719153045.70041-1-cgzones@googlemail.com>
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

