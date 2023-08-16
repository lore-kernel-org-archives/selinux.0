Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B9C001E0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjHPRiT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbjHPRh5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:37:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC73270D
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:37:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso106310181fa.1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207474; x=1692812274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFvtyjrOEyVb16bl2BjhJSausGUe31/ifsfR5hQ+qAk=;
        b=sWFVOXoK2ZV+0TeFOzOcqPJxIb/y6btMd/5hasapUbXG7xDI1zY5lBYDY0dPnjVlOE
         eh6fqWrpJ5b292kZuwEfkRFu74vYJqeoZqNomPQlhws0dxulIFPrbZjD9E1tm29rPL1A
         PvOH8zBTZVQAog98UuMauuad4eiNb+/J674vr6khA1xJMeO3EVWTR5Mv9OVMfqUyw/LI
         puHrxDzqUmX1ySnI+Uax+6lb0eAhnPj2/s3k98r+a3h6M9Kz/p6kwm0+1UhMVP3XGA6i
         vp6Nce9s6cN+Q9dUWvIixycGFT4uaRcZECUPRkTwNIXaAtkmJyJaeB+NdJulbQ1TkEHy
         3igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207474; x=1692812274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFvtyjrOEyVb16bl2BjhJSausGUe31/ifsfR5hQ+qAk=;
        b=WSI1iXsNSmKqR1XsgporY9CMwin1CcimITtlbZvqjlxArQZXHELbXrefwl+HnzgPlC
         Q7e2g1hZAexq4x6u1g3qlxvn7TxUj91KqUXrqI8y3sXNdysy9PCNMI5WJpibMMg+wtoN
         M3ffjq2UMjlD8jsdqTJXHbBvY/2y83feu/FJUZTAqU2xImBQW7kkwYYr8ahxWCgaSQhU
         +4u40Of9pT5A8sPx1Quf6X6crBhZmEndD6Vii9LnqZzQB/et8bEl8gtyIO49qKW2wMct
         OzvkHbVcVXRtepWSty/rYrUU+K84tWKgPh46To0JP/mDVGMQj00rrKchAkUYm60kQoy+
         oXEQ==
X-Gm-Message-State: AOJu0Yxf4/NamS1bsTinTKAkw+W82PDfUnGnx8ovfg/uLlwKuMGTaHNs
        nnwXh4u1dXJdsiZJLm+G+qd5TkKGCa+LfrFiKiLq/aPm
X-Google-Smtp-Source: AGHT+IFQFUnh8ERBoQryoWbm3K2lVTYbMvVLA2DBE/8pvJzzlgFqesyiSjRrnR++ypSWAGLgL/1qQ0dsAKeOdquiLrE=
X-Received: by 2002:a2e:9d45:0:b0:2bb:8bc1:db55 with SMTP id
 y5-20020a2e9d45000000b002bb8bc1db55mr1993518ljj.52.1692207473853; Wed, 16 Aug
 2023 10:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230803162245.302488-1-cgzones@googlemail.com> <CAP+JOzSxiGJ2vWC2CHZgKcRXUC0x=LP3OrEHt9O4tLptd1im+A@mail.gmail.com>
