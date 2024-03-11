Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BC482DB
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174789; cv=none; b=KatyRCMsOyv3UCZ7Q2rK/8fUJLboImWDpAmMfY/fz4tNrBhIJmMjOtDcnP9Q/QG8/5LNEXH34MN/3FhdBmZJaF/LGfhytkaa762iBToeSlb2p1/hMmKMJyhlfu3zqpsmuHcQ30X4qr2ASyfCMaUYTyJWUJjqNd7mJz5OAmaGfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174789; c=relaxed/simple;
	bh=tMGTx3SDO0EwZXBQU9xC8zk9WW2Ldx7gSD/aCwSB1+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPqFb3DV8SpylWBEHO4cmwbQ5S6ExDeBu0hRu9qgUyx3SMweSI4vPcsromrYo5eezUg/F0jGjHFZkItASqtzbwL+r5kriBfjsh6ezaRy2ShV3JPtybAwzgRSsxG1DSYW5RuaT2Bn/OzjQN7A1BtHWOak0FXD/W8CBZb6R/OAnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LLSBuZ8B; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LLSBuZ8B"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso3507913276.0
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710174787; x=1710779587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Sn5Sl1iVqYa3Dxqd4bQlRKSUGm/2uinuKYW0uuCXs=;
        b=LLSBuZ8BdLtxW+zoPjxCRvRyEO661RNr6MojsQfgpViUEeQluio+JEbThrVHV0BgS6
         Wzx+h2zcs7Acn/IacYyibr1xfquf+2s6u517XM0ZcsSyfc37CGe9z5/exNFXJ6HhGobv
         s6OJZlGyfRjZF16Mc9bBLGrkTlawNn2RNX/8mZ2snw3PPizSQaeojOwhBAGhWEDQ1H5W
         4SlUopjAOleRB0qHhmb2e+DpmdP0FqP7odEoxTvo/a+77E7vsZBT4PuillhSTjFUiCS1
         ae0CPug4UWZaKn6YqdJjoMceK3c4ix6vt4zYL7c8wn6gTIrygYzerzyv/a7RaKnsgK26
         iBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174787; x=1710779587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Sn5Sl1iVqYa3Dxqd4bQlRKSUGm/2uinuKYW0uuCXs=;
        b=jtgW+6v7O5sjhOzxOckMUYYAzcefa6mR9I8ekRuZ8yqA2Rb2DXnoVvkQYHkGUGrCst
         U6TBLyOZjXqZ1bdcQrEXXCtN4GRORKmAFM31/gvPpVNoxys0nrDX+BMUZ0z2iwyKYuED
         /mRSo6Y0rcaJtbiEnv6ZYBx1vUFSwiXNOAe9YsVcydye/EX6Q1sl6uIpYr7mqUWB4VAU
         JaTeQQlaiDwcbfJb2T8KbABMIy4cUhbMpH9WB+dhUQ3ByaEVXbKOsp0V+Auin8I7bvt0
         //8ZTugCWCf6fk7crMdYQWhBUgPhlqNpVybz5B4VNdxIqwjwJNeK+BbeabPhJzheGJUt
         Z2YA==
X-Gm-Message-State: AOJu0YwJcjjTY/333UD/790txQ6M2CP6OyWPu21tdDtPtC2R8EVjwmY4
	56an8NsPe/d8+jt+JSaRW/nANFgHZxU3RF7c2m7f+r2lWRnNVwiO2KcMYTGByDCsZEawX554F1F
	GKck/q+qzM+ehyIC5N1/bX9mUrCCvCLTW21WPcw==
X-Google-Smtp-Source: AGHT+IFqGNGKvHjb97AtV20MQ+b8RzzkEasaSNlSnyjX+Ak8jBStuqfMogTHqdeb06issjZyGxE9+/bQr//EBgEloNo=
X-Received: by 2002:a25:58d7:0:b0:dc7:3362:4b2f with SMTP id
 m206-20020a2558d7000000b00dc733624b2fmr5189601ybb.13.1710174786592; Mon, 11
 Mar 2024 09:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131130840.48155-1-cgzones@googlemail.com>
 <20240131130840.48155-6-cgzones@googlemail.com> <CAP+JOzTRKU8H3Ty0vmNQmLZkL-ZR5czmbbxnKWMJProT3kcT-Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTRKU8H3Ty0vmNQmLZkL-ZR5czmbbxnKWMJProT3kcT-Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 11 Mar 2024 17:32:55 +0100
