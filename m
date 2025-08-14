Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A55283128
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212057; cv=none; b=OnQfl0+olqVeToxTRh5P2iNPBoM8GoCHPVpjSY0CYnrI78LUyAAkIhL6kx88h7IMQm8BuzIbIL4b6EWO1Ptrm/+UnGVso3z7atNuPRvCf/JnVVzKF9JpijhPNDmv4ZxrOoMNI5/lsqApfEQ4WJrTjRGNmKuh6wNXFp/0/XMaWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212057; c=relaxed/simple;
	bh=pzwaK00Aq7NOOO/UyiK6nXSfD/m4UmWQNLqEoF8l/3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByGfttJ9aOYgFpNDd9pg6dtdps2qE68/o60Wkz7LJpcJ0q+f5z3pKLooD0rdH1l99ryL6by6+YPDIVdOgCV+U1f8aN3NQ1R0tL+aU5bQTz890nE5VVby7x9UhC+9RukPLj2IX4Uz08luONALIiDwfRl114jGQnNXNL8gccFBSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HekEcmaW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HekEcmaW"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e8706856e0so134146485a.3
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212054; x=1755816854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xicWgEd/N4kyaPHzfy07sYFHKQJNtJDjA6Rav4B/7wc=;
        b=HekEcmaWsVanmtY1neyX1HRvbBQmVKfYshThI3VSA+I4WG9S3c83LRSxFS0oIhT0z1
         gsw4ucwxq4X9o9AJ4GEIz5LOWXyAR7bK/czdeyp7eTkHj3H+SYqtQ3jeC+9aA6mOSjgc
         vv3sDyLxZC2m2w2elxFQ1Uxygfp7tth77vc4U41P4wumDaN+g1ylBWTe7Krf3ElZRjND
         4QScdzAm11qQcQip1bSPhUyvfFYIOnQWf3+5VXcCDsnzMamnAjBG5J6y8AMn+uFLmgBc
         J/oscTXejBmRIu2OAXRXLCVR7Vxf6cHr51RuUiVc27z1KbZW6zBmspz0q4TVdtnBJvUn
         k2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212054; x=1755816854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xicWgEd/N4kyaPHzfy07sYFHKQJNtJDjA6Rav4B/7wc=;
        b=HYW8sVedftgVyodZURRnF52syvhRrRaxoBLhyRXBPL0ozRhsIAwlM3iBJh2KZ6X7fe
         2DfZP+lHKogZNjK6z4GE56l4Q8I51Je2IFpFFLLpN0CXfyt5pX8NUOzlM2KUu61wYgIf
         QwqnE3ayRyeLqfSz5Q1CFuvQVsWjFSAMLg3pgSf3UvyObuIsifUIWqmX0M2pCt5c4tvR
         aaJ3XbQ/leicBBrdAMblPzc+hhvDfNQrdkNGjo4GObh2hDmBjHr2B6Q8g4ct5mOCzuDR
         PX3iHPBU59DGvAO+bCIZN/3yutayh/ptqHCCddq4IiMzendgIAkLPahF7hncZSCM52lt
         GUCg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Y6zkNt33a+MAoSJI5dIWc4wWZVouz/gZyu6FemO2taSHZVTLFMlKSkJWJ1aTRAE4Eq00WpEH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3qMBxJpmwtK+nF3OkTv746B02eqrJ8LQioSD5saSucTAcdmb
	AEN/hyFCNcqlftmtWZFP5WGUGOBCcidRLLrnsq2C2zKEWYoTiYhMUHIXUG331altTA==
X-Gm-Gg: ASbGnctpD6n8oABixNBsXIIkq7zwsggbaeucjPh84hJkehEd7SuiinsdhztGPSeVLF5
	nHBatm0LENVfq5cdel97fRhDPJsOhN1WocShSJP96P/tQYt4CyGmMkiy4TmCWw2x3koS/49F5pk
	51b4AvNeZm/Wx/XHd1vZE1XaSHBZTRox2BllYDQeY1bY5gm/CyLL6vtRGtf40Sxu4uvNRgFZqyT
	D71LYB/T+1IFw2lhRxEUJ2syUrDGG0P+wPgDPP1bjMFmL1VqQ20AqM5somAgkTNr6SWZZP4xV43
	EWzmGYbifFLhm9z+jeg1uY6Wf46zit3A9acOx3BdtU6ObfJcCCcWKwObWnhRM2BzZQGoC7bu0/o
	Z+Z1kgZNrYlYGZMtGKqx34JKiHq6t7D60r/iVaMhRLU8gohivaLq/2MmOngVF9eZtN5E=
X-Google-Smtp-Source: AGHT+IHt/kJb3lSOLbtm8dzOcpkLwY5mONObbLnQ47TCpWcbxVQwk+rWW31i4xyJVH9ElNmAhztvIw==
X-Received: by 2002:a05:620a:44c5:b0:7e8:c77:52cb with SMTP id af79cd13be357-7e871a44766mr567631185a.26.1755212054388;
        Thu, 14 Aug 2025 15:54:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32b20bsm44975785a.12.2025.08.14.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:13 -0700 (PDT)
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
Subject: [PATCH v3 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Thu, 14 Aug 2025 18:50:16 -0400
Message-ID: <20250814225159.275901-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=paul@paul-moore.com; h=from:subject; bh=pzwaK00Aq7NOOO/UyiK6nXSfD/m4UmWQNLqEoF8l/3Q=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmijXLQaVCH+4vx+yU55vpWJe8Fe1MBMrMWeo /IZmGPmr4+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oowAKCRDqIPLalzeJ c2Z1D/47W6pAra59ZpT18l8M9wUYfvkDnLjPtym+DFw/pI1D6oRlGEwMrA0zFghwddKmQ8vA43X h0xcHxnsoqGmgJvHsWo95QpbSdFNhFTvfM8pyp+ADIMQ+R0LtERXPocJg9ygSFmZL+kLC7dTkCD IGokCeB/3V2OvdjzphgBvmeAShBYOuk4yP8J2ILFWjGxlBVVSGwbxpIJulxanuyu0cxTVJyyT6b kAhzy4hXVzgPTzAyNQWVs982G7rg9NYPd7ZrggKkD+hJM+V8jUT9nFn+KLln6Ocrxkl9tVx33oL qQaEug3bm/y4806wtgxb5RaMPgXPDJ4Pi+/cRhCvOQCKrQG64eBWXqICLDmWREQrHh2JzoL3kr7 j89W9S2DMwERdFIl95XE8tPc8XZzJY6aw0E0++JMfjFWZ6c2Q0DhhvRwre4oPIBtq+HItlttUUg jP5QRyIwGXbcxzubTWq+R4K5fD7PIHd0/uw6ya/CXHfqDeCTSAmdrysAWPS5ZVtOqFYdWYmBwYn NGl08i8pu1rViNDKr/52iQnI+eQCY10tBVsL4YzOtCZqlhA1XIIn6IZ33mQuhq0EDFYeYvsK9Cw Vsa25o2G3rKgiRKOJdC0kupbQthvXyEIzMOp35fEqZtnQXnK4xnGzLyq4Asg7CQKCs1/dmVAmgj ZnU+BSrna/MOt5g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index a8b82329c76a..4a108b03c23d 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init ordered_lsm_init(void)
+/**
+ * lsm_init_ordered - Initialize the ordered LSMs
+ */
+static void __init lsm_init_ordered(void)
 {
 	unsigned int first = 0;
 	struct lsm_info **lsm;
@@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
 	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -498,7 +498,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.50.1

