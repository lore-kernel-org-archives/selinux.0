Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D5165EF8
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871324; cv=none; b=O2JKgmxXpgYZ0HkcDepGNgNKtgcAmfPaWRtbbI2WzlHpuxJE2DRC7jgSrX5x4AsSUiBrcUXqvNhkNqs0EeIPL1ZlybD61wwQj/U+dX6QwJ1365XJ+TwP+w0sfIcFhRJvDQGVaSQv7wn9+z553sCz/jAhkwJ38qLaO/x4rGxq0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871324; c=relaxed/simple;
	bh=SofyjoyC73IJhHzcVJvymn2Ir4fhRRsjtVRMLCprdNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA6/1+3UQ4IqpL/y8vziOvqCfSnhqDD8GALLAo1Stgei9hq85L5Fu40OgB55RY02pEgyOeoQVF5jr01JLcEJUX/K2g4CBVrdhjwjwKK+m0u/2AXv30bMOkuta0wO7hQyDLrs4fzJbtj7iR4oJ0qnMrPyWcFkCHaDPktantOZEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=V9eoqW6L; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="V9eoqW6L"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729871314;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yza8vaV+h1poDiOAwbpV5FiIISOKM3syN/u/nXziP/A=;
	b=V9eoqW6LCsNs11I8fAYBlFkJYyodMZ0K8muR6tACdl4vo1qvnDJeghSq34v+zRsztRy29K
	IZ+65vKJzk6UBGv7lkAg3tOSDKjc8qDQ7DzpLgZO4LpCWHuRsxQKPbfpD73rtdrjz5/Jwu
	RNMJvRRY6Y98FlJIE5RwPygSZMfymfsJhbscpHOANGqF408lq1PETr1JcI6balSoHCnaRL
	VUErZWdrzZQwlzOSgcSvR07OkM8REtz6nnoT4N5h9xh0XSJCN4RdXiBvYPtGNfhwFJP2Pw
	fmctT24/0RBHBvQ6nicnFCIax+9DXpL71MR+un0zmUcJgXNVxALL60wFD/w+pQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 5/6] libsepol: indent printed allow rule on assertion failure
Date: Fri, 25 Oct 2024 17:48:23 +0200
Message-ID: <20241025154824.140073-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241025154824.140073-1-cgoettsche@seltendoof.de>
References: <20241025154824.140073-1-cgoettsche@seltendoof.de>
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

Indent the printed allow rule that triggered an assertion by two spaces
to improve readability.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  add patch
---
 libsepol/src/assertion.c         |   8 +--
 libsepol/tests/test-neverallow.c | 100 +++++++++++++++----------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index c637f000..eb967335 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -201,7 +201,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 					permstring = sepol_extended_perms_to_string(&error);
 
 					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
-							"allowxperm %s %s:%s %s;",
+							"  allowxperm %s %s:%s %s;",
 							narule->source_line, narule->source_filename, narule->line, policy_name(p),
 							p->p_type_val_to_name[i],
 							p->p_type_val_to_name[j],
@@ -247,7 +247,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 						permstring = sepol_extended_perms_to_string(&error);
 
 						ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
-								"allowxperm %s %s:%s %s;",
+								"  allowxperm %s %s:%s %s;",
 								narule->source_line, narule->source_filename, narule->line, policy_name(p),
 								p->p_type_val_to_name[i],
 								p->p_type_val_to_name[j],
@@ -289,7 +289,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 						permstring = sepol_extended_perms_to_string(&error);
 
 						ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
-								"allowxperm %s %s:%s %s;",
+								"  allowxperm %s %s:%s %s;",
 								narule->source_line, narule->source_filename, narule->line, policy_name(p),
 								p->p_type_val_to_name[i],
 								p->p_type_val_to_name[j],
@@ -314,7 +314,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 		char *permstr = sepol_av_to_string(p, curperm->tclass, perms);
 
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
-				"allow %s %s:%s {%s };",
+				"  allow %s %s:%s {%s };",
 				narule->source_line, narule->source_filename, narule->line, policy_name(p),
 				p->p_type_val_to_name[stype],
 				p->p_type_val_to_name[ttype],
diff --git a/libsepol/tests/test-neverallow.c b/libsepol/tests/test-neverallow.c
index 7d6ad00e..80f91bf5 100644
--- a/libsepol/tests/test-neverallow.c
+++ b/libsepol/tests/test-neverallow.c
@@ -112,18 +112,18 @@ static void test_neverallow_basic(void)
 		"neverallow on line 144 of policies/test-neverallow/policy.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violated by allow test12_3_t test12_1_t:file { open };",
 		"neverallow on line 144 of policies/test-neverallow/policy.conf.std (or line 144 of policies/test-neverallow/policy.conf.std) violated by allow test12_2_t test12_1_t:file { open };",
 		"neverallow on line 156 of policies/test-neverallow/policy.conf.std (or line 156 of policies/test-neverallow/policy.conf.std) violated by allow test13_1_t test13_1_t:file { read };",
