Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F1C83000
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BD920774
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9NUQy2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD3OZM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgD3OZM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:25:12 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FAC035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:25:12 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j4so5002521otr.11
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6J4FxHCEdk10CBo+Po1s+85lELeQ5j7kYMw+l3qQfw=;
        b=H9NUQy2figO24KUygNzYS0j6EjUU8tMguaAJdoKodzPaXJzApYgw5x0sS/WubsKFBT
         ClSNYz3we2QDK77ew2odAK978IEDbAfmmP9osf6frTm0iXNNNCkHjnwRD2bzPbZAQQSk
         AwXobJX5Vd9JWDpZULsJCF4BpUbSwTuSSKlp50gW28+KfLoHrW06l8varrYO+Ldy3x5M
         7mtqvitB3XrbE+hg2BKC2CGm0Da3speT98DGxyEgwuvi81hHZaNkKw1Qp/1GvzcEmO/d
         agbJIkrY07+JubduyLUqaA3oIJyj2L/HoxEMS7m2AIJy/tBlLeBoHx4eYzn51mfrsFsB
         9HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6J4FxHCEdk10CBo+Po1s+85lELeQ5j7kYMw+l3qQfw=;
        b=rWRMOA5DyajTejqNeYnqKrpxqLYBKhCG0VU0bOzcxhd/fgzKxM4w+XVGu6Jt94b1wP
         vFgJFcFmN614lq4lTTThe4TnvvdbgxjeL/EhMUigfnDEI/lkKfOQX9FRHdzLr7MaYNEy
         K50akTvn6RSkVv/OeMn/cXA115Bo5TneL+hg5Mu8RySnbK4pvoEet2QCPYO6UywgM/nK
         +5RLa6nNRgRZem27rdRLMTe1LaZSKn0gIyxqFzKhXltMQ1/KYogHdiQbwZVKiISE/cK9
         FrIrf+BXwLeJlLr9ZxatUlPUM6c17PRAyxKBf6mOLav5sJWSE8xnBl2EbdReC+NBCoBL
         hArg==
X-Gm-Message-State: AGi0PuYSFWPjEKsOvzNzQaltJbD1LrZVAeIoui5oqE1EFq9OKNmaRuhU
        dFapZZb9++ZPxSIawTEzmD6r2nOrg6UkVZC5zqI=
X-Google-Smtp-Source: APiQypL9jO6g2BWkYTnvksP/sIdKl40DhsbR6oWo+zwYlPjb94koBvJTeN5l5Qzh0idr+a8jfzcQ/8n/KFRMo31Omw4=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr2800951otb.162.1588256711600;
 Thu, 30 Apr 2020 07:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200328124550.199568-1-omosnace@redhat.com> <20200328124550.199568-3-omosnace@redhat.com>
 <CAP+JOzTu=ziLHGgFfu6Do_yXV3eWQDA2hUEenYHP3StT64R=Bg@mail.gmail.com>
 <CAP+JOzRYAJgb3BZTJ5wodkat7kyqRED__Wp7oW6n-2Lj6J4yqQ@mail.gmail.com>
 <CAFqZXNsqfDw1SuW+69L776iw_J6CKKsrSjEivVnG_T3X20HXOA@mail.gmail.com> <CAP+JOzQMofOxLTSpDipzh52sWnKQT6bQ4dmY-AD_5NN=67mx4g@mail.gmail.com>
In-Reply-To: <CAP+JOzQMofOxLTSpDipzh52sWnKQT6bQ4dmY-AD_5NN=67mx4g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Apr 2020 10:25:00 -0400
Message-ID: <CAEjxPJ74rdziWudbtmbAm-UceJQtNePP_o-CWkyQZ7yONALYBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     James Carter <jwcart2@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 11:29 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Apr 28, 2020 at 4:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Mon, Apr 27, 2020 at 9:39 PM James Carter <jwcart2@gmail.com> wrote:
> > > On Tue, Mar 31, 2020 at 4:30 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > On Sat, Mar 28, 2020 at 8:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Implement a new, more space-efficient form of storing filename
> > > > > transitions in the binary policy. The internal structures have already
> > > > > been converted to this new representation; this patch just implements
> > > > > reading/writing an equivalent representation from/to the binary policy.
> > > > >
> > > > > This new format reduces the size of Fedora policy from 7.6 MB to only
> > > > > 3.3 MB (with policy optimization enabled in both cases). With the
> > > > > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> > > > >
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > >
> > > > Acked-by: James Carter <jwcart2@gmail.com>
> > > >
> > >
> > > Sorry, it has been a while.
> >
> > No problem. I would've merged it myself, I just wasn't sure if we
> > shouldn't try to do something about the setools issue somehow... But I
> > really don't feel like touching that code, so if the consensus is that
> > this is worth the breakage then I'm fine with it :)
> >
>
> I thought the consensus was to apply this now, but it would be nice to
> not break setools, so I am going to hold off merging for day or two
> and take a look at how much work it would be to export what setools
> needs.

There was an earlier discussion about whether we ought to make another
selinux userspace release soon.
If so, we should defer applying this change until after that release
to avoid breaking setools with no fix
in sight for it.
