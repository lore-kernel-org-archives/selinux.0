Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DBC43217
	for <selinux@archiver.kernel.org>; Mon, 28 Nov 2022 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiK1PIY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiK1PIH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Nov 2022 10:08:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDAD205FB
        for <selinux@vger.kernel.org>; Mon, 28 Nov 2022 07:08:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vv4so26595824ejc.2
        for <selinux@vger.kernel.org>; Mon, 28 Nov 2022 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C4znagd7meVacHDxzH+5455+BBsPs30hQamcCSKxvK8=;
        b=pDQymxuEJJPnBJaeWtcbent+G4MViSvf+PY/P7mfMX2Ju9ySMLVY4ZGhxCQW+nJ2GD
         5kn/0MW37/LB+ow6GHy+yF5k4u+GYfSmAclMmdTeyFK5t39/WpNWpgyOQQASg+JCVyjy
         EfM88E8uJgfmn9aJIm/MNizbuAbmiGuR71yFis6hYZhJwdkqJvXQOTuCBSc5IVka9WLe
         YwXLS+H/DB0TlkslNGzOsgrjoei2UamHtxasLKlrUEk/qgLd0RIpxWqf9E7ZlJwW1z/l
         X2vZcZRSQSUHvrGXV0HBKYQWoFYO15gHy6nyIpycMzicre6+ePCPfXfxQUOZ+Q4ASGsO
         D3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4znagd7meVacHDxzH+5455+BBsPs30hQamcCSKxvK8=;
        b=U/nIaF1P34ZBkn3f55sRL5Tx1RD9wArGDbfWMn+0wAV27RJfIb+o1US4A8bzG2PG32
         pHpZP3JKHoSYzldNVuv6B1J1uul3QErJlojVD2nq3YBCSBme8fxcy6ZzPYuBPAIUQPuy
         kt/SGsbVKDui8+892+ATDXMOzXdD+/Xvh6jY5Bzz3vRMEq9sbzUwqAdzPoqBrDI6zBFD
         k6DTtDnzCQBEeOiuOFPnozZ24CvexXW9ZKSoOKkvN3RhPcimmHIKs1iBELamXr3/RZhQ
         NyTwcuCw+x4vjJJ/uaK3V7utWmaR+GFvAy9Hh6qMr8eYymgjW2EW2GTGKcQ/BRqHh39Z
         RloQ==
X-Gm-Message-State: ANoB5pnR2aUkqNde0xmbVMwni7sjHEDOgz4Fvw/zOYEf2MgEvxrLlzVA
        hD0iis1CaIpk7qzXu3x+m18PzyIQ5RWRE1leccjA5kR1VJo=
X-Google-Smtp-Source: AA0mqf43sWUQs000j9UaG0CMaYfnoetIyMj1DgQ36bvki5zEgwjIIQT6ssAiBQan9qFlHlLTeW/TbPn1dG/7TCw3O5w=
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id
 e10-20020a1709061e8a00b007b2b992694dmr38760616ejj.651.1669648083291; Mon, 28
 Nov 2022 07:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20221122161106.55037-1-lautrbach@redhat.com> <CAP+JOzRit39R5OKLFvHt0CdOixEHrBvybq3UWa6VicwMHG5NQA@mail.gmail.com>
In-Reply-To: <CAP+JOzRit39R5OKLFvHt0CdOixEHrBvybq3UWa6VicwMHG5NQA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Nov 2022 10:07:52 -0500
Message-ID: <CAP+JOzTzBC2mW=9mH=T2SYNpk8cXD0-MMcJjKpUeeUs9nAy=ww@mail.gmail.com>
Subject: Re: [RFC PATCH] Use `pip install` instead of `setup.py install`
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 23, 2022 at 11:04 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 22, 2022 at 11:15 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Fixes:
> >     /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  README.md                | 4 +++-
> >  libselinux/src/Makefile  | 2 +-
> >  python/sepolicy/Makefile | 2 +-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index 529b7e46c871..e11b0028f4ba 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -62,6 +62,7 @@ dnf install \
> >  # For Python and Ruby bindings
> >  dnf install \
> >      python3-devel \
> > +    python3-pip \

So I noticed that I get the following message when building:
  Processing /home/jim/work/selinux/python/sepolicy
    Preparing metadata (setup.py): started
    Preparing metadata (setup.py): finished with status 'done'
  Using legacy 'setup.py install' for sepolicy, since package 'wheel'
is not installed.

Installing python3-wheel gives the following instead:
  Building wheels for collected packages: sepolicy
    Building wheel for sepolicy (setup.py): started
    Building wheel for sepolicy (setup.py): finished with status 'done'

It is not a strict dependency, but maybe we should add python3-wheel.
Unless, of course, there is some reason we don't want to be creating
these python wheels.

Thanks,
Jim

> >      ruby-devel \
> >      swig
> >  ```
> > @@ -92,6 +93,7 @@ apt-get install --no-install-recommends --no-install-suggests \
> >  # For Python and Ruby bindings
> >  apt-get install --no-install-recommends --no-install-suggests \
> >      python3-dev \
> > +    python3-pip \
> >      ruby-dev \
> >      swig
> >  ```
> > @@ -102,7 +104,7 @@ To build and install everything under a private directory, run:
> >
> >      make DESTDIR=~/obj install install-rubywrap install-pywrap
> >
> > -On Debian `PYTHON_SETUP_ARGS=--install-layout=deb` needs to be set when installing the python wrappers in order to create the correct python directory structure.
> > +On Debian `PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` needs to be set when installing the python wrappers in order to create the correct python directory structure.
> >
> >  To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
> >  This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index dc2848322e4d..0f6396ababa4 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -187,7 +187,7 @@ install: all
> >         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> >
> >  install-pywrap: pywrap
> > -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> > +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
> >         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
> >         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> >
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index d983e409e5e6..57a2e55edbbf 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -27,7 +27,7 @@ test:
> >         @$(PYTHON) test_sepolicy.py -v
> >
> >  install:
> > -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> > +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
> >         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
> >         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
> >         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> > --
> > 2.38.1
> >
