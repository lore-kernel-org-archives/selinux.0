Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F6E75451
	for <selinux@archiver.kernel.org>; Thu,  5 Oct 2023 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjJEQPr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjJEQOH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Oct 2023 12:14:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B92C2B0
        for <selinux@vger.kernel.org>; Thu,  5 Oct 2023 08:39:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c27d653856so27412221fa.0
        for <selinux@vger.kernel.org>; Thu, 05 Oct 2023 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696520352; x=1697125152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db0qrcCqp45pBCdm9QmoOEYJzulgp+dSszthQ3kvmmw=;
        b=OeW2yQMOwvKU+QFWZTl1pM1B1/DUQtInCY/Avmo5+pBvB7Wg2jIOTw/wh9AftQv7kf
         x/68qWcWffPadXDgrEAbH1KEmWlpl/AukXfo0OhCcYENg4uUxJpVU2RIXOQVV67NHiCJ
         x13+GOyAeUDwKOpWOKyazmNLDWkPt0dpWxWfK99kAToTbukBpwOP/KEfj/7WAYvkY5NC
         aFgkLuRIRN+7Mvq2R1ftterBmZc6GtUHIyzqktvbgEo7BhuEYrPJ4mqApxV0t8TqxqfQ
         mt+Ojk7i5+psUL8NrrBJfOn+xgNOUA/Q43NyNtCgO9RoDsiiIC502HgzVNfhCfavW7+Z
         StXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520352; x=1697125152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db0qrcCqp45pBCdm9QmoOEYJzulgp+dSszthQ3kvmmw=;
        b=fByoeUj8MlN2PskVZpNu3ZEiIxcDIfvDurXdrxUhaCCaRJUjTVycsm90TXQtjLQTXu
         1oTpc1OWztORgqsyChMy5BEL77P1dNOcxbcDBwk5OrmYlL6gzdw4p6QJ2hiI2EhpWQTt
         xd33x0apxL2MehBXXsBJRPWzLKC/kRGo4PB6ryCoOlZhngf4NPR+0V7hnNBIVOnBMM/n
         t1ngfLCAncBzzoC6CRuB946R4/jQUXZkU1qJnzwu7akst8/fD0G2uys41EJwSwxUvfJf
         ix/4hElnQUkh1VLUGM//dHLA9PyRUgwa84OAtv+yw2Yo55KHgSKDampwkIxpwjBq3eT1
         7L0Q==
X-Gm-Message-State: AOJu0YzaiDs1HHqEbwjtMLI/1VHDKUnoygB8dZXXYWmmD+MkCzStlLfo
        0oYNsdmfl3RtY8Ljfro9tm5x1GRzNDEf9sZPfYohvfjR3CA=
X-Google-Smtp-Source: AGHT+IGu1GcaiGrFn9RO5nRCgpD9L434o8SCO5gFpqlljbDato8rOxIfnCfjb7jRoCmS44XegglM96QdlT+YRUOLXtg=
X-Received: by 2002:ac2:5045:0:b0:505:728d:b48c with SMTP id
 a5-20020ac25045000000b00505728db48cmr2228790lfm.19.1696520352167; Thu, 05 Oct
 2023 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-15-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-15-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 5 Oct 2023 11:39:01 -0400
Message-ID: <CAP+JOzTHu896bZchA6PR97DTXTQmOF2b0Nb7aOJW_DG-LisyfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/27] libselinux: parameter simplifications
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
> Use bool where applicable.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index c0f586a2..9a972f79 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -137,9 +137,9 @@ out:
>  }
>
>  /* Public API helpers */
> -static int selabel_fini(struct selabel_handle *rec,
> +static int selabel_fini(const struct selabel_handle *rec,
>                             struct selabel_lookup_rec *lr,
> -                           int translating)
> +                           bool translating)
>  {
>         if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
>                 return -1;
> @@ -152,7 +152,7 @@ static int selabel_fini(struct selabel_handle *rec,
>  }
>
>  static struct selabel_lookup_rec *
> -selabel_lookup_common(struct selabel_handle *rec, int translating,
> +selabel_lookup_common(struct selabel_handle *rec, bool translating,
>                       const char *key, int type)
>  {
>         struct selabel_lookup_rec *lr;
> @@ -173,7 +173,7 @@ selabel_lookup_common(struct selabel_handle *rec, int=
 translating,
>  }
>
>  static struct selabel_lookup_rec *
> -selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
> +selabel_lookup_bm_common(struct selabel_handle *rec, bool translating,
>                       const char *key, int type, const char **aliases)
>  {
>         struct selabel_lookup_rec *lr;
> @@ -239,7 +239,7 @@ int selabel_lookup(struct selabel_handle *rec, char *=
*con,
>  {
>         struct selabel_lookup_rec *lr;
>
> -       lr =3D selabel_lookup_common(rec, 1, key, type);
> +       lr =3D selabel_lookup_common(rec, true, key, type);
>         if (!lr)
>                 return -1;
>
> @@ -252,7 +252,7 @@ int selabel_lookup_raw(struct selabel_handle *rec, ch=
ar **con,
>  {
>         struct selabel_lookup_rec *lr;
>
> -       lr =3D selabel_lookup_common(rec, 0, key, type);
> +       lr =3D selabel_lookup_common(rec, false, key, type);
>         if (!lr)
>                 return -1;
>
> @@ -307,7 +307,7 @@ int selabel_lookup_best_match(struct selabel_handle *=
rec, char **con,
>                 return -1;
>         }
>
> -       lr =3D selabel_lookup_bm_common(rec, 1, key, type, aliases);
> +       lr =3D selabel_lookup_bm_common(rec, true, key, type, aliases);
>         if (!lr)
>                 return -1;
>
> @@ -325,7 +325,7 @@ int selabel_lookup_best_match_raw(struct selabel_hand=
le *rec, char **con,
>                 return -1;
>         }
>
> -       lr =3D selabel_lookup_bm_common(rec, 0, key, type, aliases);
> +       lr =3D selabel_lookup_bm_common(rec, false, key, type, aliases);
>         if (!lr)
>                 return -1;
>
> --
> 2.40.1
>
