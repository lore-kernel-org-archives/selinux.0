Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712A236449
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596051; cv=none; b=eMifOnbyhAS5J6W5QqdRX766E7Z4LiwKiFgSBZqxevRUonwBYkU3lBLrgoA3dELycpSqwq5o5cvWFMEf1NtxNBaM474cgUb+zJIXEqLucG2KKqd4dpTy+4AZFXFrY3giSma6yc5q7Ym/xH5Q1F/c8XOBjJSP5iA5FJ7l3Gk6LYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596051; c=relaxed/simple;
	bh=1qlr8GJL2BB9n4kNH3+Dz6Pj/CYC0DiifTzkrZhOxhg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=JOU6L9jBe5yaUclGn7fNQuV6hPoQ5dw/CYwi/Qt7htg+80+TLpTXzTbxc0ykFiDEUVT68cGxJAh0jGjLTJ56lGh3YToaeRwCRiZZ4YXzrLfrxWukMrQp6nT+05fsH0Pg4zp3SVxHzMS86LvGFtd86CqQ9hqcPZAbBX/roPFAj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QWtINTwO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QWtINTwO"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6df83fd01cbso1088566d6.2
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740596049; x=1741200849; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoab8tVH1emRrehVBE7lcewSYOeTGxv6we7fWwNFkB0=;
        b=QWtINTwOX3ikRRvkYBUyzqSZaAT8IHmL1vvxh4uDLCAHTSdnFv8gMcxEnt1KPlGuz/
         OhkYa+bSue/vGxbhfhQ7cNWbe700tMIWgJ8QO788KybP+j/5X7vItjEwttAjy0i6lWpk
         QzLdEzNSQ+hiPGlKjVnwzvKylSSOHaKF4ZAr96eqc54IRDDh4T/T6qWtjke7fR8pMQjN
         Br/pbRBgaXdGZpiQyNl2d1TKDK2/Q+5Mn9dVXDeBml/acE9RCzqJF5sbY7r7JeWAZhNo
         Hiofa9iJ3W7Dn7a77BLXqsUTiGc1ZeWuPsRBvoAE5iK4fGKSopShjvn3Y+xdRbaJu/LJ
         bA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596049; x=1741200849;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoab8tVH1emRrehVBE7lcewSYOeTGxv6we7fWwNFkB0=;
        b=kQ6MJ/DjgI52WK7i6g9EY74Qd+hqEeDq40LzfqmQK4kh3/CzIIaS2LvmorKczdI9es
         JLDKetjU028NpjXNkgX5ic8rVKle9fwz6L3tN/BtF644rhfJuRzWXv5ol422S8QmmFUd
         Qi+fvEIsRsYPv2JD2IPpy4TR3J9m+v/ljAbdMWykOVzF+KB32IfmdzKQBmtgo3Mi2plC
         YTa0QJzBT76DQLKgwZJkxzemyNzigWKOKkVAhwHlkawOWBw3tzbRwl5E3gB167zCNEYd
         X+ucZKLDiZ3cH9FyAdu4fJg0ulbGrwLPYVk/HSnQjPThMsPmbJ6cAJNiyPPNUFLItTQ4
         JB6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbGQtEzS1wWF11d6lEL675ZMLdeWww3+g+4kFgNUIqIIBo9Yw0dGH9FetslvjLhm0DPSyiOt1U@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwX/Uyxpg5F1IFZ3zcLofypZsdGWESCGZwOJFdV164ohyUqN3
	qC2BRYk9uY56YMeRzBN6AZMsYdRhNh3binKffRJ5b3czbxS/24wMCkKBLrMT9A==
X-Gm-Gg: ASbGncuxohhgVPAQNgwgnbpuxLf/kFYt+6wkOPX2Cxynh2qCnSYxuU2VLQ3W+j0tKIN
	cwfBLFxcsh5xDP9D5HPxEgHt5FeHIYLf7CstF7Qz09C5W5fuo3zkMrZzZjCBHJZ4RRD+0zBxP1t
	VVQ0HyFow/pMMIBtWteDg/T0WvxY8BIOfk8Flx+g42DiOI5WyfwrBZzRdXmuQwn/3nkRr1O42zX
	xrXc64/k17t04I51LLS6Kbf96WFixZf/pazV4zK4O49MpvMq5p0i3/KrpxE+zS6nWgRsoLKX5TF
	gXYqcoBJet+CaN4eiT3NuLlOoa5TJT7WH5O7aTNKqxAWxc3/o7bUk7n63nk9GFEIl9eMXfw=
X-Google-Smtp-Source: AGHT+IHY/gHo5RS8nzj65pSBp8fkAoqDG1AiuqhWo7HfbKQRXOpF245m1711zOR2hDgAKQKomzvLAA==
X-Received: by 2002:a05:6214:19ee:b0:6e6:6c7f:111a with SMTP id 6a1803df08f44-6e88690302emr53863356d6.40.1740596048790;
        Wed, 26 Feb 2025 10:54:08 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b15406csm25877106d6.70.2025.02.26.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:54:08 -0800 (PST)
Date: Wed, 26 Feb 2025 13:54:07 -0500
Message-ID: <8fdd1a7b0714532aa2498c52f0461386@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH RFC] selinux: support wildcard network interface names
References: <20241217135517.534645-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241217135517.534645-1-cgoettsche@seltendoof.de>

On Dec 17, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Add support for wildcard matching of network interface names.  This is
> useful for auto-generated interfaces, for example podman creates network
> interfaces for containers with the naming scheme podman0, podman1,
> podman2, ...
> 
> Since the wildcard characters '?' and '*' should be very uncommon in
> network interface names, and thus if netifcon definitions, avoid
> introducing a new policy version or capability.
> 
> Netifcon definitions are compared against in the order given by the
> policy, so userspace tools should sort them in a reasonable order.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/ss/services.c      | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

My apologies on the delay in responding, overall I think is a nice
improvement, but I would feel a lot better if we wrapped this with a
policy capability so that users/admins that did run into a problem
would have a way to work around this using policy.

--
paul-moore.com
