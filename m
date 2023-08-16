Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBDC001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 12:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbjHPMjO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbjHPMjD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 08:39:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40291FF9
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c93638322so1341188066b.1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692189540; x=1692794340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zV8Nj7OSIjTcqPOry4WQD9ptaRYnPm3zWW0w3f0QsoU=;
        b=gx99UklzAc9ZyYY758iJwiH2C7+ngOGjDPfkIGlUXMi7soIMj+t1/YjG5iQ21XOgB+
         3vTcYKa3dPsuibDdXhfFmqvFw+AEGXpJ5l6fqdEaBQilnmPEKYiAvB08yUYwkdx7zgqd
         eW1WCjb/sQ9qv6KGR9Sb5j/2DO/dS1OQfzHQ+7UyCPYMkgzsoT8wVgibi1GTipMXLLMR
         6kQ9M9XlagED9lT1xUvqSfHe7vQL5fAO8NsDMujCErmvUhDSkBWA9MBMHQxH5htSvJzT
         siFXU00/8VI8dcNDTCwYDOs4arvoAkpruxIP5Dqre+BZDLO/gDph3ZqqflhL7WOGa9zy
         Fc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189540; x=1692794340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV8Nj7OSIjTcqPOry4WQD9ptaRYnPm3zWW0w3f0QsoU=;
        b=Ituel3iTfzOmdWufOHyZzzm3YE6EJYlU9wQFy+3RMIFe4vfQeTzC3MRA3eo2pR+y0b
         A2m/VJZ52BV54ngvc3X/V58w53KSE+cAsPRLw2eSijDUGDBbGfD1jYWI9LtQKFPgmd7l
         RLTglnWPZiXaRxAUDSRwyLgvYSRGo8jeKzFef13ToOpnJ5eG8LT7n3VA0tT9ae5dbBV5
         vRJCWsdJCPGpuGtAco8Bg0MGnp1QgmH4aF4vpYkn4CFvwfkUoyGuubBUUofOZH8wb7I2
         ZAJj8cRo1PJf0uULTKpk7ltrhetSEvOSD67LrgsxwShcdKReFCKlQ423QftzWNZqSbzl
         jryw==
X-Gm-Message-State: AOJu0YwtarmAD5CohLGwJ6zNcLOjFy1kOH7z5lELNee/PvhFLfZxuGHl
        q26Cy8/XytVOSP2LYNj/G1z6B9t520R6ATwb
X-Google-Smtp-Source: AGHT+IFf71fVW5Q1zN98d5qFabGHYfj/Ygs1RejWhv6F6/NCtqzF66G4h1sh4GcSdThsyP8BE1bjDA==
X-Received: by 2002:a17:906:5a46:b0:997:e7d0:e26d with SMTP id my6-20020a1709065a4600b00997e7d0e26dmr2140499ejc.4.1692189540242;
        Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-001-094-128.77.1.pool.telefonica.de. [77.1.94.128])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm8434075ejk.137.2023.08.16.05.38.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:38:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libselinux: use DJB2a string hash function
Date:   Wed, 16 Aug 2023 14:38:44 +0200
Message-Id: <20230816123845.80171-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816123845.80171-1-cgzones@googlemail.com>
References: <20230816123845.80171-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hash table implementation uses `& (SIDTAB_SIZE - 1)` to truncate
generated hashes to the number of buckets.  This operation is equal to
`% SIDTAB_SIZE` if and only if the size is a power of two (which seems
to be always the case).  One property of the binary and with a power of
two (and probably a small one <=2048) is all higher bits are discarded.
Thus a hash function is needed with a good avalanche effect, which the
current one is not.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_sidtab.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index f179d855..e396a938 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -15,16 +15,13 @@
 
 static inline unsigned sidtab_hash(const char * key)
 {
-	const char *p;
-	unsigned int size;
-	unsigned int val;
-
-	val = 0;
-	size = strlen(key);
-	for (p = key; (unsigned int)(p - key) < size; p++)
-		val =
-		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
-	return val & (SIDTAB_SIZE - 1);
+	unsigned int hash = 5381;
+	unsigned char c;
+
+	while ((c = *(unsigned const char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash & (SIDTAB_SIZE - 1);
 }
 
 int sidtab_init(struct sidtab *s)
-- 
2.40.1

