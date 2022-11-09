Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B781C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 21:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKIViQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKIViO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 16:38:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381AFC4
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 13:38:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so28126065lfk.0
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRjeI86hvARzFgm6WUB1hmAFQGGqRLcGJ9pTnjGhARQ=;
        b=TLl4Y/VZOgR8gRa6Wrxox3T4yzOtPywXKLXNy1XhjxtONV7LpObWrOJ7Md/lV5VzjG
         gA028a3eGlKsqXQLK0HRMPCQ1xLxwkR/4q8IPB5AyVqAbTO4qYmsiyxXABk64RpMgotf
         fOBz/KNWN0EMQDGGKr8pN0ExcX15TfNbldHmZTBnSQvkdbqMFbtSeUX4kOWOWkmU1JAR
         0RsnssAEzBLIknQEiuS1gySYE7GfmXNer0Cd53dWY54SCtEUy6ZCH55gq6iGUTeX8Wi6
         rdNpxfmDFSuZN4Wb3XF5nOQ7kral00JXK+fcfJcFMM7wt3sW65TVGz3DGnH//jn1/bnC
         n19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRjeI86hvARzFgm6WUB1hmAFQGGqRLcGJ9pTnjGhARQ=;
        b=KcGDia9TxWD3JvmhiVr371RgalTr6qwSDDk/63sc8Ud0w0IAE0PrziCKAnNFV/J65X
         qWjoILO1T6bL7rbknQ+U9gZXf8C5Tc0ftts9hKhA1zhzcxbEBYU2qIvL+GFZz069ulTU
         YIh32wKxpCyMt/9flXC7c2l2ppZY6xUfzMikOVTuuBHIX/4+CqxMLSmE5cCF33IqAAi5
         VuAnaqbm8H84XyCkMWNWmy3wpJqw4bt4ZNwZgb4ACCiSaIEQNjdyMjvXbfjEn9C0zbrp
         pLlamxQcuKpw5MhzeQEcB2I/GsUKkXBgXNRooJTAFySZmdiWgMwCsOqS4CnxfKuLljfk
         YtOA==
X-Gm-Message-State: ACrzQf1x1KjGD3AUzieAdOtgFjB68/9FzJE81bPtMd94gCU91MJleje0
        OeKEZ8WFQ1WUIzXZK7fp4TxjsnLETtm0r+j389x+v3NnukQ=
X-Google-Smtp-Source: AMsMyM6ophuE5r8MisuBjb4I64aew/jbP0Wl4qHb8CEGOAXEhBUzsVxNp3FUOCe1foi0aA8J2xULRn2qTFLE2Iah7GI=
X-Received: by 2002:a05:6512:14a:b0:499:4f:2582 with SMTP id
 m10-20020a056512014a00b00499004f2582mr937041lfo.515.1668029892020; Wed, 09
 Nov 2022 13:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20221109195640.60484-1-cgzones@googlemail.com> <20221109195640.60484-2-cgzones@googlemail.com>
In-Reply-To: <20221109195640.60484-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 16:38:00 -0500
Message-ID: <CAP+JOzS7GvJHGSX=qMux2aONmmfc1DbWqcW4DDhUtRFhYum_+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: bail out on path truncations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 3:07 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Bail out if computed paths based on user input are being truncated, to
> avoid wrong files to be opened.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/booleans.c            |  4 ++--
>  libselinux/src/get_initial_context.c |  8 ++++++--
>  libselinux/src/stringrep.c           | 15 ++++++++++++---
>  3 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ef1f64a0..66c946f9 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -164,7 +164,7 @@ static int bool_open(const char *name, int flag) {
>                 return -1;
>
>         ret =3D snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_=
DIR, name);
> -       if (ret < 0)
> +       if (ret < 0 || (size_t)ret >=3D len)

The above causes the following error:

booleans.c:167:36: error: comparison of integer expressions of
different signedness: =E2=80=98long unsigned int=E2=80=99 and =E2=80=98int=
=E2=80=99
[-Werror=3Dsign-compare]

>                 goto out;
>         assert(ret < len);
>
> @@ -184,7 +184,7 @@ static int bool_open(const char *name, int flag) {
>         fname =3D ptr;
>
>         ret =3D snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_=
DIR, alt_name);
> -       if (ret < 0)
> +       if (ret < 0 || (size_t)ret >=3D len)

Same here:

booleans.c:192:36: error: comparison of integer expressions of
different signedness: =E2=80=98long unsigned int=E2=80=99 and =E2=80=98int=
=E2=80=99
[-Werror=3Dsign-compare]

Thanks,
Jim


>                 goto out;
>         assert(ret < len);
>
> diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_in=
itial_context.c
> index 97ae3dcf..87c8adfa 100644
> --- a/libselinux/src/get_initial_context.c
> +++ b/libselinux/src/get_initial_context.c
> @@ -23,8 +23,12 @@ int security_get_initial_context_raw(const char * name=
, char ** con)
>                 return -1;
>         }
>
> -       snprintf(path, sizeof path, "%s%s%s",
> -                selinux_mnt, SELINUX_INITCON_DIR, name);
> +       ret =3D snprintf(path, sizeof path, "%s%s%s", selinux_mnt, SELINU=
X_INITCON_DIR, name);
> +       if (ret < 0 || (size_t)ret >=3D sizeof path) {
> +               errno =3D EOVERFLOW;
> +               return -1;
> +       }
> +
>         fd =3D open(path, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 return -1;
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 592410e5..d2237d1c 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -82,7 +82,10 @@ static struct discover_class_node * discover_class(con=
st char *s)
>                 goto err2;
>
>         /* load up class index */
> -       snprintf(path, sizeof path, "%s/class/%s/index", selinux_mnt,s);
> +       ret =3D snprintf(path, sizeof path, "%s/class/%s/index", selinux_=
mnt,s);
> +       if (ret < 0 || (size_t)ret >=3D sizeof path)
> +               goto err3;
> +
>         fd =3D open(path, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 goto err3;
> @@ -97,7 +100,10 @@ static struct discover_class_node * discover_class(co=
nst char *s)
>                 goto err3;
>
>         /* load up permission indices */
> -       snprintf(path, sizeof path, "%s/class/%s/perms",selinux_mnt,s);
> +       ret =3D snprintf(path, sizeof path, "%s/class/%s/perms",selinux_m=
nt,s);
> +       if (ret < 0 || (size_t)ret >=3D sizeof path)
> +               goto err3;
> +
>         dir =3D opendir(path);
>         if (dir =3D=3D NULL)
>                 goto err3;
> @@ -107,7 +113,10 @@ static struct discover_class_node * discover_class(c=
onst char *s)
>                 unsigned int value;
>                 struct stat m;
>
> -               snprintf(path, sizeof path, "%s/class/%s/perms/%s", selin=
ux_mnt,s,dentry->d_name);
> +               ret =3D snprintf(path, sizeof path, "%s/class/%s/perms/%s=
", selinux_mnt,s,dentry->d_name);
> +               if (ret < 0 || (size_t)ret >=3D sizeof path)
> +                       goto err4;
> +
>                 fd =3D open(path, O_RDONLY | O_CLOEXEC);
>                 if (fd < 0)
>                         goto err4;
> --
> 2.38.1
>
