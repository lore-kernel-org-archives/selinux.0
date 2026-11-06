Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968527;
	b=ruksrr89+3m3JqFLBEh0uY8E7o7CIkvHpwNFNq4bvkOXia/B05aphyENRu3BZNkHiBtt
	 DU1cxHyNXJ8+JknLd9thGiryiLSE8hROtGSkX/P9vkNIvBvI+j97PbwW8z8YtYm7AKSXm
	 SC5U32MONTR4nelp/rroNMeY2Hir2Uv/VrpT0O4FCHkna8/noL66fPP4MLxpcqRF/IPl8
	 qScvCEiPsCXe+qBK1Ih3jJGGeJNRuiY8gpclUo7OROlr2EpowoRhQMaCgnBt4dgKj1vCc
	 k1vDSbKUa9dXAYm/ouqupbcyHlnAG1kfwr++l/3wVt2ao/rrmhuwomt6qI1Hl1pacSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968527;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bBu7yxHYaZMdpJRxQMXGkgO71/3uHDL/cvKzm1Xvr0Y=;
	b=mbbQwCyTnHiuMNdfQtyFrad30sIZ2fY5/u4PnJG7BS80uw0k5avt/M0/cKnOde4d6Fd+
	 tZ1FxNw27P4m/hOyt3EYRjCBOQeF+DsfmCRA416HiceY7bAQerDnu+0hLP3lGGh6KT6Ii
	 YM8o+xmBExVYcGyYKSTtFf+mSKjVJHgzKBpZ4IcMw/Qjltpq2o5wQ6Qm2Rr8XzegDSJ13
	 63buJ8zGHyePoaBZtltMLM4BSwFto7Pe37IJrIpVIJb43yiRDDhx7fmKUDRTMj/6WD+bq
	 7v2ubPVbdR1T/C08RvNdZGc7uiBjYBqPKzE9FIAvT3/2ZTom8mVXPy3Aey4D9P8mTEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=KJLPrGds;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A28606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A28606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=KJLPrGds
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968524;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBu7yxHYaZMdpJRxQMXGkgO71/3uHDL/cvKzm1Xvr0Y=;
	b=KJLPrGdswmWUdMc2NxwC7B5NcT0Qn/x6vAllJiUYhtxgKQUf1vuB90LogdJ/mp6fb+j22Y
	V7pH/HUiIQK0i5CW5nXCz/+03IEexMe+/7i9WpLDgrRXdGjvUbDqtWgmuSQplTgf4Z4F8B
	SuAkkMffuYJcco4OqutuPwsP8ZQHWILZk2adOSA7s/G47PF964h2B+mhK7PCLktVrXq9J2
	Y8isuQa/V5OAIv8DIYcVsWIqZcYMfi4UlLm+8oOcyWk2B8am3Lc7sOb0CD824welAY8cAs
	uEUd+FlAj1tYZvYpp4rESkmNDG8Wdkiqj42Eeqb1c2bxn+NeIpmuorrSAgxLsg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/16] checkpolicy: reject self as a type alias name
Date: Fri,  6 Nov 2026 13:34:56 +0100
Message-ID: <20261106123510.76727-2-cgoettsche@seltendoof.de>
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

create_type() rejects "self" as a type or attribute name because it is
the reserved target keyword of type rules, but aliases declared through
"typealias t alias self;" or "type t alias self;" bypass that check in
add_aliases_to_type(). The alias is accepted, yet a later
"allow t self:..." still resolves self to the keyword instead of the
alias, so the alias can never be referenced.

Apply the same reserved-name check to alias identifiers and add negative
tests for both alias spellings.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c                    |  5 +++++
 checkpolicy/tests/negative/self_type_alias.te  |  9 +++++++++
 checkpolicy/tests/negative/self_typealias.te   | 10 ++++++++++
 checkpolicy/tests/test_checkmodule_negative.sh |  4 ++++
 4 files changed, 28 insertions(+)
 create mode 100644 checkpolicy/tests/negative/self_type_alias.te
 create mode 100644 checkpolicy/tests/negative/self_typealias.te

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index fbacdaf4..7e6d157f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1319,6 +1319,11 @@ static int add_aliases_to_type(type_datum_t *type)
 			free(id);
 			return -1;
 		}
+		if (strcmp(id, "self") == 0) {
+			yyerror("\"self\" is a reserved type name.");
+			free(id);
+			return -1;
+		}
 		aliasdatum = calloc(1, sizeof(type_datum_t));
 		if (!aliasdatum) {
 			free(id);
diff --git a/checkpolicy/tests/negative/self_type_alias.te b/checkpolicy/tests/negative/self_type_alias.te
new file mode 100644
index 00000000..61d801c9
--- /dev/null
+++ b/checkpolicy/tests/negative/self_type_alias.te
@@ -0,0 +1,9 @@
+module self_type_alias 1.0;
+
+require {
+	class file { read };
+}
+
+type foo_t alias self;
+
+allow foo_t self:file read;
diff --git a/checkpolicy/tests/negative/self_typealias.te b/checkpolicy/tests/negative/self_typealias.te
new file mode 100644
index 00000000..f9a075de
--- /dev/null
+++ b/checkpolicy/tests/negative/self_typealias.te
@@ -0,0 +1,10 @@
+module self_typealias 1.0;
+
+require {
+	class file { read };
+}
+
+type foo_t;
+typealias foo_t alias self;
+
+allow foo_t self:file read;
diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy/tests/test_checkmodule_negative.sh
index 5e35b1ae..45ff1838 100755
--- a/checkpolicy/tests/test_checkmodule_negative.sh
+++ b/checkpolicy/tests/test_checkmodule_negative.sh
@@ -324,6 +324,10 @@ expect_fail "type_attr_conflict.te" "Duplicate declaration of type" "type_attr_c
 	"${NEGDIR}/type_attr_conflict.te"
 expect_fail "invalid_type_name.te" "syntax error" "invalid_type_name" \
 	"${NEGDIR}/invalid_type_name.te"
+expect_fail "self_typealias.te" "\"self\" is a reserved type name" "self_typealias" \
+	"${NEGDIR}/self_typealias.te"
+expect_fail "self_type_alias.te" "\"self\" is a reserved type name" "self_type_alias" \
+	"${NEGDIR}/self_type_alias.te"
 expect_fail "bad_role.te" "syntax error" "bad_role" "${NEGDIR}/bad_role.te"
 expect_fail "bad_user.te" "garbage_token" "bad_user" "${NEGDIR}/bad_user.te"
 
-- 
2.55.0

