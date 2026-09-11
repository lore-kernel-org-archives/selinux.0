Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CE3603E0
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137248; cv=none; b=CcFeUkmZsyYnpjDB9oGB24OMf7qpStybk/YpFhfH+bOO0U5E8tY7R7pOeLdpJ0ccwJQeX4QOZgbWTgCNG+Rc0WM0z2WI0hSr1pcJy9a5n51iC8Lihq//WzLzABSl/kn5xBn8heHoHw2I1rUkHsGyRLBQwtVaY4XGUomjYIE7Di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137248; c=relaxed/simple;
	bh=r6qkHCLoAfjQdrB5Fr0+AbbfWFePPjBXt+9S/Y1BxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSSklbb+3wbbDvc/i59kI8NuruekUquk8xWyCj5l2sH7KiNV2z2gFntG3iHrPQ/E+DrqH0PaApCfVGE8RE1lzcOXPC/vmiHkTuy5zXYTpOoZyp9emDgPkv2l+MvKPx6E+6XQgAjeTrHr/UsLAiSYqPMGEoQMYiz+wVqFFS8QNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5JseOPw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5JseOPw"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-939f5f82829so36142585a.1
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137246; x=1789742046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vq2fy3RvootsmOwnoOtlkkb6arb+NlBEA12iUo+pYI=;
        b=i5JseOPwgY/g3Q742xR2L0AeHXyh9XlR5kAgdWAGHKQt8mhb7xZ2sWJY8/3admI1eh
         4AGtoG7q59eTGxEYiXzQUHCMkS4TtEnm7F4DBYRXUWaS53ehxgXFnSkL1AwT1mnfADGB
         SvU9xv8o/mYI+AnqZkMITPEfgmrUYROZWiLi0TJ/51/sQI/Ywwyr+Fg/anea/2zMo5Rk
         OFRUl9zjTHcjYU0GxdauUwbmUGfiruHOtosTK02WErPG9NzI+RZFL4dbUKXNTKbdQfFO
         SLcUbV+MNtnwvo1oqZHVi7tR38Zx3fV8zr9Iz5OGYOnnP38aYDjk2JCI1ZNh7zWxbOxS
         na+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137246; x=1789742046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vq2fy3RvootsmOwnoOtlkkb6arb+NlBEA12iUo+pYI=;
        b=qwwQdeb6gs3135CVHAIE3t50KWcFNdO3HR0NZYEiUN+HpVJq0Quvs5gOXmdt33gsM5
         2PlGv+lTz7yxhvAQvN9TWqTr05wzCAmQjcLF8ulAP9Swac0K1UAL+F8SBCy6PJWkO3PT
         ITnSvsgk8TE8Q6oiZeXuXqa/QvuzVz54bTDUx2PgUGl9aLTzHyHERoeBs+sGyEUtvXbY
         yPD4l49jH/P9GR+IpBLw1E1D2LoD41glcogvR/sdIaq/I5q5dz9HDhRwvgbD6Icey1ek
         +V8Vziau2QwQGamPoaQKV8OcqwXMDSaGpV3FN1Y86OJa36Wd5Hruh4jMPcNB9ytsUO7F
         Rzkw==
X-Gm-Message-State: AFuF++lMWPKgFntuknLAtgOgVxj6rkVL4Ua1g0EkqX5NLowmtKt2jYxA
	nBbyhJYBygUly17Idbb0Jj6mu5b3v3h+NN+jiFYhtICDhTpHRJCM0JEujl7VDIT2
