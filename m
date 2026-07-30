Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD3489881
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401839; cv=none; b=oitNSD4Q5BCVSYljgf7YVS11IMHZ4wJMBhEjmeMOiXOLgrbhBcERqHFVk6NrJS/Rh5lWFL9btZMIBb6a+6HOSPFHYulUtQVoM1fO9YPlWtl39raF7kclX9gHWskUXV1AORMa6gtQGSryI1xlg2iJ4o3cUCMh1nZYXfex0P8rWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401839; c=relaxed/simple;
	bh=da32SrVr3de/upq6a4EzKQdRJUkXG9mIls/tr8W4hQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxLByTTp8enQUlvYUGdjHsfSp0X8lJndpGBJ9fx3zh8Ii28GOAfZUamJBpSqTe2O0Bole4a5C2F9xYiSlhCHDeK1bP8cwTRMdqgE7HUiQd33Z5VSgpm37wgrLlNeX5UP1h2JfN/zOPO38L7y5Vq4yV2wJtCjjCI8ZameZpDxMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emmKqEF9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emmKqEF9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so10851811cf.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785401836; x=1786006636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0k72AiPdJyQPYparRRo7nFEl9PrLLjozH0QUidNvJo=;
        b=emmKqEF9jb5lurDq1tSfE2wzMMsY17vfh+E6LAv/3/5WmLgkshcMxlvRMsyB4QRJ4e
         uVv6ua7BYe/LWmT54NNLzVnf+2rphwG7arNF7U+tx6ydI3fjuvkCCvEqZoEouJwcMiJr
         f3UffCVJnR8zb93Xa9g39VfRrzNgvTD8ZwwZpFyFOR3jxw/gV+HjLrOueEXQc6xuVXxB
         /L7ZihHLFM3vHMfF1U1S22imsrmUXKhxyc4WahWcfQY3NMyF44NMsrKYC6oLXcuURdVI
         SfZbet7ag0yCtKrllVE1bWHSfi56mh0FYWamthSbUZSG9qEtv2WFUm7Rfa5G0XHvNhNi
         E//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401836; x=1786006636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0k72AiPdJyQPYparRRo7nFEl9PrLLjozH0QUidNvJo=;
        b=My/fNCnq6+e5SF71bMnSjW10VVaWZokexVMOUugJpWo4MGDr2z1vSDDGvVwaFHRJAF
         0OLQpFytWyg1Bs4+Kb2x23bZ+jTf7NYx11PsoTu/LCgkP1JH/la0K+S9AZ6e5lWZUZAF
         mVPEpfNZk0Ccm39duYfz3UaUANkdsLvIyK3Y8xsge16QKWqk204C5EKgmyf+MGyccp1T
         xpPBjhh0ih83U4u4ELbhw+DfZktN3Xd9hiu7d5dFdonutOHHL5hY1+cuStImBMOOsnRX
         H9F6T3qDeTWXE1dFqd7Z80thIVp9k5jAJdz9psyBLDQ+el0SokRQtxbHtYXQ2hwky3yn
         9Qqg==
X-Gm-Message-State: AOJu0Yx+2YAdVCUGKEkxaVSFhSrSa7He6XyuspbUTgjWCiGiiCYbIHDi
	B2Y5HPhIE01hZHf6Z0u6OdTUOp9ju8QDOotU3xCGNMPrq/FgYsqy+tI6OoXcFA==
X-Gm-Gg: AR+sD10DKiqdEWL7c7Mb/1DUUDWH1SRyCxK4KQQ9lm0EAAaix8FxwhHHS4wW2qgfnBn
	2T7UxZQ9oGEYV5YGdm1T2zsCtqgUAIRy+RicDRgOy371Oif8veEdGbB5UfwcTp1J5GYzUzNlt/3
	K/xQXlSNkM5DkvWcKbYAIxWH4VWcFWRJIEkPhIilZco0dqSsbMmZcIA+munNuddxrI9Mk8Xp/YD
	uaPlwcnd9KUh2uTWaP58HLSa+M5zyNbSd+ewvsPMw14zRvnu+o7JulwU2NmJX74SBCfZQ5OVd4n
	vy2J8Gtlu649QCQGo3OMLyVxn+WYrIM32rJ0NZnqtBzROw0hayNh7SNnGviq5KunWvzdkm6H0t0
	HDpMPiizKsBa1BYJvMcv56SdLmdlufhxpmByQub8ckwRMa1RpkA1yeDybG0paexskAaBSRSzcpA
	U3fOYc+55teNFlXwLeEqxSyu7CQeNezcI9p8of77dU0CmFslfYhd7KZEeuIbNynJpYQvyBBvEtR
	oBPeZszZ+9R+mDhJDelpi4hWSU/
X-Received: by 2002:a05:622a:230d:b0:51c:bb79:a52d with SMTP id d75a77b69052e-52b385fe051mr18568491cf.14.1785401836443;
        Thu, 30 Jul 2026 01:57:16 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e31f25c1sm38289261cf.31.2026.07.30.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:57:16 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH v2] libselinux: prevent ReDoS in file context regex matching
