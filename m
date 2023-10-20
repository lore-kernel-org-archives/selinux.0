Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B324DC001DF
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 17:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJTRcU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJTRcT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 13:32:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A7D68
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 10:32:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1595064a12.2
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697823135; x=1698427935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBkGnwZ2HovGy/zgPywp1agOgwg6FmNeSoFHBpFgS+M=;
        b=BFvNf7o3cpf6MGqLhH0tC6LRHW7QmDFsH9xVuy2egSll74B6kRQXV/byyiL/QwiEOh
         pyXg8W6dJD8l3Nw9Y3AvfR+qwPYe/ZKwqvZgTS18Pq1pgU0g2kkfgn88K7JVK1QttSm0
         kgIwTSmCZbJW1xdur1grIAEvBPgXwE7aTmdHciytPWJV86VTsi4qN60DiJ2qwHV/y07q
         0HwARXF7uiN0BHO0doY2AxRw/gK8boHt/SLpZkBPmsYYW4qT4QID+abYIR9SF5pxTpQl
         Z5npKvjCfWUaQjHt2eJ/fp2IK5Ef1jYqztTx1xw5Xv5OJ3bWpIltZnmYMX+qP1lYS8Xm
         U7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823135; x=1698427935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBkGnwZ2HovGy/zgPywp1agOgwg6FmNeSoFHBpFgS+M=;
        b=hxLA5kZAUzO8q/q5G7DnjCZ5A1jog7QOY7KqKPMeG+uDVqqxvBT7d395HkaByTkDDS
         H4dkjxM2l13D6TUHIbkOAYRVGwcnSs/XJjUkk5lHqmccQz8ITdMEqeqal3uxWB/M+/fC
         l7CVXKJG369J6a5BfCgBQ3GyS84bJdYrcL57vwfxN/YUgcA3At6nUPz6bNY/qsADmWLF
         OBMpJ/rW3mqSqHMPKBnYBIMyCXIgeLHnnnmXKiJttXVvar/q+yHgBbCmtEvnULLFnxCm
         /Vm6Nq49MuBjx6t6vjY5pDTGFvjt9awHuOrb8BgsI/PaIi+sWJ6i+zKX70/n91GYf1Od
         clEg==
X-Gm-Message-State: AOJu0Yx2P9ho4PGFCTghuMCB2ux+0iSmfs4NyXOp5876E5+61BzCSNlT
        IeWozRamcES+/YfIMAqsqmyvHCdO7NWOSmDtdFQ=
X-Google-Smtp-Source: AGHT+IFmd8CVaWbP881Dr7Axl8xEET9A+MEb7Iq4oo/Xo8rHPShXsbUDd0VpKgWOqLkFhBfvGNGgK8pNf4V4yRaIQmY=
X-Received: by 2002:a17:907:a03:b0:9c4:344e:b48c with SMTP id
 bb3-20020a1709070a0300b009c4344eb48cmr2004790ejc.36.1697823134916; Fri, 20
 Oct 2023 10:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
 <20231018175744.39667-2-jsatterfield.linux@gmail.com> <CAEjxPJ70J4AQOC4TddrzAVF+=8whO1n6yhau9i0df9gPE+d2wQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ70J4AQOC4TddrzAVF+=8whO1n6yhau9i0df9gPE+d2wQ@mail.gmail.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Fri, 20 Oct 2023 13:32:02 -0400
Message-ID: <CALMFcesEzgDhrKYYXmmzJXfcpvNi3gBt7BFydJWew14fE6Es2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selinux: refactor avtab_node comparisons
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 20, 2023 at 9:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Oct 18, 2023 at 1:58=E2=80=AFPM Jacob Satterfield
> <jsatterfield.linux@gmail.com> wrote:
> >
> > In four separate functions within avtab, the same comparison logic is
> > used. The only difference is how the result is handled or whether there
> > is a unique specifier value to be checked for or used.
> >
> > Extracting this functionality into the avtab_node_cmp() function unifie=
s
> > the comparison logic between searching and insertion and gets rid of
> > duplicative code so that the implementation is easier to maintain.
> >
> > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Nit: You can't retain a Reviewed-by line if you make any changes to
> the previously reviewed patch.
> That said, having re-reviewed this one, you can add my Reviewed-by tag
> to your next one if there are no changes.
>

My apologies. Understood for the future.

Thanks for the re-review.

