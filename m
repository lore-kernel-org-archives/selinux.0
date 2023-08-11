Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C962AC001DE
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHKQ1x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKQ1v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99C18F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf1f632b8so307899966b.1
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctTkIdOjUgd2oh0NelDXrU+PaUXy4eDCWNhDrSSQWFo=;
        b=ChFwvg197R2NO/TBPDNYBn5V+LdiQNRI7O1ZVnmsPFBQCIiQNY/2eO6rPfomcuBQPE
         UCmJ7ajOspq1diTBb/dDAw8kbflRLEJLKgx3oDsp8Bw4FwuYoiftQoIT6DzSezmZubSG
         OW8IM1nLa4SVXIQvsuMxnIBAVB74VsbgH9MELqhj+ZWqwbvD/AOud1I3hcyAsZ3wJJtF
         /4oPw4wPQVUK0cQWlGeMQ/c4RgX6MCGkYK3qb+VJBcuRty6dUkiqahXfJYpr7dfTjla2
         J8tocuQV7pJLfxHw9lhFGxKM0rBkuOi5vD5EdjSYGGZabbycFrF02UvxgXXpk3uKirYN
         8QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctTkIdOjUgd2oh0NelDXrU+PaUXy4eDCWNhDrSSQWFo=;
        b=OCTDirlcTKXVF3HGOM0YMm8djJoIFmvNBrgvbNv4d+R3em80qDcZqN3Y76N+VzTWaE
         lxZryoUjX52x22YB7p4XlwfP8Ojuh+o+5aAfD2gdY2A/wamZhYRlkpR5QtWwXhVnvQc4
         zwSKHueuc1gNPvqHd6Xkk5jhSZUka05AB3TRXdrvGym0TST2bng4o68OKwRM48qFX5h3
         pywcjw904Me+FAZ4G0fu45aoAkej4MNlGbptyEuKI5HRRt8mPkKcjRdWz6vvgRbK+nz2
         uWaYN887zWUQG8zS9kw6T5Fj+4oS12Ay1+ZKc21a039Jf7mVZ4HdTPQoxNd/rRMOg2FC
         p+UA==
X-Gm-Message-State: AOJu0Yxu/ZM72mMxjHY89TXuI5TlhD0S3aI0r49od4tqutKq0C+V6oX7
        4+RxBRiXZugKuORMfGEmtIS1YkEccpYWbg==
X-Google-Smtp-Source: AGHT+IH928PhlGdGdgcFuqLVUHjCcy5xTrU4nP8OXuoSfYZ/JOQDUMK1iQRtOPoZRCTi1dyeY0gvqQ==
X-Received: by 2002:a17:906:3ca9:b0:99c:6312:73ca with SMTP id b9-20020a1709063ca900b0099c631273camr2103542ejh.71.1691771269560;
        Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 03/24] libselinux: drop obsolete optimization flag
Date:   Fri, 11 Aug 2023 18:27:10 +0200
Message-Id: <20230811162731.50697-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The flag -fipa-pure-const is enabled by default in GCC at -O0 and above.

The flag is not supported by Clang, which might result in issues if a
compilation database was created via GCC.
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index f9a1e5f5..b1620113 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -61,7 +61,7 @@ SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 MAX_STACK_SIZE=32768
 
 ifeq ($(COMPILER), gcc)
-EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
+EXTRA_CFLAGS = -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-- 
2.40.1

