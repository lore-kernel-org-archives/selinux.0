Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F1C63793
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4325E61353
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGVMiK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhGVMiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Jul 2021 08:38:10 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55362C061575
        for <selinux@vger.kernel.org>; Thu, 22 Jul 2021 06:18:44 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id y17-20020a4ae7110000b0290262f3c22a63so1307410oou.9
        for <selinux@vger.kernel.org>; Thu, 22 Jul 2021 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iKgkulq+AYlpkDXD1KKS6Ou8zObOMG/U1EzKr5smrg4=;
        b=vN4+ug+Yj0JrSXySKxYQX5sCWJ3J2gfrpXx6h26bCUmSOJ81uZ9NLqywswwFlJjpzX
         3g66gvpFDdB7PjIoBZJv+NJCXm60HVkaK7wqv7ULfQcienpxMq0kZoaLhL3/Cw6XPC++
         cWYyG5Xg2KV0ODzMFvN9t9AuMNwEV1Iwx+YM03R3ZRhQppQRTYedkZXuwIBnjcKcNch5
         P1Gquzig5yyK3O/vyZVkrcNOzIguYkO8d4z4BjX3XnquEjdTeSXpOP1cU0qZftyDuXNd
         r0F1e0fFQ7s8Mov6tN3+xwHWTMuV8L0wJ88c2R99elui1XhHtSMiYr1OkUANTizYaALz
         0DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iKgkulq+AYlpkDXD1KKS6Ou8zObOMG/U1EzKr5smrg4=;
        b=op/uRbiCIfYxfwRNYoHzrx3WA6OCA1i0aS2X67oyssZ1kdhcaB+OeLDumGd5e3JPDJ
         dJWHHrd/C0HsDrWcss250wKQo/LvKutFfxEpisa8VMSxMheNzom0as4E8FGWsu4+bre/
         AI+iMfYEWDsr/IaHtm/gEBPhNlhI6xi7FKds6JstS1U2oW2amdS0qH/NPM5En2qRSw2O
         P5ONSmtSj0x+ud418xN7ysxv+pagyZQWs4j9hYT61kSrcGfCILMw035mB7m9pLBqSt83
         UGg5e7BapgTLpwFLh+JF7mvqwIwpe7yg0DQvPlOxw8BzzbmkbK5XQtbAcFACwiARUyQx
         ZWsQ==
X-Gm-Message-State: AOAM533+D5KmCrksLYbTX+4sJKPjWaCxP3IOYxIvbypZaZIiIowvlSbl
        qNYjFmx21c2UKuxxpKdTbRtM+kTgSXWLRceJ2kQ=
X-Google-Smtp-Source: ABdhPJwFrRnUK4291FW3Hpw7IgNl2Pr0cFIVK6y0NippawWaW75UbhNyeNpHlzffwHeAQ4OVgH/zR0z31ql4vm4BDcM=
X-Received: by 2002:a4a:d484:: with SMTP id o4mr27220684oos.35.1626959923762;
 Thu, 22 Jul 2021 06:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210714181343.58880-1-cgzones@googlemail.com> <CAP+JOzTxL=PsEHdL8PMRv8=dPLcLypPMnYEWj2WHUygXMVpeGQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTxL=PsEHdL8PMRv8=dPLcLypPMnYEWj2WHUygXMVpeGQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 22 Jul 2021 09:18:32 -0400
Message-ID: <CAP+JOzQFRsEi7q9GDVmrB=6Wervf61n9VjQKhrAyF=T=K+sTRQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/run-scan-build: update
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 19, 2021 at 12:58 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 14, 2021 at 2:16 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > - use multiple jobs
> > - define _FORTIFY_SOURCE=3D2 to enable checks on standard string handli=
ng
> >   functions due to macro/intrinsic overloads or function attributes
> > - allow to override clang and scan-build binaries, i.e. for using
> >   versioned ones
> > - set PYTHON_SETUP_ARGS accordingly on Debian
> > - enable common warning -Wextra
> > - print build result
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For all six patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

This series has been merged.

Thanks,
Jim

> > ---
> >  scripts/run-scan-build | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> > index ae5aa48b..ef07fefc 100755
> > --- a/scripts/run-scan-build
> > +++ b/scripts/run-scan-build
> > @@ -1,6 +1,10 @@
> >  #!/bin/sh
> >  # Run clang's static analyzer (scan-build) and record its output in ou=
tput-scan-build/
> >
> > +# Allow overriding binariy names, like clang-12
> > +export CC=3D${CC:-clang}
> > +SCAN_BUILD=3D${SCAN_BUILD:-scan-build}
> > +
> >  # Ensure the current directory is where this script is
> >  cd "$(dirname -- "$0")" || exit $?
> >
> > @@ -20,14 +24,24 @@ export PATH=3D"$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$=
DESTDIR/sbin:$DESTDIR/bin:$PATH
> >  export PYTHONPATH=3D"$DESTDIR$(${PYTHON:-python3} -c "from distutils.s=
ysconfig import *;print(get_python_lib(prefix=3D'/usr'))")"
> >  export RUBYLIB=3D"$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["=
vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendor=
archdir"]')"
> >
> > +if [ -f /etc/debian_version ]; then
> > +    export PYTHON_SETUP_ARGS=3D'--install-layout=3Ddeb'
> > +fi
> > +
> >  # Build and analyze
> > -make -C .. CC=3Dclang clean distclean -j"$(nproc)"
> > -scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. \
> > -    CC=3Dclang \
> > +make -C .. clean distclean -j"$(nproc)"
> > +$SCAN_BUILD -analyze-headers -o "$OUTPUTDIR" make -C .. \
> >      DESTDIR=3D"$DESTDIR" \
> > -    CFLAGS=3D"-O2 -Wall -D__CHECKER__ -I$DESTDIR/usr/include" \
> > +    CFLAGS=3D"-O2 -Wall -Wextra -D_FORTIFY_SOURCE=3D2 -D__CHECKER__ -I=
$DESTDIR/usr/include" \
> > +    -j"$(nproc)" \
> >      install install-pywrap install-rubywrap all test
> >
> > +if [ $? -eq 0 ]; then
> > +    echo "++ Build succeeded"
> > +else
> > +    echo "++ Build failed"
> > +fi
> > +
> >  # Reduce the verbosity in order to keep the message from scan-build sa=
ying
> >  # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to exam=
ine bug reports.
> >  set +x
> > --
> > 2.32.0
> >
