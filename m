Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973126;
	b=hTbruwM4zTtOvH04R9rEISXYLWBCLVmKivkKNo8e6R9rysgfOVSQfTPyAySwDGHxjql6
	 8xOM2ti/Ts15z2bpVCxa8N6EuQrTfJ8p7FJ+TdUz/SWnKzaOBpYN/FBMtOB7o57F7ifGy
	 j86Vi9fE4Na11WIAv1w4QeGovfPiFIY665cAZLM3XCBcZDOQE18kG/CbH3IQfcp7SkIwn
	 k6RPMoMH2iF4ihy13TNUosagBiy8/p6t8cDLSvNORCxZXZZ5vAOQbny09UjsmazTeEYpn
	 1Q98DfOoeIyDGWL+MzMr/lkgJTgg2b6Okj3PhP2yO86DBzP6TEqS8MkGF/lU69v5etw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973126;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nHv9R0ReS+J1d9xFEZDmL6a7QDE7CgqohTYDqesFDSo=;
	b=jWU1p0LCZ+OnYfwkt0UQ04axskR9kd+9twNJdYqdYmIwP5D/mNmuKgs6sw2F0UzP1SUb
	 ZN6EzkdLJ7qtrxYjBkskx2skbPcz/bpgZa6PsqeuMMZEd+g7fGL48tRpvkW1vnTo3bR1X
	 6Xvr7N3UALp4P8QUcr1XLRGst2MNM0IokuXr9EGwmzihAk+eXDQWtTU3f29x17KbK+rsn
	 6ltO1H0i4KdY0UE7Oq0kbNtNhZke8rH7zW+cKTgfhbIj2dCbOQzkw1Vxy7tguHSl4aWi6
	 zO/BkSwnGT78U/MLo3HBamy2guv5WeLyDmSe39aFgTVYNKNOeIVyjyReu1xmQ8MotTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=BNPwE48I;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4093606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 13:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4093606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=BNPwE48I
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793973124;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHv9R0ReS+J1d9xFEZDmL6a7QDE7CgqohTYDqesFDSo=;
	b=BNPwE48IZ+HpxhuVwEZVB0EkUD7q0xl2on07pPxMUhrEM2T6MN2g+5x0uLAfEcM8+8rwRN
	XS655g2hrJhyQYOAPMO87dqZyYgUphRaGmjLVoseHfsmbFIZI05m/R5h/o9J1r4m17Lbyl
	xBVjOgbyCxyXYc7zS6BEy/BquJ2ABkcKactWefw+FjKB5wcVQl8CG74wHuwcRPANmGFHq8
	Pv0QH2qHMaYsT/JAUe/bath+9f8Oxt4W5D8vDJrm+73TLZp88W5SsLRrkZEVJI1Kqr9aFp
	hPqb0Q74Sh046AVBC4KWifAeK97iV8L6Q3dD/dt6AG7o1nOqeS/nCFyTHKr3Yw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: link the Python bindings with -fPIC
Date: Fri,  6 Nov 2026 14:51:50 +0100
Message-ID: <20261106135150.377761-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106135150.377761-1-cgoettsche@seltendoof.de>
References: <20261106135150.377761-1-cgoettsche@seltendoof.de>
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

Pass -fPIC explicitly through CFLAGS when building the Python wheel.
Setuptools supplies -fPIC for compilation, but does not automatically
include it in the extension link commands. LTO can generate code at
link time, so these commands need -fPIC as well.

Match the existing libselinux.so and Ruby binding link rules.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9ecdbd4d..4decb198 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -151,7 +151,7 @@ all: $(LIBSO)
 endif
 
 pywrap: all selinuxswig_python_exception.i
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m build --no-isolation --wheel .
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) -fPIC" $(PYTHON) -m build --no-isolation --wheel .
 
 rubywrap: all $(SWIGRUBYSO)
 
-- 
2.55.0

