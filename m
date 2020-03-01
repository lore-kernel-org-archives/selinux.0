Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED9C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 22:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC3B246B4
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 22:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upItdT/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCAWUL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:20:11 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41352 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgCAWUL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 17:20:11 -0500
Received: by mail-il1-f195.google.com with SMTP id q13so1484090ile.8
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cakkq+SG/ikMqr03j4v8zOKrmzn5DPgbEdZ+m+a4LeI=;
        b=upItdT/xq17wq9Zky9kC+AXY8iAPOYBx4jeakbSV+IqdC5kJxD4smUElZQg+Hz20xO
         Ke22dFYjG/kzAZtZVc+W+IDnAnYMQdQlToFIQ/dvc0FTArHh+ury61UtdSsMZheiaElX
         PYFVf6wS3lbBaaJ6URY2mMUs7YbesuHUKR+WPNYBCV24bnmAut4TEV5+PleviIby9Muj
         ZYcUVHalu3mwrOejAGuVvXpJU+oFkUm7lnH0gbf4IIlnMIdubA6hAy72CHL76/HTOL+d
         32+ARCGV4GjN5r1kwEB/B0i6OZuNHQQy/C39LATpUKGXRRpwdnEH+mjdR+lBnOdsNgeP
         PUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cakkq+SG/ikMqr03j4v8zOKrmzn5DPgbEdZ+m+a4LeI=;
        b=t6ct8wT0PVxpif4Y+hK0gTxkInkEu9OrHoOvf/4euJLRu8A3/4xj8QuDy9jqQafzEP
         H0hFQufqnSLMEwAu+7zw6EM+1VMYUnbzaWyUrWo9UMLy93a2edBRWJTsx3Kz8VCUNaID
         /XKIs9x3RzWc7A3si4Ibrl1tvtDMcxHwkfIfdofFCuz1THFkP4pNw0hery6yd0z2sJxI
         7lh3Ut87AjoM9QRhyUNUCpLjdX9PJPE8KgJ/7njfxtwhQIkf7zjmpo0jdNV9vmkTTDqq
         EsdxVo6sFMNqXfhMK+ZSAhAzk76GkimP+1R4hDmFmPlpFKxmsYj2MB3PGkfCbIakOyPa
         kqkA==
X-Gm-Message-State: APjAAAXkLJ/qOp93o5ESHc2IURJ+5ujVEcnkYWX6Lu9rkmuhcokD9PW9
        Pt4DWQAQBwqNFnmLMqFMOcW5cxTZb5EC+OTuigA=
X-Google-Smtp-Source: APXvYqxu8DF5avyWNh1KHRjbh2ArXnDt33kjwxaIm73bj7+q+ae4Kx8DXNjJBtbDh4kxkvkqd1/TL1Kgv1lfFb6A8Ws=
X-Received: by 2002:a92:811c:: with SMTP id e28mr14495035ild.22.1583101208369;
 Sun, 01 Mar 2020 14:20:08 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com>
 <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
 <CAFftDdrdanf2a1=pJ7BWUE0osRJGjYq1TYpS4+1fHvX5vkdGBQ@mail.gmail.com>
 <CAJfZ7=kocVtoWs2fo8JkH+7FicnORGGVQEH51tG95u2nGoaPTw@mail.gmail.com>
 <CAFftDdpkV9furWPR1VzuSV6ew93+Rij3bF7gw2Lup9aa8VMrSw@mail.gmail.com> <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
