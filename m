Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B87485CFD
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330860; cv=none; b=CvgaEq2H5A3gVm1iRSVUl8leP//VugRD1kKdwln963bSM4v0xFmc8sZy4YexZ6FJNY0YecvFkajlA5ZRk6Wzeb/GmbqwNWtHRqsIarVZRGHfbdq1OqWdJG+jxSlOn1ibhXWaMPpZnbN2tJo/hfBRpR71O+y3fcmBCBtUFZzH2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330860; c=relaxed/simple;
	bh=qPd/zLCjnDYeWW2KGE97DZO3pvpcJEaZ8Ef6574QcEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLlJqkJE3B5TcBOfGdOIc+/nxedI2YzN64XosDIKyHXYF7dSFqYJK+3A98n9rSnUB93oesp/i0jEp2o5YFH8ajbXFwEin+11H8YROLcKI0Gl93mAhDKJwR9jcQYi6CuoMCpboLinnLe7bc4PIr3oTV7on34UQX5uk4nfJLNBj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS+jRJTX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS+jRJTX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5d50b0dbso71360485a.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330856; x=1785935656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bxlY6N8tOe4fP2OCMdJ14svDeW5jUc51lzYh09bZUE4=;
        b=IS+jRJTXjnMdg4We7JJeX4JKBvH535sarrNNdSDseMk7E8dTh6vJznJaAcOgXPJVoA
         eAMjxNz315+10ENBdVXEquZNbcQLSSwUOD7mBR255gAvE3+W2KOlo31iUS4tjOUXaBq5
         ZCz/dXOcMMqc59znqd1kUJekagIJ4vs7G2HMXYlwVVBXHKo87v5G2kUxSmm4U95D6zXI
         nA/whsfNsuhePUePI0V8IFtP0z7XVySRq9gSwo7c+mvlnGKC1Tphn9mSzbRGL+08fePv
         /xyq75Tj4fhPbA3rWnl3MmDBS87VFrtVweiUh2BTCAOQoitKAIuHrgiZ3NfccMSUlRP7
         aupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330856; x=1785935656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxlY6N8tOe4fP2OCMdJ14svDeW5jUc51lzYh09bZUE4=;
        b=cQZqQcFJRLQKigHteztDfDeyW/+rhVlAc3YSa+5kfg29ZPlsLUwe6YPlIxy7sNJbnI
         hwB3R/BvU6dGb+ZeijRKHEx1MJTGmoCCsjD1mMH+lN0gWyaNWAL7rPVH9YsV524tq22/
         8a57hnloQxsppVTzitQ1dZcE8BwsZ/o372mrjJw07KoMO/4S/0LCNVa4zS+prad7j/Q4
         bjYfxT75dqkFLuMX2dHeW2heKsV45emKnd1cMUHXKclUlLS/RLjpTkqwGME55mfHPqMG
         8zrXF9TgtZuja/1fkQrGjgsfi/vnLMAv19KevpX6wuABvwycYcMFCYDbCFICjBYykJi5
         d3LA==
X-Gm-Message-State: AOJu0Yw1P4dEJ9TGGypztX4di9pDei2COs4nTWUl4qxWIFV4ndQWfmr4
	3DuXXWWTwdNVPU+lWlczZ5j5jZmnbQWc1gc5RDTpoomXM2FNexKGFHhcTh2oOA==
X-Gm-Gg: AR+sD13RCj3/+BbINX4P/1i1Mt0gZt3iw8ZzkRNAXnfIg1GnaGN0vtUIJDv0xENuoAG
	fJC5rJjRIWI79lbuGjir3UFzQ2iF/qUJtt79zMRw+vOgc3GYBtOLMun9pp7y157EnLEf5Ivd1Vb
	JptJbunfasB7vR/s2TRfFNK1qjwsAfKk99ncFE1zISYE3HnEW8EeQeAIXHvRXkvOulnAI5P3n1N
	wkDAqRzsgF10iE1jxBXafsPRYEr07kfln7uijCNnBpK7u+0voKMgPu7b8xC2rwPpZezst3lTVaS
	Fo1rF6RcNm/wfwKX+9ZOPBQvPm5SZJK4+2/+grrJrrrIuTUKwe+49BaqCBAcZiTIOh6pGJ+KABL
	RB08DRM3Dm1VwEY4FbMkX1wikTr2CPdyzUVEjGRX7Xi8VlyxyUNCVip4tUd1Gc22SEJweL39WNA
	B7TvShKnT530dRXQQbO83hulktw8TaNvsu2RttPOe5ozldif6v0nSjJXZPhLrerfsMvXxoxY9TM
	2+/5JKtt4VpE+WTsYdzmBjE7quyv52P7ERrYmA=
X-Received: by 2002:a05:620a:4491:b0:931:575:b539 with SMTP id af79cd13be357-93302b0d054mr618898885a.94.1785330856396;
        Wed, 29 Jul 2026 06:14:16 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e735e0cdsm163731485a.42.2026.07.29.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:14:16 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
Date: Wed, 29 Jul 2026 15:14:12 +0200
Message-ID: <20260729131413.1390890-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
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
---
 libselinux/src/regex.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 7a4c5ecc..dca2353c 100644
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
+	if (rc == PCRE2_ERROR_JIT_BADOPTION)
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

