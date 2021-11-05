Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7CC4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E761108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhKEPs5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhKEPsw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B5C061210
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f4so34278448edx.12
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BHirlJ7ZYpgqmnYlUvmQC8IZnbu0+RHCXsyFWEkZ6SQ=;
        b=lxFmC87iQVmK5j7tiAQSvKBkwz32+bPuTVfOD8Gw09n9hhAv1v1mAD8uiTOy9BJyNX
         1fRwUcjtJVzw7ySobnDUpVHlwPcmogx5SkJ4sxCFlVxMn1VgrIVPBbif0xcI4sOh6W4C
         L/KYA6MxZqiW781i5drWFYY/7UkrNX5Ti4dILYCEVO3IHMRkHR+JQv4rJ5wGzOJNxHmK
         U8LXwX2UiUnQDmSBKiQ+P63VSgAnAbFnjeOnPSFiASu+dVuiDKrHOb++WtCpIJV90X+9
         vZZx8maoi22h5bghiHmSmHhW65bE7vP/vYvDXLYuBHFXIy+2pLqlRNG1BL1gMynZSPTs
         bySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHirlJ7ZYpgqmnYlUvmQC8IZnbu0+RHCXsyFWEkZ6SQ=;
        b=ZcywcDFScqGl5an/ckC36fnbyIYvhIZw/T6Rgo2u9amfnu+H7x4HQQFa/lBlvxvNtG
         AyMvcwlXB4//Jo1pF/fYwt+q9XLnrydnlJl2Tj7+U9e4jJdH6aTwH1ynQ3jIXcdSpwHu
         fNmJ+SZZUMWD5LLRFOdOmSqVzqj89tD82bucqd6ZxO8zZ5u5EKHW8OZtCLGL+3HqMCUZ
         nTd+nOAGve5mqIx/Af7t+1DckqHQ6LJD7GvaqaAi7gEsemTUwdJqqdLq3F1LTd8ABLiY
         hfSOmpOWv6PSAqxybJ4b1EYLrBD/VceYNAyQIrUPkYmO232ExdXh6bw7m+eKqqPdUgxF
         NzDw==
X-Gm-Message-State: AOAM530o+a7/l99xL8LPBQWHZZTAF67IDK+4pei3VmCa2qQl1RWBr67V
        F+JnwaymIurf87H4DoKtMQHZFTVsylw=
X-Google-Smtp-Source: ABdhPJydzCeOGInrAmCpVglduEqapZz1gmpn18s71g/XV9qgQVFYYF0VYT5NEAhisxzo1ECdD5Lu3w==
X-Received: by 2002:a17:907:6287:: with SMTP id nd7mr20986677ejc.152.1636127169999;
        Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 39/40] [CROSS-PATCH] libsepol: avoid passing NULL pointer to memcpy
Date:   Fri,  5 Nov 2021 16:45:41 +0100
Message-Id: <20211105154542.38434-40-cgzones@googlemail.com>
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

memcpy(3) might be annotated with the function attribute nonnull and
UBSan then complains:

    module.c:296:3: runtime error: null pointer passed as argument 2, which is declared to never be null
        #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/module.c:296
        #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:337
        #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule_link.c:145
        #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
        #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32a9)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 4a51f25c..549634b8 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -293,9 +293,11 @@ static int link_netfilter_contexts(sepol_module_package_t * base,
 	}
 	base->netfilter_contexts = base_context;
 	for (i = 0; i < num_modules; i++) {
-		memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
-		       modules[i]->netfilter_contexts,
-		       modules[i]->netfilter_contexts_len);
+		if (modules[i]->netfilter_contexts_len > 0) {
+			memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
+		           modules[i]->netfilter_contexts,
+		           modules[i]->netfilter_contexts_len);
+		}
 		base->netfilter_contexts_len +=
 		    modules[i]->netfilter_contexts_len;
 	}
-- 
2.33.1

