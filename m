Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12083BCD14
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142428; cv=none; b=YAK4lKL+nJWcQkEZ/2KeY/fuOOrm8lWA7yADg+ZDOjwWwx8cM9145IcW+h1lDcj84+5K8YimTI+Jdu/8BCDIIkDXM/Npe4IVikekXpWt++iRqARXpAvcb10zFkvR6zmauwt2C6rYSuuJlt+d2wGdVuOH725Lq7dLyMYhCJ6+3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142428; c=relaxed/simple;
	bh=jDSVJMFZzNW1d8hYuBMMKfk0qgvVYcGYSS3ec0FIzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9J1xWHJPQ5/EcIuQ83wyMaZqWfvz7Aqia/nHRh7ZdpD5OCmRhg4+HNPGKh4gqGWpBXDJMOo5FSBRG51w9XglK0beoQFFGfmyj8GakbSIfKco8qb+wiwjVexliGLAFWG6J8heThczyIvqKzjq4GwyQ6jcJxysZmeQrRBQUV+aYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXqcjMJM; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXqcjMJM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-920f33347f5so264396985a.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142424; x=1782747224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENmhU+AHJnzqoT1afeAfRdvTQ1ZmhSejzUw13mXFrzc=;
        b=gXqcjMJMKor64rtMxGd6Mc9vlTfd0sU5uHEzlcYD9fOh6IYeXP7myItPW0MxMuTg+k
         gHy2PAdloEDuiUoo9d66vpab2JR9ISvCxhi+fvVy4+SmUHobHcTyimAOb/wBUkQfzsU0
         aXxic7yHPGD6G2eeVHgrFqhWKVstSkbR7UNTuwsiqoawRoBcgCoFpaJEKZy2lgG8yCKh
         a/s+DbJP21C1dZOqmNXFehctH+CdaftBOif6EENfx62jqIX4JgW4N884ppaynamTPFBl
         vCPMfHgZRwNLpJlyocyoztKWSxZOd+7RLMxplFAbjN5g945s/2qVwSDY9BaSd7xO3kPK
         2hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142424; x=1782747224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENmhU+AHJnzqoT1afeAfRdvTQ1ZmhSejzUw13mXFrzc=;
        b=O+T0nLWVZtqHIvyMyU3hGJGb+L8bzw6JlyXsyhyt10oOUzyej6SwX1Q0P0W3Z+VZhg
         6fEVLq2x1PQF5rVdm0r5FrACqXZYeiNO6TmRBiB1naLCOwyY4cOPxFnW9yHfUkBAGNTl
         mv6F/nixh0U6Bx3y/3RP8crf4Fokrpqk2VETe+POA7jQpHoL3anGL4+0rbGG6uHLCCi2
         pfgDQPIZtIj/u5F72hJntApfZOELjgKblU7uyPGNYS93cOwjRR0gC6Mr8OE5ExIeUltS
         Hj7ElPa/DmNX4pf51WDKmvicobnJl5iM4oujI48DUzjQwRC6UsADHEsAzEZTVnCqK2lf
         PaEg==
X-Gm-Message-State: AOJu0YxMP5IJmq5psjS6HQH/sLckEtofpueRBaa4ufZfGC4/tmDFtvTg
	hKv3kzqXtlyJ0xD5sL8Qn0sFWScdcLg359GP7QzTLWAkxlBv0tquoK2gzbjwbQ==
