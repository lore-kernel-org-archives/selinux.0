Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A8283680
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212090; cv=none; b=CriFBNaIcgivTFEQbUmlM8AP/F7hv/L5TZc8zAg8lVzUe3EJBLP7WosKSRUZgc2OKrAEJyJoJgGtq/ly49Orw3wEey6kHW6hxFHw3eHApepQXtqLIe/p9otKDWu1WhrgCwH5ZDDxduBC6OpV6Q9Xww1redfyG9/LQSQcUBqxxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212090; c=relaxed/simple;
	bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWH49wP54bQUDKDXfNvBfrqcWls3IYIGUjszfW/Oxj409SAz6Jn8Ow4uesdNl1Va3KLXZLrV+BcAUAA8j48L/Q+vpyNqEpt5V/afTPnCaP9dQ0B1NO9O77sYBUWrINhmMDQ2IczxQEso6eovKB0xsjbHBI9XorWhzMWuVf4Dkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LjKuAAuN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LjKuAAuN"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8704c52b3so168195985a.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212088; x=1755816888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=LjKuAAuNLXi2cx9BG6eQKGcdRYsdo5ntNxL3/X2sWZ2gYekKEfvflLgadrgf5m95/E
         xKmGRu5xO9TZnXIEdLckWbMwWpB3YVAWaNEGiF+7jeHTDvvNPt1xJsou8b+RuRuGPKNt
         KCvoGvn9Ks5sRp7U8DPx88P59bUqf6hq1jkKDzZwoG1pPHOzHeQ5q6FDiGMaFOgjNZUH
         QZVAiGX4VxXapLtNjH/2yDbexibfZatHtL/kJIsqGjlL7AgLNa3w73ped2pRdUE0riIR
         fXnvIR/z37dNrVkd3hVo5fVgLAJVZgXQ07jp/keM59qsXlzdJTrQjc8oVt7mlDZ3z1Zu
         KsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212088; x=1755816888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8Sty0Yvm47AQW1EJnnfuH7Z9BMi8jqNRxSa5V1vvEM=;
        b=tFeZvOx7S4GwxA4JowEGNxP6BNTy7nEX8J+BywaoHTEpymlLSKxa8BX98c3+h8N0Ne
         Pw3D0GH7QrSU38WIBz8prz4+7L3tv+Bc+q5AgbYhu2S7nQQTXqY9e6AOVCF9CUAiajZF
         gRRKx3FaD+ZJWutsDLKoE6UQ8c2VPYPaxa1FnCCnSjqMsDNVk/TycIPXODz/svJqVEdR
         ffxXN+iTCZ31fJOnCN3aNUcVKrhVXoTwEmrUgZzlpzLn0tVR89IGpjJBiELzCs9LFJyn
         MtZAazVgnJzyOa917bxxTkg4+W85zcgzIFNgpTAx+wWo3sAdoL8ctxIcLkaQseTh8Eeg
         qvRA==
X-Forwarded-Encrypted: i=1; AJvYcCVDGBYDL9IJeM18GIoJfuJtPc9pFiWQAuN0MMGiycT0T/Vjfd+epu8uosK+hRMGfLA7T40Tw2Z8@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJ0rCn+WhgsGrh1eifC81ZxR9s5Q/FP+e1D4LN9gL66CwE6zE
	gwAcl3F1fwvjf+wdAf8JhnM9hrlYpiTK5t8+plL5XDR1pO/1OPtf+l2hlgyVheAUmg==
X-Gm-Gg: ASbGncttRj9tq79SJlxACtK9xGcbPrSkVUbyQ9vPmifOXBlcicBil3XXpQAikjMFW6x
	K/9UXyS9FaqEY+mmgD/hI9mGQSKldVKtMhZ5C4OroR7nRCG9FW+hVKwNwTptBshlg2NrJVNEoFr
	b3u1Wr2+29jls7PzAKHaSrNfwQnMgh6Oabs3NcS+VuMCAkKDZbpo1JBHXlmWRJv3Bgi9Qi64khC
	R1yUa+amX+nGWqI5NH8S7JEPVSD+bWYGX8w6a1bF1B7dEobSYBONJlhLrhtOHsGq1Q5WiBUa2A5
	F0nvp8j2F9Lu11FE1yb0ituNaKt8ULWezOp2til42GWYSugJ/sM54QIXg68AblXOA6s9RqW/o1q
	R0cKvQ3r8EjYob80OL/7OXLj4xkz7gcj8IVx8hc4mme4r+Rx/hesAJqNNcNAe/nwNgvo=
X-Google-Smtp-Source: AGHT+IGSzCA4niDL5HKKrPwnrGhczyjx/dooZOY3+mDB7/K7P5zLC5V9w2OwiPP+/HGGzK9AYJIUJw==
X-Received: by 2002:a05:620a:2991:b0:7e7:f84c:9d6a with SMTP id af79cd13be357-7e870593f83mr593401685a.32.1755212087906;
        Thu, 14 Aug 2025 15:54:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b37e39bsm43835485a.35.2025.08.14.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:46 -0700 (PDT)
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
Subject: [PATCH v3 24/34] loadpin: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:33 -0400
Message-ID: <20250814225159.275901-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=paul@paul-moore.com; h=from:subject; bh=rWEpVkUy2dqvcxYudz5qcZe6+gmqE6zjJ4LDoy/uBwo=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjaw9cl5BakIq0sgYNW3sKStdr6PBZN5MsfO tor3qOK3D6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o2gAKCRDqIPLalzeJ c331EACjhS0/W2llSBfoXRy+Dgr3gzzsfv5yar/ke/CShkqSuLcVYjqh3Jv1TTCQHmIR67UzrAX C4LbSCYMW06dyqKgfZ2XsakItXmfGcF68RS8qYsZJzgBSWPSQjvbups6hA49t5WvxQyB38NwMvd Eee/FiLcYPvCgW/cd9Svr31YN4ch91whtytc+/jTJBvVmast1x/CdCJC0lsYrR1GXFO765xaF8f VclYnYruHhVevyNXkP3VBQe561c7C/AnlByy4E43GqPv41sfCae/zovZnG74BvLQ6EuikWh4sI4 VD8JL+efegT8PITxwh9wjEkbzUz7atbeDnC/s2IcUFr1/wqcN6d9T53eKvm2UruXurW1cAN/+QM oCRL6+Vrd6yPmQRljHe1U330mlMifhufCaA070Rwm7tTZBG/vtfp7qNhVHQg8ljNboC383X4uGL xjUCnDSbEk3vp48HgVmiQWyAqyR8S5X/2MdmLsc/6ghCaePyol0+sUmuDgUsuDSBPIS+L14NQpc yC58Oa9Dx23cQqm9nahD7rXLBOYwUxAGZ85ud6TUacrVZTlp4yVYKobsWfjOvungEvKMV8Jqac0 Ew7WrYTaZ/NrYv2ldxNjDO7eZvq7EkY9AAOn9800i/6R1dUZvQV6Nv33+rh1GbTZ7rffgdBUzmN Ql+qJ3nqVG38J1g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.50.1

