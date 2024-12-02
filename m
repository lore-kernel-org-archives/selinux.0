Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65791DE4E6
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174275; cv=none; b=jsrXDtDjGfRcRoIGvJvD3PmfFdho2JaNei5jfPd0DBVg90OlXu6p5U+e6kcCkdXutQ+ZhVhFbxWFZscnylSBXNuvp4F309kuzeBY9CKQX0Tkqm5J9lZ2xw3Fy7eeEW/c0Yn22/x/zFbm38d8WXak9OwDvq/tYhCw24fgd9zjS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174275; c=relaxed/simple;
	bh=W/kI/8qP1db6lRwrxu8XeVAr2KeMQTS+wKECFr2t8Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdGYg/58z36cDKtDu9IH3Dbg79zoO29y2897c1A48zk9v0/bJsxitUZ58LWuCmAesl0SjMsHXasjcWt9eoRcdha21i363t9wfl/I3pLyjVyTidmLLctVTB4gpXMtDLZtTALOf2utoo+ZZaArO09vBT10YcpboCaj2y4d1fYbpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMpCNj2C; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMpCNj2C"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27b7a1480bdso2307546fac.2
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174273; x=1733779073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVVFnH4NnMynSKsqBSkfTA7u107tGfrI2AFAtyWJ1YQ=;
        b=PMpCNj2CfJ09GqWTWgtZNaZUJtO/9sYcQ+dyaLmFVIE0AEL/BFh/du1tCN70+kx87+
         c0Se3ECOPdXE74RPKJK/Pd5osdo8cA/0shNwr4hvXdZjhE8950PX4yBV2ZWAbgRPTYmZ
         g1bC8zbRW7+P4vQDO5jJ/wM0CcNPKxbtQOvFm2i8ILlBOoXz9ErAx+Qu71Y36D/JyMZx
         yxeMvrWaM7843+0ilKqpbEBeNVzhHXtaUztd9ow13UGhKkbiUYehbxXXezVKDxdv2mWw
         uqIHBfloGQAsRsfrnnJanW4yBfYFhUHO8LsVV0oGySxkSrV6J6NFrUimZ8Z0FFYAOV9U
         iW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174273; x=1733779073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVVFnH4NnMynSKsqBSkfTA7u107tGfrI2AFAtyWJ1YQ=;
        b=baRuO0ziy6A6dEwVr7G8sLOJl4VBktX9o7WIw8cV4q0ClwJ/g3x+IW5tG22TzURzI9
         XViMjSrSYqnbL1XSQkBeErgktp2lhvVugSOlh+gHAYVWpTbITKYJLfq7Ol9zZLshja5X
         2OELXSFwbA1HUPwmaPsaae191+zZ7ohfp+6gyt36jrQ2rBGq1OFPfe7LGOlj4mKXzZ5D
         3GqZK0RoL6K7wLwHMIZNNAqIKX0YDQIpPCyfg0kBkYcs0YQW3p1m9xueLcWP7G/RVLN6
         dLxe4JCCYtzspQMRj9qaxtpHYqNoAKhFxdsXR4yq8yvAvd0l1IVrFa45Y7iwdd6SpeXS
         lgDw==
X-Gm-Message-State: AOJu0Yy4GKeA/Jqhkw5eM1eAdg0d0aP3adabo5ghJDKozJUa3drAqlvu
	QD+qCazRHXh8JlI3iEJwrGzRi853TIWE4+rfRhy7dAFhdiC5FM8DDar2WlAacvTwIsc9L5bvqQJ
	JG7IumNBqB0ujbd9JxFJd2UI4nQ8=
X-Gm-Gg: ASbGncsYfif8Xl45ezssl+w433s9j4O7zDRywJq6fB65EPRfYoKWJ8c9I9ljC2eN+6c
	Is1aQM8uCs0DN6QUrdeuIECDtGP6vy54=
X-Google-Smtp-Source: AGHT+IFkUf2MxWqqfl+7tzWKu/wC/KjfWpX1ts1CruQ1cwZ7RzrWuDlLoYX1mycJWR/IK/JILsHJRqpR1t+Rg+4F0rE=
X-Received: by 2002:a05:6359:45a4:b0:1c3:7358:3d17 with SMTP id
 e5c5f4694b2df-1caeabcf3c8mr14981655d.23.1733174272695; Mon, 02 Dec 2024
 13:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128154034.23298-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241128154034.23298-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 2 Dec 2024 16:17:42 -0500
Message-ID: <CAP+JOzRsJzQzn6f1_UZLaGg3GWNFn7HohyiAS0z6+BZcfkVELA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid unnecessary memset(3) calls in hashtab
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 6:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use struct initialization with designators to skip unnecessary memset(3)
> calls.  Since libsepol is not a security boundary uninitialized padding
> is not a concern.
>
> Also drop the dead assignment of a region to be free'd in the next line.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/hashtab.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 399582b1..4c658588 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -48,12 +48,14 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (=
hashtab_t h,
>         if (p =3D=3D NULL)
>                 return p;
>
> -       memset(p, 0, sizeof(hashtab_val_t));
> -       p->size =3D size;
> -       p->nel =3D 0;
> -       p->hash_value =3D hash_value;
> -       p->keycmp =3D keycmp;
> -       p->htable =3D (hashtab_ptr_t *) calloc(size, sizeof(hashtab_ptr_t=
));
> +       *p =3D (hashtab_val_t) {
> +               .size =3D size,
> +               .nel =3D 0,
> +               .hash_value =3D hash_value,
> +               .keycmp =3D keycmp,
> +               .htable =3D (hashtab_ptr_t *) calloc(size, sizeof(hashtab=
_ptr_t)),
> +       };
> +
>         if (p->htable =3D=3D NULL) {
>                 free(p);
>                 return NULL;
> @@ -127,9 +129,10 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, h=
ashtab_datum_t datum)
>         newnode =3D (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
>         if (newnode =3D=3D NULL)
>                 return SEPOL_ENOMEM;
> -       memset(newnode, 0, sizeof(struct hashtab_node));
> -       newnode->key =3D key;
> -       newnode->datum =3D datum;
> +       *newnode =3D (hashtab_node_t) {
> +               .key =3D key,
> +               .datum =3D datum,
> +       };
>         if (prev) {
>                 newnode->next =3D prev->next;
>                 prev->next =3D newnode;
> @@ -223,8 +226,6 @@ void hashtab_destroy(hashtab_t h)
>         }
>
>         free(h->htable);
> -       h->htable =3D NULL;
> -
>         free(h);
>  }
>
> --
> 2.45.2
>
>
