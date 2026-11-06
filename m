Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968527;
	b=oD9iu1qaVbCyRFnxX3R9i2eRd0jJBG/sMwcaIwYg4D2VaoleheWyMxXqLupm8+Ps615o
	 Ye5uhglqoURNPweryOhiOqaBWZRX6Yc2BcnmhJfF7LpPOiss69vaRq0Q2ts05AoadhPXH
	 FYiVgP0pqkx8V0+6lLvX+pL4oAfcWvv6yu0t3EBW9hHah7quE38cW1ZaPza3WT42B5iZ4
	 yB9r4ZKfiQf1TNaQRZ6yYNnU4hNnVdLYLvyY+kxiBsFtVjWJw086qXibXOKDIk2lZfw9x
	 uEPX66pzUj7XkRNST0qJNJdluCfAc5QSRn8g5l1/eyLAIcJTjJQkh7NYhxS74qZJtNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968527;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OEbWOyPvRbC+LF3vIk/nfkThJ7NSXc78w59VNqMTGWg=;
	b=kNyjxF1AeY7Eje3ki99n2cXkkPm9k8ux01zXMt5Mhd1TmJiRKQo7OOfQHmKsNmMwKlNg
	 2NbHfLn6a+PXtYkXZPokLTFer93i0eD4gjVxhnjEifdpCjP8wrfLIl1I/4ZC+4V+0Ycx9
	 zeyDs7TayC4ONXCmFtfE1DKbZqy8wmaHpxGAEnDe7a4vyApMEB8xlbemiuy4K0Cph0kTu
	 VY2bY5SCdoRsKVgxNu0612kHmV809YSYaKcfeIZwzprpLIFb7l7vS++WaYxsgDZAbTiUS
	 dN26t66HptWAgcFg45reEmAV7bH7uFP7EMPYLFMB94+Cqi+TlEPCTmOmJQHLQH6HtjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=ouCifsjN;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD49606A32E
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD49606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=ouCifsjN
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEbWOyPvRbC+LF3vIk/nfkThJ7NSXc78w59VNqMTGWg=;
	b=ouCifsjNB4i/czlssCU7B4vzrivBQrlogYsvLn3j4cRMyIV/b0/Zo1kDN2FbXPTfUFG4j9
	EMKUWEOG8faCGIZ2z+HRPXSUjj+bs05jV1t2jT2mHvmvqVLKVhsVnYhdNKGAHxr/DvjvCE
	CylaW/PLoWRbP/7gSakP848bIevfsSjTCuZDBKoXaDfBprk7NtG0xy62GOKu9u02Df7Lk3
	lBRTK5Zl0HqBnm9uJMCaGEFkqMTV6S6/2ucxetM1jmW3xAmWuy2pZ8xPEjcDOp0v4kv4QF
	/DwfUWltixBeaDj9isUbsnuRsSum2TMoMdQiF67ALa1Qy9T/ZYpqI9YpJVUSEQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/16] libsepol: reject conflicting type aliases when linking
Date: Fri,  6 Nov 2026 13:34:59 +0100
Message-ID: <20261106123510.76727-5-cgoettsche@seltendoof.de>
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

