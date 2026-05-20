Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A873DCD9D
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288216; cv=pass; b=TpkEGQ3tAZ8hmyZOmyzMtrbBqMS1m/a7cypBC28JR6RwCWIARyJqLhIU6sVuafHyUz3EoFtgYW2asIyksxmIzcEwcQ/2QqUC78kC9gUgEhcEMvP5RSnIYjz9r8Jx7l6jPK5c0Wi4FM0EDijr4rFOdTQWzcofRlcQtttHxrbAPAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288216; c=relaxed/simple;
	bh=P2XLLRkElDFW8jSoSqVydlcdvdQ/Ykm9JcCanY6/wGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mv0QjzYdgtTjedRBA7vm0WX+tdmCe7tnMPEI5iAjHKZf1gnNEjHaGoN8/u5c1Vx33aQppPgP9CWvNvguvGrg1EOnke0IXo1EnFtLUvOiddmA3fzmzILQNybFcxyiQqb+EZW9Q+YoShFykMknVmockPKfkDJZvJr3aF85g9QFpMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2DRlkZs; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2DRlkZs"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8f9841616so4286707e87.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 07:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288212; cv=none;
        d=google.com; s=arc-20240605;
        b=B08zmlwhrleyLpxYtt7xWNlt0Sk7CcpepFewriUQL7thSTwycvUoS7XHGIMMdm6EdG
         0Yze2BZ7ToZzar6HNkOxYIUlSsiZejZOjvr5ftBWZ216mnx6OM1dyyoGOmXUjqIhiuZQ
         COf1eQhSfG6v++T9shYOUK8wZSTigNRswsUFV7f3wrsWZsnTuoXv6Enl5Gq08LAnlIAL
         cVCjpIuxY0qRdw4v6BO9eTumzHpxDyO9Dlfy2vYOS3F8tiuoJFzgWJubgw8GXuBps/fu
         3H4HbjErJIYCpQD6KLDS66jhG62YSOCgz9GZbP5iSXKImp9zjYRk4ebP0nNmxsdzXzGK
         54iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYgAhkkPwEhmAkg70qDkEx31BNze5ozxNzsxcQH8bqE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=WDCRpbA8qr0jfhhsY5nqEk/8nLEMfpMKrdq/N1LuKdFEcr41Z+EuYkOfbWy3YGgndh
         WJ8eZfuA/v9tlGFibs1/D2lw3DPp3jHrYEpbEg3PeE+GG0AyfdpVdPlBQi3kbZ8gpIC6
         jI1qUKHKVPgnQZIE7NO+0RuEv5Cyf/6JRBzaRQKw/IxRbErPuMWuDT6i+UMvFtKrRPAl
         cwDra8p+3R+KnyHOW8bBINCcSWHOaIljI0Q3LMMjkKiOJ/Jfem0wss9Sn5hrbjm59KNs
         NzE4DcMSYmxLuquwlRTaKedmuFyXPqMy9tlrYo53Qm6PoSX/Luucvv8nzEUcu1mT/PYt
         gOCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288212; x=1779893012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYgAhkkPwEhmAkg70qDkEx31BNze5ozxNzsxcQH8bqE=;
        b=Y2DRlkZsivQVqi9E2Ew2WPgZggNlTIMI3olMNwaBfWfazZ2ptB7jSQ7FcnCKltZOil
         9hJaaTevfTi4z2LGggLRPfLrfJpAmI4FqR3k6fyvo6CVn+UpmELK78hLwadtTbkML+GU
         vOSJrlC9Rn4rYiH3mQCrxV1tJsuNTCQupPRdKh84bgZs+xhlYx60Soh86YbTSQj3T4x2
         GZfdEjXmb8/y5JPgQCembN6+Y6sUBwWtrRPEqdHhpjrm2VgI64NrZofH9OHs3tdS3ZQl
         FsjSvrgVpqliWYCCuNuw/IWVuBW8u7OYiEE6155znE94x96hZhrUEnfuoWbC4N52JEgX
         zenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288212; x=1779893012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYgAhkkPwEhmAkg70qDkEx31BNze5ozxNzsxcQH8bqE=;
        b=M4+BCqE/b/oKi3YeUJT6/CMVRLdkoeaGCDUczvHJYBNWcieRbRKWjsjCdOZazjnIQ+
         29qbYNgfbc+RCeDI5gEay1B//vAJRF0XlbXcuJTIUdeBulJvrlZ8t5X1/ZJzpsPD3zpa
         8hSD9r9CLAa94LOw3X8WJD+rrtkVn68lmUY7w21EbL0Eb+5MH3wQYI9lgkwSYqSeiKKl
         gKJh5TAKbXr05ufSfAe936SRpMETncYtrv7aaqIYAacZ11VRvgBKx6eKjdGBgDfVzPa4
         dLnjLobHKWIyu5Ee4ZB1eq+5WyNdsXW7+P6CFtDOSD0+qt55HHTaFD+MiRSADSoCQnpu
         Vtmw==
