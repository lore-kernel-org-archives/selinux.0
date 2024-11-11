Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4955199939
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333087; cv=none; b=hJ0BaJmHSHbuvcC9iSmJNA9tjCmlLINCUsRaetimgKxVOnVxNEfCcZviFkq/KEgX44N9xX0Fs4DK14HLLK6RDKQlkDkZYRkTIG67rb9A1uzDkqnebtuKBj8+4/+ZzKUxGFmGYxljHh66bzSgoLqa0QivYiVNCnZN23bOmf5pnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333087; c=relaxed/simple;
	bh=mUb+6GkpmUryt5c+yLjwa81WnGujteJ+xV504mZxjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsSVJDuJVVJ0Y1x8XReWrgRXx1shNe2UlNxZ1B81VgkJeBiGW4fJyAgq/VJjxTfrm90nkDEmzqiwK96sjuOuWgbI5CNO+GqpY9Fd/108gXYxj7FJd6wuWbfTt6nH7IgwoaIcsHCYPuoNFHcHkADMCdsevIydfFhcGK10ghrXlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=chzG1d6N; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="chzG1d6N"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731333073;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nuz/y0cDyq+4YN7xtLUvUoW+hRtphEvPBmT70dgDqs=;
	b=chzG1d6NN0FnQlfLTkZruSAOeVHKu5h26TOElgtsnPIu7EQhbTwNMliyGt7tNvsHA13Z1x
	FUPlrHh8qsRK/G36yYO7v/fUDZlVkyaJy71d9t9uFLD10ydq4nrNbuP6QaekWwS0d4rBTG
	BL8jR1rFy3OOm1PSjodA/Zfd7eHIE6OHzoo1uYMpcTRNGx862pQSZ13Z7t/UeWbv2oELWG
	9QcBnwX566RNIDlkHSeDcTwyidH094d7qMwEo9dHzOssH2LtFLoJtkEPKAC653DsHLTTwu
	bv4Hbyn/rTM+VzWKfyetDuJEAtb54C7QvcVPUR+R68fVi6zR03KFI+rcGQiqBA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v5 6/6] libsepol/tests: add cond xperm neverallow tests
Date: Mon, 11 Nov 2024 14:51:07 +0100
Message-ID: <20241111135107.20280-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241111135107.20280-1-cgoettsche@seltendoof.de>
References: <20241111135107.20280-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Add some tests to verify assertion checking works for extended
permissions in conditional policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  add patch
---
 libsepol/tests/helpers.c                      |   1 +
 .../policies/test-neverallow/policy_cond.conf | 251 ++++++++++++++++++
 libsepol/tests/test-neverallow.c              |  57 ++++
 3 files changed, 309 insertions(+)
 create mode 100644 libsepol/tests/policies/test-neverallow/policy_cond.conf

