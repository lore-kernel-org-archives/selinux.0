Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E0246786
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140262; cv=none; b=Y7SOeSwhkADZe/dXV89hRgAeJfLwaL09D63ARaFJ+rPs9Vgsun6gCXELZiKTvc8ad87XpdYhn6quKAOaAZHUn1hA0uflqGSBwgh3NoJbFfkPgrBRGdb6cQuCOfGndli6rl/POLgM0IbLVljae/C1QQuuQmmqbWTkHR7YBSv7zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140262; c=relaxed/simple;
	bh=fidhY7A2GG1L6WcBRW+xXRpj5fg56e27Zf53wY+JHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GONJV6rIE3PYcFQjE/2Ez0RmIXuk+0OYwaJDHH7pSGnSw1ZqP5+5vAbxiZihr1LHSmBMkr1Z/p3WNzI3U5ABtjCgAsYEziZGXDCvJb5hACR2Kv2EbAFBD2GxumkgvxKibuIhtUBHFs7buWvNv0HNarl3sCqejw3QLYFbZhdme1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NQmR0R4d; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NQmR0R4d"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-701046cfeefso77124356d6.2
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140260; x=1753745060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRnwbk9lPTHMa8PngQqUNoOqehgPrJsVsru9KsQBvfY=;
        b=NQmR0R4dlOg5GounD19mizyA5W9iSmBiIL7a1P65XU078zessM46ZYIyhZMeA7Bk/Z
         OXni8iI6m5+/y8KcNCuwhusoQE15ukRvcRhnGBeMxJw/ycheke6Bqi5KZx58f6Ezh+l5
         2cLo/TgB2RIWxC5sQ1UyQ43w9gJmnlxasiS2W9NyWpCsQlP+QDPQLnz77W8FsyrgetGk
         l4v+Ufh/TZAn7ij6Jjf9NEIoC4GptmJ9sob8U5JLDuK9xgnvCFk2DJsLfOlDZAHSmuMK
         3VeBCf99Fk5z3B/bMZSpuExzp7BJbJE/RQR9qBmFgF3BsFWKCIm1/aMEk7cKXPF6/fMG
         GnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140260; x=1753745060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRnwbk9lPTHMa8PngQqUNoOqehgPrJsVsru9KsQBvfY=;
        b=NHOr0IlE3wBdbtJnsphHO6267RHCRYylZPReV3cf8gPBDn0jECKv+Yk8qAeKI+l0QJ
         a7OFYyxGewwM4QaS5i5obPN4YEwoDS3ktp7/YLnm2ILgP8xRiZGFTITEPR/lXBRGlRaD
         dH+3f8x48Biv+mIFONd3MAZ0sH5riq3pNtUzzgIU1KE8jdqy67zD98usTlA9CItqpujX
         0Gl/0AhMIJSDkkBwfHJcskOubgaIh9I5sYYDPd6ZyTbh0aX97KIUs1W34oT7BILRbxiz
         sdYPTu8ATKEwK8PonVUYs6zp5CzakYM0GKmiRR0Rswafl0Q88pNnCHQh4x49GlSFnVsN
         IPwA==
X-Forwarded-Encrypted: i=1; AJvYcCV733SXTDavxiDUGlJWaAaevR+pFpUlppYItjuZ1U1VCGui81ZVDrb+4jV3zwtevgkd3qY/tD+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dJstevdR3OtDpI1M76g53xNvIzGHXmkbIGTeR62O3XdokSF3
	eokJ5+VxKvThUDmMpnHqP8koCBs8XFe4MatptiTTmQaIEWdLaIlVnOYTv91NnKGf4w==
X-Gm-Gg: ASbGncsMAIbJeGuKqspHXloaY8J4Lhd+Oc6Ob/dWwEwEmq/d62UbwD9o8zKHBIFM7h7
	JXFnTWIMWRfAQnTLU+Mccd2e1zuNxf5L/6mWADaoWjGB0PwIShWJnsjgvLtSvxIrLyp3JdxvHdE
	F7dr9AtsA2fRn4U4n/d/dvInkniCyvJcVYhObtxH/PVrAevNisDCUVSJU01V7sUBNVRPYr2qlQY
	pz/xnLRrJBN5KuXmMqiWPCsd9WN5l3ROT1rQkG+BB7RD+JlYugKNrTDif+ZwsNrHwpelgTdq0O0
	HYssJmdpba72BE5v+0jHiq4U0whWw3KDST4jriqC+001mbUq1VInLjNvB+WudREuvWq1b/dDgci
	NUD1TcnlC69DxIRj3eO6BEgl2EBpTmuft0oNEFp94e1/52aNYZqiWzdPdHp41xgmZi2A=
X-Google-Smtp-Source: AGHT+IH9IQfwEip3Zt047yAPVHjA/lrnVk3FQWqrGgPKNMqgrc26LMN3+kGJ1u2fLGhsg0sQ/DZCeg==
X-Received: by 2002:a05:6214:5192:b0:704:95c6:f5f1 with SMTP id 6a1803df08f44-7051a15125fmr247201716d6.34.1753140259780;
        Mon, 21 Jul 2025 16:24:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8e0512sm44672116d6.28.2025.07.21.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:19 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Mon, 21 Jul 2025 19:21:22 -0400
Message-ID: <20250721232142.77224-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=paul@paul-moore.com; h=from:subject; bh=fidhY7A2GG1L6WcBRW+xXRpj5fg56e27Zf53wY+JHrs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvMC6Rp97jlSGqqAJ6AS0uOBcwCHGxLqjYFC Bc+O4GX2LKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LzAAKCRDqIPLalzeJ c7p2D/9RZgxDXM6i/5ySB+QBfn/HFUQ8lIdd4Nk5wXEaH3tSiMh19UxYdWxTrjQdN8oJveX8TTq mwxWtnfb4Px2JLiT+aztBGyMrgMY7hOPgBuzPAj493fSjJbaWkx/rEBj4wqks3RCdq8+jOdt1Np y5RtePZoEWsZldo89U5sb4ewmGqcQq8LHE9yaEc/VrtWK4gcWx3nlF4Da5gqDrVydSSSfpcRje8 znByyGgb7ck2l0+hdK7K8xMd+OK48DbVFslvvXXb22n490SDG3nFUACOOc33mukabPBfcH6+sV2 nbl2yq9XDDufeuVWYJ14/1XU6tOR3oG2movSbXpJ61UwyUitkuBA2uVikt52z6r1v3RusaCeVNx u0ZcSJ2VRyuA5EDnL5o8QusNx411dxovDjadeH9nT2hY4G4YdkYVJBnNVS/KllMLR7+i4wxpBKW m95HBSSeq/ezu1WC0CgGHM+XobqVMr3dclBpWLIbM8VjBcspJscaQ/LpmbWFHmK7fJ9NkVkhP2L CLPyZknHnLe0JJfyahsGer2bI5fZxYgwe/Jc3vHpmTNfmaXyg+MY6pZzQ9ymqD1UCk2KfzRH5PJ 9Z6EH9cVU56xU8L6siFNe6/pBsHTEHzs4zgJTy3BjCCMFalF65Zi+lgN+K8gN5yrTjEBxRIzYeg Uyp8FD61XvK5ODQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 25fe0c89e884..75e97f6b530c 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -312,6 +312,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -332,12 +336,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 }
 
 /**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
+ * @hooks: LSM hooks to add
+ * @count: number of hooks to add
+ * @lsmid: identification information for the LSM
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Each LSM has to register its hooks with the LSM framework.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid)
@@ -350,6 +354,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.50.1

