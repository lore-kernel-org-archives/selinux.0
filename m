Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DB1CBE9A
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707212; cv=none; b=n0LEv8uP4C9UwntAHYuOa764RxpkMBlGi7uW3YwWOsievYxFH6M3b6o5G2HorvWmD3lK+4YCxufxAoOPl7TkaLx/ZN7RaTHsfsxSkoV7uhCB6HQDbDi5cpf5pyrjzJTfF/hShlc++FRH2u+bN++hf+evmvU+BDx59d1iy2ZN7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707212; c=relaxed/simple;
	bh=r2jUphAncv4ZajzF8aNrKg6+rwVGSNaNeVuJfBHXj9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3dnPMpVlpkHKtyGccizZD6FTX7MT79zSgGmDjvbTjIhWEMO5DYxZStfCjigmVtWbHxXe71VToyuweKJ6UNwOUHJA/jKllcHFNdQKTV3w1vs5iWFl8E8YuHZolzKG0FGl9N2+NkqjggB+L7CehuTrNYVf6JiiigVPdketFOQjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwxpGraX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwxpGraX"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e60e57a322so100198b6e.3
        for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729707210; x=1730312010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYjqZOuqtl4hOkvm+gm91AqF8AoKFJP0pr3NJC2ZKM4=;
        b=BwxpGraXrLDZ4OtdujmjvG0gyqIoUCRP7z9aCcqvGmO7rGDsKuNcILC/OwexsF6H8L
         y7B0vaDbWKT+9tSq+5ii94l0QUePZSs0LZKZUL51mhkR++6Zpd3Fc+Qxf4qtL2IXHOq0
         4k6FALibAoTfKh/xKqV5SXqf+u875BZKVYg1glJsYIwE4OrBMIH8iXbXHxSvOcvrD5i5
         xCCLIPXJdwBVueMk5hxAb0kQU4Svo70BAEc5REMxXL2p1TcXUij2Cb0oWmTilvcsGJNw
         9ri6iEk0j6Y2eI1EFu94p2KbESrQ9POiYoXJYpHAz2VBhFVI+KeLMrbTyls6NYQgS0wh
         LbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729707210; x=1730312010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYjqZOuqtl4hOkvm+gm91AqF8AoKFJP0pr3NJC2ZKM4=;
        b=cDoL86KgcNoHpX7Slc8W/PoB2EQgP72SwzEWJgOKjDYte4ysGKXx+yzuQK6UTpT59B
         WbQgRFZNYGZ0yybI2bCZVNsPc46biilhZThEzI+wCj4pDzhuyozvwy8TG8llDijJHhEH
         wb5LqJtUxdQ8caq1625iQ4ZbTBYg3+QArWEpRt1LQ6G4PMA3frYbAgUlVLTkPM9nlc0z
         +5+ohpf08N384impqRaqqxBLTmkQzWuNOjfr9s+NNW1BPlVwuCQ+11tpuYCYxW/KpmDN
         MOeWE7skpY4CxF5ew+9MJF5rTukp1OJJ0QCuEYg0n1z0Ntflnl0YXH7jK4fPsY55Y1Mp
         zIKA==
X-Forwarded-Encrypted: i=1; AJvYcCX8j86nNsVxFYepwZlipfD3rF6KK6wRHxRJl1CvfDGHIJk7m9g1njQz+mJOH9ce1qsfdmnesqGa@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZZQ8gpQB7bJXkPsVMO+/7QOcv+CcoRHOR1iQ/B7osL4cElSN
	/8rKVPGGPV9x5ICjosSFfzrpbsQQLfvO/kGnqZKgBJ+VGqAjmm5xXKjca9Vn/kYEkKOp4o0nGul
	YKMyl7z0MqkNr1WOQ0+mKv7jE8gw=
