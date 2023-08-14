Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82213C07E8B
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHNNVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjHNNUs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF2171F
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso562065666b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019241; x=1692624041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynGKH2GCuzeDJnxtfumT0lqtEUXUxMF2i07Kle13BUo=;
        b=sAnhKbE0TwPGnapDhvTlQLOxzYx5o9v9p5bgWxIDNSUbHbC+s4mPnDskkJJ2lsJlvs
         rA0wHGUa2ArhaCdN7qy2CsPTbeYYSe0Wi7mnPjOKHrxU+EL1JiyKIBPZKqtH/0TGUZME
         /mKd9sKRH6YiVbtJP1/H0/AgenCNFkNqF7KfVD0bXRzlVOsbomyN9KVW/BYRQSS2E8so
         OA/uxEkzWTVSvwq6WTaViWKbwrj4SI4xvl9lvnq1vbTUnCiYN/ZJgBdSK9M5vUauYHLr
         NGn+rsjGns7DayJiek1uTs1U2RX2qWP4meJZe90NZaQeW3Smewd5fmVqB7XIlnP9K7mf
         WPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019241; x=1692624041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynGKH2GCuzeDJnxtfumT0lqtEUXUxMF2i07Kle13BUo=;
        b=ALHtdnXc1dhUTI9nz7Z/nqhSojpYiYn+tGbIyZ8mId/r2DXVIg/ZLGOP/ZPk1FoOhd
         oBsuAq5tYyeQDqIr4MvSwaOVWLT9J5SkusK8pSVX0lo81SUMmybtP/zmd+PLMnMlp2IY
         xBJKIhX0CqUyCWf8nbao5ZSrAFsR+orC4v9f/SmvRFYl2Jt9TqcVD1Cevd+hbiaskP3f
         PkraVP0se5RwpPuxNYaH+O4RCIXNlqGmPwAleyC34+ScLvCXqiACDNG8xHKzXfEIj+6n
         2PL7S2VYn1Zvmx+EfdWVTQhRk4WAbLn1PlYinJNDPuQB+I4cQbUJcx3ZrCLp8d0tu74p
         rCVQ==
X-Gm-Message-State: AOJu0YzOjNbxz4as6A6QgfiF3fNNzPmfP5PscFWCA2QaaKvt7YZznk3q
        1b9VH14DqC/SxYMf/EH+aBdNEHufONBvgpCcSvc=
X-Google-Smtp-Source: AGHT+IFzQ9EasvYzIUYzeD100GAyfdr4sXxIe+5/v6xNoJAvIFK8O/y8H2mMGvxN5Yb7NAYCTWCEtQ==
X-Received: by 2002:a17:907:b10:b0:993:f540:5bb1 with SMTP id h16-20020a1709070b1000b00993f5405bb1mr8048478ejl.41.1692019241310;
        Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 03/27] libselinux: drop obsolete optimization flag
Date:   Mon, 14 Aug 2023 15:20:01 +0200
Message-Id: <20230814132025.45364-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The flag -fipa-pure-const is enabled by default in GCC at -O0 and above.

The flag is not supported by Clang, which might result in issues if a
compilation database was created via GCC.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add missing signed-off
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

