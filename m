Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF944C65
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169046; cv=none; b=gQAYQPloEvTMXG3XVJ362rLwTw2tUj368tH2njdW3iAGhtHseyfa3i/Xb4ZxazK0rfjjwj1d26QwrrFGRBShcK1oWVrEKzJzrV3zDePfH95NE5kbYtvP6bX53kIxewKONxK2EWCu0P5dZQUJvDaw56ci0LZ4euw/5fL/JEAlhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169046; c=relaxed/simple;
	bh=AhFwo/oeQnbK30h5kxew5d1N2gh4bgN9cCPH6yLlNSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD+mcmHiAYLUBb8Iu1aJMcGVr82kc3cySDpdzdSgVCKwiiGidHk7ueQ+5qXwjZB2RIrxgzzZlRKMj88SUjiZGapTNTmQwYNVI53Z0HzVKp8gS2NgEsncYzCiorPoUyjFZ1clNKAaDgBzfi4vaWmM2ojRCNJ8RPPCkXlZHi3SaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WOUqsE2S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WOUqsE2S"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso293589166b.0
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710169042; x=1710773842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYPVbf3IT0Vmc0Jp16W9fYh/IjfBkHVtxPIQ6zQUmq8=;
        b=WOUqsE2SF825pIJ2+SoHbi4bhZoQ+U0RvGSYykeJKllA/8ZXfsSpcc3bNcZs6ppjj1
         KWIi70I2CJNkOt6rK/7wDG5duIAYi0ch43y5V9JPPiZsgXwvcJz7+px8Q96LcUSdnBbB
         V15x9jLJVVzdrYhHpFjLOCMnZAluKum1MUx9MJeB6uqIwLM2IYntXE7f6Are2TwbO4Dk
         Myij4IsIaqvJKMUdwPL2PyBlMehn37tSxeDfQHNw4SlaPlUhQvRL18e1/+mGIGw8+cXx
         wTkWMMiuSL7aP2Fyv6D+n7GQLiYoeSd5hvBTkq5VTv1e/OcDMQ6cDpN/gSqKmv7K+fH3
         UqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169042; x=1710773842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYPVbf3IT0Vmc0Jp16W9fYh/IjfBkHVtxPIQ6zQUmq8=;
        b=KKf7xlSFlEGreTvYqck4ldFMq1wwfM2+RSGnaUKNhux0SG8HTu260h4jPgdHXcyf+d
         OHBcFjl+wVsYOzvi4hk+KVlhpaImiz12McyqrXaexOogPmXqhRe81dVKF2lUwfmNXvzP
         JZ0W+ilEmad+QXR/Ztr+Gc/ki0Y6uM4gjafB6iRGTj/pcoRwzfS6LzqbgOn7VelLoQib
         MA3++cOSKmJJ31jrAbiJ/rMbRqMVPGJ7eFh0Zr7A0LsvQOfnrDYar2wpPvLgszPhfbp1
         vCKEwHXOITQ9ehvBZwnfjrPX9KQz95S/odrip+Po52Zew5hUCSBzlWyGV0vHYH4feHMF
         En8A==
X-Gm-Message-State: AOJu0YxfTslTwjGByYWqei8DXJulYx+UJc1ndrRNCqYdBKox6anAgwRl
	AQqtsATmSekfP7ePLRuh2n/ulKizGB0Kpvqk5qEM3hzFXHZDyBsNA5Lpk3oHeR4=
X-Google-Smtp-Source: AGHT+IGV/7cIT8L79JcUQ419dINh5ZpRLvuvppqLgvxsXlZLbHM1vHLhU85Ho/2BZEKnIvgy5MJlcA==
X-Received: by 2002:a17:907:c30c:b0:a46:2649:16f9 with SMTP id tl12-20020a170907c30c00b00a46264916f9mr2748923ejc.2.1710169042304;
        Mon, 11 Mar 2024 07:57:22 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-112-075-004.95.112.pool.telefonica.de. [95.112.75.4])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm2945240ejo.98.2024.03.11.07.57.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 5/5] checkpolicy/fuzz: scan Xen policies
Date: Mon, 11 Mar 2024 15:57:06 +0100
Message-ID: <20240311145706.34885-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311145706.34885-1-cgzones@googlemail.com>
References: <20240311145706.34885-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In addition to standard SELinux platform policies also check Xen ones.
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Note: this will break all current reproducers and corpuses due to the
changed input format.
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 43 ++++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index f3a17cce..ab1a6bb8 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -147,15 +147,28 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	policydb_t *finalpolicydb;
 	sidtab_t sidtab = {};
 	FILE *devnull = NULL;
-	int mls, policyvers;
+	int mls, platform, policyvers;
 
 	sepol_debug(VERBOSE);
 
-	/* Take the first byte whether to parse as MLS policy
-	* and the second byte as policy version. */
-	if (size < 2)
+	/*
+	 * Take the first byte whether to generate a SELinux or Xen policy,
+	 * the second byte whether to parse as MLS policy,
+	 * and the second byte as policy version.
+	 */
+	if (size < 3)
 		return 0;
 	switch (data[0]) {
+	case 'S':
+		platform = SEPOL_TARGET_SELINUX;
+		break;
+	case 'X':
+		platform = SEPOL_TARGET_XEN;
+		break;
+	default:
+		return 0;
+	}
+	switch (data[1]) {
 	case '0':
 		mls = 0;
 		break;
@@ -166,11 +179,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		return 0;
 	}
 	static_assert(0x7F - 'A' >= POLICYDB_VERSION_MAX, "Max policy version should be representable");
-	policyvers = data[1] - 'A';
+	policyvers = data[2] - 'A';
 	if (policyvers < POLICYDB_VERSION_MIN || policyvers > POLICYDB_VERSION_MAX)
 		return 0;
-	data += 2;
-	size -= 2;
+	data += 3;
+	size -= 3;
 
 	if (policydb_init(&parsepolicydb))
 		goto exit;
@@ -178,7 +191,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	parsepolicydb.policy_type = POLICY_BASE;
 	parsepolicydb.mls = mls;
 	parsepolicydb.handle_unknown = DENY_UNKNOWN;
-	policydb_set_target_platform(&parsepolicydb, SEPOL_TARGET_SELINUX);
+	policydb_set_target_platform(&parsepolicydb, platform);
 
 	if (read_source_policy(&parsepolicydb, data, size))
 		goto exit;
@@ -198,15 +211,17 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 
 		kernpolicydb.policyvers = policyvers;
 
-		assert(kernpolicydb.policy_type    == POLICY_KERN);
-		assert(kernpolicydb.handle_unknown == SEPOL_DENY_UNKNOWN);
-		assert(kernpolicydb.mls            == mls);
+		assert(kernpolicydb.policy_type     == POLICY_KERN);
+		assert(kernpolicydb.handle_unknown  == SEPOL_DENY_UNKNOWN);
+		assert(kernpolicydb.mls             == mls);
+		assert(kernpolicydb.target_platform == platform);
 
 		finalpolicydb = &kernpolicydb;
 	} else {
-		assert(parsepolicydb.policy_type    == POLICY_MOD);
-		assert(parsepolicydb.handle_unknown == SEPOL_DENY_UNKNOWN);
-		assert(parsepolicydb.mls            == mls);
+		assert(parsepolicydb.policy_type     == POLICY_MOD);
+		assert(parsepolicydb.handle_unknown  == SEPOL_DENY_UNKNOWN);
+		assert(parsepolicydb.mls             == mls);
+		assert(parsepolicydb.target_platform == platform);
 
 		finalpolicydb = &parsepolicydb;
 	}
-- 
2.43.0

