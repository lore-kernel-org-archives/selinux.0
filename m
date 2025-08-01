Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136221917E3
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071356; cv=none; b=eTgTT6HuHJo73XYEKSs43YMUB+CH3i54GnqGOVpu1mIyPnpfJqB8CgUGUFnRYu3tKBnZ2ToicpwZmwl9me7cjIFlEhoZRCNowT3f8zvICbpZv4hR3pbC0g0ddB+VGofkpoRBX22I1+34442VucRnMhfI/Q4wag+7YtU3xt3E7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071356; c=relaxed/simple;
	bh=R0/bCMMjBaLjWCD1+EdJiEaDfwrPNZwxZwwru6nwG9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=kf+2c90EAbEKPI/aR4m1iG0/hz3QZfwo/aV1gAfGATTZnAfxKhDOogkI3UKhZ9yxafHSOruxqJfOFZUxeZqQATvn2zBMFzo59D5AVfFMKAPJtL5053YGTffBn8ntngLm2Poera4JexnGHRV297PjZsHSCCfuZZebcvqa/7ITFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAa4Tgp8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAa4Tgp8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so11674535e9.1
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754071353; x=1754676153; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jve1d4Och/afFGSX4XwXAedjsag7SRGHaS3i4mUSqBw=;
        b=aAa4Tgp89UfrcKrQBVXWLiih1RYnz2aGt0/QozDLcTCRop/+LZEJVH9iWzI66kZRXF
         Hww/f3s4A5fZRufGpJbD1cvgqFwadQGt3cQmB335fuKGy3gDfSNV2yFixixIJ9Ugixc3
         SydYIdsdt8MObVj0iiKX9xbNaprbt+3dC8jgJm83dbZppnt7UejyDV1of1q+8semtKYd
         4diHUFNXaEAQlTodJDrZ0mhW3oozqIuA4/oUcCBGFV5KzNAIi8brRgEZWHgmDGI5rh9f
         cQ0qPKQba1yq/VO1enEngp8cPmO8U2BUtY37DViSedoOT5na7W1hkLEbBf0qWaV6mMU4
         5+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071353; x=1754676153;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jve1d4Och/afFGSX4XwXAedjsag7SRGHaS3i4mUSqBw=;
        b=b2AHSwHIKozZwB5/IAcdx1jdoWfK3vmczCgXbNZQv/bHPReFtlysiaEOFd6BMJgEIc
         cBcUgg4TOPWf0EVw7dkWBujw0X2Kb7+SNqfrdOuvwzkJX1gYqO70wsOUIbrDAIPACMRN
         maV8p/O6IKmhTsHhUUSUxCBYeCradohml2lEODrNqrvE3/bFkPTuThSplC5DIKwcwoJQ
         mMDhtyAH/0uRFwjkA1XQGdA4IbkbtwgAfwuR+YMkN0hO4S2u2KxP0EKg4DGb0/xzlhfT
         DDsbYpvJbFp6xv23nN4a6NAP3DgDaECVpk49vmItMoTISMkIO/X+e0jIf0Ac+9lHdJ1u
         JvzA==
X-Forwarded-Encrypted: i=1; AJvYcCUz/FyTKXp8YwcsNVLRTlzcx/PUVBDr1n1NNbwPZFo99Zh8wrH96FOuxp3m7EQlKLvBqUzHpeHO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7yAOVr7ek5LWjdYq7YpYsN0Tbm3kUUqnzUbzq2Grc7O2VBKS
	mpOaps7tnaXlK/+LWJJ0WVcf9SAI4wetPQnY1kflHVDWUM3+S/gk9M0Y
X-Gm-Gg: ASbGncu3TlrFrs2uixaXcZUV10b78l7hX8MresihI7PODBgZZ636bFNUmJBwPBUmGp6
	yFMkLPz/IRqbx1VfKfOCoKvye+1nfhDJUbQu4fgxx66W8jWOGuB8ByzViVTFWxLiX84CDYHsI2y
	Ae10hDgYqJjiNm2r6kOiT4qCmG9Nl1GQbQSbQ90g1XZY9um5kc6l1qeQoWXQjPeoonj2SyatUPm
	hCeFTK3W979onpUr/LiXQOAH8MktLjJGK9tAk/3j5NmwPaA2reR5Hl4fTmgnXP7YKKITFIE4dn7
	Sx4vp6yq6JfVnbrkOvmiVMB7OeMkxRRievseV2pOPNii863ptuP69sZt4OgdiPcq2oXLECjyGO/
	Sxe1uTi7IJuaFDuDycpT30ARIaP0=
X-Google-Smtp-Source: AGHT+IGWUrhzvduC5LlyLLqnsvtK/365x91uitDCtxX2Evs3n9thjI2qdSZDM+X5yyeR+Ws8TmaJ1g==
X-Received: by 2002:a05:600c:35cb:b0:455:de98:c504 with SMTP id 5b1f17b1804b1-458b6872ffcmr2250035e9.0.1754071352939;
        Fri, 01 Aug 2025 11:02:32 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaf08sm109671995e9.26.2025.08.01.11.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 11:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 19:02:32 +0100
Message-Id: <DBRAEESRVT8A.2W2FHL146DBLX@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: refactor selinux_check_securetty_context
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ5OXCS1nkJzukkp61J3a4fmGeOLftTiDHKjQmPvDw
 yKQ@mail.gmail.com>

> Unfortunately not. It would be good to specify one at some point and
> start applying it.

Ah okay, and yea sounds reasonable.

> The selinux-testsuite has a tools/check-syntax script for checking
> (and optionally fixing) coding style; we could either duplicate that
> for the userspace or come up with something else.

Maybe we could consider clang-format?  My understanding is that Linux
has also adopted it, and our code style doesn't seem too far off, so
that could probably be tweaked without too much work.  Also has the
advantage of a lot of tooling and editors supporting/integrating with
it.
