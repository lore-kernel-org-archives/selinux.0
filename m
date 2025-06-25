Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCE3FD1
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810255; cv=none; b=NOHEOgjbXK2I3GApL3BNFD4ScnZIbjesIWDmrxA0ohiBLopC0ZwpR0aXPQTEtiu5hJZbuDAd+31HsPOubelsPgaUDxCmzUgwae7n+6aLkj3/7RmF9mDh6adEWt/K2AJACFoTjrwmv4mpOTFYq/yU1Uk6PXLUtvUBegxA5CF0Fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810255; c=relaxed/simple;
	bh=9ivD5AaMhRDnIDnklljlK+k1JVxliQvvRwvsCgoM9ck=;
	h=Date:Message-ID:From:To:Cc:Subject; b=jAQkNUJvT43xcL5OoRiAMmx88A4N3TBLfn6/5ZUP1j6zKtowgF4joEEvpTuq5zkgiJ4zO70Nju/qRJnW+YYdL0l4nc6GvhCsyIybnySgp72iWRi7CV91DVnKOdbvGIGR2Z3683byCQteZhnnAox/iSSX6dXUySB6oc4iYbW8q7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TqG2G9Tm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TqG2G9Tm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d38ddc198eso654939685a.1
        for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750810252; x=1751415052; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL28Tc4w5+Q9+lcS6siAOTOvpsM1FGjQwIS4zdqxK/Y=;
        b=TqG2G9TmsT9W73nwV065TYKqyDZr540bCvd78cgAbDNcyt+VkmQidpBM/aXHlkUBrw
         BScrnBJktJj9q64n0RnxMRJkv2hSA9z3kB31gGbnB7APCpyfm9p5qf20U0rgkvhzkVqe
         2X7fzK1fIIRhuNH70P08WDm8LLWxDlNRjVAjqVNkzlKf/4043NFgeU9djry35qQFxEta
         QG675alk+W2bSgqK3JYCSPytVS+rfuUE6HmE7Imi6yHzRpAJcQOEKFvpnlvIGpUPdn0y
         pcCf2WppCQRpHA7uAidxYgHSuKoUjp9Y9JBkfr+AoCi8sALC6AbOf1Usyk9+v602464T
         3xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810252; x=1751415052;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL28Tc4w5+Q9+lcS6siAOTOvpsM1FGjQwIS4zdqxK/Y=;
        b=UK6WLhq3GuF/dCLoj30h3MOcIgmWU1S1an3+srqsQxqWMPB8cIvoPq0jlgRYs8sR/P
         29p5gPhihcwQkc8JRsvVXTVAZ31dBhyhOz+GPgiXP0J5sW1HNOR4aID0cKmyPTlYHDj4
         /P2wTbO2TYoALdNf34/OeWb0Y+MKja2m+50IzSdon0kAoTMoghw0iqUwdBwydiCyIPWr
         w3uiGVETVcAJhs2iTPjdzrVNOg0n0GS5GtsugJifjvr2GVf/kwaAR907PY0ROCNrc9Th
         0cTYbAKkp7IF1J4m0CTfTOCnEYImrH7TdkpEn5Vp8nbRyLawHYhC9WVjCe7uTgPQ1KIV
         h/jg==
X-Gm-Message-State: AOJu0YwPmsb5wiuAEJNe9PuUerFXuU5lg4FB6oD8hr9U3LHiGO8Ln3AE
	bMwoC6toNd/dPEZ5OTjABNnaGyeqp++wpjmZWawlaKR8Z6wCH+rfEeYEm1UkhBakFw==
X-Gm-Gg: ASbGncutHFFN9HpOP4p86efVjrsEcGj9aGWWB5ivFkLvlb6yCsjshlB2UAIH7lPJueB
	Fbn/JK7WxzcBQZ0jhwzmVAIZh+BxlYQHJh00IFXvS2KvxuhCUcDlYHHYCH9KTuS0LJ+gtLgKVY4
	8DlNVuizKcIandH5mCVmV6eFly8RPcpcwTrqcOp6fbt0Ciyrgiz5qJiN0g2cg4GUeX0DDjV+OIw
	no0IB/8OleD1Qwz8klx3ZMKyhBrMdUAOV8WbMnovuv4763u/I2bP1Bqot0GuLA1JZH/eBqAghrj
	NqEUkmDcNe2gTOB7pPgZ7i+74bpfRLPFzN+kJUwuSfGDV0uiB/SOlx6bNDCbTkn+2MU6tygKiAV
	OaRyI8FujBcLsYsiUwUKY3ovIiijMHfg=
X-Google-Smtp-Source: AGHT+IFL+HjknXTXoFRm3XUtKW87TK5WTKCaVLsRbT3brEr6WmdayurdNBDLXUWYy5PXbZrC8PQy/g==
X-Received: by 2002:a05:620a:370c:b0:7d2:18a1:ce0 with SMTP id af79cd13be357-7d42974ba31mr151411285a.49.1750810251876;
        Tue, 24 Jun 2025 17:10:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd09442d14sm62087126d6.34.2025.06.24.17.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:10:51 -0700 (PDT)
Date: Tue, 24 Jun 2025 20:10:50 -0400
Message-ID: <190ee36309adb0efa27e3b39a1a93de3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250624
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Another small SELinux patch to fix a problem seen by the dracut-ng folks
during early boot when SELinux is enabled, but the policy has yet to be
loaded.

-Paul

--
The following changes since commit 86c8db86af43f52f682e53a0f2f0828683be1e52:

  selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
    (2025-06-16 19:02:22 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250624

for you to fetch changes up to fde46f60f6c5138ee422087addbc5bf5b4968bf1:

  selinux: change security_compute_sid to return the ssid or tsid on match
    (2025-06-19 16:13:16 -0400)

----------------------------------------------------------------
selinux/stable-6.16 PR 20250624
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: change security_compute_sid to return the ssid or tsid on
         match

 security/selinux/ss/services.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--
paul-moore.com
