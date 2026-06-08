Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C1318EC4
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929460; cv=pass; b=rUyZ98KQ7vXVS6ETitmv0LYELmpnR7arBJN0jxEHcB4Gr6dLO29DS688wvXmflDSIBBoa2+XAo1RkAL+VbRMFIHr8w73EXayZxT1Gbocz34/8Ee6Hot0Td6bcfUofSaZiPQDWmb2RnXM2tNKQxYR/eUv3bLvlFXW87k08ACoV40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929460; c=relaxed/simple;
	bh=GIKqdI0FMvalu7Uctp9JDYqU5PoWSXUAB5U2oZpBv00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSE8yccpjePB/45vTmld+sdG0RWvdi2AVm9gWJbv2L9r+IxkGbGUdXTqmm3VO5Q0LlKvSkngZ75s8KreJFjiFgc6ULCiVqqDB8G5glpOdNfU0xNC5OcGto0pAFac6WqOkISPs+RTXYKH0wrf4x/OjfeMfHyoRn/BUdG50k4I3oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSVf68ky; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSVf68ky"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39677c434efso45254101fa.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 07:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780929457; cv=none;
        d=google.com; s=arc-20240605;
        b=X7ngwf3oIeNqDYx/K0a02Z1Lqypelpl0LzhG8MpKvzvZa1DL0KaFZmLLLxUtimjA9p
         UvU5V0zo+gAzQHy8R2NwcoiVm965bfEMBb+Rkolx/+gK6IhfdG0X3/hAvDThb5rtFmgw
         JsUMyBtUflNyh4Y3hTBrxURTxdmA8Aon8bkghBHKRQcPYts0y1CdiAyI1U7PA9eyEucW
         ItXQrQahimzqse4ebCv17+SeJA5fhsxg0HuHERzO7BFHUwIgbLP+n/kUlaEPFk0VgAzZ
         DiKkvpnauTNXUFYW3rHjXRQwRgxnn6zW9Ms9Kua38nijkdbKcL8HYkOg6PgEeJVENhAE
         cG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/l2lyo9kwhjLjX6abvBWiYK0E9rcwaP5HzzurN9fPT4=;
        fh=5kbkVu0PnMnKeJCkRXlAIJI+3UQPP+nh7Djzg4UZkNc=;
        b=aKR9PVm9T9tDCa6J5oQ418QDkeSDiFp+wsOoF1/sIQboJBdLBo+E2qZmXHlsy828pU
         aHcncn7MU5WyGlm4YwgGiwzZc2CoLPEpQDhN/YSzDRpH9TOhIoddRCwvpRneNKDX3S1m
         j1nsma6NbXYOSngAmo+QVLBsHVBsesG2Z71wItWGUGVZbXVMEtJJYSjwj0eICpcNIuYS
         poYLuQfE/IAFK8Qd213D1fYRsPHeaIXTQfmOrAzOU3NJ1WNQbOUoq0B5Y/cJw7oW3rIY
         fXtYz+/oOM1N/dby+on2JWYAxMqqf5K7jRmOkK+FiqS/MvPqoR3Oo4QeIWsD1YqWdPtd
         T3FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780929457; x=1781534257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l2lyo9kwhjLjX6abvBWiYK0E9rcwaP5HzzurN9fPT4=;
        b=hSVf68kyURiv1rHrAmHADqLCbdLU2gNVLjGqoWRdpfsfOyuiHV38crZkIjO1FTqX6M
         +fpykwv3bCfYc6Km+83ycaeMJxu9Lg75PEmLSyTMSPQZQU2qUJF6dU1ypJ2mMsxjkVna
         fFVXNGudpmkD1gABKCtTJbwEOIOhzVVWvqCJgrrvhDJ1ag4ynGiB09FRYPq5LLVigOwD
         DjvfTAgGDveWY4YP/4iWVKZwUmm1tG3aQLhqex5ynbrDMSvsM3zsXWh27QW0poBdEb8w
         hAGcYt5KvroxpIhbP8HgxQAms7uzmmdZOjoIyHGbUIcwpr+7u/Gpu5EhbdkXdiSip0k1
         287A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929457; x=1781534257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/l2lyo9kwhjLjX6abvBWiYK0E9rcwaP5HzzurN9fPT4=;
        b=bxMZH/4K8x/ctIbbwyC4MVCoAzdc7wWVtWLisqHo3xZdjzNdk/aCZG4yxYmYm4iFJV
         DIFRVZKjiTHpqC60KrAg8u7NnVp1Cu76hwlYwlYqBFQrn8Gz2x32x0JXBfuQCmq+c56A
         I/i7eh7vQIwzN5K0JSVcgAYvabmHfbRLhTS1zY+0KhKBQKl5Putdd4LyIQ86qIaV1oDe
         IrLHCzHKXLiPf11sXF25sbBxDwUlqOLwEahu5Xr8MruRx8yPqIb+T3tcY9SNeYtv3GbP
         6FNTxt6F/l/8SMjmy+mQ+N22/S6aHQw5QqoBnxXtMvxVC5WMvM2CA1C6kzDwVTjOcQK1
         3qRg==
X-Gm-Message-State: AOJu0YzH6eyqm0SgG/qome/NuwT+XuabedCoQBFAz3yZbvN0Fg/bYGhY
	xKswZCStw5hTh7LwxNJFXNw9+PYPjZTSMexjRVDkY34s5tcW2WHyWsRWw7qT6cQS2Mz46FNGOex
	C4WrreDB6mzfWR7SSSWfPojSdWUcVdH0=
X-Gm-Gg: Acq92OE+LpecXXPritr4w99OJ8IVfdIG+m1iWKsBdtCpmw5vF1WL74v3/Af5/7z9UTl
	RGuVz6ef64nbEDXQcR/YnP5BGrWU5D/u7ApoQ6kTeYknJ8+VTB+7UigNw6Gtim10AEVPb+gAvRW
	r5LK5S+l+XNZ3t/nL+5KlsFZ7eUSN3GkAMux+G1C96wtSlgmFYKvaSad3Mqsm9+b0eP95rzrVdz
	3FUQDCvn89HhCetE/4y3ltqI1TtcjP1L9+KX3jJRqSqM9TCVo5hqcZVWlRuimYvV4qW8huJetxa
	XOXNvl3iyT2rilc=
X-Received: by 2002:a2e:bc0b:0:b0:396:a041:6101 with SMTP id
 38308e7fff4ca-396d0977d22mr40167931fa.14.1780929456489; Mon, 08 Jun 2026
 07:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194502.282098-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605194502.282098-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 10:37:24 -0400
X-Gm-Features: AVVi8Ccu_9O6x-oE9rFevs3uzp9RP3KqjYngt2doZsma7i_34qzy6G18ExVMMxc
Message-ID: <CAP+JOzSdvJBYeNnOJ31C_EjPv89=t82irur7qUHR9P=g7PrsKQ@mail.gmail.com>
Subject: Re: [PATCH v2] secilc/docs: Adjusted correct statement keyword
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/466
> Signed-off-by: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 fixes the GH pr link
>
>  secilc/docs/cil_role_statements.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_st=
atements.md
> index 2e1b4047..3e0688db 100644
> --- a/secilc/docs/cil_role_statements.md
> +++ b/secilc/docs/cil_role_statements.md
> @@ -51,7 +51,7 @@ Authorises a [`role`](cil_role_statements.md#role) to a=
ccess a [`type`](cil_type
>  **Statement definition:**
>
>  ```secil
> -    (role role_id type_id)
> +    (roletype role_id type_id)
>  ```
>
>  **Where:**
> --
> 2.54.0
>