Message-ID: <CAJ2a_DdA5rYK9hK0L-rGMKdr7zXFXS=8udNqw5V3nrA3FcxV2w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/9] libselinux: sidtab updates
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 at 21:53, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jan 31, 2024 at 8:18=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add sidtab_context_lookup() to just lookup a context, not inserting
> > non-existent ones.
> >
> > Tweak sidtab_destroy() to accept a zero'ed struct sidtab.
> >
> > Remove redundant lookup in sidtab_context_to_sid() after insertion by
> > returning the newly created node directly from sidtab_insert().
> >
> > Drop declaration of only internal used sidtab_insert().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >   add patch
> > ---
> >  libselinux/src/avc_sidtab.c | 55 +++++++++++++++++++++----------------
> >  libselinux/src/avc_sidtab.h |  2 +-
> >  2 files changed, 32 insertions(+), 25 deletions(-)
> >
> > diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
> > index 9475dcb0..3d347cea 100644
> > --- a/libselinux/src/avc_sidtab.c
> > +++ b/libselinux/src/avc_sidtab.c
> > @@ -44,28 +44,23 @@ int sidtab_init(struct sidtab *s)
> >         return rc;
> >  }
> >
> > -int sidtab_insert(struct sidtab *s, const char * ctx)
> > +static struct sidtab_node *
> > +sidtab_insert(struct sidtab *s, const char * ctx)
> >  {
> >         unsigned hvalue;
> > -       int rc =3D 0;
> >         struct sidtab_node *newnode;
> >         char * newctx;
> >
> > -       if (s->nel >=3D UINT_MAX - 1) {
> > -               rc =3D -1;
> > -               goto out;
> > -       }
> > +       if (s->nel >=3D UINT_MAX - 1)
> > +               return NULL;
> >
> >         newnode =3D (struct sidtab_node *)avc_malloc(sizeof(*newnode));
> > -       if (!newnode) {
> > -               rc =3D -1;
> > -               goto out;
> > -       }
> > +       if (!newnode)
> > +               return NULL;
> >         newctx =3D strdup(ctx);
> >         if (!newctx) {
> > -               rc =3D -1;
> >                 avc_free(newnode);
> > -               goto out;
> > +               return NULL;
> >         }
> >
> >         hvalue =3D sidtab_hash(newctx);
> > @@ -73,8 +68,25 @@ int sidtab_insert(struct sidtab *s, const char * ctx=
)
> >         newnode->sid_s.ctx =3D newctx;
> >         newnode->sid_s.id =3D ++s->nel;
> >         s->htable[hvalue] =3D newnode;
> > -      out:
> > -       return rc;
> > +       return newnode;
> > +}
> > +
> > +const struct security_id *
> > +sidtab_context_lookup(const struct sidtab *s, const char *ctx)
> > +{
> > +       unsigned hvalue;
> > +       const struct sidtab_node *cur;
> > +
> > +       hvalue =3D sidtab_hash(ctx);
> > +
> > +       cur =3D s->htable[hvalue];
> > +       while (cur !=3D NULL && strcmp(cur->sid_s.ctx, ctx))
> > +               cur =3D cur->next;
> > +
> > +       if (cur =3D=3D NULL)
> > +               return NULL;
> > +
> > +       return &cur->sid_s;
> >  }
> >
> >  int
> > @@ -82,27 +94,23 @@ sidtab_context_to_sid(struct sidtab *s,
> >                       const char * ctx, security_id_t * sid)
> >  {
> >         unsigned hvalue;
> > -       int rc =3D 0;
> >         struct sidtab_node *cur;
> >
> >         *sid =3D NULL;
> >         hvalue =3D sidtab_hash(ctx);
> >
> > -      loop:
> >         cur =3D s->htable[hvalue];
> >         while (cur !=3D NULL && strcmp(cur->sid_s.ctx, ctx))
> >                 cur =3D cur->next;
> >
> >         if (cur =3D=3D NULL) {      /* need to make a new entry */
> > -               rc =3D sidtab_insert(s, ctx);
> > -               if (rc)
> > -                       goto out;
> > -               goto loop;      /* find the newly inserted node */
> > +               cur =3D sidtab_insert(s, ctx);
> > +               if (cur =3D=3D NULL)
> > +                       return -1;
> >         }
> >
> >         *sid =3D &cur->sid_s;
> > -      out:
> > -       return rc;
> > +       return 0;
> >  }
> >
>
> This duplicates the sidtab_context_lookup() code above, so why not
> just use that. If that returns NULL, then insert the context.
>
> Thanks,
> Jim

True; applied in wip-v3:
https://github.com/SELinuxProject/selinux/pull/406/commits/445cc5fc903fb6da=
7cefa059e29e6a7ed91302e9

> >  void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen=
)
> > @@ -138,7 +146,7 @@ void sidtab_destroy(struct sidtab *s)
> >         int i;
> >         struct sidtab_node *cur, *temp;
> >
> > -       if (!s)
> > +       if (!s || !s->htable)
> >                 return;
> >
> >         for (i =3D 0; i < SIDTAB_SIZE; i++) {
> > @@ -149,7 +157,6 @@ void sidtab_destroy(struct sidtab *s)
> >                         freecon(temp->sid_s.ctx);
> >                         avc_free(temp);
> >                 }
> > -               s->htable[i] =3D NULL;
> >         }
> >         avc_free(s->htable);
> >         s->htable =3D NULL;
> > diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
> > index e823e3f3..f62fd353 100644
> > --- a/libselinux/src/avc_sidtab.h
> > +++ b/libselinux/src/avc_sidtab.h
> > @@ -24,8 +24,8 @@ struct sidtab {
> >  };
> >
> >  int sidtab_init(struct sidtab *s) ;
> > -int sidtab_insert(struct sidtab *s, const char * ctx) ;
> >
> > +const struct security_id * sidtab_context_lookup(const struct sidtab *=
s, const char *ctx);
> >  int sidtab_context_to_sid(struct sidtab *s,
> >                           const char * ctx, security_id_t * sid) ;
> >
> > --
> > 2.43.0
> >
> >
