Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB9354AD5
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732932; cv=none; b=Jh0I9s12fe3WIMo3t8M52dxWACriInPFQP6Wxbq+X3ctew/iAgdRxoA0FsCmfYwy0s5EEtAXBqd5YWgpRSMWl36vdYKgGM2IH/SJNlqWBRk1NXOR/7HjaF5zxQdffrtAzaemsmsxF5x/XWAWy1WZA7rKaTHBe89IR6YXWokUkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732932; c=relaxed/simple;
	bh=7Hg0+/Rfi1IwZ+shp1qBVHWNI7btv4daM6yHtzQybBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6K5r8234CG6UEyFPP5x8Mh5/Qz+zFjTLREBc4AbrCYXpZHP87tbrXqHdD54RXKu30MgOnTAeFNYv2OKgr9h/3DILxpNg1aniFmKSxER/pAA5OizVtS50TaZBgJIj6SNT16fCt2KjHnAAv579ePhe2hBGrkEbiqZ/r1NfzDSyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZvqWF70I; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZvqWF70I"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87a092251eeso65223496d6.0
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732930; x=1761337730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F08BzygML3d7mk16+gOb8gx9xVXSNiTAN+S7YALDBJY=;
        b=ZvqWF70IyBf3tFuPNYSYNXSsekxtE2CzjJ1fR9hjRl8ph1lOD97C/BCRFBKIuPsFtU
         pUqm61Mcpk22qjsuXvx6va2aENZTNKhBaoh4R22qdSmm1InnOlzZOwBsZ4S2IFRuDrh+
         Ec1G0lsxMGaHkdLVLioNLIV89QIhlq3Os0UXRl6Gi52QNMUp6qtq0tsl8djuJiZ1C0g0
         fTJwiaBZIOyL+vLxUlmjShIPG2B92XFhk2BqI6OEO/F2rb5XY1BMsbOV8srFuYyHdN0c
         d+GPSD9fbmZ/4bEE/+5jeW7GwIsLSTUzrrzTntTxEQwz2UzXyZKnpxfPhwyaEB4BSVUx
         5fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732930; x=1761337730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F08BzygML3d7mk16+gOb8gx9xVXSNiTAN+S7YALDBJY=;
        b=qVNGU86NIAaRr3mbG8X766G4AJ7Znrpc9KzQzVDDE4qF7ya3jwrUZLl/zOFJ15KQ9g
         puRPgbTHfvhxOGSxfyYQi01U5o0/51EVrLCTP9c5USOjllpG1f1UPqFZ9HaUs2IYwlfL
         kf+0nr6XfqZkSptSG3cqaSxVvKk5+ZaqMSj6jxABZkOPyio+eIDog+tEALELfHnoHmsF
         7ravpAoAqEd77N4PYMfAqMNPc4fmZIAve82koW9CCr0M6VSvVN8xhd8nt2LCIpIHzd9N
         HofoLuJw/WtcUJ+X+XhNpKfCB07sTAO1WxsSXZBT3C09VZFeqUBJWhZJ0hqerXYGf9B0
         O60A==
X-Forwarded-Encrypted: i=1; AJvYcCVmnT1Jhwt2+6i2Q4AH2KUJPLSW9hHIdj6kB2QPJIDpVolDGwrcGXdgay7ZWSnxNHUMElnGVHBq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2mlMl9T6VQ4SYP8at5Yi57ZkK6Ysp+G2WaJeEvaUQPdIKTZV
	rjcvfXm3/G5CCMEvCViFkhty9PPmpS4u7tR+jICP0+1Rv7LmfLjsVoLjvO/NCMP2cvab+LcaK1J
	T729QpQ==
