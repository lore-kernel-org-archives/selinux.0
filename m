Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CEC04A6A
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 20:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjHHUDs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjHHUDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 16:03:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C68C09E
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 11:21:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso92057611fa.3
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691518868; x=1692123668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP2FjwaN4IGcW4joBs+CLjau9Y+cdOLxKP3zGYTN5qY=;
        b=nwEma481bjR2dVkvmw3gYcM4OaJZHx6IRoMIB50ZvK8CLaD1WjC6AqxQyLU0mqavvt
         1ssXv6G89CZdtDO6QpA5oK9SSZ55ZiN/KnTLMGAHpbwAUdi8KqFbM4TNX5qVrHIlMSXK
         Oc1v2Na/0hLiK2IyvdcYGASsGDC7f6Tr1qHfkyF6SUhTzTYzo3NjJyakw1j3C2KzhlnI
         JNKvy1xw/+RDSNOWGYJpOl9ghhaWyZ9TmOvA3A99ZazeQ7I047iUYk9Ec+keF1GmNxsZ
         EI5SJvTq/IFde5IsdlrhiUavpZjnw8qbtaIwxuYe4I+rcHYd8MPg+NaODONqKJcKaJKh
         HAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518868; x=1692123668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP2FjwaN4IGcW4joBs+CLjau9Y+cdOLxKP3zGYTN5qY=;
        b=Wm3ySURzbbqZr0HGuKzHQKESvIPZtaFrnfW61EHnZfTp8tRoUVo0ozzKo/cAUV3YOt
         cdwkuSUGWc+vdYtlwrwA8qAbStOwh3YiSqXaHb1uB60jnu1SR6B+M+fEoAeZ0lzct4Lw
         LyhQdxJ2Lwi1Xq3v70iFMjvDcZmHg8OL4cMOOQnFkxzdiezMnyBgVa8QPNUMexpxjXyp
         oshgOwISKSLAN2UCRqnn3py8FBORGb5MeyOxc3Hpbx8DTflUvzd9eFPdTjNXmrKTWE2D
         HRZ+6EiYXtEz/vjlUES4flTI+XtxXNcfL9OEpOyHu4y3ARZoCM3MAgP85otThgPmhTjX
         gO5w==
X-Gm-Message-State: AOJu0YyOyoqSHJPXKLPRpsIBtRzt5ZR28BbTT6c1brqF1nxSuWD8Suxv
        LN1qaaX5lxq3DX0LTaK1VgHDGAAxlgFE29zxNz52P3B29k8=
X-Google-Smtp-Source: AGHT+IHzd72MXRBUxxu0kGsv897AldAmF82BtYlpnQ8tHDWZm9juAjsfUZUdG08vO7RwYdA5t7BPvhrRtRP5xD4HUx0=
X-Received: by 2002:a2e:83cd:0:b0:2b4:75f0:b9e9 with SMTP id
 s13-20020a2e83cd000000b002b475f0b9e9mr211628ljh.10.1691518868206; Tue, 08 Aug
 2023 11:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230803162245.302488-1-cgzones@googlemail.com>
In-Reply-To: <20230803162245.302488-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Aug 2023 14:20:56 -0400
Message-ID: <CAP+JOzSxiGJ2vWC2CHZgKcRXUC0x=LP3OrEHt9O4tLptd1im+A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: ebitmap: avoid branches for iteration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 3, 2023 at 12:36=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Otherwise Linus might think we don't understand pointers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/ebitmap.c | 83 +++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 46 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 3ec1042f..f166b7d6 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -18,13 +18,13 @@
>  int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * =
e2)
>  {
>         const ebitmap_node_t *n1, *n2;
> -       ebitmap_node_t *new, *prev;
> +       ebitmap_node_t *new =3D NULL, **prev;
>
>         ebitmap_init(dst);
>
> +       prev =3D &dst->node;
>         n1 =3D e1->node;
>         n2 =3D e2->node;
> -       prev =3D 0;
>         while (n1 || n2) {
>                 new =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t))=
;
>                 if (!new) {
> @@ -46,12 +46,10 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1,=
 const ebitmap_t * e2)