-		"neverallowxperm on line 174 of policies/test-neverallow/policy.conf.std (or line 174 of policies/test-neverallow/policy.conf.std) violated by\nallow test15_t test15_t:file { ioctl };",
-		"neverallowxperm on line 182 of policies/test-neverallow/policy.conf.std (or line 182 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test16_t test16_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 198 of policies/test-neverallow/policy.conf.std (or line 198 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test18_t test18_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 206 of policies/test-neverallow/policy.conf.std (or line 206 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test19_t test19_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 216 of policies/test-neverallow/policy.conf.std (or line 216 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test20_a test20_a:file ioctl { 0x1111 };",
-		"neverallowxperm on line 227 of policies/test-neverallow/policy.conf.std (or line 227 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test21_1_a test21_2_a:file ioctl { 0x1111 };",
-		"neverallowxperm on line 237 of policies/test-neverallow/policy.conf.std (or line 237 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test22_t test22_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 247 of policies/test-neverallow/policy.conf.std (or line 247 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test23_t test23_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 257 of policies/test-neverallow/policy.conf.std (or line 257 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test24_t test24_a:file ioctl { 0x1111 };",
-		"neverallowxperm on line 267 of policies/test-neverallow/policy.conf.std (or line 267 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test25_t test25_t:file ioctl { 0x1111 };",
-		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
-		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\nallowxperm test26_a test26_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 174 of policies/test-neverallow/policy.conf.std (or line 174 of policies/test-neverallow/policy.conf.std) violated by\n  allow test15_t test15_t:file { ioctl };",
+		"neverallowxperm on line 182 of policies/test-neverallow/policy.conf.std (or line 182 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test16_t test16_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 198 of policies/test-neverallow/policy.conf.std (or line 198 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test18_t test18_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 206 of policies/test-neverallow/policy.conf.std (or line 206 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test19_t test19_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 216 of policies/test-neverallow/policy.conf.std (or line 216 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test20_a test20_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 227 of policies/test-neverallow/policy.conf.std (or line 227 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test21_1_a test21_2_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 237 of policies/test-neverallow/policy.conf.std (or line 237 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test22_t test22_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 247 of policies/test-neverallow/policy.conf.std (or line 247 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test23_t test23_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 257 of policies/test-neverallow/policy.conf.std (or line 257 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test24_t test24_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 267 of policies/test-neverallow/policy.conf.std (or line 267 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test25_t test25_t:file ioctl { 0x1111 };",
+		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test26_a test26_a:file ioctl { 0x1111 };",
+		"neverallowxperm on line 277 of policies/test-neverallow/policy.conf.std (or line 277 of policies/test-neverallow/policy.conf.std) violated by\n  allowxperm test26_a test26_a:file ioctl { 0x1111 };",
 	};
 
 	if (policydb_init(&base_expanded))
@@ -174,25 +174,25 @@ static void test_neverallow_minus_self(void)
 		"neverallow on line 175 of policies/test-neverallow/policy_minus_self.conf.std (or line 175 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test14_1_t test14_2_t:file { read };",
 		"neverallow on line 193 of policies/test-neverallow/policy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
 		"neverallow on line 193 of policies/test-neverallow/policy_minus_self.conf.std (or line 193 of policies/test-neverallow/policy_minus_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
