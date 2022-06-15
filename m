Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35389C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 13:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiFONrj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiFONrf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 09:47:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98A31383
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:47:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v143so15478692oie.13
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t4IGFJ5Zb1EfJqkt+PZBM02Ta5EPJxethEJDFEqJit8=;
        b=KAoDsm14kBOXzKt6Pj/2mcr1KRT692lmUVTC4T12csTULJYnQToATgz5ruYgkybPrE
         sr3jpyH8yHS8RHjjCcJ98dPqaXp4spV/Eek+6gGavbIfdIUR62bswLpHzU3PSVeVgyqP
         zShVWWHDQBplENip770HbmFpN48ZUm93ip16xkMZnKr0IF/eaHovECUcyPcpDGSBaAkP
         QNp8jKbWnY/bCC17Kc2iHUVDa7JSWCl0CU9V9KmTHTSWk/gJDbkdCahmQzqvwpxMbG1b
         ypacbqXnJEu9G/yXf2f2ksgO1W9mk+T+BJ/QFhVzEpPWn8PgjaqFw93zHmRNJaiS0EpH
         TL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t4IGFJ5Zb1EfJqkt+PZBM02Ta5EPJxethEJDFEqJit8=;
        b=gATnkSDsC5G3PG9nG3aQFfXeWjvHmkuFy3boovzUi0xPP2FnhogD7kWshhykinqgJ1
         4+kH1jYynDrwQ0c1r/WbqxMxDYBGcQ+tXi5rk6O4UzTTCP/NEclLvpmMNhygI4mJQHBr
         jx1Eltp6egzR6CXeduFZxHRwsI5xCPdUl5f1REj+2KIcUgAgzKqkjOAZFykN7h1DqouM
         up9V+R3ykVjwCAmuBCpQSpJmrLPtoGQxVGtqTvI0/5aek1azJtIWVlV4SY00CIXt4Z5t
         ek2DLidc8sO9l2tRixsmId355lvRDcFBQJHJBr3pIYWOqjYOU5Bx20oGpUDxfsjNV6xH
         aWAQ==
X-Gm-Message-State: AOAM533+nOObnzYRW0JFLu1twGwgCgbPBG0cSR1TBnAdFrDNMPsCCZTs
        j9PcGAQ/UpVnvN+CGV53H7Hk6ipe5Z3G3XmLJqvzXoBh
X-Google-Smtp-Source: ABdhPJyGEsEA8poXih0Ce3QAaKTmrND3hDfaqS6MMNNEJ0G7bCNGCkMrzjkGF4zvHbMcG9ZDdX7qyg7sRumg+vwvdzE=
X-Received: by 2002:a05:6808:20a6:b0:32f:3376:46f1 with SMTP id
 s38-20020a05680820a600b0032f337646f1mr5139318oiw.182.1655300853605; Wed, 15
 Jun 2022 06:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220607150145.29757-1-cgzones@googlemail.com> <CAP+JOzT+AaQgOa1T0zxVOERwQZnjkkQ0dGiiarHbPCxVJo7pFg@mail.gmail.com>
In-Reply-To: <CAP+JOzT+AaQgOa1T0zxVOERwQZnjkkQ0dGiiarHbPCxVJo7pFg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 09:47:22 -0400
Message-ID: <CAP+JOzRdX4x+2LQf+dY6Q5i-Y+J2-_z+S7ygXaBn=JDNA1Qxpw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix validation of user declarations in modules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>, bauen1 <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 2:41 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jun 7, 2022 at 11:54 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Users are allowed to be declared in modules. Modules do not get expande=
d
> > leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
> > empty.
> > Do no validate the expanded range and level for modular polices.
> >
> > Reported-by: bauen1 <j2468h@gmail.com>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index da18282b..99d4eb7f 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -18,7 +18,7 @@ typedef struct validate {
> >  typedef struct map_arg {
> >         validate_t *flavors;
> >         sepol_handle_t *handle;
> > -       int mls;
> > +       policydb_t *policy;
> >  } map_arg_t;
> >
> >  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebit=
map_t *gaps)
> > @@ -571,7 +571,7 @@ static int validate_mls_range(mls_range_t *range, v=
alidate_t *sens, validate_t *
> >         return -1;
> >  }
> >
> > -static int validate_user_datum(sepol_handle_t *handle, user_datum_t *u=
ser, validate_t flavors[], int mls)
> > +static int validate_user_datum(sepol_handle_t *handle, user_datum_t *u=
ser, validate_t flavors[], policydb_t *p)
> >  {
> >         if (validate_value(user->s.value, &flavors[SYM_USERS]))
> >                 goto bad;
> > @@ -581,9 +581,9 @@ static int validate_user_datum(sepol_handle_t *hand=
le, user_datum_t *user, valid
> >                 goto bad;
> >         if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_=
LEVELS], &flavors[SYM_CATS]))
> >                 goto bad;
> > -       if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LE=
VELS], &flavors[SYM_CATS]))
> > +       if (p->mls && p->policy_type !=3D POLICY_MOD && validate_mls_ra=
nge(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> >                 goto bad;
> > -       if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SY=
M_LEVELS], &flavors[SYM_CATS]))
> > +       if (p->mls && p->policy_type !=3D POLICY_MOD && validate_mls_le=
vel(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> >                 goto bad;
> >         if (user->bounds && validate_value(user->bounds, &flavors[SYM_U=
SERS]))
> >                 goto bad;
> > @@ -599,7 +599,7 @@ static int validate_user_datum_wrapper(__attribute_=
_((unused)) hashtab_key_t k,
> >  {
> >         map_arg_t *margs =3D args;
> >
> > -       return validate_user_datum(margs->handle, d, margs->flavors, ma=
rgs->mls);
> > +       return validate_user_datum(margs->handle, d, margs->flavors, ma=
rgs->policy);
> >  }
> >
> >  static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum=
_t *boolean, validate_t flavors[])
> > @@ -689,7 +689,7 @@ static int validate_datum(__attribute__ ((unused))h=
ashtab_key_t k, hashtab_datum
> >
> >  static int validate_datum_array_entries(sepol_handle_t *handle, policy=
db_t *p, validate_t flavors[])
> >  {
> > -       map_arg_t margs =3D { flavors, handle, p->mls };
> > +       map_arg_t margs =3D { flavors, handle, p };
> >
> >         if (hashtab_map(p->p_commons.table, validate_common_datum_wrapp=
er, &margs))
> >                 goto bad;
> > --
> > 2.36.1
> >