alias_copy_callback() asserts that an alias already present in the base
as TYPE_ALIAS refers to the same primary as the alias being copied. Two
modules can however alias one name to different types, e.g. a base
that only requires x_t in an optional block, one module declaring
"typealias m_t alias x_t;" and another "typealias m2_t alias x_t;".
Linking them with semodule_link aborts:

    link.c:948: alias_copy_callback: Assertion
    `base_type->primary == target_type->s.value' failed.

Report the conflict as a link error instead and add a regression test.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c                           |  7 +++-
 .../test-linker/alias-clash-base.conf         | 32 +++++++++++++++++++
 .../test-linker/alias-clash-module1.conf      |  9 ++++++
 .../test-linker/alias-clash-module2.conf      |  9 ++++++
 libsepol/tests/test-linker.c                  | 31 ++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/tests/policies/test-linker/alias-clash-base.conf
 create mode 100644 libsepol/tests/policies/test-linker/alias-clash-module1.conf
 create mode 100644 libsepol/tests/policies/test-linker/alias-clash-module2.conf

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index ac9a4f2c..f6c294d0 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -944,8 +944,13 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		 * and inserted into the hashtable as a type, fix it up now */
 
 		if (base_type->flavor == TYPE_ALIAS) {
+			if (base_type->primary != target_type->s.value) {
+				ERR(state->handle,
+				    "%s: Alias %s already aliases a type other than %s.",
+				    state->cur_mod_name, id, target_id);
+				return -1;
+			}
 			/* error checking */
-			assert(base_type->primary == target_type->s.value);
 			assert(base_type->primary ==
 			       mod->map[SYM_TYPES][primval - 1]);
 			assert(mod->map[SYM_TYPES][type->s.value - 1] ==
diff --git a/libsepol/tests/policies/test-linker/alias-clash-base.conf b/libsepol/tests/policies/test-linker/alias-clash-base.conf
new file mode 100644
index 00000000..a82fc4f5
--- /dev/null
+++ b/libsepol/tests/policies/test-linker/alias-clash-base.conf
@@ -0,0 +1,32 @@
+class process
+class file
+
+sid kernel
+
+class process { fork }
+class file { read }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+
+mlsconstrain file { read } ( h1 dom h2 );
+')
+
+type sys_isid;
+allow sys_isid self : process fork;
+
+# Only requires clash_t, so modules may declare it.
+optional {
+	require {
+		type clash_t;
+	}
+	allow sys_isid clash_t : file read;
+}
+
+role sys_role;
+role sys_role types sys_isid;
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
diff --git a/libsepol/tests/policies/test-linker/alias-clash-module1.conf b/libsepol/tests/policies/test-linker/alias-clash-module1.conf
new file mode 100644
index 00000000..bd8a2379
--- /dev/null
+++ b/libsepol/tests/policies/test-linker/alias-clash-module1.conf
@@ -0,0 +1,9 @@
+module alias_clash_1 1.0;
+
+require {
+	class file { read };
+}
+
+type clash_1_t;
+typealias clash_1_t alias clash_t;
+allow clash_1_t self : file read;
diff --git a/libsepol/tests/policies/test-linker/alias-clash-module2.conf b/libsepol/tests/policies/test-linker/alias-clash-module2.conf
new file mode 100644
index 00000000..c769447c
--- /dev/null
+++ b/libsepol/tests/policies/test-linker/alias-clash-module2.conf
@@ -0,0 +1,9 @@
+module alias_clash_2 1.0;
+
+require {
+	class file { read };
+}
+
+type clash_2_t;
+typealias clash_2_t alias clash_t;
+allow clash_2_t self : file read;
diff --git a/libsepol/tests/test-linker.c b/libsepol/tests/test-linker.c
index dbda2672..2407d8d6 100644
--- a/libsepol/tests/test-linker.c
+++ b/libsepol/tests/test-linker.c
@@ -133,6 +133,32 @@ static void test_linker_cond(void)
 	module_cond_tests(&linkedbase);
 }
 
+/*
+ * Two modules aliasing one name to different primaries must make linking
+ * fail instead of tripping an assertion.
+ */
+static void test_linker_alias_clash(void)
+{
+	policydb_t base, mod1, mod2;
+	policydb_t *mods[] = { &mod1, &mod2 };
+
+	if (test_load_policy(&base, POLICY_BASE, mls, "test-linker",
+			     "alias-clash-base.conf"))
+		CU_FAIL_FATAL("Failed to load base policy");
+	if (test_load_policy(&mod1, POLICY_MOD, mls, "test-linker",
+			     "alias-clash-module1.conf"))
+		CU_FAIL_FATAL("Failed to load module 1");
+	if (test_load_policy(&mod2, POLICY_MOD, mls, "test-linker",
+			     "alias-clash-module2.conf"))
+		CU_FAIL_FATAL("Failed to load module 2");
+
+	CU_ASSERT(link_modules(NULL, &base, mods, 2, 0) != 0);
+
+	policydb_destroy(&base);
+	policydb_destroy(&mod1);
+	policydb_destroy(&mod2);
+}
+
 int linker_add_tests(CU_pSuite suite)
 {
 	if (NULL == CU_add_test(suite, "linker_indexes", test_linker_indexes)) {
@@ -151,5 +177,10 @@ int linker_add_tests(CU_pSuite suite)
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
+	if (NULL ==
+	    CU_add_test(suite, "linker_alias_clash", test_linker_alias_clash)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
 	return 0;
 }
-- 
2.55.0