X-Google-Smtp-Source: AGHT+IGkjy5ZF37h2BSePQT7Z64da/Q/Fct87VxVjuZqMBuSnfrMm+WmW8tkaD99nNjE3l+ZVlawHATO3XEKkCsK9aQ=
X-Received: by 2002:a05:6808:150a:b0:3e6:89d:5294 with SMTP id
 5614622812f47-3e6245cb3cemr3874794b6e.42.1729707209879; Wed, 23 Oct 2024
 11:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021231201.2638151-1-tweek@google.com>
In-Reply-To: <20241021231201.2638151-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 23 Oct 2024 14:13:19 -0400
Message-ID: <CAP+JOzRH5QNpPhyj4=ZAnC7_hdAazfCdFRd8_j5secuOxb2Aww@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Support nlmsg xperms in assertions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: stephen.smalley.work@gmail.com, paul@paul-moore.com, brambonne@google.com, 
	jeffv@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:12=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> commit ba7945a250c added support for nlmsg extended permissions in the
> policy. The assertion validation was not updated which lead to false
> positives when evaluated. The optimization update was also missing. Add
> support for the new extended permission for optimization and assertions.
>
> Fixes: ba7945a250c0794837f94ee1fb124426166bbc6e
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/assertion.c | 16 ++++++++++++++--
>  libsepol/src/optimize.c  |  5 +++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 3076babe..5e129883 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -110,6 +110,10 @@ static int check_extended_permissions(av_extended_pe=
rms_t *neverallow, avtab_ext
>         } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLDRIVE=
R)
>                         && (allow->specified =3D=3D AVTAB_XPERMS_IOCTLDRI=
VER)) {
>                 rc =3D extended_permissions_and(neverallow->perms, allow-=
>perms);
> +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)) =
{
> +               if (neverallow->driver =3D=3D allow->driver)
> +                       rc =3D extended_permissions_and(neverallow->perms=
, allow->perms);
>         }
>
>         return rc;
> @@ -142,6 +146,12 @@ static void extended_permissions_violated(avtab_exte=
nded_perms_t *result,
>                 result->specified =3D AVTAB_XPERMS_IOCTLDRIVER;
>                 for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
>                         result->perms[i] =3D neverallow->perms[i] & allow=
->perms[i];
> +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)) =
{
> +               result->specified =3D AVTAB_XPERMS_NLMSG;
> +               result->driver =3D allow->driver;
> +               for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> +                       result->perms[i] =3D neverallow->perms[i] & allow=
->perms[i];
>         }
>  }
>
> @@ -176,7 +186,8 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>                              node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
>                                 xperms =3D node->datum.xperms;
>                                 if ((xperms->specified !=3D AVTAB_XPERMS_=
IOCTLFUNCTION)
> -                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER))
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
>                                 found_xperm =3D 1;
>                                 rc =3D check_extended_permissions(avrule-=
>xperms, xperms);
> @@ -376,7 +387,8 @@ static int check_assertion_extended_permissions_avtab=
(avrule_t *avrule, avtab_t
>                                 xperms =3D node->datum.xperms;
>
>                                 if ((xperms->specified !=3D AVTAB_XPERMS_=
IOCTLFUNCTION)
> -                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER))
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
>                                 rc =3D check_extended_permissions(neveral=
low_xperms, xperms);
>                                 if (rc)
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index a38025ec..8a0b70fe 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -189,6 +189,11 @@ static int process_avtab_datum(uint16_t specified,
>
>                         if (x2->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER=
)
>                                 return process_xperms(x1->perms, x2->perm=
s);
> +               } else if (x1->specified =3D=3D AVTAB_XPERMS_NLMSG
> +                               && x2->specified =3D=3D AVTAB_XPERMS_NLMS=
G) {
> +                       if (x1->driver !=3D x2->driver)
> +                               return 0;
> +                       return process_xperms(x1->perms, x2->perms);
>                 }
>                 return 0;
>         }
> --
> 2.47.0.105.g07ac214952-goog
>
>
