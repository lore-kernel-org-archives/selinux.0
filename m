Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117818027
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015511; cv=none; b=PXK1D9FhHDQ4+btV2b4xtzn7DYI3ScUkJnUwGCoCr2/SHylrZmV75L5eyMhD37wpN/cZijscjZxJWvGaQYo34o9JxlijhNK+7AJscp/SpMrdykIp6MKTOccRAf7bc4BxwwFItLGIPlG8Z0dbKC34MOatQV+mXG1JFefxJQa4FMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015511; c=relaxed/simple;
	bh=v5DtCojzwDyEElIgpMWyDGkWlfBN6xuM7yJaN4jkT8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC3Gl0T4FFMMNW086NRTKiO9FglMH0J+xW1cYmTMt0FUWoD9yG8IjaA8Xr3QLZH6mtpLWuoM/EtP0baiqwWfQmUxWRVlrweWvpPqkGeU575QgslOj/VKtM2ZOqlEwRG80lhi+7G329QPBiewBSn4sodGpHweEX0yC3+cFWgT3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0r92JRK; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0r92JRK"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so152830241.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743015508; x=1743620308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZR3FTjsDqbbSmLENkekkTKhksj7gtILkcxO8xL1RJA=;
        b=C0r92JRKjeKn97jhbIozD3qweFZJ4O2hrOVdqLj+oT8YbxDbmb6y6ob9dEAl0KPwd2
         /fvLoHI03UWOUTEBn9oW+WAfK5Z9kOXOVMNXXQedFN21Gige2/ar/bGSLLHsbD6mdzvt
         KmLQLEt0swph9mNAe7or1ZkbI9qejF7f4JqItuM6VFDEfc7YbuzQU6CAbJrYM0l5f19G
         e58ixWmZVtSnCR3bfc12p6Kd5HU4WavnjwoxijnYSAH0kiWGl5798F56peHT0WjY4CST
         14nEJkvaZTo3epTqCLab/L+6Yyg3SaJxyTmwEg5wEK/tPlIUkNfzjGv0m8DtTAckMRDV
         cOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015508; x=1743620308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZR3FTjsDqbbSmLENkekkTKhksj7gtILkcxO8xL1RJA=;
        b=DEnLrnDVnp8zNcWVOC5eGQ07W3s6Ee+CWfHdXdsVrMCwwMWRPsAsf77t+nhPmDdPxj
         d79Pi0fqGtWhCjKR9vT3nNTZhllMYPa1Xp3mYRwdJRQqz4KMWxQs9u8P7NX2Y4qHjUct
         5jEyhOdDdg9uniN1lZTFtLwO8ET2k2ikbnocL3zAZ+zxaRb0NrdtX18FojERj/qn5oYd
         oiquIJouW/7dp5/m89nqpwOikQ11g9PJSo+9oA+uxVaREXTZSAh/gAjnG0PDsrlA+0Hd
         /SVH0rCCRxg8ebqirPyyIOy/eVmm4Zf3UOkbLu9BGL5JRLBk3pdEWLha1PvCTR6h2PUe
         THLw==
X-Gm-Message-State: AOJu0YxJz9OtCl7UPnoo9GvAiNMiDRAtuY1Bbl9rUOTkBunNKPqCUrn9
	juRtlMvq6lJWCA085GVxG/90I/DjhXtPcXaq13tTQyIFUMRNeroT4wO808yaLODyChJln0Cw2ES
	LBbg/qZ/7qfyZYlHdqJR3UbXzyQA=
X-Gm-Gg: ASbGnctVtV1CVSV39eoIiNQ5k8E0IjqCWAZt8LRXSU026Ms3Hdt+XYPrFI3vuDJjSXk
	A1QJk1d0jVyadXGzV/OsbE4q/nfPLGTXX5IHq5yeQhCpDZddTsGTtz479Zsg5FncOxiZHEaNoRb
	dvuI2v5Htf38Kc4PrWmRncNFvWMg98W7XPqA==
X-Google-Smtp-Source: AGHT+IESf4tD5JyA8ZbFmCCHLtOcbWJjYU06rXiJNt9fEeg/zU10sxuP8teroZfBoHqkaDfr7rSRQXGup1lVW+LpM3g=
X-Received: by 2002:a05:6102:3f53:b0:4c2:fccb:a647 with SMTP id
 ada2fe7eead31-4c5737c044amr5400992137.5.1743015508078; Wed, 26 Mar 2025
 11:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226090127.25701-1-cgoettsche@seltendoof.de> <20250226090127.25701-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250226090127.25701-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Mar 2025 14:58:16 -0400
X-Gm-Features: AQ5f1JpiK2tmrNQUY-KKpdIVH7CB2scXaj72kHIwnmIgbIpcz9metnbKfTAUcw8
Message-ID: <CAP+JOzRkVhH-Yi4BjOmemmX0Z-d4JL8GPEYaMps1P739+P-0Lg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: add restore option to modify user and
 role portions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:14=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Useful for data of MCS separated applications, like containers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/restorecon.h |  6 ++
