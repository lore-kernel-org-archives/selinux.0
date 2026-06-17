Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857E3B19BB
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726469; cv=pass; b=bx4qNtY0m9JKS0Nj6Jt57MXWlPw4wjs2zSKEjyMcDhHWNqFUsFvF8xjkwGH4FIr3eYazZMxJEPjIuYG2Zgf+4JJ09It+RjiqjNKqX9fqRdSJw2fbpFs6wJ/DeoPaGQKgC+svoeYAutiajJo2+Df891Wcoz/z4ERhWdncJcJYt0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726469; c=relaxed/simple;
	bh=Ch8XnjRuHAoH7GmTPK50C/ntfjQNc53FdA5JqESqang=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqwe8TUNvsoqlt/q9mIZU342+MOQc5+pApgqiy4pgky+xSPbRVUUqWiOc2uusCkyi/DkcXbc/qyDZZcQ4JvaRGm3LYc7QO8BwoWxabheUsdJBxf2pvUhFeRE6TbYrEBnLyQl4wWlOsGBH8/ZjgO+OS+ekpQnsjRQYQ6rnO+m/tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjz2toF+; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjz2toF+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6c9e02e7dso1172575ad.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726463; cv=none;
        d=google.com; s=arc-20240605;
        b=exsWDzqD43BAorg3MtXZryHrbAJwi9tO9g32SrOGAglzsmggjgZdbLbwlYKh90djr0
         +yEHVurMPxQHb2iLQCWVqujxgU0S9qERXvdiLuQwuTSx+hNGN4rKjB5H6s3Sn4x69Mn/
         nAQcivob0esKRNHWwRm5Jljt0vo14bC3C/kBbwl4222DCSX871tqD2bDPpvtyWcCE//h
         He0jjMK0RV6FXb8C5B6C7ROfnyqJik/yERnj9FPkuuncfXPQybzlj5iocyWlPvnkExac
         9iWYlLVIj87paXzMTMcTI5lnmmeICS+0PoFuSsOTGZ8EsFPQTnaLarxyDJ84PEuTekAI
         fR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWhldh7o5fV14+UIEGzaR/dtcKCV9BLxpyQxbyM0+ZI=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=XDH8W/5xhDW+LGGSm78LpnpzzBpcbEVmQk1wvVH1/ljm/f9MopNKFRX82K8ayg2LNo
         qvA6JA/nmrp5zPLluZAQp9EQbIzO9SojnGzAuf3HYeBMF8eaQy/9iX6E+xFHN7KIcmCF
         ZJY3YD7q4LWrGWU/E98uvwRUTiQ3HTUV3VbTb9Mjgpxlqc1W8aNlVA/uObAnWIcVVSt/
         uLKx/0jxdCJ7A7zxJcShF8s0X8dReZt5Q9awoDTyqLvQzOk/jPr+TZYGj8tXah3mTZmB
         lM5oQZU03n+KhXNmw6uq1RqHRCvZCZvFZulBnM/Rqk0oFP8wbLozNrbTM+fBbLLyaw6N
         30yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726463; x=1782331263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWhldh7o5fV14+UIEGzaR/dtcKCV9BLxpyQxbyM0+ZI=;
        b=Jjz2toF+tX3Zwgz08XCqH4VMfag8TEut/JKEAn0L8USYYp/unn3ZmwYMrbesPdWW1r
         f9YDshEoPHTEC314WD1pVZHpJFd4hMvoe54EDHLzZDkeM4fvdc0oJ7ABETrpacPmmsqC
         PTvJLuEcllRwtL/DivwfbDdB0uh52hjaTC2S/hrCuDzz3WEUZtgIDLZwqmf92ZhGQQuw
         8GFm+Lqpajkx45fn1fkQllKAq9n6mzUFzgYO+CWvxryR0/1z4fS7ahf9f/p1lUsdF4t5
         F8cW1rGrclATI8JGsyM8iXITkdOrUd2QCtiWUWjWfP9X0SGGYZIqXl+U6KROk+ACZ4yW
         viiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726463; x=1782331263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWhldh7o5fV14+UIEGzaR/dtcKCV9BLxpyQxbyM0+ZI=;
        b=Dws0e7t9q3Dg7YVEJPWFZi9H/4HwBAElKLTGg+83MLUvoAHxqWgQAcsfH1XvjigVVf
         gYz3uGCfoSi9ThsERlNRg9cTId5dV+Lj3LwuHISwOegSCLVRFnKkJe9be/GKV3o9mP8l
         UADTwD+AF+Q6NSQsfNYj0odapktDOrr0iTGmo2EtrIL03B0GLSjHvjGVY3AIKdWuEYKC
         8hncFrd9ELJh1Z7karIRimeQBhBJOjkAqanN64z2S8YGiH3/tuIHZ5H9pRVh/4g+i3Bt
         2Jy0n07uO7emQ04OgcsocDkI8R+RrlwP3H8Peo3mFSpQzkU5FCa9b1WbxoMxJQhbUpIK
         TUWw==
