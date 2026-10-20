Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511391;
	b=b9zFhJMKgRpXGqlgPc9BJkX9xjBBuwpPtzNrsXfUU1rvdykg+fbLNrCsj0nFVDtGMScm
	 ZO5FMLfwSba4JH+uignrd48qipsopftR/8fF+BJaLvgMamX7KufvzGKvv+8NLYexn/qqa
	 EHVp6pZsQK+KVMEmTwQxqYRVGuR+M697aBuJKPlfDKwSxaOu4KHNEe1Frd1MsFmpYR4/O
	 IK9X2DUVz+vCRd/thGAlNnXNg/3/Kd9LEob7OYyZG9gLkDB5wySYdTrSUaOla4DR3NV6Z
	 w7x7VgVznRJo8AY+GB/ZLTwzguOdIj7c+hh0Sb8AsgP4+//a0DxkG5Uw+lv4e9MIAmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dqL6e/qgC44nxdvq/NXaAcnazS7c9AufKTjsEyj3lis=;
	b=PkTHYyirazCIMRCrpVXyf5b5lA7YqOVroES3epmCESQt8C7LwGsxjb/D7R8Hr3fiwr9i
	 jReYPePFcmxp6VwRa0q8ZKEPK4c9sIoSbeZbly5GnWGsnYLvif3pF0/6xALiRzFKDDf8H
	 Ux+PPrrIOdD4/LVOEQKrzsFLpJMHfEssygzNtYCkRd9evQ5dXL9pkP3VdXvq2SYTVUaXa
	 M2Zbp+rjRdyUAWKPesmid+TD3ip5LUxaFDGN/tOh3uJcRKDOxXIg4G0rPV6uBjduG53+p
	 rl04BJ7KQV7FP/lL4xmAMfZf0JhHOJypfsuuQYyrDq6DaP73gpA5fojHRQ1VbCETpdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXGH+Oka;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB6606A31C
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 15:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BXGH+Oka
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so25889535e9.2
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511389; x=1793116189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqL6e/qgC44nxdvq/NXaAcnazS7c9AufKTjsEyj3lis=;
        b=BXGH+Oka/ppwhlxI3ADa1N9ncsG6OktYMlWQWQueudYuzt895QHpNXs0HiIgCUKtg6
         CqPvHwMehcg0LKThomaK3h3UAA8pCoKAPXAKQWJkaPPTnfhsPPN4xW9zf1dPlYogI8Lg
         skRNrFqUJynqXW25iVAN4lVKUDaAHwi+KezHvUu9QxI1lKAS0XeswkCOK4n94vm5bR6s
         ugk3FnZikbkUNGDdtA5Kl9u8NYKpt2KyGeVWdlkCCflIb2kxlNr7rlv0gko7eARHtRgv
         LBOBxM4D2NHIE4+IcklS0fKZ+LgBtZLk4R6xVFTCSWAW+SVdzGgXWk1vS1EKTU0wnm6A
         fktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511389; x=1793116189;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqL6e/qgC44nxdvq/NXaAcnazS7c9AufKTjsEyj3lis=;
        b=yu4DfUChXIuV3ShnDuDWdExStjP1aC+5DixT29Ktzvfy1Nii5U8wygus0e+wqF2mAs
         kBAjLkJ8u5VrbrDTV5gF4VwdYwnqn16UvUXikFYfcYZdzgvHCn5NP/bHkwPsvgt9ckNY
         5W/KX2IZi5FLIa6Ca/exgGIoaVK19cVXghO1ryFE2+crXa9SIloviY9KffOHMmKPmR+Q
         8aLTNQqomFyBGPqi6Kj/AxAWAz19c8Tcyer35W0Deau0XWyLnLgoVa00Iof1zC2Q+ivq
         X2I0UDfBe9yokpcua9C6I2NSA25Yfi/Gjew70g7Y9uMby/3Bk+k98gXe2/+CcUmbSTTU
         my2w==
X-Gm-Message-State: AFq9FYI+TPvAODLtTE7LCXoFKUxA4ec+VCtN7+0tGO6y0lx0glwwK7VG
	MAjYMD713K/2LLAxumtGpv6LtFtxn3SMY3/816MGDQA16u4At6bO69cUDwUBrsQv
X-Gm-Gg: AYBFou0u/Bk5YH3MmNBn2zGnY/6OacWImvxlKNqKvSB8vskC2CLbRYkK4P8LYgooEQb
	TVc60rSSOysWYJJxiYSwr4eRY51j07LDwkIMvnIVjmzgHFQZwJQPcXTnr61kafDgrfxEuyK1iLu
	xFHxuCeteGphazxQpumG0tLDQudyk7X0Dvjz2+sohhaqLhORbRtbdr7NzOw1DWR5tCLpN6VTxbD
	bLlCgWyGZM+XDW0qcyYnX9AjYAjFA3jlv9aLTAizyZ3lGr7y6OL96m/TwyUihcPH31NO2VOWrgb
	RWu5aSg7twLyLJ1et7EuT1xsODxztWMavcxFT5pNpWRZHzOYtYe6v+ikAkpqqIpdUOmVu0XsYVE
	oUwj6aMQPKN437fd+hisKRCtpLoDOQUpxafdqBAxD6wZORX6X3+i5qHtHfnCbn5VOLyIV5+ASrJ
	E234Q58tilvSisEsqLlpvGamKpFY+MZCAFYZFYyiWyFh5yOPpQgkRKzYOgt9zWH81+G6VzzfQsa
	CqwJSkibU+xqIAwAzoejfcBk0RKKZ50jjVlSp4VDw1Zd7ys
X-Received: by 2002:a05:600c:c166:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4a1f7367b83mr40925165e9.5.1792511389141;
        Tue, 20 Oct 2026 08:49:49 -0700 (PDT)
Received: from omos-acer.lan (109-81-22-0.rct.o2.cz. [109.81.22.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8315a3sm6388796f8f.56.2026.10.20.08.49.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:49:45 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/binder: add missing parentheses in print_trans_data()
Date: Tue, 20 Oct 2026 17:49:43 +0200
Message-ID: <20261020154943.2408020-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The newly added casts were meant to convert the result of the '&'
operation, not just the left operand. Add parentheses to fix that.

Fixes: 705ddfdc5ae5 ("tests/binder: fix compiler warnings on ppc64le")
Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tests/binder/binder_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index 62af7b6..891ce9d 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -127,12 +127,12 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 		}
 #if HAVE_BINDERFS
 		printf("\tflags: priority: 0x%lx accept FDS: %s request security CTX: %s\n",
-		       (long unsigned)obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		       (long unsigned)(obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK),
 		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO",
 		       obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ? "YES" : "NO");
 #else
 		printf("\tflags: priority: 0x%lx accept FDS: %s\n",
-		       (long unsigned)obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		       (long unsigned)(obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK),
 		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO");
 #endif
 		printf("\tcookie: %llx\n", (long long unsigned)obj->cookie);
-- 
2.54.0