> > ---
> >  security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
> >  1 file changed, 41 insertions(+), 60 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 8751a602ead2..697eb4352439 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -96,12 +96,34 @@ avtab_insert_node(struct avtab *h, struct avtab_nod=
e **dst,
> >         return newnode;
> >  }
> >
> > +static int avtab_node_cmp(const struct avtab_key *key1,
> > +                         const struct avtab_key *key2)
> > +{
> > +       u16 specified =3D key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABL=
ED_OLD);
> > +
> > +       if (key1->source_type =3D=3D key2->source_type &&
> > +           key1->target_type =3D=3D key2->target_type &&
> > +           key1->target_class =3D=3D key2->target_class &&
> > +           (specified & key2->specified))
> > +               return 0;
> > +       if (key1->source_type < key2->source_type)
> > +               return -1;
> > +       if (key1->source_type =3D=3D key2->source_type &&
> > +           key1->target_type < key2->target_type)
> > +               return -1;
> > +       if (key1->source_type =3D=3D key2->source_type &&
> > +           key1->target_type =3D=3D key2->target_type &&
> > +           key1->target_class < key2->target_class)
> > +               return -1;
> > +       return 1;
> > +}
> > +
> >  static int avtab_insert(struct avtab *h, const struct avtab_key *key,
> >                         const struct avtab_datum *datum)
> >  {
> >         u32 hvalue;
> >         struct avtab_node *prev, *cur, *newnode;
> > -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLE=
D_OLD);
> > +       int cmp;
> >
> >         if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
> >                 return -EINVAL;
> > @@ -110,23 +132,11 @@ static int avtab_insert(struct avtab *h, const st=
ruct avtab_key *key,
> >         for (prev =3D NULL, cur =3D h->htable[hvalue];
> >              cur;
> >              prev =3D cur, cur =3D cur->next) {
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class =3D=3D cur->key.target_class &&
> > -                   (specified & cur->key.specified)) {
> > -                       /* extended perms may not be unique */
> > -                       if (specified & AVTAB_XPERMS)
> > -                               break;
> > +               cmp =3D avtab_node_cmp(key, &cur->key);
> > +               /* extended perms may not be unique */
> > +               if (cmp =3D=3D 0 && !(key->specified & AVTAB_XPERMS))
> >                         return -EEXIST;
> > -               }
> > -               if (key->source_type < cur->key.source_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type < cur->key.target_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class < cur->key.target_class)
> > +               if (cmp <=3D 0)
> >                         break;
> >         }
> >
> > @@ -148,7 +158,7 @@ struct avtab_node *avtab_insert_nonunique(struct av=
tab *h,
> >  {
> >         u32 hvalue;
> >         struct avtab_node *prev, *cur;
> > -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLE=
D_OLD);
> > +       int cmp;
> >
> >         if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
> >                 return NULL;
> > @@ -156,19 +166,8 @@ struct avtab_node *avtab_insert_nonunique(struct a=
vtab *h,
> >         for (prev =3D NULL, cur =3D h->htable[hvalue];
> >              cur;
> >              prev =3D cur, cur =3D cur->next) {
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class =3D=3D cur->key.target_class &&
> > -                   (specified & cur->key.specified))
> > -                       break;
> > -               if (key->source_type < cur->key.source_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type < cur->key.target_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class < cur->key.target_class)
> > +               cmp =3D avtab_node_cmp(key, &cur->key);
> > +               if (cmp <=3D 0)
> >                         break;
> >         }
> >         return avtab_insert_node(h, prev ? &prev->next : &h->htable[hva=
lue],
> > @@ -183,7 +182,7 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
> >  {
> >         u32 hvalue;
> >         struct avtab_node *cur;
> > -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLE=
D_OLD);
> > +       int cmp;
> >
> >         if (!h || !h->nslot)
> >                 return NULL;
> > @@ -191,20 +190,10 @@ struct avtab_node *avtab_search_node(struct avtab=
 *h,
> >         hvalue =3D avtab_hash(key, h->mask);
> >         for (cur =3D h->htable[hvalue]; cur;
> >              cur =3D cur->next) {
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class =3D=3D cur->key.target_class &&
> > -                   (specified & cur->key.specified))
> > +               cmp =3D avtab_node_cmp(key, &cur->key);
> > +               if (cmp =3D=3D 0)
> >                         return cur;
> > -
> > -               if (key->source_type < cur->key.source_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type < cur->key.target_type)
> > -                       break;
> > -               if (key->source_type =3D=3D cur->key.source_type &&
> > -                   key->target_type =3D=3D cur->key.target_type &&
> > -                   key->target_class < cur->key.target_class)
> > +               if (cmp < 0)
> >                         break;
> >         }
> >         return NULL;
> > @@ -213,27 +202,19 @@ struct avtab_node *avtab_search_node(struct avtab=
 *h,
> >  struct avtab_node*
> >  avtab_search_node_next(struct avtab_node *node, u16 specified)
> >  {
> > +       struct avtab_key tmp_key;
> >         struct avtab_node *cur;
> > +       int cmp;
> >
> >         if (!node)
> >                 return NULL;
> > -
> > -       specified &=3D ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> > +       tmp_key =3D node->key;
> > +       tmp_key.specified =3D specified;
> >         for (cur =3D node->next; cur; cur =3D cur->next) {
> > -               if (node->key.source_type =3D=3D cur->key.source_type &=
&
> > -                   node->key.target_type =3D=3D cur->key.target_type &=
&
> > -                   node->key.target_class =3D=3D cur->key.target_class=
 &&
> > -                   (specified & cur->key.specified))
> > +               cmp =3D avtab_node_cmp(&tmp_key, &cur->key);
> > +               if (cmp =3D=3D 0)
> >                         return cur;
> > -
> > -               if (node->key.source_type < cur->key.source_type)
> > -                       break;
> > -               if (node->key.source_type =3D=3D cur->key.source_type &=
&
> > -                   node->key.target_type < cur->key.target_type)
> > -                       break;
> > -               if (node->key.source_type =3D=3D cur->key.source_type &=
&
> > -                   node->key.target_type =3D=3D cur->key.target_type &=
&
> > -                   node->key.target_class < cur->key.target_class)
> > +               if (cmp < 0)
> >                         break;
> >         }
> >         return NULL;
> > --
> > 2.41.0
> >
