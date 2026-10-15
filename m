Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70ED2E5429
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028710; cv=none; b=i1eM5GUjaGGuRvb2SDPBw76jRG/S49q7EaYLa2xwTlt6LtnRdQW/TvKPzhlcdZuleuxTxGhh0p5IaqdR3RLMLaFEQoVUSygbtEtB5wh5Ix+25qpf1mJtuh/uDLwRuy9v7zFju/px9rrsR8ifLT86s6XXzmMD58nM0A2vIlJUekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028710; c=relaxed/simple;
	bh=1rrBFbZJhZqdA5a9TJm/lrL2PniXEok8D6hb7i97wZo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJowN9hkPtoMu1WMNJO8qYH3Uu8RzrgZbd+lgIXX7mCZj4OaxO1LkyFA//Ba1sL4KRrDRKVL5Y/MhVweY7MAUeyatf8RS8eqb3Vbhm/+VaXv/yHCBAIEsESpzSvL3BJ+TovkmVoGiBkNxhU/sqTPthkXb8wsVANxvBQD7vJfAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QCmfwDRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dvPZ2OS4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCmfwDRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvPZ2OS4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 207ED14000E6
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 21:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792028708; x=
	1792115108; bh=Lzgztu+nKZHgiqtJY3IH72WzLJF8LroTr15WiiIy0lk=; b=Q
	CmfwDRKczVIV/rke5A+2BUdtAOIEC3/xYDI5X1d2qlCD7xoJBSF9h0/DQ50kvxUl
	YdakVIrMbcs87ntzc7ToTkMpZ+Ou3oOztaMntdL7vVDXnxqiCjq1A6BxevBRTWI0
	xRvjvZ2j7An2p5rzXf7VXNGyVBpFaFon0dgJHh3t8IKErS+toh3HxmIFSde1apdt
	u2UxtIID1g9JOdHJ/tO1nRb/6QSL+rkAQpo1ykJkKAFk0In3esl5lo4wgXMC7TDS
	q1YvWIR5sJLV7G0D9/wbI3eDO1s5sHWyU0F5U1QfvmtGt+c3jlEQXYqHKoIi7alm
	hNy0EtQOlZpZ5szeUEgbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792028708; x=1792115108; bh=Lzgztu+nKZHgiqtJY3IH72WzLJF8
	LroTr15WiiIy0lk=; b=dvPZ2OS4UkPabVWY4ThtBhHVj12Md6tQOJf3M3W3y139
	LmTSVsj8VEgNVn+3G8LG/pcDfnwWeUl6kFksk5zyu6ZF+hWulkhgqCWOmeHUGPuD
	2ExmaS5f04QwjVL5faJQq/gTcnesNQPu+B7Q1x1CVDrmTkIrddSJ7MctcM4uhqSF
	ITRvgbPCo5uHN2wQz+qtD38hQKiUqVYg8bFNsq6ILw3d24/NDqPFPiMkA/Vz09eg
	6gJdZ78XK47cVCgmkJD7AkrQumKT9ZPDDEhvGB2S9ZMwu2SYclbjEksmurwRCdFq
	ZwDfRQvF/KEs7OkJkivIuFoAGtOmvXieTCwIXB8V9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792028708; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:CTnd2UzTfsTDC454czRJ/rs/OCh2gl3TToUxa7SBhwjXtCU
	FhJ3okd+2rSz8X9ADIq59N8pwoZli0id1D01/tPsezCvGYJmzF190zDgGJ1F5MKt
	FjbIeYtJc/AntwAaK/l481Wic9w+14+EPpdXz89C08+WLs/X8Eh4zmFRUzeZm2Kc
	eqb8/LFPdQEEloboRreMcRC78ee/JeJ8tuwdmrPsqocMSG5/8Dg4Iw/uciUDbPrd
	sJsleDhekY7VaD4G6bX6f5OIJ8E8JHEyzG57/XThG04FpBVjsHPnVJUVxOCEuWn8
	dhzI867iG4EiGDOFNj3qsOe7NiDUkZ039hU57fQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zI7upGHYAq8QL1lubke4VdBBh2D96oq2ni9Gup9G+ck=:1rrBFbZJhZqdA5a9TJm/lrL2PniXEok8D6hb7i97wZo=;
