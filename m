Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9565369990
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606539; cv=none; b=Z9CHd+ngFWqxWPm7yejqOGAEoPAJQT5Axske0KIAzmZOHIbGqr7go3Ho7Q0VueB+h984FUMvDM+rAdfIMyHLoTssYzXU69oYOIcei5VHiTW+OniSbQIRMjTu5J0RkrVveB+Tbep2eGjJ67EfTl7KQb6wfDDuKKUTMp5MlJ2vcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606539; c=relaxed/simple;
	bh=nyDTd+LkWS71fv71Wk7j3KM9BYFq2zc6wCDU/34D9p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+wiVu3LFQXcGUH0xNy1R/JOi6ty64+B82Fss9R7Jvbqh2QzOeV6RBMYZtB4yAUGwwlQnTF1izAT8pmtQ4+tcubZR/H0ATMQ7IYZ6ws8OmZI+T9VsnYqZPX8sB/dA+SO2/CWy/VuzAvXQGkiNvd7Ci2cWjL5UDKG/XQ7IT9fv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMwqoO4Q; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMwqoO4Q"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52cd38ddcdfso11112731cf.3
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786606537; x=1787211337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hracVNzfAJ9l0Qzc7KWa++WDer2XxHVVAmJRvTWdB/I=;
        b=cMwqoO4Q7g041qIIqQfRrlbc5l2LBVHIMzDzYxP85hw8BpJBZrxfvr0ziN65+OwXvu
         qEWV/TcG5Cmgdnbuv18bAyiXGjyzMnLL9/g7KKcXg95c3T9bmc9p4cv/PZKpYRD/seZT
         jz8jLZ1mU0xt/AfWiLdSGVpgXNOekvikI0fUkmgknnMR2zC+zd3SmaZ8gUkBSX/F1gnR
         YvNj0lcxdTmrt+aJnqLRirk4ro7ZCpt5X5lbs66YI2IceyDIzsMQPg+MUVV2C8u1//Gr
         WkjCo3V6i9X0CDd8D6blSiyW8Npqr5aUn4ZKAEk2rUCnk9LuoSSJrSio6MFkr7x2/yxm
         zfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786606537; x=1787211337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hracVNzfAJ9l0Qzc7KWa++WDer2XxHVVAmJRvTWdB/I=;
        b=gmJv4pwmkMPqzF5ERb8OfeI7Aq56BOf6DTqE5lbDtDt7a9I+xzTk/8cuNeelcniUpj
         me2TB9Mo/niHQQTrl0Qz9xP89Ab0YCf82bPVWd1ORnwm4T44UMvJyy6jJiVos/r2oK7I
         LHJT3gwnTeINdXv/KyHWfFRf1g0o1xBh2bRlt9ttarH+ulTnM71dcUkZ+7TIgkhWqvxL
         GPFLNO86kDGikQpJ9YvGzdbciGzbDI9OdW3ObGg+iE6kioiDyV9+Q8KscG1G22uR+hL9
         3rwQdc5GN/csVEMRyL5onHxORyzkcDCgl51YIzbCcs4e/LjXedkLn0tU0X8w+434Yp9R
         zR1A==
X-Gm-Message-State: AOJu0YxN2hQinGV9Za9OF7WUhnvOhR12+bidztvM/yhm+5mXXv4OA+uE
	ze38fY2gxvOHgPYWVjm4/cPa/YpKhnp9zZjs2d/E3GwJCMQyhC2H8z99UAY+TA==
X-Gm-Gg: AR+sD10wEArBTyCGfWrX2lKDrh+wm0uwPpz2jZ3HVDrMOn7C4SmCwpQ6CGm8qCj2/vB
	HAT2MFaWACmfOVU+rpjVZTDnR8PFYm7+oMj1uQ7EYkUBGBvuDihpzLxerHtnE94VbhahA8/Y3zI
	fqQbLe3sDBXsPWWH1WUOEt1r7ie+kwOVbTszwDM+aFBR6nT+w2fafoMr1VvJ89nl1kFvzi2noF0
	JGypU6ffQrCHUjpVOJwQZB140XIsBrMgKzB5DP+YrGv5AQ00+sW8MmqCQOYeezdsRA27FWLT4U4
	6JF8WZH8DxguknQlXj+jMGUz9MltdaEchgXz4mReyWVWzNN0AE1WElrK94FW/LN8293V5Lom1iU
	8ATeWH6m0hwQl0sIx5LqYVSf2WXCuEsxaqk0ztqMrI+tENLy0hxgq53MVAfF/tARXU50N8AMH6J
	FsBqMLOenmGDo9QzUUi94kjBZi0H8mjWkaPPPDWGgYd6OObdPWwHnoK0u5053/MSNLP2r9S7DoE
	eWlM4Ux8snNS34OgC0Z7ICpjo0=
