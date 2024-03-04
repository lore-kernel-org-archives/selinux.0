Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB378B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579926; cv=none; b=XXjIVshmAV+a3c2P8ZqCbnshDALNxZgzBUKw4vbpgAYxhQm2gTRjGUK2/Wv94pC0GNGaCto31qZ9y+FYJYQAzIrLPDvXvrpaBMcLIfesoBhC5oIsMwh/MhWIw2M7j92GAasz1DUgMevOOICzetiBtt9HP1j82m5J1l8Reyl0Jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579926; c=relaxed/simple;
	bh=64xBU9YqBvykVMMPQJxZhk1asglI4pkQhmw3qiU8NXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcW31QDaa9b/QCEiJfvGVXVt5cFkPOQ4oGwmPIpT7UZhCCU+4h9qnno9vb1xZssZYSIN+jNDlsvx5X9YBuciSi7bcjVOT70OO3f7sZ9S3PFS77xYRrvZm6UbeTiIDlQE6hTCUqmhho4qBalOi+KR8gnQns2qmaXkxQdGthsXbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn6hsVI6; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn6hsVI6"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47283c92d24so710242137.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579924; x=1710184724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtoUZZ87GE9sSWlPwKL88urUsaXhyUu3xHjFUmo1Nm4=;
        b=Mn6hsVI6RwrE4iPvR2w7V06TlC1ljbMj4DtsnZ5jyyzK1hKba5FocI2NlMogAIFdSO
         9ifm2UIUtiLc8fIRhiGdXfrwGdRtJgxIXI9L641LnrG7c1gntIA57x/9Gi3FZCHrbdTi
         KS3OmyF0epeKYyWI8N1sz61gqcsaWKS85gC81cwj/Oo3LqWMvFFFVkiOIpp6MssO7kJX
         sMxZPzJjKP5BBWi/qpLPccTsZ7NgJbDm4feVu3tUJpzoWd3f0wbdLAog51b5PnXG2cTf
         9JrKxIG8LSwDCfRND94R0yFo+/wjJAUkM0PbtkAYSsZiiP9CkJj1zwU2CILoGTIcQfKo
         rclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579924; x=1710184724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtoUZZ87GE9sSWlPwKL88urUsaXhyUu3xHjFUmo1Nm4=;
        b=tcxRoSmTjKCRIzWmgstXnR5EUp7FY63b4jYkd/8Nwti0v04gQNz/q/Pz4KeIhPhHVx
         yoizfyhvQj65zA+ufwlQb8LSA2495raa73aX0WHPRZGH3eKEz0ygYKUixz9F9e9oqhqp
         NIhYk4IetL5JQf6WHw2FfkccKXLIbloMTMIBJr6/qYAXmipDTa0HtpNYvITxYNMscOEU
         H/t4FsxQO2gWbRdsEgB8LK38mPYYW/WZ1zgG+vEzC5mpA0og3MNkFz/dJYSjnLFyqPPJ
         ieXDdC9DIpYu9boUcSFBMwawg9+0f8e+evtzRf4lCSHIieWkA4l9tJvlY3IzS7lWKgRk
         KC0w==
X-Gm-Message-State: AOJu0Yz51QM9Wz1ve7PAcmETcTTgmOJYY2qa/bWnj0cTEAjD5luItGZp
	vufspaoN9iH6VZ30kMzo908Yf6fs/lB8Cf02ADQ+qR6BJh2WPX16JqekRg/dad4eSEPyLsm+SrN
	enX5KTf0+39j+kITrqlqqwwVMMrA=
X-Google-Smtp-Source: AGHT+IH5Fo5ieYZqDJyZm8MZe2BDlg88ZyOYdp1mLyOha/5bFhAC7rhJ3Zj6Q1hyNito3mY9LbXBMJcO++Y1vGI1sZY=
X-Received: by 2002:a67:f958:0:b0:472:74c3:6fe0 with SMTP id
 u24-20020a67f958000000b0047274c36fe0mr5627799vsq.19.1709579923828; Mon, 04
 Mar 2024 11:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-6-cgzones@googlemail.com> <CAP+JOzRaAH3F7GR-TSabp61hR=etn+KkjwXP0LkkrXfeCjspQw@mail.gmail.com>