>                         n2 =3D n2->next;
>                 }
>
> -               new->next =3D 0;
> -               if (prev)
> -                       prev->next =3D new;
> -               else
> -                       dst->node =3D new;
> -               prev =3D new;
> +               new->next =3D NULL;
> +
> +               *prev =3D new;
> +               prev =3D &new->next;
>         }
>
>         dst->highbit =3D (e1->highbit > e2->highbit) ? e1->highbit : e2->=
highbit;
> @@ -74,10 +72,11 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * =
e1)
>  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
>         const ebitmap_node_t *n1, *n2;
> -       ebitmap_node_t *new, *prev =3D NULL;
> +       ebitmap_node_t *new =3D NULL, **prev;
>
>         ebitmap_init(dst);
>
> +       prev =3D &dst->node;
>         n1 =3D e1->node;
>         n2 =3D e2->node;
>         while (n1 && n2) {
> @@ -92,11 +91,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, c=
onst ebitmap_t *e2)
>                                 new->map =3D n1->map & n2->map;
>                                 new->next =3D NULL;
>
> -                               if (prev)
> -                                       prev->next =3D new;
> -                               else
> -                                       dst->node =3D new;
> -                               prev =3D new;
> +                               *prev =3D new;
> +                               prev =3D &new->next;
>                         }
>
>                         n1 =3D n1->next;
> @@ -108,8 +104,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, =
const ebitmap_t *e2)
>                 }
>         }
>
> -       if (prev)
> -               dst->highbit =3D prev->startbit + MAPSIZE;
> +       if (new)
> +               dst->highbit =3D new->startbit + MAPSIZE;
>
>         return 0;
>  }
> @@ -117,12 +113,13 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
>  int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
>         const ebitmap_node_t *n1, *n2;
> -       ebitmap_node_t *new, *prev =3D NULL;
> +       ebitmap_node_t *new =3D NULL, **prev;
>         uint32_t startbit;
>         MAPTYPE map;
>
>         ebitmap_init(dst);
>
> +       prev =3D &dst->node;
>         n1 =3D e1->node;
>         n2 =3D e2->node;
>         while (n1 || n2) {
> @@ -150,16 +147,14 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
>                         new->startbit =3D startbit;
>                         new->map =3D map;
>                         new->next =3D NULL;
> -                       if (prev)
> -                               prev->next =3D new;
> -                       else
> -                               dst->node =3D new;
> -                       prev =3D new;
> +
> +                       *prev =3D new;
> +                       prev =3D &new->next;
>                 }
>         }
>
> -       if (prev)
> -               dst->highbit =3D prev->startbit + MAPSIZE;
> +       if (new)
> +               dst->highbit =3D new->startbit + MAPSIZE;
>
>         return 0;
>  }
> @@ -167,12 +162,13 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
>  int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit=
)
>  {
>         const ebitmap_node_t *n;
> -       ebitmap_node_t *new, *prev =3D NULL;
> +       ebitmap_node_t *new =3D NULL, **prev;
>         uint32_t startbit, cur_startbit;
>         MAPTYPE map;
>
>         ebitmap_init(dst);
>
> +       prev =3D &dst->node;
>         n =3D e1->node;
>         for (cur_startbit =3D 0; cur_startbit < maxbit; cur_startbit +=3D=
 MAPSIZE) {
>                 if (n && n->startbit =3D=3D cur_startbit) {
> @@ -199,16 +195,13 @@ int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1=
, unsigned int maxbit)
>                         new->map =3D map;
>                         new->next =3D NULL;
>
> -                       if (prev)
> -                               prev->next =3D new;
> -                       else
> -                               dst->node =3D new;
> -                       prev =3D new;
> +                       *prev =3D new;
> +                       prev =3D &new->next;
>                 }
>         }
>
> -       if (prev)
> -               dst->highbit =3D prev->startbit + MAPSIZE;
> +       if (new)
> +               dst->highbit =3D new->startbit + MAPSIZE;
>
>         return 0;
>  }
> @@ -278,11 +271,11 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitmap=
_t * e2)
>  int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
>  {
>         const ebitmap_node_t *n;
> -       ebitmap_node_t *new, *prev;
> +       ebitmap_node_t *new =3D NULL, **prev;
>
>         ebitmap_init(dst);
>         n =3D src->node;
> -       prev =3D 0;
> +       prev =3D &dst->node;
>         while (n) {
>                 new =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t))=
;
>                 if (!new) {
> @@ -291,12 +284,11 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * =
src)
>                 }
>                 new->startbit =3D n->startbit;
>                 new->map =3D n->map;
> -               new->next =3D 0;
> -               if (prev)
> -                       prev->next =3D new;
> -               else
> -                       dst->node =3D new;
> -               prev =3D new;
> +               new->next =3D NULL;
> +
> +               *prev =3D new;
> +               prev =3D &new->next;
> +
>                 n =3D n->next;
>         }
>
> @@ -450,7 +442,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, =
int value)
>
>  int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned int =
maxbit)
>  {
> -       ebitmap_node_t *new, *prev =3D NULL;
> +       ebitmap_node_t *new =3D NULL, **prev;
>         uint32_t minstartbit =3D minbit & ~(MAPSIZE - 1);
>         uint32_t maxstartbit =3D maxbit & ~(MAPSIZE - 1);
>         uint32_t minhighbit =3D minstartbit + MAPSIZE;
> @@ -466,6 +458,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int mi=
nbit, unsigned int maxbit)
>         if (minhighbit =3D=3D 0 || maxhighbit =3D=3D 0)
>                 return -EOVERFLOW;
>
> +       prev =3D &e->node;
> +
>         for (startbit =3D minstartbit; startbit <=3D maxstartbit; startbi=
t +=3D MAPSIZE) {
>                 new =3D malloc(sizeof(ebitmap_node_t));
>                 if (!new)
> @@ -485,11 +479,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int m=
inbit, unsigned int maxbit)
>                         new->map =3D (mask << (minbit - startbit));
>                 }
>
> -               if (prev)
> -                       prev->next =3D new;
> -               else
> -                       e->node =3D new;
> -               prev =3D new;
> +               *prev =3D new;
> +               prev =3D &new->next;
>         }
>
>         e->highbit =3D maxhighbit;
> --
> 2.40.1
>
