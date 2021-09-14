Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F3C4321E
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2FD60F70
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhINMwH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhINMwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D46C061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n27so28658935eja.5
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BQasiyHoRS2fp1DDItVAAVd0KVYaxsvAdkxxZMUyp2Y=;
        b=WQXnekqNmBFbbd5i1t7p71+bi4tJOsbnWJBJELoJWKXmWCFKov59E04yUTNVGnPHsE
         ePQAKq3eNmkpo7NhLHC1eHB50H45se7PzLBphLDRi/AzcNxRNppS0pdspM/xb5Ant/4r
         nY06fpXpt9iOKJPWbPOtLIZ14EgIgGbDE9j83bXITUSXG+S9QnqYvER3TADrisKjISbH
         jIyZCHfmURj0pAzXSajEZJ1tM4TFtriI2OchBRAyoqJWY3pCzjVVyYimtUyyvroNK/kH
         n2aesAMSn1sh5FmQO008XB3HfF6ujjVEKJdi7FfhUXguRaQrClrdc7NXw5FAc4JbYB7e
         n36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQasiyHoRS2fp1DDItVAAVd0KVYaxsvAdkxxZMUyp2Y=;
        b=ZM/3CX3Kamltp2V6qCdxSxtH9g6Ru0ioMRlzJTW/EfXkYMT3hT9glRWN6BCnLXRNO2
         POqOIDoYSvFmvUPCZnarBufWJ0MI8jZSuUhAwF6nXryMaXf3T4QMel5fHCiEncI9SHSy
         86sFPBDqdelik8eaC0urWDMqeJCGZSIgNjO57DTD57q8mplB6QT2KKbLiONSKCee6Lc/
         782l9sUFyh8OJWa1hjPQ5nEax9uIS1lALGAure/rNhVg2kkZee8rtO2I2j5sGuDTWYce
         FMVX+nwjR++H9qJPGnH3moLnscIdTtM46rbyHAcz3xo0/74pR/9OVDTIYiQL0Z9gKE9B
         Mu1w==
X-Gm-Message-State: AOAM530/EcliWa4u8WjOVN0SZT25S5REey/9n5PKKDQgi3ixmZrLzBMJ
        bcDI8tgSk3JrEC+GPghizjRYJp1jrKE=
X-Google-Smtp-Source: ABdhPJwsFpsiTAb1f85mNRHkxFcJa8SuhA7oEBT1+y8+/v3QvGqx7SkHxtZH1xR2aYFou0wpXCiMgA==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr18832593eju.254.1631623848163;
        Tue, 14 Sep 2021 05:50:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/13] checkpolicy: avoid implicit conversion
Date:   Tue, 14 Sep 2021 14:48:25 +0200
Message-Id: <20210914124828.19488-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid implicit conversions from signed to unsigned values, found by
UB sanitizers, by using unsigned values in the first place.

    dismod.c:92:42: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dismod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 9550b999..792deb3a 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -89,7 +89,7 @@ static void render_access_bitmap(ebitmap_t * map, uint32_t class,
 	fprintf(fp, "{");
 	for (i = ebitmap_startbit(map); i < ebitmap_length(map); i++) {
 		if (ebitmap_get_bit(map, i)) {
-			perm = sepol_av_to_string(p, class, 1 << i);
+			perm = sepol_av_to_string(p, class, UINT32_C(1) << i);
 			if (perm)
 				fprintf(fp, " %s", perm);
 		}
-- 
2.33.0

