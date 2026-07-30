Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829143D4F5
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419766; cv=none; b=BHlAv5DPsPbs7OT3kynbp4x60VrM2mpSG50Ixq6Ts8qYWNgFBKMJ+MBxnaJ7Y0gF34BnkDQYeKiXvjz0ZA7HhAnDJaWWszeZmbWG6CRWXt1oSI4l2lF8VTjo22be65g2/xyzAqj8cuVimKaObRnlMI2RodfyzB4tEJMb9jeJa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419766; c=relaxed/simple;
	bh=DaxdwlOnreq5yTWIckKsa/qhGnT9VBAS7pKOHGUbvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ishdb99OQUhLdK6OO2ibAZU+WnIQxjcQcBh6cEyfvCEdOhoIksAHqJpoNm3orMyI7W4DRo/BOQAJCSnQdwEYTbYD6W6OFt5Fd0g0pQCgZTL890rTTF0AJcVBLu2HZ+wX4U02hsXYuIy7V4EHExcz0CT8ywJteyjMyy9SR4EnsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP61nVqO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP61nVqO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed19f4d60so52573985a.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419764; x=1786024564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wt/9siybfDy2eSbA+7ghQ9YcGhWGF7JVRY2SVgDfTHU=;
        b=GP61nVqOARHOSDMjZ+5rgu7no76eOpGXvZrP4r9LWfJryqc5WXOdXHCRYn5m56HJQU
         sTpqzmDCw91dJntooxEHt7XgTyVJ8uNT6rwJSgoe+3sQel6kkLOTITHwdg/hpO0ox2DD
         EpZTLeEM72Px8lFmayKYA18iR1lE3nF2btSDpVtx+u6BcRLoTymIOxEJKecJsmhuKgvz
         Jsg1cLEsQn+l06pk5SVS8JooWgjSzq1MxWJRgPjopsPHMPBzGkW2UvNzJ3yJUsf3snMe
         rbiQNp6MJjSRhVdnAWJi7rb6sjavvXtS9j01KS9DXeCfBu/qhg7PHzwj5BbFo1tcsZ7a
         uvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419764; x=1786024564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wt/9siybfDy2eSbA+7ghQ9YcGhWGF7JVRY2SVgDfTHU=;
        b=OvOZcsPhKpxKZ7cMI6+5R4uJoyk9v7mkiA9yZNUaOtfvQj8ZLWwAtuQC6V8vMvWkyb
         9Z1r51uOxhU/5F23z5AprvcJPQR6iuqwRbj0B6csRSWUUnWCMKOoiSbOcXlrXeoxmubl
         fXlQNAHJx5siTA0VID5WRqc1j5A7O3fMAEgZSXIE6Dwmp1WrjSK82kV3OfrozHQuRes9
         REnBrOaSZkVHvRhIn++Pug3VblbGOHKtC1tt2MZ2OAq2XN5TYYWbKL2PKaHVPDn5bpzZ
         icONOI7VUCAYgT/GjEkWozC0v6uhxlg9kLTIjpI33JIcIbzmG60y9Ion8wD3YC0i7+kF
         qVAg==
X-Gm-Message-State: AOJu0YwVHvigOFAVpID5e3aB41PjBuII00lUnvBxtn37InaNfMDl1Qmp
	fMx+5r6aT4ZN1GgL61zNU2VPPHc4puNeoMmxtjoIEbUssb1gmfV58rqOi+oHFg==
