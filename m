Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37C22FE05
	for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624298; cv=none; b=ojS2IrtGy5fc2FT6yJV/dcuRqOD7h8wXjjJSM852k7mSYzqE/dFjECxgP+LnV8EVICiBdZSnbYputEGCHdaayIQmDAUEf6n+LbmfZpgwlpnT1VZyZU2aAcV2FlOjoj66prQyhJKsagM5NFJnY3W9zj/6sZddHbEGlTSlcwfWC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624298; c=relaxed/simple;
	bh=EOzJGti6xtE/KS0s/r8JB1JyrUcLNSuZkkzVMvKg/uA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=ka+kle7i2B5QQ4w95zP7lKvz5hDt4ZP4XPCbpmUDuvl/XZGzZ86OTRckrQMOc0H4g1vbHXE9TxPOYBGwEFSkZXuUREBPzBQrM2WV86tSeM86O9U2kNjBF0lDTYpJBnr8lRX9mD1AwZXiGzcmwYVSDrrSVFP6iyZHbf987WE5TCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dN650yOg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dN650yOg"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474faf23fbeso55290671cf.2
        for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741624295; x=1742229095; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=dN650yOgLkW1MLoBZYEBHGx5/s6s5eakefzMlmnu962JPwhfd6GjTKiL3ftoSz9OKQ
         8NiGNIiFWFybSC6g5vwBTg/SY9oAOs67Kcg1/p9J61/h7jI5O2i9H+6YcMABjhvC9LHn
         /vuSKDlasEt0EZQ/FDL6PF10s3BppbQLDQ8i71ITG14j96Xq0sUXhh/TIiwewO0diVOc
         15m8Q81PTy52dr+kyV02zc4SBnCMtAGVhqv2K6WrbQW2s9/Gyfhap2RBtM9bGgdvUttC
         LqLFINudK8XhgLltE1LAJPLIEWnZQ4IK/AlNxn7X5vQ6HOiotplzZK4Kkhif6iB01KHH
         TDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624295; x=1742229095;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=MTjrsJVub+YKPNBIZ4e9eQUyuoQa/TIVbfUUBWk85c6oY6sQdVW4xIgW6H4UEhoBur
         dW8YN/N+ZdLrVaYIpUiMd4oen3d95R/ESXcGRFnMH2rLZITHK4/hNJvhampfR/71svHX
         qofcri5ge7B7CGe+VQAEDCqA9mt1PaiP5t/5C9dhy8zvUMgS7T6YemWFssSbMICBzi6o
         YmIQkYueON8xuzT+DahcyYfKoxoeYSe7yE8txxbOcv8IbTnlqwERi0Xz6KnVwZsZH15q
         LG/H5eAfC0PTZMpaAzJt9bgzinjzdSz/pOeaQqAtDNQhdiT4J+7un68ipeUAiQo3VvHh
         uowA==
X-Forwarded-Encrypted: i=1; AJvYcCUbGIASiUE27dXtbUYSG2ORoGnAUFjGnLysJ1oGQBD0Brsgw2iGxjVvEJbMthacFVD4WS/c4BpT@vger.kernel.org
X-Gm-Message-State: AOJu0YykwWlvzqhbjp467G6h8tItaXBB1C4pRv7SRg9oYOZ2c9L+ZQog
	+D2JquGUgSzf1Qa1p0ZGg3gawN58yHlidQOHam6qTW3OTlD18aeVs6e3MeAhVA==
X-Gm-Gg: ASbGncvPmtPGvBjWvd8rdPdRyU/nH9Wl1/sMNu4Dau1gTrtNSvWG/citaj9hWurXVrp
	8I0ARgiejr68wbFbliUowKVhegmr4WhOwiUjHLMoy+Ys3kWnBZyeXHCxszHauTCnq+pQoLp2sbn
	N+7TYw6b//iNovx6dUt7vZVQ5IPo+EFCZSkEFj9mjLYj0rhQI5PKtUZZU0pJ1svIeoSJhGq8rEM
	eHdBXTlTKB8f5WdVkJwVMI5TKVtqmtu/DY1NvMMT+AxCWZ2jgHEeCfUAjLpdHhWY4QtisceXzSU
	XiUDoXOQFpKypQxXPSYDSLT6Iuo7er4cjN208tscVpQJPr6hxvi+ZDVX+wF5Mo+UNT64gbb0QLb
	8n8/bPO1IGg8hxrxeVbB5M4Tf
X-Google-Smtp-Source: AGHT+IHlZT3bIAT3WS2IFI/YedPMfsOmKAgmF62kbG0sEZfn6Fzjq1oKL8J7czbvA3wYWZrIG85mUw==
X-Received: by 2002:a05:622a:ca:b0:475:486:2fa7 with SMTP id d75a77b69052e-476109bc959mr190733101cf.26.1741624295266;
        Mon, 10 Mar 2025 09:31:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4768cf1ec2dsm15915861cf.31.2025.03.10.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:31:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:31:34 -0400
Message-ID: <2101885775982b2b6310298ae96a3278@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] security: Propagate caller information in bpf hooks
References: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>

On Mar  7, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
> 
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
> 
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h                     |  6 +++---
>  include/linux/security.h                          | 12 ++++++------
>  kernel/bpf/syscall.c                              | 10 +++++-----
>  security/security.c                               | 15 +++++++++------
>  security/selinux/hooks.c                          |  6 +++---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
>  .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
>  .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
>  .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
>  .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
>  .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
>  .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-
>  12 files changed, 37 insertions(+), 33 deletions(-)

This still looks good to me (ACK already present), are the BPF folks
still on track to merge this into their tree?  It would be good to get
this into linux-next sooner rather than later if we want to send this
up to Linus during the next merge window.

--
paul-moore.com
