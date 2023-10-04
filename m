Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE881E7C4E3
	for <selinux@archiver.kernel.org>; Wed,  4 Oct 2023 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbjJDQXR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbjJDQXQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Oct 2023 12:23:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F96995
        for <selinux@vger.kernel.org>; Wed,  4 Oct 2023 09:23:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdcade7fbso1699166b.1
        for <selinux@vger.kernel.org>; Wed, 04 Oct 2023 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696436590; x=1697041390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3EzA3TUll1iyTG13fQ/w9gFgctk1vTna0YdXFzWqi8=;
        b=QZ0pLE569f672XYWjYV16iPV9nKDKusaTUZDa9nKmgXEQa3KXzI9dN/PTfrW1dkae8
         RGl+Zk8c7P4cSUwRUEU6uCALXyAHDzCFbqoYuGQkdrkabduca6SynYJipohIgmbSoRJ0
         KCLGbHnUVNIF6TYN6pkawMl2MCj5r2fj2+knN903PDiU7FYTg8bRkC3HMdVFdxTNLqLn
         TrkWViBy+402T4yq8yRDOjuiZsP40oRo8SZa8srC9eeHu+UMGWcamfY4E4eIQ2kSlfDo
         FGrd6nZl6OclENbtTWvBob1u9OwL9Y35km9zEPgcu0LNkeb4/5CfFJGvTTb3ukC8+E0K
         TUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436590; x=1697041390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3EzA3TUll1iyTG13fQ/w9gFgctk1vTna0YdXFzWqi8=;
        b=SbpVd6YGijZWWnu6sxZIABD3PVcHQE8+WaX/7VOrdVqrd8R1pgOst+mfs+S18/K0he
         Q8Vs9Z0kSo2GdMhBqffAV5ji53t82MbZ0X5B3Kt/QayHd/+i4SyB0fRT14RCVzv9JLrF
         Bo+uodkuhf86KnQIBwS+Fsz3iA8YFlQFiIVFGfDLp20HoYylVuFfa4dSG2f9IQ3eKI4z
         DFTarsqBXNyBbej9oFfA6372Sqo0E0rdLQqcUcn8AGWYG6iMVRAuGHC12w7CXQBvwFob
         qgqx+Sg58AwMCsxTnAJQyxa0kSiUk32pQRE/yaM9RATWZC6RwggU/GoZ/vNRYaGbSeI7
         lUaw==
X-Gm-Message-State: AOJu0YziOGw6/aIx9OOZHAkRELa1SH8MEgrW7huZO/QPXylDEiqmgYKO
        YT8GAaXA8O4nyudnEriFCxGKCWEsHD1O4/s/CVU=
X-Google-Smtp-Source: AGHT+IHTqOqWsd1RXYLX/O2QCNON5lxdUJZWnbn4VLb988c70UYqxyQzr+ZC18DoJd2JvaZDTXUz03JegjfDaArgPK8=
X-Received: by 2002:a17:906:535e:b0:9ae:42da:803c with SMTP id
 j30-20020a170906535e00b009ae42da803cmr2186115ejo.48.1696436589418; Wed, 04
 Oct 2023 09:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230929195617.65120-3-jsatterfield.linux@gmail.com> <35e5e2d03267228696d78a06bfac9b73.paul@paul-moore.com>
