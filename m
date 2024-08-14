Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39941BD012
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659893; cv=none; b=qjz+0l+Ad/KVbtW8tQEZV7W8GZF7MS/omV4n9W2+z10tAqisgL+H7A1k24xApysvOqWYc75wdr74pO7gjcqajQwzSXqm584wVSc7nvJ+zb0UI3ItoNii+MhtyuyggC59tMjSgrBHbeFAEi4UpToHYXUw2kJJ/OJvwSHlfy25aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659893; c=relaxed/simple;
	bh=FC71j4CsaS94V12LM8NwfdcMEy5qVNyTB3hMpRzjkZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0bW2E3mcZffFkhs4IRk5feomtlysxIJUI60VtGjBsUiCRoCj0M/kJgQiCYFx436yVEw2GuraVoYPMnpdON0D72UxYrlTp2gbkOrseR1Ri42KurWsdbbInC7zbQL46+Fhi1erbKiAJqpWw2ydP3e9xogEuqMlXHp3IUHDzStnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwzDrLsf; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwzDrLsf"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-492a774c807so64705137.3
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723659891; x=1724264691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUGZh7Ehe1isTnhzlN+aW7WfOqk1KOh/P2mypH6uAT0=;
        b=BwzDrLsfgjFs5ux67bh9U3TY4RF2VDoRDbVi7njj2dfRglRTNbF2p87Lm8C8bzrVzx
         Guc5qeio09/U1EZbD2iHVULGm8TA7/wsIqKelWQ/5WyE2kBVmETSzTNbuQ/f2q7lnECe
         RA2eI5oP1WD9Ltqiwt/RoweHJJn28070XIbjL20Gp60dW5pB6vtKGk/j9cK8pEp2f2Fn
         0vAvuhh014FH+idk6O3XQgaMMrNJVB13d6SqwpbMOdcZfXRC/al2cPWMvHmvXAfOTcI9
         w0VHgW+LmVhkNqCwN5uHIyrB5Z+locqwr/gNthsPirUTKApHxFjxyvdrRlIMCA88jlvb
         9yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723659891; x=1724264691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUGZh7Ehe1isTnhzlN+aW7WfOqk1KOh/P2mypH6uAT0=;
        b=tvNscmZDR9FDtx2nVtxwLNOndt/KxbMmhUDJY/Xrn6XHIJVdj1DfBvVQD8fURdw0+S
         xswm8maP5DrbUaMABax6mL7dQaHV9gb4Ar5eA9qoNSjRK6Bd8ATQvGIG1cV4vWX5KlFQ
         fWUAkBhKaSoYCpQdLioOKV+Qy9MGEhTqYtRQOXA1DvGmmv1T5Cn4bvP9EvwrSzkMvC/p
         BUKb3fgn6B9hWhDASOGpjUrtblMa88+DUThLKuM13GwZyLTPY89/HKKEFm8B7H27X7bO
         X03h+OyxW1vPddw82Tyz2xsDN2UmRKoziX5YOIGsw0140SNKe0p5jFl9KtXYV4ve2u3I
         VgwA==
X-Gm-Message-State: AOJu0YxUVxXlVD7W+yWK0zHJPsj38BkI4dR2nUU4iBARnEBKcjFCuI6O
	+7sdC2xz7NobS2Nj26E3iQ+Sefo9rOwem52hKrf9pFSYUKNWkbndM44FhSjwoy7bKUU6r/JDWo5
	p46Va62PBEIdvbUbcQDgw2dWuZzMg/g==
X-Google-Smtp-Source: AGHT+IEdVIToxNt5QhRrwBwJhU1q3Bx5JpuTp9HPIcIIki3690erA3ixEebziblPywFa151Hn+KUtZ01skOFuiMLs6o=
X-Received: by 2002:a05:6102:c8c:b0:48f:de85:2b4c with SMTP id
 ada2fe7eead31-497599c84a2mr4642973137.23.1723659890584; Wed, 14 Aug 2024
 11:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812194051.66157-1-jwcart2@gmail.com> <CAJ2a_Df+rYMNdfav-YWw+47S6CnDyKMxUcJnBSJfJ1a49UabCw@mail.gmail.com>