X-ME-Sender: <xms:JDDQarXdFKH8xuRAIOx9BZCdwA3-R89iCVm3Yvk6tHcVQ2R1iaknRA>
    <xme:JDDQaqgYj1QZaDfTFI6xFL1dt7mX01LZulDG0vKCH50x0GjisN4NIy2VBhzJB0IAJ
    7MzVAYc52EsGpYT_tRWG3NNPaW9uZohP7dLyuEddEdKzk_D3N5wU5w>
X-ME-Received: <xmr:JDDQatDaFnhzChuY3TrQZMVECQ-S7INVhR4oaQG7V54Eed_SrLBgEDUZJBbp03bvYHMeTNObkaUN9Ov9RAB4eGW10HwXCnGV46opxouGxYYKvRXl8zqHKkMj0ZPRvh25PDnqzcLxrHeYp-OT>
X-ME-Proxy-Cause: dmFkZTFHymYt1ABsB+V8Ab9CzWiaJl1F8ONvshXD8VCwj3J6isS3WLkSYK9s4cBd+Oo+Ad
    bipZePcBPU6Ibmhji332ieg5IFcPYagnVoTJW8FQHoxAv8SLYAoXUL/mYzH7JBHrDr7g85
    sFDtIYJ6FyvMw1+S3AgsDRmhEB8YpX8uEyLfiOLQQqbTKBUyaGD/6ZfPm0Y1TCL+QrOYjk
    cT4ilkbrtMP+u2JJVhYfJkBo+5oRNz1Q1YJ7g0iiLLd9zhdi8PuBbNMzn52SC3a81af/zk
    +0hiDGI6BuIJdev831SAp4tw/JWW+Ltd/hLFh2slxKJAcMAkrIRlEcTwAE55qcfU1yQisJ
    FvM3Qf1Jd9NjChIgMrXoX+wo3/SNe31FCGq/TdCowUwZ9K5ml0oLGodhK2/iNploNZCQrG
    Hkeu2sNNdBmbh52iTtp6UW1XI4qbLM0d/K1rHXXgxWeJ2s30DLlsTECx/5DjM/nmlHDHt2
    9rPtqkev/IKb7l1pZf7101xYeAVJ2xhpbmK63HUo3wUtTTVjLywpAoQkykMgxRCkBB/Gqj
    XrLahZ/BXUMDZnIzbeOgdPqm1ItCOgCWYtJpklaFCQ8N8+u/uHNQMRN9m4FkMbSOQGc19s
    1TPZeF1v4wM+/Lk6ZEh2hh50/DNQ7m6XBxSa+aEsQTPesDTGOkmPa3bDAvpw
X-ME-Proxy: <xmx:JDDQareLhyp6kN4MjWDJMosgg1alp_kAUmIzc2ifEhG8KA07aMwKjQ>
    <xmx:JDDQalfcFQNv-_1LBjauI_tRSLbBrd7jnf6shPjFXWpe9ire5kr1Zg>
    <xmx:JDDQavjnI0j20UHnZzgAx5JK1l6mR1eJNiTUVnCeKrgKYuAISHeoQQ>
    <xmx:JDDQahSeUfGiJc-W7R2_3KPfb8xakTm8_EKnCMJRC2E1-zBQayhL6g>
    <xmx:JDDQauk2Yiyaium1lSFS2hL7gYAa-oTHIhr6XLrvFHvM0s-2pkvlWgZh>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:07 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: add -i option to sefcontext_compile.8
Date: Wed, 14 Oct 2026 21:44:54 -0400
Message-ID: <20261015014457.877322-3-tmz@pobox.com>
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

The -i option was added in 487d652e (libselinux: sefcontext_compile: Add
"-i" flag, 2016-09-28) but the man page was not updated accordingly.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index d80a7381..13192e85 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -47,6 +47,18 @@ Omit precompiled regular expressions from the output.
 (PCRE2 only. Compiled PCRE2 regular expressions are not portable across
 architectures.  Use this flag if you know that you build for an incompatible
 architecture to save space.  When linked against PCRE1 this flag is ignored.)
+.TP
+.B \-i
+Print regular expression info end exit. That is, back end version and
+architecture identifier.  Arch identifier format (PCRE2):
+.br
+.in +4n
+.EX
+<pointer width>\-<size type width>\-<endianness>
+.EE
+.br
+.in
+e.g., "8-8-el" for x86_64.
 
 .SH "RETURN VALUE"
 On error -1 is returned.  On success 0 is returned.
-- 
2.56.0

