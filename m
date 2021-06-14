Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD355C2B9F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A061361107
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhFNNjE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhFNNjE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 09:39:04 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80486C061574
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 06:37:01 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c13so14333903oib.13
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RI73grzMd+vZQIenlJtoQPzuhouHEtNCph3ICqfWHOs=;
        b=dxIpyw72QTMm0960SkZWoC+RB9QgySGURczE8vmHJ/X8m2KkycKnb9wkvQfkBBVCK/
         JEAQn9y7dXareSzM8AgmbPHXrOfBA1h20Ao0KTk9P9BP3Df3bdM5O3uBqcde06xGMIDe
         6bU8HVHKQuTQly3//O7k76xrqRKWygjMI5q7l53djxC4bQrxZbXm0/Mj/S9fdrVO4/Lo
         PSTu4FmTibShZUIoxDlKUiNTQxs5pUHYUaRO279uiBGQuxIH85UcG+bdq+YYskFN+rY6
         nXZBrPo3rQjdyKLbi7+wYOeIwS5tx5GH349xGwpZZ+2VGj+Wyu0cb0LVnWtoBeJRVA6r
         K2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RI73grzMd+vZQIenlJtoQPzuhouHEtNCph3ICqfWHOs=;
        b=JJtwrPR4XMKSOf1XZtzfbCRZN47qR5ikPvnPvNcdsaVVQBFsjiak0ZsRWyft8Xo6qZ
         0IQQfKJdFGZgZq+jdTZ5f7vQsQREDfrVKyrB2wmKkYHZpN9UmenVik+A//ZxduKTOkni
         86WggmO0tFaShRMPM+9y7gcpeSwcBhSMnl1m6KKHpYjI2GJovi/NF2rC+tTjbsEwl3E4
         9p4qoKvrDy7KCWysk1VOecXdWxK4r02XXtERTKiDnWP3f55tpV86HFzONVBMQBsk0qtI
         iyac/3Aj4TPDBAWvbh8CY/w32pOb30N+5t3CQPbD8KQYOrLOGTjez3VNkPU6XyONLQ/c
         Bkyg==
X-Gm-Message-State: AOAM533wLjrJwOjl2Vhvn4sCO+8XaHA0cWxgBL3jocnzZhdA1za5mneO
        xRBYBWyRaUK/JQ1gm2KtiehBp7q9UNz0b0AX6dc/y3htPWE=
X-Google-Smtp-Source: ABdhPJz12oKjtIjIbmFureIImToGvRkJRZHi7pZ8ORvjy3k+nCHVDAJAUfsXE/AbXLl4Wd5etkicju1rAmcnScls98Q=
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr12079661oig.138.1623677820881;
 Mon, 14 Jun 2021 06:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210608193902.55060-1-cgzones@googlemail.com> <CAP+JOzQY9VPK=wZYU=9n-MB9H7bMMsC1iV3BvAbWTQteH=BDCQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQY9VPK=wZYU=9n-MB9H7bMMsC1iV3BvAbWTQteH=BDCQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 14 Jun 2021 09:36:50 -0400
Message-ID: <CAP+JOzSnmFf=fNKz-Yt4vcPf2rgN-Urnk2kAM6niJm27-p+vdg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: quote paths in CIL conversion
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 9, 2021 at 1:40 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jun 8, 2021 at 3:46 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > When generating CIL policy from kernel or module policy quote paths,
> > which are allowed to contain spaces, in the statements `genfscon` and
> > `devicetreecon`.
> >
> > Reported by LuK1337 while building policy for Android via IRC.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_cil.c | 4 ++--
> >  libsepol/src/module_to_cil.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index 989aacde..30a27bf5 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -2654,7 +2654,7 @@ static int write_genfscon_rules_to_cil(FILE *out,=
 struct policydb *pdb)
> >                                 goto exit;
> >                         }
> >
> > -                       rc =3D strs_create_and_add(strs, "(genfscon %s =
%s %s)", 3,
> > +                       rc =3D strs_create_and_add(strs, "(genfscon %s =
\"%s\" %s)", 3,
> >                                                  fstype, name, ctx);
> >                         free(ctx);
> >                         if (rc !=3D 0) {
> > @@ -3115,7 +3115,7 @@ static int write_xen_devicetree_rules_to_cil(FILE=
 *out, struct policydb *pdb)
> >                         goto exit;
> >                 }
> >
> > -               sepol_printf(out, "(devicetreecon %s %s)\n", name, ctx)=
;
> > +               sepol_printf(out, "(devicetreecon \"%s\" %s)\n", name, =
ctx);
> >
> >                 free(ctx);
> >         }
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 496693f4..19c7c65c 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2963,7 +2963,7 @@ static int genfscon_to_cil(struct policydb *pdb)
> >
> >         for (genfs =3D pdb->genfs; genfs !=3D NULL; genfs =3D genfs->ne=
xt) {
> >                 for (ocon =3D genfs->head; ocon !=3D NULL; ocon =3D oco=
n->next) {
> > -                       cil_printf("(genfscon %s %s ", genfs->fstype, o=
con->u.name);
> > +                       cil_printf("(genfscon %s \"%s\" ", genfs->fstyp=
e, ocon->u.name);
> >                         context_to_cil(pdb, &ocon->context[0]);
> >                         cil_printf(")\n");
> >                 }
> > --
> > 2.32.0
> >
