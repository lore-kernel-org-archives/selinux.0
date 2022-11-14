Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79EC4321E
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiKNULI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiKNUKx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7A1B1DD
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f5so31088306ejc.5
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXAfckhMZX5FPBpzJH3trrjSpdwktmQzBeAcL+wEFYc=;
        b=WX+vQPGjSyj4gxP/mZ4cqSV1umEyUJOKqGN0OY5l1WqvdRjsFg4oieFD/DCDWSGfsK
         RbQzHbzMlzdv0BMslWJe9oJx+ex96QCYAnOvFrEusSBgy96zBaWMJt7n6FZQPWozpWQF
         SVhT8JtaGteznO39QmqucBOuyMXy+YAEwswWgtyPaPp92EdIH+mY6divTNS7Y25+TQVa
         Cg0GxdZb2mj4rUpG3v8//FVyRFddbaP9M+8SiaVSPpvuz980ieHWJP+Sgss5sLKPOILD
         ibJ53xmIpyV7BlxQZ4RlE9RFuIj3U14hGLncmGzKsnPiykMEg4pYW62tIJ259rqL1k+7
         g2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXAfckhMZX5FPBpzJH3trrjSpdwktmQzBeAcL+wEFYc=;
        b=sUOsZnze6Ll/B3pw19MbF9JUyBJ3zAqSGsYgasdXsdpM8tsp5xaC9tqAodI78aFzPX
         fRkYLWK6Uaggt+1MAt/LxxQPx0h/1tr7s1VAp9Vb/XPds+50uLp2pWZcCjj3eEPx78F+
         /D5G+AaJ/B4A4fcjBdMzerPIED9WHk7C3Oi+q38kjP9+YLhyVJ4cKJ73dSgK0AilG3Sf
         SyS7DyeblkIt8cx8guqaaRR+XeKudAe3TNF+SHW2xF7Py1d4w4MKeTX0M/8yYPkeM02A
         LA4qSofNq7kZRM0Y14yIREHg7mX3IkkjprWpz3zIq3JXM1z84kTtnuQksnetwdSJwHBT
         M/fQ==
X-Gm-Message-State: ANoB5pnAWwChkQ3kLoHHf9ZfYyqHNYkG78rQT1xXrGhN06utUn1t6RsX
        rlHrYuBaOC2+ZLteAIoBexysiAJqYcE=
X-Google-Smtp-Source: AA0mqf5TbtBxeEVUK/ze51sDCNJZhXbcXSGpWDOMlJwfrIESldpC/pROGiy9eGeTfGDOYtKyjON5mg==
X-Received: by 2002:a17:906:6057:b0:7a0:b505:cae5 with SMTP id p23-20020a170906605700b007a0b505cae5mr11524657ejj.648.1668456649535;
        Mon, 14 Nov 2022 12:10:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/6] libsepol/tests: rename bool indentifiers
Date:   Mon, 14 Nov 2022 21:10:39 +0100
Message-Id: <20221114201042.17773-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114201042.17773-1-cgzones@googlemail.com>
References: <20221114201042.17773-1-cgzones@googlemail.com>
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
2.38.1