In-Reply-To: <CAP+JOzRaAH3F7GR-TSabp61hR=etn+KkjwXP0LkkrXfeCjspQw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:18:33 -0500
Message-ID: <CAP+JOzREUGakY7PBB1yXib5tbFbAu1N1k=-RnUrBNLqr2BahMw@mail.gmail.com>
Subject: Re: [PATCH 06/15] checkpolicy: clean expression on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The passed expression needs to be transferred into the policy or free'd
> > by the sink functions define_constraint() and define_validatetrans().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
THanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 68 ++++++++++++++++++++++---------------
> >  1 file changed, 40 insertions(+), 28 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index ec19da9d..97582630 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -3428,20 +3428,22 @@ int define_constraint(constraint_expr_t * expr)
> >                 return 0;
> >         }
> >
> > +       ebitmap_init(&classmap);
> > +
> >         depth =3D -1;
> >         for (e =3D expr; e; e =3D e->next) {
> >                 switch (e->expr_type) {
> >                 case CEXPR_NOT:
> >                         if (depth < 0) {
> >                                 yyerror("illegal constraint expression"=
);
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         break;
> >                 case CEXPR_AND:
> >                 case CEXPR_OR:
> >                         if (depth < 1) {
> >                                 yyerror("illegal constraint expression"=
);
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         depth--;
> >                         break;
> > @@ -3449,51 +3451,48 @@ int define_constraint(constraint_expr_t * expr)
> >                 case CEXPR_NAMES:
> >                         if (e->attr & CEXPR_XTARGET) {
> >                                 yyerror("illegal constraint expression"=
);
> > -                               return -1;      /* only for validatetra=
ns rules */
> > +                               goto bad;       /* only for validatetra=
ns rules */
> >                         }
> >                         if (depth =3D=3D (CEXPR_MAXDEPTH - 1)) {
> >                                 yyerror("constraint expression is too d=
eep");
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         depth++;
> >                         break;
> >                 default:
> >                         yyerror("illegal constraint expression");
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >         }
> >         if (depth !=3D 0) {
> >                 yyerror("illegal constraint expression");
> > -               return -1;
> > +               goto bad;
> >         }
> >
> > -       ebitmap_init(&classmap);
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 cladatum =3D
> >                     (class_datum_t *) hashtab_search(policydbp->p_class=
es.table,
> >                                                      (hashtab_key_t) id=
);
> >                 if (!cladatum) {
> >                         yyerror2("class %s is not defined", id);
> > -                       ebitmap_destroy(&classmap);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 if (ebitmap_set_bit(&classmap, cladatum->s.value - 1, T=
RUE)) {
> >                         yyerror("out of memory");
> > -                       ebitmap_destroy(&classmap);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 node =3D malloc(sizeof(struct constraint_node));
> >                 if (!node) {
> >                         yyerror("out of memory");
> >                         free(node);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 memset(node, 0, sizeof(constraint_node_t));
> >                 if (useexpr) {
> > @@ -3505,7 +3504,7 @@ int define_constraint(constraint_expr_t * expr)
> >                 if (!node->expr) {
> >                         yyerror("out of memory");
> >                         free(node);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 node->permissions =3D 0;
> >
> > @@ -3557,8 +3556,7 @@ int define_constraint(constraint_expr_t * expr)
> >                                         yyerror2("permission %s is not"
> >                                                  " defined for class %s=
", id, policydbp->p_class_val_to_name[i]);
> >                                         free(id);
> > -                                       ebitmap_destroy(&classmap);
> > -                                       return -1;
> > +                                       goto bad;
> >                                 }
> >                         }
> >                         node->permissions |=3D (UINT32_C(1) << (perdatu=
m->s.value - 1));
> > @@ -3569,6 +3567,13 @@ int define_constraint(constraint_expr_t * expr)
> >         ebitmap_destroy(&classmap);
> >
> >         return 0;
> > +
> > +bad:
> > +       ebitmap_destroy(&classmap);
> > +       if (useexpr)
> > +               constraint_expr_destroy(expr);
> > +
> > +       return -1;
> >  }
> >
> >  int define_validatetrans(constraint_expr_t * expr)
> > @@ -3587,20 +3592,22 @@ int define_validatetrans(constraint_expr_t * ex=
pr)
> >                 return 0;
> >         }
> >
> > +       ebitmap_init(&classmap);
> > +
> >         depth =3D -1;
> >         for (e =3D expr; e; e =3D e->next) {
> >                 switch (e->expr_type) {
> >                 case CEXPR_NOT:
> >                         if (depth < 0) {
> >                                 yyerror("illegal validatetrans expressi=
on");
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         break;
> >                 case CEXPR_AND:
> >                 case CEXPR_OR:
> >                         if (depth < 1) {
> >                                 yyerror("illegal validatetrans expressi=
on");
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         depth--;
> >                         break;
> > @@ -3608,47 +3615,45 @@ int define_validatetrans(constraint_expr_t * ex=
pr)
> >                 case CEXPR_NAMES:
> >                         if (depth =3D=3D (CEXPR_MAXDEPTH - 1)) {
> >                                 yyerror("validatetrans expression is to=
o deep");
> > -                               return -1;
> > +                               goto bad;
> >                         }
> >                         depth++;
> >                         break;
> >                 default:
> >                         yyerror("illegal validatetrans expression");
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >         }
> >         if (depth !=3D 0) {
> >                 yyerror("illegal validatetrans expression");
> > -               return -1;
> > +               goto bad;
> >         }
> >
> > -       ebitmap_init(&classmap);
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 cladatum =3D
> >                     (class_datum_t *) hashtab_search(policydbp->p_class=
es.table,
> >                                                      (hashtab_key_t) id=
);
> >                 if (!cladatum) {
> >                         yyerror2("class %s is not defined", id);
> > -                       ebitmap_destroy(&classmap);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >                 if (ebitmap_set_bit(&classmap, (cladatum->s.value - 1),=
 TRUE)) {
> >                         yyerror("out of memory");
> > -                       ebitmap_destroy(&classmap);
> >                         free(id);
> > -                       return -1;
> > +                       goto bad;
> >                 }
> >
> >                 node =3D malloc(sizeof(struct constraint_node));
> >                 if (!node) {
> >                         yyerror("out of memory");
> > -                       return -1;
> > +                       free(id);
> > +                       goto bad;
> >                 }
> >                 memset(node, 0, sizeof(constraint_node_t));
> >                 if (useexpr) {
> > @@ -3668,6 +3673,13 @@ int define_validatetrans(constraint_expr_t * exp=
r)
> >         ebitmap_destroy(&classmap);
> >
> >         return 0;
> > +
> > +bad:
> > +       ebitmap_destroy(&classmap);
> > +       if (useexpr)
> > +               constraint_expr_destroy(expr);
> > +
> > +       return -1;
> >  }
> >
> >  uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t a=
rg2)
> > --
> > 2.43.0
> >
> >
