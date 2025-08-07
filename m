Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70471A2390
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531070; cv=none; b=ksZGJuVlNHz5mCPjK4E6Rho5YHgTith6LFmxDhLyLKMjCq867v1vfcruWjTATNtbBeP1cbN/eWiL4478s53lboVaZ/BQ44OWGFXdWMRh/h/RP6jADQb/6m8V9tMDJvbNaaigtk3UPi8mlAPk8R+fdN+XTkYwnXzRY1YwVjdR9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531070; c=relaxed/simple;
	bh=2mkVdtlCixWWJ//o7YVUSuqsmwIk1v/nc9pdkOIaeBE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=Q2CbKPAEo+y9f+jDMSxtem/o/p6Wpbr1udDhivDJudF1oWRGNQU6UZeu1gVhjI2CzOM7XFsN2C/uE73mbOrWquSf2kXj5M4Gmm+t2800Ghb7MSyuArZ52yaRQpKtIKsQ9gLoFWX8esrKQ59+XMqyiJ59UhrDb6iWvVYrD9fd6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TOM1t96v; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TOM1t96v"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e6696eb422so61043885a.1
        for <selinux@vger.kernel.org>; Wed, 06 Aug 2025 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531067; x=1755135867; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=TOM1t96vrxWKFdxIKBs42WRa35bF6W+3mDdao42xHp1QCXOXEXLP3Z6TFNVZSYRyWE
         MQEe+qDXluS+P2reH5OxEXZXpnKTjG6xIVszVrwdPRScUcM3Gxxh44vU8u19id5mDGLH
         b6IH2FdSBnF/rHrYtrz9sE4DLz+I7GFefuXG89tOzmUU4uRzSB3Yrzw9e4aslgSF6acd
         t2vhlJOruV20m8jSr/MGQ87YxSfHQvjOEmQOjFzrcHcAu2Q2dA9AT4fUUJAelX2faIUC
         Nt7TCfLGJl55+W0Fwv1q4v/ujYjXlXAqVf0Jcylj1oZ2bE3m3521gwZNGPfFhA9UMGL7
         P8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531067; x=1755135867;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=gvmJ5q1Hsz50jeiI62kXsJCB8IXGwBPb/dk+jOCwW5PEV4ZWml2QRdBlvDT4GSWRkr
         ejxFXLDQa3m0IQz9dybYnnuJ+4dV+13QjxVX1nYZNa5Itzrc9hiD/gVJr5/BTJF89zTJ
         H1nBizm/9n9YPcgLtEvzmvUaeUiOeN/fx7eOUIFZrUiYof8ss7qEPrc/NNF7IsPXyH1a
         8gR2vPQ9bR780hJ4i+beve0u/TFMLd2UHQ3D9QP6WLyrg3nbqHTLfAqRXcKFMo/sIhyz
         hZoUDLfTX8v4U8syQtAimEdvWEUm1t+7wfbFgaBWwe08Q82P087ybLyQGNB2ZLa0AZh2
         pyjg==
X-Forwarded-Encrypted: i=1; AJvYcCX6KXOumAtDlotur2IAGoL4eEVL7f4T6fgHXRfZTDlYctX5XuZVojI2SWi3h9yDCmK8YA69jtCe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3keqSRSvQHDoFtC4eCEyzEsQdYBWevlzdKKdp4MDBqOQ35sv
	+N8Y9fvtVCsedPozyB8V41n/cp9nkHeS3VVSUqicyCBgK1j346wu1v/Tq0NeHhkYoQ==
X-Gm-Gg: ASbGncsKHORZwEKruzKgku3lEST89Z22mRWn8ZXV4nZrqgYS+geNSH2fAwy0cg8CZzw
	kEigS0Xtg9I2DfZb6TPi7RUEvJBw4kvoTkcRTSMXZZ6/JTyAlXCMnWAHb/is0ov4XA4qr/31BaX
	2HYkl1wBR9kb7WXtqpkeXjtTBu8y1sekaoVPbaHDFFmyKotfv6+pXy4W5LceGYGNYGH+wAmNeCB
	l0qF4p9OJ4HR3+L4eNLGT//ZlAaA5B69D7dEJvXDjy4aabms5A17Ao+RJ0nByEqD5STGtJltRQ0
	BKDShrE7pmWUz8NX4AsIyldnjscA9FGvGofnF+lK7/qag35KKpSFciH53LeK+uN6rRr0M37XfgE
	Otp0ljpIwQ2s55gFIOmGCiwno72uuiPtArkoDoSf7rLtEIUSh29GB6dzZzOEHSeDIZkye5/u9/J
	ZuqQ==
X-Google-Smtp-Source: AGHT+IFQqik3VoMmOjFgbgtVaSo3JrVORZjIHKYevZqqyzR5Qtzz+l4dS+IoKGuxupght4GYwl3SoA==
X-Received: by 2002:a05:620a:4055:b0:7e3:4678:aae with SMTP id af79cd13be357-7e814e4c2a5mr787904685a.41.1754531064023;
        Wed, 06 Aug 2025 18:44:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f7045a9sm890330285a.44.2025.08.06.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:23 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:44:22 -0400
Message-ID: <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>

On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This patch introduces LSM blob support for BPF maps, programs, and
> tokens to enable LSM stacking and multiplexing of LSM modules that
> govern BPF objects. Additionally, the existing BPF hooks used by
> SELinux have been updated to utilize the new blob infrastructure,
> removing the assumption of exclusive ownership of the security
> pointer.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
> v2:
> - Use lsm_blob_alloc
> - Remove unneded null check
> - ifdef guard bpf alloc helpers
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 86 +++++++++++++++++++++++++++++--
>  security/selinux/hooks.c          | 56 ++++----------------
>  security/selinux/include/objsec.h | 17 ++++++
>  4 files changed, 113 insertions(+), 49 deletions(-)

This looks good to me, one nit/question below ...

> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  			    struct bpf_token *token, bool kernel)
>  {
> -	return call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	int rc = 0;

I understand the motivation behind initializing @rc to zero, but to be
honest it is redundant and will surely result in a follow on patch from
someone to remove the initialization.

Do you have any objection to me removing the initialization during the
merge?  This would obviously apply to the other two as well.

> +	rc = lsm_bpf_map_alloc(map);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	if (unlikely(rc))
> +		security_bpf_map_free(map);
> +	return rc;
>  }

--
paul-moore.com
