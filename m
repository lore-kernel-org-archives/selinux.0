Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EE248F70
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140255; cv=none; b=Vp/9hdlXR5elVG8lxsqba4amGhqU3ONDaE/ZBe91Cv+IQg3M4PJCkBsleWt0FGjC7jorr/B2jBBEpJ/oHH5XYQs4d3oGTlO4qdVC3CmqrPvVAAG/WVbiN/V+rVEZYwuGLE6vK1MUphYloaGDgByaOr7pgp1pGl/aO1G+DAhDpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140255; c=relaxed/simple;
	bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAwcy04Y5fzri4HR5dzIFz3AaIINjOfRBcDxB9/by9j6ONvF1/as+DHeZCqPulSBpjMiCNg64+SZ/0tVCW0es/BFV0yz/5vY5Of8rz+i/IG6qmjkatRZeQIfdzr0UjMOR6zL2YMTN0fBHme9so9eRXWdq9zek3yqaZL3qHC1Nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eYbb7Ip+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eYbb7Ip+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e29616cc4fso486725285a.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140253; x=1753745053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=eYbb7Ip+ck0a/FVeqTqhDdqim/NB3ZY/jAVpkl3pljbWmMEoSRvOW+EdXwbDe518Mb
         LXEnvbepZGVc1+7/EO9DV5rXhoRjGP/OJOg34N8bwAwvqC08P5NnRUpx9hRrXPCW075m
         qOnNXqJMwRkTUZ/QMb7FaT1G2zWviyJXXhpxouEj3RdMURwEHeWh33eI/vB153hQ4BN2
         yjpHad7bTFaBXA9gkWd/xj2I+YuIW5CErOvjhVONvnPefxeNfwrXhafu0pCKiNpFGBBb
         1izaop58RYHT8ej3iUxozwnhdsLvEvkIKHbGxSPG9wUXL6Sywxd8YuYFwmO8pCnGLq1N
         bAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140253; x=1753745053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=edPjreUIYIqlMyj6A4+MhLGhVmpcL3sCSVSB7YOlDKVN0tnbdft40Dv6YzRJgt/nRi
         dduuDwLWC1IMdB24B/gKYGmxD3bv0AGB2voERlwabBOnxcqPssI7gj9+BCiqvbHmJES/
         MYB++O6CiPDDAvObAu1k9FJ8VnxUUbXFsi9XrccI25FuAABY2l4dSTSWQngSHH7Q9tbS
         XrBZPQ8rOEKuvkUnl4EfsJCP+ZQQCBAv1KPtbGsgBO09sLXL2bmf+PE10s0mPJW4Dwfs
         sdMEz5WxI7tfzqFYP4X3kLsYCOkH4eMDtybISH/lbNfrAQUNecbaGZOklXLvZ4FfMrzg
         G69Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGDwSz9UG6oj8KuFVaQScAuKcTuM6nu/CpQwbqJEGnn/UkeFgQBX3zdYogmAyemnGbhwqUcQI2@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3LKsK2Tv1TshcsJtTMScjNOLMTNXDh3ZpeIOJ3kHZtSVFXAh
	jwRXR6M8XbIxUmN/sh+tgNIPdQ759U9t0CJSmz+OYIyTmN4kdLdG5cTwySkzHHTaQg==
X-Gm-Gg: ASbGnctNMNIr0aJrb8W8BoXsQKVBevmjDIcuHeaVrBKXhHx49lMcLawSuyalQMynQev
	x/sbxS2RDOLmsmgncHLVvrIoxe875m+kSvy/SaynAwP9z5Br6UazkHjRXQAvH9H4SUJu8sE+euD
	cUZXHhKeXYAFKUGioAz9BCHJwIyUlYgKkQ+meggTdW3bpolSxdX76kG+byZTJvtqc7EQNeWAat3
	Mt5ebDluPscmbyXRfx75WiZ9Tvl2DRgBFEi82A9Tx4ggP2qnRQWkgxNswE+SA3Tobsj44Xj8I6y
	1OXR33jgv/DEoncRmVTHLYhzVJ0K3zPXit5z5UWJrLKTzlo6zcOOKZ23qFsKpkjbl7iPA0d9naX
	YYJ4tQPktP0u4b1tEkcOFN2PKzrH6mO5tMKnXU2Se5nkxyoGFdzgS6pBsZ+lZtanrISw=
X-Google-Smtp-Source: AGHT+IGR3ndRwfwcpR2AZDSxZ5D6qDOEkxCXXuwJKc2a6LVCAkBimE7QkoSpZmkzlqzjkDJWiHCy7Q==
X-Received: by 2002:a05:620a:2556:b0:7e3:404d:8dd9 with SMTP id af79cd13be357-7e342ab2721mr2843036585a.23.1753140253177;
        Mon, 21 Jul 2025 16:24:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b4677csm459128285a.32.2025.07.21.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Mon, 21 Jul 2025 19:21:16 -0400
Message-ID: <20250721232142.77224-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=paul@paul-moore.com; h=from:subject; bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu3I2CF2dWmc/V5ahR5wheUO+S6kvfLvkal5 srUcV2JrKOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LtwAKCRDqIPLalzeJ c0fWEAChRKn+FJl4HDckECX4DwusW4Ag8Xd1LeMR+B3gFLexRjxyekaHpFAQcvIV25XY7B/cRsr Qbv48MCrLBUGH/Ea0oEtRpEAuWssrT3hPUEw5DbtNSj6O4kU6o1bSj9YUW6PIW+vl1TFuJKL/0a yhT44n/VHkQM4iKnfuaLgx5kVCnd2iWA6aT3Z2GCZixrGwefJwqJFNbzNDt0t5M0cUjISR7Kn4L KrfZl8XX5g9BL6MJ/M4ZrHuiKdcQm9BPHhpWTilE5M3cpj2OdrTsKAFom3SyVtWLhqOXGTLX5E1 VnZEwTyhef6QLlUEKZR8SO5BtwggXYM+BhfYQtMnomCj5dIlPdLUfjKKb4ddPJ8WyGNJSqxwRCF gevkrLky2chEuU7ujyFQajZ8vxcBiAk93EG+eHGEiO0/kONRK9V7GYuqgEi80DWcfS0Jfl2hMRE CMhw8PoxKn39XZCWuwPikgrLGyuLXIj9aWaM8c6w8qvrkhGB8BXoe+RFtJN+Mgw1I3t6rK9mcvU ZTqNhoRwFRQ+9fY1T6RsXhwpNwYLqyI/M4FWC0W2ufUej49GhSJQ19e4cIwUuryxchq+js/H9ps nLTbIw0t03ysGjkmN53G3Bka3Vm6fZifbq1o1Ojz+vQUsFu7MMFM6m9hZihXwUYqcVBcFHVg5hO PEP4D1g6Mtx5QkQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 14bb6f4b4628..01825da2755f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -266,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -281,7 +284,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.50.1

