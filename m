Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5F84DF1
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225019; cv=none; b=Ef1Km8WM33GgRN21lDL2HYxbJg71EjLKNvKTfXj0sRH3KWksCcxv0Yit1U9kFwE4VRsLVqHwIlZU4bn1j++uQ1Jbak7El3dqhYXZKKmXSaJQ2mOyNtHjYKLJ5UOrBULJPrhGr1YkXIkiT8sRCcUgcbP7QxtwmZgVOKW3fLoQT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225019; c=relaxed/simple;
	bh=B9KSqPus/lN5nEt+igYrD6e9g6zPRaj9n3Fcm7H+6K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmFxvMek2Q7XVemrdCrrYRN77/k6hY59OhdstnsGyjv+mcePS8XZZVB/DEgbGIr2AL824mVKC/yGBvWWRxpQrnNGtQbTvCH8ox6GI/wr7C5LQJPtGx13z0tk+f5AVdD3a8tY85ycmaNakofhhlS0Nt2kIiQnbzPlcbnCeqz5G5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnBXTsOY; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnBXTsOY"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48d7a81a594so118292137.2
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718225017; x=1718829817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1VAJjaoV7rTHaydpHKnm6CKBZaffIZiQhGFgaicqLo=;
        b=bnBXTsOYOQuAGiClKSPckKZNRryWAv82Zsbucq94BqPMHFBGNhD871OvsaJ49o4M2P
         tStm9J5rBguDoRt6d6lRPl0OnV+M0yt27Ac0lXnQ4Xfcd0EcErMMGbQYNZejUactP8sp
         2GvN5I/ERQYyDZKC0uDdce/4OqLTdoRQSjRHiImlfA8ACcaVhNkgUB2+KFZqJpmJ4lUp
         xf1P2IFwd+K+FeZjWpy3qu/VCpuS54CEvrgEQ+BXH0adt4uEF4UuklnM25bLA/v9YZvB
         kqc3yajhCE9Slza5u5BTYRlLmIyVJkeuOafem6xq7S6yiFspGatnBVkVrgAh8wf4xxH8
         fDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225017; x=1718829817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1VAJjaoV7rTHaydpHKnm6CKBZaffIZiQhGFgaicqLo=;
        b=PZjDrw+K5PZu4ClRbbKtSe7KTT/iBrvfH+gvKW7Q4QdNDn1N4B61Wc/Q6BCXnr68mQ
         /Q/nwo9qyrTeT21mQuqFAHa4Ad25brLgtXa36PPsbl6DWigkRRy2iFFKxJPwwJsCEa8O
         HdvKlzDaMdtxie/+FIvOR9nIn2MrjcbVcg5euHQ5HC9aHUc+T7l8hD9JK8vb8Upu+ZZw
         El8gWR3eZERRQ8qMRGGMk4zHKwoOZcxuRLhEu4pkSTzUZiQzyBwm+fC4PiJqBkr0WnXm
         G90WQk+w6HvHq/PSHGHdds4oXQdhPAephUsFNbfkWSkPjW3uzTlo3+8wIKxjW3QZ3ko0
         HzZw==
X-Gm-Message-State: AOJu0Yw4SnBIQN6Xwmb4q0fCKOtADPO1IFAmF2iMmBNNipfYTmCuriSO
	8h2sbtsVZGnSqDWNGHtR2LH/Sw7RQbw5TnQA3EKbgBHmUwKPNkTHNK/vmB1lkrWNMbwtsX0lmFw
	GKLbDKHxIYNQdXT323QXerjO7HsI=
X-Google-Smtp-Source: AGHT+IHX7XymBAZ7/lo8HvdlIoVt5N/CW4WV100Rj+TjE3Od1LGbqe5bkyvHY5pgEPVKdO2qJXTFFfRJ95aydttlr6g=
X-Received: by 2002:a67:f715:0:b0:48c:377b:11d with SMTP id
 ada2fe7eead31-48d91e41468mr3845654137.22.1718225017214; Wed, 12 Jun 2024
 13:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172025.137795-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172025.137795-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 16:43:26 -0400
Message-ID: <CAP+JOzT35Q70n5zXycWt29VAnm_e4YvMcpscdfWwWYmW5Ur-mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: deprecate security_disable(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The runtime disable functionality has been removed in Linux 6.4.  Thus
> security_disable(3) will no longer work on these kernels.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/include/selinux/selinux.h   | 6 +++++-
>  libselinux/man/man3/security_disable.3 | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index 61c1422b..1318a66a 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
>  /* Get the checkreqprot value */
>  extern int security_get_checkreqprot(void);
>
> -/* Disable SELinux at runtime (must be done prior to initial policy load=
). */
> +/* Disable SELinux at runtime (must be done prior to initial policy load=
).
> +   Unsupported since Linux 6.4. */
> +#ifdef __GNUC__
> +__attribute__ ((deprecated))
> +#endif
>  extern int security_disable(void);
>

This causes the userspace build to fail.

load_policy.c:329:17: error: =E2=80=98security_disable=E2=80=99 is deprecat=
ed
[-Werror=3Ddeprecated-declarations]
  329 |                 rc =3D security_disable();
      |                 ^~
In file included from selinux_internal.h:4,
                 from load_policy.c:13:

Maybe we should just print a warning message for now until we can
remove the internal usage.

Thanks,
Jim

>  /* Get the policy version number. */
> diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3=
/security_disable.3
> index 072923ce..5ad8b778 100644
> --- a/libselinux/man/man3/security_disable.3
> +++ b/libselinux/man/man3/security_disable.3
> @@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selinuxfs=
 from
>  and then unmounts
>  .IR /sys/fs/selinux .
>  .sp
> -This function can only be called at runtime and prior to the initial pol=
icy
> +This function is only supported on Linux 6.3 and earlier, and can only b=
e
> +called at runtime and prior to the initial policy
>  load. After the initial policy load, the SELinux kernel code cannot be d=
isabled,
>  but only placed in "permissive" mode by using
>  .BR security_setenforce(3).
> --
> 2.45.1
>
>
