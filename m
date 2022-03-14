Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373CDC433F5
	for <selinux@archiver.kernel.org>; Mon, 14 Mar 2022 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiCNSZa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiCNSZ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Mar 2022 14:25:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1933B563
        for <selinux@vger.kernel.org>; Mon, 14 Mar 2022 11:24:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id r127so13490098qke.13
        for <selinux@vger.kernel.org>; Mon, 14 Mar 2022 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9RWOKlowOSiD7ja6Ri7UMxTs78BC61H5Hn8x8uDtp0=;
        b=Bn7uKhJF6Ht6TqXvmSW6JCIdhenwYgJUeNhAAeUhGSwLbtCT+yn1JIdPhGc+AHB90T
         fYw0HXajQHHTww2AuiZjG6ADgm1uEzBFKxinROfmqX8p0EcxJUmVD9vOBz27jcUAcM+x
         ygr7x4LXf/bay1X45OW+coL6LXmTsqo2gfiwqj21hfRUw/WpnXeqXhhWklmRPF3/U/lx
         tY2io9gYlFUMZ4InMPDFVoIkyaGeEf8iZWyPXFfzQF3OT4IliO8uSrT0k0xOeaSeoIDc
         H6i1Kz90LredpWXMwOnFkW3dGBmLnZNYUB6ODXbTjkgjE7oofu02t3XAvszdOSQYkVV+
         RIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9RWOKlowOSiD7ja6Ri7UMxTs78BC61H5Hn8x8uDtp0=;
        b=LlRld9tDhd+pQO/7Jv2tJNYDhxGK3WURlR+2CT7pi3qCk07XUQhFHiL9WbTAjJZXXR
         EA0ndS1/XnjGEEDTIlrhwbydfCF2K6wQHeIj8dAvY+nMnLiCt6yt8UMZY0LJfHC99Hl0
         GROSOIvNtwxlMtP0I6NbJmZr9oTnM8ANTshZ1HKelNg+RTwUmJliWgC2o+pphcJEffZ2
         FtVe7ivtbt90OrOHuvwAa03MCKt/aoqR149oHTaiqDMUviOmIv4LtkUPoojoGDoW+Q6Q
         PlHQEnEISGuBewRchqfxNRBRyd8tHpWQ56SO63oU5suKubGHFY4eZisoxH0xfxRjlEcf
         v3sA==
X-Gm-Message-State: AOAM532z23M3r5NgmYrUM5HI8hgfWv84xcL/bjYxTfJhe6JFMVSprVG3
        2fWHfC7S2nyx3+hgYuU7ePhVr+UGALU=
X-Google-Smtp-Source: ABdhPJyj/RP5IMU2NxiNIGP90znJVGiZIfIvr+G/l6E3xAGMlIBMczZAX0hogZc3r8YkPMTL3MBk4Q==
X-Received: by 2002:a05:620a:5e:b0:67d:323c:a1fc with SMTP id t30-20020a05620a005e00b0067d323ca1fcmr15574213qkt.675.1647282256460;
        Mon, 14 Mar 2022 11:24:16 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id a10-20020a05622a02ca00b002e1ce9c91d1sm3002810qtx.23.2022.03.14.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:24:16 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
Date:   Mon, 14 Mar 2022 14:24:00 -0400
Message-Id: <20220314182400.121510-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use calloc() instead of mallocarray() so that everything is
initialized to zero to prevent the use of unitialized memory when
validating malformed binary policies.

Found by oss-fuzz (#45493)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/conditional.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index f78b38a2..a620451d 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
 	if (p->bool_val_to_struct)
 		free(p->bool_val_to_struct);
 	p->bool_val_to_struct = (cond_bool_datum_t **)
-	    mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
+	    calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
 	if (!p->bool_val_to_struct)
 		return -1;
 	return 0;
-- 
2.34.1

