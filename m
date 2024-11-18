Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AA14D2B7
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960581; cv=none; b=Z4a56uFvhGQmToHqqXZCvIUCkFN0fvCs4Avfdm2icRBinNQeKNPxY7f+SxOZAkEPZ1n5DKNDYoRONJprRvpolvZnpaPsns7AAAlpc7pABzV9pkMl8KBZO79uLcU8sjEd8HzVUivyC7o552y5dD5vPOJwZHQMZeWa9GxQd9oCHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960581; c=relaxed/simple;
	bh=2xJ1zU84t1X5MeiucT7rJcxAO6jGSD4Z4OEKDg/UzCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/Zqnhj15R30vLSmYsglAnE1lXDB5eUIt93bTg4TFaRP1KsYi8umIWPqW0i/Yi6K57zRkXVT+sONRMt5IcXLHAfX9tg0C3jI5pa4A/JAg8gO6zI41YCuWH+RZZGVCWHYFaW9k2l2zPyCbxjxDj+E8EHaRPblXuh+YI1aizgTPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU8iM9dN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU8iM9dN"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71817c40110so2307031a34.1
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960579; x=1732565379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaqR/FQ2HVtFdjUTOPr9vaVJR5pO+mctcWdSs94LMJE=;
        b=CU8iM9dNBDV4w5tUJwM44SaOANeOyRwBADtRS2AQ4tfyagcsACg/neOiuckJCrsyLd
         QPALZf9lHBYkNHUjrb5VwUOA8PcfYF65K1mL4MfDHg0+2pBW5RK8gfAfh6lv75kgtG7w
         DCEpoMRlSNyLbnTfUiww1LVsUkWuXFaFjDVxKDXIGOCeiT6MMwav4h7IETMS8qmOF83/
         XdxAMYZeOj3FDkcifrqRoCksZFPwwnr9OSJm3mlI7beLUhDqDcOU3abm7sEFHonVlEF3
         vT1cv+reJRJZqbVrBORMAkZfJAOhg98k1LTdyyG/B7HggiZUYfN6KtrM+ftzg1rrbypP
         YroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960579; x=1732565379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaqR/FQ2HVtFdjUTOPr9vaVJR5pO+mctcWdSs94LMJE=;
        b=pS1/dVmUxQj88QazR8V9rAbSk/J6Ri3nUM1Lzu4Ey09xMkQyOpNs82Qgcsu67vyyqC
         tTFH+sLKQLTF9dmrmdX93E/bX8hClJk3/ItL7pwrsYj10uAOusszeaUxmQ9234oo/jz7
         9TdcjgpfBOH7jS/HfxsZ9ZDCt2rKqJ8MhOsX+Yic9Arebpai+2Z+XQKg54HI7Nwf3VJW
         ufRmtwG9EovRpySu0m9gtAa/wkNH2WU10x+5w3+rp5m4PeA/2BCnM5HNaXMipGBzpvMo
         dhcDSM7qsR8kFvvZ95cdqGyPMvStPjirZXrDSY7umU/QKDw0ib0J4BZRNMoi4CQv/lKi
         vfAg==
X-Gm-Message-State: AOJu0YzYSMKiGAzCAxY1aM4v0QWS3MDWMBOAudZcIG1CvnWOylMm59Qk
	su5jit2GaeAXpZ+jP+0O+p3/Q4P1m0WLiZQKUg4ydfTzL8hpzNCHovP2h0Yru5TFbtMBMo5Bn3T
	bSt2Wnrd9KVhjyJyfAww29LCqb7mjqg==
X-Google-Smtp-Source: AGHT+IGcpN6RV6Yvo7iPuvJABsXZbL88INxRB09UbTI0ln/r88+A8qaAlQ2+EMhWYujMMSLSmC9VJm/TkrIsRSboMAU=
X-Received: by 2002:a05:6830:3909:b0:70f:716c:7d4a with SMTP id
 46e09a7af769-71a77a0bc77mr11381332a34.27.1731960578723; Mon, 18 Nov 2024
 12:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828151557.204343-1-jwcart2@gmail.com> <CAP+JOzQJ0HsyeVy5d-RCyOCD8XF7q6m_1kmwCvrY83AOXEQw0Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQJ0HsyeVy5d-RCyOCD8XF7q6m_1kmwCvrY83AOXEQw0Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:09:28 -0500
Message-ID: <CAP+JOzSWCSKsM12x0BAqaaoZ4ToPqXA7j4X2opJPurBJSWK32g@mail.gmail.com>
Subject: Re: [PATCH v3] checkpolicy: Fix MLS users in optional blocks
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:58=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 28, 2024 at 11:16=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > When a user is created in an optional block, a user datum is added
> > to both the avrule_decl's symtab and the policydb's symtab, but
> > the semantic MLS information is only added to the avrule_decl's
> > user datum. This causes an error to occur during policy expansion
> > when user_copy_callback() is called. If this error did not occur
> > then the policydb's user datum would be written without any MLS
> > info and the policy would fail validation when read later.
> >
> > When creating a user datum, search for a user datum with the same
> > key in the policydb's symtab. If that datum has no MLS information,
> > then copy the MLS information from the avrule_decl's datum. If it
> > does, then compare the default level, low level, and high level
> > sensitivities and give an error if they do not match. There is not
> > enough information to expand the categories for the high and low
> > levels, so merge the semantic categories. If the two category sets
> > are not equal an error will occur during the expansion phase.
> >
> > A minimum policy to demonstrate the bug:
> > class CLASS1
> > sid kernel
> > class CLASS1 { PERM1 }
> > sensitivity SENS1;
> > dominance { SENS1 }
> > level SENS1;
> > mlsconstrain CLASS1 { PERM1 } ((h1 dom h2) and (l1 domby h1));
> > type TYPE1;
> > allow TYPE1 self : CLASS1 PERM1;
> > role ROLE1;
> > role ROLE1 types TYPE1;
> > optional {
> >   require {
> >     role ROLE1;
> >   }
> >   user USER2 roles ROLE1 level SENS1 range SENS1;
> > }
> > user USER1 roles ROLE1 level SENS1 range SENS1;
> > sid kernel USER1:ROLE1:TYPE1:SENS1
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I plan on merging this soon.
> Jim
>

