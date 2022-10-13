Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9A1C4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 15:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMPbO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJMPbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 11:31:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B893B9B5
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:31:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i9so1530511qvo.0
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds1fVZrhcatDuOjlvg5yRfFM6VXnZhm2TXSCGHmKtzw=;
        b=PwInAIblLX37TZ6xjwWbIP17SCITRPp5sq8BKYsaQa5vdOXIjD6K/YwiedUz+K0k2W
         9E+F15JBZ412hu37y05lZQRPplcRA/E9tXu28aIH92qa7V3rVp+JaYVKncu0Lw5t8pRr
         Doq1T7lJqlUiz5pT7mGGxLU8A33lPBQeElLcZEZb3AlLRVZRUlgct08/r5mf+2avrl3B
         z3k0Z3fB8rL98yNEF15XLTyh06+dwAxceZW54eZHDUPd3ShrRdSQ3a3iPiRUZTpZor/h
         uzjyDJI3snR0vVzWG8gjt3FwkO2ErH6WgEdE2p533tAQjSo6wYctLSP4RcmE1VRYcOO8
         gNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds1fVZrhcatDuOjlvg5yRfFM6VXnZhm2TXSCGHmKtzw=;
        b=cK3UVe7XtTxtmA8f235u78abIov6JjViJQUFgKrK/uTkFApgyhcKtJKmHPmnOjmU7u
         1KCoYiVI33GoKmvSH9IWddm2PxGj2OKue/Y+7NlYBZZxBPhVgl1quuzZklu7MgJnGSP6
         vOr3wlKOgX9pDSVMar3Tik0lzvM56eGmjIgNJuU6kf7/3HLF6PAed1HkAGYaE7/6eIKK
         GINW58MuRCMvW6sjbIItzTIgg/zqYH/Z8hyAutb4m+EoNQbcO2PIL+hEic4+d6d8iPwj
         OUrUBoCWdgDGEDOC1Y6NXUuqeSfzQ8GFz1UY6SBGrxUDdwj2OJyvMehCnZpN+WI3kEWM
         6P7Q==
X-Gm-Message-State: ACrzQf0c6L/4rUXu9/s0vC2NiMKPgRKMXsdAuO4NAqiS+gZj8zKohZgl
        ONbHGjOcwPvT9WZaMvveZbwybbcBuDU=
X-Google-Smtp-Source: AMsMyM4Ln+o8ooxxuBteZQ9ex4HW42mF004Cj1P40EB0zJBhwbKf/QDKCb065JBGdA0u/jRqQAlBog==
X-Received: by 2002:a05:6214:4114:b0:4b1:c7b1:6fad with SMTP id kc20-20020a056214411400b004b1c7b16fadmr447847qvb.76.1665675062600;
        Thu, 13 Oct 2022 08:31:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a400600b006b949afa980sm6167qko.56.2022.10.13.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:31:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     perfinion@gentoo.org, omosnace@redhat.com, nicolas.iooss@m4x.org,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH] docs: Add GPG fingerprints
Date:   Thu, 13 Oct 2022 11:30:51 -0400
Message-Id: <20221013153051.2598199-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For Nicolas Iooss, James Carter, Jason Zaman, and Ondrej Mosnacek

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 SECURITY.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index c817eac9..87e7030e 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -26,15 +26,19 @@ the issue as quickly as possible and shorten the disclosure window.
 
 * Petr Lautrbach, plautrba@redhat.com
 * Nicolas Iooss, nicolas.iooss@m4x.org
+  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
 * Jeffrey Vander Stoep, jeffv@google.com
 * Joshua Brindle, brindle@gmail.com
 * James Carter, jwcart2@gmail.com
+  *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
 * Paul Moore, paul@paul-moore.com
   *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
 * Jason Zaman, perfinion@gentoo.org
+  *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Steve Lawrence, slawrence@tresys.com
 * William Roberts, bill.c.roberts@gmail.com
 * Ondrej Mosnacek, omosnace@redhat.com
+  *  (GPG fingerprint) BDAC 5EDA 6318 7BEE 99D0  4ECA CE45 D31D D1EB 364E
 
 ### Resolving Sensitive Security Issues
 
-- 
2.37.3

