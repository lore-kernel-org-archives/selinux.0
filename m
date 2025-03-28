Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF71D6DA9
	for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187091; cv=none; b=JygYGi5r9tyKC5frUdlg2ItCGlBfZhR95Xvw+QJivD5o3TZHZtU/QXQggxUWwA/TK8qx1V8BLs6I+OnKC8STuh8lOC1H6EWeejD9B+Iq/PJdTgV81fWqOshOo60IMCiYVyScZapN3lfmqGLZbdAM3xyt4lmP32Kae106wgvh+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187091; c=relaxed/simple;
	bh=0oKKam4hL8L7ElMDqQ7y03bkkm1Rc91OA+I/glY/jbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQRX/L1NPBYZBiS6WJpDpq4sEfuxOXgJWrv+3R89VT4FS47u403zIocAY1WjKml7ubqXSgS4sRtAhNOl4Ul5k7xbtq2ueFN4shne5oZpUaxjYssG8+XL2oUqMIgG7grJ85FTicpIoDhgBVEH/d7F6lXZqUk+amUtKhvkhv20ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cysc9JuD; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cysc9JuD"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so3140601241.1
        for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743187088; x=1743791888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShjMY8SfaiLCEk8YMW9KiX/bmukuqfjH7hfcFqv9tbs=;
        b=Cysc9JuDLvKNIACegfmp8URvDhFugSohjIt/vezdrb2TOu0CPDpFRb2YlR2ELGIB51
         fpnmr761Ka6RY7N1Z08dztP2EKIK8CZjZD+XsvubgRu9afrsKVV/KUfW/Zg/nS7mzjjL
         SbX+4cmx2Oifr5GdzczB7prI9RXcvCNfXfrAl2NXyVK/IBf4vZL0ctgoGRE3kzcket7f
         lS6VTkRAqs6fVyvd/kF2YgGjk/RRKQFPTg96rXjb3Dh8xPdY4+42cM/u1uWmHP4XzfCL
         ToQMvFd6oQVx+6/G4bETNnhYV6H9UNqjUa6IrVNXZUb+p0cxS8toKotSLaGK399Th3n/
         md1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187088; x=1743791888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShjMY8SfaiLCEk8YMW9KiX/bmukuqfjH7hfcFqv9tbs=;
        b=AoSl72IQjy854wVMTMKX9fSzYAndOkNeYpDY7zQ7Y6T7yfKpKbK5nrSt3QU1W2ouuk
         ai9sDVJzRu9I3PFJV1ePHdwirQfZZlqj7xUJ7vgjZCEGteHwKFSHzC2giZeUkaTysFav
         SlElPrAbRfBKMzOTf5xYmH7bB5fcGjpZ1epwvD+RKldI/snoaNcJ0eaLN+40J4oeD0Fz
         BntWdnARt7UuojwPuTvuxLsYyL3Jbza8Yf6+8ptux8gHM/WEkg5zwYdgF6FUQkR1/LcP
         sJAzZmxq6e8EDEpCKqa0N7yYOvxxBh+upwrQYLGzgB6JyLz8O26QZ0wXc7DYVn10KgU9
         oPhQ==
X-Gm-Message-State: AOJu0YzUivgqYucsa3N7x4Shahkuq6jb65Dk2zEbG2Apj7aPVEyIawJS
	KvoUCWAXn4oMXnLpX7obmp3FtFfx72d9hVeV5JFrbMnX6y1tLtGj1GG8ewiHxEw1wMv7mAhzCco
	Fy961Od8hrI+fOj5S/8xzn/5dgg3tDVukuds=
X-Gm-Gg: ASbGncvFK/huRMQJJhrHFJ1myarKGMg6HTlHHpeD/ZnllHG9NyRYHpDVtKvTMno36pZ
	16EbJwzaSJkKaLaO3AmmhLSEiPIgbggOqxyr52/jNjCcE3b8j+FatVskS4XuIZh9DFvFN1aZn9d
	++VbMDgjgm0iK9TyPDFh02SJ4=
X-Google-Smtp-Source: AGHT+IHUxjPhOc0X/pcbRpQy12Au4UUTPtqp1j/FyhHHTpSnnSOYF3oi3ckZ0Btb4ktyl/Hkq/Hm51R7DyaiDgRRPZI=
X-Received: by 2002:a05:6102:356f:b0:4c5:2e31:8818 with SMTP id
 ada2fe7eead31-4c6c2673b6bmr2451106137.4.1743187088279; Fri, 28 Mar 2025
 11:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226094409.41452-1-cgoettsche@seltendoof.de> <20250226094409.41452-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250226094409.41452-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 28 Mar 2025 14:37:57 -0400
