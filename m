Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5232820CB
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212049; cv=none; b=gWMItgOBjJ4gz1lI1g70Ywjxq29ABsLnjH/0Q6NnQEt9CEfKOdXhI/FkGXzdh7lftgBtysTyadBFts9/QqOzNjva0rzH33GB8j93n26Mmd7dYdsQFkv2+4M+3J7wGFm3Rb2V7ME5YhzloOi9K5t0lZ6A+kz57Ofu5JJNcKJKqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212049; c=relaxed/simple;
	bh=fXLV2FjjpZr4DmNoGLf/yBwWimq5dJNqNqFStzfdqYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcigOnaxzK6KAMcvJgtXVgMi1TZH62GSqX8Y5Q0HMtdeUDLcV/TJsgN9EW9n+QVpqlU5yd0I3SlvloKKGz7hZQQgBTIj8y+lY3AAVOBmuayrHTj3CvcvUjA/pBwy+CSKbWhm+TpBGODdCzFDevnptLrz/FYes7TaWg5QjzHPxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B1rlWJfK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B1rlWJfK"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a9282139fso12854086d6.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212046; x=1755816846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfb+X11aTowlFjtXfOfCX/u8LGZYTb8NJoiRCY6w/dE=;
        b=B1rlWJfKEZDv5Q5ST2G2Oom8C52HIycf+g4+rmuG695q7PImx/S9eSI27CYKogYlVn
         QSnlwofAJWl35LeQcOIeU/GonhIOIZFrJU+2ULpTJs7v1MNZYTswD3t1eZRHKj1h9hR9
         jYj8hV/NBJqMIcrhonWU7NIxzVeZ/gDluoFJTyzzm8NdV9XEUcZJCy0ubkgCGoq92IOj
         DJPbRS6Y74AyIX8Jo2VXoMfgheb7b6/DhHJTCPBIjJMXhPtBaff7P9/tn7h161w8tLDe
         ge7V5TMkt26uczuWti4UTUHVOS2eE3qcI9aLvsyz0doJ/ocFpG4J99aYmOVvJCRbsrmM
         WNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212046; x=1755816846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfb+X11aTowlFjtXfOfCX/u8LGZYTb8NJoiRCY6w/dE=;
        b=dRhOnkW9c0WYXXSWd8f/C6v1T4HfiTM3hejtnwd0/iEi8Lavd1Dj1FO1SkCLwjKSxD
         TFa8d5XbVEOAZ+fX+O51BL9pU0Q2ItG8HTOghIwzZjA1eWIr04d41r8aeWDoRmd4XdUA
         SqgUEUaNSMWJnKDniWGIXlCMy0V+jYjkfdtdJjM8CwbEqiquFy829iLOImddkYnfnbBH
         HoiNv4Rb4kCZnvnnKgq+fI0qNZRCbvtsjCUhAS0qaNpnYnbaVLLXz2PlVwgGPc0CCPwf
         EZc4PcN5u4bLyPRUI8P5f42X46cJzLsKS/nMosisB/zfoemvw8J12k637ZVFokXHTh9R
         g7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2Ev8LYiY8gSbnUtgFJ4hiol5afOcaLgqPSC7Ws57ptS49QzIYSIPplVkpucFd3SS5MGx7HLM@vger.kernel.org
X-Gm-Message-State: AOJu0YzEO+fpG2CmS/peJGd/d6FnizFbzJAQD3ybwc5GJNd95lHXLyus
	yK+GsQOnitXca18zMn/3q60vDsCSRFq1QLw06bZzOdcbxc16oGrDdMUE/O+vo/XG9A==
X-Gm-Gg: ASbGncuILEmKuC1ogqk75DOFTi11L91Ozklnk2v4mgbM7t328px6vmb9BITpJO/jtor
	TSxKEjv6sHFsTA9KkyrObD2ZlJxOEO1JExJLnXLNj1IF1eEAEgobiCx59AZdrG/ADl7cLzs0kyS
	zvexgR7qAMHXCip1zsmJoibxpFXrEORZ3FVKSfFjjPUiOvgrMYOcHtvA0l3kgnSBBc1ue6f75Z1
	+lqkVHFqPBvm9mUaI97qBEkJOX/UTHh90VRdtiHZsevSnVlr/uZkrJoEv+mnwYydWStP+/r7xp4
	+6ALyDze1h9Sc9YeND+Zf9dyLb61BojqZV5o61TTGSgJ4wZOFYHhaCKzUh3H7upAfjO5qvAVa36
	5y/Q6pUIjWObAqxW1pGQlHOxcR8v6SmSIeR2a4W25GRFW+6idAxvOXVSwN9kQm8By0Y8=
X-Google-Smtp-Source: AGHT+IF6d6nTGUAgR4dkQ8c6mudSzuBRdkmeHxBJvBxL7rJnovHTd4SbckSmU3uNmxzER756M0XmEQ==
X-Received: by 2002:a05:6214:2245:b0:707:49d9:258f with SMTP id 6a1803df08f44-70af5c730f8mr75654156d6.16.1755212046283;
        Thu, 14 Aug 2025 15:54:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ae6cb0985sm19208896d6.19.2025.08.14.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:05 -0700 (PDT)
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
Subject: [PATCH v3 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Thu, 14 Aug 2025 18:50:12 -0400
Message-ID: <20250814225159.275901-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763; i=paul@paul-moore.com; h=from:subject; bh=fXLV2FjjpZr4DmNoGLf/yBwWimq5dJNqNqFStzfdqYg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmiVBm/EGqaaALUtA3bX0XMcoilRc9VpdO0PV qzwp6PqogOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5olQAKCRDqIPLalzeJ c72bD/4xdGHW1ORYDXxT5rp11uF/T/VWpo9lU/YNRl2c4haZYvs6rfL9fdvMG5o9MaOH3ABezg3 SodZS/hzK/bCAdo78RIHOs8VFL9g7/AjI2UI6nhMPzCY26qosOszF4KUwmmuLOtfHY05ZdOXzJ4 pXY2GuxqJsW98Sftwfz8TUttsmTMwBImzflnFdcJBxByn+Alpg5IXVtpeeZ4K7xqpTtSKx7MZJk 0+1PCk9wZEQDc4QJOknaQzVwuuSJCIxa+waZTKEqZoevQTGQgOwHzRUv6vCYaxAKTsZLUS+p6dc qr8nLFCC6QV9Udfx0+66RimgOoAqerkE1YANFqi5few+Kmt9cssLSvDBWvbFsO7wt+/pWW3BsWj sud1NIMDx6ntOreJ31a1gk0eGsYYy2aW9YVt9Jj4sBtRYa5p/w8mHyE4B/5EI/2pd0hPGOBj2Ae 8xd1v04PDNYZ7S8qeQnyGD8HLp+oECdPY+Br0XG0MOprT++JiW5R0hRgaVYOXLdYUrpwiPrDH5t xZ/BZ47JvgAj2n9v4rYXkrsfZN0+BURlms+D5obTMI73xdwB7NSd0fc9svE9qfpYP3LrljNW2MX zJ7LLp/gbaF7beOWLn4s8UXgKKV1X0EkcQnzPeWQCvhjpc/XdgIEYb4neIPUXQIbzhiz+zNgD6q i5yuLC0rVHJeoSg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1