>  libselinux/src/selinux_restorecon.c     | 77 +++++++++++++++++--------
>  2 files changed, 59 insertions(+), 24 deletions(-)
>
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index 5be6542c..0ccf73a6 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -128,6 +128,12 @@ extern int selinux_restorecon_parallel(const char *p=
athname,
>   */
>  #define SELINUX_RESTORECON_COUNT_ERRORS                        0x20000
>
> +/*
> + * In addition to the type component also change the user and
> + * role component of security contexts.
> + */
> +#define SELINUX_RESTORECON_SET_USER_ROLE               0x40000
> +
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
>   * @hndl: specifies handle to set as the global fc handle.
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index ab1c5216..72242c90 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -76,6 +76,7 @@ struct rest_flags {
>         bool progress;
>         bool mass_relabel;
>         bool set_specctx;
> +       bool set_user_role;
>         bool add_assoc;
>         bool recurse;
>         bool userealpath;
> @@ -585,43 +586,65 @@ static void filespec_destroy(void)
>  /*
>   * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
>   * the type components differ, updating newtypecon if so.
> + * Also update user and role components if
> + * SELINUX_RESTORECON_SET_USER_ROLE is set.
>   */
> -static int compare_types(const char *curcon, const char *newcon, char **=
newtypecon)
> +static int compare_portions(const char *curcon, const char *newcon,
> +                           bool set_user_role, char **newtypecon)
>  {
> -       int types_differ =3D 0;
> -       context_t cona;
> -       context_t conb;
> +       context_t curctx;
> +       context_t newctx;
> +       bool update =3D false;
>         int rc =3D 0;
>
> -       cona =3D context_new(curcon);
> -       if (!cona) {
> +       curctx =3D context_new(curcon);
> +       if (!curctx) {
>                 rc =3D -1;
>                 goto out;
>         }
> -       conb =3D context_new(newcon);
> -       if (!conb) {
> -               context_free(cona);
> +       newctx =3D context_new(newcon);
> +       if (!newctx) {
> +               context_free(curctx);
>                 rc =3D -1;
>                 goto out;
>         }
>
> -       types_differ =3D strcmp(context_type_get(cona), context_type_get(=
conb));
> -       if (types_differ) {
> -               rc |=3D context_user_set(conb, context_user_get(cona));
> -               rc |=3D context_role_set(conb, context_role_get(cona));
> -               rc |=3D context_range_set(conb, context_range_get(cona));
> -               if (!rc) {
> -                       *newtypecon =3D strdup(context_str(conb));
> -                       if (!*newtypecon) {
> -                               rc =3D -1;
> +       if (strcmp(context_type_get(curctx), context_type_get(newctx)) !=
=3D 0) {
> +               update =3D true;
> +               rc =3D context_type_set(curctx, context_type_get(newctx))=
;
> +               if (rc)
> +                   goto err;
> +       }
> +
> +       if (set_user_role) {
> +               if (strcmp(context_user_get(curctx), context_user_get(new=
ctx)) !=3D 0) {
> +                       update =3D true;
> +                       rc =3D context_user_set(curctx, context_user_get(=
newctx));
> +                       if (rc)
> +                               goto err;
> +               }
> +
> +               if (strcmp(context_role_get(curctx), context_role_get(new=
ctx)) !=3D 0) {
> +                       update =3D true;
> +                       rc =3D context_role_set(curctx, context_role_get(=
newctx));
> +                       if (rc)
>                                 goto err;
> -                       }
>                 }
>         }
>
> +       if (update) {
> +               *newtypecon =3D strdup(context_str(curctx));
> +               if (!*newtypecon) {
> +                       rc =3D -1;
> +                       goto err;
> +               }
> +       } else {
> +               *newtypecon =3D NULL;
> +       }
> +
>  err:
> -       context_free(cona);
> -       context_free(conb);
> +       context_free(curctx);
> +       context_free(newctx);
>  out:
>         return rc;
>  }
> @@ -631,7 +654,6 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>  {
>         char *newcon =3D NULL;
>         char *curcon =3D NULL;
> -       char *newtypecon =3D NULL;
>         int rc;
>         const char *lookup_path =3D pathname;
>
> @@ -724,8 +746,13 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                 }
>
>                 if (!flags->set_specctx && curcon) {
> -                       /* If types different then update newcon. */
> -                       rc =3D compare_types(curcon, newcon, &newtypecon)=
;
> +                       char *newtypecon;
> +
> +                       /* If types are different then update newcon.
> +                        * Also update if SELINUX_RESTORECON_SET_USER_ROL=
E
> +                        * is set and user or role differs.
> +                        */
> +                       rc =3D compare_portions(curcon, newcon, flags->se=
t_user_role, &newtypecon);
>                         if (rc)
>                                 goto err;
>
> @@ -1025,6 +1052,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                     SELINUX_RESTORECON_RECURSE) ? true : false;
>         state.flags.set_specctx =3D (restorecon_flags &
>                     SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
> +       state.flags.set_user_role =3D (restorecon_flags &
> +                   SELINUX_RESTORECON_SET_USER_ROLE) ? true : false;
>         state.flags.userealpath =3D (restorecon_flags &
>                    SELINUX_RESTORECON_REALPATH) ? true : false;
>         state.flags.set_xdev =3D (restorecon_flags &
> --
> 2.48.1
>
>
