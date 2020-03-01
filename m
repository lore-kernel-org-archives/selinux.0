Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E23C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 21:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05A32468E
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 21:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCAVnh convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sun, 1 Mar 2020 16:43:37 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48364 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVnh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 16:43:37 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2F12F5606A5
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 22:43:33 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id g96so7745570otb.13
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 13:43:33 -0800 (PST)
X-Gm-Message-State: APjAAAVjst6Sh9tNatL2R0Iu5koZlD1jPSyySV7ODqHlo9BE6mtJa/Mg
        qm30QlqhgZtxXAQtgzLjqDXoHpSVltjtY/oj6jM=
X-Google-Smtp-Source: APXvYqz009DQ57SNP7w3B7Lb95VyEHc/akU/U17Z3OmdbIGze/L0bcvGreNJB1FaLepxbF9/MXwFIVD0JUkjLpHflY0=
X-Received: by 2002:a05:6830:18d4:: with SMTP id v20mr11087797ote.29.1583099011923;
 Sun, 01 Mar 2020 13:43:31 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
 <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
 <CAFftDdrdanf2a1=pJ7BWUE0osRJGjYq1TYpS4+1fHvX5vkdGBQ@mail.gmail.com>
 <CAJfZ7=kocVtoWs2fo8JkH+7FicnORGGVQEH51tG95u2nGoaPTw@mail.gmail.com> <CAFftDdpkV9furWPR1VzuSV6ew93+Rij3bF7gw2Lup9aa8VMrSw@mail.gmail.com>
In-Reply-To: <CAFftDdpkV9furWPR1VzuSV6ew93+Rij3bF7gw2Lup9aa8VMrSw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 22:43:20 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
Message-ID: <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 22:43:33 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Oops, I accidentally dropped the Cc. I am restoring it now]

