Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA6243378
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140246; cv=none; b=C9ILUgL6Ru9VerGUVe/NfvqIrVNm/jDXt/r/R/lr4vMxd3x8yJ3uP4+XYP9g+z+4pTPNa66diSD6ha9AQQzV3sV3UyEvvQivFBYuFtjeUavL9tuue5PuyDMpESVIpMdXJPo6vxeYTIgNDyeGfXiDHFzkAthSyWw8tR2T8mrJ8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140246; c=relaxed/simple;
	bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr2mQ8WAIPvXuANleJwSG2hhzPxcBPDCryd63uZrbb9L/cFYBux+mAL1W+BnxxpQJtGJy6QUUgyXl2rn2rq80Awg73RIHN0ZZp5qcRh6jtgz3Pl9q/kL5yWF5U1raAn0NmbleN/Y/bU9Il2iJ9DAuj7wFJsac09URRJ9bBSy4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R8+JZ9tC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R8+JZ9tC"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-700fee04941so47788776d6.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140242; x=1753745042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=R8+JZ9tCpQ5PtyF4XlFZY0cGuFEGWBKsYDzHDBe5h9bbQYcLl5U4NV5S5CRglpEJTh
         O4N11IzGfHkaBQSYePiXFxr0VyFdxXYsQA8NbhzxPT0k58fMB6BeEI523c03RWY84oh+
         ZvD+ibRg2kzFbGLGkFgCpiaLjac0ExFH976gpb9hRnGtLptsZyZFgtQks1MfOe78e8/M
         vlp/nKE4pm40PT0nnANQ1KFG+x+GrDCZQtfpdCRQ3H8yPzTq0OcLrbnB0uRWGTScZoSy
         xh7nu7a9xXZafhdOAbtazPrY5xkOjohJemqaRYoDF59w5tB1dBz/y3fr9r5/xrqr6KQD
         xhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140242; x=1753745042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=J33XgFFjeqxOwyy0QJCBuz8Fyem4Um0Iur4zcK9vWJ1WNw6Zy1U/d6+o6wNf0V45s+
         jYez0a0/p2CCwgiQTnUQSFdiORlQeDaWHtIaQDwlii6pxymc5hAZkqFh7WOsPDkWq0uo
         ZW7T/paEE+pzOzGn1HfZ4xxN4f0D2VV/Ld11jd/X4Z6yRMAaNKC9t/RWRfNgC7ikB9pq
         Irsc83W8/Dzi8cZCi1ihqiZ0CdsiUg580vFr7B00zztM20tYEsRNVmvMKhpZP9b9+k3j
         nCnt68JviQZPoh1fL5eJnkQS4v+AxTTaItHngSzwtg1IS7zGdXs90yb2w8RW03Yfj1R0
         r5/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0dt6RMeaqY/NewsVfsfHUXT0t9+MjUgi30Fx+3zOkChL8A6mCOS1duTEkul/ujfbBfQYzl/0i@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+63trKbhRi06ksT8uESP+XzzmEgBOlJUqMDn3+/Dtx/ETv/n
	FmaMrZD9sWyFBIHNDIb2nDq7d1KH/IF9mq0LY1Pgn55y3TlByv8xx788jqqec/cr/A==
X-Gm-Gg: ASbGncs8fpA73FQ+XHQ63l6n6pbuB0W3pNaRF9+zlAjtteT15soDmgBnI19RIG7VWgF
	asOofcVJJQNJbDuJi1YrOnMMVwaxQgQH+AlFIoz5ot5EdiH5/nRPy3Zg1KFfRdFzR9m4+Tk0GoA
	CTEBh7p6gs/xT8G/Oj7I7E1m3icGe/sW5PZAqIerSvIBIE0TppIesP4dehQdvSYSESTgc1O+v8Z
	It9ZiIIXL2QxYQagYB87u/XWtgEy0VJ8HxMCJUjv2B38IYe8hYOJm0FAuQ7Y3ODG9lnXASYY4Wn
	ZWKfwFpYkjIpXSv4oLAsINCx+eR3v/LuZIvgcefetWNNpZ4pEIXUTATYCBqwPJrWDP8JaBUN8qW
	r5Ax7dkKyHZuaFn8G6+bNTyn1/5NcF+xIiKgOHx90EY6iCuBIe2mHaVbMaASsmy9tGsk=
