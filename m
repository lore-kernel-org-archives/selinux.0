Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1522094
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354889; cv=none; b=tisrJyAZcnl6Apl7V1uip/UzR3NtGwKk/o1JvLoL3NL7oiBtiTNpMp1uAPTgE6jG/TZl+InP9AqnJKsjTkvgnBso+JDcnGjSPYk6DuXM/PkixozaV/H7Ln6+FGgnpwWvyj/lx2HWT3Wuzz8CkuwW/ICUqdZAF38WI4hQkqvIBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354889; c=relaxed/simple;
	bh=3kQS2cZBJ39f+nV1qKNmNoKNDB7FDTY1mI5qcsc0L6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KN/giISuiqqNRYx+rRm6jYKhjCgll4OYReuFKeT0cwSpYwNTN3wx0o+vGOQ4V3A/mE2tsVPr1elw2wf6vMc/taDtYTvF/hHRtNYAvGn3m+p9PgJ0ucaRJ/d/vdd4ZajhLjNqDcbVAB9xdiZ1M7ypwybuWAoSt0QpKZ5ZgFj40/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sglmx1f3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sglmx1f3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f128b199so7914336d6.0
        for <selinux@vger.kernel.org>; Thu, 18 Jul 2024 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354885; x=1721959685; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=Sglmx1f3HxwYDuZhNdqszpf7ee9npoLHouQusVyxJTkA612qitV26LgWBlT7XaBiKp
         5G8FhtA4Ko05Q6Ly4/q/voIWCCgMcit6EpD5v8roA6MDiD+8THrG4sPgqFb1aJ/oW+uf
         kOG5YWA4XecbZJeGTyp9/RnudcenATcktfFG5SShxjgGUVAPoK3ESO95raBdZaTmaCHc
         0NqgoNZjuruSZ+gGuEb7aO83g6Zh0YUfs58/SisBYf5zS4WB3Ffm2HiCVMZtQZs/MLca
         9u6BNow7pAxIGdsDaT6Dhs9/v2z9TH/HCsghNHsEZ8eueX4UAxDQ/55u/7Z6ODOC7dBa
         p9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354885; x=1721959685;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=HH/vijxRdk/1nD4jhl2nkpeZtYRmV2gVcvyEhyC0YL4gH4dHNWsyxnhB+yjvlMfewR
         kqPn0Zard2aBDn78Uu5a9rtN5AcRWebgZP4CrFSuRXcpwXyPklS3FOtGmKFq/vGWIWTX
         4P9GYMZGbo4M5PX13CzGeUyoxTzEB6vS7XTGvEmoF5Gz3W3w+At/NTOnGARPYNbppgND
         ZTMZRLNPq1Mx0WNTMfJRlFyiESc53qeVnB2KXP9wJu99MwyfKAuEPmZaYd3ioGhoOwBX
         zJpVZW+Ee9HGVGKf+EW3gCdxwlWUU0Pe0HYtsSZguVM2FCaCZ+FhQXOWxJ9D2dqcBfHE
         fzVg==
X-Forwarded-Encrypted: i=1; AJvYcCVx+x9uswcJ8F/JL0Cfnfeqa0pjdbh0wyXxJas72tS9gBWTw1Q7cQJbHVs0kYb1pTX2lKzGjb3gvDehUi6yTQR4VDOxzRCVuA==
X-Gm-Message-State: AOJu0Yxsg5TCf6Deb4QjDuhJX8cCkarBO0g9ONzxaJSXcJ5CA+MhHXTv
	JI8er3X+y8JXTas4vNafC/GvHc1XKmh0Fcpf46zLUxkhzlJyKFpBYfAUUfqR5WobltT7+HHqj8t
	pXw==
X-Google-Smtp-Source: AGHT+IF74+EqudtKUL7i1ZCCvXjz+qd3zopM19m0jWGVbddz7RHlAWv2UgDf87dhf8FKY+88djubgQ==
X-Received: by 2002:a05:6214:2301:b0:6b5:3c06:a58b with SMTP id 6a1803df08f44-6b78e364c4fmr77396666d6.59.1721354885611;
        Thu, 18 Jul 2024 19:08:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7dfc97sm1785356d6.46.2024.07.18.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:04 -0400
Message-ID: <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 6/20] lsm: Refactor return value of LSM hook getselfattr
References: <20240711111908.3817636-7-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-7-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getselfattr to 0 or a negative error code.
> 
> Before:
> - Hook getselfattr returns number of attributes found on success
>   or a negative error code on failure.
> 
> After:
> - Hook getselfattr returns 0 on success or a negative error code
>   on failure. An output parameter @nattr is introduced to hold
>   the number of attributes found on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  5 +++--
>  security/lsm_syscalls.c       |  6 +++++-
>  security/security.c           | 18 +++++++++++-------
>  security/selinux/hooks.c      | 13 +++++++++----
>  security/smack/smack_lsm.c    | 13 +++++++++----
>  7 files changed, 41 insertions(+), 21 deletions(-)

The getselfattr hook is different from the majority of the other LSM
hooks as getselfattr is used as part of lsm_get_self_attr(2) syscall and
not by other subsystems within the kernel.  Let's leave it as-is for now
as it is sufficiently special case that a deviation is okay.

--
paul-moore.com
