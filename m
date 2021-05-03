Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC3C433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A198E6121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhECRy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhECRyw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA9C061763
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d14so7284100edc.12
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5oO0YCOLyVYMxcN3MBjbY9NAjoy33/7LxOpC2BU2HAs=;
        b=PB68QvO5CGUtWiipEjYVvZWR0iWNIS5ywTwAd9Jt0JN/4nDsz4E70FcmLnG4ZdRBvq
         J5lk4icvGO5oYn2Vhf5jMvTFZwuVx5jW353YijaKCU8IO/2L7HvtXGUBh7J3nhRh+DzZ
         X4ktdQUGuvdTfbvbX+5UWGDWiOifPSFWOitxU4SI5MTN7G6L/Z4dzLhm5oqUGr5cLTmx
         cLn5zOzSa/W3sFap13JYu4alEmnr4OKLXpO0djb1zMpGB1qpYoY3ck60ooVUCaoXB1lA
         T0radV4v9OMTDOuO72ohKAPlsGzD860pkTf52UdmodEmUmi+6qzPhzR2kcm+0IvchTRP
         05Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oO0YCOLyVYMxcN3MBjbY9NAjoy33/7LxOpC2BU2HAs=;
        b=un1mHk9zctZetmjKWq+XwnlOillO2XhtgMbVbY17Hq0gYNU/eH7kXo+eUziyIWTXUv
         uRtZGlNNBjvkaP1ArP6k7vTMeOSXr/PYu6uH+Hxx1kWtak/+4T7X6AmkGOtKrK9mbgOg
         v4UiTv1nBMOd1IE90VdYADJNFKOT8A1y+kEJwfGgHw+PAA1nt+IMdMi4i69rdWPPhLJz
         b6I10ty34BM/ajcqvnh3NsbT9SoeLbtcyKv0v84Y3qt9Ou/1JSO9r+kC1Vjx7G9CA1kY
         MJQ/Yl87njPKxdTNRbqTBqi5C17iWLoCLl/wkYAuR060wjU1w/cG4V3y2GR+2QYji1XX
         4IHQ==
X-Gm-Message-State: AOAM5302rOA2EDwvrw8EIBk8zdrMFYN6KG+RQjsOruPtJz1nmPDh9yuY
        XVOc3gMqjS6Pn47fM0gL7tl8C4SNbHQ0oQ==
X-Google-Smtp-Source: ABdhPJwmkhh0KDFjN1ZYJrj6fuefSXEnTNjsmFAzJA/85LpFANRcjKHUg93U1tYaJJcKfOwrfoEbOg==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr21109507edq.325.1620064437061;
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 04/25] libselinux: Sha1Finalise(): do not discard const qualifier
Date:   Mon,  3 May 2021 19:53:29 +0200
Message-Id: <20210503175350.55954-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mark the argument `Buffer` of `Sha1Update()` const, since it is not
modified.

sha1.c: In function ‘Sha1Finalise’:
sha1.c:208:25: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
  208 |     Sha1Update(Context, (uint8_t*)"\x80", 1);
      |                         ^
sha1.c:211:29: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
  211 |         Sha1Update(Context, (uint8_t*)"\0", 1);
      |                             ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sha1.c | 10 +++++-----
 libselinux/src/sha1.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 9a8ce01d..664bbcf2 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -151,7 +151,7 @@ void
     Sha1Update
     (
         Sha1Context*        Context,
-        void*               Buffer,
+        const void*         Buffer,
         uint32_t            BufferSize
     )
 {
@@ -172,7 +172,7 @@ void
         TransformFunction(Context->State, Context->Buffer);
         for (; i + 63 < BufferSize; i += 64)
         {
-            TransformFunction(Context->State, (uint8_t*)Buffer + i);
+            TransformFunction(Context->State, (const uint8_t*)Buffer + i);
         }
         j = 0;
     }
@@ -181,7 +181,7 @@ void
         i = 0;
     }
 
-    memcpy(&Context->Buffer[j], &((uint8_t*)Buffer)[i], BufferSize - i);
+    memcpy(&Context->Buffer[j], &((const uint8_t*)Buffer)[i], BufferSize - i);
 }
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -205,10 +205,10 @@ void
         finalcount[i] = (unsigned char)((Context->Count[(i >= 4 ? 0 : 1)]
          >> ((3-(i & 3)) * 8) ) & 255);  // Endian independent
     }
-    Sha1Update(Context, (uint8_t*)"\x80", 1);
+    Sha1Update(Context, (const uint8_t*)"\x80", 1);
     while ((Context->Count[0] & 504) != 448)
     {
-        Sha1Update(Context, (uint8_t*)"\0", 1);
+        Sha1Update(Context, (const uint8_t*)"\0", 1);
     }
 
     Sha1Update(Context, finalcount, 8);  // Should cause a Sha1TransformFunction()
diff --git a/libselinux/src/sha1.h b/libselinux/src/sha1.h
index eac3c195..f83a6e7e 100644
--- a/libselinux/src/sha1.h
+++ b/libselinux/src/sha1.h
@@ -64,7 +64,7 @@ void
     Sha1Update
     (
         Sha1Context*        Context,
-        void*               Buffer,
+        const void*         Buffer,
         uint32_t            BufferSize
     );
 
-- 
2.31.1

