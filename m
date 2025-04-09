Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6D278167
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224817; cv=none; b=RGExncYdRho482KFCvtRWRH6fQ0emPHmKn896mZS94o4RszMIsVqidgd4D7Ov1mqmB4bLLGCmPYty8qu3IpXUNktpbdYM9fKuIeetPQrFhDGJ6PjSpYmDA/spW6h5+66zkAVuWDpayPE3pQnfnBcl5aTMUNCtIODg0YJRd7f3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224817; c=relaxed/simple;
	bh=gpr7tsGitQIMbEcgCwGbviHAdreY0TOHnQ6cCKZK2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn6Gocn0DK8lhKcEsV9tSG6qA3PK3bWcz7QbdqXxBovu6n4YwrR2ehoggjVhNmvkFyHqZ+1bZtfvzlthjn2Brl0FPFZtzkJfMT3QQG46QOQSOZHeXwdb5Hk/c5ZdS61do32NfEEmyq9XBVyt3e+slwBaLgoBxIjxhewUhCyREOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ttqwv9Hn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ttqwv9Hn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476ab588f32so38367691cf.2
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224813; x=1744829613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyW2hd3CPeNluq5Deagk7Gz7AJbC3npegLBwPU6mSOs=;
        b=Ttqwv9HnniNCvdqkCDQW/KwY6vqkqcxNEIlFt65C/BZ63tR1xYfmlta9X+kIOajLji
         337B1zDcDlylm0cNnfhj79GZu1xScHYmz5twUMVpBqgcCFj2UFua3aw96YwSnKRpAAcc
         H4X8OYkZ4wCVQceBVN6dEDP0KRhJBvQwAhYQlW0Fm+F78T5AYdN7lkI2vpwLnfN14TK3
         x/oJJIrufXimYi0ZpNYiYHYvttit1KtelEL5eOtWG3XNnW5fCfi6UOVPT4nvL2apGHfK
         ZaiMMcAcwwNRZHbA6cX3iwoPqQZSCk8QcAZ7zcF8+WNEqWF69wuJbcK4BtNKLgp3O9fP
         wKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224813; x=1744829613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyW2hd3CPeNluq5Deagk7Gz7AJbC3npegLBwPU6mSOs=;
        b=hXLi9e5I5sgNB7BiXq8xK0E1aUQOvZ8qNHugWEbSaLs7vOQFiSrSLMwRJDQ3DrP/S8
         SyHaDpbwYVUhSIPyevo0RZlu9YH8gJo3hdEVZE5a3Qsf3N/6CwwUfppW5gHojKfaIX0C
         S0TeDQ5/yX0ZCynQ/OE5+lR5UlZxK+oR+Lj6FDdQMjGWz16IM4nzrlAk+T/EYu0Ku0Kv
         UPV5+BC9AJaykhyTuk3EPEAQVBFyZwc5muqsUWHhOcEtFJJZnmkbNs3iQfSUKuaED3Rn
         Ozr3uxwSDv5UxDWHsbNJB/AGnWzwsaNiEB7HE2GHafywoBPqu6lsowcxuSyN07oE0ZKK
         tezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCg6PB+C2xeVpMFBoCZBTz0dv70WqhsZB3Yae3dzfdRZ2ZEy3/SdmCzUzL68JZ+xUsPX5ZhSWF@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIGXG0LmPwnBwNw10j/XNC2ua2dgw3fDmsvgNx/bY15j6AM43
	c3BFCNQNch54Ez557LkXUcGsG4FiUQ5Q5Mjn1DfyWgkKopXvb6md7GBl4niu8Q==
X-Gm-Gg: ASbGnct2kE5BPXzulVhVqMDfg5YnMEvq391//h/qiWJrman+/IN+C2LnoRyKqfOzHxy
	vS1wCwOR2a4fN/Q34ftTIzvHDM0B8GX0VMkf70PS06O9h2qCBoPotR2bPfixSA1R5sGlnKLpQ1C
	leyiDaefpsUa0+T94whTOhW0XWL5psgkpqd22lIw2zNVXG7weckgS2QrTj5C/Olj34ecKakISWT
	XjuZQnBxtIDsDrfhvoENxMU97mvs176FrfGW1glfqz91lDnUYErsj/OxynUTk3v/Mcn6CJ2ye9Z
	jqp9bwYjQuvo4hWb8KTAaU1TmjeaYnL+OTPEzQQch9uVDqbEwnnpEqjuiO+L48RcuHXShrxUbfy
	Ei6rGUwOgCQ==
