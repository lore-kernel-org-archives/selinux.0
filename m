Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FD4C7EE25
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbjELJXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjELJXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:23:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0156A7A
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96598a7c5e0so1559051266b.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883400; x=1686475400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PunSpvLc/O3lE1N5MSExjNWtTnHWuSutBxFu4fOrRk=;
        b=BGrUQ4PIVorOjGjj1jhbj5fMI8QV7VWzHdJrz9p1TNQk4Vt9RNCHARJu8e3dmASS21
         DS19ezLw1WGtK10WYuoCgOxoJ6YLqW/Uq3Chwz3nXYcy7blHOrEj2p8OtrMTw3daizH1
         ITEPxYmwsTGVCjEcrFEm7EAe35cJ936V45W+F+n/3zIqz9REK3RolT8Ct/qcJEMZ/m0O
         qG721hHUlB8wBSy2JJLq8MB7va5ik/Uu699F65PUDtYWPvadlc+6ZLvdvpxerM10X9zm
         el+BisouO4AM/H0mBTatwzLFoAz2wf0XT+9wAv7kgY7qugrSQGpOkWXsdUYpvmzdriZ2
         GwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883400; x=1686475400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PunSpvLc/O3lE1N5MSExjNWtTnHWuSutBxFu4fOrRk=;
        b=bvajFMF1KII/x6GNHU9sbCWLNH1O1Gh1fB+rAvMGghf3p8+MSBifeqvx0f736xM9fJ
         MgarvGlSkT803Q+qh4n4ojBN0xHPzk6quiW1BjoUgaoJykjN2UAMSNbh2VAzJ3AqlmJC
         478+bGb07/frR1by3oY4od4kyKK2QLVyKMLHY/bR9WEyZ8+VyHc/0/pSRJ2M40dYNgq7
         Lom9Okkx+8/lDkSc1a8qTbwq7wtKnnNLUgA2eVFeDtmUrdCMukpBBKTDb1VT3pVGWTgV
         8JUItvcL2qIpiDndkr9Sll6YdZg0QF4PHZ9sC40oTYnVbshq2HWxzZ2PGkm0DF38kKPF
         Ib+g==
X-Gm-Message-State: AC+VfDyUDRd8SwlyJpoTRFAehv4305uNtnzOtpwiDk/xV/2t4Sv68Jh3
        f+jGp9F5MCWh9/Q8H72+dIRNVjTaWab0gw==
X-Google-Smtp-Source: ACHHUZ44Icu/AJ48ovPRC1DKg3It8mGk8+FF+uTCCTRn01tlHCCSTCPkfwHdosROw0LL/hbO7+XzCw==
X-Received: by 2002:a17:906:ef06:b0:960:d9d:ffb5 with SMTP id f6-20020a170906ef0600b009600d9dffb5mr20572193ejs.41.1683883400264;
        Fri, 12 May 2023 02:23:20 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id de25-20020a1709069bd900b0096664376ec9sm5186040ejc.55.2023.05.12.02.23.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:23:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libsepol: dump non-mls validatetrans rules as such
Date:   Fri, 12 May 2023 11:23:11 +0200
Message-Id: <20230512092311.42583-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512092311.42583-1-cgzones@googlemail.com>
References: <20230512092311.42583-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The functions constraint_expr_to_str() prepare a string representation
for validatetrans and mlsvalidatetrans rules.  To decide what keyword to
use the type of expression is consulted.  Currently the extra target
type (CEXPR_XTARGET) is considered to be an MLS statement while its not,
e.g.:

    validatetrans CLASS1 t3 == ATTR1;

Actually check for MLS expression types only.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 2 +-
 libsepol/src/kernel_to_conf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e9cd89c2..7e279e3f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -172,7 +172,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				goto exit;
 			}
 
-			if (curr->attr >= CEXPR_XTARGET) {
+			if (curr->attr >= CEXPR_L1L2) {
 				*use_mls = 1;
 			}
 
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index c48a7114..4c93cc10 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -169,7 +169,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				goto exit;
 			}
 
-			if (curr->attr >= CEXPR_XTARGET) {
+			if (curr->attr >= CEXPR_L1L2) {
 				*use_mls = 1;
 			}
 
-- 
2.40.1