X-Gm-Gg: ASbGnctEGGNh/oK9Ak4XZdVdKGw72GuH8HJ/C9pwLAr7Rn100xe97RpGrT2ajMpnL/z
	23BiHfBrdob+iEsW+vCejeEtP8wGUllQtjCVg2UPdswivKh7iivY0nTPGc9k3iLPp9+xp/HVTEP
	5NMfJ1CCURXj2v0k+mjXSfWPykhNTVORJSIqlTS4c41bX13hL2pZSTCZVzYt0yy5QaotkRNFcYQ
	sHfvuxYJmlRTNjJzwvu62zWZj4sUlpYMrly7E3RP+K6K8Yfcgvhzja5lA6i/Ug/6Ixs8FknUkA2
	qgy/JLrgMmJqh3JL2H5WI7zQGjkDt2UUsDEbLj5p5Pu2vd5RZZuDZ44K/bQGND+Uv+kjbfsf4aZ
	44O52wf6w+utymLlJpvaO7kQW3eRpLMcWc5R8NaQooICMjApB8Xsho9u2NDb4Rmr7fwTKXb7kbm
	EogUopGvqaIAIUfhvikqJNriOq9NGdxILTSPBeXUZ+aDwSBgATdtH2vw3k
X-Google-Smtp-Source: AGHT+IF3HUhtTfPi41vD+hJX7TMmWOx9o97ZhUtmdp87zf5Q3R4MTeyQxbuLS6dAU60nYEGqAdEQCw==
X-Received: by 2002:a05:6214:1d01:b0:70d:ba79:251e with SMTP id 6a1803df08f44-87c0c7dfe6emr125094256d6.13.1760732929705;
        Fri, 17 Oct 2025 13:28:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad4a0sm4733256d6.47.2025.10.17.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:48 -0700 (PDT)
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
Subject: [PATCH v5 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Fri, 17 Oct 2025 16:24:31 -0400
Message-ID: <20251017202456.484010-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5875; i=paul@paul-moore.com; h=from:subject; bh=7Hg0+/Rfi1IwZ+shp1qBVHWNI7btv4daM6yHtzQybBI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYee5ROvN//Rbjw9JjqOj9CDPc/bkJwkTNiq mNzBZ3jI32JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmHgAKCRDqIPLalzeJ c38HEACToF919uqtKwi+3G0eYaavQEx7jSVYYKsEtqTJppS/eml87+8DmmvGRM4X38Sp5usolyY GDQvWb7isS53nJCN3lG17vhQlE6rlnM6uT7b2E8USl8sekYSHUhGt77X8Wr17yP4l/fWbT44obM sDskMoqrQlFdJNyjk2gg5YGGSigy1nTf21S3hqJVuR3ydJ8PLoU9d1FhygXN0uj1caVnqpJ9o8z lmMJ1CQpiDOVzVi9j+pZp9nHAjweH5w3fYR1HKkWUJpVchlyYAEE93Fk0cWhJqhVFdoF8+66zG5 Z/4YvoSQNVM0b7URyilWekLcB2Yl2CPFX1xI66M/f+LdcNihigQPEPY83MBwXOqISfPND+jsuk1 gLAP2THXe0jDf5Cubg6ZDaD4l3+o+lehK91m6bMmjiWR/RlDW5XqojiGPm27H6kNPYzPh1f2zPp XTvS36S64AHKlkJWWhdTArOpghRu/vI5N4xQzrf138rBFPHhK5SJ1i5Iq4INgtpvJLx01bs0k3u /4KMzihVlJoQIbItu9feRwAlcQbxB2uxZRtNqtoQpcm/c6FkeP0zu1LMOK7bE5HNS0pNL8/3f0r TzIE04SEOJg4SP3Dlttcydm23iIDVcIDuuq7Y5ZnbloH80N/PZt+VVF9HN8CkoXIvynQ7O1NQYg n+c69DvhWtqdD6Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 109 +++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 63 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 124213b906af..6f40ab1d2f54 100644
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
@@ -151,54 +135,53 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
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
-	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
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
+	lsm_set_blob_size(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_set_blob_size(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_set_blob_size(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
 /* Initialize a given LSM, if it is enabled. */
@@ -361,7 +344,7 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
+		lsm_prepare(*lsm);
 
 	report_lsm_order();
 
@@ -505,7 +488,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.51.1.dirty

