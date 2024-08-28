Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49F18990D
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854304; cv=none; b=tF5HX/539RjbgaRyJoeYatuXRT107Xgd2HLAMI293+nwGGmljENRGEq4EZ70LsYEXXS90vVU6h/yC6I5CAdHafO6rKlRuZb2eN1B9oWh2xv/INqXWdqIImwDSKefW/srlOk7LNJ7VP294fKyK+w6BngFPqVG86RN0zyuG0pkXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854304; c=relaxed/simple;
	bh=4/zfjtyhwaI+JaESWcBDlTPlJJRcsUjtEHsIBK4FpuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8MDNJUe8KUFEA4WQkJlJj0K1Q35pSigTFPVyxsmHsZFNY/BzFrA+DNEJi12dHSGsXYaLisW8D9vTgBAKHNxdKXdXMh8NV3IhxW/4DwX6gPJvan8NHUA56Yok05J3oHRwzZdoaYB1/b4IGJK309wGwq6hmC5YWY4QyTB91zNL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD1gdepe; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD1gdepe"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70945a007f0so5323998a34.2
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854301; x=1725459101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z69sNAVNwT7Y3Qcqm21VVx0d3IJ8HUvacGLxDmSN6tw=;
        b=HD1gdepeR/NRwqrIc/wQSvAIwT1/wsql4Q8PcvTd8+owVt0VCTpDhmNR2M+lG33u3Q
         9hkfFRM8VC2k3lDab+7IHVwRN288d0t4DZ2rGnp57WlWzn9hAw7mXURAHv3DR6anqu3/
         Kep/Yv3Ok48/rxpO7xebixjzKa8DdFQx7P8H5H+NUc8HHFRiHq4OvIGgevT4JQGst96b
         iDzGXeKe0OdZAvili5jGiB6/M4teLS/hrqNQkyl8OFyqYkiI6BtNjAjiScinVXCZL8dL
         Dgptor97KB3XBJ/ZsmqjRpl/pX+YAKDFeMe92b1gQpr3rrNJRhE8P12pig1Uyr+6HdUd
         RjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854301; x=1725459101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z69sNAVNwT7Y3Qcqm21VVx0d3IJ8HUvacGLxDmSN6tw=;
        b=hLJ4fz9w6YYR2/DolfDP5RWdYCdRV06q9iHb6ISCN1Vr/gNktsnv7DaCCm0OprJaJX
         px4g7sIMU1b7O8bq/oULmlJlKAduRUWBWUS3JFQqvndxN5NEVkEZ9cTUtK9PCnUyXhhv
         B+Z3HCnllwx8Ud3fsiw1hlx7sbCLGK5gZkZk5ZBYpPgAxVFLQO2HUtvyFMdPwWlBq4F7
         1/0Q500GKHlSGA+585INELRkzRxKPmKFfFjVpW4h1hqwYQczV1T/nDVwOnv+sirZq6SF
         2lYZyMYhNS6WKG84hJYk9YCqEh4C61d/vX23J27Q3DpD9bGbbevbftRauBFmhAEZBFiF
         nluA==
X-Gm-Message-State: AOJu0Yw9vdbHj5L+pZa3af5b21uNhwhM/NzUL2MqzsT/cgCRIX94yuj7
	h3Gyf5Y+vd4owHz4Bqh2MG0r98FFkKQgF7En3MQdOYZIPGxPgMAOLlc8iM27kFZxDfuhH57/gtz
	vzGJeg58QGh19cP0ob2PDgx4VHzBzBA==
X-Google-Smtp-Source: AGHT+IGVvTFExogW16E2r/5YDT7LQKHLJoOdasLZkkV0yxXslY6+wROOCiKMLTaSVWdpOiwbOYGvdhTtEAioSgFb2+Y=
X-Received: by 2002:a05:6808:2e95:b0:3db:3303:834c with SMTP id
 5614622812f47-3deffb927fdmr2409912b6e.39.1724854301184; Wed, 28 Aug 2024
 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814190319.321748-1-jwcart2@gmail.com> <CAJ2a_DeXkO2HZbuSchEi3KzGkRdP92NLYP0ji7EuyeLQxmCR_g@mail.gmail.com>
In-Reply-To: <CAJ2a_DeXkO2HZbuSchEi3KzGkRdP92NLYP0ji7EuyeLQxmCR_g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Aug 2024 10:11:30 -0400
Message-ID: <CAP+JOzTM0ktT5=_Cvxw1fuVDXjSXD7UM+AyJY=owyv7_d_Z=yw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix MLS users in optional blocks
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:50=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 14 Aug 2024 at 21:03, James Carter <jwcart2@gmail.com> wrote:
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
> > ---
> > v2:
> >   - Fixed mls_semantic_cats_merge() so that it keeps existing cats in d=
st
> >   - Made src const in mls_add_or_check_level()
> >
> >  checkpolicy/policy_define.c | 71 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index bfeda86b..52045484 100644
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
>
> Seems similar to the adding in parse_semantic_categories().
> Thanks.
>
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
> > @@ -4258,10 +4302,15 @@ int define_user(void)
> >                 return 0;
> >         }
> >
> > +       id =3D strdup(queue_head(id_queue));
> > +
> >         if ((usrdatum =3D declare_user()) =3D=3D NULL) {
>
> Isn't `id` still leaking in this error branch?
>

Yes, it is.
Thanks,
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
> > @@ -4288,6 +4337,7 @@ int define_user(void)
> >                 usrdatum->dfltlevel.sens =3D levdatum->level->sens;
> >
> >                 while ((id =3D queue_remove(id_queue))) {
> > +                       /* This will add to any already existing catego=
ries */
> >                         if (parse_semantic_categories(id, levdatum,
> >                                                     &usrdatum->dfltleve=
l.cat)) {
> >                                 free(id);
> > @@ -4313,6 +4363,7 @@ int define_user(void)
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
> > @@ -4333,6 +4384,24 @@ int define_user(void)
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
