Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAD4C653E
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077268; cv=none; b=UIFt5t5gHvJNp6ZEh1Y4rXyYyuFmFn0Pl+h3QgOexraZq7BHNE8vQ/DKUm+5NiR4cRstrD0WrJrQJz4aR0z4HZC1jGPKe1kgmx+B4lArp6egx5U3LDkqKC3TD35JCOrXL0H+zP79Zn8S9n+fViiISWfmkkSxyo1jyhbpqXXM/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077268; c=relaxed/simple;
	bh=Gs9C0THO+YQQ5M/pSvBZUbePtpSxP6ej2x8ZICSFHig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3UH0wQO8/FH21/ZFWcDR5U1v7A/LVyuLUcq0je+ddRaWV1mEScI6rsfQXUGSpInvK6Q2wb7exoTO9uyUpmX/Q85TdCK0phI2hADXymBYGmI3ldZ5+0bhKicNFvUTcqppEE2YXxO9QQBUzZ2iT+PHGzQ5zwcmd3XXhwhfqMNcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TOQdnJ0P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7mtRwhP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOQdnJ0P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7mtRwhP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05D0A7A00CD
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792077265; x=
	1792163665; bh=pz+lj8j7Nge7lbWY63YtqgKd0pt0XGR1QDiAg0zEhkU=; b=T
	OQdnJ0PSYw2uJBzQ6iRHccuRQYCEUSWrI1LlsFGTmYWuu5yxUqu3ZQy5PLcTp81u
	qOWyUpr0JdFTxtN6gfBO/YXNehKLphsb44pnz2g1Lidl6oJCxFnb/u/v27iznn0D
	Ii7mjE8wGbTOydQuXTCUHRVroRNWKsX5h7RzhsrFYBNgSHROWTaJ/Jd529y0D/9O
	VLajig+pnqWM+gzA6QP2W1IBGMub19hLPTYbErY3s2xvmRlhf1gj5VLbrULiJsBF
	NQfhn9Uv8oERFebeo+PLk8154ixKcdFh1U5s+PhSF4hUyMiwhkgemhIvxgEIrL6G
	ymIj9yoIKabMiwSdlktRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792077265; x=1792163665; bh=pz+lj8j7Nge7lbWY63YtqgKd0pt0
	XGR1QDiAg0zEhkU=; b=k7mtRwhPJgbo2MrmAc3EqAwqI3V9hQH45EV9N0DLMaz7
	sHMxpsoUA3ZHq4qsjy2SYZsd8x2gr9i0KGBOg+Xb5mPNEIEbuDf/AmNNC071OATO
	HXsBbv9RG2pw6+pst3n0XEH4R/4T+yWCoNje7zK3LSIDGIey8k4vlkQyiGVuJIS8
	jy+N3EoMzUmXG1NVDiwGfXbND4aBnXu0CFtxrRZc5VVOIlUrc1Aatv+Qm0+5fw8P
	o+zl3aHsDchjDIfCJq9Dh8YULOkLTMvmzMiIvFAKdRFyz9zq75hfBk5GUpo7EQmr
	cHkqZX8+AhlGu1D25iO56eJ2irSXEc5D4Xq3QBrMpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077265; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:PBy48oz90HaHOfJewP25aVwBz5xX4t9+kwDv0TWjtYAoweK
	P4HkW/r4fFi7vzFxd9UBMQUClXNc4ftFsjemB+7Ayuvl7yUGNrctH4lpkAafLKPr
	LiIlTDN1qH8HsSB3066hrnFNcx0LRrdmzGuWzkHUYqFbOhvfYdPsp51pJW9JTAd2
	8pFJqw8D/NU6veCfAtLgdNOJ7IGKOWZrh1x4OkMR72NvLrkI6IBmN/mgbDpFyzq0
	Z4n0hWt+nue+8JR6caXQQNxOR7NNvK37Xlovt9Il7vQ29npcyJ03RwG1M2GOoZTQ
	uKRpFxVSS/rjaaKjgsRsy2vlDu3TxRTj64TLJ3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+wr6ehMXBIBQsDMAUN4hhezevPVDbXxNES2h7N3JcfQ=:Gs9C0THO+YQQ5M/pSvBZUbePtpSxP6ej2x8ZICSFHig=;
