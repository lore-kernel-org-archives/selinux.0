Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C7AC4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 16:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiKWQEc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiKWQEb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 11:04:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20BE5D699
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 08:04:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x102so25538764ede.0
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=guwzXGv8DsedgXRjpoDXQlOJKalpAkQ0xtbI5WNzbvU=;
        b=fw+FQ1u9txsMHVEXMNWe4x1R0OvjeB/WtDABTY78JybB7bcGBwN8X1JWf4fSdfHb8D
         kGTb/CSiCqtcagD3SSxunQLY4l5IHfRfnN0Yv/n/OdPmTendy+XXczULY2WtUX+5aJv8
         XlsryXqymVspZovl7QE+GLeq2i173piOTe7fqwXvOVGS6LfQFCWJNlyTZn+X+NZXIWg4
         PW66z2hOOuILxdpU+dmc9DogLTbIp2P/gc0aS6XjGcc5MuXHURrFUQWOybiEHpb/uuYZ
         9uyi5qqX2oJcv2VBYfFZsUypPjfcDqXMbBuSO6O7p1BYFwiquh36w3+fdTBvc1qgcLd2
         f2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guwzXGv8DsedgXRjpoDXQlOJKalpAkQ0xtbI5WNzbvU=;
        b=dI6byKf3K0cicjv/5adET4pOa0P39gFfgumcn+nH0QF7eTifXmLuYPbWPHdTMfzUH8
         SJbGTUJwGqBqcetFJP12gBJrOlRHQ8mg471mTwdcuT65ctDO1Au4+3w+ND6EBtr55PVe
         ZA1I7gAEhLfhPpQVOR+7Tn2CapKq1QjYsxUe9rbCfN5pYfnezfX2xoX8jfkYKX1bGcbX
         MfJw1omwXBr0Cfus4b3Y706N8/4Dgt8V1rY4TOFemYwd22TrxQ33YX3OQdXyFQSGzhqq
         dvwa5fVI+L2+z7qFmg4x6sWRoiiE2yo1bBAzhLyFfFp8Ho0qfgQ4U3MS2nTpRGw4wPWT
         csSQ==
X-Gm-Message-State: ANoB5pnusmKJbDpyECFlpACU5BdbtfibMs8r3oTGvyYPfTE/iLJTR3bK
        h7mbf28jOrfY2FoxRT58UJeQ/np85dSWRG0ZVJNFtHtCI5k=
X-Google-Smtp-Source: AA0mqf4RFnfkoAD54ap2jY5K1wrVKyGDu82Gj4p7C9SyC1vpSNMYNUm8XyrWE/P39Nc1A8UJkNA42kvUtlyVkcPLFyk=
X-Received: by 2002:aa7:c6da:0:b0:469:172:1f38 with SMTP id
 b26-20020aa7c6da000000b0046901721f38mr23867512eds.195.1669219466328; Wed, 23
 Nov 2022 08:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20221122161106.55037-1-lautrbach@redhat.com>
In-Reply-To: <20221122161106.55037-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 11:04:15 -0500
Message-ID: <CAP+JOzRit39R5OKLFvHt0CdOixEHrBvybq3UWa6VicwMHG5NQA@mail.gmail.com>
Subject: Re: [RFC PATCH] Use `pip install` instead of `setup.py install`
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 22, 2022 at 11:15 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Fixes:
>     /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  README.md                | 4 +++-
>  libselinux/src/Makefile  | 2 +-
>  python/sepolicy/Makefile | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/README.md b/README.md
> index 529b7e46c871..e11b0028f4ba 100644
> --- a/README.md
> +++ b/README.md
> @@ -62,6 +62,7 @@ dnf install \
>  # For Python and Ruby bindings
>  dnf install \
>      python3-devel \
> +    python3-pip \
>      ruby-devel \
>      swig
>  ```
> @@ -92,6 +93,7 @@ apt-get install --no-install-recommends --no-install-suggests \
>  # For Python and Ruby bindings
>  apt-get install --no-install-recommends --no-install-suggests \
>      python3-dev \
> +    python3-pip \
>      ruby-dev \
>      swig
>  ```
> @@ -102,7 +104,7 @@ To build and install everything under a private directory, run:
>
>      make DESTDIR=~/obj install install-rubywrap install-pywrap
>
> -On Debian `PYTHON_SETUP_ARGS=--install-layout=deb` needs to be set when installing the python wrappers in order to create the correct python directory structure.
> +On Debian `PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` needs to be set when installing the python wrappers in order to create the correct python directory structure.
>
>  To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
>  This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index dc2848322e4d..0f6396ababa4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,7 +187,7 @@ install: all
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
>
>  install-pywrap: pywrap
> -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
>         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index d983e409e5e6..57a2e55edbbf 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>         @$(PYTHON) test_sepolicy.py -v
>
>  install:
> -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
>         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --
> 2.38.1
>
