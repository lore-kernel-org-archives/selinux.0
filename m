Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCB7C43334
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiGMOL5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGMOL4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 10:11:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC4326FB
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t1so4340083ejd.12
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jtpsEukWOarPt296N7+qifAxvTIycvYQfJwreC7OguE=;
        b=qvE/fCC9/hkBc4rxvsBWPGy5Gt9loiTHce9hps/M6ehR6zFa68ih4bRJcdf/OxeBS4
         3CoGRlbVtF5P6o/zvf8UUXXSrKMoiNI0490tfc0sFFZMPxnl3Zvod7sOFX0+KVWJeyrE
         wzAvzk/zSEn85axHr7HwL5j6V2LGhVhQyUjgodUYO9vYoNk/KF1Rq1y5ubJ4QlNVbh69
         U9X+j9yYoj2CZneqAL+pG5OG8Mq2yU1bkcQBHADveSUK28fhwywEwrs4FFxBaRddCwHz
         koK4GrqGP2hIWxwfF/NDVU9Ccd1lfKLQi8HclgpZ9VKl6gox/SKPPvJegqemua2HhJAm
         GZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtpsEukWOarPt296N7+qifAxvTIycvYQfJwreC7OguE=;
        b=BKXb8iqro4VTlD0I/W6asjOTkb/FddOPkHV/8+vbw6X37td13y3o6ye5+jbAdoTtvh
         pQFbZYhUcMCb6FpwUciMaFHJXA3uqkSEA8zUZyhN9g32nP/OWjGWzemF05fAgqmW9668
         WSgmSTQUhPFGzcpOCI8JcTKS9hKwsFSafsGNpu45IG4T6C3c35EaL5NAJZIoAJ+LBF/T
         y3cS/fx1RFALvpHHDiR3CD3DbSgAE+X+CiCRLvOquCcnx2wofouz65yL5QrjmgdBlYy8
         MSh33Urd9lTtPw2HivJZgWdA4/1iA6J/kSrK1iWlvqn+Abgo0oXciptDTeqGgzkTdrTg
         /gIA==
X-Gm-Message-State: AJIora8sgADqjqpIjdPtvjbXZG3248xweyUGQrcOZKyoKeREx1PeDt4t
        PpOQU1GZsvgGuqR7CTOEA4apHKCSvGKXGA==
X-Google-Smtp-Source: AGRyM1tQsVQc5EaGAggIhPlcigdNw+KYr6qgE3Un0zD8Smj9vKn46QurwFWM/OLmSjFL/roJQF55YA==
X-Received: by 2002:a17:907:762a:b0:72b:394b:ebcc with SMTP id jy10-20020a170907762a00b0072b394bebccmr3748188ejc.622.1657721514187;
        Wed, 13 Jul 2022 07:11:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b0043589eba83bsm8010570edq.58.2022.07.13.07.11.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:11:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libsepol: rename parameter name
Date:   Wed, 13 Jul 2022 16:11:47 +0200
Message-Id: <20220713141148.35524-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713141148.35524-1-cgzones@googlemail.com>
References: <20220713141148.35524-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not use `bool` as a parameter name, for future C version support.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index a567c411..0f399771 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -862,7 +862,7 @@ bad:
 	return -1;
 }
 
-static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_ids[], unsigned int nbools, const validate_t *bool)
+static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_ids[], unsigned int nbools, const validate_t *boolean)
 {
 	unsigned int i;
 
@@ -870,7 +870,7 @@ static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_id
 		goto bad;
 
 	for (i=0; i < nbools; i++) {
-		if (validate_value(bool_ids[i], bool))
+		if (validate_value(bool_ids[i], boolean))
 			goto bad;
 	}
 
@@ -881,14 +881,14 @@ bad:
 	return -1;
 }
 
-static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *expr, const validate_t *bool)
+static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *expr, const validate_t *boolean)
 {
 	int depth = -1;
 
 	for (; expr; expr = expr->next) {
 		switch(expr->expr_type) {
 		case COND_BOOL:
-			if (validate_value(expr->bool, bool))
+			if (validate_value(expr->bool, boolean))
 				goto bad;
 			if (depth == (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
-- 
2.36.1