X-Gm-Features: AQ5f1JoM2tY_epqHcf346mNq_WQdtiEqkJheqe_DoEOwj3nFwc6f6eYBfEv2mqg
Message-ID: <CAP+JOzSjQy11K7aUYUA=+GCundQ+R+dajUQyZruzd8T7dEcddA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: introduce context_to_str(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Currently context_t offers the function context_str(3) to get the
> formatted security context of the internal representation. The return
> value is a pointer to an internally, on call allocated, stored cache.
> This can lead to invalidation issues and if the caller wants to store
> the result duplicate allocations.
>
> Introduce context_to_str(3) not using any internal cache and moving
> ownership of the string to the client.
>
> Use in appropriate places.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/context.h |  8 ++++++++
>  libselinux/src/context.c             | 30 ++++++++++++++++++++++++++++
>  libselinux/src/get_context_list.c    | 15 +++++++-------
>  libselinux/src/libselinux.map        |  5 +++++
>  libselinux/src/selinux_restorecon.c  |  2 +-
>  libselinux/src/setexecfilecon.c      |  2 +-
>  6 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/include/selinux/context.h b/libselinux/include/se=
linux/context.h
> index 59d9bb69..1b62fc72 100644
> --- a/libselinux/include/selinux/context.h
> +++ b/libselinux/include/selinux/context.h
> @@ -27,6 +27,14 @@ extern "C" {
>
>         extern const char *context_str(context_t con);
>
> +/*
> + * Return the string value of the context_t.
> + * Similar to context_str(3), but the client owns the string
> + * and needs to free it via free(3).
> + */
> +
> +       extern char *context_to_str(context_t con);
> +
>  /* Free the storage used by a context */
>         extern void context_free(context_t con);
>
> diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> index 33c48ef3..2891e5a0 100644
> --- a/libselinux/src/context.c
> +++ b/libselinux/src/context.c
> @@ -141,6 +141,36 @@ const char *context_str(context_t context)
>  }
>
>
> +/*
> + * Return a new string value of the context.
> + */
> +char *context_to_str(context_t context)
> +{
> +       const context_private_t *n =3D context->ptr;
> +       char *buf;
> +       size_t total =3D 0;
> +
> +       for (int i =3D 0; i < 4; i++) {
> +               if (n->component[i]) {
> +                       total +=3D strlen(n->component[i]) + 1;
> +               }
> +       }
> +       buf =3D malloc(total);
> +       if (buf !=3D NULL) {
> +               char *cp =3D buf;
> +
> +               cp =3D stpcpy(cp, n->component[0]);
> +               for (int i =3D 1; i < 4; i++) {
> +                       if (n->component[i]) {
> +                               *cp++ =3D ':';
> +                               cp =3D stpcpy(cp, n->component[i]);
> +                       }
> +               }
> +       }
> +       return buf;
> +}
> +
> +
>  /* Returns nonzero iff failed */
>  static int set_comp(context_private_t * n, int idx, const char *str)
>  {
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 8d5ee6fb..0f3bdc5c 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -145,7 +145,7 @@ static int get_context_user(FILE * fp,
>         char *linerole, *linetype;
>         char **new_reachable =3D NULL;
>         char *usercon_str;
> -       const char *usercon_str2;
> +       char *usercon_str2;
>         context_t usercon;
>
>         int rc;
> @@ -255,7 +255,7 @@ static int get_context_user(FILE * fp,
>                         rc =3D -1;
>                         goto out;
>                 }
> -               usercon_str2 =3D context_str(usercon);
> +               usercon_str2 =3D context_to_str(usercon);
>                 if (!usercon_str2) {
>                         context_free(usercon);
>                         rc =3D -1;
> @@ -264,6 +264,7 @@ static int get_context_user(FILE * fp,
>
>                 /* check whether usercon is already in reachable */
>                 if (is_in_reachable(*reachable, usercon_str2)) {
> +                       free(usercon_str2);
>                         context_free(usercon);
>                         start =3D end;
>                         continue;
> @@ -271,20 +272,18 @@ static int get_context_user(FILE * fp,
>                 if (security_check_context(usercon_str2) =3D=3D 0) {
>                         new_reachable =3D reallocarray(*reachable, *nreac=
hable + 2, sizeof(char *));
>                         if (!new_reachable) {
> +                               free(usercon_str2);
>                                 context_free(usercon);
>                                 rc =3D -1;
>                                 goto out;
>                         }
>                         *reachable =3D new_reachable;
> -                       new_reachable[*nreachable] =3D strdup(usercon_str=
2);
> -                       if (new_reachable[*nreachable] =3D=3D NULL) {
> -                               context_free(usercon);
> -                               rc =3D -1;
> -                               goto out;
> -                       }
> +                       new_reachable[*nreachable] =3D usercon_str2;
> +                       usercon_str2 =3D NULL;
>                         new_reachable[*nreachable + 1] =3D 0;
>                         *nreachable +=3D 1;
>                 }
> +               free(usercon_str2);
>                 context_free(usercon);
>                 start =3D end;
>         }
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index 02f5b761..ab002f01 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -257,3 +257,8 @@ LIBSELINUX_3.8 {
>    global:
>      matchpathcon_filespec_add64;
>  } LIBSELINUX_3.5;
> +
> +LIBSELINUX_3.9 {
> +  global:
> +    context_to_str;
> +} LIBSELINUX_3.8;
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index ab1c5216..f5023492 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -611,7 +611,7 @@ static int compare_types(const char *curcon, const ch=
ar *newcon, char **newtypec
>                 rc |=3D context_role_set(conb, context_role_get(cona));
>                 rc |=3D context_range_set(conb, context_range_get(cona));
>                 if (!rc) {
> -                       *newtypecon =3D strdup(context_str(conb));
> +                       *newtypecon =3D context_to_str(conb);
>                         if (!*newtypecon) {
>                                 rc =3D -1;
>                                 goto err;
> diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfile=
con.c
> index 4b31e775..15346621 100644
> --- a/libselinux/src/setexecfilecon.c
> +++ b/libselinux/src/setexecfilecon.c
> @@ -34,7 +34,7 @@ int setexecfilecon(const char *filename, const char *fa=
llback_type)
>                 if (context_type_set(con, fallback_type))
>                         goto out;
>                 freecon(newcon);
> -               newcon =3D strdup(context_str(con));
> +               newcon =3D context_to_str(con);
>                 if (!newcon)
>                         goto out;
>         }
> --
> 2.47.2
>
>
