Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128128312D
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212055; cv=none; b=WoOUXUVfwsY1msYC4Gy8DHfyxxVALl9nNoFSBB7czZsLFmwEZVadkd4X3orUKIi5A7va94Oc6vaKVvO0cYPsT6+ArSkwIQt6dj2sT/91xYGiLBXfLosx6orkTJJ3nOSIT3UnGqrCxZ/VvjmkPFU7MhEYf5v2OKBe/HaLFqOlcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212055; c=relaxed/simple;
	bh=HcP04SMFbVFcZeo1LIby4c5Gx9qgLTDtutAsKf7cnww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcVI2xKC7Fh9sK6YRq2TpoT1pja1QwjtXgCi2qoxMs/crJEtjpNpU+072rjBW+qWRRO9CC57PhI4mKqcRJ61oLeRw9iBjeHHkVoKEMnE33caZqD0KQMMoxAQM0aJ3RFwjA7elkd6wzVbQSGVUvZr6htpHwZOZfI8+QmNd5KYyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YN6w1MKB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YN6w1MKB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87031ce70so92081685a.0
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212052; x=1755816852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDmLgStpb/pmVfUhEjdkJINl6RWsSwg9MiBkFxMsmmE=;
        b=YN6w1MKBYgOxeXCHzA+MCjTmsFU0auN60xFRpPQpMNFic9iGA70MUZII59UMXgVRd3
         f2wltZ3c++jHD24LA5I1xVFgtZG/6Ky9jXUY6knkpwVmeHDgORqBEysSoiKlmCYxoLwO
         XppfUF9WnNCMFGG13yvWIYM0AiQI962H1k//1uwEneOlCpjIwS/+b4cNblv71cubQKH3
         oHZBS5tDsJnJe3d+EWl3zzBmmZD6MPh9ABi/YnEJaU3voCQeTkmKvPXQJR65PeetBUA1
         CDrgvr1MSwPbuJr5LMOO9YPPZrnOc+KYuwk8go/Vn9izeRT1+m0WhXtGGkQDXhR0KZ4P
         xRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212052; x=1755816852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDmLgStpb/pmVfUhEjdkJINl6RWsSwg9MiBkFxMsmmE=;
        b=mdmGacZrs9DfSoSmSdZuSzETRY0q5N9DEYW2raS5FXmeJ3AkKF9+TPtb9RiXxspGrF
         jJ8oWUdM7W1vyxsxounMUHEX3znAsvowLGFUZPakebRtc4p6a9RHLTGIah4Iuy08JMYO
         dvDiat8RfutCezRNYMDs82qYoCmMiH9UzMsmlwwZiVnA/AHcKVCt8DpLuto0p5dqw5Si
         pQTHIFkNGabWIrOA7w82bk2/ZkNagtAS7bsR4MwznqPdKUsHqokrcCeQ/KkTUPUcveUP
         GizOkYTcFv06fLH3OcSwQR/JHi/zEL7DKdI20HqDu6VqwBtz487QQo6eVGYw2PlPHX9G
         GcSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IpfHU2cRQTnvtN4P6NSapGmmFzNm6MFqhr5G/F42zJihtAboYgBY2eyVSEsCDJ8ZwzhkXKl1@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbWqFIecFPI2tablIO+lewgsgeDExeL6kSq5Dvg3UZexIucyw
	aBbOtX7OTcG+TTuGwEkld1kTaaYg+1+/Vh0vaAD6Vu7qfpH0FWONcizayGw0yW3DjA==
X-Gm-Gg: ASbGncuW2Xe/re3IJ3RDVHEvCc9nzjnhbkRGP0FtN3ITy4S/Wd79HT/cr2uvCSQonAp
	TPPva8PcPVBD5ogDG+DAPEwhulgzs/v7dU+9AFG4QdrDOz4Qn8HRXkHPVMsBkqzaztQPdcRpnVf
	oxEicZ4WOGEuu3s+Rtb4tZU+kkj41VdywneFkN+etRxHAH1S68tOjbEdhE4PNQ3vWFwvp0xYzvR
	YRp0EFGSrh8xksDt9pl9cWl2GfQo1YhtcPfYUKIi3mWSxOBruqLKvqtmVlQvDVQohCQH5i1b+RB
	3TNij7049mNAvPhh+40S5x+xPFeBR2JMXrf3YTSFyTp64gbpE8rN7E1reDZZNAVEqr3fSW7MuEV
	hDZNoq0O7f0dD+fSCDmwqiVzGK3sIPY15llFBW16ok1I12rxViDjXYfIuom/8kmsH0hKxiIDA7K
	kFmw==
X-Google-Smtp-Source: AGHT+IGy2TO9GI4e7U3eFLl8Xu1xzTJLMGkwNu8HPeAIs1wMWf95+6Ts+pCofbt8OK2Z4dbdR4GmcQ==
X-Received: by 2002:a05:620a:29d3:b0:7e3:47e6:a842 with SMTP id af79cd13be357-7e87de3352emr2986085a.0.1755212052609;
        Thu, 14 Aug 2025 15:54:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f3617sm42059485a.70.2025.08.14.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:11 -0700 (PDT)
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
Subject: [PATCH v3 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Thu, 14 Aug 2025 18:50:15 -0400
Message-ID: <20250814225159.275901-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=paul@paul-moore.com; h=from:subject; bh=HcP04SMFbVFcZeo1LIby4c5Gx9qgLTDtutAsKf7cnww=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmif1nk1eemSdX07BVZUjbkwk1C/BXASD1Q6+ 5kfySjShuuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5onwAKCRDqIPLalzeJ c6J2D/9TvLrbirLRtN2CsLP8BOd7NULkuetfhL3S+1tspee1aJzyhYdFO5sPKS6wzwfkektief4 B5drcUqybyQt6M5p8jIa1OmzzbxSWLJK+a8nwdHkVI2W3KcByDbeehUyxpJinWouOZjH0xyTceR o11DPiQ6pvMFwLVEcex1rN4kwY0+dBmQKB1neGAOzPnIAeNj/1UyKLMr1jooiSxA37/ojFttZQf fM8/cbEe3nlg5nEY5RU0sOZ0FtVMelL34DwkfYRf4ONaHYzpvCtY0ZqMsgthLd5fpj6u4NzbW1o kzRlB7v/oreZMk5wdqxaGeqkmh3MbHOatOY7rkfclCIFqA8sorIZNyMr6F/DYfLjFH8NVSDnMx4 LLKttkih4Yqhvm5FESfxI+HgfghgkGRl9m2B+yHJ8QzqE4v3akO95WSmalypT2vWBsi8CqJsCh6 Tc8n5rkl1dweOcqcVhDC3as+YRRv8v2RUa+XliZWIupbmy1sl65BX5F5zY9ma+BJdEFuvgb2gbB wwuhVKYvgRZKiKyCKDg2zzhkaNllNzkvv6tn5zioIoPQcocWldEK3/B5Mw5NEEN90+FKwGzi3T2 FbzEkMk0Pk3zznujeu/FvVPJhVj4B3pDJz/QbMeW54ff/PQDsZRP5w7Kn+x4fHAQOmXe3NNgvtW /7wb1N+RbW29pcQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 09afa7ad719e..a8b82329c76a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,34 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 static void __init ordered_lsm_init(void)
 {
 	unsigned int first = 0;
@@ -382,8 +354,11 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
 	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
 	}
-- 
2.50.1

