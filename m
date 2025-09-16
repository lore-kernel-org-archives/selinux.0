Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B552D062F
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060824; cv=none; b=li5zhu+49EChdUTT60w6EqSo8N8CRn3+wcdEmarOQrMsRADDu2Bi3cajdkSTXsxeIrUuf7eIlgOGf8IADJbx3cH4CFnS++z8owURfTgrSVN1hTiW7zWP8eFNRP3wMVwASMIeCr3FSYfSX3xcI9lgxu+/AG8zo3gUJ/qDOjGSLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060824; c=relaxed/simple;
	bh=uVut6TV1PJIdwfEgkpNN77srM8Vz0L/dpZkLz41WDp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUf6Q5r/PUeiVGyV42cBCdy7J1UgnTotfLtGUi19KePnI1Kjj48pD+yPUqi8mMiBizgZ61t6SUQRoy0gCb6cVv4AidIq/zT7qZNOIeSwWVWDbYT7Rps6Mfy60nET97vRNRr98cMozgqsWslrk/qP6jIN7NYWMVDFOe26WEk/ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MFeoWhZH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MFeoWhZH"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-816ac9f9507so35764585a.1
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060822; x=1758665622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVk/SEbEzznq+9S0UaU148eBB2+2tKSp40RxHPejpAI=;
        b=MFeoWhZHmmVZkuhc5GL94xvjXe8o6j2sICa8WyTV9QsNnhgYXYU8nEA0mXR9I8LPr+
         ATIGwbkCSn+faKT8dxveSnmKCYLbPrUcb9zDwgo+iDP+sl7UmsHGudAG1vBqytqW/qb7
         sWiuA1c72GBaGk+QBZuIZ32FV/T3hjqGyqCx1/fh/e/qlEHfLEccPMMLU5oSXXAiPW3H
         OZJ1WDrqms5ceoWXpsg8ed2EZU3Np4MIKdhUATGS80FHtfjSr1sk9GqmKu0TH8XdbU9C
         t2L5CEIXtkbpp6P0G6gRCzQFc+TUE8ywMnfdIMsBrtugW3GVjQe9L+xoy/s2GmXvsrre
         I2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060822; x=1758665622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVk/SEbEzznq+9S0UaU148eBB2+2tKSp40RxHPejpAI=;
        b=DkA+XcCG17uk7K4oYKYTXQt7QgCdokCqRTx8d5xBHJM7ULlKKRwIiFqFk06UNepTeM
         g0Cw6HDJhYG1itTG369mC/onwfVD4xjkf11FCw3+tD6ShzWS8X4nDCKHfkStTLOaSBgh
         u5uTrvd4Q2/BN0LpGrRzWer40o1dtm7pVA8j72kXT1UV8BthvfDKyGxnuddSmqAA81sp
         kjuISGb5r/79GxbezpUs3EfR2pweM7u5hz6Z9PHSUEA2+dpsAvCNmfjnAbXZ5s7AwFiI
         gAOTTIMTmElHL/yBUN23yc+282Hi+dgTsVwCEK0GGS4w+gNK+ZOupVz/6aibr+KNviUa
         27WA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9tdoAqRKnXGn9KrkNMtgV/SPhGL6hNElkOivUIjSJSOap+mztHkbvyh3vK4G/nPENn6GECZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+A3xUu9d7ZktQjN7WhCTk8da1VRUWYgGQBGHBuM6rSJza4rj
	uWwIoUtsoHhWGUWAYeXdokXUWEaQLuZc7dO+l5mlPZ8zeyCyp6Z8EfFdwX+4vJRNDQ==
X-Gm-Gg: ASbGncuPlr/z0LAaNd4kCzeDRst3FFxdFsEHEvHm8kF/1oHNbUDWJSW4y+YLqk+t/lb
	XMFpdtLc5OJrgTpQDnxBi55BfYhXWsIZU/KMeTqg70iStzO9dzpTMjX1rVWoSLACAASHR7s2Xp/
	LGPEOugkbl4QX19+Tn6GBTVp50GMwW/7M1RyiDVVm+U3bUw+98mcTTehacEIVv4mYc3IT9Eh1jm
	DtCKS+tvt0bCDULq7GjU/33HpqkTXayA+7nGKhpPpfWk+bnex2dIA2WDvY1wi+/T88Uje3Skuip
	EwbKwWbBjMjminyaJrFCcXsPwH+JHN3glnMTUYQV/bPKGgAqscCxIMaFFTjzlAbHclPT2MSmV/l
	yBo0BWxIdl3qOq7xgb6aal88JT580HpFm4061Jz/WVEjeIK5j/21p2AJVbC9+KlqUuT03
