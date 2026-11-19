Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123341;
	b=lJQz8fJYSxNhvs6D8babPd3I2URxv2iHK5CCu0GIL4yOpx0E/yn5J+YihmmOGGPxFrh2
	 L9uFf+8CIL3+pE2irjrC1Gmgk8ygNmsc4LUSOtV44EbGvtE4dky/H1AK/Nro2kaaFxlP5
	 rZh6LLvsmyvq7GboVfOtWBYCNndq5jWPQprYcXEU9vEziBlnpE9uqblFPr7qlz++eQvWi
	 a5rgMv9fXyJV1IPprNVl94E4Je8T2cNeONKDAczR5PUd8tef+3l+OUYdZ5aPPN2y1QCkc
	 5vnxrH3ebwmt19YrJMB38xwiO1Lja3oMU05jsS7gVd5Oj4QtFkM/BDX2Ngd+/Es1Jag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject;
	bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
	b=Ai6CZaprReszYynVkPFaEFOPvnLk0dgCNP3y/R+G7300kYIH4MIEPMFG6gY2MwVc9i0y
	 2MH0iGM4uy5SBpA6E9mblbGw3PUyUzVK9NOD46MQjlWFF7MNtXyuK3qgEXFZdrcc8R3RY
	 07pFpAfEsgljma6mRSvKY6i20W1ylghgb1ZYrrYa3HnF2iJ5KF6c3jC+ej7HWuHWPxOSv
	 0RcY2fLS3UQ0BOv4ovQ50RDDHrO53An8rJXZxkSoecbQ2Q+6E2BB2rtV2CkST48zhdU0/
	 PLpP4TozVz6YEzEJhzbNOlyX7iK7Vt39kAAARuOxfYg+bd0QXxAnrsfPyy7osizT8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b4kyZD6Q;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C8606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 21:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0C8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b4kyZD6Q
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94937a33cfbso25762285a.0
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795123339; x=1795728139; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
        b=b4kyZD6QXm+GEEGwq7TKClxnDVyHew5vDgtJgHBG8EG2okFDdAH4+rLSZVU+CLaD27
         o41y0HI1+10Tu+/uX0munx6pDHmyNXMuU6pm9SGYPVGwUwx2fb4wXToFvXHOtZq0A8Fk
         SP1GtOx/ty2rXiaapHazDej2BF5Va1HQ5szRrQHS/IEB4oRVLnUKKNLbZEjHpj6NJ74D
         DxAcyJmGCCCbf1Zddy8R9pc0U/RH5x2Tcdyb/c0uyv/yLHAhHCGr3JmSM0snMIgsZjXv
         pPGZcRIGfXTTXb7GbMJgnft3SYyL7hVt6RS7H8CgK3fTS/WSANLNtm8c0B64tfnvIGS1
         cNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123339; x=1795728139;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
        b=ZQYY0bKJfMoLVwOD0/mTcffN9QJ5d8NBf5htDKbLQhWT7BemBTUhIwMsAMW+Q+B4m+
         IYcackmzO/obkLANlnLa1QRM6V0HUWYH4zPjQ5FY1f0tZz2e33yAZnVyIRpx6xuQi1XR
         WbD+TNwcdw4/R4/BXzyrhSuhyHWyo4X0g3Smw60ZHecJ9jpha2TUCFmpC5s/kGvb/OXF
         MpkmYi4TaWNI/GMeKqvi7lPVnc6wJth9L2uv/mqimxIRe/H+/HoB1bPZI2Gg8CF6Cy0M
         6O7TDO+XdrlQF97JXbKM/RZri6OlMWWXacsMONwkuvkS/uSDeXqC1/+MN177y6jooK+J
         LVww==
X-Gm-Message-State: APuU4Z9ZURa2PtDi7Ds8Jx2ArzHuK1eAM3sGEAHCUCEneBdt7UR7Cv28
	87lnwEPUUGIasF6XOaI/YD/x1UJzG7WgN4cGbb8XgZh+rsQ3bKvrffLSxAtasMI9mHLIIg/jvn1
	SkVk=
X-Gm-Gg: AYBFou1aQJZY1mO+qCO5BII/Fh+Nhz3La/U8emEJvV82Eo9QXGEH/mllc4eyQjAuS3K
	KB3u+sj2i4Nei30A50u5evMcJM8QgpSxs0EsXkkHlnhOiTavqCRQ7je3lE7a85rY1W3kjqC7BbS
	qcTvfT3ExFjgpb69pajjgm6OCsH+q8iIVGkpVzOnytO4HPeO8VMoMMJY2K1jcOWG89bdRcthmRk
	5U8CcA+FUJUD1jaA0ZV1tbuaSsffkhWi1qWvHXmxQ/ttoMy4+4Il9Za8/XEn6rPXQILpxVL08Wt
	Hd1IiFW81JCqU7S8H5Uwy5oVswQ6VHtnhKC/eM7fIzZEDs0UNoPcNwVGJKIEb0Mbin6wJ0UmTZw
	a6q/Zl52geU+Ai3EZcG5JjBbDx6bEXkz0nUQSXRAhBEw6iMprAXv3okkOJnBBd26JFvSQE/miEe
	aXgbDgHvhj1gFiGFctNpu9OMATTf08CSSi4R7cYTwdYmhUuKwsaHWTrAC8SemoJmo+xfE9BSdRu
	Z/NYE4QcPxKGZpSW1BuU+Q/mEPpMzIRCQRkq81iDRMmVS2QZhElI5PubylFq/TCWa17lFT+vtjY
	6Y1TzOGfANG23PqwF9q4g+3XnetWmOkRu4kaYb3/J5Erp3LGi0O6kKs+wh8hj9Izwmyb85s6NCz
	UMowIfsvu02ndim0icB53msyoiLa3kw==
X-Received: by 2002:a05:620a:6c18:b0:93a:11a4:223c with SMTP id af79cd13be357-949ba81a577mr150251485a.9.1795123339444;
        Thu, 19 Nov 2026 13:22:19 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40ea12sm49176285a.35.2026.11.19.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:22:18 -0800 (PST)
Date: Thu, 19 Nov 2026 16:22:18 -0500
Message-ID: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20261119
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Linus,

A single SELinux fix for Linux v7.4 to fix a problem where we were not
properly handling MAP_SHARED_VALIDATE.  Please merge for the next v7.4-rcX
release.

Paul

--
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20261119

for you to fetch changes up to beb0ae6bcd7505e2e61babe5d98a8dd3b3f03c7f:

  selinux: check MAP_SHARED_VALIDATE mappings as shared
    (2026-11-09 18:32:04 -0500)

----------------------------------------------------------------
selinux/stable-7.4 PR 20261119
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: check MAP_SHARED_VALIDATE mappings as shared

 security/selinux/hooks.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--
paul-moore.com
