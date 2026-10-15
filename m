Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1F34F247
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028710; cv=none; b=lHN186Qr2cp+/A6tRpp4+kA5CtgC8drz9337+QX0NhwKLjR2yiyG3DjTsjX10ytBSzCzyjkK0Yrpw75lywPBE8N0KDe9XSdsBXWdCjaHUh3yGYlBK6a/64j7QecSOfopFOa+A6KRed4A0YjvbIA0o63A1vWbfazBo1JvdWyEVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028710; c=relaxed/simple;
	bh=zr39EMm2HDjQQJ1PiK4r/NQo0EaJCRPJK0SCK1vvpFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiKPcgeA/r8UYnTUINuZbNEE+BCK1sCt/oDk7FoRXSo//RonAx+JNM5rdJAoGGAyvjGG3xUcLca0uowLlHnnJcdbQxd7nbeYAN0t8pjnnVqSyISIclED8Gd4mH4jN1qdznAZ6abGLV3BeCeeYN4OiD+bB60Ds6CkbO5UBTzTwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j2CL7BlF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sl/LTYEu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2CL7BlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sl/LTYEu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B812AEC0374
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 14 Oct 2026 21:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792028707; x=
	1792115107; bh=RcC51Sr5zj6fqJNAZrqPc7iLUEkz5bsziHF61VFnk2k=; b=j
	2CL7BlF9hK6lO6C+OHAemv9J5KmQQP3Wq/VhZrO55jpQMjtl5dhaGIL528NRvZMP
	3GGBQxlJjcSGU4FYMObONKa474APhsyqniJENdBOU/ib/tg5e9jd4uRwVEZwRfRX
	8fP3uz6tt1XkMQ4xjWW0ycxVgwbJ2s/dSNMs7kkwVo49d8EOcQQHXIh+DSlLdcT6
	4UjSwdU8IA7LGkfGowDEv7+9Jfi0t2u5KodUVVpaHwBnF/JvyaBzTL4BUC1/sTlq
	oaaJccX7BRLRWmQQvZS5yniCS49NEQa0bccLaJrrGGDM8blScjrLcZHTt2bFC+i5
	Ul+UUnHXqxhp/6dtDQI5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792028707; x=1792115107; bh=RcC51Sr5zj6fqJNAZrqPc7iLUEkz
	5bsziHF61VFnk2k=; b=sl/LTYEuGGas6y6ABGt3YC+tOO2GPF8XKrRSUoOkDtwZ
	GnQ3ICppMFE4b3i7zW0Qr8C1jDNwulYxAcU2BZs+hC+LNdQK85NPkvtMTQ0nvbTN
	CsEQMXfXePJ99Q2HwjaXXjiKGYDMg7HL4hm6sGbct3J1gErl9w1f3/eJ5P6SkGAO
	r2TAixtpNMTEgyqIRecGzvlNFfgm4Wr9bzbzQzY+L4P1eFVmJJvInF2fhaTTrwi2
	0PzIk4wv76pXBEtwl90IQ+kfWuxHUtJCjj0oyFR/cl8lDqVEIVUZAEcwDul2uNoF
	gAN83KLHrbraOEOgsFMc+EPo1GYSJTefzb/oMJjg4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792028707; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:REvsoR8Ll5Jyt0OeDI9Fzy+mAItG6Jko6fqeVzkQC+6ymiO
	PGAgGA+VZRJ8pnTYzAS/op75zMzbqPGhdZXhO7KzCy0ugfCP9A4oTf7XUS8PDwKm
	oaRQrNxiZU1rpO5CTqE1MZsOuQyuZL9I8wwUI3ZyMDQniSJNWhUmXXkNtUCUwRjN
	b1VrNImfrHHm/q544hUHKIBmZXkbHnHkPZpE5Yw16NEn/wIoYvR0d6uaJjGy0I2D
	7RAQOgbeiSFs8aW4gUhi5Hn/+04tUX5afivhzLZ9av+asOHzB4Yoa4+ssSn2y9VO
	rxxJEsEbwZkdsjXMmPgt7HB58j/QO81mYHMzaQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:v1Mz66vqM2WwWXOAe5++AYfafuN0ly5RJgDdYIMTnHU=:zr39EMm2HDjQQJ1PiK4r/NQo0EaJCRPJK0SCK1vvpFc=;
