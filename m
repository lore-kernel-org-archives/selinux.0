Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A5CC433F5
	for <selinux@archiver.kernel.org>; Tue,  8 Mar 2022 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbiCHTHf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiCHTHe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Mar 2022 14:07:34 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFF53E34
        for <selinux@vger.kernel.org>; Tue,  8 Mar 2022 11:06:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 12so211110oix.12
        for <selinux@vger.kernel.org>; Tue, 08 Mar 2022 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f/odVeabSQaQSWGvQyB/pu3P0oMzR7jj0nslElis6j8=;
        b=omB5W1ddgvfTVEIyzCTj5bbiJ6MVo9NzN0ubstCPTHDjG6DfPb18TaiLgR9Aaknt6y
         IaNuep02dgdqomNr2XV+MJ6bqmd2to60cuEMh3eBiQhtHVt4pzy9BZtmDngnf6UekYS4
         N7UHBlM2R4jNP2iq9dZKsbVp08kLnJ0XK5nOdRsIBViv2zBY61TWYlHOR2pWJcEctYTf
         k838Sf9ObgbUIs7wfMoV445yz00hzRhrEn0NpVjdHlqIYlfn/C+cwQP0SusWYx4n4920
         a7IiTfz2bmiFj+d4fYszTFzue9hpl1LLfulYMBullnzEgrzLwFjNEcvhLgisgrgO3lyE
         YZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f/odVeabSQaQSWGvQyB/pu3P0oMzR7jj0nslElis6j8=;
        b=xELDvDB8/DHM5IVr1aEiBNRUYsfcBkD67hcXgHD57MC9BmeLLmdr9fw/yZ5zM8uuYV
         iZOUAX4Kx6hfvcsv86G3WysKdH1adLKHwtKb8GKravnOksfaRyzFmsnR0AhW2MWgqICy
         dBMYz9BtIIiorvmLnqRJFQQAKXkW8XBlUfIOoA5BIQiRkCGs6bqfysYG/t8Wqb10kviS
         W80igWEUFbULe4NWfanRGshE1NnwFdBFdxudGSF+PjmaphB5zPJZUdSstu/f/uJs6vo/
         773ASCPLAeCISzNxCPyefJJfqYR2Dx+BcXU3j1C+gPgR5FtyuzYWIFAUCrDmYXHQwty1
         tOnA==
X-Gm-Message-State: AOAM532Gy2AtaoNslPAYCM8vSgECqW1qUeT+pVwc1gBnYIFB8vMyQYOY
        jW+MAUIv8qlHNSpgZdmuKBNh58oAbB+obr8lZtQ=
X-Google-Smtp-Source: ABdhPJy+BFplhpIh5vxVcvmAEdzXcfWT38zeURPe1mbizsr4H8rESMHnHBewJBpYLLPFK2K8uMVwlZr8MUiPUhN14x0=
X-Received: by 2002:a05:6808:168a:b0:2d9:77df:1a95 with SMTP id
 bb10-20020a056808168a00b002d977df1a95mr3707258oib.71.1646766395385; Tue, 08
 Mar 2022 11:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20220222135037.30497-1-cgzones@googlemail.com>
 <20220222181148.54329-1-cgzones@googlemail.com> <CAP+JOzQ+bEsoJyRhsGbJVALEzL6_VTtOvjh9f4nMzhv=nQvvig@mail.gmail.com>
