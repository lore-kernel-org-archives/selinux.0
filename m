Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20412BE646
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060828; cv=none; b=GxzcJAiQwKet5vgjsvizwGA9cICPavKsm0z7ySupe71R0ZA66AFL+W7FPCIlpkCqYQFCzyX+XAVBowPZ6SM4HnkU4KZivjB2Ba9+uo6sDOnaQnFXrDw/kfEu3HwmZkxSiK86hn5zv4kydPdAUCJB3riv4UyiFrZW2xwTI0Fxki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060828; c=relaxed/simple;
	bh=9+rZddv2qo+xd/s5UYlf8vprAZ6qDrWG77BSi7z2FlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgb77PBsYyqxVmtu5BOccLUOQ6hotNsxNfiperTaX8epPWEwezj2EMK52HVtybaPIb4oC/covbHWL2LfK1A2E18MjjKQHPpPDRex40akVkqRKOvEB5owRTHStRYC5wzGN7L7m1e8FE93lZKhlsUS0uXF2y1fG2K7+YUeKmhwXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CxNvk2fD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CxNvk2fD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7240eb21ccaso2878486d6.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060826; x=1758665626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXuhypsxRUZ8Mxxpk52Nehj4qfdEBuoFOv0z8ETV42g=;
        b=CxNvk2fDghU+wPtueIGEqxbSHHKTx0EVHQMnQfE/BhSO/+EbD4tuQ1Ge7akW/gXewT
         vEkrUljwvfzArJkEKBHxdjTst3n+oj2Q1ikRe33Hb+HDM0pjAzGWeUfV49AXYxYP0jPD
         XbGYijNP+8UkqbkU1HJ88rL0PSH7h3t9vSgKCTFVv5O6ew7sgvEspprTFiD+y3JVaNzh
         42Zh4uSHJWURaP5s3GF9zKDVG1vm5Ut+rIh6es2G7tcZGfaPKGdKw/oiAEvV8P9C/LeV
         ZaBii/22Ml9y84TYOaY8VqDTVAUVK9E3WaeXji5L4OwhJbn7Tylm/qF9YssdEb34iHEu
         j7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060826; x=1758665626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXuhypsxRUZ8Mxxpk52Nehj4qfdEBuoFOv0z8ETV42g=;
        b=St0iwU/jjYixIvXnxpzKIWSxWMxkTJ1AR/HDJxDxJAeA2/AH7l/I5SuNDK5mGMQeP1
         cMH1zOxf7xmiUiEzfuYC9ag9zRx8kMe3bHHYXEymb9BVOARVmw9C1BKkCYhdYHk1D8GN
         fAF6JvzqHjkp9BT1H1DMdC/oecFfwXU/rfdOGOR0Z3+0DUecIlKiBcyI0w3fN5a11tZI
         ChWQTS4PyraMXAepwKSkeg/X5aioL4/x8ac1dtA1iJrx0DiaGg8D+zumZkQny+B+h7b3
         FbIRmmacF7AVYa4nXZ/rAmzuvycmWzJadinpkbRh+uQoSiZ5U/ew77RpmxAtKLFILKKb
         po5g==
X-Forwarded-Encrypted: i=1; AJvYcCVAPztbnZkysxCLw3alm+Jr27/QvSxf2BNiDQRXLUoleAVRfiaq/7OrgIhUbvPractP8+ax0yTO@vger.kernel.org
X-Gm-Message-State: AOJu0YxgD2f1TjVjMwrTi8XLrzljfv/Fvu/Vr8AjbbZlBNTWQ3FD4ttw
	JGyP+mta/csiIIYnboS58K2qE/hP3Y3dq6kagNSJ0VKpkXWk3ed5dx6IaGZ9/dGyMg==
X-Gm-Gg: ASbGncsTarB2CVbYmHZ8KNG2ocr43QwQzUIBzRMh6wTdUy/v3rF5+HdMjZ3w3UhDy9S
	USbr+xtUOZq4pJmkaEhl1+mEqJpqF92FAjItaZw7jM5M+bgTzdBBKapTVhTm83wcgtzKPB0SnxA
	Lc6vBxJ4jKqjvhV4kzgQAhEcZCRo9PLT4ZwQypZCkxAL8ZXqrf7I9PicUxvgt3kG5KqaAzcn61t
	k6+hfgCH5P2ERmFGK19Hncgiy0UPyopLFZRjQisoMhNKClWw9H0GgkLQ+rgDg8GOeB97f0b5vFN
	XOFCEO2pcreyA0dyFK6VYWalKR2T2sDa8qUiFBhYC82Xqy9fR7e2xAAc+pzWf8Uw2K4fR44iia+
	VSFyoNIrGZ1W34Re6EY9iucdD8twytNvWMp5LUusBniSM2T1jen0BTf2bk9QNUNx7WaXw
X-Google-Smtp-Source: AGHT+IFkYqArttlIZ4C0hP7BuEYgfHvcQK2ujMBKSE1TAKJP/b3y5+AOhn5SM5XCm8+U8tYdQ0ZjoA==
X-Received: by 2002:a05:6214:240e:b0:76a:59a2:8869 with SMTP id 6a1803df08f44-78d5d1565admr40742186d6.12.1758060825655;
        Tue, 16 Sep 2025 15:13:45 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78d971f79casm14468056d6.56.2025.09.16.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:44 -0700 (PDT)
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
Subject: [PATCH v4 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Tue, 16 Sep 2025 18:03:33 -0400
Message-ID: <20250916220355.252592-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=paul@paul-moore.com; h=from:subject; bh=9+rZddv2qo+xd/s5UYlf8vprAZ6qDrWG77BSi7z2FlQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7cZJYwx4TirbVrit/W+EPMndfkQBs+neRSs 6OSfRDeYN6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne3AAKCRDqIPLalzeJ c9K0D/4lYOvfFFY7IEVd25BEa3tYzHq7CA04RWghf6Im+/SMI6MVU0aGHALI56BCLwukOciCPaI ADhN6hw6bOsozoayKtH1vpK7BEh9gAHKAavopLu1/BkXiz3i3Xt2leEZo/EgmpwMvYccUrxuVUM C4DdLOHTwOdqtdKZyipJElOtlPgLjkFYqR3tVszbFmFj1w+O9cwjG+7vFAPjWXuUW+cIVMFWNOp jV/flJzRBGSlGcYe16i5QNFA7m9Qzg0CGJD88vfHRm9uNTX74cP38kaUSBpOzgg1AQIquUJJIGp I4DOUeqjIV7+iTEgY4sSf8St7kbibcq3eQ3xEtFoGKKywbN9CApVM7cIZdJzcKmU0fyqySSEmRj 8lc1h30D+b3h0OiIhtIDq/9MuqYaixlTPRjv/2lHz3sPhbxpc53zrFgBdIINFpCdnHBwU3o7WrK npIDQL9gHh+vnczj75OJxXKjEwkFpgTJgoZuwA40dO/9hcRBX+AxbNpeSqkUF/+5zIClxDmUWaq dQI/naX6lLaZe6a74CH9Nm3WhnkIGb1IaKlAJuzJQYRp8lb7k6kK9xRqKoggZml6uMmKGtbpeYH SoFVIxz8sihWmuOkQAjG/XhE4mm5AHpPLv14DptDA455gqcTCiKs0Dg9tBAGadxmQ7x36uBf4on OTvcB+Lk+SPtMfg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
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
2.51.0