X-Gm-Message-State: AOJu0Yx5Z/yzBykNqhtOl+SfyRl8a0ME8PrBsbn40Ys8137ZpWCDrZgz
	7wB/TzmtDtNj8w0dBOdXXxRY5Dmo67J707Gyne5Yxt866MoBaKQaJFIjLAP+GpjIjFMmhm3btOL
	Ph2Y8asktOGb3LIBwHJB6es5Y+CdgUJE=
X-Gm-Gg: Acq92OFwMfzinl5g5/rJZ9RhYi35eMG9c+j4xLFcviS4f0NVQa+BLfGBlsg+QWA9Cj5
	y+8xkyfkfd8hbx08JRUsYshi5RTjGJcijalgZCgwCCk1346UCw5F9NJBbxPyvI2I3MA20SGMUuM
	puBhQTviPXjpQR7x3xzcGyVvZS2gRWOeI4NW8dIX/wTIwHYMukmDNaIDRU7zGkxmsQPdE7FS5T2
	3iu66QMetRiA9bcA8WMLlSJXd/RGPi3YsS/Hr2byitf5ubHdlmAWY4bW6ZKGI1/s0e9nsQu4/ZW
	AKu/dLDTkXxg1ck=
X-Received: by 2002:a05:6512:33c9:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5aa0e601558mr7049859e87.8.1779288212044; Wed, 20 May 2026
 07:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507235608.65529-1-kalevi@kolttonen.fi> <CAP+JOzTF7SKz-sDE_LGPbjsKA+B+97CmY-7x5+JUQywtux-sJA@mail.gmail.com>
