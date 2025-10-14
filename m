Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76542DF71C
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483566; cv=none; b=XQMxO5zHSEJWxTbGFsweqSyPFMJzOgRQuU3iuHI+LCnlrlGc9rkAiTVEPfZPtMVcX7NDQsyID20FMplFEiriZ8iT5yyW2B/v1Rbi3F/fe9kiT2HeGw1B0dQzVmW5Wp6GqcyBN8DfULIS0f8CiomZzJdqpwIpbWlTV7Al4orRifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483566; c=relaxed/simple;
	bh=3Zla5hsgeKl5qE4xSZwjkNBiMgzZToY1+It37HWjw6k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ssCIpBuWzjL8u52c95XvWfD0NmwAZ5dF3BTEc6Hxp1D2yUaymgSBPt/XrvC415cCQwbuUuN0xjiB1VHgjrJLcSbCOooXeJEP6ZBUdeSgtEJuH/bZB2yCO/yE5ece8hxB6VkgghiRwO1Ww6tNvRydatxzY1J9A23gFNtEzLdQT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NSjOr9zQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NSjOr9zQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78f15d58576so4742956d6.0
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483563; x=1761088363; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=NSjOr9zQXLXuj1V2iyQLH6yNnAJSVtXITKlKKnken42rgfOU2TcZenzjYOIek89amM
         6jvwo3gFn5RfqnCAiemRH/Mx1zUqgw/ZnhPZV+tqlySEAh12NlDzovmSu3crxMhOQVMI
         E7YKiwzRCTa3GESfhjqm380TKTsqBpXFbV3ThQ9Y70i2gRz2v7SPnIeN3XTwFz56lO3s
         lZSxFFPtlRy8AqblWVM+POOu9G1qSiD9P4Y3QFpnZwd7Csf/58Hx1qSH/L9zlZ8wTY1a
         xxr+bRDfyaZKEEefHOi6pjoGX2kvSelWczxtvzgGnxjx2SvLfcTx34ECGvM6ZZwEVBuC
         WI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483563; x=1761088363;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtLfPqM0qRyHopfnx8yEcwhphaJsW9uFXWQJka3Yibc=;
        b=iUjISmD90TWfSsHIff/wrNaUFKVW2z32FMGPlMR91BjNZ1RVrcV2XMoK7iqzx3kr7t
         yrp2GKYHwrY1Pv70r3RW5s+T7mrwIRsJqdcUMisxhWkk0LiXUtVjJBzHrfQTA9ra84Jx
         6l4EPCUgULs9ZNaKKE3VkEngOskElyuPZ/rMsi7t5Crq/qjxMenWxo5cmvwNxolWCOEG
         FjtE0u5xzisVlCwxzHRKC27SIOc10Yk8d7IE3fsreMV1qgXwezLHEkbEU64kvmZ+Ktrw
         Y0OlJ8poeaxtbTU3LWUUq4ddRrG2Jh4V4QrRlOM2Nl4sEclau6dsgykl4L1EDrNtVOCD
         lLfA==
X-Forwarded-Encrypted: i=1; AJvYcCUjFmJWTRpdEjKrFnGtHq5ucxZpEUU0yvwGFzLX1TSJboy7OvMajUO/z/+fV0MH4y3i5PFgB7B/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWh3tXPJYlKOQ9Z3hcT+OUDfxTnblRFoQvyLNq6NXw7MydTDNO
	iakAajuLTOdiNSRm63b4zl/WtkPL8AxrvzzAJ5XrJf40bBNu3+7HppI4Pb3ZLpnZXw==
X-Gm-Gg: ASbGncue6IWyXCs/v+eS1b1vsJW9WY4fHetl6TVk2csILQqf3u0gXEWKMg7H4gVW8Lw
	Z0LZ0D6VA9jjEYyblwykLTNlazQEg+JbshmlDF4kMtvjZOO1TUIN3LVttdAV9aIhnqpWbElz2QD
	OMJaRt9NIZg9zi0ilgGXKW8eAEB9E550gEl//BVmt6qdae1v85hZK5A0UuIMz3oP4wBY6QEYt7C
	dyftWzNw64uj+i+7zUvbW90mT/bEsnlrfqXj5DO7YpQ5AKvGtbvzVPIk7D3Sf088p7tsGy9r8E8
	ikKMji9fo8c76Y9L1xvM1dNfgqotw1qZIdOsSimHe5kBg/N2Tmu1U5qBlGcYGG47V0zFvxhC96b
	OC54iN+Nlp4mre4ZnNqCDjWODiG6yi1x6xvExP/H6TdSA4+s8GD5K03Nfo4SLWPAlnk32EQx7mz
	RXkMfgTIR/ZUVgcDy9ZPmuLA==
X-Google-Smtp-Source: AGHT+IElj7ocLs2TIw65fx5R2ooBgDA9bofkFHqCmgSA+UgdqEXOhfYPORVhESpLJNrEH6dTHeSXJw==
X-Received: by 2002:a05:6214:2b06:b0:7f8:21f8:6f7a with SMTP id 6a1803df08f44-87b3a7fb6aamr353893716d6.23.1760483562435;
        Tue, 14 Oct 2025 16:12:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a226fsm6968306d6.50.2025.10.14.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:40 -0400
Message-ID: <a32fb2be726969d5da7caf55a8f82e77@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 2/15] LSM: security_lsmblob_to_secctx module selection
References: <20250621171851.5869-3-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-3-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com