X-Gm-Gg: AR+sD13Z9XNRmn28W4YQvVDuWqui/GdnbP5rrHw3ZIFmH2vLy+nl6mJYbok07sSOY2K
	7eBvqkQTH5NlNJVLvjcMAgv6n3H5VVYe/+ScMFZzoafi+0mh2eaTPKKOjistzSYVHiV4ShPTHb7
	klNkZvS0d60Na8uEPE2kLKgXwV4pLLMNGLllFssXHeGAuILyueNl19flW+43OrHImECjStw46zL
	q1Abum6O+fOEC+oI1JrCv2+DlMq4mcsQzDefP3vzgw+KoHRZyQ+zlgGM7C89TQameDCKrToz91E
	PiY+r1T2lIq+KnEcS7fBYReYbdC6jADfKrWmGmPwvxHKO3TMgjEQPILNDA5389Lxw1tEMC/ZpMp
	za4x0fg4Y6pCoTBXWOxKDd5iEqttjGfjbzsy/1bm8WiuM9MnxYk2sZd8Ppbw5lSPZcOtrWk2QeA
	kVhrn9YQHnL3H2zaC0HhDRgO+ZaHJT22y4CytNyg1rsRzG9PEgnXaDereLkmPKQqABZxcOusR97
	mg4v8n6IdtfxgP0bGUJXWM/bM9k
X-Received: by 2002:a05:620a:630f:10b0:915:9f30:23cb with SMTP id af79cd13be357-9348ea3323emr35869285a.0.1785419763999;
        Thu, 30 Jul 2026 06:56:03 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3264577sm418768185a.17.2026.07.30.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:56:03 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH v3] libselinux: prevent ReDoS in file context regex matching
Date: Thu, 30 Jul 2026 15:56:01 +0200
Message-ID: <20260730135601.1510501-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730085713.1484927-1-pmatyas@redhat.com>
References: <20260730085713.1484927-1-pmatyas@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCRE2 interpreter is susceptible to catastrophic backtracking on
crafted file context patterns or lookup keys. Since libselinux never
called pcre2_jit_compile(3), the JIT was available but unused, leaving
the interpreter exposed on all platforms.

Fix with two complementary mitigations:

1. Call pcre2_jit_compile() after every pattern compilation (including
   mmap deserialization) for both complete and partial matching modes.
   pcre2_match() uses the JIT automatically when available, which avoids
   the interpreter's susceptibility to catastrophic backtracking.
   Note: pcre2_jit_match() is deliberately NOT used as it is known to
   produce incorrect results on some platforms (e.g. aarch64).

2. Create a shared pcre2_match_context with a backtrack step limit of
   10 000 000 and pass it to pcre2_match(). PCRE2_ERROR_MATCHLIMIT is
   treated as no-match to keep the lookup safe rather than failing
   noisily. This bounds worst-case matching time to milliseconds for
   any pattern/subject combination, regardless of JIT availability.

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
 libselinux/src/regex.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 7a4c5ecc..3f7df4c7 100644
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
 
+	/* JIT-compile for complete and partial matching. pcre2_match() uses the
+	 * JIT automatically when available, avoiding the interpreter's
+	 * susceptibility to catastrophic backtracking. Failures are non-fatal. */
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
@@ -262,9 +289,14 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 			return REGEX_ERROR;
 	}
 
+	/* Use pcre2_match() rather than pcre2_jit_match(): pcre2_match()
+	 * automatically uses the JIT when the code has been compiled with
+	 * pcre2_jit_compile(), while pcre2_jit_match() is known to produce
+	 * incorrect results on some platforms (e.g. aarch64). */
 	rc = pcre2_match(regex->regex, (PCRE2_SPTR)subject,
 			 PCRE2_ZERO_TERMINATED, 0,
-			 partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
+			 partial ? PCRE2_PARTIAL_SOFT : 0, match_data,
+			 match_context);
 
 	if (slow)
 		pcre2_match_data_free(match_data);
@@ -275,6 +307,7 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 	case PCRE2_ERROR_PARTIAL:
 		return REGEX_MATCH_PARTIAL;
 	case PCRE2_ERROR_NOMATCH:
+	case PCRE2_ERROR_MATCHLIMIT:
 		return REGEX_NO_MATCH;
 	default:
 		return REGEX_ERROR;
-- 
2.55.0