In-Reply-To: <CAP+JOzQ+bEsoJyRhsGbJVALEzL6_VTtOvjh9f4nMzhv=nQvvig@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 8 Mar 2022 20:06:24 +0100
Message-ID: <CAJ2a_Ddv9gfJKkSQDGHOGyBMG=o5P73sTb5JcObXLsCvPFw6YA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: validate expressions by evaluating
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 3 Mar 2022 at 22:53, James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 9:51 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Evaluate expressions similar to the actual kernel security server such
> > that invalid expressions, e.g. `t2 =3D=3D t3` for validatetrans, are
> > rejected.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >     reject third task context in normal constraints
> > ---
> >  libsepol/src/policydb_validate.c | 226 ++++++++++++++++++++++---------
> >  1 file changed, 159 insertions(+), 67 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 735c7a33..3b0ea0e1 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -223,90 +223,182 @@ bad:
> >         return -1;
> >  }
> >
> > -static int validate_constraint_nodes(sepol_handle_t *handle, unsigned =
int nperms, constraint_node_t *cons, validate_t flavors[])
> > +/*
> > + * Follow evaluation of expressions to find invalid ones.
> > + * Keep in sync with kernel source security/selinux/ss/services.c::con=
straint_expr_eval()
> > + */
> > +static int validate_expression(sepol_handle_t *handle, constraint_expr=
_t *e, int validatetrans, validate_t flavors[])
> >  {
> > -       constraint_expr_t *cexp;
> > -
> > -       for (; cons; cons =3D cons->next) {
> > -               if (nperms > 0 && cons->permissions =3D=3D 0)
> > -                       goto bad;
> > -               if (nperms > 0 && nperms !=3D PERM_SYMTAB_SIZE && cons-=
>permissions >=3D (UINT32_C(1) << nperms))
> > -                       goto bad;
> > +       int sp =3D -1;
>
> The function read_cons_helper() is used when reading in the policy and
> it keeps track of the stack and will return an error if there is a
> problem, so I don't think that this is going to be useful when
> validating the policy.
>
> Most of what you have here is concerned with keeping track of the
> stack. There is more validation that can be done, however. See if the
> patch that I sent to the list will meet your needs.

Indeed it does (and thus renders this patch superseded).
Thanks.

>
> Thanks,
> Jim
>
>
> >
> > -               for (cexp =3D cons->expr; cexp; cexp =3D cexp->next) {
> > -                       if (cexp->attr & CEXPR_USER) {
> > -                               if (validate_ebitmap(&cexp->names, &fla=
vors[SYM_USERS]))
> > -                                       goto bad;
> > -                               if (validate_empty_type_set(cexp->type_=
names))
> > -                                       goto bad;
> > -                       } else if (cexp->attr & CEXPR_ROLE) {
> > -                               if (validate_ebitmap(&cexp->names, &fla=
vors[SYM_ROLES]))
> > -                                       goto bad;
> > -                               if (validate_empty_type_set(cexp->type_=
names))
> > -                                       goto bad;
> > -                       } else if (cexp->attr & CEXPR_TYPE) {
> > -                               if (validate_ebitmap(&cexp->names, &fla=
vors[SYM_TYPES]))
> > -                                       goto bad;
> > -                               if (validate_type_set(cexp->type_names,=
 &flavors[SYM_TYPES]))
> > -                                       goto bad;
> > -                       } else {
> > -                               if (!ebitmap_is_empty(&cexp->names))
> > -                                       goto bad;
> > -                               if (validate_empty_type_set(cexp->type_=
names))
> > -                                       goto bad;
> > -                       }
> > +       for (; e; e =3D e->next) {
> > +               /* validate symbols (implied in kernel source) */
> > +               if (e->attr & CEXPR_USER) {
> > +                       if (validate_ebitmap(&e->names, &flavors[SYM_US=
ERS]))
> > +                               goto bad;
> > +                       if (validate_empty_type_set(e->type_names))
> > +                               goto bad;
> > +               } else if (e->attr & CEXPR_ROLE) {
> > +                       if (validate_ebitmap(&e->names, &flavors[SYM_RO=
LES]))
> > +                               goto bad;
> > +                       if (validate_empty_type_set(e->type_names))
> > +                               goto bad;
> > +               } else if (e->attr & CEXPR_TYPE) {
> > +                       if (validate_ebitmap(&e->names, &flavors[SYM_TY=
PES]))
> > +                               goto bad;
> > +                       if (validate_type_set(e->type_names, &flavors[S=
YM_TYPES]))
> > +                               goto bad;
> > +               } else {
> > +                       if (!ebitmap_is_empty(&e->names))
> > +                               goto bad;
> > +                       if (validate_empty_type_set(e->type_names))
> > +                               goto bad;
> > +               }
> >
> > -                       if (cexp->expr_type =3D=3D CEXPR_ATTR || cexp->=
expr_type =3D=3D CEXPR_NAMES) {
> > -                               switch (cexp->op) {
> > -                               case CEXPR_EQ:
> > -                               case CEXPR_NEQ:
> > +               switch (e->expr_type) {
> > +               case CEXPR_NOT:
> > +                       if(sp < 0)
> > +                               goto bad;
> > +                       break;
> > +               case CEXPR_AND:
> > +                       if(sp < 0)
> > +                               goto bad;
> > +                       sp--;
> > +                       break;
> > +               case CEXPR_OR:
> > +                       if(sp < 0)
> > +                               goto bad;
> > +                       sp--;
> > +                       break;
> > +               case CEXPR_ATTR:
> > +                       if (sp =3D=3D (CEXPR_MAXDEPTH - 1))
> > +                               return 0;
> > +                       switch (e->attr) {
> > +                       case CEXPR_USER:
> > +                               break;
> > +                       case CEXPR_TYPE:
> > +                               break;
> > +                       case CEXPR_ROLE:
> > +                               switch (e->op) {
> >                                 case CEXPR_DOM:
> > +                                       ++sp;
> > +                                       continue;
> >                                 case CEXPR_DOMBY:
> > +                                       ++sp;
> > +                                       continue;
> >                                 case CEXPR_INCOMP:
> > -                                       break;
> > +                                       ++sp;
> > +                                       continue;
> >                                 default:
> > -                                       goto bad;
> > -                               }
> > -
> > -                               switch (cexp->attr) {
> > -                               case CEXPR_USER:
> > -                               case CEXPR_USER | CEXPR_TARGET:
> > -                               case CEXPR_USER | CEXPR_XTARGET:
> > -                               case CEXPR_ROLE:
> > -                               case CEXPR_ROLE | CEXPR_TARGET:
> > -                               case CEXPR_ROLE | CEXPR_XTARGET:
> > -                               case CEXPR_TYPE:
> > -                               case CEXPR_TYPE | CEXPR_TARGET:
> > -                               case CEXPR_TYPE | CEXPR_XTARGET:
> > -                               case CEXPR_L1L2:
> > -                               case CEXPR_L1H2:
> > -                               case CEXPR_H1L2:
> > -                               case CEXPR_H1H2:
> > -                               case CEXPR_L1H1:
> > -                               case CEXPR_L2H2:
> >                                         break;
> > -                               default:
> > -                                       goto bad;
> >                                 }
> > -                       } else {
> > -                               switch (cexp->expr_type) {
> > -                               case CEXPR_NOT:
> > -                               case CEXPR_AND:
> > -                               case CEXPR_OR:
> > -                                       break;
> > +                               break;
> > +                       case CEXPR_L1L2:
> > +                               goto mls_ops;
> > +                       case CEXPR_L1H2:
> > +                               goto mls_ops;
> > +                       case CEXPR_H1L2:
> > +                               goto mls_ops;
> > +                       case CEXPR_H1H2:
> > +                               goto mls_ops;
> > +                       case CEXPR_L1H1:
> > +                               goto mls_ops;
> > +                       case CEXPR_L2H2:
> > +                               goto mls_ops;
> > +mls_ops:
> > +                               switch (e->op) {
> > +                               case CEXPR_EQ:
> > +                                       ++sp;
> > +                                       continue;
> > +                               case CEXPR_NEQ:
> > +                                       ++sp;
> > +                                       continue;
> > +                               case CEXPR_DOM:
> > +                                       ++sp;
> > +                                       continue;
> > +                               case CEXPR_DOMBY:
> > +                                       ++sp;
> > +                                       continue;
> > +                               case CEXPR_INCOMP:
> > +                                       ++sp;
> > +                                       continue;
> >                                 default:
> >                                         goto bad;
> >                                 }
> > +                               break;
> > +                       default:
> > +                               goto bad;
> > +                       }
> >
> > -                               if (cexp->op !=3D 0)
> > +                       switch (e->op) {
> > +                       case CEXPR_EQ:
> > +                               ++sp;
> > +                               break;
> > +                       case CEXPR_NEQ:
> > +                               ++sp;
> > +                               break;
> > +                       default:
> > +                               goto bad;
> > +                       }
> > +                       break;
> > +               case CEXPR_NAMES:
> > +                       if (sp =3D=3D (CEXPR_MAXDEPTH-1))
> > +                               return 0;
> > +                       if (e->attr & CEXPR_TARGET)
> > +                               ;
> > +                       else if (e->attr & CEXPR_XTARGET) {
> > +                               if (!validatetrans)
> >                                         goto bad;
> > +                       }
> > +                       if (e->attr & CEXPR_USER)
> > +                               ;
> > +                       else if (e->attr & CEXPR_ROLE)
> > +                               ;
> > +                       else if (e->attr & CEXPR_TYPE)
> > +                               ;
> > +                       else
> > +                               goto bad;
> >
> > -                               if (cexp->attr !=3D 0)
> > -                                       goto bad;
> > +                       switch (e->op) {
> > +                       case CEXPR_EQ:
> > +                               ++sp;
> > +                               break;
> > +                       case CEXPR_NEQ:
> > +                               ++sp;
> > +                               break;
> > +                       default:
> > +                               goto bad;
> >                         }
> > +                       break;
> > +               default:
> > +                       goto bad;
> >                 }
> >         }
> >
> > +       if (sp !=3D 0)
> > +               goto bad;
> > +
> > +       return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid expression");
> > +       return -1;
> > +}
> > +
> > +static int validate_constraint_nodes(sepol_handle_t *handle, unsigned =
int nperms, constraint_node_t *cons, int validatetrans, validate_t flavors[=
])
> > +{
> > +       for (; cons; cons =3D cons->next) {
> > +               if (validatetrans && cons->permissions !=3D 0)
> > +                       goto bad;
> > +               if (!validatetrans && cons->permissions =3D=3D 0)
> > +                       goto bad;
> > +               if (!validatetrans && nperms !=3D PERM_SYMTAB_SIZE && c=
ons->permissions >=3D (UINT32_C(1) << nperms))
> > +                       goto bad;
> > +
> > +               if (validate_expression(handle, cons->expr, validatetra=
ns, flavors))
> > +                       goto bad;
> > +       }
> > +
> >         return 0;
> >
> >  bad:
> > @@ -320,9 +412,9 @@ static int validate_class_datum(sepol_handle_t *han=
dle, class_datum_t *class, va
> >                 goto bad;
> >         if (class->permissions.nprim > PERM_SYMTAB_SIZE)
> >                 goto bad;
> > -       if (validate_constraint_nodes(handle, class->permissions.nprim,=
 class->constraints, flavors))
> > +       if (validate_constraint_nodes(handle, class->permissions.nprim,=
 class->constraints, 0, flavors))
> >                 goto bad;
> > -       if (validate_constraint_nodes(handle, 0, class->validatetrans, =
flavors))
> > +       if (validate_constraint_nodes(handle, class->permissions.nprim,=
 class->validatetrans, 1, flavors))
> >                 goto bad;
> >
> >         switch (class->default_user) {
> > --
> > 2.35.1
> >
