Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F8C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiGRUsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRUs3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:48:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D530F5F
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:48:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k8-20020a9d4b88000000b0061c7f8c4f77so9261370otf.10
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wrgl/Z4tPeogDX8eRmcYNG3Ae24/UxBNqwoA4bjGWc=;
        b=QaGAaRgvLb/uAEWtddCpzz5S5E+46OcZs2OwZU4POx+N8FEhPODXMfv6aMVjw0fK8H
         q34Rzd7SZtRVJnJl3Rgi7fn6qbeCn2ARHY6i0Av1AuihDdl2MEdc+vzE5B68Cz6mg4VH
         m8F4FfyQjtgUYvZ7NwwLHCLRMVoftQizZpyfXBjgN4wYaWH4txHmnpuAhkHe4xfCFOdJ
         O0nFvDDOdSurJP6MLjkjxpK10tLTI2bPAQUbI+oDkzwgWtiwrGxRptb5SODysPpV9h+x
         ShaN4iBpYjKE+9Sljxkav+vfBVmSqZn6fHeK0ndYuLRrr88EsxThrlhkv+Lye/EtqgB3
         jleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wrgl/Z4tPeogDX8eRmcYNG3Ae24/UxBNqwoA4bjGWc=;
        b=ZWBmprQeJrVX/5k/CSv4zG1W0Bkvdndzj6+zp6Axin5oXWpXQ+zovZFkvFxmlWSbOV
         XDivL8kMWs5+6tjeuzIFTmk9DqYbF7GQh+ax7ciwrw/6kiehX9jXOOWGxptS/NNXzd9m
         NKGoU2yKyVF/0t+jo1V3yI4iB6T4It0LVLp/as46mMsZwJpaRMQO/uA7YuYVWkiQwGtM
         PJJ593NodXbxr5nsZV51WcCGOczZTdWgYCdk7GaP1Sk0YNSFcjWmdtCuwuJ38RS+QXIN
         omWmhqiVlmOg/MTGsh6ydPlxofpAGWixQVh2B8QB5oh9yVPtk3mNd7BC2oig52TIItoJ
         aswQ==
X-Gm-Message-State: AJIora/jL6ZNfWgN8jXHtVXcuEKu+xGVkStcd7di5UTzqix9MuOdtgQR
        1M5G3K3odu5/NGdlHt2w82HwaB7/vLfE70znjUSh87dlcY8=
X-Google-Smtp-Source: AGRyM1syyF6Dc+A1zh7Ur0OX3HID1U/mpUquQ1uoYWvaEzMiFOXeawK9/IAYJ294fLl/E5m4xqEPHw4g6F90+8kmbPw=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr12322921otb.154.1658177307783; Mon, 18
 Jul 2022 13:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-6-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-6-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:48:17 -0400
Message-ID: <CAP+JOzRJQE9nxpr94EYqXObP-2zPD3Rm3MC6pt=F_xYAXD=48Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] libsepol: optimize ebitmap_xor
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
>  libsepol/src/ebitmap.c | 49 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index c3d706e9..e0541abb 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -116,14 +116,51 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
>
>  int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
> -       unsigned int i, length =3D max(ebitmap_length(e1), ebitmap_length=
(e2));
> +       const ebitmap_node_t *n1, *n2;
> +       ebitmap_node_t *new, *prev =3D NULL;
> +       uint32_t startbit;
> +       MAPTYPE map;
> +
>         ebitmap_init(dst);
> -       for (i=3D0; i < length; i++) {
> -               int val =3D ebitmap_get_bit(e1, i) ^ ebitmap_get_bit(e2, =
i);
> -               int rc =3D ebitmap_set_bit(dst, i, val);
> -               if (rc < 0)
> -                       return rc;
> +
> +       n1 =3D e1->node;
> +       n2 =3D e2->node;
> +       while (n1 || n2) {
> +               if (n1 && n2 && n1->startbit =3D=3D n2->startbit) {
> +                       startbit =3D n1->startbit;
> +                       map =3D n1->map ^ n2->map;
> +                       n1 =3D n1->next;
> +                       n2 =3D n2->next;
> +               } else if (!n2 || (n1 && n1->startbit < n2->startbit)) {
> +                       startbit =3D n1->startbit;
> +                       map =3D n1->map;
> +                       n1 =3D n1->next;
> +               } else {
> +                       startbit =3D n2->startbit;
> +                       map =3D n2->map;
> +                       n2 =3D n2->next;
> +               }
> +
> +               if (map !=3D 0) {
> +                       new =3D malloc(sizeof(ebitmap_node_t));
> +                       if (!new) {
> +                               ebitmap_destroy(dst);
> +                               return -ENOMEM;
> +                       }
> +                       new->startbit =3D startbit;
> +                       new->map =3D map;
> +                       new->next =3D NULL;
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