X-Google-Smtp-Source: AGHT+IG040ezfwkH740S6YajZYWPmpi9wI8uXgRxyuNMWS6eUKgzMyr07cwK8w8Hcl+18TnbvenK7A==
X-Received: by 2002:a05:6214:6210:b0:706:dcab:a94d with SMTP id 6a1803df08f44-706dcaba9cdmr54588646d6.51.1753140242451;
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb49a0ab8sm48263971cf.28.2025.07.21.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Mon, 21 Jul 2025 19:21:06 -0400
Message-ID: <20250721232142.77224-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5285; i=paul@paul-moore.com; h=from:subject; bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuUN1OiYz/phHW1CqOrrQTMeI3wlWIXLLOFl SZUTAcY18yJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LlAAKCRDqIPLalzeJ c7UZEADK1oQVGOe0u59nB01nyMZFTfMAw84CF8dD7SzdYZZ3VQRkXZYddjqEvsxFsxiHr3zKe3k Omvy4my+ZYuMtAIBWwwKO8L6CJGJ/UkD7GLHm3GgjFTWrteK5JfyvgkMeKH2mbhai3gEXddPFl5 48anD2L2jcchKhdapgaikeO9DXq34c0FJBMvtRyrlfnIWc/JwmWj7CME7wrVF3cSHDpoY2xVfUv FTqfD53ev7jeBY6KPDIQbowtb9P5tmnVQHjh9oPTv3LUGaCTdWgnicOOuDTqcmJ06RRZ/ePifZk ZaMKkh1l4y1jwaGIVwY31BJPp9jL/r5B7mlRp/wL4DxhmZzqGgrqVfbXysFBuRhaEUgYDHNR4MA 0BHyAtyCsAwCZ0+Uh2i5mkjyZuAnmK5NwQzHzOnR8VhpBIFQQizPq8im+PBBXod/wzNg/geobiJ 6m8MyAWnuQUAqsb3xIKGICMMED2us82/gQ1I6Dr8ibkmF860YyGO31OSJwdfRP6Vy0Kmsom4Vd5 ghK0gW0eWTEf69x0kZMqOmG4TbTlHOXIc7FLALTT4FZqozTZb301JRuuGmJUgayIs5SNZib2cLe gFKx24jljj5491WcLJucN7AAvRMpLoRPFkpHmMKVN0oSX3xFAdjs7McwLPSV2kjlLOkY23oG91Z DAJOUKYuURS3emQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 103 ++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 70e7d4207dae..7beb028a507b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
 static void __init lsm_set_blob_size(int *need, int *lbs)
 {
 	int offset;
@@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
 	*need = offset;
 }
 
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+/**
+ * lsm_prepare - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	if (!needed)
+	struct lsm_blob_sizes *blobs;
+
+	if (!is_enabled(lsm)) {
+		set_enabled(lsm, false);
+		return;
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		set_enabled(lsm, false);
 		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
 	}
+
+	/* Mark the LSM as enabled. */
+	set_enabled(lsm, true);
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+		init_debug("exclusive chosen:   %s\n", lsm->name);
+		exclusive = lsm;
+	}
+
+	/* Register the LSM blob sizes. */
+	blobs = lsm->blobs;
+	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&blobs->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Initialize a given LSM, if it is enabled. */
@@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
+		lsm_prepare(*lsm);
 
 	report_lsm_order();
 
@@ -499,7 +482,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.50.1

