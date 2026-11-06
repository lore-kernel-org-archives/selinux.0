Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968527;
	b=jKctvSUkLPqFD3wZnBMFinsaG5psqvugnDq7W3VXdCnEJEJF4Jyy/YEC53yyWvvLnKt3
	 7gSZTHu29jfb2MSh6Idd4QoJt12aZzCaOipQc2AVBMR8cU6arNUO3UXJ3Ee17+ZTlSflO
	 YPCQjhh7OqAjjkq1K8M6YATRuhFkALraTCO7aMWTKgOy6W+I5Kk1DW1M6bjwSM9AxS7qW
	 6NJGrD01rHuOZgFsZkUk6uM+C3sotGSbDCMBEYQ8M5A0ceAXoJfCc740zcqyVdi85bOhj
	 KDdBp6klKMFwUAB2j4Q6VbOhwaY1Vf5/RncyTAL761AeagtEVnX6jaWKYZ2hXJr2mjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968527;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4ZKWD6TcIlOrKx9jS0bp3tLqUV29OaN5FeWE7zDrDu4=;
	b=ZQdcS8tHL+slFZb/U36RxhbP6eV7m2Fc7WplWMUGXvvwXEpXLwMhvF3byPSsRtwWotOF
	 RZX2fJ99i4Q3jysNREaFa28ek9awvCak0Qs/SCNaLXjqVu8u493LUnr00bhHm1Ineg7XV
	 ww7ZddiuUTk39bntFKmkthT/5dnKh1MfmGih4iCCBheaKkn0KBHfKpVw99sMWiL07wPhF
	 WSoh26EfhG25u8pK78UqIP799/u9Kz5qBUcoKzV2FJiAYbEq9qobdZ7M0rl+L3ek1h3Rl
	 NMV+GTGEXw22kRGHlN4obrXDtPgFurj9q/k60EthoUz90LTY59fGOZYv4GXnoX7wNEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=c4OEJFFM;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D44606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D44606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=c4OEJFFM
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968524;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZKWD6TcIlOrKx9jS0bp3tLqUV29OaN5FeWE7zDrDu4=;
	b=c4OEJFFM8nG5JGrTZxPcuJDjFScUU6mZlzVjJYkddnhkxTDYnBA8+DsLxZ4ZWfgO6CULJy
	tdhLYhmT2D2y5czlKVZl3Q56X083yqWQKAjHaJo2HRW3rAxqo6G/NNJVUn5zZkrEjg6hoP
	jzIufGLIgrVyp2yqUMFyRqBJJM1tCRmUsm8XFZxKqyKbyrvdxiCGK8jKdXUFqni7Zhsqo6
	BbPKczdIKQAxX/BCAOYS+hbhOhcV3co9UMFms0PM99/gJrDbkZ2wP7XzYej46uo/S5EGct
	/Ak/9ADiAK/lX6PFCcpwyyPUPNVvphD2rjdv4WpBQd6tIXLdiGF72i2lMsndAw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/16] libsepol: skip MLS alias slots when writing kernel policies as CIL
Date: Fri,  6 Nov 2026 13:34:57 +0100
Message-ID: <20261106123510.76727-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

checkpolicy gives every sensitivity and category alias its own value
slot, so p_levels.nprim and p_cats.nprim count the aliases, while the
value-to-name tables only hold the primaries and leave the alias slots
NULL. The CIL writer walks both tables up to nprim without skipping
those slots and emits declarations like

    (sensitivity (null))
    (sensitivityorder (s0 s1 s2 ))

which secilc refuses. "checkpolicy -M -b policy -C" therefore produces
unusable CIL for any checkpolicy-built MLS policy with a sensitivity or
category alias, such as one built from
checkpolicy/tests/policy_allonce_mls.conf.
The conf writer already skips unnamed slots.

Skip slots without a name in the sensitivity and category declaration
and order loops, and add a regression test converting an expanded
policy with one sensitivity and one category alias.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c                  |  8 ++
 libsepol/tests/libsepol-tests.c               |  2 +
 .../test-kernel-to-cil/mls-alias.conf         | 24 ++++++
 libsepol/tests/test-kernel-to-cil.c           | 80 +++++++++++++++++++
 libsepol/tests/test-kernel-to-cil.h           | 10 +++
 5 files changed, 124 insertions(+)
 create mode 100644 libsepol/tests/policies/test-kernel-to-cil/mls-alias.conf
 create mode 100644 libsepol/tests/test-kernel-to-cil.c
 create mode 100644 libsepol/tests/test-kernel-to-cil.h

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a9061e7c..81e266f5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -957,6 +957,8 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* sensitivities */
 	for (i = 0; i < pdb->p_levels.nprim; i++) {
 		name = pdb->p_sens_val_to_name[i];
+		if (!name)
+			continue;
 		sepol_printf(out, "(sensitivity %s)\n", name);
 	}
 
