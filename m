Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E243AC0ED
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132131; cv=none; b=oCpp6eDPQnzjzwsmSdDRoA35i5P7gzV3OFb8WWdnTTpBPgab5wHAi1RnOHsPm4aopt4pEgRvdBlbZNcBCjSAeHIko05Zh/LqZJb820O5u8aGJlWQXn10nFVnJ2x/xU3MTyd4oK8OpRt8oKV07+6L3AWH585mdj7yfubUksySYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132131; c=relaxed/simple;
	bh=jDSVJMFZzNW1d8hYuBMMKfk0qgvVYcGYSS3ec0FIzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUoPK9kNrADjFcptkONSb/66B3IUeNYldPxFIS+L5uGrhXr7rzX8qlWJSVGuXXekAOdbDx+0NtTIRRXw250W94hvzCHKfWRJD8CfqPeIOBeXaq8bnxBMyuP68daHJdKIcvJ22lNBlRgP26VEoSD1RqRZzByD07R3zbZA/JpWMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9rHiwvR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9rHiwvR"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92542fa7d07so45752285a.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132129; x=1782736929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENmhU+AHJnzqoT1afeAfRdvTQ1ZmhSejzUw13mXFrzc=;
        b=W9rHiwvRpsipgrx5m+sSFguVvRsCY1oPN+W4p4SJUs3sYAILKJGVEm/TIGOrisAE/5
         n6sQOmdFvZ2izgIVNR0SlPzmlQ98+kO1+9Z14z7TOc1gNuP70VR2Y/xHnMrtXR9D+bPq
         r5Htlka7DiEHv7vV1IbFDgrPtWybwvbRrt5pGFdkKk0EsozL3h3S/TwkGtwZy0FVaiXH
         +jBKSlM2+If42dXL1b9LW02xuNcL+6SoukHxtTiYwyGEQpnq0Ht84NILJcRNUKxiU6eP
         jVCQaNP+MNnFGkYEzCeVllOckIRHgEZZBLH+VdKL9bjZbfQXdvZN9z7ufUiv6JViKXnS
         Pc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132129; x=1782736929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENmhU+AHJnzqoT1afeAfRdvTQ1ZmhSejzUw13mXFrzc=;
        b=E1uv97gLthleuuaMf6WQfiOZdycD1B+Ck1Rhf2hZX3o8PVnaheiDgDeSP4agQcII+g
         Bm77L8RO4wcujLs7HnEjUQIMH1qjuz8mlwX61Xph+vGTfoqvcQCrmxh9uqKWqeI6HKw0
         I1YhfyGiZLGy59heWFiusdLO0+u9TasD7wA/DYAkCl76lgHnRY9qiyidVTnCdiLk7OXh
         z5eEBzz2SdqB30HuymP+dEUxEOAPYdsjaKm78NiLKzx9SwPnihVvsR0eLyGMAHU/MXYC
         TmS0FlgkK/I/OskvQ09HDY3fmR6TH6uMqkfpJcTB8BjAPKXl2FKyFopCn8vk53Xwj7qH
         rqDQ==
X-Gm-Message-State: AOJu0YxV++1gLfAsKhrS7fjPj/WahhybtVqtNqaBtN4o+CYUL5oF3Kr6
	qMkDmpUBKCyxnGmYmfwHWI4XFRfp4cEJmpi0j1kpa6c/29Ca8qOk3MhWTaGjRA==
X-Gm-Gg: AfdE7cmLL9zHt15eUzP0hP335XThtt5+2+gRdGi2r8TxSJ4fKta18luNnqP4ZnU8zXM
	dY1Lm/Dqt5mYg2Z+ojbJsrRqfewBXs8rRJ3bf+ArcJw8FSIUeGwNy8Bb3aRVlWNbsGoMfpG+VM5
	JEXox0MiK+XU+SXNwWlcnQHgYahi+rz4FZsk18A1bzjG3eNzCehexGCJwdxRlW8spVOWdrMOnvU
	BtQPT4rZsfec86CQgzE250bZ05TDYQ3RGaoGt0ZvEySe8MgPFlOXLuM26WRYmaVWWbbRtrzT1pi
	YbgLD9ougUuI7NF/ekZrwYTB1wH++TkU4Suod5d4XZTDU+0MA3uxQAGzou6VL94diYhpPdvyo5t
	Ff2ksRbZ2c+aMjWjEkFD29N0ZQPh4DixXrVkLDk29/6OKJtOVbDKD/0Yy7nNnhlUUZgio3MyFxO
	w5nc4L4/Wj6+CjGnMxaokuU81hCpf6FlcFYZxXTTF1GQRLyY7tYju3c/DfO/4fGZDq9O9dF0UnI
	JqRQWMYktDurjyW
X-Received: by 2002:a05:620a:6501:b0:911:dfb6:d89f with SMTP id af79cd13be357-92089fdc5f9mr1728879185a.4.1782132129431;
        Mon, 22 Jun 2026 05:42:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921db359a7csm903790785a.38.2026.06.22.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:42:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol: test type_set_expand bounds negset type values
Date: Mon, 22 Jun 2026 08:41:51 -0400
Message-ID: <20260622124151.31474-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
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

