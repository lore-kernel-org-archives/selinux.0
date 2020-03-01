Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03EC3F2D4
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6D8246C0
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAUdF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:33:05 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44742 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAUdF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 15:33:05 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5705A564686
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 21:33:01 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id 2so8339126oiz.5
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 12:33:01 -0800 (PST)
X-Gm-Message-State: APjAAAUVw5Lc3yDDf8FOWwT+1yhyyTUWvTKG7vURFsx/uRgHBf+81aEe
        5VgU7xMzlfgyYtAbrqONZ2JwGs6LKx8YmEbc8Iw=
X-Google-Smtp-Source: APXvYqxxxDsyhxhIBh1xhwr3ObZt+B5wlx+OkzDBtZJJD6vrxNnUJvWLZYaTfaNNNlhYfzvS7x+9JDX4xEFOsdrXbYo=
X-Received: by 2002:aca:170c:: with SMTP id j12mr3698671oii.50.1583094780341;
 Sun, 01 Mar 2020 12:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200227230129.31166-3-william.c.roberts@intel.com> <CAEjxPJ7bLsGHQ4-wz19ntft=GYvWMLL5bZd8hAimbu1hzc5+Ew@mail.gmail.com>
 <CAFftDdrNcbOWGa-o3TaeagF1TL7NnFxk2Osm_rembw+HH1wACw@mail.gmail.com>
In-Reply-To: <CAFftDdrNcbOWGa-o3TaeagF1TL7NnFxk2Osm_rembw+HH1wACw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 21:32:49 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
Message-ID: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: add -fno-semantic-interposition
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 21:33:01 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 2:59 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 7:50 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 6:01 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > Add -fno-semantic-interposition to CFLAGS. This will restore
> > > the DSO infrastructures protections to insure internal callers
> > > of exported symbols call into libselinux and not something laoding first
> > > in the library list.
> > >
> > > Clang has this enabled by default.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > I'm fine with this but since Nicolas pointed out the option of using
> > -Bsymbolic to
> > the linker as an alternative to hidden_def/hidden_proto in
> > https://github.com/SELinuxProject/selinux/issues/204#issuecomment-591092288
> > I was wondering how they differ.  I guess -Bsymbolic only affects the
> > linker while -fno-semantic-interposition
> > permits the compiler to further optimize the code.
>
> That's my understanding of the difference as well. -B is only link
> time, so the compiler can't
> really optimize the calls, but IIUC the compiler can only optimize
> whats in the compilation
> unit, so it can only optimize call sites for calls within the compilation unit.
>
> -B also only works for elf builds, so we would conditionally need to
> modify LDFLAGS based
> on host type. The compiler option is just a clang/gcc split, which is
> already there. To go
> to symbolic we would have to conditionally set that... a tad bit more work :-p

I am not very familiar with -Bsymbolic and did not know about
-fno-semantic-interposition before a few days ago. As far as I
understand, -Bsymbolic puts an entry of type "SYMBOLIC" in the dynamic
section of the .so file, which changes the behavior of the dynamic
linker at link time without modifying anything in the build-time
linking process. It is only compatible with ELF files and seems quite
uncommon.
With this in mind, -fno-semantic-interposition seems more powerful and
better suited for what we want to achieve (to optimize the
compilation). I agree with the approach of this patchset and would
have given an Acked-By if there weren't an issue with "-z,relro-Wl" ;)

Thanks for working on this!
Nicolas

