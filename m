Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2778676
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705794; cv=none; b=lmBRDBaUMfaNzzzYH/rGCqZ+yk3bGafaKr3bTF3yjctwmEDNjbiSqipZ0LbiQaLQjHlaQEVj6jkOUj2LoAjYLUuEb6WfcOFyAhUUUC5mSyyGXqUUulMZYpDWafKbrUdoSWNM3+gMDJapS4ekUxp1Laf62WT0hDXHftYCPXpLbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705794; c=relaxed/simple;
	bh=9UlJw9pEFHYOKbSS8FxPOnAgi7cgsUzpsr5GK+nN9YE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVtcCqOkKh2rWgNDSCzaORdtZeu24I5uHVXEscf0XaYeM34i5mgswPeHH0dGRz53iV1X1PQvECEmE55UY5+o1PwaI4eaca2uHMDHn1tfVBvBHE4W3uEkMZLAtF1c2VVXmPtn+oVLoYFrFpi1S6T4J2ltEVpEUdrA+XnZXXvNHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PvfvKDy5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PvfvKDy5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a318ccfe412so478018966b.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706705791; x=1707310591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhie0+7Hbsok8kASBVSMKzyXl8VXYFF1s7le8Z5fmKg=;
        b=PvfvKDy5bEin1axbCS7h7pzf2rLPpuHoLZcfdzs3Bb5UJRJgwnIZjNzmXK0B5WaohN
         XcTQ1qT4gJ6la8y2qvW2esQCbJcZXr2d7f+1SmH9NfDBA0/2rBcizI9gYcp0uAI8ncal
         iOmCBZTfW1LGpcrvbRkJyIPHMtwHY+dSdgPYKxt57nADRqxt2GeZ6wuJUEojhHYyZvIp
         pClTkZJp69MEmyoz8k3eWh6j/vncbSmSBc2JjmSh1ncU/WPC6SygxeEjLfpKERTCBxz8
         8Nh0+/iiKCWjspLhlc7g5d45YcMCOG1IdbBp/yF5Z0qqWk12YZYRyUTHXUGYJaTCQFHJ
         ksmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705791; x=1707310591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhie0+7Hbsok8kASBVSMKzyXl8VXYFF1s7le8Z5fmKg=;
        b=Wk/zQKesKaVmls0ZB1q0QhkUwetRAWOmO4YmfBYbMOSOTwnc3cBpFzuMdXl/PIm68w
         wUDxTNrCOv/tRbT8CmQOapSHKTl7ET/SZHmBESIVBe+gv8ARpCFiED1v5ZWLC3kydaeP
         uIWhACLhGdAIVAJTcDThKLyXM063ImNPvSxZVp9a4SYf/gzISwYwKRMHRO45Usdppbvr
         9O8i8dYE2NDqUEypoKtYpSlmCQe+yVZJTdwQrFpNLy2bLUubUaeDR8+5py5pAQh+F02B
         wpuGOr2IAvAL0giRVcTRGcLDrrCqjF6BC+lF5txyByyJ8Mu4cr8dNEvD9Fk6T4oTfHtL
         ZPhA==
X-Gm-Message-State: AOJu0YzCnRBeIv+bwuCR0pHyiJhjrCHF58xKz0crskBzUZtWSDYVqHcJ
	NfLOidzNDYrGxbbBM88qJY6K7Bo8NdjZ+rtL+ZKV8rxrmVkFhJF0wonLFQmz
X-Google-Smtp-Source: AGHT+IHanbEYFLFwWWpkvjhZK40K+R4+xVZ0zeR5t5l3uncpjPfl2T2tFnHXjTO2vf3mDG411PvoJQ==
X-Received: by 2002:a17:906:6d12:b0:a35:6c2f:f0e7 with SMTP id m18-20020a1709066d1200b00a356c2ff0e7mr1033610ejr.74.1706705790953;
        Wed, 31 Jan 2024 04:56:30 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm6248843ejb.170.2024.01.31.04.56.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:56:30 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol/cil: ensure transitivity in compare functions
Date: Wed, 31 Jan 2024 13:56:11 +0100
Message-ID: <20240131125623.45758-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131125623.45758-1-cgzones@googlemail.com>
References: <20240131125623.45758-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ensure comparison functions used by qsort(3) fulfill transitivity, since
otherwise the resulting array might not be sorted correctly or worse[1]
in case of integer overflows.

[1]: https://www.qualys.com/2024/01/30/qsort.txt

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 7f45299a..ac99997f 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -52,6 +52,8 @@
 #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
 #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
 
+#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
+
 struct fc_data {
 	unsigned int meta;
 	size_t stem_len;
@@ -263,8 +265,8 @@ int cil_post_ibpkeycon_compare(const void *a, const void *b)
 	if (rc)
 		return rc;
 
-	rc = (aibpkeycon->pkey_high - aibpkeycon->pkey_low)
-		- (bibpkeycon->pkey_high - bibpkeycon->pkey_low);
+	rc = spaceship_cmp(aibpkeycon->pkey_high - aibpkeycon->pkey_low,
+		bibpkeycon->pkey_high - bibpkeycon->pkey_low);
 	if (rc == 0) {
 		if (aibpkeycon->pkey_low < bibpkeycon->pkey_low)
 			rc = -1;
@@ -281,8 +283,8 @@ int cil_post_portcon_compare(const void *a, const void *b)
 	struct cil_portcon *aportcon = *(struct cil_portcon**)a;
 	struct cil_portcon *bportcon = *(struct cil_portcon**)b;
 
-	rc = (aportcon->port_high - aportcon->port_low) 
-		- (bportcon->port_high - bportcon->port_low);
+	rc = spaceship_cmp(aportcon->port_high - aportcon->port_low,
+		bportcon->port_high - bportcon->port_low);
 	if (rc == 0) {
 		if (aportcon->port_low < bportcon->port_low) {
 			rc = -1;
@@ -394,8 +396,8 @@ static int cil_post_iomemcon_compare(const void *a, const void *b)
 	struct cil_iomemcon *aiomemcon = *(struct cil_iomemcon**)a;
 	struct cil_iomemcon *biomemcon = *(struct cil_iomemcon**)b;
 
-	rc = (aiomemcon->iomem_high - aiomemcon->iomem_low) 
-		- (biomemcon->iomem_high - biomemcon->iomem_low);
+	rc = spaceship_cmp(aiomemcon->iomem_high - aiomemcon->iomem_low,
+		biomemcon->iomem_high - biomemcon->iomem_low);
 	if (rc == 0) {
 		if (aiomemcon->iomem_low < biomemcon->iomem_low) {
 			rc = -1;
@@ -413,8 +415,8 @@ static int cil_post_ioportcon_compare(const void *a, const void *b)
 	struct cil_ioportcon *aioportcon = *(struct cil_ioportcon**)a;
 	struct cil_ioportcon *bioportcon = *(struct cil_ioportcon**)b;
 
-	rc = (aioportcon->ioport_high - aioportcon->ioport_low) 
-		- (bioportcon->ioport_high - bioportcon->ioport_low);
+	rc = spaceship_cmp(aioportcon->ioport_high - aioportcon->ioport_low,
+		bioportcon->ioport_high - bioportcon->ioport_low);
 	if (rc == 0) {
 		if (aioportcon->ioport_low < bioportcon->ioport_low) {
 			rc = -1;
-- 
2.43.0

