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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF5C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B483613A7
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 13:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhHXNeB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbhHXNd7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 09:33:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449BC0613C1;
        Tue, 24 Aug 2021 06:33:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k24so19790111pgh.8;
        Tue, 24 Aug 2021 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xBb3ZyQvb4VRddrOmbezmniUyEwoDvBRNY4xhO/mzFE=;
        b=pmqylbIkUXIiBjp2a0mSg7vZamKOTdoF4mgWbJiekfcmePrnq/uH0McSwzV8vx+BDD
         xg7+WJYiO5J5OLbSRVPi5kegrODWIU4Rggz+DFfbvG7CYQR1GW3jTSvzM7XO7m/PHkxr
         c8kTEAAAIb2IZzANhR6N+RueVnfcwcv7sT8oFWW19w9MJyEizfcZHLPepDXTwXJLuln5
         5NLU647zmxE9P8cINDdIESQm3pbS5RMlW3byZjEkBCvbA3ULBW0y8ltWuiQKIFNFjrix
         i4PaV30q2OX7XAcZ3XcNxoaCGfg8cepANkr61wTanFJANcQ5bM6rPeKFA2zYiOZ2wIj9
         Em+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xBb3ZyQvb4VRddrOmbezmniUyEwoDvBRNY4xhO/mzFE=;
        b=f15Wk6ImD/l71EtedNi7X1aF33iDNLOcgVsAR3TGGI7ROusmEsAxoMUJSwM9ixbPAz
         HQDhlUkoQofm0YNWTEG0iFvZ0IkosW+NpJ3sd3N8TEwuNt8B8GVj03GXxAjGZg1s0JDT
         Y6N+gCdrtF1aPNbePeZ6uumYCg9elbCbc8Yl+VZomMzPMxrWqTja8941BnyZYM1fv1/s
         ZSfwP+lPxELwJfgMKjs3zy7aT8zQ50tuWHVfWR86bpdSbaxVd8VxX8yQDhCYwwWwaEqo
         uTA2FKY95NU9ISh3hq1wJNQWdlPL6I14h5F+9lco0q024x1Wu+FJlZvbefQDj0+0e24I
         298g==
X-Gm-Message-State: AOAM531dXzz5AAbFGEHeEpEX0edmc81t+Avzfs5kKQFV+YzzGwpuXdjZ
        pXOCoWSBJHZRoQlX89xCu59m7ydsT7yBtXDr9+U=
X-Google-Smtp-Source: ABdhPJwxcOT7TmMuiwZFQsYDdZuJgMjPnGvfI/orQEq5Y7KMzmQGBalj1yi2QRtldSf4ofUiYdNzULvZmKyJBGWhGJs=
X-Received: by 2002:a63:2242:: with SMTP id t2mr36064978pgm.111.1629811994392;
 Tue, 24 Aug 2021 06:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210824022247.GA22908@raspberrypi> <CAFqZXNuOnMpV4RJDej2tp8_2OkZLuxuC9X7jBpKGs00MAQADPQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuOnMpV4RJDej2tp8_2OkZLuxuC9X7jBpKGs00MAQADPQ@mail.gmail.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Tue, 24 Aug 2021 22:33:03 +0900
Message-ID: <CADLLry6kOGBEjfGYjS=4qCU_V=0deJLQKqeNXTsx3Hp8XEFh-Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com, =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:28, O=
ndrej Mosnacek <omosnace@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Austin,
>
> On Tue, Aug 24, 2021 at 4:23 AM Austin Kim <austindh.kim@gmail.com> wrote=
:
> >
> > From: Austin Kim <austin.kim@lge.com>
> >
> > The local variable 'i' is used to be incremented inside while loop
> > within sidtab_convert_tree(). Before while loop, 'i' is set to 0
> > inside if/else statement.
> >
> > Since there is no 'goto' statement within sidtab_convert_tree(),
> > it had better initialize 'i' as 0 once before if/else statement.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
> > ---
> >  security/selinux/ss/sidtab.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.=
c
> > index 656d50b09f76..301620de63d3 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -374,7 +374,7 @@ static int sidtab_convert_tree(union sidtab_entry_i=
nner *edst,
> >                                struct sidtab_convert_params *convert)
> >  {
> >         int rc;
> > -       u32 i;
> > +       u32 i =3D 0;
> >
> >         if (level !=3D 0) {
> >                 if (!edst->ptr_inner) {
> > @@ -383,7 +383,6 @@ static int sidtab_convert_tree(union sidtab_entry_i=
nner *edst,
> >                         if (!edst->ptr_inner)
> >                                 return -ENOMEM;
> >                 }
> > -               i =3D 0;
> >                 while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
>
> I must say I prefer the original version more, because it makes it
> clear when you look at the loop that it starts at 0. Once you move the
> initialization to the declaration section, readers will have to scan
> the code upwards to find it out.

Thanks for sharing the full story of the original version.

The original code is more readable since 'i' is mainly used
in 'for' loop rather than 'while' loop. Also agreed that
reader might attempt to scan the initial value of 'i'.

Thanks,
Austin Kim

 As is, it's also less prone to error
> if e.g. someone adds another loop before the existing ones and reuses
> the variable.
>
> In case anyone is wondering why I didn't make these for loops when I
> wrote this code: Since the loop condition a little more than the usual
> "for(i =3D 0; i < n; i++)" pattern, my intention was to emphasize that
> this is not a "regular" for loop and that readers should read the loop
> carefully to not miss something. But perhaps that's not a good reason
> and they would look more natural as for loops. If others think a for
> loop would look better here, I'd be OK with a patch that makes these
> into for loops instead.
>
> >                         rc =3D sidtab_convert_tree(&edst->ptr_inner->en=
tries[i],
> >                                                  &esrc->ptr_inner->entr=
ies[i],
> > @@ -400,7 +399,6 @@ static int sidtab_convert_tree(union sidtab_entry_i=
nner *edst,
> >                         if (!edst->ptr_leaf)
> >                                 return -ENOMEM;
> >                 }
> > -               i =3D 0;
> >                 while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
> >                         rc =3D convert->func(&esrc->ptr_leaf->entries[i=
].context,
> >                                            &edst->ptr_leaf->entries[i].=
context,
> > --
> > 2.20.1
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
