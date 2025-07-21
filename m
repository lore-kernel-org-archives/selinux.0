Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44397248F55
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140256; cv=none; b=qtRH8keX/BmeObkCqXHtTKV5vcRkQ0xJoQwDszMk9XUfUH5JfH7tD6pBr1FxiEwuS1zNgfbPO2IUv5fz4idXXkSwarrC5zXWlZBTPB1V/vnO7l43fdizt//PqQviDZx5rAOZKSz12wNq+82xuopJCP54Kr4cntKYTpN+jvcjjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140256; c=relaxed/simple;
	bh=7HWoPXRW1EX/2GFaHgB/iS8JH2SnwuDo3Bsxb+miJcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyoFwYNaKty1PmzjYym5qtmXk21GhILxMTrPwkySiVKFIh40+6e+v2uLW/QkET8EE8syWz6bPMOqoxCpu0DjXox3CTtBMyltrcYXwCWAI13yZsgNxSDyEnQ1GYDwMGQJU+shMpc5+UDrClrlZ1MOhdbIokXEI/GibxmJ/81T5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FAHDYo0T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FAHDYo0T"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4abc006bcadso32629731cf.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140254; x=1753745054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpfEx/u7NcC6D7988g6teSkVIm/SxMhG3I/K537tYFE=;
        b=FAHDYo0TOvn9io3JNOgv/5+jTd5CuoQcssS1WsWfcJ3JvGPSzYRYH+wdQn5FP5nKhM
         9w5vHaBdtJPGXHy6Bus/Gl1z+TX5YDbxw76YUxn76dD9mxVxBsBZZwqvdc9K6MQE+dp5
         I1Li9Rejfj297AGJWYxR508KVlzKg+uF+rq7O3IUK5RFUy/Q2aRR8/OVqqAvFLlFfKdH
         Kpk68i8H4sX5Ney91XvwkdkYMN/JgqO3IiLKFcKbP66r0AROl2P3VdwVufpTxAIYXTyQ
         oNJrsdfG2/BL6qDNtWTU/JzNyDxeYgKVQf80HRNWuaAg+iXLAaV0X4K6Kojtk7HiUuKb
         5g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140254; x=1753745054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpfEx/u7NcC6D7988g6teSkVIm/SxMhG3I/K537tYFE=;
        b=aOVSV/TVMbm191xgjEhLRrzUfFUiBGXnVFYBmOUi5tXYBo7P26py3AwT/LgDhVBmey
         X0cLb90EDvj5fFlRN9c6Ws7fefeS/w5VlvxCLEcKxPv8ZhfhgiNJhqY/OdJei27Ybz6J
         ShSfKtgARtn9shBv5V0xzntyiOHp4rHG20bXBLqu0/e7VTuJLl9V5gckGu7r64EX3Ydj
         5FVjTmleMf31n0UPhoa5nsbUjH4RlasSYBIPBdPbYfmMVJvvtubeCupiZac5w+t8kHBy
         x2pGINAT9Dl5WP5XXzXsg82nHjypXginOgp1wMEMSe0lB6Z1+T8ownFaqF7VeNadBOZt
         VxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCyOUorNgbK5B/ZtN955Pl4QhwJ4mYf/Acsrv6YHa9hZAvNSytokPnKKRGA6YKZ6K2QfEdrjV1@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+EixgNJ17775HWndExgxLRFUeqnWeHUCrPRsFpYoFo/aSmFf
	R6RsJgZXtGPDDUQ7NvcUy2jDYgqnOO+t+wkAUhTkwVlOoQtV/6aDdGjJ42zZSVKnMg==
X-Gm-Gg: ASbGncu0xf0B+VeREFtxqP1olp3+jiulWpB2VLDYNsacxuDZmEyFF4ggpwj70M0K44W
	E1O6JqHYz/KPoOPZZ3OeMGO71t6BmT/jngOhmPiuO1+mwFDSOkWEKy8UhSkfmFHvxq5D1SyOpj3
	ZDJTpF1Ingrq/SbHis2DSQZktuXDjmsQrcVCamkrfzfZtGXGWKgDWmSMUU8N+tP0+1iDNnqKR2n
	wHfza+ftqOGhVu4QNsFxAYK9ITXMozHG1upLVNbBDFxCVlRCVBi19pjbpmVLo+tZoP9SR0pDHBL
	dyzkxC+aqKAh4k3jjd073eatfFqAIX5WZRdE137+GN36bicR8T42dOo4RP1KlY9dovpwiyspunT
	NB5Eg3B5KcBBkqGY5aq36iidzxgWEfa5MRro7R6qM72lDY/3F3v3Eeu0D5Zh8SFLTP/s=
X-Google-Smtp-Source: AGHT+IEY+VbR3FAGlj3m/jSq2IpsVT50826SVNaIw/uF8q0xkrnEeH1etJ/kVnbgTJ+h5hml1XyPYA==
X-Received: by 2002:a05:6214:19cc:b0:701:9d0:1408 with SMTP id 6a1803df08f44-704f4aac139mr279006436d6.20.1753140254181;
        Mon, 21 Jul 2025 16:24:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b491c2sm47741531cf.69.2025.07.21.16.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/34] lsm: rename/rework append_ordered_lsm() into lsm_order_append()
