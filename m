Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B98C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D170206D8
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 18:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awM36EzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOSvl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSvk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 14:51:40 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0AC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 11:51:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w22so2732160otp.5
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQGu1NbYrp06IlZNdKafgQ+J/d17n6HBXJxxCNFH0vQ=;
        b=awM36EzYtgW0aaA+KWDwjBA8x9ajyLujPXiAAWimPphWehQV3MZVEn1sr+o0Nwei19
         PMmhB8LQ5pqBHDsqciw6c3BqA3ck/2UgCPHSlwO3o5z88Nun4ZXkd/F/JBjrxP07LqbV
         EBznOxPQMRx+eNuXRTi9/h+aS7tSjIXY9NCM+AsaIS3x75CSv21Y+2/q9ZO7ZysZ2wkb
         H16mB4KUwD4lx42kHsri1vRVS049YV0mtSPIQg6kUylzyKyO10uV9P2lzs/2Ot8wUJTn
         fS1BWdD4sGE9KMh13IJvQzoP0OMNVGJJrlbxTu2fDIUGb7BorNvcWmkK9FhNRWbGpHu8
         UA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQGu1NbYrp06IlZNdKafgQ+J/d17n6HBXJxxCNFH0vQ=;
        b=FaThRFDk26g+l7H9imX6oE9bYsk6qzpPfNwb/eGgnXxJQtghZH/4TjSUe/RN+rPFfG
         6mRSJ33SMot/9pbWNttO2Ru/y/HZwdwzVx4juniShQrAAEEdDuEsU7YcY6tBiIrWzMAh
         w2a0t0Rca82jg/3IyDCW0xVfF9ga8Kxn34ZnHJA4sOH0Oxt56A31R2ow3p9ghN0qeEte
         aPi5szMdlaOAAiPSfR9GtTzZMMdyyol4gJQHdq0vB7vuRaZ6aW1YQdcQWCg1Z9OGmcOO
         uLP8fH4ZZPfRD3kFoJYoddx5ovOvkH4a/3G4KscaG+Fz0w5aTRvv1JE2O6ogsxjDtxyK
         Vo8Q==
X-Gm-Message-State: AOAM533eo/TO024JW/Cb+g7abSIme7VMAFPUury0Okbp6VdoB7xFpXay
        fGneblDIKHVPE6xCGkjma2pb550HUXOo66qxxOc=
X-Google-Smtp-Source: ABdhPJz5BLP7iRiGAITFB94Ye5tm/wBA51Uwzo9tbQbUF+8AKyzGN2X9LvUgoT1VB6oUG7jUSlsIYsDp0FxfHT0Vnqc=
X-Received: by 2002:a05:6830:1152:: with SMTP id x18mr3121660otq.89.1589568700069;
 Fri, 15 May 2020 11:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com> <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
In-Reply-To: <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 15 May 2020 14:51:29 -0400
Message-ID: <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 2:11 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > The text above states that kernel-devel is needed, but it's missing from
> > > the dnf command.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  README.md | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/README.md b/README.md
> > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > --- a/README.md
> > > +++ b/README.md
> > > @@ -77,7 +77,8 @@ following command:
> > >                 kernel-devel \
> >
> > It's actually right there already ^^
>
> Yeah that's the foot cannon, I thought I was good, but you need the
> specific ones
> as Ondrej pointed out to me.
>
> >
> > >                 quota \
> > >                 xfsprogs-devel \
> > > -               libuuid-devel
> > > +               libuuid-devel \
> > > +               kernel-devel-$(uname -r)
> >
> > I proposed adding the -$(uname -r) before, but there were some valid
> > counterarguments. See the discussion here:
> > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> >
>
> Arguments for why the dnf command should have it with uname:
> 1. We tried to add it twice, it's bit people twice.
> 2. The README states "On a modern Fedora system you can install these
> dependencies with the following command:"
>     - which is wrong, you need the specific package
>     - If you're going to provide a "dnf install" or a apt-get install,
> it should just work
>     - the apt-get example has uname -r in it.
>     - so the precludes building your own kernel, if you do that as
> Paul stated, you're on your own. (lore comment)

I'm ok with adding it.
