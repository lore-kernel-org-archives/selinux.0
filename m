Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A73BC7EE25
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbjELJaO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjELJaN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:30:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF4EA
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1739015066b.0
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883810; x=1686475810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7fAFrJi6g0l5X8kikH/00TL4391NKpMBCM8Yjjpch8=;
        b=Swmtq8+tmMkflCgpxeZ0cQYuoTQjV4RLKlEZ9+SMCV2XBxRLY/myoL7jb8De9au6BF
         Qel3y9NFGuG4EV7ky9MVrcHcqURClPPti62SBOTHq3T6Eite2TBbOFYcMGcF9N6/9eR0
         /vVri3dZ9x72KGSVgyRO4My33b9y8+Wlo/WZNdUhVa9Nrwtux/fygDWc6CVRyQuppGua
         0UN/MwTqLExYKvB4biWpupAZ1BGLU6/sbXxnBGsCXOCn8mLmUhHopCuaAmL/pfpJZN6x
         LpV8ldXzU/KswHZhXokwJniAPGquTLrOibErk4JH9LPV2KD+3mmETtGjwgNmmKd3xNRD
         yIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883810; x=1686475810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7fAFrJi6g0l5X8kikH/00TL4391NKpMBCM8Yjjpch8=;
        b=Ja+/f7zkciFRit1VCsGvU4V+i7tiw/aiSg99IiLDcGOzkFtW6mkbkz+u5aLcU90cK4
         kUfByfHOIGqUYCABnAxjlFBvsAxXW/2i3bQBkdev2wO6yMTC93qd5XV3IFNvOb6TWOWP
         XeIdn/g0S+z07IPKFgtDP6L+ThPaRgjks4tLMqTazwQVc3yTZkiEtM7CarlC1uSF+5Oy
         mfpkRWafoSRxnWOOD3MNeewzXYRiOagLkISOHRMV0s/0wzymPVjfZl3Xaa8iGR232T8t
         aqGrIIh7e+dePQAo0sFssXp25heBLrDTVoMXOt2wIM/J904G4hitXfiN6Qt62ZlOjYt1
         Ye5A==
X-Gm-Message-State: AC+VfDz6PUuH32EDbkiU7TGBSyc27+RvXtRlfrDNvdHEaOvchQK3I0p/
        zHY7jUmN8o57ZgFLfIKommclRZra2aw5ew==
X-Google-Smtp-Source: ACHHUZ72tJg1cHxaR7Vp0rtlViW/swx/SKEq7YLBa+gY9k2dMpUz1Q/WZ5NnSb+yogAzx6qjT6u0vg==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr24514180ejy.15.1683883810168;
        Fri, 12 May 2023 02:30:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm4636356ejc.114.2023.05.12.02.30.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:30:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] libsepol: expand: skip invalid cat
Date:   Fri, 12 May 2023 11:30:01 +0200
Message-Id: <20230512093001.49208-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512093001.49208-1-cgzones@googlemail.com>
References: <20230512093001.49208-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Bail out on expanding levels with invalid low category.

UBSAN report:

    expand.c:952:21: runtime error: unsigned integer overflow: 0 - 1 cannot be represented in type 'uint32_t' (aka 'unsigned int')

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index c08d3a35..8795229a 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -943,7 +943,7 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 		return -1;
 	}
 	for (cat = sl->cat; cat; cat = cat->next) {
-		if (cat->low > cat->high) {
+		if (!cat->low || cat->low > cat->high) {
 			ERR(h, "Category range is not valid %s.%s",
 			    p->p_cat_val_to_name[cat->low - 1],
 			    p->p_cat_val_to_name[cat->high - 1]);
-- 
2.40.1

