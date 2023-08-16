Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1117FC41513
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbjHPMjO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245336AbjHPMjC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 08:39:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC9326B1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99d90ffed68so857205166b.0
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692189540; x=1692794340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg6l6Rhu1p5H5AHYMUEAumZ4eKjnIcBrWpBZ+y3B+wQ=;
        b=qM6/FgIW8Ig61/yIr9Xg8W5tynjtFCBwvPr6jLEVvGzgoD65R4ghS84HrqRRlNOi6a
         FWkvdkJogL8Hm9uiPXwhRaflxfKipiXoXLMowLdWlnI+oZVubxegXUU+MUSfDVTfLHhZ
         OXLU7xEYqg/hJ/Zl02ibVrccZBzr+OtoY4dH1Cez/ldRU/OXwcg7aRrJMCooORIe+Y2L
         yxLjDry4qVBfNepH7aM+T0NGYnAXpaqf7jVzpsa3O7MuhsRRKzcnEJdTwMQPuvJoQ2zV
         JeTv/2SYUaS0q92at9q83YuEzymshEsK9vWFxvsqkkmv8M56cH3/ESb00bcJuYhW+hYJ
         oU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189540; x=1692794340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg6l6Rhu1p5H5AHYMUEAumZ4eKjnIcBrWpBZ+y3B+wQ=;
        b=LlFUqp/XqM1zfDCBUOBXyzvli8mItjrkC9M811rubmIUGNDuwZt4rGjduLR+o8ku6g
         1fF7LlCOfPN6L9KJCCKdPV++QxM7BnfeOLmjZasw6aZM18IZRn2Ejd3yo9XYmC3GkmP7
         lbVC/iYZB5wJbGfe+DLfAfN7Huk0O4pdSGFqlZyCaEPWyl4OY5tJq4FJT/tJFU2kYgPJ
         EdOyDCzVLl3AtY0ffyesFER5gz4oOCan7Y5PewzfF4emU9lQUjwnvm/6DSL1tIagSigw
         e59WIUk6pscvek+YxO5/vK/J92YqM1aqByRfxM+BbAv4bpGFoOOiyeryl8uI2hbHMzuj
         AP4g==
X-Gm-Message-State: AOJu0YxazmKX7zRcaPshEK7wH9RVgvsvEaEZwhiD1BHc5Ae5TSNdvF+p
        h0it+rst5mo8ofPPoncpMQ3i2cThjDFgdMi7
X-Google-Smtp-Source: AGHT+IEAJFjD8AiI44+LLh8r7dOOjttlnLqzg58a37RUzTMsBc83xOn3lnLvEFqtwbnLMRQz4lqClg==
X-Received: by 2002:a17:906:519e:b0:99d:decd:3deb with SMTP id y30-20020a170906519e00b0099ddecd3debmr2532114ejk.14.1692189539760;
        Wed, 16 Aug 2023 05:38:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-001-094-128.77.1.pool.telefonica.de. [77.1.94.128])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906415b00b009886aaeb722sm8434075ejk.137.2023.08.16.05.38.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:38:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] libsepol/cil: use DJB2a string hash function
Date:   Wed, 16 Aug 2023 14:38:43 +0200
Message-Id: <20230816123845.80171-3-cgzones@googlemail.com>
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

Benchmark of building dssp5:

    # Current
    Time (mean ± σ):      1.347 s ±  0.065 s    [User: 1.207 s, System: 0.138 s]
    Range (min … max):    1.274 s …  1.436 s    10 runs

    # Patch
    Time (mean ± σ):      1.336 s ±  0.029 s    [User: 1.195 s, System: 0.140 s]
    Range (min … max):    1.303 s …  1.376 s    10 runs

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_strpool.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index e32ee4e9..beea5c9d 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -47,16 +47,13 @@ static hashtab_t cil_strpool_tab = NULL;
 
 static unsigned int cil_strpool_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	const char *p;
-	size_t size;
-	unsigned int val;
+	unsigned int hash = 5381;
+	unsigned char c;
 
-	val = 0;
-	size = strlen(key);
-	for (p = key; ((size_t) (p - key)) < size; p++)
-		val =
-		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
-	return val & (h->size - 1);
+	while ((c = *(unsigned const char *)key++))
+		hash = ((hash << 5) + hash) ^ c;
+
+	return hash & (h->size - 1);
 }
 
 static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), const_hashtab_key_t key1, const_hashtab_key_t key2)
-- 
2.40.1