Date: Thu, 30 Jul 2026 10:57:13 +0200
Message-ID: <20260730085713.1484927-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729131413.1390890-1-pmatyas@redhat.com>
References: <20260729131413.1390890-1-pmatyas@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCRE2 interpreter is susceptible to catastrophic backtracking on
crafted file context patterns or lookup keys. Since libselinux never
called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
available but unused, leaving the interpreter exposed on all platforms.

Fix with two complementary mitigations:

1. Call pcre2_jit_compile() after every pattern compilation (including
   mmap deserialization) to engage JIT for both complete and partial
   matching. regex_match() now calls pcre2_jit_match() and falls back to
   pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable or
   not compiled for the requested mode).

2. Create a shared pcre2_match_context with a backtrack step limit of
   10 000 000 and pass it to both pcre2_jit_match() and the fallback
   pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to keep
   the lookup safe rather than failing noisily. This bounds worst-case
   matching time to milliseconds for any pattern/subject combination,
   regardless of JIT availability.

The vulnerability was reproduced and confirmed fixed on:
- RHIVOS 2.0 / aarch64
- RHEL 10.3 / x86_64
- Fedora 44 / x86_64

Reproducer (149 bytes, base64):
AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GCygKeAYG
KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonVy9XV3cy
eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=

Signed-off-by: Petr Matyas <pmatyas@redhat.com>

libsepol/cil: Return SEPOL_ERR on failure to set bit

The functions cil_typepermissive_to_policydb() and
cil_typeneveraudit_to_policydb() return rc when ebitmap_set_bit()
fails, but the rc value at the point is SEPOL_OK.
---
 libselinux/src/regex.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 7a4c5ecc..af4c4328 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -41,8 +41,17 @@ static pthread_once_t match_data_key_once = PTHREAD_ONCE_INIT;
 static int match_data_key_alloc_failed = 0;
 static int match_data_key_created = 0;
 static pthread_once_t once = PTHREAD_ONCE_INIT;
+static pcre2_match_context *match_context;
 static char arch_string_buffer[32];
 
+/*
+ * Limit the number of backtrack steps to prevent catastrophic backtracking
+ * (ReDoS) from crafted file context patterns or lookup keys. 10 million steps
+ * is generous for legitimate file context patterns while bounding worst-case
+ * matching time to milliseconds.
+ */
+#define REGEX_MATCH_LIMIT 10000000U
+
 static void regex_arch_string_init(void)
 {
 	char const *endianness;
@@ -94,6 +103,12 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		goto err;
 	}
 
+	/* JIT-compile for complete and partial matching to avoid catastrophic
+	 * backtracking in the PCRE2 interpreter. Failures are non-fatal:
+	 * regex_match() falls back to pcre2_match() on PCRE2_ERROR_JIT_BADOPTION. */
+	(void)pcre2_jit_compile((*regex)->regex,
+				PCRE2_JIT_COMPLETE | PCRE2_JIT_PARTIAL_SOFT);
+
 	return 0;
 
 err:
@@ -148,6 +163,10 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		if (rc != 1)
 			goto err;
 
+		(void)pcre2_jit_compile((*regex)->regex,
+					PCRE2_JIT_COMPLETE |
+						PCRE2_JIT_PARTIAL_SOFT);
+
 		*regex_compiled = true;
 	}
 
@@ -212,10 +231,18 @@ static void match_data_thread_free(void *ptr)
 
 static void match_data_key_init(void)
 {
+	pcre2_match_context *mctx;
+
 	if (__selinux_key_create(&match_data_key, match_data_thread_free) == 0)
 		match_data_key_created = 1;
 	else
 		match_data_key_alloc_failed = 1;
+
+	mctx = pcre2_match_context_create(NULL);
+	if (mctx) {
+		pcre2_set_match_limit(mctx, REGEX_MATCH_LIMIT);
+		match_context = mctx;
+	}
 }
 
 static void __attribute__((destructor)) match_data_key_destroy(void)
@@ -262,9 +289,15 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 			return REGEX_ERROR;
 	}
 
-	rc = pcre2_match(regex->regex, (PCRE2_SPTR)subject,
-			 PCRE2_ZERO_TERMINATED, 0,
-			 partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
+	rc = pcre2_jit_match(regex->regex, (PCRE2_SPTR)subject,
+			     PCRE2_ZERO_TERMINATED, 0,
+			     partial ? PCRE2_PARTIAL_SOFT : 0, match_data,
+			     match_context);
+	if (rc == PCRE2_ERROR_JIT_BADOPTION || rc == PCRE2_ERROR_JIT_STACKLIMIT)
+		rc = pcre2_match(regex->regex, (PCRE2_SPTR)subject,
+				 PCRE2_ZERO_TERMINATED, 0,
+				 partial ? PCRE2_PARTIAL_SOFT : 0, match_data,
+				 match_context);
 
 	if (slow)
 		pcre2_match_data_free(match_data);
@@ -275,6 +308,7 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 	case PCRE2_ERROR_PARTIAL:
 		return REGEX_MATCH_PARTIAL;
 	case PCRE2_ERROR_NOMATCH:
+	case PCRE2_ERROR_MATCHLIMIT:
 		return REGEX_NO_MATCH;
 	default:
 		return REGEX_ERROR;
-- 
2.55.0