@@ -965,6 +967,8 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
 	prev = NULL;
 	for (i = 0; i < pdb->p_levels.nprim; i++) {
 		name = pdb->p_sens_val_to_name[i];
+		if (!name)
+			continue;
 		if (prev) {
 			sepol_printf(out, "%s ", prev);
 		}
@@ -1065,6 +1069,8 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 	/* categories */
 	for (i = 0; i < pdb->p_cats.nprim; i++) {
 		name = pdb->p_cat_val_to_name[i];
+		if (!name)
+			continue;
 		sepol_printf(out, "(category %s)\n", name);
 	}
 
@@ -1073,6 +1079,8 @@ static int write_category_rules_to_cil(FILE *out, struct policydb *pdb)
 	prev = NULL;
 	for (i = 0; i < pdb->p_cats.nprim; i++) {
 		name = pdb->p_cat_val_to_name[i];
+		if (!name)
+			continue;
 		if (prev) {
 			sepol_printf(out, "%s ", prev);
 		}
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 01f45562..2b758cad 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -25,6 +25,7 @@
 #include "test-deps.h"
 #include "test-downgrade.h"
 #include "test-neverallow.h"
+#include "test-kernel-to-cil.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -74,6 +75,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(downgrade);
 	DECLARE_SUITE(neverallow);
+	DECLARE_SUITE(kernel_to_cil);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-kernel-to-cil/mls-alias.conf b/libsepol/tests/policies/test-kernel-to-cil/mls-alias.conf
new file mode 100644
index 00000000..11631b5e
--- /dev/null
+++ b/libsepol/tests/policies/test-kernel-to-cil/mls-alias.conf
@@ -0,0 +1,24 @@
+class process
+
+sid kernel
+
+class process { transition }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+sensitivity s1 alias sens_alias;
+dominance { s0 s1 }
+category c0;
+category c1 alias cat_alias;
+level s0:c0.c1;
+level s1:c0.c1;
+
+mlsconstrain process { transition } ( h1 dom h2 );
+')
+
+type sys_isid;
+allow sys_isid self : process transition;
+role sys_role;
+role sys_role types sys_isid;
+gen_user(sys_user,, sys_role, s0, s0 - s1:c0.c1)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
diff --git a/libsepol/tests/test-kernel-to-cil.c b/libsepol/tests/test-kernel-to-cil.c
new file mode 100644
index 00000000..f7792bdf
--- /dev/null
+++ b/libsepol/tests/test-kernel-to-cil.c
@@ -0,0 +1,80 @@
+#include "test-kernel-to-cil.h"
+
+#include "helpers.h"
+
+#include <sepol/kernel_to_cil.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/link.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+extern int mls;
+
+int kernel_to_cil_test_init(void)
+{
+	return 0;
+}
+
+int kernel_to_cil_test_cleanup(void)
+{
+	return 0;
+}
+
+/*
+ * checkpolicy assigns sensitivity and category aliases their own value slot
+ * without a name in the value-to-name tables; the CIL writer must skip those
+ * slots instead of emitting "(null)" declarations.
+ */
+static void test_kernel_to_cil_mls_aliases(void)
+{
+	policydb_t basemod, expanded;
+	char *buf = NULL;
+	size_t len = 0;
+	FILE *out;
+
+	if (test_load_policy(&basemod, POLICY_BASE, mls, "test-kernel-to-cil",
+			     "mls-alias.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (policydb_init(&expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (expand_module(NULL, &basemod, &expanded, 0, 0))
+		CU_FAIL_FATAL("Failed to expand policy");
+
+	out = open_memstream(&buf, &len);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(out);
+	CU_ASSERT(sepol_kernel_policydb_to_cil(out, &expanded) == 0);
+	CU_ASSERT_FATAL(fclose(out) == 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(buf);
+
+	CU_ASSERT_PTR_NULL(strstr(buf, "(null)"));
+	if (mls) {
+		CU_ASSERT_PTR_NOT_NULL(
+			strstr(buf, "(sensitivityorder (s0 s1))\n"));
+		CU_ASSERT_PTR_NOT_NULL(strstr(buf, "(categoryorder (c0 c1))\n"));
+		CU_ASSERT_PTR_NOT_NULL(
+			strstr(buf, "(sensitivityaliasactual sens_alias s1)\n"));
+		CU_ASSERT_PTR_NOT_NULL(
+			strstr(buf, "(categoryaliasactual cat_alias c1)\n"));
+	}
+
+	free(buf);
+	policydb_destroy(&basemod);
+	policydb_destroy(&expanded);
+}
+
+int kernel_to_cil_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "kernel_to_cil_mls_aliases",
+				test_kernel_to_cil_mls_aliases)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	return 0;
+}
diff --git a/libsepol/tests/test-kernel-to-cil.h b/libsepol/tests/test-kernel-to-cil.h
new file mode 100644
index 00000000..16f6e4c3
--- /dev/null
+++ b/libsepol/tests/test-kernel-to-cil.h
@@ -0,0 +1,10 @@
+#ifndef TEST_KERNEL_TO_CIL_H__
+#define TEST_KERNEL_TO_CIL_H__
+
+#include <CUnit/Basic.h>
+
+int kernel_to_cil_test_init(void);
+int kernel_to_cil_test_cleanup(void);
+int kernel_to_cil_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.55.0

