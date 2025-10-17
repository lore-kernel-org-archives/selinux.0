Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B007354AF8
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732952; cv=none; b=RS2P+txrA5HaUBf3iG2J3gEywabFpw1WPHVv8rYUEyYvZ4GHmE37ajeKPKuCCxV9mSl3roIp/sK+KJ8Z5fih4GX8yn33G1M3+E2hs9joBBBM6K6F7gY0oYcdOjnMsH+HmfiuTXHFzGKuTEuZFQ024T3Ufsp7NoANsXzcoPHmyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732952; c=relaxed/simple;
	bh=Hkdj0OI5JGvnXUWu3kZ7e6LcKqeJJ0y+zTjBis11uXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nokkHstAknQlW+R24qFNPIzI121SJwVaRvHMLHe+o6nOHP3FGL1eDotfRZ/Wr1rXTd2aPUmrNzVHJzbq29RxHiLNvunrbP+6sm10sqpt2/w/SEn/r7PmCFwkqhJcpcTNfgYMwK0k7sbKuIFicLogEkIaezd3OMcDkrq1/F0tBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XwTH/m4m; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XwTH/m4m"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88f79ae58d9so311344585a.2
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732950; x=1761337750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jaiQLqTK88O3hgkSrlCVkxlRCh5w9zQGBkzoo50mK0=;
        b=XwTH/m4myY+YLtJyIBVH2mmqchK6vECTBMA72swMoyGS6c2eI/zBpiIAcETu9wqXut
         +fZihhqXpiAO9jWw/26CGRy/laFScTMxpfae5sw8AghMxOSzU5gcAGS97wuDTYikCAMc
         NUq1tmr0U9GXK2M105rx6FinVKS8rCdxfXAWBeJci5S1qOstbKqw2q1RxZwya9tSQGHV
         E9LXoPknyAxJiy/LZmwMp9Uvh6uobeOupwnMqENTFxCEJfN3KbsYG5H323R8WRaTK9am
         QV28x/15n/Nm6/dcaJjDkwu7wdT7X/RPaLKqJgETZav/VULB0T95zoFK4Tyd4fUx8Mys
         l10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732950; x=1761337750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jaiQLqTK88O3hgkSrlCVkxlRCh5w9zQGBkzoo50mK0=;
        b=h8YG2Gepgt3XiosCL4vjPbqsyRpBrcUQSiEPFGt66EHgWHMJlwwu06s1rwSyovzHLH
         m40qZ8ubWW38gzE57TJFqgskFu8AnrY31yHIQ0cZ1CQ+0pVm91xzC+RnYtZLIeK0rh3r
         HHQVW1PRAQHZGL1OPlXTGq4htredWb47PYq01qI6dSHY4QdTIkS/7WOKNt/uE/lP+CU9
         EQiIvaV4FYK62VHdFTRWp+rTbR22KxW6EXraUAgWrA2PPibsb9udZmYTZbsHqDKYBK1m
         qIr0KZvlrP9u7lHbM8gtJaKzPA9YSUC8ik5QaSFoMzw9xV/MMQi4VjZKTvUIxePogDMb
         OYaw==
X-Forwarded-Encrypted: i=1; AJvYcCWCl1XI7lzbj5xiMPjVL93uhWf/xNsjV8wZdhQxqL0tCTe0lrG9EbLIywnEzrryU3mMasIYh6LE@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEpXeVRNpglLaTCn0GN/ErVip+G0EydBxsWx1/Td5q9uIzqea
	uAbgRBTAoERssrr2xX2XwF40lAFeKP0v98xMAKqxZBG6XqGV4x8xMXSDoqilthybQw==
X-Gm-Gg: ASbGncu/DyxzPmBapJxENFFNJL2l/RFDXmnojXbOKOXL/XNOHQ9+XkPLr2wQom6F44V
	AaPeuATMCn/9WneibXSnIjOfEnMGQllG8FunFJFNyvAP5nDK6mAhzV++VDM3iDfSmbYVGUvB2Eg
	ZWoEgu3V4m9qz3/SgrB++DmzFYOrejz5rjcnvk0AxoaA3Aupr0Zkm8Y7AtqB3jD4abqsyaHaCSv
	T0cIKr0WKE3Rv0hx1cH6Zh4nX7c2q6uLRb9zhRGyulpd+B5+5VvkucCwFEQPdQmqXh52xCJdmiF
	Llc3zvTLXtRVZRnphJhmwVOOQ/J4O02Hb3RQb4CFAeO8AX6gK9B+9UO7ncvWodd1nfZYT4q0sLT
	qoHdlYlFvKe7SmRxOsBkahBpnLJhAvKJxjGBZ6GVyekMpYcRUH7ynsyDKjTjj/9aoWw9fzZXO87
	oUTS64SqtCmEjr2KbIpoKvDd1aIkHxqqVPjpNHat/klvKJcg==
X-Google-Smtp-Source: AGHT+IEtw775NA3ah7SYtQxU+JuV7pz7Eynz3OO4GnJm+Qc7/WwYCJ5of7onDXeNlNj49WNAEvKm/Q==
X-Received: by 2002:a05:620a:a1d8:20b0:891:2289:c8b0 with SMTP id af79cd13be357-8912289cb99mr403826785a.28.1760732949855;
        Fri, 17 Oct 2025 13:29:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd57c825sm40664185a.28.2025.10.17.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:08 -0700 (PDT)
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
Subject: [PATCH v5 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Fri, 17 Oct 2025 16:24:41 -0400
Message-ID: <20251017202456.484010-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=paul@paul-moore.com; h=from:subject; bh=Hkdj0OI5JGvnXUWu3kZ7e6LcKqeJJ0y+zTjBis11uXk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY/bpHjwlAYnGvTqNUcCI4NGr7OliF9vSWzN NQ6D11MM2eJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmPwAKCRDqIPLalzeJ c/W3D/988hhqWa5zZ5Lj4EZdjriGAY55Mrc7utuuQn4GAZ4+2C4p3LPU7XnpFBiY0vPqx6/M/Wa W8Ius3I2Qu/we/faYbCpoJ3kWQGwzriAUQst/5QSvagG7kuX81jw6TBrTMa+wwYGC01EEJc9Pu8 u+jPEDsglk4n9bZBWRaHq0eke5N/kDP5SoEyuf2sUf4DHyMuLnHUCpmtb3mRw6EY+qvX2wOU6fs qkFYk5bHZTTlaAHBKm1gq6zlCLf9OzgMYtS8eEL0WK9Jt08MdlqtOkQaX3OPVbSFRMyWAWIoGNc pxFsmbgiP/HHS/hC/p/1kiMOAgVqmO0ouk6Y3VaWxmOvkLfvFeqKPBMMBOFNkOKZEFQMFzWEr2/ b8envEFd4b3edHdrK8pP9RN6ahuepbuloELYyM6RDoT7OuU4W5m5oeqDD32kERL+IvxElN3d3yz s7I5jOFOn/7tD4RRzPCkM7/aEomfj5EwaEMCcptvhXnkiNhzB4HTRB2BxXBDqvI3SCKwaedwxPw R6gRzZmK7U7Yq/0gs2is01+rZBtWTBYz6FDbHgYGPajkwSyKRYMx/fBr/vt9iFE+TLNzoqx5Ykn KiMX8jy3XFIAls2pawT+zOMBtOJqC75XwF2c+YETB9TH36UGvMgJuwEYc1pYcwtHZFConahM0wb 7QMgflWFovfPURQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9bfc35b44b63..4b66a8cfe8eb 100644
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
@@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.51.1.dirty