X-Gm-Gg: AYBFou3tUy6ynJHDB0+ACZ9URHi+en7jvem6LTosDKNYZ7lLzuUAsEV32LObG8/wdaC
	NhLaPok2C/r2RwAR6kAVK12KKKuNKu4CPV8e8ZCCi2BVhOrLydaEqszMGHSeSs/SuuggkaDUrip
	xt52F89i7+HpoDb3HsDDLeb88qygxifvm6rOstHZqvk+CDZ0yICgvOjj1Mv1GYPgMY4zzoXiVBx
	hNBLWsiFs7XYKRFpjlxNCNxdH5iKmXlQs8Dgw0WWcKxdFNu9SEUu5qVWHfVv6N/aZ8vyWRlYhLX
	mucjtEDQKL+z52jgQnEMvB8EJiyfqMdHbWPJh3+eZujp8nm1RHQzZ2R8YIZzIVSCiwfD4Yl86m1
	8NBLExXOTp+wzaR86jmn9HEjLJ5xNxfPfL5grqQEtqgGLNvep4WPcY4nKopPvG4oo4luM+vWcof
	r3tDH6BmN99W2XHOr5BqjYUJyfGyEg63Buj6ws8i5fyHtdHbFuHCripXfir/l9PxrUA39mnvIuC
	ad9T0d3B8u7j1WomyMIG0ToV5kcsumzBVgCcLEklx/h1Bkn2yaQhep7CE1tjgH+KbUOpmgH4+Y=
X-Received: by 2002:a05:620a:4453:b0:939:af12:f5a0 with SMTP id af79cd13be357-939d7f8bd55mr1151584285a.23.1789137240950;
        Fri, 11 Sep 2026 07:34:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d35a9sm22029506d6.41.2026.09.11.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:34:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] libsepol/fuzz: link a trailing module into a base policy
Date: Fri, 11 Sep 2026 10:32:29 -0400
Message-ID: <20260911143226.17807-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
References: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

link_modules() is currently invoked with mods=NULL, so all of link.c's
per-module remapping and copy paths (copy_module, *_copy_callback,
copy_scope_index, ebitmap_convert) are unreachable from the fuzzer.
Two of the recent link.c hardening fixes (d7a298a7) sit exactly in
that dead subtree.

If a POLICY_BASE input carries a second concatenated policydb and it
reads/validates as a matching-MLS POLICY_MOD, hand it to link_modules()
as a single-element module array.  Existing single-policy corpus
entries have pf.len == 0 after the first read and behave exactly as
before; a trailing blob that fails to parse as a module is discarded
and the base is still linked and expanded on its own.

Ship a base+module concatenation (the test-deps pair from 34610ea2,
which link together by design) as a seed so the new path is covered
from the first iteration.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index c75d0106..977fcfb4 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -28,7 +28,9 @@ static int write_binary_policy(policydb_t *p, FILE *outfp)
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
-	policydb_t policydb = {}, out = {};
+	policydb_t policydb = {}, out = {}, modpol = {};
+	policydb_t *mods[] = { &modpol };
+	int nmods = 0;
 	sidtab_t sidtab = {};
 	struct policy_file pf;
 	FILE *devnull = NULL;
@@ -80,7 +82,26 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 			abort();
 
 		if (policydb.policy_type == POLICY_BASE) {
-			if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
+			/*
+			 * If the input carries a second concatenated policydb after
+			 * the base and it is a POLICY_MOD, feed it to link_modules()
+			 * so that link.c's per-module remapping and copy paths are
+			 * exercised (with mods=NULL that whole subtree is dead).
+			 * Trailing junk that fails to read/validate is ignored.
+			 */
+			if (pf.len > 0 && policydb_init(&modpol) == 0) {
+				if (policydb_read(&modpol, &pf, VERBOSE) == 0 &&
+				    modpol.policy_type == POLICY_MOD &&
+				    modpol.mls == policydb.mls) {
+					nmods = 1;
+				} else {
+					policydb_destroy(&modpol);
+					memset(&modpol, 0, sizeof(modpol));
+				}
+			}
+
+			if (link_modules(NULL, &policydb, nmods ? mods : NULL,
+					 nmods, VERBOSE))
 				goto exit;
 
 			if (policydb_init(&out))
@@ -113,6 +134,7 @@ exit:
 		fclose(devnull);
 
 	policydb_destroy(&out);
+	policydb_destroy(&modpol);
 	policydb_destroy(&policydb);
 	sepol_sidtab_destroy(&sidtab);
 
-- 
2.55.0

