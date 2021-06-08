Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C1C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BEB60FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhFHQB2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFHQB0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E6C0617A8
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b11so25137412edy.4
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+MrgmO26Q2rR1FpHG+RRPK4CImGFKiyb1+bEKe3ioy4=;
        b=TZXEnQ6dsDnjn28880yMRH8PxybumNGiIG0kY2LpE9bSPegenNK/qkEgHJWepUv2U0
         nSjDu/zG40rsSQ0c+7M4lKXVEidTAqQzPl/A81rVbRdH28MuXV99Kg1lkAvc2NO+7ydq
         p20bbC3p8U79bevoI3kOEdUKVb/fHe2zC3nuPbkYuFtlwtv0uyTkQvpS/tIcU+vJjSeB
         ywzmITqDaSRrNyg5JyTsLQVWlVuCU2JPXk88vupguSby8X/AImH4hkruCBnh+ut5PnfJ
         70XJrMNO55hpX4u7mlimuqbwKAW10f/ko4a6JRrraCo+/LDjhw9ubNrzc28UZ92sEiJG
         LoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MrgmO26Q2rR1FpHG+RRPK4CImGFKiyb1+bEKe3ioy4=;
        b=qqrKgZjAMSAD2GJs4kGLDLXmcGDzVpaIMViSr+JjoxecNzZWJNHB7XFWM35IFNIKlo
         YjJbgllVsQtw/8BRjVAyoX4s4l6Jc0sMIowRGnJ6IhWn5TpFrw0SK8ZXUKeo1HeZS4hH
         28zh9TlFnG/CvXYVr9c6ZBrjZzaUTf6TLia5WKzoUE62jRJ27ycAAtQKL+79Q2EnjmLZ
         K+C5ZyeS4P7uRSSlxZpj1Hbnj4f+/AAd1OzaDgy4aC0kqoBqRxGTSbycFl0kis6UJPZl
         xGsXtgMVG3GMs+w3BHEg3Ud0ikxDxHbfYpQrlPE/0B+EzMYJwGx7RqHyywpO3lDE8C3Q
         Mthw==
X-Gm-Message-State: AOAM531x6fPN1Mi6Gr2eRCiJpSpoH+0nDazvVni6KA5/NMC8EPNM6ewb
        s5KprJnaf9aMatKDd3jNinPucWhGq60=
X-Google-Smtp-Source: ABdhPJxAs9NnF89Cnq/KMNKeiU/vfdEt2inf1vOOs+J3XG2/3k6H2NJ5A+6+Hpm6y3hMob2WvOgPEA==
X-Received: by 2002:a05:6402:1648:: with SMTP id s8mr26625218edx.256.1623167970457;
        Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 20/23] libsepol: drop repeated semicolons
Date:   Tue,  8 Jun 2021 17:59:09 +0200
Message-Id: <20210608155912.32047-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c | 2 +-
 libsepol/src/module.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 17b5ebf0..238a2483 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1050,7 +1050,7 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 	p = catsbuf;
 
 	*p++ = '(';
-	remaining--;;
+	remaining--;
 
 	range = 0;
 	ebitmap_for_each_positive_bit(cats, node, i) {
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 836da308..9b53bc47 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -82,7 +82,7 @@ static int policy_file_length(struct policy_file *fp, size_t *out)
 		break;
 	case PF_USE_MEMORY:
 		*out = fp->size;
-		break;;
+		break;
 	default:
 		*out = 0;
 		break;
-- 
2.32.0

