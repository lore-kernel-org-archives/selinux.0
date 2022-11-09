Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD2BC4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 13:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiKINrj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiKINrh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 08:47:37 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70F275E2
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 05:47:33 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x21so25825514ljg.10
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8M0Om0QXbI7Z/ufZ0cfzvYE9bMe+ImuwU2gVBFROWOE=;
        b=ie6FdhkhG9f9JREUNByKpZiap5dzx38xOQLM7nLHoHU4wR2bANJ5tifGrslP45tQHI
         USpXUmsRg+hbyK9w1RGGkHr50Q2+B5UFX2BATFqMz1DK3AZAujcjYcRx554Uexcb91iY
         710wgwDuRCiXOcQGIS3f96NaECl1GXisiTGMe+L9OAXFPKhpxeiVESVgsELokTih06jZ
         cao/ojN1H9ies3mVNSwY/IeRglxCXP9mYfzws4Fogv24gi0GAwzQ9MJQyU0IC0jJxT0h
         zYVYdqIAZibvrNFydlw7BnFtA9VJxAbhckKPFYcaU1PKGlCK/rfbjez/4rxg57Ga5f6k
         yARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8M0Om0QXbI7Z/ufZ0cfzvYE9bMe+ImuwU2gVBFROWOE=;
        b=J+LfnparlphRBhM7RTxpFmthzmrJRqHVHbIAz3YjBlca8f2i7tE+onxC4rUFmJfxwN
         MlTHAvmeSVLN9O81hqamhekXDY3HDXWwyAQYHtjSEPmKCJ/mgmUFHMPkLBSTlBC5q9OL
         NzvdAARR0gMrGrmiMjsxoNvcAtBtJBIX+xxrwo1wDtNbmjx6ZX0Afm18SQty6u2L/e73
         P9+0w0VQdc0dUdWL3K3VSubPNxnUlbuK4Uyn+9ZZ+gk9UvE2aG9x2BXR7zvA2vOBkG/I
         Zq6mEol3euBadM9Bvof6psUyE1lrOKGyaR/+JXwnt5NnHgier3Tj9bTr/VX0RwmNxiAX
         Bq5Q==
X-Gm-Message-State: ACrzQf2U7beFZSuKcPFGqOT36cIpbPs6pJM/yp1MViIQlCbO3D7n6/fO
        PQ83hvMiFfDa17fa13/OVqKi9tXofQR9NU7JSyA=
X-Google-Smtp-Source: AMsMyM6T1oUnEUiVjL+Rjps589ZtQIZgemGz6EqewgyoUeynzVodOD+Flw+2dllconyJXxVMEVLK+aMa+l+Kt5rU940=
X-Received: by 2002:a2e:4e02:0:b0:277:5c7e:b120 with SMTP id
 c2-20020a2e4e02000000b002775c7eb120mr15507929ljb.102.1668001652004; Wed, 09
 Nov 2022 05:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20221104143616.1089636-1-jwcart2@gmail.com> <87r0yfchbx.fsf@redhat.com>
In-Reply-To: <87r0yfchbx.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 08:47:20 -0500
Message-ID: <CAP+JOzTG1SSKpwS3Ss8052q52RfbA6Pxv_xf9=39Y1_m14JHvQ@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] Remove dependency on the Python module distutils
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 7, 2022 at 3:14 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > The distutils package is deprecated and scheduled to be removed in
> > Python 3.12.
> >
> > When building the SELinux userspace we currently get warnings like the following:
> > <string>:1: DeprecationWarning: The distutils.sysconfig module is deprecated, use sysconfig instead
> > <string>:1: DeprecationWarning: The distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or check PEP 632 for potential alternatives
> >
> > I am not a Python expert, but everything seems to work with these patches.
> > I would appreciate other people testing this and any Python experts to let
> > me know if this is the right way of replacing distutils.
> >
> > v3: Removed a second usage of distutils in python/sepolicy/sepolicy/gui.py
> >
> > v2: Use sysconfig.get_path('purelib'... when original used
> >     get_python_lib(prefix=... and use sysconfig.get_path('platlib'...
> >     when original used get_python_lib(plat_specific=1, prefix=...
> >
> > James Carter (5):
> >   libselinux: Remove dependency on the Python module distutils
> >   libsemanage: Remove dependency on the Python module distutils
> >   python: Remove dependency on the Python module distutils
> >   scripts: Remove dependency on the Python module distutils
> >   README.md: Remove mention of python3-distutils dependency
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

This series has been merged.
Jim

>
> >  README.md                             | 1 -
> >  libselinux/src/Makefile               | 2 +-
> >  libselinux/src/setup.py               | 2 +-
> >  libsemanage/src/Makefile              | 2 +-
> >  python/semanage/Makefile              | 2 +-
> >  python/sepolgen/src/sepolgen/Makefile | 2 +-
> >  python/sepolicy/sepolicy/gui.py       | 4 ++--
> >  python/sepolicy/setup.py              | 2 +-
> >  scripts/env_use_destdir               | 2 +-
> >  scripts/run-scan-build                | 2 +-
> >  10 files changed, 10 insertions(+), 11 deletions(-)
> >
> > --
> > 2.38.1
>