X-Received: by 2002:a05:622a:30f:b0:527:8770:8fd6 with SMTP id d75a77b69052e-52d73dfefbcmr35393811cf.35.1786606536585;
        Thu, 13 Aug 2026 00:35:36 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a817bb1a6sm9554236d6.12.2026.08.13.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:35:36 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Subject: [PATCH] libselinux: fix SEGV in JIT matching of recursive patterns in partial mode
Date: Thu, 13 Aug 2026 09:35:33 +0200
Message-ID: <20260813073533.3253251-1-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCRE2 JIT compiler has a bug in its PCRE2_JIT_PARTIAL_SOFT code
path: patterns containing recursive subroutine calls (the (?1...)
syntax) cause the generated native code to dereference a null pointer
at match time. pcre2_jit_compile() returns 0 (success) and the
compiled JIT size is non-zero, so the bug is undetectable at compile
time and only manifests when pcre2_match() executes the JIT code.

The root cause is an interaction between OP_RECURSE backtracking and
the hit_start tracking mechanism that the partial-soft JIT uses to
remember the earliest position at which a partial match was seen.
No fix is currently available in PCRE2.

Commit 92af7f1b61db ("libselinux: prevent ReDoS in file context regex
matching") introduced pcre2_jit_compile() calls with both
PCRE2_JIT_COMPLETE and PCRE2_JIT_PARTIAL_SOFT. ClusterFuzz
subsequently reported a SEGV in selabel_file_compiled-fuzzer via a
crafted compiled file_contexts input that triggers the bug through
the lazy text-compilation fallback path (version/arch mismatch causes
the pre-compiled PCRE2 data to be skipped, so the embedded regex
string is compiled on demand via regex_prepare_data()).

Fix by dropping PCRE2_JIT_PARTIAL_SOFT. Per the PCRE2 documentation,
when partial-soft JIT code has not been compiled, pcre2_match()
automatically falls back to the interpreter for partial matches.
Partial matches remain protected against ReDoS by the 10 000 000-step
backtrack limit that was introduced in the same commit. Full matches
continue to use PCRE2_JIT_COMPLETE and are unaffected.

Reported-by: ClusterFuzz (testcase 5660382656790528)
Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex matching")
Signed-off-by: Petr Matyas <pmatyas@redhat.com>
---
 libselinux/src/regex.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 3f7df4c7..017647b4 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -103,11 +103,12 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		goto err;
 	}
 
-	/* JIT-compile for complete and partial matching. pcre2_match() uses the
-	 * JIT automatically when available, avoiding the interpreter's
-	 * susceptibility to catastrophic backtracking. Failures are non-fatal. */
-	(void)pcre2_jit_compile((*regex)->regex,
-				PCRE2_JIT_COMPLETE | PCRE2_JIT_PARTIAL_SOFT);
+	/* JIT-compile for complete matching only. pcre2_match() uses the JIT
+	 * automatically when available, avoiding the interpreter's
+	 * susceptibility to catastrophic backtracking. Partial matches fall
+	 * back to the interpreter, protected by the match limit. Failures
+	 * are non-fatal. */
+	(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
 
 	return 0;
 
@@ -163,9 +164,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		if (rc != 1)
 			goto err;
 
-		(void)pcre2_jit_compile((*regex)->regex,
-					PCRE2_JIT_COMPLETE |
-						PCRE2_JIT_PARTIAL_SOFT);
+		(void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
 
 		*regex_compiled = true;
 	}
-- 
2.55.0