-		"neverallowxperm on line 201 of policies/test-neverallow/policy_minus_self.conf.std (or line 201 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl };",
-		"neverallowxperm on line 219 of policies/test-neverallow/policy_minus_self.conf.std (or line 219 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
-		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
-		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
-		"neverallowxperm on line 261 of policies/test-neverallow/policy_minus_self.conf.std (or line 261 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
-		"neverallowxperm on line 272 of policies/test-neverallow/policy_minus_self.conf.std (or line 272 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 283 of policies/test-neverallow/policy_minus_self.conf.std (or line 283 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
-		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
-		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
-		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 348 of policies/test-neverallow/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 348 of policies/test-neverallow/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_minus_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 201 of policies/test-neverallow/policy_minus_self.conf.std (or line 201 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allow test17_1_t test17_2_t:class17 { ioctl };",
+		"neverallowxperm on line 219 of policies/test-neverallow/policy_minus_self.conf.std (or line 219 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
+		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
+		"neverallowxperm on line 231 of policies/test-neverallow/policy_minus_self.conf.std (or line 231 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
+		"neverallowxperm on line 261 of policies/test-neverallow/policy_minus_self.conf.std (or line 261 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
+		"neverallowxperm on line 272 of policies/test-neverallow/policy_minus_self.conf.std (or line 272 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 283 of policies/test-neverallow/policy_minus_self.conf.std (or line 283 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test25_a test25_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 295 of policies/test-neverallow/policy_minus_self.conf.std (or line 295 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allow test28_2_t test28_1_t:file { ioctl };",
+		"neverallowxperm on line 317 of policies/test-neverallow/policy_minus_self.conf.std (or line 317 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
+		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allow test29_2_t test29_1_t:file { ioctl };",
+		"neverallowxperm on line 327 of policies/test-neverallow/policy_minus_self.conf.std (or line 327 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test30_a test30_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 337 of policies/test-neverallow/policy_minus_self.conf.std (or line 337 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test30_a test30_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 348 of policies/test-neverallow/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 348 of policies/test-neverallow/policy_minus_self.conf.std (or line 348 of policies/test-neverallow/policy_minus_self.conf.std) violated by\n  allowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
 	};
 
 	if (policydb_init(&base_expanded))
@@ -244,25 +244,25 @@ static void test_neverallow_not_self(void)
 		"neverallow on line 185 of policies/test-neverallow/policy_not_self.conf.std (or line 185 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test13_1_t test13_2_t:file { read };",
 		"neverallow on line 194 of policies/test-neverallow/policy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test16_2_t test16_1_t:file { read };",
 		"neverallow on line 194 of policies/test-neverallow/policy_not_self.conf.std (or line 194 of policies/test-neverallow/policy_not_self.conf.std) violated by allow test16_1_t test16_2_t:file { read };",
-		"neverallowxperm on line 202 of policies/test-neverallow/policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test17_1_t test17_2_t:class17 { ioctl };",
-		"neverallowxperm on line 220 of policies/test-neverallow/policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
-		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
-		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
-		"neverallowxperm on line 262 of policies/test-neverallow/policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
-		"neverallowxperm on line 273 of policies/test-neverallow/policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 284 of policies/test-neverallow/policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test25_a test25_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
-		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test28_2_t test28_1_t:file { ioctl };",
-		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
-		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallow test29_2_t test29_1_t:file { ioctl };",
-		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test30_a test30_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 349 of policies/test-neverallow/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
-		"neverallowxperm on line 349 of policies/test-neverallow/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_not_self.conf.std) violated by\nallowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 202 of policies/test-neverallow/policy_not_self.conf.std (or line 202 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allow test17_1_t test17_2_t:class17 { ioctl };",
+		"neverallowxperm on line 220 of policies/test-neverallow/policy_not_self.conf.std (or line 220 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test19_2_t test19_1_t:file ioctl { 0x101-0x102 };",
+		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test20_2_t test20_1_t:file ioctl { 0x103 };",
+		"neverallowxperm on line 232 of policies/test-neverallow/policy_not_self.conf.std (or line 232 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test20_1_t test20_2_t:file ioctl { 0x102 };",
+		"neverallowxperm on line 262 of policies/test-neverallow/policy_not_self.conf.std (or line 262 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test23_1_t test23_2_t:file ioctl { 0x9511 };",
+		"neverallowxperm on line 273 of policies/test-neverallow/policy_not_self.conf.std (or line 273 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test24_1_t test24_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 284 of policies/test-neverallow/policy_not_self.conf.std (or line 284 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test25_a test25_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 296 of policies/test-neverallow/policy_not_self.conf.std (or line 296 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test26_1_a test26_2_a:file ioctl { 0x9511 };",
+		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allow test28_2_t test28_1_t:file { ioctl };",
+		"neverallowxperm on line 318 of policies/test-neverallow/policy_not_self.conf.std (or line 318 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test28_1_t test28_2_t:file ioctl { 0x9521 };",
+		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allow test29_2_t test29_1_t:file { ioctl };",
+		"neverallowxperm on line 328 of policies/test-neverallow/policy_not_self.conf.std (or line 328 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test29_1_t test29_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test30_a test30_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 338 of policies/test-neverallow/policy_not_self.conf.std (or line 338 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test30_a test30_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 349 of policies/test-neverallow/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
+		"neverallowxperm on line 349 of policies/test-neverallow/policy_not_self.conf.std (or line 349 of policies/test-neverallow/policy_not_self.conf.std) violated by\n  allowxperm test31_1_a test31_2_a:file ioctl { 0x9521 };",
 	};
 
 	if (policydb_init(&base_expanded))
-- 
2.45.2