diff --git a/libsepol/tests/helpers.c b/libsepol/tests/helpers.c
index 1192734b..97ddfe8e 100644
--- a/libsepol/tests/helpers.c
+++ b/libsepol/tests/helpers.c
@@ -53,6 +53,7 @@ int test_load_policy(policydb_t * p, int policy_type, int mls, const char *test_
 
 	p->policy_type = policy_type;
 	p->mls = mls;
+	p->policyvers = MOD_POLICYDB_VERSION_MAX;
 
 	if (read_source_policy(p, filename, test_name)) {
 		fprintf(stderr, "failed to read policy %s\n", filename);
diff --git a/libsepol/tests/policies/test-neverallow/policy_cond.conf b/libsepol/tests/policies/test-neverallow/policy_cond.conf
new file mode 100644
index 00000000..c81fc01d
--- /dev/null
+++ b/libsepol/tests/policies/test-neverallow/policy_cond.conf
@@ -0,0 +1,251 @@
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+
+sid kernel
+sid security
+sid unlabeled
+sid file
+sid port
+sid netif
+sid netmsg
+sid node
+sid devnull
+
+class process { dyntransition transition }
+class file { getattr ioctl open read write }
+
+bool boolean1 false;
+bool boolean2 true;
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0; category c1; category c2; category c3;
+category c4; category c5; category c6; category c7;
+category c8; category c9; category c10; category c11;
+category c12; category c13; category c14; category c15;
+category c16; category c17; category c18; category c19;
+category c20; category c21; category c22; category c23;
+
+level s0:c0.c23;
+
+mlsconstrain file { write } ( h1 dom h2 );
+')
+
+
+########################################
+#
+# Test start
+#
+########################################
+
+
+## Test 1 (basic - fail)
+
+type test1_t;
+if boolean1 {
+	allow test1_t self : file read;
+}
+neverallow test1_t * : file *;
+
+
+## Test 2 (basic - fail)
+
+attribute test2_a;
+type test2_1_t, test2_a;
+type test2_2_t;
+if !boolean1 {
+	allow test2_1_t test2_1_t : file write;
+	allow test2_2_t test2_2_t : file write;
+}
+neverallow test2_a * : file *;
+
+
+## Test 3 (xperm - no xperm in one branch - fail)
+
+type test3_t;
+if boolean1 {
+	allow test3_t self : file ioctl;
+} else {
+	allowxperm test3_t self : file ioctl 0x1;
+}
+neverallowxperm test3_t self : file ioctl 0x4;
+
+
+## Test 4 (xperm - xperm in neither branch - fail)
+
+type test4_t;
+allow test4_t self : file ioctl;
+if boolean1 {
+	allow test4_t self : file read;
+} else {
+	allow test4_t self : file write;
+}
+neverallowxperm test4_t self : file ioctl 0x4;
+
+
+## Test 5 (xperm - xperm in both branches - no failure)
+
+type test5_t;
+allow test5_t self : file ioctl;
+if boolean1 {
+	allowxperm test5_t self : file ioctl 0x1;
+} else {
+	allowxperm test5_t self : file ioctl 0x2;
+}
+neverallowxperm test5_t self : file ioctl 0x4;  # nofail
+
+
+## Test 6 (xperm - failure in one branch - fail)
+
+type test6_t;
+if boolean1 {
+	allow test6_t self : file ioctl;
+	allowxperm test6_t self : file ioctl 0x1;
+} else {
+	allow test6_t self : file write;
+}
+neverallowxperm test6_t self : file ioctl 0x1;
+
+
+## Test 7 (xperm - failure in both branches - fail)
+
+type test7_t;
+if boolean1 {
+	allow test7_t self : file ioctl;
+	allowxperm test7_t self : file ioctl 0x1;
+} else {
+	allow test7_t self : file ioctl;
+	allowxperm test7_t self : file ioctl 0x2;
+}
+neverallowxperm test7_t self : file ioctl { 0x1-0x2 };
+
+
+## Test 8 (xperm - different xperm in both branches - no failure)
+
+type test8_t;
+allow test8_t self : file ioctl;
+if boolean1 {
+	allowxperm test8_t self : file ioctl 0x1;
+} else {
+	allowxperm test8_t self : file ioctl 0x2;
+}
+neverallowxperm test8_t self : file ioctl 0x3;  # nofail
+
+
+## Test 9 (xperm - rules split into two booleans - no failure)
+
+type test9_t;
+allow test9_t self : file ioctl;
+if boolean1 {
+	allowxperm test9_t self : file ioctl 0x1;
+}
+if !boolean2 {
+	allowxperm test9_t self : file ioctl 0x1;
+}
+neverallowxperm test9_t self : file ioctl 0x4;
+
+
+## Test 10 (xperm - valid usage in one branch - no failure)
+
+type test10_t;
+if boolean1 {
+	allow test10_t self : file ioctl;
+	allowxperm test10_t self : file ioctl 0x1;
+} else {
+	allow test10_t self : file write;
+}
+neverallowxperm test10_t self : file ioctl 0x2;  # nofail
+
+
+## Test 11 (xperm - valid usage in both branches - no failure)
+
+type test11_t;
+if boolean1 {
+	allow test11_t self : file ioctl;
+	allowxperm test11_t self : file ioctl 0x1;
+} else {
+	allow test11_t self : file ioctl;
+	allowxperm test11_t self : file ioctl 0x2;
+}
+neverallowxperm test11_t self : file ioctl 0x3;  # nofail
+
+
+## Test 12 (xperm - base allow in one branch - fail)
+
+type test12_t;
+if boolean1 {
+	allow test12_t self : file ioctl;
+} else {
+	allow test12_t self : file write;
+}
+neverallowxperm test12_t self : file ioctl 0x1;
+
+
+## Test 13 (xperm - invalid second branch - fail)
+
+type test13_t;
+allow test13_t self : file ioctl;
+if boolean1 {
+	allow test13_t self : file ioctl;
+	allowxperm test13_t self : file ioctl 0x1;
+} else {
+	allow test13_t self : file write;
+}
+neverallowxperm test13_t self : file ioctl 0x1;
+
+
+## Test 14 (xperm - invalid second branch - fail)
+
+type test14_t;
+allow test14_t self : file ioctl;
+if boolean1 {
+	allow test14_t self : file ioctl;
+	allowxperm test14_t self : file ioctl 0x1;
+} else {
+	allow test14_t self : file write;
+}
+neverallowxperm test14_t self : file ioctl 0x2;
+
+
+## Test 15 (xperm - base uncond in one branch - fail)
+
+type test15_t;
+allow test15_t self : file ioctl;
+allowxperm test15_t self : file ioctl 0x1;
+if boolean1 {
+	allow test15_t self : file ioctl;
+} else {
+	allow test15_t self : file write;
+}
+neverallowxperm test15_t self : file ioctl 0x2;
+
+
+########################################
+#
+# Test End
+#
+########################################
+
+
+type sys_isid;
+role sys_role;
+role sys_role types sys_isid;
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0.c23)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
+sid security gen_context(sys_user:sys_role:sys_isid, s0)
+sid unlabeled gen_context(sys_user:sys_role:sys_isid, s0)
+sid file gen_context(sys_user:sys_role:sys_isid, s0)
+sid port gen_context(sys_user:sys_role:sys_isid, s0)
+sid netif gen_context(sys_user:sys_role:sys_isid, s0)
+sid netmsg gen_context(sys_user:sys_role:sys_isid, s0)
+sid node gen_context(sys_user:sys_role:sys_isid, s0)
+sid devnull gen_context(sys_user:sys_role:sys_isid, s0)
+fs_use_trans devpts gen_context(sys_user:sys_role:sys_isid, s0);
+fs_use_trans devtmpfs gen_context(sys_user:sys_role:sys_isid, s0);
diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-neverallow.c
index 80f91bf5..9c3001c4 100644
--- a/libsepol/tests/test-neverallow.c
+++ b/libsepol/tests/test-neverallow.c
@@ -293,6 +293,58 @@ static void test_neverallow_not_self(void)
 	policydb_destroy(&base_expanded);
 }
 
