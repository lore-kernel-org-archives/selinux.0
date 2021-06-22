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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B4C48BDF
	for <selinux@archiver.kernel.org>; Tue, 22 Jun 2021 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAA360725
	for <selinux@archiver.kernel.org>; Tue, 22 Jun 2021 13:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFVNlV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFVNlU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jun 2021 09:41:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA02C061756
        for <selinux@vger.kernel.org>; Tue, 22 Jun 2021 06:39:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t40so23777468oiw.8
        for <selinux@vger.kernel.org>; Tue, 22 Jun 2021 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylJX21gBwKT0I1/+IJ11AFRJjSc6E/YEFXWARBrelp4=;
        b=ZgsFDyGNu/x5nNkgWT/5gMgu3yAu/rjnJD4f/blkt7b3vcj3uUVO9SD99K3+2FxIwo
         miNJbLl+flgvxnxybTNFFKXgf/r6KRbtgFlko1LwGGXYXTzf9gLxO7NaHtoy5CnhFpxa
         WM9CQYwyDtbsomhJBiQ9zW97MchHXrapjiJPA2eUv0CgpRp+FcoFxFbguqXiPY4MN3Sf
         I/0Vv4DBw59iAGMP8spR3C9Bv8zUzSrSvnapO3m/rYe4L6pEqvjuCMxbB0DdHzV0kW+K
         drmkTYI1GZ4eZFRDGJvN0jxHbUTFJR6QLD7wEhNryfkBkuWQwYrJA4rNasvVB47kPQe9
         MHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylJX21gBwKT0I1/+IJ11AFRJjSc6E/YEFXWARBrelp4=;
        b=HFLfFS5AN5s5yX7Jxy9PDRNQsNnx8dKDkDl75NQwSnS2/kPf2EGZqwRH+MLa5yzxIz
         JD8x+hsRWuro6yvsKZT8zQ+G2Qa6R+4314omendMURNfcOYy7o/JiypqGwoJ0GdzYgVV
         DO/QRLEwHXld+JjNRehoh71e0JdD/s6vnhpE0dFhjnTtDckV/UrmE8IXnpmSs8Q0WWm3
         Ihf95EBQNHCE4xHoleu58BSsG8fqfVIGrxvFSh5TzmCog9t0GNWCfuRrc6zCPdvsyVga
         2NtwvNQSwBAUZ+4JnALgnUgsWAfbMLtKq4mstJdmnZeTBLb/WgA3M3TOREFPhumcdeT/
         AxFw==
X-Gm-Message-State: AOAM530n2yGHMBs7kxVxPqTV0Y0DGPTm2nlQX9e/VnfV3W22lCcDL0cH
        kK+YzILENimSZVZKNwfw4NKT7OoBUTPmxd+0WE4=
X-Google-Smtp-Source: ABdhPJyQmiXLPPbMX84vdfsCc+2tJeh+gW5S4HR3H6nsH50sLKursY77P4Jbf3URcv2yamNV+BipEgDrVm7GMMkPgwc=
X-Received: by 2002:a05:6808:903:: with SMTP id w3mr702411oih.16.1624369143472;
 Tue, 22 Jun 2021 06:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210616144843.79344-1-jwcart2@gmail.com> <87mtrn1ay3.fsf@redhat.com>
In-Reply-To: <87mtrn1ay3.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 22 Jun 2021 09:38:52 -0400
Message-ID: <CAP+JOzRokFq2R93rKdT1nWNZjRtWLS0=21AJLECSPvSzW5BENQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Quote paths when generating policy.conf from
 binary policy
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 18, 2021 at 10:53 AM Petr Lautrbach <plautrba@redhat.com> wrote=
:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Christian G=C3=B6ttsche <cgzones@googlemail.com> submitted a similar pa=
tch
> > to quote paths when generating CIL policy from a binary policy.
> >
> > Since genfscon and devicetreecon rules have paths which are allowed
> > to contain spaces, always quote the path when writing out these rules.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

This has been merged.
Jim

>
>
> > ---
> >  libsepol/src/kernel_to_conf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 5db47fe4..ffdf179a 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -2527,7 +2527,7 @@ static int write_genfscon_rules_to_conf(FILE *out=
, struct policydb *pdb)
> >                               goto exit;
> >                       }
> >
> > -                     rc =3D strs_create_and_add(strs, "genfscon %s %s =
%s", 3,
> > +                     rc =3D strs_create_and_add(strs, "genfscon %s \"%=
s\" %s", 3,
> >                                                fstype, name, ctx);
> >                       free(ctx);
> >                       if (rc !=3D 0) {
> > @@ -2992,7 +2992,7 @@ static int write_xen_devicetree_rules_to_conf(FIL=
E *out, struct policydb *pdb)
> >                       goto exit;
> >               }
> >
> > -             sepol_printf(out, "devicetreecon %s %s\n", name, ctx);
> > +             sepol_printf(out, "devicetreecon \"%s\" %s\n", name, ctx)=
;
> >
> >               free(ctx);
> >       }
> > --
> > 2.26.3
>