In-Reply-To: <35e5e2d03267228696d78a06bfac9b73.paul@paul-moore.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Wed, 4 Oct 2023 12:22:57 -0400
Message-ID: <CALMFcet8XdUZEdhZ6hq0r-iPKKT++WdKztFTiZRhRDcihVgqDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: refactor avtab_node comparisons
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 3, 2023 at 5:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Sep 29, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
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
> > ---
> >  security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
> >  1 file changed, 41 insertions(+), 60 deletions(-)
>
> Thanks for doing this.  I've got a few small nits (below), but overall
> I think this is a nice improvement.
>
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 8751a602ead2..1cd4fed30bf7 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -96,12 +96,34 @@ avtab_insert_node(struct avtab *h, struct avtab_nod=
e **dst,
> >       return newnode;
> >  }
> >
> > +static int avtab_node_cmp(const struct avtab_key *key1,
> > +                       const struct avtab_key *key2)
> > +{
> > +     u16 specified =3D key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED=
_OLD);
> > +
> > +     if (key1->source_type =3D=3D key2->source_type &&
> > +             key1->target_type =3D=3D key2->target_type &&
> > +             key1->target_class =3D=3D key2->target_class &&
> > +             (specified & key2->specified))
> > +             return 0;
>
> Normally I'd be a nice guy and fix this up during the merge, but
> since I'd like a respin for other reasons I'm going to mention
> this so you can fix it yourself, and learn a bit for next time ;)
>
> Please don't needlessly indent multi-line if-conditionals.  As an
> example, here is what I would have preferred to see for the above
> if-statement:
>
>   if (key1->source_type =3D=3D key2->source_type &&
>       key1->target_type =3D=3D key2->target_type &&
>       key1->target_class =3D=3D key2->target_class &&
>       (specified & key2->specified))
>           return 0;
>
> At some point in the future (hopefully soon, but my review backlog
> is daunting at the moment) we'll have some automated tools to help
> identify problems like this, but we're not there quite yet.
>

Fixed, my editor must have inserted them when I moved the code up.
I'll be more mindful in the future.

