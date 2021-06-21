Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA6C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AE761245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUVB7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVB7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:01:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C7C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:59:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w127so21414611oig.12
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sWPslvKg712eMrCjeAueNa7WO/EzfdoWjKxSzDAv5y8=;
        b=ZznqPTvKEkDXZBaTPajD8S/SFSswqJw6ekAccKh1vw22U62X4/w4ahfDbHZ6xsk5/Z
         dSsLXdyxmYbVMQst3yOvs4liafSkIW86tiVjOMHuZCvlXjBGgGJjOyXfZ8xMtL3JvxUN
         PzJ2cWC8uOjU0ZzwtCAwh536RoHYpI4/LwEtZOxr7pkqSviDGtbDEqI9H62EK/N8bDrP
         9CEqcl0YchH/JcNWIOGZaO4+7FDimM/qoso9FhjzARgRJJpqsSMdqsFjJb9pbNADk62F
         Cr5AE3/+qxHxeXOXa3DiEXKHj14gFlmsfddB0F4QM+mCthQl/tbc5BjeyBJjfIrUf2zw
         oLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sWPslvKg712eMrCjeAueNa7WO/EzfdoWjKxSzDAv5y8=;
        b=omuPaTI5KbaPxiigTp2VhRdAXMUYlVl2muuI9rlA0+gE5QE4Ldt5WHAXBijfA5Bslj
         dNcA1qWFSkf3eqYxuQlpqZGAU3GqqfMLeyeLO4JNJvRykvU86LvCzXZ9pu8JXKc5wbUB
         svefwfXo5w5XodOI8SRui/ihk1yFegUCVF8Ovw4FnGxioGm37z3pR9xDPepOw8PQaz1x
         NCB7KgjzwBK5W38vEy2ZXEwBez6ZDYQPFoEyc3nnd7H78zxgFlzRLqj2lXisH4vZYfE8
         eCkCiwcxDmPE20J/C0V1MZFGckgKzdKSPR9sQDU12gJ8o2Ezgkf56rqK+Lymn2mAcjrs
         ifoQ==
X-Gm-Message-State: AOAM5311TIKgyMf7e9/X1C/yEKHMRwVFmp/w+x4wTMcCNXhi2paV0Dr4
        v+c9TGJftMRmwneuagCeq/pIDQmmT23+1AudRh4=
X-Google-Smtp-Source: ABdhPJwVthlfuBvY/nMa6tlqec/iMCpCkzsiYRGpVXk9MJZuz+aXL7t3ilYzESf2vIrqJFz/4kDE1QkaZJpTDcSjKEY=
X-Received: by 2002:aca:30d1:: with SMTP id w200mr460991oiw.16.1624309183999;
 Mon, 21 Jun 2021 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-13-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-13-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:59:32 -0400
Message-ID: <CAP+JOzSxAfFHu30tX9V1r+v6L01y0yvmeeh0OgQ5wRh3kmq3sg@mail.gmail.com>
Subject: Re: [PATCH 12/23] libsepol: do not allocate memory of size 0
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case cats_ebitmap_len() returns 0, do not allocate but quit.
>
> Found by clang-analyzer
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c  | 5 ++++-
>  libsepol/src/kernel_to_conf.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 989aacde..17b5ebf0 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1034,11 +1034,14 @@ static char *cats_ebitmap_to_str(struct ebitmap *=
cats, char **val_to_name)
>  {
>         struct ebitmap_node *node;
>         uint32_t i, start, range;
> -       char *catsbuf, *p;
> +       char *catsbuf =3D NULL, *p;
>         const char *fmt;
>         int len, remaining;
>
>         remaining =3D (int)cats_ebitmap_len(cats, val_to_name);
> +       if (remaining =3D=3D 0) {
> +               goto exit;
> +       }
>         catsbuf =3D malloc(remaining);
>         if (!catsbuf) {
>                 goto exit;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 5db47fe4..c1253820 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1025,12 +1025,15 @@ static char *cats_ebitmap_to_str(struct ebitmap *=
cats, char **val_to_name)
>  {
>         struct ebitmap_node *node;
>         uint32_t i, start, range, first;
> -       char *catsbuf, *p;
> +       char *catsbuf =3D NULL, *p;
>         const char *fmt;
>         char sep;
>         int len, remaining;
>
>         remaining =3D (int)cats_ebitmap_len(cats, val_to_name);
> +       if (remaining =3D=3D 0) {
> +               goto exit;
> +       }
>         catsbuf =3D malloc(remaining);
>         if (!catsbuf) {
>                 goto exit;
> --
> 2.32.0
>