Date: Mon, 21 Jul 2025 19:21:17 -0400
Message-ID: <20250721232142.77224-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5039; i=paul@paul-moore.com; h=from:subject; bh=7HWoPXRW1EX/2GFaHgB/iS8JH2SnwuDo3Bsxb+miJcg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu7nmr/6eWI4erEg+lIkFd98mZp3F4xC5Uu/ K4gNKQkR8+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LuwAKCRDqIPLalzeJ cy0/EACKL0+2lWBsJ2SuBcfxHwkrqYoJYcmDW3hp1zb9yUeZBybFZDmyjd5TdHb/1AV5Z19VIvS g+24LzOgIO9OZf9aE5vhPsTcxUO+ww+mGdttAyzBuIvC+7vJPEHgkyJe+AQ4fFXmCBKrU1Rf770 wina1DaSONXjSlusn3duKvXpg2TtGydqhh5QxpICiu7e2SL4gHqhJzZ2drSNfMP8IPg5sj7vhnw MnSrEBbNlimW/fTn+0IcEFnpZmjyrUkY4+CNwKjkn5QOhBrmDAOv1++Jr4+Jm4TgzpUz2EtHXfO xZKBt9coQiX1r1xr3xfMSzMa7vUs7wvfJPTMK7zYAaFQq1QHElr3QRh3Po6N32u4oU8fNrK/JO5 imZSqfH2B+1RdCq53KwBpr15cqGXCncHfhp7sZ+QcSkOPa7D/bDIzzHIv82/pWyjDIy5g672o8Q Gu7JFQCs4E2ssxJ9ebODx4Rn+wdljjh7unXoA9PxrsuaEi9VVIfeAYF6ykBtwgikC35NnxXTv5U o1hIk+CswjGKHwK7KdC0toLdXNj+KFCCe1P1hGeOaSSEGbccugZkch7zdWM0hVWuIcovHdzHKRF q9eTw/66zmuWo7oWAnFSM7lOF0dGAl+dFOaaRy7kvRlmAJG0nntZbj5Onfxm4taHndEineKu7nh pZ+n7hMDQrQAOfg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename append_ordered_lsm() to lsm_order_append() to better match
convention and do some rework.  The rework includes moving the
LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
in order to consolidate the individual LSM append/activation code,
and adding logic to skip appending explicitly disabled LSMs to the
active LSM list.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 01825da2755f..8c632ab77da9 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
 	return false;
 }
 
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+/**
+ * lsm_order_append - Append a LSM to the ordered list
+ * @lsm: LSM definition
+ * @src: source of the addition
+ *
+ * Append @lsm to the enabled LSM array after ensuring that it hasn't been
+ * explicitly disabled, is a duplicate entry, or would run afoul of the
+ * LSM_FLAG_EXCLUSIVE logic.
+ */
+static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
 	/* Ignore duplicate selections. */
 	if (lsm_order_exists(lsm))
 		return;
 
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
+	/* Skip explicitly disabled LSMs. */
+	if (lsm->enabled && !lsm_is_enabled(lsm))
+		goto out;
 
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	lsm_order[last_lsm] = lsm;
-	lsm_idlist[last_lsm++] = lsm->id;
+	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
+		 "%s: out of LSM static calls!?\n", src)) {
+		lsm_enabled_set(lsm, false);
+		goto out;
+	}
 
-	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
+	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
+		if (lsm_exclusive) {
+			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_enabled_set(lsm, false);
+			goto out;
+		} else {
+			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_exclusive = lsm;
+		}
+	}
+
+	lsm_enabled_set(lsm, true);
+	lsm_order[lsm_active_cnt] = lsm;
+	lsm_idlist[lsm_active_cnt++] = lsm->id;
+
+out:
+	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
@@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
  */
 static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	struct lsm_blob_sizes *blobs;
+	struct lsm_blob_sizes *blobs = lsm->blobs;
 
-	if (!lsm_is_enabled(lsm)) {
-		lsm_enabled_set(lsm, false);
+	if (!blobs)
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		lsm_enabled_set(lsm, false);
-		return;
-	}
-
-	/* Mark the LSM as enabled. */
-	lsm_enabled_set(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		lsm_exclusive = lsm;
-	}
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
@@ -224,7 +234,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
+			lsm_order_append(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -256,7 +266,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
+					lsm_order_append(lsm, origin);
 				found = true;
 			}
 		}
@@ -272,14 +282,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				append_ordered_lsm(lsm, "security=");
+				lsm_order_append(lsm, "security=");
 		}
 	}
 
 	/* LSM_ORDER_LAST is always last. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
+			lsm_order_append(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
@@ -409,8 +419,8 @@ int __init early_security_init(void)
 	struct lsm_info *lsm;
 
 	lsm_early_for_each_raw(lsm) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
+		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
-- 
2.50.1

