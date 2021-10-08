Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0DC433FE
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6813460F9E
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhJHVMe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVMe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 17:12:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D410C061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 14:10:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 73so10840726qki.4
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sv+WSIFY9coACSqYRvs/n2rnMq3n/kKESVVqYF0view=;
        b=HNNkc+lTi7mKAz+XvvonQ7oFiDbYKZAr++TJlWzDxWJZExaXf0Tm47fxRQPADl5EXN
         roORbeFRwRvWsz7bHTUd/TpEqED7wK/Wn+TS9tHp4btELw8vIIRm/rkaPIrxEYTNutbI
         DHBArXRvBKcroZqLjrHEuheSgq8bzTUiTo40mxBt++vxpY4Z4ZBifWVFiFO5vfDIczLA
         909/QM5chhReFBkQPfLUC1iDk9Xq3z32lXCQ9MbNQTINuDeXZv27lvszMe7GXTSigoFV
         6Wm+NxbNPe60xDitsf5QOOYflRbpniodYMqe1M8aD77sYRJgtMYytqPirXoZJ72Fmh1a
         J9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sv+WSIFY9coACSqYRvs/n2rnMq3n/kKESVVqYF0view=;
        b=59v+5dp3qykWYYOywzlfCHp0USYvFyRi5zTM4eWe6JmD9qgBt6glq8zZbqKJjrxErv
         xQS960rhwSKzm5ihFArri1ZHYFUCTang916o0RFEe3BkmlwVrPqgQaKLphFcoyG7P3xK
         gWCdLd0kqQ5LKW+WFvB4VsP6Ys7K+iA9J9ryP4N6oBVdsROGhsNGn58FJFGL8VGvp6Yp
         kLT4j2+d/gOdGBsreO9ZBLttpELDkamzRz2nTPnmGfHpq6WkZM994uVqV4G+kbetRZpF
         BK/aqUqpCkyg4dopCsXqBgp3gkuY6qYm7nbhdBop7xhqyDyXHdx4Fn5uWEbt8HCfw+Yi
         3AjA==
X-Gm-Message-State: AOAM532cVfQ90ALrSH9zrcyjgEdURQDRlKsuWJzsNugaL0Q2a5Dmm6Rz
        U0zdlBN4cx1PjGE9HxYzmWQCbW3ft7w=
X-Google-Smtp-Source: ABdhPJwmHTii51wZtfRXphkc8TPAE/ajZo7XbcTi66KCy8okQWzjZ7eRTCvS6y/ZUB/AjKO9yXpZwg==
X-Received: by 2002:a37:f902:: with SMTP id l2mr4927140qkj.511.1633727437447;
        Fri, 08 Oct 2021 14:10:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u9sm332453qta.90.2021.10.08.14.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:10:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/4] libsepol/cil: Fix potential undefined shifts
Date:   Fri,  8 Oct 2021 17:10:29 -0400
Message-Id: <20211008211031.393884-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008211031.393884-1-jwcart2@gmail.com>
References: <20211008211031.393884-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An expression of the form "1 << x" is undefined if x == 31 because
the "1" is an int and cannot be left shifted by 31.

Instead, use "UINT32_C(1) << x" which will be an unsigned int of
at least 32 bits.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ec5f01e5..34dc63c7 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *da
 			goto exit;
 		}
 	}
-	*datum |= 1 << (sepol_perm->s.value - 1);
+	*datum |= UINT32_C(1) << (sepol_perm->s.value - 1);
 
 	return SEPOL_OK;
 
@@ -1523,7 +1523,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
 /* index of the u32 containing the permission */
 #define XPERM_IDX(x) (x >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
+#define XPERM_SETBITS(x) (UINT32_C(1) << (x & 0x1f)) - 1)
 /* low value for this u32 */
 #define XPERM_LOW(x) (x << 5)
 /* high value for this u32 */
@@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
 	cil_list_init(&cp->perms, CIL_PERM);
 	for (i = 0; i < sepol_class->permissions.nprim; i++) {
 		struct cil_perm *perm;
-		if ((data & (1 << i)) == 0) continue;
+		if ((data & (UINT32_C(1) << i)) == 0) continue;
 		perm = perm_value_to_cil[class][i+1];
 		if (!perm) goto exit;
 		cil_list_append(cp->perms, CIL_PERM, perm);
-- 
2.31.1