X-ME-Sender: <xms:IzDQagJZR8y-IZqj8uQBbh38htK3y8e5j0YRv1STFgAS-4lWW8BqhQ>
    <xme:IzDQanHG0IT88Yemyo-PbJmx2KZQyVA3f7FSMHaPqyK3k7O5-zKSkeK5VU3s4GS6E
    2gq3Ptie4fjw_wMdHRBmXhqv1b4Q0kVzr7Md0BykYlBJUm6ahbjJA>
X-ME-Received: <xmr:IzDQamVvfIlWufcxpL7pzsmNZuV1AETj8FFX-gS5yL0k-INZ7aS53m3Pxe43H42CA00NdGrx2QjP3TWooYqikJCuMmS0d3TNQCcIoxmNFy_yAzm76FYh7l-PbK4cI-5I12CZirZduQgWQk9Y>
X-ME-Proxy-Cause: dmFkZTE0vJokWS8xRf3zf+vyOCP06Vk37MbgeXR11HabD3ZrhRUiUQXCdFUg/PhGQafbNP
    j4EHtYsf6dOzPtjMeyUA7q6e4OOsJ5sBGdY7G5ioX8jAPF1Q+ANrCsvAd2NJ/P/hILRUcN
    ds2L3DjFAWcXwASyJn29Zu6fqarYukqcXf8rhGrV0uPWOyiNAHEr2xe69+FYO6h5gq9drz
    vLJXE2cVRo5s6Utj/zySoUctot9irPLFResjiBWJl5kq0PMn7CDvgclgRk2j1797bGaPL6
    vQ8YcqZ07eQU6ORhNrKsDsbiwwFu4rcd3MZgaJCIbEbcvZcWyOo+GxQFQk2behRTRZbXkk
    ytH0E6Iuf8u+H7a1jGm6EfJUaQQWxqTCc63+HMvJnLYJ0SzMwNGrQ9//xQv8MeaiPFLEvr
    zHQ4534z9tMlS/x8KI4qalXfhUxp43JqQT0/17R/ZBXNR72Eucod/1kIT1k/kS3h2oQ47H
    GVI0z95dy5r7iTiT5jWY8/mvChPaaiDQqFBd4CJ6CtTkssIXVin7c346xXRvH2r7AqeKR5
    /rXRBD8PsYlzoe6P9YAJbZWfC0ALzNTl1VdrAjIXHFc4vaUlbYn/Fpo4MTALnns2pTX3CK
    fWLIrtFmsxXXGosvcQRsiMgkJAa1hvsbKwjt8sUUGpGkEfGNkcel2mO/cV8Q
X-ME-Proxy: <xmx:IzDQaiitoQWnkN6apjcfct2yh4khpEbzA8enpdgs3pGObvfe9aPAqA>
    <xmx:IzDQanSfbZlxaYw8WIi9ydbWqobMZpl2-6wxu3-8Gh6XKvGIBSSjdQ>
    <xmx:IzDQalEJiilztsvq03l7yktoQxnCdVqG-AlnoHgdcYUJrJiU0VAtOg>
    <xmx:IzDQavnGz5ey5j3rDTX_lsfYen7pULAxcZ_Yzclt_pnHLGIpepZfXQ>
    <xmx:IzDQapqWe4k9H7zBh4iHyX5ZI8fNsM96LXqsCnumBU31MKkwbBjU2xZy>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:07 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: add -r option to sefcontext_compile.8
Date: Wed, 14 Oct 2026 21:44:53 -0400
Message-ID: <20261015014457.877322-2-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015014457.877322-1-tmz@pobox.com>
References: <20261015014457.877322-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -r option was added in 50f0910c (libselinux: add support for pcre2,
2016-09-15), initially to "Include precompiled regular expressions in
the output" and updated in 36df3755 (libselinux: sefcontext_compile
invert semantics of "-r" flag, 2016-09-28) to exclude precompiled
regular expressions.

The man page was not updated for either commit, leaving this option
documented only the usage string.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index 4eae1736..d80a7381 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -40,6 +40,13 @@ that will be used to validate the context entries in the
 .br
 If an invalid context is found the pcre formatted file will not be written and
 an error will be returned.
+.TP
+.B \-r
+Omit precompiled regular expressions from the output.
+.br
+(PCRE2 only. Compiled PCRE2 regular expressions are not portable across
+architectures.  Use this flag if you know that you build for an incompatible
+architecture to save space.  When linked against PCRE1 this flag is ignored.)
 
 .SH "RETURN VALUE"
 On error -1 is returned.  On success 0 is returned.
-- 
2.56.0