In-Reply-To: <CAJfZ7=kB1i0ULzcC-EXNkUpRVbw+TCMzZGiV3EcNPsbqZ-hL1A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 1 Mar 2020 16:19:57 -0600
Message-ID: <CAFftDdrTxb9kh-HqfzQfKhHBo7xnCjmO8s0J=6WtPuad7YZc0w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 1, 2020 at 3:43 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> [Oops, I accidentally dropped the Cc. I am restoring it now]
>
> On Sun, Mar 1, 2020 at 10:09 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Sun, Mar 1, 2020 at 2:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wr=
ote:
> > >
> > > On Sun, Mar 1, 2020 at 9:33 PM William Roberts <bill.c.roberts@gmail.=
com> wrote:
> > > >
> > > > On Sun, Mar 1, 2020 at 2:21 PM Nicolas Iooss <nicolas.iooss@m4x.org=
> wrote:
> > > > >
> > > > > On Sun, Mar 1, 2020 at 8:53 PM William Roberts <bill.c.roberts@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Sun, Mar 1, 2020 at 1:25 PM Nicolas Iooss <nicolas.iooss@m4x=
.org> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wr=
ote:
> > > > > > > >
> > > > > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > > > > >
> > > > > > > > If libsepol is older than version 3.0, the required routine
> > > > > > > > sepol_policydb_optimize will not be present. Use pkg-config=
 to get the
> > > > > > > > modversion and check that it is 3.0 or higher.
> > > > > > > >
> > > > > > > > This can manifest as a compilation issue:
> > > > > > > > direct_api.c: In function =E2=80=98semanage_direct_commit=
=E2=80=99:
> > > > > > > > direct_api.c:1466:13: error: implicit declaration of functi=
on =E2=80=98sepol_policydb_optimize=E2=80=99; did you mean =E2=80=98sepol_p=
olicydb_to_image=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > > > > > > >      retval =3D sepol_policydb_optimize(out);
> > > > > > > >
> > > > > > > > Which is not really clear on how to check.
> > > > > > >
> > > > > > > >From my point of view, this kind of dependency management is=
 something
> > > > > > > that is more suited in a package management system than in a =
Makefile.
> > > > > > > It makes sense to check for libsepol version if there is some=
 kind of
> > > > > > > optional features that gets enabled according to it (in a sim=
ilar way
> > > > > > > as a --with-... statement in build systems using autoconf) or=
 if there
> > > > > > > is a fall back to another compatible source code (and the Mak=
efile
> > > > > > > would "route" the building process to the right .c file). But=
 these
> > > > > > > reasons do not match what you are doing in this change.
> > > > > >
> > > > > > Since we don't use autotools, selinux makefiles have to be smar=
ter. We
> > > > > > already use
> > > > > > PKG_CONFIG to get various flags, which would normally be handle=
d in a
> > > > > > configure script, which if we had autotools, would also be a pl=
ace to check
> > > > > > dependency versions.
> > > > > >
> > > > > > >
> > > > > > > Why do you need this patch, instead of stating in the package=
 to use
> > > > > > > for libsemanage that it depends on libsepol>=3D3.0?
> > > > > >
> > > > > > We should document that as well, but make software smarter, not=
 people.
> > > > > > If we can provide a better error message, without a huge burden=
 of
> > > > > > work or maintenance
> > > > > > I always vote to do it. In this case, it's pretty simple to do,=
 since
> > > > > > we already have the infrastructure for
> > > > > > PKG_CONFIG in the Makefiles.
> > > > >
> > > > > Adding a magic Makefile target which is later removed for a varia=
ble
> > > > > using $(filter-out $<,$^) makes things a little bit more complex,=
 but
> > > > > I can agree with this.
> > > >
> > > > I'm not a huge a fan of that, we could just make it always run on m=
ake
> > > > invocation, but I thought it was only interesting on actual builds.=
 We don't
> > > > want to stop a make clean for instance.
> > > >
> > > > > On the other hand, since I began packaging SELinux libraries for =
Arch
> > > > > Linux, I found several releases that needed to bump such a depend=
ency
> > > > > version. For example, if I remember correctly libsemanage 2.4 req=
uires
> > > > > libsepol>=3D2.4, same for 2.5, 2.6... but libsemanage 2.9 could w=
ork
> > > > > with libsepol 2.8 (I usually tries building with older versions w=
hen
> > > > > packaging a release for Arch Linux, and the history is available =
for
> > > > > example on https://aur.archlinux.org/cgit/aur.git/log/?h=3Dlibsem=
anage).
> > > > >
> > > > > This being said, what about adding some logic to force libsemange
> > > > > version X.Y to depend on libsepol>=3DX.Y and libselinux>=3DX.Y? T=
he
> > > >
> > > > So you want to check both libsepol and libselinux versions? So you =
want
> > > > me to add a libselinux version check?
> > > >
> > > > > version is already available in libsemanage/VERSION and this file
> > > > > could be used to implement such a check.
> > > >
> > > > I'm not following here. That file contains the version of libsemana=
ge,
> > > > so I am not sure really how I could use that to implement the check
> > > > as we're checking for dependent package versions. Do you want to au=
gment
> > > > that file with dependency versions?
> > > >
> > > > Package config files appear to have also a requires field than can =
set
> > > > the minimum
> > > > version. Not sure if pkg-config has the ability to detect and error=
 on
