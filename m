Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44BC11F64
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34B561402
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGAShI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAShH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 14:37:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C7C061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 11:34:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n25so9751920edw.9
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/O9/1Xx/lXuOvloFgpj8Qb6XqrhNRAe9a5ix4sIidA=;
        b=tay0mFHTI5ZLO1sJTzBB9zxRiuK3NX++DCMMTlzrhschqzOe7F0fqmQhD1y6W8AM62
         KKFhGJv5kMO7vR8eVZ4zRf4kO9nHG/pFI6riPuoZvosK0kxGpbXUd5gDQ02srhahavcB
         Wm74z29nx8YQTfBC3AhJCDGlE7CyaQeHa7L46ShQ8xXVeLYCiVg619p5KhuHrYAKRFc3
         ZBUpWsA4H8kRAHyV1ryT+x8HY/hbG2rFSV/pO+V+QNv2P+qSBPLVklIbL3IiupQoAr9D
         YKqiaQfD00Chy47SfAwJWpmxaTGbJxu/1gLMA3s1rWd7zgBQ51DFJZl0LYZuDGNPpTaB
         +mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/O9/1Xx/lXuOvloFgpj8Qb6XqrhNRAe9a5ix4sIidA=;
        b=dmMFMerai6sodoKrpebGxR03m1q8vXHx10zZNRrzcgENkklAm4Vk+XO00eBAbDQB26
         eP2pUtQaVX/rGfKh7GHnJVg5Kkb7sY550ibr6xYlVWaCFhdkWnRzCQO9EKZThOwfCMXc
         qkVYEjA5TImZxBO/hQY27gKUEXnUUIz8XgVvA10yrln483TeQ1MBXK9dcICS61sUrMTI
         Ktj2tZjCGUgf8S79+HrCjqUm+QEcUK94i7hirlxqn/FW0lLjwI5uo/guRr0MneEV/40j
         /BuCowJ5dREfqtDZEv0ydoGn2IdPS/3+fwrjRrQN6dB4A/B/0ZXZ6MEMu8jLjxomGj6w
         UXLg==
X-Gm-Message-State: AOAM530JEP9wBLkVbX1ItoguUuPcaTE9doR0iqr1QP2gjZveoXAPFiAw
        UqUYtALBC9yRRb95/PUAmOMBCyYUTAI=
X-Google-Smtp-Source: ABdhPJw37SMjsDvIjgHVRrFXHzbWgFT5GeQcHbdH/f8Blv4qdqIleyVW0kTN8p3u8+9i3K1cPYroNg==
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr1605920edr.83.1625164475211;
        Thu, 01 Jul 2021 11:34:35 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-223-136.77.6.pool.telefonica.de. [77.6.223.136])
        by smtp.gmail.com with ESMTPSA id h7sm273618edb.13.2021.07.01.11.34.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:34:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: avoid unsigned integer overflow
Date:   Thu,  1 Jul 2021 20:34:30 +0200
Message-Id: <20210701183430.145934-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unsigned integer overflow is well-defined and not undefined behavior.
But it is still useful to enable undefined behavior sanitizer checks on
unsigned arithmetic to detect possible issues on counters or variables
with similar purpose.

Use a spaceship operator like comparison instead of subtraction.

Modern compilers will generate a single comparison instruction instead
of actually perform the subtraction.

    policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'

This is similar to 1537ea84.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ef2217c2..8865a2eb 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
 	const struct range_trans *key2 = (const struct range_trans *)k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = (key1->source_type > key2->source_type) - (key1->source_type < key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = (key1->target_type > key2->target_type) - (key1->target_type < key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = (key1->target_class > key2->target_class) - (key1->target_class > key2->target_class);
 
 	return v;
 }
-- 
2.32.0

