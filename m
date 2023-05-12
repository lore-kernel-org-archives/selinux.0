Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FDC77B7C
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjELJXY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjELJXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:23:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7B106D3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so6824171a12.0
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883399; x=1686475399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bv6sLPbYptRsTVEg6bG72SrsVKBv8YWDQDS+Ak2hso=;
        b=JCKcQVeP/MSnn54eZ5c7933wEtGqxaWpnyQ0mzIFqXrz0cE7/Dnj0TNvIAzYOLaTNG
         bUEuEW8hQs5YM0fZRB0Pur52uj2a67//1AuEkjMLmaIiuedLwO66TPhz3ty0EcstNZnb
         CjMQj/tXdp21CrCafxHitz64axoXfqrPQAR9O1DNco0ZDjWLm9SfxLeTimeaMMPWA/9q
         7RbnbSiAgzqZrj6brxm0wAVXASqRF0Eu9yxFrRgI2p26NjCD9MkB2Sw1gOb/TXPhdM4a
         WcdgeSjbsDLmKWnGIBs8s9tFsUjfofKIMJKr2vzfGjdMdpYt8jL4s7/IWhTk8mvJ6kPc
         ug4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883399; x=1686475399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bv6sLPbYptRsTVEg6bG72SrsVKBv8YWDQDS+Ak2hso=;
        b=UfuXbUV7dSSM9VBdG0N2HVgXfOuKMi7plPbkNvQC9/P/laeFruAvdFm1YRpqVKFCo/
         Lpba5XAUXWaZmNyyHMBCpmdn7G52RNPrKhBuoZ0PgelTTTF0cKzTyq0pKKqOo9JKmjuZ
         aQYdkAIuOBatkpXQcb8Koj2zvioMfw6bze2Yx6kTxt1qCGROnyinvRMA2c22CN2wuIV2
         0gBq95nnKdTY2zGwjPeIUI7q1k0RWW7hN4NWYq1PZF5DnRv/jjAu3m5sZRzJFXjd9B8G
         Luwoil95vi1Q92sgZUJadSI65zt2Cun/2fU29kXVB3ubHA8n1jU98wIjrhu1D1Zj0qMB
         LUpw==
X-Gm-Message-State: AC+VfDxd+lR2SdDYd1BV0y6rs5FzX7Zye/3kQU/MbtCw1V0QfLYK+6bg
        S1irQQgDJFxSs3nP56KIs12+Zr1AndGDhA==
X-Google-Smtp-Source: ACHHUZ6KvRtb5VBqFQamo6jN9dQ/uTPfArFROwk2ReQMyzKcrIVjj9uZG3sGoZDh6+733anNv9vB7w==
X-Received: by 2002:a17:906:da88:b0:93a:353d:e38b with SMTP id xh8-20020a170906da8800b0093a353de38bmr22887390ejb.37.1683883398984;
        Fri, 12 May 2023 02:23:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id de25-20020a1709069bd900b0096664376ec9sm5186040ejc.55.2023.05.12.02.23.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:23:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] checkpolicy: reject condition with bool and tunable in expression
Date:   Fri, 12 May 2023 11:23:09 +0200
Message-Id: <20230512092311.42583-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512092311.42583-1-cgzones@googlemail.com>
References: <20230512092311.42583-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If tunables are not preserved (the mode unconditionally used by
checkpolicy) an expression must not consist of booleans and tunables,
since such expressions are not supported during expansion (see expand.c:
discard_tunables()).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d4e376ad..95cd5c85 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3964,8 +3964,9 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 {
 	cond_expr_t *e;
-	int depth;
+	int depth, booleans, tunables;
 	cond_node_t cn, *cn_old;
+	const cond_bool_datum_t *bool_var;
 
 	/* expression cannot be NULL */
 	if (!expr) {
@@ -3990,6 +3991,8 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 
 	/* verify expression */
 	depth = -1;
+	booleans = 0;
+	tunables = 0;
 	for (e = expr; e; e = e->next) {
 		switch (e->expr_type) {
 		case COND_NOT:
@@ -4018,6 +4021,14 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 				return -1;
 			}
 			depth++;
+
+			bool_var = policydbp->bool_val_to_struct[e->boolean - 1];
+			if (bool_var->flags & COND_BOOL_FLAGS_TUNABLE) {
+				tunables = 1;
+			} else {
+				booleans = 1;
+			}
+
 			break;
 		default:
 			yyerror("illegal conditional expression");
@@ -4028,6 +4039,10 @@ int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
 		yyerror("illegal conditional expression");
 		return -1;
 	}
+	if (booleans && tunables) {
+		yyerror("illegal conditional expression; Contains boolean and tunable");
+		return -1;
+	}
 
 	/*  use tmp conditional node to partially build new node */
 	memset(&cn, 0, sizeof(cn));
-- 
2.40.1

