Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968529;
	b=bHG5DH0pohcuQgxtLOIaXo3dWv9+1MmjEWzwUhDNTJyUFAXRohT737uvv0jyXkdhCzo6
	 ZP5TntoZxTsz3czGkbTBIK0SYLcaXoN1wuLkhPYlRKW1RPjt9CPXez6lHx6ch79j1biBp
	 1qtXL/Vo/QcwfWBPQPp+7OObxzPD3OVp/GAvKuJY0AZqcWHte/b1ISd25wZAn1m/PJf1v
	 hh2JcY1u1FFYIdsFEW5BABzuaNZ0iBGLrsZIcyg9jEsi0AJaMenZUbOw/K5DAXnAkjJOn
	 sfjloKHXuOASI74tKN2+wbTlkVFqL7XXW+gmSmQnWxErkQTlEolQEayQuLyTt/FBkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968529;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LHGQvHR77G/0W8Hg+4IVBg/BQVJCZjkGa7ySFm+mD3g=;
	b=kZ4COVnqdr5G2Tq5VlbCgXYKfbwKEaol5dU6qD36FXdJZwvtVpz1eMrDuV8M5TR+fOT7
	 aCwM2CgxJxJVQxQ8Bk5lVZncq6m+ztYqRmBhoZnja56OJvdRhNIJ6s8B5ShwylxKe52JU
	 h2D0m1mU3aNVoUfjRUWtuTS0t7wsZrO1UCY4BUVMWR5ri7asUQDxeiJ57vAIEAgzb51tb
	 mqd4vVd2vCAaLzQO5sRgvkWDfOvyk1jE1DAGxn8m+XDA1sxM2oZoT5YMQqaO2cmOr0rAX
	 mtaywg1xBGWKzJHPVaQO8XTEXf3ch/7nd1IKit8f12RPHrcBofvLeH24BcwglH/EWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=BwHxAQkU;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A53606A330
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A53606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=BwHxAQkU
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHGQvHR77G/0W8Hg+4IVBg/BQVJCZjkGa7ySFm+mD3g=;
	b=BwHxAQkUs+mCi2t+p5Nhmthh9zpuYat18ponlYCQoSVMreIC0gXDC4guf7qtJ4rjUIDfnF
	2mi5JVvOPUBnDKfmdP99FBsjsPV6bvhBwM/ci4zccX2ZmMGilhkQ0nxZodSM2O9HhTY9Ql
	Xd5WvvArad9hO66p+dXWb7AVvJMVmvfM5UwrYWOUdsukWU3SbnxaaGtZLpGIT4mrl8Du1R
	z3ht3n4CVrbNVWmEM0MMJdqQTSsV8s2VJnY8VdrQyAWLgbQQycyYcDJ3nhV6xbXkI53S4N
	A0WcPHc8t9xvNDRaD3YAeI/7TYiG+Z1hX0u/KgZV5DCa1Y4hL/CJhdFHPPuImA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/16] libsepol: declare the cil_gen_require user attribute in converted bases
Date: Fri,  6 Nov 2026 13:35:02 +0100
Message-ID: <20261106123510.76727-8-cgoettsche@seltendoof.de>
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

module_to_cil marks symbols a module only requires by adding them to a
cil_gen_require attribute, so that a missing symbol disables the
enclosing optional block. Required users become

    (userattributeset cil_gen_require base_u)

but the base only declares the type and role attributes of that name.
A converted module requiring a user therefore fails to compile at the
top level ("Failed to resolve userattributeset statement"), and inside
an optional block the unresolvable statement silently disables the
whole block, dropping its rules even though the user exists.

Declare the user attribute alongside the type and role attributes.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 44ae04d7..98a202b5 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -4424,6 +4424,7 @@ static int generate_gen_require_attribute(void)
 {
 	cil_println(0, "(typeattribute " GEN_REQUIRE_ATTR ")");
 	cil_println(0, "(roleattribute " GEN_REQUIRE_ATTR ")");
+	cil_println(0, "(userattribute " GEN_REQUIRE_ATTR ")");
 
 	return 0;
 }
-- 
2.55.0

