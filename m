Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE730AAB1
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932207; cv=none; b=o94oDOumcRHUq6qbGnJeY4BnA5wfYWi+QUCjT7zJxqsOk9S+mq8i1gnq1EZfZOJ0ml78kw3802r7QqYHqdRvH9fCANOn2uVnc/0gbaHqOn1KEEeOmxLlPLUyQRublEtj0RZmbyB6fkXjYsYb9oM/J5sBr2V9ESSDI2qZlFnhj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932207; c=relaxed/simple;
	bh=27og5+fwLnrq84zqJxNwPwieJR4goIKuoY55Yt2xb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cquin5qa1KVUJC95RVHEERMlRy1X+yW3cU4cIMPB+/YaeQuucNSDZl1hv+ZdQf4/hDZQyyJg8W/IbdVkXkOxZN/XU8CdWkgyqMqTRB8+HpvxjslsunKYGfPgLRExXEDRSyaJ+iTqlCLILBA+lbehaZqt/dvY5IYf5Nul6fbmAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cH97UslS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cH97UslS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so175252a91.3
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756932205; x=1757537005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=cH97UslScOfryM/kMlZ5wsLXstKkAQGi+JRvHcA4eVQ7QlaEol3FbJ6SKzShOH4uq5
         X99tkyDv8wzgXvFCLXDirm2/Ne8Cd2AtlRaq8x/AEIryR4FbCxaWpcfhcFIyxYoK5j4c
         gduSY/BpKZ8uZf50Wn8575y811S/NnT2fQLvfQc30KLOS/mRk5I8MnMq7dQj67Esm31z
         EWH7ZbCwHIuJYLrvZZKwW6Q2y5H6CFtqNFqqVdugbeVoAzmv2dOvieiT7X3FoHKwId05
         fDfcF+8fUInA01ftYDism6bskgoVjZGFrHhXbFnjSkJgzMJBQb2QJjbSlinUMJfJ7BE0
         oN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932205; x=1757537005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=nJLvtTBPLxEfxqtAo9wm2JuWC79aA6pRLnudDgCVE0aqYogEe40OuVl12adIBp3kCz
         0VpSMYB5ybIMAtiP0bZiFEZXY9vDp7sRidwuosxNQiL0Cxg4XtpYhd2JzzRSfjPUH/7M
         7aa0seZzGEhxdm8TkGSLKEEcsN1Gv7+k61KcnsUTKq/R0XTXHC9NiYAaumyOQrpqd+Xg
         0CQt5AjUcN4w9EKPcUNTgw+jKNPJlFUWoAZuSKdG/IAOWoiNFAcuyE9HgjECOlJ5a4HM
         NjjHInfVNM2SIsAiClJou+8yWJyFS2Jz5DIvO9kHmNiTAW/XXZz0txMM+4rkyxNBgqyd
         gACw==
X-Forwarded-Encrypted: i=1; AJvYcCWUiRU1vLhpsAXcJeBJfJWdNTJhjtaS43PxzXksBuTji7FFO10cutYhODD4lmv9AF8EHb4xsKAr@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6mL4pY5qXKiD0Mv8aN4PjCvKzKYU9oMNff6+G5L3VnOCUjdx
	4oZun3vkNBSXNOowhpPPbxI9mEja56rGdYiC6FncnAf5d25/M88//gLRoEFPJAS/AEscGeB+Cnt
	eqrfXSnf4PMeGsSE+YGRZBhlQ9PuTEk6v0mgMOrUV
X-Gm-Gg: ASbGncsrJ10H7V02eKM3FqvrCTqkDCRifBJ4Bcd/WkTcO0Y/KdSXVSW1KE1iuOJnCNi
	8jlq/hChyi2EFAgFJybgvjtIHdfuhxIYTqMZfP9xK1BG19B8OFDgQlvhbk+2UArLNAv519hpdw0
	j+g5wcbUlcG24JQwR8SpoJdgjlNXg9MWMu78vJWJcmeR2zKsHzMaXkYYCc4Zl+KM4glBO2GU+F1
	+zHy48=
X-Google-Smtp-Source: AGHT+IEQJCaMMXRQwVvK7h5/Q6b9DGduxYynzANDDzGXPsK+5nl9MJ7jOAJpAhUnmR3pkuQpDg9Pg4o7XueiTWfhdoI=
X-Received: by 2002:a17:90b:2802:b0:32b:9506:1773 with SMTP id
 98e67ed59e1d1-32b950618b8mr55670a91.33.1756932205371; Wed, 03 Sep 2025
 13:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com> <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:43:13 -0400
X-Gm-Features: Ac12FXxKMPsEzJAGYC2xoOwmRYoQxVIxBe63dOEJDQM6GwZfLYjmyRi68JmcOCk
Message-ID: <CAHC9VhSP=NEDd7nLUxPj95tgaHeERaJHf2KH9PDfpwNNuPRzTQ@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org, 
	mic@digikod.net, kees@kernel.org, mortonm@chromium.org, 
	casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Paul Moore <paul@paul-moore.com>

We should obviously drop the 'From:' line above ;)

> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c  |  3 +--
>  security/integrity/evm/evm_secfs.c | 11 +++++++++--
>  security/integrity/iint.c          | 14 ++++++++++++--
>  security/integrity/ima/ima_fs.c    | 11 +++++++++--
>  security/integrity/ima/ima_main.c  |  4 ++--
>  security/integrity/integrity.h     |  2 ++
>  6 files changed, 35 insertions(+), 10 deletions(-)

I'm happy to replace my patch with this one, would you like me to wait
on an ACK from Mimi, or are you okay if I go ahead with this patch?

(As an aside, I'm still not entirely clear if I should wait on ACKs
from both you and Mimi on IMA/EVM changes, or if one of the two of you
is sufficient?  I'm happy to follow whatever approach the two of you
would prefer, but I don't know what that is ;) ... )

--=20
paul-moore.com