+static void test_neverallow_cond(void)
+{
+	policydb_t basemod, base_expanded;
+	sepol_handle_t *handle;
+	static const char *const expected_messages[] = {
+		"16 neverallow failures occurred",
+		"neverallow on line 58 of policies/test-neverallow/policy_cond.conf.std (or line 58 of policies/test-neverallow/policy_cond.conf.std) violated by allow test1_t test1_t:file { read };",
+		"neverallow on line 70 of policies/test-neverallow/policy_cond.conf.std (or line 70 of policies/test-neverallow/policy_cond.conf.std) violated by allow test2_1_t test2_1_t:file { write };",
+		"neverallowxperm on line 81 of policies/test-neverallow/policy_cond.conf.std (or line 81 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test3_t test3_t:file { ioctl };",
+		"neverallowxperm on line 93 of policies/test-neverallow/policy_cond.conf.std (or line 93 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test4_t test4_t:file { ioctl };",
+		"neverallowxperm on line 117 of policies/test-neverallow/policy_cond.conf.std (or line 117 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test6_t test6_t:file ioctl { 0x1 };",
+		"neverallowxperm on line 130 of policies/test-neverallow/policy_cond.conf.std (or line 130 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test7_t test7_t:file ioctl { 0x2 };",
+		"neverallowxperm on line 130 of policies/test-neverallow/policy_cond.conf.std (or line 130 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test7_t test7_t:file ioctl { 0x1 };",
+		"neverallowxperm on line 130 of policies/test-neverallow/policy_cond.conf.std (or line 130 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test7_t test7_t:file ioctl { 0x2 };",
+		"neverallowxperm on line 130 of policies/test-neverallow/policy_cond.conf.std (or line 130 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test7_t test7_t:file ioctl { 0x1 };",
+		"neverallowxperm on line 155 of policies/test-neverallow/policy_cond.conf.std (or line 155 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test9_t test9_t:file { ioctl };",
+		"neverallowxperm on line 191 of policies/test-neverallow/policy_cond.conf.std (or line 191 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test12_t test12_t:file { ioctl };",
+		"neverallowxperm on line 204 of policies/test-neverallow/policy_cond.conf.std (or line 204 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test13_t test13_t:file ioctl { 0x1 };",
+		"neverallowxperm on line 204 of policies/test-neverallow/policy_cond.conf.std (or line 204 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test13_t test13_t:file { ioctl };",
+		"neverallowxperm on line 204 of policies/test-neverallow/policy_cond.conf.std (or line 204 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allowxperm test13_t test13_t:file ioctl { 0x1 };",
+		"neverallowxperm on line 217 of policies/test-neverallow/policy_cond.conf.std (or line 217 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test14_t test14_t:file { ioctl };",
+		"neverallowxperm on line 230 of policies/test-neverallow/policy_cond.conf.std (or line 230 of policies/test-neverallow/policy_cond.conf.std) violated by\n  allow test15_t test15_t:file { ioctl };",
+	};
+
+	if (policydb_init(&base_expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	if (test_load_policy(&basemod, POLICY_BASE, mls, "test-neverallow", "policy_cond.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (expand_module(NULL, &basemod, &base_expanded, 0, 0))
+		CU_FAIL_FATAL("Failed to expand policy");
+
+	if ((handle = sepol_handle_create()) == NULL)
+		CU_FAIL_FATAL("Failed to initialize handle");
+
+	sepol_msg_set_callback(handle, msg_handler, NULL);
+
+	if (check_assertions(handle, &base_expanded, base_expanded.global->branch_list->avrules) != -1)
+		CU_FAIL("Assertions did not trigger");
+
+	messages_check(ARRAY_SIZE(expected_messages), expected_messages);
+
+	sepol_handle_destroy(handle);
+	messages_clean();
+	policydb_destroy(&basemod);
+	policydb_destroy(&base_expanded);
+}
+
 int neverallow_add_tests(CU_pSuite suite)
 {
 	/*
@@ -317,5 +369,10 @@ int neverallow_add_tests(CU_pSuite suite)
 		return CU_get_error();
 	}
 
+	if (NULL == CU_add_test(suite, "neverallow_cond", test_neverallow_cond)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
 	return 0;
 }
-- 
2.45.2

