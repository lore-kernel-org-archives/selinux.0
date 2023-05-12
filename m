Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D73C77B7C
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjELJaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjELJaM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:30:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB8F7
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1776457266b.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883809; x=1686475809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q9LwskrCelAeYHCmxT4xjuIKOqph/7licKqVLZWj1M=;
        b=It5XRjXaY4wJm1IAU/mDBfmLuj4raHE0mFcrcfb37ZsMj2+rXB9zlFpCj9RJrN6kMN
         kVfOgLkiGcOTwzmHseygvMDgeodLLVAG0iuiAG3rIJBF+jkdhp00CaZ23WOoXf+ARXuu
         fa8jYeWYwxqEWLNprqvZuVsQksN1yRJyuwURr6jTIS5ykBrzQ929rHc5JqiI1Em0KcbU
         vS7rt7TV1h3fc87KR5pQ0zccq5qPlwMgUoUmG1PKW/p4k7K39E2DsfAd2n20H23RnUSk
         xx28uyDmCeJAi+jgmQLokSjZ9i5GmmwlOA5+D4aGR/GvsbPnM7KbswG+TbHFYYTrf4OA
         tzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883809; x=1686475809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q9LwskrCelAeYHCmxT4xjuIKOqph/7licKqVLZWj1M=;
        b=dJD9c7p0t+o1QV9OPu0O02xvkyZ7/fYcvPnqc4ZaKQkSwhHkLQZImlCUludrlpIigL
         9NFE2oskCA/i5tqEMvG3V8tayUEy1E3EaXG9h8zixaEgjyR4BlPPU6YzolSCTsvaNXts
         0xMnL54/pzSqYGI6cNU3Bm8SQ7KSHMINghFjjhfc5PQCjpbd6rVQ75UBBsAMGRqNj7CF
         GWWfOrT/5Tx6F3cuU4H54oKVNI0HWXLKBlogbshtBkq6Xl7wbzr3RTGQty15igEgfjE2
         my3+cpVGGiQbZm5FWpMUzXvoeE+ag4PRT/YHdD2F/Jqz2QQ3lSOwoeU9rE5874xcWgSM
         5DAw==
X-Gm-Message-State: AC+VfDy4wCqvB59MqZQeqWSMosmNrT0x8kSggLP1UpORAo2L2kO7XwMx
        Xk4VfT59+HK402bpj2RRGmiEhm3cTPaPvA==
X-Google-Smtp-Source: ACHHUZ7/G0NzyP7NIO5/KBhkWyDerId3p+3+vMdXOQnTOOZVceNtHjOzD9jl/ppxsUzi3uEbe9pkIw==
X-Received: by 2002:a17:907:368a:b0:94e:13e9:3926 with SMTP id bi10-20020a170907368a00b0094e13e93926mr22055425ejc.19.1683883809294;
        Fri, 12 May 2023 02:30:09 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm4636356ejc.114.2023.05.12.02.30.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:30:08 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libsepol: validate: reject XEN policy with xperm rules
Date:   Fri, 12 May 2023 11:30:00 +0200
Message-Id: <20230512093001.49208-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512093001.49208-1-cgzones@googlemail.com>
References: <20230512093001.49208-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

XEN policies with extended permissions are not supported, e.g. writing
them will fail (see write.c:avrule_write()).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index b34f83ec..3540f34a 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -799,6 +799,8 @@ static int validate_avtab_key(const avtab_key_t *key, int conditional, const pol
 	case AVTAB_XPERMS_ALLOWED:
 	case AVTAB_XPERMS_AUDITALLOW:
 	case AVTAB_XPERMS_DONTAUDIT:
+		if (p->target_platform != SEPOL_TARGET_SELINUX)
+			goto bad;
 		if (conditional)
 			goto bad;
 		break;
@@ -910,6 +912,8 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int
 		}
 
 		if (avrule->specified & AVRULE_XPERMS) {
+			if (p->target_platform != SEPOL_TARGET_SELINUX)
+				goto bad;
 			if (!avrule->xperms)
 				goto bad;
 			switch (avrule->xperms->specified) {
-- 
2.40.1

