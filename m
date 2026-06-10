Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8022275870
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100175; cv=pass; b=CZO9mr+8uR9Q1PcZ8XHCHQXCdLVpBkUf5C4nUr5WGegs5P268e/1N9wdoyerfadvM+9N2YudE56hKOGIrXyaMkRwFbxzHVUwoXazeeGZaaA8z3hJ7k2K3kUcjqeRytcN7+qH1zFUFDu9oZh+gasy9iVtEsNHY7SvgJ1nNwj2ixU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100175; c=relaxed/simple;
	bh=b/TiR4RhK1acSCIMHuVgweN7SiNErixObYEvt1uztDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgIxmenqtaK3sxgQjc8AHXkbiTZlWiOSESS+cfoS/nGB4T7Bsk1Pqmm4dSNv7J9eo6DlWdf98RDfF/+SBdP2Y1SjyAEBGXmnzubAhW6pYdXLiPdi1ft1VqEcoeIm/t6rCbQzKJaD0GiYExpEFeS7yoqCMe9bgjJXnZnEIVseAcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZvKkFcZ; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZvKkFcZ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-397e391cb2aso30680931fa.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781100172; cv=none;
        d=google.com; s=arc-20240605;
        b=h9bsnsafk56JUqjpCAR6yZwhmeXx5csypVoOz3rRha0I7auHdXQ4pZ2tYmmIcdeaut
         yTi6bx2WPNnQbUQhF3EjC2yVHI9yCZBGmRiN0OJ8FGwUirbJ5vVn74nQUsvzy9PS7smn
         2PjH4ERcrTpBxoIPLQWVemcmE7/hcBVyJwzop0zplzQlE3FLRhWSOg+hz2mOPIh2rElH
         PxsW9WP6ggJ1MwPdRenjvZjFnTCYoIZuLFNptUX2rfwBlkFcLyeWM53aM/SGuO1gZ9Fk
         J9z8bAYXpGXuO72a/JnchsSk+8J9Lidz6ay4rLLZsJgS3EEWLThgRhGNUeuXby5yH1Km
         3wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kvw/nK732WKR1TTdsATi37M3D0Y/T2YVWEij2o5vcH4=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=RSa9Wv3sFywYD6DjFdYq2fwQ4YaSBB+kJRVApUq3ZJWnxaHpGup5eezHIgdj7YikFk
         KhVrNU9UHf0AZJgCdPCGEvaOaiXX689gCLLqZSmc23hwv6B70voYtE7AK+lmnS2EjOuG
         /LTsMfk74SGq8hdTt52FoxLvUphF1HexKK4NVypG+sc+BrKGDk79cZWXz7qnRZAhgBFQ
         hmH3hBuhWkoFE3Y3EoDZ108aEjbnsvUsF+5tNF1afcNuWw0Uo8miudGcmpKPc9ObB3k8
         uT5sIfVgHk/UzcRa7FMYWD8YNhwhmvhsfh851gEUYK55AznOWALLdE81SD/shT+xjd9q
         8VuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781100172; x=1781704972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvw/nK732WKR1TTdsATi37M3D0Y/T2YVWEij2o5vcH4=;
        b=sZvKkFcZaJUKy3ldOioT7lyidRVtz8c5bnA+uvh/2zMMl4oLAQyzAc1oDqLxIBVip6
         z3kzRKazVtH/ZoM59UFrdm35keMvkdHPKnPF+jJP6zaRjAEWXyGaoM4c2JTuxIyNkYEp
         eaclLJvyzWv3uz9iLhB4+M9tqDY2jQeA1hG3Z5MwdvTIQOVIye253X8pOUU8gE80bN1J
         4WCs6hovl1tqQ74B03tH5Meb+h+DvfC39OdPWOAYiseNG/Te5V6QCw/zVbrz6bMoFff3
         8ljfqIzZXeqdt03QonkKdvvMTgAEgZOhXJYP2Ham38b7unh74VDBtmCk0RMyrcJSfMhL
         DSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100172; x=1781704972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kvw/nK732WKR1TTdsATi37M3D0Y/T2YVWEij2o5vcH4=;
        b=RBZD2zX/CrZyJcgK/hIrGtJTUeQCUM950tO6+lphqK2hodD+DrAGtqfRlxc/f25+RX
         QayVxpLj5nasxz8ibvp+PQ0ANJ39cZ0WD6THS7+n7zk7c6z8kkfceVkxHybcNDQQQu6S
         tkEvJAqRDX8NzwejcL5k+4Q50rrnzMrWWITmruhNN6nehN7M2cPFfQ9H2FCxbtsAYNbF
         ShK6PwxvkLjODodVNXzYY0zx5O1ErvDXvxsGnz5eMOgIosiSnkLqqF/LpuUKEI+DJlTW
         GVHi1sNXoshC4ueJILOTIUXacOeJoXenhFoEQgzqlhCj9fY16Qlf/y80CINSNpt4/ryW
         NN/A==
