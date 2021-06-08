Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BFC4743D
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7824660FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhFHQCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:30 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33517 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbhFHQC2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:28 -0400
Received: by mail-ed1-f53.google.com with SMTP id f5so20105769eds.0
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hNFqoMTSBb2YEQ/JMOq6ZaerAAisBzB47j3A/Xya/Nw=;
        b=JfZd4LhBCqb/hWyB72Eq0YKrinGRJifxM/hIDh7Cxh5gHQb2EbaLvMoKndgdZVebX2
         R3N1dw62mYuie1zwifNgwoHTP01UeHi/9fuM2PHxmmoZ0D+growvJbhHH3wA6zpdq76V
         kGCnB8dCHAfC2cJTg62f/lnA9ZZLQ5XzsZNhRrJW24HjcPOu1GC6kEe0HyC8s+zDRrp1
         ChQml2ZuI/0lI2z7TGwe+NlaUi3rnk0RQuEiz1HlfaZHpoKWU4P1H2Jakf33JsZkrI4O
         XRO0Ztd+dsHg8zp51au2H8OF+1Z2+9RceNcNUlKnAaq27NQwiPCfY0Oo2ZUXDcVUs0EY
         oQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNFqoMTSBb2YEQ/JMOq6ZaerAAisBzB47j3A/Xya/Nw=;
        b=SYGXrsdIZI8QGT9kamyzmgKhyMa9iAIPmnof7vdZB4QbPazQWK+0bpsIk7uPURGyqb
         g+EgUnC5Ap0/hoyQm3bobkQIv1hdS1olyRuu9FRgAq36CKd8sEYLsKFxwADAbzI/3lgw
         eDqaeucM+uKuz0BKzAfpSEhDHVBhKww7TdNw2OH0PRGbTwMQLJBhQwIVo464T/jbofwk
         GpLSpS7Q4jOutcO99U/6rdSK0nu+9K4ZUoT9TpJKlMHw/pwr8crWsA4b8taDLySeKOVy
         EDyqltYHJ7pfYnRyIqx3XUsYFqCH/RrYiIzKllClnsOCkKsSDik/gsDw8JCWXB5aBS9F
         HqJQ==
X-Gm-Message-State: AOAM533fYEFI1//pBM/06JWYEZDQJQJsyLtiRL9pV38adVsJjYM3Sd0t
        sxSKRRxGF3x4Zn7QlHXTwyly9ccmSFI=
X-Google-Smtp-Source: ABdhPJxwzzV7M7rzWu1x3bEDaXQL4rl7ezfJOYKtJAScuycx7ViUIq0UAKgZg6p7UooQBWcvmeWr4g==
X-Received: by 2002:a05:6402:1ac9:: with SMTP id ba9mr26459682edb.250.1623167962603;
        Tue, 08 Jun 2021 08:59:22 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/23] libsepol: avoid unsigned integer overflow
Date:   Tue,  8 Jun 2021 17:58:55 +0200
Message-Id: <20210608155912.32047-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unsigned integer overflow is well-defined and not undefined behavior.
But it is still useful to enable undefined behavior sanitizer checks on
unsigned arithmetic to detect possible issues on counters or variables
with similar purpose.

Use a spaceship operator like comparison instead of subtraction.

Modern compilers will generate a single comparison instruction instead
of actually perform the subtraction.

policydb.c:826:17: runtime error: unsigned integer overflow: 24 - 1699 cannot be represented in type 'unsigned int'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index cbe0c432..3389a943 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -823,11 +823,11 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
 	const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
 	int v;
 
-	v = ft1->ttype - ft2->ttype;
+	v = (ft1->ttype > ft2->ttype) - (ft1->ttype < ft2->ttype);
 	if (v)
 		return v;
 
-	v = ft1->tclass - ft2->tclass;
+	v = (ft1->tclass > ft2->tclass) - (ft1->tclass < ft2->tclass);
 	if (v)
 		return v;
 
-- 
2.32.0

