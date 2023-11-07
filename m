Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF5C4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjKGVms (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjKGVms (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:42:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D110DB
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:42:45 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd19eac8so8032822e87.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393364; x=1699998164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaKJNnrbw1cYs3VHow5V2gGajmBRCawkDBXFo+0tI6E=;
        b=QKRDsQEPkRo/Xwdf0op+ZeIvi5Xh6U2U6mGvjanB7YV0P07Z4suey8ToBPmfR90CqV
         cVHAnqc91nQdfe1zbSQKDkvioUMCVdONsnGnDp2lQOL1ySWUGKGrb7EiSrSTaglzdnfa
         EJEDw0U6yM04oJrIXN4Wu+Pv91OG8flb6Ym7lEdmsdSPXR/hCBNj8ErvdVQCCHqVRhxf
         tCTJdNwLbrJmo2IYVo2ozZ3jroJ/D+7qS057/2iOiMktNDU/FH1qYiuWxFVgv6ixupOq
         FzgpofqcZGzkHDJSGZXQMV/ax4vS/TRWjmC2IJg1G9rtke5uOdJQ9b4vDyos7+kC7kyP
         hbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393364; x=1699998164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaKJNnrbw1cYs3VHow5V2gGajmBRCawkDBXFo+0tI6E=;
        b=LaPLevzZiLrIU9nE68Qkp8pEZSk1Zwf8Hi3m159hhnmqcUf70IEusY1+k9msrIDcWp
         A2zdqSaA0Y3+qxYkg2KUkD9NxX/OCj6uM5yz9GdOHTh7kzDQKYKMBq42HK3xF5n8jZtI
         xytZwynjYethZYB6hkPXbtiIwuXEm6942KYLA3eEkSJhJjBhaLyrJM3pJwpe15jgVqxe
         X7TqUrtJyED1yliByvJ2+X8G3LYNLhqfm//KU250Jw6u0jPJPYVSmneJ/srcuoRhouli
         sojPRSgU9c15oadhlE93fL0UrVa2wBctf/5/AJXVquwfhe53XbPhfsIJ9+MsNqIMNrfV
         ZK+w==
X-Gm-Message-State: AOJu0YwjPNM3R6G8UdAgSD8i+NNmPr/iUC6UveoPYpEyaWnG9UoZZgJ3
        47unIVdjBoefL6iNRiKMQMoJ4xRieunlkPvsn5v1xHV/
X-Google-Smtp-Source: AGHT+IG0q+DgYsKaFoIZw8/b4WBcUWALClLHl43isxWaCVI1SRJcRhf2LINFfvWQm/us5noR6jERfRoosF6VvucVxfA=
X-Received: by 2002:ac2:5634:0:b0:507:aaab:528c with SMTP id
 b20-20020ac25634000000b00507aaab528cmr23963337lff.69.1699393364148; Tue, 07
 Nov 2023 13:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20231103182637.85003-1-cgzones@googlemail.com> <CAP+JOzRS4ErNLz-tERjzuqWxot2OW7N6se0p9f5dBmGwU_-GJg@mail.gmail.com>
In-Reply-To: <CAP+JOzRS4ErNLz-tERjzuqWxot2OW7N6se0p9f5dBmGwU_-GJg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:42:32 -0500
Message-ID: <CAP+JOzTwgYNtwA_rv45LWHmXZaYBoFqg3e2SrPbze91mBJQ5pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: validate default type of transition is
 not an attribute
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 6, 2023 at 9:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The default type of a type transition must be a regular type, not an
> > attribute.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> > v2:
> >   fix build error by supplying necessary arguments to
> >   validate_simpletype()
> > ---
> >  libsepol/src/policydb_validate.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 892a0ffd..810c3263 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -468,7 +468,7 @@ static int validate_role_datum_wrapper(__attribute_=
_((unused)) hashtab_key_t k,
> >         return validate_role_datum(margs->handle, d, margs->flavors);
> >  }
> >
> > -static int validate_simpletype(uint32_t value, const policydb_t *p, va=
lidate_t flavors[])
> > +static int validate_simpletype(uint32_t value, const policydb_t *p, co=
nst validate_t flavors[SYM_NUM])
> >  {
> >         const type_datum_t *type;
> >
> > @@ -1094,7 +1094,9 @@ static int validate_filename_trans(hashtab_key_t =
k, hashtab_datum_t d, void *arg
> >  {
> >         const filename_trans_key_t *ftk =3D (filename_trans_key_t *)k;
> >         const filename_trans_datum_t *ftd =3D d;
> > -       validate_t *flavors =3D (validate_t *)args;
> > +       const map_arg_t *margs =3D args;
> > +       const validate_t *flavors =3D margs->flavors;
> > +       const policydb_t *p =3D margs->policy;
> >
> >         if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
> >                 goto bad;
> > @@ -1105,7 +1107,7 @@ static int validate_filename_trans(hashtab_key_t =
k, hashtab_datum_t d, void *arg
> >         for (; ftd; ftd =3D ftd->next) {
> >                 if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES])=
)
> >                         goto bad;
> > -               if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
> > +               if (validate_simpletype(ftd->otype, p, flavors))
> >                         goto bad;
> >         }
> >
> > @@ -1115,9 +1117,11 @@ bad:
> >         return -1;
> >  }
> >
> > -static int validate_filename_trans_hashtab(sepol_handle_t *handle, has=
htab_t filename_trans, validate_t flavors[])
> > +static int validate_filename_trans_hashtab(sepol_handle_t *handle, con=
st policydb_t *p, validate_t flavors[])
> >  {
> > -       if (hashtab_map(filename_trans, validate_filename_trans, flavor=
s)) {
> > +       map_arg_t margs =3D { flavors, handle, p };
> > +
> > +       if (hashtab_map(p->filename_trans, validate_filename_trans, &ma=
rgs)) {
> >                 ERR(handle, "Invalid filename trans");
> >                 return -1;
> >         }
> > @@ -1555,7 +1559,7 @@ int policydb_validate(sepol_handle_t *handle, con=
st policydb_t *p)
> >                 if (validate_role_allows(handle, p->role_allow, flavors=
))
> >                         goto bad;
> >                 if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
> > -                       if (validate_filename_trans_hashtab(handle, p->=
filename_trans, flavors))
> > +                       if (validate_filename_trans_hashtab(handle, p, =
flavors))
> >                                 goto bad;
> >         } else {
> >                 if (validate_avrule_blocks(handle, p->global, p, flavor=
s))
> > --
> > 2.42.0
> >
