Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA0C3F2D1
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2005246BE
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCAUV4 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sun, 1 Mar 2020 15:21:56 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58667 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAUV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 15:21:56 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D8AE3561246
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 21:21:51 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id g96so7628924otb.13
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 12:21:51 -0800 (PST)
X-Gm-Message-State: APjAAAWqR+vhlCTziKt3sjmEa/HUxvprVRYnZlyCMW/c9w1N/NrKzSE1
        CRDyO4rw/oCLWujrD9i1TL/dv8ApK7pLqNkiw6A=
X-Google-Smtp-Source: APXvYqw/TVPSMEE2wXp+dKystumCcjMmQ8g528uvlTmyKPF5u+EuPUwgAkEb0m8XOon6/nNqXjU30gsh+zzfrFXZy8w=
X-Received: by 2002:a05:6830:18d4:: with SMTP id v20mr10912378ote.29.1583094110704;
 Sun, 01 Mar 2020 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
In-Reply-To: <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 21:21:39 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
Message-ID: <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 21:21:52 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 1, 2020 at 8:53 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Sun, Mar 1, 2020 at 1:25 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > If libsepol is older than version 3.0, the required routine
> > > sepol_policydb_optimize will not be present. Use pkg-config to get the
> > > modversion and check that it is 3.0 or higher.
> > >
> > > This can manifest as a compilation issue:
> > > direct_api.c: In function ‘semanage_direct_commit’:
> > > direct_api.c:1466:13: error: implicit declaration of function ‘sepol_policydb_optimize’; did you mean ‘sepol_policydb_to_image’? [-Werror=implicit-function-declaration]
> > >      retval = sepol_policydb_optimize(out);
> > >
> > > Which is not really clear on how to check.
> >
> > >From my point of view, this kind of dependency management is something
> > that is more suited in a package management system than in a Makefile.
> > It makes sense to check for libsepol version if there is some kind of
> > optional features that gets enabled according to it (in a similar way
> > as a --with-... statement in build systems using autoconf) or if there
> > is a fall back to another compatible source code (and the Makefile
> > would "route" the building process to the right .c file). But these
> > reasons do not match what you are doing in this change.
>
> Since we don't use autotools, selinux makefiles have to be smarter. We
> already use
> PKG_CONFIG to get various flags, which would normally be handled in a
> configure script, which if we had autotools, would also be a place to check
> dependency versions.
>
> >
> > Why do you need this patch, instead of stating in the package to use
> > for libsemanage that it depends on libsepol>=3.0?
>
> We should document that as well, but make software smarter, not people.
> If we can provide a better error message, without a huge burden of
> work or maintenance
> I always vote to do it. In this case, it's pretty simple to do, since
> we already have the infrastructure for
> PKG_CONFIG in the Makefiles.

Adding a magic Makefile target which is later removed for a variable
using $(filter-out $<,$^) makes things a little bit more complex, but
I can agree with this.
On the other hand, since I began packaging SELinux libraries for Arch
Linux, I found several releases that needed to bump such a dependency
version. For example, if I remember correctly libsemanage 2.4 requires
libsepol>=2.4, same for 2.5, 2.6... but libsemanage 2.9 could work
with libsepol 2.8 (I usually tries building with older versions when
packaging a release for Arch Linux, and the history is available for
example on https://aur.archlinux.org/cgit/aur.git/log/?h=libsemanage).

This being said, what about adding some logic to force libsemange
version X.Y to depend on libsepol>=X.Y and libselinux>=X.Y? The
version is already available in libsemanage/VERSION and this file
could be used to implement such a check.

Nicolas

