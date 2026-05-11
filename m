Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FA37F8A8
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530788; cv=pass; b=lkyy8zkjx9QiVXUHdsHOjQ787GA1DG9WOZxOkoEGRNlvYnPCrYS1xOSINN9ffIk6u5zLoZf67WveDEM7PXyeBtROQ/cDNPOsmneZC7MHACuMw0Xk0QgeorBfbf1WOQytLRP0W88r6UKO/tMu6vHRpG0cmpyd/HQeYHPX9hYxV5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530788; c=relaxed/simple;
	bh=K6ahRJJ0e5KDfR/InW9PQmfCdOV/MMnKBcw/HB3afOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkfMLKuxCefXSDONQSmRUdFtJax7egf+XxW15cAulxdBJ+p+YmZHIS46UjQBGsXUaiVoCO9HLxzjAWjRadZitinYTTEsSKkz40/ITQyHG26KFvVn9VkCe7r38EjKNhSDtlMwTk8qjJEmZWg/F6FmT8NSWMPWFkR/xAii5d9d5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZOasl4M0; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZOasl4M0"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c827313dac0so996568a12.1
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530787; cv=none;
        d=google.com; s=arc-20240605;
        b=jWK0kWKwISQONsVk7lhpES8X20tuYyO94QRoEGpO3xiMb4BpLW5WrNW7+lGVeh71Ap
         SvHLQDNGZXG9/CV9Iis0SpwxHZVn6mPaT1KMQR4jhoo2zurSTKYhxowD9XMl50GfCsPw
         TYrVwba8efB6FY8YfZ3vLLeX8kHu/2Mu0Bthl9lteDrbd8pGYF7Y7xE6IFjNNHhZLmWK
         sSfBfUEMaKZYnkYTsQv6M2cjNqbABC8+pdtsrrfE7T5jgLwgAADBhAnkHwm2ZXhvB78L
         JWcw9tTIXy/uGPPdz9RMvBgx1P6xoBCMcw3qLds8n+lnR535pNGyqsf1RF2/PwFMMDtw
         wUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        fh=df/Uh+ebPx5n2NbZ/2joCAfmd3k+9e7gEvhKT1HfVLw=;
        b=ONEK9YYp4sNMNpLxaiY0cVJdB77xNmXKdU1MYm7U4G+LLLVQyPUNcUCpJ1DrDU80zS
         8wL/MJfuGfBb/4hIPjoWrp4g4gVRS1SC7Qy0yF6xxlyoS5H6FjxQpkEohb26B7hMDXjB
         u5Qj6jzKO9yNhfReoA2Vk5jXqPEFwzKgnHlj9vX71juQRviXwXe6tvaU5TyUYE17vg1D
         LeGEUGbteEO9B9qFBAdCEmx0v9fQn3aaN8ovqo8yTQ59qAPrxPOwS/ffBEhmwFfNaifV
         mL2wG30bp3M0bhmPnlq40JkviSAwtCugrX1Gt87F+xkhFyg9YySIXx5i1sC/rqregGY4
         CY2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778530787; x=1779135587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=ZOasl4M02vdGq0CtzjM+mJSdzkG+WbWS2zDRXeT3zlmdySNNaKpsmRKaj/NozMmeeA
         4FBuv5gCY/kAmyaFd19D6aKtGP1akbARVnR3WlhARcP+pM+vtL0vvCRp5Z8/hbhuxB8Y
         G25Ai9ebx5/Uy9l2NuYRFOfPdTHbkJWrI3UVd0a6SROG+u1qQ6YchySwuAjbQ+7knXFd
         7wK44M85G5C1WR9QFG5q67FP4m9IbeW/mFVm+deCjCzVbIihKkm6VztMdE3nepc82M43
         S63Y911yCQ8vTV+FZpZ0ZL8BXXU8x+sHK/XrLzZHerG+If8gkHtfX4r0oEAmSymTw77x
         SLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530787; x=1779135587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=izF4Zi78FJ0KZLVYJqRxfxTHMvJ/m/ZNxjv0FixjEdxcUGBpNg4IRd9CiWDU1avqot
         1vM1ObnJoOj5BKUg98jiZ7G71vSKIOGJLDmMvEtAZsgQ7hSz11MlzbY0sizkkbIKKgau
         VcNT3Xpvftn8Rrbf6UJpO/FcE+FCM2nI6mKH+yU+bgdUn7l5lC02UBtQUNv9+VSgOIYd
         H23ftuIVAigJhqRyfB18G7fF2gNCxCXK2Tad1UkbzOj0P2DMqrVrc+D5Opl3oc5oq5Iz
         1s13LQfH1c4Un8bGmhblFyhzI9wFBkhYnTwIXdJFE9ng3qsybsze72LYtWXAW5XOcWvx
         N8/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+BkJleLw9gxC7A/+gg4QaBxQD4AZUDXYbXl8/03JLJqnSQwu12fwmLhmsyU9nayD4LEq1Dk5wl@vger.kernel.org
