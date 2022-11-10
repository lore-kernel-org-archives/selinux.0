Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD58C4332F
	for <selinux@archiver.kernel.org>; Thu, 10 Nov 2022 13:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKJN4E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiKJN4D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Nov 2022 08:56:03 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BF289
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 05:56:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b9so1211294ljr.5
        for <selinux@vger.kernel.org>; Thu, 10 Nov 2022 05:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLXk0Io5NUJ2Gc4rnaqA/cHXagRRpCL972pFfVphS4c=;
        b=djA51zG+EmiDRjbElsLyA1LF1guphyZsRyWyn5/o0s9NqRfkM+IeMFyb6n9M6eFU+f
         Ec3nHMXOxrvYZT4Dfqqfqhw8RSK4U0hR9L7H5M9RkAcMwgoPVHjJyBonAXNK10r6fgjH
         gI3cdJZ1pm51wcdAnXTERaS0gKX6QMcIxh4NR8ZsgJIt/X9DtULMczlkaYS8MDWc8Kxw
         ouc7WLOxAgRBdVS6UWNWo/HH9iAhF5tIJWdQ+w/T/iRWTzfrWglHyuRkyb6Cgv1WgKLM
         Tktv06iNkJQh19kofMz/M3f3eFzvtDIQqIfe/WhxvdEc/C6odWH4hvGJO09251ms18dO
         /C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLXk0Io5NUJ2Gc4rnaqA/cHXagRRpCL972pFfVphS4c=;
        b=jr6pZO/MZaW622g0lLoa+0X/f9UjP++a1a5Ojtdf3WgQ6j3sqk1WyEEMirnES+TXWC
         Ft1vYOZcaggMXRC4YxtheAJR8Rlt/DYIwcG2Yp334MMsKyJspXG1B4vew22AhZbPsgOD
         /LHdZsWuDQ+Yvn2i4sKbX/QwKWLBZB21LGdCKCajCeLK9c1Umfgck9XyASccshCAh8ik
         vdvRf5PfDIzgzrvCdOr9/CC7wkc/L0CX6q5SoCYmaTpsvZjWOmjJuTzPXLjSZzHZl0mm
         vTkPmFCq7K2XuDI0G7tru54FbUAyQaJoAb2H7MRVDpVx94rUkWfKQc1snvLeeueaO/km
         FMkA==
X-Gm-Message-State: ACrzQf1BVnDtabCooCRIxVv0l5c9aanO5c+krT4n2MqdkUeMz+aMlGcw
        KyI4j6WaZjNEX23DkQIPXy7keRgk6oID4mIeng5I4qLQe8U=
X-Google-Smtp-Source: AMsMyM5cbeVEKd9vzE6NSaZXsFukybhN2+Ym3l8m6GxeDBFUW85X1ycTpx1acAfXytF27aFelR0ixSFM/eclaIKXvbI=
X-Received: by 2002:a05:651c:11cc:b0:277:d75:f1de with SMTP id
 z12-20020a05651c11cc00b002770d75f1demr9380026ljo.272.1668088560192; Thu, 10
 Nov 2022 05:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20221109200939.62525-1-cgzones@googlemail.com>
In-Reply-To: <20221109200939.62525-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 10 Nov 2022 08:55:48 -0500
Message-ID: <CAP+JOzTBu1J+8yxXae0FB1-udOA8L1C5yHM2BfKfLpuRTW-GzA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: simplify string copying
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 3:11 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use strdup(3)/strndup(3) instead of allocating memory and then manually
> copying the content.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/context.c                     | 11 +++++------
>  libselinux/src/get_default_type.c            |  3 +--
>  libselinux/src/matchpathcon.c                |  9 +++------
>  libselinux/utils/selabel_lookup_best_match.c | 10 ++++------
>  4 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> index 9dddbc5a..8830bf42 100644
> --- a/libselinux/src/context.c
> +++ b/libselinux/src/context.c
> @@ -149,19 +149,18 @@ static int set_comp(context_private_t * n, int idx,=
 const char *str)
