Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D04C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114E20671
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0GiuooR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOUqm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUql (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 16:46:41 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523AC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:46:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y10so4206841iov.4
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrpzdI3IfjIjEXPA9Q/VJarpuUe1X1yIAf/vVeZbvrE=;
        b=u0GiuooRE4Vtd69gRPzQ7ifl3L21r08pmb6gXtXvygkgI26Z/+v9iaMdpXZ9SUkMiJ
         k/l286y2APk7/PZnGCu6MwH8frD1o7ahwWyY0dKULyPVDRpEIUQTngjweski9+HJW2W6
         e00RBEl4rotu5H2T/CgQq9QOwCPPytHKSf2qjQtDYYI+/keEcMFSO7O1ZD0Gnb/eYXC2
         InSmnEqbwZVTdyVbmFvnYZRIqgnoGZ5Dbun39DZ3d0/kbGjyTTXuZtBAVsI8P4RWhzkC
         eCnVykcyk8CTqa2LhFH6UdNbWOaecT9ePuMY9BdJuBQ97YAuEtXWqpwDqeVEq3aaIRlR
         RUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrpzdI3IfjIjEXPA9Q/VJarpuUe1X1yIAf/vVeZbvrE=;
        b=L1b5gezvol22EthyA7x6GgEJ2TmCPfSa2q/GO2TntssZMPK9YhunM1mhuI8bCmrU9q
         f6PMrTWAFjche5lOUXXlhLCu4nHoAmI7dIeYk61VBwKo8F5QRgQ8jCFKoDtUPUE5agdk
         uZWjwwcKiid/ckthGoXwramOsUTqeUi/Qru9g5cEkGh1Lo7VVEWb3FRnvhCpXUU0HR0m
         RbYfNWjC+jgi0/+XNl+jMvvor5sBLd0Rz3E0LiqvOCYds8hatCFB+QUMgmYbYQt8mw3g
         jCtuLc6zk6m6F/m+ddzQ6PzBD0XkQ5GSfXseZ/rVS5hxHxh8dfqxrGVl0xPR9aaUlk2K
         OA3w==
X-Gm-Message-State: AOAM533SDkmX/fJq7UV8y0uK3hxh05FVR1SNkmg8/eJJ8/Y4D9n8T71l
        I/JolZcJsrckwMGVbUUTZFSm6eQhVxUnOSRzjEEh/qKP
X-Google-Smtp-Source: ABdhPJxmPwcOHeBhJg2MP6PMrJm7U27GvRHgT4qhKfyIeUh2tF5xiCwSpmKhiHsZKMugs82nyuxVy2eYELJ2p1sMK84=
X-Received: by 2002:a6b:d10f:: with SMTP id l15mr4634203iob.143.1589575600709;
 Fri, 15 May 2020 13:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com>
 <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
 <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com> <CAFqZXNvSgE5Eb+89D_j9M1mQFAdgq1Q6PhJbUuzYPeunR4RtHw@mail.gmail.com>
In-Reply-To: <CAFqZXNvSgE5Eb+89D_j9M1mQFAdgq1Q6PhJbUuzYPeunR4RtHw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 15:46:29 -0500
Message-ID: <CAFftDdrN+f7D=OhdQbTLUvFZL8QDw_+eqN3scqBgxdWT2yB+=A@mail.gmail.com>
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

On Fri, May 15, 2020 at 2:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 9:27 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
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
> As Stephen already said while I was writing this message, please just
> update the existing kernel-devel line.
>
> >
> > Ok I found another one, kernel-modules-extra is needed for the sctp module.
>
> On Fedora it shouldn't be, only on RHEL/CentOS 8.

Not on the cloud image, so I am assuming that desktop just has it already
fulfilled.

>
> >
> > The tests expect sctp support, should we conditionally skip these if
> > sctp is not enabled?
> > Whats the best way of checking for that proto if we want this? just an
> > ls of /proc/sys/net:
> > ls /proc/sys/net/
> > bridge  core  ipv4  ipv6  netfilter  nf_conntrack_max  sctp  unix
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
