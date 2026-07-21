Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E946D094
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656400; cv=none; b=Uz5XhIBASZcqgJZuVR6ErCj2CRP0ughjeMcpm7pGw3qacVq5rQqPr+jdIKt5RAYC8G8k/PoXvyOSXSDg6A2y7gQ8T2znJu5XktpC9yw9kPWwORR51Z6jYHNEv8DRLm9F9CKFoB2CDpma6Q/B8SIv71BHZLOhMYS5ht77sXR3yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656400; c=relaxed/simple;
	bh=4IpV4LPb90ZLdV2TzjkMErMlcYy5oKnfB/iYUms71tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMdgB42tBOodns6bw2QDptBiSLeIN3KBlOwAgYlx/Py7F4HoO2YJOfxspoF3+jgBtabfFb6i/i+C1PtKiXinWcJWfnLLJ24WSRzN3fcMJmG0PG4qJKbOO+dpllCwIfFLwLGDBqw7xcss+28FI9Eggh7SqMqwMCr5wrfjV6UjqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf20bOZl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf20bOZl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92b21f65b60so487773085a.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656398; x=1785261198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzwAEWZPIA1FZVtXGE52YOqaQITtBkKsTklSarGPm2Y=;
        b=jf20bOZlkN/r6HG3djVqS+P44TWDrgQZVTfwdkznekrYngmwMdgHQ+RO4jbNBGrFMP
         l+ex4YthgfLEPFLOhpt02C9+LKsPtb7LZG27dtcJ5zhABn0w91XNx1VL1iaMVpO/vYED
         Ktiu8Gt9UIqV3yfFJKTSJNi4bfiZQ2QtIEHnv7mE9Dv1DV+CrMQcBWAl6qV0Xdz/GZ8i
         sbOh67ShuitPp0z2FRvB3LAg9lbfTyCfjHlacOmZTHYDSOO6QOhL5aUGA0xE1lcGqtHo
         azOveX9CReqnyx2bWb91xQBMDPGlZ25o2ouad//XhO2SWxlOiHkQPRMZ05Sm0R/2kImI
         u0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656398; x=1785261198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzwAEWZPIA1FZVtXGE52YOqaQITtBkKsTklSarGPm2Y=;
        b=ZJpwKRNcI7OdzXB4+CbqR2hg4A18Hw8kB5bMGsoC6u6TAijq4YHr2x3+Tgh6k1tRJf
         oKNO08GiyFEA4O5STf+/Jsc9MeEvS3Z9evF4wEWWob0/c4LZSxgyMKf1vgQEQxKPrAAn
         gHxtK+n7n/xF8MJHfKVJbQfMN1q1NSdENbfxhBSUxetLF4IB0cV6x8ynj4M4glUigQ7V
         4AE60WavvA6GTOC48pJCDej1YuvybhYX87tq2VEOHypF7ET8p+MEhKL5ydQR49GyYL4l
         xPgjHBo+C+E69oeD34uuBzTVE6bSt5LCCeuyCemBtOBQP2/t1F4qMxJwRJTHkCL2rtFs
         Akmg==
X-Gm-Message-State: AOJu0YxBvF5V9EMhHQkCd2QN+2luVPJrXZRpLCYiUpC0gow+0p5GsktQ
	KbPzctyD8XgVq3hfzxyuk/F/OxlbS9j97/NbnuS1nk6mwugLt6uy3Hgh3H7YDw==
X-Gm-Gg: AfdE7cmFte6chvAkOxW31n6CoCRUM40mD/DgBLd+irg0bPRO81ukJtIaylIn6x2RBwo
	RjGCMGn+3v8a4EmBKvWJ+nSh3I2LHteXp9jw0xMnTUubOjT4FVp5cK3pWoF7l2N7DB8EK5/fJKG
	mRNVGJ/EQna/w2kfaaypa2CuFF6rRetTR+Scc5GBDdClWUaW/FThW3GSzki32Jg1BTqrFrcJ3f6
	Jbt8F+NBKn0R76JOkRQdw514sK2UQu0IqXFSEFVu6s+/g+ErQ8gx2dzEgeJM6ne2nFDnyvsrGlN
	rmH5JjBlI8JGrEUHXEanOeTlLRtc4ZFTD3tWydyUMi0Unv4e5dWQ3+ZeaxH3bUlO+0fagc8xjl0
	LMRo3Zfv+0EUbo/pl8Cmx5Rpq3L72sEugR4e7LiCfoQg+d3QlX6k6gxeX0qD8s7zyG8Sw0Vv1Lv
	spj6T+wOgZLAGsH70wpr5uu4nEsOfhc10jgvmUHtrnHTvUTkbs2HjvINi5Afk2GhS0GDeJuieU9
	KjxASR49eO/Pnvh
X-Received: by 2002:a05:620a:c43:b0:92e:650f:c392 with SMTP id af79cd13be357-930f2d6a6ffmr89288185a.17.1784656397676;
        Tue, 21 Jul 2026 10:53:17 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542d1e5sm1192367485a.23.2026.07.21.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:53:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: increase context length limit in secolor.conf
Date: Tue, 21 Jul 2026 13:53:02 -0400
Message-ID: <20260721175303.61692-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 255 character limit on context strings in secolor.conf causes
mcstrans color translations to fail for legitimate contexts.

Fixes: https://github.com/SELinuxProject/selinux/issues/333
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcscolor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index fd8a248b..e4a0db74 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -225,7 +225,7 @@ static int add_mnemonic(const char *name, uint32_t color)
    May modify the data pointed to by the buffer parameter */
 static int process_color(char *buffer, int line)
 {
-	char rule[10], pat[256], f[256], b[256];
+	char rule[10], pat[4096], f[256], b[256];
 	uint32_t i, fg, bg;
 	int ret;
 
@@ -234,7 +234,7 @@ static int process_color(char *buffer, int line)
 	if (buffer[0] == '#' || buffer[0] == '\0')
 		return 0;
 
-	ret = sscanf(buffer, "%8s %255s = %255s %255s", rule, pat, f, b);
+	ret = sscanf(buffer, "%8s %4095s = %255s %255s", rule, pat, f, b);
 	if (ret == 4) {
 		if (find_mnemonic(f, &fg) == 0 && find_mnemonic(b, &bg) == 0)
 			for (i = 0; i < N_COLOR; i++)
-- 
2.55.0

