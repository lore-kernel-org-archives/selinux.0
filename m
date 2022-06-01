Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92658CCA468
	for <selinux@archiver.kernel.org>; Wed,  1 Jun 2022 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiFANqt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiFANqt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Jun 2022 09:46:49 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF613627E
        for <selinux@vger.kernel.org>; Wed,  1 Jun 2022 06:46:46 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-d39f741ba0so2717745fac.13
        for <selinux@vger.kernel.org>; Wed, 01 Jun 2022 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnncdfP4PtwcHc4mRdORDVa1U9go5Bk7eQYVu5tOfJI=;
        b=WpaSvBZyTxFptqTWvnV3/wgdprjv8pmdwLVfBJ2fBQdtaq9QIprLCYrw3Lc5cRh4CT
         kW33O80mLBjePYgfSQ28h6T+Tr+0XoNiFB5IzaWZs2+8ZT4RoKWRE1KorwXP/BQyhsjz
         /b8ZBsEMZCeAwn0Fo2o5Dq7CUEkjufW9iFrapFtuBW/hUq7a+SWiGzludB9dEgw3oAbg
         tTg/81xtmRF/Kgvnuwz3Y07U0jsXmPC01Uc+3SuuTftcBwxHFF+ZV2sDNNCWioSWZ5yM
         9J4pS7TOrTblXkz58x1cFx/DblbEy3kly1x23SXH08iWB5R+tEN76pKG5aYlzPzuNpFP
         IXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnncdfP4PtwcHc4mRdORDVa1U9go5Bk7eQYVu5tOfJI=;
        b=CREvjVz/WyKHp2e/D3FPrBAMRstBRarZHq7y3zRloAnskdq9x1gRSAvn2zkKE26o1d
         bBDk0wq066SRchDulgyR62Yf2yGkqdsfOhstJQzIrRwPBOO4M0ZUjnHqH4o6iexw2Mzg
         yt6A+DnYARnxV2E6QGJ8hTWXZ8vwgwK4sWh13c+3hB8FhZxhHDaChYnaPPkwJZna3DCL
         K/qILnNglYt9BkGEfk8Gdje3v+7ZHXFK4HUJmUZYJjS40oT5Mr1+2/2uJIKqyTec1tad
         Y6SjXcXawM7LEj/tRNeoo/uUK6OxihfDO78zI9Wf4Tog9fTtnUtqUT7sJ6QWYyYsgX5K
         ixzw==
X-Gm-Message-State: AOAM5333UVbvqVuYMXf87gUCu4ClLoAhQFvxuUVGPNs3EDZkj8VMAI85
        lafL4A13N8iq+ZLErUUNfrHp75+kT4Kd7xm0oj8MjcX1KsU=
X-Google-Smtp-Source: ABdhPJzE+G9Ou8ZBVrWWajMWz7pAzbpWAyYffwswuVp3Msk1cZRDmgI9B3q6MFf2Bb7Qxh69UTbDnrZ0AEU1sCUBui8=
X-Received: by 2002:a05:6870:e40c:b0:f3:2f32:7c3d with SMTP id
 n12-20020a056870e40c00b000f32f327c3dmr9314460oag.71.1654091206185; Wed, 01
 Jun 2022 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220520130004.9096-1-cgzones@googlemail.com> <CAJfZ7=mjPwViS6umaq=BPF1=bDHZZfSwGwMq=-Ajtj2RoLcLUA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mjPwViS6umaq=BPF1=bDHZZfSwGwMq=-Ajtj2RoLcLUA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 1 Jun 2022 15:46:35 +0200
