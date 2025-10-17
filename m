Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28775354AD4
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732935; cv=none; b=HWBjvY0PxHHlk4TvyIYOs1xUayKmTI/xp167pEr9RA+YwcO19AsHVB79UiNbzED7OJOlEqf2NDKmxxLR7OJ674Dr5Qi09qI8F3s4SVRGrsovgSl0q8tc7Yl0UVwsDRTNheBXxoexfm2588fRmFKYE/HMucNXWm8EEcoc8yLCmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732935; c=relaxed/simple;
	bh=IcGvizNgZGL9h2FA62hxYLM232VPWr/gYb/vwf9u2og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjMvRKJUalGlLnhu+fV7n5bXADEeb81JAOyczISkTw09XhOvbByhcqK+fuGRQ5579KW3U3dqQ4Deouw8LI+q1o6KghG+UfGbm9d69D33TAYGTWpVhhdo6nA31mNQIY6cv9/DRChu7ktdqK76OkH4z5c2yS/gbdVsbu0ujzsn4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KCfwQxqN; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KCfwQxqN"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c1a760df5so43276596d6.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732932; x=1761337732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xSS0DznLyqvwKTxBm7wwaT98bLvbWmaxwhSSdXZFnQ=;
        b=KCfwQxqNEEU4hjCmHZd9jpNq75zphwuhP83zf/cvYqz6eZwqF6o+qhTRO/jpF9f++h
         AWd5mo+dpgGXbJ/tyzGTffrhUkYgwldPNLxAMqhQ4YoZEQz7UJIFaMzHfPvxiRZClYG3
         tmLF2xcIfTewcHb6bn97oiQ+wmfbQI8wg6e1KIMSRZELSQxclypgM5EE5cgLOPb4uW17
         f0ukmqQjOA6Kd5gB9DnVJ1sVba1i2125zbmecJxLiU0zK5k7taTUe4A+KrphgV8poBI5
         zzPduytKVT57fAzRyOIpBiJokhcV87WuLtNnZ7np35eIYhI4nJX+eRphE9s99UORcwNb
         VcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732932; x=1761337732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xSS0DznLyqvwKTxBm7wwaT98bLvbWmaxwhSSdXZFnQ=;
        b=A7qUnfmMaLS9SZvOPHCnq0hSqvSsvVKTBROmZQ+n+Y9RCSPoJZbQit/wrak2oD3+em
         /gMnKZSuCkPfHa5tAEZamjJ8JrxhL3bfhUHtKEDCnvVy51VIoCPOzJCKdDa+5EIzBirQ
         a0ltbECH5/Tf1e/Wh29NzKOREMtwXnyYYt858Jh/VjUlV/mMoor91CJ7TZTyyZjSS063
         kWdPkDtAAMgL5PLwdu0NyhWT+2zOH1qdg8biytFsqLfQhLfXPUX6avaVSuJcx14FBPIE
         SsmK9Lq650rUKdpd1i9lWs0Wz+gbHodEjSHCdIGmfpNgA8yj/O3Hh4v96mzUTbjdJwTC
         LSpg==
X-Forwarded-Encrypted: i=1; AJvYcCUMHJopeUXjHG5Ugg80As07/JYMKOCjmZYMs5nspUv0x1XLW3gfEyqivAlLxYWUOUesfeV5Y8qT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq63tE+D9QsupNm+C8q4viPbwcWfJkxgKzdBa8ZJw5Ay5x4ByL
	JyKFFmBIJ3X2tc2zkELa00+ylNz1U9YnfIpnXh1o+9bWB/mwPcxYpsLgWvjRhvzg9w==
