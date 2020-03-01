Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73105C3F2D1
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDBE24697
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgCAUFO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:05:14 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:56728 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCAUFO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 15:05:14 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B5D6B56485F
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 21:05:10 +0100 (CET)
Received: by mail-oi1-f179.google.com with SMTP id 5so2685514oiy.4
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 12:05:10 -0800 (PST)
X-Gm-Message-State: APjAAAVaNRbwvfpTadSBXoigpzmIU8CEbdyLOnB3nEWFZU6pd7TUDZ3j
        q7hU2aDfxkwa5PVozRtkrBKqg46Sfq9uGFArJBI=
X-Google-Smtp-Source: APXvYqxOCGJFa2i9axiDz6id88XT6ODBDM7Dv4na4NUTqb8gEI+c2rAZxcAgKDcJyioK20+kBvMgd+9we5il2a5bYrY=
X-Received: by 2002:a05:6808:983:: with SMTP id a3mr3781395oic.172.1583093109781;
 Sun, 01 Mar 2020 12:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200228154857.587-1-william.c.roberts@intel.com> <20200228154857.587-4-william.c.roberts@intel.com>
 <CAEjxPJ7CuMf5QeW_jjEonRN=kfcpTV8c4UnUMyEjyb2hee1YXg@mail.gmail.com>
 <CAFftDdpeP39qvXNTe06EWkc3Kp_TMu5bGOf8WN6Q-k2Cehn_3w@mail.gmail.com> <CAEjxPJ7tt7T1NaYcG6B+k9smtcjrM0WXQXDXjnx5A=FNPLPt4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7tt7T1NaYcG6B+k9smtcjrM0WXQXDXjnx5A=FNPLPt4w@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 21:04:57 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==a2-XorqoSBM-hBO_HhdBSuYX30NyG-=FM6XF8uzMXBw@mail.gmail.com>
Message-ID: <CAJfZ7==a2-XorqoSBM-hBO_HhdBSuYX30NyG-=FM6XF8uzMXBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Makefile: add linker script to minimize exports
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 21:05:11 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 8:04 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 1:43 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 12:35 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Feb 28, 2020 at 10:49 AM <bill.c.roberts@gmail.com> wrote:
> > > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > index c76110fbc650..f74dbeb983dd 100644
> > > > --- a/libselinux/src/Makefile
> > > > +++ b/libselinux/src/Makefile
> > > > @@ -90,7 +90,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
> > > >            -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > > >            $(EXTRA_CFLAGS)
> > > >
> > > > -LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
> > > > +LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro-Wl,--version-script=libselinux.map
> > >
> > > /usr/bin/ld: warning: -z relro-Wl ignored
> > > I guess you meant relro,-Wl but you don't want that either.  -Wl has
> > > to precede all the flags and it is already pre-pended later in the
> > > Makefile.
> >
> > Grumble, did I ever say I *hate* Makefiles! v4 coming, im going to
> > hold them so I can coalesce any other feedback
> > into v4.
>
> (restored cc; I accidentally only replied to you)

While at it, I personally prefer if options -soname and
--version-script come first (like in libsepol/src/Makefile). This way,
it is "easier" for packagers to make a difference between options that
are really required and the options that could be removed if the need
arises (-z,defs,-z,relro). But this is nitpicking, so feel free to
ignore my comment.

Thanks,
Nicolas

