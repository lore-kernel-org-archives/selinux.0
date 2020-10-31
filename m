Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5031C388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A9220663
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL47WMzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgJaQx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 12:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgJaQx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 12:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604163235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btGGNJsN0ToR/TQmmq+8gjvvg0ZwwIF6ahP2ChZME/g=;
        b=gL47WMzIHllrhs1T1y92sRc3ye9COIGUQ+cmxAIqI/lsj2nu5nLDaKprAKPvtVEaVT8R6z
        +axAB9bM9MADgRGOZ2tbFViA112cYEb/lLjFeozmv4duuya1RB/sFC3+0z2CEBkxISUcYT
        ZbU0tMHnrd53LHhCje6vvPXlLmhadXw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-uL1VKvTsPsux0Is6sy5sUg-1; Sat, 31 Oct 2020 12:53:52 -0400
X-MC-Unique: uL1VKvTsPsux0Is6sy5sUg-1
Received: by mail-lf1-f72.google.com with SMTP id 78so1315841lfd.22
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 09:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btGGNJsN0ToR/TQmmq+8gjvvg0ZwwIF6ahP2ChZME/g=;
        b=QDkx06aMvyXkS9gizpIQ7Sf+Bl0xqLEi4IbkwNC7+WjTtJIWNYWy54I98Zq8VhZnFh
         9vJnGPkX3rzbh+GkGLQ8DOen8NHT1o6awCbej7IGgpJMmk2CPRtrktZOAsyVVnGVpTUr
         dtGJGbNVzjrTBFEqt6fYhaOTdRlSPeyN1/CbXy5LYZiY3mCiCoCGQp0fOs2/mbJjRnMp
         nHNQ/EypZz+IQL3rb/s8oVl6S5TEoeqRl2pjIeOSNQLP/WYGktISUFlC/oBjgh/45l5o
         6D1rnVAdzsafh0OgvfJqTnTKch7aLndgb0YJv5T/1cnrU/ETJoPllduwM1Z1Xr7eMHuJ
         ILJg==
X-Gm-Message-State: AOAM533j6VFYVG070Oy0nLs6+d/AgqcdA19YoPU6slo3YzNB0PRP1llT
        smmLA15bgYQiNcJ3VONPfB8fuCW2SuXVNWDGl78Gcp0AXIXjn99RLpeTI51W1q2gKQVEn+adBvS
        7Rji08xC8UJmpgn+dc8oTF+qIxDd+Xl/BYg==
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr3152326lfa.354.1604163231078;
        Sat, 31 Oct 2020 09:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf+7SPSL2lAAJTCwJUTBYy11k2QlHUIZEhmRJRgWz/Qfme7/tTwGvvzuf2fU13dz4zmXD+uwMDoAB2l6GhttU=
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr3152321lfa.354.1604163230879;
 Sat, 31 Oct 2020 09:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201030211327.111834-1-omosnace@redhat.com> <CAFftDdrws1qjTPZzg4aAAUPX2xeO8a6Q2YuHqDM7poaabM0fNA@mail.gmail.com>
In-Reply-To: <CAFftDdrws1qjTPZzg4aAAUPX2xeO8a6Q2YuHqDM7poaabM0fNA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 17:53:40 +0100
Message-ID: <CAFqZXNviw_R7PQOUC7H026pz_M2A68rQUx4sQ-GQfAEvhQT2zQ@mail.gmail.com>
Subject: Re: [PATCH userspace v2] ci: use parallel build
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 12:05 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Oct 30, 2020 at 4:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Pass -j$(nproc) to all make invocations to make the CI run a little
> > faster.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2: use POSIX $() instead of ``
> >
> >  .travis.yml | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index bd3c9842..8ea6cc74 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -74,7 +74,7 @@ install:
> >    - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
> >    # Make refpolicy Makefile use the new toolchain when building modules
> >    - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
> > -  - sudo make -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
> > +  - sudo make -j$(nproc) -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
> >    - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
> >    - sudo mkdir -p /etc/selinux
> >    - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
> > @@ -129,12 +129,12 @@ before_script:
> >
> >  script:
> >    # Start by installing everything into $DESTDIR
> > -  - make install $EXPLICIT_MAKE_VARS -k
> > -  - make install-pywrap $EXPLICIT_MAKE_VARS -k
> > -  - make install-rubywrap $EXPLICIT_MAKE_VARS -k
> > +  - make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
> > +  - make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
> > +  - make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
> >
> >    # Now that everything is installed, run "make all" to build everything which may have not been built
> > -  - make all $EXPLICIT_MAKE_VARS -k
> > +  - make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
> >
> >    # Set up environment variables for the tests
> >    - . ./scripts/env_use_destdir
> > --
> > 2.26.2
> >
>
> Ack

Thanks, applied now:
https://github.com/SELinuxProject/selinux/commit/4dd74ded5b7078e203a64583fc23dbca2858bb88

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