In-Reply-To: <CAP+JOzSxiGJ2vWC2CHZgKcRXUC0x=LP3OrEHt9O4tLptd1im+A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 13:37:42 -0400
Message-ID: <CAP+JOzQdv_6Cp=UO5fs2k9kZ9k5xO5=pgj5aO7cMS8R1rX4aZA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: ebitmap: avoid branches for iteration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 8, 2023 at 2:20=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, Aug 3, 2023 at 12:36=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Otherwise Linus might think we don't understand pointers.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/ebitmap.c | 83 +++++++++++++++++++-----------------------
> >  1 file changed, 37 insertions(+), 46 deletions(-)
> >
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index 3ec1042f..f166b7d6 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -18,13 +18,13 @@
> >  int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t =
* e2)
> >  {
> >         const ebitmap_node_t *n1, *n2;
> > -       ebitmap_node_t *new, *prev;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >
> >         ebitmap_init(dst);
> >
> > +       prev =3D &dst->node;
> >         n1 =3D e1->node;
> >         n2 =3D e2->node;
> > -       prev =3D 0;
> >         while (n1 || n2) {
> >                 new =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t=
));
> >                 if (!new) {
> > @@ -46,12 +46,10 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e=
1, const ebitmap_t * e2)
> >                         n2 =3D n2->next;
> >                 }
> >
> > -               new->next =3D 0;
> > -               if (prev)
> > -                       prev->next =3D new;
> > -               else
> > -                       dst->node =3D new;
> > -               prev =3D new;
> > +               new->next =3D NULL;
> > +
> > +               *prev =3D new;
> > +               prev =3D &new->next;
> >         }
> >
> >         dst->highbit =3D (e1->highbit > e2->highbit) ? e1->highbit : e2=
->highbit;
> > @@ -74,10 +72,11 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t =
* e1)
> >  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *=
e2)
> >  {
> >         const ebitmap_node_t *n1, *n2;
> > -       ebitmap_node_t *new, *prev =3D NULL;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >
> >         ebitmap_init(dst);
> >
> > +       prev =3D &dst->node;
> >         n1 =3D e1->node;
> >         n2 =3D e2->node;
> >         while (n1 && n2) {
> > @@ -92,11 +91,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1,=
 const ebitmap_t *e2)
> >                                 new->map =3D n1->map & n2->map;
> >                                 new->next =3D NULL;
> >
> > -                               if (prev)
> > -                                       prev->next =3D new;
> > -                               else
> > -                                       dst->node =3D new;
> > -                               prev =3D new;
> > +                               *prev =3D new;
> > +                               prev =3D &new->next;
> >                         }
> >
> >                         n1 =3D n1->next;
> > @@ -108,8 +104,8 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1=
, const ebitmap_t *e2)
> >                 }
> >         }
> >
> > -       if (prev)
> > -               dst->highbit =3D prev->startbit + MAPSIZE;
> > +       if (new)
> > +               dst->highbit =3D new->startbit + MAPSIZE;
> >
> >         return 0;
> >  }
> > @@ -117,12 +113,13 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *=
e1, const ebitmap_t *e2)
> >  int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *=
e2)
> >  {
> >         const ebitmap_node_t *n1, *n2;
> > -       ebitmap_node_t *new, *prev =3D NULL;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >         uint32_t startbit;
> >         MAPTYPE map;
> >
> >         ebitmap_init(dst);
> >
> > +       prev =3D &dst->node;
> >         n1 =3D e1->node;
> >         n2 =3D e2->node;
> >         while (n1 || n2) {
> > @@ -150,16 +147,14 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *=
e1, const ebitmap_t *e2)
> >                         new->startbit =3D startbit;
> >                         new->map =3D map;
> >                         new->next =3D NULL;
> > -                       if (prev)
> > -                               prev->next =3D new;
> > -                       else
> > -                               dst->node =3D new;
> > -                       prev =3D new;
> > +
> > +                       *prev =3D new;
> > +                       prev =3D &new->next;
> >                 }
> >         }
> >
> > -       if (prev)
> > -               dst->highbit =3D prev->startbit + MAPSIZE;
> > +       if (new)
> > +               dst->highbit =3D new->startbit + MAPSIZE;
> >
> >         return 0;
> >  }
> > @@ -167,12 +162,13 @@ int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *=
e1, const ebitmap_t *e2)
> >  int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxb=
it)
> >  {
> >         const ebitmap_node_t *n;
> > -       ebitmap_node_t *new, *prev =3D NULL;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >         uint32_t startbit, cur_startbit;
> >         MAPTYPE map;
> >
> >         ebitmap_init(dst);
> >
> > +       prev =3D &dst->node;
> >         n =3D e1->node;
> >         for (cur_startbit =3D 0; cur_startbit < maxbit; cur_startbit +=
=3D MAPSIZE) {
> >                 if (n && n->startbit =3D=3D cur_startbit) {
> > @@ -199,16 +195,13 @@ int ebitmap_not(ebitmap_t *dst, const ebitmap_t *=
e1, unsigned int maxbit)
> >                         new->map =3D map;
> >                         new->next =3D NULL;
> >
> > -                       if (prev)
> > -                               prev->next =3D new;
> > -                       else
> > -                               dst->node =3D new;
> > -                       prev =3D new;
> > +                       *prev =3D new;
> > +                       prev =3D &new->next;
> >                 }
> >         }
> >
> > -       if (prev)
> > -               dst->highbit =3D prev->startbit + MAPSIZE;
> > +       if (new)
> > +               dst->highbit =3D new->startbit + MAPSIZE;
> >
> >         return 0;
> >  }
> > @@ -278,11 +271,11 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitm=
ap_t * e2)
> >  int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
> >  {
> >         const ebitmap_node_t *n;
> > -       ebitmap_node_t *new, *prev;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >
> >         ebitmap_init(dst);
> >         n =3D src->node;
> > -       prev =3D 0;
> > +       prev =3D &dst->node;
> >         while (n) {
> >                 new =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t=
));
> >                 if (!new) {
> > @@ -291,12 +284,11 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t =
* src)
> >                 }
> >                 new->startbit =3D n->startbit;
> >                 new->map =3D n->map;
> > -               new->next =3D 0;
> > -               if (prev)
> > -                       prev->next =3D new;
> > -               else
> > -                       dst->node =3D new;
> > -               prev =3D new;
> > +               new->next =3D NULL;
> > +
> > +               *prev =3D new;
> > +               prev =3D &new->next;
> > +
> >                 n =3D n->next;
> >         }
> >
> > @@ -450,7 +442,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit=
, int value)
> >
> >  int ebitmap_init_range(ebitmap_t * e, unsigned int minbit, unsigned in=
t maxbit)
> >  {
> > -       ebitmap_node_t *new, *prev =3D NULL;
> > +       ebitmap_node_t *new =3D NULL, **prev;
> >         uint32_t minstartbit =3D minbit & ~(MAPSIZE - 1);
> >         uint32_t maxstartbit =3D maxbit & ~(MAPSIZE - 1);
> >         uint32_t minhighbit =3D minstartbit + MAPSIZE;
> > @@ -466,6 +458,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int =
minbit, unsigned int maxbit)
> >         if (minhighbit =3D=3D 0 || maxhighbit =3D=3D 0)
> >                 return -EOVERFLOW;
> >
> > +       prev =3D &e->node;
> > +
> >         for (startbit =3D minstartbit; startbit <=3D maxstartbit; start=
bit +=3D MAPSIZE) {
> >                 new =3D malloc(sizeof(ebitmap_node_t));
> >                 if (!new)
> > @@ -485,11 +479,8 @@ int ebitmap_init_range(ebitmap_t * e, unsigned int=
 minbit, unsigned int maxbit)
> >                         new->map =3D (mask << (minbit - startbit));
> >                 }
> >
> > -               if (prev)
> > -                       prev->next =3D new;
> > -               else
> > -                       e->node =3D new;
> > -               prev =3D new;
> > +               *prev =3D new;
> > +               prev =3D &new->next;
> >         }
> >
> >         e->highbit =3D maxhighbit;
> > --
> > 2.40.1
> >