X-Gm-Message-State: AOJu0YxMj5x6ng/XeLzw6W9Q0VXv6vV4n+Z4bcIHNUUIiXQOqG3RRTP0
	YajnKFua2fw5OKV45ZKkVOweYqYw8lZb216CUOTUaXiVA6THHz/D9wdKKyE2fzmbEDqwgRkVsMV
	eTcSIitDQaDDuNrpHzwXnl4SDoWNmfHOAuhtYkIjE
X-Gm-Gg: Acq92OGTcxyHkppq2ECoOmQ2LuyfNUrP80zZi6s3TuSMJS8sWMkMIv7c5UNUmERGS06
	l7X368OdTwZ+Ol4ZSa6UIkl+e8VldJgjl46n8+3GYmdHpXhv/yjX7GmCqPVvpDqXfALvgHSsIyz
	H+OCmc3vGIMF/XVS+rsjdfbX5YverCwZ5oQqSwMQMtaNTx14TIb2QhDdU7vH5kD5P+1RkoUoOzj
	AR/lHhRdu6/b8gINlsk0GP6HS8u3lRsmXhp6jaudYGpiIAd8zT/9q85rx8TnZ5YMnGq4k13+14i
	PCdoK/A=
X-Received: by 2002:a17:902:d294:b0:2b2:ec33:cf15 with SMTP id
 d9443c01a7336-2bcfcc3cdd5mr5383065ad.7.1778530786540; Mon, 11 May 2026
 13:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org>
In-Reply-To: <agDuCdGIeM-6z-j-@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:19:34 -0400
X-Gm-Features: AVHnY4I9tIhrxU9BB89LwwsmZTDJPrnnYPaBxKCsIK682ecgTABjXJE_lLrFyyA
Message-ID: <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> Hi,
>
> We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> (without bpf lsm scripts loaded). (This also happens with a boot with
> "security=3Dselinux" if selinux was not in LSM=3D list but bpf is.)
>
> systemd reports on the failing boot attempt:
>
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/shm: Invalid argument
>   Mounting tmpfs to /dev/shm of type tmpfs with options mode=3D01777.
>   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "=
mode=3D01777")...
>   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_S=
TRICTATIME "mode=3D01777"): No such file or directory
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/pts: Invalid argument
>   Mounting devpts to /dev/pts of type devpts with options mode=3D0620,gid=
=3D5.
>   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=3D0620,=
gid=3D5")...
>   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "=
mode=3D0620,gid=3D5"): No such file or directory
>   No filesystem is currently mounted on /sys/fs/cgroup.
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/cgroup: Invalid argument
>   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdeleg=
ate,memory_recursiveprot.
>   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOE=
XEC "nsdelegate,memory_recursiveprot")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/pstore: Invalid argument
>   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
>   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXE=
C "")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/bpf: Invalid argument
>   Mounting bpf to /sys/fs/bpf of type bpf with options mode=3D0700.
>   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=
=3D0700")...
>   [!!!!!!] Failed to mount API filesystems.
>   Freezing execution
>
> 'Invalid arguments' seems from setfscreatecon_raw.
>
> Reproducer:
>
>   Boot with lsm=3Dlockdown,capability,landlock,yama,safesetid,bpf,selinux=
,ima,evm
>
>   (none):~# cat /proc/thread-self/attr/current
>   cat: /proc/thread-self/attr/current: Invalid argument
>   (none):~# echo > /proc/thread-self/attr/fscreate
>   bash: echo: write error: Invalid argument
>
> This appears to be caused by security_getprocattr / security_setprocattr
> iterating until the first hook defined (which is bpf) and returning with
> default value -EINVAL before selinux even sees them.

Thanks for the problem report, the general recommendation is to place
the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
help text), but we're trying to ensure that the BPF LSM works properly
when placed anywhere in that list.

My apologies if you're abilities are well beyond this, but if you are
familiar with patching and building your own kernel, have you tried
changing the LSM_RET_DEFAULT value for those functions to zero/0?
Assuming userspace is happy with that, I believe it may solve this
problem.

--=20
paul-moore.com