X-Gm-Message-State: AOJu0Yxlrt9zTjZt+AzFzm4D9Q8LyE69e+OEtP74VyznjARHvGesKhXl
	oj71aSiUOI8fvN4tZxShAW/5MCVJDsIENqF4i1o81pRgQjXuO5BAaJFPueqN6dPtEBnr6YRrMJ7
	3O5hKnbX8f3Am0tDELlNHPgOmgjiKMR4=
X-Gm-Gg: Acq92OFSqZkVq+2Cq7VQg1R9O3jXEF6z/TnpTu9w7j8JDCTM812JKTytQ3odLjG1swL
	9FFcw71eUbEIx3lwiON9AeOPCfzH75DxupxhU9zocnSLwU6gcbCBwC99LzHx0BhY04xycltvCf6
	P4Na+ALXFOALAzcZvqxyjceoulG14pyeGuY+aZemVHRb3wzjG2YOPXM+QexkOFlwWacrhGOacIO
	lIdAOqWBtLIRjaKrKw/4H7bef2bj1DNFRKRf/0D/WqblIGarul3Ue7RKiO87DyNSZRbDIhuw64x
	l5iHpfqoYaHrd/I=
X-Received: by 2002:a05:651c:1502:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-396d07f065cmr73175771fa.6.1781100171717; Wed, 10 Jun 2026
 07:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610124229.5628-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260610124229.5628-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:02:40 -0400
X-Gm-Features: AVVi8CeqSmzLzK2OZbtfbxNpCeXL7-ZCkX9OYvsimI3yU7EnUNZrAyrAbrkCj5U
Message-ID: <CAP+JOzRxCMaUBqPJyje-jmeePWpTg0PPCs4Sq3v2fn=Mj1PxyQ@mail.gmail.com>
Subject: Re: [PATCH] sestatus: null-terminate process and file check entries
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> load_checks() copies each [process]/[files] entry with malloc(buf_len)
> followed by memcpy(dst, bufp, buf_len), leaving no room for a
> terminator. A config line without a trailing newline (such as the last
> line of /etc/sestatus.conf) yields a buffer of exactly buf_len bytes
> with no NUL, and the entries are later used as C strings in pidof(),
> lgetfilecon(), lstat() and printf_tab(), producing a heap over-read.
> Allocate one extra byte and terminate the copy.
>
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

make check-format complains, but other than that:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/sestatus/sestatus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestat=
us/sestatus.c
> index d83602fd..528cdcce 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -135,22 +135,24 @@ static void load_checks(char *pc[], int *npc, char =
*fc[], int *nfc)
>                                 case 0:
>                                         if (*npc >=3D MAX_CHECK)
>                                                 break;
> -                                       pc[*npc] =3D (char *)malloc((buf_=
len) *
> +                                       pc[*npc] =3D (char *)malloc((buf_=
len + 1) *
>                                                                   sizeof(=
char));
>                                         if (!pc[*npc])
>                                                 break;
>                                         memcpy(pc[*npc], bufp, buf_len);
> +                                       pc[*npc][buf_len] =3D '\0';
>                                         (*npc)++;
>                                         bufp =3D NULL;
>                                         break;
>                                 case 1:
>                                         if (*nfc >=3D MAX_CHECK)
>                                                 break;
> -                                       fc[*nfc] =3D (char *)malloc((buf_=
len) *
> +                                       fc[*nfc] =3D (char *)malloc((buf_=
len + 1) *
>                                                                   sizeof(=
char));
>                                         if (!fc[*nfc])
>                                                 break;
>                                         memcpy(fc[*nfc], bufp, buf_len);
> +                                       fc[*nfc][buf_len] =3D '\0';
>                                         (*nfc)++;
>                                         bufp =3D NULL;
>                                         break;
> --
> 2.54.0
>
