Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70249C4363D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49276206DD
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJBHCU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 03:02:20 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52855 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHCT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 03:02:19 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1B4BE5646B4
        for <selinux@vger.kernel.org>; Fri,  2 Oct 2020 08:53:22 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id c2so444483otp.7
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 23:53:22 -0700 (PDT)
X-Gm-Message-State: AOAM532Nyr5IvgKw+x2GjhKA5rjNPO7r4aI8y9Sr6vqtoWkEEue0JBgK
        DroBvsRXCJf/0UUkPwaddLtTUqz/dq4GJJGoNIQ=
X-Google-Smtp-Source: ABdhPJyVLgFohEL5olQ5N1ng7Ce2g5MQPQ0o4ajhskGwGEzY2WoUD6q+B8tmGYOOdKDc+oxopfpfZ1n5LxnVROv8Yuc=
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr654609otx.279.1601621600955;
 Thu, 01 Oct 2020 23:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com> <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
 <20201001165551.GA33342@localhost.localdomain> <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
 <20201001174837.GB33342@localhost.localdomain>
In-Reply-To: <20201001174837.GB33342@localhost.localdomain>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 2 Oct 2020 08:53:09 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ksiWidL58wj2=qjvq4sWW9uxi-mF+YdZf_niuf8KHDBQ@mail.gmail.com>
Message-ID: <CAJfZ7=ksiWidL58wj2=qjvq4sWW9uxi-mF+YdZf_niuf8KHDBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Oct  2 08:53:22 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 1, 2020 at 7:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 01:08:27PM -0400, Stephen Smalley wrote:
> > On Thu, Oct 1, 2020 at 12:56 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Thu, Oct 01, 2020 at 10:18:35AM -0400, Stephen Smalley wrote:
> > > > On Wed, Sep 30, 2020 at 11:56 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> > > > > > On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > > > > >
> > > > > > > It's due to the previous ABI incompatible change
> > > > > > >
> > > > > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > > > >
> > > > > > My only real question is what are the implications for distros for
> > > > > > this change?  Would Fedora end up having to carry both so versions for
> > > > > > a time?  Or can you cleanly switch from the old to the new without
> > > > > > disruption?
> > > > > >
> > > > >
> > > > > Fedora and other distribution will need to temporary ship something like libsepol-compat and
> > > > > libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in order not to
> > > > > break buildroots. Also all packages which require so.1, see bellow, will have to
> > > > > be rebuilt against so.2
> > > > >
> > > > > # dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
> > > > > libselinux-utils-0:3.1-3.fc34.x86_64
> > > > > libsemanage-0:3.1-2.fc33.x86_64
> > > > > libsepol-devel-0:3.1-3.fc33.x86_64
> > > > > parted-0:3.3-6.fc34.x86_64
> > > > > policycoreutils-0:3.1-4.fc33.x86_64
> > > > > python3-setools-0:4.3.0-5.fc33.x86_64
> > > > > secilc-0:3.1-2.fc33.x86_64
> > > > >
> > > > > # dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
> > > > > libsemanage-devel-0:3.1-2.fc33.x86_64
> > > > > policycoreutils-0:3.1-4.fc33.x86_64
> > > > > python3-libsemanage-0:3.1-2.fc33.x86_64
> > > > > shadow-utils-2:4.8.1-4.fc33.x86_64
> > > > > sssd-common-0:2.3.1-4.fc33.x86_64
> > > > > sssd-ipa-0:2.3.1-4.fc33.x86_64
> > > > >
> > > > > I've experienced with this, builds are available in
> > > > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
> > > > >
> > > > > E.g. for libsemanage, I've added
> > > > >
> > > > > +%set_build_flags
> > > > > +CFLAGS="$CFLAGS -fno-semantic-interposition"
> > > > > +sed -i 's/LIBVERSION = 2/LIBVERSION = 1/' src/Makefile
> > > > > +%make_build
> > > > > +cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.so.1
> > > > >
> > > > > to the spec file in order to get libsemanage.so.1 which is shipped by
> > > > > libsemanage.so.1
> > > >
> > > > The parted dependency looks suspect; seems to be an incorrect linking
> > > > with libsepol despite not directly calling any sepol functions.
> > > > Aside from that, if we have to bump the so version and deal with
> > > > compat packages anyway, should we go ahead and purge all of the other
> > > > deprecated functions in libsepol and libsemanage (grep -ri deprecated
> > > > libsepol libsemanage)?
> > > >
> > >
> > > I'd like to ship compat only for short time until all dependent components are
> > > rebuilt.
> > >
> > > Purging deprecated functions could have much bigger impact than this patchset as it affects API. With
> > > this change, it's generally enough to rebuild a component. If we drop functions
> > > and change API, different software could stop work. There are only few packages
> > > using libsepol and libsemanage directly, but there might be much bigger group of
> > > python or ruby scripts using deprecated symbols like matchpathcon*()
> >
> > Yes, I just meant libsepol and libsemanage deprecated functions not
> > libselinux (so not matchpathcon) since you are already bumping the so
> > version.  But it's fine if you don't want to do it at the same time.
> >
>
> I see, I missed that point, sorry. It seems to be reasonable, but I'll check it
> again tomorrow.

Hello,
I have another question: why is bumping the .so version needed? As we
are not changing the ABI of a "linked symbol" (thanks to using
versioned symbols, with .map files), if we do not bump the .so
version, programs that were built with libsepol.so from years ago will
just stop working due to missing symbols, with an error message which
will be quite clear (and this only if they were using deprecated
symbols). In my humble opinion, bumping the .so version is most
required when the calling convention of a non-versioned symbol
changes, but this leads to unexpected execution paths.

Nevertheless I did not spend time to search for a document that would
explain why bumping the .so version would be recommended when removing
symbols. If you know one, could you please add a reference to it in
the commit description ("Following guidelines from https://...) and/or
to some documentation?

>From a "distro maintainer point of view" (for Arch Linux), having just
spent a considerable amount of time due to breaking changes in the
last release of PAM, I am not eager to spend time dealing with finding
clever ways to smoothly upgrade the system if there is no
easy&straightforward way to do this. Introducing a transition package
for each library which is bumped is acceptable to me, but if the
release after the next one bumps the version again, introducing
another set of transition packages will begin to be quite painful. In
short: I agree to remove the deprecated functions in order to "bump
the .so version only once", as suggested.

Cheers,
Nicolas

