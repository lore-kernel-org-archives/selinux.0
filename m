Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFF1C6FE1
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935932; cv=none; b=pnefN+SIlaQHTgLVJO5z2iu/t0cM73jlLiOc42JavujAE1bE9NkPhGaJj3lcEOwfTuC9R9bfAvGdxPHF1DYraBSyTk9mXLlEGaGnY+d3Lx+UJImzCzPIY+qXBFPnBGB/3/8Va4AHi+lgXXy3QZK8OLS62stSGS0bBHY900RUfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935932; c=relaxed/simple;
	bh=wR7vuNmavpgQ9KSVIUXDIW6qbtN1VhVjhEqCH2+XRQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhNYNuKiBnmwluTxO5IbZG0m3dsheUK9mC1fqrVCNc4DapQhUcIhgGSepqXTCKDAzER1FWYUD+JCSeBEpgQhKkz/4d2xbTkyrlWXzCk4ppMU0bfi69O5f5UTHby2HyyJPYTkMSOIHhg6pBIBeD78Pc+MpufHYXX17XhJNtB7x/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CHqeqbXy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CHqeqbXy"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so7101257b3a.0
        for <selinux@vger.kernel.org>; Wed, 08 Oct 2025 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759935930; x=1760540730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo+vXcvToPF+nlBqsQTd/xRPbKZF00V1HN3VvGDKMCw=;
        b=CHqeqbXyD9HkFUrqD7E/tdrZ/FMTyFOwcqZn2u51As+0v8nk1d+Wk7nYWPZwPKiVRQ
         9cGTCOrW0XL8oXNQKQt6pTIyDck+0fdpUGtBRiJktDolE57/Yww6L3RPg9Yd9AMICOW8
         xzmk7GrJcAfpAanFCIKjQl2pw1F4Pxeljnktq+9qxqarGGBDJm4ldqhL4C3bl+TIJqBT
         dj3ihe06OC2prICEPo4fCX4xYZ3ESuqyfBGIpH8JqgWqta5J9Hhs565mDumuR+Xkj0Ju
         hAAUjRakQHZNYmZUlLiAFMXyRCCnBSoXVGFAGI/OdHDFa0OXA6nLhh3kHL1GPYY42Kdy
         EHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935930; x=1760540730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo+vXcvToPF+nlBqsQTd/xRPbKZF00V1HN3VvGDKMCw=;
        b=I1LPslNfBXil+Y8XFW30o38h3mAPTECrrnyQLmOU0YRF7TFs2IzFYvUwFfiSmT9AT1
         8iTyh0NJ5AJ5rK5DLghYPPP1x1dzew3QA8gPx7j6UH5yiuZR4YZpr1VtW62CpYsB0u2k
         mf9muEzEpuUIgf/YIy1ApRNfWaCh3Mk6Vx3YlkAPp5CSJ5koh48g+B9031E3VH+OVsI1
         dSilLlNMaU09X021xYs8Ho8Szsh5zfXMeJ8nr8VWCeot6OwumijlY3t+mnXcisjSbRmP
         dOFKD9VOW60qCXW/myZYTLqqryTImYyoc/YVbQq8zWgUzFHU0fevRETEf1Tqud7IpLnW
         1mLw==
X-Gm-Message-State: AOJu0YwdK3IHr71G6IeQZfB0WgPnEGLYlBiaR0FLyVT6LmIl1xG/b/yJ
	Cbqr4UnymncE2vWs08yEJdPC+FyHNmSjS3OUbxbV4THwDKvjwUdxO1qVSC8gbEecm2+Q6nnb1/z
	/J08k4Nf1f+2O55Lm4YTWKrLbpDQ+8XI7SNCiZL3g5NqrlYwGpto=
X-Gm-Gg: ASbGncv/5A2hAGuKRUruqaH9JPE3iJR/Ts7KWhivlZpfWxgeXBGfhPbSTI5lhSjUtcT
	uKk1d8ThZtvfDDST3WfM4zAe325vTAIH8/Ck5pd4GjysBzdUutyZWD2mombmDcfRFjqjonalLfH
	JImlUGeG9BezjX4uMWnqcR/4sGpmIt0hjOpIIbwvNeMC1Q/vGgjAxnQtv3l5jxBLPVnqsCkeVMC
	slQaYHpYGCPt+cti6GQDlrHFadY52w=
X-Google-Smtp-Source: AGHT+IHQTfIb1UegkA8lvqvFg4GXwTEmg70Jvprg4Lmb7zu0LpCqTzxIUjuo/Bgeh4PnxyN373Wwrem7tLXogxfkVHk=
X-Received: by 2002:a05:6a21:3386:b0:251:43f5:cad4 with SMTP id
 adf61e73a8af0-32da80bb8f5mr4856139637.10.1759935929655; Wed, 08 Oct 2025
 08:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008143612.96917-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20251008143612.96917-3-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Oct 2025 11:05:17 -0400
X-Gm-Features: AS18NWDgMmUL5GEP2DjYr2ryQH2xPbSZs7RoHtrz7rfRkVMFgtKhbzIelYsc0vM
Message-ID: <CAHC9VhR-zOypjb0r7A_s3NXT0w1usWRtY0N-kPPAcVnkWGb1Yg@mail.gmail.com>
Subject: Re: [PATCH v4] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Richard Haines <richard_c_haines@btinternet.com>
>
> This allows btrfs filesystems to be created to support the
> filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> type calls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4 drops the mkfs size for btrfs to 128M since it doesn't require
> 300M, unlike xfs.
>
> v3 was just a re-base of Richard Haines' earlier patch which
> ended at v2.
>
>  README.md                      | 2 ++
>  defconfig                      | 5 +++++
>  tests/Makefile                 | 2 +-
>  tests/filesystem/Filesystem.pm | 3 +++
>  tests/filesystem/btrfs         | 1 +
>  tests/filesystem/test          | 6 ++++++
>  tests/fs_filesystem/btrfs      | 1 +
>  tests/fs_filesystem/test       | 6 ++++++
>  8 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 120000 tests/filesystem/btrfs
>  create mode 120000 tests/fs_filesystem/btrfs

I'd probably still give it a few days to let Ondrej comment/merge if
he is available, but otherwise it looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