X-Gm-Gg: ASbGnctJp2sS7hmOCk05tqsH5lhxmil0VY9DzISv6GqxOMF9lqudl7w6XYqMDhAtyOU
	MzyLLmvU2RxbGeUvhbm4Hk6l+qgD0ioO6wvmNCOD6KPHZOcAB4lmiTjyzw/Sl9f8OeRCJWCAEYE
	U6VcIV9I+0Z6n3UpQXbFaL1IEtaoPg0xIooOZo2UBprIlZMVzS/nhQtE9QDEm90R+O9Zg6TtQgq
	WMleFutrzVgsVOTudGM05ofRGk3ZC9b9l+5LzQOKh/8MZi+/CBkOS4xdqK+eQz5N0pZYPQgdWtc
	NSH+jP0FR6m0BHgI3PhoumkTa/2af6lqMIf5QSdhH6G3rponJH1ARItWlDz59iagJq6OackzAcL
	IdaPPjwm0NOyeAqNYW1xaHh/0Z/eKhs1vHjk3i4pLh8XNiBLTIvJOc6nZoKeeT1blB9ljqE0sQS
	SXx7XKL3zjQz6h8UXAu3H8pVeV1wR/363s0GgDw2f1hPYH1GYMVt8uyh9W
X-Google-Smtp-Source: AGHT+IHPL7mRi02sW10ITppWrGOnRoXDGDeZCAcucOTapOVnq81gRIQmCWGpCe8U/Dj17o6yilnMUA==
X-Received: by 2002:a05:6214:20aa:b0:87c:2636:5319 with SMTP id 6a1803df08f44-87c2636a5dfmr49540616d6.27.1760732932027;
        Fri, 17 Oct 2025 13:28:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8d0f2sm4679326d6.56.2025.10.17.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:50 -0700 (PDT)
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
Subject: [PATCH v5 04/34] lsm: introduce looping macros for the initialization code
Date: Fri, 17 Oct 2025 16:24:32 -0400
Message-ID: <20251017202456.484010-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5466; i=paul@paul-moore.com; h=from:subject; bh=IcGvizNgZGL9h2FA62hxYLM232VPWr/gYb/vwf9u2og=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYilmNWvqXA6HivCH6tTfGgoj3Zd1OcN9R0i 2fevOHcBxCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmIgAKCRDqIPLalzeJ c5VUEAC5b3widl3a934URy2Wtt1Egpb9dpbawwRAlgf+ygVzzp3TMapFTgm5eX5bQbeS+3VF0ue J6b2YwS5kFpzDToLbhJ2Nz0KcaE2Dqk/ZrIdxHcLT5ceV1vXtWT1+E3SSX+et1Zopo3iBCJlQBW 9GgcUaDzV2STSu+A6gFfI7HXa9PDcYFOiuPwcX6QwByq9UL9xIJnPrEMT4yKV4vrEOq9cGVVj2D BSutKVfc6r9c44fsQ0rRI4fnKZEMXZt1TwV1Z/1DRVmTwGq4s6GLwg08au0gv3jvZr+6hjElM6U K9ocrTaHRMWzeLE9jD45UbL1uExgTfqWmjZ0oeUpqN4xvRf77BEFSs+IPpErpLYq/yY1sM7AxYa glHMPobFhqO/rEYb+MUHrXg9KuUOWxJJ/YLKNI2G+KtxyK2/kNZRxMCiAg9QSStp4dVjMinoR4c 3M/VXUdDA66npguDgOcKTeRc1r9xKINL98wsXdOOVr1cLcnavRvrQvcNhjUkepVlnNJvu0EeEPX 1As/WaeU3iIiqAe+MQF06wcGZgyHC2GIiYbgY3JvPqmvfo0+m1gjCXCLIrkTzJF5YcXJWyZhib9 TsxWpdMneuKPqre1garPV99O/2r4+2q1LBb48w+6hBAwfQiqk5OeAGVYLzaxpHSzk2HMM96sGpV qp5CYo+/Xtc0L2A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There are three common for loop patterns in the LSM initialization code
to loop through the ordered LSM list and the registered "early" LSMs.
This patch implements these loop patterns as macros to help simplify the
code and reduce the chance for errors.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
2.51.1.dirty

