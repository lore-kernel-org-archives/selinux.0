Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F89DC433E3
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FE420709
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZu0ulAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOTks (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOTkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 15:40:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BFC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 12:40:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id x5so4015592ioh.6
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4v2kdPmTdIA5NDkTILdTczYXs3T7D+XJEkY4i5zO+0=;
        b=WZu0ulAZi6zgTVHvxBm2aNKBZrN+4u9o84EmhzOFN14Cez/r+DLssBnubHlBW55c2W
         IPbr6brEc0xXv1T1PUtyboT/DbBxPk8f1eJV2ZrrBURLlV4+TWP/NYlN5REmppkI1hBP
         gZVCldI1oTIrSUGNDRF5Gf1o/9yxSGn030f3F/jfR0a+C6rkN6fT9GO8fFQtKbEpdGdj
         8W+soqzdKmG7OTDKoumpuIMYUXKaxZkwedLJi+LFF03/rKiSLc8thZmdoPde4iPu50Z3
         EG51YZecPssjvYJjD1HbgKBOMkgkxggkocd/s7MAZujHBoYwp5TAFcDo95/pzTHaYCGQ
         0Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4v2kdPmTdIA5NDkTILdTczYXs3T7D+XJEkY4i5zO+0=;
        b=dF4Jt7RciGnHhyE5tZweEK/tY4tP84dKyJI+8gEhnEb5GwtFYdWHKtWpmhyfI7wlfD
         Pu12mkoTgooAm1yITa/GtdyGKOGFDTFcgnkn57WHYt+KUFFdj6W7uJufYYYFLPp9IeRX
         gRFLeTWvhqLM9WiSPvaFvk7/RCBaShxpmyd8uLX5rfPtQbpwZJ7/Vd52hp+B2SDcqSMw
         6aVRIyBuxmoGOwpZv+poQFupl5Qui1p39EILXhCR3lBrrzw+IxSVQCx3SNkL/HB5P9PK
         8fE+BN/Vdt1tECK2Cz8kQm0uE7p0rcEyCwMXy8nb8Q8TnTxnbL7XKD4TOC00Df6BLeZ9
         pOqw==
X-Gm-Message-State: AOAM531CUaWjgAaGZ78HM1qA8sNMte0e9jOyql+SNqzFrZr+YdU/h0BP
        YGBEoP46cbd8isvGEFXJKGdoibeNWxAH+n9EzQ9iLglE
X-Google-Smtp-Source: ABdhPJwxszxvHQ9U/7Dhmuyv7d0637PFbSOfWu5y2YMCZm6OLAKbd4iPXF5zBumGehwNzbxJ4ltVGOhOtSrCZhLZoSg=
X-Received: by 2002:a05:6638:1131:: with SMTP id f17mr4587237jar.61.1589571646926;
 Fri, 15 May 2020 12:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
 <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
 <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com> <CAEjxPJ7Uh_suR=ye0xihUapnU3nHcqLZUG34h_-NmG7XVrmb-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Uh_suR=ye0xihUapnU3nHcqLZUG34h_-NmG7XVrmb-A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 14:40:35 -0500
Message-ID: <CAFftDdrsx+ga_snRGAL++nSfN-WH1pHs3=ObC=zgbJGo4iMj8Q@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 2:36 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 3:27 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, May 15, 2020 at 1:51 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, May 15, 2020 at 2:11 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > > >
> > > > > > The text above states that kernel-devel is needed, but it's missing from
> > > > > > the dnf command.
> > > > > >
> > > > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > > > ---
> > > > > >  README.md | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/README.md b/README.md
> > > > > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > > > > --- a/README.md
> > > > > > +++ b/README.md
> > > > > > @@ -77,7 +77,8 @@ following command:
> > > > > >                 kernel-devel \
> > > > >
> > > > > It's actually right there already ^^
> > > >
> > > > Yeah that's the foot cannon, I thought I was good, but you need the
> > > > specific ones
> > > > as Ondrej pointed out to me.
> > > >
> > > > >
> > > > > >                 quota \
> > > > > >                 xfsprogs-devel \
> > > > > > -               libuuid-devel
> > > > > > +               libuuid-devel \
> > > > > > +               kernel-devel-$(uname -r)
> > > > >
> > > > > I proposed adding the -$(uname -r) before, but there were some valid
> > > > > counterarguments. See the discussion here:
> > > > > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> > > > >
> > > >
> > > > Arguments for why the dnf command should have it with uname:
> > > > 1. We tried to add it twice, it's bit people twice.
> > > > 2. The README states "On a modern Fedora system you can install these
> > > > dependencies with the following command:"
> > > >     - which is wrong, you need the specific package
> > > >     - If you're going to provide a "dnf install" or a apt-get install,
> > > > it should just work
> > > >     - the apt-get example has uname -r in it.
> > > >     - so the precludes building your own kernel, if you do that as
> > > > Paul stated, you're on your own. (lore comment)
> > >
> > > I'm ok with adding it.
> >
> > Does anyone want to ack this one?
>
> To be clear, we should just replace "kernel-devel" in the dnf command
> with "kernel-devel-$(uname -r)" assuming that works.
> Not just add it in addition to the existing kernel-devel line.

Ahh, Ok.

>
> > Ok I found another one, kernel-modules-extra is needed for the sctp module.
> >
> > The tests expect sctp support, should we conditionally skip these if
> > sctp is not enabled?
> > Whats the best way of checking for that proto if we want this? just an
> > ls of /proc/sys/net:
> > ls /proc/sys/net/
> > bridge  core  ipv4  ipv6  netfilter  nf_conntrack_max  sctp  unix
>
> Currently we require that the defconfig options are enabled (as per
> the README.md).
> Making sctp optional however might not be a bad idea since it is
> blacklisted these days by default in some distros.

Except defconfig has it as a module, so you need to have the module
there and loaded. So for Fedora, you need the kernel modules package
and modprobe it.
