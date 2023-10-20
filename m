Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888CC0032E
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 13:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjJTNwl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjJTNwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 09:52:40 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF198CA
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 06:52:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so568335a34.0
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697809958; x=1698414758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzIw5fx9HlC9Ch2S4jj8h5NxDv+iA2bGe1SIe06i82I=;
        b=Sdt5wfoPKWV483EBW+MIBGGAyooFVbBvL7LzJ1QrILDnh0NcLWIPqy9tXsbBL6QIgO
         PrkjyazwrJco7SoGm+bMM2HuPtNRyfaha3Z9nL69Nl6EcZ+h+cwv/zR8e1tpspytu7UN
         xbLgGHe3vLpfXPIxR2ecRbGGo5xKbQnp9iN01pKMwXebO6DnVBxuOax/ss7P3fnaq81V
         CA8XFfoiTh91KQR+QnMWQxDZsJOzKJgM30AJARcBGj+MTZQaSAkbapl8OCqieAg0LGW0
         2pz7DFoFz/2QUbwrBS6/+jDPv7yFXSvGqz0iCwBM2wL2z1K3GkwAaG997yBVGRpXpp6f
         hAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809958; x=1698414758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzIw5fx9HlC9Ch2S4jj8h5NxDv+iA2bGe1SIe06i82I=;
        b=GZ7gdeurjO/mgahwHhOEZXIwnZnQvE4PXPfIzW/tXrhtJeYBckLfyEf30tOGaC+/D7
         sZp0rc9dZWOoxGf3DxAYveK7u+d1z/1UXz4LCC4j4B1Ob5X4RqgRLG6Y2b9NnQqj4Whn
         qRNUtfmqe5mH+3Ip4CnnJRGYRDYz9gRO1441U2qKgh2KKlk7c1oSbdtX5Fe9LHVxbLIt
         4+a4hiWfxkk4GOWXlunzcvMITNPbUbEgaUBcTKFYhNfq392s1MMr/xt96e7jW1kpm92L
         +2pAZdvwg7EWdpiZAy7OoOAla9WK/ZzTWp5ViJi4qk4eVuiN+8eyJQQgmOGMcEs//oeZ
         3Ugg==
X-Gm-Message-State: AOJu0Yzi5pofXfYgGaVhqQITaN0jXJH0vgZBK2kGaTtQoGfprqHmUACV
        2Qd0T2yZ9cmErzHu9aop4CRI6mmw5lIL62Pb004=
X-Google-Smtp-Source: AGHT+IENKuv/cQROKDB4Q+4OLkHV+QAEFHKYdBA7MvfiQ8B6sY0KFv7fp4A4BpoAlrAucepwgI9iBYIkjxnfZAEoUDk=
X-Received: by 2002:a9d:6398:0:b0:6be:fdab:dc65 with SMTP id
 w24-20020a9d6398000000b006befdabdc65mr1814523otk.19.1697809957997; Fri, 20
 Oct 2023 06:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com> <20231018175744.39667-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20231018175744.39667-2-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 20 Oct 2023 09:52:27 -0400
Message-ID: <CAEjxPJ70J4AQOC4TddrzAVF+=8whO1n6yhau9i0df9gPE+d2wQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selinux: refactor avtab_node comparisons
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 1:58=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> In four separate functions within avtab, the same comparison logic is
> used. The only difference is how the result is handled or whether there
> is a unique specifier value to be checked for or used.
>
> Extracting this functionality into the avtab_node_cmp() function unifies
> the comparison logic between searching and insertion and gets rid of
> duplicative code so that the implementation is easier to maintain.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Nit: You can't retain a Reviewed-by line if you make any changes to
the previously reviewed patch.
That said, having re-reviewed this one, you can add my Reviewed-by tag
to your next one if there are no changes.

