Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA8C7619A
	for <selinux@archiver.kernel.org>; Thu, 30 Mar 2023 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC3Tou (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjC3Toi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Mar 2023 15:44:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716710260
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:44:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ew6so80883514edb.7
        for <selinux@vger.kernel.org>; Thu, 30 Mar 2023 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680205471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b1UhmQ0W3Xiic+7yaq6j0lSRUsA+VfBgeEt7lHpRrY=;
        b=GSRLg2Z9wNvTT8VFlKqZe0SxAvDvfJrMHLqUnK15E+iYX/e7dXg3T1rvVnFV3gbo5B
         h76lwxfz6an8xDep9/UL/qwJSVGy+2w0U6u3MvJNyLPuIy6pvcBmftx8zdtu1Fv0PP1R
         XK1u+aa7wVFDd+8NuNErM8xgFoFzCjaTfkVdbWp+PNTttjCWf+T61lvYjBec7KrqTvbP
         +fzkbTedgpgDykD79PNHVQIXr5tnc1UzJmKrsWOr1MFzhsVYxOyw2uJaCI5PaRDw7Sco
         CV+5D3O3T1Ib96MgRkLzH8tMObC1mw6k0jayyqfawTWa15seq42yebnkSUu80yOcY/GV
         8bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b1UhmQ0W3Xiic+7yaq6j0lSRUsA+VfBgeEt7lHpRrY=;
        b=PNrg8DHCgvI4HY+5cHXRdxRS3IrIR12ZpREotwuerCN62Q0DckuT95oEBe+dxipeJE
         cKP2AEP1B/ljcrs2sVg5k/iK56FxhKTmN3ZmDzKq9VIHayahZUxE1Z0qiDHSjdzmJUx0
         0C3mBURDpC3UVqfJnhCeImEw8jZ4lIRoN76Blc1B6ku3aO0KXaJ9WAee73iDQ8WxeEdx
         6Lpu+n9tNMvjRJ6/rUz6p4Yt5xA/8Vm/C0u3ipNhzD4UnCvvwxEwy30e4/QsioiuJsBx
         34GEk0NbeMoiND0bK1Z6twqArcwJh+fJhXtAy09ZGQKwGGKUSo6xhdimye2tLA8aa9MM
         0SSQ==
X-Gm-Message-State: AAQBX9cEPK3f35UqGeiCc/Z9lZ61r7hWlq9evhTtA+eanAuQ0/jqvJga
        4++LN16o9H2J/GwTE8x+4HNwvCUMn1C3DR5FhAZaizmN
X-Google-Smtp-Source: AKy350bSOLkiARXhAtkAQLr4CO62YYiWXYzTDvHXlteZ/6ClCAir5HC1IgDZMPjqGI3NtbUky36EPdupzmLtF2iaj8c=
X-Received: by 2002:a17:906:a146:b0:931:fb3c:f88d with SMTP id
 bu6-20020a170906a14600b00931fb3cf88dmr12251530ejb.5.1680205471554; Thu, 30
 Mar 2023 12:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com>
 <20221125154952.20910-7-cgzones@googlemail.com> <CAP+JOzSat=AeeMC4T5DJY=RiJW7HgUEvJ-0r9==RSET6RB404Q@mail.gmail.com>
In-Reply-To: <CAP+JOzSat=AeeMC4T5DJY=RiJW7HgUEvJ-0r9==RSET6RB404Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Mar 2023 15:44:20 -0400
Message-ID: <CAP+JOzQk0GJnGr2tPFDmeuLsMq2ZBZQ1PxrsdxikvmQmumaEUg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/6] libsepol: update CIL generation for trivial
 not-self rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 9:35=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Convert trivial not-self neverallow rules to CIL, e.g.
> >
> >     neverallow TYPE1 ~self:CLASS1 PERM1;
> >
> > into
> >
> >     (neverallow TYPE1 notself (CLASS1 (PERM1)))
> >
> > More complex targets are not yet supported in CIL and will fail to
> > convert, e.g.:
> >
> >     neverallow TYPE1 ~{ self ATTR1 } : CLASS1 PERM1;
> >     neverallow TYPE2 { ATTR2 -self } : CLASS2 PERM2;
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> I know what is needed to translate these rules to CIL, but it is going
> to require some reworking of how attributes are handled, so I think
> that it is better to take this patch for now.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This one needs to wait until my CIL notself patch is merged.
Jim

> > ---
> >  libsepol/src/module_to_cil.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index b900290a..2d5d1d6d 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1201,10 +1201,23 @@ static int avrule_list_to_cil(int indent, struc=
t policydb *pdb, struct avrule *a
> >                         goto exit;
> >                 }
> >
> > -               ts =3D &avrule->ttypes;
> > -               rc =3D process_typeset(pdb, ts, attr_list, &tnames, &nu=
m_tnames);
> > -               if (rc !=3D 0) {
> > -                       goto exit;
> > +               if (avrule->flags & RULE_NOTSELF) {
> > +                       if (!ebitmap_is_empty(&avrule->ttypes.types) ||=
 !ebitmap_is_empty(&avrule->ttypes.negset)) {
> > +                               if (avrule->source_filename) {
> > +                                       log_err("%s:%lu: Non-trivial ne=
verallow rules with targets containing not or minus self not yet supported"=
,
> > +                                               avrule->source_filename=
, avrule->source_line);
> > +                               } else {
> > +                                       log_err("Non-trivial neverallow=
 rules with targets containing not or minus self not yet supported");
> > +                               }
> > +                               rc =3D -1;
> > +                               goto exit;
> > +                       }
> > +               } else {
> > +                       ts =3D &avrule->ttypes;
> > +                       rc =3D process_typeset(pdb, ts, attr_list, &tna=
mes, &num_tnames);
> > +                       if (rc !=3D 0) {
> > +                               goto exit;
> > +                       }
> >                 }
> >
> >                 for (s =3D 0; s < num_snames; s++) {
> > @@ -1228,6 +1241,15 @@ static int avrule_list_to_cil(int indent, struct=
 policydb *pdb, struct avrule *a
> >                                 if (rc !=3D 0) {
> >                                         goto exit;
> >                                 }
> > +                       } else if (avrule->flags & RULE_NOTSELF) {
> > +                               if (avrule->specified & AVRULE_XPERMS) =
{
> > +                                       rc =3D avrulex_to_cil(indent, p=
db, avrule->specified, snames[s], "notself", avrule->perms, avrule->xperms)=
;
> > +                               } else {
> > +                                       rc =3D avrule_to_cil(indent, pd=
b, avrule->specified, snames[s], "notself", avrule->perms);
> > +                               }
> > +                               if (rc !=3D 0) {
> > +                                       goto exit;
> > +                               }
> >                         }
> >                 }
> >
> > --
> > 2.38.1
> >
