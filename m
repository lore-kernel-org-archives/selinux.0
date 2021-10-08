Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08881C433F5
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D638860F9E
	for <selinux@archiver.kernel.org>; Fri,  8 Oct 2021 21:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhJHVMd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVMd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Oct 2021 17:12:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE740C061570
        for <selinux@vger.kernel.org>; Fri,  8 Oct 2021 14:10:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id z15so7219699qvj.7
        for <selinux@vger.kernel.org>; Fri, 08 Oct 2021 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2iDWdiD8CSOIQx2q5djdnCrczqYEBsrUpo5KEaNd6E=;
        b=a8oHVMjt2Un7Mfsuod3g8lHedMW3UK/yUYZry707ZshYA2c34fYWcVMCgk10dGlwss
         oJ44aD8Y7ZCpgDtZgxiLA43jMNBbKNdxS30x4zRuELae1wbw3FjfcW4ZWnaxjqRfEGFn
         l3KnuJOJeSIDrZQ3YyTJ33NbQMwljaN8e1E2EqVb269SctPI2t9fQXbL8nvnRvFF/93G
         BXuNdii0CuskUJhWXBx2dNFWsLXPddybfHptLzMCZ2+4buXCTKU/i/e/Wh0OYx2uGg4P
         6iZTmmI4NitEI+7MRGiv3gq7PxlmUafp1OWI7pK8cO525ifnZiDYEexENP08bPTFf9vr
         d4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2iDWdiD8CSOIQx2q5djdnCrczqYEBsrUpo5KEaNd6E=;
        b=jhIO6Rl6uEL2alPJFjMIj5GzfbOjuAlJT0w4e5+5BeNtmFkCKQ51R1LpV9aliddPTL
         gKakG7GalLGtMB6PHY/wzAeBcmzwxwl9c8ejYwAh9jWqHH1mY6z7p8Xl0tjmcZIE2Muu
         uPdGlgWcJKWqN2lyWM5b1u3pMivrTvT6aiQH3dRcbFqW3MCSDsWr0zh1kwo3uxgz6U3h
         gXV3QjobiidPJPpDmVZtg9KjIDVYeYKqJE+9dmJRfS0fOWhqzbZRQDkwxG7R2LgfNLzE
         U8Fy1gVfjsLMEDmPozdrP5btjS3WPa5c529kxQplVT7cU9fcEmCC9gTDHyrdDi9TQEXy
         +o1Q==
X-Gm-Message-State: AOAM5300MGjx3WSGOSchlTB4GZq2W5fUWX6WxGu+KkgR7Wvc42Ewumbf
        cEbJc4x0sp78aZwQQoqkhSG/Ro1moe8=
X-Google-Smtp-Source: ABdhPJxgr/FMh6th4hKOubUKGJEww0nIh6jfCo77SN60s6Kk6lfLlChAztjrC4iCndyocsXzE8g7lg==
X-Received: by 2002:ad4:4622:: with SMTP id x2mr12506312qvv.39.1633727436586;
        Fri, 08 Oct 2021 14:10:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u9sm332453qta.90.2021.10.08.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:10:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4] libsepol: Fix potential undefined shifts
Date:   Fri,  8 Oct 2021 17:10:28 -0400
Message-Id: <20211008211031.393884-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An expression of the form "1 << x" is undefined if x == 31 because
the "1" is an int and cannot be left shifted by 31.

Instead, use "UINT32_C(1) << x" which will be an unsigned int of
at least 32 bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/avtab.c       | 2 +-
 libsepol/src/conditional.c | 6 +++---
 libsepol/src/link.c        | 4 ++--
 libsepol/src/policydb.c    | 4 ++--
 libsepol/src/services.c    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 93505b20..46e1e75d 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -376,7 +376,7 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
 	}
 	if (shift > 2)
 		shift = shift - 2;
-	nslot = 1 << shift;
+	nslot = UINT32_C(1) << shift;
 	if (nslot > MAX_AVTAB_HASH_BUCKETS)
 		nslot = MAX_AVTAB_HASH_BUCKETS;
 	mask = nslot - 1;
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index e3ede694..037dc7e2 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -411,13 +411,13 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 		}
 
 		/* loop through all possible combinations of values for bools in expression */
-		for (test = 0x0; test < (0x1U << cn->nbools); test++) {
+		for (test = 0x0; test < (UINT32_C(1) << cn->nbools); test++) {
 			/* temporarily set the value for all the bools in the
 			 * expression using the corr.  bit in test */
 			for (j = 0; j < cn->nbools; j++) {
 				p->bool_val_to_struct[cn->bool_ids[j] -
 						      1]->state =
-				    (test & (0x1 << j)) ? 1 : 0;
+				    (test & (UINT32_C(1) << j)) ? 1 : 0;
 			}
 			k = cond_evaluate_expr(p, cn->expr);
 			if (k == -1) {
@@ -428,7 +428,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 			}
 			/* set the bit if expression evaluates true */
 			if (k)
-				cn->expr_pre_comp |= 0x1 << test;
+				cn->expr_pre_comp |= UINT32_C(1) << test;
 		}
 
 		/* restore bool default values */
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 461d2feb..7512a4d9 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1291,10 +1291,10 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 				     i <
 				     module->perm_map_len[cur_perm->tclass - 1];
 				     i++) {
-					if (!(cur_perm->data & (1U << i)))
+					if (!(cur_perm->data & (UINT32_C(1) << i)))
 						continue;
 					new_perm->data |=
-					    (1U <<
+					    (UINT32_C(1) <<
 					     (module->
 					      perm_map[cur_perm->tclass - 1][i] -
 					      1));
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 7093d9b7..587ba64a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4166,7 +4166,7 @@ static sepol_access_vector_t policydb_string_to_av_perm(
 			hashtab_search(tclass_datum->permissions.table,
 			(hashtab_key_t)perm_name);
 	if (perm_datum != NULL)
-		return 0x1U << (perm_datum->s.value - 1);
+		return UINT32_C(1) << (perm_datum->s.value - 1);
 
 	if (tclass_datum->comdatum == NULL)
 		return 0;
@@ -4176,7 +4176,7 @@ static sepol_access_vector_t policydb_string_to_av_perm(
 			(hashtab_key_t)perm_name);
 
 	if (perm_datum != NULL)
-		return 0x1U << (perm_datum->s.value - 1);
+		return UINT32_C(1) << (perm_datum->s.value - 1);
 
 	return 0;
 }
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 673b3971..3407058f 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1213,7 +1213,7 @@ int sepol_string_to_av_perm(sepol_security_class_t tclass,
 			hashtab_search(tclass_datum->permissions.table,
 			perm_name);
 	if (perm_datum != NULL) {
-		*av = 0x1 << (perm_datum->s.value - 1);
+		*av = UINT32_C(1) << (perm_datum->s.value - 1);
 		return STATUS_SUCCESS;
 	}
 
@@ -1225,7 +1225,7 @@ int sepol_string_to_av_perm(sepol_security_class_t tclass,
 			perm_name);
 
 	if (perm_datum != NULL) {
-		*av = 0x1 << (perm_datum->s.value - 1);
+		*av = UINT32_C(1) << (perm_datum->s.value - 1);
 		return STATUS_SUCCESS;
 	}
 out:
-- 
2.31.1