X-Gm-Gg: AfdE7ckJkj3xj71boEMP4zRH4hMrhZ84nJx4kzcG2XJ2VDIPAB2XqEqe3wzb6z1UUp6
	EeKNvG69huXzX6K0vLuH5pU3P6tPqbLSIe+P0eHVQSuvWHu8m/vkPMHqH7jZLgiSOiFr8vprsch
	nCDXdGaz5KJNbLeIGNV0gIFTCYLdQmwe95DH4fHIVMxKFk0kdx8W/yJg7QAwR84Q/z285gcH2yO
	PvQbTQGZsCbeNEk6FQxeicjBMtO3on+yJd1eQQ3AqSjTFhQM4BQeQDSH0wU7L2QXcHpQr08RrXk
	7XnsDSN0xMYMF2gS2QnoMudq0DAn340xXtQFPJa/RCxpiRszrAy9OKTOWt6fAqJXZy4SN36H72f
	8UlHirjsUNtvVDS1Ude4CDEr4N0vqoGWOB/KFs1yata4jA5v8zcsuvVrbXl54iIcmv1/qqHlTB0
	dNaPeqDKxqgYuZImoyNEK/gPhdCOv7g5fRfszAE7p5FUKof4KtBWFGv1eYl8awp+Qvg3hORb5Hb
	ZUkSfjzKJnClI2R
X-Received: by 2002:a05:620a:d8e:b0:915:c4de:7ad8 with SMTP id af79cd13be357-92090cb587dmr2495179685a.38.1782142424353;
        Mon, 22 Jun 2026 08:33:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd3923edsm2964785a.8.2026.06.22.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:33:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH v2 2/2] libsepol: test type_set_expand bounds negset type values
Date: Mon, 22 Jun 2026 11:33:25 -0400
Message-ID: <20260622153325.17783-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622153325.17783-1-stephen.smalley.work@gmail.com>
References: <20260622153325.17783-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

Add an expander suite case that drives type_set_expand() with a negset
bit one past the declared type count (p_types.nprim). Without the bound
in the negset loop this indexes type_val_to_struct out of bounds, which
ASAN flags as a heap read overflow; with the bound the call fails cleanly
and the test asserts a negative return.

Fixes: https://github.com/SELinuxProject/selinux/pull/532
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/tests/test-expander.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index ec879119..56977e09 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -44,6 +44,7 @@
 #include <sepol/policydb/conditional.h>
 #include <limits.h>
 #include <stdlib.h>
+#include <string.h>
 
 policydb_t role_expanded;
 policydb_t user_expanded;
@@ -222,6 +223,44 @@ static void test_expander_alias(void)
 			 1, 0);
 }
 
+/*
+ * A role's negset ebitmap is read straight from the policy file and is not
+ * bounded against the declared type count, so type_set_expand() must reject a
+ * bit that falls outside the type_val_to_struct mapping rather than read past
+ * its end.
+ */
+static void test_expander_negset_bounds(void)
+{
+	policydb_t p;
+	type_datum_t type0;
+	type_set_t set;
+	ebitmap_t result;
+	int rc;
+
+	memset(&p, 0, sizeof(p));
+	p.p_types.nprim = 1;
+	p.type_val_to_struct =
+		calloc(p.p_types.nprim, sizeof(*p.type_val_to_struct));
+	CU_ASSERT_PTR_NOT_NULL_FATAL(p.type_val_to_struct);
+
+	type_datum_init(&type0);
+	type0.flavor = TYPE_TYPE;
+	p.type_val_to_struct[0] = &type0;
+
+	type_set_init(&set);
+	/* one past the last valid type value */
+	rc = ebitmap_set_bit(&set.negset, p.p_types.nprim, 1);
+	CU_ASSERT_FATAL(rc == 0);
+
+	/* must fail cleanly instead of indexing type_val_to_struct OOB */
+	rc = type_set_expand(&set, &result, &p, 1);
+	CU_ASSERT(rc < 0);
+
+	ebitmap_destroy(&result);
+	type_set_destroy(&set);
+	free(p.type_val_to_struct);
+}
+
 int expander_add_tests(CU_pSuite suite)
 {
 	if (NULL ==
@@ -250,5 +289,10 @@ int expander_add_tests(CU_pSuite suite)
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
+	if (NULL == CU_add_test(suite, "expander_negset_bounds",
+				test_expander_negset_bounds)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
 	return 0;
 }
-- 
2.54.0

