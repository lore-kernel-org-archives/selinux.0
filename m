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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F68C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0451420643
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVLqIpFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgEOVT0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOVT0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:19:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A745C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:19:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s10so4262421iog.7
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzJGfMsERVOgh8kH7t9vVGlKSN9KhhcCuJLA1GQFoN4=;
        b=BVLqIpFe+x2Xu81FsblKqpaUI7CYv7biUtQmAAA/l9Pj5gopqcvrKV+naRBDitKbxp
         af2HHZimPnTlheYM4OsetJeCyfMMSV3B1iY4icFk8PN7POeVJA4YXsn07IMrAMcdm/cK
         /zLED/Pq48SH0CvSP2nT1IKS7SN48QVYNrKHKtcGH9hMgolYF3BkzHiRthNBM7ZQbuXf
         WAsiVCihpXOhutbR7UY2rHzwOK6ulafwPWOkKUPovKY5NMnjHCoG8uGQCtvmQ/iSDe7W
         43phlMEqiGEa88EyQMnJp61uYIlXfHuu+JifQ2ha8ja9NVEkWdA/IcJ1ZuBFliL1V7EL
         n+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzJGfMsERVOgh8kH7t9vVGlKSN9KhhcCuJLA1GQFoN4=;
        b=gcJa9MhLSpNFfnRQ5nyBqBwGZtw8HSaNiFCG+jvOnz25KWDtLigSwzjhv5cwATDBUB
         htm9OM5XRN9cZDR+68CFirAMHWTaucObovOMEScJosFsckxRhhWdc8QIJC9oYXNNQIcm
         ME3y2dv/SbZtIfDLMpdRh9KwrfoqCGSCKnMUYrbWplL8FLR352cPaqfUrks44BespHAh
         xT7DM/E6NpL8XiwdClqJnZLJ/TzGIvwX+QY21W8Q/P815qxJwRQqaVstS74yEUMSbWpP
         Y6e6dAoUBplI7gbzgGAfLomjhzp66pLaNBVOOgV6q+uM0c4Y6Fy0NEvOg7MypKxRbiiz
         qF/Q==
X-Gm-Message-State: AOAM531Rq2IxZ2Tam6frLdGbdobPgd5wu9SYlGWym1UXnU9gIajvwwk8
        VNrZoNSAJeFmlQxjzowPbZO/9x5/IjB3qUkncYA=
X-Google-Smtp-Source: ABdhPJyqHTrIBdsvfJY7u/hnRZrKEu4LpWQpKa62LDXxzEW4lPRh7zQcTl7FQK8LJcncbqIuyyfBfO/qWYP7ASHL2aU=
X-Received: by 2002:a6b:d10f:: with SMTP id l15mr4744839iob.143.1589577565593;
 Fri, 15 May 2020 14:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
 <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
 <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com>
 <CAFqZXNvSgE5Eb+89D_j9M1mQFAdgq1Q6PhJbUuzYPeunR4RtHw@mail.gmail.com>
 <CAFftDdrN+f7D=OhdQbTLUvFZL8QDw_+eqN3scqBgxdWT2yB+=A@mail.gmail.com> <CAFqZXNv=FhQBy1FNbP4_=8i0UPQprwhyfnxSFqkEtTUX00YfEQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv=FhQBy1FNbP4_=8i0UPQprwhyfnxSFqkEtTUX00YfEQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 16:19:14 -0500
Message-ID: <CAFftDdqEgZUu=5UTdT5DTTy9Lw41r=oZ72H6KkUCcyo66B6=bA@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 4:06 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 10:46 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Fri, May 15, 2020 at 2:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Fri, May 15, 2020 at 9:27 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > > On Fri, May 15, 2020 at 1:51 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2020 at 2:11 PM William Roberts
> > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > > > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > > > > >
> > > > > > > > The text above states that kernel-devel is needed, but it's missing from
> > > > > > > > the dnf command.
> > > > > > > >
> > > > > > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > > > > > ---
> > > > > > > >  README.md | 3 ++-
> > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/README.md b/README.md
> > > > > > > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > > > > > > --- a/README.md
> > > > > > > > +++ b/README.md
> > > > > > > > @@ -77,7 +77,8 @@ following command:
> > > > > > > >                 kernel-devel \
> > > > > > >
> > > > > > > It's actually right there already ^^
> > > > > >
> > > > > > Yeah that's the foot cannon, I thought I was good, but you need the
> > > > > > specific ones
> > > > > > as Ondrej pointed out to me.
> > > > > >
> > > > > > >
> > > > > > > >                 quota \
> > > > > > > >                 xfsprogs-devel \
> > > > > > > > -               libuuid-devel
> > > > > > > > +               libuuid-devel \
> > > > > > > > +               kernel-devel-$(uname -r)
> > > > > > >
> > > > > > > I proposed adding the -$(uname -r) before, but there were some valid
> > > > > > > counterarguments. See the discussion here:
> > > > > > > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> > > > > > >
> > > > > >
> > > > > > Arguments for why the dnf command should have it with uname:
> > > > > > 1. We tried to add it twice, it's bit people twice.
> > > > > > 2. The README states "On a modern Fedora system you can install these
> > > > > > dependencies with the following command:"
> > > > > >     - which is wrong, you need the specific package
> > > > > >     - If you're going to provide a "dnf install" or a apt-get install,
> > > > > > it should just work
> > > > > >     - the apt-get example has uname -r in it.
> > > > > >     - so the precludes building your own kernel, if you do that as
> > > > > > Paul stated, you're on your own. (lore comment)
> > > > >
> > > > > I'm ok with adding it.
> > > >
> > > > Does anyone want to ack this one?
> > >
> > > As Stephen already said while I was writing this message, please just
> > > update the existing kernel-devel line.
> > >
> > > >
> > > > Ok I found another one, kernel-modules-extra is needed for the sctp module.
> > >
> > > On Fedora it shouldn't be, only on RHEL/CentOS 8.
> >
> > Not on the cloud image, so I am assuming that desktop just has it already
> > fulfilled.
>
> That's strange... Was this with the 5.6.6-300.fc32.x86_64 kernel
> mentioned in the other thread? I just downloaded the RPMs for that
> build and sctp.ko was in kernel-modules, not kernel-modules-extra.

I say it was in kernel-modules-extra-$(uname -r), but what I should have said,
that solved the issue od not having the sctp module, but it solved it buy
being dependent on kernel-modules, so the correct line to add would be
that one, not extra.

I don't do really use fedora distros, so bear me with as I learn where
to find info
and poke the system.

>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