>         char *t =3D NULL;
>         const char *p;
>         if (str) {
> -               t =3D (char *)malloc(strlen(str) + 1);
> -               if (!t) {
> -                       return -1;
> -               }
>                 for (p =3D str; *p; p++) {
>                         if (*p =3D=3D '\t' || *p =3D=3D '\n' || *p =3D=3D=
 '\r' ||
>                             ((*p =3D=3D ':' || *p =3D=3D ' ') && idx !=3D=
 COMP_RANGE)) {
> -                               free(t);
>                                 errno =3D EINVAL;
>                                 return -1;
>                         }
>                 }
> -               strcpy(t, str);
> +
> +               t =3D strdup(str);
> +               if (!t) {
> +                       return -1;
> +               }
>         }
>         conditional_free(&n->component[idx]);
>         n->component[idx] =3D t;
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index dd7b5d79..766ea4b7 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -62,10 +62,9 @@ static int find_default_type(FILE * fp, const char *ro=
le, char **type)
>                 return -1;
>         }
>
> -       t =3D malloc(strlen(buf) - len);
> +       t =3D strndup(ptr, strlen(buf) - len - 1);
>         if (!t)
>                 return -1;
> -       strcpy(t, ptr);
>         *type =3D t;
>         return 0;
>  }
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index ea78a23e..bf2da083 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -215,10 +215,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>                         if (ret < 0 || sb.st_ino !=3D ino) {
>                                 fl->specind =3D specind;
>                                 free(fl->file);
> -                               fl->file =3D malloc(strlen(file) + 1);
> +                               fl->file =3D strdup(file);
>                                 if (!fl->file)
>                                         goto oom;
> -                               strcpy(fl->file, file);
>                                 return fl->specind;
>
>                         }
> @@ -232,10 +231,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>                              __FUNCTION__, file, fl->file,
>                              con_array[fl->specind]);
>                         free(fl->file);
> -                       fl->file =3D malloc(strlen(file) + 1);
> +                       fl->file =3D strdup(file);
>                         if (!fl->file)
>                                 goto oom;
> -                       strcpy(fl->file, file);
>                         return fl->specind;
>                 }
>
> @@ -248,10 +246,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>                 goto oom;
>         fl->ino =3D ino;
>         fl->specind =3D specind;
> -       fl->file =3D malloc(strlen(file) + 1);
> +       fl->file =3D strdup(file);
>         if (!fl->file)
>                 goto oom_freefl;
> -       strcpy(fl->file, file);
>         fl->next =3D prevfl->next;
>         prevfl->next =3D fl;
>         return fl->specind;
> diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/ut=
ils/selabel_lookup_best_match.c
> index a4af0679..e816c04b 100644
> --- a/libselinux/utils/selabel_lookup_best_match.c
> +++ b/libselinux/utils/selabel_lookup_best_match.c
> @@ -30,7 +30,7 @@ static __attribute__ ((__noreturn__)) void usage(const =
char *progname)
>         exit(1);
>  }
>
> -static mode_t string_to_mode(char *s)
> +static mode_t string_to_mode(const char *s)
>  {
>         switch (s[0]) {
>         case 'b':
> @@ -53,7 +53,7 @@ static mode_t string_to_mode(char *s)
>
>  int main(int argc, char **argv)
>  {
> -       int raw =3D 0, mode =3D 0, rc, opt, i, num_links, string_len;
> +       int raw =3D 0, mode =3D 0, rc, opt, i, num_links;
>         char *validate =3D NULL, *path =3D NULL, *context =3D NULL, *file=
 =3D NULL;
>         char **links =3D NULL;
>
> @@ -101,13 +101,11 @@ int main(int argc, char **argv)
>                 }
>
>                 for (i =3D optind, num_links =3D 0; i < argc; i++, num_li=
nks++) {
> -                       string_len =3D strlen(argv[i]) + 1;
> -                       links[num_links] =3D malloc(string_len);
> +                       links[num_links] =3D strdup(argv[i]);
>                         if (!links[num_links]) {
> -                               fprintf(stderr, "ERROR: malloc failed.\n"=
);
> +                               fprintf(stderr, "ERROR: strdup failed.\n"=
);
>                                 exit(1);
>                         }
> -                       strcpy(links[num_links], argv[i]);
>                 }
>         }
>
> --
> 2.38.1
>