In-Reply-To: <CAP+JOzTF7SKz-sDE_LGPbjsKA+B+97CmY-7x5+JUQywtux-sJA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 10:43:20 -0400
X-Gm-Features: AVHnY4IkNxq27C1TQO0a9jo9Bo4u4IUE7Ly8TNwV4_aXEYbBkUJaiUF63onQVro
Message-ID: <CAP+JOzQ=QOyEdVvJ1mx3CQ3JsMXVONKwXTjMUsppqJKDT5Ae5g@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: replace malloc()+memset() with calloc()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 7, 2026 at 7:56=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
> >
> > Replace malloc()+memset() pattern with calloc()
> > and also remove unneeded casts while at it.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  checkpolicy/policy_define.c | 89 +++++++++++++------------------------
> >  1 file changed, 31 insertions(+), 58 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index b73de45c..02e2c077 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -175,12 +175,11 @@ int define_class(void)
> >                 yyerror("no class name for class definition?");
> >                 return -1;
> >         }
> > -       datum =3D (class_datum_t *) malloc(sizeof(class_datum_t));
> > +       datum =3D calloc(1, sizeof(class_datum_t));
> >         if (!datum) {
> >                 yyerror("out of memory");
> >                 goto cleanup;
> >         }
> > -       memset(datum, 0, sizeof(class_datum_t));
> >         ret =3D declare_symbol(SYM_CLASSES, id, datum, &value, &value);
> >         switch (ret) {
> >         case -3:{
> > @@ -354,12 +353,11 @@ int define_initial_sid(void)
> >                 yyerror("no sid name for SID definition?");
> >                 return -1;
> >         }
> > -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 goto bad;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >         newc->u.name =3D id;
> >         context_init(&newc->context[0]);
> >         head =3D policydbp->ocontexts[OCON_ISID];
> > @@ -579,12 +577,11 @@ int define_common_perms(void)
> >                 free(id);
> >                 return -1;
> >         }
> > -       comdatum =3D (common_datum_t *) malloc(sizeof(common_datum_t));
> > +       comdatum =3D calloc(1, sizeof(common_datum_t));
> >         if (!comdatum) {
> >                 yyerror("out of memory");
> >                 goto bad;
> >         }
> > -       memset(comdatum, 0, sizeof(common_datum_t));
> >         ret =3D hashtab_insert(policydbp->p_commons.table,
> >                              (hashtab_key_t) id, (hashtab_datum_t) comd=
atum);
> >
> > @@ -603,12 +600,11 @@ int define_common_perms(void)
> >         }
> >         policydbp->p_commons.nprim++;
> >         while ((perm =3D queue_remove(id_queue))) {
> > -               perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_=
t));
> > +               perdatum =3D calloc(1, sizeof(perm_datum_t));
> >                 if (!perdatum) {
> >                         yyerror("out of memory");
> >                         goto bad_perm;
> >                 }
> > -               memset(perdatum, 0, sizeof(perm_datum_t));
> >                 perdatum->s.value =3D comdatum->permissions.nprim + 1;
> >
> >                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) =
* 8)) {
> > @@ -713,12 +709,11 @@ int define_av_perms(int inherits)
> >                 cladatum->permissions.nprim +=3D comdatum->permissions.=
nprim;
> >         }
> >         while ((id =3D queue_remove(id_queue))) {
> > -               perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_=
t));
> > +               perdatum =3D calloc(1, sizeof(perm_datum_t));
> >                 if (!perdatum) {
> >                         yyerror("out of memory");
> >                         goto bad;
> >                 }
> > -               memset(perdatum, 0, sizeof(perm_datum_t));
> >                 perdatum->s.value =3D ++cladatum->permissions.nprim;
> >
> >                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) =
* 8)) {
> > @@ -1330,13 +1325,12 @@ static int add_aliases_to_type(type_datum_t * t=
ype)
> >                         free(id);
> >                         return -1;
> >                 }
> > -               aliasdatum =3D (type_datum_t *) malloc(sizeof(type_datu=
m_t));
> > +               aliasdatum =3D calloc(1, sizeof(type_datum_t));
> >                 if (!aliasdatum) {
> >                         free(id);
> >                         yyerror("Out of memory!");
> >                         return -1;
> >                 }
> > -               memset(aliasdatum, 0, sizeof(type_datum_t));
> >                 aliasdatum->s.value =3D type->s.value;
> >
> >                 ret =3D declare_symbol(SYM_TYPES, id, aliasdatum,
> > @@ -1890,13 +1884,12 @@ int define_bool_tunable(int is_tunable)
> >                 free(id);
> >                 return -1;
> >         }
> > -       datum =3D (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t=
));
> > +       datum =3D calloc(1, sizeof(cond_bool_datum_t));
> >         if (!datum) {
> >                 yyerror("out of memory");
> >                 free(id);
> >                 return -1;
> >         }
> > -       memset(datum, 0, sizeof(cond_bool_datum_t));
> >         if (is_tunable)
> >                 datum->flags |=3D COND_BOOL_FLAGS_TUNABLE;
> >         ret =3D declare_symbol(SYM_BOOLS, id, datum, &value, &value);
> > @@ -2519,7 +2512,7 @@ static int avrule_cpy(avrule_t *dest, const avrul=
e_t *src)
> >         /* increment through the class perms and copy over */
> >         src_perms =3D src->perms;
> >         while (src_perms) {
> > -               dest_perms =3D (class_perm_node_t *) calloc(1, sizeof(c=
lass_perm_node_t));
> > +               dest_perms =3D calloc(1, sizeof(class_perm_node_t));
> >                 if (!dest_perms) {
> >                         yyerror("out of memory");
> >                         return -1;
> > @@ -2556,7 +2549,7 @@ static int define_te_avtab_ioctl(const avrule_t *=
avrule_template, avrule_t **ret
> >         if (avrule_ioctl_completedriver(rangelist, &complete_driver))
> >                 return -1;
> >         if (complete_driver) {
> > -               avrule =3D (avrule_t *) calloc(1, sizeof(avrule_t));
> > +               avrule =3D calloc(1, sizeof(avrule_t));
> >                 if (!avrule) {
> >                         yyerror("out of memory");
> >                         return -1;
> > @@ -2591,7 +2584,7 @@ static int define_te_avtab_ioctl(const avrule_t *=
avrule_template, avrule_t **ret
> >                         return -1;
> >
> >                 if (xperms) {
> > -                       avrule =3D (avrule_t *) calloc(1, sizeof(avrule=
_t));
> > +                       avrule =3D calloc(1, sizeof(avrule_t));
> >                         if (!avrule) {
> >                                 yyerror("out of memory");
> >                                 return -1;
> > @@ -2654,7 +2647,7 @@ static int define_te_avtab_netlink(const avrule_t=
 *avrule_template, avrule_t **r
> >                         return -1;
> >
> >                 if (xperms) {
> > -                       avrule =3D (avrule_t *) calloc(1, sizeof(avrule=
_t));
> > +                       avrule =3D calloc(1, sizeof(avrule_t));
> >                         if (!avrule) {
> >                                 yyerror("out of memory");
> >                                 return -1;
> > @@ -3343,12 +3336,11 @@ int define_role_trans(int class_specified)
> >                                         }
> >                                 }
> >
> > -                               tr =3D malloc(sizeof(struct role_trans)=
);
> > +                               tr =3D calloc(1, sizeof(struct role_tra=
ns));
> >                                 if (!tr) {
> >                                         yyerror("out of memory");
> >                                         goto bad;
> >                                 }
> > -                               memset(tr, 0, sizeof(struct role_trans)=
);
> >                                 tr->role =3D i + 1;
> >                                 tr->type =3D j + 1;
> >                                 tr->tclass =3D k + 1;
> > @@ -3359,12 +3351,11 @@ int define_role_trans(int class_specified)
> >                 }
> >         }
> >         /* Now add the real rule */
> > -       rule =3D malloc(sizeof(struct role_trans_rule));
> > +       rule =3D calloc(1, sizeof(struct role_trans_rule));
> >         if (!rule) {
> >                 yyerror("out of memory");
> >                 goto bad;
> >         }
> > -       memset(rule, 0, sizeof(struct role_trans_rule));
> >         rule->roles =3D roles;
> >         rule->types =3D types;
> >         rule->classes =3D e_classes;
> > @@ -3731,13 +3722,12 @@ int define_constraint(constraint_expr_t * expr)
> >                         free(id);
> >                         goto bad;
> >                 }
> > -               node =3D malloc(sizeof(struct constraint_node));
> > +               node =3D calloc(1, sizeof(struct constraint_node));
> >                 if (!node) {
> >                         yyerror("out of memory");
> >                         free(node);
> >                         goto bad;
> >                 }
> > -               memset(node, 0, sizeof(constraint_node_t));
> >                 if (useexpr) {
> >                         node->expr =3D expr;
> >                         useexpr =3D 0;
> > @@ -3892,13 +3882,12 @@ int define_validatetrans(constraint_expr_t * ex=
pr)
> >                         goto bad;
> >                 }
> >
> > -               node =3D malloc(sizeof(struct constraint_node));
> > +               node =3D calloc(1, sizeof(struct constraint_node));
> >                 if (!node) {
> >                         yyerror("out of memory");
> >                         free(id);
> >                         goto bad;
> >                 }
> > -               memset(node, 0, sizeof(constraint_node_t));
> >                 if (useexpr) {
> >                         node->expr =3D expr;
> >                         useexpr =3D 0;
> > @@ -4209,12 +4198,11 @@ cond_expr_t *define_cond_expr(uint32_t expr_typ=
e, void *arg1, void *arg2)
> >         }
> >
> >         /* create a new expression struct */
> > -       expr =3D malloc(sizeof(struct cond_expr));
> > +       expr =3D calloc(1, sizeof(struct cond_expr));
> >         if (!expr) {
> >                 yyerror("out of memory");
> >                 return NULL;
> >         }
> > -       memset(expr, 0, sizeof(cond_expr_t));
> >         expr->expr_type =3D expr_type;
> >
> >         /* create the type asked for */
> > @@ -4864,12 +4852,11 @@ int define_fs_context(unsigned int major, unsig=
ned int minor)
> >                 return 0;
> >         }
> >
> > -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.name =3D (char *)malloc(6);
> >         if (!newc->u.name) {
> > @@ -4924,12 +4911,11 @@ int define_pirq_context(unsigned int pirq)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.pirq =3D pirq;
> >
> > @@ -4975,12 +4961,11 @@ int define_iomem_context(uint64_t low, uint64_t=
 high)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.iomem.low_iomem  =3D low;
> >         newc->u.iomem.high_iomem =3D high;
> > @@ -5036,12 +5021,11 @@ int define_ioport_context(unsigned long low, un=
signed long high)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.ioport.low_ioport  =3D low;
> >         newc->u.ioport.high_ioport =3D high;
> > @@ -5097,12 +5081,11 @@ int define_pcidevice_context(unsigned long devi=
ce)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.device =3D device;
> >
> > @@ -5150,12 +5133,11 @@ int define_devicetree_context(void)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.name =3D (char *)queue_remove(id_queue);
> >         if (!newc->u.name) {
> > @@ -5208,12 +5190,11 @@ int define_port_context(unsigned int low, unsig=
ned int high)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         id =3D (char *)queue_remove(id_queue);
> >         if (!id) {
> > @@ -5301,12 +5282,11 @@ int define_ibpkey_context(unsigned int low, uns=
igned int high)
> >                 return 0;
> >         }
> >
> > -       newc =3D malloc(sizeof(*newc));
> > +       newc =3D calloc(1, sizeof(*newc));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(*newc));
> >
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> > @@ -5411,12 +5391,11 @@ int define_ibendport_context(unsigned int port)
> >                 return -1;
> >         }
> >
> > -       newc =3D malloc(sizeof(*newc));
> > +       newc =3D calloc(1, sizeof(*newc));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(*newc));
> >
> >         newc->u.ibendport.dev_name =3D queue_remove(id_queue);
> >         if (!newc->u.ibendport.dev_name) {
> > @@ -5484,12 +5463,11 @@ int define_netif_context(void)
> >                 return 0;
> >         }
> >
> > -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.name =3D (char *)queue_remove(id_queue);
> >         if (!newc->u.name) {
> > @@ -5615,13 +5593,12 @@ int define_ipv4_node_context(void)
> >                 yywarn("host bits in ipv4 address set");
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> >
> > -       memset(newc, 0, sizeof(ocontext_t));
> >         newc->u.node.addr =3D addr.s_addr;
> >         newc->u.node.mask =3D mask.s_addr;
> >
> > @@ -5864,13 +5841,12 @@ int define_ipv6_node_context(void)
> >                 yywarn("host bits in ipv6 address set");
> >         }
> >
> > -       newc =3D malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> >
> > -       memset(newc, 0, sizeof(ocontext_t));
> >         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
> >         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
> >
> > @@ -5975,12 +5951,11 @@ int define_fs_use(int behavior)
> >                 return 0;
> >         }
> >
> > -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.name =3D (char *)queue_remove(id_queue);
> >         if (!newc->u.name) {
> > @@ -6043,12 +6018,11 @@ static int define_genfs_context_helper(char *fs=
type, int has_type)
> >         }
> >
> >         if (!genfs || strcmp(fstype, genfs->fstype)) {
> > -               newgenfs =3D malloc(sizeof(struct genfs));
> > +               newgenfs =3D calloc(1, sizeof(struct genfs));
> >                 if (!newgenfs) {
> >                         yyerror("out of memory");
> >                         return -1;
> >                 }
> > -               memset(newgenfs, 0, sizeof(struct genfs));
> >                 newgenfs->fstype =3D fstype;
> >                 newgenfs->next =3D genfs;
> >                 if (genfs_p)
> > @@ -6061,12 +6035,11 @@ static int define_genfs_context_helper(char *fs=
type, int has_type)
> >                 fstype =3D NULL;
> >         }
> >
> > -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> > +       newc =3D calloc(1, sizeof(ocontext_t));
> >         if (!newc) {
> >                 yyerror("out of memory");
> >                 return -1;
> >         }
> > -       memset(newc, 0, sizeof(ocontext_t));
> >
> >         newc->u.name =3D (char *)queue_remove(id_queue);
> >         if (!newc->u.name)
> > --
> > 2.54.0
> >
> >