> > > > this condition.
> > >
> > > My point was that it would be likely for libsemanage 3.1 to depend on
> > > libsepol 3.1, libsemanage 3.2 to depend on libsepol 3.2... There is a
> > > choice to be made:
> > >
> > > * either we introduce specific dependency checks like your patch, and
> > > these checks will need to be tested and updated when appropriate,
> >
> > This patch should probably change to using something like:
> > pkg-config --libs "bar >=3D 2.7"
> >
> > Digging into this concept, I hacked the .pc file to make it depend on
> > libsepol > 5.0
> >
> > diff --git a/libsemanage/src/libsemanage.pc.in
> > b/libsemanage/src/libsemanage.pc.in
> > index 43681ddb8652..5b25e467393a 100644
> > --- a/libsemanage/src/libsemanage.pc.in
> > +++ b/libsemanage/src/libsemanage.pc.in
> > @@ -7,7 +7,7 @@ Name: libsemanage
> >  Description: SELinux management library
> >  Version: @VERSION@
> >  URL: http://userspace.selinuxproject.org/
> > -Requires.private: libselinux libsepol
> > +Requires.private: libselinux libsepol > 5.0
> >  Libs: -L${libdir} -lsemanage
> >  Libs.private: -lbz2
> >  Cflags: -I${includedir}
> >
> > and ran this command:
> > pkg-config --print-requires-private libsemanage
> > Package 'libsemanage' requires 'libsepol > 5.0' but version of libsepol=
 is 2.9
> > You may find new versions of libsepol at http://userspace.selinuxprojec=
t.org/
> >
> > So we can just put this in one spot (the pc file) and we can discuss ab=
out
> > running this pkg-config command in make.
> >
> > > * or we write down/document a rule that has been true for some
> > > releases : "libsemanage X.Y depends on libsepol>=3DX.Y and
> > > libselinux>=3DX.Y (where "X.Y" is the content of libsemanage/VERSION)
> > > and that trying to use an older version is likely to break things".
> >
> > I think we want both. Documentation is nice, but clear errors under wro=
ng
> > conditions just help make things easier. Especially now that I see how =
to
> > get this into pkg-config better.
> >
> > I think making the all target, which builds the LIBSO and the LIBA
> > target, first build the
> > PC file, run the PC check and then build the LIBSO and LIBA would be go=
od. Then
> > folks still can run the LIBSO/LIBA targets without the pkg-config check=
s.
>
> By the way, there also needs to be a way to skip this check or to
> configure which pkg-config file is selected when building for example
> in a continuous-integration environment. For example I got a failure
> in https://circleci.com/gh/fishilico/selinux/438 ("libsepol is
> required to be version 3.0 or higher, got: 2.8") because libsepol 2.8
> is installed system-wide while libsepol from git is being used
> (because there is a -L flag in LDFLAGS). A possible way to dead with
> this would be to modify an environment variable such as
> PKG_CONFIG_PATH in the root Makefile (in block "ifneq ($(DESTDIR),)").

The default when invoking make is to build and link against the normal
search paths,
so if your building and linking against something non-standard by
modifying the various
environment flags to manipulate things like -,  etc, the
PKG_CONFIG_PATH would be
what you would also modify. If you add to the env variable, that dir
is searched first.

I'm also noticing our PC requires field is missing libaudit, ie:
requires.private audit

It looks like something like this when building the PC file is what we need=
:
pkg-config --print-errors ./src/libsemanage.pc << use the local file

This would also provide validation to our PC file before release.
