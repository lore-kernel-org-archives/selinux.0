Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4FFC25B4F
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHNNVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHNNVC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35399172B
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so560737466b.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019250; x=1692624050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F76+OARcbDG+Dhzl4dXmbQMfBLLsN2l7V+qnY8M1apY=;
        b=oyE5DKUv2cDh/K8dJ5LEpDpVpXgivYq4+625B1jggy9oiiPRHl1+hcz/YKTWYQ4n75
         UT3yjZ4E1GxgNpTFI2ay9DStfDRalys8NIaB7T6Ye3jEU67LuORwJkkpwnSXzSISh28B
         1U3j9GySL804ntdxu8aDb4dt7gYUJoaE3sUPl6Y+rUeGjPm83UtfnqGGAnQXp0NLutvQ
         5GbjqBiN55ckW7J+mXG2UnhYr4WDukRqRPqyv1P9XZ2T2wFe6Q1YP9D/8rlzujda/O9H
         fW6NvR8squu0FhwQZVc2wnY497aRGWwH+OuLzUU4ZaOvsWqc4M06I5jjqsIbU6AxjbK7
         nfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019251; x=1692624051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76+OARcbDG+Dhzl4dXmbQMfBLLsN2l7V+qnY8M1apY=;
        b=abFBKQSLY+L6dwjwpOfVuI+kW8aZQRRbJFzlIZuULKVC0lvV6RqB1Z5urBePek22PE
         FCl2A+I1j8jyGCd6PUP5WsLCwyfgeJWiV41kkBLrXzI/TMZrkDG+bTn/XVJ1/J48hCr0
         WRxXvBk9yoVOss9Gt4iIEn+U9zcPxP6u4atz4w9wnxEdb78qyxpEO0DIYZvv9/ue/O1q
         w56tYy4NBilIFxAbmIK+n7nBCRr4n6CAxCCFO0hCqG3DDa/6C+8XycOcmWMp+freWXi6
         jDLjxm1DcZ9oHSE2ZOQI3RFE+bXDzfKXnGo0d2Gv5XAKTO+gR1foOYmFYDAEtfEg4UES
         +JWg==
X-Gm-Message-State: AOJu0YzI3+qO/rAsCYpM31iMCscshqWXL78oWyGoFS/QwgWyOSI/U4c7
        WpzIQVc6Uu9fHiyVLnVjw9G7L6oFSA3WPlkx2lA=
X-Google-Smtp-Source: AGHT+IFScb5PcbLPmbONsiza/n34KVF1mQ1ZbEdYLw1b0afn3pT71u+opCxsUOKjO4k+r6Y1CKbkPQ==
X-Received: by 2002:a17:906:31db:b0:993:fe68:569d with SMTP id f27-20020a17090631db00b00993fe68569dmr6651355ejf.17.1692019250484;
        Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 18/27] libselinux: fix logic for building android backend
Date:   Mon, 14 Aug 2023 15:20:16 +0200
Message-Id: <20230814132025.45364-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the typo and adjust the logic accordingly so the android backend is
not build by default, but if either ANDROID_HOST or
LABEL_BACKEND_ANDROID is set to y.

Fixes: c2a58cc52574 ("libselinux: LABEL_BACKEND_ANDROID add option to enable")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 15d224e1..86a254da 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -131,11 +131,10 @@ DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
 SRCS= callbacks.c freecon.c label.c label_file.c \
 	label_backends_android.c regex.c label_support.c \
 	matchpathcon.c setrans_client.c sha1.c booleans.c
-else
 LABEL_BACKEND_ANDROID=y
 endif
 
-ifneq ($(LABEL_BACKEND_ANDROIDT),y)
+ifneq ($(LABEL_BACKEND_ANDROID),y)
 SRCS:= $(filter-out label_backends_android.c, $(SRCS))
 DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
 endif
-- 
2.40.1

