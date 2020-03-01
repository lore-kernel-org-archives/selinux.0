Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB30C3F2D1
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D8246BE
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5fjStDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAUdn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:33:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45600 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAUdn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 15:33:43 -0500
Received: by mail-io1-f65.google.com with SMTP id w9so9261007iob.12
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HcL8sR+KbjwKNT1rlg0555b7/rfVCBLYFD8W6NzhsxQ=;
        b=P5fjStDH4gLAPhmFj0tYsY1DfnpFhs7WTa7ECsMNn1zRIoGJ0gPvHV1V6T6f1dalbn
         uZsyOVcdumENIK8GLOul0UXIImrF8rEDC52zlemRQhRqAVTt2gZvwFlEIjLUSHSS5hRI
         0a3WF8BZ7oRUFX8v0N+wj13arXKrws728N4v1dMpVN0rRneTWNXzcritKVmgIhUHT2dU
         YW6kKit+22K+L9M6kQ+9X19qJpN7e5n6KEh8hN3OYSNmT8RVLtR2B3ztiavIojo0oYYC
         M/N1O36jDDN+V8UkdpB8DAPS4cZH+zRpGjhOIbacM6UICkg1oh2Fq6ojR+y6KjgRcVPI
         Gacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HcL8sR+KbjwKNT1rlg0555b7/rfVCBLYFD8W6NzhsxQ=;
        b=Guyt14iJuZQOuuKNcy6CyJkokV8HC5J9fa5lsnW1lHm9ozJBxzuyV3wxJJ9d5ThQwr
         gLGCsqUxB6V/Y/DPaEpe8iON0s+m8CBBxjPjxFIukma/mwWyQ/KWswJYrO9Q3immlZqE
         9fz8mzsW/t98VzhEpg7DS/RY4xOiN+UgzANGHQvR9ad+Fq9yanrq2apWIfEhSXmeiKnD
         6Yd2B1jq1DdiEQUJYoWyYsCSdPBQGMgmMgC62SNlESERfFRr2ee8Zkm9o3MfqNQJ5KwK
         Pqws7TI/q5XYmw53KnfFF3WbxGdqhsNJL50HhQz2DTsZn+mIYTGWNNIQpZ0Oi/OfI+1E
         F1Ng==
X-Gm-Message-State: APjAAAWkIa5CA/DUVQRNwv74KtD3N+vpiErvCvOrjH/VYDJNzNAmEjBm
        fDMQ1mzNIqrZqwkiTvfsXr9tuxU6Q8ujLDhFQbo=
X-Google-Smtp-Source: APXvYqxlQPqF1VW+MUNNn6UE1k1NKW06BsQZI/uJ1ggh5bBlj3HnY4rIrvxjwQViIg941sMVJBWEtdOy2kfiX8mO76M=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr10206154ior.129.1583094821881;
 Sun, 01 Mar 2020 12:33:41 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com> <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
 <CAFftDdo6ndA=uHW9Ujr2WA4cvMMN_+tJezZYaTL7vXNnafK0ig@mail.gmail.com> <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
In-Reply-To: <CAJfZ7=mtc=9NdK=rs_BenvG2O1n6KG=Gb7oPYTdrzu9KdRBxRw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 1 Mar 2020 14:33:31 -0600
Message-ID: <CAFftDdrdanf2a1=pJ7BWUE0osRJGjYq1TYpS4+1fHvX5vkdGBQ@mail.gmail.com>
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

On Sun, Mar 1, 2020 at 2:21 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sun, Mar 1, 2020 at 8:53 PM William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> >
> > On Sun, Mar 1, 2020 at 1:25 PM Nicolas Iooss <nicolas.iooss@m4x.org> wr=
ote:
> > >
> > > On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > If libsepol is older than version 3.0, the required routine
> > > > sepol_policydb_optimize will not be present. Use pkg-config to get =
the
> > > > modversion and check that it is 3.0 or higher.
> > > >
> > > > This can manifest as a compilation issue:
> > > > direct_api.c: In function =E2=80=98semanage_direct_commit=E2=80=99:
> > > > direct_api.c:1466:13: error: implicit declaration of function =E2=
=80=98sepol_policydb_optimize=E2=80=99; did you mean =E2=80=98sepol_policyd=
b_to_image=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > > >      retval =3D sepol_policydb_optimize(out);
> > > >
> > > > Which is not really clear on how to check.
> > >
> > > >From my point of view, this kind of dependency management is somethi=
ng
> > > that is more suited in a package management system than in a Makefile=
.
> > > It makes sense to check for libsepol version if there is some kind of
> > > optional features that gets enabled according to it (in a similar way
> > > as a --with-... statement in build systems using autoconf) or if ther=
e
> > > is a fall back to another compatible source code (and the Makefile
> > > would "route" the building process to the right .c file). But these
> > > reasons do not match what you are doing in this change.
> >
> > Since we don't use autotools, selinux makefiles have to be smarter. We
> > already use
> > PKG_CONFIG to get various flags, which would normally be handled in a
> > configure script, which if we had autotools, would also be a place to c=
heck
> > dependency versions.
> >
> > >
> > > Why do you need this patch, instead of stating in the package to use
> > > for libsemanage that it depends on libsepol>=3D3.0?
> >
> > We should document that as well, but make software smarter, not people.
> > If we can provide a better error message, without a huge burden of
> > work or maintenance
> > I always vote to do it. In this case, it's pretty simple to do, since
> > we already have the infrastructure for
> > PKG_CONFIG in the Makefiles.
>
> Adding a magic Makefile target which is later removed for a variable
> using $(filter-out $<,$^) makes things a little bit more complex, but
> I can agree with this.

I'm not a huge a fan of that, we could just make it always run on make
invocation, but I thought it was only interesting on actual builds. We don'=
t
want to stop a make clean for instance.

> On the other hand, since I began packaging SELinux libraries for Arch
> Linux, I found several releases that needed to bump such a dependency
> version. For example, if I remember correctly libsemanage 2.4 requires
> libsepol>=3D2.4, same for 2.5, 2.6... but libsemanage 2.9 could work
> with libsepol 2.8 (I usually tries building with older versions when
> packaging a release for Arch Linux, and the history is available for
> example on https://aur.archlinux.org/cgit/aur.git/log/?h=3Dlibsemanage).
>
> This being said, what about adding some logic to force libsemange
> version X.Y to depend on libsepol>=3DX.Y and libselinux>=3DX.Y? The

So you want to check both libsepol and libselinux versions? So you want
me to add a libselinux version check?

> version is already available in libsemanage/VERSION and this file
> could be used to implement such a check.

I'm not following here. That file contains the version of libsemanage,
so I am not sure really how I could use that to implement the check
as we're checking for dependent package versions. Do you want to augment
that file with dependency versions?

Package config files appear to have also a requires field than can set
the minimum
version. Not sure if pkg-config has the ability to detect and error on
this condition.

>
> Nicolas
>