In-Reply-To: <CAJ2a_Df+rYMNdfav-YWw+47S6CnDyKMxUcJnBSJfJ1a49UabCw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 Aug 2024 14:24:39 -0400
Message-ID: <CAP+JOzRgRRHTe4sA_ULMqeMSR1MbyH3s=uf+atCN8HWXrgy23Q@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix MLS users in optional blocks
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:06=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 12 Aug 2024 at 21:41, James Carter <jwcart2@gmail.com> wrote:
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
>
> Maybe add this optional block to checkpolicy/tests/policy_allonce_mls.con=
f?
>

Yes, eventually. I've been working on testing all the valid syntax
options for each rule and block (which is how I found this bug).

> > user USER1 roles ROLE1 level SENS1 range SENS1;
> > sid kernel USER1:ROLE1:TYPE1:SENS1
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  checkpolicy/policy_define.c | 76 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 75 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index bfeda86b..93a1397e 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4175,6 +4175,55 @@ static int parse_categories(char *id, level_datu=
m_t * levdatum, ebitmap_t * cats
> >         return 0;
> >  }
> >
> > +static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
> > +                                                                  cons=
t mls_semantic_cat_t * src)
> > +{
> > +       mls_semantic_cat_t *new, *dcat;
> > +
> > +       dcat =3D *dst;
>
> Does this always work?
> *dst is the pointer to the first category (which might be NULL).
> What if the list is not empty, so dcat->next is not NULL, then we
> would override it later and lose the existing tail of the list.

No, it doesn't work. I wasn't really thinking and just used the syntax
from mls_semantic_level_cpy(), which, of course, is not used when the
level already has values.

>
> > +       while (src) {
> > +               new =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semant=
ic_cat_t));
> > +               if (!new)
> > +                       return -1;
> > +
> > +               mls_semantic_cat_init(new);
> > +               new->low =3D src->low;
> > +               new->high =3D src->high;
> > +
> > +               if (dcat)
> > +                       dcat->next =3D new;
> > +               else
> > +                       *dst =3D new;
> > +               dcat =3D new;
> > +
> > +               src =3D src->next;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int mls_add_or_check_level(mls_semantic_level_t *dst, mls_seman=
tic_level_t *src)
>
> src can be declared const
>

That is true.

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
> > @@ -4233,7 +4282,7 @@ static int parse_semantic_categories(char *id, le=
vel_datum_t * levdatum __attrib
> >  int define_user(void)
> >  {
> >         char *id;
> > -       user_datum_t *usrdatum;
> > +       user_datum_t *usrdatum, *usr_global;
> >         level_datum_t *levdatum;
> >         int l;
> >
> > @@ -4258,10 +4307,15 @@ int define_user(void)
> >                 return 0;
> >         }
> >
> > +       id =3D strdup(queue_head(id_queue));
> > +
> >         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
>
> free(id);
>

I actually free it below after the hashtab_search(). I have to copy it
here because declare_user() pulls things from the queue.

Thanks for the review.
Jim

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
> > @@ -4288,6 +4342,7 @@ int define_user(void)
> >                 usrdatum->dfltlevel.sens =3D levdatum->level->sens;
> >
> >                 while ((id =3D queue_remove(id_queue))) {
> > +                       /* This will add to any already existing catego=
ries */
> >                         if (parse_semantic_categories(id, levdatum,
> >                                                     &usrdatum->dfltleve=
l.cat)) {
> >                                 free(id);
> > @@ -4313,6 +4368,7 @@ int define_user(void)
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
> > @@ -4333,6 +4389,24 @@ int define_user(void)
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
> >
