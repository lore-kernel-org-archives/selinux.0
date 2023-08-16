Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23229C04E69
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbjHPMjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbjHPMjD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 08:39:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A4211E
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-525597d891fso4885081a12.3
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692189539; x=1692794339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqIGz5TKkb4E1kbvULKruf/3JJhLy36IztWTYKBbei8=;
        b=eetLqIwYD5uFrf4kmr08yEJ2UWQMQmiLfeptoWcvmBQPg5QL9r+voiS4ncbaY+7sVI
         IX8yfF1UWJpebfHXV21D/jNXYgWPH0S5x+GjS+Y+z7ew/ZsBeIR0P7yUqeZ922ZZJ8Jy
         Iggue4HkMOybo9FTZyGN2iKFYtlYykPcq6bVtgbeFhq5oBPiJ9fWQ3eN6eW3hBR2sccl
         X7Is61wZelENaM4C08wMt7owK5BGmijL6luR36s8ObotxvN/qVx7326NtClgq/VPpKb1
         I20gcAsi3CsL2iUlhMrsnSA67bpLKeEDRBatv57epTQ8PXR1A85Onhqm5kb+jDG/nT2I
         AXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189539; x=1692794339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqIGz5TKkb4E1kbvULKruf/3JJhLy36IztWTYKBbei8=;
        b=goEqF4DmGnvEPbnMnHmB8qPmvB8yrV19PxE/RR0hjUKC/ll/KLk+igl2zUS2c5mC2I
         gAEFyS61VL88WjcmWHO2F/CzgJgN57HyPfXxzFIkBOVWWYOp8hFU0SZR0g/q4g92u5Wz
         L+IVE0fQ/zl47bgYzXHihlLjr48yISJT67c7lrqbYl+giortft5bRzU0vMbQg+O7PXoa
         MCCxKf3jp67qvEfXz147e+fsrrpfVHO5jGL9IfyjFda2uQRzc9r6H5PNYnvU+tDN9t/h
         zV1g/4fMuthqK1KGyYlrrEb9lv+1N4tPC++U1rQB9OdeT3Qh1XzidUFRL+7pSNqLHuv2
         7YcA==
X-Gm-Message-State: AOJu0YxFIdLBf8mqjRbNfCvn/Gqa4rQt0l7vHzxW496OA97KuuUd7AEZ
        6QdDe7hJryGUzay+xi+YLJE3Yn3slehcNfxo
X-Google-Smtp-Source: AGHT+IEXIvQ6ZNfHgY+mbvjJIuh3bLU2j56kvqtfcx400PxSJCWDDrwm3AQcFfLm2Xpl3NscWqurfg==
X-Received: by 2002:a17:906:cc0d:b0:99d:7336:728c with SMTP id ml13-20020a170906cc0d00b0099d7336728cmr1247968ejb.35.1692189539231;
        Wed, 16 Aug 2023 05:38:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-001-094-128.77.1.pool.telefonica.de. [77.1.94.128])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm8434075ejk.137.2023.08.16.05.38.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:38:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: use DJB2a string hash function
Date:   Wed, 16 Aug 2023 14:38:42 +0200
Message-Id: <20230816123845.80171-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816123845.80171-1-cgzones@googlemail.com>
References: <20230816123845.80171-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hash table implementation uses `& (h->size - 1)` to truncate
generated hashes to the number of buckets.  This operation is equal to
`% h->size` if and only if the size is a power of two (which seems to be
always the case).  One property of the binary and with a power of two
(and probably a small one <=2048) is all higher bits are discarded.
Thus a hash function is needed with a good avalanche effect, which the
current one is not.

Benchmark of building Reference Policy:

    # Current
    Benchmark 1: /tmp/destdir/usr/bin/checkpolicy -c 33 -U deny -S -O -E policy.conf -o policy.33
      Time (mean ± σ):      2.521 s ±  0.025 s    [User: 2.442 s, System: 0.076 s]
      Range (min … max):    2.467 s …  2.550 s    10 runs

    # Patch
    Benchmark 1: /tmp/destdir/usr/bin/checkpolicy -c 33 -U deny -S -O -E policy.conf -o policy.33
      Time (mean ± σ):      2.385 s ±  0.031 s    [User: 2.303 s, System: 0.081 s]
      Range (min … max):    2.353 s …  2.446 s    10 runs

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/symtab.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index 78567dbf..4b45c549 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -17,17 +17,13 @@
 ignore_unsigned_overflow_
 static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
 {
-	const char *p, *keyp;
-	size_t size;
-	unsigned int val;
-
-	val = 0;
-	keyp = (const char *)key;
-	size = strlen(keyp);
-	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
-		val =
-		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
-	return val & (h->size - 1);
+	unsigned int hash = 5381;
+	unsigned char c;
+
+	while ((c = *(unsigned const char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash & (h->size - 1);
 }
 
 static int symcmp(hashtab_t h
-- 
2.40.1