Message-ID: <CAJ2a_DdG3xu3JwTqJ_H5p0TfWKc_o7MkaR=UJmd=GTS3z-w9og@mail.gmail.com>
Subject: Re: [PATCH] Makefile: always include and link with DESTDIR
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 30 May 2022 at 00:49, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, May 20, 2022 at 3:00 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The top level Makefile adds, if the environment variable DESTDIR is
> > defined, the according include and link directory to CFLAGS and LDFLAGS
> > to build all userspace tools against dependencies from this repository
> > and not the system.
> > If CFLAGS or LDFLAGS are specified by the user, e.g.
> >
> >     DESTDIR=3D~/destdir CFLAGS=3D-Dfoo LDFLAGS=3D-Lbar make install
> >
> > use the override directive to force adding DESTDIR paths to the user
> > specified CFLAGS or LDFLAGS.
> >
> > Note that
> >
> >     DESTDIR=3D~/destdir make CFLAGS=3D-Dfoo LDFLAGS=3D-Lbar install
> >
> > does not work, since in sub-directories the internal make options take
> > precedence over the overridden environment variables in the top
> > Makefile.
>
> Hello,
>
> >From my understanding of the documentation of "override"
> (https://www.gnu.org/software/make/manual/html_node/Override-Directive.ht=
ml)
> it only matters when setting variables which come from the command
> line, not from the environment. On my system (Arch Linux with "GNU
> Make 4.3"), your first command works fine. To really be sure I
> understood things correctly, I added a target into the main Makefile:
>
> testenv:
>     @echo Root Makefile: CFLAGS=3D$(CFLAGS)
>     (cd libsepol && $(MAKE) $@)
>
> ... and added similar commands to libsepol/Makefile and
> libsepol/src/Makefile. Without override, "DESTDIR=3D/tmp/destdir
> CFLAGS=3D-Dfoo make testenv" displays:
>
> Root Makefile: CFLAGS=3D-Dfoo -I/tmp/destdir/usr/include
> libsepol Makefile: CFLAGS=3D-Dfoo -I/tmp/destdir/usr/include
> libsepol/src Makefile: CFLAGS=3D-Dfoo -I/tmp/destdir/usr/include -I.
> -I../include -D_GNU_SOURCE -I../cil/include -DHAVE_REALLOCARRAY
>
> ... which shows that the Makefile works as expected. Adding "override"
> does not change this output. It only changes it with
> "DESTDIR=3D/tmp/destdir make CFLAGS=3D-Dfoo testenv":
>
> Root Makefile: CFLAGS=3D-Dfoo -I/tmp/destdir/usr/include
> libsepol Makefile: CFLAGS=3D-Dfoo
> libsepol/src Makefile: CFLAGS=3D-Dfoo -I. -I../include -D_GNU_SOURCE
> -I../cil/include -DHAVE_REALLOCARRAY
>
> Your patch makes the first output have " -I/tmp/destdir/usr/include"
> but not the other lines, because $(MAKEFLAGS) contains "CFLAGS=3D-Dfoo"
> (as documented on
> https://www.gnu.org/software/make/manual/html_node/Variables_002fRecursio=
n.html
> ). So using CFLAGS in command-line argument does not work and making
> it work would require removing CFLAGS and LDFLAGS from MAKEFLAGS,
> which seems fragile.
>
> Therefore, I did not manage to reproduce the issue that your patch was
> fixing and I did not understand why using "override" helped. You could
> be using a specific kind of make which behaves differently as mine.
> Could you please provide some way to reproduce the issue you were
> experiencing (that "DESTDIR=3D~/destdir CFLAGS=3D-Dfoo LDFLAGS=3D-Lbar ma=
ke
> install" did not work on your system)?

Thanks for reviewing.
I must have mixed up something, cause

    DESTDIR=3D~/destdir CFLAGS=3D-Dfoo LDFLAGS=3D-Lbar make install

works indeed.
Please disregard this patch.

>
> Thanks,
> Nicolas
>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2ffba8e9..e05e924b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -29,8 +29,8 @@ ifneq ($(DESTDIR),)
> >         LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >         LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> >
> > -       CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
> > -       LDFLAGS +=3D -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
> > +       override CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
> > +       override LDFLAGS +=3D -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
> >         export CFLAGS
> >         export LDFLAGS
> >         export LIBSEPOLA
> > --
> > 2.36.1
> >
>