X-ME-Sender: <xms:0e3Qak3qpSqidMgnxVIatGaHcKKaZJVkckcYcyOygI3vWcffRUfnaw>
    <xme:0e3QamAFwqSm1RVdTi3Hyg4dD_-eJlb5lSJ_4j3-7xh3uud8h462ozfbzz6-YdOtM
    _5Aue3PNfc9cHYcAbhJoQq8WMftObHZwZ22Yl8ujCMjoDjVygyfBw>
X-ME-Received: <xmr:0e3Qaij1EiholrS-NgmURW7pvn_ZWgPLB679rzSszFR2d0mL9Mou1sBHXPH46MVE-Fb-gSjs36wLBGDjAU085JZ66_ciFaDsbuO_RwDXpc0S9PMgOo22906Txf8hWEv8BH_7FwykTUH8Yomc>
X-ME-Proxy-Cause: dmFkZTGvzYVLZxzBED0c/WpDmVurWCaMM6ep2gLBg1hhNFZvr6fTbGhlnNWkPSFsU+PAda
    ufZ7IroiJh01v82kzwapurO3ZXqAIJ10Hfi3EQ6+2MPyD9QM6pbYp/y0UUC49PSDTVi76/
    C1b6XKXcpf3UKKowKmlcp9skOXwi15Sy9CWplUq73Uqb1vDYsprRXjdgcqphhH5EfuV/2y
    T0GmRVHkrqu70dGKxBeUzc1XeSr1SMHIlVyYv5shaQSqx9ORInpy1rU0ksHB8g1aTz+3JM
    I7pXTe5afxOqq5q8xAhc+d3kuN6uJYGySEr5ap+/or0HHKH7GhUiVtR4cwcXs7C2YNrFTY
    zbf43Hg41oHjxrUxNoTL55h1hgzWl5u3Khs0LWxmrvIQXGjQt0z0x0YU8VngzgfNXEGy1+
    nO+VSjpR0algg4jgDkZsMAAk5RXhUtbDFg5EvpU4ihe2/KQLHWVxlHapd6laBkZBLdHb1h
    ya34oubxEbWJTJiZ3ZBpqAukoTcMTBlq4W5a1oJSSqQH3mS/Bx98CzzPNLeOM8xX1jndiO
    JttUteFwPY6qlS82jy66OBnXosMy+yLMLoALDKctIuTx0cILq62Vo9uZKpIIEH+GSvAOKC
    WhkJ1ou+897V4QbazgTZNybjRzoAg5D/MQ0BmppINPlpEGSJHkbvuRtLDjgw
X-ME-Proxy: <xmx:0e3Qai_TqTE6gwy3F1d_vt0aaIA5rnr48jYJ5PAOg2nHnqRFpFKknA>
    <xmx:0e3Qam8ahMueBOKqKsgq7Ae7BYmW_88ngdgjKKMBLejzDGlbNMKv5A>
    <xmx:0e3QajDo_biat6cXkd8GTMzg6SuysOrtzYnGbAHwOvNwT9t5sia-WA>
    <xmx:0e3QauwF9p1hzLxM2JlNHsEtUgMGws9oFiWp4IhK2v4c7D46joCYXg>
    <xmx:0e3QamFMBaMelnonezqyBiTdr4xYaNzD_paZUcbnb1EeRmsYzqyYYLd2>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:25 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 1/3] libselinux: add -r option to sefcontext_compile.8
Date: Thu, 15 Oct 2026 11:14:18 -0400
Message-ID: <20261015151422.1057210-2-tmz@pobox.com>
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
documented only in the usage string.

Update the usage string to include "-r" as well.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 8 ++++++++
 libselinux/utils/sefcontext_compile.c    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index 4eae1736..11c2bbc3 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -4,6 +4,7 @@ sefcontext_compile \- compile file context regular expression files
 .
 .SH "SYNOPSIS"
 .B sefcontext_compile
+.RB [ \-r ]
 .RB [ \-o
 .IR outputfile ]
 .RB [ \-p
@@ -40,6 +41,13 @@ that will be used to validate the context entries in the
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
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index e504b508..02d9a2b5 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -524,7 +524,7 @@ err:
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage: %s [-iV] [-o out_file] [-p policy_file] fc_file\n"
+		"usage: %s [-riV] [-o out_file] [-p policy_file] fc_file\n"
 		"Where:\n\t"
 		"-o       Optional file name of the PCRE formatted binary\n\t"
 		"         file to be output. If not specified the default\n\t"
-- 
2.56.0