On Sun, Mar 1, 2020 at 10:09 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Sun, Mar 1, 2020 at 2:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Sun, Mar 1, 2020 at 9:33 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Sun, Mar 1, 2020 at 2:21 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > >
> > > > On Sun, Mar 1, 2020 at 8:53 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > On Sun, Mar 1, 2020 at 1:25 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > > >
> > > > > > On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wrote:
> > > > > > >
> > > > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > > > >
> > > > > > > If libsepol is older than version 3.0, the required routine
> > > > > > > sepol_policydb_optimize will not be present. Use pkg-config to get the
> > > > > > > modversion and check that it is 3.0 or higher.
> > > > > > >
> > > > > > > This can manifest as a compilation issue:
> > > > > > > direct_api.c: In function ‘semanage_direct_commit’:
> > > > > > > direct_api.c:1466:13: error: implicit declaration of function ‘sepol_policydb_optimize’; did you mean ‘sepol_policydb_to_image’? [-Werror=implicit-function-declaration]
> > > > > > >      retval = sepol_policydb_optimize(out);
> > > > > > >
> > > > > > > Which is not really clear on how to check.
> > > > > >
> > > > > > >From my point of view, this kind of dependency management is something
> > > > > > that is more suited in a package management system than in a Makefile.
> > > > > > It makes sense to check for libsepol version if there is some kind of
> > > > > > optional features that gets enabled according to it (in a similar way
> > > > > > as a --with-... statement in build systems using autoconf) or if there
> > > > > > is a fall back to another compatible source code (and the Makefile
> > > > > > would "route" the building process to the right .c file). But these
> > > > > > reasons do not match what you are doing in this change.
> > > > >
> > > > > Since we don't use autotools, selinux makefiles have to be smarter. We
> > > > > already use
> > > > > PKG_CONFIG to get various flags, which would normally be handled in a
> > > > > configure script, which if we had autotools, would also be a place to check
> > > > > dependency versions.
> > > > >
> > > > > >
> > > > > > Why do you need this patch, instead of stating in the package to use
> > > > > > for libsemanage that it depends on libsepol>=3.0?
> > > > >
> > > > > We should document that as well, but make software smarter, not people.
> > > > > If we can provide a better error message, without a huge burden of
> > > > > work or maintenance
> > > > > I always vote to do it. In this case, it's pretty simple to do, since
> > > > > we already have the infrastructure for
> > > > > PKG_CONFIG in the Makefiles.
> > > >
> > > > Adding a magic Makefile target which is later removed for a variable
> > > > using $(filter-out $<,$^) makes things a little bit more complex, but
> > > > I can agree with this.
> > >
> > > I'm not a huge a fan of that, we could just make it always run on make
> > > invocation, but I thought it was only interesting on actual builds. We don't
> > > want to stop a make clean for instance.
> > >
> > > > On the other hand, since I began packaging SELinux libraries for Arch
> > > > Linux, I found several releases that needed to bump such a dependency
> > > > version. For example, if I remember correctly libsemanage 2.4 requires
> > > > libsepol>=2.4, same for 2.5, 2.6... but libsemanage 2.9 could work
> > > > with libsepol 2.8 (I usually tries building with older versions when
> > > > packaging a release for Arch Linux, and the history is available for
> > > > example on https://aur.archlinux.org/cgit/aur.git/log/?h=libsemanage).
> > > >
> > > > This being said, what about adding some logic to force libsemange
> > > > version X.Y to depend on libsepol>=X.Y and libselinux>=X.Y? The
> > >
> > > So you want to check both libsepol and libselinux versions? So you want
> > > me to add a libselinux version check?
> > >
> > > > version is already available in libsemanage/VERSION and this file
> > > > could be used to implement such a check.
> > >
> > > I'm not following here. That file contains the version of libsemanage,
> > > so I am not sure really how I could use that to implement the check
> > > as we're checking for dependent package versions. Do you want to augment
> > > that file with dependency versions?
> > >
> > > Package config files appear to have also a requires field than can set
> > > the minimum
> > > version. Not sure if pkg-config has the ability to detect and error on
> > > this condition.
> >
> > My point was that it would be likely for libsemanage 3.1 to depend on
> > libsepol 3.1, libsemanage 3.2 to depend on libsepol 3.2... There is a
> > choice to be made:
> >
> > * either we introduce specific dependency checks like your patch, and
> > these checks will need to be tested and updated when appropriate,
>
> This patch should probably change to using something like:
> pkg-config --libs "bar >= 2.7"
>
> Digging into this concept, I hacked the .pc file to make it depend on
> libsepol > 5.0
>
> diff --git a/libsemanage/src/libsemanage.pc.in
> b/libsemanage/src/libsemanage.pc.in
> index 43681ddb8652..5b25e467393a 100644
> --- a/libsemanage/src/libsemanage.pc.in
> +++ b/libsemanage/src/libsemanage.pc.in
> @@ -7,7 +7,7 @@ Name: libsemanage
>  Description: SELinux management library
>  Version: @VERSION@
>  URL: http://userspace.selinuxproject.org/
> -Requires.private: libselinux libsepol
> +Requires.private: libselinux libsepol > 5.0
>  Libs: -L${libdir} -lsemanage
>  Libs.private: -lbz2
>  Cflags: -I${includedir}
>
> and ran this command:
> pkg-config --print-requires-private libsemanage
> Package 'libsemanage' requires 'libsepol > 5.0' but version of libsepol is 2.9
> You may find new versions of libsepol at http://userspace.selinuxproject.org/
>
> So we can just put this in one spot (the pc file) and we can discuss about
> running this pkg-config command in make.
>
> > * or we write down/document a rule that has been true for some
> > releases : "libsemanage X.Y depends on libsepol>=X.Y and
> > libselinux>=X.Y (where "X.Y" is the content of libsemanage/VERSION)
> > and that trying to use an older version is likely to break things".
>
> I think we want both. Documentation is nice, but clear errors under wrong
> conditions just help make things easier. Especially now that I see how to
> get this into pkg-config better.
>
> I think making the all target, which builds the LIBSO and the LIBA
> target, first build the
> PC file, run the PC check and then build the LIBSO and LIBA would be good. Then
> folks still can run the LIBSO/LIBA targets without the pkg-config checks.

By the way, there also needs to be a way to skip this check or to
configure which pkg-config file is selected when building for example
in a continuous-integration environment. For example I got a failure
in https://circleci.com/gh/fishilico/selinux/438 ("libsepol is
required to be version 3.0 or higher, got: 2.8") because libsepol 2.8
is installed system-wide while libsepol from git is being used
(because there is a -L flag in LDFLAGS). A possible way to dead with
this would be to modify an environment variable such as
PKG_CONFIG_PATH in the root Makefile (in block "ifneq ($(DESTDIR),)").

Thanks,
Nicolas

