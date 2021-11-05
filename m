Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C111AC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF5161108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhKEPsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhKEPsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB4DC061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o8so34462408edc.3
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pRwjPS0nNNxXSbcL7RPcb7125smJmsfdlpMvx6bncV4=;
        b=LJdk5G+Szvr5J54lCgE2xZS/MeZNUWm8Bd15dzE80yywQp4GlnyqiOx/eTDQUmIUpy
         VssyXlxUH+43F6AxVFMsQaEZokPY+/hAXwi33Qh1yBT1giFhvOIg4f2nvyBqGz01q/9C
         6fOdvZKRbn+h2zdb+1KSSqnvia6Aa/Vy/u0wz3oETbCUm44+SLzMqQRFBMbXiO+ReLKJ
         opaeoK0hUIBcBRGSdPFuNSFfrZQHgst1Yg9A+CozVJcIVdPsw5ITKiVG8mpVnRJdsjCr
         L0gqEuCS10yEQ4vTm605qcmog5rYyeDzJZyEBu55AsH6y/8ILiKbpvMF7bBrVMz2Nt+s
         2gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRwjPS0nNNxXSbcL7RPcb7125smJmsfdlpMvx6bncV4=;
        b=0j30VtxZwShLdNLEutPn2MU/VVp7xtz9ZW2hqWML96T60a5Ca6lPG2uC8buHEdlr0K
         qUFK2JkGTLOiKoHC0AMiiGqSFY4xmu153u2OE7Ln8GI1h/zQ5JzHRO+XR1tH3X4jWG78
         cE6BlWpsSSyXVZ9AKxAzZMMC2LoBhgYIbbsGAUNX8aNTd+WohK4+dNcUTltK3M3IWBox
         t3VDJ9LRH/Wop1T2lpI5lAwQLQtTICZRf7t014WIZu2bC1eBbapBPpl3J1lIF1MakOql
         8H612LKMS/XQcuG1U1FtZ0fDgm8scoSNZn6gmEGs0IkYanvRZWkFeym6PfMI3Smd19eR
         I7Lg==
X-Gm-Message-State: AOAM530ZxaQGcHdmxswsoyTSQbaFCOl/rVu7iWUoHCKIkI3N60s9zXew
        WU8NLhalfxlPI2b3hUp6sV87Ivk3Nwk=
X-Google-Smtp-Source: ABdhPJyB/p/2ndoKnrxd2N7M4gfRsarjoUswAKjhq/C6PqGoItXrUVgm2Q1nHjD5pArlmoi8k7UH+g==
X-Received: by 2002:a05:6402:2753:: with SMTP id z19mr48638755edd.143.1636127157673;
        Fri, 05 Nov 2021 08:45:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 20/36] libsepol: use correct size for initial string list
Date:   Fri,  5 Nov 2021 16:45:22 +0100
Message-Id: <20211105154542.38434-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the number of categories not levels, which might be zero, for the
string list initial size of categories.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 68dd2d32..dcdd4252 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -914,7 +914,7 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 	unsigned i, j, num;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_levels.nprim);
+	rc = strs_init(&strs, pdb->p_cats.nprim);
 	if (rc != 0) {
 		goto exit;
 	}
-- 
2.33.1

