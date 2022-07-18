Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E6C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiGRUqT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRUqS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:46:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792B7669
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:46:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so10238849otk.0
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnbzpVAbs8gNs5Pk89QKSxl3pRwdFO6orB08hGbl57I=;
        b=hUdOZ2V1u15p4fNXEsDwB8uGkr03oFPRLR9iYt+D3iKB4Xm1AX7QnA8/Ed5r80MRA4
         uEM4nWdlSHxZIwYlvHQbB8Q3nTyd2/7GIWJPwqHMFtiRvh1ujDHxNrOyp16SlGXL0fPp
         l2cX4epjGRkmlbhXFfVjXIpmcyFhwTyJ5Kg2W3mzHWdvEYZuobWnFH9+BgX52xrx5T40
         xG+QFkmMi2+/vAnyWBfQ7PG6uWuGcmlTTniGmDRIIV/yqbctkGY0IVfDVZ6uIZT6z6Kl
         0biKzD1FHa7s1l7y7wvuU/Im/8IFaF04dfnwbwnFFp+FtbEWts0X4boEkeJBe5mS/Eni
         WvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnbzpVAbs8gNs5Pk89QKSxl3pRwdFO6orB08hGbl57I=;
        b=t6LHKUI0o5R0RxzDCK6n4f3XHWq7VWdVMkg0Qx3ktrEgxfWbonzVaia0vA+4G3dWJ+
         7DcXR6tdnOlG0e+iQLFlq1H6zb7WkVKU2Z6k3GH8/jZH2s9h/4rN4pZIrBmgOjrJHUmA
         HMkPb+Su3YGhZvSdD29me6t5CaAb3J65fN9QofZGar3YKUDvLBrVwr3kHbs5mVRoj7NO
         Yd3ccD5Nq2p2lVrXGZsF1w7Msbc9CrXNtpHjug9oHT4gFxpzjKDoiQ+AZ60ytkqrfzom
         /ngPgBdBltPOAG6yVJ49oAejas1W+BKCh8YaIeIolMUutpF/X9FQoIqOUdQ4JfnV2gni
         iRZw==
X-Gm-Message-State: AJIora99JtgAkF5TyEcY51QYkiNMy+wfUz8mpe9V9uQvD92bJc+vstAf
        I7Olw8rM1Z00s6aWnZq+4RWggK1SANNsDwAhEKzu6dRDHLo=
X-Google-Smtp-Source: AGRyM1tYN5cn9s58z4u/vlwZwKsICnA3aneYjeiRuZ9it0Xhr1mxkChuHrIjiod92KJk/rxeedTtmodLyGcZz7Lr63Y=
X-Received: by 2002:a05:6830:91d:b0:616:e98c:2581 with SMTP id
 v29-20020a056830091d00b00616e98c2581mr11733014ott.53.1658177177622; Mon, 18
 Jul 2022 13:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-4-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:46:06 -0400
Message-ID: <CAP+JOzRPbs2xTxfPOEQPEWnEFL7Uv0Fx14UwW=VL5U_vMiNGPw@mail.gmail.com>
Subject: Re: [PATCH 4/7] libsepol: optimize ebitmap_not
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 12, 2022 at 12:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Iterate on nodes instead of single bits to save node resolution for each
> single bit.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/ebitmap.c | 48 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index fb20e994..6a63e559 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -101,14 +101,50 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
>
>  int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit=
)
>  {
> -       unsigned int i;
> +       const ebitmap_node_t *n;
> +       ebitmap_node_t *new, *prev =3D NULL;
> +       uint32_t startbit, cur_startbit;
> +       MAPTYPE map;
> +
>         ebitmap_init(dst);
> -       for (i=3D0; i < maxbit; i++) {
> -               int val =3D ebitmap_get_bit(e1, i);
> -               int rc =3D ebitmap_set_bit(dst, i, !val);
> -               if (rc < 0)
> -                       return rc;
> +
> +       n =3D e1->node;
> +       for (cur_startbit =3D 0; cur_startbit < maxbit; cur_startbit +=3D=
 MAPSIZE) {
> +               if (n && n->startbit =3D=3D cur_startbit) {
> +                       startbit =3D n->startbit;
> +                       map =3D ~n->map;
> +
> +                       n =3D n->next;
> +               } else {
> +                       startbit =3D cur_startbit;
> +                       map =3D ~((MAPTYPE) 0);
> +               }
> +
> +               if (maxbit - cur_startbit < MAPSIZE)
> +                       map &=3D (((MAPTYPE)1) << (maxbit - cur_startbit)=
) - 1;
> +
> +               if (map !=3D 0) {
> +                       new =3D malloc(sizeof(ebitmap_node_t));
> +                       if (!new) {
> +                               ebitmap_destroy(dst);
> +                               return -ENOMEM;
> +                       }
> +
> +                       new->startbit =3D startbit;
> +                       new->map =3D map;
> +                       new->next =3D NULL;
> +
> +                       if (prev)
> +                               prev->next =3D new;
> +                       else
> +                               dst->node =3D new;
> +                       prev =3D new;
> +               }
>         }
> +
> +       if (prev)
> +               dst->highbit =3D prev->startbit + MAPSIZE;
> +
>         return 0;
>  }
>
> --
> 2.36.1
>
