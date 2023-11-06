Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5A0C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 14:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFOdq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOdq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 09:33:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA194
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 06:33:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso6466448e87.2
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699281221; x=1699886021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJZo9YKqhfmhI/TwMX4StaaUJZXAdX5BxZiRawAVs8w=;
        b=Fbm/Mw997WwWYa2vuTH8cYVUWLhnN9baWbGwwuMSXiucAve65ymJQKMzfu88nUtOgG
         AT8XJLcRW/+hZrdmmdtIDHXPmZbJVmM3OY+xV+NAyzGJKB9NR8KjVaH+cI67oQItdCC6
         n+JwevTJFrRr0Trf8dWXBKA18RuJgOsohS26lqn+oRUXzc7cTuZF+OGBZ4cmvMF9qXng
         P+WqNf3MxI7sEmc6Ir9nVvhOi+KHL1Wte0WXqxo5u/7Abm8n7a7CfXv49VGO4oZ7KhLJ
         5oIk+eKqALG3YJhMq1W2Pi/sgAqAV5jG6cpIYcLTslz8FBVRiJH9KNilj4kTWVJWzUZn
         AJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281221; x=1699886021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJZo9YKqhfmhI/TwMX4StaaUJZXAdX5BxZiRawAVs8w=;
        b=pgFnLQzLLreLcAT22J/mI/DDCpsk0nYjhOlV2lHmCH+oxeJ3S8nf8btgtJzv++OasN
         a14aoPJbSPRpqpo4KG2wh6qyZ+Z4aBnJk4L2m/tffZVM8AEDX0haok7AATqX3TwubwTe
         D2ZjYANt7rieDo0QouERLzKNLAMzGeKbT6NMAyqI2sAs0YPy8FWwuO+7ETH1NZF2+pQr
         k83ELy89EYFwHLqEWzX/KHyMX+0n48h7oPkkxM+Na6UgNTDFBdaxi1XU9LF3sTpXKm6l
         0Mdni5LV7JChj08c9NllvLyJ5wqPaNg4WMv/6W+Bb65tLnSik7Kc9+jlcCG/uz6DRL0d
         WWXQ==
X-Gm-Message-State: AOJu0YxF+Z+RKIyHTNohBayjNYKGyIzjHEl+1gf0U2PX/FUE8+Ia5Wbi
        4sOI/8Kk6Kmy/ww/f3ldsGb522fQtRZd7OsER43xzqI5vyg=
X-Google-Smtp-Source: AGHT+IHLrbMIadxw2KC4S568lzBHrF6WdL9h7rCz1+qzBdZYF31vrp11tsExVq+nbY4Nkg2ZLMITBl7oHm3rr328Lw4=
X-Received: by 2002:a05:6512:703:b0:506:926c:9b0d with SMTP id
 b3-20020a056512070300b00506926c9b0dmr19021624lfs.20.1699281221516; Mon, 06
 Nov 2023 06:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20231103182637.85003-1-cgzones@googlemail.com> <20231103182637.85003-2-cgzones@googlemail.com>
In-Reply-To: <20231103182637.85003-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 09:33:30 -0500
Message-ID: <CAP+JOzRCKrLqcKdZ=ZXgYNhCFVvi8FZ3+d_Y6a7nJMiY=g2Egw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libsepol: validate constraint depth
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure constraint expressions are complete and do not exceed the
> supported depth limit.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 810c3263..b20ed579 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -228,6 +228,7 @@ bad:
>  static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, const constraint_node_t *cons, validate_t flavors[])
>  {
>         const constraint_expr_t *cexp;
> +       int depth;
>
>         for (; cons; cons =3D cons->next) {
>                 if (nperms =3D=3D 0 && cons->permissions !=3D 0)
> @@ -240,8 +241,14 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                 if (!cons->expr)
>                         goto bad;
>
> +               depth =3D -1;
> +
>                 for (cexp =3D cons->expr; cexp; cexp =3D cexp->next) {
>                         if (cexp->expr_type =3D=3D CEXPR_NAMES) {
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))
> +                                       goto bad;
> +                               depth++;
> +
>                                 if (cexp->attr & CEXPR_XTARGET && nperms =
!=3D 0)
>                                         goto bad;
>                                 if (!(cexp->attr & CEXPR_TYPE)) {
> @@ -282,6 +289,10 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                                         goto bad;
>                                 }
>                         } else if (cexp->expr_type =3D=3D CEXPR_ATTR) {
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))
> +                                       goto bad;
> +                               depth++;
> +
>                                 if (!ebitmap_is_empty(&cexp->names))
>                                         goto bad;
>                                 if (validate_empty_type_set(cexp->type_na=
mes))
> @@ -318,8 +329,14 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                         } else {
>                                 switch (cexp->expr_type) {
>                                 case CEXPR_NOT:
> +                                       if (depth < 0)
> +                                               goto bad;
> +                                       break;
>                                 case CEXPR_AND:
>                                 case CEXPR_OR:
> +                                       if (depth < 1)
> +                                               goto bad;
> +                                       depth--;
>                                         break;
>                                 default:
>                                         goto bad;
> @@ -335,6 +352,9 @@ static int validate_constraint_nodes(sepol_handle_t *=
handle, unsigned int nperms
>                                         goto bad;
>                         }
>                 }
> +
> +               if (depth !=3D 0)
> +                       goto bad;
>         }
>
>         return 0;
> --
> 2.42.0
>