> > +     if (key1->source_type < key2->source_type)
> > +             return -1;
> > +     if (key1->source_type =3D=3D key2->source_type &&
> > +             key1->target_type < key2->target_type)
> > +             return -1;
> > +     if (key1->source_type =3D=3D key2->source_type &&
> > +             key1->target_type =3D=3D key2->target_type &&
> > +             key1->target_class < key2->target_class)
> > +             return -1;
> > +     return 1;
> > +}
> > +
> >  static int avtab_insert(struct avtab *h, const struct avtab_key *key,
> >                       const struct avtab_datum *datum)
> >  {
> >       u32 hvalue;
> >       struct avtab_node *prev, *cur, *newnode;
> > -     u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> > +     int cmp;
> >
> >       if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
> >               return -EINVAL;
> > @@ -110,23 +132,11 @@ static int avtab_insert(struct avtab *h, const st=
ruct avtab_key *key,
> >       for (prev =3D NULL, cur =3D h->htable[hvalue];
> >            cur;
> >            prev =3D cur, cur =3D cur->next) {
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class =3D=3D cur->key.target_class &&
> > -                 (specified & cur->key.specified)) {
> > -                     /* extended perms may not be unique */
> > -                     if (specified & AVTAB_XPERMS)
> > -                             break;
> > +             cmp =3D avtab_node_cmp(key, &cur->key);
> > +             /* extended perms may not be unique */
> > +             if (unlikely(cmp =3D=3D 0 && !(key->specified & AVTAB_XPE=
RMS)))
> >                       return -EEXIST;
> > -             }
>
> I'm generally not a big fan of the unlikely()/likely() macros unless
> it is a rather extreme case, please don't add one here.
>

Understood. I will not add them unless perf profiling shows a
significant branch-predictor improvement; and I'll tag it accordingly
in the commit message.

> > -             if (key->source_type < cur->key.source_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type < cur->key.target_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class < cur->key.target_class)
> > +             if (cmp <=3D 0)
> >                       break;
>
> I wonder if we should put the `cmp <=3D 0` (no match) check first since
> that will probably the more common case, right?  Or am I thinking of
> this backwards?
>

In this function, we can't do the `<=3D` first because the  `=3D=3D` branch
is an invalid policy check. Only duplicate XPERMs are allowed, but if
the `<=3D` is moved first it would allow all duplicates.

> >       }
> >
> > @@ -148,7 +158,7 @@ struct avtab_node *avtab_insert_nonunique(struct av=
tab *h,
> >  {
> >       u32 hvalue;
> >       struct avtab_node *prev, *cur;
> > -     u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> > +     int cmp;
> >
> >       if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
> >               return NULL;
> > @@ -156,19 +166,8 @@ struct avtab_node *avtab_insert_nonunique(struct a=
vtab *h,
> >       for (prev =3D NULL, cur =3D h->htable[hvalue];
> >            cur;
> >            prev =3D cur, cur =3D cur->next) {
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class =3D=3D cur->key.target_class &&
> > -                 (specified & cur->key.specified))
> > -                     break;
> > -             if (key->source_type < cur->key.source_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type < cur->key.target_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class < cur->key.target_class)
> > +             cmp =3D avtab_node_cmp(key, &cur->key);
> > +             if (cmp <=3D 0)
> >                       break;
> >       }
> >       return avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalu=
e],
> > @@ -183,7 +182,7 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
> >  {
> >       u32 hvalue;
> >       struct avtab_node *cur;
> > -     u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> > +     int cmp;
> >
> >       if (!h || !h->nslot)
> >               return NULL;
> > @@ -191,20 +190,10 @@ struct avtab_node *avtab_search_node(struct avtab=
 *h,
> >       hvalue =3D avtab_hash(key, h->mask);
> >       for (cur =3D h->htable[hvalue]; cur;
> >            cur =3D cur->next) {
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class =3D=3D cur->key.target_class &&
> > -                 (specified & cur->key.specified))
> > +             cmp =3D avtab_node_cmp(key, &cur->key);
> > +             if (cmp =3D=3D 0)
> >                       return cur;
> > -
> > -             if (key->source_type < cur->key.source_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type < cur->key.target_type)
> > -                     break;
> > -             if (key->source_type =3D=3D cur->key.source_type &&
> > -                 key->target_type =3D=3D cur->key.target_type &&
> > -                 key->target_class < cur->key.target_class)
> > +             if (cmp < 0)
> >                       break;
>
> See the ordering comment/question above in avtab_insert().  I'm
> reasonably confident in the search case there will be more misses
> than hits.
>

I'll admit that I'm not well versed in all of the ways that SELinux is
exercised, but my intuition of the call patterns of this particular
function leads me to believe that the performance trade-off depends on
which mode will be used.

Under permissive mode, a long-running process (like a database or
webserver) could cause an indeterminate number of searches which don't
have entries in the avtab causing misses to be more prevalent. Under
enforcing mode, the same process would only search up to the first
missing entry before being denied, making hits the default case.

I did not consider a change to the original ordering since I had
assumed this trade-off had already been considered. The current
ordering suggests that enforcing would be preferred. However, given
that this portion of code has not been touched since it was mainlined,
do we see one mode preferred over the other and should that preference
be catered to? Should it be a compile time option? And how substantial
is the performance difference under the policies of different
distributions?

> >       }
> >       return NULL;
> > @@ -213,27 +202,19 @@ struct avtab_node *avtab_search_node(struct avtab=
 *h,
> >  struct avtab_node*
> >  avtab_search_node_next(struct avtab_node *node, u16 specified)
> >  {
> > +     struct avtab_key tmp_key;
> >       struct avtab_node *cur;
> > +     int cmp;
> >
> >       if (!node)
> >               return NULL;
> > -
> > -     specified &=3D ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> > +     tmp_key =3D node->key;
> > +     tmp_key.specified =3D specified;
> >       for (cur =3D node->next; cur; cur =3D cur->next) {
> > -             if (node->key.source_type =3D=3D cur->key.source_type &&
> > -                 node->key.target_type =3D=3D cur->key.target_type &&
> > -                 node->key.target_class =3D=3D cur->key.target_class &=
&
> > -                 (specified & cur->key.specified))
> > +             cmp =3D avtab_node_cmp(&tmp_key, &cur->key);
> > +             if (cmp =3D=3D 0)
> >                       return cur;
> > -
> > -             if (node->key.source_type < cur->key.source_type)
> > -                     break;
> > -             if (node->key.source_type =3D=3D cur->key.source_type &&
> > -                 node->key.target_type < cur->key.target_type)
> > -                     break;
> > -             if (node->key.source_type =3D=3D cur->key.source_type &&
> > -                 node->key.target_type =3D=3D cur->key.target_type &&
> > -                 node->key.target_class < cur->key.target_class)
> > +             if (cmp < 0)
> >                       break;
>
> Another ordering spot.
>

My comments above apply to here as well.

> >       }
> >       return NULL;
> > --
> > 2.41.0
>
> --
> paul-moore.com

Thanks for the review!
-Jacob
