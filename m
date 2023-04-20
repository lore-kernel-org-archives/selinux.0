Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F62C77B7E
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDTPgJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjDTPgI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864940E5
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-953343581a4so73728766b.3
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004964; x=1684596964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C96sKIRAaChBMo8h8tmv3cooYyFNHwEKdRuv7vFYqy0=;
        b=XjP5OSpU2SkXPK99DOr74gRXw7CB9owgyZ/1f55Z6IgN2iHq7lDgplXNO15QIQs5qK
         EOjU1tZ6Y/Lapw9vxvWQDxqoIs+UlPWgIQDfbS52JH6Id5L/FT8TolWRN4N0cZyuSwSd
         DmOK1EqUqUk3IJ7VTo5dYh2ZLvYGUS+65i5P6lXmIhX7c6U72SCOtBU9+8KN1NKN6++Q
         Oq3jO3EB9pyRIbk+y7C15JjNSfE0rO6cO7zsZRRg8CVfLSdbwqHT57+LvH96VTpLzhnh
         8KD03R2HzctV3oOjsjWn/K1U4hQawVjrtE1n/+LDgFrN9q7V9CAyHA77c1yJ9pj7rZCO
         sdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004964; x=1684596964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C96sKIRAaChBMo8h8tmv3cooYyFNHwEKdRuv7vFYqy0=;
        b=dYKtdfX4nNstItp/UBfAav8uYWjvv7Rlfs5sIHNEjfoAQI5/U9felW270D5PLJd/rN
         wwqgbTlMRYP/bdoZxKGOmfYUV92o/CwcT6WRDet40eNgDskvLOX9llTmlxrcPE7X8A7T
         1MD6+S4U7ZO78eEOjULg/uwd44PIBlamtzBaRxW6nDcajaLhsJVgK+PmC3BjVpp9IwWR
         H1xL0CqzpjHujU6hHFLHj734rB/hT8F3lBM6mhBB1ek+5yhVJpqQ25MuepDR/M6kiUeP
         fFWcbpIP5zi4rIvtDioznLQaMLScFwUSmDucPO05/Levbt1pM0gZMtN6OQwUFIRD8G7V
         N1zg==
X-Gm-Message-State: AAQBX9fbXzdCS9NAmO7Nn9SI4WlghqkNiMrITor0ey0sL3IL3/vVzrpV
        NBrEHuC9xHMlOCzeIXkEXqSJpM8hVSI=
X-Google-Smtp-Source: AKy350buQHHA33TawPkTjyUEpMXKpO4l7c34nEFyQSsaWc0ydKNc9m963f9+VS85IUxebStCQmg6qA==
X-Received: by 2002:aa7:d80c:0:b0:506:2c70:3066 with SMTP id v12-20020aa7d80c000000b005062c703066mr2273002edq.21.1682004963995;
        Thu, 20 Apr 2023 08:36:03 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/6] libsepol/tests: rename bool indentifiers
Date:   Thu, 20 Apr 2023 17:35:53 +0200
Message-Id: <20230420153556.32115-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420153556.32115-1-cgzones@googlemail.com>
References: <20230420153556.32115-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 6ea0e4c2..14206666 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -51,7 +51,7 @@
  */
 
 typedef struct test_cond_expr {
-	const char *bool;
+	const char *boolean;
 	uint32_t expr_type;
 } test_cond_expr_t;
 
@@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_
 		CU_ASSERT_FATAL(expr != NULL);
 
 		CU_ASSERT(expr->expr_type == bools[i].expr_type);
-		if (bools[i].bool) {
-			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].bool) == 0);
+		if (bools[i].boolean) {
+			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].boolean) == 0);
 		}
 		expr = expr->next;
 	}
 }
 
-static void test_bool_state(policydb_t * p, const char *bool, int state)
+static void test_bool_state(policydb_t * p, const char *boolean, int state)
 {
 	cond_bool_datum_t *b;
 
-	b = hashtab_search(p->p_bools.table, bool);
+	b = hashtab_search(p->p_bools.table, boolean);
 	CU_ASSERT_FATAL(b != NULL);
 	CU_ASSERT(b->state == state);
 }
@@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
 	test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "g_b_bool_1", 0);
 	/* conditional expression mapped correctly */
-	bools[0].bool = "g_b_bool_1";
+	bools[0].boolean = "g_b_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
 	test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "o1_b_bool_1", 1);
 	/* conditional expression mapped correctly */
-	bools[0].bool = "o1_b_bool_1";
+	bools[0].boolean = "o1_b_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
 	test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "g_m1_bool_1", 1);
 	/* conditional expression mapped correctly */
-	bools[0].bool = "g_m1_bool_1";
+	bools[0].boolean = "g_m1_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
 	test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
 	test_bool_state(base, "o1_m1_bool_1", 0);
 	/* conditional expression mapped correctly */
-	bools[0].bool = "o1_m1_bool_1";
+	bools[0].boolean = "o1_m1_bool_1";
 	bools[0].expr_type = COND_BOOL;
 	test_cond_expr_mapping(base, d, bools, 1);
 
@@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
 	test_bool_state(base, "g_m2_bool_1", 1);
 	test_bool_state(base, "g_m2_bool_2", 0);
 	/* conditional expression mapped correctly */
-	bools[0].bool = "g_m2_bool_1";
+	bools[0].boolean = "g_m2_bool_1";
 	bools[0].expr_type = COND_BOOL;
-	bools[1].bool = "g_m2_bool_2";
+	bools[1].boolean = "g_m2_bool_2";
 	bools[1].expr_type = COND_BOOL;
-	bools[2].bool = NULL;
+	bools[2].boolean = NULL;
 	bools[2].expr_type = COND_AND;
 	test_cond_expr_mapping(base, d, bools, 3);
 }
-- 
2.40.0