> ---
>  security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 60 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 8751a602ead2..697eb4352439 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -96,12 +96,34 @@ avtab_insert_node(struct avtab *h, struct avtab_node =
**dst,
>         return newnode;
>  }
>
> +static int avtab_node_cmp(const struct avtab_key *key1,
> +                         const struct avtab_key *key2)
> +{
> +       u16 specified =3D key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED=
_OLD);
> +
> +       if (key1->source_type =3D=3D key2->source_type &&
> +           key1->target_type =3D=3D key2->target_type &&
> +           key1->target_class =3D=3D key2->target_class &&
> +           (specified & key2->specified))
> +               return 0;
> +       if (key1->source_type < key2->source_type)
> +               return -1;
> +       if (key1->source_type =3D=3D key2->source_type &&
> +           key1->target_type < key2->target_type)
> +               return -1;
> +       if (key1->source_type =3D=3D key2->source_type &&
> +           key1->target_type =3D=3D key2->target_type &&
> +           key1->target_class < key2->target_class)
> +               return -1;
> +       return 1;
> +}
> +
>  static int avtab_insert(struct avtab *h, const struct avtab_key *key,
>                         const struct avtab_datum *datum)
>  {
>         u32 hvalue;
>         struct avtab_node *prev, *cur, *newnode;
> -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> +       int cmp;
>
>         if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
>                 return -EINVAL;
> @@ -110,23 +132,11 @@ static int avtab_insert(struct avtab *h, const stru=
ct avtab_key *key,
>         for (prev =3D NULL, cur =3D h->htable[hvalue];
>              cur;
>              prev =3D cur, cur =3D cur->next) {
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class =3D=3D cur->key.target_class &&
> -                   (specified & cur->key.specified)) {
> -                       /* extended perms may not be unique */
> -                       if (specified & AVTAB_XPERMS)
> -                               break;
> +               cmp =3D avtab_node_cmp(key, &cur->key);
> +               /* extended perms may not be unique */
> +               if (cmp =3D=3D 0 && !(key->specified & AVTAB_XPERMS))
>                         return -EEXIST;
> -               }
> -               if (key->source_type < cur->key.source_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type < cur->key.target_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class < cur->key.target_class)
> +               if (cmp <=3D 0)
>                         break;
>         }
>
> @@ -148,7 +158,7 @@ struct avtab_node *avtab_insert_nonunique(struct avta=
b *h,
>  {
>         u32 hvalue;
>         struct avtab_node *prev, *cur;
> -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> +       int cmp;
>
>         if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
>                 return NULL;
> @@ -156,19 +166,8 @@ struct avtab_node *avtab_insert_nonunique(struct avt=
ab *h,
>         for (prev =3D NULL, cur =3D h->htable[hvalue];
>              cur;
>              prev =3D cur, cur =3D cur->next) {
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class =3D=3D cur->key.target_class &&
> -                   (specified & cur->key.specified))
> -                       break;
> -               if (key->source_type < cur->key.source_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type < cur->key.target_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class < cur->key.target_class)
> +               cmp =3D avtab_node_cmp(key, &cur->key);
> +               if (cmp <=3D 0)
>                         break;
>         }
>         return avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalu=
e],
> @@ -183,7 +182,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  {
>         u32 hvalue;
>         struct avtab_node *cur;
> -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> +       int cmp;
>
>         if (!h || !h->nslot)
>                 return NULL;
> @@ -191,20 +190,10 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
>         hvalue =3D avtab_hash(key, h->mask);
>         for (cur =3D h->htable[hvalue]; cur;
>              cur =3D cur->next) {
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class =3D=3D cur->key.target_class &&
> -                   (specified & cur->key.specified))
> +               cmp =3D avtab_node_cmp(key, &cur->key);
> +               if (cmp =3D=3D 0)
>                         return cur;
> -
> -               if (key->source_type < cur->key.source_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type < cur->key.target_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class < cur->key.target_class)
> +               if (cmp < 0)
>                         break;
>         }
>         return NULL;
> @@ -213,27 +202,19 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
>  struct avtab_node*
>  avtab_search_node_next(struct avtab_node *node, u16 specified)
>  {
> +       struct avtab_key tmp_key;
>         struct avtab_node *cur;
> +       int cmp;
>
>         if (!node)
>                 return NULL;
> -
> -       specified &=3D ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> +       tmp_key =3D node->key;
> +       tmp_key.specified =3D specified;
>         for (cur =3D node->next; cur; cur =3D cur->next) {
> -               if (node->key.source_type =3D=3D cur->key.source_type &&
> -                   node->key.target_type =3D=3D cur->key.target_type &&
> -                   node->key.target_class =3D=3D cur->key.target_class &=
&
> -                   (specified & cur->key.specified))
> +               cmp =3D avtab_node_cmp(&tmp_key, &cur->key);
> +               if (cmp =3D=3D 0)
>                         return cur;
> -
> -               if (node->key.source_type < cur->key.source_type)
> -                       break;
> -               if (node->key.source_type =3D=3D cur->key.source_type &&
> -                   node->key.target_type < cur->key.target_type)
> -                       break;
> -               if (node->key.source_type =3D=3D cur->key.source_type &&
> -                   node->key.target_type =3D=3D cur->key.target_type &&
> -                   node->key.target_class < cur->key.target_class)
> +               if (cmp < 0)
>                         break;
>         }
>         return NULL;
> --
> 2.41.0
>
