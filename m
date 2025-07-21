Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B924679E
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140264; cv=none; b=Ws/waAeKmH5pxOpA+HL5PhDimYT+lTxTVE2wdIYKgDzRlEa6p0t3AJWe74CSVgHHo8FJaTZXwhEMijfPSukwu45LmNGBw+O2BmEUU8YH0EURiYBS16iOOgp6UCdJq3FZtUjeaNPGsaQnrhYxTmy1znULLamfyJKHfHTq5FKR+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140264; c=relaxed/simple;
	bh=Y2hRlfpCiLuP1sucoYWSWj1pXRm67ck5wpz1JlBqpaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHxcK5pwu/Q2sUR+HrotmQ/DHVTdlYvlLhl9GuRpsnZlfab/gq+7MQjIkHFcZiYI8C2+H0E2hXjTHHMRmFRy1oT01YeTOSFNiXAMpK1jxQuIH0o7QuCI8lQMansSs2XjKWI7ByLh9a1XtAQ2LO8lOmVNLHJ3d5xosRwpk6Ck9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eq1W8Zcg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eq1W8Zcg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab9ba884c6so62424251cf.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140262; x=1753745062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMIP+vklhfbSXDcu+iaiVpcBtx2jZ7HFwIcQrOHkBHw=;
        b=Eq1W8ZcgaP67Kzo34lHuSdtI+Zfr6HVh946dcltLlFN0iYkuROXSCcvCvf07d8joR6
         KxvpOcti0TuYCa+8BgGi+N9N+VocWKlgMXbE5ysQqdZhRVBhYctUsG+6VfJN2sf30W6q
         wDFbcctQfdS6dMblAFkdEp8z+tgY79kwkbA/24S8Da9Aakp1jqbelGD5ZNwh9v5AWaIa
         Iu/OcK/avyuzoDSFcAtsdAD6GjdlXp/lY4F0C1LwSdjCh/oQzi/Nuhm2noRBo73ETIec
         jfoUBY4gcE26j5jLi0WUAO5bUPXUENHWzfGN8nUj2NI3GLyVIfbIGNHhpPpWsdos9Hxc
         9y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140262; x=1753745062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMIP+vklhfbSXDcu+iaiVpcBtx2jZ7HFwIcQrOHkBHw=;
        b=NYWXW9HRCexP1hwqFx9BkvgmU07Q0OZQ6okxUioTcuOhTPPMS2NjCAqCMlDgK/YvOE
         wvIPRbzxtybcDMsJOTjVRW6lpqbgs1rKUcwFTXZasGWoOnsvfcPVcnJnBh/MLN/AaMmz
         9vuvIWc01oAxv663IT/j+8HFA6GBRZhEWJ7xHVwRzfyHb5zCyQKQQ6F7OsDqpiUdoIiF
         XdQ+iLJui684fVdCSve4aHAMAXSQbyhnV4RSLcy26KsOPjmUhXngECZIUMu4tzqbMcdd
         wr/fJBgZrCCjYl2+gqF6VwRLB80fCOlSP8X/puSGHANDn2CQlkarbiohvOfpRWVmF0V9
         urBw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZvJpwIJIudGZgXXrHx/q0ZTguwDCEuzTLEI5oYujY7onKUUXtvoXzNSKW361wzIHXdw44jln@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZhib/QGOD7yY+r2CUOiPvkXq0k+T+FIDhsr3n+sp9kb/3RsD
	NLgEHuJKdzyM7ryW7g8RzgCYCJCWNiJhSTR3yM9BnTTiVpPH9AUFu2Egt4+6z9pp2g==
X-Gm-Gg: ASbGncv3ax3IydDTzCKslSUA9Yd8Jjk6jJpTI0yFr6sbExvpXNJNy7zNB+hfvw0GaIZ
	Ck/mpMCnl7p+vEj66K9ydPW9FiDgZ3oU23jdbKvr4iOpA7lYl7OIaV4GjUBWUU1/wGEnFVS6Fjw
	rfHRA4H3fkL35bJXb/HFckxugBWYZ+wo7bsAzeZO19DiGppGNeO4DrBq8SLpj04MM2eLv0wdRnN
	EOt4R3jvul2Gsvh3McnmqZPgPamQyx279kCf2v2atuduzc4PBe9UeaxdNWuTlhZM5Fbqu/XX/H0
	/oVNzX1HmFrU4MqyXeNZDxWmHO0GTZ3uS7vj9Rg9VE8ijPeunuwG99YEV6NrIWXQ4GHb0DD/wD9
	ww0lsa5GcjyNbLgfnVe5/eZb1/82eK+dXBCahIWs0r9mtegkJpAmF8GKw7xC1OHr7RvU=
X-Google-Smtp-Source: AGHT+IEHEZEGKqFY1O9l8UIYW4D8yN2kx2JeTF/l43FeyDczyu4F8qjiN5kPNnVvjxaM9ahcqr3jDw==
X-Received: by 2002:a05:622a:2484:b0:4ab:7173:ce8c with SMTP id d75a77b69052e-4ae5b464ad9mr27831741cf.0.1753140262288;
        Mon, 21 Jul 2025 16:24:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4981ec5sm46027201cf.11.2025.07.21.16.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:21 -0700 (PDT)
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
Subject: [RFC PATCH v2 21/34] lsm: output available LSMs when debugging
Date: Mon, 21 Jul 2025 19:21:24 -0400
Message-ID: <20250721232142.77224-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=paul@paul-moore.com; h=from:subject; bh=Y2hRlfpCiLuP1sucoYWSWj1pXRm67ck5wpz1JlBqpaw=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvTlnVeQCsYNiFO7davQCZdD+ljG8epLQRb+ 2FaPWrhibaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L0wAKCRDqIPLalzeJ c5PdD/40OgsbzaRLQzZ63S+u6quwh00vi5d9x+lg4I8csLtlOKBtRsmkpQ4oJutwAA54Kk1446R X6N8Fi3AscqcciJoLBhBHOkE08l10mBdai9PN6KkL770mqaNYw+wnf4Uq5B4RsWm/q7kUWMrHki Hhrhu5HDy3orCrImMwe83e9BzQoVGPu7ezEwI+bpFk+C2gHRhk4bB4l7L2jY/dQj4Y4JVuw2613 URB08GzzNu/Y78Ks2KyMgymp2R6y0vl26eMzG7P4UCj78/rjRFuTijohi9a6wNDyfvyhS2ew5IR DLWNUwYGk9tqSK99f7aeCaVa2uLPJr4hPhq3W1FmB8HonyOIWxd7EI+KsaTD4qNT0pTchwJ8yEs d3VkA1UOT6TcwrJjEl/2W9RioM4TZ7lfKlVmyj/AukoEtAqywJb//52r9RQja1aO9uA+0c5K6Ud 9qsJ3gUW2cl08zAtvlm21vnBC5jE0Gh9EfnWQtLFkF367yZWEkmVOqxVJZgKyme0KU3p6ajiitg ERwxh80yhUq/wLN5t0/8XYZLDtFq3+qcmkkDIMZ4rj4CZxl+TsGnnAWuRL//Qsw8ndhPTRYrxfC OMrb9XCWj+K84ujTUNO8yx8dbvESbKPYRO2XfHylRZQuO2cjwOWITUXr5vaLqOZBT1kQ2CdumOW VOuR5xZMusdhWMw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 0a8e4c725055..7e794f4515ea 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -360,6 +360,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -382,9 +384,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.50.1

