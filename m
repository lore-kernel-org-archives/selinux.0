Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F7ECDB475
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 18:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjJKSsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjJKSsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 14:48:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457F90
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:48:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50337b43ee6so247215e87.3
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050126; x=1697654926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWH9Ut9e56tmjlhtYxqDarymrHEfdhur/qACkuLlbxc=;
        b=WiU16LJ8agqcdV+pyhU3IJfNlVFaeAtlrmfxDfCQlkO2baJAtJvxmLi7P5sqhqICf6
         r1xs7b10VGsKvrjfIMO8ozJjYYU38ZaSb7KQFRNIfOWf2ExmDNOpOJ5RKK8ZiZS/VCOo
         Mq37rIVdvoyaBywUfBWyN0Ejy/3yQ3yGkK5wBEHMgNLojT6rY7vImbRdv0Oj2057b04/
         J3exjymIpW0fl3/VUAuhgXhPIuxxJL1VF6uRe0QioeJcOh0nKNadLfOxa22YmqiAMd+Z
         64aieAFNTVdey6BCRDXotKqi1nkgCK9/g4/3sRlZlk7Sh5ts68YzTnBSe1q8UpDt5SNS
         yqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050126; x=1697654926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWH9Ut9e56tmjlhtYxqDarymrHEfdhur/qACkuLlbxc=;
        b=Mt3WbT0oAOfwmTx1fmOYOTlUiV1+ET9esbHWvGRZKh6SXf8143gIQK/2spvMXGYAu9
         HRTWQijNDxpvXElyLI4triEfY79tGx5IlAcOVfeoR+FxAoTLnxRIHD7B2Yi9FFAGXGzU
         x8mhvJ7fssig4xx31N8icguQVEyh6gXG4pVWRSDTZbYKRbid6jV/X1JxG9pbTSMjRNuZ
         Vg7gwrmdNBVIbiNqzZOdqw+6t6IAe46wv1yf3nwTWNXeTUepCaEb4vy7t6vSl6n7HQ7e
         xDjfEEtszZpzkTnb5zvWSFOdhDHz5i3Ldo2v8XyAsrSJ+3N5/ZhgyQVxTpD5TH86zAYq
         aDBA==
X-Gm-Message-State: AOJu0YwcGxJyLL1s5iTlTvlgGskHwaOZdI/Dp3QXko5F093Zg8H2T3F0
        bnAwkue6hTb2HqS2Q3uxdyBDfHGEAW+yANQf1EfKK53995s=
X-Google-Smtp-Source: AGHT+IG4770sM9YOpm54K1V9ugRKttSUOAN1BiXxYGUj8t8VzWveoOspm4JooKcjYZuhI4jqNAzSetGnlHznAUxzKsg=
X-Received: by 2002:a05:6512:304b:b0:500:9969:60bf with SMTP id
 b11-20020a056512304b00b00500996960bfmr20087161lfb.68.1697050125922; Wed, 11
 Oct 2023 11:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-21-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-21-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Oct 2023 14:48:34 -0400
Message-ID: <CAP+JOzR+5ukWPRBfs0QaNBcWZ3TNpKg1r60sUf-rLgsi60ZjCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/27] libselinux: check for stream rewind failures
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use fseek(3) instead of rewind(3) to detect failures.
>
> Drop the final rewind in digest_add_specfile(), since all callers are
> going to close the stream without any further action.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/is_customizable_type.c   |  7 ++++++-
>  libselinux/src/label_backends_android.c |  5 ++++-
>  libselinux/src/label_file.c             | 16 +++++++++++++---
>  libselinux/src/label_media.c            |  5 ++++-
>  libselinux/src/label_support.c          |  5 +++--
>  libselinux/src/label_x.c                |  5 ++++-
>  6 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_cu=
stomizable_type.c
> index f83e1e83..9be50174 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -31,7 +31,12 @@ static void customizable_init(void)
>         while (fgets_unlocked(buf, selinux_page_size, fp) && ctr < UINT_M=
AX) {
>                 ctr++;
>         }
> -       rewind(fp);
> +
> +       if (fseek(fp, 0L, SEEK_SET) =3D=3D -1) {
> +               fclose(fp);
> +               return;
> +       }
> +
>         if (ctr) {
>                 list =3D
>                     (char **) calloc(sizeof(char *),
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index c2d78360..6494f3cd 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -208,7 +208,10 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                                 goto finish;
>
>                         maxnspec =3D data->nspec;
> -                       rewind(fp);
> +
> +                       status =3D fseek(fp, 0L, SEEK_SET);
> +                       if (status =3D=3D -1)
> +                               goto finish;
>                 }
>         }
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 471fd56b..a5677411 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -519,12 +519,16 @@ static char *rolling_append(char *current, const ch=
ar *suffix, size_t max)
>         return current;
>  }
>
> -static bool fcontext_is_binary(FILE *fp)
> +static int fcontext_is_binary(FILE *fp)
>  {
>         uint32_t magic;
> +       int rc;
>
>         size_t len =3D fread(&magic, sizeof(magic), 1, fp);
> -       rewind(fp);
> +
> +       rc =3D fseek(fp, 0L, SEEK_SET);
> +       if (rc =3D=3D -1)
> +               return -1;
>
>         return (len && (magic =3D=3D SELINUX_MAGIC_COMPILED_FCONTEXT));
>  }
> @@ -622,7 +626,13 @@ static int process_file(const char *path, const char=
 *suffix,
>                 if (fp =3D=3D NULL)
>                         return -1;
>
> -               rc =3D fcontext_is_binary(fp) ?
> +               rc =3D fcontext_is_binary(fp);
> +               if (rc < 0) {
> +                       (void) fclose(fp);
> +                       return -1;
> +               }
> +
> +               rc =3D rc ?
>                                 load_mmap(fp, sb.st_size, rec, found_path=
) :
>                                 process_text_file(fp, rec, found_path);
>                 if (!rc)
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index f09461ab..b3443b47 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -130,7 +130,10 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                                 goto finish;
>                         memset(data->spec_arr, 0, sizeof(spec_t)*data->ns=
pec);
>                         maxnspec =3D data->nspec;
> -                       rewind(fp);
> +
> +                       status =3D fseek(fp, 0L, SEEK_SET);
> +                       if (status =3D=3D -1)
> +                               goto finish;
>                 }
>         }
>         free(line_buf);
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 94fb6697..f7ab9292 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -174,12 +174,13 @@ int  digest_add_specfile(struct selabel_digest *dig=
est, FILE *fp,
>         digest->hashbuf =3D tmp_buf;
>
>         if (fp) {
> -               rewind(fp);
> +               if (fseek(fp, 0L, SEEK_SET) =3D=3D -1)
> +                       return -1;
> +
>                 if (fread(digest->hashbuf + (digest->hashbuf_size - buf_l=
en),
>                                             1, buf_len, fp) !=3D buf_len)
>                         return -1;
>
> -               rewind(fp);
>         } else if (from_addr) {
>                 tmp_buf =3D memcpy(digest->hashbuf +
>                                     (digest->hashbuf_size - buf_len),
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index e80bf107..e15190ca 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -157,7 +157,10 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                                 goto finish;
>                         memset(data->spec_arr, 0, sizeof(spec_t)*data->ns=
pec);
>                         maxnspec =3D data->nspec;
> -                       rewind(fp);
> +
> +                       status =3D fseek(fp, 0L, SEEK_SET);
> +                       if (status =3D=3D -1)
> +                               goto finish;
>                 }
>         }
>         free(line_buf);
> --
> 2.40.1
>
