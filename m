Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309AC3F2D3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA2246A3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgEDX16W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgB1Mnr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:43:47 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45205 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Mnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 07:43:47 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3205400iob.12
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 04:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=61HbQ+TN/2xHn+NzJ/f+6N3i3sE6dg/dBIyaJwFNlgU=;
        b=sgEDX16WLfZKblwoFxXdCc6Lb09U975RkXCodDeSum4OLaO49t22D44pj659021Lrq
         I5uCmM0looDvjvlAbLyapD4Gk6BZjk4Y8BABgIP0t/jzbh4EM+weg+H3zXolEmMQb8ne
         9KW4qRK81NxQ3G9PCkT0c0HB4ItkMusHwfHfIIgtI7VE1jmitdSsPurtIWnolSpJm39D
         nUcpoWY9ASu3rPWj17ijBpEqVo6OEieWHU//LvwNIXbwiTsP7gkj/pvKOEUov+81+72/
         K2TPkG50yv8ox4R7XMIc5XZEcA83OGCcwKIb9jjhupHM4FbtJJWmeUnuS62K3OZHnhJc
         dg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=61HbQ+TN/2xHn+NzJ/f+6N3i3sE6dg/dBIyaJwFNlgU=;
        b=O8NfsCFAQp33TCNWckyTxnxx1edG2Br23lxMHlpTYagzydUhVkTCxg/NhP54yO2cxs
         ULu8zpc4w8Tc0iZbjO/4k+Y3ztIuo6a9BaC8HIhzTgMNsM1gbmxJlc/cXH15piOPwl9F
         WLHODqSqDOJJM+Azxm4kwE+MxZUc6EsO4DIIV7auiiRNiWgsYfn66nNZB9bYCF40Rp1M
         05CojkKHl31xE8eq8BAQEQnAHCA+/JZ1NeOYY9VJVui51+LU3pXB/mbXd1WakbhhyFQi
         mbXQDP/4NU0gADWVJSoZBUv3TmHCcEwOmFlWalqL1tsOvuMV8DubtM0LUcxQEhVlHL/2
         CAqw==
X-Gm-Message-State: APjAAAVun4kC3rKpwcZvnCTKaqeOvlzO1BK5ruEKSQjtBPG74/seJ6pY
        ttQUHH1Tc2SlwQQk31pfrh+yjd55R/RJFKpeXnE=
X-Google-Smtp-Source: APXvYqxKpF1eGu94LPceN7fuuyeKqMEbW/rPrxJ7bQCHqpOXoOj3elSh6rXZZJL6LwBZBCs2RLohv1kMGWZ2nvKCgt4=
X-Received: by 2002:a5d:9708:: with SMTP id h8mr3463757iol.141.1582893826576;
 Fri, 28 Feb 2020 04:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20200227224706.29892-1-william.c.roberts@intel.com> <CAFqZXNv4g8fdreQgSqrEumjPVYhT5btjiMcSYezZm7LaEJRW_A@mail.gmail.com>
In-Reply-To: <CAFqZXNv4g8fdreQgSqrEumjPVYhT5btjiMcSYezZm7LaEJRW_A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 28 Feb 2020 06:43:34 -0600
Message-ID: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
Subject: Re: [PATCH] libsemange: add missing header sepol/policydb.h
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 2:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> On Thu, Feb 27, 2020 at 11:47 PM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Fix below compilation issue:
> > direct_api.c: In function =E2=80=98semanage_direct_commit=E2=80=99:
> > direct_api.c:1466:13: error: implicit declaration of function =E2=80=98=
sepol_policydb_optimize=E2=80=99; did you mean =E2=80=98sepol_policydb_to_i=
mage=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >     retval =3D sepol_policydb_optimize(out);
>
> It is probably a good idea to include it explicitly, but it is already
> included indirectly via <sepol/module.h>, so I'm not sure how you got
> the above error. Maybe your build flags weren't set properly and the
> compiler was including older system headers instead of the local ones?

AFAIK, the userspace selinux builds, it always pulls the system
headers and libraries unless you configure your build system
otherwise.

It looks like an issue with an older system installed sepol, I updated
sepol and the issue went away.

This bug appears if you have libsepol versions < 3.0 installed, and
then build libsemanage from tip of tree.

It appears that the routine sepol_policydb_optimize was brought in
version libsepol-3.0, so libsemanage has a hard dependency on libsepol
>=3D 3.0

Since libsemanage is already querying pkgconfig, perhaps we should run
pkgconfig --modversion libsepol and verify the version is
greater than or equal to 3.0 so we can give a better error message?

Not sure why adding this patch got libsemanage to build and link though....

>
> (BTW, there is a typo in the subject line - 'libsemange' is missing an 'a=
'.)
>
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsemanage/src/direct_api.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 1088a0ac6165..92f0a17b0156 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -23,6 +23,7 @@
> >  #include <sepol/handle.h>
> >  #include <sepol/cil/cil.h>
> >  #include <selinux/selinux.h>
> > +#include <sepol/policydb.h>
> >
> >  #include <assert.h>
> >  #include <fcntl.h>
> > --
> > 2.17.1
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
