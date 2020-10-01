Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B5C4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D10020B1F
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcy0Sf2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbgJARIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJARIj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 13:08:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC1C0613D0
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 10:08:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so6190305otl.4
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx6YHbr1W3n3DCHd3RzqRDKOiQrTRDUoLNLW0QxxSuU=;
        b=Mcy0Sf2SusGlozqdkriK6kDJDIYg0q++PF92pTSS75AFmmD4RLxQmmTP/RbMC47JFx
         qzy9nTy7uoE19cXTygoLVdozjSgqKDBTBtreTm6ow8gW48M33GlERZFX5UHeoZhnXDZB
         5o2r38QX1UvgyOyrseUeANUAjGAuAM5JR7caZ/lRxai8Tux4MBGLxWA4rycLNePEoE6J
         EyPZxZUMfBlSLoW05cumXaIHRNQfPeFOIlsIMkdc+XgFiLDsui2XwXMByQzswLXJlMHU
         j2fZ3wZHBhqd1nNQSnjHqKBKVaRzcrbbW58kMuVt2IN9pRZe0NSAepYj6ImCoUnIT52m
         A1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx6YHbr1W3n3DCHd3RzqRDKOiQrTRDUoLNLW0QxxSuU=;
        b=IAa3PKizEM9jixoMD1/pV62jzoRQ0xFYYcAciNcboEbwg0QfFaPtgKQN4QQCFzg8Dm
         /AoOQc+hSLPExSs+SUvFjdOf77u3QCgi/Ki+Ulh9dU/2AoHfcTeg5QCFl8znasOU5bd+
         /y4g6oOywSstR8yjfOUc/X/nRjdi/i6SMtlGsl/CGl8WaCO/zttrB/O3yTYOWOhlOe7X
         PknQ868e9ompRGiCJ+Lz/MYFzcTqZPabQswAbT95nR15u4PoROsqq03Ai7C4oBb+AOwT
         r3x2YP/02SBmD7D4onwKHcoCVapmXXeBvthbSiCN9deg+6RYX0npjxHB6LI0QjvVHrMr
         zISA==
X-Gm-Message-State: AOAM532a2opJ9K5PIOCaXoShVwis9qli/B6WSlgUdXUJuS+rcfDQy9UR
        AOg/BBc+1GXLjHejHO1xcUBSR2sD9PikimoRHmI=
X-Google-Smtp-Source: ABdhPJzwXMqqvEhAhexRtuoBX44iS/EoKs5JteGsCl9icdknSJFXLZgzk6Cw5ItOQrbBh+l1mLdsb5xkYRH0D6O4oV0=
X-Received: by 2002:a9d:185:: with SMTP id e5mr5804257ote.135.1601572118401;
 Thu, 01 Oct 2020 10:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com> <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
 <20201001165551.GA33342@localhost.localdomain>
In-Reply-To: <20201001165551.GA33342@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 1 Oct 2020 13:08:27 -0400
Message-ID: <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 1, 2020 at 12:56 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 10:18:35AM -0400, Stephen Smalley wrote:
> > On Wed, Sep 30, 2020 at 11:56 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> > > > On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > > >
> > > > > It's due to the previous ABI incompatible change
> > > > >
> > > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > >
> > > > My only real question is what are the implications for distros for
> > > > this change?  Would Fedora end up having to carry both so versions for
> > > > a time?  Or can you cleanly switch from the old to the new without
> > > > disruption?
> > > >
> > >
> > > Fedora and other distribution will need to temporary ship something like libsepol-compat and
> > > libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in order not to
> > > break buildroots. Also all packages which require so.1, see bellow, will have to
> > > be rebuilt against so.2
> > >
> > > # dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
> > > libselinux-utils-0:3.1-3.fc34.x86_64
> > > libsemanage-0:3.1-2.fc33.x86_64
> > > libsepol-devel-0:3.1-3.fc33.x86_64
> > > parted-0:3.3-6.fc34.x86_64
> > > policycoreutils-0:3.1-4.fc33.x86_64
> > > python3-setools-0:4.3.0-5.fc33.x86_64
> > > secilc-0:3.1-2.fc33.x86_64
> > >
> > > # dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
> > > libsemanage-devel-0:3.1-2.fc33.x86_64
> > > policycoreutils-0:3.1-4.fc33.x86_64
> > > python3-libsemanage-0:3.1-2.fc33.x86_64
> > > shadow-utils-2:4.8.1-4.fc33.x86_64
> > > sssd-common-0:2.3.1-4.fc33.x86_64
> > > sssd-ipa-0:2.3.1-4.fc33.x86_64
> > >
> > > I've experienced with this, builds are available in
> > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
> > >
> > > E.g. for libsemanage, I've added
> > >
> > > +%set_build_flags
> > > +CFLAGS="$CFLAGS -fno-semantic-interposition"
> > > +sed -i 's/LIBVERSION = 2/LIBVERSION = 1/' src/Makefile
> > > +%make_build
> > > +cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.so.1
> > >
> > > to the spec file in order to get libsemanage.so.1 which is shipped by
> > > libsemanage.so.1
> >
> > The parted dependency looks suspect; seems to be an incorrect linking
> > with libsepol despite not directly calling any sepol functions.
> > Aside from that, if we have to bump the so version and deal with
> > compat packages anyway, should we go ahead and purge all of the other
> > deprecated functions in libsepol and libsemanage (grep -ri deprecated
> > libsepol libsemanage)?
> >
>
> I'd like to ship compat only for short time until all dependent components are
> rebuilt.
>
> Purging deprecated functions could have much bigger impact than this patchset as it affects API. With
> this change, it's generally enough to rebuild a component. If we drop functions
> and change API, different software could stop work. There are only few packages
> using libsepol and libsemanage directly, but there might be much bigger group of
> python or ruby scripts using deprecated symbols like matchpathcon*()

Yes, I just meant libsepol and libsemanage deprecated functions not
libselinux (so not matchpathcon) since you are already bumping the so
version.  But it's fine if you don't want to do it at the same time.
