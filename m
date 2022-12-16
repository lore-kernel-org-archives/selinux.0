Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D309C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 22:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLPWNB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLPWM6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 17:12:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70027CF5
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:12:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a16so5493989edb.9
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpgvCx4i8zTFKySjwG0E+29NRAeHamIpelEtp6TsBys=;
        b=EsYpqgQwGyLJhd5xaE2mJBhEPyPk5ClsbgYvQs+aRuUav/Qb9nA/lwn+/2OcF2PZ6B
         azpXz02NgnUiTW0oqepiPlxTAf94/H5E0EupIQtw8W5hdODFkBaxd795jwnq/TezIDFp
         Ki7xny7poLbE64wEkHQQYn+Dk4/R+RJsx1qKodcNp2IuelMguJdKM4zPKkc742IScIYg
         7DE5vVafC+WN8PpZZwbfUR1HAPgE792HzcrZZSODiQupWRkU+LccOs6bIQiivfkhLPqX
         eelpb/jHph7HSAqk2XQocplm9Q6EN0eG9AGeIsTB+dFobjO6i+HQ37qpuWY9pbBT+/g+
         Rs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpgvCx4i8zTFKySjwG0E+29NRAeHamIpelEtp6TsBys=;
        b=YRnedSPw58SIhGvDs3bUxd8lIR//zKjHNSuH+vuHPx0uFG3mHQG9Vi90t2eOmlNq7o
         M6wFDReeRZrxYtnF3auv4JMo9RRnLCjDlGurx0f193A2NyKoMmQkuXMLSSueBbw3tNze
         clBNU8VF44/hRo6kZ72f8oc8ADfsaN+yuzp5YKJ04bOnGs8x96FU4TTwDOlg2PAXUGze
         djAR8K8MWt3dLvsj0XZDN153YwWo8nsFHoOH4dQ11WNzsgv7kNUAlUxAYzIpx9BV1AEK
         g2ijPqhHmCdSx6gSTq03MFi4wbHTCVhEfPqe5weTfQUM6eAxM1s313HrIAe240VKrSxg
         /6YQ==
X-Gm-Message-State: ANoB5plcI5SeCpjU32ImUyJGEaBk9t00EaX0ikv9nNdh8P+WAFAtfZuT
        jREOmynXtm6O8M5Ip4l75XvzIT84rk2pOz9/1fgVhhBXg6Q=
X-Google-Smtp-Source: AA0mqf5h5Vul0/5Hev1pO/Cfnbi1Xsk3M/+R1RbW0EEyBblcpo5EnFK2xfMDfb67G7TlDTpmjgiIxMG98a5dbR/WXfM=
X-Received: by 2002:a50:fe8d:0:b0:461:9183:834b with SMTP id
 d13-20020a50fe8d000000b004619183834bmr72257515edt.196.1671228767568; Fri, 16
 Dec 2022 14:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20221129163250.475549-1-lautrbach@redhat.com>
In-Reply-To: <20221129163250.475549-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 17:12:36 -0500
Message-ID: <CAP+JOzS5tx4G5y=hOAk8BSOyW-S06-vWoT00zhb2BNTsZtjn-g@mail.gmail.com>
Subject: Re: [PATCH v2] Use `pip install` instead of `setup.py install`
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 29, 2022 at 11:40 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Fixes:
>     /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

I made a mess of this. I merged the earlier patch by mistake, that has
been reverted and this version merged.

Acked-by: James Carter <jwcart2@gmail.com>
and merged.

Thanks,
Jim

> ---
>  README.md                | 8 +++++++-
>  libselinux/src/Makefile  | 2 +-
>  python/sepolicy/Makefile | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/README.md b/README.md
> index 529b7e46c871..c272ce89fec5 100644
> --- a/README.md
> +++ b/README.md
> @@ -62,6 +62,9 @@ dnf install \
>  # For Python and Ruby bindings
>  dnf install \
>      python3-devel \
> +    python3-pip \
> +    python3-setuptools \
> +    python3-wheel \
>      ruby-devel \
>      swig
>  ```
> @@ -92,6 +95,9 @@ apt-get install --no-install-recommends --no-install-suggests \
>  # For Python and Ruby bindings
>  apt-get install --no-install-recommends --no-install-suggests \
>      python3-dev \
> +    python3-pip \
> +    python3-setuptools \
> +    python3-wheel \
>      ruby-dev \
>      swig
>  ```
> @@ -102,7 +108,7 @@ To build and install everything under a private directory, run:
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
