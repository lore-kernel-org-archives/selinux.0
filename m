Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA62475F2
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140274; cv=none; b=XtSthMcYSw3FPOrWuTq4/BViXy9N+hbuQ8LAoX67PokN1n/BoswUJPX+j1ktadV6mQjwRmdR48/pZ292UyvBVrPSVldvXHLZTziOZHdY4gXGU6Bm6G4YDekz2/FHkqqEDDOhnbaB4dtUtGUqWmCQuSM1XYysiVxmU1lkD3hti6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140274; c=relaxed/simple;
	bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMBL9XNy1smyGSbbdojlf3AXOkuPMOHv+8ozVZXGsHxz6gYFQ8f/fpXMVhs5AVgMFBSv+N47ypZ72gr+HvvWBO39mkgcVo/ArIriTIKTfaEuUZN9ckJhKt3z3puJzsUKTF2OW4LgfdYkqp3lga1wQwc1d699QBbmQDpjOHP/u+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBzCQrjU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBzCQrjU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e346ab53d8so436439585a.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140272; x=1753745072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=CBzCQrjUfV4R8fFYnokVkLgmzsFVP8Gg17oYQ29VLVoAtQlGemi1aOEIJ05eDsPSNN
         +Hakb8SVfIL8l73OA7So8wpyLjqMibcs2nV567iz5HFn+tGTJLlZ00w0vbmTDkoqBwtG
         Aby96dwIEZyCjFsazDD1KpU82BfM4ofQJ4bL9H57UEil0l7UlzMS2NpuoPjNQS7XoRTh
         6OKutoI5/I6czFZWiJZMZzNxhwLbEnx2b7WYRko7B0OicKiLnPa9OzKctECFqbdE7fcb
         5FE1sbFZFTWBPo+5pBIwf3wnu6lD/q0Tsy6WoP6UEQ1ZsKH3MMwhJBqhb06Q/pX7Xudm
         KzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140272; x=1753745072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=hbXeUKNU5TaFrB2OxHKdxR08cJOun4BrxYKcKoijlq/x1JM7CJ0Kzf1b2iK9slujyy
         eVYjcG4QVM8ICS49xKcrpPy5QkuhEGZJ2E877kC4pulCndf677TmAdMVKb4eeTJ/O2sb
         Uo2318x/R+vIIoO49rYH+y+NO6MCRXcOgaEw7PsXzc4wJSW3w8Dn76Q1N+gN78uLvlS9
         U9+K8V8SYv+d25XWI1yevtx/z73ZT6v7kQyHjIOjGGvU2m6WCQYSO1V8E5i2ahauj1fS
         2svbrjVzxYQeOaDXt9zr+AmmUU66fWaCrVlaUaE4yHuiRFlyppRw3SAK9u5i8+0LfVbr
         0gXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWj9Z22hpLDECvt2REMv0Xb4ZdKbGecwG9V79uQ3L/YGWFZBkCqg3OUJFtGjy1Zwpzb1lzmOr0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvl1VlxA+15JAYcqiTDOsjXpOSyPCI/3a7a+MZzZwzjAEv+v/8
	3ANIov0t2bRKyMa4rZ+ERRXXVo/f+lDVpamkj/h8+VgW8cEwgYSKUSJ+dYqhPWrO9w==
X-Gm-Gg: ASbGncvQYuM6xmzLc1h+iepZjBvbINtzxrRdvlP9mrTR2Y0OUgreg+vpH/d4wQfb15I
	5j1SwEGQtxYrIOpTFRp4un5t4oZZYu5GeB/nsfzGzv9UCUC/E048vWErWhRuGStfW18EIu7ZVUG
	7xORhA7ktCahiFr3YKDGWMV97TQXzJs78uE/TnkUgLLvWbrWGai0Q04BFz5xmEUrACF9L9LHbRJ
	3PbIS3iSBDuvr5BMK1FpUYVIaYi1kCiopbkdT/8ITCnSlyU5YCtTMCzEnExYTJHNASIwxWy3CJf
	83Vy/rs4sawdgxEm3RUfApySYzw24zcp3rHKgCZZlUGXExLui0WPzgrFFBBrgBB9QyE7qJ3s6ay
	aLmaWfBop+qk7GFfY5VCsyoQImi3ZB4trm+9MJQ4Q7XxEb2ikOEcf9Q/yD+OMzOhbNIs=
X-Google-Smtp-Source: AGHT+IFkxGCxtcFnWVigtUFhdyx2aVzIyfYem/1oEuP3/Zm9qp6xaLQfWlhY3zSnEccPCMBAk1ecng==
X-Received: by 2002:a05:620a:12c6:b0:7d3:c4c7:75d6 with SMTP id af79cd13be357-7e34d9d33dbmr2054160585a.47.1753140272445;
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b92394fsm44367576d6.51.2025.07.21.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
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
Subject: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:33 -0400
Message-ID: <20250721232142.77224-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=paul@paul-moore.com; h=from:subject; bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvy3UEZdfYgB23vwGfEkd84LDlsFR4wF6KP+ yniXnVb3q2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L8gAKCRDqIPLalzeJ c+btEACauTWNp5Gu8YrkRQgdA4davHACFivPcXvrQ0Il6ENbXpajLH2TWVTaUlQU3YZhIJyT23v cRM868Poy+cb7oob11+8scn9nuO92G3E2YdladXyFnt0c0QUG6PlU4f2H6lm2VR8Ti+d+AJYCtz zrIVH8io5PiTjgy4qxyDJOUafdDbJODKMJvAY/wKcGARa8yGXH1KZmrpnHMDz1kGj3A1uhaIOnz ggR0W0+fFO/dGkrRgAm2FctkVHlGBXNxJCWEbgPevx8gxx7QUZYZFUOSU8wywc++Dtodq8J3rmW e8piOK9TgjyFcJgWnGms3TP3YacJ2LOYJhsH4KtjQLFgLPmYUaE2GtFZNvi5Pj4aDjC6CNM0d59 ihkl3WL88A3fDwtlJdJH28MLimjtz0NLTJrpuTUI6FypLQapA5U8P9fKV+JgwOGsaw+3XsRRI6u xaJiVpBfGAV7dhw6aibup9vYOG0yRVAE6/G9sMiGvVm0gp/uGup5muMix6FwmrWcMK3oQSkHQkF ZizYDYcJDr7rbDXgvUcHV6FzVOz1RNrwxn5HyJ0IBgsLYWGelAdYq0J6m8XrU3LYlu3RT5Jc7zp MjnoSIzrKUqklG6PCsA0vaitp64IbcxUY+AB/uoghzqnRdyOpzLW9rsNgey3cffgxwpYecYLt3p 9J5j0FwPnbh9EFA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.50.1

