Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=lRhYPXjm6LQVsBTYCMFW1a2TjRCty2KHvFuUjIzL3SG2Z0eW29YT9+ImkNTkpfdOeydV
	 1LrshK8NzfBczpi2TggpCfKfwRU50JGRkshq6/B5I5ozdglsOeq+l6qiSGQpWkfTr4oB6
	 1tnMrzDTVZdg/HsgZBLRoo8eWFzyGa9R1klOb2/y3Ls2oRjMIyR16A/QhpEqqWWYzsac0
	 enhVC7ggZgTBGo8HIvQmaqWTDU/QalxLiQUPYaWBy/FkKo/PkxU43qg1stRDI6fxythCT
	 Y1GYk9x0EUKrhkPQzdbkaYoZW2PB6lytdfwKDLg6A3+71hLMKxBA4RZXaycn+lxqFpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WVPs4jawNeOVOBEHXf2hPGtLwDd/Q1OB0iPqU1CIBZc=;
	b=Ved/xvewH7/QCfgqJ8Pru55C9am8S6WcAduVXPt0eAM/dKnIwbWvwJLdW+KDvmT9O49Z
	 sIf9ufOy6uLc/tpvGwPOQJihC5uQ7Gc/24l82eeVaOxAiZRequdsxYE8xDEXc7aIYmvvr
	 k1BGRpJu37YGmFaJAFG+8rVQM1V8zPdeEEsdp8DGRh5hLHXR3+/R7IGYo/U10GpeBxsC7
	 Fskupq0Vpk+wdRieA6loUap+duRzfTSwV3uzTBykuN7VUyCN6xvYcdWyorowWWbfYwyXZ
	 A0cCzv24qsJe5+Fmw3neNqkUUWHYtOE+hXR5onllotZl/ofqawWSBZWwTh+JIqk8IWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Kw8aAJWI;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C67606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C67606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Kw8aAJWI
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVPs4jawNeOVOBEHXf2hPGtLwDd/Q1OB0iPqU1CIBZc=;
	b=Kw8aAJWI/03GQsk2oWrJWKyji91VlgiddcddXgFCukv/1lDDCllkaRManmBAS2f3igajlW
	v3+C95KW7jnFb5RTNnVJS83YYusT5meJeb1rrVzZ7qgsQg03qNajFWpDm6iEa8PNcY4+sX
	Nh7zsoxEYWt37C89faR9NbLKRv/jaJ2tm6pgwiL07YLwSYVuLJNwoUffZFPH29LW+AUd8K
	iNkvjxVcv+SveYzyuAPsI1xyvZTRrIVvUJ7egQ6QHwo9wBacrhIKCVZCy9CewhVczRFQkj
	F5vH9quKWJk9SJrDR/9nSPbXtqvMFUiebOsIUySZi2t2xAU9vDNb+iDvodtyHQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 08/16] checkpolicy: accept a class listed twice in a constraint
Date: Fri,  6 Nov 2026 13:35:01 +0100
Message-ID: <20261106123510.76727-7-cgoettsche@seltendoof.de>
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

define_constraint() creates one constraint node per listed class and
then assigns the permissions to the most recent node of each class. A
class listed twice, as in

    constrain { file file } { read } ( u1 == u2 );

gets two nodes, and the older one keeps an empty permission set. Policy
validation then fails with the unhelpful "Invalid constraint expr";
checkpolicy 3.11, which did not validate before writing, wrote a policy
that libsepol refuses to read. define_validatetrans() likewise writes
the same validatetrans rule twice.

Treat the class list as a set, as other class lists are, by skipping
classes already listed, and add a round-trip test.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c                     | 10 ++++++++++
 checkpolicy/tests/policy_dupclass.conf          | 14 ++++++++++++++
 checkpolicy/tests/policy_dupclass.expected.conf | 16 ++++++++++++++++
 checkpolicy/tests/test_roundtrip.sh             |  2 ++
 4 files changed, 42 insertions(+)
 create mode 100644 checkpolicy/tests/policy_dupclass.conf
 create mode 100644 checkpolicy/tests/policy_dupclass.expected.conf

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 28ad816b..349cd355 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3793,6 +3793,11 @@ int define_constraint(constraint_expr_t *expr)
 			free(id);
 			goto bad;
 		}
+		/* a class listed twice gets a single constraint */
+		if (ebitmap_get_bit(&classmap, cladatum->s.value - 1)) {
+			free(id);
+			continue;
+		}
 		if (ebitmap_set_bit(&classmap, cladatum->s.value - 1, TRUE)) {
 			yyerror("out of memory");
 			free(id);
@@ -3953,6 +3958,11 @@ int define_validatetrans(constraint_expr_t *expr)
 			free(id);
 			goto bad;
 		}
+		/* a class listed twice gets a single validatetrans rule */
+		if (ebitmap_get_bit(&classmap, cladatum->s.value - 1)) {
+			free(id);
+			continue;
+		}
 		if (ebitmap_set_bit(&classmap, (cladatum->s.value - 1), TRUE)) {
 			yyerror("out of memory");
 			free(id);
diff --git a/checkpolicy/tests/policy_dupclass.conf b/checkpolicy/tests/policy_dupclass.conf
new file mode 100644
index 00000000..51df7c7b
--- /dev/null
+++ b/checkpolicy/tests/policy_dupclass.conf
@@ -0,0 +1,14 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+sid kernel
+class CLASS1 { PERM1 }
+class CLASS2 { PERM1 }
+type TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+role ROLE1;
+role ROLE1 types { TYPE1 };
+user USER1 roles ROLE1;
+constrain { CLASS1 CLASS2 CLASS1 } { PERM1 } u1 == u2;
+validatetrans { CLASS2 CLASS1 CLASS2 } r1 == r2;
+sid kernel USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_dupclass.expected.conf b/checkpolicy/tests/policy_dupclass.expected.conf
new file mode 100644
index 00000000..03af5017
--- /dev/null
+++ b/checkpolicy/tests/policy_dupclass.expected.conf
@@ -0,0 +1,16 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+sid kernel
+class CLASS1 { PERM1 }
+class CLASS2 { PERM1 }
+type TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+role ROLE1;
+role ROLE1 types { TYPE1 };
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } u1 == u2;
+constrain CLASS2 { PERM1 } u1 == u2;
+validatetrans CLASS1 r1 == r2;
+validatetrans CLASS2 r1 == r2;
+sid kernel USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test_roundtrip.sh
index d05b36bb..beac2fba 100755
--- a/checkpolicy/tests/test_roundtrip.sh
+++ b/checkpolicy/tests/test_roundtrip.sh
@@ -31,6 +31,8 @@ check_policy  policy_minimal.conf      policy_minimal.conf                   '-E
 check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E'
 check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E -S -O'
 
+check_policy  policy_dupclass.conf     policy_dupclass.expected.conf         ''
+
 check_policy  policy_allonce.conf      policy_allonce.expected.conf          ''
 check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf      '-S -O'
 
-- 
2.55.0

