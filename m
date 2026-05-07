Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A600378D77
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170696; cv=none; b=gxduNXFUaqr65dHA3UFC9LXz2zWJ6FJsPyjcbsbZObo3EFjhtpOwQWBHQN4RxvnTaAyiJ4fiZS52AU+O/0cNbcE5AqlEqtXx5z7UdbMtJbyN1vbaG2bUZ6x++dAT2Ioe1QJGoXa9QJCgkstGXXRlxeQdwXe7vlP7rMg3Tpn4JQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170696; c=relaxed/simple;
	bh=s27z7TLLi8wWvja4zWzC3wg9X0ip5MHYd0J3kAmJpX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jV9s23Xg7oRsBjaSMPC+4gRiNcBaq28XsZ8iI75hrRr0LcY82hBycYzDb8VsNHeMaOWYtZyTaDLqejzZQv7XDsBfR+lHL1RGgQO8a+WFn2Q9JGEyPoTdSJYWy7B38wus7/kXNAf/YKKtJgAlATEp8Watn8D6rJs/JpFp4sd+K8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmG3ISII; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmG3ISII"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b7105dfb35so10310006d6.3
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170694; x=1778775494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EqFu5ktYK3L46sGn6giVtaRcRZrltSkXtrNhZFCdJc=;
        b=SmG3ISIIBepoZOfMuzGrl0RovmzJIdEJP4pKPFCHJJ6jlMOprRJjQSy/Jx4nB9xoJW
         /fOOUhKc/g0exgGnC+wM+vc64rymzfD5YviJY8uTfbCmYNoji46jSVuaLruHqwXLN4Di
         NP3zAe7vL1+Qx076AmnTQSZTEwXVdBBgYS7YudToohm6DBFhxFI1akX0AVYcXiCayvll
         6xcXywgF7e5TFXkY4wrLDXvBS2zxTZ/QqdkHfpsLc/96M57A3gCy2s/z3ChQw6pcx0u2
         EryMrgs23EDXqS4qiRlumYf1+z4b5/DEylAmIhXlMcLw6J+ztGBaFCcSZTEsA6Nk9TUC
         APQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170694; x=1778775494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EqFu5ktYK3L46sGn6giVtaRcRZrltSkXtrNhZFCdJc=;
        b=WnaEN50cCzWWCH+4ZITKXxS3zvK15etWs4LeWGThnw3wvCiNcoi73BSnV4vvhO1S+r
         /J14sWZoN5cMmTK5+AF7UsqQMFGzcq6ja7ZJgyuEMgvuQl7Ebo+nUAoWPwfz8FGk+SIN
         PQ3XLCt2uJnIuRiMifP07S+yDcBK56FLfcLaz9OIk/kqw1ptLTeyqornfxK5AHuBItmX
         vzHOHYaVfBYHxXDeNUgLyfxpwW81m1tnu9LkNPvgfp49jI0KIKqXSTwmjkbU+VIVrrwL
         ZiN01MtGmo8UYTadKCFLsT71WfmBopZQbhjWjSaBtiTN3Jj0HOO8CNk09ZPoWZbQXZmE
         gwgg==
X-Gm-Message-State: AOJu0YxRa8fL4IIoS1NvbsLpgTbSmNGQ252Z+nYD3sBlwrQXVMP65kFr
	YBznIdYHdUMxp4MhS5YPG5oOQCxlbYlSbnl1B9glY3H2KbqW+VmLAnrB3xL7tw==
X-Gm-Gg: AeBDiesaUidkFn765M7H85fSZ8jBJTKFC8sjbtEfYXzHLlMTvhqpT/HmPV1P2Nw6U/y
	25zuTpuahFcps5fsRwH9ZKd3lhCJmlYd+zqx5vDu9q+VL+ZHlECN3N0HZcMZUi2/SRX4/yWPWcs
	BnPJNmxRYup0n483v5TeenHscQ8iqB+4FNUrTzR52Npl6IJ/UqJctTIDuRRttHGIJiTBlqFiU18
	J3VijrnicPYN8Hz7bcq9DpqXZAycvYnkXiVgBdboT//+c48LyJA6IFddsDpg8qzBrWKwpoN0T8b
	Fib/lIQ7iEUkHLR9GLDnBAb35qUg8BlaIl4h1Tr2/UQ8qCtWK/yrr7iXaEPH/fXBbTp/R9R/l+Z
	mRIHkh/oWYSb9Au4L3cbRNxSHh3A+7CqN6kmXe6gx7CuHQSM2HGpO8eJs+XqHRlmEt5QxtbwJ0s
	o+mQWFcN1YLZc2ivUZHPeeJDGlRCRJ2QtX9IbMX0vThK3JkrckCD2LWR8hoS+1R+lpagvFbOBV1
	DG6lFTaORWvVKMjgA7r4nixLGnVwlkv1DTHueWvs7X2WaChakrUKgs=
X-Received: by 2002:a05:6214:5508:b0:8a2:d93c:993a with SMTP id 6a1803df08f44-8bc41cc2e8dmr122961666d6.3.1778170693908;
        Thu, 07 May 2026 09:18:13 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm207160226d6.22.2026.05.07.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:18:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] selinux: tighten type validation during policy load
Date: Thu,  7 May 2026 12:16:34 -0400
Message-ID: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten type validation during policy load to improve robustness in
the face of ill-formed policies.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 removes a spurious empty line leftover from one of the changes
dropped due to Christian's patches and adds the word "type" to the
error message for clarity.

 security/selinux/ss/policydb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ead504a639e3..ba1c9bd9e29f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -604,10 +604,15 @@ static int type_index(void *key, void *datum, void *datap)
 	typdatum = datum;
 	p = datap;
 
+	if (!typdatum->value || typdatum->value > p->p_types.nprim ||
+		typdatum->bounds > p->p_types.nprim) {
+		pr_err("SELinux: type %s had value %u bounds %u nprim %u\n",
+			(char *)key, typdatum->value, typdatum->bounds,
+			p->p_types.nprim);
+		return -EINVAL;
+	}
+
 	if (typdatum->primary) {
-		if (!typdatum->value || typdatum->value > p->p_types.nprim ||
-		    typdatum->bounds > p->p_types.nprim)
-			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
 		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}
-- 
2.54.0