X-Gm-Message-State: AOJu0YxO2zgsIN2ng19eS569+qcMDor9on9TpDZhjC4tNad18Y+pLYjz
	JZhsUYNHDNTGMNhmDJHR1GrOJnNhpABUJS6NuAErTPyOL/L3AnLZrt9p411JduNPf+/g6EvSz2x
	cqwSgxQrQtrr9ONlSRtjA8uC5w+7LGaA=
X-Gm-Gg: AfdE7clpPPiPiJaDMdm3EMQclWlAziYCm1thqkpn3vZe4H9xnfeuNglssSGjxYcq+I+
	hp79rutpNh0BZMAf9ijFHSDfjrt3TmmpfPi6Vw4jOMUdy+n5np2lSMc1IdKPA/9xT2MIuyfMoeE
	lDkMjfC72AnOrPWbqqGZ3QitsRlGz8AadyeCSTLeKpD4AGAX/FOV5c1M2/r/TBYu6aipx9DpA8t
	jAC26cpvDLgprVnGu+IHDEPF1nLGE/tIYrXnuWJNTypdm0OEZZu2LF2yyH5ZkU1Yu9tVYmRdqew
	n39Tjs8=
X-Received: by 2002:a17:902:e5cd:b0:2c6:e1f7:b4ce with SMTP id
 d9443c01a7336-2c6e5277676mr5170535ad.28.1781726460953; Wed, 17 Jun 2026
 13:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617185543.91749-1-jwcart2@gmail.com> <20260617185543.91749-4-jwcart2@gmail.com>
In-Reply-To: <20260617185543.91749-4-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 16:00:49 -0400
X-Gm-Features: AVVi8CcoKz3BBhLBaEy_aUVN7EI4fprBieezxFBRSBlyBL09BKFqQeSQCqgheuw
Message-ID: <CAEjxPJ70nZSWVjydSNGXNMybk2=2SO+DbkGGakxYGJKJ4dbqsw@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol: Add checks when growing lists to prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:00=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> A common idiom to grow a list or buffer is to use "len *=3D 2", but
> it is possible for the multiplication to wrap on overflow. This
> would result in the new len being smaller than the old len and
> could lead to problems.
>
> Add checks to prevent doing the multiplication if it would wrap.
> The multiplication can always be done if len <=3D MAX / 2 and
> should not be done if len > MAX / 2.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/kernel_to_common.c | 16 ++++++++++++++++
>  libsepol/src/module_to_cil.c    | 12 ++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..9ffd452b 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -22,6 +22,8 @@
>  #include "private.h"
>  #include "kernel_to_common.h"
>
> +#define MAX_NUM_STRS 1UL << 24

Should parenthesize the expression (1UL << 24) so that if anyone ever does:
MAX_NUM_STRS - 1
it won't break.

> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 00db3d7f..ae7d700e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -447,13 +447,16 @@ static int stack_push(struct stack *stack, void *pt=
r)
>         void *new_stack;
>
>         if (stack->pos + 1 =3D=3D stack->size) {
> -               new_stack =3D reallocarray(stack->stack, stack->size * 2,
> +               if (stack->size > INT_MAX / 2) {
> +                       goto exit;
> +               }
> +               stack->size *=3D 2;
> +               new_stack =3D reallocarray(stack->stack, stack->size,
>                                          sizeof(*stack->stack));
>                 if (new_stack =3D=3D NULL) {
>                         goto exit;
>                 }
>                 stack->stack =3D new_stack;
> -               stack->size *=3D 2;

Old code kept stack->size in sync with stack->stack; new code
introduces a case where you could goto exit
with stack->size double what stack->stack permits so subsequent
stack_push() could write OOB. Not a problem at the moment I think but
probably worth fixing.
