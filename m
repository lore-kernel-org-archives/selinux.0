Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B632F002B
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264481; cv=none; b=JxceCynKF5zLqOKsySzq66d78TdqGsT2uqAxadLl72fDy1QDVo+HKrAPH7OxvaIgPywMvS4RZiQCpaMeNqdbWP0kTrRvgT6IQgKK3LOUjbunhvkoEDS4FCXx3nkDhnlbTVQUc+A5xyB1jIHS7GEmx4aRQ1juy1HoYhaE0THHObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264481; c=relaxed/simple;
	bh=ZzkADdvrUYp2iBklNDWW6xzN0gMHXVooR4VxL/q0Dq0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=X6ftdQx0MS4rEmUpWmgwTSc4mrjBuAsCqzARjFiANRLzvMC/4/4h1nObi1z6Nq6q+aw4laC/wrr9kyAIRxckEnrgtHzkUipXtwze6I89rpMFwmUCiNSjlorJLb2JIEaqLcVfJ9JdKGBwm8zdLyajEmPbqUnLclmuWitatIAMtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VCt6yaDd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VCt6yaDd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d20451c016so415182285a.1
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750264479; x=1750869279; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imh5Ssw3G0KGFdr40XoL+KWm94eOloF5qrtOJ+fWZB8=;
        b=VCt6yaDdn3tqn0oi6o/OUg9dN5QKBmB1+CSNLD9T/Mectqsiw5Di3ihKtFq9VSUip0
         kbDXiVw/zk1i4+lb4XiCVMm/f7+/POeF192NrrnAr1Eh1Zve117g2SUqk6CSWt2SxLQ7
         6/+3UGaQ1t3JCUJmM3T1nXnLtoKnFYcViqYa5b4EUiMnwXBQe5HTgYWOqyrmt3coebGW
         ++6Fqj2GzJdfc2cgvZLYpDUmscDPg+Lsy9lcIwKuj/ssNssd0q5UiC/z7KsEsPxVh/cP
         yVtIHcCBMfWh2KLMIKFz08KYQAlR3b2FrPWk/5YlTq+NUMCeZV0g5Tkv5z8UdErLNnyR
         njBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264479; x=1750869279;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imh5Ssw3G0KGFdr40XoL+KWm94eOloF5qrtOJ+fWZB8=;
        b=enPmev1Kn+iJxxOQbLso+TZp6DJ1f8Uh+YFNoIlpSG4OyWglcGT0upPSS5OGpCGuW4
         MrGYZfprfaR0n0hMmErjXC5ZrO0QNm3g2JUptzxW/wx73lTRD+6GOgL73sYVQ117L3we
         SK/sUE+euaCz15Orrp+PRSyG+0eoTRAmR/yXezIC71NQ3hT1ovFU2w0SpdaZ9A5cMOKR
         BYr8y2/zvmanPl5tWNFs6YkTJiB3pbrY1s+MfrQ+/3DeQl6orWQsvVWRzwRfBnFo/OQU
         TQ1PiNom9LuKuX1eY5OCWuaCXXKRWjpuHdhxnMJWdj9kqqctrJQ7ixPWyc+RdgDR0R8o
         pL7g==
X-Gm-Message-State: AOJu0YypDQpyzqF2B9W8Kgl8v1Nq9BiLK2xabMvR592xuU5IW169sE9U
	P8lQuAc7Ut5ZpvBON/G0NEChHV0RV8FR/QLAlK+yuPpdGYgObmBKiPndmKEa7iLq8sXKVzOAnh0
	4lUY=
X-Gm-Gg: ASbGnct3n7JEgCEL7rt4acIVZsu3zGlRf+xd1+tlCStvMZRKuf3l5dpdlQ8uEIG/OST
	N2qAF4HxwTjRtzrstVDHxjdkkfsZjSuL9KMfEaWdMDOK34BvqB/dQcRxfoSbTq262GQmhM10dVP
	n4KOSk77R+GMZg+Kl8EXAhBH5iHSbE6Q1g9Y53Djd4JALgwSKL2uej8Y0H8ZmKtK0ADJ/2zyBTG
	B/5dAXOM0g4l7tPbH8EHgj2FqD2mPsivLqaV9f8JQcdNKm/bj4Xp8+49YA0jlaeOenXqMsyZkCp
	dlNpvvIPbP4ZqpqFRjhgDmUjRMWTG6EETsgCl4B60WSBGZNFF+MJ+nG5gmy+rW4co542dV8nLAZ
	Zefd4gmnJxumGJzp0N3RYYM5UIAKNeRM=
X-Google-Smtp-Source: AGHT+IHr8FvKf71qQwRs4UPz7p47lfWchWTy4Nt0DInVpS3n1BfVZvOZGMOilRzif8doAl9RkPjI0g==
X-Received: by 2002:a05:620a:3725:b0:7ce:f58e:7e9c with SMTP id af79cd13be357-7d3c6c0c72bmr3217588185a.7.1750264479031;
        Wed, 18 Jun 2025 09:34:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b8f114absm778879985a.106.2025.06.18.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:34:38 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:34:38 -0400
Message-ID: <5894f2f11a7a4741ba0279c703160e82@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250618
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A small SELinux patch to resolve a UBSAN warning in the xfrm/labeled-IPsec
code.

-Paul

--
The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250618

for you to fetch changes up to 86c8db86af43f52f682e53a0f2f0828683be1e52:

  selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
    (2025-06-16 19:02:22 -0400)

----------------------------------------------------------------
selinux/stable-6.16 PR 20250618
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

 security/selinux/xfrm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
