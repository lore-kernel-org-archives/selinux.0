Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B015C19F4F
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 19:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjHPTKS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbjHPTJw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 15:09:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2450272B
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 12:09:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bcb5df95c5so5614631a34.1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692212979; x=1692817779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6Jey8TLB80UFD+T1hzKA+wXqg78houKxYXGFbewCCQ=;
        b=Q6ZL6/aBBEjDhGBRukCvEjzw+WyjErVQkUxsOmtPg4XpVWGW5Z49Ef4L/yLNYSk3o8
         q8l5TfSmEVvIPfDSVLDH10YPmIFif8/s1NhKxHGQn4C6Hs71WmxHJ2u7fV06FHppyaNS
         CrwzvOvzSExP1RuuxlYxayvsEKwBVIb2FWublv3L2yVXKNZkL67wnDcOktPaxGqs+vdf
         1zFPKbI1NEVtiRjS82JDChdR3EcchyhRQIWJ26+Imo/HU8DvzeIAll4B0GoD3f9kRZdT
         T84gBE5yzQlSb9CRJU3OT70PuQCdWGBIBw5veDwKdhugCgvwRN3hUEBQXrRPZXbdiS1k
         u31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212979; x=1692817779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6Jey8TLB80UFD+T1hzKA+wXqg78houKxYXGFbewCCQ=;
        b=HpxTGYyIwR5vQl6ztNDF61zHWQK9EQ2jJSv7GYGZvFr/0Yz6LEL3+rs4gmwuLO4TyX
         u92tc+IVaGv9+ZBv2MX46Utpu4NuUQJ2fj8cBMtsG5t3890FlrtIGRFlyhowEZKyCTPH
         JQoTgZVGu8UxvV0jMGLh2P/Ov1w/TdtHtDOkqPmyBGxTo4pZWSTwTGM7mb/9aH5WTLPJ
         aq3XhMScGsjig9qNg7pI0wS3d4X+3WWGV7aotfTGb94BGv9Mep6dOPnxasGggGrBoJzn
         mIJrp7z6Skobxq10qsPBJdULthDFcDjgmrz8RD4CQOylP2SZv8zIIgmNIoZgTh104e6M
         6E7w==
X-Gm-Message-State: AOJu0YzrH4E5ZB9UdH60ZGiJruA4heE2CjeWFd08MukknDKFoGg+vpZi
        4I54yjYHan8+R269FSn4aIKrhUN67TM=
X-Google-Smtp-Source: AGHT+IGv4sTm6OOnyqt8F8HpPoyem3WumcE6+QntNVD73+jrDOpVoIFspyE446rMkRH0eHr8Y7rzzw==
X-Received: by 2002:a05:6871:8a0:b0:1bf:88c8:7924 with SMTP id r32-20020a05687108a000b001bf88c87924mr3258129oaq.47.1692212979516;
        Wed, 16 Aug 2023 12:09:39 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id v6-20020a0ce1c6000000b006418eba1ea3sm4158836qvl.140.2023.08.16.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:09:39 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix the version number for the latest exported function
Date:   Wed, 16 Aug 2023 15:09:34 -0400
Message-ID: <20230816190934.729086-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

cil_write_post_ast() should be in libsepol version 3.6, since version
3.5 has already been released.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/libsepol.map.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 6ad68f0b..e5e6608c 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -290,7 +290,7 @@ LIBSEPOL_3.4 {
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
 
-LIBSEPOL_3.5 {
+LIBSEPOL_3.6 {
   global:
 	cil_write_post_ast;
 } LIBSEPOL_3.4;
-- 
2.41.0