This patch has been merged.
Jim

> > ---
> > v2:
> >   - Fixed mls_semantic_cats_merge() so that it keeps existing cats in d=
st
> >   - Made src const in mls_add_or_check_level()
> > v3:
> >   - Free id in the error path
> >
> >  checkpolicy/policy_define.c | 72 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index bfeda86b..af8d007c 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4175,6 +4175,50 @@ static int parse_categories(char *id, level_datu=
m_t * levdatum, ebitmap_t * cats
> >         return 0;
> >  }
> >
> > +static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
> > +                                                                  cons=
t mls_semantic_cat_t * src)
> > +{
> > +       mls_semantic_cat_t *new;
> > +
> > +       while (src) {
> > +               new =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semant=
ic_cat_t));
> > +               if (!new)
> > +                       return -1;
> > +
> > +               mls_semantic_cat_init(new);
> > +               new->low =3D src->low;
> > +               new->high =3D src->high;
> > +               new->next =3D *dst;
> > +               *dst =3D new;
> > +
> > +               src =3D src->next;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int mls_add_or_check_level(mls_semantic_level_t *dst, const mls=
_semantic_level_t *src)
> > +{
> > +       if (!dst->sens) {
> > +               if (mls_semantic_level_cpy(dst, src) < 0) {
> > +                       yyerror("out of memory");
> > +                       return -1;
> > +               }
> > +       } else {
> > +               if (dst->sens !=3D src->sens) {
> > +                       return -1;
> > +               }
> > +               /* Duplicate cats won't cause problems, but different c=
ats will
> > +                * result in an error during expansion */
> > +               if (mls_semantic_cats_merge(&dst->cat, src->cat) < 0) {
> > +                       yyerror("out of memory");
> > +                       return -1;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int parse_semantic_categories(char *id, level_datum_t * levdatu=
m __attribute__ ((unused)),
> >                                      mls_semantic_cat_t ** cats)
> >  {
> > @@ -4233,7 +4277,7 @@ static int parse_semantic_categories(char *id, le=
vel_datum_t * levdatum __attrib
> >  int define_user(void)
> >  {
> >         char *id;
> > -       user_datum_t *usrdatum;
> > +       user_datum_t *usrdatum, *usr_global;
> >         level_datum_t *levdatum;
> >         int l;
> >
> > @@ -4258,10 +4302,16 @@ int define_user(void)
> >                 return 0;
> >         }
> >
> > +       id =3D strdup(queue_head(id_queue));
> > +
> >         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
> > +               free(id);
> >                 return -1;
> >         }
> >
> > +       usr_global =3D hashtab_search(policydbp->p_users.table, (hashta=
b_key_t) id);
> > +       free(id);
> > +
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (set_user_roles(&usrdatum->roles, id))
> >                         return -1;
> > @@ -4288,6 +4338,7 @@ int define_user(void)
> >                 usrdatum->dfltlevel.sens =3D levdatum->level->sens;
> >
> >                 while ((id =3D queue_remove(id_queue))) {
> > +                       /* This will add to any already existing catego=
ries */
> >                         if (parse_semantic_categories(id, levdatum,
> >                                                     &usrdatum->dfltleve=
l.cat)) {
> >                                 free(id);
> > @@ -4313,6 +4364,7 @@ int define_user(void)
> >                         usrdatum->range.level[l].sens =3D levdatum->lev=
el->sens;
> >
> >                         while ((id =3D queue_remove(id_queue))) {
> > +                               /* This will add to any already existin=
g categories */
> >                                 if (parse_semantic_categories(id, levda=
tum,
> >                                                &usrdatum->range.level[l=
].cat)) {
> >                                         free(id);
> > @@ -4333,6 +4385,24 @@ int define_user(void)
> >                                 return -1;
> >                         }
> >                 }
> > +
> > +               if (usr_global && usr_global !=3D usrdatum) {
> > +                       if (mls_add_or_check_level(&usr_global->dfltlev=
el,
> > +                                                                      =
    &usrdatum->dfltlevel)) {
> > +                               yyerror("Problem with user default leve=
l");
> > +                               return -1;
> > +                       }
> > +                       if (mls_add_or_check_level(&usr_global->range.l=
evel[0],
> > +                                                                      =
    &usrdatum->range.level[0])) {
> > +                               yyerror("Problem with user low level");
> > +                               return -1;
> > +                       }
> > +                       if (mls_add_or_check_level(&usr_global->range.l=
evel[1],
> > +                                                                      =
    &usrdatum->range.level[1])) {
> > +                               yyerror("Problem with user high level")=
;
> > +                               return -1;
> > +                       }
> > +               }
> >         }
> >         return 0;
> >  }
> > --
> > 2.46.0
> >
