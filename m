Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBF3D1CA2
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289279; cv=none; b=sTM5DhwbMpb5GSSbTmSewgtFgzHSsbKVm2OpPqZqlsw7U7sTDxEg7g3rT+63JPgowVAFq6W//y5xMTEJQdKKZ9n/H3Fzmpao2UHelOMa4r+8WEKFQRILi74C1hHwGOasBuJrkoSXI6Q2VKdXOZiJ65oPOEQycqIsmWLOGSO69Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289279; c=relaxed/simple;
	bh=e6QSChStcZFzCV03ags1SB1CkD3OZNGzPiQXcprMGC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K+7UeUDdR08kxvlL2BF8qljv69rGfvEsqMouu4vLVdg4Kp9cA1/iM2qWvH+roXA02Xulf2Uech2jl/AoyD9rdeR2Y5EMaZt1vYpIxN1z/iOxcqGY5F3mz5RbcqO2GkvezPl+sQmp43GAmNeNOJa3bsfMUnzkLvB6VDicUW2fQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIHNeRP1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIHNeRP1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bc7b311e77so21623255ad.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779289276; x=1779894076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSMyYinNfzIn455REuPYPM5Y2syByf1Si+RTLPxcmKM=;
        b=NIHNeRP1ZfaTL9PGxrCGx0yMLcHope1JVN4/dhLR+ge/8f+2vfUSd4AzMjuJC+immZ
         pcMJmxmpTT8fkfz0ufr/yf1w1MtPS8Xvmx6TWy2fzHNfzT1aQdLwxL3lHfgkPfl6zl4u
         AWf1c7qZSEcK1clSPve9480cgOILEOfXXfyFVUOxWwU22Te5CVXpaRTvMmCArqjCdCSZ
         2xRpaXAB+2ZYKg0u5HvgacbBOvG/zNKHl4Kus6MWJK4EroZmx4AmbggJni1HF67DzY9k
         X7gTlD+Zq3crTYHkDDNHOpyZCUZij9L03BmADXwiASzhzFtbtSYxsRVixsPDBFK374xX
         iDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289276; x=1779894076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSMyYinNfzIn455REuPYPM5Y2syByf1Si+RTLPxcmKM=;
        b=XvHfko6FpLsFuUl4vXxx9Zrb5rI7pwiGPB4QyAcMV2yEEMpoyajyW99WXHNZKupR5u
         EIbDCm1PENaZchlGr2KrPWslJAkc50ytU7+4di1WdB9t8jlqwSdimkEpbqcEO72bknNX
         3heNKjr3N3KXaEMO+Ks1+0q0utsrsz4I4IEJ3wG0sCFpNW+Pc3rMgGBzT13lXSAqmd62
         8xOEhNoLpEbjwmRLCd01MeSbb3XJjhbsOhVElllSOJnx4cm7RSivTFBQrA979U1uCCsn
         sNFm9YWzW5eLbBY6NIu1XbcwXPVi0MkfAeE9AGpBuzP7Oh6eteIho83TecnT3zfd+hrp
         KKQw==
X-Forwarded-Encrypted: i=1; AFNElJ96x9rnchxBtI3ymgVqPGnZsQaxSK0SeFHC+oHcsrJuFasYi36kcxejDbyQ3fTvM3KmAjvtYyKq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PDXfyHKMdkf4L/cdI1cfcNhn0eLQPWOoOS0luShZkKlzmVj3
	c0fIey3zzXpQNOLk/SiuErAy8VgS2pOrdseIUm5eBz19/hu632noWG2P
X-Gm-Gg: Acq92OGFoc0rg3S5NHeACD8hUmer4c76nRtKjCEeUoSbBh501p5oCnJeRBvtQ10EHsZ
	+v2t1v32/HvC+oEJVEgnhKdjUF1DdOgESCqBmTegO3kf05m9tno4kTB7wVld/yKf5vgGihfVzkd
	ZCaFNiYQUVe421fpqxInXhrgvvpD+Cnt96ygL7/pXIA4niAmTK40Uo08qDc02lzwH61kpm8wrwt
	d1xlsb4+pl/YEPoJBI2JfN+SmAGx7Xt9kfe0w0m3FvCBH5cj8z6zXdYH73sl5vsFUDgjXQAnxSl
	ssAZOpYojytYRJZZu9fMWZLhgNZV5yFa+IuWEj20Rqp+xpjyoOwG9rQQFvPL4UxMg5RnWSax1As
	q2NU8ba7kIlaX/uif8zIQAplI6d+98n8eOJLAsb74YWVppQuQkIzsCzRxJMPFvou9y7AA9HSOYP
	KF9kwoFifXuG+If03q4pdORGg=
X-Received: by 2002:a17:903:2f4e:b0:2bc:977b:846d with SMTP id d9443c01a7336-2bd7e826aa4mr209194255ad.5.1779289275862;
        Wed, 20 May 2026 08:01:15 -0700 (PDT)
Received: from ubuntu2204.. ([171.213.253.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fd279sm223536775ad.62.2026.05.20.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:01:05 -0700 (PDT)
From: liem <liem16213@gmail.com>
To: keescook@chromium.org,
	anton@enomsg.org,
	ccross@android.com,
	tony.luck@intel.com
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	2541289564@qq.com,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: enable genfscon labeling for securityfs
Date: Wed, 20 May 2026 23:00:54 +0800
Message-Id: <20260520150054.27994-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Add support for genfscon per-file labeling of securityfs files.
This allows for separate labels and thereby access control for
different files. For example a genfscon statement

    genfscon securityfs /integrity/ima/policy \
	system_u:object_r:ima_policy_t:s0

will set a private label to the IMA policy file and thus allow to
control the ability to set the IMA policy. Setting labels directly
with setxattr(2), e.g. by chcon(1) or setfiles(8), is still not
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: line width fixes in the commit description]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 8a764ef1bd43fb2bb4ff3290746e5c820a3a9716)
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 69143a216a3c..1c0f8209f130 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
-	    !strcmp(sb->s_type->name, "pstore"))
+	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
-- 
2.34.1