X-Google-Smtp-Source: AGHT+IEZYT3KxPn/C21QpjEd43lkmb7fETnxfqKpQsM10eziHnAEfcJz3e9e+zeensN/SAaRNpSbcg==
X-Received: by 2002:a05:6214:f26:b0:77c:e97b:91b3 with SMTP id 6a1803df08f44-78d5ce634bfmr31939346d6.9.1758060821493;
        Tue, 16 Sep 2025 15:13:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-783278c7ea7sm43662926d6.46.2025.09.16.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:39 -0700 (PDT)
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
Subject: [PATCH v4 04/34] lsm: introduce looping macros for the initialization code
Date: Tue, 16 Sep 2025 18:03:31 -0400
Message-ID: <20250916220355.252592-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5413; i=paul@paul-moore.com; h=from:subject; bh=uVut6TV1PJIdwfEgkpNN77srM8Vz0L/dpZkLz41WDp0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7VafqACNXqa/p4/ASVOhq0v0XoMMzzDKHq0 /e+W2F++PCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne1QAKCRDqIPLalzeJ c/tlEADewOE87v22s4u7VzfGVaWMmtlNgkBKgoIntGp0qWo5JgXxXJa5rXnXHiTFeNLFlyAvs+B 2Aab3cQ32MrzcsWGpAtDYszfrqWOiNR38Om+yMxHSnEUwweavqO9RcIyZ+XSEZeRIseDccLBQNA vVifCGuCtG/TJdz77kkIc17s87GkgURQ9+klY5V7r8VUjrzleTnX2XE96blG4xodzutIALPqKa6 Jqj6WByngipaIKYnWJi3A1Tt7EWQEH+uX0Kj81sA1mxeQ+11wWE7r8ZbGaLWciRGzWWRrTLCkDU 7DCger+DbVwVUm7N0zii/z2/BBRD/0JSVv2AtkE37MpeNVM2ebbCG3rcYAvkPshY4Wi8RtvQOtB fkyTNh/pa7msO0KqaB4B0VGYCd+ZD7LwtKzEnw4FtLf/QCW/99arI8QBPN4BWEXFLep+uz/eUGg kEX/R5wpSCuLCbZXRu9QWbqNzd3IHp/5MUyaHP/CQVylo63vKHoMCylDvNbjnk7HefKA4pyFYyY 709r09UzQs2JVYPu2jgPYYKy1sDhPw1+MMlkKav0XwiarFyBykOVcLIYgvjIWnSfI9AEvHuVEo2 +erRITaXF1cCSgNgNnq5AfFA0Avja8oRs55cO0a2oi/0lW7oe8ggH68/abf3HFkyVBK3x5tXpvH gnB+I/feDh2tQSw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There are three common for loop patterns in the LSM initialization code
to loop through the ordered LSM list and the registered "early" LSMs.
This patch implements these loop patterns as macros to help simplify the
code and reduce the chance for errors.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 6f40ab1d2f54..18828a65c364 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -32,6 +32,15 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);				\
 	} while (0)
 
+#define lsm_order_for_each(iter)					\
+	for ((iter) = ordered_lsms; *(iter); (iter)++)
+#define lsm_for_each_raw(iter)						\
+	for ((iter) = __start_lsm_info;					\
+	     (iter) < __end_lsm_info; (iter)++)
+#define lsm_early_for_each_raw(iter)					\
+	for ((iter) = __start_early_lsm_info;				\
+	     (iter) < __end_early_lsm_info; (iter)++)
+
 static int lsm_append(const char *new, char **result);
 
 /* Save user chosen LSM */
@@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
-	for (check = ordered_lsms; *check; check++)
+	lsm_order_for_each(check) {
 		if (*check == lsm)
 			return true;
+	}
 
 	return false;
 }
@@ -209,7 +219,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	char *sep, *name, *next;
 
 	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
 			append_ordered_lsm(lsm, "  first");
 	}
@@ -224,8 +234,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 * if the selected one was separately disabled: disable
 		 * all non-matching Legacy Major LSMs.
 		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
+		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->name, chosen_major_lsm) != 0) {
 				set_enabled(major, false);
@@ -241,7 +250,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	while ((name = strsep(&next, ",")) != NULL) {
 		bool found = false;
 
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
@@ -256,7 +265,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Process "security=", if given. */
 	if (chosen_major_lsm) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
 			if (strcmp(lsm->name, chosen_major_lsm) == 0)
@@ -265,13 +274,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
 			append_ordered_lsm(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
 		set_enabled(lsm, false);
@@ -290,13 +299,14 @@ static void __init report_lsm_order(void)
 	pr_info("initializing lsm=");
 
 	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
+	lsm_early_for_each_raw(early) {
 		if (is_enabled(early))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	}
+	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+	}
 
 	pr_cont("\n");
 }
@@ -343,8 +353,9 @@ static void __init ordered_lsm_init(void)
 	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
+	}
 
 	report_lsm_order();
 
@@ -382,8 +393,9 @@ static void __init ordered_lsm_init(void)
 
 	lsm_early_cred((struct cred *) current->cred);
 	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
+	}
 }
 
 static bool match_last_lsm(const char *list, const char *lsm)
@@ -485,7 +497,7 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
 		lsm_prepare(lsm);
@@ -512,7 +524,7 @@ int __init security_init(void)
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
-- 
2.51.0