X-Google-Smtp-Source: AGHT+IElE6XZTnvc8PwrZp+Tvpsb+oUBi9puAZOOHhxs0inLj4RSOmzkhtSEd80tUBKIzcruBlRftA==
X-Received: by 2002:a05:622a:1115:b0:476:6b20:2cef with SMTP id d75a77b69052e-47960134f73mr58523681cf.41.1744224813280;
        Wed, 09 Apr 2025 11:53:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ec504asm10336751cf.62.2025.04.09.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:32 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 04/29] lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
Date: Wed,  9 Apr 2025 14:49:49 -0400
Message-ID: <20250409185019.238841-35-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5284; i=paul@paul-moore.com; h=from:subject; bh=gpr7tsGitQIMbEcgCwGbviHAdreY0TOHnQ6cCKZK2UY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGBx4wuIYQqbtw+d/oiQz36dPSuSfB0GAmp4 QzeVymGZF+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBgQAKCRDqIPLalzeJ c8YTD/45zC/x50mbnS+rmFfYNWP9G7OQcwdN2nOZ7WlXXy/epOxNYO9oqUAgfdTzFclLzS6Cx+q JexaE0/dKwgqBmq2/vsiE3r/sVjTKUrVSi2mvqjV51Geb0hAuDMqWaK7eKvfgtNSesynf5tTqT/ lPk4H7BQUeSa97Fkz/Re2+QYIlwCZJkv31vSfm3+qPCk+OerKWhY8VZu51pBC3CLtgNfxyNSljc g3VsZvrWiU/P3TRj41DhNh/VUgqiKVhg1exx4JwxUBmbLRZbgYhaUqW0LHu/WgXW457mPO3udHR jVSiSfQlYR9vvXVhQW2GsXrWG9p6rRCtBrab6nLdRYB0gcWo6WOG4j2ARZ0tq+iu2EUDn0dMZwm mcoV/4DlyCQGlmXSskfG61bAiexiAZk/B4omodClDjdvIKpTOpl5chS2QxM5hbtPnh0sNsYgY0S wMRjIw2dp1yCDaxBAzHHNrAaCbX4GsKPoshHc9bVzaQS4kWd18EblGK+xlDd+rHYOZklSWgeRT5 miwOSwpsajR0EUTPZge4ZD10xkpSK3YhI/lTH8ctR3cKBhcB7p0CdCl7RSivVwDRYyE1iVaibCl RhAe83ZgFLjc4DBqaXDAHX00Y1WEnIyA9PIr1B81EJF9wzWLKrQpe6cM8eFitRA21hLUmGEETFX oAqDnf61MsjtA3w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 94 +++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 58 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index dffa8dc2da36..407429688f1b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -32,6 +32,12 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);				\
 	} while (0)
 
+#define lsm_order_for_each(iter)					\
+	for ((iter) = ordered_lsms; *(iter); (iter)++)
+#define lsm_early_for_each_raw(iter)					\
+	for ((iter) = __start_early_lsm_info;				\
+	     (iter) < __end_early_lsm_info; (iter)++)
+
 static int lsm_append(const char *new, char **result);
 
 /* Save user chosen LSM */
@@ -96,9 +102,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
-	for (check = ordered_lsms; *check; check++)
+	lsm_order_for_each(check) {
 		if (*check == lsm)
 			return true;
+	}
 
 	return false;
 }
@@ -279,56 +286,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-
-	pr_cont("\n");
-}
-
 /**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
+ * lsm_init_ordered - Initialize the ordered LSMs
  */
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
-static void __init ordered_lsm_init(void)
+static void __init lsm_init_ordered(void)
 {
 	struct lsm_info **lsm;
+	struct lsm_info *early;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
@@ -340,10 +304,23 @@ static void __init ordered_lsm_init(void)
 	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		lsm_prep_single(*lsm);
+	}
 
-	report_lsm_order();
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (is_enabled(early))
+			pr_cont("%s%s",
+				early == __start_early_lsm_info ? "" : ",",
+				early->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (is_enabled(*lsm))
+			pr_cont("%s%s",
+				lsm == ordered_lsms ? "" : ",", (*lsm)->name);
+	}
+	pr_cont("\n");
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
@@ -362,9 +339,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -374,10 +348,14 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
+	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
+	}
 }
 
 static bool match_last_lsm(const char *list, const char *lsm)
@@ -479,7 +457,7 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
 		lsm_prep_single(lsm);
@@ -506,7 +484,7 @@ int __init security_init(void)
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
@@ -514,7 +492,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.49.0

